Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D81A67FE96
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 12:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjA2Ld4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 06:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjA2Ldy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 06:33:54 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02571448A;
        Sun, 29 Jan 2023 03:33:52 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id mf7so5851728ejc.6;
        Sun, 29 Jan 2023 03:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7DeF/Im5Ox/EC8aY91BfzAVcVX2OaqPeNjgRIOWyYlo=;
        b=qher80ixuhNYiAm65L77Ie+Xe1m7zKiEpiceSOHBvZWm8iPx3lTRavImzkl4iFS43n
         m7e6yb6q8dXPr2MRNr7g8GkyvTstbGrIkLEsJ5/dJtaBoGXMUOKP8WPqFyb/DxiJAA8D
         YRjcZbXnJdl8bky2iTRfXoVwVqZ63HIxYiqaE/bFQuknncER2u6b5S1SuNeQ5DVWbUIM
         f4DiBcGGlxIFLeomnCBddw9bTfJ5WU6lgoTXHCti9DVRTkJLN7F1GHRmTpS4k9e2YDst
         nBbjz9df1jnuF4f/kV2vX4L/Un4OCoaf8i4yr5otQunsxrH0sxl++qPxRqclbSCGjx4H
         rd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7DeF/Im5Ox/EC8aY91BfzAVcVX2OaqPeNjgRIOWyYlo=;
        b=v+rfJvbG4FJzNVgtsKBSFAqnLPxck+YcaCg1jiVjS7+a8TGnfro2KpDRoleMs78h5r
         2wLYozp2D1t13ozJsmBdvsz8ZmZnxlx/z3iLeZf8a78OxjiD7PrjG5bS9OafornFbaAk
         +taQGMJSmWtNtyQEnFK0F8Hux/fUf8g/v3/ZBGKYkH2pz8eqHQerFuvMp+NW+CEJZkn8
         Y2EuD915a3ty4FDISmMCqr8pl6AwdydP/OFg3207lvZeNXJizPRhdSF9D2urG3F3Oead
         UcZnDfnMjlC/tJBnXrWB2W69TcHVn1Iu+8oWiVICiLRQ5FBxT/XWeUSbBe8IRjzdUvse
         2ghg==
X-Gm-Message-State: AO0yUKVftw3T6r/ALTtRt3t1vNuEuvoFtQqsmDEOBTAz+vYfzKWWeVZ4
        tuOjGYa8POlX6AZMiMNRhZY=
X-Google-Smtp-Source: AK7set8tkB+4AG0XBVkn/oUh87SFkhEebpfBV2rtvTsx7eOG3IgsqeqnA4HGkhbpJ9rfDTstLP6kxg==
X-Received: by 2002:a17:907:93d6:b0:87b:a1ed:4a57 with SMTP id cp22-20020a17090793d600b0087ba1ed4a57mr8555069ejc.16.1674992031588;
        Sun, 29 Jan 2023 03:33:51 -0800 (PST)
Received: from sakura.myxoz.lan (90-224-45-44-no2390.tbcn.telia.com. [90.224.45.44])
        by smtp.gmail.com with ESMTPSA id v14-20020a170906564e00b0081bfc79beaesm5172715ejr.75.2023.01.29.03.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 03:33:51 -0800 (PST)
Message-ID: <4bca96c7614eefa5e46959dc46bcb25165fd28cf.camel@gmail.com>
Subject: Re: [PATCH v2] fbdev: Fix invalid page access after closing
 deferred I/O devices
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>, Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Patrik Jakobsson <pjakobsson@suse.de>,
        Thomas Zimmermann <tzimmermann@suse.de>
Date:   Sun, 29 Jan 2023 12:33:50 +0100
In-Reply-To: <20230129082856.22113-1-tiwai@suse.de>
References: <20230129082856.22113-1-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.module_f37+15877+cf3308f9) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-01-29 at 09:28 +0100, Takashi Iwai wrote:
> When a fbdev with deferred I/O is once opened and closed, the dirty
> pages still remain queued in the pageref list, and eventually later
> those may be processed in the delayed work.=C2=A0 This may lead to a
> corruption of pages, hitting an Oops.
>=20
> This patch makes sure to cancel the delayed work and clean up the
> pageref list at closing the device for addressing the bug.=C2=A0 A part o=
f
> the cleanup code is factored out as a new helper function that is
> called from the common fb_release().
>=20
> Reviewed-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> v1->v2: Fix build error without CONFIG_FB_DEFERRED_IO
>=20
> =C2=A0drivers/video/fbdev/core/fb_defio.c | 10 +++++++++-
> =C2=A0drivers/video/fbdev/core/fbmem.c=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
> =C2=A0include/linux/fb.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A03 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/core/fb_defio.c
> b/drivers/video/fbdev/core/fb_defio.c
> index c730253ab85c..583cbcf09446 100644
> --- a/drivers/video/fbdev/core/fb_defio.c
> +++ b/drivers/video/fbdev/core/fb_defio.c
> @@ -313,7 +313,7 @@ void fb_deferred_io_open(struct fb_info *info,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(fb_deferred_io_open);
> =C2=A0
> -void fb_deferred_io_cleanup(struct fb_info *info)
> +void fb_deferred_io_release(struct fb_info *info)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct fb_deferred_io *fb=
defio =3D info->fbdefio;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct page *page;
> @@ -327,6 +327,14 @@ void fb_deferred_io_cleanup(struct fb_info
> *info)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0page =3D fb_deferred_io_page(info, i);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0page->mapping =3D NULL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +}
> +EXPORT_SYMBOL_GPL(fb_deferred_io_release);
> +
> +void fb_deferred_io_cleanup(struct fb_info *info)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct fb_deferred_io *fbdefio=
 =3D info->fbdefio;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fb_deferred_io_release(info);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kvfree(info->pagerefs);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_destroy(&fbdefio->l=
ock);
> diff --git a/drivers/video/fbdev/core/fbmem.c
> b/drivers/video/fbdev/core/fbmem.c
> index 3a6c8458eb8d..ab3545a00abc 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1454,6 +1454,10 @@ __releases(&info->lock)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct fb_info * const in=
fo =3D file->private_data;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lock_fb_info(info);
> +#if IS_ENABLED(CONFIG_FB_DEFERRED_IO)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (info->fbdefio)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0fb_deferred_io_release(info);
> +#endif
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (info->fbops->fb_relea=
se)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0info->fbops->fb_release(info,1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0module_put(info->fbops->o=
wner);
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 96b96323e9cb..73eb1f85ea8e 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -662,6 +662,7 @@ extern int=C2=A0 fb_deferred_io_init(struct fb_info
> *info);
> =C2=A0extern void fb_deferred_io_open(struct fb_info *info,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct inode *inode,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct file *file);
> +extern void fb_deferred_io_release(struct fb_info *info);
> =C2=A0extern void fb_deferred_io_cleanup(struct fb_info *info);
> =C2=A0extern int fb_deferred_io_fsync(struct file *file, loff_t start,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0loff_t end, int datasync);

Tested-by: Miko Larsson <mikoxyzzz@gmail.com>
--=20
~miko
