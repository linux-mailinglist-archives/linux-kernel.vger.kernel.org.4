Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36493607F65
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJUUBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJUUBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:01:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F60B25E891
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 13:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666382490; x=1697918490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V6m+YOfy5sxTfMqFs+Sj5pHdQRZvXRPoJwkK0Nyet44=;
  b=WcBHh3Hct0txAAqvbYNLgbiUbR3F1xFiGvVtyJPdniUKRz4xcQdbKR1g
   tZveZV78S3XyYLhXPVrlJrwlOESJ0yMdZYXnPn7sjp2CJjTt8QNox5KcB
   A6ybOnZ38917SRiop7MtVLLI13vh0j1r7+0UwTXovdh4tUN9MXKFQzxkM
   0hJBGMwxAI6t8ln4lD0YjDjuWas9YSrZPweuU9L9jNs4/zBYLsaZ8KXnh
   VI3Aq3rOLVbh5P4qmoSJFQytAzsP8QmAbgPGxUE/DJ0XwwctUcilJr4rb
   fvFOx82ySPOIruWEXR080ohDdOf7S7Lm9M2SUUyi82Xa6eu47KSdaHZvy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="290401090"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="290401090"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:01:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="633069091"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="633069091"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:01:27 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 2/2] mm, hwpoison: When copy-on-write hits poison, take page offline
Date:   Fri, 21 Oct 2022 13:01:20 -0700
Message-Id: <20221021200120.175753-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221021200120.175753-1-tony.luck@intel.com>
References: <20221019170835.155381-1-tony.luck@intel.com>
 <20221021200120.175753-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cannot call memory_failure() directly from the fault handler because
mmap_lock (and others) are held.

It is important, but not urgent, to mark the source page as h/w poisoned
and unmap it from other tasks.

Use memory_failure_queue() to request a call to memory_failure() for the
page with the error.

Also provide a stub version for CONFIG_MEMORY_FAILURE=n

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/mm.h | 5 ++++-
 mm/memory.c        | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8bbcccbc5565..03ced659eb58 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3268,7 +3268,6 @@ enum mf_flags {
 int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 		      unsigned long count, int mf_flags);
 extern int memory_failure(unsigned long pfn, int flags);
-extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
 extern int sysctl_memory_failure_early_kill;
@@ -3277,8 +3276,12 @@ extern void shake_page(struct page *p);
 extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(unsigned long pfn, int flags);
 #ifdef CONFIG_MEMORY_FAILURE
+extern void memory_failure_queue(unsigned long pfn, int flags);
 extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags);
 #else
+static inline void memory_failure_queue(unsigned long pfn, int flags)
+{
+}
 static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 {
 	return 0;
diff --git a/mm/memory.c b/mm/memory.c
index b6056eef2f72..eae242351726 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2866,8 +2866,10 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
 	unsigned long addr = vmf->address;
 
 	if (likely(src)) {
-		if (copy_mc_user_highpage(dst, src, addr, vma))
+		if (copy_mc_user_highpage(dst, src, addr, vma)) {
+			memory_failure_queue(page_to_pfn(src), 0);
 			return -EHWPOISON;
+		}
 		return 0;
 	}
 
-- 
2.37.3

