Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197B763F7C5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiLASyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiLASyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:54:35 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722DFA7A8A;
        Thu,  1 Dec 2022 10:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669920874; x=1701456874;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Jdd3JeTcAYRw6AHft7jx0LnYEUDxhppfNugWgzzgMoA=;
  b=YEELlC5tiR06EDVnMA4nXtNW3CX6GxJv7pS78V05npq1pYEDz0KqegOG
   LaLQi1Ndqp+8jOdBINFJfSqJC4BB1mQtPAw4xVo8+FNkPsnlA1HxKpoNb
   MMcHsLFQUD5iemY73lribD5+Vk9KGACvLubZdLlbDRCWjpPoUGPQo5zCw
   fMBoCw3PEzy0h6f+wMEL6KJ0hsKq4PXxZi/yn5uDciBp2WLxKxfokrug3
   pVRJUehE4VC1NwG0zzF8rrp793uue8yuK+o/YjjJ2NJvxrBXpI7KkhC9+
   +wOxGN88y3bH0wF/tZqvKnQ5wwkSJGrcCnBee7gi7Yz0b7LjuKuNYsCTx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="303376018"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="303376018"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 10:54:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="733526636"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="733526636"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.66.184]) ([10.212.66.184])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 10:54:33 -0800
Message-ID: <f4d03365-2bbb-8b54-4868-7174978089eb@intel.com>
Date:   Thu, 1 Dec 2022 11:54:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH V2 05/11] cxl/mem: Trace General Media Event Record
Content-Language: en-US
To:     ira.weiny@intel.com, Dan Williams <dan.j.williams@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-6-ira.weiny@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221201002719.2596558-6-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/2022 5:27 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL rev 3.0 section 8.2.9.2.1.1 defines the General Media Event Record.
> 
> Determine if the event read is a general media record and if so trace
> the record as a General Media Event Record.
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> Changes from V1:
> 	Jonathan
> 		fix spec references for CXL rev 3.0
> 		Make flags all caps
> 
> Changes from RFC v2:
> 	Output DPA flags as a single field
> 	Ensure names of fields match what TP_print outputs
> 	Steven
> 		prefix TRACE_EVENT with 'cxl_'
> 	Jonathan
> 		Remove Reserved field
> 
> Changes from RFC:
> 	Add reserved byte array
> 	Use common CXL event header record macros
> 	Jonathan
> 		Use unaligned_le{24,16} for unaligned fields
> 		Don't use the inverse of phy addr mask
> 	Dave Jiang
> 		s/cxl_gen_media_event/general_media
> 		s/cxl_evt_gen_media/cxl_event_gen_media
> ---
>   drivers/cxl/core/mbox.c    |  40 ++++++++++--
>   drivers/cxl/cxlmem.h       |  19 ++++++
>   include/trace/events/cxl.h | 124 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 179 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 076a3df0ba38..20191fe55bba 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -709,6 +709,38 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>   
> +/*
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +static const uuid_t gen_media_event_uuid =
> +	UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
> +		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
> +
> +static bool cxl_event_tracing_enabled(void)
> +{
> +	return trace_cxl_generic_event_enabled() ||
> +	       trace_cxl_general_media_enabled();
> +}
> +
> +static void cxl_trace_event_record(const char *dev_name,
> +				   enum cxl_event_log_type type,
> +				   struct cxl_event_record_raw *record)
> +{
> +	uuid_t *id = &record->hdr.id;
> +
> +	if (uuid_equal(id, &gen_media_event_uuid)) {
> +		struct cxl_event_gen_media *rec =
> +				(struct cxl_event_gen_media *)record;
> +
> +		trace_cxl_general_media(dev_name, type, rec);
> +		return;
> +	}
> +
> +	/* For unknown record types print just the header */
> +	trace_cxl_generic_event(dev_name, type, record);
> +}
> +
>   static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
>   				  enum cxl_event_log_type log,
>   				  struct cxl_get_event_payload *get_pl,
> @@ -772,11 +804,11 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
>   		if (nr_rec > 0) {
>   			int i;
>   
> -			if (trace_cxl_generic_event_enabled()) {
> +			if (cxl_event_tracing_enabled()) {
>   				for (i = 0; i < nr_rec; i++)
> -					trace_cxl_generic_event(dev_name(cxlds->dev),
> -								type,
> -								&payload->records[i]);
> +					cxl_trace_event_record(dev_name(cxlds->dev),
> +							       type,
> +							       &payload->records[i]);
>   			}
>   
>   			rc = cxl_clear_event_record(cxlds, type, payload, nr_rec);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 1ae9962c5a06..10696debefa8 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -410,6 +410,25 @@ struct cxl_mbox_clear_event_payload {
>   	__le16 handle[CXL_CLEAR_EVENT_MAX_HANDLES];
>   };
>   
> +/*
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +#define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
> +struct cxl_event_gen_media {
> +	struct cxl_event_record_hdr hdr;
> +	__le64 phys_addr;
> +	u8 descriptor;
> +	u8 type;
> +	u8 transaction_type;
> +	u8 validity_flags[2];
> +	u8 channel;
> +	u8 rank;
> +	u8 device[3];
> +	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +	u8 reserved[0x2e];
> +} __packed;
> +
>   struct cxl_mbox_get_partition_info {
>   	__le64 active_volatile_cap;
>   	__le64 active_persistent_cap;
> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> index c03a1a894af8..a4d6bd64e9bc 100644
> --- a/include/trace/events/cxl.h
> +++ b/include/trace/events/cxl.h
> @@ -118,6 +118,130 @@ TRACE_EVENT(cxl_generic_event,
>   		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
>   );
>   
> +/*
> + * Physical Address field masks
> + *
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + *
> + * DRAM Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> + */
> +#define CXL_DPA_FLAGS_MASK			0x3F
> +#define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
> +
> +#define CXL_DPA_VOLATILE			BIT(0)
> +#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
> +#define show_dpa_flags(flags)	__print_flags(flags, "|",		   \
> +	{ CXL_DPA_VOLATILE,			"VOLATILE"		}, \
> +	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
> +)
> +
> +/*
> + * General Media Event Record - GMER
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +#define CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT		BIT(0)
> +#define CXL_GMER_EVT_DESC_THRESHOLD_EVENT		BIT(1)
> +#define CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW		BIT(2)
> +#define show_event_desc_flags(flags)	__print_flags(flags, "|",		   \
> +	{ CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,		"UNCORRECTABLE_EVENT"	}, \
> +	{ CXL_GMER_EVT_DESC_THRESHOLD_EVENT,		"THRESHOLD_EVENT"	}, \
> +	{ CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW,	"POISON_LIST_OVERFLOW"	}  \
> +)
> +
> +#define CXL_GMER_MEM_EVT_TYPE_ECC_ERROR			0x00
> +#define CXL_GMER_MEM_EVT_TYPE_INV_ADDR			0x01
> +#define CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x02
> +#define show_mem_event_type(type)	__print_symbolic(type,			\
> +	{ CXL_GMER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },		\
> +	{ CXL_GMER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },	\
> +	{ CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,	"Data Path Error" }	\
> +)
> +
> +#define CXL_GMER_TRANS_UNKNOWN				0x00
> +#define CXL_GMER_TRANS_HOST_READ			0x01
> +#define CXL_GMER_TRANS_HOST_WRITE			0x02
> +#define CXL_GMER_TRANS_HOST_SCAN_MEDIA			0x03
> +#define CXL_GMER_TRANS_HOST_INJECT_POISON		0x04
> +#define CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB		0x05
> +#define CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT	0x06
> +#define show_trans_type(type)	__print_symbolic(type,					\
> +	{ CXL_GMER_TRANS_UNKNOWN,			"Unknown" },			\
> +	{ CXL_GMER_TRANS_HOST_READ,			"Host Read" },			\
> +	{ CXL_GMER_TRANS_HOST_WRITE,			"Host Write" },			\
> +	{ CXL_GMER_TRANS_HOST_SCAN_MEDIA,		"Host Scan Media" },		\
> +	{ CXL_GMER_TRANS_HOST_INJECT_POISON,		"Host Inject Poison" },		\
> +	{ CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,		"Internal Media Scrub" },	\
> +	{ CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT,	"Internal Media Management" }	\
> +)
> +
> +#define CXL_GMER_VALID_CHANNEL				BIT(0)
> +#define CXL_GMER_VALID_RANK				BIT(1)
> +#define CXL_GMER_VALID_DEVICE				BIT(2)
> +#define CXL_GMER_VALID_COMPONENT			BIT(3)
> +#define show_valid_flags(flags)	__print_flags(flags, "|",		   \
> +	{ CXL_GMER_VALID_CHANNEL,			"CHANNEL"	}, \
> +	{ CXL_GMER_VALID_RANK,				"RANK"		}, \
> +	{ CXL_GMER_VALID_DEVICE,			"DEVICE"	}, \
> +	{ CXL_GMER_VALID_COMPONENT,			"COMPONENT"	}  \
> +)
> +
> +TRACE_EVENT(cxl_general_media,
> +
> +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> +		 struct cxl_event_gen_media *rec),
> +
> +	TP_ARGS(dev_name, log, rec),
> +
> +	TP_STRUCT__entry(
> +		CXL_EVT_TP_entry
> +		/* General Media */
> +		__field(u64, dpa)
> +		__field(u8, descriptor)
> +		__field(u8, type)
> +		__field(u8, transaction_type)
> +		__field(u8, channel)
> +		__field(u32, device)
> +		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
> +		__field(u16, validity_flags)
> +		/* Following are out of order to pack trace record */
> +		__field(u8, rank)
> +		__field(u8, dpa_flags)
> +	),
> +
> +	TP_fast_assign(
> +		CXL_EVT_TP_fast_assign(dev_name, log, rec->hdr);
> +
> +		/* General Media */
> +		__entry->dpa = le64_to_cpu(rec->phys_addr);
> +		__entry->dpa_flags = __entry->dpa & CXL_DPA_FLAGS_MASK;
> +		/* Mask after flags have been parsed */
> +		__entry->dpa &= CXL_DPA_MASK;
> +		__entry->descriptor = rec->descriptor;
> +		__entry->type = rec->type;
> +		__entry->transaction_type = rec->transaction_type;
> +		__entry->channel = rec->channel;
> +		__entry->rank = rec->rank;
> +		__entry->device = get_unaligned_le24(rec->device);
> +		memcpy(__entry->comp_id, &rec->component_id,
> +			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
> +		__entry->validity_flags = get_unaligned_le16(&rec->validity_flags);
> +	),
> +
> +	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \
> +		"descriptor='%s' type='%s' transaction_type='%s' channel=%u rank=%u " \
> +		"device=%x comp_id=%s validity_flags='%s'",
> +		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
> +		show_event_desc_flags(__entry->descriptor),
> +		show_mem_event_type(__entry->type),
> +		show_trans_type(__entry->transaction_type),
> +		__entry->channel, __entry->rank, __entry->device,
> +		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
> +		show_valid_flags(__entry->validity_flags)
> +	)
> +);
> +
>   #endif /* _CXL_TRACE_EVENTS_H */
>   
>   /* This part must be outside protection */
