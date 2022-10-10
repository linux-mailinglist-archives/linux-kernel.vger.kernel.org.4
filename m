Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19B15FA7CA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJJWnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiJJWn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:43:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0167B29A;
        Mon, 10 Oct 2022 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665441794; x=1696977794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oRymjZD++Hu1ER8afzkEyUfhkPVZwlpVp0FwvixLVRI=;
  b=lZNJ3oIAsxNqKcvGQqQ9jCMUsXvsRoP07F+6MkoeC2bwZt3xA76SyW04
   X5pWuBCVsUo2gHINeb/CUPq12aJFzAqim76criAymC44+3X71vtnGAuMu
   f6tWEtqE2OpKcZMNRX9+WAIign8tfYp79J/ORmJkrynTdvuBLC3UkdlqN
   ganfS9BDPWZupuLqqDHboyimfxUToelvYHcTAC4tqXocxjHqQwjI3IRtA
   pByn369GclbCmgrtKxlhTpSd8y02K5+zW7tMpb+bnJ6QnPn0bQpr1r3qt
   JHlow+0eusRxzwkfMiKZ2q0N/dpmkOC195mlSw5eRj6YA09l9Gugk1+BX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="287615393"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="287615393"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:10 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="621191392"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="621191392"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.252.141.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:43:10 -0700
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
Subject: [RFC V2 PATCH 10/11] cxl/test: Simulate event log overflow
Date:   Mon, 10 Oct 2022 15:41:30 -0700
Message-Id: <20221010224131.1866246-11-ira.weiny@intel.com>
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

Log overflow is marked by a separate trace message.

Simulate a log with lots of messages and flag overflow until it is
drained a bit.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC
	Adjust for new struct changes
---
 tools/testing/cxl/test/events.c | 36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/cxl/test/events.c b/tools/testing/cxl/test/events.c
index 1d3dbeaf7794..21cbd2990bca 100644
--- a/tools/testing/cxl/test/events.c
+++ b/tools/testing/cxl/test/events.c
@@ -68,11 +68,21 @@ static void event_store_add_event(struct mock_event_store *mes,
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
@@ -98,6 +108,20 @@ int mock_get_event(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
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
 	memcpy(&pl->record, get_cur_event(log), sizeof(pl->record));
 	pl->record.hdr.handle = get_cur_event_handle(log);
 	return 0;
@@ -276,6 +300,18 @@ void cxl_mock_add_event_logs(struct cxl_dev_state *cxlds)
 	event_store_add_event(mes, CXL_EVENT_TYPE_INFO,
 			      (struct cxl_event_record_raw *)&mem_module);
 
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
+
 	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
 	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL,
 			      (struct cxl_event_record_raw *)&dram);
-- 
2.37.2

