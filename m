Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60916475DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLHTB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiLHTBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:01:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 236AB49B4A;
        Thu,  8 Dec 2022 11:01:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A1B923A;
        Thu,  8 Dec 2022 11:01:29 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C5793F73D;
        Thu,  8 Dec 2022 11:01:20 -0800 (PST)
Message-ID: <2a188b8a-ab16-d5d4-ed5f-f8eec236e4ca@arm.com>
Date:   Thu, 8 Dec 2022 19:01:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH] arm64: dts: ls1028a: mark ARM SMMU as DMA coherent
Content-Language: en-GB
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
References: <20221208151514.3840720-1-vladimir.oltean@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221208151514.3840720-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2022 3:15 pm, Vladimir Oltean wrote:
> Since commit df198b37e72c ("iommu/arm-smmu: Report
> IOMMU_CAP_CACHE_COHERENCY better"), the SMMU driver will say that a
> device has the IOMMU_CAP_CACHE_COHERENCY capability if the
> ARM_SMMU_FEAT_COHERENT_WALK bit was set in smmu->features.
> 
> This breaks vfio-pci, as can be seen below:
> 
> $ echo 0000:00:00.0 > /sys/bus/pci/drivers/fsl_enetc/unbind
> $ echo vfio-pci > /sys/bus/pci/devices/0000\:00\:00.0/driver_override
> $ echo 0000:00:00.0 > /sys/bus/pci/drivers/vfio-pci/bind
> [   25.261941] vfio-pci 0000:00:00.0: arm_smmu_capable: smmu features 0xe9e
> [   25.268877] vfio-pci 0000:00:00.0: vfio_group_find_or_alloc: device_iommu_capable() returned false
> [   25.279271] vfio-pci 0000:00:00.0: vfio_pci_core_register_device: failed to register group dev: -EINVAL
> [   25.301377] vfio-pci: probe of 0000:00:00.0 failed with error -22
> 
> The ARM_SMMU_FEAT_COHERENT_WALK feature is set in
> arm_smmu_device_dt_probe() if the OF node of the SMMU device was set as
> dma-coherent. In the case of LS1028A, it wasn't.
> 
> Fix that.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> The LS1028A is not the only SoC affected by this, it seems.
> fsl-ls1088a.dtsi seems to be in the same situation where vfio-pci worked
> before. There are also other SoCs which don't have dma-coherent in the
> iommu node. There's also something I don't quite like about this patch
> technically introducing a regression which requires a device tree update.
> 
> Can something different be done about that, or are LS1028A/LS1088A
> simply to blame because of breaching the dt-bindings contract, and in
> that case, I'll have to suck it up, put a Fixes tag here, write another
> patch for LS1088A, and resend?

It's more just good fortune that it ever worked properly at all. We have
to make the DT authoritative about coherency because cases exist where
the ID register is misconfigured. You've been telling Linux that that is
the case, and now the message is finally getting through to VFIO. If we
weren't also lazy in io-pgtable-arm about what shareability attribute to
use for IOMMU_CACHE, you would have actually had the broken VFIO
behaviour that that check is now defending against.

I'd argue that you do want to make the DT change, because it's the truth
of the hardware. Even if you did want to keep doing the significant
extra work of maintaining non-coherent pagetables (there is a dubious
snoop latency vs. TLB miss rate argument), that would be better achieved
at the level of the io_pgtable_cfg, not by lying about the entire SMMU.

However, since Jason refactored things at the VFIO end too, it looks like
this should now be consistently checked for every individual device
bound to a VFIO driver, so we might be able to do a bit better, as
below. I'd be rather surprised if anyone ever genuinely built this
topology, but it does happen to be the one other combination that's easy
to infer with reasonable confidence.

Thanks,
Robin.

----->8-----
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 30dab1418e3f..a5ad9d6b51cf 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1320,7 +1320,8 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
  	switch (cap) {
  	case IOMMU_CAP_CACHE_COHERENCY:
  		/* Assume that a coherent TCU implies coherent TBUs */
-		return cfg->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK;
+		return cfg->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK ||
+			device_get_dma_attr(dev) == DEV_DMA_COHERENT;
  	case IOMMU_CAP_NOEXEC:
  		return true;
  	default:
