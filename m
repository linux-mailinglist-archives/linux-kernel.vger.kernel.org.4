Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949A863766A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiKXK24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiKXK2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:28:53 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FF4A13C2;
        Thu, 24 Nov 2022 02:28:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9A9DACE29E0;
        Thu, 24 Nov 2022 10:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26949C433D6;
        Thu, 24 Nov 2022 10:28:45 +0000 (UTC)
Message-ID: <d8595ab3-93ad-e852-ceaf-cc11a09c1784@xs4all.nl>
Date:   Thu, 24 Nov 2022 11:28:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220610125215.240539-1-nicolas.dufresne@collabora.com>
 <20220610125215.240539-3-nicolas.dufresne@collabora.com>
 <fed8b2cf-3098-0690-dc40-796dbe0ff424@xs4all.nl>
 <46211420a76c7608c34cd6b3569f41accdfd08a1.camel@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v1 2/5] media: rkvdec: Add an ops to check for decode
 errors
In-Reply-To: <46211420a76c7608c34cd6b3569f41accdfd08a1.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 14/06/2022 18:14, Nicolas Dufresne wrote:
> Le mardi 14 juin 2022 à 16:44 +0200, Hans Verkuil a écrit :
>> On 6/10/22 14:52, Nicolas Dufresne wrote:
>>> This optional internal ops allow each codec to do their own
>>> error status checking. The presence of an error is reported
>>> using the ERROR buffer state. This patch have no functional
>>> changes.
>>
>> If a buffer is returned with state ERROR, then that means that it is
>> seriously corrupt and userspace is expected to drop it. You might still
>> want to show it for debugging purposes, but the normal action is to drop it.
> 
> The discussion should be around the ERROR flag, and not the error state. Error
> state is just an internal thing that have no meaning API wise, but turns out to
> be the only way to get the ERROR flag to be set. With that in mind, this is not
> what V4L2_BUF_FLAG_ERROR specification says:
> 
>> When this flag is set, the buffer has been dequeued successfully, although
>> the data might have been corrupted. This is recoverable, streaming may
>> continue as normal and the buffer may be reused normally. Drivers set 
>> this flag when the VIDIOC_DQBUF ioctl is called.
> 
> For me "seriously corrupt" and "might have been corrupted" is very different.

So I did some more digging (better late than never): the documentation for
the stateful/stateless codecs explicitly states that ERROR should be used
to indicate de/encoding errors.

I am actually not that happy about that, since the original purpose of ERROR
was really to indicate that there is something seriously wrong with the
captured data, and applications should skip it, except for debugging purposes.

But since it has been adopted in the codec documentation I have to accept this
behavior for codecs.

So I am OK with this series. There were some comments about some typos, so
I will mark it as 'Changes Requested' in patchwork, but if you post a v2, then
I'll take it.

Regards,

	Hans

> 
>>
>> So this is not a valid approach for a decoder that can still produce a
>> decent picture, albeit with macroblock artifacts.
>>
>> A separate control that can be returned as part of the request and contains
>> some sort of error indication would be more appropriate.
>>
>> Buffer state ERROR is really meant for e.g. DMA errors and it shouldn't
>> be mixed with decode errors that still produce a valid picture.
> 
> The ERROR flag has been used for many years by the UVC driver to indicate a
> partially received image (possibly due to DMA error). That driver went even
> further and set the bytesused to the amount of bytes that was received. How this
> have been interpreted (mostly due to how the spec around ERROR flag is written)
> in GStreamer is that the buffer contains "some valid" data unless payload size
> is 0.
> 
> As explained earlier, the decision to display "some valid" data is not something
> we should decided for our users. This should be left to the application to
> decide. Same goes for GStreamer, if a buffer exist but has "some valid data", we
> have a GST_BUFFER_FLAG_CORRUPTED flag for it. It is then up for the application
> to drop if needed for the application. I'm pretty sure some stateful decoders
> also behaves like this (simply because an error is an error, regardless of the
> nature of it).
> 
> It might be different today, but few years ago, dropping or not dropping was the
> main difference between Apple Facetime (dropping) and the other video streaming
> applications. One would freeze, the other would show "some valid data".
> 
> If you look at the outcome of a partially corrupted decoded images and the
> outcome of a mid-frame DMA error (typically from a camera stream), you'll find
> that these are visually the same. So it is unfair to consider these two error so
> different that a new mechanism must be added. In my opinion, adding RO controls
> to signal these corruption only make sense if the hardware can provide detailed
> reports of what is corrupted (list/range of macro-blocks, or CTU that are
> affected). Then you could measure the level of corruption, but in reality, I
> doubt there would be a vast usage of this, specially that the report will likely
> be inconsistent due to limited HW support.
> 
> Finally, in the bitstream decoder world, including all software decoders I've
> worked with, the decode is a success only if all bits are perfectly decoded.
> This is the baseline for good vs bad. Userland expected an image, and whatever
> happened, in real-time scenario, it must send an image. Sending a corrupted
> image, or sending the previously good image remains a decision to be made by
> application. As application exist around the implemented mechanism here, I'd
> prefer to go for that rather then adding a new API.
> 
> Nicolas
> 
>>
>> Regards,
>>
>> 	Hans
>>
>>>
>>> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>>> ---
>>>  drivers/staging/media/rkvdec/rkvdec.c | 10 ++++++----
>>>  drivers/staging/media/rkvdec/rkvdec.h |  2 ++
>>>  2 files changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
>>> index 7bab7586918c..7e76f8b72885 100644
>>> --- a/drivers/staging/media/rkvdec/rkvdec.c
>>> +++ b/drivers/staging/media/rkvdec/rkvdec.c
>>> @@ -950,6 +950,7 @@ static void rkvdec_v4l2_cleanup(struct rkvdec_dev *rkvdec)
>>>  static irqreturn_t rkvdec_irq_handler(int irq, void *priv)
>>>  {
>>>  	struct rkvdec_dev *rkvdec = priv;
>>> +	struct rkvdec_ctx *ctx;
>>>  	enum vb2_buffer_state state;
>>>  	u32 status;
>>>  
>>> @@ -958,12 +959,13 @@ static irqreturn_t rkvdec_irq_handler(int irq, void *priv)
>>>  		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
>>>  
>>>  	writel(0, rkvdec->regs + RKVDEC_REG_INTERRUPT);
>>> -	if (cancel_delayed_work(&rkvdec->watchdog_work)) {
>>> -		struct rkvdec_ctx *ctx;
>>> +	ctx = v4l2_m2m_get_curr_priv(rkvdec->m2m_dev);
>>>  
>>> -		ctx = v4l2_m2m_get_curr_priv(rkvdec->m2m_dev);
>>> +	if (ctx->coded_fmt_desc->ops->check_error_info)
>>> +		state = ctx->coded_fmt_desc->ops->check_error_info(ctx);
>>> +
>>> +	if (cancel_delayed_work(&rkvdec->watchdog_work))
>>>  		rkvdec_job_finish(ctx, state);
>>> -	}
>>>  
>>>  	return IRQ_HANDLED;
>>>  }
>>> diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
>>> index 633335ebb9c4..4ae8e6c6b03c 100644
>>> --- a/drivers/staging/media/rkvdec/rkvdec.h
>>> +++ b/drivers/staging/media/rkvdec/rkvdec.h
>>> @@ -73,6 +73,8 @@ struct rkvdec_coded_fmt_ops {
>>>  		     struct vb2_v4l2_buffer *dst_buf,
>>>  		     enum vb2_buffer_state result);
>>>  	int (*try_ctrl)(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl);
>>> +	/* called from IRQ handler */
>>> +	int (*check_error_info)(struct rkvdec_ctx *ctx);
>>>  };
>>>  
>>>  struct rkvdec_coded_fmt_desc {
>>
> 

