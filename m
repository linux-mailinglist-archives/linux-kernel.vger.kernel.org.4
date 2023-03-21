Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4AA6C3C25
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCUUqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjCUUqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:46:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB02F54C8F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:46:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i9so15026101wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679431584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfsZBuYgS6pqJ3Am6jGw1RAqKs9VHOoqJ2PWKKositw=;
        b=Xthyp8pNRedrgpz+v7r1SoXbmc6FhAaRO0rPX1lWRJx0A6HaV08XrfWC3LBKRr1v4J
         VVJn5sFjSfzpbAaBIECALfN2ebHT0JfzrX1GnPa4bT8W0hFFyOdyhRLCYjL9viRXVCzW
         l8Lz43DLOTRm3mkbFemM/Ofmh4JH89aCXl1jKSNyU4vhKGd9FSFAaRKFmKYTcaaNMWae
         kU9h111gk9jlfYE1r8tSyq65aKuuJ9TgN6Jm2xuLTJ/VsMbqA9+nRWd5HiO03wrPX5Kz
         yuAd9nbzdzKyHs0L2r/tAw9etDrdkFR9dao7pQuZoWZ9Ht3Mr6j88Cgqyd0Q6+GrsfnO
         Uwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679431584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfsZBuYgS6pqJ3Am6jGw1RAqKs9VHOoqJ2PWKKositw=;
        b=bfgLgmsdlOe5AMbXO7YmvF+MoV4N5MxOigEh463wxYWD2o7C8ncfyQkIimXT4pfo9q
         PD0OW90k/xq5+ER9qszsQYYmutpKV/L4tAwHNATX4QJR2iN3PKdf4Mwk2DDDNQRAtDSd
         WmNx2ELgnKm66y58y1k3c07WUGZ9BgtHMWI0g9m6oKJRMCTIWKIyvBHMbN8HwytbPISG
         ne+vFE0tlUuI/opmNMnKbloXHUW2+FVJar7PSWyO85SgpjZ5sTEgl696nvhwY4NcNbCe
         GkOhVx3ite5GoJ3GDQCDLGInVspAF8k2KBz4WVLT8KDf1UlUDJe9CA6HT9IyUfk7UIAQ
         VJwg==
X-Gm-Message-State: AO0yUKUzTtupYnbOqS9q+7auLUJnpm9a1kb999LzbDoY6zPzSssAAuaY
        7x+/azvFl4LyqQtvOM/wkio=
X-Google-Smtp-Source: AK7set8vgB48KSqkTfNA3yVmqhUDD2V9Hf3XxSaQnFm8ZDXG7nS4tj0A/4peODTUrzQZWqI5gVVA0w==
X-Received: by 2002:a5d:4535:0:b0:2c7:e5f:e0e0 with SMTP id j21-20020a5d4535000000b002c70e5fe0e0mr3542607wra.65.1679431584097;
        Tue, 21 Mar 2023 13:46:24 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id a4-20020adffb84000000b002d322b9a7f5sm12142491wrr.88.2023.03.21.13.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:46:23 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 3/4] mm/mmap/vma_merge: extend invariants, avoid invalid res, vma
Date:   Tue, 21 Mar 2023 20:45:57 +0000
Message-Id: <17b6fc3edc46c4b33aa93b9ef17a63a3a76f4b5f.1679431180.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679431180.git.lstoakes@gmail.com>
References: <cover.1679431180.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, vma was an uninitialised variable which was only definitely
assigned as a result of the logic covering all possible input cases - for
it to have remained uninitialised, prev would have to be NULL, and next
would _have_ to be mergeable.

We now reuse vma to assign curr and next, so to be absolutely explicit,
ensure this variable is _always_ assigned, and while we're at it remove the
redundant assignment of both res and vma (if prev is NULL then we simply
assign to NULL).

In addition, we absolutely do rely on addr == curr->vm_start should curr
exist, so assert as much.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/mmap.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6361baf75601..7aec49c3bc74 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -911,7 +911,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 {
 	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
 	pgoff_t vma_pgoff;
-	struct vm_area_struct *curr, *next, *res = NULL;
+	struct vm_area_struct *curr, *next, *res;
 	struct vm_area_struct *vma, *adjust, *remove, *remove2;
 	int err = -1;
 	bool merge_prev = false;
@@ -940,14 +940,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		/* Is there a VMA next to a hole (case 1 - 3) or prev (4)? */
 		next = vma_lookup(mm, end);
 
-	/* verify some invariant that must be enforced by the caller */
+	/*
+	 * By default, we return prev. Cases 3, 4, 8 will instead return next
+	 * and cases 3, 8 will also update vma to point at next.
+	 */
+	res = vma = prev;
+
+	/* Verify some invariant that must be enforced by the caller. */
 	VM_WARN_ON(prev && addr <= prev->vm_start);
-	VM_WARN_ON(curr && end > curr->vm_end);
+	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
 	VM_WARN_ON(addr >= end);
 
 	if (prev) {
-		res = prev;
-		vma = prev;
 		vma_start = prev->vm_start;
 		vma_pgoff = prev->vm_pgoff;
 		/* Can we merge the predecessor? */
@@ -958,6 +962,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_prev(vmi);
 		}
 	}
+
 	/* Can we merge the successor? */
 	if (next && mpol_equal(policy, vma_policy(next)) &&
 	    can_vma_merge_before(next, vm_flags,
@@ -998,6 +1003,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			adj_start = -(prev->vm_end - addr);
 			err = dup_anon_vma(next, prev);
 		} else {
+			/*
+			 * Note that cases 3 and 8 are the ONLY ones where prev
+			 * is permitted to be (but is not necessarily) NULL.
+			 */
 			vma = next;			/* case 3 */
 			vma_start = addr;
 			vma_end = next->vm_end;
-- 
2.39.2

