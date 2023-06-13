Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ABC72E902
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbjFMRH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjFMRHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:07:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825F5EA;
        Tue, 13 Jun 2023 10:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1580962DCC;
        Tue, 13 Jun 2023 17:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8635C433D9;
        Tue, 13 Jun 2023 17:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686676067;
        bh=4tym3mpNouiPVG5YMxQ5NCtxU3PD6kbHD3sozEQml+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNAOh7T1PonBAOB+B4XvjkRMB3sP3gr0SqsmZRZukoj0fTn61v9yJiekaPko426fh
         Z+J+RLqQjuhR0eaMIUrYqdVy1n/XVRDdrZnjjaZl+BIkl7hbqQLCdtcu3OiB2KPj5y
         fqXoXdLE2QsjBJZpaL5q5IrTetcE00PnB+I2iXxFXfsCSMmjTb/cNi+pvL8V08irfO
         csV3h8MLn6Y3GbA5VWI9UDAo4OSQEAexppSo24Xs1dO2NciOs9wtaMD6Ezevrx8gx6
         fsm4dbFXq7U1BU+0SiKmDgW80T06VfWZ6ZgUP5gwry3gb+a9c1o4KKcQ5tOrnpU0MV
         lbWhYBVzIIbCg==
Date:   Tue, 13 Jun 2023 10:11:10 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 06/10] soc: qcom: Add LLCC support for multi channel
 DDR
Message-ID: <20230613171110.ud2ybjpoxnwwflce@ripper>
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
 <20230512122134.24339-7-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512122134.24339-7-quic_kbajaj@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 05:51:30PM +0530, Komal Bajaj wrote:
> Add LLCC support for multi channel DDR configuration
> based on a feature register.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  drivers/soc/qcom/llcc-qcom.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 6cf373da5df9..1da337e7a378 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -12,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> @@ -943,6 +944,19 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev,
>  	return ret;
>  }
> 
> +static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u8 *cfg_index)
> +{
> +	int ret = 0;

First use is an assignment, no need to initialize here.

> +
> +	ret = nvmem_cell_read_u8(&pdev->dev, "multi_chan_ddr", cfg_index);
> +	if (ret == -ENOENT) {
> +		*cfg_index = 0;

Does nvmem_cell_read_u8() cahnge cfg_index when it fails with -ENOENT?

> +		return 0;
> +	}
> +
> +	return ret;
> +}
> +
>  static int qcom_llcc_remove(struct platform_device *pdev)
>  {
>  	/* Set the global pointer to a error code to avoid referencing it */
> @@ -975,11 +989,13 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	int ret, i;
>  	struct platform_device *llcc_edac;
> -	const struct qcom_llcc_config *cfg;
> +	const struct qcom_llcc_config *cfg, *entry;
>  	const struct llcc_slice_config *llcc_cfg;
>  	u32 sz;
> +	u8 cfg_index;
>  	u32 version;
>  	struct regmap *regmap;
> +	u32 num_entries = 0;
> 
>  	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
>  	if (!drv_data) {
> @@ -1040,8 +1056,18 @@ static int qcom_llcc_probe(struct platform_device *pdev)
> 
>  	drv_data->version = version;
> 
> -	llcc_cfg = cfg[0]->sct_data;
> -	sz = cfg[0]->size;
> +	ret = qcom_llcc_get_cfg_index(pdev, &cfg_index);
> +	if (ret)
> +		goto err;
> +
> +	for (entry = cfg; entry->sct_data; entry++, num_entries++);

This is not readable, move the increment of num_entries out of there.

> +	if (cfg_index >= num_entries || cfg_index < 0) {

How can cfg_index be negative?

Regards,
Bjorn

> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	llcc_cfg = cfg[cfg_index].sct_data;
> +	sz = cfg[cfg_index].size;
> 
>  	for (i = 0; i < sz; i++)
>  		if (llcc_cfg[i].slice_id > drv_data->max_slices)
> --
> 2.17.1
> 
