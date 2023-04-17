Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9BC6E513F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDQTye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjDQTy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FD4E6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681761206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZZajLRXbE1gHSG0/rWcJydl4VAkwntQbZfH27HHj2cI=;
        b=UERaqskK3tXv/LdQiirxN4czmv8yGqF3TI6D2EFVZHjOnUfZqY4oLMb9TYlCkxFVu3B16b
        VvF3rQL4NGcNUE7LvuBbtSlVkQ4+rBVF0tM2RJNxbu12VD7w1pNHqcGEXN4Zs3pwVd3ysi
        n54kKzWAELzAIITExzh8MVQhe3jKEWg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-pYY-GGELN5-Ng1fR-ZQUXQ-1; Mon, 17 Apr 2023 15:53:25 -0400
X-MC-Unique: pYY-GGELN5-Ng1fR-ZQUXQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3ed767b30easo1904911cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681761204; x=1684353204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZajLRXbE1gHSG0/rWcJydl4VAkwntQbZfH27HHj2cI=;
        b=NWBMYm5aHIsxlBp8ondzM8isHbwfygMoEuFJoBCXJIQP5vOamVzxImXe0fNcao6JiO
         eGKycxrGE2h2fWk+M3c9ylu2rpiyHwJZ91b6SkW9gq8raCQmPTRCqtdiHw+QJj5IdomV
         OxRFxkLKmS+FG+4ZdsQcGXWyorEPgm4LYEQuL5oCEpJclMsywLUN1Jm7focSC2Ce75UC
         AjrHvKlIlRICUX9wVf0g1LUVNN3+7vhOy1fQexnKhXhvJnqbEzr96JErqFC35N8tqR15
         Y/pUKByWkQu4aVnSTnS8kM+DKcKrdkX2mSA7lioM4IbZt7PJ3qnP70eMCXlnLzbvWBBr
         lJEw==
X-Gm-Message-State: AAQBX9c8iTF+bYI72lGcMjUHzRN2lLsG0JXx/mU8hWEus9Fza7BrCyAC
        ZUPxJVlevVBC8mOZUQrZ+J3Bt4GhD/aMs9tqnm+kH/GaTZT0KJx80Rdb1zJV0CRj6XXEJ3jYflc
        14REu41e6BbGNqZU0dQURRh7D4LlrO0hxgwwON+no6W8XXRffY+CaRaQre5U5YX2QOUB/rTlLG8
        wTPawbjA==
X-Received: by 2002:a05:622a:1a9b:b0:3ea:ef5:5b8c with SMTP id s27-20020a05622a1a9b00b003ea0ef55b8cmr19155691qtc.3.1681761204345;
        Mon, 17 Apr 2023 12:53:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350aPbpBAnSBo8hIMWFwYiZl6fBgvrueoUnmaQeBSdZmgAZBXgdsikL50SEQY0Q9p7+B82l1+8Q==
X-Received: by 2002:a05:622a:1a9b:b0:3ea:ef5:5b8c with SMTP id s27-20020a05622a1a9b00b003ea0ef55b8cmr19155663qtc.3.1681761204064;
        Mon, 17 Apr 2023 12:53:24 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id r17-20020ac87ef1000000b003edfb5d7637sm1731278qtc.73.2023.04.17.12.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:53:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        linux-stable <stable@vger.kernel.org>
Subject: [PATCH v2 2/6] mm/hugetlb: Fix uffd-wp bit lost when unsharing happens
Date:   Mon, 17 Apr 2023 15:53:13 -0400
Message-Id: <20230417195317.898696-3-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230417195317.898696-1-peterx@redhat.com>
References: <20230417195317.898696-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0213efaf31be..cd3a9d8f4b70 100644
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

