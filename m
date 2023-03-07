Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD12F6ADA5E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjCGJaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjCGJ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:29:57 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34BEAD0B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:29:55 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id o6so11726370vsq.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678181395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8goPimXtY9eXF8BKLvHmZ0u83Zt2PKSi+B0JmB3vsfc=;
        b=NE+mKXAo+H3QjK0P0/OVAwrbvbtxvH1cdEHWvMUeuvH+pB7Eb1arYYOdiMdYqdn5fd
         di6B53hmkM4z5HtrPs8vg+iDSWVHYYboYULC/5WjvGz78AK5lGIytP23gFTWVYYQlvpa
         ILRLUXbl4vZs6YeRqZKizelS6VdpNtxzjYVFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678181395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8goPimXtY9eXF8BKLvHmZ0u83Zt2PKSi+B0JmB3vsfc=;
        b=0Kga+6wYMr0VIs6VZSi7Fu1TEB4Xyzl/RephV6u6PkFu7ZYulj8VFzIir2NRzSdo0R
         rBotDUuKWyWuIDSe/ic5JnQDA3x5ZcRUHqr/OydKNs+aB9G43aunv2TBID0RKoSRMc0W
         47pIm5tmuGhI+xSVqZacG61RUFb0Y3P+AlX8PVFC3hK8DvYfYNJz7v9bN2sTVOKpwKku
         PUr4Y/Pa0gDeOFxSpROr35nbd1T74+GAfBFNHTj2+nxnjhW9k/0FCMUDg1JVuA5KQ25j
         CJqHA51VOW6J7ab6V2yg7LyQ0fFMeqDgfBTcG4BXLowZno1Wy8v1lUC6U7TpPPR4BmrI
         IegA==
X-Gm-Message-State: AO0yUKW+Zv97EkMeM2eNIk79N/sZWHlVrtLyjo9vc6YI+gqXQhXsBAR9
        VCWhQoUsCjeXJCYxNK2aVtuYcHfHvbJZcDjAaYsStw==
X-Google-Smtp-Source: AK7set9IkGlmYXilT5agN2FXyJziAMhQFQMkO74+iSB4SZT5UPALL4hZi2qilSE5uy1FMm4UoDTQVSQrzs0rQLH41qk=
X-Received: by 2002:a67:e053:0:b0:415:48dd:e0b9 with SMTP id
 n19-20020a67e053000000b0041548dde0b9mr9546490vsl.3.1678181395014; Tue, 07 Mar
 2023 01:29:55 -0800 (PST)
MIME-Version: 1.0
References: <20230206100105.861720-1-angelogioacchino.delregno@collabora.com>
 <20230206100105.861720-8-angelogioacchino.delregno@collabora.com>
 <CAGXv+5Ey02hzNQA2O2ussAt9sXxxy9mOjze2GH90Ko9HeoETXQ@mail.gmail.com> <a890fd4c-f15e-480a-64e3-c42c73584417@collabora.com>
In-Reply-To: <a890fd4c-f15e-480a-64e3-c42c73584417@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Mar 2023 17:29:44 +0800
Message-ID: <CAGXv+5E_2iKH625PTRwo-qJONc2HqgHY5_+QJcuCmdZuEf7csw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] clk: mediatek: mt8195: Add support for frequency
 hopping through FHCTL
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        miles.chen@mediatek.com, chun-jie.chen@mediatek.com,
        rex-bc.chen@mediatek.com, jose.exposito89@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 5:27=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 07/03/23 05:43, Chen-Yu Tsai ha scritto:
> > On Mon, Feb 6, 2023 at 6:01=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Add FHCTL parameters and register PLLs through FHCTL to add support
> >> for frequency hopping and SSC. FHCTL will be enabled only on PLLs
> >> specified in devicetree.
> >>
> >> This commit brings functional changes only upon addition of
> >> devicetree configuration.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@c=
ollabora.com>
> >> ---
> >>   drivers/clk/mediatek/clk-mt8195-apmixedsys.c | 69 ++++++++++++++++++=
+-
> >>   1 file changed, 66 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/cl=
k/mediatek/clk-mt8195-apmixedsys.c
> >> index 1bc917f2667e..c0db31ce0741 100644
> >> --- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> >> +++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> >> @@ -3,9 +3,11 @@
> >>   // Copyright (c) 2021 MediaTek Inc.
> >>   // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> >>
> >> +#include "clk-fhctl.h"
> >>   #include "clk-gate.h"
> >>   #include "clk-mtk.h"
> >>   #include "clk-pll.h"
> >> +#include "clk-pllfh.h"
> >>
> >>   #include <dt-bindings/clock/mt8195-clk.h>
> >>   #include <linux/of_device.h>
> >> @@ -105,6 +107,61 @@ static const struct mtk_pll_data plls[] =3D {
> >>              0, 0, 22, 0x0158, 24, 0, 0, 0, 0x0158, 0, 0x0158, 0, 9),
> >>   };
> >>
> >> +enum fh_pll_id {
> >> +       FH_ARMPLL_LL,
> >> +       FH_ARMPLL_BL,
> >> +       FH_MEMPLL,
> >> +       FH_ADSPPLL,
> >> +       FH_NNAPLL,
> >> +       FH_CCIPLL,
> >> +       FH_MFGPLL,
> >> +       FH_TVDPLL2,
> >> +       FH_MPLL,
> >> +       FH_MMPLL,
> >> +       FH_MAINPLL,
> >> +       FH_MSDCPLL,
> >> +       FH_IMGPLL,
> >> +       FH_VDECPLL,
> >> +       FH_TVDPLL1,
> >> +       FH_NR_FH,
> >> +};
> >> +
> >> +#define FH(_pllid, _fhid, _offset) {                                 =
  \
> >> +               .data =3D {                                           =
    \
> >> +                       .pll_id =3D _pllid,                           =
    \
> >> +                       .fh_id =3D _fhid,                             =
    \
> >> +                       .fh_ver =3D FHCTL_PLLFH_V2,                   =
    \
> >> +                       .fhx_offset =3D _offset,                      =
    \
> >> +                       .dds_mask =3D GENMASK(21, 0),                 =
    \
> >
> >> +                       .slope0_value =3D 0x6003c97,                  =
    \
> >> +                       .slope1_value =3D 0x6003c97,                  =
    \
> >
> > Are these
> >
> >> +                       .sfstrx_en =3D BIT(2),                        =
    \
> >> +                       .frddsx_en =3D BIT(1),                        =
    \
> >> +                       .fhctlx_en =3D BIT(0),                        =
    \
> >> +                       .tgl_org =3D BIT(31),                         =
    \
> >> +                       .dvfs_tri =3D BIT(31),                        =
    \
> >> +                       .pcwchg =3D BIT(31),                          =
    \
> >
> >> +                       .dt_val =3D 0x0,                              =
    \
> >> +                       .df_val =3D 0x9,                              =
    \
> >
> > and these just copied from MT8186?
>
> Yes, and that's because they're really the same.

Just to be safe, I asked MediaTek to take a look at the parameters.

> >
> >> +                       .updnlmt_shft =3D 16,                         =
    \
> >> +                       .msk_frddsx_dys =3D GENMASK(23, 20),          =
    \
> >> +                       .msk_frddsx_dts =3D GENMASK(19, 16),          =
    \
> >> +               },                                                    =
  \
> >> +       }
> >> +
> >> +static struct mtk_pllfh_data pllfhs[] =3D {
> >> +       FH(CLK_APMIXED_ADSPPLL, FH_ADSPPLL, 0x78),
> >> +       FH(CLK_APMIXED_NNAPLL, FH_NNAPLL, 0x8c),
> >> +       FH(CLK_APMIXED_MFGPLL, FH_MFGPLL, 0xb4),
> >> +       FH(CLK_APMIXED_TVDPLL2, FH_TVDPLL2, 0xc8),
> >> +       FH(CLK_APMIXED_MMPLL, FH_MMPLL, 0xf0),
> >> +       FH(CLK_APMIXED_MAINPLL, FH_MAINPLL, 0x104),
> >> +       FH(CLK_APMIXED_MSDCPLL, FH_MSDCPLL, 0x118),
> >> +       FH(CLK_APMIXED_IMGPLL, FH_IMGPLL, 0x12c),
> >> +       FH(CLK_APMIXED_VDECPLL, FH_VDECPLL, 0x140),
> >> +       FH(CLK_APMIXED_TVDPLL2, FH_TVDPLL1, 0x154),
> >> +};
> >> +
> >>   static const struct of_device_id of_match_clk_mt8195_apmixed[] =3D {
> >>          { .compatible =3D "mediatek,mt8195-apmixedsys", },
> >>          {}
> >> @@ -114,13 +171,17 @@ static int clk_mt8195_apmixed_probe(struct platf=
orm_device *pdev)
> >>   {
> >>          struct clk_hw_onecell_data *clk_data;
> >>          struct device_node *node =3D pdev->dev.of_node;
> >> +       const u8 *fhctl_node =3D "mediatek,mt8195-fhctl";
> >>          int r;
> >>
> >>          clk_data =3D mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
> >>          if (!clk_data)
> >>                  return -ENOMEM;
> >>
> >> -       r =3D mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_=
data);
> >> +       fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
> >> +
> >> +       r =3D mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
> >> +                                   pllfhs, ARRAY_SIZE(pllfhs), clk_da=
ta);
> >>          if (r)
> >>                  goto free_apmixed_data;
> >>
> >> @@ -140,7 +201,8 @@ static int clk_mt8195_apmixed_probe(struct platfor=
m_device *pdev)
> >>   unregister_gates:
> >>          mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clk=
s), clk_data);
> >>   unregister_plls:
> >> -       mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
> >> +       mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
> >> +                                 ARRAY_SIZE(pllfhs), clk_data);
> >
> > Nit: I think this could be squeezed into one line.
> >
> >>   free_apmixed_data:
> >>          mtk_free_clk_data(clk_data);
> >>          return r;
> >> @@ -153,7 +215,8 @@ static int clk_mt8195_apmixed_remove(struct platfo=
rm_device *pdev)
> >>
> >>          of_clk_del_provider(node);
> >>          mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clk=
s), clk_data);
> >> -       mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
> >> +       mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
> >> +                                 ARRAY_SIZE(pllfhs), clk_data);
> >
> > Same here.
> >
>
> That's the same on the others as well, but if I compress those lines I wi=
ll have
> to rebase the clocks cleanup series again and send the 54 patches again..=
 I'd like
> to avoid that noise.
>
> If you really want though, I can do that... what should I do?

I see. Let's keep it the way it is then.
