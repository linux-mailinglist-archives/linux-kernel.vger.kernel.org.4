Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05406E1E12
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjDNIYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjDNIXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:23:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBEA83F6;
        Fri, 14 Apr 2023 01:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681460618; x=1712996618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KlLl00c1BkbXcaNS+veMVCoA8VHv6YdBHnPGvXsCuZw=;
  b=GCDCeErIVi60cfi8c5dY0oJLqOLNo1xxN5TNGX0GdZQWxZZNnbR2F/eq
   JTrJ0P7HUaEQtt+FfZ/VTDCRLMMxs53/YJL6WN4/3/M66gDo9E/ldDQC8
   sOTeWzBPONk5TsUWGgSPQLMnbMXpsgo+A9l8W7Z0g8U1Aeh2mOYKvg8YV
   baSO2n0LknY1XLaMmPgMqMeAmDTh0sCjE27RFlMof/fMYxVdlDYutZYln
   O3TfRSE97yak4jwRFPy48pO1q0GN/cCSFtDNJFOUSfr3WaJSfZC0BLLyi
   BzTsKpwwt4+1LCxmktTqqDQvahaQ8uA4URbjLelJES0i6FV++gkaNWoaG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="430708155"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="430708155"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 01:23:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="683267565"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="683267565"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.34.252])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 01:23:34 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 5/5] perf: Add mmap to the sideband ioctl
Date:   Fri, 14 Apr 2023 11:23:00 +0300
Message-Id: <20230414082300.34798-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414082300.34798-1-adrian.hunter@intel.com>
References: <20230414082300.34798-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the case of output to an active event, and return an error if
output is not possible in that case. Set PERF_RECORD_MISC_STATUS_ONLY to
differentiate the ioctl status-only sideband event from a "real" sideband
event.

Set the mmap pid/tid from the appropriate task.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/events/core.c | 91 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 73 insertions(+), 18 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cddc02c2e411..317bdf5f919a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8584,6 +8584,7 @@ static void perf_event_cgroup(struct cgroup *cgrp)
 
 struct perf_mmap_event {
 	struct vm_area_struct	*vma;
+	struct task_struct	*task;
 
 	const char		*file_name;
 	int			file_size;
@@ -8605,19 +8606,25 @@ struct perf_mmap_event {
 	} event_id;
 };
 
+static int perf_event_mmap_match_vma(struct perf_event *event,
+				     struct vm_area_struct *vma)
+{
+	int executable = vma->vm_flags & VM_EXEC;
+
+	return (!executable && event->attr.mmap_data) ||
+	       (executable && (event->attr.mmap || event->attr.mmap2));
+}
+
 static int perf_event_mmap_match(struct perf_event *event,
 				 void *data)
 {
 	struct perf_mmap_event *mmap_event = data;
 	struct vm_area_struct *vma = mmap_event->vma;
-	int executable = vma->vm_flags & VM_EXEC;
 
-	return (!executable && event->attr.mmap_data) ||
-	       (executable && (event->attr.mmap || event->attr.mmap2));
+	return perf_event_mmap_match_vma(event, vma);
 }
 
-static void perf_event_mmap_output(struct perf_event *event,
-				   void *data)
+static int perf_event_mmap_output(struct perf_event *event, void *data)
 {
 	struct perf_mmap_event *mmap_event = data;
 	struct perf_output_handle handle;
@@ -8628,7 +8635,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	int ret;
 
 	if (!perf_event_mmap_match(event, data))
-		return;
+		return -ENOENT;
 
 	if (event->attr.mmap2) {
 		mmap_event->event_id.header.type = PERF_RECORD_MMAP2;
@@ -8646,8 +8653,8 @@ static void perf_event_mmap_output(struct perf_event *event,
 	if (ret)
 		goto out;
 
-	mmap_event->event_id.pid = perf_event_pid(event, current);
-	mmap_event->event_id.tid = perf_event_tid(event, current);
+	mmap_event->event_id.pid = perf_event_pid(event, mmap_event->task);
+	mmap_event->event_id.tid = perf_event_tid(event, mmap_event->task);
 
 	use_build_id = event->attr.build_id && mmap_event->build_id_size;
 
@@ -8681,9 +8688,10 @@ static void perf_event_mmap_output(struct perf_event *event,
 out:
 	mmap_event->event_id.header.size = size;
 	mmap_event->event_id.header.type = type;
+	return ret;
 }
 
-static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
+static int perf_event_mmap_event(struct perf_mmap_event *mmap_event, struct perf_event *event)
 {
 	struct vm_area_struct *vma = mmap_event->vma;
 	struct file *file = vma->vm_file;
@@ -8694,6 +8702,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	char tmp[16];
 	char *buf = NULL;
 	char *name;
+	int ret;
 
 	if (vma->vm_flags & VM_READ)
 		prot |= PROT_READ;
@@ -8795,11 +8804,10 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 	if (atomic_read(&nr_build_id_events))
 		build_id_parse(vma, mmap_event->build_id, &mmap_event->build_id_size);
 
-	perf_iterate_sb(perf_event_mmap_output,
-		       mmap_event,
-		       NULL);
+	ret = perf_output_sb(perf_event_mmap_output, mmap_event, NULL, event);
 
 	kfree(buf);
+	return ret;
 }
 
 /*
@@ -8899,21 +8907,25 @@ static void perf_addr_filters_adjust(struct vm_area_struct *vma)
 	rcu_read_unlock();
 }
 
-void perf_event_mmap(struct vm_area_struct *vma)
+static int __perf_event_mmap(struct vm_area_struct *vma,
+			     struct perf_event *event,
+			     struct task_struct *task)
 {
 	struct perf_mmap_event mmap_event;
 
 	if (!atomic_read(&nr_mmap_events))
-		return;
+		return -ENOENT;
 
 	mmap_event = (struct perf_mmap_event){
 		.vma	= vma,
+		.task	= task ?: current,
 		/* .file_name */
 		/* .file_size */
 		.event_id  = {
 			.header = {
 				.type = PERF_RECORD_MMAP,
-				.misc = PERF_RECORD_MISC_USER,
+				.misc = PERF_RECORD_MISC_USER |
+					(event ? PERF_RECORD_MISC_STATUS_ONLY : 0),
 				/* .size */
 			},
 			/* .pid */
@@ -8930,8 +8942,14 @@ void perf_event_mmap(struct vm_area_struct *vma)
 		/* .flags (attr_mmap2 only) */
 	};
 
-	perf_addr_filters_adjust(vma);
-	perf_event_mmap_event(&mmap_event);
+	if (!event)
+		perf_addr_filters_adjust(vma);
+	return perf_event_mmap_event(&mmap_event, event);
+}
+
+void perf_event_mmap(struct vm_area_struct *vma)
+{
+	__perf_event_mmap(vma, NULL, NULL);
 }
 
 void perf_event_aux_event(struct perf_event *event, unsigned long head,
@@ -12901,9 +12919,46 @@ static int perf_event_emit_comm(struct perf_event *event, struct task_struct *ta
 	return __perf_event_comm(task, false, event);
 }
 
+static int perf_event_mm_emit_mmap(struct perf_event *event,
+				   struct task_struct *task,
+				   struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
+	int err;
+
+	for_each_vma(vmi, vma) {
+		if (!perf_event_mmap_match_vma(event, vma))
+			continue;
+		err = __perf_event_mmap(vma, event, task);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int perf_event_emit_mmap(struct perf_event *event, struct task_struct *task)
 {
-	return -EINVAL;
+	struct mm_struct *mm;
+	int err;
+
+	if (!event->attr.mmap_data && !event->attr.mmap && !event->attr.mmap2)
+		return -EINVAL;
+
+	mm = get_task_mm(task);
+	if (!mm)
+		return 0;
+
+	mmap_read_lock(mm);
+
+	err = perf_event_mm_emit_mmap(event, task, mm);
+
+	mmap_read_unlock(mm);
+
+	mmput(mm);
+
+	return err;
 }
 
 static int perf_event_emit_sideband(struct perf_event *event, void __user *arg)
-- 
2.34.1

