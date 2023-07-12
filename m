Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D50674FE73
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 06:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjGLEpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 00:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjGLEpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 00:45:08 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3D01980
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:45:03 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-c50c797c31bso7317863276.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 21:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689137103; x=1691729103;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FwWrXdLh4e+ZZMmHSG9GahXduxLzpg1IKzk9+Pois54=;
        b=gzISCkNIkoYstaiURssLgcAP0NHrER6I1tuZ8rc0Qvm4Mprsdiz1G+fVe2F78Gadly
         Zd6Zv7R4mMYit6gDmv3ASM0ewnC89JI2TxXgi3FWSUoDcd6h1cjVrlXHTbjoLAQWnXuN
         ZQUv1RJ1RAUpKOWClvwrVKEYf90QtijHOwpAofLxIipQ4ubW+8saarTIudeMK/r5lyew
         pHuqVs8/tIX7WT6ZYHIjSpcSZfFYwHc9ruaHZLElCwezBNkxHQx4zaVjKMhWpdolCgWJ
         CTIkHHX4v8I9yJRfGqJT3RXI/emCB7p8zIkR9VuDxyTUEDm4M6z0824h8U/TQtrRCylu
         LH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689137103; x=1691729103;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwWrXdLh4e+ZZMmHSG9GahXduxLzpg1IKzk9+Pois54=;
        b=BSP5AA3FTFI9JsJDV8hgRjembLS+YSdbw4InQUQB3vKIVcdyFbRu/ll3yTfu5awhlg
         neK1B7YBrCMkXUTG2EUMINonmDqm5YSHEoKIclmHBxTs7UMMeI1ad6IxI5j6/gWR7HKX
         tDYe9LbOhlkVZWA+G2fNJIn5iNW+zCA2GIpiMg+qjeqNRnEqvzDTkz93s3TQOXAAjdb0
         lkEegYzSnSpAg4nL7j/Ym6pkQBjLpzupM5m7W1wdTC6H/ci0n4ZhfcID9RpspJdFZaFZ
         veYFD1QARFNgReZNc/QjHa+4kDZ5QaRjjmXA/wpahLPAgWVsq4weMZti2rH2MHOXscH3
         M2bA==
X-Gm-Message-State: ABy/qLZRkV8NB8LMXaHffMo/Fckz+baciv3gw2nwvB4RB9fdJdp8M7YZ
        ZKjpztMI8O3PrhU6FSX0r05nSw==
X-Google-Smtp-Source: APBJJlHRrkvIp6Bta0OiFd96ROrSVoBT2nJnQYkUAOeyOnPlbKa4aui5kARvVpJZZxshvdKBo9N7Xg==
X-Received: by 2002:a81:ab51:0:b0:577:bc6:6f8c with SMTP id d17-20020a81ab51000000b005770bc66f8cmr17906536ywk.26.1689137102617;
        Tue, 11 Jul 2023 21:45:02 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r11-20020a0de80b000000b00561949f713fsm993186ywe.39.2023.07.11.21.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 21:45:02 -0700 (PDT)
Date:   Tue, 11 Jul 2023 21:44:57 -0700 (PDT)
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
Subject: [PATCH v3 12/13] mm: delete mmap_write_trylock() and
 vma_try_start_write()
In-Reply-To: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
Message-ID: <728dae79-5110-e3c4-df27-ce3df525aaef@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmap_write_trylock() and vma_try_start_write() were added just for
khugepaged, but now it has no use for them: delete.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/mm.h        | 17 -----------------
 include/linux/mmap_lock.h | 10 ----------
 2 files changed, 27 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2dd73e4f3d8e..b7b45be616ad 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -692,21 +692,6 @@ static inline void vma_start_write(struct vm_area_struct *vma)
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
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
 	int mm_lock_seq;
@@ -731,8 +716,6 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 		{ return false; }
 static inline void vma_end_read(struct vm_area_struct *vma) {}
 static inline void vma_start_write(struct vm_area_struct *vma) {}
-static inline bool vma_try_start_write(struct vm_area_struct *vma)
-		{ return true; }
 static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}
 static inline void vma_mark_detached(struct vm_area_struct *vma,
 				     bool detached) {}
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index aab8f1b28d26..d1191f02c7fa 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -112,16 +112,6 @@ static inline int mmap_write_lock_killable(struct mm_struct *mm)
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
-- 
2.35.3

