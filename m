Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B31D702BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbjEOLoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbjEOLl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:41:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9A0273E
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:36:53 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae2c8734fcso157225ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684150613; x=1686742613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JDGTIMvQ20JVretXaWpYChh5fuqmnmjbHjkoKJsET3E=;
        b=gsDwZ5YYgydAKCX/7AZ61JKSBtxGPl3Mm/uK9A8rkw23VSkL2jYq4AHgq9Hlj5mbUj
         K/uX65RocRePHnFKmO1F9GF3Oyzq+UYK/qbWZYLmjc5tMlecJNE9H7FT7TgU1FW5UoRk
         wfyfKTWTO0XoaOsrb/DTy9/FEPq4Iz3P5K4tfomcj1DZSjeV09VAEWGBYAJJjI3qh1Qb
         b7w0bMTQJDchFDDSP+Bz4vR9zj6D5Fy2EepuZZBsCIyGyXFYsLs4LHwQfRUmvDg9+pnJ
         smZp+G6nnvcVxKjltdM9ldEPYpEVR8Zj3uGxiFh59anC9xkN56PiWNJC6SMVAUuWYPLK
         TtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684150613; x=1686742613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDGTIMvQ20JVretXaWpYChh5fuqmnmjbHjkoKJsET3E=;
        b=Y/rcGbqkZMlFB1D3Isilx2TeDtyY92ROEqqqNm8fJpOiVOCa/aCWH1g4mrvQf03yPe
         Byz2mAxAQnp+M8+jfB/c+8WcPvuZjKGAUctELIAIF8xB2+EIBd3FEGXU2eKjWYcybQHy
         QbOT58rlTiJJz0mwDDQR9N6Wj7mC2aH49Zmpa+kVP3r8ENJPzea2Xv4DICv8JlCiSDhn
         zBa4cYv/0VdbowpiX1Cn5Y6iSo+9B4GFegyWIKMEnfrJNxcOWJNvT3aCQWIHiWeezM3S
         T6uY6aFNShXus2qVFRR9HTIXyhWeyE5CIho+M7KLDGh75F6Uzvr/wI9PfTHKl/ZYoo3S
         gYTQ==
X-Gm-Message-State: AC+VfDyNEvOq4XXFrIgRw1KGshzX9i0pfC5q5q87m9UeXCmPzK/n+Nai
        SZa5Y9jMk0EOd/I+5h307Nnn
X-Google-Smtp-Source: ACHHUZ7p1EfpEfxZTNZfQR84HRz/yhR66O35QNmEBHtA7e0wDXhMBrPFi4yV+hz8WZJN8J5bhTiJAA==
X-Received: by 2002:a17:903:245:b0:1a9:85f2:5df6 with SMTP id j5-20020a170903024500b001a985f25df6mr40646014plh.6.1684150613021;
        Mon, 15 May 2023 04:36:53 -0700 (PDT)
Received: from thinkpad ([120.138.12.27])
        by smtp.gmail.com with ESMTPSA id u5-20020a170903124500b001ae2b94701fsm203842plh.21.2023.05.15.04.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 04:36:52 -0700 (PDT)
Date:   Mon, 15 May 2023 17:06:47 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kishon VijayAbraham I <kvijayab@amd.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 7/7] PCI: endpoint: Add PCI Endpoint function driver
 for MHI bus
Message-ID: <20230515113647.GA42703@thinkpad>
References: <20230314044623.10254-1-manivannan.sadhasivam@linaro.org>
 <20230314044623.10254-8-manivannan.sadhasivam@linaro.org>
 <d25fdf75-e1fe-b83b-cb9c-ec0fb62f9254@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d25fdf75-e1fe-b83b-cb9c-ec0fb62f9254@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On Mon, May 15, 2023 at 01:37:28PM +0530, Kishon VijayAbraham I wrote:
> Hi Manivannan,
> 
> On 3/14/2023 10:16 AM, Manivannan Sadhasivam wrote:
> > Add PCI Endpoint driver for the Qualcomm MHI (Modem Host Interface) bus.
> > The driver implements the MHI function over PCI in the endpoint device
> > such as SDX55 modem. The MHI endpoint function driver acts as a
> > controller driver for the MHI Endpoint stack and carries out all PCI
> > related activities like mapping the host memory using iATU, triggering
> > MSIs etc...
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/pci/endpoint/functions/Kconfig       |  10 +
> >   drivers/pci/endpoint/functions/Makefile      |   1 +
> >   drivers/pci/endpoint/functions/pci-epf-mhi.c | 454 +++++++++++++++++++
> >   3 files changed, 465 insertions(+)
> >   create mode 100644 drivers/pci/endpoint/functions/pci-epf-mhi.c
> > 
> > diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> > index 9fd560886871..f5171b4fabbe 100644
> > --- a/drivers/pci/endpoint/functions/Kconfig
> > +++ b/drivers/pci/endpoint/functions/Kconfig
> > @@ -37,3 +37,13 @@ config PCI_EPF_VNTB
> >   	  between PCI Root Port and PCIe Endpoint.
> >   	  If in doubt, say "N" to disable Endpoint NTB driver.
> > +
> > +config PCI_EPF_MHI
> > +	tristate "PCI Endpoint driver for MHI bus"
> > +	depends on PCI_ENDPOINT && MHI_BUS_EP
> > +	help
> > +	   Enable this configuration option to enable the PCI Endpoint
> > +	   driver for Modem Host Interface (MHI) bus in Qualcomm Endpoint
> > +	   devices such as SDX55.
> > +
> > +	   If in doubt, say "N" to disable Endpoint driver for MHI bus.
> > diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
> > index 5c13001deaba..696473fce50e 100644
> > --- a/drivers/pci/endpoint/functions/Makefile
> > +++ b/drivers/pci/endpoint/functions/Makefile
> > @@ -6,3 +6,4 @@
> >   obj-$(CONFIG_PCI_EPF_TEST)		+= pci-epf-test.o
> >   obj-$(CONFIG_PCI_EPF_NTB)		+= pci-epf-ntb.o
> >   obj-$(CONFIG_PCI_EPF_VNTB) 		+= pci-epf-vntb.o
> > +obj-$(CONFIG_PCI_EPF_MHI)		+= pci-epf-mhi.o
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> > new file mode 100644
> > index 000000000000..03e7f42663b3
> > --- /dev/null
> > +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> .
> .
> <snip>
> .
> .
> > +static int pci_epf_mhi_link_up(struct pci_epf *epf)
> > +{
> > +	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
> > +	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
> > +	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
> > +	struct pci_epc *epc = epf->epc;
> > +	struct device *dev = &epf->dev;
> > +	int ret;
> > +
> > +	mhi_cntrl->mmio = epf_mhi->mmio;
> > +	mhi_cntrl->irq = epf_mhi->irq;
> > +	mhi_cntrl->mru = info->mru;
> > +
> > +	/* Assign the struct dev of PCI EP as MHI controller device */
> > +	mhi_cntrl->cntrl_dev = epc->dev.parent;
> > +	mhi_cntrl->raise_irq = pci_epf_mhi_raise_irq;
> > +	mhi_cntrl->alloc_map = pci_epf_mhi_alloc_map;
> > +	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
> > +	mhi_cntrl->read_from_host = pci_epf_mhi_read_from_host;
> > +	mhi_cntrl->write_to_host = pci_epf_mhi_write_to_host;
> > +
> > +	/* Register the MHI EP controller */
> > +	ret = mhi_ep_register_controller(mhi_cntrl, info->config);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to register MHI EP controller: %d\n", ret);
> > +		return ret;
> > +	}
> 
> Any reason for delaying registration with MHI bus till link up? Since after
> linkup, the host can start using the device, this should be doing minimal
> stuff IMHO. Or is there further handshake between the host side MHI driver
> and the endpoint side MHI driver?
> 

Yes, there are further handshakes required between ep and host before the host
can start using MHI and this is done during mhi_ep_power_up(). Moreover,
registering the controller during link_up event allows us to do cleanup properly
when the link goes down.

- Mani
 
> Thanks,
> Kishon

-- 
மணிவண்ணன் சதாசிவம்
