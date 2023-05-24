Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0902A70ED7A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbjEXF7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239521AbjEXF7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:59:07 -0400
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DEF18B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 22:58:54 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id CE8E2E1EEA; Wed, 24 May 2023 13:58:52 +0800 (CST)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     yang.yang29@zte.com.cn, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, shr@devkernel.io
Subject: [PATCH v9 4/5] ksm: consider KSM-placed zeropages when calculating KSM profit
Date:   Wed, 24 May 2023 13:58:51 +0800
Message-Id: <20230524055851.20565-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202305241351365661923@zte.com.cn>
References: <202305241351365661923@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_NON_FQDN_1,
        HEADER_FROM_DIFFERENT_DOMAINS,HELO_NO_DOMAIN,NO_DNS_FOR_FROM,
        RCVD_IN_PBL,RDNS_NONE,SPF_SOFTFAIL,SPOOFED_FREEMAIL_NO_RDNS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

When use_zero_pages is enabled, the calculation of ksm profit is not
correct because ksm zero pages is not counted in. So update the
calculation of KSM profit including the documentation.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Jiang Xuexin <jiang.xuexin@zte.com.cn>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/ksm.rst | 18 +++++++++++-------
 mm/ksm.c                             |  4 ++--
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index 6cc919dbfd55..5c5be7bd84b8 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -203,21 +203,25 @@ several times, which are unprofitable memory consumed.
 1) How to determine whether KSM save memory or consume memory in system-wide
    range? Here is a simple approximate calculation for reference::
 
-	general_profit =~ pages_sharing * sizeof(page) - (all_rmap_items) *
+	general_profit =~ ksm_saved_pages * sizeof(page) - (all_rmap_items) *
 			  sizeof(rmap_item);
 
-   where all_rmap_items can be easily obtained by summing ``pages_sharing``,
-   ``pages_shared``, ``pages_unshared`` and ``pages_volatile``.
+   where ksm_saved_pages equals to the sum of ``pages_sharing`` +
+   ``ksm_zero_pages`` of the system, and all_rmap_items can be easily
+   obtained by summing ``pages_sharing``, ``pages_shared``, ``pages_unshared``
+   and ``pages_volatile``.
 
 2) The KSM profit inner a single process can be similarly obtained by the
    following approximate calculation::
 
-	process_profit =~ ksm_merging_pages * sizeof(page) -
+	process_profit =~ ksm_saved_pages * sizeof(page) -
 			  ksm_rmap_items * sizeof(rmap_item).
 
-   where ksm_merging_pages is shown under the directory ``/proc/<pid>/``,
-   and ksm_rmap_items is shown in ``/proc/<pid>/ksm_stat``. The process profit
-   is also shown in ``/proc/<pid>/ksm_stat`` as ksm_process_profit.
+   where ksm_saved_pages equals to the sum of ``ksm_merging_pages`` and
+   ``ksm_zero_pages``, both of which are shown under the directory
+   ``/proc/<pid>/ksm_stat``, and ksm_rmap_items is also shown in
+   ``/proc/<pid>/ksm_stat``. The process profit is also shown in
+   ``/proc/<pid>/ksm_stat`` as ksm_process_profit.
 
 From the perspective of application, a high ratio of ``ksm_rmap_items`` to
 ``ksm_merging_pages`` means a bad madvise-applied policy, so developers or
diff --git a/mm/ksm.c b/mm/ksm.c
index 07a6fe7d7c99..1c7d0e215c47 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3090,7 +3090,7 @@ static void wait_while_offlining(void)
 #ifdef CONFIG_PROC_FS
 long ksm_process_profit(struct mm_struct *mm)
 {
-	return mm->ksm_merging_pages * PAGE_SIZE -
+	return (long)(mm->ksm_merging_pages + mm->ksm_zero_pages) * PAGE_SIZE -
 		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
 }
 #endif /* CONFIG_PROC_FS */
@@ -3371,7 +3371,7 @@ static ssize_t general_profit_show(struct kobject *kobj,
 {
 	long general_profit;
 
-	general_profit = ksm_pages_sharing * PAGE_SIZE -
+	general_profit = (ksm_pages_sharing + ksm_zero_pages) * PAGE_SIZE -
 				ksm_rmap_items * sizeof(struct ksm_rmap_item);
 
 	return sysfs_emit(buf, "%ld\n", general_profit);
-- 
2.15.2
