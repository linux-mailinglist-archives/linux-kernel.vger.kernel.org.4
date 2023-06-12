Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E533572CAB7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbjFLPwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjFLPwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:52:22 -0400
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [46.30.211.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A002910CB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=0dH/oRTF+guHoZ2aCWN+cBBdc2GgeZgNnM5H0oi1HW4=;
        b=DMtMgFCAz8w7xuqqwYQEelOFxaeBNhQtvqYwwISUTOg8g2iShVN++VhldRLQdgcDAgvH99ZUi+oJp
         CwVxMrM7vajMBm9WqrSlplxhTAPwSVuEnkGTno6XKYuvIHAEFf2trhvCjt0tgZohDlZGk1cctDlKDy
         sZs/PNip22Gz1uuHwbDZ+dQbas6FDwiXHLJt+Ef99n4SGti2R0Kau+Vtm2gi1Jjsva1ATGOG7pShy/
         OpN/jmoHycVOlVrUt1s/DaVTsMu1uHiejykIGIYDjIxg7EFpiYzHHh33eIev94IBXKB73gW1gQYE+C
         rFawV5zUMLGMnV1vsOHCAF3gsTQZRpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=0dH/oRTF+guHoZ2aCWN+cBBdc2GgeZgNnM5H0oi1HW4=;
        b=kFjPfBgFI4g//7VhHuxMhjP+4sZby/YSx6Dh7J8cEwhi3J80mOiahDnmMFj548RhMJQlsKeOvepCH
         N2dDRd0CA==
X-HalOne-ID: f48a10d7-0938-11ee-bd17-231b2edd0ed2
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay5 (Halon) with ESMTPSA
        id f48a10d7-0938-11ee-bd17-231b2edd0ed2;
        Mon, 12 Jun 2023 15:51:14 +0000 (UTC)
Date:   Mon, 12 Jun 2023 17:51:12 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, javierm@redhat.com, deller@gmx.de,
        geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 21/38] fbdev/radeonfb: Reorder backlight and
 framebuffer cleanup
Message-ID: <20230612155112.GB1243864@ravnborg.org>
References: <20230612141352.29939-1-tzimmermann@suse.de>
 <20230612141352.29939-22-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612141352.29939-22-tzimmermann@suse.de>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Jun 12, 2023 at 04:07:59PM +0200, Thomas Zimmermann wrote:
> The driver's backlight code requires the framebuffer to be
> registered. Therefore reorder the cleanup calls for both data
> structures. The init calls are already in the correct order.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  drivers/video/fbdev/aty/radeon_base.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
> index 972c4bbedfa36..8f2a527c26ebf 100644
> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -2517,9 +2517,8 @@ static void radeonfb_pci_unregister(struct pci_dev *pdev)
>  
>  	del_timer_sync(&rinfo->lvds_timer);
>  	arch_phys_wc_del(rinfo->wc_cookie);
> -        unregister_framebuffer(info);
> -
>          radeonfb_bl_exit(rinfo);
> +	unregister_framebuffer(info);
>  
>          iounmap(rinfo->mmio_base);
>          iounmap(rinfo->fb_base);
The mix of spaces and tabs for indent looks strange in the diff.
Consider to use the style of the surrounding code if you are going to
refresh the patch-set.

	Sam
