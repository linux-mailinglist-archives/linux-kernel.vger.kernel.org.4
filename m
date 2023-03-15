Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9506BC0C4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjCOXVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjCOXVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:21:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845BBA2245
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 16:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678922462; x=1710458462;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=hTHmFfjOsB4OVepCRKtPKTfrpQQ+NPJymzD64IX4dgI=;
  b=j84el0Et30dv55z0cKnzYgVjBQN+nGGW64ldo7wtjL2Ma29CY6xBif0Y
   ZfVO4z3COXY6EJ0nbRjkjai2YndGMt7LcchZFtm7efC3+JIBMHWZ4Eox1
   LvEf+IJWB5bUNndP0UNWQH0ewN/2W1FVhHwdRClBcTDscpbixw70c87/H
   vtjTcG5+0c0hliPbHMfK7k7bzskLyc9K6AXGFbc4PM6910JeQmgmpD7yt
   DVoDxi9CgsYNqUwdGbglk/1VF5fPX83JHUuiD8lrFHkW8ymVvOtnqfhcW
   No4yEQAdyWLz75DOnDL1Jq030KgE+Th3kApzfC+fuUmYhImeb5Gs5OckU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="365527041"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="365527041"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 16:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="672915091"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="672915091"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.196.133])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 16:21:01 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 15 Mar 2023 16:20:54 -0700
Subject: [PATCH 1/3] x86, uaccess: Remove memcpy_page_flushcache()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221230-kmap-x86-v1-1-15f1ecccab50@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678922459; l=1867;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=hTHmFfjOsB4OVepCRKtPKTfrpQQ+NPJymzD64IX4dgI=;
 b=R22Wk9eXfxke9PcTFFNPFdA1VAjkKHUHCkHh1AmhPOofA7NfgRUw0cVsSIqTFK5KdEdll3UM1
 g6ReFh5l0vcC3FUcAcbPNkHsO4AUXpCGvxlsHRQDHtFWxKTP8cIfI60
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

kmap_atomic() is deprecated and used in memcpy_page_flushcache().

Remove the unnecessary memcpy_page_flushcache() call.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Dan Williams" <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/include/asm/uaccess_64.h | 2 --
 arch/x86/lib/usercopy_64.c        | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index d13d71af5cf6..c6b1dcded364 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -62,8 +62,6 @@ extern long __copy_user_nocache(void *dst, const void __user *src,
 				unsigned size, int zerorest);
 
 extern long __copy_user_flushcache(void *dst, const void __user *src, unsigned size);
-extern void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
-			   size_t len);
 
 static inline int
 __copy_from_user_inatomic_nocache(void *dst, const void __user *src,
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 6c1f8ac5e721..f515542f017f 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -136,13 +136,4 @@ void __memcpy_flushcache(void *_dst, const void *_src, size_t size)
 	}
 }
 EXPORT_SYMBOL_GPL(__memcpy_flushcache);
-
-void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
-		size_t len)
-{
-	char *from = kmap_atomic(page);
-
-	memcpy_flushcache(to, from + offset, len);
-	kunmap_atomic(from);
-}
 #endif

-- 
2.39.2

