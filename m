Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E109B73BA2F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjFWOap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjFWOab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6352107
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687530584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gk9nBOPG6j2+jM6FIDDaVYVwIkM1l3Tetg7sVWCV7Y=;
        b=Jf8/Z7rHZW705xb9nyY9kqDdJpAThcdqQgE+RkUFRniv6/HBnnArSpyZjUUkEVK0AFySF5
        TzS2g2TU3LzRo+o+2kBNNoyA9CQ3gynCvi8O5bIJl/eicQM/87YRDSN1gw6/SpBID3QzSg
        sQ8HU/D8WsVxurYbjDEXg9lM/QwwV/c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-cdKQw0Q7P_Sop92j7zu6yA-1; Fri, 23 Jun 2023 10:29:43 -0400
X-MC-Unique: cdKQw0Q7P_Sop92j7zu6yA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62ffa1214edso1381436d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530582; x=1690122582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gk9nBOPG6j2+jM6FIDDaVYVwIkM1l3Tetg7sVWCV7Y=;
        b=kwb0Tm/G35J145/5w+eB9xjyQXc3PbNgbXdO5Bp97s9mhdxDycAgCJ57M2fZgNts0c
         tVGtHep1N3TWcQ8jqbigkbIsFLZaVKnpmUkhPv+7W4nzUand12OjGjuEUDRj/6Ymfyza
         p5Vu94neY/OuZAdTE9S+Rmq+SNILwAt6L5qy3OF5j/b9t6vC96+76iwbf7ILPMAGVc5l
         hiGjVfi1m9qo5EaPFzdKvVfHwwbolyEx0GlBhf/waICotQa8BrdMXnemoahg9K2JiHSF
         +KJLVDVmvX+DgR9Kw+iS6glWPjvRmFItvF9JkOWxsg7WDw+9tJ9u+TbfcE1TZtWNm+PA
         BKbw==
X-Gm-Message-State: AC+VfDyJIIMMTQrRCF5AoCdXJnIhZhWczFyUSi1i/z7oL/qawpYSrhFw
        xbsHukbL04R7ccYI6B3KSUOf052xLTvFHabtwNq7ndfY26hG514/axWOE9PuPBMY2iNQhyfWxSH
        tU4biEsQNPJ5kBMLXHwIuBINN
X-Received: by 2002:a05:6214:27eb:b0:616:870c:96b8 with SMTP id jt11-20020a05621427eb00b00616870c96b8mr25389399qvb.3.1687530582615;
        Fri, 23 Jun 2023 07:29:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6b6BfAOlLY4UY84oPtrElMpGPs2JooejEq2dKySJ7sqg4gO6FWfBJO1DRPK0VM93X3ONSVMg==
X-Received: by 2002:a05:6214:27eb:b0:616:870c:96b8 with SMTP id jt11-20020a05621427eb00b00616870c96b8mr25389388qvb.3.1687530582350;
        Fri, 23 Jun 2023 07:29:42 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id b9-20020a0cc989000000b0062821057ac7sm5104827qvk.39.2023.06.23.07.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:29:41 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 2/8] mm/hugetlb: Prepare hugetlb_follow_page_mask() for FOLL_PIN
Date:   Fri, 23 Jun 2023 10:29:30 -0400
Message-Id: <20230623142936.268456-3-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623142936.268456-1-peterx@redhat.com>
References: <20230623142936.268456-1-peterx@redhat.com>
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f75f5e78ff0b..27367edf5c72 100644
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
@@ -6478,8 +6472,21 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 	ptl = huge_pte_lock(h, mm, pte);
 	entry = huge_ptep_get(pte);
 	if (pte_present(entry)) {
-		page = pte_page(entry) +
-				((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
+		page = pte_page(entry);
+
+		if ((flags & FOLL_WRITE) && !huge_pte_write(entry)) {
+			page = NULL;
+			goto out;
+		}
+
+		if (gup_must_unshare(vma, flags, page)) {
+			/* Tell the caller to do unsharing */
+			page = ERR_PTR(-EMLINK);
+			goto out;
+		}
+
+		page += ((address & ~huge_page_mask(h)) >> PAGE_SHIFT);
+
 		/*
 		 * Note that page may be a sub-page, and with vmemmap
 		 * optimizations the page struct may be read only.
@@ -6489,8 +6496,10 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
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
2.40.1

