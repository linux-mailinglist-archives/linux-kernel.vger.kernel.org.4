Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF35063F134
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiLANHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLANHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:07:02 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23366589;
        Thu,  1 Dec 2022 05:06:53 -0800 (PST)
Received: from frapeml500001.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NNGV90wjpz687L9;
        Thu,  1 Dec 2022 21:03:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500001.china.huawei.com (7.182.85.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 14:06:51 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Dec
 2022 13:06:50 +0000
Date:   Thu, 1 Dec 2022 13:06:50 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 02/11] cxl/mem: Implement Get Event Records command
Message-ID: <20221201130650.00007f3d@Huawei.com>
In-Reply-To: <20221201002719.2596558-3-ira.weiny@intel.com>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
        <20221201002719.2596558-3-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
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

On Wed, 30 Nov 2022 16:27:10 -0800
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL devices have multiple event logs which can be queried for CXL event
> records.  Devices are required to support the storage of at least one
> event record in each event log type.
> 
> Devices track event log overflow by incrementing a counter and tracking
> the time of the first and last overflow event seen.
> 
> Software queries events via the Get Event Record mailbox command; CXL
> rev 3.0 section 8.2.9.2.2.
> 
> Issue the Get Event Record mailbox command on driver load.  Trace each
> record found with a generic record trace.  Trace any overflow
> conditions.
> 
> The device can return up to 1MB worth of event records per query.
> Allocate a shared large buffer to handle the max number of records based
> on the mailbox payload size.
> 
> This patch traces a raw event record only and leaves the specific event
> record types to subsequent patches.
> 
> Macros are created to use for tracing the common CXL Event header
> fields.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Hi Ira,

Looks good to me.  A few trivial suggestions inline. Either way,

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 16176b9278b4..70b681027a3d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -7,6 +7,9 @@

...

> +
> +static void cxl_mem_free_event_buffer(void *data)
> +{
> +	struct cxl_dev_state *cxlds = data;
> +
> +	kvfree(cxlds->event_buf);

Trivial, but why not just pass in the event_buf?

> +}
> +
> +/*
> + * There is a single buffer for reading event logs from the mailbox.  All logs
> + * share this buffer protected by the cxlds->event_buf_lock.
> + */
> +static struct cxl_get_event_payload *alloc_event_buf(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_get_event_payload *buf;
> +
> +	dev_dbg(cxlds->dev, "Allocating event buffer size %zu\n",
> +		cxlds->payload_size);
> +
> +	buf = kvmalloc(cxlds->payload_size, GFP_KERNEL);

huh. I assumed there would be a devm_kvmalloc() but apparently not..  Ah well
- whilst it might makes sense to add one, let's not tie that up with this series.

> +	if (buf && devm_add_action_or_reset(cxlds->dev,
> +			cxl_mem_free_event_buffer, cxlds))
> +		return NULL;

Trivial, but I'd go for a more wordy but more conventional pattern of
	if (!buf)
		return NULL;

	if (devm_add_action_or_reset())
		return NULL
	
	return buff;
	
> +	return buf;
> +}
> +

...

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index cd35f43fedd4..55d57f5a64bc 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -4,6 +4,7 @@
>  #define __CXL_MEM_H__
>  #include <uapi/linux/cxl_mem.h>
>  #include <linux/cdev.h>
> +#include <linux/uuid.h>
>  #include "cxl.h"
>  
>  /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> @@ -250,12 +251,16 @@ struct cxl_dev_state {
>  
>  	bool msi_enabled;
>  
> +	struct cxl_get_event_payload *event_buf;
Whilst it is obvious (and document at point of allocation),
I think one of the static checkers still warns that all locks must
have comments.  Probably easier to add one now than wait for the
inevitable warning report.

> +	struct mutex event_buf_lock;
> +
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
>  


