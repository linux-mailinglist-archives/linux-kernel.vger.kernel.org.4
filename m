Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6DA6B227C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjCILRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCILRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:17:11 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419E452938
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:13:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BA22820038;
        Thu,  9 Mar 2023 11:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678360391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gbf95vBZ5k9dAL8M3+AX1LlYXPAiH98C9Dqf/EiMlS8=;
        b=L4GQl+rCi7b/MlyiNCdlvP2/QHKYSvrumdcDGMrBzztwmi38bCFmnGky5OC57tE0RHNqs1
        7ixmN+UDKQDs7qdXNJXp8kM4Yh6i0SgG3yx2LHagLLa6elEk0YbHrXOHaRnzB3yiNaZ15O
        06yPlYNnALxdXMnr1zP8jY0WKHDijDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678360391;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gbf95vBZ5k9dAL8M3+AX1LlYXPAiH98C9Dqf/EiMlS8=;
        b=RqUUZs3zze8kfxz8IeZ6c3MJNo33G7eXkX3dJBPrfXidjrYIU6s49P6pyslGajl/2z7Pgk
        kkgN3lTDU9B34LBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F19A1391B;
        Thu,  9 Mar 2023 11:13:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4KlAJke/CWRiRwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 09 Mar 2023 11:13:11 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 06/10] mm/mmap/vma_merge: set mid to NULL if not applicable
Date:   Thu,  9 Mar 2023 12:12:54 +0100
Message-Id: <20230309111258.24079-7-vbabka@suse.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309111258.24079-1-vbabka@suse.cz>
References: <20230309111258.24079-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several places where we test if 'mid' is really the area NNNN
in the diagram and the tests have two variants and are non-obvious to
follow.  Instead, set 'mid' to NULL up-front if it's not the NNNN area,
and simplify the tests.

Also update the description in comment accordingly.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index be60b344e4b1..3396c9b13f1c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -848,10 +848,11 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
  *
  * The following mprotect cases have to be considered, where AAAA is
  * the area passed down from mprotect_fixup, never extending beyond one
- * vma, PPPPPP is the prev vma specified, and NNNNNN the next vma after:
+ * vma, PPPPPP is the prev vma specified, NNNN is a vma that overlaps
+ * the area AAAA and XXXXXX the next vma after AAAA:
  *
  *     AAAA             AAAA                   AAAA
- *    PPPPPPNNNNNN    PPPPPPXXXXXX       PPPPPPNNNNNN
+ *    PPPPPPXXXXXX    PPPPPPXXXXXX       PPPPPPNNNNNN
  *    cannot merge    might become       might become
  *                    PPXXXXXXXXXX       PPPPPPPPPPNN
  *    mmap, brk or    case 4 below       case 5 below
@@ -879,9 +880,10 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
  *
  * In the code below:
  * PPPP is represented by *prev
- * NNNN is represented by *mid (and possibly equal to *next)
- * XXXX is represented by *next or not represented at all.
- * AAAA is not represented - it will be merged or the function will return NULL
+ * NNNN is represented by *mid or not represented at all (NULL)
+ * XXXX is represented by *next or not represented at all (NULL)
+ * AAAA is not represented - it will be merged and the vma containing the
+ *      area is returned, or the function will return NULL
  */
 struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			struct vm_area_struct *prev, unsigned long addr,
@@ -918,6 +920,9 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	else
 		next = mid;
 
+	if (mid && end <= mid->vm_start)
+		mid = NULL;
+
 	/* verify some invariant that must be enforced by the caller */
 	VM_WARN_ON(prev && addr <= prev->vm_start);
 	VM_WARN_ON(mid && end > mid->vm_end);
@@ -952,7 +957,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		remove = next;				/* case 1 */
 		vma_end = next->vm_end;
 		err = dup_anon_vma(prev, next);
-		if (mid != next) {			/* case 6 */
+		if (mid) {				/* case 6 */
 			remove = mid;
 			remove2 = next;
 			if (!next->anon_vma)
@@ -960,7 +965,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		}
 	} else if (merge_prev) {
 		err = 0;				/* case 2 */
-		if (mid && end > mid->vm_start) {
+		if (mid) {
 			err = dup_anon_vma(prev, mid);
 			if (end == mid->vm_end) {	/* case 7 */
 				remove = mid;
@@ -982,7 +987,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_end = next->vm_end;
 			vma_pgoff = next->vm_pgoff;
 			err = 0;
-			if (mid != next) {		/* case 8 */
+			if (mid) {			/* case 8 */
 				vma_pgoff = mid->vm_pgoff;
 				remove = mid;
 				err = dup_anon_vma(next, mid);
-- 
2.39.2

