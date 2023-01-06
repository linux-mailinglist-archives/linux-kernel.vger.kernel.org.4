Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC136605C9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjAFRjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjAFRjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:39:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FF87D9DB;
        Fri,  6 Jan 2023 09:39:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FD7461EEA;
        Fri,  6 Jan 2023 17:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C782BC433EF;
        Fri,  6 Jan 2023 17:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673026749;
        bh=9lYpIJ7urZJueAO54CHt0eT1xP3N1T1yp3v6HZ0ADNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h5p+UChZEbXLcG+vuuBe5NXZesdLSwOIoel6pLd0TOAJY56sTRhdYAP5GUZNQz4Kf
         QDj8NHkDlNXy3PFgQ3sSM5VD77x/X0tXJDd2+0S80RICDKQ+nda3cepNok4HRKH+I3
         qdyZiSyXVXqDQk9EVBIvzpF18IAUT8Qrf+4fcCq1hejvXMSjuI+e4jKod5qscWbDCD
         IRIwqE1Xy9h2ohvmBoPscSs+zVpl9JIrNsB08rYbaFiWhajBJru5AvY9PjdvbYi5eU
         oox/QhKPLa7bnH2nGPsPefwjkkxBKGsBY1pqesjXX3ziqtQEQh9iSh4L7bp42KUhLq
         so0PE2NRO5Pug==
Date:   Fri, 6 Jan 2023 11:39:06 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, quic_schowdhu@quicinc.com,
        agross@kernel.org, konrad.dybcio@linaro.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 2/2] usb: misc: eud: Add driver support for SM6115 /
 SM4250
Message-ID: <20230106173906.djdk5vbm4e4uz3wv@builder.lan>
References: <20230103150419.3923421-1-bhupesh.sharma@linaro.org>
 <20230103150419.3923421-3-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103150419.3923421-3-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 08:34:19PM +0530, Bhupesh Sharma wrote:
> Add SM6115 / SM4250 SoC EUD support in qcom_eud driver.
> 
> On some SoCs (like the SM6115 / SM4250 SoC), the mode manager
> needs to be accessed only via the secure world (through 'scm'
> calls).
> 

This difference does not come from the platform number, but how the
firmware is configured.

How about relying on the presence of the extra DT properties to identify
if the secure access is needed?

> Also, the enable bit inside 'tcsr_check_reg' needs to be set
> first to set the eud in 'enable' mode on these SoCs.
> 
> Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/usb/misc/Kconfig    |  1 +
>  drivers/usb/misc/qcom_eud.c | 49 ++++++++++++++++++++++++++++++++++---
>  2 files changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index a5f7652db7da1..ed4ae32ff1577 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -140,6 +140,7 @@ config USB_APPLEDISPLAY
>  config USB_QCOM_EUD
>  	tristate "QCOM Embedded USB Debugger(EUD) Driver"
>  	depends on ARCH_QCOM || COMPILE_TEST
> +	select QCOM_SCM
>  	select USB_ROLE_SWITCH
>  	help
>  	  This module enables support for Qualcomm Technologies, Inc.
> diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
> index b7f13df007646..a96ca28a4899b 100644
> --- a/drivers/usb/misc/qcom_eud.c
> +++ b/drivers/usb/misc/qcom_eud.c
> @@ -11,7 +11,9 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/qcom_scm.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/usb/role.h>
> @@ -30,15 +32,24 @@
>  #define EUD_INT_SAFE_MODE	BIT(4)
>  #define EUD_INT_ALL		(EUD_INT_VBUS | EUD_INT_SAFE_MODE)
>  
> +struct eud_soc_data {
> +	bool secure_eud_en;
> +	bool tcsr_check_enable;
> +};
> +
>  struct eud_chip {
>  	struct device			*dev;
>  	struct usb_role_switch		*role_sw;
> +	const struct eud_soc_data	*eud_data;
>  	void __iomem			*base;
>  	void __iomem			*mode_mgr;
>  	unsigned int			int_status;
>  	int				irq;
>  	bool				enabled;
>  	bool				usb_attached;
> +	phys_addr_t			mode_mgr_phys_base;

Given that mode_mgr doesn't come with the "_phys_base" suffix, how about
naming this "secure_mode_mgr"?

> +	phys_addr_t			tcsr_check_phys_base;

For now this could be a local variable in eud_probe(). Also while
mode_mgr_phys_base denotes an address range, afaict this points directly
to a single register. As such the suffix isn't appropriate.

How about "tcsr_check"?

> +
>  };
>  
>  static int enable_eud(struct eud_chip *priv)
> @@ -46,7 +57,11 @@ static int enable_eud(struct eud_chip *priv)
>  	writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
>  	writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
>  			priv->base + EUD_REG_INT1_EN_MASK);
> -	writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
> +
> +	if (priv->eud_data->secure_eud_en)

if (priv->mode_mgr_phys_base)

Would avoid the notion of having two separate variables to keep track of
the validity of one entity.

> +		qcom_scm_io_writel(priv->mode_mgr_phys_base + EUD_REG_EUD_EN2, BIT(0));
> +	else
> +		writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
>  
>  	return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
>  }
> @@ -54,7 +69,11 @@ static int enable_eud(struct eud_chip *priv)
>  static void disable_eud(struct eud_chip *priv)
>  {
>  	writel(0, priv->base + EUD_REG_CSR_EUD_EN);
> -	writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
> +
> +	if (priv->eud_data->secure_eud_en)
> +		qcom_scm_io_writel(priv->mode_mgr_phys_base + EUD_REG_EUD_EN2, 0);
> +	else
> +		writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
>  }
>  
>  static ssize_t enable_show(struct device *dev,
> @@ -178,12 +197,15 @@ static void eud_role_switch_release(void *data)
>  static int eud_probe(struct platform_device *pdev)
>  {
>  	struct eud_chip *chip;
> +	struct resource *res;
>  	int ret;
>  
>  	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
>  	if (!chip)
>  		return -ENOMEM;
>  
> +	chip->eud_data = of_device_get_match_data(&pdev->dev);
> +
>  	chip->dev = &pdev->dev;
>  
>  	chip->role_sw = usb_role_switch_get(&pdev->dev);
> @@ -200,10 +222,25 @@ static int eud_probe(struct platform_device *pdev)
>  	if (IS_ERR(chip->base))
>  		return PTR_ERR(chip->base);
>  
> -	chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
> +	chip->mode_mgr = devm_platform_get_and_ioremap_resource(pdev, 1, &res);

Perhaps it would be best not to ioremap the region when secure accesses
are required?

Regards,
Bjorn

>  	if (IS_ERR(chip->mode_mgr))
>  		return PTR_ERR(chip->mode_mgr);
>  
> +	if (chip->eud_data->secure_eud_en)
> +		chip->mode_mgr_phys_base = res->start;
> +
> +	if (chip->eud_data->tcsr_check_enable) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +		if (!res)
> +			return dev_err_probe(chip->dev, -ENODEV, "failed to get tcsr reg base\n");
> +
> +		chip->tcsr_check_phys_base = res->start;
> +
> +		ret = qcom_scm_io_writel(chip->tcsr_check_phys_base, BIT(0));
> +		if (ret)
> +			return dev_err_probe(chip->dev, ret, "failed to write tcsr check reg\n");
> +	}
> +
>  	chip->irq = platform_get_irq(pdev, 0);
>  	ret = devm_request_threaded_irq(&pdev->dev, chip->irq, handle_eud_irq,
>  			handle_eud_irq_thread, IRQF_ONESHOT, NULL, chip);
> @@ -230,8 +267,14 @@ static int eud_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct eud_soc_data sm6115_eud_data = {
> +	.secure_eud_en = true,
> +	.tcsr_check_enable = true,
> +};
> +
>  static const struct of_device_id eud_dt_match[] = {
>  	{ .compatible = "qcom,sc7280-eud" },
> +	{ .compatible = "qcom,sm6115-eud", .data = &sm6115_eud_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, eud_dt_match);
> -- 
> 2.38.1
> 
