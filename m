Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCAF72A768
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 03:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjFJBVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 21:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjFJBVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 21:21:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C9435B0;
        Fri,  9 Jun 2023 18:21:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2565865649;
        Sat, 10 Jun 2023 01:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8664AC433EF;
        Sat, 10 Jun 2023 01:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686360064;
        bh=4EzQQBfR3Y6IMMwcv3Ml6mE37bE59PBewIq+eKeDgdw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SVCbP7shTsCtyucgEUhJnBhSnUxvBOjDELgNu69+AsuWIZ3gpRvWR7D7QCyYRY02B
         ceeaBjl2Nog+iYzFvfFd7fpI3hZW23YsU00wLf1hFtNpcqXhpZ78mQEm4mNqHeBQTk
         XYoGUsL+R/E96G+DRJ/xKx04jPEcQxjNAxOZ5zC/0Gv4ZMMHdoXV6iWetZv7MEIOEI
         kpKbdcT+v7CbBqaJW4tm+v4aeUPtj0C0jy+jiOMAaJOxhnQK3fbLyg711CLsne9yiw
         MFKSSLlLM5GLkkTEIgHPbVUXIva8iMpbuWeoTpMX7RO2oaw8WH9/WG9LYAkIYUXk+v
         FO0Bbdi/roSUQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-55ab0f7778cso1597751eaf.1;
        Fri, 09 Jun 2023 18:21:04 -0700 (PDT)
X-Gm-Message-State: AC+VfDxMkhOSZHeLxn4JJ7a5en4p/PxOwV70iEE8S1oUS/XKVFowoNuW
        qAtkO+Dt1btCyvfXprxzTwdh/ynC56GQqwvuR00=
X-Google-Smtp-Source: ACHHUZ6P8QQ65VhsV/Qfo9dv4MOBcLQ5tp1vntMJnnm4lvvGL2lDtm3He7qaum/8UKsyci+znd6MrY++SYH1GIDnYFM=
X-Received: by 2002:a4a:a746:0:b0:55a:f44b:43cd with SMTP id
 h6-20020a4aa746000000b0055af44b43cdmr1980800oom.7.1686360063739; Fri, 09 Jun
 2023 18:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230609164207.430377-1-hamza.mahfooz@amd.com> <20230609201754.GA3961359@dev-arch.thelio-3990X>
In-Reply-To: <20230609201754.GA3961359@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 10 Jun 2023 10:20:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQArK=+Qy+yQU2qB-0pCKyWugsQ=VGXUzLUf+tPow5M_w@mail.gmail.com>
Message-ID: <CAK7LNAQArK=+Qy+yQU2qB-0pCKyWugsQ=VGXUzLUf+tPow5M_w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: enable W=1 for amdgpu
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        James Zhu <James.Zhu@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 5:17=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> + Masahiro and linux-kbuild
>
> On Fri, Jun 09, 2023 at 12:42:06PM -0400, Hamza Mahfooz wrote:
> > We have a clean build with W=3D1 as of
> > commit 12a15dd589ac ("drm/amd/display/amdgpu_dm/amdgpu_dm_helpers: Move
> > SYNAPTICS_DEVICE_ID into CONFIG_DRM_AMD_DC_DCN ifdef"). So, let's enabl=
e
> > these checks unconditionally for the entire module to catch these error=
s
> > during development.
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>
> I think this is fine, especially since it will help catch issues in
> amdgpu quickly and hopefully encourage developers to fix their problems
> before they make it to a tree with wider impact lika -next.
>
> However, this is now the third place that W=3D1 has been effectively
> enabled (i915 and btrfs are the other two I know of) and it would be
> nice if this was a little more unified, especially since it is not
> uncommon for the warnings under W=3D1 to shift around and keeping them
> unified will make maintainence over the longer term a little easier. I
> am not sure if this has been brought up in the past and I don't want to
> hold up this change but I suspect this sentiment of wanting to enable
> W=3D1 on a per-subsystem basis is going to continue to grow.



I believe this patch is the right way because
we will be able to add a new warning option to
scripts/Makefile.extrawarn without fixing any code.

I remember somebody argued that drivers should be
able to do
  subdir-ccflags-y +=3D $(W1_FLAGS)

However, if a new flag, -Wfoo, emits warnings
for drivers/gpu/drm/{i915,amd},
you cannot add it to W=3D1 until fixing the code.

If many drivers start to do likewise,
W=3D1 warning will not be W=3D1 any more.



Another good thing for hard-coding warning options
is you can lift up a warning flag one by one.


Let's say you fixed the entire DRM subsystem so
it is -Wunused free now.

Then, you can move -Wunused to drivers/gpu/drm/Makefile,
while other warning options stay in drivers Makefiles.







>
> Regardless, for clang 11.1.0 to 16.0.5, I see no warnings when building
> drivers/gpu/drm/amd/amdgpu/ with Arch Linux's configuration or
> allmodconfig.
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/Makefile | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/=
amdgpu/Makefile
> > index 86b833085f19..8d16f280b695 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> > +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> > @@ -40,7 +40,18 @@ ccflags-y :=3D -I$(FULL_AMD_PATH)/include/asic_reg \
> >       -I$(FULL_AMD_PATH)/amdkfd
> >
> >  subdir-ccflags-y :=3D -Wextra
> > -subdir-ccflags-y +=3D $(call cc-option, -Wunused-but-set-variable)
> > +subdir-ccflags-y +=3D -Wunused
> > +subdir-ccflags-y +=3D -Wmissing-prototypes
> > +subdir-ccflags-y +=3D -Wmissing-declarations
> > +subdir-ccflags-y +=3D -Wmissing-include-dirs
> > +subdir-ccflags-y +=3D -Wold-style-definition
> > +subdir-ccflags-y +=3D -Wmissing-format-attribute
> > +# Need this to avoid recursive variable evaluation issues
> > +cond-flags :=3D $(call cc-option, -Wunused-but-set-variable) \
> > +     $(call cc-option, -Wunused-const-variable) \
> > +     $(call cc-option, -Wstringop-truncation) \
> > +     $(call cc-option, -Wpacked-not-aligned)
> > +subdir-ccflags-y +=3D $(cond-flags)
> >  subdir-ccflags-y +=3D -Wno-unused-parameter
> >  subdir-ccflags-y +=3D -Wno-type-limits
> >  subdir-ccflags-y +=3D -Wno-sign-compare
> > --
> > 2.40.1
> >



--=20
Best Regards
Masahiro Yamada
