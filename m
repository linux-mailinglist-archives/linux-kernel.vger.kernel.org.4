Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B21E607C88
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiJUQlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiJUQjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:39:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B71328B1B2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f9-20020a25b089000000b006be298e2a8dso3756312ybj.20
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aZtBH3hoHoyLKHZRtw1whotmEhRsDJhNWbtzAg1Amnw=;
        b=hgVq1BGI9uAPQNPd5svcoZ0uICUDeObQg8sjHrHyUINwI5zeVQNqGOHjoo/I6apJKi
         k/JHaeZ4Yl0qrBsh6RDFwRouNrgEUvtGuCUfpRfpfN4sO+Xf2T8PiR1oaMkO0yS/UNTz
         23yBS9W01SZ1r6pO17zULLRSmQAG2HfnAL6Oj1CQ5zD5aGiHW6MLxM2mYGGk74xNkJVY
         PqQQmAGOeK1qbySxR4UJaQgs9hCNXsrXirmumCJnGX6I+NXqom+pwXFznBlBrvL3S+zD
         jT93upMwLSjpb8myFKnMEGe3Y5MDjPbD5ykOxmhldKIp5uvY/jR4K4NRBGpRWxnp01tl
         jMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZtBH3hoHoyLKHZRtw1whotmEhRsDJhNWbtzAg1Amnw=;
        b=0tAWEkzxssSMde6OIaUykJVpz1t9uMOAg0ko8Ek2ZJC+MbQFrQVv0LkR8Dyd61WANH
         R5XEs6+XfUgtI+G9sNaBA4rps00+HiQN0H0UlUeGApVyuF45BB2+RHetlPamUS/HSId2
         GozY6Kvon5LWTAIQrmY9rf6VJTGRlxE5Af47M8RSmXCGGBRBG/5ieKnimCrJRoE/NhKO
         X8ufjwbAxZNm0p8gQSheKWKTrSoqeHSEOO52ckioy5WpER+AFcSbFRw2i/uWeLueaLHZ
         aoDyarFRvnOYWO80CDQLjLiTq6EfThB/OwbzBqNB1okzD3WdJc1LStLh0+e6HIhrMb4W
         vpwA==
X-Gm-Message-State: ACrzQf0QSXuZYp0CkXO6A9MW3UsEpDkkZo+ruqUOo23xJ83qGX3JKedu
        dfoP0+/tT1vbzk8Qo75IE60xvREDpAoHznwC
X-Google-Smtp-Source: AMsMyM4WUFFcbz+a39rMX4Pd0dvJkqMzPaAe4hK5UbBTGwsMnH/jSNJj+49mYcOwtGDlZYF7vGruuaB3FpImvesN
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:1083:b0:6c0:7c4f:f093 with
 SMTP id v3-20020a056902108300b006c07c4ff093mr17523772ybu.25.1666370273909;
 Fri, 21 Oct 2022 09:37:53 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:56 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-41-jthoughton@google.com>
Subject: [RFC PATCH v2 40/47] hugetlb: x86: enable high-granularity mapping
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

Now that HGM is fully supported for GENERAL_HUGETLB, x86 can enable it.
The x86 KVM MMU already properly handles HugeTLB HGM pages (it does a
page table walk to determine which size to use in the second-stage page
table instead of, for example, checking vma_mmu_pagesize, like arm64
does).

We could also enable HugeTLB HGM for arm (32-bit) at this point, as it
also uses GENERAL_HUGETLB and I don't see anything else that is needed
for it. However, I haven't tested on arm at all, so I won't enable it.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6d1879ef933a..6d7103266e61 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -124,6 +124,7 @@ config X86
 	select ARCH_WANT_GENERAL_HUGETLB
 	select ARCH_WANT_HUGE_PMD_SHARE
 	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP	if X86_64
+	select ARCH_WANT_HUGETLB_HIGH_GRANULARITY_MAPPING
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
-- 
2.38.0.135.g90850a2211-goog

