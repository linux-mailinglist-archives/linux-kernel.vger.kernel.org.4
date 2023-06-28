Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6A8741B35
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjF1VyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjF1VyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47E61FFB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687989197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3NUxws11iZimZs89ga1+mchuciCcK5t8cj7qgaLP/g=;
        b=OEl983S61xAqUc7taiXElasALKboGk6fgtZlBFgUd3JbyO63frx7h8JFAIq9/CMAz5m3Kd
        p6gr7hj052LFA+Milgu40T1D1LtvRkcc/GZnl9NwOl0bexv3vNv45p1tVaFCv/09zukdP2
        aNVoUAp2Pqa47jUVLdeeflnZ8lC8zCg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-JOaH0agJOf6-Ev5MPtQW0A-1; Wed, 28 Jun 2023 17:53:16 -0400
X-MC-Unique: JOaH0agJOf6-Ev5MPtQW0A-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62dd79f63e0so60436d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687989195; x=1690581195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3NUxws11iZimZs89ga1+mchuciCcK5t8cj7qgaLP/g=;
        b=KtfDYZi4WJPdTgeral5vIpmT5bcvhfjPh57yKrTRUDfCUY2MeHnlYGdrtM/OGnuhvJ
         /fDaeZWKQkcwcawYT1aF6FgeRb5O+WSDd3VdbLQuqsqOgWuINYxLyVf7GJUoD2bNvL0F
         g04zGBKT7QwQaKGv9nPVD+4Pv/eLPIu9krWLUMkqoSvSalhgYBouT9QpemVTpAPPAcPI
         1NrXMxBJDZ5RMy1QY6C2+0OKM9r47A6N4USodc2c1w3VwZA9U+YEXcIUT8t9gjO7nBlp
         REuAtz9jzoedQH+yRBJCk9jy+cj0cdMtQ2FkxbZ78ywAnxhcNjnSuK8rQ+PPrvyPz5pO
         Ou+w==
X-Gm-Message-State: AC+VfDyueb1hZSCRtAOP/g9plnRY+BjX1WCFtuQhPr7TK8D7rYrgdCZl
        qkQKtRASk85m7RGw6WxU2AlL4qkR2VfR1u0A4xWDT7h3jRruk9Cb0dt0zC9+5Y8DbtwazBZ8iBj
        9nG0Dr/0is829bfVXlIOzJy2t
X-Received: by 2002:a05:6214:f2f:b0:62b:6c6f:b3e3 with SMTP id iw15-20020a0562140f2f00b0062b6c6fb3e3mr45427363qvb.3.1687989195524;
        Wed, 28 Jun 2023 14:53:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6HBU77CP7xJIw4KayPpNq4pGfYosv7bGjCnvBLq1S/WNi+e+thj4Rrto2qPbX4dx7awzouIw==
X-Received: by 2002:a05:6214:f2f:b0:62b:6c6f:b3e3 with SMTP id iw15-20020a0562140f2f00b0062b6c6fb3e3mr45427346qvb.3.1687989195254;
        Wed, 28 Jun 2023 14:53:15 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id p3-20020a0cfac3000000b00631fea4d5bcsm6277797qvo.95.2023.06.28.14.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:53:15 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        James Houghton <jthoughton@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com
Subject: [PATCH v4 2/8] mm/hugetlb: Prepare hugetlb_follow_page_mask() for FOLL_PIN
Date:   Wed, 28 Jun 2023 17:53:04 -0400
Message-ID: <20230628215310.73782-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628215310.73782-1-peterx@redhat.com>
References: <20230628215310.73782-1-peterx@redhat.com>
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

Namely, either the need to CoW due to missing write bit, or proper
unsharing on !AnonExclusive pages over R/O pins to reject the follow page.
That brings this function closer to follow_hugetlb_page().

So we don't care before, and also for now.  But we'll care if we switch
over slow-gup to use hugetlb_follow_page_mask().  We'll also care when to
return -EMLINK properly, as that's the gup internal api to mean "we should
unshare".  Not really needed for follow page path, though.

When at it, switching the try_grab_page() to use WARN_ON_ONCE(), to be
clear that it just should never fail.  When error happens, instead of
setting page==NULL, capture the errno instead.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d04ba5782fdd..4410139cf890 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6462,13 +6462,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	struct page *page = NULL;
 	spinlock_t *ptl;
 	pte_t *pte, entry;
-
-	/*
-	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
-	 * follow_hugetlb_page().
-	 */
-	if (WARN_ON_ONCE(flags & FOLL_PIN))
-		return NULL;
+	int ret;
 
 	hugetlb_vma_lock_read(vma);
 	pte = hugetlb_walk(vma, haddr, huge_page_size(h));
@@ -6478,8 +6472,23 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	ptl = huge_pte_lock(h, mm, pte);
 	entry = huge_ptep_get(pte);
 	if (pte_present(entry)) {
-		page = pte_page(entry) +
-				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
+		page = pte_page(entry);
+
+		if (!huge_pte_write(entry)) {
+			if (flags & FOLL_WRITE) {
+				page = NULL;
+				goto out;
+			}
+
+			if (gup_must_unshare(vma, flags, page)) {
+				/* Tell the caller to do unsharing */
+				page = ERR_PTR(-EMLINK);
+				goto out;
+			}
+		}
+
+		page += ((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
+
 		/*
 		 * Note that page may be a sub-page, and with vmemmap
 		 * optimizations the page struct may be read only.
@@ -6489,8 +6498,10 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 		 * try_grab_page() should always be able to get the page here,
 		 * because we hold the ptl lock and have verified pte_present().
 		 */
-		if (try_grab_page(page, flags)) {
-			page = NULL;
+		ret = try_grab_page(page, flags);
+
+		if (WARN_ON_ONCE(ret)) {
+			page = ERR_PTR(ret);
 			goto out;
 		}
 	}
-- 
2.41.0

