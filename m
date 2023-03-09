Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895036B2289
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjCILSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjCILRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:17:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB5D52F64
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:13:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD1FE20039;
        Thu,  9 Mar 2023 11:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678360391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H5Xl+u0fh2FgM3W17DN3PSvRbLMjIOp4J+v3PnRSZIo=;
        b=B/CM6zj2HePtuxZyWrSBOI+UpLPmAYIkevuMn8C1gakrbEx7dx4iWnWdEWCjgvFUYVVUZy
        k7q5PeFsmR6+U94AH7pmEh964kEjclVSO7u6kyj/hU04saF+BWM8C0OR9Ec46vrX2itxVX
        nosl3jQgoKjWKudlG81Kp3fkVEQczgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678360391;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H5Xl+u0fh2FgM3W17DN3PSvRbLMjIOp4J+v3PnRSZIo=;
        b=oNHa/N2cnuMf0OOPPR/beI9/RMdRl/JNf5JcX8V2U8tICXzM5KqpPDQQXmiUIn/6euVKKV
        y9QumAAEW80pDOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC57113A73;
        Thu,  9 Mar 2023 11:13:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eL1bLUe/CWRiRwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 09 Mar 2023 11:13:11 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        maple-tree@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 07/10] mm/mmap/vma_merge: rename adj_next to adj_start
Date:   Thu,  9 Mar 2023 12:12:55 +0100
Message-Id: <20230309111258.24079-8-vbabka@suse.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309111258.24079-1-vbabka@suse.cz>
References: <20230309111258.24079-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'adj_next' holds the value by which we adjust vm_start of a
vma in variable 'adjust', that's either 'next' or 'mid', so the current
name is inaccurate. Rename it to 'adj_start'.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3396c9b13f1c..c51d69592e4e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -903,7 +903,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	bool vma_expanded = false;
 	struct vma_prepare vp;
 	unsigned long vma_end = end;
-	long adj_next = 0;
+	long adj_start = 0;
 	unsigned long vma_start = addr;
 
 	validate_mm(mm);
@@ -971,7 +971,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 				remove = mid;
 			} else {			/* case 5 */
 				adjust = mid;
-				adj_next = (end - mid->vm_start);
+				adj_start = (end - mid->vm_start);
 			}
 		}
 	} else if (merge_next) {
@@ -979,7 +979,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		if (prev && addr < prev->vm_end) {	/* case 4 */
 			vma_end = addr;
 			adjust = next;
-			adj_next = -(prev->vm_end - addr);
+			adj_start = -(prev->vm_end - addr);
 			err = dup_anon_vma(next, prev);
 		} else {
 			vma = next;			/* case 3 */
@@ -1002,7 +1002,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (vma_iter_prealloc(vmi))
 		return NULL;
 
-	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_next);
+	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_start);
 	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
 	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
 		   vp.anon_vma != adjust->anon_vma);
@@ -1018,10 +1018,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (vma_expanded)
 		vma_iter_store(vmi, vma);
 
-	if (adj_next) {
-		adjust->vm_start += adj_next;
-		adjust->vm_pgoff += adj_next >> PAGE_SHIFT;
-		if (adj_next < 0) {
+	if (adj_start) {
+		adjust->vm_start += adj_start;
+		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
+		if (adj_start < 0) {
 			WARN_ON(vma_expanded);
 			vma_iter_store(vmi, next);
 		}
-- 
2.39.2

