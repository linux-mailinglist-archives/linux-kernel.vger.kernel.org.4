Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C28728D0F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbjFIB0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237202AbjFIB0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:26:10 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4411218D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:26:09 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-565cd2fc9acso11738727b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686273968; x=1688865968;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PmbbTemShg7dGpCJymh8ioCm9PQPk/gLwHXF7mQ6jbw=;
        b=d+dKJf7MYgGkbogFV5iJ0in/u8QWUjYLBAFmQ7ygcUpoTtYR38tV8VjHHRx79+tqC1
         xHAi8VEI8udjhn0i6NXjlbZGM0curW/G09YDGBDO7uNeymgEDUutuEhY67dcv9e1JC3c
         Kr/lYteRhi8EZZ4ON3qgr8IZYbs22sar5cHF6pJ+hkjtIcaYivcyvRaJDrPKAoQHoxL4
         78cmtQoJihNLnrWGPJ0/wzQ+Ft29PFAH7mols+/0p1qq115e8foXt7EV0WK2TTvZzAlK
         WTFccNgXKTckPziGTMxd+vfG4KkV3xlgmbe2/Bx5rx+kPXmMSxor6N0wIGRCDIqsVdI4
         znJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686273968; x=1688865968;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmbbTemShg7dGpCJymh8ioCm9PQPk/gLwHXF7mQ6jbw=;
        b=H1joAbgKagzyKsreS/veSL4IlkDtHwhxRof9KBqhgxgANyKpCbSadHD4EaXyYh4zeI
         WUC8zpYJBLoZoEnJkbi6wiUysGT2fqzUleFv+KbeinQwx56zdm1HFXCwNwGuf9GZRcI3
         2LJv5Jf1LNadnyxqnhvB34//RCq7LmKpGLI04xUlTxUU3XDQZjX/+rnLKYVzUYcVHAuH
         5yC53WpipkgwJ4sDYq8sIE+UsrIGY9obo//zeYLCg9YzM0n/uhiBnpCVYzp9gUUjwBA/
         n/Dcci/eQj0YQGL8C/AFdwjIQHqy4GpeF/5mSYVR3YcxMBnVZ0uANNwWPPmmvCzl/U+M
         W4dA==
X-Gm-Message-State: AC+VfDzSLijw/uygBUSGnQiLkUNuJEYct4txjH4vfB0/z3LjLW9sJLEm
        3NM8QVQ5yMfP42vOxKKFqvd1BQ==
X-Google-Smtp-Source: ACHHUZ7XTCguPhOybQY+LH+ypWpoP0kYFfabibD6+mqWrxXo7bpsKAzEBYkvZOCdhGRiVh3fVLiw0Q==
X-Received: by 2002:a81:5b89:0:b0:560:eadc:3bc9 with SMTP id p131-20020a815b89000000b00560eadc3bc9mr1402433ywb.7.1686273968353;
        Thu, 08 Jun 2023 18:26:08 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p82-20020a815b55000000b00561e7639ee8sm296391ywb.57.2023.06.08.18.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:26:07 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:26:04 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 15/32] mm/userfaultfd: allow pte_offset_map_lock() to
 fail
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <50cf3930-1bfa-4de9-a079-3da47b7ce17b@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mfill_atomic_install_pte() and mfill_atomic_pte_zeropage() treat
failed pte_offset_map_lock() as -EAGAIN, which mfill_atomic() already
returns to user for a similar race.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/userfaultfd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e97a0b4889fc..5fd787158c70 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -76,7 +76,10 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	if (flags & MFILL_ATOMIC_WP)
 		_dst_pte = pte_mkuffd_wp(_dst_pte);
 
+	ret = -EAGAIN;
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+	if (!dst_pte)
+		goto out;
 
 	if (vma_is_shmem(dst_vma)) {
 		/* serialize against truncate with the page table lock */
@@ -121,6 +124,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	ret = 0;
 out_unlock:
 	pte_unmap_unlock(dst_pte, ptl);
+out:
 	return ret;
 }
 
@@ -212,7 +216,10 @@ static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
 
 	_dst_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
 					 dst_vma->vm_page_prot));
+	ret = -EAGAIN;
 	dst_pte = pte_offset_map_lock(dst_vma->vm_mm, dst_pmd, dst_addr, &ptl);
+	if (!dst_pte)
+		goto out;
 	if (dst_vma->vm_file) {
 		/* the shmem MAP_PRIVATE case requires checking the i_size */
 		inode = dst_vma->vm_file->f_inode;
@@ -231,6 +238,7 @@ static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
 	ret = 0;
 out_unlock:
 	pte_unmap_unlock(dst_pte, ptl);
+out:
 	return ret;
 }
 
-- 
2.35.3

