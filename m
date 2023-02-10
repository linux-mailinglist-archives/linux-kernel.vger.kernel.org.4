Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0365369189D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjBJGl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjBJGlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:41:53 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CDA1115B;
        Thu,  9 Feb 2023 22:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676011312; x=1707547312;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=eiNZRovgGtYMT3dCMoI5ZB50b+BK2P4JSaNAWOtAIvw=;
  b=Nml3oiCury585hBh9tGy2/OtcLLLbaWiz/LciycfRHnplhiVtkAfbbzp
   l2Inc6f3+WjFdMTRGKlfP3236/YbIodFuDQZcYlmempr5anzh/DBT9rkW
   i1iu3HMGKslfCrC5+MAhAv/3rj0gvisBw57GzRuqvfFkwbybe1ehlgKYs
   F5P/Sz0bb+K0F7v96oU13I97epHFPwyAuONEZELP5xDk7HkUmaeM0s4cz
   DGx2gDngXuIGRXBoq/xImTVnudCJn4idayDbyCC+fBV08fqy68noQxaEX
   n0Ydcr+Bh1jPjTQTcRTiSe7NXj1KCVWs0N8LrHfEykp63pdgMh9Oq/mZd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="331654760"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="331654760"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 22:41:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="661300314"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="661300314"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.43.65])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 22:41:51 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Thu, 09 Feb 2023 22:40:16 -0800
Subject: [PATCH 2/2] cxl/trace: Add host output to trace points
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230208-cxl-event-names-v1-2-73f0ff3a3870@intel.com>
References: <20230208-cxl-event-names-v1-0-73f0ff3a3870@intel.com>
In-Reply-To: <20230208-cxl-event-names-v1-0-73f0ff3a3870@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Jiang <dave.jiang@intel.com>
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676011309; l=4583;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=eiNZRovgGtYMT3dCMoI5ZB50b+BK2P4JSaNAWOtAIvw=;
 b=SzIHAJIHeQ7Hsc4oFlAT0kTPw4RfNVBuvKtGwiGbupvZfY1e797td+6EmLFwLVPbmFfADCQlyHLi
 uHbtKuZlAiMG1gkai2rrBZa9ZE4zwjBN8HttWpU7bxafwJKaWtC2
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/cxl/core/trace.h | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index b7a11e6b0e28..1d32fc5d5eba 100644
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
 	__string(memdev, dev_name(&cxlmd->dev))		\
+	__string(host, dev_name(cxlmd->dev.parent))		\
 	__field(int, log)					\
 	__field_struct(uuid_t, hdr_uuid)			\
 	__field(u32, hdr_flags)					\
@@ -182,6 +191,7 @@ TRACE_EVENT(cxl_overflow,
 
 #define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
 	__assign_str(memdev, dev_name(&cxlmd->dev));				\
+	__assign_str(host, dev_name(cxlmd->dev.parent));			\
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

