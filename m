Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199655F06C8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiI3IpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiI3IpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:45:12 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E426BC44D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:45:10 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id s12so1901096vkn.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=eYOas3VXsXobBgGmtzAVIzPk9FBE1PJp5RKi3UmSRLI=;
        b=GJCpgpENmZ9VS8Ex8TOfXcdTqJ+A5fhCQuiZf0REpGFr5RiUlW30OmBu6CQ3iBAp9c
         XpttbI4sPkB7xXrID7uUnN5Vp9S+ShdFmrMQtl9TDGda1IacLjQowt6IhjlEwcm3MheE
         Gm9wOf8DRMCL0C37Motg9BOgM+M8HIavdO7hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eYOas3VXsXobBgGmtzAVIzPk9FBE1PJp5RKi3UmSRLI=;
        b=GK1z/ImOoVu8B1kDYjDeOVnRdx+dj394qADLMdqGfVRq6njS537EDWXScH4EkfzX5j
         MxPsgAZgh1xcBjQktBrOuDdtLgOyu+ulHylRg5/7QUZad/tXWYlvSM+pI10ZNhfa37Nx
         +ywc81zlwb+3R+EyNXssp49066ICI6xOLbILRibsAY9t2uNpxVt1L3sXe02PHhXvF8vR
         d1icScFz5n5rtSxXFYg9jXitIvXg9HOo8JUlYLMtIPZFDgXhRMe/c4FHUFzv15Hg+/J2
         Voyp7HjfIsNpZ/QM9gew2FRNmdUWqxZcLgvnXKcWTMsSQfar1xB0GynoB04gq7uu/l5G
         HARw==
X-Gm-Message-State: ACrzQf1zN0pj4L4k/1Be05hE4s8O9btUC8NyCHShHM+xB5TxMtaL86IC
        TNrqoO9rWN/tYhWbqtIHcPUDY6kgFW7eR1QBYUt2Gw==
X-Google-Smtp-Source: AMsMyM7ZVcX/HQPq3Iutjv+Qs5JQ+qNe+Y9ufGnOT8bZqW5T2N6SQrZRNWY+iEho68J6+dT6Sh4gm031XYqthxUycbU=
X-Received: by 2002:a1f:9116:0:b0:3a2:362b:fea9 with SMTP id
 t22-20020a1f9116000000b003a2362bfea9mr3616390vkd.11.1664527509413; Fri, 30
 Sep 2022 01:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220927101128.44758-1-angelogioacchino.delregno@collabora.com>
 <20220927101128.44758-9-angelogioacchino.delregno@collabora.com>
 <79490e834466628a1b92e51f65aeb9e9ce82ddce.camel@mediatek.com> <5d8af9a1-3afc-bd69-8f34-164284a452c2@collabora.com>
In-Reply-To: <5d8af9a1-3afc-bd69-8f34-164284a452c2@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 30 Sep 2022 16:44:58 +0800
Message-ID: <CAGXv+5EfsdjqH-gG=wcU4mGxWKmODMw3xJpNsugZJG9hdt1jcw@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] clk: mediatek: clk-mt8195-topckgen: Drop
 univplls from mfg mux parents
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?B?TWFuZHlKSCBMaXUgKOWKieS6uuWDlik=?= 
        <MandyJH.Liu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "jose.exposito89@gmail.com" <jose.exposito89@gmail.com>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        =?UTF-8?B?Q2h1bi1KaWUgQ2hlbiAo6Zmz5rWa5qGAKQ==?= 
        <Chun-Jie.Chen@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        =?UTF-8?B?V2VpeWkgTHUgKOWRguWogeWEgCk=?= <Weiyi.Lu@mediatek.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?UTF-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 4:29 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 30/09/22 07:59, MandyJH Liu (=E5=8A=89=E4=BA=BA=E5=83=96) ha scritto:
> > On Tue, 2022-09-27 at 12:11 +0200, AngeloGioacchino Del Regno wrote:
> >> These PLLs are conflicting with GPU rates that can be generated by
> >> the GPU-dedicated MFGPLL and would require a special clock handler
> >> to be used, for very little and ignorable power consumption benefits.
> >> Also, we're in any case unable to set the rate of these PLLs to
> >> something else that is sensible for this task, so simply drop them:
> >> this will make the GPU to be clocked exclusively from MFGPLL for
> >> "fast" rates, while still achieving the right "safe" rate during
> >> PLL frequency locking.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <
> >> angelogioacchino.delregno@collabora.com>
> >> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> >> ---
> >>   drivers/clk/mediatek/clk-mt8195-topckgen.c | 9 ++++++---
> >>   1 file changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c
> >> b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> >> index 4dde23bece66..8cbab5ca2e58 100644
> >> --- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
> >> +++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> >> @@ -298,11 +298,14 @@ static const char * const ipu_if_parents[] =3D {
> >>      "mmpll_d4"
> >>   };
> >>
> >> +/*
> >> + * MFG can be also parented to "univpll_d6" and "univpll_d7":
> >> + * these have been removed from the parents list to let us
> >> + * achieve GPU DVFS without any special clock handlers.
> >> + */
> >>   static const char * const mfg_parents[] =3D {
> >>      "clk26m",
> >> -    "mainpll_d5_d2",
> >> -    "univpll_d6",
> >> -    "univpll_d7"
> >> +    "mainpll_d5_d2"
> >>   };
> >>
> >>   static const char * const camtg_parents[] =3D {
> > There might be a problem here. Since the univpll_d6 and univpll_d7 are
> > available parents in hardware design and they can be selected other
> > than kernel stage, like bootloader, the clk tree listed in clk_summary
> > cannot show the real parent-child relationship in such case.
>
> I agree about that, but the clock framework will change the parent to
> the "best parent" in that case... this was done to avoid writing complica=
ted
> custom clock ops just for that one.
>
> This issue is present only on MT8195, so it can be safely solved this way=
,
> at least for now.
>
> Should this become a thing on another couple SoCs, it'll then make sense
> to write custom clock ops just for the MFG.

Would CLK_SET_RATE_NO_REPARENT on the fast mux coupled with forcing
the clk tree to a state that we like (mfgpll->fast_mux->gate) work?

ChenYu
