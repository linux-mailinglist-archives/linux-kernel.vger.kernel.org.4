Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD0E6BC0C5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjCOXVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjCOXVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:21:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291599F077
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 16:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678922464; x=1710458464;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=nw/5j1jSpLgBUUzdvXc7MsautacAZY58cIXNBbOwElk=;
  b=l2HFb/N6H2JdNC4Cp+Nim9fPw1hg4OnWFAT9+utysgshSLsVnpCd1EbF
   a+iARunBhVtlmV8oBoWhpfrnWTzdWwYLjKdxKG+3ckRRXXKoggHcMhfhe
   7ng/b6ggYH+aXijKXNjZkDpf6Gik+4P0waDwlv1rpfoTAS977vBtNGFhb
   3OmSpI3ioLXubtVYZY8NG7xF7dgSM6ryVnPSSG4CqiFiJD2jaECuze6/t
   bXGOwSUTSm9ByDPWZNMDdLc8WghWGvIwjeY1t8BquzfxcIdbEogxF/3B1
   8qJuZDiug5+8E0EUDenBMix4ykLozlkw2WV/aQ/rkSFwkco/MaTixc9XC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="365527055"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="365527055"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 16:21:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="672915100"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="672915100"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.196.133])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 16:21:02 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 15 Mar 2023 16:20:55 -0700
Subject: [PATCH 2/3] powerpc: Remove memcpy_page_flushcache()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221230-kmap-x86-v1-2-15f1ecccab50@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678922459; l=1774;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=nw/5j1jSpLgBUUzdvXc7MsautacAZY58cIXNBbOwElk=;
 b=I19fBOZllVPuww2XPYb6Yj7SCTP0c5VvdEc1+udYFhYFeIDcPWfYUR9BHff5pGr5NQfrq/2HP
 Ku062ohYTaOB3XapC/cKDnTRLhJb/UBQCJE0wd6lYwaIKHy2W6KvNCQ
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

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Dan Williams" <dan.j.williams@intel.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/powerpc/include/asm/uaccess.h | 2 --
 arch/powerpc/lib/pmem.c            | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 3ddc65c63a49..52378e641d38 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -361,8 +361,6 @@ copy_mc_to_user(void __user *to, const void *from, unsigned long n)
 
 extern long __copy_from_user_flushcache(void *dst, const void __user *src,
 		unsigned size);
-extern void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
-			   size_t len);
 
 static __must_check inline bool user_access_begin(const void __user *ptr, size_t len)
 {
diff --git a/arch/powerpc/lib/pmem.c b/arch/powerpc/lib/pmem.c
index eb2919ddf9b9..4e724c4c01ad 100644
--- a/arch/powerpc/lib/pmem.c
+++ b/arch/powerpc/lib/pmem.c
@@ -85,10 +85,3 @@ void memcpy_flushcache(void *dest, const void *src, size_t size)
 	clean_pmem_range(start, start + size);
 }
 EXPORT_SYMBOL(memcpy_flushcache);
-
-void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
-	size_t len)
-{
-	memcpy_flushcache(to, page_to_virt(page) + offset, len);
-}
-EXPORT_SYMBOL(memcpy_page_flushcache);

-- 
2.39.2

