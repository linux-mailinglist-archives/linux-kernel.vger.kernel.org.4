Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7546DA89A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 07:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjDGFwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 01:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDGFwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 01:52:13 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C168E2101
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 22:52:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l26-20020a05600c1d1a00b003edd24054e0so307693wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 22:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680846730; x=1683438730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N85jrvvXyD9fHkvKb/3/oJj/HF/PifZiFmuCM3M4Pjs=;
        b=u1TFdX7fv7gXqeGkS3FZ2pijuds6NGsuWOLE0kxlwH4A+do7EIvSpEPydBGmUAULUD
         goa8zLGLVsSrq8EAIe6uU0vK5DwX7CGApuDjIv4khw5cQujK8O9YIbQubWB1pHqqb9HX
         jQGy0jhiHHKj+L0ENBNgni8H6kphMJ8qJ0oesw10CFn3UoZIJiBBKwB6nVjTvVmz5WUu
         ZoxyYm+MGM6skYk+0ZdH8pMGu0Zcf3RJ3t9kvVr0n+72igx0qkjak6+OhhmnQI+g2tis
         tFRpKyrew5jTsI4Uv2se4DHQg999JrITI9bipdgG+3Q6hkGq8tpTRpfzO1Wc7roprM00
         z45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680846730; x=1683438730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N85jrvvXyD9fHkvKb/3/oJj/HF/PifZiFmuCM3M4Pjs=;
        b=Vf5Fa9GabdCkEraHu+ceMGSJZBcAZWR5w8QprQbvRtimYbztxzoq8+rT04hawWTkyx
         mivyRvIkecdD7qECerMzKX4E/2JiSQCvL0agSeePISjO5a1j0R0Q6phQ+VeZtrduBiAK
         Q6fg65rm+q9ga84lXEgQHlZxmrqNCVC/M1GwJ9Jrx7NUoIiwu1GEa2ycuIWG4+VGRATD
         VY2PIHRn1br50JuLBIYNdRKJRTosEZrjo5076s8UMNxmpv1u6aQ7RoGQNy+Wfxw+okkt
         c0d+qOI699g3XNaJYBmmao/rmylKD6JtfDdUNUJDcy3wAnuD5+KaCWbVk0wUhA+59bvW
         ojxA==
X-Gm-Message-State: AAQBX9euGI/w2EHAHECpHNWaKfx3TKeoPbxuSDgdwRTt3i+1MxbfXB+m
        SpzwFS1UIyfHtJughzhSQEK+rQ==
X-Google-Smtp-Source: AKy350ZGeZWg3kfEOsRAKHRLRfqytP+ssITGSZmZoPdlv66cizXKdo8hN4eDF/FYbjn+3KPWlPsbfg==
X-Received: by 2002:a7b:ce99:0:b0:3ef:672a:2c93 with SMTP id q25-20020a7bce99000000b003ef672a2c93mr363926wmj.36.1680846730106;
        Thu, 06 Apr 2023 22:52:10 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id y10-20020a7bcd8a000000b003e203681b26sm3421659wmj.29.2023.04.06.22.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 22:52:09 -0700 (PDT)
Date:   Fri, 7 Apr 2023 08:52:08 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] soc: qcom: llcc: Refactor llcc driver to support
 multiple configuration
Message-ID: <ZC+viDZTelCJiuBJ@linaro.org>
References: <20230313124040.9463-1-quic_kbajaj@quicinc.com>
 <20230313124040.9463-2-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313124040.9463-2-quic_kbajaj@quicinc.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-13 18:10:36, Komal Bajaj wrote:
> Refactor driver to support multiple configuration for llcc on a target.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>

LGTM.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/soc/qcom/llcc-qcom.c | 191 ++++++++++++++++++++---------------
>  1 file changed, 112 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 23ce2f78c4ed..00699a0c047e 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -416,92 +416,125 @@ static const u32 llcc_v2_1_reg_offset[] = {
>  	[LLCC_COMMON_STATUS0]	= 0x0003400c,
>  };
>  
> -static const struct qcom_llcc_config sc7180_cfg = {
> -	.sct_data	= sc7180_data,
> -	.size		= ARRAY_SIZE(sc7180_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_llcc_config sc7180_cfg[] = {
> +	{
> +		.sct_data	= sc7180_data,
> +		.size		= ARRAY_SIZE(sc7180_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
> +	{ },
>  };
>  
> -static const struct qcom_llcc_config sc7280_cfg = {
> -	.sct_data	= sc7280_data,
> -	.size		= ARRAY_SIZE(sc7280_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_llcc_config sc7280_cfg[] = {
> +	{
> +		.sct_data	= sc7280_data,
> +		.size		= ARRAY_SIZE(sc7280_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
> +	{ },
>  };
>  
> -static const struct qcom_llcc_config sc8180x_cfg = {
> -	.sct_data	= sc8180x_data,
> -	.size		= ARRAY_SIZE(sc8180x_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_llcc_config sc8180x_cfg[] = {
> +	{
> +		.sct_data	= sc8180x_data,
> +		.size		= ARRAY_SIZE(sc8180x_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
> +	{ },
>  };
>  
> -static const struct qcom_llcc_config sc8280xp_cfg = {
> -	.sct_data	= sc8280xp_data,
> -	.size		= ARRAY_SIZE(sc8280xp_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_llcc_config sc8280xp_cfg[] = {
> +	{
> +		.sct_data	= sc8280xp_data,
> +		.size		= ARRAY_SIZE(sc8280xp_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
> +	{ },
>  };
>  
> -static const struct qcom_llcc_config sdm845_cfg = {
> -	.sct_data	= sdm845_data,
> -	.size		= ARRAY_SIZE(sdm845_data),
> -	.need_llcc_cfg	= false,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_llcc_config sdm845_cfg[] = {
> +	{
> +		.sct_data	= sdm845_data,
> +		.size		= ARRAY_SIZE(sdm845_data),
> +		.need_llcc_cfg	= false,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
> +	{ },
>  };
>  
> -static const struct qcom_llcc_config sm6350_cfg = {
> -	.sct_data	= sm6350_data,
> -	.size		= ARRAY_SIZE(sm6350_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_llcc_config sm6350_cfg[] = {
> +	{
> +		.sct_data	= sm6350_data,
> +		.size		= ARRAY_SIZE(sm6350_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
> +	{ },
>  };
>  
> -static const struct qcom_llcc_config sm8150_cfg = {
> -	.sct_data       = sm8150_data,
> -	.size           = ARRAY_SIZE(sm8150_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_llcc_config sm8150_cfg[] = {
> +	{
> +		.sct_data       = sm8150_data,
> +		.size           = ARRAY_SIZE(sm8150_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
> +	{ },
>  };
>  
> -static const struct qcom_llcc_config sm8250_cfg = {
> -	.sct_data       = sm8250_data,
> -	.size           = ARRAY_SIZE(sm8250_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_llcc_config sm8250_cfg[] = {
> +	{
> +		.sct_data       = sm8250_data,
> +		.size           = ARRAY_SIZE(sm8250_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
> +	{ },
>  };
>  
> -static const struct qcom_llcc_config sm8350_cfg = {
> -	.sct_data       = sm8350_data,
> -	.size           = ARRAY_SIZE(sm8350_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v1_reg_offset,
> -	.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +static const struct qcom_llcc_config sm8350_cfg[] = {
> +	{
> +		.sct_data       = sm8350_data,
> +		.size           = ARRAY_SIZE(sm8350_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v1_reg_offset,
> +		.edac_reg_offset = &llcc_v1_edac_reg_offset,
> +	},
> +	{ },
>  };
>  
> -static const struct qcom_llcc_config sm8450_cfg = {
> -	.sct_data       = sm8450_data,
> -	.size           = ARRAY_SIZE(sm8450_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v2_1_reg_offset,
> -	.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +static const struct qcom_llcc_config sm8450_cfg[] = {
> +	{
> +		.sct_data       = sm8450_data,
> +		.size           = ARRAY_SIZE(sm8450_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v2_1_reg_offset,
> +		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +	},
> +	{ },
>  };
>  
> -static const struct qcom_llcc_config sm8550_cfg = {
> -	.sct_data       = sm8550_data,
> -	.size           = ARRAY_SIZE(sm8550_data),
> -	.need_llcc_cfg	= true,
> -	.reg_offset	= llcc_v2_1_reg_offset,
> -	.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +static const struct qcom_llcc_config sm8550_cfg[] = {
> +	{
> +		.sct_data       = sm8550_data,
> +		.size           = ARRAY_SIZE(sm8550_data),
> +		.need_llcc_cfg	= true,
> +		.reg_offset	= llcc_v2_1_reg_offset,
> +		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +	},
> +	{ },
>  };
>  
>  static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
> @@ -966,8 +999,8 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  	num_banks >>= LLCC_LB_CNT_SHIFT;
>  	drv_data->num_banks = num_banks;
>  
> -	llcc_cfg = cfg->sct_data;
> -	sz = cfg->size;
> +	llcc_cfg = cfg[0].sct_data;
> +	sz = cfg[0].size;
>  
>  	for (i = 0; i < sz; i++)
>  		if (llcc_cfg[i].slice_id > drv_data->max_slices)
> @@ -1016,17 +1049,17 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id qcom_llcc_of_match[] = {
> -	{ .compatible = "qcom,sc7180-llcc", .data = &sc7180_cfg },
> -	{ .compatible = "qcom,sc7280-llcc", .data = &sc7280_cfg },
> -	{ .compatible = "qcom,sc8180x-llcc", .data = &sc8180x_cfg },
> -	{ .compatible = "qcom,sc8280xp-llcc", .data = &sc8280xp_cfg },
> -	{ .compatible = "qcom,sdm845-llcc", .data = &sdm845_cfg },
> -	{ .compatible = "qcom,sm6350-llcc", .data = &sm6350_cfg },
> -	{ .compatible = "qcom,sm8150-llcc", .data = &sm8150_cfg },
> -	{ .compatible = "qcom,sm8250-llcc", .data = &sm8250_cfg },
> -	{ .compatible = "qcom,sm8350-llcc", .data = &sm8350_cfg },
> -	{ .compatible = "qcom,sm8450-llcc", .data = &sm8450_cfg },
> -	{ .compatible = "qcom,sm8550-llcc", .data = &sm8550_cfg },
> +	{ .compatible = "qcom,sc7180-llcc", .data = sc7180_cfg },
> +	{ .compatible = "qcom,sc7280-llcc", .data = sc7280_cfg },
> +	{ .compatible = "qcom,sc8180x-llcc", .data = sc8180x_cfg },
> +	{ .compatible = "qcom,sc8280xp-llcc", .data = sc8280xp_cfg },
> +	{ .compatible = "qcom,sdm845-llcc", .data = sdm845_cfg },
> +	{ .compatible = "qcom,sm6350-llcc", .data = sm6350_cfg },
> +	{ .compatible = "qcom,sm8150-llcc", .data = sm8150_cfg },
> +	{ .compatible = "qcom,sm8250-llcc", .data = sm8250_cfg },
> +	{ .compatible = "qcom,sm8350-llcc", .data = sm8350_cfg },
> +	{ .compatible = "qcom,sm8450-llcc", .data = sm8450_cfg },
> +	{ .compatible = "qcom,sm8550-llcc", .data = sm8550_cfg },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, qcom_llcc_of_match);
> -- 
> 2.39.1
> 
