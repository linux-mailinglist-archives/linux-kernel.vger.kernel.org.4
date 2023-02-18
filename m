Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC5F69B6D8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjBRAbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjBRAao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:30:44 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBFE5BDB0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:43 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-53655de27a1so28453887b3.14
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YyhF10hcbQMtiIcRNPe2j9wgCL3nu0mYgfomzauIh1M=;
        b=mdWiwuhXmCO7ZvCnfOzT5kGyeI1B76654OSvGqg0v4SfpBfq8gE8Y2HxCtDlqyAoCe
         RlH3iNC1O3POA4w07JzQSLH9WOuQMtWGYGTcuZDqfaF7LyXaloMakwXqjQejR67+NzLM
         ZSebxnW4BLvieTC+ErPKwo8+NE2d2ITkqYp8qePD98ii1puW00fdoHibbpwmm78EnXnc
         e9mKjUDG0xvqx47GeoE/+zEj2Ty0K8brFhlfqMVjJV2l/MZO0YGU5DUAH3uw/T0E0FYc
         e6nZsvIWbjAB08oOCLK03Uzk6o/Dc+xelLgiCeHsfs3lPkfiBKCFNyXIzhr8GfZEa1Cd
         rW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YyhF10hcbQMtiIcRNPe2j9wgCL3nu0mYgfomzauIh1M=;
        b=ldTZJnUaB9vjveagyNoKM5vwgl2MAh23/erCGa2jZLxRTuWUtZIZAZJ/Yw+7oA2Wq5
         vQIfUkBpg2CT3xPQsJomH8uJZIEmI4nAw9FRI8vKGHXzTNP0H11uiniSbmHI8O/wf6Hx
         ypMwPIdAQ8vB/YFN8ac9m357B71xxCoJxkc2rGC/uzvNiq/dMtyAKPWM0JhwLlLoecEF
         +rYz5fzdhZ+qi78ddrqW7DsRyw5F1re3ZpWDF6GfYMSjV+0eaDU1ihBECmY2fzilr60T
         JSQYMTTiQJa1BYxIy+h3NFcHH6pNrqSzdbX+h198sn3GZhNsbBMJd8ZF15fYxnkaNIHj
         2diQ==
X-Gm-Message-State: AO0yUKX4Yt//dgMwaoDJjkyVOFg0of0EPrlLBHMTjA5znVF8LSgevKft
        ATzq4Stpg8E/1bWZNxREnyiUJPp8tTSluhdh
X-Google-Smtp-Source: AK7set887EplN25RNMt2wpSeZlZy1r4wkCtXdk+wH3AhIORU9/UsNcsfMi31QN73nnyYQPAtcJJOO2NybrEvv00c
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:3:b0:90d:af77:9ca6 with SMTP
 id l3-20020a056902000300b0090daf779ca6mr34196ybh.7.1676680163234; Fri, 17 Feb
 2023 16:29:23 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:12 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-40-jthoughton@google.com>
Subject: [PATCH v2 39/46] hugetlb: x86: enable high-granularity mapping for x86_64
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

Now that HGM is fully supported for GENERAL_HUGETLB, we can enable it
for x86_64. We can only enable it for 64-bit architectures because the
vm flag VM_HUGETLB_HGM uses a high bit.

The x86 KVM MMU already properly handles HugeTLB HGM pages (it does a
page table walk to determine which size to use in the second-stage page
table instead of, for example, checking vma_mmu_pagesize, like arm64
does).

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074a878b..fde9ba1dd8d7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -126,6 +126,7 @@ config X86
 	select ARCH_WANT_GENERAL_HUGETLB
 	select ARCH_WANT_HUGE_PMD_SHARE
 	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP	if X86_64
+	select ARCH_WANT_HUGETLB_HIGH_GRANULARITY_MAPPING if X86_64
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
-- 
2.39.2.637.g21b0678d19-goog

