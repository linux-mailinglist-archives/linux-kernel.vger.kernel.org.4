Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A703D5E6447
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiIVNxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiIVNxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:53:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B24EFA6F;
        Thu, 22 Sep 2022 06:53:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A332B836FD;
        Thu, 22 Sep 2022 13:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDCCC433C1;
        Thu, 22 Sep 2022 13:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663854784;
        bh=ZtBSLVtLZO92XrxyNwtC9eWus376GKy0kCeTqk0vh0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0dFy09ViTv+wVTJqBRN/3XvroQL0nQaBSJK1/8b7o9CKuUrQzqWLGslxZESQC6R/
         siKdWL21JC8BQXutM56JTl2IvuObzL9w5XmknDowP2LM7TWnkaQS0/24/NdoS5wyyz
         z2hY28hSletdHlzRB3apvevKed8PlYsTdv8+a6GKkJwurPQM9ytXF4tw70+/NfSYwJ
         IGNSslervWARidXWQAPt/nB+694/9xrNF1dmVXxtnYIVmwuTCauHsj99CuW4e4qmxx
         l1s5d2ij5ec1DK2AmMPmIA4kIcE7G0dIXwTZAxO0MM+feCdm+Y+MCS1o+aAJfD3LPa
         m3t59dnRCAp2Q==
Date:   Thu, 22 Sep 2022 14:52:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     suzuki.poulose@arm.com, robin.murphy@arm.com,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, sudeep.holla@arm.com,
        thanu.rangarajan@arm.com, Michael.Williams@arm.com,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org
Subject: Re: [PATCH v4 1/2] perf: arm_cspmu: Add support for ARM CoreSight
 PMU driver
Message-ID: <20220922135257.GD12095@willie-the-truck>
References: <20220814182351.8861-1-bwicaksono@nvidia.com>
 <20220814182351.8861-2-bwicaksono@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220814182351.8861-2-bwicaksono@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 01:23:50PM -0500, Besar Wicaksono wrote:
> Add support for ARM CoreSight PMU driver framework and interfaces.
> The driver provides generic implementation to operate uncore PMU based
> on ARM CoreSight PMU architecture. The driver also provides interface
> to get vendor/implementation specific information, for example event
> attributes and formating.
> 
> The specification used in this implementation can be found below:
>  * ACPI Arm Performance Monitoring Unit table:
>         https://developer.arm.com/documentation/den0117/latest
>  * ARM Coresight PMU architecture:
>         https://developer.arm.com/documentation/ihi0091/latest
> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
>  arch/arm64/configs/defconfig       |    1 +
>  drivers/perf/Kconfig               |    2 +
>  drivers/perf/Makefile              |    1 +
>  drivers/perf/arm_cspmu/Kconfig     |   13 +
>  drivers/perf/arm_cspmu/Makefile    |    6 +
>  drivers/perf/arm_cspmu/arm_cspmu.c | 1262 ++++++++++++++++++++++++++++
>  drivers/perf/arm_cspmu/arm_cspmu.h |  151 ++++
>  7 files changed, 1436 insertions(+)
>  create mode 100644 drivers/perf/arm_cspmu/Kconfig
>  create mode 100644 drivers/perf/arm_cspmu/Makefile
>  create mode 100644 drivers/perf/arm_cspmu/arm_cspmu.c
>  create mode 100644 drivers/perf/arm_cspmu/arm_cspmu.h

[...]

> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> new file mode 100644
> index 000000000000..410876f86eb0
> --- /dev/null
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c

[...]

> +/*
> + * Read 64-bit register as a pair of 32-bit registers using hi-lo-hi sequence.
> + */
> +static u64 read_reg64_hilohi(const void __iomem *addr)
> +{
> +	u32 val_lo, val_hi;
> +	u64 val;
> +
> +	/* Use high-low-high sequence to avoid tearing */
> +	do {
> +		val_hi = readl(addr + 4);
> +		val_lo = readl(addr);
> +	} while (val_hi != readl(addr + 4));

Hmm, we probably want a timeout or something in here so we don't lock
up the CPU if the device goes wonky.

With that, how about adding this a helper to
include/linux/io-64-nonatomic-*o.h so other folks can reuse it?

> +/* Check if PMU supports 64-bit single copy atomic. */
> +static inline bool supports_64bit_atomics(const struct arm_cspmu *cspmu)
> +{
> +	return CHECK_APMT_FLAG(cspmu->apmt_node->flags, ATOMIC, SUPP);
> +}

Is this just there because the architecture permits it, or are folks
actually hanging these things off 32-bit MMIO buses on arm64 SoCs?

> +static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
> +{
> +	int irq, ret;
> +	struct device *dev;
> +	struct platform_device *pdev;
> +	struct acpi_apmt_node *apmt_node;
> +
> +	dev = cspmu->dev;
> +	pdev = to_platform_device(dev);
> +	apmt_node = cspmu->apmt_node;
> +
> +	/* Skip IRQ request if the PMU does not support overflow interrupt. */
> +	if (apmt_node->ovflw_irq == 0)
> +		return 0;

Set PERF_PMU_CAP_NO_INTERRUPT?

Will
