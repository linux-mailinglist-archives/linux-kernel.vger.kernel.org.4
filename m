Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04562624A45
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiKJTGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiKJTFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:05:44 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4696A53EC6;
        Thu, 10 Nov 2022 11:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668107128; x=1699643128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rXCfHgqEwojyPNUhIvBOVf4I3jSPcxkWsQv6Y0z9kg4=;
  b=RBLf0vx+dv5EZmRWyQX5FaJJQWLautpHz9WFNg4HixrVB2ZaHnT5SatK
   B65FXyvdzmLrGV15SxxjTCciPxpPFaRWo7vvpa10zeMD3UsuLl7ayXORZ
   t67JrqjlumzmYq6Bnhmpmn6+7bDt3NXxM0tZSy2txv493oI3fPLdIMK+F
   QtlOykKzbg+8sFU/cf55dH7mamk46xS3iW6JKm0kOZMHv8kgfqJ3zb6Cy
   VIRFg2h555zX6av8ARqXSid3LDPl9V5UcpIJ8XaqQJeQKw/LK6Pa/dAoF
   4WWNJCtu1KfC4c3p/Li+ZDoXgyn8o+rtKEYqoN7JvgmRN/TRYzSJyVhXA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="375662151"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="375662151"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 10:58:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="882473459"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="882473459"
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
Subject: [PATCH 10/11] cxl/test: Add specific events
Date:   Thu, 10 Nov 2022 10:57:57 -0800
Message-Id: <20221110185758.879472-11-ira.weiny@intel.com>
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

Each type of event has different trace point outputs.

Add mock General Media Event, DRAM event, and Memory Module Event
records to the mock list of events returned.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC:
	Adjust for struct changes
	adjust for unaligned fields
---
 tools/testing/cxl/test/events.c | 70 +++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/cxl/test/events.c b/tools/testing/cxl/test/events.c
index a4816f230bb5..8693f3fb9cbb 100644
--- a/tools/testing/cxl/test/events.c
+++ b/tools/testing/cxl/test/events.c
@@ -186,6 +186,70 @@ struct cxl_event_record_raw hardware_replace = {
 	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
 };
 
+struct cxl_event_gen_media gen_media = {
+	.hdr = {
+		.id = UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
+				0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
+		.length = sizeof(struct cxl_event_gen_media),
+		.flags[0] = CXL_EVENT_RECORD_FLAG_PERMANENT,
+		/* .handle = Set dynamically */
+		.related_handle = cpu_to_le16(0),
+	},
+	.phys_addr = cpu_to_le64(0x2000),
+	.descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
+	.type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
+	.transaction_type = CXL_GMER_TRANS_HOST_WRITE,
+	.validity_flags = { CXL_GMER_VALID_CHANNEL |
+			    CXL_GMER_VALID_RANK, 0 },
+	.channel = 1,
+	.rank = 30
+};
+
+struct cxl_event_dram dram = {
+	.hdr = {
+		.id = UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
+				0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
+		.length = sizeof(struct cxl_event_dram),
+		.flags[0] = CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,
+		/* .handle = Set dynamically */
+		.related_handle = cpu_to_le16(0),
+	},
+	.phys_addr = cpu_to_le64(0x8000),
+	.descriptor = CXL_GMER_EVT_DESC_THRESHOLD_EVENT,
+	.type = CXL_GMER_MEM_EVT_TYPE_INV_ADDR,
+	.transaction_type = CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,
+	.validity_flags = { CXL_DER_VALID_CHANNEL |
+			    CXL_DER_VALID_BANK_GROUP |
+			    CXL_DER_VALID_BANK |
+			    CXL_DER_VALID_COLUMN, 0 },
+	.channel = 1,
+	.bank_group = 5,
+	.bank = 2,
+	.column = { 0xDE, 0xAD},
+};
+
+struct cxl_event_mem_module mem_module = {
+	.hdr = {
+		.id = UUID_INIT(0xfe927475, 0xdd59, 0x4339,
+				0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
+		.length = sizeof(struct cxl_event_mem_module),
+		/* .handle = Set dynamically */
+		.related_handle = cpu_to_le16(0),
+	},
+	.event_type = CXL_MMER_TEMP_CHANGE,
+	.info = {
+		.health_status = CXL_DHI_HS_PERFORMANCE_DEGRADED,
+		.media_status = CXL_DHI_MS_ALL_DATA_LOST,
+		.add_status = (CXL_DHI_AS_CRITICAL << 2) |
+			      (CXL_DHI_AS_WARNING << 4) |
+			      (CXL_DHI_AS_WARNING << 5),
+		.device_temp = { 0xDE, 0xAD},
+		.dirty_shutdown_cnt = { 0xde, 0xad, 0xbe, 0xef },
+		.cor_vol_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
+		.cor_per_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
+	}
+};
+
 u32 cxl_mock_add_event_logs(struct cxl_dev_state *cxlds)
 {
 	struct device *dev = cxlds->dev;
@@ -204,9 +268,15 @@ u32 cxl_mock_add_event_logs(struct cxl_dev_state *cxlds)
 	}
 
 	event_store_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
+	event_store_add_event(mes, CXL_EVENT_TYPE_INFO,
+			      (struct cxl_event_record_raw *)&gen_media);
+	event_store_add_event(mes, CXL_EVENT_TYPE_INFO,
+			      (struct cxl_event_record_raw *)&mem_module);
 	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
 
 	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
+	event_store_add_event(mes, CXL_EVENT_TYPE_FATAL,
+			      (struct cxl_event_record_raw *)&dram);
 	mes->ev_status |= CXLDEV_EVENT_STATUS_FATAL;
 
 	return mes->ev_status;
-- 
2.37.2

