Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCEC6351F2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbiKWIIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbiKWIIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:08:36 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C39A8E2A0;
        Wed, 23 Nov 2022 00:08:33 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aeb9c.dynamic.kabel-deutschland.de [95.90.235.156])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id B9EDE61EA1BD5;
        Wed, 23 Nov 2022 09:08:30 +0100 (CET)
Message-ID: <c8a4a3b6-6591-2710-433f-642277eeb8f3@molgen.mpg.de>
Date:   Wed, 23 Nov 2022 09:08:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] media: aspeed: Use v4l2_dbg to replace v4l2_warn to avoid
 log spam
To:     Jammy Huang <jammy_huang@aspeedtech.com>
References: <20221110095611.522-1-jammy_huang@aspeedtech.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     eajames@linux.ibm.com, mchehab@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, hverkuil-cisco@xs4all.nl, zev@bewilderbeest.net,
        linux-media@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221110095611.522-1-jammy_huang@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jammy,


Am 10.11.22 um 10:56 schrieb Jammy Huang:
> If the host is powered off, there will be many warning log. To avoid the

…, many warnings are logged.

Also, please paste one example message.

Are the messages really just debug messages, or only in the one 
condition? If the latter, another solution should be found, like 
checking if the host is powered off, or rate limiting the message.

> log spam in this condition, replace v4l2_warn with v4l2_dbg.

Please add a reference, to Zev’s report on the mailing list.

Link: …

> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>   drivers/media/platform/aspeed/aspeed-video.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
> index cf76aeee8cb6..662465d13a0e 100644
> --- a/drivers/media/platform/aspeed/aspeed-video.c
> +++ b/drivers/media/platform/aspeed/aspeed-video.c
> @@ -586,13 +586,13 @@ static int aspeed_video_start_frame(struct aspeed_video *video)
>   	bool bcd_buf_need = (video->format != VIDEO_FMT_STANDARD);
>   
>   	if (video->v4l2_input_status) {
> -		v4l2_warn(&video->v4l2_dev, "No signal; don't start frame\n");
> +		v4l2_dbg(1, debug, &video->v4l2_dev, "No signal; don't start frame\n");
>   		return 0;
>   	}
>   
>   	if (!(seq_ctrl & VE_SEQ_CTRL_COMP_BUSY) ||
>   	    !(seq_ctrl & VE_SEQ_CTRL_CAP_BUSY)) {
> -		v4l2_warn(&video->v4l2_dev, "Engine busy; don't start frame\n");
> +		v4l2_dbg(1, debug, &video->v4l2_dev, "Engine busy; don't start frame\n");
>   		return -EBUSY;
>   	}
>   
> @@ -615,7 +615,7 @@ static int aspeed_video_start_frame(struct aspeed_video *video)
>   				       struct aspeed_video_buffer, link);
>   	if (!buf) {
>   		spin_unlock_irqrestore(&video->lock, flags);
> -		v4l2_warn(&video->v4l2_dev, "No buffers; don't start frame\n");
> +		v4l2_dbg(1, debug, &video->v4l2_dev, "No buffers; don't start frame\n");
>   		return -EPROTO;
>   	}
>   
> @@ -796,7 +796,7 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
>   			if (video->format == VIDEO_FMT_STANDARD &&
>   			    list_is_last(&buf->link, &video->buffers)) {
>   				empty = false;
> -				v4l2_warn(&video->v4l2_dev, "skip to keep last frame updated\n");
> +				v4l2_dbg(1, debug, &video->v4l2_dev, "skip to keep last frame updated\n");
>   			} else {
>   				buf->vb.vb2_buf.timestamp = ktime_get_ns();
>   				buf->vb.sequence = video->sequence++;
> @@ -1060,7 +1060,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>   						      res_check(video),
>   						      MODE_DETECT_TIMEOUT);
>   		if (!rc) {
> -			v4l2_warn(&video->v4l2_dev, "Timed out; first mode detect\n");
> +			v4l2_dbg(1, debug, &video->v4l2_dev, "Timed out; first mode detect\n");
>   			clear_bit(VIDEO_RES_DETECT, &video->flags);
>   			return;
>   		}
> @@ -1081,7 +1081,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>   						      MODE_DETECT_TIMEOUT);
>   		clear_bit(VIDEO_RES_DETECT, &video->flags);
>   		if (!rc) {
> -			v4l2_warn(&video->v4l2_dev, "Timed out; second mode detect\n");
> +			v4l2_dbg(1, debug, &video->v4l2_dev, "Timed out; second mode detect\n");
>   			return;
>   		}
>   
> @@ -1104,7 +1104,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>   	} while (invalid_resolution && (tries++ < INVALID_RESOLUTION_RETRIES));
>   
>   	if (invalid_resolution) {
> -		v4l2_warn(&video->v4l2_dev, "Invalid resolution detected\n");
> +		v4l2_dbg(1, debug, &video->v4l2_dev, "Invalid resolution detected\n");
>   		return;
>   	}
>   
> @@ -1856,7 +1856,7 @@ static void aspeed_video_stop_streaming(struct vb2_queue *q)
>   				!test_bit(VIDEO_FRAME_INPRG, &video->flags),
>   				STOP_TIMEOUT);
>   	if (!rc) {
> -		v4l2_warn(&video->v4l2_dev, "Timed out when stopping streaming\n");
> +		v4l2_dbg(1, debug, &video->v4l2_dev, "Timed out when stopping streaming\n");
>   
>   		/*
>   		 * Need to force stop any DMA and try and get HW into a good
> 
> base-commit: aae703b02f92bde9264366c545e87cec451de471
> prerequisite-patch-id: bf47e8ab2998acfbc32be5a4b7b5ae8a3ae4218b
> prerequisite-patch-id: bf82715983e08f2e810ff1a82ce644f5f9006cd9
> prerequisite-patch-id: 28a2040ef0235e5765f05d2fc5529bce2a0f4c6f
> prerequisite-patch-id: 7e761c779730536db8baf50db5fc8caf058e95af
> prerequisite-patch-id: c48ea20973fa35938a7d33a0e20d2900df48755f
