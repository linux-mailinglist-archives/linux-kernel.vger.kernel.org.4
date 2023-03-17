Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13E26BF4C9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCQV6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjCQV6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:58:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066094681
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:58:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m2so5641241wrh.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 14:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679090313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WRGTUCFXkHGDXIpCCchpoD4urIMZfIjv9HBnqnD3s8=;
        b=ZTWp/dwXxkIJIy+sbetjHxGbG0sO2V60Lc6mgkm/ewopNB3etrn+nimKaBs9LZa5oK
         s09Hb5HBEPk6X2C62wDwpIYPR5YI48oITA9/DKyfpdaWn8BwBJalIS6Ey+pZPsCJt3Io
         hpucBdirZtxnd9VMFC4qtthIk6X5y0S03dKANyqGe4sgtSpgwVAbnGedB2t6t+Fe/B/a
         N27QqhyVa7oEnyqFzwfh3ysCWlZrg90Y7BiV246iEUpdMlwGY8VYLSC2Zg4Lwef5+2oA
         2oyXGyEm1ndLdBbzbbS/zNzczh1IrcNT4Safuzctvy7quwGA6/wrUpwLBF2Ychrgqyb/
         kreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679090313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WRGTUCFXkHGDXIpCCchpoD4urIMZfIjv9HBnqnD3s8=;
        b=ydxQ8++bLlDsXPIWzVjSQE8V8Pq0igyXpRcgNKl+pMGi+DuJNUTOswlDnkbZUVxmO6
         t5ZJk7qhv2ciP5FQi23jOoyWaFTztLW8+ouLdFwSBfTrZKlMrQtcqmHjAsmM1euMn/ww
         zTg4Y8EtGgrjoiQYXwruazTR9YlNYiIjd0DRLAaWpY0wVsy8jmCFnsuw516+F7gjQAnW
         F6x7T7FTjyklmsmswKUvnz03QTNX5JZjHu8M1IZPeuC1STRWhiaMEZAzG+q28hHoG1Mr
         hY7njYhR/wR8aQSBrbr2AMZKISwDqK9xWMjnwjjGm3yBk/vwgNkYIPHswebnnI2O39a3
         a64g==
X-Gm-Message-State: AO0yUKXTaPQflaCpfhPj2aaZkr9zDJGG00HUi9Z/OiZADy4ymGUi6C+M
        y45PM9HJBT9LxKkGRlr/M+A=
X-Google-Smtp-Source: AK7set8pr8elo4x2KKbOBJVOAwcf4Xa9fosjB+N4AOwqHw6oQ4zMx+Q4dkmlOhI3zZUFpRUaUI8ZTA==
X-Received: by 2002:adf:e8cd:0:b0:2ca:175b:d850 with SMTP id k13-20020adfe8cd000000b002ca175bd850mr7718855wrn.11.1679090313217;
        Fri, 17 Mar 2023 14:58:33 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id c9-20020a5d4cc9000000b002d21379bcabsm2849757wrt.110.2023.03.17.14.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:58:32 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 1/2] mm: refactor do_fault_around()
Date:   Fri, 17 Mar 2023 21:58:25 +0000
Message-Id: <d125db1c3665a63b80cea29d56407825482e2262.1679089214.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679089214.git.lstoakes@gmail.com>
References: <cover.1679089214.git.lstoakes@gmail.com>
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

The existing logic is confusing and fails to abstract a number of bitwise
tricks.

Use ALIGN_DOWN() to perform alignment, pte_index() to obtain a PTE index
and represent the address range using PTE offsets, which naturally make it
clear that the operation is intended to occur within only a single PTE and
prevent spanning of more than one page table.

We rely on the fact that fault_around_bytes will always be page-aligned, at
least one page in size, a power of two and that it will not exceed
PAGE_SIZE * PTRS_PER_PTE in size (i.e. the address space mapped by a
PTE). These are all guaranteed by fault_around_bytes_set().

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/memory.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c5f1bf906d0c..3d85aa7106b0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4437,8 +4437,8 @@ late_initcall(fault_around_debugfs);
  * It uses vm_ops->map_pages() to map the pages, which skips the page if it's
  * not ready to be mapped: not up-to-date, locked, etc.
  *
- * This function doesn't cross the VMA boundaries, in order to call map_pages()
- * only once.
+ * This function doesn't cross VMA or page table boundaries, in order to call
+ * map_pages() and acquire a PTE lock only once.
  *
  * fault_around_bytes defines how many bytes we'll try to map.
  * do_fault_around() expects it to be set to a power of two less than or equal
@@ -4451,27 +4451,19 @@ late_initcall(fault_around_debugfs);
  */
 static vm_fault_t do_fault_around(struct vm_fault *vmf)
 {
-	unsigned long address = vmf->address, nr_pages, mask;
-	pgoff_t start_pgoff = vmf->pgoff;
-	pgoff_t end_pgoff;
-	int off;
+	pgoff_t nr_pages = READ_ONCE(fault_around_bytes) >> PAGE_SHIFT;
+	pgoff_t pte_off = pte_index(vmf->address);
+	/* The page offset of vmf->address within the VMA. */
+	pgoff_t vma_off = vmf->pgoff - vmf->vma->vm_pgoff;
+	pgoff_t from_pte, to_pte;
 
-	nr_pages = READ_ONCE(fault_around_bytes) >> PAGE_SHIFT;
-	mask = ~(nr_pages * PAGE_SIZE - 1) & PAGE_MASK;
+	/* The PTE offset of the start address, clamped to the VMA. */
+	from_pte = max(ALIGN_DOWN(pte_off, nr_pages),
+		       pte_off - min(pte_off, vma_off));
 
-	address = max(address & mask, vmf->vma->vm_start);
-	off = ((vmf->address - address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1);
-	start_pgoff -= off;
-
-	/*
-	 *  end_pgoff is either the end of the page table, the end of
-	 *  the vma or nr_pages from start_pgoff, depending what is nearest.
-	 */
-	end_pgoff = start_pgoff -
-		((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)) +
-		PTRS_PER_PTE - 1;
-	end_pgoff = min3(end_pgoff, vma_pages(vmf->vma) + vmf->vma->vm_pgoff - 1,
-			start_pgoff + nr_pages - 1);
+	/* The PTE offset of the end address, clamped to the VMA and PTE. */
+	to_pte = min3(from_pte + nr_pages, (pgoff_t)PTRS_PER_PTE,
+		      pte_off + vma_pages(vmf->vma) - vma_off) - 1;
 
 	if (pmd_none(*vmf->pmd)) {
 		vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm_mm);
@@ -4479,7 +4471,9 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 			return VM_FAULT_OOM;
 	}
 
-	return vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
+	return vmf->vma->vm_ops->map_pages(vmf,
+		vmf->pgoff + from_pte - pte_off,
+		vmf->pgoff + to_pte - pte_off);
 }
 
 /* Return true if we should do read fault-around, false otherwise */
-- 
2.39.2

