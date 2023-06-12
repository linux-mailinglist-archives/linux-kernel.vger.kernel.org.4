Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D50572B6D3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 06:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjFLEqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 00:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbjFLEpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 00:45:36 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A93810F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 21:45:33 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-558a7faa989so2576380eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 21:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686545133; x=1689137133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8PjX/aOXa3D/DnSIe/K9/s+OsmRXVqzcni+yFefbXo=;
        b=SiM+aG3JrJbkzgBR0VBVug7fBxoWkJMWBYaON6CcIT1cIB2IMsknprPYSLSVZtGt6a
         K/p6m/eBIsDmlzxNPkCe/gneRcrBLANYXoOZW9AUOkwmYSagXnnlNWJz7z2zYr4JcLdk
         E6Gf7ia1Mx76DK7wwOY9f1xRXHya2IQuaZMXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686545133; x=1689137133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8PjX/aOXa3D/DnSIe/K9/s+OsmRXVqzcni+yFefbXo=;
        b=jx0gJ/bTMTm0Y0dejFOVC6kmxhyuDEa2We6I+5gBtVxk/HI97Yv/6ispvP92Rhh64n
         gHbYaD4itBopuKAEahzNPTOIHFNQT2WrePhRs4P3ZvIZaNerKt0QOGEd60Us5X3e9qll
         CAL21V2b52vlxEyYQ8if8wAKSQZMqzwIHlAad9a500SnNyRD2/Q8bFEXnfSxqaQReEkV
         vqU1rP80I/Dz7O3Bu58fr9IZqe4RYFaPj8qHwe3KkmetGHy7jX6FrkwXg6Wm8J7M+FE8
         rBswiYVJPTODvNHME2sgOwgVyUVqOPL/pOB/0FLUR4ROrZgXXwHmCsFbTe3R40Tq0Bch
         n8/w==
X-Gm-Message-State: AC+VfDx0vw1KX9iVU03o5prLpDHam68N2IUrCPUn/LosdIwFbB+SMrXQ
        nhcaCCNhk3eHWrfFUsPLRT2+Uq/2/XfhiJaaIEp5PA==
X-Google-Smtp-Source: ACHHUZ59qM3qtQdWanFUYraxh4tCd+HRdsqwvAeH16+bcYuPxn5Z5kNdapzrWdVRi/Y9P+z48jlOBEOHfRnsOZ/ruBI=
X-Received: by 2002:aca:c41:0:b0:39b:d6f1:36e5 with SMTP id
 i1-20020aca0c41000000b0039bd6f136e5mr3313176oiy.50.1686545132808; Sun, 11 Jun
 2023 21:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230609083009.2822259-1-wenst@chromium.org> <20230609083009.2822259-5-wenst@chromium.org>
 <a7b7476d-3bbd-5503-db3d-5d57356764f8@collabora.com>
In-Reply-To: <a7b7476d-3bbd-5503-db3d-5d57356764f8@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 12 Jun 2023 12:45:21 +0800
Message-ID: <CAGXv+5FskpxjATk5aJA4CG0GyarO55XXYSYkvxWd-40d4ML8RQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] regulator: mt6358: Drop *_SSHUB regulators
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 5:03=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 09/06/23 10:30, Chen-Yu Tsai ha scritto:
> > The *_SSHUB regulators are actually alternate configuration interfaces
> > for their non *_SSHUB counterparts. They are not separate regulator
> > outputs. These registers are intended for the companion processor to
> > use to configure the power rails while the main processor is sleeping.
> > They are not intended for the main operating system to use.
> >
> > Since they are not real outputs they shouldn't be modeled separately.
> > Remove them. Luckily no device tree actually uses them.
> >
>
> I'm not sure that MT6358/6366 are used only on Chromebook SoCs, and that =
this SSHUB
> mechanism (companion processor) is the same across all firmwares.

AFAICT from Internet sources there's also the MT6771 and MT6781, which
are used on some phones.

But what part are you concerned about? The upstream regulator driver does
not actually have any code to switch to/from normal operation and SSHUB
mode.

In a downstream kernel I found that the SSHUB mode is only used if SCP is
doing DVFS [1]. In that same kernel, the regulator driver [2] doesn't even
list the *_SSHUB versions. So if SCP DVFS is used, the regulator driver
has no idea what's going on, and can't interfere either, which I think is
actually a good thing. Only one side should have complete control of one
output.

ChenYu

[1] https://github.com/nokia-dev/android_kernel_nokia_mt6771/blob/android-9=
.0/drivers/misc/mediatek/scp/mt6771/scp_dvfs.c
[2] https://github.com/nokia-dev/android_kernel_nokia_mt6771/blob/android-9=
.0/drivers/misc/mediatek/pmic/mt6358/v1/regulator_codegen.c

> I'd like someone from MediaTek to confirm that this is valid for both Chr=
omebook
> and Smartphone firmwares.
>
> Regards,
> Angelo
>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >   drivers/regulator/mt6358-regulator.c       | 14 --------------
> >   include/linux/regulator/mt6358-regulator.h |  4 ----
> >   2 files changed, 18 deletions(-)
> >
> > diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/m=
t6358-regulator.c
> > index faf6b0757019..946a251a8b3a 100644
> > --- a/drivers/regulator/mt6358-regulator.c
> > +++ b/drivers/regulator/mt6358-regulator.c
> > @@ -505,9 +505,6 @@ static struct mt6358_regulator_info mt6358_regulato=
rs[] =3D {
> >       MT6358_BUCK("buck_vcore", VCORE, 500000, 1293750, 6250,
> >                   buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f,
> >                   MT6358_VCORE_VGPU_ANA_CON0, 1),
> > -     MT6358_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 625=
0,
> > -                 buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_SSHUB_ELR0,=
 0x7f,
> > -                 MT6358_VCORE_VGPU_ANA_CON0, 1),
> >       MT6358_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
> >                   buck_volt_range3, 0x3f, MT6358_BUCK_VPA_DBG0, 0x3f,
> >                   MT6358_VPA_ANA_CON0, 3),
> > @@ -583,10 +580,6 @@ static struct mt6358_regulator_info mt6358_regulat=
ors[] =3D {
> >       MT6358_LDO1("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750, 62=
50,
> >                   buck_volt_range1, MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f0=
0,
> >                   MT6358_LDO_VSRAM_CON2, 0x7f),
> > -     MT6358_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
> > -                 1293750, 6250, buck_volt_range1,
> > -                 MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f,
> > -                 MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f),
> >       MT6358_LDO1("ldo_vsram_gpu", VSRAM_GPU, 500000, 1293750, 6250,
> >                   buck_volt_range1, MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00,
> >                   MT6358_LDO_VSRAM_CON3, 0x7f),
> > @@ -603,9 +596,6 @@ static struct mt6358_regulator_info mt6366_regulato=
rs[] =3D {
> >       MT6366_BUCK("buck_vcore", VCORE, 500000, 1293750, 6250,
> >                   buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f,
> >                   MT6358_VCORE_VGPU_ANA_CON0, 1),
> > -     MT6366_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 625=
0,
> > -                 buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_SSHUB_ELR0,=
 0x7f,
> > -                 MT6358_VCORE_VGPU_ANA_CON0, 1),
> >       MT6366_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
> >                   buck_volt_range3, 0x3f, MT6358_BUCK_VPA_DBG0, 0x3f,
> >                   MT6358_VPA_ANA_CON0, 3),
> > @@ -670,10 +660,6 @@ static struct mt6358_regulator_info mt6366_regulat=
ors[] =3D {
> >       MT6366_LDO1("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750, 62=
50,
> >                   buck_volt_range1, MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f0=
0,
> >                   MT6358_LDO_VSRAM_CON2, 0x7f),
> > -     MT6366_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
> > -                 1293750, 6250, buck_volt_range1,
> > -                 MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f,
> > -                 MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f),
> >       MT6366_LDO1("ldo_vsram_gpu", VSRAM_GPU, 500000, 1293750, 6250,
> >                   buck_volt_range1, MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00,
> >                   MT6358_LDO_VSRAM_CON3, 0x7f),
> > diff --git a/include/linux/regulator/mt6358-regulator.h b/include/linux=
/regulator/mt6358-regulator.h
> > index a4307cd9edd6..c71a6a9fce7a 100644
> > --- a/include/linux/regulator/mt6358-regulator.h
> > +++ b/include/linux/regulator/mt6358-regulator.h
> > @@ -47,8 +47,6 @@ enum {
> >       MT6358_ID_VLDO28,
> >       MT6358_ID_VAUD28,
> >       MT6358_ID_VSIM2,
> > -     MT6358_ID_VCORE_SSHUB,
> > -     MT6358_ID_VSRAM_OTHERS_SSHUB,
> >       MT6358_ID_RG_MAX,
> >   };
> >
> > @@ -88,8 +86,6 @@ enum {
> >       MT6366_ID_VMC,
> >       MT6366_ID_VAUD28,
> >       MT6366_ID_VSIM2,
> > -     MT6366_ID_VCORE_SSHUB,
> > -     MT6366_ID_VSRAM_OTHERS_SSHUB,
> >       MT6366_ID_RG_MAX,
> >   };
> >
>
