Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E032C6B026D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjCHJJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjCHJJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:09:17 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035EBB719D;
        Wed,  8 Mar 2023 01:08:36 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id i5so17066473pla.2;
        Wed, 08 Mar 2023 01:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678266515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdds9wfgs29gdzt8sKvKPTyIOCg9hqKMEvaBr114uy4=;
        b=XdvK6v3pSk6FcKi8RUyxgG3I61e4nDI5t1H7Mqjd5NSsrLz0HxnDRxLuYNkkbhkmpg
         wWbZAuVh7PfVpELOcHLp/oTw2KTkxVbXRW5WCNs/1tXRoU/2ncIkVsjChyeJsD5dEFo0
         fvwTrpeWS2QwLdW7AnV8C2Y51DdAeCtvU2afrGfYX1scHmlQtgMgCVqzp7X8/QFJRBm2
         +YdFGFr70xC1GXga7GZGfjzhoWBw2dV1u+Dfy4s4DxSb9YY+WqItDe2hI56LNYBKe178
         IGB0MJsWx8jJpRnkLa1iyzObBdhAcXjrusS/RsUJUuUg+GhUB93NtzCWrT3HtTjA/9UY
         2zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdds9wfgs29gdzt8sKvKPTyIOCg9hqKMEvaBr114uy4=;
        b=Mukbpox+RCze1S+eeY7aGapQmsNpemoM0b7d3ihpR0S70Hw+TueuZCuy/8RDb8ImmS
         0sIYxzea06CP+fR+3eAO9IlNfWhx+zJq5IoYjrvN7ocMfIkrR+rWz0uZu7nh5ksWi2Y0
         zufa2bkl0VNcFDpHC1Si5sHu7YCg3CLtT0mwLAGxpnc7zAeP1t7UUE97Z8x8rtjWiEtW
         rGeg+AHXCtw9eo92UK8bs/iZ2L3f8kP0wZjvh168tSG0tDTTQSbNgfeDdTLtfusgxZ9b
         mY0pUXjqa5XtrvIUfkVCfubrj0+5TYv/ynpCkRgeealfZJDEKN5LPZDo/XoDJG4zDrrZ
         PG3Q==
X-Gm-Message-State: AO0yUKVXY5HwX9rbsBF7PHbVP25lYLazUaJvIukqC6kPYaIyxtqKnQKA
        cT82pOh/Zc6d+1ng90O57RtXMh2cF2XtMkX/FAP/T1UN/Q4=
X-Google-Smtp-Source: AK7set/t4WjcIseNy7HgHhXJu/mVmHYGr8n+kDDLwcJ9O3Ozy2MkSBarTAF0TdNVuc1B4pEIM/ypGE6/jYq8x4NqXKw=
X-Received: by 2002:a17:903:2614:b0:19b:b17:6610 with SMTP id
 jd20-20020a170903261400b0019b0b176610mr7066566plb.4.1678266515368; Wed, 08
 Mar 2023 01:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20230308063628.15233-1-tiwai@suse.de>
In-Reply-To: <20230308063628.15233-1-tiwai@suse.de>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Wed, 8 Mar 2023 10:08:24 +0100
Message-ID: <CAMeQTsYSgXm=Sku99USE+Up+uuJHUFdE8zPj7_B=BUi5SH=6KQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev: Fix incorrect page mapping clearance at fb_deferred_io_release()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, Miko Larsson <mikoxyzzz@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Patrik Jakobsson <pjakobsson@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 7:36=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrote:
>
> The recent fix for the deferred I/O by the commit
>   3efc61d95259 ("fbdev: Fix invalid page access after closing deferred I/=
O devices")
> caused a regression when the same fb device is opened/closed while
> it's being used.  It resulted in a frozen screen even if something
> is redrawn there after the close.  The breakage is because the patch
> was made under a wrong assumption of a single open; in the current
> code, fb_deferred_io_release() cleans up the page mapping of the
> pageref list and it calls cancel_delayed_work_sync() unconditionally,
> where both are no correct behavior for multiple opens.
>
> This patch adds a refcount for the opens of the device, and applies
> the cleanup only when all files get closed.
>
> Fixes: 3efc61d95259 ("fbdev: Fix invalid page access after closing deferr=
ed I/O devices")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/video/fbdev/core/fb_defio.c | 16 +++++++++++++---
>  include/linux/fb.h                  |  1 +
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/co=
re/fb_defio.c
> index aa5f059d0222..9dcec9e020b6 100644
> --- a/drivers/video/fbdev/core/fb_defio.c
> +++ b/drivers/video/fbdev/core/fb_defio.c
> @@ -305,17 +305,19 @@ void fb_deferred_io_open(struct fb_info *info,
>                          struct inode *inode,
>                          struct file *file)
>  {
> +       struct fb_deferred_io *fbdefio =3D info->fbdefio;
> +
>         file->f_mapping->a_ops =3D &fb_deferred_io_aops;
> +       fbdefio->opens++;
>  }
>  EXPORT_SYMBOL_GPL(fb_deferred_io_open);
>
> -void fb_deferred_io_release(struct fb_info *info)
> +static void fb_deferred_io_release_internal(struct fb_info *info)

Maybe a better name would be fb_deferred_io_lastclose() to be more in
line with DRM?

>  {
>         struct fb_deferred_io *fbdefio =3D info->fbdefio;
>         struct page *page;
>         int i;
>
> -       BUG_ON(!fbdefio);

Should the BUG_ON be put back into fb_deferred_io_release()?

>         cancel_delayed_work_sync(&info->deferred_work);
>
>         /* clear out the mapping that we setup */
> @@ -324,13 +326,21 @@ void fb_deferred_io_release(struct fb_info *info)
>                 page->mapping =3D NULL;
>         }
>  }
> +
> +void fb_deferred_io_release(struct fb_info *info)
> +{
> +       struct fb_deferred_io *fbdefio =3D info->fbdefio;
> +
> +       if (!--fbdefio->opens)
> +               fb_deferred_io_release_internal(info);

I think this can race so we need locking.

> +}
>  EXPORT_SYMBOL_GPL(fb_deferred_io_release);
>
>  void fb_deferred_io_cleanup(struct fb_info *info)
>  {
>         struct fb_deferred_io *fbdefio =3D info->fbdefio;
>
> -       fb_deferred_io_release(info);
> +       fb_deferred_io_release_internal(info);
>
>         kvfree(info->pagerefs);
>         mutex_destroy(&fbdefio->lock);
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index d8d20514ea05..29674a29d1c4 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -212,6 +212,7 @@ struct fb_deferred_io {
>         /* delay between mkwrite and deferred handler */
>         unsigned long delay;
>         bool sort_pagereflist; /* sort pagelist by offset */
> +       int opens; /* number of opened files */

I would prefer the name num_opens (or open_count as in DRM) instead of
opens since it can be interpreted as a verb.
Also, don't we need it to be atomic_t?

>         struct mutex lock; /* mutex that protects the pageref list */
>         struct list_head pagereflist; /* list of pagerefs for touched pag=
es */
>         /* callback */
> --
> 2.35.3
>
