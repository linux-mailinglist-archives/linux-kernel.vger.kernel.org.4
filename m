Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77195E9842
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 05:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiIZD1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 23:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiIZD1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 23:27:47 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E70A24F1A
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 20:27:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c30so6091769edn.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 20:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1z+K3iZ5edH9Wvs3sWpMytE5kCGm2zb+7oEAH+Nf3iQ=;
        b=eJhq7Fc27wKeinfDqhvMNOiJ/Gb1/og0KmVp3G+UnwXEDuClmgZJTTtEdniYEEOZTu
         PkHeKnkfj5Nz22Ox5Hm6qKfgc47pn/rMMFS/mdiS+DoqM4BTAKvibBmdiJ5XQLJZrvMQ
         qyrnEu2NdvfYAGMs7Cl67PsiuzyzFdl8K592U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1z+K3iZ5edH9Wvs3sWpMytE5kCGm2zb+7oEAH+Nf3iQ=;
        b=OSuLRPHk3z1yokB1mdGFWLyv4J4Zcj4q7Fh73+tJ3p1GXhYDy6FPI3fXF7gdruvBqW
         y+VRfOhIfNeF4t6HAnqoSZXspvVCwRv/p7gCBE3RGQevbghWLjqAdVuQZzn5nEalOp16
         k0mx1MswFxvt679zqzypriNhoSl7IGzDUiF9JB1qgP8HsZnB4MNQ1gHUEgKIzk30nJ4S
         kIlX16Fdik0BD0iDvWLeeHY+HpF7UWjW8Eh5wFkNMIxFln4OL7KPPnvVLapBqYaawDUk
         JNZANC2ljxX9WUcjneJZsEmhZNLcPYr09GnuHPVnaooxohvGjxXISCtVvJPV7EVMsQ5W
         Rpbw==
X-Gm-Message-State: ACrzQf3EF3mD+a/jNCn4pg4QY1rOtKALNQbo0s7Ha5j5g3gjaH7JkmnA
        VznVA8ygTV9gO36PFkv5lp1jtAIvWuprIfP3f9XtNw==
X-Google-Smtp-Source: AMsMyM5D3keac5HMYAnwObUUepcFX4Nc0uJR6fxSr+8PfMtKkHus/shERelQElMbLNntt0PEAz4+xxwiFElIWC2rDqQ=
X-Received: by 2002:a05:6402:3549:b0:454:414e:a7fd with SMTP id
 f9-20020a056402354900b00454414ea7fdmr21116157edd.69.1664162864997; Sun, 25
 Sep 2022 20:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220915072458.18232-1-angelogioacchino.delregno@collabora.com> <20220915072458.18232-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220915072458.18232-6-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Sep 2022 11:27:33 +0800
Message-ID: <CAGXv+5HxEWPmLLi0zRrJ+T7bVcpoQoFt81+_ciXNDXRrGmfU6w@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 3:25 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The MFG_BG3D is a gate to enable/disable clock output to the GPU,
> but the actual output is decided by multiple muxes; in particular:
> mfg_ck_fast_ref muxes between "slow" (top_mfg_core_tmp) and
> "fast" (MFGPLL) clock, while top_mfg_core_tmp muxes between the
> 26MHz clock and various system PLLs.
>
> This also implies that "top_mfg_core_tmp" is a parent of the
> "mfg_ck_fast_ref" mux (and not vice-versa), so reparent the

I don't see where this was the case though? I think what you meant
was that the direct parent for "mfg_bg3d" is "mfg_ck_fast_ref, not
"top_mfg_core_tmp"?

> MFG_BG3D gate to the latter and add the CLK_SET_RATE_PARENT
> flag to it: this way we ensure propagating rate changes that
> are requested on MFG_BG3D along its entire clock tree.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>


> ---
>  drivers/clk/mediatek/clk-mt8195-mfg.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8195-mfg.c b/drivers/clk/mediatek/clk-mt8195-mfg.c
> index 9411c556a5a9..c94cb71bd9b9 100644
> --- a/drivers/clk/mediatek/clk-mt8195-mfg.c
> +++ b/drivers/clk/mediatek/clk-mt8195-mfg.c
> @@ -17,10 +17,12 @@ static const struct mtk_gate_regs mfg_cg_regs = {
>  };
>
>  #define GATE_MFG(_id, _name, _parent, _shift)                  \
> -       GATE_MTK(_id, _name, _parent, &mfg_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
> +       GATE_MTK_FLAGS(_id, _name, _parent, &mfg_cg_regs,       \
> +                      _shift, &mtk_clk_gate_ops_setclr,        \
> +                      CLK_SET_RATE_PARENT)
>
>  static const struct mtk_gate mfg_clks[] = {
> -       GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "top_mfg_core_tmp", 0),
> +       GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "mfg_ck_fast_ref", 0),
>  };
>
>  static const struct mtk_clk_desc mfg_desc = {
> --
> 2.37.2
>
