Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC7D6BB585
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjCOOIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjCOOIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:08:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90717DB5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:08:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id y2so18934023pjg.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678889297;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tE9TM9jIe+wBA1tLudHncoReuU8nCE7h9AdsVHA82YI=;
        b=cO5srOsIzfpsYma6JL9MAPcLaqdXlgxTPNHC2gNW4HMWkJ+b0t7bE8jN7u8It2bREr
         5yWjZ3MR/7BvNw5A7qgyY5w9fpUqyieQKMk4IlULj6kcQgR9JscMf5jzIQZe0znN2p/1
         +0opCgVT7c4jGLbne1S9G5eJvsNT1tUHZH8nfbpAJLfZvDdSrqEDGXvDmkrBJnFnyoby
         sisbOoS61HcXDx+0+XtueMk/ExNOWW72z1Zarmr2RP7o7Dor6HAPfnw2v4nede4K1hUs
         0SCJy5bqJt3Hnak1Rm0dbyggLxZTdG2vOkB80jgWfVMRrE8FEgT4X4IoIHfyuLUD0B+4
         DiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678889297;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tE9TM9jIe+wBA1tLudHncoReuU8nCE7h9AdsVHA82YI=;
        b=FThFcNUfwasYJIY6x0SL4UPA0Ve4x3mB5x3ESe/WOrhxiGKyXUrnEuJwysmEfCsNV/
         eY9hfJy9BBra6OdviPB0opbvM5rHS/o1VogtxUwRbpZ52tz+F/Dz7HkSx6X3lN+1iGmF
         hLevmMaDf6ojijRVHdLEQR95AfGA0IldEin/jCEdeHGP3471XuC6mfr3+ov2x1P7Wwd2
         QMELRM4opq8ySMN4Uo6N6qWr9emDcJDy6phYz1K8so3yx2EPNWI+J/D/3mbBOTl78n4T
         5T6NrNs1Wz4xBGqfZfkaIV+16VQyhmYobYqAgQwS7ZM3P7d4t+Ytz98NAmiZzoIgsdRa
         n7ZQ==
X-Gm-Message-State: AO0yUKV3auYX/Fu2+sVhlHc6QA+3TSpP+nKKmGwGjU98HLGCFTUBykiE
        eqgQxxI3lO4DLjxMQupcKMaP
X-Google-Smtp-Source: AK7set/ylWfVr/jYohN6EqLAANVvgvAQvjOnGOawVQuQ0mI04OheMkj8yVAvzIAc0yKpQPQIXa44pA==
X-Received: by 2002:a17:90b:390f:b0:23d:44c6:745a with SMTP id ob15-20020a17090b390f00b0023d44c6745amr35425pjb.2.1678889297231;
        Wed, 15 Mar 2023 07:08:17 -0700 (PDT)
Received: from thinkpad ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id ch7-20020a17090af40700b0023cd53e7706sm1425037pjb.47.2023.03.15.07.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:08:16 -0700 (PDT)
Date:   Wed, 15 Mar 2023 19:38:07 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 4/5] soc: qcom: Add LLCC support for multi channel DDR
Message-ID: <20230315140807.GB98488@thinkpad>
References: <20230313124040.9463-1-quic_kbajaj@quicinc.com>
 <20230313124040.9463-5-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230313124040.9463-5-quic_kbajaj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 06:10:39PM +0530, Komal Bajaj wrote:
> Add LLCC support for multi channel DDR configurations
> based off of a feature register.
> 

Please elaborate more in the commit message on why this patch is needed and how
it is implemented.

> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  drivers/soc/qcom/llcc-qcom.c       | 56 ++++++++++++++++++++++++++++--
>  include/linux/soc/qcom/llcc-qcom.h |  2 ++
>  2 files changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 00699a0c047e..f4d3e266c629 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -17,6 +17,7 @@
>  #include <linux/regmap.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> +#include <linux/firmware/qcom/qcom_scm.h>

Sort the includes alphabetically

>  #include <linux/soc/qcom/llcc-qcom.h>
>  
>  #define ACTIVATE                      BIT(0)
> @@ -924,6 +925,40 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u32 *cfg_index)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *ch_res = NULL;

No need to initialize the pointer

> +

No need of a newline

> +	u32 ch_reg_sz;
> +	u32 ch_reg_off;
> +	u32 val;
> +	int ret = 0;
> +
> +	ch_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "multi_channel_register");
> +	if (ch_res) {
> +		if (of_property_read_u32(dev->of_node, "multi-ch-bit-off", &ch_reg_off)) {
> +			dev_err(&pdev->dev,
> +				"Couldn't get offset for multi channel feature register\n");
> +			return -ENODEV;
> +		}
> +		if (of_property_read_u32_index(dev->of_node, "multi-ch-bit-off", 1, &ch_reg_sz)) {
> +			dev_err(&pdev->dev,
> +				"Couldn't get size of multi channel feature register\n");
> +			return -ENODEV;
> +		}
> +
> +		if (qcom_scm_io_readl(ch_res->start, &val)) {

You didn't mention this SCM call in the commit message. Also, for SCM, you need
to select the driver in Kconfig. 

> +			dev_err(&pdev->dev, "Couldn't access multi channel feature register\n");
> +			ret = -EINVAL;

Catch the actual error no from qcom_scm_io_readl().

So in the case of failure, you still want to calculate cfg_index?

> +		}
> +		*cfg_index = (val >> ch_reg_off) & ((1 << ch_reg_sz) - 1);
> +	} else

Use braces for else condition

> +		*cfg_index = 0;
> +
> +	return ret;
> +}
> +
>  static int qcom_llcc_remove(struct platform_device *pdev)
>  {
>  	/* Set the global pointer to a error code to avoid referencing it */
> @@ -956,10 +991,13 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	int ret, i;
>  	struct platform_device *llcc_edac;
> -	const struct qcom_llcc_config *cfg;
> +	const struct qcom_llcc_config *cfg, *entry;
>  	const struct llcc_slice_config *llcc_cfg;
> +

No need of newline

>  	u32 sz;
> +	u32 cfg_index;
>  	u32 version;
> +	u32 no_of_entries = 0;

num_entries?

>  
>  	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
>  	if (!drv_data) {
> @@ -999,8 +1037,20 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  	num_banks >>= LLCC_LB_CNT_SHIFT;
>  	drv_data->num_banks = num_banks;
>  
> -	llcc_cfg = cfg[0].sct_data;
> -	sz = cfg[0].size;
> +	ret = qcom_llcc_get_cfg_index(pdev, &cfg_index);
> +	if (ret)
> +		goto err;
> +
> +	for (entry = cfg; entry->sct_data; entry++, no_of_entries++)
> +		;

Wrap ; in the above line itself

> +	if (cfg_index >= no_of_entries) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	drv_data->cfg_index = cfg_index;

Where is this cached value used?

Thanks,
Mani

> +	llcc_cfg = cfg[cfg_index].sct_data;
> +	sz = cfg[cfg_index].size;
>  
>  	for (i = 0; i < sz; i++)
>  		if (llcc_cfg[i].slice_id > drv_data->max_slices)
> diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
> index ad1fd718169d..225891a02f5d 100644
> --- a/include/linux/soc/qcom/llcc-qcom.h
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -125,6 +125,7 @@ struct llcc_edac_reg_offset {
>   * @cfg: pointer to the data structure for slice configuration
>   * @edac_reg_offset: Offset of the LLCC EDAC registers
>   * @lock: mutex associated with each slice
> + * @cfg_index: index of config table if multiple configs present for a target
>   * @cfg_size: size of the config data table
>   * @max_slices: max slices as read from device tree
>   * @num_banks: Number of llcc banks
> @@ -139,6 +140,7 @@ struct llcc_drv_data {
>  	const struct llcc_slice_config *cfg;
>  	const struct llcc_edac_reg_offset *edac_reg_offset;
>  	struct mutex lock;
> +	u32 cfg_index;
>  	u32 cfg_size;
>  	u32 max_slices;
>  	u32 num_banks;
> -- 
> 2.39.1
> 

-- 
மணிவண்ணன் சதாசிவம்
