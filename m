Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85B463E685
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLAA2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiLAA14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:27:56 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC5F12D28;
        Wed, 30 Nov 2022 16:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669854459; x=1701390459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nJK5EYVQsbsVhEkfDMZIpLJP3ACrgI2e3ZyBYEWndGU=;
  b=R9cYtbFtU7B3IIKkqT1zZbay+jdMrQYOeK52h8/unGlk21upSyq6Hfl3
   BkHEI090Qw9LOT7Seg7LqoLzl+1va7BXqOq0aSW2EXdqpYEiIghQ+oCmn
   m4NVnzwdWf24TIF3oUx1GTYCjLFWMTJIU2qxN46+xWQL4G5Bat7izbdqx
   5K7ss4k7usp5OqjADMRtaJxvCSyiD87tJ6WLbuNj7Ep70HaVcTXGqKCNX
   sC3BPLYSX8x17Czv1n21jfFKJ5lPJTuE4ur2X6nLn5WdUsUeOp2wOuBe4
   UgkNIotbw+pW1Gv7YKr8fh62ZVApm9pP8cAatTcRgLBCReelVv8RU+A98
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="317400898"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="317400898"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:27:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="622085255"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="622085255"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.251.1.240])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:27:36 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [PATCH V2 11/11] cxl/test: Simulate event log overflow
Date:   Wed, 30 Nov 2022 16:27:19 -0800
Message-Id: <20221201002719.2596558-12-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221201002719.2596558-1-ira.weiny@intel.com>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Log overflow is marked by a separate trace message.

Simulate a log with lots of messages and flag overflow until it is
drained a bit.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC
	Adjust for new struct changes
---
 tools/testing/cxl/test/events.c | 49 ++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/events.c b/tools/testing/cxl/test/events.c
index 0bcc485e07da..ceabefb526c2 100644
--- a/tools/testing/cxl/test/events.c
+++ b/tools/testing/cxl/test/events.c
@@ -15,6 +15,8 @@ struct mock_event_log {
 	u16 clear_idx;
 	u16 cur_idx;
 	u16 nr_events;
+	u16 nr_overflow;
+	u16 overflow_reset;
 	struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
 };
 
@@ -45,6 +47,7 @@ void reset_event_log(struct mock_event_log *log)
 {
 	log->cur_idx = 0;
 	log->clear_idx = 0;
+	log->nr_overflow = log->overflow_reset;
 }
 
 /* Handle can never be 0 use 1 based indexing for handle */
@@ -76,8 +79,12 @@ static void event_store_add_event(struct mock_event_store *mes,
 		return;
 
 	log = &mes->mock_logs[log_type];
-	if (WARN_ON(log->nr_events >= CXL_TEST_EVENT_CNT_MAX))
+
+	if ((log->nr_events + 1) > CXL_TEST_EVENT_CNT_MAX) {
+		log->nr_overflow++;
+		log->overflow_reset = log->nr_overflow;
 		return;
+	}
 
 	log->events[log->nr_events] = event;
 	log->nr_events++;
@@ -87,6 +94,7 @@ int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_get_event_payload *pl;
 	struct mock_event_log *log;
+	u16 nr_overflow;
 	u8 log_type;
 	int i;
 
@@ -118,6 +126,21 @@ int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 	if (!log_empty(log))
 		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
 
+	if (log->nr_overflow) {
+		u64 ns;
+
+		pl->flags |= CXL_GET_EVENT_FLAG_OVERFLOW;
+		pl->overflow_err_count = cpu_to_le16(nr_overflow);
+		ns = ktime_get_real_ns();
+		ns -= 5000000000; /* 5s ago */
+		pl->first_overflow_timestamp = cpu_to_le64(ns);
+		ns = ktime_get_real_ns();
+		ns -= 1000000000; /* 1s ago */
+		pl->last_overflow_timestamp = cpu_to_le64(ns);
+
+		log->nr_overflow = 0;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mock_get_event);
@@ -297,6 +320,30 @@ u32 cxl_mock_add_event_logs(struct cxl_dev_state *cxlds)
 			      (struct cxl_event_record_raw *)&mem_module);
 	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
 
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &maint_needed);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL,
+			      (struct cxl_event_record_raw *)&dram);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL,
+			      (struct cxl_event_record_raw *)&gen_media);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL,
+			      (struct cxl_event_record_raw *)&mem_module);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL,
+			      (struct cxl_event_record_raw *)&dram);
+	/* Overflow this log */
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
+	mes->ev_status |= CXLDEV_EVENT_STATUS_FAIL;
+
 	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
 	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL,
 			      (struct cxl_event_record_raw *)&dram);
-- 
2.37.2

