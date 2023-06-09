Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F26729402
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbjFIJAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbjFII7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:59:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2302E4211;
        Fri,  9 Jun 2023 01:58:41 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 34FB66606F1D;
        Fri,  9 Jun 2023 09:58:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686301119;
        bh=v/JdB+WJ+9dqXMcQEztInK7JcbHhmK32bd12IwZ2XZ8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ISgHSdGDTZht+Ps3nFiTgRpH+EaXVLVnGhe24ABfj2hoAOaSXBkGzXnlQHg7qdDoh
         kPzn2oDAQiy8haBmBpnF/to1QyKJ0GmNIf70PEtL5/4xnYlZ0bnIxCFXNZDQUkXPWC
         I595ilSykteItF+2cG4lWJD8WWXEar1wtbR1z8iTKj/XDkjxz8YNri3ZHuKUB9xyyj
         ZSO3W2TEOSXK4B/spCZsLQIG/ffnubKLnZXOd9XmC4683+lHWxEAOujRtsAHRzLtfB
         2YUKltfgutIkGl7l+jZQvtYipOyz4DPeyFC7dvVUU64fPuPymhx5G3JVJ/GfQYebFM
         Q3MVP8q6uvHoQ==
Message-ID: <07816a63-0d54-aced-a109-209c446f6bfa@collabora.com>
Date:   Fri, 9 Jun 2023 10:58:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/9] regulator: mt6358: Merge VCN33_* regulators
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230609083009.2822259-1-wenst@chromium.org>
 <20230609083009.2822259-4-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230609083009.2822259-4-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/06/23 10:30, Chen-Yu Tsai ha scritto:
> The VCN33_BT and VCN33_WIFI regulators are actually the same regulator,
> having the same voltage setting and output pin. There are simply two
> enable bits that are ORed together to enable the regulator.
> 
> Having two regulators representing the same output pin is misleading
> from a design matching standpoint, and also error-prone in driver
> implementations. If consumers try to set different voltages on either
> regulator, the one set later would override the one set before. There
> are ways around this, such as chaining them together and having the
> downstream one act as a switch. But given there's only one output pin,
> such a workaround doesn't match reality.
> 
> Remove the VCN33_WIFI regulator. During the probe phase, have the driver
> sync the enable status of VCN33_WIFI to VCN33_BT. Also drop the suffix
> so that the regulator name matches the pin name in the datasheet.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   drivers/regulator/mt6358-regulator.c       | 65 +++++++++++++++++-----
>   include/linux/regulator/mt6358-regulator.h |  6 +-
>   2 files changed, 52 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
> index c9e16bd092f6..faf6b0757019 100644
> --- a/drivers/regulator/mt6358-regulator.c
> +++ b/drivers/regulator/mt6358-regulator.c
> @@ -277,7 +277,7 @@ static const unsigned int vcama_voltages[] = {
>   	2800000, 2900000, 3000000,
>   };
>   
> -static const unsigned int vcn33_bt_wifi_voltages[] = {
> +static const unsigned int vcn33_voltages[] = {
>   	3300000, 3400000, 3500000,
>   };
>   
> @@ -321,7 +321,7 @@ static const u32 vcama_idx[] = {
>   	0, 7, 9, 10, 11, 12,
>   };
>   
> -static const u32 vcn33_bt_wifi_idx[] = {
> +static const u32 vcn33_idx[] = {
>   	1, 2, 3,
>   };
>   
> @@ -566,12 +566,8 @@ static struct mt6358_regulator_info mt6358_regulators[] = {
>   		   MT6358_LDO_VCAMA1_CON0, 0, MT6358_VCAMA1_ANA_CON0, 0xf00),
>   	MT6358_LDO("ldo_vemc", VEMC, vmch_vemc_voltages, vmch_vemc_idx,
>   		   MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700),
> -	MT6358_LDO("ldo_vcn33_bt", VCN33_BT, vcn33_bt_wifi_voltages,
> -		   vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_0,
> -		   0, MT6358_VCN33_ANA_CON0, 0x300),
> -	MT6358_LDO("ldo_vcn33_wifi", VCN33_WIFI, vcn33_bt_wifi_voltages,
> -		   vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_1,
> -		   0, MT6358_VCN33_ANA_CON0, 0x300),
> +	MT6358_LDO("ldo_vcn33", VCN33, vcn33_voltages, vcn33_idx,
> +		   MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0x300),
>   	MT6358_LDO("ldo_vcama2", VCAMA2, vcama_voltages, vcama_idx,
>   		   MT6358_LDO_VCAMA2_CON0, 0, MT6358_VCAMA2_ANA_CON0, 0xf00),
>   	MT6358_LDO("ldo_vmc", VMC, vmc_voltages, vmc_idx,
> @@ -662,12 +658,8 @@ static struct mt6358_regulator_info mt6366_regulators[] = {
>   		   MT6358_LDO_VMCH_CON0, 0, MT6358_VMCH_ANA_CON0, 0x700),
>   	MT6366_LDO("ldo_vemc", VEMC, vmch_vemc_voltages, vmch_vemc_idx,
>   		   MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700),
> -	MT6366_LDO("ldo_vcn33_bt", VCN33_BT, vcn33_bt_wifi_voltages,
> -		   vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_0,
> -		   0, MT6358_VCN33_ANA_CON0, 0x300),
> -	MT6366_LDO("ldo_vcn33_wifi", VCN33_WIFI, vcn33_bt_wifi_voltages,
> -		   vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_1,
> -		   0, MT6358_VCN33_ANA_CON0, 0x300),
> +	MT6366_LDO("ldo_vcn33", VCN33, vcn33_voltages, vcn33_idx,
> +		   MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0x300),
>   	MT6366_LDO("ldo_vmc", VMC, vmc_voltages, vmc_idx,
>   		   MT6358_LDO_VMC_CON0, 0, MT6358_VMC_ANA_CON0, 0xf00),
>   	MT6366_LDO("ldo_vsim2", VSIM2, vsim_voltages, vsim_idx,
> @@ -690,13 +682,56 @@ static struct mt6358_regulator_info mt6366_regulators[] = {
>   		    MT6358_LDO_VSRAM_CON1, 0x7f),
>   };
>   
> +static int mt6358_sync_vcn33_setting(struct device *dev)
> +{
> +	struct mt6397_chip *mt6397 = dev_get_drvdata(dev->parent);
> +	unsigned int val;
> +	int ret;
> +
> +	/*
> +	 * VCN33_WIFI and VCN33_BT are two separate enable bits for the same
> +	 * regulator. They share the same voltage setting and output pin.
> +	 * Instead of having two potentially conflicting regulators, just have
> +	 * one VCN33 regulator. Sync the two enable bits and only use one in
> +	 * the regulator device.
> +	 */
> +	ret = regmap_read(mt6397->regmap, MT6358_LDO_VCN33_CON0_1, &val);
> +	if (ret) {
> +		dev_err(dev, "Failed to read VCN33_WIFI setting\n");
> +		return ret;
> +	}
> +
> +	if (!(val & BIT(0)))
> +		return 0;
> +
> +	/* Sync VCN33_WIFI enable status to VCN33_BT */
> +	ret = regmap_update_bits(mt6397->regmap, MT6358_LDO_VCN33_CON0_0, BIT(0), BIT(0));
> +	if (ret) {
> +		dev_err(dev, "Failed to sync VCN33_WIFI setting to VCN33_BT\n");
> +		return ret;
> +	}
> +
> +	/* Disable VCN33_WIFI */
> +	ret = regmap_update_bits(mt6397->regmap, MT6358_LDO_VCN33_CON0_1, BIT(0), 0);
> +	if (ret) {
> +		dev_err(dev, "Failed to disable VCN33_BT\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   static int mt6358_regulator_probe(struct platform_device *pdev)
>   {
>   	struct mt6397_chip *mt6397 = dev_get_drvdata(pdev->dev.parent);
>   	struct regulator_config config = {};
>   	struct regulator_dev *rdev;
>   	struct mt6358_regulator_info *mt6358_info;
> -	int i, max_regulator;
> +	int i, max_regulator, ret;
> +
> +	ret = mt6358_sync_vcn33_setting(&pdev->dev);
> +	if (ret)
> +		return ret;

I'd put this after the chip_id check, and I would also add a safety check for
that...

	switch (mt6397->chip_id) {
	case MT6366_CHIP_ID:
		max_regulator = MT6366_MAX_REGULATOR;
		mt6358_info = mt6366_regulators;
		break;
	case MT6358_CHIP_ID:
		max_regulator = MT6358_MAX_REGULATOR;
		mt6358_info = mt6358_regulators;
		break;
	default:
		return -EINVAL;
	}

	ret = mt6358_sync_vcn33_setting(....)

...but I agree with your point here about this being a strange design and
also with your way of fixing the driver.

Regards,
Angelo
