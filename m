Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE176E17EA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjDMXMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDMXMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD91B4EDC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681427489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sPrSeNO5Sj4btD4u1XV4AOohfTbtE2i2MNiZ002Yg6Y=;
        b=TxD/o0u7U68RMOA2/AfI3LifWOajGaY68YTF2MzlsvYbyB6MvURc0mMGIgaNhBTVWw7yJK
        oaPIRPUBZ2hBwduJT8Uy4s+aJ9MOqpiCH010ALqP2eTj7ub5Pwiqgf1Ag2L8wZfS4n9Ahh
        fOVP02A3J0jJUiKvvdEzM9/6jvMFAg8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-EideDlK8PiyjdhCIELtpxA-1; Thu, 13 Apr 2023 19:11:28 -0400
X-MC-Unique: EideDlK8PiyjdhCIELtpxA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-74a25fcda05so96963885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681427487; x=1684019487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPrSeNO5Sj4btD4u1XV4AOohfTbtE2i2MNiZ002Yg6Y=;
        b=ajSe9Jeopvr4p5OhnF1eBu3Gn8Pq+wZJFB0LdqZq3tdXaI1wkDKWkw2T2sfYRJbwER
         MT5h06LcmwR0l9tkGr4/9KYncLr2Da9ynEFpciRMwdKBhkoMDr1dCZKloMI7uP6OGGN8
         161bMOQloJde/2M5IVmgXAFWjgcGYAw+0ClboIyDU7/2Fe9uO0th0wtpiKlD3Zywo8Mu
         m6k0JznqhfphOqmMsl0yLnKAp3p8FO7LRrrMvcFFF9mdwL5EX7Mixrvi/SMk8eZ9oMbB
         bvOS7e48LyYAIU3SM8we9HY2zkgdXZYNV4isMwzWzwFVFhbft0sm9+nA71sCafUWb/Pe
         vPDw==
X-Gm-Message-State: AAQBX9eeYnzBR4RpGvQ3dAeeu+DFqZCTMhMJ/lSJlbV4UnJJp6f6pZ++
        XPUy7MT/Ut0Yg16TMxudZM5d4AGagjttxx9hXZtvA1lHGD9NpfKbMBnSn07AD9UgSQ7QUo3ZdX4
        qlnm/3mlXPN+YmAuNwha0dJRi40e8UfkALLq6oSEtQ+bUh0lPzioDFPDya0QvEXBSfWjgfjQw3m
        NUPHFjCA==
X-Received: by 2002:a05:622a:1aa6:b0:3e2:be32:cb74 with SMTP id s38-20020a05622a1aa600b003e2be32cb74mr1006409qtc.3.1681427487047;
        Thu, 13 Apr 2023 16:11:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350ay1srzjNEubUa8Bu2M4QrSigXg05em6AqIPROuVf3uz6yCOvlGUBFyb0XrOhaExs1Nao5lxA==
X-Received: by 2002:a05:622a:1aa6:b0:3e2:be32:cb74 with SMTP id s38-20020a05622a1aa600b003e2be32cb74mr1006377qtc.3.1681427486764;
        Thu, 13 Apr 2023 16:11:26 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id g3-20020ac81243000000b003ea1b97acfasm612446qtj.49.2023.04.13.16.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 16:11:25 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-stable <stable@vger.kernel.org>
Subject: [PATCH 2/6] mm/hugetlb: Fix uffd-wp bit lost when unsharing happens
Date:   Thu, 13 Apr 2023 19:11:16 -0400
Message-Id: <20230413231120.544685-3-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230413231120.544685-1-peterx@redhat.com>
References: <20230413231120.544685-1-peterx@redhat.com>
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

When we try to unshare a pinned page for a private hugetlb, uffd-wp bit can
get lost during unsharing.  Fix it by carrying it over.

This should be very rare, only if an unsharing happened on a private
hugetlb page with uffd-wp protected (e.g. in a child which shares the same
page with parent with UFFD_FEATURE_EVENT_FORK enabled).

Cc: linux-stable <stable@vger.kernel.org>
Fixes: 166f3ecc0daf ("mm/hugetlb: hook page faults for uffd write protection")
Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7320e64aacc6..083aae35bff8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5637,13 +5637,16 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	spin_lock(ptl);
 	ptep = hugetlb_walk(vma, haddr, huge_page_size(h));
 	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
+		pte_t newpte = make_huge_pte(vma, &new_folio->page, !unshare);
+
 		/* Break COW or unshare */
 		huge_ptep_clear_flush(vma, haddr, ptep);
 		mmu_notifier_invalidate_range(mm, range.start, range.end);
 		page_remove_rmap(old_page, vma, true);
 		hugepage_add_new_anon_rmap(new_folio, vma, haddr);
-		set_huge_pte_at(mm, haddr, ptep,
-				make_huge_pte(vma, &new_folio->page, !unshare));
+		if (huge_pte_uffd_wp(pte))
+			newpte = huge_pte_mkuffd_wp(newpte);
+		set_huge_pte_at(mm, haddr, ptep, newpte);
 		folio_set_hugetlb_migratable(new_folio);
 		/* Make the old page be freed below */
 		new_folio = page_folio(old_page);
-- 
2.39.1

