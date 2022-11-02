Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E53161650B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiKBOYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiKBOYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:24:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF242A704
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:24:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A820B822DD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52EAC43147
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667399065;
        bh=uO1Wv+ReevzIk1aXtBRREBtT/tgyabwShw4JBUSnx6k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UNWJ/4jpUzZFIB7tPJV/eqMaxCh+PYp4P7Aq2szKTVXCULfLz10BbAhBDKtn7qon7
         qCNQVVXYd8Rulhr4Qq76/2tUh+peqQ1Xtjhnk/XkaYwbxs2BkZH/jwIpmG++6e1ptc
         M5Rikc5GMKxE97zUoPxQiafVfiTMYdNSJ1T0XEGhXwkloj+ZKycNRFA5j145qIAGJo
         66Q7B7Y+0XQE9nhPCcxajawU42eAMsG2/zleyYIRr3HHJ34gDx5ybrdzuvsWp3Cil1
         h2xtFFZ0lpbUQSocP8NEWBNCU1QPkCl8/NhbylGIUZH6XfcpA7F9jL9whYWHFuTQNV
         83Vz7gBgTpJhw==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-3701a0681daso133041657b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 07:24:25 -0700 (PDT)
X-Gm-Message-State: ACrzQf3yJfxPcE0m2yDAmdTyBPBwRZqh1CwRqyxbUVAAkGOriyfGEYfN
        BfeS2vp/Q3sN3BcqpwYgrZpo8NY7575UDr+MC7g=
X-Google-Smtp-Source: AMsMyM4ABQsof+4Xlk8ax7jbRQ+7bPAZ4K1/9vveI4fArkhRYZ2W2wwyMUVBNLw66TPXUcGd25zoAo2WgbXtEQJIcyo=
X-Received: by 2002:a05:690c:825:b0:36a:b160:21b with SMTP id
 by5-20020a05690c082500b0036ab160021bmr23933191ywb.211.1667399064738; Wed, 02
 Nov 2022 07:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220911211443.581481-1-michal.winiarski@intel.com> <20220911211443.581481-2-michal.winiarski@intel.com>
In-Reply-To: <20220911211443.581481-2-michal.winiarski@intel.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Wed, 2 Nov 2022 16:23:57 +0200
X-Gmail-Original-Message-ID: <CAFCwf11=hKGm93oF1A5PLhdvdo2ujYJWyt4qAqK-KQQqe6ngDA@mail.gmail.com>
Message-ID: <CAFCwf11=hKGm93oF1A5PLhdvdo2ujYJWyt4qAqK-KQQqe6ngDA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] drm: Use XArray instead of IDR for minors
To:     =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Simon Ser <contact@emersion.fr>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 12:17 AM Micha=C5=82 Winiarski
<michal.winiarski@intel.com> wrote:
>
> IDR is deprecated, and since XArray manages its own state with internal
> locking, it simplifies the locking on DRM side.
> Additionally, don't use the IRQ-safe variant, since operating on drm
> minor is not done in IRQ context.
>
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> ---
>  drivers/gpu/drm/drm_drv.c | 51 ++++++++++++++-------------------------
>  1 file changed, 18 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 8214a0b1ab7f..61d24cdcd0f8 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -34,6 +34,7 @@
>  #include <linux/pseudo_fs.h>
>  #include <linux/slab.h>
>  #include <linux/srcu.h>
> +#include <linux/xarray.h>
>
>  #include <drm/drm_cache.h>
>  #include <drm/drm_client.h>
> @@ -53,8 +54,7 @@ MODULE_AUTHOR("Gareth Hughes, Leif Delgass, Jos=C3=A9 F=
onseca, Jon Smirl");
>  MODULE_DESCRIPTION("DRM shared core routines");
>  MODULE_LICENSE("GPL and additional rights");
>
> -static DEFINE_SPINLOCK(drm_minor_lock);
> -static struct idr drm_minors_idr;
> +static DEFINE_XARRAY_ALLOC(drm_minors_xa);
>
>  /*
>   * If the drm core fails to init for whatever reason,
> @@ -98,21 +98,19 @@ static struct drm_minor **drm_minor_get_slot(struct d=
rm_device *dev,
>  static void drm_minor_alloc_release(struct drm_device *dev, void *data)
>  {
>         struct drm_minor *minor =3D data;
> -       unsigned long flags;
>
>         WARN_ON(dev !=3D minor->dev);
>
>         put_device(minor->kdev);
>
> -       spin_lock_irqsave(&drm_minor_lock, flags);
> -       idr_remove(&drm_minors_idr, minor->index);
> -       spin_unlock_irqrestore(&drm_minor_lock, flags);
> +       xa_erase(&drm_minors_xa, minor->index);
>  }
>
> +#define DRM_MINOR_LIMIT(t) ({ typeof(t) _t =3D (t); XA_LIMIT(64 * _t, 64=
 * _t + 63); })
> +
>  static int drm_minor_alloc(struct drm_device *dev, unsigned int type)
>  {
>         struct drm_minor *minor;
> -       unsigned long flags;
>         int r;
>
>         minor =3D drmm_kzalloc(dev, sizeof(*minor), GFP_KERNEL);
> @@ -122,21 +120,10 @@ static int drm_minor_alloc(struct drm_device *dev, =
unsigned int type)
>         minor->type =3D type;
>         minor->dev =3D dev;
>
> -       idr_preload(GFP_KERNEL);
> -       spin_lock_irqsave(&drm_minor_lock, flags);
> -       r =3D idr_alloc(&drm_minors_idr,
> -                     NULL,
> -                     64 * type,
> -                     64 * (type + 1),
> -                     GFP_NOWAIT);
> -       spin_unlock_irqrestore(&drm_minor_lock, flags);
> -       idr_preload_end();
> -
> +       r =3D xa_alloc(&drm_minors_xa, &minor->index, NULL, DRM_MINOR_LIM=
IT(type), GFP_KERNEL);
>         if (r < 0)
>                 return r;
>
> -       minor->index =3D r;
> -
>         r =3D drmm_add_action_or_reset(dev, drm_minor_alloc_release, mino=
r);
>         if (r)
>                 return r;
> @@ -152,7 +139,7 @@ static int drm_minor_alloc(struct drm_device *dev, un=
signed int type)
>  static int drm_minor_register(struct drm_device *dev, unsigned int type)
>  {
>         struct drm_minor *minor;
> -       unsigned long flags;
> +       void *entry;
>         int ret;
>
>         DRM_DEBUG("\n");
> @@ -172,9 +159,12 @@ static int drm_minor_register(struct drm_device *dev=
, unsigned int type)
>                 goto err_debugfs;
>
>         /* replace NULL with @minor so lookups will succeed from now on *=
/
> -       spin_lock_irqsave(&drm_minor_lock, flags);
> -       idr_replace(&drm_minors_idr, minor, minor->index);
> -       spin_unlock_irqrestore(&drm_minor_lock, flags);
> +       entry =3D xa_cmpxchg(&drm_minors_xa, minor->index, NULL, &minor, =
GFP_KERNEL);
I believe we should pass in "minor", without the &, as &minor will
give you the address of the local pointer.

Oded

> +       if (xa_is_err(entry)) {
> +               ret =3D xa_err(entry);
> +               goto err_debugfs;
> +       }
> +       WARN_ON(entry);
>
>         DRM_DEBUG("new minor registered %d\n", minor->index);
>         return 0;
> @@ -187,16 +177,13 @@ static int drm_minor_register(struct drm_device *de=
v, unsigned int type)
>  static void drm_minor_unregister(struct drm_device *dev, unsigned int ty=
pe)
>  {
>         struct drm_minor *minor;
> -       unsigned long flags;
>
>         minor =3D *drm_minor_get_slot(dev, type);
>         if (!minor || !device_is_registered(minor->kdev))
>                 return;
>
>         /* replace @minor with NULL so lookups will fail from now on */
> -       spin_lock_irqsave(&drm_minor_lock, flags);
> -       idr_replace(&drm_minors_idr, NULL, minor->index);
> -       spin_unlock_irqrestore(&drm_minor_lock, flags);
> +       xa_store(&drm_minors_xa, minor->index, NULL, GFP_KERNEL);
>
>         device_del(minor->kdev);
>         dev_set_drvdata(minor->kdev, NULL); /* safety belt */
> @@ -215,13 +202,12 @@ static void drm_minor_unregister(struct drm_device =
*dev, unsigned int type)
>  struct drm_minor *drm_minor_acquire(unsigned int minor_id)
>  {
>         struct drm_minor *minor;
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&drm_minor_lock, flags);
> -       minor =3D idr_find(&drm_minors_idr, minor_id);
> +       xa_lock(&drm_minors_xa);
> +       minor =3D xa_load(&drm_minors_xa, minor_id);
>         if (minor)
>                 drm_dev_get(minor->dev);
> -       spin_unlock_irqrestore(&drm_minor_lock, flags);
> +       xa_unlock(&drm_minors_xa);
>
>         if (!minor) {
>                 return ERR_PTR(-ENODEV);
> @@ -1037,7 +1023,7 @@ static void drm_core_exit(void)
>         unregister_chrdev(DRM_MAJOR, "drm");
>         debugfs_remove(drm_debugfs_root);
>         drm_sysfs_destroy();
> -       idr_destroy(&drm_minors_idr);
> +       WARN_ON(!xa_empty(&drm_minors_xa));
>         drm_connector_ida_destroy();
>  }
>
> @@ -1046,7 +1032,6 @@ static int __init drm_core_init(void)
>         int ret;
>
>         drm_connector_ida_init();
> -       idr_init(&drm_minors_idr);
>         drm_memcpy_init_early();
>
>         ret =3D drm_sysfs_init();
> --
> 2.37.3
>
