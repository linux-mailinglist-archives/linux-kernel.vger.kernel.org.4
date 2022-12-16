Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB6364EE45
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiLPPyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiLPPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:53:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47D76F0C2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671205949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rIRGvziR/92Z54UoPp5pwcNYu+IBI1cm3v25qmGTr7U=;
        b=HOjjp+kqXAbRlmu+PzSl07pk/lyPcxklwi4UAsoNTmQ0OfY0bCY3t7y9HtM6PykFfgV3e+
        H41/7KK8dZ7knL/ZMvEOG2a8rknPdfcNZFsG7ciXVjk2tawYAqdTEB42jVIgmSSw6RpHsd
        hjoHuVfKpA7cEvdGFpI1o1DrZVlnItU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-4vPy465zNb-doL3sbTb1YA-1; Fri, 16 Dec 2022 10:52:28 -0500
X-MC-Unique: 4vPy465zNb-doL3sbTb1YA-1
Received: by mail-qk1-f200.google.com with SMTP id h13-20020a05620a244d00b006fb713618b8so2133899qkn.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:52:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIRGvziR/92Z54UoPp5pwcNYu+IBI1cm3v25qmGTr7U=;
        b=rLf+TmgFIKV6Jl5aQSXVf+k3E9fav2wd9aATqnhGyJD6X9FWZIhMTkzr641DtGqwDP
         /WxrrWb+u5XDEk5qo2DnqcmVPQJmHsQguJAnq02U0zPmEeFpt+iGcQSTtdasQdNl2pAq
         5FdTvfYHEnvtdnTpktgwwdc798RqC5yBi5yl+4V28XnMMm4O6vhduRTMhff5TzsftwnX
         NfgcOiYaaM0OpoUiur0dqnQgO5ssvGrfPUTSxTrTRpXK0BWjrJMSr6qfW6TQnU+kHYoW
         SpcFWq+49KEdLd8w2Pz2kXmxYZu+92ebExXBLKNnGI+TqNzKy8ElLSDA1Q8Nww2rsPLx
         a1+A==
X-Gm-Message-State: ANoB5pn+l/HdWTyAgzhupw65vW4YTqx/ptXTVjzu06flVxlAwHXBMkfT
        i6b3eaqzZD4pVTd5Pb12/xjjmGX1MN649Ikj+YJCl8dw6CS4lZiS+B+1EmPOXLTeMSusSGDFm+M
        EWhyKrGBQ/4VuvAD+gSPHn9xduNz2vtvhn+2cwTtQeaF4hhkpeSYg4TG+InI+XMsy8YfLWrmmag
        ==
X-Received: by 2002:ad4:4353:0:b0:4e8:c749:7f3a with SMTP id q19-20020ad44353000000b004e8c7497f3amr20525145qvs.50.1671205946817;
        Fri, 16 Dec 2022 07:52:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4PGgI1eYNhoIKqqtlFBB21vIxd73/3ENYwzCz1J5KG++K1lTB3/aO/vYUZa2W/DRv/E7u/0g==
X-Received: by 2002:ad4:4353:0:b0:4e8:c749:7f3a with SMTP id q19-20020ad44353000000b004e8c7497f3amr20525095qvs.50.1671205946508;
        Fri, 16 Dec 2022 07:52:26 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id d136-20020ae9ef8e000000b006fef157c8aesm1673097qkg.36.2022.12.16.07.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:52:25 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>, peterx@redhat.com,
        Miaohe Lin <linmiaohe@huawei.com>,
        Jann Horn <jannh@google.com>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 7/9] mm/hugetlb: Make follow_hugetlb_page() safe to pmd unshare
Date:   Fri, 16 Dec 2022 10:52:23 -0500
Message-Id: <20221216155223.2043727-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221216155100.2043537-1-peterx@redhat.com>
References: <20221216155100.2043537-1-peterx@redhat.com>
MIME-Version: 1.0
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

Since follow_hugetlb_page() walks the pgtable, it needs the vma lock
to make sure the pgtable page will not be freed concurrently.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0bf0abea388d..33fe73e1e589 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6433,6 +6433,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			break;
 		}
 
+		hugetlb_vma_lock_read(vma);
 		/*
 		 * Some archs (sparc64, sh*) have multiple pte_ts to
 		 * each hugepage.  We have to make sure we get the
@@ -6457,6 +6458,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		    !hugetlbfs_pagecache_present(h, vma, vaddr)) {
 			if (pte)
 				spin_unlock(ptl);
+			hugetlb_vma_unlock_read(vma);
 			remainder = 0;
 			break;
 		}
@@ -6478,6 +6480,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 
 			if (pte)
 				spin_unlock(ptl);
+			hugetlb_vma_unlock_read(vma);
+
 			if (flags & FOLL_WRITE)
 				fault_flags |= FAULT_FLAG_WRITE;
 			else if (unshare)
@@ -6540,6 +6544,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			remainder -= pages_per_huge_page(h);
 			i += pages_per_huge_page(h);
 			spin_unlock(ptl);
+			hugetlb_vma_unlock_read(vma);
 			continue;
 		}
 
@@ -6569,6 +6574,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			if (WARN_ON_ONCE(!try_grab_folio(pages[i], refs,
 							 flags))) {
 				spin_unlock(ptl);
+				hugetlb_vma_unlock_read(vma);
 				remainder = 0;
 				err = -ENOMEM;
 				break;
@@ -6580,6 +6586,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		i += refs;
 
 		spin_unlock(ptl);
+		hugetlb_vma_unlock_read(vma);
 	}
 	*nr_pages = remainder;
 	/*
-- 
2.37.3

