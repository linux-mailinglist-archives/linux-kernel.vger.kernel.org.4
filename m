Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC846F80B6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjEEKXM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 May 2023 06:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjEEKXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:23:10 -0400
X-Greylist: delayed 1200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 May 2023 03:23:07 PDT
Received: from mail.avery-design.com.tw (unknown [60.251.56.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19541162F;
        Fri,  5 May 2023 03:23:07 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.avery-design.com.tw (Postfix) with ESMTPSA id 6652C1003C571;
        Fri,  5 May 2023 17:57:26 +0800 (CST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-956ff2399c9so271752166b.3;
        Fri, 05 May 2023 02:47:31 -0700 (PDT)
X-Gm-Message-State: AC+VfDz4Y1QXQ8frIWTErPokpFl5O+Hsc1LbvTjrNZQyHC0CHU1WaiNm
        SCseISHSdhNMuGhh8O8i3YABW6o5FruMpVQZe1k=
X-Google-Smtp-Source: ACHHUZ7YD5vl+DN5qhAzaauFOYSJVE3xP9mCQR+g50HLWvVGP4s43DA9PTe/hvMSB7OBbWL2RF9xcabEj9SKFCB3PPg=
X-Received: by 2002:a17:907:1687:b0:958:cc8:bd55 with SMTP id
 hc7-20020a170907168700b009580cc8bd55mr977486ejc.0.1683280048815; Fri, 05 May
 2023 02:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221216-cxl-ev-log-v7-0-2316a5c8f7d8@intel.com> <20221216-cxl-ev-log-v7-1-2316a5c8f7d8@intel.com>
In-Reply-To: <20221216-cxl-ev-log-v7-1-2316a5c8f7d8@intel.com>
From:   Huai-Cheng <hchkuo@avery-design.com.tw>
Date:   Fri, 5 May 2023 17:47:17 +0800
X-Gmail-Original-Message-ID: <CA+2kVq_L0_OGLR5VXL1sHDeGa+RPTt-Kj9Ajnc8j82jsi2XM7Q@mail.gmail.com>
Message-ID: <CA+2kVq_L0_OGLR5VXL1sHDeGa+RPTt-Kj9Ajnc8j82jsi2XM7Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] cxl/mem: Read, trace, and clear events on driver load
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 1:53 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> CXL devices have multiple event logs which can be queried for CXL event
> records.  Devices are required to support the storage of at least one
> event record in each event log type.
>
> Devices track event log overflow by incrementing a counter and tracking
> the time of the first and last overflow event seen.
>
> Software queries events via the Get Event Record mailbox command; CXL
> rev 3.0 section 8.2.9.2.2 and clears events via CXL rev 3.0 section
> 8.2.9.2.3 Clear Event Records mailbox command.
>
> If the result of negotiating CXL Error Reporting Control is OS control,
> read and clear all event logs on driver load.
>
> Ensure a clean slate of events by reading and clearing the events on
> driver load.
>
> The status register is not used because a device may continue to trigger
> events and the only requirement is to empty the log at least once.  This
> allows for the required transition from empty to non-empty for interrupt
> generation.  Handling of interrupts is in a follow on patch.
>
> The device can return up to 1MB worth of event records per query.
> Allocate a shared large buffer to handle the max number of records based
> on the mailbox payload size.
>
> This patch traces a raw event record and leaves specific event record
> type tracing to subsequent patches.  Macros are created to aid in
> tracing the common CXL Event header fields.
>
> Each record is cleared explicitly.  A clear all bit is specified but is
> only valid when the log overflows.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes in v7:
>         Jonathan
>                 Picked up Jonathans review
>                 Shorten dev error line lengths
>                 Return error from devm_add_action_or_reset
>         Jonathan/Dan
>                 Make struct cxl_mbox_clear_event_payload a dynamic struct
>                 Clarify meaning of CXL_CLEAR_EVENT_MAX_HANDLES
>         Jonathan
>                 Only allocate buffer if native cxl error is true
> ---
>  drivers/cxl/core/mbox.c  | 148 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/trace.h | 120 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h        |  12 ++++
>  drivers/cxl/cxlmem.h     |  79 +++++++++++++++++++++++++
>  drivers/cxl/pci.c        |  42 ++++++++++++++
>  5 files changed, 401 insertions(+)
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index b03fba212799..c329c1e67a2c 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -8,6 +8,7 @@
>  #include <cxl.h>
>
>  #include "core.h"
> +#include "trace.h"
>
>  static bool cxl_raw_allow_all;
>
> @@ -717,6 +718,152 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>
> +static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
> +                                 enum cxl_event_log_type log,
> +                                 struct cxl_get_event_payload *get_pl)
> +{
> +       struct cxl_mbox_clear_event_payload *payload;
> +       u16 total = le16_to_cpu(get_pl->record_count);
> +       u8 max_handles = CXL_CLEAR_EVENT_MAX_HANDLES;
> +       size_t pl_size = struct_size(payload, handles, max_handles);
> +       struct cxl_mbox_cmd mbox_cmd;
> +       u16 cnt;
> +       int rc = 0;
> +       int i;
> +
> +       /* Payload size may limit the max handles */
> +       if (pl_size > cxlds->payload_size) {
> +               max_handles = (cxlds->payload_size - sizeof(*payload)) /
> +                               sizeof(__le16);
> +               pl_size = struct_size(payload, handles, max_handles);
> +       }
> +
> +       payload = kvzalloc(pl_size, GFP_KERNEL);
> +       if (!payload)
> +               return -ENOMEM;
> +
> +       *payload = (struct cxl_mbox_clear_event_payload) {
> +               .event_log = log,
> +       };
> +
> +       mbox_cmd = (struct cxl_mbox_cmd) {
> +               .opcode = CXL_MBOX_OP_CLEAR_EVENT_RECORD,
> +               .payload_in = payload,
> +               .size_in = pl_size,
> +       };
> +
> +       /*
> +        * Clear Event Records uses u8 for the handle cnt while Get Event
> +        * Record can return up to 0xffff records.
> +        */
> +       i = 0;
> +       for (cnt = 0; cnt < total; cnt++) {
> +               payload->handles[i++] = get_pl->records[cnt].hdr.handle;
> +               dev_dbg(cxlds->dev, "Event log '%d': Clearing %u\n",
> +                       log, le16_to_cpu(payload->handles[i]));
> +
> +               if (i == max_handles) {
> +                       payload->nr_recs = i;
> +                       rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +                       if (rc)
> +                               goto free_pl;
> +                       i = 0;
> +               }
> +       }
> +
> +       /* Clear what is left if any */
> +       if (i) {
> +               payload->nr_recs = i;
> +               mbox_cmd.size_in = struct_size(payload, handles, i);
> +               rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +               if (rc)
> +                       goto free_pl;
> +       }
> +
> +free_pl:
> +       kvfree(payload);
> +       return rc;
> +}
> +
> +static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> +                                   enum cxl_event_log_type type)
> +{
> +       struct cxl_get_event_payload *payload;
> +       struct cxl_mbox_cmd mbox_cmd;
> +       u8 log_type = type;
> +       u16 nr_rec;
> +
> +       mutex_lock(&cxlds->event.log_lock);
> +       payload = cxlds->event.buf;
> +
> +       mbox_cmd = (struct cxl_mbox_cmd) {
> +               .opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
> +               .payload_in = &log_type,
> +               .size_in = sizeof(log_type),
> +               .payload_out = payload,
> +               .size_out = cxlds->payload_size,
> +               .min_out = struct_size(payload, records, 0),
> +       };
> +
> +       do {
> +               int rc, i;
> +
> +               rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +               if (rc) {
> +                       dev_err_ratelimited(cxlds->dev,
> +                               "Event log '%d': Failed to query event records : %d",
> +                               type, rc);
> +                       break;
> +               }
> +
> +               nr_rec = le16_to_cpu(payload->record_count);
> +               if (!nr_rec)
> +                       break;
> +
> +               for (i = 0; i < nr_rec; i++)
> +                       trace_cxl_generic_event(cxlds->dev, type,
> +                                               &payload->records[i]);
> +
> +               if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> +                       trace_cxl_overflow(cxlds->dev, type, payload);
> +
> +               rc = cxl_clear_event_record(cxlds, type, payload);
> +               if (rc) {
> +                       dev_err_ratelimited(cxlds->dev,
> +                               "Event log '%d': Failed to clear events : %d",
> +                               type, rc);
> +                       break;
> +               }
> +       } while (nr_rec);
Should the (payload->flags & CXL_GET_EVENT_FLAG_MORE_RECORDS) be used
instead of (nr_rec) in this while condition? According to the spec,
this bit is used to see if there
are more event records.
> +
> +       mutex_unlock(&cxlds->event.log_lock);
> +}
> +
> +/**
> + * cxl_mem_get_event_records - Get Event Records from the device
> + * @cxlds: The device data for the operation
> + *
> + * Retrieve all event records available on the device, report them as trace
> + * events, and clear them.
> + *
> + * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
> + * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
> + */
> +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status)
> +{
> +       dev_dbg(cxlds->dev, "Reading event logs: %x\n", status);
> +
> +       if (status & CXLDEV_EVENT_STATUS_FATAL)
> +               cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FATAL);
> +       if (status & CXLDEV_EVENT_STATUS_FAIL)
> +               cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
> +       if (status & CXLDEV_EVENT_STATUS_WARN)
> +               cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);
> +       if (status & CXLDEV_EVENT_STATUS_INFO)
> +               cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_INFO);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
> +
>  /**
>   * cxl_mem_get_partition_info - Get partition info
>   * @cxlds: The device data for the operation
> @@ -868,6 +1015,7 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>         }
>
>         mutex_init(&cxlds->mbox_mutex);
> +       mutex_init(&cxlds->event.log_lock);
>         cxlds->dev = dev;
>
>         return cxlds;
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 20ca2fe2ca8e..6898212fcb47 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -6,7 +6,9 @@
>  #if !defined(_CXL_EVENTS_H) || defined(TRACE_HEADER_MULTI_READ)
>  #define _CXL_EVENTS_H
>
> +#include <asm-generic/unaligned.h>
>  #include <cxl.h>
> +#include <cxlmem.h>
>  #include <linux/tracepoint.h>
>
>  #define CXL_RAS_UC_CACHE_DATA_PARITY   BIT(0)
> @@ -103,6 +105,124 @@ TRACE_EVENT(cxl_aer_correctable_error,
>         )
>  );
>
> +#include <linux/tracepoint.h>
> +
> +#define cxl_event_log_type_str(type)                           \
> +       __print_symbolic(type,                                  \
> +               { CXL_EVENT_TYPE_INFO, "Informational" },       \
> +               { CXL_EVENT_TYPE_WARN, "Warning" },             \
> +               { CXL_EVENT_TYPE_FAIL, "Failure" },             \
> +               { CXL_EVENT_TYPE_FATAL, "Fatal" })
> +
> +TRACE_EVENT(cxl_overflow,
> +
> +       TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
> +                struct cxl_get_event_payload *payload),
> +
> +       TP_ARGS(dev, log, payload),
> +
> +       TP_STRUCT__entry(
> +               __string(dev_name, dev_name(dev))
> +               __field(int, log)
> +               __field(u64, first_ts)
> +               __field(u64, last_ts)
> +               __field(u16, count)
> +       ),
> +
> +       TP_fast_assign(
> +               __assign_str(dev_name, dev_name(dev));
> +               __entry->log = log;
> +               __entry->count = le16_to_cpu(payload->overflow_err_count);
> +               __entry->first_ts = le64_to_cpu(payload->first_overflow_timestamp);
> +               __entry->last_ts = le64_to_cpu(payload->last_overflow_timestamp);
> +       ),
> +
> +       TP_printk("%s: log=%s : %u records from %llu to %llu",
> +               __get_str(dev_name), cxl_event_log_type_str(__entry->log),
> +               __entry->count, __entry->first_ts, __entry->last_ts)
> +
> +);
> +
> +/*
> + * Common Event Record Format
> + * CXL 3.0 section 8.2.9.2.1; Table 8-42
> + */
> +#define CXL_EVENT_RECORD_FLAG_PERMANENT                BIT(2)
> +#define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED     BIT(3)
> +#define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED    BIT(4)
> +#define CXL_EVENT_RECORD_FLAG_HW_REPLACE       BIT(5)
> +#define show_hdr_flags(flags)  __print_flags(flags, " | ",                        \
> +       { CXL_EVENT_RECORD_FLAG_PERMANENT,      "PERMANENT_CONDITION"           }, \
> +       { CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,   "MAINTENANCE_NEEDED"            }, \
> +       { CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,  "PERFORMANCE_DEGRADED"          }, \
> +       { CXL_EVENT_RECORD_FLAG_HW_REPLACE,     "HARDWARE_REPLACEMENT_NEEDED"   }  \
> +)
> +
> +/*
> + * Define macros for the common header of each CXL event.
> + *
> + * Tracepoints using these macros must do 3 things:
> + *
> + *     1) Add CXL_EVT_TP_entry to TP_STRUCT__entry
> + *     2) Use CXL_EVT_TP_fast_assign within TP_fast_assign;
> + *        pass the dev, log, and CXL event header
> + *     3) Use CXL_EVT_TP_printk() instead of TP_printk()
> + *
> + * See the generic_event tracepoint as an example.
> + */
> +#define CXL_EVT_TP_entry                                       \
> +       __string(dev_name, dev_name(dev))                       \
> +       __field(int, log)                                       \
> +       __field_struct(uuid_t, hdr_uuid)                        \
> +       __field(u32, hdr_flags)                                 \
> +       __field(u16, hdr_handle)                                \
> +       __field(u16, hdr_related_handle)                        \
> +       __field(u64, hdr_timestamp)                             \
> +       __field(u8, hdr_length)                                 \
> +       __field(u8, hdr_maint_op_class)
> +
> +#define CXL_EVT_TP_fast_assign(dev, l, hdr)                                    \
> +       __assign_str(dev_name, dev_name(dev));                                  \
> +       __entry->log = (l);                                                     \
> +       memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));                  \
> +       __entry->hdr_length = (hdr).length;                                     \
> +       __entry->hdr_flags = get_unaligned_le24((hdr).flags);                   \
> +       __entry->hdr_handle = le16_to_cpu((hdr).handle);                        \
> +       __entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);        \
> +       __entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);                  \
> +       __entry->hdr_maint_op_class = (hdr).maint_op_class
> +
> +#define CXL_EVT_TP_printk(fmt, ...) \
> +       TP_printk("%s log=%s : time=%llu uuid=%pUb len=%d flags='%s' "          \
> +               "handle=%x related_handle=%x maint_op_class=%u"                 \
> +               " : " fmt,                                                      \
> +               __get_str(dev_name), cxl_event_log_type_str(__entry->log),      \
> +               __entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
> +               show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,        \
> +               __entry->hdr_related_handle, __entry->hdr_maint_op_class,       \
> +               ##__VA_ARGS__)
> +
> +TRACE_EVENT(cxl_generic_event,
> +
> +       TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
> +                struct cxl_event_record_raw *rec),
> +
> +       TP_ARGS(dev, log, rec),
> +
> +       TP_STRUCT__entry(
> +               CXL_EVT_TP_entry
> +               __array(u8, data, CXL_EVENT_RECORD_DATA_LENGTH)
> +       ),
> +
> +       TP_fast_assign(
> +               CXL_EVT_TP_fast_assign(dev, log, rec->hdr);
> +               memcpy(__entry->data, &rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
> +       ),
> +
> +       CXL_EVT_TP_printk("%s",
> +               __print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
> +);
> +
>  #endif /* _CXL_EVENTS_H */
>
>  #define TRACE_INCLUDE_FILE trace
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index aa3af3bb73b2..5974d1082210 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -156,6 +156,18 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX 0x3
>  #define CXLDEV_CAP_CAP_ID_MEMDEV 0x4000
>
> +/* CXL 3.0 8.2.8.3.1 Event Status Register */
> +#define CXLDEV_DEV_EVENT_STATUS_OFFSET         0x00
> +#define CXLDEV_EVENT_STATUS_INFO               BIT(0)
> +#define CXLDEV_EVENT_STATUS_WARN               BIT(1)
> +#define CXLDEV_EVENT_STATUS_FAIL               BIT(2)
> +#define CXLDEV_EVENT_STATUS_FATAL              BIT(3)
> +
> +#define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |    \
> +                                CXLDEV_EVENT_STATUS_WARN |     \
> +                                CXLDEV_EVENT_STATUS_FAIL |     \
> +                                CXLDEV_EVENT_STATUS_FATAL)
> +
>  /* CXL 2.0 8.2.8.4 Mailbox Registers */
>  #define CXLDEV_MBOX_CAPS_OFFSET 0x00
>  #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ab138004f644..0f272206e294 100644
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
> @@ -193,6 +194,17 @@ struct cxl_endpoint_dvsec_info {
>         struct range dvsec_range[2];
>  };
>
> +/**
> + * struct cxl_event_state - Event log driver state
> + *
> + * @event_buf: Buffer to receive event data
> + * @event_log_lock: Serialize event_buf and log use
> + */
> +struct cxl_event_state {
> +       struct cxl_get_event_payload *buf;
> +       struct mutex log_lock;
> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -266,12 +278,16 @@ struct cxl_dev_state {
>
>         struct xarray doe_mbs;
>
> +       struct cxl_event_state event;
> +
>         int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
>
>  enum cxl_opcode {
>         CXL_MBOX_OP_INVALID             = 0x0000,
>         CXL_MBOX_OP_RAW                 = CXL_MBOX_OP_INVALID,
> +       CXL_MBOX_OP_GET_EVENT_RECORD    = 0x0100,
> +       CXL_MBOX_OP_CLEAR_EVENT_RECORD  = 0x0101,
>         CXL_MBOX_OP_GET_FW_INFO         = 0x0200,
>         CXL_MBOX_OP_ACTIVATE_FW         = 0x0202,
>         CXL_MBOX_OP_GET_SUPPORTED_LOGS  = 0x0400,
> @@ -347,6 +363,68 @@ struct cxl_mbox_identify {
>         u8 qos_telemetry_caps;
>  } __packed;
>
> +/*
> + * Common Event Record Format
> + * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> + */
> +struct cxl_event_record_hdr {
> +       uuid_t id;
> +       u8 length;
> +       u8 flags[3];
> +       __le16 handle;
> +       __le16 related_handle;
> +       __le64 timestamp;
> +       u8 maint_op_class;
> +       u8 reserved[15];
> +} __packed;
> +
> +#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
> +struct cxl_event_record_raw {
> +       struct cxl_event_record_hdr hdr;
> +       u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
> +} __packed;
> +
> +/*
> + * Get Event Records output payload
> + * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
> + */
> +#define CXL_GET_EVENT_FLAG_OVERFLOW            BIT(0)
> +#define CXL_GET_EVENT_FLAG_MORE_RECORDS                BIT(1)
> +struct cxl_get_event_payload {
> +       u8 flags;
> +       u8 reserved1;
> +       __le16 overflow_err_count;
> +       __le64 first_overflow_timestamp;
> +       __le64 last_overflow_timestamp;
> +       __le16 record_count;
> +       u8 reserved2[10];
> +       struct cxl_event_record_raw records[];
> +} __packed;
> +
> +/*
> + * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
> + */
> +enum cxl_event_log_type {
> +       CXL_EVENT_TYPE_INFO = 0x00,
> +       CXL_EVENT_TYPE_WARN,
> +       CXL_EVENT_TYPE_FAIL,
> +       CXL_EVENT_TYPE_FATAL,
> +       CXL_EVENT_TYPE_MAX
> +};
> +
> +/*
> + * Clear Event Records input payload
> + * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
> + */
> +struct cxl_mbox_clear_event_payload {
> +       u8 event_log;           /* enum cxl_event_log_type */
> +       u8 clear_flags;
> +       u8 nr_recs;
> +       u8 reserved[3];
> +       __le16 handles[];
> +} __packed;
> +#define CXL_CLEAR_EVENT_MAX_HANDLES 0xff /* max based on nr_recs */
> +
>  struct cxl_mbox_get_partition_info {
>         __le64 active_volatile_cap;
>         __le64 active_persistent_cap;
> @@ -441,6 +519,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status);
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 3a66aadb4df0..0fd7742ee70c 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -417,8 +417,39 @@ static void disable_aer(void *pdev)
>         pci_disable_pcie_error_reporting(pdev);
>  }
>
> +static void cxl_mem_free_event_buffer(void *buf)
> +{
> +       kvfree(buf);
> +}
> +
> +/*
> + * There is a single buffer for reading event logs from the mailbox.  All logs
> + * share this buffer protected by the cxlds->event_log_lock.
> + */
> +static int cxl_mem_alloc_event_buf(struct cxl_dev_state *cxlds)
> +{
> +       struct cxl_get_event_payload *buf;
> +       int rc;
> +
> +       dev_dbg(cxlds->dev, "Allocating event buffer size %zu\n",
> +               cxlds->payload_size);
> +
> +       buf = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       rc = devm_add_action_or_reset(cxlds->dev, cxl_mem_free_event_buffer,
> +                                     buf);
> +       if (rc)
> +               return rc;
> +
> +       cxlds->event.buf = buf;
> +       return 0;
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> +       struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>         struct cxl_register_map map;
>         struct cxl_memdev *cxlmd;
>         struct cxl_dev_state *cxlds;
> @@ -494,6 +525,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>         if (IS_ERR(cxlmd))
>                 return PTR_ERR(cxlmd);
>
> +       /*
> +        * When BIOS maintains CXL error reporting control, it will process
> +        * event records.  Only one agent can do so.
> +        */
> +       if (host_bridge->native_cxl_error) {
> +               rc = cxl_mem_alloc_event_buf(cxlds);
> +               if (rc)
> +                       return rc;
> +               cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> +       }
> +
>         if (cxlds->regs.ras) {
>                 pci_enable_pcie_error_reporting(pdev);
>                 rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
>
> --
> 2.39.0
Best Regards,
Huai-Cheng Kuo
