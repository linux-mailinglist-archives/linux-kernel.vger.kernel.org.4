Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A74E6B3F02
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjCJMSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjCJMSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:18:35 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A137260430;
        Fri, 10 Mar 2023 04:18:33 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id d6so2924643pgu.2;
        Fri, 10 Mar 2023 04:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678450713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQWRSFkOKg9T+y+gldqtOznj/eHaxJktJYeXp0a1CHE=;
        b=X0m1GIXnFLZSnUIMC8tXN3MjJv2mxoBg8j2HZE1gg2EljBsDDqNYawAJnqQehG+RDZ
         jREisZCDSP7uiTfTAzwc3iYvaxlipaIEe4mVodlCBoTZWs8w6U7akm8BvQ+aWBONC1Ma
         eMo92jTbE2ZwwnlBKTpzCSdPq+/Jj5e6H3mNm1wDenRXdNr5rXW/7S/kmgvV/kVSOi0o
         6NZsvabnM3diJ2x45r8E1KnETDQhbIW6zA367SagnJtl4kDNP1sDJGBjjMLF/D5uyxI7
         /+xD6E14oxPxTw9wQu39kcQgH4J4ZORMsSrYgdK6smLGNG1OOVp4D3C2Vsqqtphi3ZCd
         IHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678450713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQWRSFkOKg9T+y+gldqtOznj/eHaxJktJYeXp0a1CHE=;
        b=pE4XLSkp8dXzH3Ojub9IboJoRX+Mp/aXsMsBs9vweqJ01eJFMwCvRLjN/gyaoTTuMj
         LZBp4Olkhv+QfC0ap+Ii55m8nPH6RsT39VdxPwLddzUISlNWe5BfTAHR+AkYWmR0eQF7
         c6dUPbmYODZA+Tp372wCcs94ua0rYqOzfB4R1YDwN9PlOqeagNoj3LGRhAiNPysfOhHF
         tAKfKixly56QfIBOqG9peRvEpWu/Q2liKaX+rYynq2vrjwXBjQOS7/BhzXI+McBTeOMt
         oVG3D3QVxpvr8QFqon/iSt+F9OCORMnm+Kl75y9LpqE9/By0j2NkdTHdzYWwirYbZrY0
         4P0A==
X-Gm-Message-State: AO0yUKV5hzj4W/7/kpgnBU89Gc41n+QulFcOuWOajCQFWEbMH806Dur1
        QP3o70d9ZUmT1mImM++duZePM49IAM0De6Zxd6g=
X-Google-Smtp-Source: AK7set+IE1/l1QhMtQeSm2c0wnMVPaxpSDAntt8hngJitI03+uAOBDkn81AVlY6BxhtlRQmUYaAGdEm2Y/elvAsSZTg=
X-Received: by 2002:a62:cd83:0:b0:5e5:7675:88e3 with SMTP id
 o125-20020a62cd83000000b005e5767588e3mr10322774pfg.5.1678450713012; Fri, 10
 Mar 2023 04:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20230308105012.1845-1-tiwai@suse.de>
In-Reply-To: <20230308105012.1845-1-tiwai@suse.de>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Fri, 10 Mar 2023 13:18:21 +0100
Message-ID: <CAMeQTsbFuoP4KXmMm4xbwvXOjYw5CYJs6q2nnMuRYHsutrX0aw@mail.gmail.com>
Subject: Re: [PATCH v2] fbdev: Fix incorrect page mapping clearance at fb_deferred_io_release()
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

On Wed, Mar 8, 2023 at 11:50=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrote:
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
> As both fb_deferred_io_open() and _close() are called always in the
> fb_info lock (mutex), it's safe to use the normal int for the
> refcounting.
>
> Also, a useless BUG_ON() is dropped.
>
> Fixes: 3efc61d95259 ("fbdev: Fix invalid page access after closing deferr=
ed I/O devices")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Looks good to me

Reviewed-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

> ---
> v1->v2:
> * Rename to fb_deferred_io_lastclose()
> * Rename the new field from opens to open_count
> * Removed unused variable
> * More comments about fb_info locking
>
>  drivers/video/fbdev/core/fb_defio.c | 17 +++++++++++++----
>  include/linux/fb.h                  |  1 +
>  2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/co=
re/fb_defio.c
> index aa5f059d0222..274f5d0fa247 100644
> --- a/drivers/video/fbdev/core/fb_defio.c
> +++ b/drivers/video/fbdev/core/fb_defio.c
> @@ -305,17 +305,18 @@ void fb_deferred_io_open(struct fb_info *info,
>                          struct inode *inode,
>                          struct file *file)
>  {
> +       struct fb_deferred_io *fbdefio =3D info->fbdefio;
> +
>         file->f_mapping->a_ops =3D &fb_deferred_io_aops;
> +       fbdefio->open_count++;
>  }
>  EXPORT_SYMBOL_GPL(fb_deferred_io_open);
>
> -void fb_deferred_io_release(struct fb_info *info)
> +static void fb_deferred_io_lastclose(struct fb_info *info)
>  {
> -       struct fb_deferred_io *fbdefio =3D info->fbdefio;
>         struct page *page;
>         int i;
>
> -       BUG_ON(!fbdefio);
>         cancel_delayed_work_sync(&info->deferred_work);
>
>         /* clear out the mapping that we setup */
> @@ -324,13 +325,21 @@ void fb_deferred_io_release(struct fb_info *info)
>                 page->mapping =3D NULL;
>         }
>  }
> +
> +void fb_deferred_io_release(struct fb_info *info)
> +{
> +       struct fb_deferred_io *fbdefio =3D info->fbdefio;
> +
> +       if (!--fbdefio->open_count)
> +               fb_deferred_io_lastclose(info);
> +}
>  EXPORT_SYMBOL_GPL(fb_deferred_io_release);
>
>  void fb_deferred_io_cleanup(struct fb_info *info)
>  {
>         struct fb_deferred_io *fbdefio =3D info->fbdefio;
>
> -       fb_deferred_io_release(info);
> +       fb_deferred_io_lastclose(info);
>
>         kvfree(info->pagerefs);
>         mutex_destroy(&fbdefio->lock);
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index d8d20514ea05..02d09cb57f6c 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -212,6 +212,7 @@ struct fb_deferred_io {
>         /* delay between mkwrite and deferred handler */
>         unsigned long delay;
>         bool sort_pagereflist; /* sort pagelist by offset */
> +       int open_count; /* number of opened files; protected by fb_info l=
ock */
>         struct mutex lock; /* mutex that protects the pageref list */
>         struct list_head pagereflist; /* list of pagerefs for touched pag=
es */
>         /* callback */
> --
> 2.35.3
>
