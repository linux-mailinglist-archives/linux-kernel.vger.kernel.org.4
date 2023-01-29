Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA8B67FD7D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 08:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjA2H6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 02:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjA2H6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 02:58:34 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D59206A0;
        Sat, 28 Jan 2023 23:58:33 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id s67so5716765pgs.3;
        Sat, 28 Jan 2023 23:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kzKr+TJAqT7F7z/9v5ayYMXFB2YFYwz9vAKvcRSlKT0=;
        b=M5kO+rqKkqjnnJkONowxwIaf5e9+NCn048MMDMZOIPpxoyczf2CI+CQvkAW0Xm0ocC
         8NGFuOnlLWv630EzzayZfwUB4C0KHckCwSkTBkX3nVo3Yy9i/yjxr/iSG/eTFECVZC/2
         3YOgx/SG3ef4eae0V/1qNxn+N5iwAniNTlxNhZ7G84eXNHThGlbdi93m1qkfV9mruEjN
         t5vrKM8kqXixkxHFlnOYLSB4JEXf36Gxlu44Nvi0651KHByz8TFNZEtFdKuNJwZli+xs
         dI4EwyJehc5JOT06UCtLPyCaGfA0ZGkq4Rm4mh4IAcNTgs47WtyGyvK7DhdEMQCyhk4V
         AqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzKr+TJAqT7F7z/9v5ayYMXFB2YFYwz9vAKvcRSlKT0=;
        b=zTdHTpHHajWhKKdU/5YJDPuiEQyX2HxUOKzUvjgBg7km3S3mQNUccD5EMNiy/Un9eK
         6ehG7CtixPCb1GsflltgpQZs768Ss8UXwvs7nGbLQq9bgYEFoUj41xKr98bHgH/SIssj
         t+0xHh+hCM8bh4C+CeqXZcIoMcNd90Qfou0WO0lK5BIeILP1EE4EbqjLYoxngPKnblDj
         o5qRl+1nvNVEwdkk1X9a+ImYZysc1onXrdd8oLfwjO72s88PbxKtok9Yu7Ec3D3VJAEl
         G1t3LPRvxm2+LQRLHkrw9MTFGzMwoZAdDkZtL1R8WVeAH9Ux3Y/iiTDh4jg+GSjxFcAd
         2Pyg==
X-Gm-Message-State: AFqh2kqrTj1O9Ssq3aQKsHmK6qNhpzTBrzfXB5S39EYcmDnpNE0rgZVj
        NsMI174A3t/QLYSd9IjXjF3JKTmqupayap6e+1I6zPOp+VM=
X-Google-Smtp-Source: AMrXdXvx+wlBpulzGXBvdiRG79FdiAvCIRPaA0HgMiHIK10Dapr0pdrS8RP0Tu7WZIhb/cp+J5YgEPjiCP5qVNeqe6o=
X-Received: by 2002:aa7:820f:0:b0:58d:a713:d1dd with SMTP id
 k15-20020aa7820f000000b0058da713d1ddmr5698790pfi.59.1674979112473; Sat, 28
 Jan 2023 23:58:32 -0800 (PST)
MIME-Version: 1.0
References: <20230127165834.11387-1-tiwai@suse.de>
In-Reply-To: <20230127165834.11387-1-tiwai@suse.de>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Sun, 29 Jan 2023 08:58:21 +0100
Message-ID: <CAMeQTsZxdNXFscgR6s1y4L1b9jczQYL7CqKjyjMYNSTTC0aydQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev: Fix invalid page access after closing deferred I/O devices
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Patrik Jakobsson <pjakobsson@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 5:58 PM Takashi Iwai <tiwai@suse.de> wrote:
>
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

For some reason my first review didn't make it to the list. Trying
again with my other email.

As kernel test robot says, we need to check CONFIG_FB_DEFERRED_IO
around access to info->fbdefio.

With that fixed:
Reviewed-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

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
>         struct fb_deferred_io *fbdefio = info->fbdefio;
>         struct page *page;
> @@ -327,6 +327,14 @@ void fb_deferred_io_cleanup(struct fb_info *info)
>                 page = fb_deferred_io_page(info, i);
>                 page->mapping = NULL;
>         }
> +}
> +EXPORT_SYMBOL_GPL(fb_deferred_io_release);
> +
> +void fb_deferred_io_cleanup(struct fb_info *info)
> +{
> +       struct fb_deferred_io *fbdefio = info->fbdefio;
> +
> +       fb_deferred_io_release(info);
>
>         kvfree(info->pagerefs);
>         mutex_destroy(&fbdefio->lock);
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 3a6c8458eb8d..78c4cb5ee7c9 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1454,6 +1454,8 @@ __releases(&info->lock)
>         struct fb_info * const info = file->private_data;
>
>         lock_fb_info(info);
> +       if (info->fbdefio)
> +               fb_deferred_io_release(info);
>         if (info->fbops->fb_release)
>                 info->fbops->fb_release(info,1);
>         module_put(info->fbops->owner);
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 96b96323e9cb..73eb1f85ea8e 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -662,6 +662,7 @@ extern int  fb_deferred_io_init(struct fb_info *info);
>  extern void fb_deferred_io_open(struct fb_info *info,
>                                 struct inode *inode,
>                                 struct file *file);
> +extern void fb_deferred_io_release(struct fb_info *info);
>  extern void fb_deferred_io_cleanup(struct fb_info *info);
>  extern int fb_deferred_io_fsync(struct file *file, loff_t start,
>                                 loff_t end, int datasync);
> --
> 2.35.3
>
