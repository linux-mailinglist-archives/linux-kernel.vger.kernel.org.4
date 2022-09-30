Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B5E5F072F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiI3JHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiI3JHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:07:20 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDFC5A2E5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:07:16 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id f18so289421uao.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=2O0rSEtTAy0knRuT/Hcih3kexyznyybv1LdXYTkE3mE=;
        b=hyEIS+p4+YRJmugxMeR5SS04dKOPO+QUcku+NXamU7avCUHZ7OxLvbuBV3OFb3Ju2B
         /mCjnk4K6AVjIZEwiH6hdGQywHYZZ35d1YQfvVFND7Mi4xV+haeKavxAvGei8eR9K9Eu
         O5h+9hrQ+BIh6nQXW/wQytzfWqe9CX7ghbk+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2O0rSEtTAy0knRuT/Hcih3kexyznyybv1LdXYTkE3mE=;
        b=fDu3dyCSXNj97JLu9Fl+MJXMfFpZsacgrE7q343saVpPJ0C5VIht6fHnEiBoBS58ON
         cmc2i6bnOuIWSBKVLMktBFW//JwRfCaieTTZ1uSZUgCtTujGrIoj6DGM7PEkHVtywYT3
         PwWkaBALt8JxPj1v/tJnbD2MVDe27xYAUFD3BK/O1ZGB54nGo3BIPh9qQ6pPrF9bMMqM
         z5VMn6miJBxtMeaLGzSQsCOWtL/dmg5Z3P2TuwpafP2ixoCupNbtQp2gcaiJ241Igflw
         Nz54b0lzZNX3CwfdS9u9+EkJTLh5VCHqmj0BUDq7vZel+2zw/3AY8abJtiSdX2dsq5ik
         QwEQ==
X-Gm-Message-State: ACrzQf3HMhkYPdr1fp483Qn/frJm/XDwi5YtbNgNeGvyPwZoVcKB4Qjt
        yom8Vy13fxMp9PILhGpqgIP3lIxoP9jkjQ8Jw/Bvhg==
X-Google-Smtp-Source: AMsMyM6bUR/yrPC1DoEEAN0PD5lPpCxtfQBFAz5X4vz8GHRKU17hGyPhEVwY8GqjKFkK519m5v0OZBPLBud5mUCNeqc=
X-Received: by 2002:ab0:14ef:0:b0:39e:df1d:8eff with SMTP id
 f44-20020ab014ef000000b0039edf1d8effmr4156651uae.97.1664528835340; Fri, 30
 Sep 2022 02:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220927101128.44758-1-angelogioacchino.delregno@collabora.com>
 <20220927101128.44758-9-angelogioacchino.delregno@collabora.com>
 <79490e834466628a1b92e51f65aeb9e9ce82ddce.camel@mediatek.com>
 <5d8af9a1-3afc-bd69-8f34-164284a452c2@collabora.com> <CAGXv+5EfsdjqH-gG=wcU4mGxWKmODMw3xJpNsugZJG9hdt1jcw@mail.gmail.com>
 <5d62200e-e058-29ea-063f-91dd1fd92cf7@collabora.com> <CAGXv+5F-P0D5G2ydxUbwDPaW-GgDSYOUGv5+3yx8JbHL_px=EA@mail.gmail.com>
 <b31518f0-c8ba-11b0-ff36-b5789b92878e@collabora.com>
In-Reply-To: <b31518f0-c8ba-11b0-ff36-b5789b92878e@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 30 Sep 2022 17:07:03 +0800
Message-ID: <CAGXv+5Fq7vqH+0AH9_U_Do3i8D9No8iZ1VJhyQTKtcgKuBBKzQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 5:04 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 30/09/22 11:02, Chen-Yu Tsai ha scritto:
> > On Fri, Sep 30, 2022 at 4:58 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 30/09/22 10:44, Chen-Yu Tsai ha scritto:
> >>> On Fri, Sep 30, 2022 at 4:29 PM AngeloGioacchino Del Regno
> >>> <angelogioacchino.delregno@collabora.com> wrote:
> >>>>
> >>>> Il 30/09/22 07:59, MandyJH Liu (=E5=8A=89=E4=BA=BA=E5=83=96) ha scri=
tto:
> >>>>> On Tue, 2022-09-27 at 12:11 +0200, AngeloGioacchino Del Regno wrote=
:
> >>>>>> These PLLs are conflicting with GPU rates that can be generated by
> >>>>>> the GPU-dedicated MFGPLL and would require a special clock handler
> >>>>>> to be used, for very little and ignorable power consumption benefi=
ts.
> >>>>>> Also, we're in any case unable to set the rate of these PLLs to
> >>>>>> something else that is sensible for this task, so simply drop them=
:
> >>>>>> this will make the GPU to be clocked exclusively from MFGPLL for
> >>>>>> "fast" rates, while still achieving the right "safe" rate during
> >>>>>> PLL frequency locking.
> >>>>>>
> >>>>>> Signed-off-by: AngeloGioacchino Del Regno <
> >>>>>> angelogioacchino.delregno@collabora.com>
> >>>>>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> >>>>>> ---
> >>>>>>     drivers/clk/mediatek/clk-mt8195-topckgen.c | 9 ++++++---
> >>>>>>     1 file changed, 6 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c
> >>>>>> b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> >>>>>> index 4dde23bece66..8cbab5ca2e58 100644
> >>>>>> --- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
> >>>>>> +++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> >>>>>> @@ -298,11 +298,14 @@ static const char * const ipu_if_parents[] =
=3D {
> >>>>>>        "mmpll_d4"
> >>>>>>     };
> >>>>>>
> >>>>>> +/*
> >>>>>> + * MFG can be also parented to "univpll_d6" and "univpll_d7":
> >>>>>> + * these have been removed from the parents list to let us
> >>>>>> + * achieve GPU DVFS without any special clock handlers.
> >>>>>> + */
> >>>>>>     static const char * const mfg_parents[] =3D {
> >>>>>>        "clk26m",
> >>>>>> -    "mainpll_d5_d2",
> >>>>>> -    "univpll_d6",
> >>>>>> -    "univpll_d7"
> >>>>>> +    "mainpll_d5_d2"
> >>>>>>     };
> >>>>>>
> >>>>>>     static const char * const camtg_parents[] =3D {
> >>>>> There might be a problem here. Since the univpll_d6 and univpll_d7 =
are
> >>>>> available parents in hardware design and they can be selected other
> >>>>> than kernel stage, like bootloader, the clk tree listed in clk_summ=
ary
> >>>>> cannot show the real parent-child relationship in such case.
> >>>>
> >>>> I agree about that, but the clock framework will change the parent t=
o
> >>>> the "best parent" in that case... this was done to avoid writing com=
plicated
> >>>> custom clock ops just for that one.
> >>>>
> >>>> This issue is present only on MT8195, so it can be safely solved thi=
s way,
> >>>> at least for now.
> >>>>
> >>>> Should this become a thing on another couple SoCs, it'll then make s=
ense
> >>>> to write custom clock ops just for the MFG.
> >>>
> >>> Would CLK_SET_RATE_NO_REPARENT on the fast mux coupled with forcing
> >>> the clk tree to a state that we like (mfgpll->fast_mux->gate) work?
> >>
> >> I'm not sure that it would, and then this would mean that we'd have to=
 add
> >> assigned-clock-parents to the devicetree and the day we will introduce=
 the
> >> "complicated custom clock ops" for that, we'll most probably have to c=
hange
> >> the devicetree as well... which is something that I'm a bit reluctant =
to do
> >> as a kernel upgrade doesn't automatically mean that you upgrade the DT=
 with
> >> it to get the "new full functionality".
> >
> > You can also do it by doing clk_set_parent() in the clock driver after =
the
> > clocks are registered, or just write to the register before the clock i=
s
> > registered.
> >
>
> I honestly don't like doing that - but I can try if that works and, if it=
 does,
> I can send a commit with a Fixes tag later, perhaps?

Sounds good to me.

FWIW, I think it's OK for drivers to reinitialize hardware to a known
state that it can work with. As long as it doesn't break the system
while doing so.

ChenYu

>
> > We do the latter in some of the sunxi-ng drivers, though IIRC it was to
> > force a certain divider on what we expose as a fixed divider clock.
> >
> > ChenYu
> >
> >> Introducing the new clock ops for the mfg mux is something that will h=
appen
> >> for sure, but if we don't get new SoCs with a similar "issue", I don't=
 feel
> >> confident to write them, as I fear these won't be as flexible as neede=
d and
> >> will eventually need a rewrite; that's why I want to wait to get the s=
ame
> >> situation on "something new".
> >>
> >> In my opinion, it is safe to keep this change as it is, even though I =
do
> >> understand the shown concerns about the eventual unability to show the=
 tree
> >> relationship in case the bootloader chooses to initialize the mfg mux =
with
> >> a univpll parent.
> >>
> >> Regards,
> >> Angelo
> >>
>
>
>
