Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5108E65F776
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 00:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbjAEXEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 18:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjAEXEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 18:04:46 -0500
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [IPv6:2a01:e0c:1:1599::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42A0676CB
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 15:04:44 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e35:39f2:1220:c70:c024:95ee:ebbb])
        by smtp3-g21.free.fr (Postfix) with ESMTPS id 17FD613F838;
        Fri,  6 Jan 2023 00:04:37 +0100 (CET)
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCH] shmem: optimize shmem_huge_enabled() and shmem_is_huge() when !CONFIG_TRANSPARENT_HUGEPAGE
Date:   Fri,  6 Jan 2023 00:04:17 +0100
Message-Id: <20230105230417.966438-1-ydroneaud@opteya.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_TRANSPARENT_HUGEPAGE is not set, shmem_is_huge() is not needed
outside of shmem.c.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 include/linux/shmem_fs.h | 9 +++++++++
 mm/shmem.c               | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index d500ea967dc7..18a4968ded73 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -92,6 +92,7 @@ extern struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
 int shmem_unuse(unsigned int type);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
 			  pgoff_t index, bool shmem_huge_force);
 static inline bool shmem_huge_enabled(struct vm_area_struct *vma,
@@ -100,6 +101,14 @@ static inline bool shmem_huge_enabled(struct vm_area_struct *vma,
 	return shmem_is_huge(vma, file_inode(vma->vm_file), vma->vm_pgoff,
 			     shmem_huge_force);
 }
+#else /* !CONFIG_TRANSPARENT_HUGEPAGE */
+static inline bool shmem_huge_enabled(struct vm_area_struct *vma,
+				      bool shmem_huge_force)
+{
+	return false;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 extern unsigned long shmem_swap_usage(struct vm_area_struct *vma);
 extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 						pgoff_t start, pgoff_t end);
diff --git a/mm/shmem.c b/mm/shmem.c
index c301487be5fb..9437c200a311 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -678,8 +678,8 @@ static long shmem_unused_huge_count(struct super_block *sb,
 
 #define shmem_huge SHMEM_HUGE_DENY
 
-bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
-		   pgoff_t index, bool shmem_huge_force)
+static inline bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
+				 pgoff_t index, bool shmem_huge_force)
 {
 	return false;
 }
-- 
2.37.2

