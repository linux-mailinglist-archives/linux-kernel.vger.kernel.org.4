Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D95970B452
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjEVFHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjEVFHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:07:45 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93863121
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:40 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-ba81ded8d3eso8293222276.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684732059; x=1687324059;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Po1SIcw5OHs73xEeyHWdahQyrrpxMX/55AnymOheHdY=;
        b=XzjxgjxtBkGDdrW/JpZQDO+0w80TppLUP+i4zWugdKgK+0BNyYiAZxNPu761zqLwx6
         N3d13FtSjEQD3/Az+Ls+AFMRVUTTfTFgq/wZnRC0unRzbTg+QL2AfL6VOrwQD3Fvko86
         qlQqsdfEsD0BIjaUfvcqtxxN7EhPjQv4ZZ4GoDxZbghd8kbh23gJUnZyVTa53cW4rd+n
         tv3DkjOFptWFHPJ1odIqKO55YZwU9ED++0I8TwmndtdJ/9Tx2WjmcnDlE6yL1e/aGSkQ
         np4d2w4yIyiw0TP07HR0yzbTPdSSCgTIX7OtmwdleJ4u8G05hehjmr7+xcCmgkF4+y38
         RHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732059; x=1687324059;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Po1SIcw5OHs73xEeyHWdahQyrrpxMX/55AnymOheHdY=;
        b=dVww+O0f9z+uvXtvp1yOl6IH2wP4gUM7hpmSEoHntm/39WLvWf5tCPg8qTxMLUGeYX
         FhshdE4h4y2RLGWuJoAmK2539m5ebfA6VVKsswOu3aA8LsIk35PEZlGw7Bqs9ZHFiadS
         /UemxjSvWZeAuSDtdRL1kgXLwLbjRic3VoP6/2PZ1zjj8aPERNI8V38xrvQHa0rhu+m+
         uyq2Uk9hQY+sJ25ankSaVFEE9PWcaYj6f1lZz32C/zKE4essLpIYwGqqk2uMy13LLK2F
         MozzqfSTPgr50Em/deqCMUGFy777ttj4mPq6dO6BOCVnoenjbHUzcXyQHlUciRKStZ/Y
         Rq4w==
X-Gm-Message-State: AC+VfDzt37Sa2ZjHkFkr6SQwGcgSElx7PqYcv2qnATv0jGBox1tXgT7G
        uzSVazV1g0025nniqD0CBrrsQw==
X-Google-Smtp-Source: ACHHUZ4m3WCKHCRUDIqxwtJbDgKim2PjP4Uj/Gl/wyaY7gpZzCtLpfaCmSlMhzQlWiwCXodOnzTDfw==
X-Received: by 2002:a25:ada2:0:b0:ba8:fe6:8e3f with SMTP id z34-20020a25ada2000000b00ba80fe68e3fmr8924520ybi.5.1684732059390;
        Sun, 21 May 2023 22:07:39 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r10-20020a0de80a000000b0054662f7b42dsm1801064ywe.63.2023.05.21.22.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:07:39 -0700 (PDT)
Date:   Sun, 21 May 2023 22:07:35 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 15/31] mm/userfaultfd: allow pte_offset_map_lock() to fail
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <49d92b15-3442-4e84-39bd-c77c316bf844@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
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
failed pte_offset_map_lock() as -EFAULT, with no attempt to retry.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/userfaultfd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e97a0b4889fc..b1554286a31c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -76,14 +76,16 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	if (flags & MFILL_ATOMIC_WP)
 		_dst_pte = pte_mkuffd_wp(_dst_pte);
 
+	ret = -EFAULT;
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+	if (!dst_pte)
+		goto out;
 
 	if (vma_is_shmem(dst_vma)) {
 		/* serialize against truncate with the page table lock */
 		inode = dst_vma->vm_file->f_inode;
 		offset = linear_page_index(dst_vma, dst_addr);
 		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
-		ret = -EFAULT;
 		if (unlikely(offset >= max_off))
 			goto out_unlock;
 	}
@@ -121,6 +123,7 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
 	ret = 0;
 out_unlock:
 	pte_unmap_unlock(dst_pte, ptl);
+out:
 	return ret;
 }
 
@@ -212,13 +215,15 @@ static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
 
 	_dst_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
 					 dst_vma->vm_page_prot));
+	ret = -EFAULT;
 	dst_pte = pte_offset_map_lock(dst_vma->vm_mm, dst_pmd, dst_addr, &ptl);
+	if (!dst_pte)
+		goto out;
 	if (dst_vma->vm_file) {
 		/* the shmem MAP_PRIVATE case requires checking the i_size */
 		inode = dst_vma->vm_file->f_inode;
 		offset = linear_page_index(dst_vma, dst_addr);
 		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
-		ret = -EFAULT;
 		if (unlikely(offset >= max_off))
 			goto out_unlock;
 	}
@@ -231,6 +236,7 @@ static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
 	ret = 0;
 out_unlock:
 	pte_unmap_unlock(dst_pte, ptl);
+out:
 	return ret;
 }
 
-- 
2.35.3

