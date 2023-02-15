Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C7D697522
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjBOENT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBOENE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:13:04 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46C0241E7;
        Tue, 14 Feb 2023 20:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676434383; x=1707970383;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Hw1DDHRIHIwPlwNgbgIfy7AWI3+eWUYTCa7drEZt1eI=;
  b=cud5PTODHg77ga+zq8z8rUKhGo/8QRZiHAKgyG+xIZPvm4vEVr0r7TZU
   636oMRtIkEzfXfCWIggcg5qpemRvhKsyg1wzkOK8Mhel0lIKXlxi6KWW1
   R7YAIkjLoD7nW2TqzUxWfIWunQQjzdCKCqGQcfrSj2Zjpz806beZsmG32
   O0iS6PUlfxsBOAD3zPnq3h3V4PU4y+MIDweqGyxfaVF2rEykdl9af8zs0
   BPHrl+BHvjZ/V3bUakEdR1E18xSPvkGQuzh/zoLS6WQtE1egnlC9Or98B
   a/us11dKcE1gHwzCtAvovUUo4GZXCuxTv2LJZek0eHLvdq3h5GVz9Fhy+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="311706810"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="311706810"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 20:13:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="647017003"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="647017003"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.74.178])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 20:13:01 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Tue, 14 Feb 2023 20:12:45 -0800
Subject: [PATCH v2 3/3] cxl/trace: Add serial number to trace points
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230208-cxl-event-names-v2-3-fca130c2c68b@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676434378; l=5068;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=Hw1DDHRIHIwPlwNgbgIfy7AWI3+eWUYTCa7drEZt1eI=;
 b=OGsI2VdXSKeA4uMGc+TIfF1n64xZK9eC0RhbRGhesXGaL7aI28/E17lFL1gFxEfd5h0j8+8qMSER
 uKoIKjmqBsSpirWJ2xvR8IgzP7yH7c4ScYej9kNqxtiYpuLvJyTa
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

Device serial numbers are useful information for the user.

Add device serial numbers to all the trace points.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
NOTE: Device serial numbers default to 0 but can be added in QEMU with
the following syntax for testing:

	"-device cxl-type3,sn=<serial>,..."

Changes for v2
	From Dan
		New patch -- don't forget the serial number
---
 drivers/cxl/core/trace.h | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index ed69e558187b..9b8d3d997834 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -52,6 +52,7 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	TP_STRUCT__entry(
 		__string(memdev, dev_name(&cxlmd->dev))
 		__string(host, dev_name(cxlmd->dev.parent))
+		__field(u64, serial)
 		__field(u32, status)
 		__field(u32, first_error)
 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
@@ -59,6 +60,7 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	TP_fast_assign(
 		__assign_str(memdev, dev_name(&cxlmd->dev));
 		__assign_str(host, dev_name(cxlmd->dev.parent));
+		__entry->serial = cxlmd->cxlds->serial;
 		__entry->status = status;
 		__entry->first_error = fe;
 		/*
@@ -67,8 +69,8 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 		 */
 		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
 	),
-	TP_printk("memdev=%s host=%s: status: '%s' first_error: '%s'",
-		  __get_str(memdev), __get_str(host),
+	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
+		  __get_str(memdev), __get_str(host), __entry->serial,
 		  show_uc_errs(__entry->status),
 		  show_uc_errs(__entry->first_error)
 	)
@@ -98,15 +100,17 @@ TRACE_EVENT(cxl_aer_correctable_error,
 	TP_STRUCT__entry(
 		__string(memdev, dev_name(&cxlmd->dev))
 		__string(host, dev_name(cxlmd->dev.parent))
+		__field(u64, serial)
 		__field(u32, status)
 	),
 	TP_fast_assign(
 		__assign_str(memdev, dev_name(&cxlmd->dev));
 		__assign_str(host, dev_name(cxlmd->dev.parent));
+		__entry->serial = cxlmd->cxlds->serial;
 		__entry->status = status;
 	),
-	TP_printk("memdev=%s host=%s: status: '%s'",
-		  __get_str(memdev), __get_str(host),
+	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
+		  __get_str(memdev), __get_str(host), __entry->serial,
 		  show_ce_errs(__entry->status)
 	)
 );
@@ -129,6 +133,7 @@ TRACE_EVENT(cxl_overflow,
 		__string(memdev, dev_name(&cxlmd->dev))
 		__string(host, dev_name(cxlmd->dev.parent))
 		__field(int, log)
+		__field(u64, serial)
 		__field(u64, first_ts)
 		__field(u64, last_ts)
 		__field(u16, count)
@@ -137,14 +142,15 @@ TRACE_EVENT(cxl_overflow,
 	TP_fast_assign(
 		__assign_str(memdev, dev_name(&cxlmd->dev));
 		__assign_str(host, dev_name(cxlmd->dev.parent));
+		__entry->serial = cxlmd->cxlds->serial;
 		__entry->log = log;
 		__entry->count = le16_to_cpu(payload->overflow_err_count);
 		__entry->first_ts = le64_to_cpu(payload->first_overflow_timestamp);
 		__entry->last_ts = le64_to_cpu(payload->last_overflow_timestamp);
 	),
 
-	TP_printk("memdev=%s host=%s: log=%s : %u records from %llu to %llu",
-		__get_str(memdev), __get_str(host),
+	TP_printk("memdev=%s host=%s serial=%lld: log=%s : %u records from %llu to %llu",
+		__get_str(memdev), __get_str(host), __entry->serial,
 		cxl_event_log_type_str(__entry->log), __entry->count,
 		__entry->first_ts, __entry->last_ts)
 
@@ -182,6 +188,7 @@ TRACE_EVENT(cxl_overflow,
 	__string(host, dev_name(cxlmd->dev.parent))		\
 	__field(int, log)					\
 	__field_struct(uuid_t, hdr_uuid)			\
+	__field(u64, serial)					\
 	__field(u32, hdr_flags)					\
 	__field(u16, hdr_handle)				\
 	__field(u16, hdr_related_handle)			\
@@ -193,6 +200,7 @@ TRACE_EVENT(cxl_overflow,
 	__assign_str(memdev, dev_name(&(cxlmd)->dev));				\
 	__assign_str(host, dev_name((cxlmd)->dev.parent));			\
 	__entry->log = (l);							\
+	__entry->serial = (cxlmd)->cxlds->serial;				\
 	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
 	__entry->hdr_length = (hdr).length;					\
 	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
@@ -202,10 +210,10 @@ TRACE_EVENT(cxl_overflow,
 	__entry->hdr_maint_op_class = (hdr).maint_op_class
 
 #define CXL_EVT_TP_printk(fmt, ...) \
-	TP_printk("memdev=%s host=%s log=%s : time=%llu uuid=%pUb len=%d "	\
-		"flags='%s' handle=%x related_handle=%x maint_op_class=%u"	\
-		" : " fmt,							\
-		__get_str(memdev), __get_str(host),				\
+	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu uuid=%pUb "	\
+		"len=%d flags='%s' handle=%x related_handle=%x "		\
+		"maint_op_class=%u : " fmt,					\
+		__get_str(memdev), __get_str(host), __entry->serial,		\
 		cxl_event_log_type_str(__entry->log),				\
 		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
 		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\

-- 
2.39.1

