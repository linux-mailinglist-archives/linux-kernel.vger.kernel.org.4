Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4308362C11D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiKPOke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiKPOk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:40:27 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF11D2700;
        Wed, 16 Nov 2022 06:40:25 -0800 (PST)
Received: from frapeml100008.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NC5FC5Lltz6H6hq;
        Wed, 16 Nov 2022 22:35:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 15:40:23 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 14:40:22 +0000
Date:   Wed, 16 Nov 2022 14:40:21 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 08/11] cxl/mem: Wire up event interrupts
Message-ID: <20221116144021.00007a7c@Huawei.com>
In-Reply-To: <20221110185758.879472-9-ira.weiny@intel.com>
References: <20221110185758.879472-1-ira.weiny@intel.com>
        <20221110185758.879472-9-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Thu, 10 Nov 2022 10:57:55 -0800
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL device events are signaled via interrupts.  Each event log may have
> a different interrupt message number.  These message numbers are
> reported in the Get Event Interrupt Policy mailbox command.
> 
> Add interrupt support for event logs.  Interrupts are allocated as
> shared interrupts.  Therefore, all or some event logs can share the same
> message number.
> 
> The driver must deal with the possibility that dynamic capacity is not
> yet supported by a device it sees.  Fallback and retry without dynamic
> capacity if the first attempt fails.
> 
> Device capacity event logs interrupt as part of the informational event
> log.  Check the event status to see which log has data.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
Hi Ira,

A few comments inline.

Thanks,

Jonathan

> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 879b228a98a0..1e6762af2a00 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c

>  /**
>   * cxl_mem_get_event_records - Get Event Records from the device
> @@ -867,6 +870,52 @@ void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
>  
> +int cxl_event_config_msgnums(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_event_interrupt_policy *policy = &cxlds->evt_int_policy;
> +	size_t policy_size = sizeof(*policy);
> +	bool retry = true;
> +	int rc;
> +
> +	policy->info_settings = CXL_INT_MSI_MSIX;
> +	policy->warn_settings = CXL_INT_MSI_MSIX;
> +	policy->failure_settings = CXL_INT_MSI_MSIX;
> +	policy->fatal_settings = CXL_INT_MSI_MSIX;
> +	policy->dyn_cap_settings = CXL_INT_MSI_MSIX;
> +
> +again:
> +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_SET_EVT_INT_POLICY,
> +			       policy, policy_size, NULL, 0);
> +	if (rc < 0) {
> +		/*
> +		 * If the device does not support dynamic capacity it may fail
> +		 * the command due to an invalid payload.  Retry without
> +		 * dynamic capacity.
> +		 */

There are a number of ways to discover if DCD is supported that aren't based
on try and retry like this. 9.13.3 has "basic sequence to utilize Dynamic Capacity"
That calls out:
Verify the necessary Dynamic Capacity commands are returned in the CEL.

First I'm not sure we should set the interrupt on for DCD until we have a lot
more of the flow handled, secondly even then we should figure out if it is supported
at a higher level than this command and pass that info down here.


> +		if (retry) {
> +			retry = false;
> +			policy->dyn_cap_settings = 0;
> +			policy_size = sizeof(*policy) - sizeof(policy->dyn_cap_settings);
> +			goto again;
> +		}
> +		dev_err(cxlds->dev, "Failed to set event interrupt policy : %d",
> +			rc);
> +		memset(policy, CXL_INT_NONE, sizeof(*policy));

Relying on all the fields being 1 byte is a bit error prone. I'd just set them all
individually in the interests of more readable code.

> +		return rc;
> +	}
> +
> +	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_EVT_INT_POLICY, NULL, 0,
> +			       policy, policy_size);

Add a comment on why you are reading this back (to get the msgnums in the upper
bits) as it's not obvious to a casual reader.

> +	if (rc < 0) {
> +		dev_err(cxlds->dev, "Failed to get event interrupt policy : %d",
> +			rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_event_config_msgnums, CXL);
> +

...

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index e0d511575b45..64b2e2671043 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -458,6 +458,138 @@ static void cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
>  	cxlds->nr_irq_vecs = nvecs;
>  }
>  
> +struct cxl_event_irq_id {
> +	struct cxl_dev_state *cxlds;
> +	u32 status;
> +	unsigned int msgnum;
msgnum is only here for freeing the interrupt - I'd rather we fixed
that by using standard infrastructure (or adding some - see below).

status is an indirect way of allowing us to share an interrupt handler.
You could do that by registering a trivial wrapper for each instead.
Then all you have left is the cxl_dev_state which could be passed
in directly as the callback parameter removing need to have this
structure at all.  I think that might be neater.

> +};
> +
> +static irqreturn_t cxl_event_int_thread(int irq, void *id)
> +{
> +	struct cxl_event_irq_id *cxlid = id;
> +	struct cxl_dev_state *cxlds = cxlid->cxlds;
> +
> +	if (cxlid->status & CXLDEV_EVENT_STATUS_INFO)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_INFO);
> +	if (cxlid->status & CXLDEV_EVENT_STATUS_WARN)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);
> +	if (cxlid->status & CXLDEV_EVENT_STATUS_FAIL)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
> +	if (cxlid->status & CXLDEV_EVENT_STATUS_FATAL)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FATAL);
> +	if (cxlid->status & CXLDEV_EVENT_STATUS_DYNAMIC_CAP)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_DYNAMIC_CAP);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t cxl_event_int_handler(int irq, void *id)
> +{
> +	struct cxl_event_irq_id *cxlid = id;
> +	struct cxl_dev_state *cxlds = cxlid->cxlds;
> +	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> +
> +	if (cxlid->status & status)
> +		return IRQ_WAKE_THREAD;
> +	return IRQ_HANDLED;

If status not set IRQ_NONE.
Ah. I see Dave raised this as well.

> +}

...

> +static int cxl_request_event_irq(struct cxl_dev_state *cxlds,
> +				 enum cxl_event_log_type log_type,
> +				 u8 setting)
> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_event_irq_id *id;
> +	unsigned int msgnum = CXL_EVENT_INT_MSGNUM(setting);
> +	int irq;
> +
> +	/* Disabled irq is not an error */
> +	if (!cxl_evt_int_is_msi(setting) || msgnum > cxlds->nr_irq_vecs) {

I don't think that second condition can occur.  The language under table 8-52
(I think) means that it will move around if there aren't enough vectors
(for MSI - MSI-X is more complex, but result the same).

> +		dev_dbg(dev, "Event interrupt not enabled; %s %u %d\n",
> +			cxl_event_log_type_str(CXL_EVENT_TYPE_INFO),
> +			msgnum, cxlds->nr_irq_vecs);
> +		return 0;
> +	}
> +
> +	id = devm_kzalloc(dev, sizeof(*id), GFP_KERNEL);
> +	if (!id)
> +		return -ENOMEM;
> +
> +	id->cxlds = cxlds;
> +	id->msgnum = msgnum;
> +	id->status = log_type_to_status(log_type);
> +
> +	irq = pci_request_irq(pdev, id->msgnum, cxl_event_int_handler,
> +			      cxl_event_int_thread, id,
> +			      "%s:event-log-%s", dev_name(dev),
> +			      cxl_event_log_type_str(log_type));
> +	if (irq)
> +		return irq;
> +
> +	devm_add_action_or_reset(dev, cxl_free_event_irq, id);

Hmm. no pcim_request_irq()  maybe this is the time to propose one
(separate from this patch so we don't get delayed by that!)

We discussed this way back in DOE series (I'd forgotten but lore found
it for me).  There I suggested just calling
devm_request_threaded_irq() directly as a work around.

> +	return 0;
> +}
> +
> +static void cxl_event_irqsetup(struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = cxlds->dev;
> +	u8 setting;
> +
> +	if (cxl_event_config_msgnums(cxlds))
> +		return;
> +
> +	/*
> +	 * Dynamic Capacity shares the info message number
> +	 * Nothing to be done except check the status bit in the
> +	 * irq thread.
> +	 */
> +	setting = cxlds->evt_int_policy.info_settings;
> +	if (cxl_request_event_irq(cxlds, CXL_EVENT_TYPE_INFO, setting))
> +		dev_err(dev, "Failed to get interrupt for %s event log\n",
> +			cxl_event_log_type_str(CXL_EVENT_TYPE_INFO));
> +
> +	setting = cxlds->evt_int_policy.warn_settings;
> +	if (cxl_request_event_irq(cxlds, CXL_EVENT_TYPE_WARN, setting))
> +		dev_err(dev, "Failed to get interrupt for %s event log\n",
> +			cxl_event_log_type_str(CXL_EVENT_TYPE_WARN));
> +
> +	setting = cxlds->evt_int_policy.failure_settings;
> +	if (cxl_request_event_irq(cxlds, CXL_EVENT_TYPE_FAIL, setting))
> +		dev_err(dev, "Failed to get interrupt for %s event log\n",
> +			cxl_event_log_type_str(CXL_EVENT_TYPE_FAIL));
> +
> +	setting = cxlds->evt_int_policy.fatal_settings;
> +	if (cxl_request_event_irq(cxlds, CXL_EVENT_TYPE_FATAL, setting))
> +		dev_err(dev, "Failed to get interrupt for %s event log\n",
> +			cxl_event_log_type_str(CXL_EVENT_TYPE_FATAL));
> +}

