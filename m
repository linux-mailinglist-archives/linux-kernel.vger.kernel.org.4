Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311D168E9B0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBHISJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjBHISH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:18:07 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D202193E6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:18:01 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id k4so19039272vsc.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 00:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+tHCOo8sJZFp5flt13By50o4tNKKdblBZ0IURhBoSow=;
        b=DWoNKb7tfi9icZU4oIKLPqnab+Sj0mZeDxOTR23zSyVv7NUeoHIV9jah/FfcehBZT3
         IvIRbnr6y0oAMomfg/Vi3ZeAh9tQS087u25cYyphjBfXSXgI1shgp9tVmT72JbqiP0dp
         l87j3oZbJaWOEfU9eE25Kttipo2uV6TJwUUHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tHCOo8sJZFp5flt13By50o4tNKKdblBZ0IURhBoSow=;
        b=7u4yeZX+h0iD/Z7O1+oYEevm2t5LkVtqi/WCOTFrGxuc4RMBNeYWd84otaVNIUiIIL
         +pi/8vkxnPsE0J3bPbyhVMGw9S9jUEu3J5SLaximESuGQVBNqeQmLYnSDQunLJQxn0HL
         jO5Za57tK/GGpFgIidhJrTQkiS4WgGjpsDeBVhYieLl6dCQpXsP6tOappREp12Z/GnNe
         ylTL1rhlT5HNNOAPRPOc4WeOoYycJAcr0tx6vcw6gt0RvAQiMym6igFS2bPTms55ChWS
         Jaf7U6xy4zxECOZOCfQCZG4iaCy7wahw8XMO7EMeHfYaazAFWGV4vSagzERCf9BEFbm/
         0WKw==
X-Gm-Message-State: AO0yUKWBgdA+ieglPh0Fc237Qj/uN8z+jab/v5JWhQ0BmjRRNItPJqUr
        +1R8aARaMnLZvrv96J98PpdlvnSIfQS2TaYRr7Lmfg==
X-Google-Smtp-Source: AK7set/N9Zr6zqMMbyyTI+mcr75A04f7/sCiIHNtPyBlQMz3Kxdbrzdom/HO0bm0zxky0AHBLxotaH+PXfBWROHsdto=
X-Received: by 2002:a67:1904:0:b0:3e8:d5a8:3fbe with SMTP id
 4-20020a671904000000b003e8d5a83fbemr1650981vsz.9.1675844280469; Wed, 08 Feb
 2023 00:18:00 -0800 (PST)
MIME-Version: 1.0
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
 <20230206152928.918562-20-angelogioacchino.delregno@collabora.com>
 <CAGXv+5G0ksgGMXUGk-=CXUANtGQa2M5RLY+wG7c-0cMSKS5DJQ@mail.gmail.com> <7adadf24-c14f-6eb4-edfd-265dca93e907@collabora.com>
In-Reply-To: <7adadf24-c14f-6eb4-edfd-265dca93e907@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 8 Feb 2023 16:17:49 +0800
Message-ID: <CAGXv+5Ftq6RfAHkF3KxZNPx17MMFBtpDWqg=DLVDWo1pJwVijg@mail.gmail.com>
Subject: Re: [PATCH v1 19/45] clk: mediatek: mt8183: Convert all remaining
 clocks to common probe
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 8:14 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
> Il 07/02/23 10:58, Chen-Yu Tsai ha scritto:
> > On Mon, Feb 6, 2023 at 11:30 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Switch to mtk_clk_simple_{probe,remove}() for infracfg and topckgen
> >> clocks on MT8183 to allow full module build for clock drivers.
> >> In order to do this, like done for other MediaTek clock drivers, it
> >> was necessary to join top_early_divs with top_divs and to stop
> >> registering the `clk13m` clock early.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >> ---
> >>   drivers/clk/mediatek/clk-mt8183.c | 160 ++++++------------------------
> >>   1 file changed, 28 insertions(+), 132 deletions(-)
> >>
> >> diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
> >> index 0fad2cf7f41b..035fdd02f0be 100644
> >> --- a/drivers/clk/mediatek/clk-mt8183.c
> >> +++ b/drivers/clk/mediatek/clk-mt8183.c
> >> @@ -25,11 +25,8 @@ static const struct mtk_fixed_clk top_fixed_clks[] = {
> >>          FIXED_CLK(CLK_TOP_UNIVP_192M, "univpll_192m", "univpll", 192000000),
> >>   };
> >>
> >> -static const struct mtk_fixed_factor top_early_divs[] = {
> >> -       FACTOR(CLK_TOP_CLK13M, "clk13m", "clk26m", 1, 2),
> >> -};
> >> -
> >>   static const struct mtk_fixed_factor top_divs[] = {
> >> +       FACTOR(CLK_TOP_CLK13M, "clk13m", "clk26m", 1, 2),
> >
> > A clock with the same name is now present in the DT, and so this clock
> > would fail to register. We should drop this one completely and point
> > any references to it internally to "csw_f26m_ck_d2".
> >
> >>          FACTOR(CLK_TOP_F26M_CK_D2, "csw_f26m_ck_d2", "clk26m", 1, 2),
> >
> > MT8192 and MT8195 aren't affected because they only have "csw_f26m_ck_d2",
> > which systimer was referencing.
> >
> >>          FACTOR_FLAGS(CLK_TOP_SYSPLL_CK, "syspll_ck", "mainpll", 1, 1, 0),
> >>          FACTOR_FLAGS(CLK_TOP_SYSPLL_D2, "syspll_d2", "syspll_ck", 1, 2, 0),
> >> @@ -809,26 +806,6 @@ static const struct mtk_clk_rst_desc clk_rst_desc = {
> >>          .rst_bank_nr = ARRAY_SIZE(infra_rst_ofs),
> >>   };
> >>
> >> -static struct clk_hw_onecell_data *top_clk_data;
> >> -
> >> -static void clk_mt8183_top_init_early(struct device_node *node)
> >> -{
> >> -       int i;
> >> -
> >> -       top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
> >> -
> >> -       for (i = 0; i < CLK_TOP_NR_CLK; i++)
> >> -               top_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
> >> -
> >> -       mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs),
> >> -                       top_clk_data);
> >
> > And since we used to not do error checking, the name conflict was OK.
> > With the new common probe, it's not.
> >
>
> That makes me proud of my changes to extend the new common probe mechanism,
> as this is one of (hopefully not) many wrongs that slipped through without
> any apparent issue.
> Anyway, there was no reference to this clk13m (nor CLK_TOP_CLK13M) anywhere
> so I changed this commit to just "forget about this clock" (advertising the
> reason in the commit description, of course).

I think I should send this as a separate patch as a follow-up to the systimer
changes. And we should keep the CLK_TOP_CLK13M entry valid, since that's
the entry referenced in old DTs, but change its name to "csw_f26m_ck_d2".

In short we are actually merging CLK_TOP_CLK13M and CLK_TOP_F26M_CK_D2,
with the former surviving but with a name change. CLK_TOP_F26M_CK_D2
is only referenced internally in TOPCKGEN.

> Is MT8183's cpufreq working after this change, or is it still not behaving?

Yes it's back.

ChenYu
