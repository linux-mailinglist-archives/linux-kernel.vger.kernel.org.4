Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0526562BDA3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbiKPMXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiKPMWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:22:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1F327CFD;
        Wed, 16 Nov 2022 04:19:46 -0800 (PST)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NC26w365Wz67QRR;
        Wed, 16 Nov 2022 20:15:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 13:19:43 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 12:19:43 +0000
Date:   Wed, 16 Nov 2022 12:19:42 +0000
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
Subject: Re: [PATCH v3 1/6] trace, cxl: Introduce a TRACE_EVENT for CXL
 poison records
Message-ID: <20221116121942.00003a3e@Huawei.com>
In-Reply-To: <5746274c905f57f117987c8268c9f6dc9bd33337.1668115235.git.alison.schofield@intel.com>
References: <cover.1668115235.git.alison.schofield@intel.com>
        <5746274c905f57f117987c8268c9f6dc9bd33337.1668115235.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Thu, 10 Nov 2022 19:12:39 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices may support the retrieval of a device poison list.
> Introduce a trace event that the CXL subsystem can use to log
> the poison error records.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Only thing I wondered a bit about in here is the philosophy of whether it is
useful to include the pcidev and region given they can both be established
fairly easily via other paths..  Meh. Seems reasonable to me to have the
in here so.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/cxlmem.h       | 14 +++++++
>  include/trace/events/cxl.h | 80 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
>  create mode 100644 include/trace/events/cxl.h
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88e3a8e54b6a..669868cc1553 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -347,6 +347,20 @@ struct cxl_mbox_set_partition_info {
>  
>  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
>  
> +/* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
> +
> +/* Get Poison List: Payload out flags */
> +#define CXL_POISON_FLAG_MORE            BIT(0)
> +#define CXL_POISON_FLAG_OVERFLOW        BIT(1)
> +#define CXL_POISON_FLAG_SCANNING        BIT(2)
> +
> +/* Get Poison List: Poison Source */
> +#define CXL_POISON_SOURCE_UNKNOWN	0
> +#define CXL_POISON_SOURCE_EXTERNAL	1
> +#define CXL_POISON_SOURCE_INTERNAL	2
> +#define CXL_POISON_SOURCE_INJECTED	3
> +#define CXL_POISON_SOURCE_VENDOR	7
> +
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI
> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> new file mode 100644
> index 000000000000..03428125573f
> --- /dev/null
> +++ b/include/trace/events/cxl.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM cxl
> +
> +#if !defined(_CXL_TRACE_H) ||  defined(TRACE_HEADER_MULTI_READ)
> +#define _CXL_TRACE_H
> +
> +#include <linux/tracepoint.h>
> +#include <cxlmem.h>
> +
> +#define __show_poison_source(source)                          \
> +	__print_symbolic(source,                              \
> +		{ CXL_POISON_SOURCE_UNKNOWN,   "Unknown"  },  \
> +		{ CXL_POISON_SOURCE_EXTERNAL,  "External" },  \
> +		{ CXL_POISON_SOURCE_INTERNAL,  "Internal" },  \
> +		{ CXL_POISON_SOURCE_INJECTED,  "Injected" },  \
> +		{ CXL_POISON_SOURCE_VENDOR,    "Vendor"   })
> +
> +#define show_poison_source(source)			     \
> +	(((source > CXL_POISON_SOURCE_INJECTED) &&	     \
> +	 (source != CXL_POISON_SOURCE_VENDOR)) ? "Reserved"  \
> +	 : __show_poison_source(source))
> +
> +#define show_poison_flags(flags)                             \
> +	__print_flags(flags, "|",                            \
> +		{ CXL_POISON_FLAG_MORE,      "More"     },   \
> +		{ CXL_POISON_FLAG_OVERFLOW,  "Overflow"  },  \
> +		{ CXL_POISON_FLAG_SCANNING,  "Scanning"  })
> +
> +TRACE_EVENT(cxl_poison,
> +
> +	    TP_PROTO(const char *memdev, const char *pcidev, const char *region,
> +		     const uuid_t *uuid, u64 dpa, u32 length, u8 source,
> +		     u8 flags, u64 overflow_t),
> +
> +	    TP_ARGS(memdev, pcidev, region, uuid, dpa, length, source,
> +		    flags, overflow_t),
> +
> +	    TP_STRUCT__entry(
> +		__string(memdev, memdev)
> +		__string(pcidev, pcidev)
> +		__string(region, region ? region : "")
> +		__array(char, uuid, 16)
> +		__field(u64, dpa)
> +		__field(u32, length)
> +		__field(u8, source)
> +		__field(u8, flags)
> +		__field(u64, overflow_t)
> +	    ),
> +
> +	    TP_fast_assign(
> +		__assign_str(memdev, memdev);
> +		__assign_str(pcidev, pcidev);
> +		__assign_str(region, region ? region : "");
> +		if (uuid)
> +			memcpy(__entry->uuid, uuid, 16);
> +		__entry->dpa = dpa;
> +		__entry->length = length;
> +		__entry->source = source;
> +		__entry->flags = flags;
> +		__entry->overflow_t = overflow_t;
> +	    ),
> +
> +	    TP_printk("memdev=%s pcidev=%s region=%s region_uuid=%pU dpa=0x%llx length=0x%x source=%s flags=%s overflow_time=%llu",
> +		__get_str(memdev),
> +		__get_str(pcidev),
> +		__get_str(region),
> +		__entry->uuid,
> +		__entry->dpa,
> +		__entry->length,
> +		show_poison_source(__entry->source),
> +		show_poison_flags(__entry->flags),
> +		__entry->overflow_t)
> +);
> +#endif /* _CXL_TRACE_H */
> +
> +/* This part must be outside protection */
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE cxl
> +#include <trace/define_trace.h>

