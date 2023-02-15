Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2CE697467
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 03:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjBOCiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 21:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjBOCiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 21:38:18 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E1D27D6E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:38:14 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230215023811epoutp0202478e7964e6a039b69d4f54841946ad~D3wM5HJ1f0451504515epoutp02F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:38:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230215023811epoutp0202478e7964e6a039b69d4f54841946ad~D3wM5HJ1f0451504515epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676428691;
        bh=MYrK5odi8ehuumCYTygtU8F4voyDIDpU6cypwIrWmZI=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=nM8vPXGvsvfzTY71W2OT/0CJhCGt8Gf50kGYxAOKw77EwrCqxtgedW7YSPOuejQ36
         RCHIBBoNwmVqHB8LmuNq2mWpR1q8JGfE1oRAnuItmsFK/ftLprfh7hZR+twAKd+JXQ
         +/pg5hxzXZv5POcKPeeKC8cBHrUupa4MP0gs30W0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230215023810epcas2p21582246aa3ce83804095ab293fe34ce6~D3wMVwthm2340523405epcas2p2F;
        Wed, 15 Feb 2023 02:38:10 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.99]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PGj1G26Bbz4x9Pv; Wed, 15 Feb
        2023 02:38:10 +0000 (GMT)
X-AuditID: b6c32a47-ab7ff7000000e044-63-63ec4592337d
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.AE.57412.2954CE36; Wed, 15 Feb 2023 11:38:10 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 3/6] clk: samsung: clk-pll: Implement pll0818x PLL type
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
In-Reply-To: <20230211064006.14981-4-semen.protsenko@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230215023809epcms2p37b9e2cb4c9ca136849a1accf526aa7ad@epcms2p3>
Date:   Wed, 15 Feb 2023 11:38:09 +0900
X-CMS-MailID: 20230215023809epcms2p37b9e2cb4c9ca136849a1accf526aa7ad
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmue4k1zfJBq0f+CwezNvGZnH9y3NW
        i/lHzrFa7H29ld1i0+NrrBYfe+6xWlzeNYfNYsb5fUwWF0+5WrTuPcJucfhNO6vFv2sbWSye
        9wHFT939zG6xatcfRovj7x8zOgh4vL/Ryu6xc9Zddo9NqzrZPO5c28PmsXlJvUffllWMHp83
        yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDd
        rqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIF
        KkzIzli/yaagkafi/rN3bA2MLzm7GDk5JARMJG7Pn8XexcjFISSwg1Hi7t/PLF2MHBy8AoIS
        f3cIg9QIC3hLrDw8ixUkLCSgLLFxWyxEWF/ie38TC4jNJqArMf/DJ1aQMSIC9xkldj/9ygji
        MAscZ5GYdfM4I8QyXokZ7U9ZIGxpie3Lt4LFOQUcJC6tfwxVoyHxY1kvM4QtKnFz9Vt2GPv9
        sflQNSISrffOQtUISjz4uZsR5DgJAUmJSW8iIMIBEk33QQ4CsXMkNhycxAZhm0t8fzofrJVX
        wFdi4b4JTCA2i4CqxM0dS6FGukgs3rUIrJdZQF5i+9s5zCDjmQU0Jdbv0ofYpCxx5BYLRAWf
        RMfhv+wwD+6Y94QJwlaXOLB9OtSzshLdcz5DXeMhsejOepYJjIqzEOE8C8muWQi7FjAyr2IU
        Sy0ozk1PLTYqMIbHbHJ+7iZGcBrWct/BOOPtB71DjEwcjIcYJTiYlUR4hZ++SBbiTUmsrEot
        yo8vKs1JLT7EaAr05URmKdHkfGAmyCuJNzSxNDAxMzM0NzI1MFcS55W2PZksJJCeWJKanZpa
        kFoE08fEwSnVwFTe8SDct45FfdOPRYofT2WonLfQ/BjqXfti64uw20fKC37Pmv1dMvDezNAN
        9cy11RWHdq+OKBSY+cJn3c5fF+26Kn7q3Fz1ZdXffaFZjpv/uve4NF8WsEsS/vDiq4v36lnf
        Vz2aeeFD5MINATaSPxb17v295/B6rV82dq1lad95Dng6JZ8q2XVy8f1pM+fvikl8/F4j+fmf
        CYlXc5fuKjvRIswf9+SO1u89DoHH5r8RenY+cErFcRf+53McNFfKnZi9YeUX1mNLrwZM51e0
        rklIC/gVx9UxtclyzoPLIZJ7Xkp9EtzEPnlKdl7ojszdaXPi2w2teA82lBeIBgr+8VnLpPt+
        8p6EKX2WYauqqo73KrEUZyQaajEXFScCAAtItWxMBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230211063955epcas2p177f52416ffb66cffa368fde02ee40411
References: <20230211064006.14981-4-semen.protsenko@linaro.org>
        <20230211064006.14981-1-semen.protsenko@linaro.org>
        <CGME20230211063955epcas2p177f52416ffb66cffa368fde02ee40411@epcms2p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 3/6] clk: samsung: clk-pll: Implement pll0818x PLL type
> 
> pll0818x PLL is used in Exynos850 SoC for CMU_G3D PLL. Operation-wise,
> pll0818x is the same as pll0822x. The only difference is:
>   - pl0822x is integer PLL with Middle FVCO (950 to 2400 MHz)
>   - pl0818x is integer PLL with Low FVCO (600 to 1200 MHz)
> 
> Add pll0818x type as an alias to pll0822x.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

> ---
>  drivers/clk/samsung/clk-pll.c | 1 +
>  drivers/clk/samsung/clk-pll.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
> index 5ceac4c25c1c..74934c6182ce 100644
> --- a/drivers/clk/samsung/clk-pll.c
> +++ b/drivers/clk/samsung/clk-pll.c
> @@ -1314,6 +1314,7 @@ static void __init _samsung_clk_register_pll(struct
> samsung_clk_provider *ctx,
>  			init.ops = &samsung_pll35xx_clk_ops;
>  		break;
>  	case pll_1417x:
> +	case pll_0818x:
>  	case pll_0822x:
>  		pll->enable_offs = PLL0822X_ENABLE_SHIFT;
>  		pll->lock_offs = PLL0822X_LOCK_STAT_SHIFT; diff --git
> a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h index
> 5d5a58d40e7e..0725d485c6ee 100644
> --- a/drivers/clk/samsung/clk-pll.h
> +++ b/drivers/clk/samsung/clk-pll.h
> @@ -34,6 +34,7 @@ enum samsung_pll_type {
>  	pll_1451x,
>  	pll_1452x,
>  	pll_1460x,
> +	pll_0818x,
>  	pll_0822x,
>  	pll_0831x,
>  	pll_142xx,
> --
> 2.39.1
