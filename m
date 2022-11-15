Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE7462AE6F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiKOWjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiKOWjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:39:15 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05377641A;
        Tue, 15 Nov 2022 14:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668551955; x=1700087955;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6p/iUlPxQ3wW5OztvcWbqGpmH/nbEfVJfSgGqNe43OE=;
  b=mmL4dXOFTe5fuJFD+oE/O6jnkP1IqKJSQY/nuhIECBvUJfEZSiCBPtOE
   4wscdDutlhPkkTy+Y5K5m2JOdxFzfEz7Y98+mLrhtytXU2qjb8cHpRWoL
   iQe8NouCYCBOZYmgIQcWjdXefjAxQE8MXKcx3qiQOvlpvPW05/X9iilbE
   biA/WIEYQoKiYquzYQlRItayf1+58r4qlIThbpg+lbbzpWEEWPrW+JQcB
   zmu+aOp5Ok7CvonFRhO7hw38247YGbPYF6iwtrDyc+7Mq2fDmF+MW28RF
   IYGaSanXzVM6Hm4e3qrdvR7bBNt4SHkcDFJGtNYn749ey6j9gGAJsWexI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292777755"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292777755"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 14:39:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="968173720"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="968173720"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.7.249]) ([10.212.7.249])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 14:39:14 -0800
Message-ID: <d632352b-202c-d2ae-4fbf-1390f52e1137@intel.com>
Date:   Tue, 15 Nov 2022 15:39:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH 07/11] cxl/mem: Trace Memory Module Event Record
Content-Language: en-US
To:     ira.weiny@intel.com, Dan Williams <dan.j.williams@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20221110185758.879472-1-ira.weiny@intel.com>
 <20221110185758.879472-8-ira.weiny@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221110185758.879472-8-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2022 10:57 AM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL rev 3.0 section 8.2.9.2.1.3 defines the Memory Module Event Record.
> 
> Determine if the event read is memory module record and if so trace the
> record.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
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
> index b03d7b856f3d..879b228a98a0 100644
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
> index 87c877f0940d..03da4f8f74d3 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -454,6 +454,32 @@ struct cxl_event_dram {
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
> index 37bbe59905af..05437e13a882 100644
> --- a/include/trace/events/cxl.h
> +++ b/include/trace/events/cxl.h
> @@ -335,6 +335,150 @@ TRACE_EVENT(cxl_dram,
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
> +	{ CXL_DHI_HS_MAINTENANCE_NEEDED,	"Maintenance Needed"	}, \
> +	{ CXL_DHI_HS_PERFORMANCE_DEGRADED,	"Performance Degraded"	}, \
> +	{ CXL_DHI_HS_HW_REPLACEMENT_NEEDED,	"Replacement Needed"	}  \
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
