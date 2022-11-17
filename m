Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DEA62D949
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiKQLUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239221AbiKQLUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:20:15 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36CB2CE2C;
        Thu, 17 Nov 2022 03:20:12 -0800 (PST)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NCclh1RtQz687SH;
        Thu, 17 Nov 2022 19:15:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 17 Nov 2022 12:20:10 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 11:20:10 +0000
Date:   Thu, 17 Nov 2022 11:20:09 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 01/11] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221117112009.00005f1d@Huawei.com>
In-Reply-To: <Y3V24PrgL0aN9P08@iweiny-desk3>
References: <20221110185758.879472-1-ira.weiny@intel.com>
        <20221110185758.879472-2-ira.weiny@intel.com>
        <20221116145341.00006411@Huawei.com>
        <Y3V24PrgL0aN9P08@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 15:48:48 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> On Wed, Nov 16, 2022 at 02:53:41PM +0000, Jonathan Cameron wrote:
> > On Thu, 10 Nov 2022 10:57:48 -0800
> > ira.weiny@intel.com wrote:
> >   
> > > From: Davidlohr Bueso <dave@stgolabs.net>
> > > 
> > > Currently the only CXL features targeted for irq support require their
> > > message numbers to be within the first 16 entries.  The device may
> > > however support less than 16 entries depending on the support it
> > > provides.
> > > 
> > > Attempt to allocate these 16 irq vectors.  If the device supports less
> > > then the PCI infrastructure will allocate that number.  Store the number
> > > of vectors actually allocated in the device state for later use
> > > by individual functions.  
> > See later patch review, but I don't think we need to store the number
> > allocated because any vector is guaranteed to be below that point  
> 
> Only as long as we stick to those functions which are guaranteed to be under
> 16.  If a device supports more than 16 and code is added to try and enable that
> irq this base support will not cover that.

It matters only if this enable is changed.  If this remains at 16, the vectors
are guaranteed to be under 16..

> 
> > (QEMU code is wrong on this at the momemt, but there are very few vectors
> >  so it hasn't mattered yet).  
> 
> How so?  Does the spec state that a device must report at least 16 vectors?

Technically QEMU upstream today uses 1 vector I think, so failure to get that
is the same as no irqs.

As we expand to more possible vectors, QEMU should adjust the reported msgnums
to fit in whatever vectors are enabled (if using msi, logic is handled
elsewhere for msix as there is an indirection in the way and I think it
is down to the OS to program that indirection correctly).  See spec language
referred to in review of the patch using the irqs.  We may never implement
that magic. but it is done correctly for other devices.

https://elixir.bootlin.com/qemu/latest/source/hw/pci-bridge/ioh3420.c#L47
is an example where aer is on vector 1 unless there is only one vector in which
case it falls back to vector 0.

Jonathan


> 
> > 
> > Otherwise, pcim fun deals with some of the cleanup you are doing again
> > here for us so can simplify this somewhat. See inline.  
> 
> Yea it is broken.
> 
> > 
> > Jonathan
> > 
> > 
> >   
> > > 
> > > Upon successful allocation, users can plug in their respective isr at
> > > any point thereafter, for example, if the irq setup is not done in the
> > > PCI driver, such as the case of the CXL-PMU.
> > > 
> > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > > 
> > > ---
> > > Changes from Ira
> > > 	Remove reviews
> > > 	Allocate up to a static 16 vectors.
> > > 	Change cover letter
> > > ---
> > >  drivers/cxl/cxlmem.h |  3 +++
> > >  drivers/cxl/cxlpci.h |  6 ++++++
> > >  drivers/cxl/pci.c    | 32 ++++++++++++++++++++++++++++++++
> > >  3 files changed, 41 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index 88e3a8e54b6a..b7b955ded3ac 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > > @@ -211,6 +211,7 @@ struct cxl_endpoint_dvsec_info {
> > >   * @info: Cached DVSEC information about the device.
> > >   * @serial: PCIe Device Serial Number
> > >   * @doe_mbs: PCI DOE mailbox array
> > > + * @nr_irq_vecs: Number of MSI-X/MSI vectors available
> > >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> > >   *
> > >   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> > > @@ -247,6 +248,8 @@ struct cxl_dev_state {
> > >  
> > >  	struct xarray doe_mbs;
> > >  
> > > +	int nr_irq_vecs;
> > > +
> > >  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> > >  };
> > >  
> > > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > > index eec597dbe763..b7f4e2f417d3 100644
> > > --- a/drivers/cxl/cxlpci.h
> > > +++ b/drivers/cxl/cxlpci.h
> > > @@ -53,6 +53,12 @@
> > >  #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
> > >  #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
> > >  
> > > +/*
> > > + * NOTE: Currently all the functions which are enabled for CXL require their
> > > + * vectors to be in the first 16.  Use this as the max.
> > > + */
> > > +#define CXL_PCI_REQUIRED_VECTORS 16
> > > +
> > >  /* Register Block Identifier (RBI) */
> > >  enum cxl_regloc_type {
> > >  	CXL_REGLOC_RBI_EMPTY = 0,
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index faeb5d9d7a7a..62e560063e50 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -428,6 +428,36 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> > >  	}
> > >  }
> > >  
> > > +static void cxl_pci_free_irq_vectors(void *data)
> > > +{
> > > +	pci_free_irq_vectors(data);
> > > +}
> > > +
> > > +static void cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> > > +{
> > > +	struct device *dev = cxlds->dev;
> > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > +	int nvecs;
> > > +	int rc;
> > > +
> > > +	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_REQUIRED_VECTORS,
> > > +				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
> > > +	if (nvecs < 0) {
> > > +		dev_dbg(dev, "Not enough interrupts; use polling instead.\n");
> > > +		return;
> > > +	}
> > > +
> > > +	rc = devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);  
> > The pci managed code always gives me a headache because there is a lot of magic
> > under the hood if you ever called pcim_enable_device() which we did.
> > 
> > Chasing through
> > 
> > pci_alloc_irq_vectors_affinity()->
> > either
> > 	__pci_enable_msix_range()
> > or
> > 	__pci_enable_msi_range()
> > 
> > they are similar
> > 	pci_setup_msi_context()
> > 		pci_setup_msi_release()
> > 			adds pcmi_msi_release devm action.
> > and that frees the vectors for us.
> > So we don't need to do it here.  
> 
> :-/
> 
> So what is the point of pci_free_irq_vectors()?  This is very confusing to have
> a function not called pcim_* [pci_alloc_irq_vectors()] do 'pcim stuff'.
> 
> Ok I'll drop this extra because I see it now.
> 
> > 
> >   
> > > +	if (rc) {
> > > +		dev_dbg(dev, "Device managed call failed; interrupts disabled.\n");
> > > +		/* some got allocated, clean them up */
> > > +		cxl_pci_free_irq_vectors(pdev);  
> > We could just leave them lying around for devm cleanup to sweep up eventually
> > or free them as you have done here.  
> 
> And besides this extra call is flat out broken.  cxl_pci_free_irq_vectors() is
> already called at this point if devm_add_action_or_reset() failed...  But I see
> this is not required.
> 
> I do plan to add a big ol' comment as to why we don't need to mirror the call
> with the corresponding 'free'.
> 
> I'll respin,
> Ira
> 
> >   
> > > +		return;
> > > +	}
> > > +
> > > +	cxlds->nr_irq_vecs = nvecs;
> > > +}
> > > +
> > >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  {
> > >  	struct cxl_register_map map;
> > > @@ -494,6 +524,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  	if (rc)
> > >  		return rc;
> > >  
> > > +	cxl_pci_alloc_irq_vectors(cxlds);
> > > +
> > >  	cxlmd = devm_cxl_add_memdev(cxlds);
> > >  	if (IS_ERR(cxlmd))
> > >  		return PTR_ERR(cxlmd);  
> >   

