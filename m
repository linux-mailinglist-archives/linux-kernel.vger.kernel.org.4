Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E66691624
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 02:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjBJBUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 20:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBJBUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 20:20:06 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314CC643F9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 17:20:05 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PCbWR6Qvjz8R042;
        Fri, 10 Feb 2023 09:20:03 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
        by mse-fl2.zte.com.cn with SMTP id 31A1JmBv024052;
        Fri, 10 Feb 2023 09:19:48 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 10 Feb 2023 09:19:49 +0800 (CST)
Date:   Fri, 10 Feb 2023 09:19:49 +0800 (CST)
X-Zmail-TransId: 2b0363e59bb508349ce2
X-Mailer: Zmail v1.0
Message-ID: <202302100919492571517@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>
Cc:     <david@redhat.com>, <imbrenda@linux.ibm.com>,
        <jiang.xuexin@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY2IDQvNl0ga3NtOiBjb3VudCB6ZXJvIHBhZ2VzIGZvciBlYWNoIHByb2Nlc3M=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 31A1JmBv024052
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63E59BC3.000 by FangMail milter!
X-FangMail-Envelope: 1675992003/4PCbWR6Qvjz8R042/63E59BC3.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E59BC3.000/4PCbWR6Qvjz8R042
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

As the number of ksm zero pages is not included in ksm_merging_pages per
process when enabling use_zero_pages, it's unclear of how many actual
pages are merged by KSM. To let users accurately estimate their memory
demands when unsharing KSM zero-pages, it's necessary to show KSM zero-
pages per process.

since unsharing zero pages placed by KSM accurately is achieved, then
tracking empty pages merging and unmerging is not a difficult thing any
longer.

Since we already have /proc/<pid>/ksm_stat, just add the information of
zero_pages_sharing in it.

Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 fs/proc/base.c           | 1 +
 include/linux/mm_types.h | 7 ++++++-
 mm/ksm.c                 | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9e479d7d202b..ac9ebe972be0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3207,6 +3207,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
 	mm = get_task_mm(task);
 	if (mm) {
 		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
+		seq_printf(m, "zero_pages_sharing %lu\n", mm->ksm_zero_pages_sharing);
 		mmput(mm);
 	}

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4e1031626403..5c734ebc1890 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -776,7 +776,7 @@ struct mm_struct {
 #ifdef CONFIG_KSM
 		/*
 		 * Represent how many pages of this process are involved in KSM
-		 * merging.
+		 * merging (not including ksm_zero_pages_sharing).
 		 */
 		unsigned long ksm_merging_pages;
 		/*
@@ -784,6 +784,11 @@ struct mm_struct {
 		 * including merged and not merged.
 		 */
 		unsigned long ksm_rmap_items;
+		/*
+		 * Represent how many empty pages are merged with kernel zero
+		 * pages when enabling KSM use_zero_pages.
+		 */
+		unsigned long ksm_zero_pages_sharing;
 #endif
 #ifdef CONFIG_LRU_GEN
 		struct {
diff --git a/mm/ksm.c b/mm/ksm.c
index 1fa668e1fe82..42dbcc3ec90d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -794,6 +794,7 @@ static inline void clean_rmap_item_zero_flag(struct ksm_rmap_item *rmap_item)
 {
 	if (rmap_item->address & ZERO_PAGE_FLAG) {
 		ksm_zero_pages_sharing--;
+		rmap_item->mm->ksm_zero_pages_sharing--;
 		rmap_item->address &= PAGE_MASK;
 	}
 }
@@ -2117,6 +2118,7 @@ static int try_to_merge_with_kernel_zero_page(struct ksm_rmap_item *rmap_item,
 			if (!err) {
 				rmap_item->address |= ZERO_PAGE_FLAG;
 				ksm_zero_pages_sharing++;
+				rmap_item->mm->ksm_zero_pages_sharing++;
 			}
 		} else {
 			/* If the vma is out of date, we do not need to continue. */
-- 
2.15.2
