Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C066D82D6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbjDEQDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbjDEQDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8995FCF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680710569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=haUnYelB5LusrEoBxVPl4UNNfNfVynWBkPKVNWIDj2U=;
        b=Syajd34ab0PjiryPvfcj4ZKv3oHUu7PpgOTG6agSHWbMIlKn/u9uR3pn51uA8hdP6cHdS8
        xq7xcaa3yPxJ9TCWPP0eE7OFytGHvJr9zzhgxWjg6LeKD62E/hpmSLziEN+9hJwiEn+kQG
        22+bD8NvmEZKD26s+2otOPhngbeFWyU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-_hSYB7tFOaKls9fUcmn9jQ-1; Wed, 05 Apr 2023 12:02:42 -0400
X-MC-Unique: _hSYB7tFOaKls9fUcmn9jQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1837C1C02D3D;
        Wed,  5 Apr 2023 16:02:42 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.195.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AEDF492C14;
        Wed,  5 Apr 2023 16:02:40 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v2 2/2] mm/userfaultfd: don't consider uffd-wp bit of writable migration entries
Date:   Wed,  5 Apr 2023 18:02:36 +0200
Message-Id: <20230405160236.587705-3-david@redhat.com>
In-Reply-To: <20230405160236.587705-1-david@redhat.com>
References: <20230405160236.587705-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we end up with a writable migration entry that has the uffd-wp bit set,
we already messed up: the source PTE/PMD was writable, which means we could
have modified the page without notifying uffd first. Setting the uffd-wp
bit always implies converting migration entries to !writable migration
entries.

Commit 8f34f1eac382 ("mm/userfaultfd: fix uffd-wp special cases for
fork()") documents that "3. Forget to carry over uffd-wp bit for a write
migration huge pmd entry", but it doesn't really say why that should be
relevant.

So let's remove that code to avoid hiding an eventual underlying issue
(in the future, we might want to warn when creating writable migration
 entries that have the uffd-wp bit set -- or even better when turning a
 PTE writable that still has the uffd-wp bit set).

This now matches the handling for hugetlb migration entries in
hugetlb_change_protection().

In copy_huge_pmd()/copy_nonpresent_pte()/copy_hugetlb_page_range(), we
still transfer the uffd-bit also for writable migration entries, but simply
because we have unified handling for "writable" and "readable-exclusive"
migration entries, and we care about transferring the uffd-wp bit for
the latter.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 2 --
 mm/mprotect.c    | 2 --
 2 files changed, 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e3706a2b34b2..fffc953fa6ea 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1853,8 +1853,6 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			newpmd = swp_entry_to_pmd(entry);
 			if (pmd_swp_soft_dirty(*pmd))
 				newpmd = pmd_swp_mksoft_dirty(newpmd);
-			if (pmd_swp_uffd_wp(*pmd))
-				newpmd = pmd_swp_mkuffd_wp(newpmd);
 		} else {
 			newpmd = *pmd;
 		}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 13e84d8c0797..e04e9ea62ae7 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -223,8 +223,6 @@ static long change_pte_range(struct mmu_gather *tlb,
 				newpte = swp_entry_to_pte(entry);
 				if (pte_swp_soft_dirty(oldpte))
 					newpte = pte_swp_mksoft_dirty(newpte);
-				if (pte_swp_uffd_wp(oldpte))
-					newpte = pte_swp_mkuffd_wp(newpte);
 			} else if (is_writable_device_private_entry(entry)) {
 				/*
 				 * We do not preserve soft-dirtiness. See
-- 
2.39.2

