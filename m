Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8EB69B6B8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjBRA3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjBRA2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:28:51 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113A15F252
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:50 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 188-20020a2503c5000000b008e1de4c1e7dso2280796ybd.17
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8nfyEWndKsa3tyc1KlPsVZDyN8xlZ4zW0vpf47Ary0I=;
        b=ghgOaEONmk3TxY7Vbd4llR8C6ZhiH535rAEn2mRoH4sgelGi+DzvBNDNzGInJZzqfs
         MEErbyZH29/h7FEPNCh9VZcW/Bm4YgRch9ir0kS2NDXVsbFg5l6v2m5+GdPoQ68p73Au
         kx7/25Br5F6Yw90cWFqLg3eViGqsOMcWI58kCeCLrtLPN7KaOw1BIGgyIswJlZykM+9O
         0y4w9vz06OJ9NLQ+jIbxIwJsCdh/V36xONqd3gjqH80qszv271zhh3nf8DhiYiNLA2qQ
         k8oLBo0ZQMuPQXPM4GYcllmYMP6s7dZX1ehwhZA1pOfZpnWcQPV0VVxxICdxJelUUbzk
         U9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nfyEWndKsa3tyc1KlPsVZDyN8xlZ4zW0vpf47Ary0I=;
        b=s8B0tOqgX8vcKTYrHBQBdT1oUZ3EGwnGoCLmybxnIwa4n7Zhb0wnkPWZs4vVe2B0gJ
         kdbiuQsNZfeMSJ0ArfCD+JueRq8yUBD8u9NMlLwcWNT0eIisXBIgBmES3kpN2esXL+YA
         6SrUOZjl5lpC8YJnSSx1bZFFIZF+W2ShwhsEDKijLNncYbPwGoNbJFDspUmj/SAyWA3M
         yNTg/5EB7z0+P8kLpx43cd4rNWABw+N75mbKDjtmuBtHxvdEQ71P2ZPsHn8Z3hy2HzA3
         hdk97J1ft/C4wixEyelLJoNx08YOxXYh/6pd3QIm1VeanwuXsH9S93NzmdkdD9g3KTaI
         8FGg==
X-Gm-Message-State: AO0yUKV/ys6LJDzMLR91QYaHn8uzP+tXTKQzI0htQMvqoKsdcwlpkRZo
        QkBnMaFhQTFqRAJc+OOcNK7EAYOfWwsvhVWH
X-Google-Smtp-Source: AK7set+i/pEV+wA/Uyq68EOFTB/N9gXVBIKZiQfbLrFGkhuKCKH/yF+5J8fuZrkmB0Jrum8skN72smbY4sjy/+UA
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:241:b0:8db:41c9:aa6f with SMTP
 id k1-20020a056902024100b008db41c9aa6fmr200113ybs.2.1676680129319; Fri, 17
 Feb 2023 16:28:49 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:27:39 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-7-jthoughton@google.com>
Subject: [PATCH v2 06/46] hugetlb: add CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
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

This adds the Kconfig to enable or disable high-granularity mapping.
Each architecture must explicitly opt-in to it (via
ARCH_WANT_HUGETLB_HIGH_GRANULARITY_MAPPING), but when opted in, HGM will
be enabled by default if HUGETLB_PAGE is enabled.

Signed-off-by: James Houghton <jthoughton@google.com>

diff --git a/fs/Kconfig b/fs/Kconfig
index 2685a4d0d353..a072bbe3439a 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -246,6 +246,18 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+config ARCH_WANT_HUGETLB_HIGH_GRANULARITY_MAPPING
+	bool
+
+config HUGETLB_HIGH_GRANULARITY_MAPPING
+	bool "HugeTLB high-granularity mapping support"
+	default n
+	depends on ARCH_WANT_HUGETLB_HIGH_GRANULARITY_MAPPING
+	help
+	  HugeTLB high-granularity mapping (HGM) allows userspace to issue
+	  UFFDIO_CONTINUE on HugeTLB mappings in PAGE_SIZE chunks.
+	  HGM is incompatible with the HugeTLB Vmemmap Optimization (HVO).
+
 #
 # Select this config option from the architecture Kconfig, if it is preferred
 # to enable the feature of HugeTLB Vmemmap Optimization (HVO).
@@ -257,6 +269,7 @@ config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	def_bool HUGETLB_PAGE
 	depends on ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	depends on SPARSEMEM_VMEMMAP
+	depends on !HUGETLB_HIGH_GRANULARITY_MAPPING
 
 config HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON
 	bool "HugeTLB Vmemmap Optimization (HVO) defaults to on"
-- 
2.39.2.637.g21b0678d19-goog

