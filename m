Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1A5607316
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiJUI60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiJUI6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:58:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6B0250EEB;
        Fri, 21 Oct 2022 01:58:22 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MtyyZ6Hxwz6H7BS;
        Fri, 21 Oct 2022 16:57:10 +0800 (CST)
Received: from frapeml100002.china.huawei.com (7.182.85.26) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:58:20 +0200
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100002.china.huawei.com (7.182.85.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:58:20 +0200
Received: from localhost (10.81.215.159) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 09:58:19 +0100
Date:   Fri, 21 Oct 2022 09:58:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <bwidawsk@kernel.org>, <vishal.l.verma@intel.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221021095818.00006ed1@huawei.com>
In-Reply-To: <Y1IcpaodrrVrkEcL@iweiny-desk3>
References: <20221018030010.20913-1-dave@stgolabs.net>
        <20221018030010.20913-2-dave@stgolabs.net>
        <20221018103619.00004c39@huawei.com>
        <20221018115227.00002a4c@huawei.com>
        <Y1IcpaodrrVrkEcL@iweiny-desk3>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.215.159]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Thu, 20 Oct 2022 21:14:29 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Tue, Oct 18, 2022 at 11:52:27AM +0100, Jonathan Cameron wrote:
> > On Tue, 18 Oct 2022 10:36:19 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> > > On Mon, 17 Oct 2022 20:00:09 -0700
> > > Davidlohr Bueso <dave@stgolabs.net> wrote:
> > >   
> > > > Introduce a generic irq table for CXL components/features that can have
> > > > standard irq support - DOE requires dynamic vector sizing and is not
> > > > considered here. For now the table is empty.
> > > > 
> > > > Create an infrastructure to query the max vectors required for the CXL
> > > > device. Upon successful allocation, users can plug in their respective isr
> > > > at any point thereafter, which is supported by a new cxlds->has_irq flag,
> > > > for example, if the irq setup is not done in the PCI driver, such as
> > > > the case of the CXL-PMU.
> > > > 
> > > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>    
> > > 
> > > A few nitpicks inline.
> > > 
> > > With the comment one tidied up (other one optional)
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > I'll rebase my cpmu code on top of this shortly.  
> > Hi Davidlohr,
> > 
> > Doing the CPMU rebase has shown up that using this generic infrastructure
> > ends up rather ugly.
> > 
> > Previously I had a local array to manage the required register maps
> > that was then freed.  Now I have to move that into the cxl device state
> > just so I can get at it from the irq finding callback.
> > 
> > So I have an extra step to be able to use this generic framework.
> > 
> > 1. Query how many CPMU devices there are.  Stash that and register map
> >    info in cxlds.  I could do this in the callback but that's really really
> >    horrible layering issue as most of what is done has nothing to do
> >    with finding the vector numbers.  
> 
> FWIW I did this for the event stuff and did not find it so distasteful...  :-/
> 
> However the information I am stashing in the cxlds is all interrupt
> information.  So I think it is different from what I see in the CPMU stuff.

Right now I'm just stashing the max interrupt number to squirt into a callback
a few lines later. That feels like a hack to get around parsing the structures
4 times.  If it's an acceptable hack then fair enough.

> 
> > 2. The callback below to find those numbers 
> > 3. Registration of the cpmu devices.
> > 
> > Reality is that it is cleaner to more or less ignore the infrastructure
> > proposed in this patch.
> > 
> > 1. Query how many CPMU devices there are. Whilst there stash the maximim
> >    cpmu vector number in the cxlds.
> > 2. Run a stub in this infrastructure that does max(irq, cxlds->irq_num);
> > 3. Carry on as before.
> > 
> > Thus destroying the point of this infrastructure for that usecase at least
> > and leaving an extra bit of state in the cxl_dev_state that is just
> > to squirt a value into the callback...  
> 
> I'm not sure I follow?  Do you mean this?
> 
> static int cxl_cpmu_get_max_msgnum(struct cxl_dev_state *cxlds)
> {
> 	return cxlds->cpmu_max_vector;
> }

Yup. That state is no relevance to the cxl_dev_state outside of this tiny
block of code.  Hence I really don't like putting it in there.
  
> 
> > 
> > So with that in mind I'm withdrawing the RB above.  This looks to be
> > an idea that with hindsight doesn't necessarily pan out.
> > Long hand equivalent with the specific handling needed for each case
> > is probably going to be neater than walking a table of much more
> > restricted callbacks.  
> 
> I'm not married to the idea of the array of callbacks but I'm not sure how this
> solves having to iterate on the CPMU devices twice?

Laid that out in the other branch of the thread but basically either
1) We stash irrelevant information in cxl_dev_state just to get it into the callback
   It's not used for anything else and this makes a fiddly and non obvious tie
   up between different registration steps that appear somewhat independent.

2) We do the whole double parse twice (so 4 times in total) which is the right
   option to keep the layering if using this array of callbacks approach, but
   really ugly.  If we flatten it to straight line code there is no implication
   of layering and the state being parsed on is right there in a local variable.

I can live with it either way, but it's definitely not as pretty as it looks
for the mailbox case.

Jonathan

> 
> Ira
> 
> > Maybe there is a nice way to fit the CPMU
> > registration into this infrastructure, but I'm not immediately seeing it.
> > 
> > One other note inline via a compiler warning.
> > 
> > Jonathan
> >   
> > > 
> > > Jonathan
> > > 
> > >   
> > > > ---
> > > >  drivers/cxl/cxlmem.h |  3 ++
> > > >  drivers/cxl/pci.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 75 insertions(+)
> > > > 
> > > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > > index 88e3a8e54b6a..72b69b003302 100644
> > > > --- a/drivers/cxl/cxlmem.h
> > > > +++ b/drivers/cxl/cxlmem.h
> > > > @@ -211,6 +211,7 @@ struct cxl_endpoint_dvsec_info {
> > > >   * @info: Cached DVSEC information about the device.
> > > >   * @serial: PCIe Device Serial Number
> > > >   * @doe_mbs: PCI DOE mailbox array
> > > > + * @has_irq: PCIe MSI-X/MSI support
> > > >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> > > >   *
> > > >   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> > > > @@ -247,6 +248,8 @@ struct cxl_dev_state {
> > > >  
> > > >  	struct xarray doe_mbs;
> > > >  
> > > > +	bool has_irq;
> > > > +
> > > >  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> > > >  };
> > > >  
> > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > index faeb5d9d7a7a..9c3e95ebaa26 100644
> > > > --- a/drivers/cxl/pci.c
> > > > +++ b/drivers/cxl/pci.c
> > > > @@ -428,6 +428,73 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> > > >  	}
> > > >  }
> > > >  
> > > > +/**
> > > > + * struct cxl_irq_cap - CXL feature that is capable of receiving MSI-X/MSI irqs.
> > > > + *
> > > > + * @name: Name of the device/component generating this interrupt.
> > > > + * @get_max_msgnum: Get the feature's largest interrupt message number.  If the
> > > > + *		    feature does not have the Interrupt Supported bit set, then
> > > > + *		    return -1.
> > > > + */
> > > > +struct cxl_irq_cap {
> > > > +	const char *name;
> > > > +	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
> > > > +};
> > > > +
> > > > +static const struct cxl_irq_cap cxl_irq_cap_table[] = {
> > > > +	NULL  
> > 
> > That's not valid, just make it empty instead.
> > 
> >   
> > > > +};
> > > > +
> > > > +static void cxl_pci_free_irq_vectors(void *data)
> > > > +{
> > > > +	pci_free_irq_vectors(data);
> > > > +}
> > > > +
> > > > +/*
> > > > + * Attempt to allocate the largest amount of necessary vectors.
> > > > + *
> > > > + * Returns 0 upon a successful allocation of *all* vectors, or a    
> > > 
> > > Technically not all vectors.  If we wanted to do that we could
> > > just directly query that via pci_msix_vec_count() etc that gets
> > > it from the MSIX capability. That's frowned upon because it's common
> > > to stick lots of extra vectors on the end for stuff that linux never
> > > cares about (debug etc, or optional features).
> > > 
> > > All vectors up to the maximum one the code uses would be more accurate.
> > >   
> > > > + * negative value otherwise.
> > > > + */
> > > > +static int cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> > > > +{
> > > > +	struct device *dev = cxlds->dev;
> > > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > > +	int rc, i, vectors = -1;
> > > > +
> > > > +	for (i = 0; i < ARRAY_SIZE(cxl_irq_cap_table); i++) {
> > > > +		int irq;
> > > > +
> > > > +		if (!cxl_irq_cap_table[i].get_max_msgnum)
> > > > +			continue;
> > > > +
> > > > +		irq = cxl_irq_cap_table[i].get_max_msgnum(cxlds);
> > > > +		vectors = max_t(int, irq, vectors);
> > > > +	}
> > > > +
> > > > +	/*
> > > > +	 * Semantically lack of irq support is not an error, but we
> > > > +	 * still fail to allocate, so return negative.
> > > > +	 */
> > > > +	if (vectors == -1)
> > > > +		return -1;
> > > > +
> > > > +	vectors++;
> > > > +	rc = pci_alloc_irq_vectors(pdev, vectors, vectors,
> > > > +				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
> > > > +	if (rc < 0)
> > > > +		return rc;
> > > > +
> > > > +	if (rc != vectors) {
> > > > +		dev_dbg(dev, "Not enough interrupts; use polling instead.\n");
> > > > +		/* some got allocated, clean them up */
> > > > +		cxl_pci_free_irq_vectors(pdev);
> > > > +		return -ENOSPC;
> > > > +	}
> > > > +
> > > > +	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
> > > > +}
> > > > +
> > > >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > >  {
> > > >  	struct cxl_register_map map;
> > > > @@ -494,6 +561,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > >  	if (rc)
> > > >  		return rc;
> > > >  
> > > > +	if (!cxl_pci_alloc_irq_vectors(cxlds)) {
> > > > +		cxlds->has_irq = true;
> > > > +	} else
> > > > +		cxlds->has_irq = false;
> > > > +    
> > > 	cxlds->has_irq = !(cxl_pci_aloc_irq_vectors(cxlds) < 0);
> > > 
> > > maybe...
> > >   
> > > >  	cxlmd = devm_cxl_add_memdev(cxlds);
> > > >  	if (IS_ERR(cxlmd))
> > > >  		return PTR_ERR(cxlmd);    
> > >   
> >   
> 

