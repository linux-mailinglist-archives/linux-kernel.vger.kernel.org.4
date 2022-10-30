Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED78B612D08
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 22:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJ3VcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 17:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJ3Vb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 17:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067ADBCAB
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667165450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MbdbMcNyE2RWt/K55AkSFMkKO4f3Jk1aXGE/HUSEbTg=;
        b=BS6qw7MNn/JHJKrhXFZ2er9onLButcr1nAeCNucXNFEpX1Ei7MwOZ25D1P09ylrkCUxlWi
        P9R9yb2OQ8OzCFvu6cxF5EkJGxEgR0odij+gEECUXgo25XoxLIKDgB6nrQkLlLOFFpiB6x
        rYWvNEvTuMWqRnIP5UdtC0SCHXUkM+Q=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-617-Go1VYq51Ptymg0yEMlu4-Q-1; Sun, 30 Oct 2022 17:30:48 -0400
X-MC-Unique: Go1VYq51Ptymg0yEMlu4-Q-1
Received: by mail-qk1-f199.google.com with SMTP id j13-20020a05620a410d00b006e08208eb31so8010670qko.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbdbMcNyE2RWt/K55AkSFMkKO4f3Jk1aXGE/HUSEbTg=;
        b=vYPyoHtdpwqPYuIWghT0jHZACAu08BXGDGzzqpav3AKbK7KbwEqu09XxFkqdZbbQYr
         VK/BKs2SweK2iYhWujQ/EQWZYQg6gvZXv+Br21oUnkdNqQBhlCHdbOwpoMNnFAgHVN7o
         LFCiRZ/1z0O/QHbMp2rVcMb2o6WzbiEaEU9taS2riCu2wIj3soT9bI5bv51u4LnxmQhN
         vOwpKYcPnBsivKYDyj3bSxQipvYcSz5vKuDzOktNn2OCSlIx7xHIrMUBB2c+9yq+gDAu
         Q+ZZOYTvBvUg8wptp6YSn6VOZz1ZkMAIJBU0iikTUrBlQF2qnByqM6lCL+E2nAl1qOO8
         jDqg==
X-Gm-Message-State: ACrzQf3u42xVCrCYeDvkwEOwHscGIKA+lNFhmFEAlF7iaiD+VGqH5rjR
        TeyJ9bFdZa/hu4JrzyLIxWBq6kw9OQADGFzumR6x9ydo740X+f/b5NlUEZJENrv9GpouZtQxeMU
        KmTrgHq5AHL41SpNeYDDqJihd
X-Received: by 2002:a0c:e44d:0:b0:4bb:6814:cacc with SMTP id d13-20020a0ce44d000000b004bb6814caccmr8623248qvm.73.1667165447960;
        Sun, 30 Oct 2022 14:30:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6jOrHvdqiTcpqwmdfHOEF5EeLgusoteeQUtfIu8VXZPch/zK/jAZabG/q9ulUqzuJxcqfFYA==
X-Received: by 2002:a0c:e44d:0:b0:4bb:6814:cacc with SMTP id d13-20020a0ce44d000000b004bb6814caccmr8623237qvm.73.1667165447749;
        Sun, 30 Oct 2022 14:30:47 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bk20-20020a05620a1a1400b006f3e6933bacsm3482823qkb.113.2022.10.30.14.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 14:30:47 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH RFC 10/10] mm/hugetlb: Comment at rest huge_pte_offset() places
Date:   Sun, 30 Oct 2022 17:30:45 -0400
Message-Id: <20221030213045.335680-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221030212929.335473-1-peterx@redhat.com>
References: <20221030212929.335473-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes sure that we're covering all the existing huge_pte_offset()
callers and mention why they are safe regarding to pmd unsharing.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6d336d286394..270bfc578115 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4822,6 +4822,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	last_addr_mask = hugetlb_mask_last_page(h);
 	for (addr = src_vma->vm_start; addr < src_vma->vm_end; addr += sz) {
 		spinlock_t *src_ptl, *dst_ptl;
+		/* With vma lock held, safe without RCU */
 		src_pte = huge_pte_offset(src, addr, sz);
 		if (!src_pte) {
 			addr |= last_addr_mask;
@@ -5026,6 +5027,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(mapping);
 	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
+		/* With vma lock held, safe without RCU */
 		src_pte = huge_pte_offset(mm, old_addr, sz);
 		if (!src_pte) {
 			old_addr |= last_addr_mask;
@@ -5097,6 +5099,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 	last_addr_mask = hugetlb_mask_last_page(h);
 	address = start;
 	for (; address < end; address += sz) {
+		/* With vma lock held, safe without RCU */
 		ptep = huge_pte_offset(mm, address, sz);
 		if (!ptep) {
 			address |= last_addr_mask;
@@ -5402,6 +5405,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			hugetlb_vma_lock_read(vma);
 			spin_lock(ptl);
+			/* With vma lock held, safe without RCU */
 			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 			if (likely(ptep &&
 				   pte_same(huge_ptep_get(ptep), pte)))
@@ -5440,6 +5444,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * before the page tables are altered
 	 */
 	spin_lock(ptl);
+	/* With vma lock (and even pgtable lock) held, safe without RCU */
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
 		/* Break COW or unshare */
@@ -6511,6 +6516,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	last_addr_mask = hugetlb_mask_last_page(h);
 	for (; address < end; address += psize) {
 		spinlock_t *ptl;
+		/* With vma lock held, safe without RCU */
 		ptep = huge_pte_offset(mm, address, psize);
 		if (!ptep) {
 			address |= last_addr_mask;
@@ -7060,7 +7066,14 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 
 		saddr = page_table_shareable(svma, vma, addr, idx);
 		if (saddr) {
+			/*
+			 * huge_pmd_share() (or say its solo caller,
+			 * huge_pte_alloc()) always takes the hugetlb vma
+			 * lock, so it's always safe to walk the pgtable of
+			 * the process, even without RCU.
+			 */
 			spte = huge_pte_offset(svma->vm_mm, saddr,
+
 					       vma_mmu_pagesize(svma));
 			if (spte) {
 				get_page(virt_to_page(spte));
@@ -7420,6 +7433,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	for (address = start; address < end; address += PUD_SIZE) {
+		/* With vma lock held, safe without RCU */
 		ptep = huge_pte_offset(mm, address, sz);
 		if (!ptep)
 			continue;
-- 
2.37.3

