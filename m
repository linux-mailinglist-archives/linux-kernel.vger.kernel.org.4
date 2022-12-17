Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D6464FB16
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 17:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiLQQnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 11:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLQQnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 11:43:17 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C863E13D13;
        Sat, 17 Dec 2022 08:43:15 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NZBZX1L2zz67kTG;
        Sun, 18 Dec 2022 00:41:56 +0800 (CST)
Received: from localhost (10.81.207.254) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 17 Dec
 2022 16:43:13 +0000
Date:   Sat, 17 Dec 2022 16:43:11 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V4 3/9] cxl/mem: Wire up event interrupts
Message-ID: <20221217164311.00004cd7@Huawei.com>
In-Reply-To: <Y5zkNxGan2rmSJW0@iweiny-desk3>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
        <20221212070627.1372402-4-ira.weiny@intel.com>
        <20221216182110.00003f62@Huawei.com>
        <Y5zkNxGan2rmSJW0@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.207.254]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Fri, 16 Dec 2022 13:33:43 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> On Fri, Dec 16, 2022 at 06:21:10PM +0000, Jonathan Cameron wrote:
> > On Sun, 11 Dec 2022 23:06:21 -0800
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
> > > then the PCI infrastructure will allocate that number.  Upon successful
> > > allocation, users can plug in their respective isr at any point
> > > thereafter.
> > > 
> > > CXL device events are signaled via interrupts.  Each event log may have
> > > a different interrupt message number.  These message numbers are
> > > reported in the Get Event Interrupt Policy mailbox command.
> > > 
> > > Add interrupt support for event logs.  Interrupts are allocated as
> > > shared interrupts.  Therefore, all or some event logs can share the same
> > > message number.
> > > 
> > > In addition all logs are queried on any interrupt in order of the most
> > > to least severe based on the status register.
> > > 
> > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>  
> > 
> > Sometimes it feels like we go around in circles as I'm sure we've
> > fixed this at least 3 times now in different sets that got dropped
> > (was definitely in the DOE interrupt support set and was controversial ;)  
> 
> Well I certainly seem to be spinning ATM.  I probably need more eggnog.  ;-)
> 
> > 
> > Nothing in this patch set calls pci_set_master() so no interrupts
> > will even be delivered.  
> 
> Is this a bug in Qemu then?  Because this _is_ tested and irqs _were_
> delivered.  I thought we determined that pci_set_master() was called in
> pcim_enable_device() but I don't see that now.  :-(
> 
> What I do know is this works with Qemu.  :-/

Without the addition of a pci_set_master() the kernel code, 
I don't get any interrupts on my arm64 test setup. Only reason I realized the
call was missing.  Possible there is something different on x86 I guess.

Jonathan

> 
> Ira
> 
> > I don't think there are any sets in flight
> > that would fix that.
> > 
> > Jonathan
> > 
> >   
> > > 
> > > ---
> > > Changes from V3:
> > > 	Adjust based on changes in patch 1
> > > 	Consolidate event setup into cxl_event_config()
> > > 	Consistently use cxl_event_* for function names
> > > 	Remove cxl_event_int_is_msi()
> > > 	Ensure DCD log is ignored in status
> > > 	Simplify event status loop logic
> > > 	Dan
> > > 		Fail driver load if the irq's are not allocated
> > > 		move cxl_event_config_msgnums() to pci.c
> > > 		s/CXL_PCI_REQUIRED_VECTORS/CXL_PCI_DEFAULT_MAX_VECTORS
> > > 		s/devm_kmalloc/devm_kzalloc
> > > 		Fix up pci_alloc_irq_vectors() comment
> > > 		Pass pdev to cxl_alloc_irq_vectors()
> > > 		Check FW irq policy prior to configuration
> > > 	Jonathan
> > > 		Use FIELD_GET instead of manual masking
> > > ---
> > >  drivers/cxl/cxl.h    |   4 +
> > >  drivers/cxl/cxlmem.h |  19 ++++
> > >  drivers/cxl/cxlpci.h |   6 ++
> > >  drivers/cxl/pci.c    | 208 +++++++++++++++++++++++++++++++++++++++++--
> > >  4 files changed, 231 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > index 5974d1082210..b3964149c77b 100644
> > > --- a/drivers/cxl/cxl.h
> > > +++ b/drivers/cxl/cxl.h
> > > @@ -168,6 +168,10 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
> > >  				 CXLDEV_EVENT_STATUS_FAIL |	\
> > >  				 CXLDEV_EVENT_STATUS_FATAL)
> > >  
> > > +/* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
> > > +#define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
> > > +#define CXLDEV_EVENT_INT_MSGNUM_MASK	GENMASK(7, 4)
> > > +
> > >  /* CXL 2.0 8.2.8.4 Mailbox Registers */
> > >  #define CXLDEV_MBOX_CAPS_OFFSET 0x00
> > >  #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index dd9aa3dd738e..bd8bfbe61ec8 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > > @@ -194,6 +194,23 @@ struct cxl_endpoint_dvsec_info {
> > >  	struct range dvsec_range[2];
> > >  };
> > >  
> > > +/**
> > > + * Event Interrupt Policy
> > > + *
> > > + * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
> > > + */
> > > +enum cxl_event_int_mode {
> > > +	CXL_INT_NONE		= 0x00,
> > > +	CXL_INT_MSI_MSIX	= 0x01,
> > > +	CXL_INT_FW		= 0x02
> > > +};
> > > +struct cxl_event_interrupt_policy {
> > > +	u8 info_settings;
> > > +	u8 warn_settings;
> > > +	u8 failure_settings;
> > > +	u8 fatal_settings;
> > > +} __packed;
> > > +
> > >  /**
> > >   * struct cxl_event_state - Event log driver state
> > >   *
> > > @@ -288,6 +305,8 @@ enum cxl_opcode {
> > >  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> > >  	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
> > >  	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
> > > +	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
> > > +	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
> > >  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
> > >  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
> > >  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> > > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > > index 77dbdb980b12..a8ea04f536ab 100644
> > > --- a/drivers/cxl/cxlpci.h
> > > +++ b/drivers/cxl/cxlpci.h
> > > @@ -53,6 +53,12 @@
> > >  #define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
> > >  #define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
> > >  
> > > +/*
> > > + * NOTE: Currently all the functions which are enabled for CXL require their
> > > + * vectors to be in the first 16.  Use this as the default max.
> > > + */
> > > +#define CXL_PCI_DEFAULT_MAX_VECTORS 16
> > > +
> > >  /* Register Block Identifier (RBI) */
> > >  enum cxl_regloc_type {
> > >  	CXL_REGLOC_RBI_EMPTY = 0,
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index a2d8382bc593..d42d87faddb8 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -445,6 +445,201 @@ static int cxl_mem_alloc_event_buf(struct cxl_dev_state *cxlds)
> > >  	return 0;
> > >  }
> > >  
> > > +static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
> > > +{
> > > +	int nvecs;
> > > +
> > > +	/*
> > > +	 * CXL requires MSI/MSIX support.
> > > +	 *
> > > +	 * Additionally pci_alloc_irq_vectors() handles calling
> > > +	 * pci_free_irq_vectors() automatically despite not being called
> > > +	 * pcim_*.  See pci_setup_msi_context().
> > > +	 */
> > > +	nvecs = pci_alloc_irq_vectors(pdev, 1, CXL_PCI_DEFAULT_MAX_VECTORS,
> > > +				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
> > > +	if (nvecs < 1) {
> > > +		dev_dbg(&pdev->dev, "Failed to alloc irq vectors: %d\n", nvecs);
> > > +		return -ENXIO;
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > > +struct cxl_dev_id {
> > > +	struct cxl_dev_state *cxlds;
> > > +};
> > > +
> > > +static irqreturn_t cxl_event_thread(int irq, void *id)
> > > +{
> > > +	struct cxl_dev_id *dev_id = id;
> > > +	struct cxl_dev_state *cxlds = dev_id->cxlds;
> > > +	u32 status;
> > > +
> > > +	do {
> > > +		/*
> > > +		 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
> > > +		 * ignore the reserved upper 32 bits
> > > +		 */
> > > +		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> > > +		/* Ignore logs unknown to the driver */
> > > +		status &= CXLDEV_EVENT_STATUS_ALL;
> > > +		if (!status)
> > > +			break;
> > > +		cxl_mem_get_event_records(cxlds, status);
> > > +		cond_resched();
> > > +	} while (status);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
> > > +{
> > > +	struct device *dev = cxlds->dev;
> > > +	struct pci_dev *pdev = to_pci_dev(dev);
> > > +	struct cxl_dev_id *dev_id;
> > > +	int irq;
> > > +
> > > +	if (FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting) != CXL_INT_MSI_MSIX)
> > > +		return -ENXIO;
> > > +
> > > +	/* dev_id must be globally unique and must contain the cxlds */
> > > +	dev_id = devm_kzalloc(dev, sizeof(*dev_id), GFP_KERNEL);
> > > +	if (!dev_id)
> > > +		return -ENOMEM;
> > > +	dev_id->cxlds = cxlds;
> > > +
> > > +	irq =  pci_irq_vector(pdev,
> > > +			      FIELD_GET(CXLDEV_EVENT_INT_MSGNUM_MASK, setting));
> > > +	if (irq < 0)
> > > +		return irq;
> > > +
> > > +	return devm_request_threaded_irq(dev, irq, NULL, cxl_event_thread,
> > > +					 IRQF_SHARED, NULL, dev_id);
> > > +}
> > > +
> > > +static int cxl_event_get_int_policy(struct cxl_dev_state *cxlds,
> > > +				    struct cxl_event_interrupt_policy *policy)
> > > +{
> > > +	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> > > +		.opcode = CXL_MBOX_OP_GET_EVT_INT_POLICY,
> > > +		.payload_out = policy,
> > > +		.size_out = sizeof(*policy),
> > > +	};
> > > +	int rc;
> > > +
> > > +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> > > +	if (rc < 0)
> > > +		dev_err(cxlds->dev, "Failed to get event interrupt policy : %d",
> > > +			rc);
> > > +
> > > +	return rc;
> > > +}
> > > +
> > > +static int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
> > > +				    struct cxl_event_interrupt_policy *policy)
> > > +{
> > > +	struct cxl_mbox_cmd mbox_cmd;
> > > +	int rc;
> > > +
> > > +	policy->info_settings = CXL_INT_MSI_MSIX;
> > > +	policy->warn_settings = CXL_INT_MSI_MSIX;
> > > +	policy->failure_settings = CXL_INT_MSI_MSIX;
> > > +	policy->fatal_settings = CXL_INT_MSI_MSIX;
> > > +
> > > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > > +		.opcode = CXL_MBOX_OP_SET_EVT_INT_POLICY,
> > > +		.payload_in = policy,
> > > +		.size_in = sizeof(*policy),
> > > +	};
> > > +
> > > +	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> > > +	if (rc < 0) {
> > > +		dev_err(cxlds->dev, "Failed to set event interrupt policy : %d",
> > > +			rc);
> > > +		return rc;
> > > +	}
> > > +
> > > +	/* Retrieve final interrupt settings */
> > > +	return cxl_event_get_int_policy(cxlds, policy);
> > > +}
> > > +
> > > +static int cxl_event_irqsetup(struct cxl_dev_state *cxlds)
> > > +{
> > > +	struct cxl_event_interrupt_policy policy;
> > > +	int rc;
> > > +
> > > +	rc = cxl_event_config_msgnums(cxlds, &policy);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	rc = cxl_event_req_irq(cxlds, policy.info_settings);
> > > +	if (rc) {
> > > +		dev_err(cxlds->dev, "Failed to get interrupt for event Info log\n");
> > > +		return rc;
> > > +	}
> > > +
> > > +	rc = cxl_event_req_irq(cxlds, policy.warn_settings);
> > > +	if (rc) {
> > > +		dev_err(cxlds->dev, "Failed to get interrupt for event Warn log\n");
> > > +		return rc;
> > > +	}
> > > +
> > > +	rc = cxl_event_req_irq(cxlds, policy.failure_settings);
> > > +	if (rc) {
> > > +		dev_err(cxlds->dev, "Failed to get interrupt for event Failure log\n");
> > > +		return rc;
> > > +	}
> > > +
> > > +	rc = cxl_event_req_irq(cxlds, policy.fatal_settings);
> > > +	if (rc) {
> > > +		dev_err(cxlds->dev, "Failed to get interrupt for event Fatal log\n");
> > > +		return rc;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static bool cxl_event_int_is_fw(u8 setting)
> > > +{
> > > +	u8 mode = FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting);
> > > +
> > > +	return mode == CXL_INT_FW;
> > > +}
> > > +
> > > +static int cxl_event_config(struct pci_host_bridge *host_bridge,
> > > +			    struct cxl_dev_state *cxlds)
> > > +{
> > > +	struct cxl_event_interrupt_policy policy;
> > > +	int rc;
> > > +
> > > +	/*
> > > +	 * When BIOS maintains CXL error reporting control, it will process
> > > +	 * event records.  Only one agent can do so.
> > > +	 */
> > > +	if (!host_bridge->native_cxl_error)
> > > +		return 0;
> > > +
> > > +	rc = cxl_event_get_int_policy(cxlds, &policy);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	if (cxl_event_int_is_fw(policy.info_settings) ||
> > > +	    cxl_event_int_is_fw(policy.warn_settings) ||
> > > +	    cxl_event_int_is_fw(policy.failure_settings) ||
> > > +	    cxl_event_int_is_fw(policy.fatal_settings)) {
> > > +		dev_err(cxlds->dev, "FW still in control of Event Logs despite _OSC settings\n");
> > > +		return -EBUSY;
> > > +	}
> > > +
> > > +	rc = cxl_event_irqsetup(cxlds);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  {
> > >  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> > > @@ -519,6 +714,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  	if (rc)
> > >  		return rc;
> > >  
> > > +	rc = cxl_alloc_irq_vectors(pdev);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > >  	cxlmd = devm_cxl_add_memdev(cxlds);
> > >  	if (IS_ERR(cxlmd))
> > >  		return PTR_ERR(cxlmd);
> > > @@ -527,12 +726,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  	if (rc)
> > >  		return rc;
> > >  
> > > -	/*
> > > -	 * When BIOS maintains CXL error reporting control, it will process
> > > -	 * event records.  Only one agent can do so.
> > > -	 */
> > > -	if (host_bridge->native_cxl_error)
> > > -		cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> > > +	rc = cxl_event_config(host_bridge, cxlds);
> > > +	if (rc)
> > > +		return rc;
> > >  
> > >  	if (cxlds->regs.ras) {
> > >  		pci_enable_pcie_error_reporting(pdev);  
> >   
> 

