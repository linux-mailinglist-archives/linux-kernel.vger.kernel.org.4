Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235F2742D07
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjF2TTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjF2TS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:18:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15B23C24
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=g+NcRVz6DlwyP650U53R0sBow95cLltWneKiM8xVWy4=; b=KZMHkzW6OX3pVpvLi1BlRRDsQ9
        14tq/tMjc+Hrm6ASrjWDb8Vx66bhGDFFieE1p3YtcoHv4V0OLqwRJ/hEo0fxBLfXXQI3Wl+Ffn1sm
        HZ/JjL1mAW5NricHoqNFaS5yfx/Vff56JUhVb7FffLODFkfIe65zA+z4agN2OB8Jcj/AajTwaEYkL
        xm8he5HSR2Gd3ro4cM3DmkKmIG4bsgStIYe4/xpmb4G5bwchkoSmaOm8osKvWiLYy4Zf3QdHSiulj
        cxTnvfBFgbb1aVu8D0v0ehfNBNhlpKbDs/MEEBm9NIbcK0cdaUpBTyGD61G/372McjE2grGJfBBRs
        WBG8gd/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEx5t-0056Kz-E4; Thu, 29 Jun 2023 19:14:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] mm: Always downgrade mmap_lock if requested
Date:   Thu, 29 Jun 2023 20:14:14 +0100
Message-Id: <20230629191414.1215929-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that stack growth must always hold the mmap_lock for write, we can
always downgrade the mmap_lock to read and safely unmap pages from the
page table, even if we're next to a stack.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/mmap.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9b5188b65800..82efaca58ca2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2550,19 +2550,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	mm->locked_vm -= locked_vm;
 	mm->map_count -= count;
-	/*
-	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
-	 * VM_GROWSUP VMA. Such VMAs can change their size under
-	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
-	 */
-	if (downgrade) {
-		if (next && (next->vm_flags & VM_GROWSDOWN))
-			downgrade = false;
-		else if (prev && (prev->vm_flags & VM_GROWSUP))
-			downgrade = false;
-		else
-			mmap_write_downgrade(mm);
-	}
+	if (downgrade)
+		mmap_write_downgrade(mm);
 
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
-- 
2.39.2

