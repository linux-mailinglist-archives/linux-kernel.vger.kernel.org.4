Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CA965B6C7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjABS4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbjABS4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:56:21 -0500
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:404::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCE21C4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 10:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=T70pOC09+NujKRVeR1akX6EBNTO9mHE+jSLlF9LW/Ck=;
        b=CGY7vkdVsWoDv28hYU39CZBRmGr0sQ5sc6Xee7Ui5MgOoBb/a4P6pfYwYrzM54WdbNfHrhCHK+O4o
         G6p7W4rfY3o8XMdMLrd29ClE5IuB3EtQv68A0JUnYgED18vWRMtffTxuZOgkgbJ9a3Z6cByHIK91dc
         JTvtV2RjUQTULGvtuWCmvF2xiMgY5sys0rJSX7dV3pEtD/3ZJ3q1fT8crMZm2OBGolhC1pIUAS6Abr
         eZ9gXI4zgQZ1gBmE5MqfF35NQonoabF00QxgyNkgLJkwjKsM0yo24clX3msfQHJ6HJhTYt929MNB5g
         NDriwf1vLZvxJHId/gd+ltPbp7QpBig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=T70pOC09+NujKRVeR1akX6EBNTO9mHE+jSLlF9LW/Ck=;
        b=catoolPBNx2RQt2NPCemAzAN3qkb/Fn4dnN5nM5fKVI4AAPGeMFKhNVcRyfxZgCO0IH9F+9tbqIsI
         n+0mRS9Cw==
X-HalOne-ID: 231ad9c3-8acf-11ed-820b-7703b0afff57
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay5 (Halon) with ESMTPSA
        id 231ad9c3-8acf-11ed-820b-7703b0afff57;
        Mon, 02 Jan 2023 18:56:19 +0000 (UTC)
Date:   Mon, 2 Jan 2023 19:56:17 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 10/14] drm/panel-samsung-sofef00: Drop custom DSI write
 macro
Message-ID: <Y7Mo0bTuzI3Nil0f@ravnborg.org>
References: <20221228014757.3170486-1-javierm@redhat.com>
 <20221228014757.3170486-11-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228014757.3170486-11-javierm@redhat.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 02:47:53AM +0100, Javier Martinez Canillas wrote:
> There is a macro for this already in the <drm/drm_mipi_dsi.h> header, use
> that instead and delete the custom DSI write macro defined in the driver.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
>  drivers/gpu/drm/panel/panel-samsung-sofef00.c | 24 +++++++------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-sofef00.c b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
> index 1a0d24595faa..9db49a028930 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-sofef00.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
> @@ -34,14 +34,6 @@ struct sofef00_panel *to_sofef00_panel(struct drm_panel *panel)
>  	return container_of(panel, struct sofef00_panel, panel);
>  }
>  
> -#define dsi_dcs_write_seq(dsi, seq...) do {				\
> -		static const u8 d[] = { seq };				\
> -		int ret;						\
> -		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));	\
> -		if (ret < 0)						\
> -			return ret;					\
> -	} while (0)
> -
>  static void sofef00_panel_reset(struct sofef00_panel *ctx)
>  {
>  	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> @@ -67,7 +59,7 @@ static int sofef00_panel_on(struct sofef00_panel *ctx)
>  	}
>  	usleep_range(10000, 11000);
>  
> -	dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
>  
>  	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
>  	if (ret < 0) {
> @@ -75,13 +67,13 @@ static int sofef00_panel_on(struct sofef00_panel *ctx)
>  		return ret;
>  	}
>  
> -	dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
> -	dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
> -	dsi_dcs_write_seq(dsi, 0xb0, 0x07);
> -	dsi_dcs_write_seq(dsi, 0xb6, 0x12);
> -	dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
> -	dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x20);
> -	dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
> +	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
> +	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq(dsi, 0xb0, 0x07);
> +	mipi_dsi_dcs_write_seq(dsi, 0xb6, 0x12);
> +	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
> +	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x20);
> +	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
>  
>  	ret = mipi_dsi_dcs_set_display_on(dsi);
>  	if (ret < 0) {
> -- 
> 2.38.1
