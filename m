Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032DF67FB26
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 22:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjA1Vbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 16:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjA1Vbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 16:31:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F63B1DB89;
        Sat, 28 Jan 2023 13:31:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B6E7F2228D;
        Sat, 28 Jan 2023 21:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674941500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lOfcriW/CJmr7HzgUiwJfhcc5+KRom0nCF1f1hpSBS4=;
        b=HS5MqC3Q76GX4oHy2jBobUiNlykjj/LmhKD9TbJJsvI/zrKXclcBUj7PFzHVsjtxgG4Zc3
        w+mMMqMzLAKuZ4UDwMBJeYOqPD7AZZAjUUTUGXktBD2IegCgtxaHTivatgesgSob8wGaK5
        Q1n0wbEm7WYzsR3iqiABkqCzH0cwOJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674941500;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lOfcriW/CJmr7HzgUiwJfhcc5+KRom0nCF1f1hpSBS4=;
        b=hQfzaWM9LAUjR9lUc8gaNOSV7tV3foiBE5UAME/JBvEHtMQZ8IKgvgE0ZCNjD0KVLR2nQk
        Ft13wP/XBB5nA6Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9ED6C13918;
        Sat, 28 Jan 2023 21:31:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R9DbJDyU1WN0TgAAMHmgww
        (envelope-from <pjakobsson@suse.de>); Sat, 28 Jan 2023 21:31:40 +0000
Date:   Sat, 28 Jan 2023 22:31:40 +0100
From:   Patrik Jakobsson <pjakobsson@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] fbdev: Fix invalid page access after closing deferred
 I/O devices
Message-ID: <20230128213140.b54wgvupuldexvzk@workstation>
References: <20230127165834.11387-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127165834.11387-1-tiwai@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 05:58:34PM +0100, Takashi Iwai wrote:
> When a fbdev with deferred I/O is once opened and closed, the dirty
> pages still remain queued in the pageref list, and eventually later
> those may be processed in the delayed work.  This may lead to a
> corruption of pages, hitting an Oops.
> 
> This patch makes sure to cancel the delayed work and clean up the
> pageref list at closing the device for addressing the bug.  A part of
> the cleanup code is factored out as a new helper function that is
> called from the common fb_release().
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Patrik Jakobsson <pjakobsson@suse.de>

> ---
>  drivers/video/fbdev/core/fb_defio.c | 10 +++++++++-
>  drivers/video/fbdev/core/fbmem.c    |  2 ++
>  include/linux/fb.h                  |  1 +
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
> index c730253ab85c..583cbcf09446 100644
> --- a/drivers/video/fbdev/core/fb_defio.c
> +++ b/drivers/video/fbdev/core/fb_defio.c
> @@ -313,7 +313,7 @@ void fb_deferred_io_open(struct fb_info *info,
>  }
>  EXPORT_SYMBOL_GPL(fb_deferred_io_open);
>  
> -void fb_deferred_io_cleanup(struct fb_info *info)
> +void fb_deferred_io_release(struct fb_info *info)
>  {
>  	struct fb_deferred_io *fbdefio = info->fbdefio;
>  	struct page *page;
> @@ -327,6 +327,14 @@ void fb_deferred_io_cleanup(struct fb_info *info)
>  		page = fb_deferred_io_page(info, i);
>  		page->mapping = NULL;
>  	}
> +}
> +EXPORT_SYMBOL_GPL(fb_deferred_io_release);
> +
> +void fb_deferred_io_cleanup(struct fb_info *info)
> +{
> +	struct fb_deferred_io *fbdefio = info->fbdefio;
> +
> +	fb_deferred_io_release(info);
>  
>  	kvfree(info->pagerefs);
>  	mutex_destroy(&fbdefio->lock);
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 3a6c8458eb8d..78c4cb5ee7c9 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1454,6 +1454,8 @@ __releases(&info->lock)
>  	struct fb_info * const info = file->private_data;
>  
>  	lock_fb_info(info);
> +	if (info->fbdefio)
> +		fb_deferred_io_release(info);
>  	if (info->fbops->fb_release)
>  		info->fbops->fb_release(info,1);
>  	module_put(info->fbops->owner);
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 96b96323e9cb..73eb1f85ea8e 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -662,6 +662,7 @@ extern int  fb_deferred_io_init(struct fb_info *info);
>  extern void fb_deferred_io_open(struct fb_info *info,
>  				struct inode *inode,
>  				struct file *file);
> +extern void fb_deferred_io_release(struct fb_info *info);
>  extern void fb_deferred_io_cleanup(struct fb_info *info);
>  extern int fb_deferred_io_fsync(struct file *file, loff_t start,
>  				loff_t end, int datasync);
> -- 
> 2.35.3
> 
