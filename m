Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65FC6E069D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDMF6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDMF6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:58:03 -0400
Received: from ubuntu20 (unknown [193.203.214.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D86212C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:58:02 -0700 (PDT)
Received: by ubuntu20 (Postfix, from userid 1003)
        id E73CFE1A31; Thu, 13 Apr 2023 05:58:00 +0000 (UTC)
From:   Yang Yang <yang.yang29@zte.com.cn>
To:     akpm@linux-foundation.org, david@redhat.com
Cc:     yang.yang29@zte.com.cn, imbrenda@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>
Subject: [PATCH v7 5/6] ksm: update the calculation of KSM profit
Date:   Thu, 13 Apr 2023 13:57:59 +0800
Message-Id: <20230413055759.181210-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202304131346489021903@zte.com.cn>
References: <202304131346489021903@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_NON_FQDN_1,
        HEADER_FROM_DIFFERENT_DOMAINS,HELO_NO_DOMAIN,NO_DNS_FOR_FROM,
        RCVD_IN_PBL,RDNS_NONE,SPF_SOFTFAIL,SPOOFED_FREEMAIL_NO_RDNS
        autolearn=no autolearn_force=no version=3.4.6
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
 mm/ksm.c                             |  5 +++++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index 64e6a13bda74..1a0f623cd570 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -243,21 +243,25 @@ several times, which are unprofitable memory consumed.
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
+   ``/proc/<pid>/``, and ksm_rmap_items is shown in ``/proc/<pid>/ksm_stat``.
+   The process profit is also shown in ``/proc/<pid>/ksm_stat`` as
+   ksm_process_profit.
 
 From the perspective of application, a high ratio of ``ksm_rmap_items`` to
 ``ksm_merging_pages`` means a bad madvise-applied policy, so developers or
diff --git a/mm/ksm.c b/mm/ksm.c
index 7867fae3c61c..10902c8c503f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2936,8 +2936,13 @@ static void wait_while_offlining(void)
 #ifdef CONFIG_PROC_FS
 long ksm_process_profit(struct mm_struct *mm)
 {
+#ifdef CONFIG_KSM_ZERO_PAGES_TRACK
+	return (long)(mm->ksm_merging_pages + mm->ksm_zero_pages) * PAGE_SIZE -
+			mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
+#else
 	return (long)mm->ksm_merging_pages * PAGE_SIZE -
 		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
+#endif
 }
 
 /* Return merge type name as string. */
-- 
2.15.2
