Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DDF62BE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiKPMl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiKPMlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:41:24 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094692650;
        Wed, 16 Nov 2022 04:41:21 -0800 (PST)
Received: from frapeml500007.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NC2br13knz67m28;
        Wed, 16 Nov 2022 20:36:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 13:41:19 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 12:41:19 +0000
Date:   Wed, 16 Nov 2022 12:41:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <20221116124118.0000144b@Huawei.com>
In-Reply-To: <46c7c7339224744fce424b196da3e5566effec17.1668115235.git.alison.schofield@intel.com>
References: <cover.1668115235.git.alison.schofield@intel.com>
        <46c7c7339224744fce424b196da3e5566effec17.1668115235.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On Thu, 10 Nov 2022 19:12:40 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices maintain a list of locations that are poisoned or result
> in poison if the addresses are accessed by the host.
> 
> Per the spec (CXL 3.0 8.2.9.8.4.1), the device returns this Poison
> list as a set of  Media Error Records that include the source of the
> error, the starting device physical address and length. The length is
> the number of adjacent DPAs in the record and is in units of 64 bytes.
> 
> Retrieve the list and log each Media Error Record as a trace event of
> type 'cxl_poison'.
> 
> When the poison list is requested by region, include the region name
> and uuid in the trace event.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Hi Alison,

I've forgotten most of previous discussions around versions of this series
so I may well repeat things that were covered earlier!

A few things inline.

Thanks,

Jonathan


> ---
>  drivers/cxl/core/mbox.c | 81 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 37 +++++++++++++++++++
>  2 files changed, 118 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 0c90f13870a4..88f034e97812 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -9,6 +9,9 @@
>  
>  #include "core.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/cxl.h>
> +
>  static bool cxl_raw_allow_all;
>  
>  /**
> @@ -752,6 +755,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>  {
>  	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
>  	struct cxl_mbox_identify id;
> +	__le32 val = 0;
>  	int rc;
>  
>  	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_IDENTIFY, NULL, 0, &id,
> @@ -771,6 +775,9 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>  	cxlds->lsa_size = le32_to_cpu(id.lsa_size);
>  	memcpy(cxlds->firmware_version, id.fw_revision, sizeof(id.fw_revision));
>  
> +	memcpy(&val, id.poison_list_max_mer, 3);

This is ugly.  I've lost track of last discussion about get_unaligned_le24()
and using it on elements of a packed structure.  At very least can we
do a memcpy to a u8[3] array and then use get_unaligned_le24() on that if
we can't use it directly on the structure element?


> +	cxlds->poison_max = min_t(u32, le32_to_cpu(val), CXL_POISON_LIST_MAX);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
> @@ -835,6 +842,79 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
>  
> +int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> +		       struct cxl_region *cxlr)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	const char *memdev_name = dev_name(&cxlmd->dev);
Could just do this where it's used rather than here.

> +	const char *pcidev_name = dev_name(cxlds->dev);
Same with this.

> +	struct cxl_mbox_poison_payload_out *po;
> +	struct cxl_mbox_poison_payload_in pi;
> +	int nr_records = 0;
> +	int rc;
> +
> +	po = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> +	if (!po)
> +		return -ENOMEM;
> +
> +	pi.offset = cpu_to_le64(offset);
> +	pi.length = cpu_to_le64(len);
> +
> +	rc = mutex_lock_interruptible(&cxlds->poison_list_mutex);
> +	if (rc)
> +		goto out;
> +
> +	do {
> +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_POISON, &pi,
> +				       sizeof(pi), po, cxlds->payload_size);
> +		if (rc)
> +			break;
> +
> +		if (trace_cxl_poison_enabled())
> +			cxl_trace_poison(po, cxlr, memdev_name, pcidev_name);
> +
> +		/* Protect against an uncleared _FLAG_MORE */
> +		nr_records = nr_records + le16_to_cpu(po->count);
> +		if (nr_records >= cxlds->poison_max) {
> +			dev_dbg(&cxlmd->dev, "Max Error Records reached: %d\n",
> +				nr_records);
> +			break;
> +		}
> +	} while (po->flags & CXL_POISON_FLAG_MORE);
> +
> +	mutex_unlock(&cxlds->poison_list_mutex);
> +out:
> +	kvfree(po);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, CXL);
> +
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  {
>  	struct cxl_dev_state *cxlds;
> @@ -846,6 +926,7 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  	}
>  
>  	mutex_init(&cxlds->mbox_mutex);
> +	mutex_init(&cxlds->poison_list_mutex);
>  	cxlds->dev = dev;
>  
>  	return cxlds;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 669868cc1553..49d891347e39 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -192,6 +192,8 @@ struct cxl_endpoint_dvsec_info {
>   *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
>   * @lsa_size: Size of Label Storage Area
>   *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
> + * @poison_max: maximum media error records held in device cache
For consistency of capitalization: Maximum 
> + * @poison_list_mutex: Mutex to synchronize poison list retrieval
>   * @mbox_mutex: Mutex to synchronize mailbox access.
>   * @firmware_version: Firmware version for the memory device.
>   * @enabled_cmds: Hardware commands found enabled in CEL.
> @@ -224,6 +226,8 @@ struct cxl_dev_state {
>  

...


