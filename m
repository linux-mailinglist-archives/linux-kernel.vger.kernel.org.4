Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129C26FCE73
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbjEITUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjEITUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:20:42 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EA44232
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 12:20:41 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4effb818c37so7107769e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 12:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20221208.gappssmtp.com; s=20221208; t=1683660040; x=1686252040;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LtZh4FKqjRIIlvC8PRON5MECQekh/TBXt0NLOJpp3uY=;
        b=MGrwUJdXzumLTuxDu+/2GyCTFkZdLEylXtQGiWKEny9XOEgcEoFbwtrh9EVosBJtqx
         iyHhL03wekhcTzw5PcZjPFgZUXOQC/CWdnwQw48ZJMQpDywEuNRMSzumMxOpIQi0XXGW
         SbHDXU80NA+71Vfh3IK92iJi4t47Kz1OrauTCbT95SKEEtAgKXJWitCMahbaNVp9aHh0
         eKDXh29lCMqDhTwHQKNt1OZk6oOrwKDdH0wQ9p2Fm8HiGuvfNtmqWPo1uBAA3EwN0CoR
         BY1l/H6XMaTqYLKC1Yu/bZlz78L+TxG/q6Ei3rTXTkrRyAZAt7Hf41Da/+0f/h3XvOWI
         /mDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683660040; x=1686252040;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LtZh4FKqjRIIlvC8PRON5MECQekh/TBXt0NLOJpp3uY=;
        b=ff6Yt5t3wbZ1vSTRuXBltJm09FIFWnK7vLFq63ilCLejGpy52BZ5Pcdpqd80HlMtd8
         bIBAkrcDpEufito6E70wRDt2vOxfwmMKk7Jmfdd9+RUaE/mwth0weBup+Rdntu2BF0eq
         +7VzcIUsxcTBJzg22VxXi0jddM74VE8/TOqyQJsBRCllVBrDr2bRyt1lu3YN8YGBgyP4
         RPeAsrCO81iW954R2qmdvtMZkNlSU2/K8dpJSYn5JY6XCEM66odofoQytcPNGVoVjHvO
         yM8DFZirBq7RxFKihlYZWoWaUfMFtGq1o1u43XW0mYCp8RbTGFCQkPqVjMcRKanbLukU
         dRUg==
X-Gm-Message-State: AC+VfDzmTL/6RuavwwIpNEEkoCALxQv4hagErrB0YOQwBHxz31I4+EhQ
        XzJiK8b/Xuhs64nxgNnIg6tfTv0gUEW/EXUFz8iDoA==
X-Google-Smtp-Source: ACHHUZ5aAp2rsdUt1+l84t+X7rbRMNA0iixHc8AC7j0dIVSc+Rgb7LU2zV03RDR2GMZqdtgavKctMA==
X-Received: by 2002:ac2:46d6:0:b0:4f2:502d:f6c9 with SMTP id p22-20020ac246d6000000b004f2502df6c9mr1023602lfo.13.1683660039713;
        Tue, 09 May 2023 12:20:39 -0700 (PDT)
Received: from localhost (h-46-59-89-207.A463.priv.bahnhof.se. [46.59.89.207])
        by smtp.gmail.com with ESMTPSA id c2-20020a197602000000b004d023090504sm440335lff.84.2023.05.09.12.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:20:39 -0700 (PDT)
Date:   Tue, 9 May 2023 21:20:38 +0200
From:   Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Richard Alpe <richard@bit42.se>
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] nvmem: add new NXP QorIQ eFuse driver
Message-ID: <ZFqdBhfyUaGRMfw0@oden.dyn.berto.se>
References: <20230410082051.2948510-1-richard@bit42.se>
 <20230410082051.2948510-2-richard@bit42.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230410082051.2948510-2-richard@bit42.se>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

Thanks for your work.

On 2023-04-10 10:20:51 +0200, Richard Alpe wrote:
> Add SFP (Security Fuse Processor) read support for NXP (Freescale)
> QorIQ series SOC's.
> 
> This patch adds support for the T1023 SOC using the SFP offset from
> the existing T1023 device tree. In theory this should also work for
> T1024, T1014 and T1013 which uses the same SFP base offset.
> 
> Signed-off-by: Richard Alpe <richard@bit42.se>

Looks good.

Reviewed-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>

> ---
> v2: Rebase.
> v3: Updates according to feedback from Srinivas.
> v4,v5: No changes to this patch.
> 
>  drivers/nvmem/Kconfig       | 12 ++++++
>  drivers/nvmem/Makefile      |  2 +
>  drivers/nvmem/qoriq-efuse.c | 78 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 92 insertions(+)
>  create mode 100644 drivers/nvmem/qoriq-efuse.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 6dec38805041..43446e5f7d9b 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -377,4 +377,16 @@ config NVMEM_ZYNQMP
>  
>  	  If sure, say yes. If unsure, say no.
>  
> +config NVMEM_QORIQ_EFUSE
> +	tristate "NXP QorIQ eFuse support"
> +	depends on PPC_85xx || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This driver provides read support for the eFuses (SFP) on NXP QorIQ
> +	  series SoC's. This includes secure boot settings, the globally unique
> +	  NXP ID 'FUIDR' and the OEM unique ID 'OUIDR'.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem_qoriq_efuse.
> +
>  endif
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 6a1efffa88f0..b8fdf9b51953 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -74,3 +74,5 @@ obj-$(CONFIG_NVMEM_VF610_OCOTP)		+= nvmem-vf610-ocotp.o
>  nvmem-vf610-ocotp-y			:= vf610-ocotp.o
>  obj-$(CONFIG_NVMEM_ZYNQMP)		+= nvmem_zynqmp_nvmem.o
>  nvmem_zynqmp_nvmem-y			:= zynqmp_nvmem.o
> +obj-$(CONFIG_NVMEM_QORIQ_EFUSE)		+= nvmem-qoriq-efuse.o
> +nvmem-qoriq-efuse-y			:= qoriq-efuse.o
> diff --git a/drivers/nvmem/qoriq-efuse.c b/drivers/nvmem/qoriq-efuse.c
> new file mode 100644
> index 000000000000..e7fd04d6dd94
> --- /dev/null
> +++ b/drivers/nvmem/qoriq-efuse.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 2023  Westermo Network Technologies AB
> + */
> +
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/platform_device.h>
> +
> +struct qoriq_efuse_priv {
> +	void __iomem *base;
> +};
> +
> +static int qoriq_efuse_read(void *context, unsigned int offset, void *val,
> +			    size_t bytes)
> +{
> +	struct qoriq_efuse_priv *priv = context;
> +
> +	/* .stride = 4 so offset is guaranteed to be aligned */
> +	__ioread32_copy(val, priv->base + offset, bytes / 4);
> +
> +	/* Ignore trailing bytes (there shouldn't be any) */
> +
> +	return 0;
> +}
> +
> +static int qoriq_efuse_probe(struct platform_device *pdev)
> +{
> +	struct nvmem_config config = {
> +		.dev = &pdev->dev,
> +		.read_only = true,
> +		.reg_read = qoriq_efuse_read,
> +		.stride = sizeof(u32),
> +		.word_size = sizeof(u32),
> +		.name = "qoriq_efuse_read",
> +		.id = NVMEM_DEVID_AUTO,
> +		.root_only = true,
> +	};
> +	struct qoriq_efuse_priv *priv;
> +	struct nvmem_device *nvmem;
> +	struct resource *res;
> +
> +	priv = devm_kzalloc(config.dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	config.size = resource_size(res);
> +	config.priv = priv;
> +	nvmem = devm_nvmem_register(config.dev, &config);
> +
> +	return PTR_ERR_OR_ZERO(nvmem);
> +}
> +
> +static const struct of_device_id qoriq_efuse_of_match[] = {
> +	{ .compatible = "fsl,t1023-sfp", },
> +	{/* sentinel */},
> +};
> +MODULE_DEVICE_TABLE(of, qoriq_efuse_of_match);
> +
> +static struct platform_driver qoriq_efuse_driver = {
> +	.probe = qoriq_efuse_probe,
> +	.driver = {
> +		.name = "qoriq-efuse",
> +		.of_match_table = qoriq_efuse_of_match,
> +	},
> +};
> +module_platform_driver(qoriq_efuse_driver);
> +
> +MODULE_AUTHOR("Richard Alpe <richard.alpe@bit42.se>");
> +MODULE_DESCRIPTION("NXP QorIQ Security Fuse Processor (SFP) Reader");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund
