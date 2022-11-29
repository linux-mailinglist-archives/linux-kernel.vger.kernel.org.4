Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEFC63BAC7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiK2HeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiK2HeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:34:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0885429BB;
        Mon, 28 Nov 2022 23:34:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D059B811BE;
        Tue, 29 Nov 2022 07:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471A9C433C1;
        Tue, 29 Nov 2022 07:34:04 +0000 (UTC)
Message-ID: <f53b0b08-3f35-184e-5be4-3143192e3e44@xs4all.nl>
Date:   Tue, 29 Nov 2022 08:34:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] media: platform: Fix missing error code in
 rzg2l_cru_start_streaming_vq()
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, mchehab@kernel.org
Cc:     p.zabel@pengutronix.de, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20221129031712.115354-1-jiapeng.chong@linux.alibaba.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20221129031712.115354-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiapeng Chong,

Please repost with a proper subject line prefix: "media: rzg2l-cru:".

The 'media: platform:' prefix suggests a media/platform-wide patch, not a patch
for a single driver.

Why is this so hard to do?

Regards,

	Hans


On 29/11/2022 04:17, Jiapeng Chong wrote:
> Failed to allocate scratch buffer, add the error code '-ENOMEM' to the
> return value 'ret'.
> 
> drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c:676 rzg2l_cru_start_streaming_vq() warn: missing error code 'ret'.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3275
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> index 9533e4069ecd..91b57c7c2e56 100644
> --- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> @@ -673,6 +673,7 @@ static int rzg2l_cru_start_streaming_vq(struct vb2_queue *vq, unsigned int count
>  	if (!cru->scratch) {
>  		return_unused_buffers(cru, VB2_BUF_STATE_QUEUED);
>  		dev_err(cru->dev, "Failed to allocate scratch buffer\n");
> +		ret = -ENOMEM;
>  		goto free_image_conv_irq;
>  	}
>  

