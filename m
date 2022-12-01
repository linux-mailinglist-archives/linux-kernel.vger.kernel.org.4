Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2742F63E682
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiLAA2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiLAA1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:27:55 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A93A5FE6;
        Wed, 30 Nov 2022 16:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669854457; x=1701390457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MIt8u5M8Ue6CxDEWxdx1n9xx/jT7kbKrMNIRbSJ2oXA=;
  b=i8hO6rW2LYuq67wuOJasAhmlX6SDKKU9YGSwxXH10I2knZHRB4F64GEA
   MOEoLdam9N8/gj4PyFHZDP5poUhB4NeprmukDyQjQ2wqqTh+mswdMRTb2
   ps5IH0NUIfr8wN6jvrJMOTdumaBJV+Oe6sNObGF+Asai1m+fMimk1PK5k
   ugHwJgFlQGC857dfJKEp4cWoQEOoAQoXE+wu+MvJJzKOs3+h9xhuzh9eR
   rQLExTeU5tWVOcXMecP5S4MEunM1LjAI6X9tGtiTd1wtKdifM3OdTFeaW
   dJQll3mG7vaSD3QrbLSHwes5j1oAqUCxVTV/eXntG36WEGtgTupwPbawm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="317400892"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="317400892"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:27:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="622085248"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="622085248"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.251.1.240])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:27:35 -0800
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
Subject: [PATCH V2 10/11] cxl/test: Add specific events
Date:   Wed, 30 Nov 2022 16:27:18 -0800
Message-Id: <20221201002719.2596558-11-ira.weiny@intel.com>
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

Each type of event has different trace point outputs.

Add mock General Media Event, DRAM event, and Memory Module Event
records to the mock list of events returned.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1:
	Jonathan
		use put_unaligned_le16()
		fix spacing

Changes from RFC:
	Adjust for struct changes
	adjust for unaligned fields
---
 tools/testing/cxl/test/events.c | 73 +++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/cxl/test/events.c b/tools/testing/cxl/test/events.c
index a3d2ec7cc9fe..0bcc485e07da 100644
--- a/tools/testing/cxl/test/events.c
+++ b/tools/testing/cxl/test/events.c
@@ -206,6 +206,66 @@ struct cxl_event_record_raw hardware_replace = {
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
+	/* .validity_flags = <set below> */
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
+	/* .validity_flags = <set below> */
+	.channel = 1,
+	.bank_group = 5,
+	.bank = 2,
+	.column = {0xDE, 0xAD},
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
@@ -223,10 +283,23 @@ u32 cxl_mock_add_event_logs(struct cxl_dev_state *cxlds)
 		return 0;
 	}
 
+	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK,
+			   &gen_media.validity_flags);
+
+	put_unaligned_le16(CXL_DER_VALID_CHANNEL | CXL_DER_VALID_BANK_GROUP |
+			   CXL_DER_VALID_BANK | CXL_DER_VALID_COLUMN,
+			   &dram.validity_flags);
+
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

