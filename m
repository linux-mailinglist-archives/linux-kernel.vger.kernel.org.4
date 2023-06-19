Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A598735FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 01:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjFSXLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 19:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjFSXLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 19:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88164E63
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687216251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AeVTfhKtj8N8KTpZF3pjKuqjoCywpEvllD4d3FaXf9c=;
        b=OryfhD2zLjeRdfhsA7D5vhfYjL/zTiBvNkNWx4WGyaYIP+uDbtO9IGmH+lg+QneuTfCDG2
        YRhG34Kkp1NsEtK7eesfuVPsCkhihho2MBipajLL2VPSyHx7cEjcvsPsF4hQkRaAtK+Bxs
        vM2bVjUF6vcbGPX1Him36EhhXTegn/I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-WID_dHrMP168ottQo23Aaw-1; Mon, 19 Jun 2023 19:10:50 -0400
X-MC-Unique: WID_dHrMP168ottQo23Aaw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76248f3057bso37226485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687216250; x=1689808250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeVTfhKtj8N8KTpZF3pjKuqjoCywpEvllD4d3FaXf9c=;
        b=Cmy9UavqbjDQk5c4XVtrPs3+S5ByiBg6rPIK/fq4KY/wAkdEgQjZCYMPVQjPRgr4/R
         YtcVnosrv/CkDm9/ZuKTgeSGDEPK4+9SSkng4+rWVpdufCtQGp8Kd/iqGOl6fMXXt53w
         O68HbF61aKMrdS0bR0wG+rNSDp5yY9TpWixBA9BRDZFmRyw1h9Q10UV2RcEqJWXSlZvz
         sy4f6iMVpoaJc2bl2oWgseKvFpg8r3qEhIVLbOxQ+fz6HFFx7rQrxEM11RQPsX95+p8m
         JVfXTzwYl2WZ65X513EguqoTSpNTDgKO5Oo83VCKhE/5UnQoMifIQLSxhwFsSfykuz96
         Tewg==
X-Gm-Message-State: AC+VfDwGaCmlKI5ggoRgHoVP6jUFWgbvMf+/mhbN6LC8g8lR+0y3EA+i
        EiGTyZmZjFx/ZK/DZrlNqGOomvWTusLDr3abHoRH829buCmfETgZisisq/8J0Uw23TtJ8aCt+Pb
        lZJUv3YxgMNoIWtu01Vh0Hp5h
X-Received: by 2002:a05:620a:2889:b0:75b:23a1:82a4 with SMTP id j9-20020a05620a288900b0075b23a182a4mr13246239qkp.5.1687216249803;
        Mon, 19 Jun 2023 16:10:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+hV0zbUQ9aN/HCxdwdLyhYSlUogcbP8i7JCZJTHjyygAvLUH/tHfcgC5j3ZztZhUlzdg3lA==
X-Received: by 2002:a05:620a:2889:b0:75b:23a1:82a4 with SMTP id j9-20020a05620a288900b0075b23a182a4mr13246224qkp.5.1687216249526;
        Mon, 19 Jun 2023 16:10:49 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id t15-20020a05620a034f00b007592f2016f4sm405864qkm.110.2023.06.19.16.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 16:10:49 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 2/8] mm/hugetlb: Prepare hugetlb_follow_page_mask() for FOLL_PIN
Date:   Mon, 19 Jun 2023 19:10:38 -0400
Message-Id: <20230619231044.112894-3-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619231044.112894-1-peterx@redhat.com>
References: <20230619231044.112894-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

follow_page() doesn't use FOLL_PIN, meanwhile hugetlb seems to not be the
target of FOLL_WRITE either.  However add the checks.

Namely, either the need to CoW due to missing write bit, or proper CoR on
!AnonExclusive pages over R/O pins to reject the follow page.  That brings
this function closer to follow_hugetlb_page().

So we don't care before, and also for now.  But we'll care if we switch
over slow-gup to use hugetlb_follow_page_mask().  We'll also care when to
return -EMLINK properly, as that's the gup internal api to mean "we should
do CoR".  Not really needed for follow page path, though.

When at it, switching the try_grab_page() to use WARN_ON_ONCE(), to be
clear that it just should never fail.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f75f5e78ff0b..9a6918c4250a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6463,13 +6463,6 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	spinlock_t *ptl;
 	pte_t *pte, entry;
 
-	/*
-	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
-	 * follow_hugetlb_page().
-	 */
-	if (WARN_ON_ONCE(flags & FOLL_PIN))
-		return NULL;
-
 	hugetlb_vma_lock_read(vma);
 	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
 	if (!pte)
@@ -6478,8 +6471,21 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	ptl = huge_pte_lock(h, mm, pte);
 	entry = huge_ptep_get(pte);
 	if (pte_present(entry)) {
-		page = pte_page(entry) +
-				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
+		page = pte_page(entry);
+
+		if (gup_must_unshare(vma, flags, page)) {
+			/* Tell the caller to do Copy-On-Read */
+			page = ERR_PTR(-EMLINK);
+			goto out;
+		}
+
+		if ((flags & FOLL_WRITE) && !pte_write(entry)) {
+			page = NULL;
+			goto out;
+		}
+
+		page += ((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
+
 		/*
 		 * Note that page may be a sub-page, and with vmemmap
 		 * optimizations the page struct may be read only.
-- 
2.40.1

