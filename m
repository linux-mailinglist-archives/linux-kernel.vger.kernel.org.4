Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8286C5EEC41
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 05:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiI2DAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 23:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiI2DAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:00:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5549695AC6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 20:00:33 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h8-20020a17090a054800b00205ccbae31eso4636612pjf.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 20:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=M5H3e9miRP4TxLcvskK5xs1da7TP6nFSXnPh1B/uK2w=;
        b=Mk1MoSlpOIGJ4QYg52wnT9GlN8jKL7rjjAdKFbxViUNsIbhj2a2zXIXIh1VcXUDXi2
         42W5RRTWOPedqPJEbBtSK2ej+Loh6MlGoOqze0q+ITSKl0G5VDc9Djd+d5xeJ4b7AzX4
         BhsTqrgZFLjE9rwe0SS2ofinH+Q9ot3EybD7gfWyyWtqon/fC8tn7nMOYnyTOrm47Mx5
         Pgzb9z2XlsX7dBNgsbrJzilxGgQUeASGz42QwlCDjcvMkwN/wTYqlYL2zberSQp/qxwm
         UBNx6zgBJ4y1fH/bUO8vk2gHjzOCJR12D+xjModqaurZDpIGfHLDORSHUX0Pb7F5ZdyQ
         Vb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M5H3e9miRP4TxLcvskK5xs1da7TP6nFSXnPh1B/uK2w=;
        b=W24bi8hmQByKszf+GtO97WO2f3dHsB01NYZvsaT5GhLM858JNrcw30NarJsrFYQ1BS
         0PZy/8qKP/PqiiFNw0CMm517slFJ1iW0JUf3PSvlFASLFBxdfI3UnUS0uOL095V9wx3x
         xhSmTKk+Gj5QJeuTeiJ/8hp3233TS+zY5suuBywLBsjye9stQCbs8nDyTBZyvrtJfD1V
         8Z8Ngix1IAcy2Vyam273U0VK3zOclq1vzev0dl4124cXUvxZu9ja+gSmhRdrx9hie1VU
         Fr01pTzycnyvGl+b7zYQfSXGdQKRY26I5Fpv9FTjVYjJ+80dqYq0XjG4Fm/+LAOfocng
         OXZg==
X-Gm-Message-State: ACrzQf1cajcbAdepFpQfvjMyDlOJtemBCoNiW/bAF27UrEBup/iDsWPa
        BSIJR30GSoHxx76NWOV9l1o=
X-Google-Smtp-Source: AMsMyM7xpxY/1haMW08MyUdfHdX++2KCNx7LNnzmjS9WsU8ZUB1xTLtAXofMOI/gzJSnB5AGDtFljw==
X-Received: by 2002:a17:902:d548:b0:178:41dd:899 with SMTP id z8-20020a170902d54800b0017841dd0899mr1210936plf.149.1664420433430;
        Wed, 28 Sep 2022 20:00:33 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id gi9-20020a17090b110900b001fb47692333sm2309867pjb.23.2022.09.28.20.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 20:00:33 -0700 (PDT)
From:   xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org, david@redhat.com,
        imbrenda@linux.vnet.ibm.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>
Subject: [PATCH 2/3] ksm: add the accounting of zero pages merged by use_zero_pages
Date:   Thu, 29 Sep 2022 03:00:27 +0000
Message-Id: <20220929030027.281387-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929025206.280970-1-xu.xin16@zte.com.cn>
References: <20220929025206.280970-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

Before enabling use_zero_pages by setting /sys/kernel/mm/ksm/
use_zero_pages to 1, Using pages_sharing of KSM to indicate how
much pages saved by KSM is basically accurate. But when enabling
use_zero_pages, it becomes not accurate, and all empty(zeroed)
pages that are merged with kernel zero page are not counted in
pages_sharing or pages_shared. That is because the rmap_items
of these ksm zero pages are never appended to the Stable Tree
of KSM.

This leads to KSM not being fully correct and transparent with all
merged pages when enabling use_zero_pages.

There are two ways to fix it. One way is to count ksm zero pages into
pages_sharing, but it breaks the definition of pages_sharing (means
how many pages is sharing those KSM stable node). So we have to choose
Plan B, which is adding a new interface "zero_pages_sharing" under
/sys/kernel/mm/ksm/ to show it.

To implement that, we introduce a new flag SPECIAL_ZERO_FLAG to mark
those special zero pages (merged with kernel zero pages) for accounting
because these zero pages neither belongs to the existing STABLE_FLAG
nor UNSTABLE_FLAG.

Fixes: e86c59b1b12d ("mm/ksm: improve deduplication of zero pages with colouring")

Co-developed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Signed-off-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Co-developed-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Co-developed-by: Jiang Xuexin <jiang.xuexin@zte.com.cn>
Signed-off-by: Jiang Xuexin <jiang.xuexin@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/ksm.c | 98 +++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 79 insertions(+), 19 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 5b68482d2b3b..88153d2b497f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -213,6 +213,7 @@ struct ksm_rmap_item {
 #define SEQNR_MASK	0x0ff	/* low bits of unstable tree seqnr */
 #define UNSTABLE_FLAG	0x100	/* is a node of the unstable tree */
 #define STABLE_FLAG	0x200	/* is listed from the stable tree */
+#define SPECIAL_ZERO_FLAG 0x400 /* specially treated zero page */
 
 /* The stable and unstable tree heads */
 static struct rb_root one_stable_tree[1] = { RB_ROOT };
@@ -274,6 +275,9 @@ static unsigned int zero_checksum __read_mostly;
 /* Whether to merge empty (zeroed) pages with actual zero pages */
 static bool ksm_use_zero_pages __read_mostly;
 
+/* The number of empty(zeroed) pages merged but not in the stable tree */
+static unsigned long ksm_zero_pages_sharing;
+
 #ifdef CONFIG_NUMA
 /* Zeroed when merging across nodes is not allowed */
 static unsigned int ksm_merge_across_nodes = 1;
@@ -796,6 +800,10 @@ static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
 		struct ksm_rmap_item *rmap_item = *rmap_list;
 		*rmap_list = rmap_item->rmap_list;
 		remove_rmap_item_from_tree(rmap_item);
+		if (rmap_item->address & SPECIAL_ZERO_FLAG) {
+			rmap_item->address &= PAGE_MASK;
+			ksm_zero_pages_sharing--;
+		}
 		free_rmap_item(rmap_item);
 	}
 }
@@ -2017,6 +2025,39 @@ static void stable_tree_append(struct ksm_rmap_item *rmap_item,
 	rmap_item->mm->ksm_merging_pages++;
 }
 
+static int try_to_merge_with_kernel_zero_page(struct mm_struct *mm,
+				   struct ksm_rmap_item *rmap_item,
+				   struct page *page)
+{
+	int err = 0;
+
+	if (!(rmap_item->address & SPECIAL_ZERO_FLAG)) {
+		struct vm_area_struct *vma;
+
+		mmap_read_lock(mm);
+		vma = find_mergeable_vma(mm, rmap_item->address);
+		if (vma) {
+			err = try_to_merge_one_page(vma, page,
+					ZERO_PAGE(rmap_item->address));
+		} else {
+			/* If the vma is out of date, we do not need to continue. */
+			err = 0;
+		}
+		mmap_read_unlock(mm);
+		/*
+		 * In case of failure, the page was not really empty, so we
+		 * need to continue. Otherwise we're done.
+		 */
+		if (!err) {
+			rmap_item->address |= SPECIAL_ZERO_FLAG;
+			ksm_zero_pages_sharing++;
+		}
+
+	}
+
+	return err;
+}
+
 /*
  * cmp_and_merge_page - first see if page can be merged into the stable tree;
  * if not, compare checksum to previous and if it's the same, see if page can
@@ -2101,29 +2142,22 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	 * Same checksum as an empty page. We attempt to merge it with the
 	 * appropriate zero page if the user enabled this via sysfs.
 	 */
-	if (ksm_use_zero_pages && (checksum == zero_checksum)) {
-		struct vm_area_struct *vma;
-
-		mmap_read_lock(mm);
-		vma = find_mergeable_vma(mm, rmap_item->address);
-		if (vma) {
-			err = try_to_merge_one_page(vma, page,
-					ZERO_PAGE(rmap_item->address));
-		} else {
+	if (ksm_use_zero_pages) {
+		if (checksum == zero_checksum) {
+			/* If success, just return. Otherwise, continue */
+			if (!try_to_merge_with_kernel_zero_page(mm, rmap_item, page))
+				return;
+		} else if (rmap_item->address & SPECIAL_ZERO_FLAG) {
 			/*
-			 * If the vma is out of date, we do not need to
-			 * continue.
+			 * The page now is not kernel zero page(modified) but the flag
+			 * of its rmap_item is still zero-page, so need to reset the
+			 * flag and update the corresponding count.
 			 */
-			err = 0;
+			rmap_item->address &= PAGE_MASK;
+			ksm_zero_pages_sharing--;
 		}
-		mmap_read_unlock(mm);
-		/*
-		 * In case of failure, the page was not really empty, so we
-		 * need to continue. Otherwise we're done.
-		 */
-		if (!err)
-			return;
 	}
+
 	tree_rmap_item =
 		unstable_tree_search_insert(rmap_item, page, &tree_page);
 	if (tree_rmap_item) {
@@ -2336,6 +2370,24 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 				mmap_read_unlock(mm);
 				return rmap_item;
 			}
+			/*
+			 * Because we want to count ksm zero pages which is
+			 * non-anonymous, we must try to return the rmap_items
+			 * of those kernel zero pages which replaces its
+			 * original anonymous empty page due to use_zero_pages's
+			 * feature.
+			 */
+			if (is_zero_pfn(page_to_pfn(*page))) {
+				rmap_item = try_to_get_old_rmap_item(
+									ksm_scan.address,
+									ksm_scan.rmap_list);
+				if (rmap_item->address & SPECIAL_ZERO_FLAG) {
+					ksm_scan.rmap_list = &rmap_item->rmap_list;
+					ksm_scan.address += PAGE_SIZE;
+					mmap_read_unlock(mm);
+					return rmap_item;
+				}
+			}
 next_page:
 			put_page(*page);
 			ksm_scan.address += PAGE_SIZE;
@@ -3115,6 +3167,13 @@ static ssize_t pages_volatile_show(struct kobject *kobj,
 }
 KSM_ATTR_RO(pages_volatile);
 
+static ssize_t zero_pages_sharing_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%ld\n", ksm_zero_pages_sharing);
+}
+KSM_ATTR_RO(zero_pages_sharing);
+
 static ssize_t stable_node_dups_show(struct kobject *kobj,
 				     struct kobj_attribute *attr, char *buf)
 {
@@ -3175,6 +3234,7 @@ static struct attribute *ksm_attrs[] = {
 	&merge_across_nodes_attr.attr,
 #endif
 	&max_page_sharing_attr.attr,
+	&zero_pages_sharing_attr.attr,
 	&stable_node_chains_attr.attr,
 	&stable_node_dups_attr.attr,
 	&stable_node_chains_prune_millisecs_attr.attr,
-- 
2.25.1

