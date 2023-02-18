Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5276C69B6BD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBRA24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjBRA2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:28:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA8A5A3AD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l206-20020a25ccd7000000b006fdc6aaec4fso2656471ybf.20
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDdwvW86Qv3EMGRuKtmhHN/6JFPd8EDP9/1ArRwRYXY=;
        b=fw5qqHMfBDzeIudommkAOwo+9UU/gmxeQgIih9FaoEsaJr2Xir63Ni9u5plph47GPQ
         qKNMSk3EoMZlFvKBixc5SlWffdrOIGT9xwufVeB6w6XtbUefWoHl0UTkSBIeVWA0nx9V
         3vx/k8P3X+Nic17umWBpychYwMRvoLYQTiDpyeEvZuRVuWt8x3OPh+qcKKxIEMfqpB+f
         E4BJn1mxijItNJzVQ7AX794mA3LDFIyPdFN2u6SvQkdpMoHSeet4GeunVcsqyLAUuaFL
         HvKzb76potSZYgInefPIg3oX/vB0taPuTk8WpA+EnFjlSQJ7bSf8eNOYwuT07YyeDAq/
         1HaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDdwvW86Qv3EMGRuKtmhHN/6JFPd8EDP9/1ArRwRYXY=;
        b=rV/Ak7uYg1+nUcXhwhFgwb2O/djGNJvsu5VfW/zyy9GNhI/MF9QwDI11JpTPUBSXA9
         f894AFAWIbiv8UG8ny1I3ULhi0HCESK8GIVpVsUva6LG3Vuau3T0EgbGiJo3Rvk/nrc7
         IhFviLsUwdCa2dtciOCWR2d9mXjqJ64u63kFAokQBBOsUVMsj99Xof3dN9msjNXRZXcz
         BHULRRQoG5XWKeHT+WATlEWisJIN5vSRvGkuYojXrvL4XWdIfyRkKjmOX8Rzv+gS5HmC
         gp4YLuNih5R1o29AfspttvQMZLbC6tMx6a7J0iQLdz0dYr0Kgb3EVa4er02BdLbjgBud
         /6/Q==
X-Gm-Message-State: AO0yUKWlITKU+Uu0KT1F0zlIwMwrhm8rk6luLgvznZreMQk+9UD6AkjI
        eCfUc1sUYup2bm6IYC5YOJ/ZwZZJyVGReTxd
X-Google-Smtp-Source: AK7set+jWNiXveMIuz9URODx+pb4bTot1Uag93kYz1pPcv1KgJFihpEhzSj3o+H8iWxGWVbjL8VHgACEeLjh2Bea
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:4511:0:b0:52f:69d:cc75 with SMTP id
 s17-20020a814511000000b0052f069dcc75mr301138ywa.6.1676680126332; Fri, 17 Feb
 2023 16:28:46 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:36 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-4-jthoughton@google.com>
Subject: [PATCH v2 03/46] hugetlb: remove redundant pte_mkhuge in migration path
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
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
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
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

diff --git a/mm/migrate.c b/mm/migrate.c
index 37865f85df6d..d3964c414010 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -249,7 +249,6 @@ static bool remove_migration_pte(struct folio *folio,
 		if (folio_test_hugetlb(folio)) {
 			unsigned int shift = huge_page_shift(hstate_vma(vma));
 
-			pte = pte_mkhuge(pte);
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
 			if (folio_test_anon(folio))
 				hugepage_add_anon_rmap(new, vma, pvmw.address,
-- 
2.39.2.637.g21b0678d19-goog

