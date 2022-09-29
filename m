Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3245EFD87
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiI2TAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiI2TAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:00:25 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A02422D2;
        Thu, 29 Sep 2022 12:00:20 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id s6so3604546lfo.7;
        Thu, 29 Sep 2022 12:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=SY/4WkYOmkl8lLhwHjGDsTY18oy7FqnoV1a67hyhnvg=;
        b=iynaTUJuGEJ1xYv61AyJ2C63AHxExlrneQBTLQHAC136VKy9J6K0tbozr81Bvir/AI
         SfS9ZcWx+Ba2isbfcYjwoR2i8SMANTpsDujvlD/iFD1c21YVibAMbuqJda7JgMyvUiFm
         /e68snbouSihBiHuSbwMYPby2AKiridgYC/+YmuI4dtRqw3NwEIp72wTUBOaWLkJBNNX
         CUWuQO4Cwi/bPFc5A1Lmqd5p73xZXF8wTME0Rp41lasOy4x7A3qD3CEhBiuR8oY8gSLX
         PBJ4DegqNqspXOLs8t6TLEK3h5rOlhVKliFhtT8vHXCLTr+x5NEr6yZ71KEgJSd7a+0K
         wwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SY/4WkYOmkl8lLhwHjGDsTY18oy7FqnoV1a67hyhnvg=;
        b=DQQ8MyRlNyjAh/Rz8Z6ZnsmvDRXSQvoDnAbd2tFYNZesG5ps+fzjepyjlIasPj9Gzb
         0xH4cd+KTvD7X8oQrY8+LuGwltsHOwLq8gigW0izoySixAuMXOE5K3NztEKPBgI6Vmnf
         jNloa3BCsnANtHKahtcQuM/f3UPk7gcTzPCTOHgHXeeckAkMLIKHqA8O9vcH1ujh6POo
         fyainmtFFrqezqkQPmtdXVkSzaeUQW+28B39knHlKOH1UUaKUiPrYy1UNVObPAAUhIAc
         fYYtygfkbdqahirN04eUZaLjZkbQtuwMxkRGBMMtfllazkqBZ8FSFX1TQgd4QiKWpPgZ
         14kg==
X-Gm-Message-State: ACrzQf2yuJCTZnMF3CJoRvVyI08OCnnT6IxYvQ6/b/dv8rjW3MJuJTuH
        J98z9GUMYteU/qihW33UCho=
X-Google-Smtp-Source: AMsMyM5cwuQ9wtdC6uw0DRfreE0DdPeVCoj9/HI5U7ukZrMzDFqywqPHQzNieZy0iKIdpYEjhnIN0w==
X-Received: by 2002:a05:6512:3b9f:b0:499:198:aed1 with SMTP id g31-20020a0565123b9f00b004990198aed1mr1910102lfv.448.1664478018691;
        Thu, 29 Sep 2022 12:00:18 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b00497aae401edsm28248lfb.109.2022.09.29.12.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:00:17 -0700 (PDT)
Date:   Thu, 29 Sep 2022 22:00:15 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     William McVicker <willmcvicker@google.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 2/2] PCI: dwc: Add support for 64-bit MSI target
 address
Message-ID: <20220929190015.n3gxufrk7r4p27n5@mobilestation>
References: <20220825185026.3816331-1-willmcvicker@google.com>
 <20220825185026.3816331-3-willmcvicker@google.com>
 <20220928120510.rkdlnczytxuioxcn@mobilestation>
 <YzSJ2ioEeRhHC6zn@google.com>
 <YzVTmy9MWh+AjshC@lpieralisi>
 <YzXo2cu/IrhojbYU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzXo2cu/IrhojbYU@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 06:50:01PM +0000, William McVicker wrote:
> On 09/29/2022, Lorenzo Pieralisi wrote:
> > On Wed, Sep 28, 2022 at 05:52:26PM +0000, William McVicker wrote:
> > > On 09/28/2022, Serge Semin wrote:
> > > > On Thu, Aug 25, 2022 at 06:50:25PM +0000, Will McVicker wrote:
> > > > > Since not all devices require a 32-bit MSI address, add support to the
> > > > > PCIe host driver to allow setting the DMA mask to 64-bits if the 32-bit
> > > > > allocation fails. This allows kernels to disable ZONE_DMA32 and bounce
> > > > > buffering (swiotlb) without risking not being able to get a 32-bit address
> > > > > during DMA allocation.
> > > > 
> > > > What is a problem in having the ZONE_DMA32 enabled anyway?
> > > 
> > > On Android most devices don't have a 32-bit limitation. Several Android OEMs
> > > have reported significant enough performance improvements after disabling
> > > ZONE_DMA32. These include reducing memory usage, improving the time spent by
> > > kswapd, improving direct reclaim, and improving app launch time.
> > > 
> > > So this patch series was introduced to remove the dependency on ZONE_DMA32 for
> > > the DW PCIe drivers.
> > > 
> > > > 
> > > > > 
> > > > > Basically, in the slim chance that there are no 32-bit allocations
> > > > > available, the current PCIe host driver will fail to allocate the msi_msg
> > > > > page due to a DMA address overflow (seen in [1]). With this patch, the
> > > > > PCIe host can retry the allocation with a 64-bit DMA mask if the current
> > > > > PCIe device advertises 64-bit support via its MSI capabilities.
> > > > > 
> > > > > [1] https://lore.kernel.org/all/Yo0soniFborDl7+C@google.com/
> > > > 
> > > > Note the reported error isn't caused by the allocation procedure, but
> > > > by the mapping procedure.
> > > > 
> > > > > 
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > Acked-by: Jingoo Han <jingoohan1@gmail.com>
> > > > > ---
> > > > >  .../pci/controller/dwc/pcie-designware-host.c | 38 ++++++++++++++-----
> > > > >  drivers/pci/controller/dwc/pcie-designware.c  |  8 ++++
> > > > >  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
> > > > >  3 files changed, 38 insertions(+), 9 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > index 39f3b37d4033..8928a9a29d58 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > @@ -330,6 +330,9 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > > > >  	u64 *msi_vaddr;
> > > > >  	int ret;
> > > > >  	u32 ctrl, num_ctrls;
> > > > > +	bool msi_64bit = false;
> > > > > +	bool retry_64bit = false;
> > > > > +	u16 msi_capabilities;
> > > > >  
> > > > >  	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
> > > > >  		pp->irq_mask[ctrl] = ~0;
> > > > > @@ -367,16 +370,33 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > > > >  						    dw_chained_msi_isr, pp);
> > > > >  	}
> > > > >  
> > > > > -	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > > > > -	if (ret)
> > > > > -		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> > > > 
> > > > > +	msi_capabilities = dw_pcie_msi_capabilities(pci);
> > > > > +	if (msi_capabilities & PCI_MSI_FLAGS_ENABLE)
> > > > > +		msi_64bit = msi_capabilities & PCI_MSI_FLAGS_64BIT;
> > > > 
> > > > Note this capability flag has nothing to do with the DW PCIe iMSI-RX
> > > > engine, which is used here to detect and report MSI TLPs. By design
> > > > iMSI-RX always support 64-bit addresses. If you imply having that flag
> > > > set by the DW PCIe platform drivers on the platform-specific probe
> > > > stage as an indication of MSI address range, then ok.
> > > 
> > > Right. The DW PCIe device driver can set this flag during probe before calling
> > > dw_pcie_host init() to ensure that we will always successfully allocate and map
> > > the MSI target address (as required to return successfully from
> > > dw_pcie_host_init()).
> > > 
> > > > 
> > > > >  
> > > > > -	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > > > > -					GFP_KERNEL);
> > > > > -	if (!msi_vaddr) {
> > > > > -		dev_err(dev, "Failed to alloc and map MSI data\n");
> > > > > -		dw_pcie_free_msi(pp);
> > > > > -		return -ENOMEM;
> > > > > +	while (true) {
> > > > > +		dev_dbg(dev, "Setting MSI DMA mask to %s-bit.\n",
> > > > > +			retry_64bit ? "64" : "32");
> > > > 
> > > > > +		ret = dma_set_mask_and_coherent(dev, retry_64bit ?
> > > > > +						DMA_BIT_MASK(64) :
> > > > > +						DMA_BIT_MASK(32));
> > > > 
> > > > I'd suggest to just drop this. No DMA actually performed on getting the
> > > > MSI TLPs. So modifying the device DMA-mask due to something which
> > > > doesn't cause DMA and based on the flag which doesn't indicates the
> > > > device DMA-capability is at least inappropriate.
> > > > 
> > > > > +		if (ret)
> > > > > +			dev_warn(dev, "Failed to set DMA mask to %s-bit.\n",
> > > > > +				 retry_64bit ? "64" : "32");
> > > > > +
> > > > 
> > > > > +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > > > > +						GFP_KERNEL);
> > > > 
> > > > As I noted earlier the DMA-coherent memory can be too expensive. So
> > > > it's a waste of one allocating with no intent of usage. Instead of this
> > > > just get back the alloc_page() method here and pass the flag GFP_DMA32
> > > > to that function if MSI-capability reported the PCI_MSI_FLAGS_64BIT
> > > > unset.
> > > 
> > > As mentioned above, we don't want to force this driver to require the kernel to
> > > enable ZONE_DMA32. Since no I/O happens to this buffer, could we use
> > > dma_alloc_attrs() with the DMA_ATTR_SKIP_CPU_SYNC and
> > > DMA_ATTR_NO_KERNEL_MAPPING attribute? Would that address the "too expensive"
> > > issues you're referring to?
> > > 
> > > With regards to the DMA mask, I'm okay with moving that out of the host
> > > controller and into the DW PCIe device driver. That would address all of my
> > > issues and we could just drop the logic for checking the PCI_MSI_FLAGS_64BIT.
> > > However, I'm not the one you to convince to do that.
> > 
> > We are late -rc7 and it does not look like we are converging on this
> > discussion - I will wait till tomorrow but then I will have to drop
> > 
> > https://lore.kernel.org/linux-pci/20220825235404.4132818-1-willmcvicker@google.com
> > 
> > from the PCI queue for v6.1 so that we can restart from a clean slate.
> > 
> > Lorenzo
> > 
> 
> Hi Lorenzo,
> 
> Based on Robin's response [1], I don't think we should change the
> implementation based on MIPS32 until we have (1) someone showing MIPS32 is
> using this driver and 

This patch adds the DW PCIe controller implemented in the framework of
MIPS32 arch:
https://lore.kernel.org/linux-pci/20220822184701.25246-21-Sergey.Semin@baikalelectronics.ru/

> (2) that there's an actual perf regression when using
> dmam_alloc_coherent(). My patch series addresses a real issue by removing the
> dependency on ZONE_DMA32.

What about finding out what is a root cause of the performance
degradation instead of just dropping the whole standard zone support?

> Even if we did drop my patches, it won't solve
> Serge's DMA mask issues since the DW PCIe host driver will continue to
> unconditionally set the mask to 32-bits.

If you moved the DMA-mask setting to the platform driver that would
have solved my problems. I am pretty much sure the generic code
shouldn't be altering the DMA-mask if it isn't aware of the actual
device capability. In case of DW PCIe controller the AXI-bus address
width is a platform specific parameter and the generic DW PCIe code
doesn't know which width is valid.

-Sergey

> 
> [1] https://lore.kernel.org/linux-pci/4dc31a63-00b1-f379-c5ac-7dc9425937f4@arm.com/
> 
> Thanks,
> Will
> 
> > > Regards,
> > > Will
> > > 
> > > > 
> > > > -Sergey
> > > > 
> > > > > +		if (!msi_vaddr) {
> > > > > +			dev_err(dev, "Failed to alloc and map MSI data\n");
> > > > > +			if (msi_64bit && !retry_64bit) {
> > > > > +				retry_64bit = true;
> > > > > +				continue;
> > > > > +			}
> > > > > +
> > > > > +			dw_pcie_free_msi(pp);
> > > > > +			return -ENOMEM;
> > > > > +		}
> > > > > +		break;
> > > > >  	}
> > > > >  
> > > > >  	return 0;
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > index c6725c519a47..650a7f22f9d0 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > @@ -82,6 +82,14 @@ u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
> > > > >  
> > > > > +u16 dw_pcie_msi_capabilities(struct dw_pcie *pci)
> > > > > +{
> > > > > +	u8 offset;
> > > > > +
> > > > > +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> > > > > +	return dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
> > > > > +}
> > > > > +
> > > > >  static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
> > > > >  					    u8 cap)
> > > > >  {
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > > > index a871ae7eb59e..45fcdfc8c035 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > > @@ -332,6 +332,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
> > > > >  
> > > > >  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
> > > > >  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
> > > > > +u16 dw_pcie_msi_capabilities(struct dw_pcie *pci);
> > > > >  
> > > > >  int dw_pcie_read(void __iomem *addr, int size, u32 *val);
> > > > >  int dw_pcie_write(void __iomem *addr, int size, u32 val);
> > > > > -- 
> > > > > 2.37.2.672.g94769d06f0-goog
> > > > > 
> > > > > 
> > > 
