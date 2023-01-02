Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA5665B6C3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjABSzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjABSzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:55:20 -0500
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61776BE03
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 10:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=Jqdntt21bL7Yjq26W0YUxIQULOrcTsSva3Xle99cHtY=;
        b=ski8yGOkKzHAX6Gs2Xwez3f5FQT7X+yMioJlOE7wG5gL7byH4Q6Gvutj+bjx+H1C/3Y9rdZs0NiBt
         pnem6E5Ojxlkv/YAg0tXJQv/TlGr7e0gh4lqJ4Akgst7O4HeGqxeY187qRnevpGhXcgfQtazW78yJc
         GMV860cVTAIeEHMwIPiqUDykvNGrV0bdOnXuNLsbWASfnpk3d6ozJGs2aljoQBR8cnw416DhGLlPsQ
         JDjLFiKUeTCCrcMnuiuKic/6VkjoGyq+ulHFzy64BV10fngJpDCiBmNEikad9q+8sipdq3Oz0LN4xj
         cCeMIs9VC7c8jLub8i8dF7Dfekf6aJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=Jqdntt21bL7Yjq26W0YUxIQULOrcTsSva3Xle99cHtY=;
        b=lASuBO6+/smpGM7ICJFExO21ghrG8C1HUFNKGC4lvC6V7RPlN46WPOmYHHDhOicIwSZbhK0NM7Hg/
         eqyForeCA==
X-HalOne-ID: bef84d81-8acc-11ed-b424-ede074c87fad
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id bef84d81-8acc-11ed-b424-ede074c87fad;
        Mon, 02 Jan 2023 18:39:11 +0000 (UTC)
Date:   Mon, 2 Jan 2023 19:39:10 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 01/14] drm/mipi-dsi: Add a mipi_dsi_dcs_write_seq() macro
Message-ID: <Y7MkzucDEdsYenqX@ravnborg.org>
References: <20221228014757.3170486-1-javierm@redhat.com>
 <20221228014757.3170486-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228014757.3170486-2-javierm@redhat.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier.

On Wed, Dec 28, 2022 at 02:47:44AM +0100, Javier Martinez Canillas wrote:
> Many panel drivers define dsi_dcs_write_seq() and dsi_generic_write_seq()
> macros to send DCS commands and generic write packets respectively, with
> the payload specified as a list of parameters instead of using arrays.
> 
> There's already a macro for the former, introduced by commit 2a9e9daf75231
> ("drm/mipi-dsi: Introduce mipi_dsi_dcs_write_seq macro") so drivers can be
> changed to use that. But there isn't one yet for the latter, let's add it.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  include/drm/drm_mipi_dsi.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 20b21b577dea..c7c458131ba1 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -297,6 +297,22 @@ int mipi_dsi_dcs_set_display_brightness(struct mipi_dsi_device *dsi,
>  int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
>  					u16 *brightness);
>  
> +/**
> + * mipi_dsi_generic_write - transmit data using a generic write packet
s/mipi_dsi_generic_write/mipi_dsi_generic_write_seq
(As the bot also reported)

with this fixed:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

> + * @dsi: DSI peripheral device
> + * @seq: buffer containing the payload
> + */
> +#define mipi_dsi_generic_write_seq(dsi, seq...) do {				\
> +		static const u8 d[] = { seq };					\
> +		struct device *dev = &dsi->dev;	\
> +		int ret;						\
> +		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));	\
> +		if (ret < 0) {						\
> +			dev_err_ratelimited(dev, "transmit data failed: %d\n", ret); \
> +			return ret;						\
> +		}						\
> +	} while (0)
> +
(If you align '\' under each other it would be nicer, but I could see
that mipi_dsi_dcs_write_seq() do not do so).
>  /**
>   * mipi_dsi_dcs_write_seq - transmit a DCS command with payload
>   * @dsi: DSI peripheral device
> -- 
> 2.38.1
