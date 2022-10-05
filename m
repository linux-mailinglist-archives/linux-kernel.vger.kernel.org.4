Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698595F5CA8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 00:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiJEWZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 18:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiJEWZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 18:25:07 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDF3303FB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 15:25:06 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f193so231536pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 15:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=mhMPvEXXYCPlbOQG8BzvcGNV3ML97Cg893xM+52RSgQ=;
        b=HKuN0K2/4ikar8N5dBtbFYT2BkP1HBPMufC0LN0ASsAwWLksRCjjpnM9XlJ5SeB6n+
         ySPGxHRhhG6mCK65FB3pcbzHpPbdxpA8sA8UbmUj0+qWBmzvCPvtBm54ktu4z08OSzFW
         DKw5YNTHUgpDkk6JP78GbjkeqmngeyhPmmJPFX2IuqVfigmcI5bwfDHJCfcOyJb2+pCl
         6leXfPw9laNO4XY4HtELKik3uemLvs5YG3LQ5Swyl1J31KlJ+38Ysgz9EUzuMmQKBFgf
         rKCND9i2sBRfwe91Z9K7UZIl1aVwvXlLSLG/sI2FXXdKl52AvITTPwy2aRnCQk/9Kz2i
         yRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mhMPvEXXYCPlbOQG8BzvcGNV3ML97Cg893xM+52RSgQ=;
        b=bwhHrHYgFypC34XMMYCm2a9KPZSP98xI5MsDC2RjUQZ9QthrrnifIkaQ4NFuI6+LwT
         EoHRspMkjsSQ98W4UQv4GzAsIH36otHWQs6QjfUseAtA/0SAj4u216hFzGjiODuZ+ySQ
         ZjGJ3vQQ+JL3SmrV0J8sIsgSK6h1axF/tcF2O9JGYi2zPfBhmoAcSUmbVR4Nx8UtOmpr
         /ZIOcGgLmZMRxlZXpa2jOtlKfy9LqdLIa6L1QyRyjd6SqLXR8GwxTxvtvgtvkUdveWrh
         PfJ4bV4KXksreiuIdGI52K9z9Y1M9W5ma7pjx2Ajet3E2BNYvnZH6xJZU7IiyUhCiz6T
         0Ilg==
X-Gm-Message-State: ACrzQf32vMUoPPaPh5mqzOMrdAEMuQTGGE0FOhiP042CCrkxAtBTFILG
        6detthZhZ9rmGmcVB/Lnh4rU
X-Google-Smtp-Source: AMsMyM6v376O9YGcV0tO2jMHWj9Uz6l4fYQHTnPsRJHku8zvGt26Cc6qQWLWAmd/MsqnDBTBNXhdIQ==
X-Received: by 2002:a63:5d48:0:b0:43a:390b:2183 with SMTP id o8-20020a635d48000000b0043a390b2183mr1669590pgm.29.1665008705484;
        Wed, 05 Oct 2022 15:25:05 -0700 (PDT)
Received: from thinkpad ([27.111.75.192])
        by smtp.gmail.com with ESMTPSA id d2-20020a17090acd0200b001ef8ab65052sm1614744pju.11.2022.10.05.15.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 15:25:04 -0700 (PDT)
Date:   Thu, 6 Oct 2022 03:54:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v4 06/12] PCI: qcom-ep: Gate Master AXI clock to MHI bus
 during L1SS
Message-ID: <20221005222458.GA6150@thinkpad>
References: <20220914075350.7992-7-manivannan.sadhasivam@linaro.org>
 <20221005220838.GA2400326@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221005220838.GA2400326@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 05:08:38PM -0500, Bjorn Helgaas wrote:
> [+cc Krishna]
> 
> On Wed, Sep 14, 2022 at 01:23:44PM +0530, Manivannan Sadhasivam wrote:
> > During L1SS, gate the Master clock supplied to the MHI bus to save power.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > index 2dc6d4e44aff..526e98ea23f6 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > @@ -27,6 +27,7 @@
> >  #define PARF_SYS_CTRL				0x00
> >  #define PARF_DB_CTRL				0x10
> >  #define PARF_PM_CTRL				0x20
> > +#define PARF_MHI_CLOCK_RESET_CTRL		0x174
> >  #define PARF_MHI_BASE_ADDR_LOWER		0x178
> >  #define PARF_MHI_BASE_ADDR_UPPER		0x17c
> >  #define PARF_DEBUG_INT_EN			0x190
> > @@ -89,6 +90,9 @@
> >  #define PARF_PM_CTRL_READY_ENTR_L23		BIT(2)
> >  #define PARF_PM_CTRL_REQ_NOT_ENTR_L1		BIT(5)
> >  
> > +/* PARF_MHI_CLOCK_RESET_CTRL fields */
> > +#define PARF_MSTR_AXI_CLK_EN			BIT(1)
> > +
> >  /* PARF_AXI_MSTR_RD_HALT_NO_WRITES register fields */
> >  #define PARF_AXI_MSTR_RD_HALT_NO_WRITE_EN	BIT(0)
> >  
> > @@ -394,6 +398,11 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
> >  		       pcie_ep->parf + PARF_MHI_BASE_ADDR_LOWER);
> >  	writel_relaxed(0, pcie_ep->parf + PARF_MHI_BASE_ADDR_UPPER);
> >  
> > +	/* Gate Master AXI clock to MHI bus during L1SS */
> > +	val = readl_relaxed(pcie_ep->parf + PARF_MHI_CLOCK_RESET_CTRL);
> > +	val &= ~PARF_MSTR_AXI_CLK_EN;
> > +	val = readl_relaxed(pcie_ep->parf + PARF_MHI_CLOCK_RESET_CTRL);
> 
> Is this code executed when the link actually transitions to L1.x, or
> is this just configuring things so that when the link does transition
> to L1.x sometime later, hardware will gate the Master AXI clock?
> 

It is the latter... This patch programs the EP controller in such a way that
when the link enters L1.x, the AXI clock supplied to the MHI bus (EP function)
will be cut-off to save power. Once the link goes out of L1.x, the clock will
be restored by the controller.

> Just curious because this looks more like *configuration*, i.e., the
> latter, but there's the ongoing conversation about qcom system
> suspend/resume, where IIUC, software is involved at least in some
> L1.2 exits.
> 

Krishna's suspend/resume patches are for Qcom PCIe RC controller, but this
series and this patch is for Qcom PCIe EP controller.

Thanks,
Mani

> >  	dw_pcie_ep_init_notify(&pcie_ep->pci.ep);
> >  
> >  	/* Enable LTSSM */
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்
