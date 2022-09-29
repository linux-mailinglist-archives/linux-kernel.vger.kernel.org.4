Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C6B5EF129
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbiI2JCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbiI2JCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:02:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F529138F08
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:02:19 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 40EAA660229F;
        Thu, 29 Sep 2022 10:02:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664442137;
        bh=N0m7GBoyHiib0OgCMmTseGmbEmSpvEwOlrrxgDsGcqw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oa2JJqk3rJEZ5c8IJ8fmkQp64qx1xIha2YVgIZrpoiu4eUhp62/3ettvq7GKxehUg
         3onKr6oRJ/XMv3S8+x38pZPW0EwOlav0y+bhJ14+ziSFPVplqa+lFD8ooJ1u+mHge9
         hsGYpcV5eEExNHrQ12eSL7g2nnUkuBCIhKT7+b3eMPMbMHcqXBQmnOLY28+MNUBo4E
         rjQzZJXD3SIj3IAuMGs3tve9iyuKXEM34DuXwUZGQsriiPtYeNo00Ms8XVVXT971xO
         MPZ7c4tL3myG/HL5RSDvC5n93u/kb4qzSqA/iVNc+hUaV9KvAktq6kpJfysuDSXL/6
         Bn8d4yjnatgcQ==
Message-ID: <09bc1393-dd30-3c96-3309-f822994f4aab@collabora.com>
Date:   Thu, 29 Sep 2022 11:02:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 2/2] phy: mediatek: tphy: add debugfs files
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>
References: <20220929080926.1272-1-chunfeng.yun@mediatek.com>
 <20220929080926.1272-2-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220929080926.1272-2-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/09/22 10:09, Chunfeng Yun ha scritto:
> These debugfs files are mainly used to make eye diagram test easier,
> especially helpful to do HQA test for a new IC without efuse enabled.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: add CONFIG_PHY_MTK_TPHY_DEBUGFS suggested by AngeloGioacchino
> ---
>   drivers/phy/mediatek/Kconfig        |   5 +
>   drivers/phy/mediatek/phy-mtk-tphy.c | 403 +++++++++++++++++++++++++++-
>   2 files changed, 407 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
> index 3125ecb5d119..e9fdfe9f519f 100644
> --- a/drivers/phy/mediatek/Kconfig
> +++ b/drivers/phy/mediatek/Kconfig
> @@ -27,6 +27,11 @@ config PHY_MTK_TPHY
>   	  multi-ports is first version, otherwise is second version,
>   	  so you can easily distinguish them by banks layout.
>   
> +config PHY_MTK_TPHY_DEBUGFS
> +	bool "Add T-PHY Debugfs Files"
> +	help
> +	  Say Y here to add debugfs files mainly for T-PHY HQA test.
> +
>   config PHY_MTK_UFS
>   	tristate "MediaTek UFS M-PHY driver"
>   	depends on ARCH_MEDIATEK || COMPILE_TEST
> diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
> index e906a82791bd..d9509e1314a4 100644
> --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> @@ -7,6 +7,7 @@
>   
>   #include <dt-bindings/phy/phy.h>
>   #include <linux/clk.h>
> +#include <linux/debugfs.h>
>   #include <linux/delay.h>
>   #include <linux/iopoll.h>
>   #include <linux/mfd/syscon.h>
> @@ -264,6 +265,8 @@
>   
>   #define TPHY_CLKS_CNT	2
>   
> +#define USER_BUF_LEN(count) min_t(size_t, 8, (count))
> +
>   enum mtk_phy_version {
>   	MTK_PHY_V1 = 1,
>   	MTK_PHY_V2,
> @@ -310,6 +313,7 @@ struct mtk_phy_instance {
>   	struct clk_bulk_data clks[TPHY_CLKS_CNT];
>   	u32 index;
>   	u32 type;
> +	struct dentry *dbgfs;

Unused when !IS_ENABLED(CONFIG_PHY_MTK_TPHY_DEBUGFS)

>   	struct regmap *type_sw;
>   	u32 type_sw_reg;
>   	u32 type_sw_index;
> @@ -332,10 +336,389 @@ struct mtk_tphy {
>   	const struct mtk_phy_pdata *pdata;
>   	struct mtk_phy_instance **phys;
>   	int nphys;
> +	struct dentry *dbgfs_root;

Same here

>   	int src_ref_clk; /* MHZ, reference clock for slew rate calibrate */
>   	int src_coef; /* coefficient for slew rate calibrate */
>   };
>   
> +#if IS_ENABLED(CONFIG_PHY_MTK_TPHY_DEBUGFS)
> +

..snip..

> +
> +static void tphy_debufs_init(struct mtk_tphy *tphy, struct mtk_phy_instance *inst)

Please fix typo "debufs" -> "debugfs", here and everywhere else.

Apart from that, it looks good to me.

Regards,
Angelo
