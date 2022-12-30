Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5233F6593FF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 02:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiL3BPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 20:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbiL3BPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 20:15:20 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E1417409
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 17:15:19 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NjnPK4sdDz5PkHg;
        Fri, 30 Dec 2022 09:15:17 +0800 (CST)
Received: from szxlzmapp06.zte.com.cn ([10.5.230.252])
        by mse-fl1.zte.com.cn with SMTP id 2BU1FDjd083722;
        Fri, 30 Dec 2022 09:15:13 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 30 Dec 2022 09:15:14 +0800 (CST)
Date:   Fri, 30 Dec 2022 09:15:14 +0800 (CST)
X-Zmail-TransId: 2b0363ae3ba2067bb0e7
X-Mailer: Zmail v1.0
Message-ID: <202212300915147801864@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>
Cc:     <david@redhat.com>, <imbrenda@linux.ibm.com>,
        <jiang.xuexin@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY1IDMvNl0ga3NtOiBjb3VudCBhbGwgemVybyBwYWdlcyBwbGFjZWQgYnkgS1NN?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2BU1FDjd083722
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63AE3BA5.000 by FangMail milter!
X-FangMail-Envelope: 1672362917/4NjnPK4sdDz5PkHg/63AE3BA5.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63AE3BA5.000/4NjnPK4sdDz5PkHg
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

As pages_sharing and pages_shared don't include the number of zero pages
merged by KSM, we cannot know how many pages are zero pages placed by KSM
when enabling use_zero_pages, which leads to KSM not being transparent with
all actual merged pages by KSM. In the early days of use_zero_pages,
zero-pages was unable to get unshared by the ways like MADV_UNMERGEABLE so
it's hard to count how many times one of those zeropages was then unmerged.

But now, unsharing KSM-placed zero page accurately has been achieved, so we
can easily count both how many times a page full of zeroes was merged with
zero-page and how many times one of those pages was then unmerged. and so,
it helps to estimate memory demands when each and every shared page could
get unshared.

So we add zero_pages_sharing under /sys/kernel/mm/ksm/ to show the number
of all zero pages placed by KSM.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>

 v4->v5:
 fix warning  mm/ksm.c:3238:9: warning: no previous prototype for
 'zero_pages_sharing_show' [-Wmissing-prototypes].
---
 mm/ksm.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 652c088f9786..72c0722be280 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -276,6 +276,9 @@ static unsigned int zero_checksum __read_mostly;
 /* Whether to merge empty (zeroed) pages with actual zero pages */
 static bool ksm_use_zero_pages __read_mostly;

+/* The number of zero pages placed by KSM use_zero_pages */
+static unsigned long ksm_zero_pages_sharing;
+
 #ifdef CONFIG_NUMA
 /* Zeroed when merging across nodes is not allowed */
 static unsigned int ksm_merge_across_nodes = 1;
@@ -789,8 +792,10 @@ static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
  */
 static inline void clean_rmap_item_zero_flag(struct ksm_rmap_item *rmap_item)
 {
-	if (rmap_item->address & ZERO_PAGE_FLAG)
+	if (rmap_item->address & ZERO_PAGE_FLAG) {
+		ksm_zero_pages_sharing--;
 		rmap_item->address &= PAGE_MASK;
+	}
 }

 /* Only called when rmap_item is going to be freed */
@@ -2109,8 +2114,10 @@ static int try_to_merge_with_kernel_zero_page(struct ksm_rmap_item *rmap_item,
 		if (vma) {
 			err = try_to_merge_one_page(vma, page,
 						ZERO_PAGE(rmap_item->address));
-			if (!err)
+			if (!err) {
 				rmap_item->address |= ZERO_PAGE_FLAG;
+				ksm_zero_pages_sharing++;
+			}
 		} else {
 			/* If the vma is out of date, we do not need to continue. */
 			err = 0;
@@ -3228,6 +3235,13 @@ static ssize_t pages_volatile_show(struct kobject *kobj,
 }
 KSM_ATTR_RO(pages_volatile);

+static ssize_t zero_pages_sharing_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%ld\n", ksm_zero_pages_sharing);
+}
+KSM_ATTR_RO(zero_pages_sharing);
+
 static ssize_t stable_node_dups_show(struct kobject *kobj,
 				     struct kobj_attribute *attr, char *buf)
 {
@@ -3283,6 +3297,7 @@ static struct attribute *ksm_attrs[] = {
 	&pages_sharing_attr.attr,
 	&pages_unshared_attr.attr,
 	&pages_volatile_attr.attr,
+	&zero_pages_sharing_attr.attr,
 	&full_scans_attr.attr,
 #ifdef CONFIG_NUMA
 	&merge_across_nodes_attr.attr,
-- 
2.15.2
