Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E065B68C23A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBFPwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjBFPwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:52:02 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4B3FE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:52:01 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id p185so10108097oif.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 07:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewNknrTIhxgifgegQjNKFLYnHAmBZ6wnASSDjWFLX4U=;
        b=WExQnweh9n72+U/JnYdS5gjHVGXjETHzhTEolJlm7uoslO9V9jvnuRenbbL6Zchn4J
         xKxTHJfZPAxBKx7Rt6XIA/Nit4mLScow4XSgI94ancjT3FAafQPX/jmPAhUy3N6D3jor
         BI4ribYlL3kWJ+jfpf90aEXRdnGvqFAwjsbZCnldg9jmq0ngmDG+ho9cgCChJuzfL9Nb
         RODDYUmGB0tfbftxzoX8lg1/NQ6ESTAgGfNQnrfNV2Vuu4xzNVBGez6ApjsMVwjgLAG4
         tVpd7GpQVZq4A5o8G1Tdz8PInze0BJjQ0ZsxS4qepHQnwemetSKSUGPzsJd+QayqA5L+
         cByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewNknrTIhxgifgegQjNKFLYnHAmBZ6wnASSDjWFLX4U=;
        b=3jg7Bj2yAWwhBiy+ryFMOGKs0lK4SiBzu4Z76u3eUkkqtXOKYFUuQFPXpdFqYCgOZE
         ry5K+qpSRePhFkYoeJn1Yz40f64bKOHWlYkCpW1p3uejvmt7f1xa+pVjnaXotrX8WKHz
         0p7xrMBOeQD1pT/K397eMzezB3teLL96MNZL7mvGAOKk9RD5YcTeENQGbraVrpDzEyWv
         UPYW5MeQeTLne0frp7oHjihkeYPQoU1RGATONhroLrcKzYJxmpaBYZmW5y/jjMW41UIO
         UC8EWC34Ne7j/+iev1NYw9af2UG8HjJi4fDFlLKABRjewU6TPxlOFABvwt0ICg080Joe
         CPfw==
X-Gm-Message-State: AO0yUKVHyotViF5isODa9q/vx08x4YUTKOpYPjPJDOWmgfMCXCIu5W5Q
        KAbxM0ld+toI2P1Y0geYecdnBTf3IMkH2O/1Y4I=
X-Google-Smtp-Source: AK7set8piArdvE8DBSNcLGPv3fS97X3lwrJJHfQAtlcjP2kK5YZw7axK00CJbV+jmtizrdpxL2YvEWLxDKdKvV/aK9Q=
X-Received: by 2002:aca:ea84:0:b0:360:ffcc:3685 with SMTP id
 i126-20020acaea84000000b00360ffcc3685mr7940oih.183.1675698720426; Mon, 06 Feb
 2023 07:52:00 -0800 (PST)
MIME-Version: 1.0
References: <20230203181005.4129175-1-robdclark@gmail.com> <2d5fc6f8-2247-8a8b-1174-eccdc2b08064@amd.com>
In-Reply-To: <2d5fc6f8-2247-8a8b-1174-eccdc2b08064@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 6 Feb 2023 07:52:14 -0800
Message-ID: <CAF6AEGtAqE-h06zgCzjr+R-WWj0ELfyKkD8KHZUYeo6cjS1ceQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix potential race processing vm->freed
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Philip Yang <Philip.Yang@amd.com>, Qiang Yu <qiang.yu@amd.com>,
        Jammy Zhou <Jammy.Zhou@amd.com>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Mon, Feb 6, 2023 at 2:15 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 03.02.23 um 19:10 schrieb Rob Clark:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > If userspace calls the AMDGPU_CS ioctl from multiple threads, because
> > the vm is global to the drm_file, you can end up with multiple threads
> > racing in amdgpu_vm_clear_freed().  So the freed list should be
> > protected with the status_lock, similar to other vm lists.
>
> Well this is nonsense. To process the freed list the VM root PD lock
> must be held anyway.
>
> If we have a call path where this isn't true then we have a major bug at
> a different place here.

I'm not super familiar w/ the amdgpu cs parser stuff, but the only
thing that I'm seeing that protects things is the bo_list_mutex and it
isn't clear to me that this is 1:1 with the vm (it looks like it is
not).

(I cc'd you on the bug report, jfyi)

BR,
-R

>
> Regards,
> Christian.
>
> >
> > Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 33 ++++++++++++++++++++++---=
-
> >   1 file changed, 29 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index b9441ab457ea..aeed7bc1512f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -1240,10 +1240,19 @@ int amdgpu_vm_clear_freed(struct amdgpu_device =
*adev,
> >       struct amdgpu_bo_va_mapping *mapping;
> >       uint64_t init_pte_value =3D 0;
> >       struct dma_fence *f =3D NULL;
> > +     struct list_head freed;
> >       int r;
> >
> > -     while (!list_empty(&vm->freed)) {
> > -             mapping =3D list_first_entry(&vm->freed,
> > +     /*
> > +      * Move the contents of the VM's freed list to a local list
> > +      * that we can iterate without racing against other threads:
> > +      */
> > +     spin_lock(&vm->status_lock);
> > +     list_replace_init(&vm->freed, &freed);
> > +     spin_unlock(&vm->status_lock);
> > +
> > +     while (!list_empty(&freed)) {
> > +             mapping =3D list_first_entry(&freed,
> >                       struct amdgpu_bo_va_mapping, list);
> >               list_del(&mapping->list);
> >
> > @@ -1258,6 +1267,15 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *=
adev,
> >               amdgpu_vm_free_mapping(adev, vm, mapping, f);
> >               if (r) {
> >                       dma_fence_put(f);
> > +
> > +                     /*
> > +                      * Move any unprocessed mappings back to the free=
d
> > +                      * list:
> > +                      */
> > +                     spin_lock(&vm->status_lock);
> > +                     list_splice_tail(&freed, &vm->freed);
> > +                     spin_unlock(&vm->status_lock);
> > +
> >                       return r;
> >               }
> >       }
> > @@ -1583,11 +1601,14 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *ad=
ev,
> >       mapping->bo_va =3D NULL;
> >       trace_amdgpu_vm_bo_unmap(bo_va, mapping);
> >
> > -     if (valid)
> > +     if (valid) {
> > +             spin_lock(&vm->status_lock);
> >               list_add(&mapping->list, &vm->freed);
> > -     else
> > +             spin_unlock(&vm->status_lock);
> > +     } else {
> >               amdgpu_vm_free_mapping(adev, vm, mapping,
> >                                      bo_va->last_pt_update);
> > +     }
> >
> >       return 0;
> >   }
> > @@ -1671,7 +1692,9 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_dev=
ice *adev,
> >                   tmp->last =3D eaddr;
> >
> >               tmp->bo_va =3D NULL;
> > +             spin_lock(&vm->status_lock);
> >               list_add(&tmp->list, &vm->freed);
> > +             spin_unlock(&vm->status_lock);
> >               trace_amdgpu_vm_bo_unmap(NULL, tmp);
> >       }
> >
> > @@ -1788,7 +1811,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
> >               amdgpu_vm_it_remove(mapping, &vm->va);
> >               mapping->bo_va =3D NULL;
> >               trace_amdgpu_vm_bo_unmap(bo_va, mapping);
> > +             spin_lock(&vm->status_lock);
> >               list_add(&mapping->list, &vm->freed);
> > +             spin_unlock(&vm->status_lock);
> >       }
> >       list_for_each_entry_safe(mapping, next, &bo_va->invalids, list) {
> >               list_del(&mapping->list);
>
