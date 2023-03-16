Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6453D6BC0C6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjCOXVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjCOXVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:21:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302C09B9AA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 16:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678922465; x=1710458465;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=oUNGwFKGfCNeFmEzlWbIjgeX9cjyVruIm7Nzwqf6dqc=;
  b=auhUUXaOe0ygPY+iguRGPZEcpI1d3Hc7HaAYqodTtli+OOOzydjGNm4Y
   2VIWouPa8DdtakXVsID3wUeLvSLf5sJxjTrGTJNCLd8Y9qV8uldm1TQ/0
   MFyAhD5lhsMJ8njzh97PxacSQ+VoqXIURIoZmN6fLd0oS88f4RJJqXa6i
   wDRwsy5xJFgSkamrYc9HWTGNMFgCC973NGQ2BzIesXCwlqcGO6FOmWBVa
   AV07Pv+ORRewWTYDNEujjvEBtsKOypEPzvJaNSX7P8beCSE0y5uG4/Lju
   75RwOXmIMkglvzI/UAKwHy09+PWhw7ex0H2SA1/xY1hkzzjaD2Fi2vDn6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="365527073"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="365527073"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 16:21:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="672915107"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="672915107"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.196.133])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 16:21:03 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 15 Mar 2023 16:20:56 -0700
Subject: [PATCH 3/3] arm: uaccess: Remove memcpy_page_flushcache()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221230-kmap-x86-v1-3-15f1ecccab50@intel.com>
References: <20221230-kmap-x86-v1-0-15f1ecccab50@intel.com>
In-Reply-To: <20221230-kmap-x86-v1-0-15f1ecccab50@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678922459; l=1951;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=oUNGwFKGfCNeFmEzlWbIjgeX9cjyVruIm7Nzwqf6dqc=;
 b=029LLrpbd7VMZrAQfKYKO6kviK6io7TXxDI1OO3rXTtKEVFcqP25qXdcWxYdxjw/HbQDbRkgI
 tKmFt4wL/zHCVE+R+u24nRdfFvw80JCiCHp6v+2+M42Wcom5uYjWOyD
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 21b56c847753 ("iov_iter: get rid of separate bvec and xarray
callbacks") removed the calls to memcpy_page_flushcache().

Remove the unnecessary memcpy_page_flushcache() call.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Dan Williams" <dan.j.williams@intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/arm64/include/asm/uaccess.h    | 2 --
 arch/arm64/lib/uaccess_flushcache.c | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 5c7b2f9d5913..4bf2c0975a82 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -449,8 +449,6 @@ extern long strncpy_from_user(char *dest, const char __user *src, long count);
 extern __must_check long strnlen_user(const char __user *str, long n);
 
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
-struct page;
-void memcpy_page_flushcache(char *to, struct page *page, size_t offset, size_t len);
 extern unsigned long __must_check __copy_user_flushcache(void *to, const void __user *from, unsigned long n);
 
 static inline int __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
diff --git a/arch/arm64/lib/uaccess_flushcache.c b/arch/arm64/lib/uaccess_flushcache.c
index baee22961bdb..7510d1a23124 100644
--- a/arch/arm64/lib/uaccess_flushcache.c
+++ b/arch/arm64/lib/uaccess_flushcache.c
@@ -19,12 +19,6 @@ void memcpy_flushcache(void *dst, const void *src, size_t cnt)
 }
 EXPORT_SYMBOL_GPL(memcpy_flushcache);
 
-void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
-			    size_t len)
-{
-	memcpy_flushcache(to, page_address(page) + offset, len);
-}
-
 unsigned long __copy_user_flushcache(void *to, const void __user *from,
 				     unsigned long n)
 {

-- 
2.39.2

