Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA40624A49
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiKJTGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiKJTFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:05:45 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200E754B18;
        Thu, 10 Nov 2022 11:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668107129; x=1699643129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tGLSIWnfH0DX3OQVfNiE0JPNGcqNJkXbIRqhBGzlC2A=;
  b=H1fb9gCwAejUnLOr8+PLS7V92QZNyCF0aQ0mAlEahoEs+5eLNXrRDEZ0
   oGptIDEsLe3MgMfB1WVg/pM0syS5LpTO9lxaBytPJIJyBryf4sne5O3RN
   mn2CbK2aKpewDG0EbPgzLCV4XZ0Z4+Z7k7h9Jjf0AB0DNWLFlgptPDkJz
   WsvrUqblwonVZD8J3kGC6SgwzQcvMeGO7LzRVRVMMmJ19l3b3EnZJRt3G
   QVTixePUvNHkiLDzzIXIjmvK8WOdLOoKbq3b6GGBQYL+PdFuJEQLNnQ9z
   +8gdGC8F1puYM8tirQKvjmXrGDIcGiuQ+yWleYz5TxppoQMFHOkV3bbg6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="375662165"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="375662165"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 10:58:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="882473467"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="882473467"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.6.223])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 10:58:11 -0800
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
Subject: [PATCH 11/11] cxl/test: Simulate event log overflow
Date:   Thu, 10 Nov 2022 10:57:58 -0800
Message-Id: <20221110185758.879472-12-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221110185758.879472-1-ira.weiny@intel.com>
References: <20221110185758.879472-1-ira.weiny@intel.com>
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

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC
	Adjust for new struct changes
---
 tools/testing/cxl/test/events.c | 37 +++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/cxl/test/events.c b/tools/testing/cxl/test/events.c
index 8693f3fb9cbb..5ce257114f4e 100644
--- a/tools/testing/cxl/test/events.c
+++ b/tools/testing/cxl/test/events.c
@@ -69,11 +69,21 @@ static void event_store_add_event(struct mock_event_store *mes,
 	log->nr_events++;
 }
 
+static u16 log_overflow(struct mock_event_log *log)
+{
+	int cnt = log_rec_left(log) - 5;
+
+	if (cnt < 0)
+		return 0;
+	return cnt;
+}
+
 int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_get_event_payload *pl;
 	struct mock_event_log *log;
 	u8 log_type;
+	u16 nr_overflow;
 
 	/* Valid request? */
 	if (cmd->size_in != sizeof(log_type))
@@ -95,6 +105,20 @@ int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 	if (log_rec_left(log) > 1)
 		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
 
+	nr_overflow = log_overflow(log);
+	if (nr_overflow) {
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
+	}
+
 	memcpy(&pl->record[0], get_cur_event(log), sizeof(pl->record[0]));
 	pl->record[0].hdr.handle = get_cur_event_handle(log);
 	return 0;
@@ -274,6 +298,19 @@ u32 cxl_mock_add_event_logs(struct cxl_dev_state *cxlds)
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
+	mes->ev_status |= CXLDEV_EVENT_STATUS_FAIL;
+
 	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
 	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL,
 			      (struct cxl_event_record_raw *)&dram);
-- 
2.37.2

