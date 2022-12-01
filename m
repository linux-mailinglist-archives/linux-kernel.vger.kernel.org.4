Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D3F63F7CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiLAS5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiLAS5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:57:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83589A7A8A;
        Thu,  1 Dec 2022 10:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669921038; x=1701457038;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZP5Qd529dnLBA62shskdb4YWSABwIzUhlyLtKTCPBuY=;
  b=N4qoBZWUBDECcEJrVtqMcPx4Ifk6yDT319YuRSV0BiV2ad8dW30zuIpw
   yf85A7j30Kg9+FnHK9RRdVBeCK6kpN5+gSkVla15swpKOCciTvtTxNQmI
   vd4AQnswNKuj0yKA0/K1aV79Jfef+ojnnicanvG5JNZbOF9uJptvUf9UL
   MZWoRIxY5bi0wHP2A3HVSxGCifuS8FhfD1qIWoZ38sDJoP/HIdelizGuv
   6Uiy9+IyXdK03huOnQFayPdjGXp5gP+cZsrvAqSrLdRqlOHErfBvJv3NW
   SpPKMCg3NRUbbRexJeW10G1Ife3Ppw66QhJA4ng/t6msqWvALPI00zwWu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="315796994"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="315796994"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 10:57:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="713333700"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="713333700"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.66.184]) ([10.212.66.184])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 10:57:17 -0800
Message-ID: <92114aca-46a9-910b-070e-281bb8ae1886@intel.com>
Date:   Thu, 1 Dec 2022 11:57:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH V2 07/11] cxl/mem: Trace Memory Module Event Record
Content-Language: en-US
To:     ira.weiny@intel.com, Dan Williams <dan.j.williams@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-8-ira.weiny@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221201002719.2596558-8-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/2022 5:27 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL rev 3.0 section 8.2.9.2.1.3 defines the Memory Module Event Record.
> 
> Determine if the event read is memory module record and if so trace the
> record.
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> Changes from V1:
> 	Use all caps for flag fields
> 
> Changes from RFC v2:
> 	Ensure field names match TP_print output
> 	Steven
> 		prefix TRACE_EVENT with 'cxl_'
> 	Jonathan
> 		Remove reserved field
> 		Define a 1bit and 2 bit status decoder
> 		Fix paren alignment
> 
> Changes from RFC:
> 	Clean up spec reference
> 	Add reserved data
> 	Use new CXL header macros
> 	Jonathan
> 		Use else if
> 		Use get_unaligned_le*() for unaligned fields
> 	Dave Jiang
> 		s/cxl_mem_mod_event/memory_module
> 		s/cxl_evt_mem_mod_rec/cxl_event_mem_module
> ---
>   drivers/cxl/core/mbox.c    |  17 ++++-
>   drivers/cxl/cxlmem.h       |  26 +++++++
>   include/trace/events/cxl.h | 144 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 186 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 66fc50d89bf4..30840b711381 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -725,11 +725,20 @@ static const uuid_t dram_event_uuid =
>   	UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
>   		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24);
>   
> +/*
> + * Memory Module Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +static const uuid_t mem_mod_event_uuid =
> +	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
> +		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
> +
>   static bool cxl_event_tracing_enabled(void)
>   {
>   	return trace_cxl_generic_event_enabled() ||
>   	       trace_cxl_general_media_enabled() ||
> -	       trace_cxl_dram_enabled();
> +	       trace_cxl_dram_enabled() ||
> +	       trace_cxl_memory_module_enabled();
>   }
>   
>   static void cxl_trace_event_record(const char *dev_name,
> @@ -749,6 +758,12 @@ static void cxl_trace_event_record(const char *dev_name,
>   
>   		trace_cxl_dram(dev_name, type, rec);
>   		return;
> +	} else if (uuid_equal(id, &mem_mod_event_uuid)) {
> +		struct cxl_event_mem_module *rec =
> +				(struct cxl_event_mem_module *)record;
> +
> +		trace_cxl_memory_module(dev_name, type, rec);
> +		return;
>   	}
>   
>   	/* For unknown record types print just the header */
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index f5f63a475478..450b410f29f6 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -452,6 +452,32 @@ struct cxl_event_dram {
>   	u8 reserved[0x17];
>   } __packed;
>   
> +/*
> + * Get Health Info Record
> + * CXL rev 3.0 section 8.2.9.8.3.1; Table 8-100
> + */
> +struct cxl_get_health_info {
> +	u8 health_status;
> +	u8 media_status;
> +	u8 add_status;
> +	u8 life_used;
> +	u8 device_temp[2];
> +	u8 dirty_shutdown_cnt[4];
> +	u8 cor_vol_err_cnt[4];
> +	u8 cor_per_err_cnt[4];
> +} __packed;
> +
> +/*
> + * Memory Module Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +struct cxl_event_mem_module {
> +	struct cxl_event_record_hdr hdr;
> +	u8 event_type;
> +	struct cxl_get_health_info info;
> +	u8 reserved[0x3d];
> +} __packed;
> +
>   struct cxl_mbox_get_partition_info {
>   	__le64 active_volatile_cap;
>   	__le64 active_persistent_cap;
> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> index 474390f895d9..48786d6c9615 100644
> --- a/include/trace/events/cxl.h
> +++ b/include/trace/events/cxl.h
> @@ -334,6 +334,150 @@ TRACE_EVENT(cxl_dram,
>   	)
>   );
>   
> +/*
> + * Memory Module Event Record - MMER
> + *
> + * CXL res 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +#define CXL_MMER_HEALTH_STATUS_CHANGE		0x00
> +#define CXL_MMER_MEDIA_STATUS_CHANGE		0x01
> +#define CXL_MMER_LIFE_USED_CHANGE		0x02
> +#define CXL_MMER_TEMP_CHANGE			0x03
> +#define CXL_MMER_DATA_PATH_ERROR		0x04
> +#define CXL_MMER_LAS_ERROR			0x05
> +#define show_dev_evt_type(type)	__print_symbolic(type,			   \
> +	{ CXL_MMER_HEALTH_STATUS_CHANGE,	"Health Status Change"	}, \
> +	{ CXL_MMER_MEDIA_STATUS_CHANGE,		"Media Status Change"	}, \
> +	{ CXL_MMER_LIFE_USED_CHANGE,		"Life Used Change"	}, \
> +	{ CXL_MMER_TEMP_CHANGE,			"Temperature Change"	}, \
> +	{ CXL_MMER_DATA_PATH_ERROR,		"Data Path Error"	}, \
> +	{ CXL_MMER_LAS_ERROR,			"LSA Error"		}  \
> +)
> +
> +/*
> + * Device Health Information - DHI
> + *
> + * CXL res 3.0 section 8.2.9.8.3.1; Table 8-100
> + */
> +#define CXL_DHI_HS_MAINTENANCE_NEEDED				BIT(0)
> +#define CXL_DHI_HS_PERFORMANCE_DEGRADED				BIT(1)
> +#define CXL_DHI_HS_HW_REPLACEMENT_NEEDED			BIT(2)
> +#define show_health_status_flags(flags)	__print_flags(flags, "|",	   \
> +	{ CXL_DHI_HS_MAINTENANCE_NEEDED,	"MAINTENANCE_NEEDED"	}, \
> +	{ CXL_DHI_HS_PERFORMANCE_DEGRADED,	"PERFORMANCE_DEGRADED"	}, \
> +	{ CXL_DHI_HS_HW_REPLACEMENT_NEEDED,	"REPLACEMENT_NEEDED"	}  \
> +)
> +
> +#define CXL_DHI_MS_NORMAL							0x00
> +#define CXL_DHI_MS_NOT_READY							0x01
> +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOST					0x02
> +#define CXL_DHI_MS_ALL_DATA_LOST						0x03
> +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_POWER_LOSS			0x04
> +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_SHUTDOWN			0x05
> +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_IMMINENT				0x06
> +#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_POWER_LOSS				0x07
> +#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_SHUTDOWN				0x08
> +#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_IMMINENT					0x09
> +#define show_media_status(ms)	__print_symbolic(ms,			   \
> +	{ CXL_DHI_MS_NORMAL,						   \
> +		"Normal"						}, \
> +	{ CXL_DHI_MS_NOT_READY,						   \
> +		"Not Ready"						}, \
> +	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOST,				   \
> +		"Write Persistency Lost"				}, \
> +	{ CXL_DHI_MS_ALL_DATA_LOST,					   \
> +		"All Data Lost"						}, \
> +	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_POWER_LOSS,		   \
> +		"Write Persistency Loss in the Event of Power Loss"	}, \
> +	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_SHUTDOWN,		   \
> +		"Write Persistency Loss in Event of Shutdown"		}, \
> +	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_IMMINENT,			   \
> +		"Write Persistency Loss Imminent"			}, \
> +	{ CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_POWER_LOSS,		   \
> +		"All Data Loss in Event of Power Loss"			}, \
> +	{ CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_SHUTDOWN,		   \
> +		"All Data loss in the Event of Shutdown"		}, \
> +	{ CXL_DHI_MS_WRITE_ALL_DATA_LOSS_IMMINENT,			   \
> +		"All Data Loss Imminent"				}  \
> +)
> +
> +#define CXL_DHI_AS_NORMAL		0x0
> +#define CXL_DHI_AS_WARNING		0x1
> +#define CXL_DHI_AS_CRITICAL		0x2
> +#define show_two_bit_status(as) __print_symbolic(as,	   \
> +	{ CXL_DHI_AS_NORMAL,		"Normal"	}, \
> +	{ CXL_DHI_AS_WARNING,		"Warning"	}, \
> +	{ CXL_DHI_AS_CRITICAL,		"Critical"	}  \
> +)
> +#define show_one_bit_status(as) __print_symbolic(as,	   \
> +	{ CXL_DHI_AS_NORMAL,		"Normal"	}, \
> +	{ CXL_DHI_AS_WARNING,		"Warning"	}  \
> +)
> +
> +#define CXL_DHI_AS_LIFE_USED(as)			(as & 0x3)
> +#define CXL_DHI_AS_DEV_TEMP(as)				((as & 0xC) >> 2)
> +#define CXL_DHI_AS_COR_VOL_ERR_CNT(as)			((as & 0x10) >> 4)
> +#define CXL_DHI_AS_COR_PER_ERR_CNT(as)			((as & 0x20) >> 5)
> +
> +TRACE_EVENT(cxl_memory_module,
> +
> +	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
> +		 struct cxl_event_mem_module *rec),
> +
> +	TP_ARGS(dev_name, log, rec),
> +
> +	TP_STRUCT__entry(
> +		CXL_EVT_TP_entry
> +
> +		/* Memory Module Event */
> +		__field(u8, event_type)
> +
> +		/* Device Health Info */
> +		__field(u8, health_status)
> +		__field(u8, media_status)
> +		__field(u8, life_used)
> +		__field(u32, dirty_shutdown_cnt)
> +		__field(u32, cor_vol_err_cnt)
> +		__field(u32, cor_per_err_cnt)
> +		__field(s16, device_temp)
> +		__field(u8, add_status)
> +	),
> +
> +	TP_fast_assign(
> +		CXL_EVT_TP_fast_assign(dev_name, log, rec->hdr);
> +
> +		/* Memory Module Event */
> +		__entry->event_type = rec->event_type;
> +
> +		/* Device Health Info */
> +		__entry->health_status = rec->info.health_status;
> +		__entry->media_status = rec->info.media_status;
> +		__entry->life_used = rec->info.life_used;
> +		__entry->dirty_shutdown_cnt = get_unaligned_le32(rec->info.dirty_shutdown_cnt);
> +		__entry->cor_vol_err_cnt = get_unaligned_le32(rec->info.cor_vol_err_cnt);
> +		__entry->cor_per_err_cnt = get_unaligned_le32(rec->info.cor_per_err_cnt);
> +		__entry->device_temp = get_unaligned_le16(rec->info.device_temp);
> +		__entry->add_status = rec->info.add_status;
> +	),
> +
> +	CXL_EVT_TP_printk("event_type='%s' health_status='%s' media_status='%s' " \
> +		"as_life_used=%s as_dev_temp=%s as_cor_vol_err_cnt=%s " \
> +		"as_cor_per_err_cnt=%s life_used=%u device_temp=%d " \
> +		"dirty_shutdown_cnt=%u cor_vol_err_cnt=%u cor_per_err_cnt=%u",
> +		show_dev_evt_type(__entry->event_type),
> +		show_health_status_flags(__entry->health_status),
> +		show_media_status(__entry->media_status),
> +		show_two_bit_status(CXL_DHI_AS_LIFE_USED(__entry->add_status)),
> +		show_two_bit_status(CXL_DHI_AS_DEV_TEMP(__entry->add_status)),
> +		show_one_bit_status(CXL_DHI_AS_COR_VOL_ERR_CNT(__entry->add_status)),
> +		show_one_bit_status(CXL_DHI_AS_COR_PER_ERR_CNT(__entry->add_status)),
> +		__entry->life_used, __entry->device_temp,
> +		__entry->dirty_shutdown_cnt, __entry->cor_vol_err_cnt,
> +		__entry->cor_per_err_cnt
> +	)
> +);
> +
> +
>   #endif /* _CXL_TRACE_EVENTS_H */
>   
>   /* This part must be outside protection */
