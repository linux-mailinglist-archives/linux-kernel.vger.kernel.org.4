Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CA969751D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjBOENP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBOENE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:13:04 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4628241C5;
        Tue, 14 Feb 2023 20:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676434383; x=1707970383;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=IGyWMYciUslHEYV1SyNUcPNSTP6hK0gf7hhbx21h8G8=;
  b=AY15KkvDpI6VWfeCENI7fvyBgIB+h1s7pS5JY/WbtjA805iJ2UdoGibg
   Y2UEiTCyD+ej5pXbK+km3yOc3Bqo/ZWqlFJrGML3FTiaWRvVMZ3NzQCJU
   MwupPP3OAcy71V+yF/66DVqeot71nYRpVOa3s0dMCDunHbuK+pZH58kbK
   F67Jqd/RaI++EXzYf2dvFDlgpXIwroOnYA43idMyAHVbSEFYJzc7CluH1
   vfCwoHMwenzPg7sKcMorIlxMYeVaYeRaTMJnRDY940nTfL2dAcPwmfl3y
   JpW3b26zKHuejy+zhjRkZ93UjbTz4j0+Ae3wHZWenxGV3TQ5BuVO19rcI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="311706807"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="311706807"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 20:13:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="647016999"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="647016999"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.74.178])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 20:13:00 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Tue, 14 Feb 2023 20:12:44 -0800
Subject: [PATCH v2 2/3] cxl/trace: Add host output to trace points
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230208-cxl-event-names-v2-2-fca130c2c68b@intel.com>
References: <20230208-cxl-event-names-v2-0-fca130c2c68b@intel.com>
In-Reply-To: <20230208-cxl-event-names-v2-0-fca130c2c68b@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Jiang <dave.jiang@intel.com>
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676434378; l=4670;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=IGyWMYciUslHEYV1SyNUcPNSTP6hK0gf7hhbx21h8G8=;
 b=l/uO+zxczN1O6TEigg2pxzvc0xM9VDRHf5i13B3Oa3JqhDPH8qUs7JsAJdWDm5M4mCyK1o1XfSCn
 HIgd8rfQAUGrsMdIcEh4FFRnBOHQ+Zt5hvoPbhJz3J3mhixwsem8
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host parameter of where the memdev is connected is useful
information.

Report host consistently in all trace points.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v2
	Correctly use parens in the CXL_EVT_TP_fast_assign macro
---
 drivers/cxl/core/trace.h | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 93ac651a2f21..ed69e558187b 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -51,12 +51,14 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	TP_ARGS(cxlmd, status, fe, hl),
 	TP_STRUCT__entry(
 		__string(memdev, dev_name(&cxlmd->dev))
+		__string(host, dev_name(cxlmd->dev.parent))
 		__field(u32, status)
 		__field(u32, first_error)
 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
 	),
 	TP_fast_assign(
 		__assign_str(memdev, dev_name(&cxlmd->dev));
+		__assign_str(host, dev_name(cxlmd->dev.parent));
 		__entry->status = status;
 		__entry->first_error = fe;
 		/*
@@ -65,8 +67,8 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 		 */
 		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
 	),
-	TP_printk("memdev=%s: status: '%s' first_error: '%s'",
-		  __get_str(memdev),
+	TP_printk("memdev=%s host=%s: status: '%s' first_error: '%s'",
+		  __get_str(memdev), __get_str(host),
 		  show_uc_errs(__entry->status),
 		  show_uc_errs(__entry->first_error)
 	)
@@ -95,14 +97,17 @@ TRACE_EVENT(cxl_aer_correctable_error,
 	TP_ARGS(cxlmd, status),
 	TP_STRUCT__entry(
 		__string(memdev, dev_name(&cxlmd->dev))
+		__string(host, dev_name(cxlmd->dev.parent))
 		__field(u32, status)
 	),
 	TP_fast_assign(
 		__assign_str(memdev, dev_name(&cxlmd->dev));
+		__assign_str(host, dev_name(cxlmd->dev.parent));
 		__entry->status = status;
 	),
-	TP_printk("memdev=%s: status: '%s'",
-		  __get_str(memdev), show_ce_errs(__entry->status)
+	TP_printk("memdev=%s host=%s: status: '%s'",
+		  __get_str(memdev), __get_str(host),
+		  show_ce_errs(__entry->status)
 	)
 );
 
@@ -122,6 +127,7 @@ TRACE_EVENT(cxl_overflow,
 
 	TP_STRUCT__entry(
 		__string(memdev, dev_name(&cxlmd->dev))
+		__string(host, dev_name(cxlmd->dev.parent))
 		__field(int, log)
 		__field(u64, first_ts)
 		__field(u64, last_ts)
@@ -130,15 +136,17 @@ TRACE_EVENT(cxl_overflow,
 
 	TP_fast_assign(
 		__assign_str(memdev, dev_name(&cxlmd->dev));
+		__assign_str(host, dev_name(cxlmd->dev.parent));
 		__entry->log = log;
 		__entry->count = le16_to_cpu(payload->overflow_err_count);
 		__entry->first_ts = le64_to_cpu(payload->first_overflow_timestamp);
 		__entry->last_ts = le64_to_cpu(payload->last_overflow_timestamp);
 	),
 
-	TP_printk("memdev=%s: log=%s : %u records from %llu to %llu",
-		__get_str(memdev), cxl_event_log_type_str(__entry->log),
-		__entry->count, __entry->first_ts, __entry->last_ts)
+	TP_printk("memdev=%s host=%s: log=%s : %u records from %llu to %llu",
+		__get_str(memdev), __get_str(host),
+		cxl_event_log_type_str(__entry->log), __entry->count,
+		__entry->first_ts, __entry->last_ts)
 
 );
 
@@ -171,6 +179,7 @@ TRACE_EVENT(cxl_overflow,
  */
 #define CXL_EVT_TP_entry					\
 	__string(memdev, dev_name(&cxlmd->dev))			\
+	__string(host, dev_name(cxlmd->dev.parent))		\
 	__field(int, log)					\
 	__field_struct(uuid_t, hdr_uuid)			\
 	__field(u32, hdr_flags)					\
@@ -182,6 +191,7 @@ TRACE_EVENT(cxl_overflow,
 
 #define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
 	__assign_str(memdev, dev_name(&(cxlmd)->dev));				\
+	__assign_str(host, dev_name((cxlmd)->dev.parent));			\
 	__entry->log = (l);							\
 	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
 	__entry->hdr_length = (hdr).length;					\
@@ -192,10 +202,11 @@ TRACE_EVENT(cxl_overflow,
 	__entry->hdr_maint_op_class = (hdr).maint_op_class
 
 #define CXL_EVT_TP_printk(fmt, ...) \
-	TP_printk("memdev=%s log=%s : time=%llu uuid=%pUb len=%d flags='%s' "	\
-		"handle=%x related_handle=%x maint_op_class=%u"			\
+	TP_printk("memdev=%s host=%s log=%s : time=%llu uuid=%pUb len=%d "	\
+		"flags='%s' handle=%x related_handle=%x maint_op_class=%u"	\
 		" : " fmt,							\
-		__get_str(memdev), cxl_event_log_type_str(__entry->log),	\
+		__get_str(memdev), __get_str(host),				\
+		cxl_event_log_type_str(__entry->log),				\
 		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
 		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
 		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\

-- 
2.39.1

