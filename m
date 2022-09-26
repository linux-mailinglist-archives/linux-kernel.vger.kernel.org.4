Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CD85E9CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiIZI5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiIZI5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:57:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AA2102E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:57:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y8so8018492edc.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=q89NyQ9b1PpoKXEkGp2ns+Ib3Shkz3cUPYaSufAXKUc=;
        b=n/ZXnZb952U5lWurVM94tkGD6ar7Ax0UfVipCAlGLuHtleFEQEIN8GHQ1RxzVtONhj
         In6/yRm/tdgCGv8hilqP8gcd7Oqi2ZwL3QVpyvlv8kYKqjGjKzLXsy+X0BGAE38HpLbD
         H/LXzx8uHjOrCBpNJnaINnVOmlDy+OhaZAJgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=q89NyQ9b1PpoKXEkGp2ns+Ib3Shkz3cUPYaSufAXKUc=;
        b=lWCK3QvISHPB5ej2ogvRe+aZ/SoWRTJBBQIwC3fAhrpZFbNYxYSrGnOsseRRf7NMaB
         bbZSiz328GjYUNiU6gsGwRhaDHPuUeW2jZwpMORuMVofD05aeVmxKsOwJ7KqbwmGBkVG
         O5kfUvYBZLXz1UsqO91oxzH45CmUqhYZq86oghELukj4lxqXxlPRJgjWKvVczZxochUA
         EeiHx7FPzZvOHFB4qtIQvKCBRGhDxFxsOuPLDjqQVB+dlMfm2/5DiaF33Ol5HmC9SR4n
         cmK4wrUlgDmQbme/9c0rLJNQnzfdEqPw3GiQ4ryeIa9NI+4rqKvr/BBFlxP2Qqhw9N7I
         74+Q==
X-Gm-Message-State: ACrzQf3STMSG30K7/F1hd0oJJ14W7aX3Kdes/3rb9VevuPauNI6Dds9m
        pUmlR3Qi845lEZnIY/NU1N4Fzxm5eaPjUluWVOcYEw==
X-Google-Smtp-Source: AMsMyM7HZwvp/a4tFxiTN7T+gF7HA3kkCdtKrxuJAFXrT6ZiR+YlsGYzpYjFqob4runlnShPtvtGPHUPzlbsMnmQ86Y=
X-Received: by 2002:a05:6402:90e:b0:443:ec4b:2b03 with SMTP id
 g14-20020a056402090e00b00443ec4b2b03mr20918608edz.71.1664182648982; Mon, 26
 Sep 2022 01:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220915072458.18232-1-angelogioacchino.delregno@collabora.com>
 <20220915072458.18232-6-angelogioacchino.delregno@collabora.com>
 <CAGXv+5HxEWPmLLi0zRrJ+T7bVcpoQoFt81+_ciXNDXRrGmfU6w@mail.gmail.com> <9f7d1eda-cdf3-5108-7e9d-a10937fe224e@collabora.com>
In-Reply-To: <9f7d1eda-cdf3-5108-7e9d-a10937fe224e@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Sep 2022 16:57:17 +0800
Message-ID: <CAGXv+5HYKjDJALa6MAAE4XzRTMfE_vdEWg6XaWekUq7w8ko3BQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] clk: mediatek: clk-mt8195-mfg: Reparent mfg_bg3d
 and propagate rate changes
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        miles.chen@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, chun-jie.chen@mediatek.com,
        jose.exposito89@gmail.com, drinkcat@chromium.org,
        weiyi.lu@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 4:36 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 26/09/22 05:27, Chen-Yu Tsai ha scritto:
> > On Thu, Sep 15, 2022 at 3:25 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> The MFG_BG3D is a gate to enable/disable clock output to the GPU,
> >> but the actual output is decided by multiple muxes; in particular:
> >> mfg_ck_fast_ref muxes between "slow" (top_mfg_core_tmp) and
> >> "fast" (MFGPLL) clock, while top_mfg_core_tmp muxes between the
> >> 26MHz clock and various system PLLs.
> >>
> >> This also implies that "top_mfg_core_tmp" is a parent of the
> >> "mfg_ck_fast_ref" mux (and not vice-versa), so reparent the
> >
> > I don't see where this was the case though? I think what you meant
> > was that the direct parent for "mfg_bg3d" is "mfg_ck_fast_ref, not
> > "top_mfg_core_tmp"?
> >
>
> MFG_BG3D's direct parent is mfg_ck_fast_ref - yes - but in the commit message
> I am explaining how the clock tree for MFG_BG3D really is and, in particular,
> I'm then explaining that:
> * parenting MFG_BG3D to "top_mfg_core_tmp" is wrong; because
> * "top_mfg_core_tmp" is a parent of "mfg_ck_fast_ref" (not the other way around).
>
> So, the question in your comment is addressed just a little later....
>
> >> MFG_BG3D gate to the latter and add the CLK_SET_RATE_PARENT
>
> ...here, where I say "reparent MFG_BG3D to the latter", where "the latter" is,
> exactly "mfg_ck_fast_ref".
>
> I hope you now understand what I am trying to communicate :-)
>
> However, if even after that you still think that the commit description should
> be rewritten in some less tangled and/or more understandable way, I definitely
> can do that.
>
> Please confirm :-)

I think

    This also implies that "top_mfg_core_tmp" is a parent of the
    "mfg_ck_fast_ref" mux (and not vice-versa)

actually confused me.

Maybe just say

    The clock gate comes after all the muxes, so its parent is
    mfg_ck_fast_ref, not top_mfg_core_tmp. Reparent mfg_bg3d to
    the latter to match the hardware ...

Since you are fixing the topology, could you also add a fixes tag?


Thanks
ChenYu


> >> flag to it: this way we ensure propagating rate changes that
> >> are requested on MFG_BG3D along its entire clock tree.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >
> > Otherwise,
> >
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> >
> >
> >> ---
> >>   drivers/clk/mediatek/clk-mt8195-mfg.c | 6 ++++--
> >>   1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/clk/mediatek/clk-mt8195-mfg.c b/drivers/clk/mediatek/clk-mt8195-mfg.c
> >> index 9411c556a5a9..c94cb71bd9b9 100644
> >> --- a/drivers/clk/mediatek/clk-mt8195-mfg.c
> >> +++ b/drivers/clk/mediatek/clk-mt8195-mfg.c
> >> @@ -17,10 +17,12 @@ static const struct mtk_gate_regs mfg_cg_regs = {
> >>   };
> >>
> >>   #define GATE_MFG(_id, _name, _parent, _shift)                  \
> >> -       GATE_MTK(_id, _name, _parent, &mfg_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
> >> +       GATE_MTK_FLAGS(_id, _name, _parent, &mfg_cg_regs,       \
> >> +                      _shift, &mtk_clk_gate_ops_setclr,        \
> >> +                      CLK_SET_RATE_PARENT)
> >>
> >>   static const struct mtk_gate mfg_clks[] = {
> >> -       GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "top_mfg_core_tmp", 0),
> >> +       GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "mfg_ck_fast_ref", 0),
> >>   };
> >>
> >>   static const struct mtk_clk_desc mfg_desc = {
> >> --
> >> 2.37.2
> >>
>
>
