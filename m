Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C016A698DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 08:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBPHW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 02:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPHWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 02:22:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01008524B;
        Wed, 15 Feb 2023 23:22:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9017461EA3;
        Thu, 16 Feb 2023 07:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DD3C433EF;
        Thu, 16 Feb 2023 07:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676532171;
        bh=kZ1WjxkkGFjEg+o/K47n5dpVDH7R2gXcd9cVzzQujE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZWP45HDcQpfjun1y3qe6ONR7rQIZZ0GYjAnbKe41lHNpQS89LtbS4qlTyo4b1hgv
         iHqfSAycowngnN1s5SMqXw4LddJHrmDWkn9YPHFV1sD3V4MindmwQvrW+sRYwHexMx
         tsNABpYBgF4TsHm9PpJ/BgyO1JDuC3vjcZPhGAq+synTvrZSOeuNCIiX5OoHbAGp75
         P+y+aPZrTiaZogPk2hP5iL91SPjrXQMCQMQMjZKV2A//7e+IoviICF8L+CMI60nH4W
         nbSj3nLrlHGZfsOwqbzSFMZJrt1GWqi5+I7m/SIFHx23LvFCxfCA2ceMCEw6wptDxk
         x/vX1X1Sc/knQ==
Date:   Wed, 15 Feb 2023 23:22:49 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] soc: qcom: Make the Qualcomm UFS/SDCC ICE a
 dedicated driver
Message-ID: <Y+3ZyVRowJplzm9t@sol.localdomain>
References: <20230214120253.1098426-1-abel.vesa@linaro.org>
 <20230214120253.1098426-2-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214120253.1098426-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Tue, Feb 14, 2023 at 02:02:49PM +0200, Abel Vesa wrote:
> This takes the already existing duplicated support in both ufs-qcom
> and sdhci-msm drivers and makes it a dedicated driver that can be used
> by both mentioned drivers. The reason for this is because, staring with
> SM8550, the ICE IP block is shared between UFS and SDCC, which means we
> need to probe a dedicated device and share it between those two
> consumers. So let's add the ICE dedicated driver as a soc driver.

Thanks for doing this!

About a year ago there was also a patch (that seems to have been abandoned) by
Gaurav Kashyap to create an ICE library:
https://lore.kernel.org/linux-scsi/20211206225725.77512-2-quic_gaurkash@quicinc.com

That patch just made it a library, not an actual device driver.

Is it fair to say that the library approach would not be appropriate anymore for
the reason you mention above: on the latest SoC there's now a single ICE
instance for both the UFS and eMMC host controllers, instead of one per host
controller?

Will there be any issue with using the dedicated driver on older SoCs that do
have separate ICE instances?

Also, in both cases, how will the ICE clock be controlled?  Currently the ICE
clock gets turned on and off by the UFS and eMMC drivers.  I don't see any logic
in your new driver that turns the clock on and off.

> +config QCOM_INLINE_CRYPTO_ENGINE
> +	bool "QCOM UFS & SDCC Inline Crypto Engine driver"

Shouldn't this be a tristate?

Also should it really be user-selectable (have a prompt string)?  There's
already SCSI_UFS_QCOM and MMC_SDHCI_MSM that control the host controller
drivers, and SCSI_UFS_CRYPTO and MMC_CRYPTO that control the inline encryption
support for those host controller drivers.  Shouldn't the kconfig just select
QCOM_INLINE_CRYPTO_ENGINE if 'SCSI_UFS_QCOM && SCSI_UFS_CRYPTO' or
'MMC_SDHCI_MSM && MMC_CRYPTO'?  I don't think there's any need to make users
explicitly select yet another option.

> diff --git a/drivers/soc/qcom/qcom-ice.c b/drivers/soc/qcom/qcom-ice.c
> new file mode 100644
> index 000000000000..40c9adbc2666
> --- /dev/null
> +++ b/drivers/soc/qcom/qcom-ice.c

The directory is already named "qcom", so how about just naming the file
"ice.c"?

> @@ -0,0 +1,315 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Qualcomm ICE (Inline Crypto Engine) support.
> + *
> + * Copyright (c) 2023, Linaro Limited
> + */

Can you please keep the copyright statements from the file this is derived from?

> +/* Only one ICE instance is supported currently by HW */
> +static struct qcom_ice *engine;

Isn't it very bad practice for drivers to store state in static variables like
this?  Sure, the SCM calls are global anyway, so multiple ICE instances aren't
going to be supported regardless.  But surely it isn't necessary to use a static
variable like this too, since the device private data could be used instead?

> +static bool qcom_ice_check_supported(struct qcom_ice *ice)
> +{
> +	u32 regval = qcom_ice_readl(ice, QCOM_ICE_REG_VERSION);
> +	struct device *dev = ice->dev;
> +	int major = regval >> 24;
> +	int minor = (regval >> 16) & 0xFF;
> +	int step = regval & 0xFFFF;
> +
> +	ice->supported = true;
> +
> +	/* For now this driver only supports ICE version 3. */
> +	if (major != 3) {
> +		dev_warn(dev, "Unsupported ICE version: v%d.%d.%d\n",
> +			 major, minor, step);
> +		ice->supported = false;
> +		goto out;
> +	}
> +
> +	dev_info(dev, "Found QC Inline Crypto Engine (ICE) v%d.%d.%d\n",
> +		 major, minor, step);
> +
> +	/* If fuses are blown, ICE might not work in the standard way. */
> +	regval = qcom_ice_readl(ice, QCOM_ICE_REG_FUSE_SETTING);
> +	if (regval & (QCOM_ICE_FUSE_SETTING_MASK |
> +		      QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK |
> +		      QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK)) {
> +		dev_warn(dev, "Fuses are blown; ICE is unusable!\n");
> +		ice->supported = false;
> +		goto out;
> +	}
> +out:
> +	return ice->supported;
> +}

Is the 'supported' field necessary?  Shouldn't the driver just not bind to the
device if it doesn't support it?

> +void qcom_ice_low_power_mode_enable(struct qcom_ice *ice)
> +{

Please make functions static whenever possible.

> +/* Poll until all BIST bits are reset */
> +static int qcom_ice_wait_bist_status(struct qcom_ice *ice)
> +{
> +	int count;
> +	u32 reg;
> +
> +	if (!ice)
> +		return 0;
> +
> +	for (count = 0; count < 100; count++) {
> +		reg = qcom_ice_readl(ice, QCOM_ICE_REG_BIST_STATUS);
> +		if (!(reg & QCOM_ICE_BIST_STATUS_MASK))
> +			break;
> +		udelay(50);
> +	}
> +
> +	if (reg)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}

The version of this function in drivers/mmc/host/sdhci-msm.c has a better
comment, and a simpler implementation using readl_poll_timeout().  How about
using that version of this function?

> +int qcom_ice_resume(struct qcom_ice *ice)
> +{
> +	struct device *dev = ice->dev;
> +	int err;
> +
> +	if (!ice)
> +		return 0;

The above NULL check occurs after the pointer was already dereferenced.

Also, why is NULL allowed here anyway?

> +/*
> + * Program a key into a QC ICE keyslot, or evict a keyslot.  QC ICE requires
> + * vendor-specific SCM calls for this; it doesn't support the standard way.
> + */
> +int qcom_ice_program_key(struct qcom_ice *ice, bool config_enable,
> +			 u8 crypto_cap_idx, u8 algorithm_id,
> +			 u8 key_size, const u8 crypto_key[],
> +			 u8 data_unit_size, int slot)
> +{
> +	struct device *dev = ice->dev;
> +	union {
> +		u8 bytes[AES_256_XTS_KEY_SIZE];
> +		u32 words[AES_256_XTS_KEY_SIZE / sizeof(u32)];
> +	} key;
> +	int i;
> +	int err;
> +
> +	if (!config_enable)
> +		return qcom_scm_ice_invalidate_key(slot);

Can you please make eviction a separate function?  All it needs is the ICE
instance and the keyslot, not the other parameters.

Yes, the UFS and eMMC drivers have the program_key method that does both
programming and eviction, but that doesn't mean this has to do the same.

> diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
> new file mode 100644
> index 000000000000..3ee8add7aeb9
> --- /dev/null
> +++ b/include/soc/qcom/ice.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#ifndef __QCOM_ICE_H__
> +#define __QCOM_ICE_H__
> +
> +#include <linux/err.h>
> +
> +struct qcom_ice {
> +	struct device *dev;
> +	struct device_node *np;
> +	void __iomem *base;
> +
> +	struct clk *core_clk;
> +
> +	bool supported;
> +};

Shouldn't struct qcom_ice be private to the driver?

> +enum qcom_ice_crypto_key_size {
> +	QCOM_ICE_CRYPTO_KEY_SIZE_INVALID	= 0x0,
> +	QCOM_ICE_CRYPTO_KEY_SIZE_128		= 0x1,
> +	QCOM_ICE_CRYPTO_KEY_SIZE_192		= 0x2,
> +	QCOM_ICE_CRYPTO_KEY_SIZE_256		= 0x3,
> +	QCOM_ICE_CRYPTO_KEY_SIZE_512		= 0x4,
> +};
> +
> +enum qcom_ice_crypto_alg {
> +	QCOM_ICE_CRYPTO_ALG_AES_XTS		= 0x0,
> +	QCOM_ICE_CRYPTO_ALG_BITLOCKER_AES_CBC	= 0x1,
> +	QCOM_ICE_CRYPTO_ALG_AES_ECB		= 0x2,
> +	QCOM_ICE_CRYPTO_ALG_ESSIV_AES_CBC	= 0x3,
> +};

This patch series introduces an implicit assumption that these values match the
UFS and eMMC algorithm constants.

The way it worked previously is that the UFS driver explicitly checked that the
UFS algorithm ID was AES-256-XTS before translating it into
QCOM_SCM_ICE_CIPHER_AES_256_XTS, and similarly for eMMC.

Now there are these intermediate QCOM_ICE_CRYPTO_ALG_* constants, and there's no
explicit validation that they actually match the UFS and eMMC constants.

Maybe this part should be kept more similar to how it was before, where the
check for AES-256-XTS happens in the UFS and eMMC drivers?

- Eric
