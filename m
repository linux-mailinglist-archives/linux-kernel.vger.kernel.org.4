Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF946974DF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 04:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjBODYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 22:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBODYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 22:24:15 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BD96192
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 19:24:11 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230215032407epoutp041928c330ad159fc638a8f7f1e737c684~D4YTgJqcW1897518975epoutp04X
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:24:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230215032407epoutp041928c330ad159fc638a8f7f1e737c684~D4YTgJqcW1897518975epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676431447;
        bh=CeJJHr1g6TM0kd+qg2F6GEyKVlKxUpGWmpbMLofy6qE=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=mW6XZWIX8t+UuyYjsUuJxVes9to4uNhUoB5KCk4naY/tJJ/vFodkhXa0Ht2FchrgU
         7Z2H1kg6nTxtEQPu7TmFL+/W625LzHqEXJAuEMg24mJpbcAYuFTExF+pZpM9e+BSa0
         hw+wQ31iB4JSkL8H+HdcIDxnGQdqr41vfcGpmOvk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230215032406epcas2p322c2fe6d3498b6031458606aca1900f9~D4YS8b1FA1167411674epcas2p3l;
        Wed, 15 Feb 2023 03:24:06 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.101]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PGk2F6hdSz4x9Q2; Wed, 15 Feb
        2023 03:24:05 +0000 (GMT)
X-AuditID: b6c32a48-45bfc70000021624-79-63ec50555a07
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.5A.05668.5505CE36; Wed, 15 Feb 2023 12:24:05 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 4/6] clk: samsung: exynos850: Implement CMU_G3D domain
Reply-To: chanho61.park@samsung.com
Sender: CHANHO PARK <chanho61.park@samsung.com>
From:   CHANHO PARK <chanho61.park@samsung.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     David Virag <virag.david003@gmail.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230211064006.14981-5-semen.protsenko@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230215032405epcms2p433e63daf766faff2635641cc856ab515@epcms2p4>
Date:   Wed, 15 Feb 2023 12:24:05 +0900
X-CMS-MailID: 20230215032405epcms2p433e63daf766faff2635641cc856ab515
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmmW5owJtkgxfLTCwezNvGZnH9y3NW
        i/lHzrFa7H29ld1i0+NrrBYfe+6xWlzeNYfNYsb5fUwWF0+5WrTuPcJucfhNO6vFv2sbWSye
        9wHFT939zG6xatcfRovj7x8zOgh4vL/Ryu6xc9Zddo9NqzrZPO5c28PmsXlJvUffllWMHp83
        yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDd
        rqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIF
        KkzIzvh3bBdTwcKQiqaGfWwNjM/cuhg5OSQETCT2rN7BBGILCexglOifqNnFyMHBKyAo8XeH
        MEhYWMBL4urjeywgYSEBZYmN22IhwvoS3/ubWEBsNgFdifkfPrF2MXJxiAjcZ5TY/fQrI4jD
        LHCcRWLWzeOMELt4JWa0P2WBsKUlti/fChbnFHCQmNb0gRkiriHxY1kvlC0qcXP1W3YY+/2x
        +VBzRCRa752FqhGUePBzNyPIcRICkhKT3kRAhAMkmu6DHARi50hsODiJDcI2l/j+dD5YK6+A
        r8Td7u9gcRYBVYnp92dBrXKRmDltJdiZzALyEtvfzmEGGc8soCmxfpc+xCZliSO3oCr4JDoO
        /2WHeXDHvCdMELa6xIHt06GelZXonvMZ6hoPiX/7dzBNYFSchQjnWUh2zULYtYCReRWjWGpB
        cW56arFRgQk8ZpPzczcxgtOwlscOxtlvP+gdYmTiYDzEKMHBrCTCK/z0RbIQb0piZVVqUX58
        UWlOavEhRlOgLycyS4km5wMzQV5JvKGJpYGJmZmhuZGpgbmSOK+07clkIYH0xJLU7NTUgtQi
        mD4mDk6pBiathiuyd4N7DfJ92HKyA9Q2zVkXM8PLbumE5xP4L80MPP50z6QOwX2b6h92WXo7
        NUfOnfjykJLcUelZGjPqDrj+Or5dpYdDzyEqq8QhZ/sH/dsC1m8FtY7u4/XpbrzfGPfTTSp/
        VUPB87B1c5MNNQq3NW47Ol/53aniw1wrPhRdy+yP/yNt9+mVxdN1Cd3bGYOvnp/VycA/e+9R
        RTWLB5qy+y/2Fl/28/jAp7a9fdu8uOXf2Toz1J8u3n/701v/WZbcySK5O25s6ZnKkWG2WHv5
        Yq5pjifk+Hn+nWE7KKHxysP6MMtanoY7oYIfVluvX8pS9yx0VmZJ8+XgPLE1Uxf+nm5bvbhs
        Y26F26TC3yeUWIozEg21mIuKEwEXvQVhTAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230211063957epcas2p2302d93ee2aeb2c5e680b771aa8bbc785
References: <20230211064006.14981-5-semen.protsenko@linaro.org>
        <20230211064006.14981-1-semen.protsenko@linaro.org>
        <CGME20230211063957epcas2p2302d93ee2aeb2c5e680b771aa8bbc785@epcms2p4>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Sam Protsenko <semen.protsenko@linaro.org>
> Sent: Saturday, February 11, 2023 3:40 PM
> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Chanwoo Choi
> <cw00.choi@samsung.com>; Sylwester Nawrocki <s.nawrocki@samsung.com>; Rob
> Herring <robh+dt@kernel.org>
> Cc: David Virag <virag.david003@gmail.com>; Chanho Park
> <chanho61.park@samsung.com>; Alim Akhtar <alim.akhtar@samsung.com>; Sumit
> Semwal <sumit.semwal@linaro.org>; Tomasz Figa <tomasz.figa@gmail.com>;
> Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>; linux-samsung-soc@vger.kernel.org; linux-
> clk@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 4/6] clk: samsung: exynos850: Implement CMU_G3D domain
> 
> CMU_G3D clock domain provides clocks for Mali-G52 GPU and bus clocks for
> BLK_G3D.
> 
> This patch adds next clocks:
>   - bus clocks in CMU_TOP for CMU_G3D
>   - all internal CMU_G3D clocks
>   - leaf clocks for GPU, TZPC (TrustZone Protection Controller) and
>     SysReg
> 
> G3D_CMU_G3D clock was marked as CLK_IGNORE_UNUSED, as system hangs on boot
> otherwise.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/clk/samsung/clk-exynos850.c | 121 ++++++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
> 
> diff --git a/drivers/clk/samsung/clk-exynos850.c
> b/drivers/clk/samsung/clk-exynos850.c
> index 541761e96aeb..a24eff42baae 100644
> --- a/drivers/clk/samsung/clk-exynos850.c
> +++ b/drivers/clk/samsung/clk-exynos850.c
> @@ -36,6 +36,7 @@
>  #define CLK_CON_MUX_MUX_CLKCMU_CORE_MMC_EMBD	0x101c
>  #define CLK_CON_MUX_MUX_CLKCMU_CORE_SSS		0x1020
>  #define CLK_CON_MUX_MUX_CLKCMU_DPU		0x1034
> +#define CLK_CON_MUX_MUX_CLKCMU_G3D_SWITCH	0x1038
>  #define CLK_CON_MUX_MUX_CLKCMU_HSI_BUS		0x103c
>  #define CLK_CON_MUX_MUX_CLKCMU_HSI_MMC_CARD	0x1040
>  #define CLK_CON_MUX_MUX_CLKCMU_HSI_USB20DRD	0x1044
> @@ -57,6 +58,7 @@
>  #define CLK_CON_DIV_CLKCMU_CORE_MMC_EMBD	0x1828
>  #define CLK_CON_DIV_CLKCMU_CORE_SSS		0x182c
>  #define CLK_CON_DIV_CLKCMU_DPU			0x1840
> +#define CLK_CON_DIV_CLKCMU_G3D_SWITCH		0x1844
>  #define CLK_CON_DIV_CLKCMU_HSI_BUS		0x1848
>  #define CLK_CON_DIV_CLKCMU_HSI_MMC_CARD		0x184c
>  #define CLK_CON_DIV_CLKCMU_HSI_USB20DRD		0x1850
> @@ -84,6 +86,7 @@
>  #define CLK_CON_GAT_GATE_CLKCMU_CORE_MMC_EMBD	0x2024
>  #define CLK_CON_GAT_GATE_CLKCMU_CORE_SSS	0x2028
>  #define CLK_CON_GAT_GATE_CLKCMU_DPU		0x203c
> +#define CLK_CON_GAT_GATE_CLKCMU_G3D_SWITCH	0x2040
>  #define CLK_CON_GAT_GATE_CLKCMU_HSI_BUS		0x2044
>  #define CLK_CON_GAT_GATE_CLKCMU_HSI_MMC_CARD	0x2048
>  #define CLK_CON_GAT_GATE_CLKCMU_HSI_USB20DRD	0x204c
> @@ -116,6 +119,7 @@ static const unsigned long top_clk_regs[] __initconst
> = {
>  	CLK_CON_MUX_MUX_CLKCMU_CORE_MMC_EMBD,
>  	CLK_CON_MUX_MUX_CLKCMU_CORE_SSS,
>  	CLK_CON_MUX_MUX_CLKCMU_DPU,
> +	CLK_CON_MUX_MUX_CLKCMU_G3D_SWITCH,
>  	CLK_CON_MUX_MUX_CLKCMU_HSI_BUS,
>  	CLK_CON_MUX_MUX_CLKCMU_HSI_MMC_CARD,
>  	CLK_CON_MUX_MUX_CLKCMU_HSI_USB20DRD,
> @@ -137,6 +141,7 @@ static const unsigned long top_clk_regs[] __initconst
> = {
>  	CLK_CON_DIV_CLKCMU_CORE_MMC_EMBD,
>  	CLK_CON_DIV_CLKCMU_CORE_SSS,
>  	CLK_CON_DIV_CLKCMU_DPU,
> +	CLK_CON_DIV_CLKCMU_G3D_SWITCH,
>  	CLK_CON_DIV_CLKCMU_HSI_BUS,
>  	CLK_CON_DIV_CLKCMU_HSI_MMC_CARD,
>  	CLK_CON_DIV_CLKCMU_HSI_USB20DRD,
> @@ -164,6 +169,7 @@ static const unsigned long top_clk_regs[] __initconst
> = {
>  	CLK_CON_GAT_GATE_CLKCMU_CORE_MMC_EMBD,
>  	CLK_CON_GAT_GATE_CLKCMU_CORE_SSS,
>  	CLK_CON_GAT_GATE_CLKCMU_DPU,
> +	CLK_CON_GAT_GATE_CLKCMU_G3D_SWITCH,
>  	CLK_CON_GAT_GATE_CLKCMU_HSI_BUS,
>  	CLK_CON_GAT_GATE_CLKCMU_HSI_MMC_CARD,
>  	CLK_CON_GAT_GATE_CLKCMU_HSI_USB20DRD,
> @@ -216,6 +222,9 @@ PNAME(mout_core_mmc_embd_p)	= { "oscclk",
> "dout_shared0_div2",
>  				    "oscclk", "oscclk" };
>  PNAME(mout_core_sss_p)		= { "dout_shared0_div3",
> "dout_shared1_div3",
>  				    "dout_shared0_div4", "dout_shared1_div4" };
> +/* List of parent clocks for Muxes in CMU_TOP: for CMU_G3D */
> +PNAME(mout_g3d_switch_p)	= { "dout_shared0_div2", "dout_shared1_div2",
> +				    "dout_shared0_div3", "dout_shared1_div3" };
>  /* List of parent clocks for Muxes in CMU_TOP: for CMU_HSI */
>  PNAME(mout_hsi_bus_p)		= { "dout_shared0_div2",
> "dout_shared1_div2" };
>  PNAME(mout_hsi_mmc_card_p)	= { "oscclk", "dout_shared0_div2",
> @@ -283,6 +292,10 @@ static const struct samsung_mux_clock top_mux_clks[]
> __initconst = {
>  	MUX(CLK_MOUT_DPU, "mout_dpu", mout_dpu_p,
>  	    CLK_CON_MUX_MUX_CLKCMU_DPU, 0, 2),
> 
> +	/* G3D */
> +	MUX(CLK_MOUT_G3D_SWITCH, "mout_g3d_switch", mout_g3d_switch_p,
> +	    CLK_CON_MUX_MUX_CLKCMU_G3D_SWITCH, 0, 2),
> +
>  	/* HSI */
>  	MUX(CLK_MOUT_HSI_BUS, "mout_hsi_bus", mout_hsi_bus_p,
>  	    CLK_CON_MUX_MUX_CLKCMU_HSI_BUS, 0, 1), @@ -357,6 +370,10 @@
> static const struct samsung_div_clock top_div_clks[] __initconst = {
>  	DIV(CLK_DOUT_DPU, "dout_dpu", "gout_dpu",
>  	    CLK_CON_DIV_CLKCMU_DPU, 0, 4),
> 
> +	/* G3D */
> +	DIV(CLK_DOUT_G3D_SWITCH, "dout_g3d_switch", "gout_g3d_switch",
> +	    CLK_CON_DIV_CLKCMU_G3D_SWITCH, 0, 3),
> +
>  	/* HSI */
>  	DIV(CLK_DOUT_HSI_BUS, "dout_hsi_bus", "gout_hsi_bus",
>  	    CLK_CON_DIV_CLKCMU_HSI_BUS, 0, 4), @@ -417,6 +434,10 @@ static
> const struct samsung_gate_clock top_gate_clks[] __initconst = {
>  	GATE(CLK_GOUT_DPU, "gout_dpu", "mout_dpu",
>  	     CLK_CON_GAT_GATE_CLKCMU_DPU, 21, 0, 0),
> 
> +	/* G3D */
> +	GATE(CLK_GOUT_G3D_SWITCH, "gout_g3d_switch", "mout_g3d_switch",
> +	     CLK_CON_GAT_GATE_CLKCMU_G3D_SWITCH, 21, 0, 0),
> +
>  	/* HSI */
>  	GATE(CLK_GOUT_HSI_BUS, "gout_hsi_bus", "mout_hsi_bus",
>  	     CLK_CON_GAT_GATE_CLKCMU_HSI_BUS, 21, 0, 0), @@ -992,6 +1013,103
> @@ static const struct samsung_cmu_info cmgp_cmu_info __initconst = {
>  	.clk_name		= "gout_clkcmu_cmgp_bus",
>  };
> 
> +/* ---- CMU_G3D
> +------------------------------------------------------------- */
> +
> +/* Register Offset definitions for CMU_G3D (0x11400000) */
> +#define PLL_LOCKTIME_PLL_G3D			0x0000
> +#define PLL_CON0_PLL_G3D			0x0100
> +#define PLL_CON3_PLL_G3D			0x010c
> +#define PLL_CON0_MUX_CLKCMU_G3D_SWITCH_USER	0x0600
> +#define CLK_CON_MUX_MUX_CLK_G3D_BUSD		0x1000
> +#define CLK_CON_DIV_DIV_CLK_G3D_BUSP		0x1804
> +#define CLK_CON_GAT_CLK_G3D_CMU_G3D_PCLK	0x2000
> +#define CLK_CON_GAT_CLK_G3D_GPU_CLK		0x2004
> +#define CLK_CON_GAT_GOUT_G3D_TZPC_PCLK		0x200c
> +#define CLK_CON_GAT_GOUT_G3D_GRAY2BIN_CLK	0x2010
> +#define CLK_CON_GAT_GOUT_G3D_BUSD_CLK		0x2024
> +#define CLK_CON_GAT_GOUT_G3D_BUSP_CLK		0x2028
> +#define CLK_CON_GAT_GOUT_G3D_SYSREG_PCLK	0x202c
> +
> +

Nit: double empty lines.
Otherwise, looks good to me :)

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

> +static const unsigned long g3d_clk_regs[] __initconst = {
> +	PLL_LOCKTIME_PLL_G3D,
> +	PLL_CON0_PLL_G3D,
> +	PLL_CON3_PLL_G3D,
> +	PLL_CON0_MUX_CLKCMU_G3D_SWITCH_USER,
> +	CLK_CON_MUX_MUX_CLK_G3D_BUSD,
> +	CLK_CON_DIV_DIV_CLK_G3D_BUSP,
> +	CLK_CON_GAT_CLK_G3D_CMU_G3D_PCLK,
> +	CLK_CON_GAT_CLK_G3D_GPU_CLK,
> +	CLK_CON_GAT_GOUT_G3D_TZPC_PCLK,
> +	CLK_CON_GAT_GOUT_G3D_GRAY2BIN_CLK,
> +	CLK_CON_GAT_GOUT_G3D_BUSD_CLK,
> +	CLK_CON_GAT_GOUT_G3D_BUSP_CLK,
> +	CLK_CON_GAT_GOUT_G3D_SYSREG_PCLK,
> +};
> +
> +/* List of parent clocks for Muxes in CMU_G3D */
> +PNAME(mout_g3d_pll_p)		= { "oscclk", "fout_g3d_pll" };
> +PNAME(mout_g3d_switch_user_p)	= { "oscclk", "dout_g3d_switch" };
> +PNAME(mout_g3d_busd_p)		= { "mout_g3d_pll",
> "mout_g3d_switch_user" };
> +
> +/*
> + * Do not provide PLL table to PLL_G3D, as MANUAL_PLL_CTRL bit is not
> +set
> + * for that PLL by default, so set_rate operation would fail.
> + */
> +static const struct samsung_pll_clock g3d_pll_clks[] __initconst = {
> +	PLL(pll_0818x, CLK_FOUT_G3D_PLL, "fout_g3d_pll", "oscclk",
> +	    PLL_LOCKTIME_PLL_G3D, PLL_CON3_PLL_G3D, NULL), };
> +
> +static const struct samsung_mux_clock g3d_mux_clks[] __initconst = {
> +	MUX(CLK_MOUT_G3D_PLL, "mout_g3d_pll", mout_g3d_pll_p,
> +	    PLL_CON0_PLL_G3D, 4, 1),
> +	MUX(CLK_MOUT_G3D_SWITCH_USER, "mout_g3d_switch_user",
> +	    mout_g3d_switch_user_p,
> +	    PLL_CON0_MUX_CLKCMU_G3D_SWITCH_USER, 4, 1),
> +	MUX(CLK_MOUT_G3D_BUSD, "mout_g3d_busd", mout_g3d_busd_p,
> +	    CLK_CON_MUX_MUX_CLK_G3D_BUSD, 0, 1), };
> +
> +static const struct samsung_div_clock g3d_div_clks[] __initconst = {
> +	DIV(CLK_DOUT_G3D_BUSP, "dout_g3d_busp", "mout_g3d_busd",
> +	    CLK_CON_DIV_DIV_CLK_G3D_BUSP, 0, 3), };
> +
> +static const struct samsung_gate_clock g3d_gate_clks[] __initconst = {
> +	GATE(CLK_GOUT_G3D_CMU_G3D_PCLK, "gout_g3d_cmu_g3d_pclk",
> +	     "dout_g3d_busp",
> +	     CLK_CON_GAT_CLK_G3D_CMU_G3D_PCLK, 21, CLK_IGNORE_UNUSED, 0),
> +	GATE(CLK_GOUT_G3D_GPU_CLK, "gout_g3d_gpu_clk", "mout_g3d_busd",
> +	     CLK_CON_GAT_CLK_G3D_GPU_CLK, 21, 0, 0),
> +	GATE(CLK_GOUT_G3D_TZPC_PCLK, "gout_g3d_tzpc_pclk", "dout_g3d_busp",
> +	     CLK_CON_GAT_GOUT_G3D_TZPC_PCLK, 21, 0, 0),
> +	GATE(CLK_GOUT_G3D_GRAY2BIN_CLK, "gout_g3d_gray2bin_clk",
> +	     "mout_g3d_busd",
> +	     CLK_CON_GAT_GOUT_G3D_GRAY2BIN_CLK, 21, 0, 0),
> +	GATE(CLK_GOUT_G3D_BUSD_CLK, "gout_g3d_busd_clk", "mout_g3d_busd",
> +	     CLK_CON_GAT_GOUT_G3D_BUSD_CLK, 21, 0, 0),
> +	GATE(CLK_GOUT_G3D_BUSP_CLK, "gout_g3d_busp_clk", "dout_g3d_busp",
> +	     CLK_CON_GAT_GOUT_G3D_BUSP_CLK, 21, 0, 0),
> +	GATE(CLK_GOUT_G3D_SYSREG_PCLK, "gout_g3d_sysreg_pclk",
> "dout_g3d_busp",
> +	     CLK_CON_GAT_GOUT_G3D_SYSREG_PCLK, 21, 0, 0), };
> +
> +static const struct samsung_cmu_info g3d_cmu_info __initconst = {
> +	.pll_clks		= g3d_pll_clks,
> +	.nr_pll_clks		= ARRAY_SIZE(g3d_pll_clks),
> +	.mux_clks		= g3d_mux_clks,
> +	.nr_mux_clks		= ARRAY_SIZE(g3d_mux_clks),
> +	.div_clks		= g3d_div_clks,
> +	.nr_div_clks		= ARRAY_SIZE(g3d_div_clks),
> +	.gate_clks		= g3d_gate_clks,
> +	.nr_gate_clks		= ARRAY_SIZE(g3d_gate_clks),
> +	.nr_clk_ids		= G3D_NR_CLK,
> +	.clk_regs		= g3d_clk_regs,
> +	.nr_clk_regs		= ARRAY_SIZE(g3d_clk_regs),
> +	.clk_name		= "dout_g3d_switch",
> +};
> +
>  /* ---- CMU_HSI ---------------------------------------------------------
> ---- */
> 
>  /* Register Offset definitions for CMU_HSI (0x13400000) */ @@ -1700,6
> +1818,9 @@ static const struct of_device_id exynos850_cmu_of_match[] = {
>  	}, {
>  		.compatible = "samsung,exynos850-cmu-cmgp",
>  		.data = &cmgp_cmu_info,
> +	}, {
> +		.compatible = "samsung,exynos850-cmu-g3d",
> +		.data = &g3d_cmu_info,
>  	}, {
>  		.compatible = "samsung,exynos850-cmu-hsi",
>  		.data = &hsi_cmu_info,
> --
> 2.39.1
