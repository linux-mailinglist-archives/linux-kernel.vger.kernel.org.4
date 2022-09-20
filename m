Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8BC5BDBC3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 06:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiITEpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 00:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiITEpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 00:45:11 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B0733421;
        Mon, 19 Sep 2022 21:45:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQHRevk_1663649105;
Received: from 30.97.56.91(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQHRevk_1663649105)
          by smtp.aliyun-inc.com;
          Tue, 20 Sep 2022 12:45:06 +0800
Message-ID: <475726f7-bb65-5681-1967-a9ae9075004e@linux.alibaba.com>
Date:   Tue, 20 Sep 2022 12:45:03 +0800
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
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <Yyktx/xz0qTNxnT4@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/20 11:04, Ming Lei wrote:
> On Tue, Sep 20, 2022 at 09:49:33AM +0800, Ziyang Zhang wrote:
>> On 2022/9/19 20:33, Ming Lei wrote:
>>>>>> +
>>>>>> +static void ublk_quiesce_queue(struct ublk_device *ub,
>>>>>> +		struct ublk_queue *ubq)
>>>>>> +{
>>>>>> +	int i;
>>>>>> +
>>>>>> +	for (i = 0; i < ubq->q_depth; i++) {
>>>>>> +		struct ublk_io *io = &ubq->ios[i];
>>>>>> +
>>>>>> +		if (!(io->flags & UBLK_IO_FLAG_ACTIVE)) {
>>>>>> +			struct request *rq = blk_mq_tag_to_rq(
>>>>>> +					ub->tag_set.tags[ubq->q_id], i);
>>>>>> +
>>>>>> +			WARN_ON_ONCE(!rq);
>>>>>> +			pr_devel("%s: %s rq: qid %d tag %d io_flags %x\n", __func__,
>>>>>> +					ublk_queue_can_use_recovery_reissue(ubq) ?
>>>>>> +					"requeue" : "abort",
>>>>>> +					ubq->q_id, i, io->flags);
>>>>>> +			if (ublk_queue_can_use_recovery_reissue(ubq))
>>>>>> +				blk_mq_requeue_request(rq, false);
>>>>>
>>>>> This way is too violent.
>>>>>
>>>>> There may be just one queue dying, but you requeue all requests
>>>>> from any queue. I'd suggest to take the approach in ublk_daemon_monitor_work(),
>>>>> such as, just requeuing requests in dying queue.
>>>>
>>>> If we want to start a new process after a crash for USER_RECOVERY, all old ubq_daemons
>>>> must exit and rqs of all queues have to be requeued/aborted. We cannot let live
>>>> ubq_daemons run any more because they do not belong to the new process.
>>>
>>> IMO, the old process really can exist, and recently even I got such
>>> requirement for switching queue from one thread to another.
>>
>> For now, only one process can open /dev/ublkcX, so a new process is necessary now.
>>
>> If you think "per ubq_daemon" recovery is reasonable, I can do that in the future
>> if multiple processes is supported. But I really suggest that we can keep current
>> design as the first step which assumes all ubq_daemons are exited and a new process
>> is started, and that really meets our requirement.
>>
>> BTW, START_USER_RECOVERY has to be reconsidered because we may need to pass a ubq_id
>> with it.
>>
>>>
>>> What we should do is to get all inflight requests done, and cancel all io
>>> commands, no matter if the ubq pthread is dead or live.
>>>
>>>>
>>>> BTW, I really wonder why there could be just one queue dying? All queues must be dying
>>>> shortly after any ubq_daemon is dying since they are all pthreads in the same process.
>>>
>>> You can't assume it is always so. Maybe one pthread is dead first, and
>>> others are dying later, maybe just one is dead.
>>
>> Yes, I know there may be only one pthread is dead while others keep running, but now
>> ublk_drv only support one process opening the same /dev/ublkcX, so other pthreads
>> must dead(no matter they are aborted by signal or themselves) later.
>>
>>>
>>> If one queue's pthread is live, you may get trouble by simply requeuing
>>> the request, that is why I suggest to re-use the logic of
>>> ublk_daemon_monitor_work/ublk_abort_queue().
>>
>> Actually, if any ubq_daemon is live, no rqs are requeued, please see the check in
>> ublk_quiesce_dev(). It always makes sure that ALL ubq_daemons are dying, then it
>> starts quiesce jobs.
> 
> OK, looks I miss this point, but you should have quiesced queue at the
> beginning of ublk_quiesce_dev(), then the transition period can be kept
> as short as possible. Otherwise, if one queue pthread isn't dying, the
> device can be kept in this part-working state forever.
> 

Ming, this is what you said in PATCH V2:
"
The simplest handling might be to exit all ublk queues first, and re-create one
new process to recover all since the request queue is required to be
quiesced first, and all ublk queue is actually quiesced too. So from user
viewpoint, there is nothing visible comparing with just recovering
single ubq daemon/pthread.
"

So I assume that quiesce_work starts only after all ubq_damons are dying.
Note that current ublk does not support mutpile process opening the same chardev.

Really we should agree on this. My suggestion is that we only consider "all ubq_daemons
are dying".

You mention that someone want to enable "switch ubq_daemon pthread to another one" and
I think it is another feature but not recovery feature.

Regards,
Zhang.

