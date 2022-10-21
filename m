Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C34C607C62
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiJUQhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiJUQhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:37:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2A124BAA4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:19 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-360a7ff46c3so34028667b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZUN9P7JGIQHPnquxx9reV3Jbe3B3qBfX9sZ+LRQm7o=;
        b=GJoNeaGDjwD1Fl1cyhHuK2aLhzkgPOKG7HEw7TkRJFgoz4poH2nLCE3sHMXaMDFunc
         w58AGv5zD/ndOCN5807bGBahVC5t3I4qD5n2viZgEwpgYmeuPO+w8ZUmQC0tetwyZma6
         tnt+SbOGRucmBwJ4t0wW+XGY70fiV6i1Si6lkcLf27swVkRoOYIPAlkG/JqDsto1XLnY
         Mc9LriuigNU7e6Dt/Y1OKV5sJg/o96ytQuNXvUjynTNWGnVUG1Ap7CSa0NXR3xqkTQw9
         i4dLRfrG2R7TcYitFjvdRgvivePstzTsFNXsq03qGK/00RpCzirkjyJ+wubBLyXDN6fR
         YW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZUN9P7JGIQHPnquxx9reV3Jbe3B3qBfX9sZ+LRQm7o=;
        b=o+R0WxT/8v31c9BMStrefNo+ZArjhbmQ+GQcbufIecRYK4F2K3WpYs8Rfcwe3lncEI
         VTiuSY2acelWLxlJBN1P+lcgmQjffkI9jU6Ab5wAAsP/C5ge92QIKZ9+ebUrOn6aMHrY
         7G3lv7akc5Nh2WqJe8GNPYMlnh2708AIiJRNbv9HebMbsZYAnnEFgYqttaOLr3ssrCgi
         dASpOm4pu3o1Ak6lMTSMgX+Qvy8HDdwVs1bKUSHxK9shCSiiaqLVfwcwyEAa6HHGf7Pe
         Yc/b3vf/hlyhHdta13ya+FHBIN5EQau6U0O/aSIinDE9t/yErm3tLFNZDDUe/C40lqwQ
         vDmg==
X-Gm-Message-State: ACrzQf0Ck/kZnuaaV0oW8Z7vrvcLK1a8xtom9wvzx5NMO+1lHvhCDpvA
        jhdGEMQsxifyYqsNdgzv6UNswLGcVk7Vxnot
X-Google-Smtp-Source: AMsMyM6glgNF0xzBVlnv9CGZLhulgQ4Bomw5BBvj+Pqsya/BXuBbeRDw2FnYNlQBJbKk9FqkELlNYTzbRdED6jS4
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:383:0:b0:350:9b62:60bc with SMTP id
 125-20020a810383000000b003509b6260bcmr17608845ywd.514.1666370238413; Fri, 21
 Oct 2022 09:37:18 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:19 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-4-jthoughton@google.com>
Subject: [RFC PATCH v2 03/47] hugetlb: remove redundant pte_mkhuge in
 migration path
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_make_huge_pte, which is called immediately following pte_mkhuge,
already makes the necessary changes to the PTE that pte_mkhuge would
have. The generic implementation of arch_make_huge_pte simply calls
pte_mkhuge.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/migrate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 8e5eb6ed9da2..1457cdbb7828 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -237,7 +237,6 @@ static bool remove_migration_pte(struct folio *folio,
 		if (folio_test_hugetlb(folio)) {
 			unsigned int shift = huge_page_shift(hstate_vma(vma));
 
-			pte = pte_mkhuge(pte);
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
 			if (folio_test_anon(folio))
 				hugepage_add_anon_rmap(new, vma, pvmw.address,
-- 
2.38.0.135.g90850a2211-goog

