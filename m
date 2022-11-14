Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF3F627B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbiKNLHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbiKNLHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:07:02 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F481EEEF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:07:00 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id c2so9716869plz.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MkiR3wHiiW1PYTQ7TE0X6JrLq1vnHDKlS/zuy1ypUvQ=;
        b=ZyksGHtPdVe30jSTgBir0r6zjbL2u5GpgzS6sid5bMO3qTdKn3E/3GkV/i3dPVbdIk
         RsGErEozMC3CakHQBZoiCYtATnxPpYCBd+IucCJ9ZuaQSWUq4pfCBp/NTMDK/Cv7qXw9
         5soHBfyk3f0ZRFpK1JDNpN8a3MUnSPhZcDjP7hcLzQmyTOB7zBY2NIhRn5NJB3i88QEW
         uHe3xe3Cp+S6p9sz5gne5a/sseMiLdvXDYwRxYM/upoVE/afbaOLEji0SIlHpKOngidm
         uO/Ito79czfU+1qwEEdq9xI5eXwdEsfaysfzdHOeIBwIpL5qwMg9hT40U3hyBJLxpup5
         FHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MkiR3wHiiW1PYTQ7TE0X6JrLq1vnHDKlS/zuy1ypUvQ=;
        b=I8UlU38AbB0rpIBY/h7V01FDu7ZpB8UWW4gwL9FVcsK4BMV55m7b4wqcPLLWOGMqf/
         wRim1dIArQjxrq/dbU+NOSnT7Z01+Be8jaKItmavPc2OhiznY2pwUHClbqNQIJit34YC
         EucW370K3dsSqSw6C961qevmrRMmHsGNwUdL4JBhA+TlMVvr45LT0AHaBa6DWIYtH/LY
         vC661BxXXxfOA6tmWLwTOyDC4UfFPyhL2Fb4lnvi/3R1XolQ4kS9f6dvX5UeIKfINXBN
         dWZOvaAI4X+zwr9r6vd7Ivg4+wkQh3YtlxZ+6FMV0l4rWNW95irHouV30MGOvD0weX6q
         TbKg==
X-Gm-Message-State: ANoB5pllgvx4ZCGB/v0K0VvOdUtJjQXoCuy0e9j4E0ZWoZ5euxxqnjhH
        HEJbb2UVOxXfE2pADttFndAF
X-Google-Smtp-Source: AA0mqf5eoKaaLhLXcQHHPo+28RlJ+upBEvK/afNrX2kqhp8MLM29+9/SV1+DyMsD+pEiLuFQDG7UuA==
X-Received: by 2002:a17:902:7843:b0:187:282c:9b9c with SMTP id e3-20020a170902784300b00187282c9b9cmr13283212pln.29.1668424019854;
        Mon, 14 Nov 2022 03:06:59 -0800 (PST)
Received: from thinkpad ([117.248.0.54])
        by smtp.gmail.com with ESMTPSA id y2-20020a62ce02000000b0056bbd286cf4sm6362246pfg.167.2022.11.14.03.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 03:06:58 -0800 (PST)
Date:   Mon, 14 Nov 2022 16:36:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vidyas@nvidia.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, lpieralisi@kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v4 2/5] PCI: tegra194: Move dw_pcie_ep_linkup() to
 threaded IRQ handler
Message-ID: <20221114110654.GL3869@thinkpad>
References: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
 <20221025145101.116393-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221025145101.116393-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 08:20:58PM +0530, Manivannan Sadhasivam wrote:
> dw_pcie_ep_linkup() may take more time to execute depending on the EPF
> driver implementation. Calling this API in the hard IRQ handler is not
> encouraged since the hard IRQ handlers are supposed to complete quickly.
> 
> So move the dw_pcie_ep_linkup() call to threaded IRQ handler.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 1b6b437823d2..a0d231b7a435 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -287,6 +287,7 @@ struct tegra_pcie_dw {
>  	struct gpio_desc *pex_refclk_sel_gpiod;
>  	unsigned int pex_rst_irq;
>  	int ep_state;
> +	long link_status;
>  };
>  
>  static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
> @@ -450,9 +451,13 @@ static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
>  static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>  {
>  	struct tegra_pcie_dw *pcie = arg;
> +	struct dw_pcie_ep *ep = &pcie->pci.ep;
>  	struct dw_pcie *pci = &pcie->pci;
>  	u32 val, speed;
>  
> +	if (test_and_clear_bit(0, &pcie->link_status))
> +		dw_pcie_ep_linkup(ep);
> +
>  	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
>  		PCI_EXP_LNKSTA_CLS;
>  	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> @@ -499,7 +504,6 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>  static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
>  {
>  	struct tegra_pcie_dw *pcie = arg;
> -	struct dw_pcie_ep *ep = &pcie->pci.ep;
>  	int spurious = 1;
>  	u32 status_l0, status_l1, link_status;
>  
> @@ -515,7 +519,8 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
>  			link_status = appl_readl(pcie, APPL_LINK_STATUS);
>  			if (link_status & APPL_LINK_STATUS_RDLH_LINK_UP) {
>  				dev_dbg(pcie->dev, "Link is up with Host\n");
> -				dw_pcie_ep_linkup(ep);
> +				set_bit(0, &pcie->link_status);
> +				return IRQ_WAKE_THREAD;
>  			}
>  		}
>  
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
