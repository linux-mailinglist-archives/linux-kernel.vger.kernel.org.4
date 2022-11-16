Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F7962C24E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiKPPUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbiKPPTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:19:43 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794064FF8D;
        Wed, 16 Nov 2022 07:19:40 -0800 (PST)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NC66V22R9z689R4;
        Wed, 16 Nov 2022 23:14:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 16:19:38 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 15:19:37 +0000
Date:   Wed, 16 Nov 2022 15:19:36 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 02/11] cxl/mem: Implement Get Event Records command
Message-ID: <20221116151936.0000662f@Huawei.com>
In-Reply-To: <20221110185758.879472-3-ira.weiny@intel.com>
References: <20221110185758.879472-1-ira.weiny@intel.com>
        <20221110185758.879472-3-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Thu, 10 Nov 2022 10:57:49 -0800
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
> The device can return up to 1MB worth of event records per query.  This
> presents complications with allocating a huge buffers to potentially
> capture all the records.  It is not anticipated that these event logs
> will be very deep and reading them does not need to be performant.
> Process only 3 records at a time.  3 records was chosen as it fits
> comfortably on the stack to prevent dynamic allocation while still
> cutting down on extra mailbox messages.
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

A question inline about whether some of the conditions you are checking
for can actually happen. Otherwise looks good to me.

Jonathan

> 
> ---
> Change from RFC v2:
> 	Support reading 3 events at once.
> 	Reverse Jonathan's suggestion and check for positive number of
> 		records.  Because the record count may have been
> 		returned as something > 3 based on what the device
> 		thinks it can send back even though the core Linux mbox
> 		processing truncates the data.
> 	Alison and Dave Jiang
> 		Change header uuid type to uuid_t for better user space
> 		processing
> 	Smita
> 		Check status reg before reading log.
> 	Steven
> 		Prefix all trace points with 'cxl_'
> 		Use static branch <trace>_enabled() calls
> 	Jonathan
> 		s/CXL_EVENT_TYPE_INFO/0
> 		s/{first,last}/{first,last}_ts
> 		Remove Reserved field from header
> 		Fix header issue for cxl_event_log_type_str()
> 
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
>  MAINTAINERS                  |   1 +
>  drivers/cxl/core/mbox.c      |  70 +++++++++++++++++++
>  drivers/cxl/cxl.h            |   8 +++
>  drivers/cxl/cxlmem.h         |  73 ++++++++++++++++++++
>  include/trace/events/cxl.h   | 127 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/cxl_mem.h |   1 +
>  6 files changed, 280 insertions(+)
>  create mode 100644 include/trace/events/cxl.h

> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 16176b9278b4..a908b95a7de4 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c

> +static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> +				    enum cxl_event_log_type type)
> +{
> +	struct cxl_get_event_payload payload;
> +	u16 pl_nr;
> +
> +	do {
> +		u8 log_type = type;
> +		int rc;
> +
> +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_EVENT_RECORD,
> +				       &log_type, sizeof(log_type),
> +				       &payload, sizeof(payload));
> +		if (rc) {
> +			dev_err(cxlds->dev, "Event log '%s': Failed to query event records : %d",
> +				cxl_event_log_type_str(type), rc);
> +			return;
> +		}
> +
> +		pl_nr = le16_to_cpu(payload.record_count);
> +		if (trace_cxl_generic_event_enabled()) {
> +			u16 nr_rec = min_t(u16, pl_nr, CXL_GET_EVENT_NR_RECORDS);

Either I'm misreading the spec, or it can't be greater than NR_RECORDS.
"The number of event records in the Event Records list...."
Event Records being the field inside this payload which is not big enough to
take more than CXL_GET_EVENT_NR_RECORDS and the intro to Get Event Records
refers to the number being restricted by the mailbox output payload provided.

I'm in favor of defense against broken hardware, but don't paper over any
such error - scream about it.

> +			int i;
> +
> +			for (i = 0; i < nr_rec; i++)
> +				trace_cxl_generic_event(dev_name(cxlds->dev),
> +							type,
> +							&payload.record[i]);
> +		}
> +
> +		if (trace_cxl_overflow_enabled() &&
> +		    (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW))
> +			trace_cxl_overflow(dev_name(cxlds->dev), type, &payload);
> +
> +	} while (pl_nr > CXL_GET_EVENT_NR_RECORDS ||

Isn't pl_nr > CXL_GET_EVENT_NR_RECORDS a hardware bug? It's the number in returned
payload not the total number.

> +		 payload.flags & CXL_GET_EVENT_FLAG_MORE_RECORDS);
> +}


> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> new file mode 100644
> index 000000000000..60dec9a84918
> --- /dev/null
> +++ b/include/trace/events/cxl.h
> @@ -0,0 +1,127 @@


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
Trivial: Maybe one blank line is enough?
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

