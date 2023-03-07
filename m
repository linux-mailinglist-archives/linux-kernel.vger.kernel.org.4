Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5956AEAB4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjCGRgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjCGRgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:36:21 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96652A2F28
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:32:06 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id t22so10165100oiw.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 09:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678210326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMnHUwAy5pc1w+T7Jgak3PUg7pKDe3xFrRkk5NHVfc8=;
        b=XDlVbj6h/y2SEcS7l/u5dJQIcVGtH4KyRQlvX7kiv1aO58TchCgHydju1tkoQ1Gpex
         8ZIkKzpRv5yVLUEpocQgmzn7459YVNRpvrqVTiHGUGg9ZoCfGlUsQTNSa9rQ01V6DS8A
         0w0FXCz/7edUtiVXCZEkGQ8SS9fIEl+bKq2zLp8+L8mosbW56BIgE3TGZv0Lu17fThrN
         NFYwyAQz/m7xwmbLU1CKnaJJNmd1OitVs0QeAxhGGGBa+UZThjaENwO6Tmd1XRMbeKTk
         9tBuPqUYYNyMVrRF4jyNhsY2PApkieEWV0xnId/PszQ1nCpsHtXiyoDikX7tBnkABOIu
         Xxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678210326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMnHUwAy5pc1w+T7Jgak3PUg7pKDe3xFrRkk5NHVfc8=;
        b=Zb8gcDRnkXUZQD3Pd5AiUaGR/LyBVCncUMW4mvpU7caZDfpeEyWMJdJEuO7xLcDn2Q
         L3tGN3Q1STu31w4uizswpTocIYsHST9WEkLxA+wozAkrcUuRPfutg6poWDp1vO4RWTgR
         gM+ExFe6xL/z+DWxinpixqe9XXk99DR5gBElUG86s29vYHCF9UK2XjoCL7NOQJOjWs75
         3RloSR/VUs5pQyBIGtNg3Fzv8v702TlgKvV+X/Z8ynxM71FYXqwiq3U9vpJFQnaoCiKQ
         jfuHmgqUqhMzkK7uwFbpFhCAkeoSads72FCtWjFWbKjImGHa19t3LeqvMJmecbZhfdTs
         20pQ==
X-Gm-Message-State: AO0yUKUEjjhaLHmsPRMCT/GfIhaB6zxUhM8rFbfRIhQ7D3Ei/azOX8Iw
        /5D71ORH/4ed2PayKnM5P8QJuFTSiMuO0lHnS+4=
X-Google-Smtp-Source: AK7set9bdQBOUBXS+VMa4aA1TRGDtDFTVLl+ukUGIPW4rVdPocpbwHT9n/1nZMDm6ePrr5xUNHMdUKhr8M2TtJ5yd2A=
X-Received: by 2002:aca:1206:0:b0:384:e059:c00a with SMTP id
 6-20020aca1206000000b00384e059c00amr410124ois.8.1678210325839; Tue, 07 Mar
 2023 09:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20230112-amduml-v1-1-5e4a0d37de16@pefoley.com> <7212f65a-4d2d-5ecd-235d-95b60f45a0e8@amd.com>
In-Reply-To: <7212f65a-4d2d-5ecd-235d-95b60f45a0e8@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 7 Mar 2023 12:31:54 -0500
Message-ID: <CADnq5_M31w7tND+5v4_iYuKterg79te4mUM_h9agJ3a+x5FNFQ@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: Avoid building on UML
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Peter Foley <pefoley2@pefoley.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks.

Alex

On Mon, Mar 6, 2023 at 11:17 AM Felix Kuehling <felix.kuehling@amd.com> wro=
te:
>
> Looks like this patch got lost over the holidays. Alex, are you OK with
> applying this patch? Or are people looking for a more general solution
> to not build HW drivers for UML? FWIW:
>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
> Am 2023-01-12 um 23:30 schrieb Peter Foley:
> > The amdgpu driver tries to use fields not supported by UML's cpuinfo
> > struct. Disable the driver when targeting UML to avoid tripping up
> > allyesconfig.
> >
> > e.g.
> > ../drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c: In fu=
nction =E2=80=98intel_core_rkl_chk=E2=80=99:
> > ../drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1742:3=
3: error: initialization of =E2=80=98struct cpuinfo_x86 *=E2=80=99 from inc=
ompatible pointer type =E2=80=98struct cpuinfo_um *=E2=80=99 [-Werror=3Dinc=
ompatible-pointer-types
> > ]
> > ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: In function =E2=
=80=98kfd_cpumask_to_apic_id=E2=80=99:
> > ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:2157:48: error: =
=E2=80=98struct cpuinfo_um=E2=80=99 has no member named =E2=80=98apicid=E2=
=80=99
> >
> > Signed-off-by: Peter Foley <pefoley2@pefoley.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/a=
mdgpu/Kconfig
> > index 5fcd510f1abb..aa0008ff8712 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> > +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> > @@ -3,6 +3,7 @@
> >   config DRM_AMDGPU
> >       tristate "AMD GPU"
> >       depends on DRM && PCI && MMU
> > +     depends on !UML
> >       select FW_LOADER
> >       select DRM_DISPLAY_DP_HELPER
> >       select DRM_DISPLAY_HDMI_HELPER
> >
> > ---
> > base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> > change-id: 20230112-amduml-565935d34bfb
> >
> > Best regards,
