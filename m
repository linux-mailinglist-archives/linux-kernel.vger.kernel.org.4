Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD876DD8E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjDKLH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjDKLHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:07:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4003AAB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:06:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c3so8560637pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681211211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jo6fILbA0nBPbnJ67sQdpRNR+O+VicyEIM4g1muSLtA=;
        b=N3YlAx+R+ynKun1E9btqLANZMdHSQQGT4PcRmgXCMxyebjSmYY7jXTzqsw9FQeigQx
         EGVNibo/FwKYLvlQHjK5L2x2DV7Se25l1M2FN7mV4G4v7rhfVRiARs5nm8O2Xm0TbqEW
         lCKHQ1C6Z8M68aNVsUgh43iPN518tEAuSVVVQ4RjI9R2DgesLtIOIrfaEu4WcgcvBFxJ
         gDoG09TH1u5w2UoydleeK9VD7UkpCoNRYkQAUavQAQXrBXKeIgELO/Br6mELHxnslaGk
         Xbzi2nwcO3rJS8l76OqBCpy55NibJ+kt1LIszbYOceLAzKKHi6ZJ9w4daGRzJbkUciug
         isSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681211211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jo6fILbA0nBPbnJ67sQdpRNR+O+VicyEIM4g1muSLtA=;
        b=QiTFAYdPc0jkaIIWGaBKibn22zsKzjX4wbcep2nrRPlLOcGBHcNgthpEvz7p07KaMf
         ja0yDBkGMhGrsrSgA2vIXO38P+0jKBmWiGW+++eqo/d8XvzNgHG9aFr8pA2Jl077H2yW
         8RrfFMKSe9T7L+i8AS+3O/xeu7LBc5ljL7uvpHpkGJ8VR+qxselio40W4ZAlcwcs/E9X
         9LO5sxVcxLzxZgzSf0qkD2L27o1jl2+odQOVFUPMoJGoRU6JsdWMp97lJLs6XTbFnB7T
         /HPzifVL/h0hFxiQEOFYuM4A5sn0btmw7R0nWGdSGHi1y19YuxkZ1NkwkXrPzT3vEqTp
         unOA==
X-Gm-Message-State: AAQBX9cmWCwYzmXemVNzqZdg9us0LesKYm4dTIcrC9uVbWowMRlk1UgP
        5w78JPIES3ohjDsDfOh92n4d
X-Google-Smtp-Source: AKy350Zh1A56N2F2a8bO7VmS2d1vLSjHni4An3v1eI4Jbu6ux0wXz6BuuhiAOdISjhsFZhMrF3JuTg==
X-Received: by 2002:a05:6a20:2a22:b0:d9:b0b5:fdaf with SMTP id e34-20020a056a202a2200b000d9b0b5fdafmr14340899pzh.48.1681211211536;
        Tue, 11 Apr 2023 04:06:51 -0700 (PDT)
Received: from thinkpad ([117.216.120.128])
        by smtp.gmail.com with ESMTPSA id a22-20020a62e216000000b00627ee6dcb84sm9531260pfi.203.2023.04.11.04.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 04:06:51 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:36:43 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 04/10] PCI: bt1: Fix printing false error
 message
Message-ID: <20230411110643.GF5333@thinkpad>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
 <20230411033928.30397-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411033928.30397-5-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 06:39:22AM +0300, Serge Semin wrote:
> The dev_err_probe() method is supposed to be invoked only if any error is
> happened. It was definitely wrong to call it unconditionally. Due to that
> the DWC PCIe host initialization error-message is printed all the time the
> Baikal-T1 PCIe controller is probed even if no error actually happened.
> 
> Fixes: ba6ed462dcf4 ("PCI: dwc: Add Baikal-T1 PCIe controller support")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-bt1.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
> index e36a20bf82cf..6557141873ad 100644
> --- a/drivers/pci/controller/dwc/pcie-bt1.c
> +++ b/drivers/pci/controller/dwc/pcie-bt1.c
> @@ -597,8 +597,10 @@ static int bt1_pcie_add_port(struct bt1_pcie *btpci)
>  	dw_pcie_cap_set(&btpci->dw, REQ_RES);
>  
>  	ret = dw_pcie_host_init(&btpci->dw.pp);
> +	if (ret)
> +		dev_err_probe(dev, ret, "Failed to initialize DWC PCIe host\n");
>  
> -	return dev_err_probe(dev, ret, "Failed to initialize DWC PCIe host\n");
> +	return ret;
>  }
>  
>  static void bt1_pcie_del_port(struct bt1_pcie *btpci)
> -- 
> 2.40.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
