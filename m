Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C326DCC3D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjDJUoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDJUoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:44:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5791BC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681159448; x=1712695448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3yZhgwnPsync3tBJ/DDYSKMmfcMk16C74zq7dCxuWvo=;
  b=M/CCSL5olFluRLDk/WdvxT2DtL1rFIqkFjZ092q2kDC3gbtUPOrZps79
   1mXEx+ylPiR+Zj7z1VLfvzPPC8A74ChLjydlVfQ7Ku1j6/3Hd/aW9GYko
   xIFQmEEOJZxpeUXB98Rx8G9di2XaEv194rXkfeb7zmlgGfyjTkQVUXv/6
   BuUZ2mav75XWkNG4Gh+zJn5ohlJo2htlkkyKwazYuwRlkFY4BNTZ5PBZo
   uLv9JeVhkblkmp1ZSoJq5jGOEw99hvoXiRlnC7Ig24kWfXOBxZtG2EVFS
   fwTTwhhW8r2aIsbIZxN5rWl1XW1BJcmg1AC38KGm0vz4T8kNb+oWRiG2T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="408588928"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="408588928"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 13:44:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="638569717"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="638569717"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga003.jf.intel.com with ESMTP; 10 Apr 2023 13:44:05 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/6] perf: Support branch events logging
Date:   Mon, 10 Apr 2023 13:43:48 -0700
Message-Id: <20230410204352.1098067-2-kan.liang@linux.intel.com>
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

With the cycle time information between branches, stalls can be easily
observed. But it's difficult to explain what causes the long delay.

Add a new field to collect the occurrences of events since the last
branch entry, which can be used to provide some causality information
for the cycle time values currently recorded in branches.

Add a new branch sample type to indicate whether include occurrences of
events in branch info.

Only support up to 4 events with saturating at value 3.
In the current kernel, the events are ordered by either the counter
index or the enabling sequence. But none of the order information is
available to the user space tool.
Add a new PERF_SAMPLE format, PERF_SAMPLE_BRANCH_EVENT_IDS, and generic
support to dump the event IDs of the branch events.
Add a helper function to detect the branch event flag.
These will be used in the following patch.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h      | 26 ++++++++++++++++++++++++++
 include/uapi/linux/perf_event.h | 22 ++++++++++++++++++++--
 kernel/events/core.c            | 23 +++++++++++++++++++++++
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5628a7b5eaa..3b659a57129a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -126,6 +126,11 @@ struct perf_branch_stack {
 	struct perf_branch_entry	entries[];
 };
 
+struct perf_branch_event_ids {
+	__u64				nr;
+	__u64				ids[];
+};
+
 struct task_struct;
 
 /*
@@ -1127,6 +1132,11 @@ static inline bool branch_sample_priv(const struct perf_event *event)
 	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_PRIV_SAVE;
 }
 
+static inline bool branch_sample_event(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_EVENT;
+}
+
 
 struct perf_sample_data {
 	/*
@@ -1161,6 +1171,7 @@ struct perf_sample_data {
 	struct perf_callchain_entry	*callchain;
 	struct perf_raw_record		*raw;
 	struct perf_branch_stack	*br_stack;
+	struct perf_branch_event_ids	*br_event_ids;
 	union perf_sample_weight	weight;
 	union  perf_mem_data_src	data_src;
 	u64				txn;
@@ -1250,6 +1261,21 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 	data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
 }
 
+static inline void perf_sample_save_event_ids(struct perf_sample_data *data,
+					      struct perf_branch_event_ids *ids)
+{
+	int size = sizeof(u64); /* nr */
+
+	if (WARN_ON_ONCE(ids->nr > PERF_MAX_BRANCH_EVENTS))
+		ids->nr = PERF_MAX_BRANCH_EVENTS;
+
+	size += ids->nr * sizeof(u64);
+
+	data->br_event_ids = ids;
+	data->dyn_size += size;
+	data->sample_flags |= PERF_SAMPLE_BRANCH_EVENT_IDS;
+}
+
 static inline u32 perf_sample_data_size(struct perf_sample_data *data,
 					struct perf_event *event)
 {
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 37675437b768..36d70717ecbd 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
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
 
@@ -1018,6 +1023,8 @@ enum perf_event_type {
 	 *	  char			data[size]; } && PERF_SAMPLE_AUX
 	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
 	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
+	 *	{ u64			nr;
+	 *	  u64			ids[nr];} && PERF_SAMPLE_BRANCH_EVENT_IDS
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
@@ -1394,6 +1401,12 @@ union perf_mem_data_src {
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
@@ -1410,6 +1423,10 @@ union perf_mem_data_src {
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
@@ -1423,7 +1440,8 @@ struct perf_branch_entry {
 		spec:2,     /* branch speculation info */
 		new_type:4, /* additional branch type */
 		priv:3,     /* privilege level */
-		reserved:31;
+		events:8,   /* occurrences of events since the last branch entry */
+		reserved:23;
 };
 
 union perf_sample_weight {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f79fd8b87f75..1ec7cc8b0730 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7401,6 +7401,23 @@ void perf_output_sample(struct perf_output_handle *handle,
 			perf_aux_sample_output(event, handle, data);
 	}
 
+	if (sample_type & PERF_SAMPLE_BRANCH_EVENT_IDS) {
+		if (data->br_event_ids) {
+			size_t size;
+
+			size = data->br_event_ids->nr * sizeof(u64);
+			perf_output_put(handle, data->br_event_ids->nr);
+			perf_output_copy(handle, data->br_event_ids->ids, size);
+		} else {
+			/*
+			 * we always store at least the value of nr
+			 */
+			u64 nr = 0;
+
+			perf_output_put(handle, nr);
+		}
+	}
+
 	if (!event->attr.watermark) {
 		int wakeup_events = event->attr.wakeup_events;
 
@@ -7747,6 +7764,12 @@ void perf_prepare_sample(struct perf_sample_data *data,
 		data->dyn_size += size + sizeof(u64); /* size above */
 		data->sample_flags |= PERF_SAMPLE_AUX;
 	}
+
+	if (filtered_sample_type & PERF_SAMPLE_BRANCH_EVENT_IDS) {
+		data->br_event_ids = NULL;
+		data->dyn_size += sizeof(u64);
+		data->sample_flags |= PERF_SAMPLE_BRANCH_EVENT_IDS;
+	}
 }
 
 void perf_prepare_header(struct perf_event_header *header,
-- 
2.35.1

