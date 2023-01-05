Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02EA65E8C5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjAEKTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjAEKTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:19:01 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13ED395E1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:18:56 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v13-20020a25ab8d000000b007b54623bf71so1083316ybi.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6/ywzp+1XO7/Q8q0gmg2VRvRHujBF/Iur/xAcCpSChk=;
        b=pqyC2KhnurZ2BnxaxGpvFtfxzpkkxexWo/NsKpGJkrtsdVnOn9JsTznF5L8T10dpT9
         AAb47kUzRLKe5zL54ZIpCmLTz4iG0qnBDPnnSJAcX0pnE6+rQ5/lLGGtdmK63OoTnblo
         GF3eU42h4BBDQ+ilspuDnsLoOBvix+ESeq+eoZdNGcZsD8QY/hbtyL1dR+g501YZ67Fz
         z9RZ/NbRSQRm1YcmxGoEQ2uIv7H63+AOQO1vX0XPbnZjLlUJSXkLGIr1Ih39qo/E4CRT
         MtdnGWeT9yFYs2+Gmn78g91Y+8+cLHMNidVLgMRBi0PWC2oIxVrguFCrpF8qXSNrN1Aj
         N+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/ywzp+1XO7/Q8q0gmg2VRvRHujBF/Iur/xAcCpSChk=;
        b=k+wtV9f+Vo4yo2iwVPRg+YPf676NVMWbA/bz6f3ErzkMph4NsLxQrWvbDeBYWWN6Y/
         UY5xPGHsZ8l7b6qCu7xUeiQOeUqvGmaRJrrijStmhnR6XAOXM5Le5yanImtCvWo5RH+9
         2Y1SpgfVgnwNdgZTy3mu2IADGyPoQrYBwGecQgqGTEs9JgwC6xNHOEn3H6xcLYlVGr5I
         3OPG1Ud6VMp7dWpsM+Vw9sDFyvNm1yHkhxWJOqsO6cf4Z7+foE1Qj8fR7dUdXdSxHMj8
         w/kEsNAoxxyfc1BUz5OGPgQF+hrFfR51O1pCDz+J7WtXk13yY4Qk0/7U5uc8M1Ai7NPL
         0qxQ==
X-Gm-Message-State: AFqh2kpoL9USd/E7MiNSDC9LGdbGJiHGo1yZI3zOl1WOKfQRY9B9rtIK
        g3ONhuu5lwNuZz6Jvb3/slroZuR0Lz3eLaTF
X-Google-Smtp-Source: AMrXdXttj0DV8I+dROfy27Xg3A4VmdnnuZWQjLlZFwNJGVFmulN/HFoUXOpheTies8pt4M5XCaM5PllEMoSoJYup
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:bc8c:0:b0:79c:8a57:64ed with SMTP
 id e12-20020a25bc8c000000b0079c8a5764edmr1722191ybk.16.1672913935908; Thu, 05
 Jan 2023 02:18:55 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:01 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-4-jthoughton@google.com>
Subject: [PATCH 03/46] hugetlb: remove redundant pte_mkhuge in migration path
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

Acked-by: Peter Xu <peterx@redhat.com>
Acked-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/migrate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 494b3753fda9..b5032c3e940a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -246,7 +246,6 @@ static bool remove_migration_pte(struct folio *folio,
 		if (folio_test_hugetlb(folio)) {
 			unsigned int shift = huge_page_shift(hstate_vma(vma));
 
-			pte = pte_mkhuge(pte);
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
 			if (folio_test_anon(folio))
 				hugepage_add_anon_rmap(new, vma, pvmw.address,
-- 
2.39.0.314.g84b9a713c41-goog

