Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24586DD8F2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjDKLJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjDKLJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:09:50 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AB33A87
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:09:49 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y6so6394257plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681211388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QOx5eZKogwJSLrh2Vav6fLlQsO7QYAE/SH8n+Ne0r9Q=;
        b=ZH85dAPo498DS0h5EDuGUGvjqayZtif/6/t7/zxxZ0IvGbhMmY1B4KIHejL4eQfr4N
         UqF2c/PpEWVond3GaUlyi/0G+AlGDpO+uMg5oMI7shOXMqKrp9myH6Y30+YvqqWTSqPz
         vhsbH/DHLzvJ7No3+yFBPdXgC+pnfVOAertgUgxub1Scp2prnGR3T6rfYMJCqewVncHo
         3u35NsmQGul91eAbDPD4+tEPMPdFTBE/R+dZSUgnN529LWyRqDFkcVlaS6ra4Zfuu+xQ
         QQoWpGAT8Z5YdV8CKtJZnv3v+G1hGP0B3zXwXEECZPKlJJiXM1MfuywniQlTgqSF4gGe
         rgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681211388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOx5eZKogwJSLrh2Vav6fLlQsO7QYAE/SH8n+Ne0r9Q=;
        b=bQfimWQHMx4Z6yzgYN+/8ntfHU2nGBWw5ppO4816fxfx/pBWJSQEZCgKoO4uorKyvg
         cFTaRoH3/aAd5mJ+mlBc9LlG9ig/+Hk202ASPzQMliS9aAhokHRk39Fw5YPOpg9RSuLK
         fflsEhmnPirBJLv1nN4dnvMCYGs5Cb0PZ+Q+FW17BeeiffAwHogBZIZG/KSrEi1XQjoE
         CFtY+MhAKdeq10cckJ72T1I129vlMz+RzhKVsyFTxHqJoqu+rbHMgeql8mxQe3u21iou
         eHX64ZnlOAyVNJ6AXGJ5vlpNzDJlO31a1rwQu0UK99RL5Cptvgw7wYQP4SxHmypjJB5g
         4mdg==
X-Gm-Message-State: AAQBX9fZJS3zd0sL1TuyqQJ0jJjXLXZSf3TpepOuQk7107etUCHGDs55
        2ZvKcbev3P1nWEyhuM9eeMUu
X-Google-Smtp-Source: AKy350bz2vrwhxHgbaDZ5T+Yl0U8D9+aim7xCaBJsGduLDqQeFi5s5ubuq+zk9Z/Bnk5Uf4H6zWcZg==
X-Received: by 2002:a05:6a20:9387:b0:e8:ee27:8ade with SMTP id x7-20020a056a20938700b000e8ee278ademr14038242pzh.22.1681211388447;
        Tue, 11 Apr 2023 04:09:48 -0700 (PDT)
Received: from thinkpad ([117.216.120.128])
        by smtp.gmail.com with ESMTPSA id b22-20020a63d316000000b0051b10da9949sm1951112pgg.66.2023.04.11.04.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 04:09:48 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:39:38 +0530
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
        Serge Semin <fancer.lancer@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 06/10] PCI: dwc: Drop empty line from
 dw_pcie_link_set_max_speed()
Message-ID: <20230411110938.GH5333@thinkpad>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
 <20230411033928.30397-7-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411033928.30397-7-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 06:39:24AM +0300, Serge Semin wrote:
> Well, just drop a redundant empty line from the tail of the denoted
> function which by mistake was added in commit 39bc5006501c ("PCI: dwc:
> Centralize link gen setting").
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index e55b7b387eb6..ede166645289 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -729,7 +729,6 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>  
>  	cap &= ~((u32)PCI_EXP_LNKCAP_SLS);
>  	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
> -
>  }
>  
>  void dw_pcie_iatu_detect(struct dw_pcie *pci)
> -- 
> 2.40.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
