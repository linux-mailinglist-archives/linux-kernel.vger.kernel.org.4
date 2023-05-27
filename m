Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC28F713676
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 22:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjE0Uqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 16:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjE0Uqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 16:46:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C40CB1;
        Sat, 27 May 2023 13:46:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38B22615BC;
        Sat, 27 May 2023 20:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6919C4339C;
        Sat, 27 May 2023 20:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685220405;
        bh=D2oC4HfjT26KTZWAe8gA/JRbJNuOnSYmnk26i/r7Fdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aTHU86AiAZEdXrNyZKQm5Wky7BSpOHYGKfV1K7/pAJxTmad48pKjiG/NXeAokNVm5
         1mNuF5FC2Toue8P8MBkVYXQK08awDsVwtN7uYwhFO3w4BOwuG7xBgD/Qkvkh0wlJDO
         F2jNlnFoFw4r9ue8K6x0RyuQFBQL/NTyykPhFeXoPkAJGuRNC3jEwrzkMDnM39WJer
         oZzyfnnbTyVZCBGrR/AiSxtPoQ/1aGd1VbZEbsaME10o3F8pplnsDWzdGVbmK2axEe
         pZYlIZJ4YPN4ZQRYnpY6f+BPuGpizpZiIEgfJHYuwAuHM7ikYfRk/Lr0gMRr7vberJ
         6I1S1ecjLE1Uw==
Date:   Sat, 27 May 2023 13:50:31 -0700
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
Subject: Re: [PATCH v3 01/10] nvmem: qfprom: Add support for secure reading
Message-ID: <20230527205031.iwsujvlbxazukwfy@ripper>
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
 <20230512122134.24339-2-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512122134.24339-2-quic_kbajaj@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 05:51:25PM +0530, Komal Bajaj wrote:
> For some of the Qualcomm SoC's, it is possible that
> some of the fuse regions or entire qfprom region is
> protected from non-secure access. In such situations,
> linux will have to use secure calls to read the region.
> With that motivation, add the support of reading secure
> regions in qfprom driver. Ensuring the address to read
> is word aligned since our secure I/O only supports word
> size I/O.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  drivers/nvmem/Kconfig  |  1 +
>  drivers/nvmem/qfprom.c | 69 +++++++++++++++++++++++++++++++++---------
>  2 files changed, 55 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index b291b27048c7..3d896ba29b89 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -209,6 +209,7 @@ config NVMEM_QCOM_QFPROM
>  	tristate "QCOM QFPROM Support"
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on HAS_IOMEM
> +	select QCOM_SCM
>  	help
>  	  Say y here to enable QFPROM support. The QFPROM provides access
>  	  functions for QFPROM data to rest of the drivers via nvmem interface.
> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> index c1e893c8a247..20662e2d3732 100644
> --- a/drivers/nvmem/qfprom.c
> +++ b/drivers/nvmem/qfprom.c
> @@ -16,6 +16,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
> 
>  /* Blow timer clock frequency in Mhz */
>  #define QFPROM_BLOW_TIMER_OFFSET 0x03c
> @@ -59,21 +60,22 @@ struct qfprom_soc_data {
>  /**
>   * struct qfprom_priv - structure holding qfprom attributes
>   *
> - * @qfpraw:       iomapped memory space for qfprom-efuse raw address space.
> - * @qfpconf:      iomapped memory space for qfprom-efuse configuration address
> - *                space.
> + * @qfpraw: iomapped memory space for qfprom-efuse raw address space.
> + * @qfpconf: iomapped memory space for qfprom-efuse configuration address space.

Adjusting the indentation makes it unnecessarily hard to see what you
actually changed.

>   * @qfpcorrected: iomapped memory space for qfprom corrected address space.
> - * @qfpsecurity:  iomapped memory space for qfprom security control space.
> - * @dev:          qfprom device structure.
> - * @secclk:       Clock supply.
> - * @vcc:          Regulator supply.
> - * @soc_data:     Data that for things that varies from SoC to SoC.
> + * @qfpsecurity: iomapped memory space for qfprom security control space.
> + * @qfpseccorrected: starting physical address for qfprom secure corrected address space.
> + * @dev: qfprom device structure.
> + * @secclk: Clock supply.
> + * @vcc: Regulator supply.
> + * @soc_data: Data that for things that varies from SoC to SoC.
>   */
>  struct qfprom_priv {
>  	void __iomem *qfpraw;
>  	void __iomem *qfpconf;
>  	void __iomem *qfpcorrected;
>  	void __iomem *qfpsecurity;
> +	phys_addr_t qfpseccorrected;
>  	struct device *dev;
>  	struct clk *secclk;
>  	struct regulator *vcc;
> @@ -99,10 +101,12 @@ struct qfprom_touched_values {
>   *
>   * @keepout: Array of keepout regions for this SoC.
>   * @nkeepout: Number of elements in the keepout array.
> + * @secure: Is qfprom region for this SoC protected from non-secure access.
>   */
>  struct qfprom_soc_compatible_data {
>  	const struct nvmem_keepout *keepout;
>  	unsigned int nkeepout;
> +	bool secure;
>  };
> 
>  static const struct nvmem_keepout sc7180_qfprom_keepout[] = {
> @@ -334,6 +338,34 @@ static int qfprom_reg_read(void *context,
>  	return 0;
>  }
> 
> +static int qfprom_sec_reg_read(void *context, unsigned int reg, void *_val, size_t bytes)
> +{
> +	struct qfprom_priv *priv = context;
> +	u8 *val = _val;
> +	int buf_start, buf_end, index, i = 0;
> +	char *buffer;
> +	u32 read_val;
> +
> +	buf_start = ALIGN_DOWN(reg, 4);
> +	buf_end = ALIGN(reg + bytes, 4);
> +	buffer = kzalloc(buf_end - buf_start, GFP_KERNEL);
> +	if (!buffer)
> +		return -ENOMEM;

I don't you need all these variables, the full temp buffer or the two
memcpy... I think something like this should do the trick:

	unsigned int i;
	u8 *val = _val;
	u8 tmp[4];

	for (i = 0; i < bytes; i++, reg++)
		if (i == 0 || reg % 4 == 0)
			qcom_scm_io_readl(qfpseccorrected + (reg & ~3), tmp);

		val[i] = tmp[reg & 3];
	}

> +
> +	for (index = buf_start; index < buf_end; index += 4, i += 4) {
> +		if (qcom_scm_io_readl(priv->qfpseccorrected + index, &read_val)) {
> +			dev_err(priv->dev, "Couldn't access feature register\n");

What's a "feature register"?

Regards,
Bjorn

> +			kfree_sensitive(buffer);
> +			return -EINVAL;
> +		}
> +		memcpy(buffer + i, &read_val, 4);
> +	}
> +
> +	memcpy(val, buffer + reg % 4, bytes);
> +	kfree_sensitive(buffer);
> +	return 0;
> +}
> +
>  static void qfprom_runtime_disable(void *data)
>  {
>  	pm_runtime_disable(data);
> @@ -373,13 +405,6 @@ static int qfprom_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
> 
> -	/* The corrected section is always provided */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->qfpcorrected = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(priv->qfpcorrected))
> -		return PTR_ERR(priv->qfpcorrected);
> -
> -	econfig.size = resource_size(res);
>  	econfig.dev = dev;
>  	econfig.priv = priv;
> 
> @@ -390,6 +415,20 @@ static int qfprom_probe(struct platform_device *pdev)
>  		econfig.nkeepout = soc_data->nkeepout;
>  	}
> 
> +	/* The corrected section is always provided */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	if (soc_data && soc_data->secure) {
> +		priv->qfpseccorrected = res->start;
> +		econfig.reg_read = qfprom_sec_reg_read;
> +	} else {
> +		priv->qfpcorrected = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(priv->qfpcorrected))
> +			return PTR_ERR(priv->qfpcorrected);
> +	}
> +
> +	econfig.size = resource_size(res);
> +
>  	/*
>  	 * If more than one region is provided then the OS has the ability
>  	 * to write.
> --
> 2.17.1
> 
