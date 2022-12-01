Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D03C63F2A4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiLAOV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiLAOVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:21:24 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AE948424;
        Thu,  1 Dec 2022 06:21:22 -0800 (PST)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NNJ8T3jJVz6H7Wb;
        Thu,  1 Dec 2022 22:18:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 15:21:20 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 14:21:19 +0000
Date:   Thu, 1 Dec 2022 14:21:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 08/11] cxl/mem: Wire up event interrupts
Message-ID: <20221201142118.00002933@Huawei.com>
In-Reply-To: <20221201002719.2596558-9-ira.weiny@intel.com>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
        <20221201002719.2596558-9-ira.weiny@intel.com>
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

On Wed, 30 Nov 2022 16:27:16 -0800
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
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

A few trivial comments, but only superficially code style stuff which you
can ignore if you feel strongly about current style or it matches existing
file style etc...

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes from V1:
> 	Remove unneeded evt_int_policy from struct cxl_dev_state
> 	defer Dynamic Capacity support
> 	Dave Jiang
> 		s/irq/rc
> 		use IRQ_NONE to signal the irq was not for us.
> 	Jonathan
> 		use msi_enabled rather than nr_irq_vec
> 		On failure explicitly set CXL_INT_NONE
> 		Add comment for Get Event Interrupt Policy
> 		use devm_request_threaded_irq()
> 		Use individual handler/thread functions for each of the
> 		logs rather than struct cxl_event_irq_id.
> 
> Changes from RFC v2
> 	Adjust to new irq 16 vector allocation
> 	Jonathan
> 		Remove CXL_INT_RES
> 	Use irq threads to ensure mailbox commands are executed outside irq context
> 	Adjust for optional Dynamic Capacity log
> ---
>  drivers/cxl/core/mbox.c      |  44 +++++++++++-
>  drivers/cxl/cxlmem.h         |  30 ++++++++
>  drivers/cxl/pci.c            | 130 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/cxl_mem.h |   2 +
>  4 files changed, 204 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 450b410f29f6..2d384b0fc2b3 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -179,6 +179,30 @@ struct cxl_endpoint_dvsec_info {
>  	struct range dvsec_range[2];
>  };
>  
> +/**
> + * Event Interrupt Policy
> + *
> + * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
> + */
> +enum cxl_event_int_mode {
> +	CXL_INT_NONE		= 0x00,
> +	CXL_INT_MSI_MSIX	= 0x01,
> +	CXL_INT_FW		= 0x02
> +};
> +#define CXL_EVENT_INT_MODE_MASK 0x3
> +#define CXL_EVENT_INT_MSGNUM(setting) (((setting) & 0xf0) >> 4)
> +struct cxl_event_interrupt_policy {
> +	u8 info_settings;
> +	u8 warn_settings;
> +	u8 failure_settings;
> +	u8 fatal_settings;
> +} __packed;
> +
> +static inline bool cxl_evt_int_is_msi(u8 setting)
> +{
> +	return CXL_INT_MSI_MSIX == (setting & CXL_EVENT_INT_MODE_MASK);

Maybe a case for FIELD_GET() though given the defines are all local
it is already obvious what this is doing so fine if you prefer to
keep it as is.

> +}
...

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 11e95a95195a..3c0b9199f11a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -449,6 +449,134 @@ static void cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
>  	cxlds->msi_enabled = true;
>  }
>  
> +static irqreturn_t cxl_event_info_thread(int irq, void *id)
> +{
> +	struct cxl_dev_state *cxlds = id;
> +
> +	cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_INFO);
> +	return IRQ_HANDLED;
> +}

I'm not a great fan of macros, but maybe this is a case for them.

> +
> +static irqreturn_t cxl_event_info_handler(int irq, void *id)
> +{
> +	struct cxl_dev_state *cxlds = id;
> +	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);

Superficial and this is guaranteed to work (8.2.8 allow all sizes of read up
to 64 bytes), but maybe should treat this as a 64 bit register as that aligns
better with spec?

> +
> +	if (CXLDEV_EVENT_STATUS_INFO & status)

Another maybe FIELD_GET() case?

> +		return IRQ_WAKE_THREAD;
> +	return IRQ_NONE;
> +}
> +
> +static irqreturn_t cxl_event_warn_thread(int irq, void *id)
> +{
> +	struct cxl_dev_state *cxlds = id;

Why id?  I'd call it what it is (maybe _cxlsd) and not bother with
the local variable in this case as it is only used once and doesn't
need the type.

static irqreturn_t cxl_event_warn_thread(int irq, void *cxlds)
{
	cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);

	return IRQ_HANDLED;
}


> +
> +	cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);
> +	return IRQ_HANDLED;
> +}
> +

...



