Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2844563F642
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiLARjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiLARi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:38:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B253A4334;
        Thu,  1 Dec 2022 09:38:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5796F6209D;
        Thu,  1 Dec 2022 17:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87642C433C1;
        Thu,  1 Dec 2022 17:38:52 +0000 (UTC)
Date:   Thu, 1 Dec 2022 12:38:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH V2 02/11] cxl/mem: Implement Get Event Records command
Message-ID: <20221201123849.0f7802ce@gandalf.local.home>
In-Reply-To: <20221201002719.2596558-3-ira.weiny@intel.com>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
        <20221201002719.2596558-3-ira.weiny@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 16:27:10 -0800
ira.weiny@intel.com wrote:

>  CONEXANT ACCESSRUNNER USB DRIVER
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 16176b9278b4..70b681027a3d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -7,6 +7,9 @@
>  #include <cxlmem.h>
>  #include <cxl.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/cxl.h>
> +
>  #include "core.h"
>  
>  static bool cxl_raw_allow_all;
> @@ -48,6 +51,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(RAW, CXL_VARIABLE_PAYLOAD, CXL_VARIABLE_PAYLOAD, 0),
>  #endif
>  	CXL_CMD(GET_SUPPORTED_LOGS, 0, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
> +	CXL_CMD(GET_EVENT_RECORD, 1, CXL_VARIABLE_PAYLOAD, 0),
>  	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
>  	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
>  	CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> @@ -704,6 +708,106 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> +static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> +				    enum cxl_event_log_type type)
> +{
> +	struct cxl_get_event_payload *payload;
> +	u16 nr_rec;
> +
> +	mutex_lock(&cxlds->event_buf_lock);
> +
> +	payload = cxlds->event_buf;
> +
> +	do {
> +		u8 log_type = type;
> +		int rc;
> +
> +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_EVENT_RECORD,
> +				       &log_type, sizeof(log_type),
> +				       payload, cxlds->payload_size);
> +		if (rc) {
> +			dev_err(cxlds->dev, "Event log '%s': Failed to query event records : %d",
> +				cxl_event_log_type_str(type), rc);
> +			goto unlock_buffer;
> +		}
> +
> +		nr_rec = le16_to_cpu(payload->record_count);
> +		if (trace_cxl_generic_event_enabled()) {
> +			int i;
> +
> +			for (i = 0; i < nr_rec; i++)
> +				trace_cxl_generic_event(dev_name(cxlds->dev),
> +							type,
> +							&payload->records[i]);
> +		}
> +
> +		if (trace_cxl_overflow_enabled() &&
> +		    (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW))
> +			trace_cxl_overflow(dev_name(cxlds->dev), type, payload);
> +
> +	} while (nr_rec);
> +
> +unlock_buffer:
> +	mutex_unlock(&cxlds->event_buf_lock);
> +}
> +
> +static void cxl_mem_free_event_buffer(void *data)
> +{
> +	struct cxl_dev_state *cxlds = data;
> +
> +	kvfree(cxlds->event_buf);
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
> +	if (buf && devm_add_action_or_reset(cxlds->dev,
> +			cxl_mem_free_event_buffer, cxlds))
> +		return NULL;
> +	return buf;
> +}
> +
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
> +	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> +
> +	dev_dbg(cxlds->dev, "Reading event logs: %x\n", status);
> +
> +	if (!cxlds->event_buf) {
> +		cxlds->event_buf = alloc_event_buf(cxlds);
> +		if (WARN_ON_ONCE(!cxlds->event_buf))
> +			return;
> +	}
> +
> +	if (status & CXLDEV_EVENT_STATUS_INFO)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_INFO);
> +	if (status & CXLDEV_EVENT_STATUS_WARN)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);
> +	if (status & CXLDEV_EVENT_STATUS_FAIL)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
> +	if (status & CXLDEV_EVENT_STATUS_FATAL)
> +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FATAL);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
> +
>  /**
>   * cxl_mem_get_partition_info - Get partition info
>   * @cxlds: The device data for the operation
> @@ -846,6 +950,7 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  	}
>  
>  	mutex_init(&cxlds->mbox_mutex);
> +	mutex_init(&cxlds->event_buf_lock);
>  	cxlds->dev = dev;
>  
>  	return cxlds;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f680450f0b16..d4baae74cd97 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -132,6 +132,13 @@ static inline int ways_to_cxl(unsigned int ways, u8 *iw)
>  #define CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX 0x3
>  #define CXLDEV_CAP_CAP_ID_MEMDEV 0x4000
>  
> +/* CXL 3.0 8.2.8.3.1 Event Status Register */
> +#define CXLDEV_DEV_EVENT_STATUS_OFFSET		0x00
> +#define CXLDEV_EVENT_STATUS_INFO		BIT(0)
> +#define CXLDEV_EVENT_STATUS_WARN		BIT(1)
> +#define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
> +#define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
> +
>  /* CXL 2.0 8.2.8.4 Mailbox Registers */
>  #define CXLDEV_MBOX_CAPS_OFFSET 0x00
>  #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
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
> +	struct mutex event_buf_lock;
> +
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
>  
>  enum cxl_opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> +	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> @@ -325,6 +330,72 @@ struct cxl_mbox_identify {
>  	u8 qos_telemetry_caps;
>  } __packed;
>  
> +/*
> + * Common Event Record Format
> + * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> + */
> +struct cxl_event_record_hdr {
> +	uuid_t id;
> +	u8 length;
> +	u8 flags[3];
> +	__le16 handle;
> +	__le16 related_handle;
> +	__le64 timestamp;
> +	u8 maint_op_class;
> +	u8 reserved[0xf];
> +} __packed;
> +
> +#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
> +struct cxl_event_record_raw {
> +	struct cxl_event_record_hdr hdr;
> +	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
> +} __packed;
> +
> +/*
> + * Get Event Records output payload
> + * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
> + */
> +#define CXL_GET_EVENT_FLAG_OVERFLOW		BIT(0)
> +#define CXL_GET_EVENT_FLAG_MORE_RECORDS		BIT(1)
> +struct cxl_get_event_payload {
> +	u8 flags;
> +	u8 reserved1;
> +	__le16 overflow_err_count;
> +	__le64 first_overflow_timestamp;
> +	__le64 last_overflow_timestamp;
> +	__le16 record_count;
> +	u8 reserved2[0xa];
> +	struct cxl_event_record_raw records[];
> +} __packed;
> +
> +/*
> + * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
> + */
> +enum cxl_event_log_type {
> +	CXL_EVENT_TYPE_INFO = 0x00,
> +	CXL_EVENT_TYPE_WARN,
> +	CXL_EVENT_TYPE_FAIL,
> +	CXL_EVENT_TYPE_FATAL,
> +	CXL_EVENT_TYPE_MAX
> +};
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
> +	default:
> +		break;
> +	}
> +	return "<unknown>";
> +}

So you are using this in a TP_printk() section, which means perf and
trace-cmd have no idea how to parse it. Can I recommend instead having:

#define cxl_event_log_type_str(type)				\
	__print_symbolic(type,					\
		{ CXL_EVENT_TYPE_INFO, "Informational" },	\
		{ CXL_EVENT_TYPE_WARN, "Warning" },		\
		{ CXL_EVENT_TYPE_FAIL, "Failure" },		\
		{ CXL_EVENT_TYPE_FATAL, "Fatal" })

#ifndef CREATE_TRACE_POINTS
static inline const char *__cxl_event_log_type_str(enum cxl_event_log_type type,
			struct trace_print_flags *symbols)
{
	for (; symbols->mask >= 0; symbols++) {
		if (type == symbols->mask)
			return symbols->name;
	}
	return "<unknown>";
}
#define __print_symbolic(value, symbol_array...)			\
	({								\
		static const struct trace_print_flags symbols[] =	\
			{ symbol_array, { -1, NULL }};			\
		__cxl_event_log_type_str(value, symbols);		\
	})
#endif		

Note, I did not even try to compile the above. But it should be close to
working.

This way, the cxl_event_log_type_str() for trace events will be converted
into the __print_symbolic() which can be parsed by perf and trace-cmd. For
all other use cases, it is converted into the function above to return the
string.

-- Steve

> +
>  struct cxl_mbox_get_partition_info {
>  	__le64 active_volatile_cap;
>  	__le64 active_persistent_cap;
> @@ -384,6 +455,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds);
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> new file mode 100644
> index 000000000000..c03a1a894af8
> --- /dev/null
> +++ b/include/trace/events/cxl.h
> @@ -0,0 +1,126 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM cxl
> +
> +#if !defined(_CXL_TRACE_EVENTS_H) ||  defined(TRACE_HEADER_MULTI_READ)
> +#define _CXL_TRACE_EVENTS_H
> +
> +#include <asm-generic/unaligned.h>
> +#include <linux/tracepoint.h>
> +#include <cxlmem.h>
> +
> +TRACE_EVENT(cxl_overflow,
> +
> +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> +		 struct cxl_get_event_payload *payload),
> +
> +	TP_ARGS(dev_name, log, payload),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name)
> +		__field(int, log)
> +		__field(u64, first_ts)
> +		__field(u64, last_ts)
> +		__field(u16, count)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name);
> +		__entry->log = log;
> +		__entry->count = le16_to_cpu(payload->overflow_err_count);
> +		__entry->first_ts = le64_to_cpu(payload->first_overflow_timestamp);
> +		__entry->last_ts = le64_to_cpu(payload->last_overflow_timestamp);
> +	),
> +
> +	TP_printk("%s: EVENT LOG OVERFLOW log=%s : %u records from %llu to %llu",
> +		__get_str(dev_name), cxl_event_log_type_str(__entry->log),
> +		__entry->count, __entry->first_ts, __entry->last_ts)
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
> +	{ CXL_EVENT_RECORD_FLAG_PERMANENT,	"PERMANENT_CONDITION"		}, \
> +	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,	"MAINTENANCE_NEEDED"		}, \
> +	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"PERFORMANCE_DEGRADED"		}, \
> +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"HARDWARE_REPLACEMENT_NEEDED"	}  \
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
> +	__field_struct(uuid_t, hdr_uuid)			\
> +	__field(u32, hdr_flags)					\
> +	__field(u16, hdr_handle)				\
> +	__field(u16, hdr_related_handle)			\
> +	__field(u64, hdr_timestamp)				\
> +	__field(u8, hdr_length)					\
> +	__field(u8, hdr_maint_op_class)
> +
> +#define CXL_EVT_TP_fast_assign(dname, l, hdr)					\
> +	__assign_str(dev_name, (dname));					\
> +	__entry->log = (l);							\
> +	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
> +	__entry->hdr_length = (hdr).length;					\
> +	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
> +	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
> +	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
> +	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
> +	__entry->hdr_maint_op_class = (hdr).maint_op_class
> +
> +#define CXL_EVT_TP_printk(fmt, ...) \
> +	TP_printk("%s log=%s : time=%llu uuid=%pUb len=%d flags='%s' "		\
> +		"handle=%x related_handle=%x maint_op_class=%u"			\
> +		" : " fmt,							\
> +		__get_str(dev_name), cxl_event_log_type_str(__entry->log),	\
> +		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
> +		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
> +		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
> +		##__VA_ARGS__)
> +
> +TRACE_EVENT(cxl_generic_event,
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
> +
> +/* This part must be outside protection */
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE cxl
> +#include <trace/define_trace.h>
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index c71021a2a9ed..70459be5bdd4 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -24,6 +24,7 @@
>  	___C(IDENTIFY, "Identify Command"),                               \
>  	___C(RAW, "Raw device command"),                                  \
>  	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
> +	___C(GET_EVENT_RECORD, "Get Event Record"),                       \
>  	___C(GET_FW_INFO, "Get FW Info"),                                 \
>  	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
>  	___C(GET_LSA, "Get Label Storage Area"),                          \

