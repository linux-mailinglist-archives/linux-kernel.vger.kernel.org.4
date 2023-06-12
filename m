Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C312472CAFA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjFLQFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjFLQFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:05:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0C0C3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686585867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8Z4sQASkP/QzczZ9MtwSxp/dOU3reXMwaqRjOEgVO0E=;
        b=fAa0wca2RzwAeGROPW96y0FdrfOuNIiMVltD9B7hqY7bT+zT61gP3px4HgT0ViD5F+9m7g
        yIzW6KToMsyMIwNw6JD01xd0I1KX7ghyirAJeRuGujoN30LdTc5m32/EnhGMlTQ/diErXm
        lGGV7RBZoKatiy7HO4S+Kl50swL2NFw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-yLvVi303OHe4cAdU3ZGIaw-1; Mon, 12 Jun 2023 12:04:23 -0400
X-MC-Unique: yLvVi303OHe4cAdU3ZGIaw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75d54053a76so54347685a.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686585862; x=1689177862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Z4sQASkP/QzczZ9MtwSxp/dOU3reXMwaqRjOEgVO0E=;
        b=VJVXpVZXGwxaXuQDHSmSeGHeWw4cK2XIhYUSmG4Zttq9/yp5F1U4nzZW0JnRif6OM3
         sM8ES7hHl8+6OY09MSPfeMPisB53BFJ0JH6wpxQEbAUuie9HpvdcQNDPuDOIOO4+nry1
         9IANgSOGT6aoWJov+9Fdpsp97o6Ktjk616sfEXBNS/d+h17zIT5454152LgcQ1GfISML
         NHtr5I+vwlxzSjxk+Ab2FSTZ8o3HDKu3NBHb5mMKoL+IuqLn59m9rzlmt1I6Gcw6LomP
         cHqGvr/SpWPWwCyekqoKhnER563icPbB+MhU3MWGyaX7L+p7romRGwjNWgq9vK6PKDC8
         8j9Q==
X-Gm-Message-State: AC+VfDx/f+5Io+C3ikr6GDG/U06RJGgP8SvXsx6tnvBLrb2GbjRENCDD
        F/IZZaudLO4v0E1Fr9MVukDltepcjTG5VNuyPr3SrHQ3PrUIHq1riky4sXVHZguhPMe7I/IgYks
        HL/euQyFsk58fpuFQ1zgx2ygi76nQmalV2Xhb2rKNrZrQBbkiX3TR1+4gYo6GhgPtqiqSXlSLuI
        86iiQuoA==
X-Received: by 2002:a05:620a:3c8d:b0:75b:23a1:82a4 with SMTP id tp13-20020a05620a3c8d00b0075b23a182a4mr10269989qkn.5.1686585862464;
        Mon, 12 Jun 2023 09:04:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ43DjOBQqRgF/c9IKJHRBcmjSh7mZCgF+L6b23a4ZBilYEfplQZvNu5fp9TUqJzmsf2MOxD1g==
X-Received: by 2002:a05:620a:3c8d:b0:75b:23a1:82a4 with SMTP id tp13-20020a05620a3c8d00b0075b23a182a4mr10269965qkn.5.1686585862163;
        Mon, 12 Jun 2023 09:04:22 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id p5-20020a05620a112500b0075cd80fde9esm2942730qkk.89.2023.06.12.09.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 09:04:21 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: [PATCH] mm/hugetlb: Fix pgtable lock on pmd sharing
Date:   Mon, 12 Jun 2023 12:04:20 -0400
Message-Id: <20230612160420.809818-1-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
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

Huge pmd sharing operates on PUD not PMD, huge_pte_lock() is not suitable
in this case because it should only work for last level pte changes, while
pmd sharing is always one level higher.

Meanwhile, here we're locking over the spte pgtable lock which is even not
a lock for current mm but someone else's.

It seems even racy on operating on the lock, as after put_page() of the
spte pgtable page logically the page can be released, so at least the
spin_unlock() needs to be done after the put_page().

No report I am aware, I'm not even sure whether it'll just work on taking
the spte pmd lock, because while we're holding i_mmap read lock it probably
means the vma interval tree is frozen, all pte allocators over this pud
entry could always find the specific svma and spte page, so maybe they'll
serialize on this spte page lock?  Even so, doesn't seem to be expected.
It just seems to be an accident of cb900f412154.

Fix it with the proper pud lock (which is the mm's page_table_lock).

Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Fixes: cb900f412154 ("mm, hugetlb: convert hugetlbfs to use split pmd lock")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index dfa412d8cb30..270ec0ecd5a1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7133,7 +7133,6 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	unsigned long saddr;
 	pte_t *spte = NULL;
 	pte_t *pte;
-	spinlock_t *ptl;
 
 	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
@@ -7154,7 +7153,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (!spte)
 		goto out;
 
-	ptl = huge_pte_lock(hstate_vma(vma), mm, spte);
+	spin_lock(&mm->page_table_lock);
 	if (pud_none(*pud)) {
 		pud_populate(mm, pud,
 				(pmd_t *)((unsigned long)spte & PAGE_MASK));
@@ -7162,7 +7161,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 	} else {
 		put_page(virt_to_page(spte));
 	}
-	spin_unlock(ptl);
+	spin_unlock(&mm->page_table_lock);
 out:
 	pte = (pte_t *)pmd_alloc(mm, pud, addr);
 	i_mmap_unlock_read(mapping);
-- 
2.40.1

