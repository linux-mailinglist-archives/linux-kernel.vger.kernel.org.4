Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351645FB28B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJKMja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJKMj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:39:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A2C8A7F3;
        Tue, 11 Oct 2022 05:39:24 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MmwLm0Z0jz687m2;
        Tue, 11 Oct 2022 20:38:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 14:39:21 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 11 Oct
 2022 13:39:21 +0100
Date:   Tue, 11 Oct 2022 13:39:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [RFC V2 PATCH 02/11] cxl/mem: Implement Get Event Records
 command
Message-ID: <20221011133920.00007945@huawei.com>
In-Reply-To: <20221010224131.1866246-3-ira.weiny@intel.com>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
        <20221010224131.1866246-3-ira.weiny@intel.com>
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

On Mon, 10 Oct 2022 15:41:22 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Event records are defined for CXL devices.  Each record is reported in
> one event log.  Devices are required to support the storage of at least
> one event record in each event log type.
> 
> Devices track event log overflow by incrementing a counter and tracking
> the time of the first and last overflow event seen.
> 
> Software queries events via the Get Event Record mailbox command; CXL
> rev 3.0 section 8.2.9.2.2.
> 
> Issue the Get Event Record mailbox command on driver load.  Trace each
> record found, as well as any overflow conditions.  Only 1 event is
> requested for each query.  Optimization of multiple record queries is
> deferred.
> 
> This patch traces a raw event record only and leaves the specific event
> record types to subsequent patches.
> 
> Macros are created to use for the common CXL Event header fields.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Hi Ira,

This looks basically fine, but I'm not convinced that it is a good
or sustainable idea to report reserved fields from the underlying
events in the trace events.
If they are defined to have meaning later, we can't remove them from
the 'reserved' field with out breaking backwards compatibility.
So we end up with a weird mixture of some fields in both reserved and
new entries in the TP and some not.

I've cc'd Mauro as he's probably more experienced in how to handle this
sort of stuff than anyone else I know.

Jonathan

> 
> ---
> Change from RFC:
> 	Remove redundant error message in get event records loop
> 	s/EVENT_RECORD_DATA_LENGTH/CXL_EVENT_RECORD_DATA_LENGTH
> 	Use hdr_uuid for the header UUID field
> 	Use cxl_event_log_type_str() for the trace events
> 	Create macros for the header fields and common entries of each event
> 	Add reserved buffer output dump
> 	Report error if event query fails
> 	Remove unused record_cnt variable
> 	Steven - reorder overflow record
> 		Remove NOTE about checkpatch
> 	Jonathan
> 		check for exactly 1 record
> 		s/v3.0/rev 3.0
> 		Use 3 byte fields for 24bit fields
> 		Add 3.0 Maintenance Operation Class
> 		Add Dynamic Capacity log type
> 		Fix spelling
> 	Dave Jiang/Dan/Alison
> 		s/cxl-event/cxl
> 		trace/events/cxl-events => trace/events/cxl.h
> 		s/cxl_event_overflow/overflow
> 		s/cxl_event/generic_event
> ---

... 

> +/**
> + * cxl_mem_get_event_records - Get Event Records from the device
> + * @cxlds: The device data for the operation
> + *
> + * Retrieve all event records available on the device and report them as trace
> + * events.
> + *
> + * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
> + */
> +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
> +{
> +	enum cxl_event_log_type log_type;
> +
> +	dev_dbg(cxlds->dev, "Reading event logs\n");
> +
> +	for (log_type = CXL_EVENT_TYPE_INFO;

I'd start at 0.  To my mind that's clearer than this which
basically says there is a contiguous range that may or may
not be 0 based.

> +	     log_type < CXL_EVENT_TYPE_MAX; log_type++)
> +		cxl_mem_get_records_log(cxlds, log_type);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
> +
>  /**
>   * cxl_mem_get_partition_info - Get partition info
>   * @cxlds: The device data for the operation
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88e3a8e54b6a..fa8d248fb299 100644
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
> @@ -253,6 +254,7 @@ struct cxl_dev_state {
>  enum cxl_opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> +	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> @@ -322,6 +324,78 @@ struct cxl_mbox_identify {
>  	u8 qos_telemetry_caps;
>  } __packed;
>  
> +/*
> + * Common Event Record Format
> + * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> + */
> +#define CXL_EVENT_REC_HDR_RES_LEN 0xf
> +struct cxl_event_record_hdr {
> +	uuid_t id;
> +	u8 length;
> +	u8 flags[3];
> +	__le16 handle;
> +	__le16 related_handle;
> +	__le64 timestamp;
> +	u8 maint_op_class;
> +	u8 reserved[CXL_EVENT_REC_HDR_RES_LEN];
> +} __packed;
> +
> +#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
> +struct cxl_event_record_raw {

I'd like some comments here on 'why' this makes sense.
Is expectation that it's here for future CXL spec definitions
or is it intended to allow some reporting of vendor defined
records?  Actually maybe a comment down at the TP would make more
sense than here.  Either way comment somewhere :)

> +	struct cxl_event_record_hdr hdr;
> +	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
> +} __packed;
> +


> +static inline const char *cxl_event_log_type_str(enum cxl_event_log_type type)
> +{
> +	switch (type) {
> +	case CXL_EVENT_TYPE_INFO:
> +		return "Informational";
> +	case CXL_EVENT_TYPE_WARN:
> +		return "Warning";
> +	case CXL_EVENT_TYPE_FAIL:
> +		return "Failure";
> +	case CXL_EVENT_TYPE_FATAL:
> +		return "Fatal";
> +	case CXL_EVENT_TYPE_DYNAMIC_CAP:
> +		return "Dynamic Capacity";
Array of const char * that you pick from (with limit check) maybe rather than a switch?
Doesn't matter that much though.

> +	default:
> +		break;
> +	}
> +	return "<unknown>";
> +}
> +
>  struct cxl_mbox_get_partition_info {
>  	__le64 active_volatile_cap;
>  	__le64 active_persistent_cap;
> @@ -381,6 +455,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds);
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> new file mode 100644
> index 000000000000..318ba5fe046e
> --- /dev/null
> +++ b/include/trace/events/cxl.h
> @@ -0,0 +1,130 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM cxl
> +
> +#if !defined(_CXL_TRACE_EVENTS_H) ||  defined(TRACE_HEADER_MULTI_READ)
> +#define _CXL_TRACE_EVENTS_H
> +
> +#include <asm-generic/unaligned.h>
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(overflow,
> +
> +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> +		 struct cxl_get_event_payload *payload),
> +
> +	TP_ARGS(dev_name, log, payload),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name)
> +		__field(int, log)
> +		__field(u64, first)

first_ts maybe?  first alone is a bit vague.

> +		__field(u64, last)
> +		__field(u16, count)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name);
> +		__entry->log = log;
> +		__entry->count = le16_to_cpu(payload->overflow_err_count);
> +		__entry->first = le64_to_cpu(payload->first_overflow_timestamp);
> +		__entry->last = le64_to_cpu(payload->last_overflow_timestamp);
> +	),
> +
> +	TP_printk("%s: EVENT LOG OVERFLOW log=%s : %u records from %llu to %llu",
> +		__get_str(dev_name), cxl_event_log_type_str(__entry->log),

So we have a potential header include ordering issue given this header doesn't
include the definition of cxl_event_log_type_str()?

> +		__entry->count, __entry->first, __entry->last)
> +
> +);
> +
> +/*
> + * Common Event Record Format
> + * CXL 3.0 section 8.2.9.2.1; Table 8-42
> + */
> +#define CXL_EVENT_RECORD_FLAG_PERMANENT		BIT(2)
> +#define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED	BIT(3)
> +#define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
> +#define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
> +#define show_hdr_flags(flags)	__print_flags(flags, " | ",			   \
> +	{ CXL_EVENT_RECORD_FLAG_PERMANENT,	"Permanent Condition"		}, \
> +	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,	"Maintenance Needed"		}, \
> +	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"Performance Degraded"		}, \
> +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"Hardware Replacement Needed"	}  \
> +)
> +
> +/*
> + * Define macros for the common header of each CXL event.
> + *
> + * Tracepoints using these macros must do 3 things:
> + *
> + *	1) Add CXL_EVT_TP_entry to TP_STRUCT__entry
> + *	2) Use CXL_EVT_TP_fast_assign within TP_fast_assign;
> + *	   pass the dev_name, log, and CXL event header
> + *	3) Use CXL_EVT_TP_printk() instead of TP_printk()
> + *
> + * See the generic_event tracepoint as an example.
> + */
> +#define CXL_EVT_TP_entry					\
> +	__string(dev_name, dev_name)				\
> +	__field(int, log)					\
> +	__array(u8, hdr_uuid, UUID_SIZE)			\
> +	__field(u32, hdr_flags)					\
> +	__field(u16, hdr_handle)				\
> +	__field(u16, hdr_related_handle)			\
> +	__field(u64, hdr_timestamp)				\
> +	__array(u8, hdr_res, CXL_EVENT_REC_HDR_RES_LEN)		\
> +	__field(u8, hdr_length)					\
> +	__field(u8, hdr_maint_op_class)
> +
> +#define CXL_EVT_TP_fast_assign(dname, l, hdr)					\
> +	__assign_str(dev_name, (dname));					\
> +	__entry->log = (l);							\
> +	memcpy(__entry->hdr_uuid, &(hdr).id, UUID_SIZE);			\
> +	__entry->hdr_length = (hdr).length;					\
> +	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
> +	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
> +	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
> +	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
> +	__entry->hdr_maint_op_class = (hdr).maint_op_class;			\
> +	memcpy(__entry->hdr_res, &(hdr).reserved,				\
> +		CXL_EVENT_REC_HDR_RES_LEN)

What's the logic behind having the reserved fields here?
How does that change when a future spec defines them as used? Do we have
to keep whatever was in the previously reserved fields for ever in order to
maintain backwards compatibility even though we've added the same data to the end
of the trace point?

I don't think they should be here at all. Given a userspace stack has to cope with
out knowing the contents of those fields as userspace might not be up to date, 
I see no problem with requiring a newer kernel to support stuff added in future
specs.

Steven, Mauro, you probably have a better idea of history of similar cases.  How
have other people handled reserved fields in underlying hardware reports that
may become used in later revisions?

Also, probably makes sense to cc linux-edac on v3 of this series as the experts
in these flows tend to read that list.  Obviously intent so far is not to pass
these into the edac subsystem, but I'd still let them know this work is going on.


> +
> +
> +#define CXL_EVT_TP_printk(fmt, ...) \
> +	TP_printk("%s log=%s : time=%llu uuid=%pUl len=%d flags='%s' "		\
> +		"handle=%x related_handle=%x maint_op_class=%u res='%s' "	\
> +		" : " fmt,							\
> +		__get_str(dev_name), cxl_event_log_type_str(__entry->log),	\
> +		__entry->hdr_timestamp, __entry->hdr_uuid, __entry->hdr_length,	\
> +		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
> +		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
> +		__print_hex(__entry->hdr_res, CXL_EVENT_REC_HDR_RES_LEN),	\
> +		##__VA_ARGS__)
> +
> +TRACE_EVENT(generic_event,
> +
> +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> +		 struct cxl_event_record_raw *rec),
> +
> +	TP_ARGS(dev_name, log, rec),
> +
> +	TP_STRUCT__entry(
> +		CXL_EVT_TP_entry
> +		__array(u8, data, CXL_EVENT_RECORD_DATA_LENGTH)
> +	),
> +
> +	TP_fast_assign(
> +		CXL_EVT_TP_fast_assign(dev_name, log, rec->hdr);
> +		memcpy(__entry->data, &rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
> +	),
> +
> +	CXL_EVT_TP_printk("%s",
> +		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
> +);
> +
> +#endif /* _CXL_TRACE_EVENTS_H */
