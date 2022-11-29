Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3B863C896
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbiK2TjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbiK2The (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:37:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C55F61B9E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669750546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T6R1JTF+AaMAR6h+PxJxqsbJoPo1sRZuxu2H68hPMl4=;
        b=ZyJNUbZYcDJiXuNvY51fAT1dqbwwBU567CV9FlKVUidJW/2OMKqYsdI8rX0kJPYoQ5aKwm
        IBsMo71H7IAq8K8eTNWsIrNIQNdEAETQGglVgN7i10/42DG0rMSRxxDTUjiTKLn8C50kcO
        VmpY121zu8V7Q3rPfKl68Ly6YX0ZtBo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-194-nlRha3X-Mq67M3YdpnzmwA-1; Tue, 29 Nov 2022 14:35:44 -0500
X-MC-Unique: nlRha3X-Mq67M3YdpnzmwA-1
Received: by mail-qk1-f200.google.com with SMTP id u5-20020a05620a0c4500b006fb30780443so32368208qki.22
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6R1JTF+AaMAR6h+PxJxqsbJoPo1sRZuxu2H68hPMl4=;
        b=zxN9CAUXaF+XXAlA4QMp79Z/t5PkTH95AZKxBV0xAuVvNHwE5meKkXDVcYpOaTg+N9
         ORIiOiO9EiWNfqNeax+aPlyuhRdiMs56+pGBPUVNcvmoryXReBeoOCBox3uTeqUUHPHw
         RxtMVPhBtIwIxeDqv7xs1VTrx256o0+2f6HO9hflgiQTOO4DBiQeM2JG2GfEY3VF02tE
         7GhvqWfLDqm0HLMELU1Gtky7cJTdCYUBBWQjvR1KMn4AJ/TKP9dUM3IOecbZUxJo+o6I
         7X0tYQjBaBVsdKckpoYVPe1LMEhHeaPIfXiXS9TPH7HQxsX9s20bXniC5cp9lMpNKprc
         zOdA==
X-Gm-Message-State: ANoB5pmBUZjVSTYCvL4qePWWtGOdkwb+e7gJf+Xw82YPDGrjLVvOzbHb
        ID/gW/n0SL7ZE9nGIdUyzft07Gf48vI8/VujPvPBf6uA5p9XigMKB/mmUkdaXvMY+aDCFznGw3U
        hi3E05q7P41ZmfVSs92kUk1nK
X-Received: by 2002:ac8:5511:0:b0:3a5:ae62:7b5a with SMTP id j17-20020ac85511000000b003a5ae627b5amr54714914qtq.595.1669750543739;
        Tue, 29 Nov 2022 11:35:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7OLspeAz8TgknZG0PdWjf/lNlOIdFM+L3EuhSvYh9tGOcnnSYMMTA7F6avxTBtXfjUbDS3oA==
X-Received: by 2002:ac8:5511:0:b0:3a5:ae62:7b5a with SMTP id j17-20020ac85511000000b003a5ae627b5amr54714888qtq.595.1669750543457;
        Tue, 29 Nov 2022 11:35:43 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006fa16fe93bbsm11313013qkp.15.2022.11.29.11.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 11:35:43 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 09/10] mm/hugetlb: Make page_vma_mapped_walk() safe to pmd unshare
Date:   Tue, 29 Nov 2022 14:35:25 -0500
Message-Id: <20221129193526.3588187-10-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221129193526.3588187-1-peterx@redhat.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since page_vma_mapped_walk() walks the pgtable, it needs the vma lock
to make sure the pgtable page will not be freed concurrently.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/rmap.h | 4 ++++
 mm/page_vma_mapped.c | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index bd3504d11b15..a50d18bb86aa 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -13,6 +13,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/memremap.h>
+#include <linux/hugetlb.h>
 
 /*
  * The anon_vma heads a list of private "related" vmas, to scan if
@@ -408,6 +409,9 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
 		pte_unmap(pvmw->pte);
 	if (pvmw->ptl)
 		spin_unlock(pvmw->ptl);
+	/* This needs to be after unlock of the spinlock */
+	if (is_vm_hugetlb_page(pvmw->vma))
+		hugetlb_vma_unlock_read(pvmw->vma);
 }
 
 bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 93e13fc17d3c..f94ec78b54ff 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -169,10 +169,13 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		if (pvmw->pte)
 			return not_found(pvmw);
 
+		hugetlb_vma_lock_read(vma);
 		/* when pud is not present, pte will be NULL */
 		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
-		if (!pvmw->pte)
+		if (!pvmw->pte) {
+			hugetlb_vma_unlock_read(vma);
 			return false;
+		}
 
 		pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
 		if (!check_pte(pvmw))
-- 
2.37.3

