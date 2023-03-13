Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E326B8105
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjCMSqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjCMSqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:46:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C6128D34;
        Mon, 13 Mar 2023 11:45:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E81E061477;
        Mon, 13 Mar 2023 18:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B84FC433D2;
        Mon, 13 Mar 2023 18:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678733080;
        bh=dSwjc6VrZyuKRs3FcaS0zc1QaXTsOptD0AFwcVyG0TE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QUAVNamWky1dVxT9NHY5JfDqMATEh4vR38zN2/zYgXqZq16+e1apMBeGMi6OasDKA
         Tl3R5o90cdFuLE7UsxczfCVUYGRXK/zoJ6G5MJAqKXffWY/4U0dpOAPvIEmh8aw87A
         LJnaOExIMOgSdLbZzHxEe1ztgvZ1Vlsiyr0rB2br2S5KBQhheIPI5/ZpF39XENlwwq
         6DkIzAXK1WW5i7BiWi+y3bPwK1AQRxZPjWjdW2PvuiKmMJF3FelN7yntJ+ac9QRwra
         TDFstxdo3jwFyx9A2V/9jO5xDBmFpxvn7DH00kBnukVhJhavQ2rGWf16fbh2dy9E2U
         6iepRZj96D/lg==
Date:   Mon, 13 Mar 2023 11:44:37 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v3 4/7] soc: qcom: Make the Qualcomm UFS/SDCC ICE a
 dedicated driver
Message-ID: <ZA9vFcjLMoifqcsE@sol.localdomain>
References: <20230313115202.3960700-1-abel.vesa@linaro.org>
 <20230313115202.3960700-5-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313115202.3960700-5-abel.vesa@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 01:51:59PM +0200, Abel Vesa wrote:
> diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
> new file mode 100644
> index 000000000000..d664dd598791
> --- /dev/null
> +++ b/drivers/soc/qcom/ice.c
> @@ -0,0 +1,347 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Qualcomm ICE (Inline Crypto Engine) support.
> + *
> + * Copyright (c) 2013-2019, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2019, Google LLC
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include <linux/of_platform.h>
> +
> +#include <linux/firmware/qcom/qcom_scm.h>
> +
> +#include <soc/qcom/ice.h>
> +
> +#define AES_256_XTS_KEY_SIZE			64
> +
> +/* QCOM ICE registers */
> +#define QCOM_ICE_REG_VERSION			0x0008
> +#define QCOM_ICE_REG_FUSE_SETTING		0x0010
> +
> +/* QCOM ICE v2.X only */
> +
> +#define QCOM_ICE_REG_BIST_STATUS		0x0070
> +#define QCOM_ICE_REG_ADVANCED_CONTROL		0x1000

The "/* QCOM ICE v2.X only */" comment should be removed, as it's misleading.
This driver only supports v3.  I think this comment also originally described
registers that have now been removed from the file.

> +/* BIST ("built-in self-test"?) status flags */
> +#define QCOM_ICE_BIST_STATUS_MASK		GENMASK(31, 28)

I think we're confident enough in what "BIST" stands for now that the question
mark can be removed.

> +/* Only one ICE instance is currently supported by HW */
> +static bool qcom_ice_check_supported(struct qcom_ice *ice)

I don't see how the comment relates to the function it documents.

> +static int __qcom_ice_enable(struct qcom_ice *ice, bool enable)
> +{
> +	struct device *dev = ice->dev;
> +	int err;
> +
> +	err = clk_prepare_enable(ice->core_clk);
> +	if (err) {
> +		dev_err(dev, "failed to enable core clock (%d)\n",
> +			err);
> +		return err;
> +	}
> +
> +	if (enable) {
> +		qcom_ice_low_power_mode_enable(ice);
> +		qcom_ice_optimization_enable(ice);
> +	}
> +
> +	err = qcom_ice_wait_bist_status(ice);
> +	if (err) {
> +		dev_err(dev, "BIST status error (%d)\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}

The 'enable' parameter is confusing.  Maybe call it 'enable_optimizations'?

> +
> +int qcom_ice_program_key(struct qcom_ice *ice, u8 crypto_cap_idx,
> +			 u8 algorithm_id, u8 key_size,
> +			 const u8 crypto_key[], u8 data_unit_size,
> +			 int slot)
> +{
> +	struct device *dev;
> +	union {
> +		u8 bytes[AES_256_XTS_KEY_SIZE];
> +		u32 words[AES_256_XTS_KEY_SIZE / sizeof(u32)];
> +	} key;
> +	int i;
> +	int err;
> +
> +	dev = ice->dev;

Nit: declare and initialize 'dev' on the same line.

> +static struct qcom_ice *qcom_ice_create(struct platform_device *pdev, void __iomem *base)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct qcom_ice *engine;
> +
> +	if (!qcom_scm_is_available())
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	if (!qcom_scm_ice_available()) {
> +		dev_warn(dev, "ICE SCM interface not found\n");
> +		return NULL;
> +	}
> +
> +	engine = devm_kzalloc(dev, sizeof(*engine), GFP_KERNEL);
> +	if (!engine)
> +		return ERR_PTR(-ENOMEM);
> +
> +	engine->dev = &pdev->dev;
> +	engine->np = np;
> +	engine->base = base;
> +
> +	engine->core_clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(engine->core_clk))
> +		return ERR_CAST(engine->core_clk);
> +
> +	if (!qcom_ice_check_supported(engine))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	dev_info(dev, "Registered Qualcomm Inline Crypto Engine\n");
> +
> +	return engine;

Shouldn't the !qcom_scm_is_available() and !qcom_ice_check_supported() cases
have the same return value?  Both mean not supported, right?

And shouldn't it be NULL, not ERR_PTR(-EOPNOTSUPP), so that the caller doesn't
fail to probe the host controller just because ICE is not supported?

> diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
> new file mode 100644
> index 000000000000..d4644c9f1bcd
> --- /dev/null
> +++ b/include/soc/qcom/ice.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#ifndef __QCOM_ICE_H__
> +#define __QCOM_ICE_H__
> +
> +#include <linux/err.h>

<linux/types.h> would be more appropriate here, I think.

> +
> +#if IS_ENABLED(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)

This #if does not appear to be necessary.

> +int qcom_ice_enable(struct qcom_ice *ice);
> +int qcom_ice_resume(struct qcom_ice *ice);
> +int qcom_ice_suspend(struct qcom_ice *ice);
> +struct qcom_ice *of_qcom_ice_get(struct device *dev);
> +int qcom_ice_program_key(struct qcom_ice *ice, u8 crypto_cap_idx,
> +			 u8 algorithm_id, u8 key_size,
> +			 const u8 crypto_key[], u8 data_unit_size,
> +			 int slot);

The crypto_cap_idx parameter is unused and should be removed.

> +int qcom_ice_evict_key(struct qcom_ice *ice, int slot);

Nit: these declarations are in a slightly different order from the definitions
in the .c file.

- Eric
