Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3F363F7CA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiLASzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiLASzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:55:38 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0B3BE69C;
        Thu,  1 Dec 2022 10:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669920937; x=1701456937;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X6rCMESon8MHgZFu+Z/9FPg3fMCvsR+KRpNAqQGS81o=;
  b=IqqJyA/9mLCNsJZiG3k2Dcvb4fKoONFa4Hqh3WL83KwGtHrDIlhnLAWS
   Vz7WHuXQWuI183JKO62XPFPmzwGC4pRksEmQIiV/s99iZww6Fa/UoFcJ4
   /I/xiGjCLzjM64ikJwyWwpvVNDeCTEGc9xWHEVqb2YVPIJMAMv6Gspd8M
   0nzwP92roXG4Y01scOLiqZcLaKEmDSHZjq24HMGaHmljNU1n/YRD+ZD6N
   zhvOcv96qzkfkJam1QKfjgOH4nI6phs5GfBA+4+exKSIFpYKQf37w2DEF
   Zl0Zk0ijhbkhY1g2KBsZ/BjXU3nDG1GDGzgpk4wWMNBL6umK+z8061o9G
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="317637230"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="317637230"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 10:55:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="677320570"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="677320570"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.66.184]) ([10.212.66.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 10:55:36 -0800
Message-ID: <97dbe220-11c2-0d82-c07b-691c71845f4d@intel.com>
Date:   Thu, 1 Dec 2022 11:55:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH V2 06/11] cxl/mem: Trace DRAM Event Record
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
 <20221201002719.2596558-7-ira.weiny@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221201002719.2596558-7-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/2022 5:27 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL rev 3.0 section 8.2.9.2.1.2 defines the DRAM Event Record.
> 
> Determine if the event read is a DRAM event record and if so trace the
> record.
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> Changes from RFC v2:
> 	Output DPA flags as a separate field.
> 	Ensure field names match TP_print output
> 	Steven
> 		prefix TRACE_EVENT with 'cxl_'
> 	Jonathan
> 		Formatting fix
> 		Remove reserved field
> 
> Changes from RFC:
> 	Add reserved byte data
> 	Use new CXL header macros
> 	Jonathan
> 		Use get_unaligned_le{24,16}() for unaligned fields
> 		Use 'else if'
> 	Dave Jiang
> 		s/cxl_dram_event/dram
> 		s/cxl_evt_dram_rec/cxl_event_dram
> 	Adjust for new phys addr mask
> ---
>   drivers/cxl/core/mbox.c    | 16 ++++++-
>   drivers/cxl/cxlmem.h       | 23 ++++++++++
>   include/trace/events/cxl.h | 92 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 130 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 20191fe55bba..66fc50d89bf4 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -717,10 +717,19 @@ static const uuid_t gen_media_event_uuid =
>   	UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
>   		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
>   
> +/*
> + * DRAM Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> + */
> +static const uuid_t dram_event_uuid =
> +	UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
> +		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24);
> +
>   static bool cxl_event_tracing_enabled(void)
>   {
>   	return trace_cxl_generic_event_enabled() ||
> -	       trace_cxl_general_media_enabled();
> +	       trace_cxl_general_media_enabled() ||
> +	       trace_cxl_dram_enabled();
>   }
>   
>   static void cxl_trace_event_record(const char *dev_name,
> @@ -735,6 +744,11 @@ static void cxl_trace_event_record(const char *dev_name,
>   
>   		trace_cxl_general_media(dev_name, type, rec);
>   		return;
> +	} else if (uuid_equal(id, &dram_event_uuid)) {
> +		struct cxl_event_dram *rec = (struct cxl_event_dram *)record;
> +
> +		trace_cxl_dram(dev_name, type, rec);
> +		return;
>   	}
>   
>   	/* For unknown record types print just the header */
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 10696debefa8..f5f63a475478 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -429,6 +429,29 @@ struct cxl_event_gen_media {
>   	u8 reserved[0x2e];
>   } __packed;
>   
> +/*
> + * DRAM Event Record - DER
> + * CXL rev 3.0 section 8.2.9.2.1.2; Table 3-44
> + */
> +#define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
> +struct cxl_event_dram {
> +	struct cxl_event_record_hdr hdr;
> +	__le64 phys_addr;
> +	u8 descriptor;
> +	u8 type;
> +	u8 transaction_type;
> +	u8 validity_flags[2];
> +	u8 channel;
> +	u8 rank;
> +	u8 nibble_mask[3];
> +	u8 bank_group;
> +	u8 bank;
> +	u8 row[3];
> +	u8 column[2];
> +	u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
> +	u8 reserved[0x17];
> +} __packed;
> +
>   struct cxl_mbox_get_partition_info {
>   	__le64 active_volatile_cap;
>   	__le64 active_persistent_cap;
> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> index a4d6bd64e9bc..474390f895d9 100644
> --- a/include/trace/events/cxl.h
> +++ b/include/trace/events/cxl.h
> @@ -242,6 +242,98 @@ TRACE_EVENT(cxl_general_media,
>   	)
>   );
>   
> +/*
> + * DRAM Event Record - DER
> + *
> + * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> + */
> +/*
> + * DRAM Event Record defines many fields the same as the General Media Event
> + * Record.  Reuse those definitions as appropriate.
> + */
> +#define CXL_DER_VALID_CHANNEL				BIT(0)
> +#define CXL_DER_VALID_RANK				BIT(1)
> +#define CXL_DER_VALID_NIBBLE				BIT(2)
> +#define CXL_DER_VALID_BANK_GROUP			BIT(3)
> +#define CXL_DER_VALID_BANK				BIT(4)
> +#define CXL_DER_VALID_ROW				BIT(5)
> +#define CXL_DER_VALID_COLUMN				BIT(6)
> +#define CXL_DER_VALID_CORRECTION_MASK			BIT(7)
> +#define show_dram_valid_flags(flags)	__print_flags(flags, "|",			   \
> +	{ CXL_DER_VALID_CHANNEL,			"CHANNEL"		}, \
> +	{ CXL_DER_VALID_RANK,				"RANK"			}, \
> +	{ CXL_DER_VALID_NIBBLE,				"NIBBLE"		}, \
> +	{ CXL_DER_VALID_BANK_GROUP,			"BANK GROUP"		}, \
> +	{ CXL_DER_VALID_BANK,				"BANK"			}, \
> +	{ CXL_DER_VALID_ROW,				"ROW"			}, \
> +	{ CXL_DER_VALID_COLUMN,				"COLUMN"		}, \
> +	{ CXL_DER_VALID_CORRECTION_MASK,		"CORRECTION MASK"	}  \
> +)
> +
> +TRACE_EVENT(cxl_dram,
> +
> +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> +		 struct cxl_event_dram *rec),
> +
> +	TP_ARGS(dev_name, log, rec),
> +
> +	TP_STRUCT__entry(
> +		CXL_EVT_TP_entry
> +		/* DRAM */
> +		__field(u64, dpa)
> +		__field(u8, descriptor)
> +		__field(u8, type)
> +		__field(u8, transaction_type)
> +		__field(u8, channel)
> +		__field(u16, validity_flags)
> +		__field(u16, column)	/* Out of order to pack trace record */
> +		__field(u32, nibble_mask)
> +		__field(u32, row)
> +		__array(u8, cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE)
> +		__field(u8, rank)	/* Out of order to pack trace record */
> +		__field(u8, bank_group)	/* Out of order to pack trace record */
> +		__field(u8, bank)	/* Out of order to pack trace record */
> +		__field(u8, dpa_flags)	/* Out of order to pack trace record */
> +	),
> +
> +	TP_fast_assign(
> +		CXL_EVT_TP_fast_assign(dev_name, log, rec->hdr);
> +
> +		/* DRAM */
> +		__entry->dpa = le64_to_cpu(rec->phys_addr);
> +		__entry->dpa_flags = __entry->dpa & CXL_DPA_FLAGS_MASK;
> +		__entry->dpa &= CXL_DPA_MASK;
> +		__entry->descriptor = rec->descriptor;
> +		__entry->type = rec->type;
> +		__entry->transaction_type = rec->transaction_type;
> +		__entry->validity_flags = get_unaligned_le16(rec->validity_flags);
> +		__entry->channel = rec->channel;
> +		__entry->rank = rec->rank;
> +		__entry->nibble_mask = get_unaligned_le24(rec->nibble_mask);
> +		__entry->bank_group = rec->bank_group;
> +		__entry->bank = rec->bank;
> +		__entry->row = get_unaligned_le24(rec->row);
> +		__entry->column = get_unaligned_le16(rec->column);
> +		memcpy(__entry->cor_mask, &rec->correction_mask,
> +			CXL_EVENT_DER_CORRECTION_MASK_SIZE);
> +	),
> +
> +	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' descriptor='%s' type='%s' " \
> +		"transaction_type='%s' channel=%u rank=%u nibble_mask=%x " \
> +		"bank_group=%u bank=%u row=%u column=%u cor_mask=%s " \
> +		"validity_flags='%s'",
> +		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
> +		show_event_desc_flags(__entry->descriptor),
> +		show_mem_event_type(__entry->type),
> +		show_trans_type(__entry->transaction_type),
> +		__entry->channel, __entry->rank, __entry->nibble_mask,
> +		__entry->bank_group, __entry->bank,
> +		__entry->row, __entry->column,
> +		__print_hex(__entry->cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE),
> +		show_dram_valid_flags(__entry->validity_flags)
> +	)
> +);
> +
>   #endif /* _CXL_TRACE_EVENTS_H */
>   
>   /* This part must be outside protection */
