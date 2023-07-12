Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A7F74FE7E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 06:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGLEs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 00:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjGLEs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 00:48:56 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94346E5C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:48:54 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-765a5b93b5bso611468085a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689137333; x=1691729333;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0zmjk3m732t/eWPq5qXNEJLvruggBsecgrKanNe5l4=;
        b=tAltrJ8qMr5yXVnQZuMMmsi4IPuKxAEYvXvmeooSI3v5NqdP6qPUWbcm4zb7tBU4h0
         936uy7Nm9V74iqdYDFyZwMLGwgOGnmghXNT5lAvkazM3oPgRlzOU3kBQMNJKMKWtzkws
         ZatO7SnXXoLC90BYBdzQ4WBYmqP0ctRk/0Hc+tF1GdsKEFAQeyvKQs86n+DiFjeYhpmk
         XRCMyCpcHGCSuZBRElORlA2grjvaFnRdFuAQT1Yla1Xs8yZi7vEIkUka7t7lT4f5IA/C
         Nz/zbna6jWOHljpIWs1q8ROPrfRJMrX036XcNg8uGpFIBpPpSv0XdZ4EIxr1ptLpLNuX
         DVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689137333; x=1691729333;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0zmjk3m732t/eWPq5qXNEJLvruggBsecgrKanNe5l4=;
        b=NbIXLhGcv55DRN+tdgUF1RDQaXbW3R1iWR+8p4hRVQpmLqedYByNgzUIGf+EJvA/15
         iUv8ehpim6Mp26bDUSizoyZwLVeVpnhQ6tcpgxqPExuqHK6oQYgHxVJAL6ZDqL5llzg8
         uLfh72bA+3dFwQJN5FMN29JbMrVFu80xGw0kiCoSBAVgrd5h/ti4Go6Dxksm0v9vuMmx
         8uMB4tybOZnSpQcqD1splNKlvMVU1RTHNtJe67+DepfhcFxOR/iLSAJz+SZ2CgXTB5jQ
         8m3aMCovMTZgP1LF1W5MfzqqifsFY6utYL8TXO3s+bzPum+Zm7t6iebnHNHJpZTfXhgC
         XDcg==
X-Gm-Message-State: ABy/qLa/OCLP8pU0kzlQGKiBzpWq7oJEetgiGAit66jpYaLpMhVRrWyh
        bqLq0zJB4RX18ymy1TitKDUNhA==
X-Google-Smtp-Source: APBJJlEFW7pAKJkrMMZ7so7H+6qQo4Zhl/O905ULRzoeoCUXWypLVpWBJRwEwG5/0JeTCh7gTt6reA==
X-Received: by 2002:a05:620a:404e:b0:767:3fa7:2ae9 with SMTP id i14-20020a05620a404e00b007673fa72ae9mr19722823qko.12.1689137333537;
        Tue, 11 Jul 2023 21:48:53 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m124-20020a817182000000b0056d0709e0besm972906ywc.129.2023.07.11.21.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 21:48:53 -0700 (PDT)
Date:   Tue, 11 Jul 2023 21:48:48 -0700 (PDT)
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
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH mm 12/13] mm: delete mmap_write_trylock() and
 vma_try_start_write()
In-Reply-To: <728dae79-5110-e3c4-df27-ce3df525aaef@google.com>
Message-ID: <4e6db3d-e8e-73fb-1f2a-8de2dab2a87c@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com> <728dae79-5110-e3c4-df27-ce3df525aaef@google.com>
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

mmap_write_trylock() and vma_try_start_write() were added just for
khugepaged, but now it has no use for them: delete.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
This is the version which applies to mm-unstable or linux-next.

 include/linux/mm.h        | 17 -----------------
 include/linux/mmap_lock.h | 10 ----------
 2 files changed, 27 deletions(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -692,21 +692,6 @@ static inline void vma_start_write(struc
 	up_write(&vma->vm_lock->lock);
 }
 
-static inline bool vma_try_start_write(struct vm_area_struct *vma)
-{
-	int mm_lock_seq;
-
-	if (__is_vma_write_locked(vma, &mm_lock_seq))
-		return true;
-
-	if (!down_write_trylock(&vma->vm_lock->lock))
-		return false;
-
-	vma->vm_lock_seq = mm_lock_seq;
-	up_write(&vma->vm_lock->lock);
-	return true;
-}
-
 static inline void vma_assert_locked(struct vm_area_struct *vma)
 {
 	int mm_lock_seq;
@@ -758,8 +743,6 @@ static inline bool vma_start_read(struct
 		{ return false; }
 static inline void vma_end_read(struct vm_area_struct *vma) {}
 static inline void vma_start_write(struct vm_area_struct *vma) {}
-static inline bool vma_try_start_write(struct vm_area_struct *vma)
-		{ return true; }
 static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}
 static inline void vma_mark_detached(struct vm_area_struct *vma,
 				     bool detached) {}
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -112,16 +112,6 @@ static inline int mmap_write_lock_killab
 	return ret;
 }
 
-static inline bool mmap_write_trylock(struct mm_struct *mm)
-{
-	bool ret;
-
-	__mmap_lock_trace_start_locking(mm, true);
-	ret = down_write_trylock(&mm->mmap_lock) != 0;
-	__mmap_lock_trace_acquire_returned(mm, true, ret);
-	return ret;
-}
-
 static inline void mmap_write_unlock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_released(mm, true);
