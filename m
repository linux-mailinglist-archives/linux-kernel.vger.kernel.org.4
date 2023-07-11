Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC7474E988
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjGKIzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjGKIyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:54:43 -0400
Received: from kozue.soulik.info (kozue.soulik.info [IPv6:2001:19f0:7000:8404:5400:ff:fe00:d7d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5432123;
        Tue, 11 Jul 2023 01:54:21 -0700 (PDT)
Received: from [192.168.10.7] (unknown [10.0.12.132])
        by kozue.soulik.info (Postfix) with ESMTPSA id 61B35300489;
        Tue, 11 Jul 2023 17:54:02 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info 61B35300489
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
        t=1689065645; bh=Jl1HNU+32gpX0ib5//w1xpXSY5M4giUtIFQvhpVnHJE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D9ENCR6KhZHyauCjGdicq1KGNkIuEvLvrAkGHBkC+lAbYrgP+LASwrUQsk70Aw66F
         ZGhnD7ESt8I8bSzR3ymYhfQcm8fr6kU5IogQOvd0CHQfiKQkmEmqATwqyHAe4l2qYE
         fBKLtQZTmBQ8lOrV2JaEtYeu3s0scnmttUwjFbVw=
Message-ID: <7f6ea6b2-39b8-cdd1-403a-faceca1f1b61@soulik.info>
Date:   Tue, 11 Jul 2023 16:54:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] media: v4l2-mem2mem: add a list for buf used by hw
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     hans.verkuil@cisco.com, tfiga@chromium.org,
        linux-media@vger.kernel.org, Hsia-Jun Li <randy.li@synaptics.com>,
        mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        hiroh@chromium.org, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org
References: <20230704040044.681850-1-randy.li@synaptics.com>
 <20230704040044.681850-3-randy.li@synaptics.com>
 <575b5a7bd48b3fab7a33c7c25962b36b2ccf6b14.camel@ndufresne.ca>
Content-Language: en-US
From:   Randy Li <ayaka@soulik.info>
In-Reply-To: <575b5a7bd48b3fab7a33c7c25962b36b2ccf6b14.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/7/8 03:20, Nicolas Dufresne wrote:
> Le mardi 04 juillet 2023 à 12:00 +0800, Hsia-Jun Li a écrit :
>> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
>>
>> Many drivers have to create its own buf_struct for a
>> vb2_queue to track such a state. Also driver has to
>> iterate over rdy_queue every times to find out a buffer
>> which is not sent to hardware(or firmware), this new
>> list just offers the driver a place to store the buffer
>> that hardware(firmware) has acknowledged.
>>
>> One important advance about this list, it doesn't like
>> rdy_queue which both bottom half of the user calling
>> could operate it, while the v4l2 worker would as well.
>> The v4l2 core could only operate this queue when its
>> v4l2_context is not running, the driver would only
>> access this new hw_queue in its own worker.
> That's an interesting proposal. I didn't like leaving decoded frames into the
> rdy_queue, but removing them required me to have my own list, so that I can
> clean it up if some buffers are never displayed.
>
> We'll see if we can use this into wave5.
>
>> Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
>> ---
>>   drivers/media/v4l2-core/v4l2-mem2mem.c | 25 +++++++++++++++++--------
>>   include/media/v4l2-mem2mem.h           | 10 +++++++++-
>>   2 files changed, 26 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
>> index c771aba42015..b4151147d5bd 100644
>> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
>> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
>> @@ -321,15 +321,21 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
>>   		goto job_unlock;
>>   	}
>>   
>> -	src = v4l2_m2m_next_src_buf(m2m_ctx);
>> -	dst = v4l2_m2m_next_dst_buf(m2m_ctx);
>> -	if (!src && !m2m_ctx->out_q_ctx.buffered) {
>> -		dprintk("No input buffers available\n");
>> -		goto job_unlock;
>> +	if (list_empty(&m2m_ctx->out_q_ctx.hw_queue)) {
>> +		src = v4l2_m2m_next_src_buf(m2m_ctx);
>> +
>> +		if (!src && !m2m_ctx->out_q_ctx.buffered) {
>> +			dprintk("No input buffers available\n");
>> +			goto job_unlock;
>> +		}
>>   	}
>> -	if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
>> -		dprintk("No output buffers available\n");
>> -		goto job_unlock;
>> +
>> +	if (list_empty(&m2m_ctx->cap_q_ctx.hw_queue)) {
>> +		dst = v4l2_m2m_next_dst_buf(m2m_ctx);
>> +		if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
>> +			dprintk("No output buffers available\n");
>> +			goto job_unlock;
>> +		}
>>   	}
>>   
>>   	m2m_ctx->new_frame = true;
>> @@ -896,6 +902,7 @@ int v4l2_m2m_streamoff(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>>   	INIT_LIST_HEAD(&q_ctx->rdy_queue);
>>   	q_ctx->num_rdy = 0;
>>   	spin_unlock_irqrestore(&q_ctx->rdy_spinlock, flags);
>> +	INIT_LIST_HEAD(&q_ctx->hw_queue);
>>   
>>   	if (m2m_dev->curr_ctx == m2m_ctx) {
>>   		m2m_dev->curr_ctx = NULL;
>> @@ -1234,6 +1241,8 @@ struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct v4l2_m2m_dev *m2m_dev,
>>   
>>   	INIT_LIST_HEAD(&out_q_ctx->rdy_queue);
>>   	INIT_LIST_HEAD(&cap_q_ctx->rdy_queue);
>> +	INIT_LIST_HEAD(&out_q_ctx->hw_queue);
>> +	INIT_LIST_HEAD(&cap_q_ctx->hw_queue);
>>   	spin_lock_init(&out_q_ctx->rdy_spinlock);
>>   	spin_lock_init(&cap_q_ctx->rdy_spinlock);
>>   
>> diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
>> index d6c8eb2b5201..2342656e582d 100644
>> --- a/include/media/v4l2-mem2mem.h
>> +++ b/include/media/v4l2-mem2mem.h
>> @@ -53,9 +53,16 @@ struct v4l2_m2m_dev;
>>    *	processed
>>    *
>>    * @q:		pointer to struct &vb2_queue
>> - * @rdy_queue:	List of V4L2 mem-to-mem queues
>> + * @rdy_queue:	List of V4L2 mem-to-mem queues. If v4l2_m2m_buf_queue() is
>> + *		called in struct vb2_ops->buf_queue(), the buffer enqueued
>> + *		by user would be added to this list.
>>    * @rdy_spinlock: spin lock to protect the struct usage
>>    * @num_rdy:	number of buffers ready to be processed
>> + * @hw_queue:	A list for tracking the buffer is occupied by the hardware
>> + * 		(or device's firmware). A buffer could only be in either
>> + * 		this list or @rdy_queue.
>> + * 		Driver may choose not to use this list while uses its own
>> + * 		private data to do this work.
> What's the threading protection around this one ?

I mentioned that in commit message.

"

The v4l2 core could only operate this queue when its
v4l2_context is not running, the driver would only
access this new hw_queue in its own worker.
"

>   Also, would it be possible to
> opt-in that the driver cleanup that list automatically after streamoff has been
> executed ?
I think that is what streamoff purposes to do, or we don't have a method 
to let the hardware(firmware) release all its buffers.
>
> One thing the doc is missing, is that HW buffer are actually flagged as ACTIVE
> buffer vb2, there is a strong link between the two concept, and the doc should
> take care.

I would like to complete the doc if people are not against about this idea.

And I would put all necessary information in one place.

>
>>    * @buffered:	is the queue buffered?
>>    *
>>    * Queue for buffers ready to be processed as soon as this
>> @@ -68,6 +75,7 @@ struct v4l2_m2m_queue_ctx {
>>   	struct list_head	rdy_queue;
>>   	spinlock_t		rdy_spinlock;
>>   	u8			num_rdy;
>> +	struct list_head	hw_queue;
>>   	bool			buffered;
>>   };
>>   
