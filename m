Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97B26394A9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 09:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiKZI2t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 26 Nov 2022 03:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKZI2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 03:28:47 -0500
Received: from kozue.soulik.info (kozue.soulik.info [IPv6:2001:19f0:7000:8404:5054:ff:fe75:428f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA98FEE39;
        Sat, 26 Nov 2022 00:28:46 -0800 (PST)
Received: from [192.168.10.76] (unknown [112.65.61.224])
        by kozue.soulik.info (Postfix) with ESMTPSA id 3ABC1100C90;
        Sat, 26 Nov 2022 17:28:32 +0900 (JST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   ayaka <ayaka@soulik.info>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] media: v4l2-mem2mem: allow device run without buf
Date:   Sat, 26 Nov 2022 16:28:33 +0800
Message-Id: <80315D27-6558-44F8-B4F0-8F464602D709@soulik.info>
References: <edd368ea3cc9bb31700600a7f1fe7c837501458c.camel@collabora.com>
Cc:     Hsia-Jun Li <randy.li@synaptics.com>, linux-media@vger.kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        sebastian.fricke@collabora.com,
        kieran.bingham+renesas@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, ming.qian@nxp.com,
        wenst@chromium.org, linux-kernel@vger.kernel.org
In-Reply-To: <edd368ea3cc9bb31700600a7f1fe7c837501458c.camel@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
X-Mailer: iPad Mail (18D61)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 25, 2022, at 9:43 PM, Nicolas Dufresne <nicolas.dufresne@collabora.com> wrote:
> 
> ﻿CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
>> Le mercredi 23 novembre 2022 à 17:24 +0800, Hsia-Jun Li a écrit :
>> From: Randy Li <ayaka@soulik.info>
>> 
>> For the decoder supports Dynamic Resolution Change,
>> we don't need to allocate any CAPTURE or graphics buffer
>> for them at inital CAPTURE setup step.
>> 
>> We need to make the device run or we can't get those
>> metadata.
> 
> Nack: This is not how it works. I know the m2m framework make it difficult, but
> it is expected that the driver have a special state for OUTPUT streamon (before
> capture streamon). Please have a look at other drivers.
> 
I have some good reasons here that make dynamic resolution should happen in the device_run().
1. If the CAPTURE is STREAMON, when the resolution changed event should be triggered? Of course it would be in device_run(), there is no reason to make an special case here.

The following reasons may be better applied for encrypted(DRM) video, when no normal video stream parser could be invoked.
We don’t know whether the user input contains valid sequence header, would the sequence header applied to the current frame? Beside the metadata we need may not at the beginning of the buffer.
2. If it would cost lots of device time on parsing it, it even may even need to read more than one OUTPUT buffers, we would be better to fix this into the normal schedule procedure. Or it would block the other running contexts(instances)
3. We need extra methods to wait the other context done their work which breaks the original job queue.

buffered flag is a perfect way to fix these problems, I didn’t see any m2m driver uses them.

> Nicolas
>> 
>> Signed-off-by: Randy Li <ayaka@soulik.info>
>> ---
>> drivers/media/v4l2-core/v4l2-mem2mem.c | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
>> index be7fde1ed3ea..cd56d60fad9d 100644
>> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
>> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
>> @@ -301,8 +301,9 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
>> 
>>      dprintk("Trying to schedule a job for m2m_ctx: %p\n", m2m_ctx);
>> 
>> -     if (!m2m_ctx->out_q_ctx.q.streaming
>> -         || !m2m_ctx->cap_q_ctx.q.streaming) {
>> +     if (!(m2m_ctx->out_q_ctx.q.streaming || m2m_ctx->out_q_ctx.buffered)
>> +         || !(m2m_ctx->cap_q_ctx.q.streaming
>> +              || m2m_ctx->cap_q_ctx.buffered)) {
>>              dprintk("Streaming needs to be on for both queues\n");
>>              return;
>>      }
> 

