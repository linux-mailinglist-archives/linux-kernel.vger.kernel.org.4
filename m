Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE935BDBBD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 06:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiITEjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 00:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiITEji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 00:39:38 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2819B6587;
        Mon, 19 Sep 2022 21:39:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQHPXJt_1663648772;
Received: from 30.97.56.91(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQHPXJt_1663648772)
          by smtp.aliyun-inc.com;
          Tue, 20 Sep 2022 12:39:33 +0800
Message-ID: <5af80188-c904-635a-242e-4bb1cd7f2e01@linux.alibaba.com>
Date:   Tue, 20 Sep 2022 12:39:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V3 5/7] ublk_drv: consider recovery feature in aborting
 mechanism
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <20220913041707.197334-1-ZiyangZhang@linux.alibaba.com>
 <20220913041707.197334-6-ZiyangZhang@linux.alibaba.com>
 <Yyg3KLfQaxbS1miq@T590>
 <9a682fac-f022-1f4d-5c2c-e1f0a84746d8@linux.alibaba.com>
 <YyhhnbrHTJpW4Xcm@T590>
 <dbc78e92-ede7-fc63-1bee-83794bf1e33b@linux.alibaba.com>
 <Yyktx/xz0qTNxnT4@T590>
 <64492fad-e14a-c647-b490-cd1f53a475a8@linux.alibaba.com>
 <Yyk7LnH9lj303DTj@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <Yyk7LnH9lj303DTj@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/20 12:01, Ming Lei wrote:
> On Tue, Sep 20, 2022 at 11:24:12AM +0800, Ziyang Zhang wrote:
>> On 2022/9/20 11:04, Ming Lei wrote:
>>> On Tue, Sep 20, 2022 at 09:49:33AM +0800, Ziyang Zhang wrote:
>>>
>>> Follows the delta patch against patch 5 for showing the idea:
>>>
>>>
>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>>> index 4409a130d0b6..60c5786c4711 100644
>>> --- a/drivers/block/ublk_drv.c
>>> +++ b/drivers/block/ublk_drv.c
>>> @@ -656,7 +656,8 @@ static void ublk_complete_rq(struct request *req)
>>>   * Also aborting may not be started yet, keep in mind that one failed
>>>   * request may be issued by block layer again.
>>>   */
>>> -static void __ublk_fail_req(struct ublk_io *io, struct request *req)
>>> +static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
>>> +		struct request *req)
>>>  {
>>>  	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
>>>  
>>> @@ -667,7 +668,10 @@ static void __ublk_fail_req(struct ublk_io *io, struct request *req)
>>>  				req->tag,
>>>  				io->flags);
>>>  		io->flags |= UBLK_IO_FLAG_ABORTED;
>>> -		blk_mq_end_request(req, BLK_STS_IOERR);
>>> +		if (ublk_queue_can_use_recovery_reissue(ubq))
>>> +			blk_mq_requeue_request(req, false);
>>
>> Here is one problem:
>> We reset io->flags to 0 in ublk_queue_reinit() and it is called before new
> 
> As we agreed, ublk_queue_reinit() will be moved to ublk_ch_release(), when there isn't
> any inflight request, which is completed by either ublk server or __ublk_fail_req().
> 
> So clearing io->flags isn't related with quisceing device.
> 
>> ubq_daemon with FETCH_REQ is accepted. ublk_abort_queue() is not protected with
>> ub_mutex and it is called many times in monitor_work. So same rq may be requeued
>> multiple times.
> 
> UBLK_IO_FLAG_ABORTED is set for the slot, so one req is only ended or
> requeued just once.

Yes, we can move ublk_queue_reinit() into ublk_ch_release(), but monitor_work is scheduled
periodically so ublk_abort_queue() is called multiple times. As ublk_queue_reinit() clear
io->flags, ublk_abort_queue() can requeue the same rq twice. Note that monitor_work can be
scheduled after ublk_ch_release().
 
> 
>>
>> With recovery disabled, there is no such problem since io->flags does not change
>> until ublk_dev is released.
> 
> But we have agreed that ublk_queue_reinit() can be moved to release
> handler of /dev/ublkcN.
> 
>>
>> In my patch 5 I only requeue the same rq once. So re-using ublk_abort_queue() is
>> hard for recovery feature.
> 
> No, the same rq is just requeued once. Here the point is:
> 
> 1) reuse previous pattern in ublk_stop_dev(), which is proved as
> workable reliably
> 
> 2) avoid to stay in half-working state forever
> 
> 3) the behind idea is more simpler.

Ming, your patch requeue rqs with ACTVE unset. these rqs have been issued to the
dying ubq_daemon. What I concern about is inflight rqs with ACTIVE set.

Regards,
Zhang.
