Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33A35FBF58
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 04:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiJLCuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 22:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJLCuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 22:50:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B236B8FF;
        Tue, 11 Oct 2022 19:50:14 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MnHBP0sdzz1CDyL;
        Wed, 12 Oct 2022 10:47:41 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 10:50:12 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 10:50:12 +0800
Message-ID: <b209b4a7-5de4-8ad6-4e99-8fff63397abd@huawei.com>
Date:   Wed, 12 Oct 2022 10:50:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] clk: at91: fix the build with binutils 2.27
Content-Language: en-US
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-clk@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>
References: <20221012030635.13140-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20221012030635.13140-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/10/12 11:06, Kefeng Wang wrote:
> There is an issue when build with older versions of binutils 2.27.0,
>
> arch/arm/mach-at91/pm_suspend.S: Assembler messages:
> arch/arm/mach-at91/pm_suspend.S:1086: Error: garbage following instruction -- `ldr tmp1,=0x00020010UL'
>
> Use UL() macro to fix the issue in assembly file.
>
> Fixes: 4fd36e458392 ("ARM: at91: pm: add plla disable/enable support for sam9x60")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2: use linux/bits.h instead of vdso/bits.h
+ Stephen
>
>   include/linux/clk/at91_pmc.h | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
> index 3484309b59bf..7af499bdbecb 100644
> --- a/include/linux/clk/at91_pmc.h
> +++ b/include/linux/clk/at91_pmc.h
> @@ -12,6 +12,8 @@
>   #ifndef AT91_PMC_H
>   #define AT91_PMC_H
>   
> +#include <linux/bits.h>
> +
>   #define AT91_PMC_V1		(1)			/* PMC version 1 */
>   #define AT91_PMC_V2		(2)			/* PMC version 2 [SAM9X60] */
>   
> @@ -45,8 +47,8 @@
>   #define	AT91_PMC_PCSR		0x18			/* Peripheral Clock Status Register */
>   
>   #define AT91_PMC_PLL_ACR	0x18			/* PLL Analog Control Register [for SAM9X60] */
> -#define		AT91_PMC_PLL_ACR_DEFAULT_UPLL	0x12020010UL	/* Default PLL ACR value for UPLL */
> -#define		AT91_PMC_PLL_ACR_DEFAULT_PLLA	0x00020010UL	/* Default PLL ACR value for PLLA */
> +#define		AT91_PMC_PLL_ACR_DEFAULT_UPLL	UL(0x12020010)	/* Default PLL ACR value for UPLL */
> +#define		AT91_PMC_PLL_ACR_DEFAULT_PLLA	UL(0x00020010)	/* Default PLL ACR value for PLLA */
>   #define		AT91_PMC_PLL_ACR_UTMIVR		(1 << 12)	/* UPLL Voltage regulator Control */
>   #define		AT91_PMC_PLL_ACR_UTMIBG		(1 << 13)	/* UPLL Bandgap Control */
>   
