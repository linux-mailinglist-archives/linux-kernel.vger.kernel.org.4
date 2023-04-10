Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA206DCC40
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjDJUoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjDJUoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:44:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C1BE9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681159449; x=1712695449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wFzltUgS6Pzw4w0XrpzUI9z/qWOC7lvk1CiGYtqNtYc=;
  b=cZx9OQby+717X7R8kYqziTbvFAO1hhkVZrx/wg7B+haaw7ksxV5tLk4N
   GNWZnHF4IyIWV+iZuVhSVLxClwRHhknKsMveFwGA7sJisrxBESMZI0tI5
   Zny9Cub8PYjR+RzasH8vLXogMiDcl56jMd8O6arkGxRaHsnhiHG9iBdPd
   DSFGnRhR6UQatZwpnEQBNJOz/JLGD3gPLs+d0U/wqS8cUHzj89JQMbp4j
   pGVidJpofPqlBHQypYsg3UDDO3OgxjT1wvKVf4NoHzMDZIPhx4msZTYhe
   Pkc29bXjZM0hvmA8OEos3//3i18Ddf98T5+xK3+jPkjgx7FzL8eqe2Faz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="408588940"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="408588940"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 13:44:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="638569723"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="638569723"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga003.jf.intel.com with ESMTP; 10 Apr 2023 13:44:06 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/6] tools headers UAPI: Sync include/uapi/linux/perf_event.h header with the kernel
Date:   Mon, 10 Apr 2023 13:43:50 -0700
Message-Id: <20230410204352.1098067-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230410204352.1098067-1-kan.liang@linux.intel.com>
References: <20230410204352.1098067-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The branch event information and the corresponding event IDs can be
collected by kernel with the LBR event logging feature on Intel
platforms. Sync the new sample types and the new fields of
struct perf_branch_entry, so the perf tool can retrieve the occurrences
of events for each branch and the corresponding event IDs.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/include/uapi/linux/perf_event.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index ccb7f5dad59b..3c019ed7dbf6 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -162,8 +162,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
 	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
 	PERF_SAMPLE_WEIGHT_STRUCT		= 1U << 24,
+	PERF_SAMPLE_BRANCH_EVENT_IDS		= 1U << 25,
 
-	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 26,		/* non-ABI */
 };
 
 #define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
@@ -204,6 +205,8 @@ enum perf_branch_sample_type_shift {
 
 	PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT	= 18, /* save privilege mode */
 
+	PERF_SAMPLE_BRANCH_EVENT_SHIFT		= 19, /* save occurrences of events */
+
 	PERF_SAMPLE_BRANCH_MAX_SHIFT		/* non-ABI */
 };
 
@@ -235,6 +238,8 @@ enum perf_branch_sample_type {
 
 	PERF_SAMPLE_BRANCH_PRIV_SAVE	= 1U << PERF_SAMPLE_BRANCH_PRIV_SAVE_SHIFT,
 
+	PERF_SAMPLE_BRANCH_EVENT	= 1U << PERF_SAMPLE_BRANCH_EVENT_SHIFT,
+
 	PERF_SAMPLE_BRANCH_MAX		= 1U << PERF_SAMPLE_BRANCH_MAX_SHIFT,
 };
 
@@ -1015,6 +1020,8 @@ enum perf_event_type {
 	 *	  char			data[size]; } && PERF_SAMPLE_AUX
 	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
 	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
+	 *	{ u64			nr;
+	 *	  u64			ids[nr];} && PERF_SAMPLE_BRANCH_EVENT_IDS
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
@@ -1391,6 +1398,12 @@ union perf_mem_data_src {
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
 
+#define PERF_MAX_BRANCH_EVENTS		4
+#define PERF_BRANCH_EVENTS_MASK		0x3
+#define PERF_BRANCH_EVENTS_STEP		2
+
+#define perf_branch_event_by_idx(_events, _idx)		\
+	(((_events) >> ((_idx) * PERF_BRANCH_EVENTS_STEP)) & PERF_BRANCH_EVENTS_MASK)
 /*
  * single taken branch record layout:
  *
@@ -1407,6 +1420,10 @@ union perf_mem_data_src {
  *    cycles: cycles from last branch (or 0 if not supported)
  *      type: branch type
  *      spec: branch speculation info (or 0 if not supported)
+ *      events: occurrences of events since the last branch entry.
+ *              The fields can store up to 4 events with saturating
+ *              at value 3.
+ *              (or 0 if not supported)
  */
 struct perf_branch_entry {
 	__u64	from;
@@ -1420,7 +1437,8 @@ struct perf_branch_entry {
 		spec:2,     /* branch speculation info */
 		new_type:4, /* additional branch type */
 		priv:3,     /* privilege level */
-		reserved:31;
+		events:8,   /* occurrences of events since the last branch entry */
+		reserved:23;
 };
 
 union perf_sample_weight {
-- 
2.35.1

