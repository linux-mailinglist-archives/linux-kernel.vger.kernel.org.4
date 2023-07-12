Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9020750429
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjGLKMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjGLKMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:12:08 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FB01991;
        Wed, 12 Jul 2023 03:12:06 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 053DF61E5FE01;
        Wed, 12 Jul 2023 12:09:16 +0200 (CEST)
Message-ID: <461f3b88-87e6-32f2-3ed8-5764a9a6e162@molgen.mpg.de>
Date:   Wed, 12 Jul 2023 12:09:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: aspeed: Fix memory overwrite if timing is 1600x900
Content-Language: en-US
To:     Jammy Huang <jammy_huang@aspeedtech.com>
References: <20230712092606.2508-1-jammy_huang@aspeedtech.com>
Cc:     eajames@linux.ibm.com, mchehab@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230712092606.2508-1-jammy_huang@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jammy,


Thank you very much for your patch.

Am 12.07.23 um 11:26 schrieb Jammy Huang:
> When capturing 1600x900, system could crash when system memory usage is
> tight.

Please provide part of the trace, and if you have a commend to reproduce 
it, please also add it. Is it documented somewhere, that it needs to be 
aligned?

> The size of macro block captured is 8x8. Therefore, we should make sure
> the height of src-buf is 8 aligned to fix this issue.
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>   drivers/media/platform/aspeed/aspeed-video.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
> index 374eb7781936..14594f55a77f 100644
> --- a/drivers/media/platform/aspeed/aspeed-video.c
> +++ b/drivers/media/platform/aspeed/aspeed-video.c
> @@ -1130,7 +1130,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>   static void aspeed_video_set_resolution(struct aspeed_video *video)
>   {
>   	struct v4l2_bt_timings *act = &video->active_timings;
> -	unsigned int size = act->width * act->height;
> +	unsigned int size = act->width * ALIGN(act->height, 8);
>   
>   	/* Set capture/compression frame sizes */
>   	aspeed_video_calc_compressed_size(video, size);
> @@ -1147,7 +1147,7 @@ static void aspeed_video_set_resolution(struct aspeed_video *video)
>   		u32 width = ALIGN(act->width, 64);
>   
>   		aspeed_video_write(video, VE_CAP_WINDOW, width << 16 | act->height);
> -		size = width * act->height;
> +		size = width * ALIGN(act->height, 8);

Maybe add a comment.

Excuse my ignorance, but as `width` is already 64 bit aligned, how does 
aligning the second factor make a difference for `size`? Can you give an 
example?

>   	} else {
>   		aspeed_video_write(video, VE_CAP_WINDOW,
>   				   act->width << 16 | act->height);
> 
> base-commit: 2605e80d3438c77190f55b821c6575048c68268e


Kind regards,

Paul
