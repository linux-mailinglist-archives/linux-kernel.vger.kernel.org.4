Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340256DD8EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDKLJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjDKLJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:09:21 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCEE35B5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:09:18 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id c3so8566599pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681211358;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uHPA9C0yqBppQUyazyjnVWRaEtn3c0yVe1/8oTMQ7lE=;
        b=xtdC5WSNqSlnsFwIurjh3A0QREnEpBBcoNMnxI/cuQMgc5yH9HSLuqALtwvvCmQtCB
         HOGmw3OCUcz6B6Ax5f62uus1sU8XaPTgbPKOG+v9JjmxK5sUjJa1igvj68+ACdFK+0TY
         xWefeofwOJX9g7u7f9g280avow5e+pl3+HBcT8w1pxr2NdQihJbAAZSUF/Jfw1rX8ifm
         +blj5NuZOniaI8sepPwhqSRoDv/KGmU4Rgc/4XIxbX+ow6LAMIPFIPGEM8VoohfGbJwY
         9uRDVugrCeO17d5Bt2zaYA/vJN1UNNelPW/J8xtpuEwuUY9UIBe7+vW5+wjtXllstiks
         SGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681211358;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHPA9C0yqBppQUyazyjnVWRaEtn3c0yVe1/8oTMQ7lE=;
        b=k54KTKHKRqHNU82RIH66qpcGktvICKm2sp8u+oQr9bdf6r8Ae1vj4Bbau0x6Inb3tC
         a9s8VgJQOdduubMQN1lwHlY7tpa+NTBJGDIdhYAbSPyRyErtj+xHzBYCLJitZXZVo+H3
         qNkLHB6tirMBsrgoEPpn3H/Ix1Vkvi29ufgYrrDf6HVNT17XQd1vts3uD52qSf9NwgHL
         gBPG5JuiuUR9gzhoy7klWcCojULjuZKTUvu7fRvLybj2sJ88wOeu12w4AnLcHrPx1XS3
         yhmm34oqFVyEdE8uBvzhTO1OAeYAaP75zlgok/6BI5mLz1hQtQveJBRT34f6BC9F7Dil
         WBBQ==
X-Gm-Message-State: AAQBX9eV6HWFNWncd8+FtNj7fv5ts0inB0p1X9TxtKHAC8D1woLPNrDc
        lLUC2KIeCEL2SZF1y7GLRXixpwa6zUgmGwkT9Q==
X-Google-Smtp-Source: AKy350YAFtY1ogexluLyKBFt7qgR3kFbhzc2DonzIeZxvZuwJ9+MwYiFXM84IIKWOL0mycYDrVJpMQ==
X-Received: by 2002:a17:902:e843:b0:19f:87b5:1873 with SMTP id t3-20020a170902e84300b0019f87b51873mr17801744plg.62.1681211357858;
        Tue, 11 Apr 2023 04:09:17 -0700 (PDT)
Received: from thinkpad ([117.216.120.128])
        by smtp.gmail.com with ESMTPSA id r19-20020a170902be1300b001a072aedec7sm9489813pls.75.2023.04.11.04.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 04:09:17 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:39:07 +0530
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
Subject: Re: [PATCH RESEND v3 05/10] PCI: dwc: Drop duplicated fast-link-mode
 flag unsetting
Message-ID: <20230411110907.GG5333@thinkpad>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
 <20230411033928.30397-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411033928.30397-6-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 06:39:23AM +0300, Serge Semin wrote:
> Most likely by mistake the PORT_LINK_FAST_LINK_MODE flag unsetting was
> added twice in the commit cff9244432e8 ("PCI: dwc: Ensure FAST_LINK_MODE
> is cleared"): first it is cleared right after the content of the
> PCIE_PORT_LINK_CONTROL register is read, second it's cleared in the
> framework of the link-mode initialization procedure. The later action is
> redundant. Let's drop it.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 8e33e6e59e68..e55b7b387eb6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1019,7 +1019,6 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  	}
>  
>  	/* Set the number of lanes */
> -	val &= ~PORT_LINK_FAST_LINK_MODE;
>  	val &= ~PORT_LINK_MODE_MASK;
>  	switch (pci->num_lanes) {
>  	case 1:
> -- 
> 2.40.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
