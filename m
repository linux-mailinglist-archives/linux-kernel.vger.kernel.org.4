Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06A865D148
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbjADLVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbjADLVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:21:49 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE8EF011
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 03:21:47 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qk9so81591086ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 03:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BZFK1XtqSvSNazd1LQ0CL0w4JuW+TKw76ixJfKxBxw=;
        b=D4y6ujJrhUp5mtLkyIXKK6QsnxSPpgtp2jaKVZm71n7Zp/44nF9+6EzBtZ7cpaLFC6
         XQpOidJwPczJO0icZx5AaSK446dIzFYhP/mySwRcayjyQehY+ZXCNLy1iBFiyX7GSy5K
         GgApjnUCa8yHlAvfLvs1yOnLz3DNU5wNc7Bcdy0+bLzue51jXbws3pRZUsBs1KGzK5m0
         mgFuZwwCl1fth/vIIqEI5koHrA7lHKMaVJGXhs2dBEM9ph6b+gI81CA61XgdM0AHeMui
         IRY//i7ixgzBXRie2XbZ4xJUlQbBrey2mSw+k0nlIbuhJqt2tohyyFZXnXwvm/KPrr4A
         7chA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BZFK1XtqSvSNazd1LQ0CL0w4JuW+TKw76ixJfKxBxw=;
        b=bTmFV6Fa1VmVKYhe8J3DtM7psGz26PLmcnJTgYowiFrCusLrmd5Vy9vsruARkxToTZ
         6/H/3ofBT8Dkl9uMVnRf1NoeaQLlwesIQdIBPFG0MjYxvhltvGObxxw9ngRIbiAGVS6V
         0fDYMNPPTGlGVwe7DJmoececQvoUBnmN/7l5ke/lwouHL+VOtwryXvZI6FfGw4voKZbL
         bpVPwXA8USCLJT1hX6FnK41vrEl3OWcZu458+wYhs/HUxuepLL4/oKK4vsqe77vm8Qmp
         Gq2C+F8B8GqjWprmdPuMaYF1rX0b60y3wTZ7qfDSeQ8xMMgbJVqWOHE1gTbbNnlq+JY1
         RXDA==
X-Gm-Message-State: AFqh2krlXzWJQ4RO2Bz6qFGyWpEaoH8gT2Q5N0CQpfJVP5lj78LJhGRY
        Rmr70yFub0QDGOelnX4YOwkDzg==
X-Google-Smtp-Source: AMrXdXuv+7PIVLUMmBdOXd5HetgMDw0bcTwbjm+KZvLng3jXTBr8JGR8nh0dMCF9lpxl28YuE9o9/A==
X-Received: by 2002:a17:906:eda7:b0:7c4:f402:9769 with SMTP id sa7-20020a170906eda700b007c4f4029769mr52241684ejb.76.1672831305960;
        Wed, 04 Jan 2023 03:21:45 -0800 (PST)
Received: from blmsp ([2001:4091:a245:805c:8713:84e4:2a9e:cbe8])
        by smtp.gmail.com with ESMTPSA id bx4-20020a170906a1c400b007c0e6d6bd10sm15134042ejb.132.2023.01.04.03.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 03:21:45 -0800 (PST)
Date:   Wed, 4 Jan 2023 12:21:44 +0100
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wenst@chromium.org, johnson.wang@mediatek.com,
        miles.chen@mediatek.com, fparent@baylibre.com,
        chun-jie.chen@mediatek.com, sam.shih@mediatek.com,
        y.oudjana@protonmail.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, ryder.lee@kernel.org,
        daniel@makrotopia.org, jose.exposito89@gmail.com,
        yangyingliang@huawei.com, pablo.sun@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 03/23] clk: mediatek: clk-gate: Propagate struct
 device with mtk_clk_register_gates()
Message-ID: <20230104112144.n2mx33xqavigxwa2@blmsp>
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
 <20221223094259.87373-4-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221223094259.87373-4-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Fri, Dec 23, 2022 at 10:42:39AM +0100, AngeloGioacchino Del Regno wrote:
> Commit e4c23e19aa2a ("clk: mediatek: Register clock gate with device")
> introduces a helper function for the sole purpose of propagating a
> struct device pointer to the clk API when registering the mtk-gate
> clocks to take advantage of Runtime PM when/where needed and where
> a power domain is defined in devicetree.
> 
> Function mtk_clk_register_gates() then becomes a wrapper around the
> new mtk_clk_register_gates_with_dev() function that will simply pass
> NULL as struct device: this is essential when registering drivers
> with CLK_OF_DECLARE instead of as a platform device, as there will
> be no struct device to pass... but we can as well simply have only
> one function that always takes such pointer as a param and pass NULL
> when unavoidable.
> 
> This commit removes the mtk_clk_register_gates() wrapper and renames
> mtk_clk_register_gates_with_dev() to the former and all of the calls
> to either of the two functions were fixed in all drivers in order to
> reflect this change.
> 
> Since a lot of MediaTek clock drivers are actually registering as a
> platform device, but were still registering the mtk-gate clocks
> without passing any struct device to the clock framework, they've
> been changed to pass a valid one now, as to make all those platforms
> able to use runtime power management where available.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

A few nitpicks, otherwise it looks good,

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

> ---
>  drivers/clk/mediatek/clk-gate.c              | 16 ++++------------
>  drivers/clk/mediatek/clk-gate.h              |  8 ++------
>  drivers/clk/mediatek/clk-mt2701-aud.c        |  2 +-
>  drivers/clk/mediatek/clk-mt2701-eth.c        |  2 +-
>  drivers/clk/mediatek/clk-mt2701-g3d.c        |  2 +-
>  drivers/clk/mediatek/clk-mt2701-hif.c        |  2 +-
>  drivers/clk/mediatek/clk-mt2701-mm.c         |  2 +-
>  drivers/clk/mediatek/clk-mt2701.c            |  6 +++---
>  drivers/clk/mediatek/clk-mt2712-mm.c         |  2 +-
>  drivers/clk/mediatek/clk-mt2712.c            |  6 +++---
>  drivers/clk/mediatek/clk-mt6765.c            |  6 +++---
>  drivers/clk/mediatek/clk-mt6779-mm.c         |  2 +-
>  drivers/clk/mediatek/clk-mt6779.c            |  4 ++--
>  drivers/clk/mediatek/clk-mt6795-infracfg.c   |  3 ++-
>  drivers/clk/mediatek/clk-mt6795-mm.c         |  3 ++-
>  drivers/clk/mediatek/clk-mt6795-pericfg.c    |  3 ++-
>  drivers/clk/mediatek/clk-mt6797-mm.c         |  2 +-
>  drivers/clk/mediatek/clk-mt6797.c            |  2 +-
>  drivers/clk/mediatek/clk-mt7622-aud.c        |  2 +-
>  drivers/clk/mediatek/clk-mt7622-eth.c        |  4 ++--
>  drivers/clk/mediatek/clk-mt7622-hif.c        |  4 ++--
>  drivers/clk/mediatek/clk-mt7622.c            |  9 +++++----
>  drivers/clk/mediatek/clk-mt7629-eth.c        |  5 +++--
>  drivers/clk/mediatek/clk-mt7629-hif.c        |  4 ++--
>  drivers/clk/mediatek/clk-mt7629.c            |  6 +++---
>  drivers/clk/mediatek/clk-mt7986-eth.c        |  6 +++---
>  drivers/clk/mediatek/clk-mt7986-infracfg.c   |  2 +-
>  drivers/clk/mediatek/clk-mt8135.c            |  4 ++--
>  drivers/clk/mediatek/clk-mt8167-aud.c        |  2 +-
>  drivers/clk/mediatek/clk-mt8167-img.c        |  2 +-
>  drivers/clk/mediatek/clk-mt8167-mfgcfg.c     |  2 +-
>  drivers/clk/mediatek/clk-mt8167-mm.c         |  2 +-
>  drivers/clk/mediatek/clk-mt8167-vdec.c       |  3 ++-
>  drivers/clk/mediatek/clk-mt8167.c            |  2 +-
>  drivers/clk/mediatek/clk-mt8173-mm.c         |  2 +-
>  drivers/clk/mediatek/clk-mt8173.c            | 12 ++++++------
>  drivers/clk/mediatek/clk-mt8183-audio.c      |  2 +-
>  drivers/clk/mediatek/clk-mt8183-mm.c         |  2 +-
>  drivers/clk/mediatek/clk-mt8183.c            |  8 ++++----
>  drivers/clk/mediatek/clk-mt8186-mm.c         |  3 ++-
>  drivers/clk/mediatek/clk-mt8192-aud.c        |  3 ++-
>  drivers/clk/mediatek/clk-mt8192-mm.c         |  3 ++-
>  drivers/clk/mediatek/clk-mt8192.c            | 12 ++++++------
>  drivers/clk/mediatek/clk-mt8195-apmixedsys.c |  3 ++-
>  drivers/clk/mediatek/clk-mt8195-topckgen.c   |  3 ++-
>  drivers/clk/mediatek/clk-mt8195-vdo0.c       |  3 ++-
>  drivers/clk/mediatek/clk-mt8195-vdo1.c       |  3 ++-
>  drivers/clk/mediatek/clk-mt8365-mm.c         |  5 ++---
>  drivers/clk/mediatek/clk-mt8365.c            |  2 +-
>  drivers/clk/mediatek/clk-mt8516-aud.c        |  2 +-
>  drivers/clk/mediatek/clk-mt8516.c            |  2 +-
>  drivers/clk/mediatek/clk-mtk.c               |  4 ++--
>  52 files changed, 103 insertions(+), 103 deletions(-)
> 

[...]

> diff --git a/drivers/clk/mediatek/clk-mt7986-eth.c b/drivers/clk/mediatek/clk-mt7986-eth.c
> index 7868c0728e96..765df117afa6 100644
> --- a/drivers/clk/mediatek/clk-mt7986-eth.c
> +++ b/drivers/clk/mediatek/clk-mt7986-eth.c
> @@ -85,7 +85,7 @@ static void __init mtk_sgmiisys_0_init(struct device_node *node)
>  	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii0_clks));
>  
>  	mtk_clk_register_gates(node, sgmii0_clks, ARRAY_SIZE(sgmii0_clks),
> -			       clk_data);
> +			       clk_data, NULL);
>  
>  	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>  	if (r)
> @@ -103,7 +103,7 @@ static void __init mtk_sgmiisys_1_init(struct device_node *node)
>  	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii1_clks));
>  
>  	mtk_clk_register_gates(node, sgmii1_clks, ARRAY_SIZE(sgmii1_clks),
> -			       clk_data);
> +			       clk_data, NULL);
>  
>  	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>  
> @@ -121,7 +121,7 @@ static void __init mtk_ethsys_init(struct device_node *node)
>  
>  	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(eth_clks));
>  
> -	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks), clk_data);
> +	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks), clk_data, NULL);

You kept within 80c nearly everywhere, but there are a few calls where
you added 'NULL' that go over the 80c now. Not sure if that was
intended?!

>  
>  	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>  

[...]

> diff --git a/drivers/clk/mediatek/clk-mt8183-mm.c b/drivers/clk/mediatek/clk-mt8183-mm.c
> index 11ecc6fb0065..f93043da26c0 100644
> --- a/drivers/clk/mediatek/clk-mt8183-mm.c
> +++ b/drivers/clk/mediatek/clk-mt8183-mm.c
> @@ -91,7 +91,7 @@ static int clk_mt8183_mm_probe(struct platform_device *pdev)
>  	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
>  
>  	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
> -			clk_data);
> +			clk_data, &pdev->dev);

This is not aligned with the opening bracket here and a few below. Maybe
you can fix it with your patch as well.

>  
>  	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>  }
[...]
> diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
> index 991d78a71644..e1b625b86911 100644
> --- a/drivers/clk/mediatek/clk-mt8192.c
> +++ b/drivers/clk/mediatek/clk-mt8192.c
> @@ -1127,7 +1127,7 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
>  	if (r)
>  		goto unregister_top_composites;
>  
> -	r = mtk_clk_register_gates_with_dev(node, top_clks, ARRAY_SIZE(top_clks),
> +	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
>  					    top_clk_data, &pdev->dev);

Here and below, the function call got shorter, please fix the
indentation in the following lines.

Best,
Markus
