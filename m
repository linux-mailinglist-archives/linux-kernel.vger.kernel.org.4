Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17245FA7C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJJWn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiJJWnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:43:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039397B2BC;
        Mon, 10 Oct 2022 15:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665441790; x=1696977790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OMZr/Z9cHLq6Lac5FQzd8sM80AdPtvflfuAidfNjWO0=;
  b=oCCfkyiunXdrPW4/LKZDkWlP/TzK97p3O7gq9Ru06/EFK1vtcU4GKg99
   Xce8qcXHmKwbIUYb154NF4eNf05bvDtFRQ+7GNpNdGRdN4EGK/2IFBCES
   z+7fRwZzARRyIf6g9vWCTmzUV3FGdF4vsvsvwELkSk8kz1HaYP4CcKSHH
   aYNGrw9MW3+RM2MuVuwQkoWXZiAJJ4IKB7Evrx0sGbHd56o/vs0TgQX/g
   /VKl7QX1sz7nkqn+haivMswowFTgXsSBrkqyAvcqCWwyJ7XFdYEIteBWr
   iovlaGcqGPmQC8nuO8C2k2e6Uqna+co8XGRmJJOQ5s6vwTJpTOqSqLLx/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="287615387"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="287615387"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="621191373"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="621191373"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.252.141.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:07 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [RFC V2 PATCH 07/11] cxl/mem: Trace Memory Module Event Record
Date:   Mon, 10 Oct 2022 15:41:27 -0700
Message-Id: <20221010224131.1866246-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221010224131.1866246-1-ira.weiny@intel.com>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

CXL rev 3.0 section 8.2.9.2.1.3 defines the Memory Module Event Record.

Determine if the event read is memory module record and if so trace the
record.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC:
	Clean up spec reference
	Add reserved data
	Use new CXL header macros
	Jonathan
		Use else if
		Use get_unaligned_le*() for unaligned fields
	Dave Jiang
		s/cxl_mem_mod_event/memory_module
		s/cxl_evt_mem_mod_rec/cxl_event_mem_module
---
 drivers/cxl/core/mbox.c    |  14 ++++
 drivers/cxl/cxlmem.h       |  27 +++++++
 include/trace/events/cxl.h | 146 +++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 72b589edc074..6b3119bc83d2 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -728,6 +728,14 @@ static const uuid_t dram_event_uuid =
 	UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
 		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24);
 
+/*
+ * Memory Module Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+static const uuid_t mem_mod_event_uuid =
+	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
+		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
+
 static void cxl_trace_event_record(const char *dev_name,
 				   enum cxl_event_log_type type,
 				   struct cxl_get_event_payload *payload)
@@ -746,6 +754,12 @@ static void cxl_trace_event_record(const char *dev_name,
 
 		trace_dram(dev_name, type, rec);
 		return;
+	} else if (uuid_equal(id, &mem_mod_event_uuid)) {
+		struct cxl_event_mem_module *rec =
+				(struct cxl_event_mem_module *)&payload->record;
+
+		trace_memory_module(dev_name, type, rec);
+		return;
 	}
 
 	/* For unknown record types print just the header */
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index d0253e5f1187..79b3fac6d9ef 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -455,6 +455,33 @@ struct cxl_event_dram {
 	u8 reserved[CXL_EVENT_DER_RES_SIZE];
 } __packed;
 
+/*
+ * Get Health Info Record
+ * CXL rev 3.0 section 8.2.9.8.3.1; Table 8-100
+ */
+struct cxl_get_health_info {
+	u8 health_status;
+	u8 media_status;
+	u8 add_status;
+	u8 life_used;
+	u8 device_temp[2];
+	u8 dirty_shutdown_cnt[4];
+	u8 cor_vol_err_cnt[4];
+	u8 cor_per_err_cnt[4];
+} __packed;
+
+/*
+ * Memory Module Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+#define CXL_EVENT_MEM_MOD_RES_SIZE	0x3d
+struct cxl_event_mem_module {
+	struct cxl_event_record_hdr hdr;
+	u8 event_type;
+	struct cxl_get_health_info info;
+	u8 reserved[CXL_EVENT_MEM_MOD_RES_SIZE];
+} __packed;
+
 struct cxl_mbox_get_partition_info {
 	__le64 active_volatile_cap;
 	__le64 active_persistent_cap;
diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
index 7a90cfea348b..e2082862ed94 100644
--- a/include/trace/events/cxl.h
+++ b/include/trace/events/cxl.h
@@ -324,6 +324,152 @@ TRACE_EVENT(dram,
 		)
 );
 
+/*
+ * Memory Module Event Record - MMER
+ *
+ * CXL res 3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+#define CXL_MMER_HEALTH_STATUS_CHANGE		0x00
+#define CXL_MMER_MEDIA_STATUS_CHANGE		0x01
+#define CXL_MMER_LIFE_USED_CHANGE		0x02
+#define CXL_MMER_TEMP_CHANGE			0x03
+#define CXL_MMER_DATA_PATH_ERROR		0x04
+#define CXL_MMER_LAS_ERROR			0x05
+#define show_dev_evt_type(type)	__print_symbolic(type,			   \
+	{ CXL_MMER_HEALTH_STATUS_CHANGE,	"Health Status Change"	}, \
+	{ CXL_MMER_MEDIA_STATUS_CHANGE,		"Media Status Change"	}, \
+	{ CXL_MMER_LIFE_USED_CHANGE,		"Life Used Change"	}, \
+	{ CXL_MMER_TEMP_CHANGE,			"Temperature Change"	}, \
+	{ CXL_MMER_DATA_PATH_ERROR,		"Data Path Error"	}, \
+	{ CXL_MMER_LAS_ERROR,			"LSA Error"		}  \
+)
+
+/*
+ * Device Health Information - DHI
+ *
+ * CXL res 3.0 section 8.2.9.8.3.1; Table 8-100
+ */
+#define CXL_DHI_HS_MAINTENANCE_NEEDED				BIT(0)
+#define CXL_DHI_HS_PERFORMANCE_DEGRADED				BIT(1)
+#define CXL_DHI_HS_HW_REPLACEMENT_NEEDED			BIT(2)
+#define show_health_status_flags(flags)	__print_flags(flags, "|",	   \
+	{ CXL_DHI_HS_MAINTENANCE_NEEDED,	"Maintenance Needed"	}, \
+	{ CXL_DHI_HS_PERFORMANCE_DEGRADED,	"Performance Degraded"	}, \
+	{ CXL_DHI_HS_HW_REPLACEMENT_NEEDED,	"Replacement Needed"	}  \
+)
+
+#define CXL_DHI_MS_NORMAL							0x00
+#define CXL_DHI_MS_NOT_READY							0x01
+#define CXL_DHI_MS_WRITE_PERSISTENCY_LOST					0x02
+#define CXL_DHI_MS_ALL_DATA_LOST						0x03
+#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_POWER_LOSS			0x04
+#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_SHUTDOWN			0x05
+#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_IMMINENT				0x06
+#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_POWER_LOSS				0x07
+#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_SHUTDOWN				0x08
+#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_IMMINENT					0x09
+#define show_media_status(ms)	__print_symbolic(ms,			   \
+	{ CXL_DHI_MS_NORMAL,						   \
+		"Normal"						}, \
+	{ CXL_DHI_MS_NOT_READY,						   \
+		"Not Ready"						}, \
+	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOST,				   \
+		"Write Persistency Lost"				}, \
+	{ CXL_DHI_MS_ALL_DATA_LOST,					   \
+		"All Data Lost"						}, \
+	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_POWER_LOSS,		   \
+		"Write Persistency Loss in the Event of Power Loss"	}, \
+	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_SHUTDOWN,		   \
+		"Write Persistency Loss in Event of Shutdown"		}, \
+	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_IMMINENT,			   \
+		"Write Persistency Loss Imminent"			}, \
+	{ CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_POWER_LOSS,		   \
+		"All Data Loss in Event of Power Loss"			}, \
+	{ CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_SHUTDOWN,		   \
+		"All Data loss in the Event of Shutdown"		}, \
+	{ CXL_DHI_MS_WRITE_ALL_DATA_LOSS_IMMINENT,			   \
+		"All Data Loss Imminent"				}  \
+)
+
+#define CXL_DHI_AS_NORMAL		0x0
+#define CXL_DHI_AS_WARNING		0x1
+#define CXL_DHI_AS_CRITICAL		0x2
+#define show_add_status(as) __print_symbolic(as,	   \
+	{ CXL_DHI_AS_NORMAL,		"Normal"	}, \
+	{ CXL_DHI_AS_WARNING,		"Warning"	}, \
+	{ CXL_DHI_AS_CRITICAL,		"Critical"	}  \
+)
+
+#define CXL_DHI_AS_LIFE_USED(as)			(as & 0x3)
+#define CXL_DHI_AS_DEV_TEMP(as)				((as & 0xC) >> 2)
+#define CXL_DHI_AS_COR_VOL_ERR_CNT(as)			((as & 0x10) >> 4)
+#define CXL_DHI_AS_COR_PER_ERR_CNT(as)			((as & 0x20) >> 5)
+
+TRACE_EVENT(memory_module,
+
+	TP_PROTO(const char *dev_name, enum cxl_event_log_type log,
+		 struct cxl_event_mem_module *rec),
+
+	TP_ARGS(dev_name, log, rec),
+
+	TP_STRUCT__entry(
+		CXL_EVT_TP_entry
+
+		/* Memory Module Event */
+		__field(u8, event_type)
+
+		/* Device Health Info */
+		__field(u8, health_status)
+		__field(u8, media_status)
+		__field(u8, life_used)
+		__field(u32, dirty_shutdown_cnt)
+		__field(u32, cor_vol_err_cnt)
+		__field(u32, cor_per_err_cnt)
+		__field(s16, device_temp)
+		__field(u8, add_status)
+
+		__array(u8, reserved, CXL_EVENT_MEM_MOD_RES_SIZE)
+	),
+
+	TP_fast_assign(
+		CXL_EVT_TP_fast_assign(dev_name, log, rec->hdr);
+
+		/* Memory Module Event */
+		__entry->event_type = rec->event_type;
+
+		/* Device Health Info */
+		__entry->health_status = rec->info.health_status;
+		__entry->media_status = rec->info.media_status;
+		__entry->life_used = rec->info.life_used;
+		__entry->dirty_shutdown_cnt = get_unaligned_le32(rec->info.dirty_shutdown_cnt);
+		__entry->cor_vol_err_cnt = get_unaligned_le32(rec->info.cor_vol_err_cnt);
+		__entry->cor_per_err_cnt = get_unaligned_le32(rec->info.cor_per_err_cnt);
+		__entry->device_temp = get_unaligned_le16(rec->info.device_temp);
+		__entry->add_status = rec->info.add_status;
+		memcpy(__entry->reserved, &rec->reserved,
+			CXL_EVENT_MEM_MOD_RES_SIZE);
+	),
+
+	CXL_EVT_TP_printk("evt_type='%s' health_status='%s' media_status='%s' " \
+		"as_life_used=%s as_dev_temp=%s as_cor_vol_err_cnt=%s " \
+		"as_cor_per_err_cnt=%s life_used=%u dev_temp=%d " \
+		"dirty_shutdown_cnt=%u cor_vol_err_cnt=%u cor_per_err_cnt=%u " \
+		"reserved=%s",
+		show_dev_evt_type(__entry->event_type),
+		show_health_status_flags(__entry->health_status),
+		show_media_status(__entry->media_status),
+		show_add_status(CXL_DHI_AS_LIFE_USED(__entry->add_status)),
+		show_add_status(CXL_DHI_AS_DEV_TEMP(__entry->add_status)),
+		show_add_status(CXL_DHI_AS_COR_VOL_ERR_CNT(__entry->add_status)),
+		show_add_status(CXL_DHI_AS_COR_PER_ERR_CNT(__entry->add_status)),
+		__entry->life_used, __entry->device_temp,
+		__entry->dirty_shutdown_cnt, __entry->cor_vol_err_cnt,
+		__entry->cor_per_err_cnt,
+		__print_hex(__entry->reserved, CXL_EVENT_MEM_MOD_RES_SIZE)
+		)
+);
+
+
 #endif /* _CXL_TRACE_EVENTS_H */
 
 /* This part must be outside protection */
-- 
2.37.2

