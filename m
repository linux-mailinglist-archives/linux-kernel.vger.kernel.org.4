Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF37564FF23
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 15:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiLROjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 09:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiLROjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 09:39:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA9B65CA
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 06:39:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8654F60D34
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 14:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CC1C433EF;
        Sun, 18 Dec 2022 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671374383;
        bh=nXWI4NnPj2evLqQogx54Y6YnlZ05bcN4H6W54oI+B14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EPelM1UBbt6zo1O+xsJFsUJe2nR96ebNUDshAgwXWubP6AUWwkHLHMazP4AXX2xU3
         B4V+9CpL5R5k6QwfT610jNxAQ5v9ehLkDVxv5WWuNRP361vaUapKEy+B/8ONLqn1fY
         fX/RnZguGkyy/RuirUYbUffsFvN87j5VrKR+76zj4WsGvIfwE7yPeyaLv5H0+1bvDY
         L7B87jxn2BuBafPwRRYgTc24aby8alQ2fb0W5A98tP69BQMsMU0uW/pwFw45p/gRDa
         pr/WLDyOe+CzFpqlfW/FxG+JWLE48RgP3ygc9omD2vWABbEn0b07nF7nlF70V1HO+s
         0PUogyaOkYDoQ==
Date:   Sun, 18 Dec 2022 15:39:38 +0100
From:   Alexey Gladkov <legion@kernel.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kbd@lists.altlinux.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbd] [patchv2 3/3] VT: Bump font size limitation to 64x128
 pixels
Message-ID: <Y58mKmE9Km+NujDa@example.org>
References: <20221218003209.503539532@ens-lyon.org>
 <20221218003237.503424466@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221218003237.503424466@ens-lyon.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 01:32:12AM +0100, Samuel Thibault wrote:
> This moves 32x32 font size limitation checking down to drivers, so that
> fbcon can allow large fonts.
> 
> We still keep a limitation to 64x128 pixels so as to have a simple bounded
> allocation for con_font_get and in the userland kbd tool. That glyph size
> will however be enough to have 128x36 characters on a "16/9 8K display".
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> ---
> V1 -> V2: Switch con_font_get to kvmalloc/kvfree instead of kmalloc/kfree
> 
> Index: linux-6.0/drivers/tty/vt/vt.c
> ===================================================================
> --- linux-6.0.orig/drivers/tty/vt/vt.c
> +++ linux-6.0/drivers/tty/vt/vt.c
> @@ -4575,17 +4575,20 @@ void reset_palette(struct vc_data *vc)
>  /*
>   *  Font switching
>   *
> - *  Currently we only support fonts up to 32 pixels wide, at a maximum height
> - *  of 32 pixels. Userspace fontdata is stored with 32 bytes (shorts/ints, 
> - *  depending on width) reserved for each character which is kinda wasty, but 
> - *  this is done in order to maintain compatibility with the EGA/VGA fonts. It 
> - *  is up to the actual low-level console-driver convert data into its favorite
> - *  format (maybe we should add a `fontoffset' field to the `display'
> - *  structure so we won't have to convert the fontdata all the time.
> + *  Currently we only support fonts up to 128 pixels wide, at a maximum height
> + *  of 128 pixels. Userspace fontdata may have to be stored with 32 bytes
> + *  (shorts/ints, depending on width) reserved for each character which is
> + *  kinda wasty, but this is done in order to maintain compatibility with the
> + *  EGA/VGA fonts. It is up to the actual low-level console-driver convert data
> + *  into its favorite format (maybe we should add a `fontoffset' field to the
> + *  `display' structure so we won't have to convert the fontdata all the time.
>   *  /Jes
>   */
>  
> -#define max_font_size 65536
> +#define max_font_width	64
> +#define max_font_height	128
> +#define max_font_glyphs	512
> +#define max_font_size	(max_font_glyphs*max_font_width*max_font_height)

As a suggestion that you can safely ignore. Maybe make max_font_glyphs a
sysctl parameter to be able to use larger fonts ?

I get requests from time to time in kbd that it is not possible to load a
larger font.

>  static int con_font_get(struct vc_data *vc, struct console_font_op *op)
>  {
> @@ -4595,7 +4598,7 @@ static int con_font_get(struct vc_data *
>  	unsigned int vpitch = op->op == KD_FONT_OP_GET_TALL ? op->height : 32;
>  
>  	if (op->data) {
> -		font.data = kmalloc(max_font_size, GFP_KERNEL);
> +		font.data = kvmalloc(max_font_size, GFP_KERNEL);
>  		if (!font.data)
>  			return -ENOMEM;
>  	} else
> @@ -4630,7 +4633,7 @@ static int con_font_get(struct vc_data *
>  		rc = -EFAULT;
>  
>  out:
> -	kfree(font.data);
> +	kvfree(font.data);
>  	return rc;
>  }
>  
> @@ -4645,9 +4648,10 @@ static int con_font_set(struct vc_data *
>  		return -EINVAL;
>  	if (!op->data)
>  		return -EINVAL;
> -	if (op->charcount > 512)
> +	if (op->charcount > max_font_glyphs)
>  		return -EINVAL;
> -	if (op->width <= 0 || op->width > 32 || !op->height || op->height > 32)
> +	if (op->width <= 0 || op->width > max_font_width || !op->height ||
> +	    op->height > max_font_height)
>  		return -EINVAL;
>  	if (vpitch < op->height)
>  		return -EINVAL;
> Index: linux-6.0/drivers/usb/misc/sisusbvga/sisusb_con.c
> ===================================================================
> --- linux-6.0.orig/drivers/usb/misc/sisusbvga/sisusb_con.c
> +++ linux-6.0/drivers/usb/misc/sisusbvga/sisusb_con.c
> @@ -1203,7 +1203,7 @@ sisusbcon_font_set(struct vc_data *c, st
>  	struct sisusb_usb_data *sisusb;
>  	unsigned charcount = font->charcount;
>  
> -	if (font->width != 8 || vpitch != 32 ||
> +	if (font->width != 8 || font->height > 32 || vpitch != 32 ||
>  	    (charcount != 256 && charcount != 512))
>  		return -EINVAL;
>  
> Index: linux-6.0/drivers/video/console/vgacon.c
> ===================================================================
> --- linux-6.0.orig/drivers/video/console/vgacon.c
> +++ linux-6.0/drivers/video/console/vgacon.c
> @@ -1037,7 +1037,7 @@ static int vgacon_font_set(struct vc_dat
>  	if (vga_video_type < VIDEO_TYPE_EGAM)
>  		return -EINVAL;
>  
> -	if (font->width != VGA_FONTWIDTH || vpitch != 32 ||
> +	if (font->width != VGA_FONTWIDTH || font->height > 32 || vpitch != 32 ||
>  	    (charcount != 256 && charcount != 512))
>  		return -EINVAL;
>  
> Index: linux-6.0/drivers/video/fbdev/core/fbcon.c
> ===================================================================
> --- linux-6.0.orig/drivers/video/fbdev/core/fbcon.c
> +++ linux-6.0/drivers/video/fbdev/core/fbcon.c
> @@ -2279,6 +2279,8 @@ static int fbcon_get_font(struct vc_data
>  
>  	font->width = vc->vc_font.width;
>  	font->height = vc->vc_font.height;
> +	if (font->height > vpitch)
> +		return -ENOSPC;
>  	font->charcount = vc->vc_hi_font_mask ? 512 : 256;
>  	if (!font->data)
>  		return 0;
> 
> _______________________________________________
> kbd mailing list
> kbd@lists.altlinux.org
> https://lists.altlinux.org/mailman/listinfo/kbd
> 

-- 
Rgrds, legion

