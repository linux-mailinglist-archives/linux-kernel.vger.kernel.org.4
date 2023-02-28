Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4744C6A547D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjB1IgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjB1IgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:36:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E342A98D;
        Tue, 28 Feb 2023 00:36:04 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C97536602E18;
        Tue, 28 Feb 2023 08:36:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677573362;
        bh=sSCSNcAqqjG5p1vyPrPF5laJlyrHjAnoYyrkzT0wCBw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XHL41QU1m5Z4BwJXQIyYlnOOwEx/7A9c153+Idri0aMSGntkahLFPF3DYvkCGX20D
         P+I5OlLsTyhGBusUPopLSfCGZgb2DVJI9Rn+Mt4wiqersYQr4aaWhQpFpajX5yAI1K
         F9Yo5cxeMAhC9rmlDnzD4Hw7SSLP/uuBpbSzh8GMt80yLSm8MOkmAYz+BeCBelhTis
         C4q+FAWUEnHMYxbRVFQYzkWGL0oJbxDSuo43ihRTG/0rUw5JhKqBJ+6ORyOXJPTk2i
         zdcjgoMF4+Fo899Qq3U32VFjrVPBOwtbqUGw/YBziFrz7uKP1v2ISyZMqTdiHf98jd
         YclbNjOLfMntA==
Message-ID: <d86908b8-20b1-418e-d266-6532c012c8ea@collabora.com>
Date:   Tue, 28 Feb 2023 09:35:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC 1/1] irqchip/gic-v3: Add RK3588 GICR and GITS no share
 workaround
Content-Language: en-US
To:     Lucas Tanure <lucas.tanure@collabora.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230227151847.207922-1-lucas.tanure@collabora.com>
 <20230227151847.207922-2-lucas.tanure@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230227151847.207922-2-lucas.tanure@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/02/23 16:18, Lucas Tanure ha scritto:
> The GIC600 integration in RK356x, used in rk3588, doesn't support
> any of the shareability or cacheability attributes, and requires
> both values to be set to 0b00 for all the ITS and Redistributor
> tables.
> 
> Based on work of Peter Geis for the Quartz64 board.
> 
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
> ---
>   Documentation/arm64/silicon-errata.rst |  4 +++
>   arch/arm64/Kconfig                     | 13 ++++++++
>   drivers/irqchip/irq-gic-v3-its.c       | 42 ++++++++++++++++++++++++++
>   3 files changed, 59 insertions(+)
> 
> diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
> index ec5f889d7681..b26cf8ca7d5c 100644
> --- a/Documentation/arm64/silicon-errata.rst
> +++ b/Documentation/arm64/silicon-errata.rst
> @@ -209,3 +209,7 @@ stable kernels.
>   +----------------+-----------------+-----------------+-----------------------------+
>   | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
>   +----------------+-----------------+-----------------+-----------------------------+
> +
> ++----------------+-----------------+-----------------+-----------------------------+
> +| RockChip       | RK3588          | N/A             | ROCKCHIP_NO_SHARE           |
> ++----------------+-----------------+-----------------+-----------------------------+

This should go after Qualcomm, as it looks like this file is ordered by name but
for some reason Fujitsu got at the bottom.
Just keep your new addition ordered.

Besides, I propose the following:

| RockChip       | RK3588          | N/A             | ROCKCHIP_ITS_ERRATUM       |

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 27b2592698b0..ad3f1742052b 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1150,6 +1150,19 @@ config NVIDIA_CARMEL_CNP_ERRATUM
>   
>   	  If unsure, say Y.
>   
> +config ROCKCHIP_NO_SHARE

config ROCKCHIP_ITS_ERRATUM ?? :-)

> +	bool "Rockchip RK3588 GIC6000 No shareability or cacheability attributes"

You've got a typo here: GIC6000.

> +	default y
> +	help
> +	  The GIC600 integration in RK356x doesn't support any of the shareability or
> +	  cacheability attributes, and requires both values to be set to 0b00 for all
> +	  the ITS and Redistributor tables.
> +
> +	  Work around the issue by clearing the GICR_PROPBASER_SHAREABILITY_MASK from
> +	  register reads at GICR and GITS.
> +
> +	  If unsure, say Y.
> +
>   config SOCIONEXT_SYNQUACER_PREITS
>   	bool "Socionext Synquacer: Workaround for GICv3 pre-ITS"
>   	default y
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 586271b8aa39..637e2e2a1ab1 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -42,6 +42,7 @@
>   #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
>   #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
>   #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
> +#define ITS_FLAGS_WORKAROUND_ROCKCHIP_NOSHARE	(1ULL << 3)
>   
>   #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
>   #define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
> @@ -2359,6 +2360,15 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
>   	its_write_baser(its, baser, val);
>   	tmp = baser->val;
>   
> +#if CONFIG_ROCKCHIP_NO_SHARE

None of the other workarounds have an ifdef in parsing the flags, so I think
that you can avoid enclosing this in a preprocessor `if` block.

> +	if (its->flags & ITS_FLAGS_WORKAROUND_ROCKCHIP_NOSHARE) {
> +		if (tmp & GITS_BASER_SHAREABILITY_MASK)
> +			tmp &= ~GITS_BASER_SHAREABILITY_MASK;
> +		else
> +			gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
> +	}
> +#endif
> +
>   	if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {
>   		/*
>   		 * Shareability didn't stick. Just use
> @@ -3057,6 +3067,7 @@ static void its_cpu_init_lpis(void)
>   {
>   	void __iomem *rbase = gic_data_rdist_rd_base();
>   	struct page *pend_page;
> +	struct its_node *its;
>   	phys_addr_t paddr;
>   	u64 val, tmp;
>   
> @@ -3096,6 +3107,12 @@ static void its_cpu_init_lpis(void)
>   	gicr_write_propbaser(val, rbase + GICR_PROPBASER);
>   	tmp = gicr_read_propbaser(rbase + GICR_PROPBASER);
>   
> +#if CONFIG_ROCKCHIP_NO_SHARE

ditto.

> +	its = list_first_entry(&its_nodes, struct its_node, entry);
> +	if (its->flags & ITS_FLAGS_WORKAROUND_ROCKCHIP_NOSHARE)
> +		tmp &= ~GICR_PROPBASER_SHAREABILITY_MASK;
> +#endif
> +
>   	if ((tmp ^ val) & GICR_PROPBASER_SHAREABILITY_MASK) {
>   		if (!(tmp & GICR_PROPBASER_SHAREABILITY_MASK)) {
>   			/*
> @@ -3120,6 +3137,11 @@ static void its_cpu_init_lpis(void)
>   	gicr_write_pendbaser(val, rbase + GICR_PENDBASER);
>   	tmp = gicr_read_pendbaser(rbase + GICR_PENDBASER);
>   
> +#if CONFIG_ROCKCHIP_NO_SHARE
> +	if (its->flags & ITS_FLAGS_WORKAROUND_ROCKCHIP_NOSHARE)
> +		tmp &= ~GICR_PENDBASER_SHAREABILITY_MASK;
> +#endif
> +
>   	if (!(tmp & GICR_PENDBASER_SHAREABILITY_MASK)) {
>   		/*
>   		 * The HW reports non-shareable, we must remove the
> @@ -4710,6 +4732,14 @@ static bool __maybe_unused its_enable_quirk_hip07_161600802(void *data)
>   	return true;
>   }
>   
> +static bool __maybe_unused its_enable_quirk_rk356x(void *data)
> +{
> +	struct its_node *its = data;
> +
> +	its->flags |= ITS_FLAGS_WORKAROUND_ROCKCHIP_NOSHARE;
> +	return true;
> +}
> +
>   static const struct gic_quirk its_quirks[] = {
>   #ifdef CONFIG_CAVIUM_ERRATUM_22375
>   	{
> @@ -4755,6 +4785,14 @@ static const struct gic_quirk its_quirks[] = {
>   		.mask	= 0xffffffff,
>   		.init	= its_enable_quirk_hip07_161600802,
>   	},
> +#endif
> +#ifdef CONFIG_ROCKCHIP_NO_SHARE

here it's fine.

> +	{
> +		.desc	= "ITS: Rockchip RK356X/RK3588 doesn't support shareability",
> +		.iidr	= 0x0201743b,
> +		.mask	= 0xffffffff,
> +		.init	= its_enable_quirk_rk356x,
> +	},
>   #endif
>   	{
>   	}
> @@ -5096,6 +5134,10 @@ static int __init its_probe_one(struct resource *res,
>   	gits_write_cbaser(baser, its->base + GITS_CBASER);
>   	tmp = gits_read_cbaser(its->base + GITS_CBASER);
>   
> +#if CONFIG_ROCKCHIP_NO_SHARE

...here it's not, again.

> +	if (its->flags & ITS_FLAGS_WORKAROUND_ROCKCHIP_NOSHARE)
> +		tmp &= ~GITS_CBASER_SHAREABILITY_MASK;
> +#endif
>   	if ((tmp ^ baser) & GITS_CBASER_SHAREABILITY_MASK) {
>   		if (!(tmp & GITS_CBASER_SHAREABILITY_MASK)) {
>   			/*


Regards,
Angelo
