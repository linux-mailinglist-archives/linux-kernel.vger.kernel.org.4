Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B52A70B449
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjEVFDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjEVFDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:03:11 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8433E9
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:03:10 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-ba86ea269e0so7904390276.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684731790; x=1687323790;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3t6elq9R4Rh1GonIcnIp9HMVNr0t0fb96tM78h+6lY=;
        b=Kc//GQWtdcYt13ahGjffwsLxy+Q5bVB6WROYwiSc3JojtgWwDe3izjSyHuE6U0IG/O
         5Fry5zLgCWeTO19pC/0eYwlnvGNsyrmto6ZIBbyVNO56nsRvrMOAOUvYspI147xhZOi+
         xqdX2iixj9Eo1KLPuK7IDQx9rj9ZoPh6D5XKx6tya/9I/bhzim+Yk6xTIzKBifA2beI4
         8qMCGwFCGRwoHjLeW/d0tZsZvr4CJThANuX9SXUFpqX1pEid4ilFDqnQwxhHJZTeMBQb
         PwATHquSI9R4s4VAZXrMlE6dKgd4X76gX9zjTUT4KksMHQf4ahMKcn/OqGVTbmF1mVyt
         4G7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684731790; x=1687323790;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3t6elq9R4Rh1GonIcnIp9HMVNr0t0fb96tM78h+6lY=;
        b=IN6gI94sVKJiUeDaC112dAJZ5TO/WkIGwL46DZwmZdrFTSkTu+fufGXiAEXOFKW06g
         VhjUss3ciLF9Y38n+dvjZgRLltne/dGeLO7SUmv8s/xyQk/vwcFMQBT70+Dbxk87gYaV
         AM1J9gm8EL4GofkwVNRV1G8wq5ZU+E/EWdQkSShy8wv+nY0DeYUHnq8XyhB6QJffDeS+
         yTJlr11aGB1dtMKZmvWZikIW5uEJuYPeib/ESWCC0z6yhbhAfzTvfOVh7fEpLDszPObt
         SB4GxVZbOPZkCahO71apgufy6uiBdRIdBRlosUZbC31Qo3toAVmSLjfw9/cjII2r+RE+
         f2SA==
X-Gm-Message-State: AC+VfDyX33BbhhZOChB31JfOJhlTgNQX6RX50bFffpVUrx4WkYsg45ox
        nEEvhoBeY5bFad1pJgsiAnaW3Q==
X-Google-Smtp-Source: ACHHUZ6OdnTYy1GhoQl2g/GfXGTjIkyQzrSYRsCypiToKGf2HILo2risNfGACl3kmPaMyL1d5bYIVQ==
X-Received: by 2002:a25:aaac:0:b0:bab:eb8b:c484 with SMTP id t41-20020a25aaac000000b00babeb8bc484mr2926154ybi.14.1684731789855;
        Sun, 21 May 2023 22:03:09 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e6-20020a25b046000000b00ba73c26f0d6sm1322602ybj.15.2023.05.21.22.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:03:09 -0700 (PDT)
Date:   Sun, 21 May 2023 22:03:06 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 11/31] mm/vmwgfx: simplify pmd & pud mapping dirty helpers
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <cafe6ccf-6fee-999-5e1-7963cd529d9@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wp_clean_pmd_entry() need not check pmd_trans_unstable() or pmd_none(),
wp_clean_pud_entry() need not check pud_trans_unstable() or pud_none():
it's just the ACTION_CONTINUE when trans_huge or devmap that's needed
to prevent splitting, and we're hoping to remove pmd_trans_unstable().
Is that PUD #ifdef necessary?  Maybe some configs are missing a stub.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/mapping_dirty_helpers.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index e1eb33f49059..87b4beeda4fa 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -128,19 +128,11 @@ static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
 {
 	pmd_t pmdval = pmdp_get_lockless(pmd);
 
-	if (!pmd_trans_unstable(&pmdval))
-		return 0;
-
-	if (pmd_none(pmdval)) {
-		walk->action = ACTION_AGAIN;
-		return 0;
-	}
-
-	/* Huge pmd, present or migrated */
-	walk->action = ACTION_CONTINUE;
-	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
+	/* Do not split a huge pmd, present or migrated */
+	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval)) {
 		WARN_ON(pmd_write(pmdval) || pmd_dirty(pmdval));
-
+		walk->action = ACTION_CONTINUE;
+	}
 	return 0;
 }
 
@@ -156,23 +148,15 @@ static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
 static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
 			      struct mm_walk *walk)
 {
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 	pud_t pudval = READ_ONCE(*pud);
 
-	if (!pud_trans_unstable(&pudval))
-		return 0;
-
-	if (pud_none(pudval)) {
-		walk->action = ACTION_AGAIN;
-		return 0;
-	}
-
-#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
-	/* Huge pud */
-	walk->action = ACTION_CONTINUE;
-	if (pud_trans_huge(pudval) || pud_devmap(pudval))
+	/* Do not split a huge pud */
+	if (pud_trans_huge(pudval) || pud_devmap(pudval)) {
 		WARN_ON(pud_write(pudval) || pud_dirty(pudval));
+		walk->action = ACTION_CONTINUE;
+	}
 #endif
-
 	return 0;
 }
 
-- 
2.35.3

