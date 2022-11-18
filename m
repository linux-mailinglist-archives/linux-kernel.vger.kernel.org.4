Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FF662EABC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbiKRBLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbiKRBL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:11:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502D47EBF4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668733833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9OM954c43rVIe2ciAr/4Oap5Q/Q5UCXLA+pQIGS7ALA=;
        b=fIMHU/7KojRQNjAMWX66gkpbpNw8nYu3MXsX1AueD22kg6hkJousqWQlc/oN9mX3gCjBGw
        IBGGnO3IVi3v57/4GddAJ6nN9XOdVLBDQLxdv5cMHNRKHX3iXwZSrSqJHM3f6Sihy6gNdk
        +R9Kdh9BqFFzpnU9lT0q8xKzLTA6s9s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-WILyBoSWNLO6KXyuAHx8HA-1; Thu, 17 Nov 2022 20:10:32 -0500
X-MC-Unique: WILyBoSWNLO6KXyuAHx8HA-1
Received: by mail-qt1-f197.google.com with SMTP id fz10-20020a05622a5a8a00b003a4f466998cso3416598qtb.16
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OM954c43rVIe2ciAr/4Oap5Q/Q5UCXLA+pQIGS7ALA=;
        b=1xz3RL4d+zI2B9bSlVNTzFqOA4wssvG2Kgsz3TBiiq+WyOKNt6AcEzFHodiuzJC6E/
         QsYl3+Fsvyvssf4rBlKT5tD+rIPWsfVEYOsJP82AY2ohxFF7rKMVRYKpaYYyJL1Ba9Bc
         NMEB27GEAMBoAc37pl8o9WLcLYagL2RVC1eNDaKHfcZV2cnTs//XrN6aF7PvQCSk98pG
         LhJ0Lp1Bf4ba5l16p8TtDGGN1JwLKqhdeXz9VAr9IGywLS9IpyrzAT/Qnuh/MAXhCnTv
         ZmRk7ZfZAe1xfpAIU2Hd8i2pjCrVOYj+1sJA8ePvILP/3bCy797l7l7XzbEZo6fkPxnu
         WMYw==
X-Gm-Message-State: ANoB5pnlK8aIv9VHSiIMWmw5ygtxgrMSL26sHFP6F/FmTgOtDfugWvn7
        /aEMgvpngn9QJsXWiutngHCPHTbvHHvHVcgx336HmmtIrBsRdlkf7sucgG30oXXjBoqq7IrmZW0
        INk2Uh9NyQdZk+pkd1yN2PhmQ
X-Received: by 2002:a05:620a:260d:b0:6fb:a9af:2238 with SMTP id z13-20020a05620a260d00b006fba9af2238mr4174796qko.457.1668733831792;
        Thu, 17 Nov 2022 17:10:31 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Aqw8l8m4fWogYc3FoWyNkgwxEBla8HpkXPW9zfRaGkpX2OEDEon4bGw7svTSEDlw3e0SH+w==
X-Received: by 2002:a05:620a:260d:b0:6fb:a9af:2238 with SMTP id z13-20020a05620a260d00b006fba9af2238mr4174778qko.457.1668733831551;
        Thu, 17 Nov 2022 17:10:31 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006eed75805a2sm1491342qko.126.2022.11.17.17.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:10:31 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH RFC v2 02/12] mm/hugetlb: Move swap entry handling into vma lock for fault
Date:   Thu, 17 Nov 2022 20:10:15 -0500
Message-Id: <20221118011025.2178986-3-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221118011025.2178986-1-peterx@redhat.com>
References: <20221118011025.2178986-1-peterx@redhat.com>
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

In hugetlb_fault(), there used to have a special path to handle swap entry
at the entrance using huge_pte_offset().  That's unsafe because
huge_pte_offset() for a pmd sharable range can access freed pgtables if
without either the walker lock or vma lock.

Here the simplest solution for making it safe is just to move the swap
handling to be after the vma lock being held.  We may need to take the
fault mutex on either migration or hwpoison entries now (also the vma lock,
but that's really needed), however neither of them is hot path so it should
be fine.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c3aab6d5b7aa..62ff3fc51d4e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5824,22 +5824,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	int need_wait_lock = 0;
 	unsigned long haddr = address & huge_page_mask(h);
 
-	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
-	if (ptep) {
-		/*
-		 * Since we hold no locks, ptep could be stale.  That is
-		 * OK as we are only making decisions based on content and
-		 * not actually modifying content here.
-		 */
-		entry = huge_ptep_get(ptep);
-		if (unlikely(is_hugetlb_entry_migration(entry))) {
-			migration_entry_wait_huge(vma, ptep);
-			return 0;
-		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
-			return VM_FAULT_HWPOISON_LARGE |
-				VM_FAULT_SET_HINDEX(hstate_index(h));
-	}
-
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
 	 * get spurious allocation failures if two CPUs race to instantiate
@@ -5886,8 +5870,14 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * fault, and is_hugetlb_entry_(migration|hwpoisoned) check will
 	 * properly handle it.
 	 */
-	if (!pte_present(entry))
+	if (!pte_present(entry)) {
+		if (unlikely(is_hugetlb_entry_migration(entry)))
+			migration_entry_wait_huge(vma, ptep);
+		else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
+			ret = VM_FAULT_HWPOISON_LARGE |
+			    VM_FAULT_SET_HINDEX(hstate_index(h));
 		goto out_mutex;
+	}
 
 	/*
 	 * If we are going to COW/unshare the mapping later, we examine the
-- 
2.37.3

