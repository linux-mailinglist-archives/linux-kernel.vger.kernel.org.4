Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3DE600C02
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiJQKHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJQKG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:06:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00DD6563;
        Mon, 17 Oct 2022 03:06:58 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MrXfy3JH3z6H73n;
        Mon, 17 Oct 2022 18:05:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 12:06:55 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 11:06:49 +0100
Date:   Mon, 17 Oct 2022 11:06:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     Ira Weiny <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <bwidawsk@kernel.org>,
        <a.manzanares@samsung.com>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI/MSI-X interrupt support
Message-ID: <20221017110648.000052ba@huawei.com>
In-Reply-To: <20221017003707.e73mh2ezre52xqvd@offworld>
References: <20221014194930.2630416-1-dave@stgolabs.net>
        <20221014194930.2630416-2-dave@stgolabs.net>
        <Y0yBbjJgqyBS+viw@iweiny-desk3>
        <20221017003707.e73mh2ezre52xqvd@offworld>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
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

On Sun, 16 Oct 2022 17:37:07 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Sun, 16 Oct 2022, Ira Weiny wrote:
> 
> >> +enum {
> >> +	CXL_IRQ_NONE,
> >> +	CXL_IRQ_MSI,
> >> +};  
> >
> >I don't recall this being in v1?  
> 
> No, it wasn't. I added it because it was a clean way of doing the irq setup
> for each interested party in it's own setup call (such as I do in patch 2).
> Jonathan preferred it this way... but per all the below, it seems actually
> better to stick with the original plan and do the request_irq for all
> interested parties at once, after a succesful call to cxl_pci_alloc_irq_vectors().
> 
> >
> >Right now do we have any users who will register irq's without having MSI
> >support?  
> 
> We don't, and as you know, the fw interrupts thing is only for events; so
> actually if we were to have any kind of flags, I guess a cxlds->has_msi
> boolean would do, instead of the enum. But the below voids this I guess.

I still want that bool for the PMUs.  Might not apply everywhere but IRQ
setup for the PMU at least is a job for the cpmu driver, not the pci driver.

Just call it has_int though to avoid the msi/msix naming confusion.
Also, might just be local to function initializing the various other
devices, so passed in as a parameter to those calls so they can do
what they like with it.


> 
> >  
> >> +
> >>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
> >>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
> >>  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
> >> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> >> index 88e3a8e54b6a..ca020767f7fc 100644
> >> --- a/drivers/cxl/cxlmem.h
> >> +++ b/drivers/cxl/cxlmem.h
> >> @@ -247,6 +247,8 @@ struct cxl_dev_state {
> >>
> >>	struct xarray doe_mbs;
> >>
> >> +	int irq_type;
> >> +
> >>	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> >>  };
> >>
> >> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> >> index faeb5d9d7a7a..942c4449d30f 100644
> >> --- a/drivers/cxl/pci.c
> >> +++ b/drivers/cxl/pci.c
> >> @@ -428,6 +428,67 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
> >>	}
> >>  }
> >>
> >> +/**
> >> + * struct cxl_irq_cap - CXL feature that is capable of receiving MSI/MSI-X irqs.
> >> + *
> >> + * @name: Name of the device generating this interrupt.
> >> + * @get_max_msgnum: Get the feature's largest interrupt message number.  If the
> >> + *		    feature does not have the Interrupt Supported bit set, then
> >> + *		    return -1.
> >> + */
> >> +struct cxl_irq_cap {
> >> +	const char *name;
> >> +	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
> >> +};
> >> +
> >> +static const struct cxl_irq_cap cxl_irq_cap_table[] = { NULL };
> >> +
> >> +static void cxl_pci_free_irq_vectors(void *data)
> >> +{
> >> +	pci_free_irq_vectors(data);
> >> +}
> >> +
> >> +/*
> >> + * Attempt to allocate the largest amount of necessary vectors.
> >> + *
> >> + * Returns 0 upon a successful allocation of *all* vectors, or a
> >> + * negative value otherwise.
> >> + */
> >> +static int cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
> >> +{
> >> +	struct device *dev = cxlds->dev;
> >> +	struct pci_dev *pdev = to_pci_dev(dev);
> >> +	int rc, i, vectors = -1;
> >> +
> >> +	for (i = 0; i < ARRAY_SIZE(cxl_irq_cap_table); i++) {
> >> +		int irq;
> >> +
> >> +		if (!cxl_irq_cap_table[i].get_max_msgnum)
> >> +			continue;
> >> +
> >> +		irq = cxl_irq_cap_table[i].get_max_msgnum(cxlds);
> >> +		vectors = max_t(int, irq, vectors);
> >> +	}
> >> +
> >> +	if (vectors == -1)
> >> +		return -1;
> >> +
> >> +	vectors++;
> >> +	rc = pci_alloc_irq_vectors(pdev, vectors, vectors,
> >> +				   PCI_IRQ_MSIX | PCI_IRQ_MSI);  
> >
> >Yea without PCI_IRQ_LEGACY I don't think we need any communication about which
> >type of vectors were allocated.
> >
> >Basically if cxl_pci_alloc_irq_vectors() is successful all users can assume
> >that at least MSI is available...  
> 
> Agreed, and that's why I added the flag to indicate to the users if the previous
> cxl_pci_alloc_irq_vectors() call had been successful or not, basically to avoid
> having them unnecessarily attempt to install their isr. But again all this was
> because the request_irq() calls were now going to be in each component setup.
> 
> >
> >For the mailboxes they could key off of the message number being set in cxlds.
> >  
> >> +	if (rc < 0)
> >> +		return rc;
> >> +
> >> +	if (rc != vectors) {
> >> +		dev_err(dev, "Not enough interrupts; use polling instead.\n");
> >> +		/* some got allocated, clean them up */
> >> +		cxl_pci_free_irq_vectors(pdev);
> >> +		return -ENOSPC;
> >> +	}
> >> +
> >> +	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
> >> +}
> >> +
> >>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >>  {
> >>	struct cxl_register_map map;
> >> @@ -478,6 +539,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >>
> >>	devm_cxl_pci_create_doe(cxlds);
> >>
> >> +	if (!cxl_pci_alloc_irq_vectors(cxlds))  
> >
> >This can't be here for the event stuff because I need the mailboxes set up to
> >find out the message numbers for those events.  I had a hell of a time by
> >accident putting it here.  :-(  
> 
> I'm fine with putting this back down, right before the devm_cxl_add_memdev().

Ah. I'd missed that subtlety.

> 
> >  
> >> +		cxlds->irq_type = CXL_IRQ_MSI;
> >> +	else
> >> +		cxlds->irq_type = CXL_IRQ_NONE;
> >> +
> >>	rc = cxl_pci_setup_mailbox(cxlds);
> >>	if (rc)
> >>		return rc;  
> >
> >Can't the mailbox irq's be set up after this call?  Mailbox access during set
> >up is probably fine using polling, right?  
> 
> Again, fine by me. So we'd end up in the original:
> 
> if (!cxl_pci_alloc_irq_vectors(cxlds)) {
>     cxl_mbox_setup_irq();
>     cxl_events_setup_irq();
>     cxl_pmu_setup_irq();
> }

For the pmu just pass a flag into the existing setup call, I don't want to
see separate setup of irqs from the rest of the setup.  Not sure how this
works out for the other cases.

Jonathan



> 
> Thanks,
> Davidlohr

