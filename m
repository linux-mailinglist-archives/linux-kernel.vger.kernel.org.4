Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81467701DA5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 15:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjENNqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 09:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjENNqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 09:46:35 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934CC1732
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 06:46:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ab14cb3aaeso83344945ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 06:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684071992; x=1686663992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kcb2f4Ev9/MrkBRrwgPUZL/+4rEBt9/dH5HyrPeBpO4=;
        b=zRRMijhxUqcZNdU5t3A7v0iTTy5sp9JnGXlF+tE6U62rA927JXkfzTcDVK+vQUPhIu
         2fe42bQ+Vp9ycOqoOi+lm+jpoGCHJkgxHzZsXSX608PBcrSeJQl6d8Rl0MfjOwGtLYyI
         Uzmt0aHUvNVO02oaFXpSdzGZO5jM/ZBm6VqnrGHvVxTeJ32DCnO29zKE/SGDlnRbgHm7
         1jdCsAgzRtTP3K8mdfCelYfl3ZzHK/sYCmQCvSJAgChtV+Cy+VLaOKVUZNtuRIQQunSc
         sWuiV81BZq3SpDsL3VDBGF43CQPwt7pmPZqnZSU32L6A7wZLV39jTGo/7+qXVuElYWt4
         mC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684071992; x=1686663992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kcb2f4Ev9/MrkBRrwgPUZL/+4rEBt9/dH5HyrPeBpO4=;
        b=MG9iyMd8Zl2WbFRnVIMDIypHmXctyv9GlUCX2yKDqz7GGL55wER9yQR8lmQ/DzeGK0
         3Mg56H2sbO9EKA0+Jrh5ro2dzMHvmL+Dcyd3oV5jFJvmYRChKy3vcrnsDseQFbzVAjiD
         rHr5Itw/Io+pFZOL4doAnypfr+XOi/5yaoMsIP4VuuPlKlF74m18IY54pGzStOsc5H6G
         ecWnT+oNM7a8sEScyiJ06AWmA3lykdgJaZ4vMznrRw8TuNFrhl6+o4EiogXcZAeEryqX
         Aw05AqD4/nSUoP90WCobqpPlQQzwcarjKmroFn8SL0+J/Ty0plO5Fr82gOIqvbgCBiT8
         d6vg==
X-Gm-Message-State: AC+VfDwRlZAAlzDvMteIh18QqeQxJ90QXtM2HNTxBQQZjpzCEsBPyATC
        BFhMGPuiYZshTxJLArq4k3Re
X-Google-Smtp-Source: ACHHUZ4w5jCbkX6MzOxwLVijUmBV55zTb3NrD9AvLOeEjyB4nA4W4gawwMADr5WX8bC0T2xCDrg0YA==
X-Received: by 2002:a17:902:b7cc:b0:1ac:3ddf:2299 with SMTP id v12-20020a170902b7cc00b001ac3ddf2299mr31094193plz.44.1684071992018;
        Sun, 14 May 2023 06:46:32 -0700 (PDT)
Received: from thinkpad ([120.138.12.96])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902e88e00b001ac591b0500sm4725357plg.134.2023.05.14.06.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 06:46:31 -0700 (PDT)
Date:   Sun, 14 May 2023 19:16:25 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-pci@vger.kernel.org>,
        "moderated list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] PCI: layerscape: Add the endpoint linkup notifier
 support
Message-ID: <20230514134625.GB116991@thinkpad>
References: <20230508215235.1994348-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230508215235.1994348-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 05:52:35PM -0400, Frank Li wrote:
> Layerscape has PME interrupt, which can be used as linkup notifier.
> Set CFG_READY bit of PEX_PF0_CONFIG to enable accesses from root complex
> when linkup detected.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

One minor comment below. With that fixed,

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
> Change from v2 to v3
>  - align 80 column
>  - clear irq firstly
>  - dev_info to dev_dbg
>  - remove double space
>  - update commit message
> 
> Change from v1 to v2
> - pme -> PME
> - irq -> IRQ
> - update dev_info message according to Bjorn's suggestion
> - remove '.' at error message
> 
>  .../pci/controller/dwc/pci-layerscape-ep.c    | 102 +++++++++++++++++-
>  1 file changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index c640db60edc6..1a431a9be91e 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -18,6 +18,20 @@
>  
>  #include "pcie-designware.h"
>  
> +#define PEX_PF0_CONFIG			0xC0014
> +#define PEX_PF0_CFG_READY		BIT(0)
> +
> +/* PEX PFa PCIE PME and message interrupt registers*/
> +#define PEX_PF0_PME_MES_DR		0xC0020
> +#define PEX_PF0_PME_MES_DR_LUD		BIT(7)
> +#define PEX_PF0_PME_MES_DR_LDD		BIT(9)
> +#define PEX_PF0_PME_MES_DR_HRD		BIT(10)
> +
> +#define PEX_PF0_PME_MES_IER		0xC0028
> +#define PEX_PF0_PME_MES_IER_LUDIE	BIT(7)
> +#define PEX_PF0_PME_MES_IER_LDDIE	BIT(9)
> +#define PEX_PF0_PME_MES_IER_HRDIE	BIT(10)
> +
>  #define to_ls_pcie_ep(x)	dev_get_drvdata((x)->dev)
>  
>  struct ls_pcie_ep_drvdata {
> @@ -30,8 +44,86 @@ struct ls_pcie_ep {
>  	struct dw_pcie			*pci;
>  	struct pci_epc_features		*ls_epc;
>  	const struct ls_pcie_ep_drvdata *drvdata;
> +	bool				big_endian;
> +	int				irq;

Move bool to the end of struct to avoid holes.

- Mani

>  };
>  
> +static u32 ls_lut_readl(struct ls_pcie_ep *pcie, u32 offset)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +
> +	if (pcie->big_endian)
> +		return ioread32be(pci->dbi_base + offset);
> +	else
> +		return ioread32(pci->dbi_base + offset);
> +}
> +
> +static void ls_lut_writel(struct ls_pcie_ep *pcie, u32 offset, u32 value)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +
> +	if (pcie->big_endian)
> +		iowrite32be(value, pci->dbi_base + offset);
> +	else
> +		iowrite32(value, pci->dbi_base + offset);
> +}
> +
> +static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
> +{
> +	struct ls_pcie_ep *pcie = dev_id;
> +	struct dw_pcie *pci = pcie->pci;
> +	u32 val, cfg;
> +
> +	val = ls_lut_readl(pcie, PEX_PF0_PME_MES_DR);
> +	ls_lut_writel(pcie, PEX_PF0_PME_MES_DR, val);
> +
> +	if (!val)
> +		return IRQ_NONE;
> +
> +	if (val & PEX_PF0_PME_MES_DR_LUD) {
> +		cfg = ls_lut_readl(pcie, PEX_PF0_CONFIG);
> +		cfg |= PEX_PF0_CFG_READY;
> +		ls_lut_writel(pcie, PEX_PF0_CONFIG, cfg);
> +		dw_pcie_ep_linkup(&pci->ep);
> +
> +		dev_dbg(pci->dev, "Link up\n");
> +	} else if (val & PEX_PF0_PME_MES_DR_LDD) {
> +		dev_dbg(pci->dev, "Link down\n");
> +	} else if (val & PEX_PF0_PME_MES_DR_HRD) {
> +		dev_dbg(pci->dev, "Hot reset\n");
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ls_pcie_ep_interrupt_init(struct ls_pcie_ep *pcie,
> +				     struct platform_device *pdev)
> +{
> +	u32 val;
> +	int ret;
> +
> +	pcie->irq = platform_get_irq_byname(pdev, "pme");
> +	if (pcie->irq < 0) {
> +		dev_err(&pdev->dev, "Can't get 'pme' IRQ\n");
> +		return pcie->irq;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, pcie->irq, ls_pcie_ep_event_handler,
> +			       IRQF_SHARED, pdev->name, pcie);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't register PCIe IRQ\n");
> +		return ret;
> +	}
> +
> +	/* Enable interrupts */
> +	val = ls_lut_readl(pcie, PEX_PF0_PME_MES_IER);
> +	val |=  PEX_PF0_PME_MES_IER_LDDIE | PEX_PF0_PME_MES_IER_HRDIE |
> +		PEX_PF0_PME_MES_IER_LUDIE;
> +	ls_lut_writel(pcie, PEX_PF0_PME_MES_IER, val);
> +
> +	return 0;
> +}
> +
>  static const struct pci_epc_features*
>  ls_pcie_ep_get_features(struct dw_pcie_ep *ep)
>  {
> @@ -125,6 +217,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>  	struct ls_pcie_ep *pcie;
>  	struct pci_epc_features *ls_epc;
>  	struct resource *dbi_base;
> +	int ret;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
> @@ -144,6 +237,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>  	pci->ops = pcie->drvdata->dw_pcie_ops;
>  
>  	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4);
> +	ls_epc->linkup_notifier = true;
>  
>  	pcie->pci = pci;
>  	pcie->ls_epc = ls_epc;
> @@ -155,9 +249,15 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>  
>  	pci->ep.ops = &ls_pcie_ep_ops;
>  
> +	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
> +
>  	platform_set_drvdata(pdev, pcie);
>  
> -	return dw_pcie_ep_init(&pci->ep);
> +	ret = dw_pcie_ep_init(&pci->ep);
> +	if (ret)
> +		return ret;
> +
> +	return ls_pcie_ep_interrupt_init(pcie, pdev);
>  }
>  
>  static struct platform_driver ls_pcie_ep_driver = {
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
