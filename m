Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB0565E8F1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjAEKXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjAEKVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:21:50 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0924C559FF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:52 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-45c1b233dd7so377526717b3.20
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ebd8Vu/XVboNQYDKBTu4hK6f3y9obuZPyqPY5k+Gudc=;
        b=I6ayK2fjeeV6XAYAV3ZhwaEnnQoYUdQNqveqXyF5ggg1QXVgf5LPqhurqUyX4Sg8HO
         s6F9jORt3w8TrKLgQbE9o/ipsILjWJVWxOlolxXAYaC7l1LUJTPuzmnYXb8M/6TAOgE6
         iV4jd4Plk12mL7A8sfE6TF+7lw9HKJSmcmSdh24PWpxCGN5c8WUgHm+WCIlfPdcQb8Va
         oaa3biXUtYUW2lT6cUJ+TJCPkPPPYnk+RY3IQZ7J1RSQZAg/BMdpqELg44GmDZbqhD/+
         kIK71fstpMvWu1m6mR114A35MUphScUHv/CK8JATL1Z7Dr//wEo/gsARlq+dXyJGqPZ3
         FyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebd8Vu/XVboNQYDKBTu4hK6f3y9obuZPyqPY5k+Gudc=;
        b=l3QEQnfbLZIhrBeIPKwd5JBPSmYWi/PpvsT87VR/6ahjoOcjnJPCI1cqs+ww7HLVAS
         3oJyLhlUvWqqAtoulhXWtCIX5AvgYmZdSWkOaITaWUI2p0IXVXvkxRNF51VD0e0UPoR2
         sTIslCTqodunu1zMg08/X8v6fLB+MQYXP19V+rtBhF2HqXwWH7CqCsPCsjUEHwXR+ou8
         TdGeGvvqqg0zjKq3vRvSK23hPvg0ne3LMECKBwm2dTNUQYDdksiuEfhZP5azeOrvhS9i
         LAN4Z0+5+kcdUqS0d64s0XtJlIVdz/JoqwK8OowGHKksWSa8H+Knd4mPQslhbFYZPah1
         8ZGw==
X-Gm-Message-State: AFqh2kppfkQxpLcC5D67Fy7GE3bYkaATXRjkpemiAYPmJ+vUaX8pc5Eo
        Fh2wNOl3eGRVn/1lWZ5iKr1zeoV0I1i5ZxGH
X-Google-Smtp-Source: AMrXdXtV4+6oO1J8uKzAHBFEmMr5riCkeBCaO8d3MxL5klPMuG1OvNmF2A8uHxD11fFnV9fuWT3AXj8ucCtp8clM
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:690c:c81:b0:48c:9ce1:9ac8 with SMTP
 id cm1-20020a05690c0c8100b0048c9ce19ac8mr2452166ywb.305.1672913991340; Thu,
 05 Jan 2023 02:19:51 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:37 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-40-jthoughton@google.com>
Subject: [PATCH 39/46] hugetlb: x86: enable high-granularity mapping
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
index 3604074a878b..3d08cd45549c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -126,6 +126,7 @@ config X86
 	select ARCH_WANT_GENERAL_HUGETLB
 	select ARCH_WANT_HUGE_PMD_SHARE
 	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP	if X86_64
+	select ARCH_WANT_HUGETLB_HIGH_GRANULARITY_MAPPING
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
-- 
2.39.0.314.g84b9a713c41-goog

