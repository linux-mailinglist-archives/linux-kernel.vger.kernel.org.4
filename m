Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215E265B6B7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjABSuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjABSuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:50:05 -0500
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:404::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D30F7C
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 10:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=uKZ9ejEbAXP7LAVfMSwcGCdKOMN3DZwOJOtQ18Tjjb0=;
        b=rtX4Oo7lVaonQsqmuyXCRzwu6Up+606U51SnVP0KD23lyhq6l/u5Z4TdKWWL4+7/zD4ikEZR/qrfa
         ra04gDG8bUd49+ggEaxMOXATOoCS4z5j98VrhKyADywByJyaAJ5VLguKLnO+3uYRvj6c5yqrwnL+2r
         +AIPlE6b7X5ofywkL1UKcqRs5Z28xroZ333GU7khxPgS5HDyuCFpSf/qk0gHaig8Pe119PcOkMitNd
         x+CTRCpKn2WBFNSwlxVX6ezBXrwYnl2eg59cxJga9x3qiKcN1CI46cV9W75Ash/mABtvJgaxRLbcO4
         i6mDkNwmwOdV3iamRaEWrEDOlFLbcZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=uKZ9ejEbAXP7LAVfMSwcGCdKOMN3DZwOJOtQ18Tjjb0=;
        b=X3qh4Gfthhe/sY+JGg6/RVEgKUxbCG65xHR/PcqvPngrlpo3hkv1HEYGgDihfavFIyUPzVrN7Pw4u
         IgoMytKAw==
X-HalOne-ID: 41d0c376-8ace-11ed-81f5-7703b0afff57
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay5 (Halon) with ESMTPSA
        id 41d0c376-8ace-11ed-81f5-7703b0afff57;
        Mon, 02 Jan 2023 18:50:01 +0000 (UTC)
Date:   Mon, 2 Jan 2023 19:50:00 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 11/14] drm/panel-sharp-ls060t1sx01: Drop custom DSI write
 macro
Message-ID: <Y7MnWBaQfnDHHKqv@ravnborg.org>
References: <20221228014757.3170486-1-javierm@redhat.com>
 <20221228014757.3170486-12-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228014757.3170486-12-javierm@redhat.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 02:47:54AM +0100, Javier Martinez Canillas wrote:
> There is a macro for this already in the <drm/drm_mipi_dsi.h> header, use
> that instead and delete the custom DSI write macro defined in the driver.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

This is a nice patch - where you benefit from the more advanced macro,
and drop even more code.

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

> ---
> 
>  .../gpu/drm/panel/panel-sharp-ls060t1sx01.c   | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c b/drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c
> index 8a4e0c1fe73f..68f52eaaf4fa 100644
> --- a/drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c
> +++ b/drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c
> @@ -32,12 +32,6 @@ static inline struct sharp_ls060 *to_sharp_ls060(struct drm_panel *panel)
>  	return container_of(panel, struct sharp_ls060, panel);
>  }
>  
> -#define dsi_dcs_write_seq(dsi, seq...) ({				\
> -		static const u8 d[] = { seq };				\
> -									\
> -		mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));	\
> -	})
> -
>  static void sharp_ls060_reset(struct sharp_ls060 *ctx)
>  {
>  	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> @@ -56,17 +50,8 @@ static int sharp_ls060_on(struct sharp_ls060 *ctx)
>  
>  	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>  
> -	ret = dsi_dcs_write_seq(dsi, 0xbb, 0x13);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to send command: %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_MEMORY_START);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to send command: %d\n", ret);
> -		return ret;
> -	}
> +	mipi_dsi_dcs_write_seq(dsi, 0xbb, 0x13);
> +	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_MEMORY_START);
>  
>  	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
>  	if (ret < 0) {
> -- 
> 2.38.1
