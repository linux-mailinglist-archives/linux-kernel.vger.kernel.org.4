Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8ED5E585A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 04:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiIVCEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 22:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiIVCEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:04:39 -0400
Received: from out199-4.us.a.mail.aliyun.com (out199-4.us.a.mail.aliyun.com [47.90.199.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D9013CD5;
        Wed, 21 Sep 2022 19:04:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQQCF9u_1663812271;
Received: from 30.97.56.134(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQQCF9u_1663812271)
          by smtp.aliyun-inc.com;
          Thu, 22 Sep 2022 10:04:32 +0800
Message-ID: <19edc1a4-91ef-2384-2fc1-82f57303cc17@linux.alibaba.com>
Date:   Thu, 22 Sep 2022 10:04:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V4 4/8] ublk_drv: requeue rqs with recovery feature
 enabled
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20220921095849.84988-1-ZiyangZhang@linux.alibaba.com>
 <20220921095849.84988-5-ZiyangZhang@linux.alibaba.com>
 <YyuqV1sauPRUjug8@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <YyuqV1sauPRUjug8@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/22 08:28, Ming Lei wrote:
> On Wed, Sep 21, 2022 at 05:58:45PM +0800, ZiyangZhang wrote:
>> With recovery feature enabled, in ublk_queue_rq or task work
>> (in exit_task_work or fallback wq), we requeue rqs instead of
>> ending(aborting) them. Besides, No matter recovery feature is enabled
>> or disabled, we schedule monitor_work immediately.
>>
>> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
>> ---
>>  drivers/block/ublk_drv.c | 31 +++++++++++++++++++++++++++++--
>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 3bdac4bdf46f..b940e490ebab 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -655,6 +655,19 @@ static void ubq_complete_io_cmd(struct ublk_io *io, int res)
>>  
>>  #define UBLK_REQUEUE_DELAY_MS	3
>>  
>> +static inline void __ublk_abort_rq_in_task_work(struct ublk_queue *ubq,
>> +		struct request *rq)
>> +{
>> +	pr_devel("%s: %s q_id %d tag %d io_flags %x.\n", __func__,
>> +			(ublk_queue_can_use_recovery(ubq)) ? "requeue" : "abort",
>> +			ubq->q_id, rq->tag, ubq->ios[rq->tag].flags);
>> +	/* We cannot process this rq so just requeue it. */
>> +	if (ublk_queue_can_use_recovery(ubq))
>> +		blk_mq_requeue_request(rq, false);
>> +	else
>> +		blk_mq_end_request(rq, BLK_STS_IOERR);
>> +}
>> +
>>  static inline void __ublk_rq_task_work(struct request *req)
>>  {
>>  	struct ublk_queue *ubq = req->mq_hctx->driver_data;
>> @@ -677,7 +690,7 @@ static inline void __ublk_rq_task_work(struct request *req)
>>  	 * (2) current->flags & PF_EXITING.
>>  	 */
>>  	if (unlikely(current != ubq->ubq_daemon || current->flags & PF_EXITING)) {
>> -		blk_mq_end_request(req, BLK_STS_IOERR);
>> +		__ublk_abort_rq_in_task_work(ubq, req);
>>  		mod_delayed_work(system_wq, &ub->monitor_work, 0);
>>  		return;
>>  	}
>> @@ -752,6 +765,20 @@ static void ublk_rq_task_work_fn(struct callback_head *work)
>>  	__ublk_rq_task_work(req);
>>  }
>>  
>> +static inline blk_status_t __ublk_abort_rq(struct ublk_queue *ubq,
>> +		struct request *rq)
>> +{
>> +	pr_devel("%s: %s q_id %d tag %d io_flags %x.\n", __func__,
>> +			(ublk_queue_can_use_recovery(ubq)) ? "requeue" : "abort",
>> +			ubq->q_id, rq->tag, ubq->ios[rq->tag].flags);
>> +	/* We cannot process this rq so just requeue it. */
>> +	if (ublk_queue_can_use_recovery(ubq)) {
>> +		blk_mq_requeue_request(rq, false);
>> +		return BLK_STS_OK;
>> +	}
>> +	return BLK_STS_IOERR;
>> +}
>> +
> 
> Please remove the two added logging, otherwise this patch looks fine.

OK, will do so in V5.

Regards,
Zhang

