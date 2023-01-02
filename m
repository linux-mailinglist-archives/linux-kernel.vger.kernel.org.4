Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF3C65B6AD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjABSo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjABSoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:44:46 -0500
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:405::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A15BE08
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 10:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=uEHKxfoCnx6TexhJbOGzWn9HamFVFhhnfdWyeUvLDuM=;
        b=DlI7Vbz9YgLFBKlF/Dc8ATToeFVQYmNjnZ51aSk7mq23G0wOMc3mCf2MEhKnUwXhZl8SiQqEi/DzI
         zgyvSR2KWU13taVEEvNSGIfAqvhgroQPdJCSVX//RpoR1Uq2yUsHJfoxhINz944XfHL2oIHIKdJ9xL
         73OWMHF+0n0WGKvf0KPxgXbvIi681368P2CCEgLQ58cXR1qPtEnyV/FwlnuOlYv7MOFXLljnaFY4L4
         mZVoEvFlbjKFpHISLPWMSBvar23ZVBsauXEjnd5k8sV4PLf65srbIJH1M/+PJRwu4il7g8KTfixflI
         1++g88EKsWn+AOzs6wn06JeQkkZFbnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=uEHKxfoCnx6TexhJbOGzWn9HamFVFhhnfdWyeUvLDuM=;
        b=G6sXXQscTLuda+dCOxPdrk99ogcGNwABYW5nPcBxNuvRfBnHvbqxm/ryTakBqYeDxJokkMy87uVwA
         fkTTEqYDg==
X-HalOne-ID: 844a0a16-8acd-11ed-918d-cde5ad41a1dd
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay6 (Halon) with ESMTPSA
        id 844a0a16-8acd-11ed-918d-cde5ad41a1dd;
        Mon, 02 Jan 2023 18:44:42 +0000 (UTC)
Date:   Mon, 2 Jan 2023 19:44:41 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 05/14] drm/panel-elida-kd35t133: Drop custom DSI write
 macro
Message-ID: <Y7MmGVMbc4u9NYNd@ravnborg.org>
References: <20221228014757.3170486-1-javierm@redhat.com>
 <20221228014757.3170486-6-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228014757.3170486-6-javierm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Wed, Dec 28, 2022 at 02:47:48AM +0100, Javier Martinez Canillas wrote:
> There is a macro for this already in the <drm/drm_mipi_dsi.h> header, use
> that instead and delete the custom DSI write macro defined in the driver.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  drivers/gpu/drm/panel/panel-elida-kd35t133.c | 34 ++++++++------------
>  1 file changed, 13 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
> index eee714cf3f49..48535ea3f1d3 100644
> --- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
> +++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
> @@ -51,14 +51,6 @@ static inline struct kd35t133 *panel_to_kd35t133(struct drm_panel *panel)
>  	return container_of(panel, struct kd35t133, panel);
>  }
>  
> -#define dsi_dcs_write_seq(dsi, cmd, seq...) do {			\
> -		static const u8 b[] = { cmd, seq };			\
> -		int ret;						\
> -		ret = mipi_dsi_dcs_write_buffer(dsi, b, ARRAY_SIZE(b));	\
> -		if (ret < 0)						\
> -			return ret;					\
> -	} while (0)
> -
>  static int kd35t133_init_sequence(struct kd35t133 *ctx)
>  {
>  	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
> @@ -68,24 +60,24 @@ static int kd35t133_init_sequence(struct kd35t133 *ctx)
>  	 * Init sequence was supplied by the panel vendor with minimal
>  	 * documentation.
>  	 */
> -	dsi_dcs_write_seq(dsi, KD35T133_CMD_POSITIVEGAMMA,
> +	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POSITIVEGAMMA,
>  			  0x00, 0x13, 0x18, 0x04, 0x0f, 0x06, 0x3a, 0x56,
>  			  0x4d, 0x03, 0x0a, 0x06, 0x30, 0x3e, 0x0f);
Fix indent, here and later.
With this fixed:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

> -	dsi_dcs_write_seq(dsi, KD35T133_CMD_NEGATIVEGAMMA,
> +	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_NEGATIVEGAMMA,
>  			  0x00, 0x13, 0x18, 0x01, 0x11, 0x06, 0x38, 0x34,
>  			  0x4d, 0x06, 0x0d, 0x0b, 0x31, 0x37, 0x0f);
> -	dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL1, 0x18, 0x17);
> -	dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL2, 0x41);
> -	dsi_dcs_write_seq(dsi, KD35T133_CMD_VCOMCONTROL, 0x00, 0x1a, 0x80);
> -	dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x48);
> -	dsi_dcs_write_seq(dsi, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
> -	dsi_dcs_write_seq(dsi, KD35T133_CMD_INTERFACEMODECTRL, 0x00);
> -	dsi_dcs_write_seq(dsi, KD35T133_CMD_FRAMERATECTRL, 0xa0);
> -	dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYINVERSIONCTRL, 0x02);
> -	dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYFUNCTIONCTRL,
> +	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL1, 0x18, 0x17);
> +	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL2, 0x41);
> +	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_VCOMCONTROL, 0x00, 0x1a, 0x80);
> +	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x48);
> +	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
> +	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_INTERFACEMODECTRL, 0x00);
> +	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_FRAMERATECTRL, 0xa0);
> +	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYINVERSIONCTRL, 0x02);
> +	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYFUNCTIONCTRL,
>  			  0x20, 0x02);
> -	dsi_dcs_write_seq(dsi, KD35T133_CMD_SETIMAGEFUNCTION, 0x00);
> -	dsi_dcs_write_seq(dsi, KD35T133_CMD_ADJUSTCONTROL3,
> +	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_SETIMAGEFUNCTION, 0x00);
> +	mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_ADJUSTCONTROL3,
>  			  0xa9, 0x51, 0x2c, 0x82);
>  	mipi_dsi_dcs_write(dsi, MIPI_DCS_ENTER_INVERT_MODE, NULL, 0);
>  
> -- 
> 2.38.1
