Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF20E6E01BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjDLWSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDLWSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:18:39 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC8D49FE;
        Wed, 12 Apr 2023 15:18:38 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id cd20so2439129oib.0;
        Wed, 12 Apr 2023 15:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681337917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nX5ZUWZ+h14V2FRkq8UuCb9+sDAe/a4u14goLUk2eQ=;
        b=cE5xZzmiH+xB6rbLmtl0fzBJVegyhjkLsVveqwxO5qbNd4xIuKTR3hTFoqJeF9WUhm
         JlHLAC27LDrFCRNQay/+gqmrXNnoQ8btdgulvP28AuJaWw/c9JRdp4CiPW7KItWgORuP
         X3GdvgE4UN5p2reyTu+wLa1eNhaMkyUyDlipXEMw/uQeYawfDdj847Rp2y1ncrbAMPRR
         Pqh+A+wEisSSGwOy8FrS/bJ6eDtK6RIBn3Bp7m8s0zUaaWShkI3zI4+DluUfRpkSm9TF
         WpiQwT1ks7DbLSHJFmx23w1eXfdDI5y+vXcfAmosXdK406t32J/z2S1j08SeSoPMpb6s
         OSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681337917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nX5ZUWZ+h14V2FRkq8UuCb9+sDAe/a4u14goLUk2eQ=;
        b=aXpn83ZYGt4urCkqt9rVZS+hvSd/7HAHO1RKIHyhrFSs9pfC2c7M+LGAk0MDGA8I0q
         6smEvkl7DhGaoX9YXA0BiXFaU6c3E6vkMhZzXiIBl765b5qwJnSKnlwIOMn95JrDJ4rw
         CPokvxckvx1T3XsjIksPXzVD/3ybKr3xjIqUkKIfTSDOjeARK+Kzb5n70kccsiuGsSUk
         DM1uWwwjhJsIbTKoHAM7XiA4k/xndCmEC4YF3ICS0DQ5HlOSbxav0MJ5ne2tNhLwSKg1
         TYXu25+rQkhfcrCD6MrxgKgpd+XwoYVZndhB84a3pJ48r1WjzSXk6lIflu34hpURQYG0
         lCkw==
X-Gm-Message-State: AAQBX9eilHgNlxxHjvbh93h+3CdeGf83bdiziQXIOKojvj+OtpLEmfBJ
        s4RV5GAhTYL5DhWNSnk/Dr+IGSmSnPoGMGr87rU=
X-Google-Smtp-Source: AKy350bOhvWIiyhe+J80+lztyliieDNbQlmei33h8VmroEAF5j/kc0QWcldJvL0uwIA2beG8ww2iwFaa8ZM/TtWtX3A=
X-Received: by 2002:aca:917:0:b0:386:a109:57c8 with SMTP id
 23-20020aca0917000000b00386a10957c8mr34183oij.5.1681337917575; Wed, 12 Apr
 2023 15:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230411225725.2032862-1-robdclark@gmail.com> <20230411225725.2032862-6-robdclark@gmail.com>
 <ZDZk+8uWouvMtWle@phenom.ffwll.local>
In-Reply-To: <ZDZk+8uWouvMtWle@phenom.ffwll.local>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 12 Apr 2023 15:18:26 -0700
Message-ID: <CAF6AEGtNANeM4b4Btso8xMreTEMiZSwUfQEJSm=7q+z=C0N9hw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] drm/etnaviv: Switch to fdinfo helper
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        "moderated list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <etnaviv@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 12:59=E2=80=AFAM Daniel Vetter <daniel@ffwll.ch> wr=
ote:
>
> On Tue, Apr 11, 2023 at 03:56:10PM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> You're on an old tree, this got reverted. But I'm kinda wondering whether
> another patch on top shouldn't just includ the drm_show_fdinfo in
> DRM_GEM_FOPS macro ... There's really no good reasons for drivers to not
> have this I think?

oh, I'm roughly on msm-next, so didn't see the revert.. I'll drop this
one.  But with things in flux, this is why I decided against adding it
to DRM_GEM_FOPS.  Ie. we should do that as a followup cleanup step
once everyone is moved over to the new helpers to avoid conflicts or
build breaks when merging things via different driver trees

BR,
-R

> -Daniel
>
> > ---
> >  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/et=
naviv/etnaviv_drv.c
> > index 44ca803237a5..170000d6af94 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > @@ -476,9 +476,8 @@ static const struct drm_ioctl_desc etnaviv_ioctls[]=
 =3D {
> >       ETNA_IOCTL(PM_QUERY_SIG, pm_query_sig, DRM_RENDER_ALLOW),
> >  };
> >
> > -static void etnaviv_fop_show_fdinfo(struct seq_file *m, struct file *f=
)
> > +static void etnaviv_fop_show_fdinfo(struct drm_printer *p, struct drm_=
file *file)
> >  {
> > -     struct drm_file *file =3D f->private_data;
> >       struct drm_device *dev =3D file->minor->dev;
> >       struct etnaviv_drm_private *priv =3D dev->dev_private;
> >       struct etnaviv_file_private *ctx =3D file->driver_priv;
> > @@ -487,8 +486,6 @@ static void etnaviv_fop_show_fdinfo(struct seq_file=
 *m, struct file *f)
> >        * For a description of the text output format used here, see
> >        * Documentation/gpu/drm-usage-stats.rst.
> >        */
> > -     seq_printf(m, "drm-driver:\t%s\n", dev->driver->name);
> > -     seq_printf(m, "drm-client-id:\t%u\n", ctx->id);
> >
> >       for (int i =3D 0; i < ETNA_MAX_PIPES; i++) {
> >               struct etnaviv_gpu *gpu =3D priv->gpu[i];
> > @@ -507,7 +504,7 @@ static void etnaviv_fop_show_fdinfo(struct seq_file=
 *m, struct file *f)
> >                       cur =3D snprintf(engine + cur, sizeof(engine) - c=
ur,
> >                                      "%sNN", cur ? "/" : "");
> >
> > -             seq_printf(m, "drm-engine-%s:\t%llu ns\n", engine,
> > +             drm_printf(p, "drm-engine-%s:\t%llu ns\n", engine,
> >                          ctx->sched_entity[i].elapsed_ns);
> >       }
> >  }
> > @@ -515,7 +512,7 @@ static void etnaviv_fop_show_fdinfo(struct seq_file=
 *m, struct file *f)
> >  static const struct file_operations fops =3D {
> >       .owner =3D THIS_MODULE,
> >       DRM_GEM_FOPS,
> > -     .show_fdinfo =3D etnaviv_fop_show_fdinfo,
> > +     .show_fdinfo =3D drm_fop_show_fdinfo,
> >  };
> >
> >  static const struct drm_driver etnaviv_drm_driver =3D {
> > @@ -529,6 +526,7 @@ static const struct drm_driver etnaviv_drm_driver =
=3D {
> >  #ifdef CONFIG_DEBUG_FS
> >       .debugfs_init       =3D etnaviv_debugfs_init,
> >  #endif
> > +     .show_fdinfo        =3D etnaviv_fop_show_fdinfo,
> >       .ioctls             =3D etnaviv_ioctls,
> >       .num_ioctls         =3D DRM_ETNAVIV_NUM_IOCTLS,
> >       .fops               =3D &fops,
> > --
> > 2.39.2
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
