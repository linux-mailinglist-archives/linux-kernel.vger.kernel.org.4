Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1B06CF85E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 02:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjC3AtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 20:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjC3AtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 20:49:22 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5925A420F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 17:49:19 -0700 (PDT)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F15483F233
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680137356;
        bh=2bTlOOOOVa4/gjv3TZ+YFUjSIkiCAUcO1Pmm7DLw2W0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=OMbQPawfa3fbkSt/oIWgXF9Vdt+m02uusql4Yu7RsYvyZtC7OI+A1cXD6dsl8RBOo
         k1Z9Ln7MooHUqExefYRyp+Y/LtlAby+MEEYSF9/AXsXOSwcgzkn2mMLyCBDUGy4R/P
         LTVs1RuMG7XPOzN1NXLdbjmZO269jVZ6cHbAT2ePLl7TUFeLJYPXk2uVc4Ol2ycMPq
         sOVP6DPBeAM3GcYDd1IdPPY/1wVUr69oCDsAeaM6HPFaco0MwnQ3pcbNNM4wQCKUw2
         OGqvXMmmlKHOGs2xG+tP/J5NXDTpN7XPR3xtNUc7oFNlQlB3JPrS45Ay2vkkfNns8S
         eP0tCufNky9DA==
Received: by mail-pf1-f197.google.com with SMTP id b8-20020aa78708000000b005eaa50faa35so8182582pfo.20
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 17:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680137354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bTlOOOOVa4/gjv3TZ+YFUjSIkiCAUcO1Pmm7DLw2W0=;
        b=KmFJk6KIjSstz0w8Tg7yFNURGtCWgIa2GYIxGwiI40wRL4P35+JEzAekLNSMPI/39t
         9KHGnfpwR8HwNoFOiQCy5N9nrgMTl1Tc2sScE6hnePKctRCjt3++Ypk6KeiZe4JgooAS
         M57bIaB0gS6HyuIzriRpfrJXOhEGfERjt99pu1yMwsnOrANXdCw5BrQVJNZ5OR/dFKXK
         gGebEpmHpHzpP1EmQtJGKEEwKFCITMJxK+QtoOmk2AK8jkdgKIuL5py9EHoNom8Flc8k
         ObHTp/IrDZ9nsLqjfcO7j8GfqAe8xfxMExx43YBIejN30tHuShEh3Mn7H87kn3lik8XA
         FH7A==
X-Gm-Message-State: AAQBX9e+hL/eS52JqHfrwf9vQq0DbCujqKVfY7Pa+1QtQfNcDNVsoF4C
        8wN/0H6TmeJSPnM9PkutiY/NKdus92oZyNfv5xcsWzRx1+u3Gaocq/VoB5aLmw58LURfA8uXb6V
        bzaxOUOmUwOOoMVo8Eztgh6K4Ez6JICNbbxHtu8ykw4hwSIprVMtiwjFSyg==
X-Received: by 2002:a17:902:ea0c:b0:1a0:527b:9189 with SMTP id s12-20020a170902ea0c00b001a0527b9189mr7876950plg.11.1680137354470;
        Wed, 29 Mar 2023 17:49:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350bveMH01s7+yH455+SdTj3dQe+mfSCF727NIqTHZ2zVZXUcA2FnI/LaSBhxpMsA8Pcm1zN+9zySOov6rVuVADo=
X-Received: by 2002:a17:902:ea0c:b0:1a0:527b:9189 with SMTP id
 s12-20020a170902ea0c00b001a0527b9189mr7876926plg.11.1680137354120; Wed, 29
 Mar 2023 17:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230329095933.1203559-1-kai.heng.feng@canonical.com> <CADnq5_MMg4XD3QK72ZfLYvq02hYrX2aApNT2JUEAvQGvBP+NeQ@mail.gmail.com>
In-Reply-To: <CADnq5_MMg4XD3QK72ZfLYvq02hYrX2aApNT2JUEAvQGvBP+NeQ@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 30 Mar 2023 08:49:02 +0800
Message-ID: <CAAd53p5A4Rxs0FHXzkgP9sXe=5_mWjfkDeROBT2k71PYKVKTwQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Reset GPU on S0ix when device supports BOCO
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, Jingyu Wang <jingyuwang_vip@163.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        amd-gfx@lists.freedesktop.org,
        Jiansong Chen <Jiansong.Chen@amd.com>,
        Kenneth Feng <kenneth.feng@amd.com>,
        Tim Huang <tim.huang@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Evan Quan <evan.quan@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        linux-kernel@vger.kernel.org, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 9:21=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Wed, Mar 29, 2023 at 6:00=E2=80=AFAM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > When the power is lost due to ACPI power resources being turned off, th=
e
> > driver should reset the GPU so it can work anew.
> >
> > First, _PR3 support of the hierarchy needs to be found correctly. Since
> > the GPU on some discrete GFX cards is behind a PCIe switch, checking th=
e
> > _PR3 on downstream port alone is not enough, as the _PR3 can associate
> > to the root port above the PCIe switch.
> >
> > Once the _PR3 is found and BOCO support is correctly marked, use that
> > information to inform the GPU should be reset. This solves an issue tha=
t
> > system freeze on a Intel ADL desktop that uses S0ix for sleep and D3col=
d
> > is supported for the GFX slot.
>
> I don't think we need to reset the GPU.  If the power is turned off, a
> reset shouldn't be necessary. The reset is only necessary when the
> power is not turned off to put the GPU into a known good state.  It
> should be in that state already if the power is turn off.  It sounds
> like the device is not actually getting powered off.

I had the impression that the GPU gets reset because S3 turned the
power rail off.

So the actual intention for GPU reset is because S3 doesn't guarantee
the power is being turned off?

Kai-Heng

>
> Alex
>
> >
> > Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1885
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2458
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c   |  3 +++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  7 ++++++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 12 +++++-------
> >  3 files changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_acpi.c
> > index 60b1857f469e..407456ac0e84 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > @@ -987,6 +987,9 @@ bool amdgpu_acpi_should_gpu_reset(struct amdgpu_dev=
ice *adev)
> >         if (amdgpu_sriov_vf(adev))
> >                 return false;
> >
> > +       if (amdgpu_device_supports_boco(adev_to_drm(adev)))
> > +               return true;
> > +
> >  #if IS_ENABLED(CONFIG_SUSPEND)
> >         return pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE;
> >  #else
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index f5658359ff5c..d56b7a2bafa6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2181,7 +2181,12 @@ static int amdgpu_device_ip_early_init(struct am=
dgpu_device *adev)
> >
> >         if (!(adev->flags & AMD_IS_APU)) {
> >                 parent =3D pci_upstream_bridge(adev->pdev);
> > -               adev->has_pr3 =3D parent ? pci_pr3_present(parent) : fa=
lse;
> > +               do {
> > +                       if (pci_pr3_present(parent)) {
> > +                               adev->has_pr3 =3D true;
> > +                               break;
> > +                       }
> > +               } while ((parent =3D pci_upstream_bridge(parent)));
> >         }
> >
> >         amdgpu_amdkfd_device_probe(adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index ba5def374368..5d81fcac4b0a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -2415,10 +2415,11 @@ static int amdgpu_pmops_suspend(struct device *=
dev)
> >         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> >         struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> >
> > -       if (amdgpu_acpi_is_s0ix_active(adev))
> > -               adev->in_s0ix =3D true;
> > -       else if (amdgpu_acpi_is_s3_active(adev))
> > +       if (amdgpu_acpi_is_s3_active(adev) ||
> > +           amdgpu_device_supports_boco(drm_dev))
> >                 adev->in_s3 =3D true;
> > +       else if (amdgpu_acpi_is_s0ix_active(adev))
> > +               adev->in_s0ix =3D true;
> >         if (!adev->in_s0ix && !adev->in_s3)
> >                 return 0;
> >         return amdgpu_device_suspend(drm_dev, true);
> > @@ -2449,10 +2450,7 @@ static int amdgpu_pmops_resume(struct device *de=
v)
> >                 adev->no_hw_access =3D true;
> >
> >         r =3D amdgpu_device_resume(drm_dev, true);
> > -       if (amdgpu_acpi_is_s0ix_active(adev))
> > -               adev->in_s0ix =3D false;
> > -       else
> > -               adev->in_s3 =3D false;
> > +       adev->in_s0ix =3D adev->in_s3 =3D false;
> >         return r;
> >  }
> >
> > --
> > 2.34.1
> >
