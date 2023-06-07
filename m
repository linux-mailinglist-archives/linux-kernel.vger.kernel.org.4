Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6F2726466
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbjFGP0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241218AbjFGPZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:25:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB241BE2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686151515; x=1717687515;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ARZjNToUiO85DLbaOveTz4aJbWaU0n8lP8ieuY9WBAg=;
  b=A2mvcJi/gZezCXpPtX4airtaCl2TnYEKg+ctc8gocffxIWVDOJM1W8Dm
   WqzIit5+dOgpDCMwii9wGHS//aYtOgxyUF7ZvwccajBuCei/5a2Leig/K
   hILp/SIiiQzpBHrpZ9p1ph5fKiPqjWSMu1k76QLI86uLwcimNUFX2gDOF
   q8lpOozzI3lhSh9cXSmwsgZg/5INGPUPXfsRsvLvyq6xwpLywirkgR2ak
   xWrXD0k3RJX/+1RFnEyjruQC9Fc5VenV5BjGPXpmiGOIt6NS3iqTjxRLZ
   rArzy/foOgUH6xrnGTO9MwTidkGcc+Uz3RoJSLwXeOCnXAzKp4yK2adPk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="337383278"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="337383278"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 08:24:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956327825"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="956327825"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.213.10.174])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 08:24:00 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH v2] x86/mm: Fix PAT bit missing from page protection modify mask
Date:   Wed,  7 Jun 2023 17:23:09 +0200
Message-ID: <20230607152308.125787-2-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Visible glitches have been observed when running graphics applications on
Linux under Xen hypervisor.  Those observations have been confirmed with
failures from kms_pwrite_crc Intel GPU test that verifies data coherency
of DRM frame buffer objects using hardware CRC checksums calculated by
display controllers, exposed to userspace via debugfs.  Affected
processing paths have then been identified with new IGT test variants that
mmap the objects using different methods and caching modes [1].

When running as a Xen PV guest, Linux uses Xen provided PAT configuration
which is different from its native one.  In particular, Xen specific PTE
encoding of write-combining caching, likely used by graphics applications,
differs from the Linux default one found among statically defined minimal
set of supported modes.  Since Xen defines PTE encoding of the WC mode as
_PAGE_PAT, it no longer belongs to the minimal set, depends on correct
handling of _PAGE_PAT bit, and can be mismatched with write-back caching.

When a user calls mmap() for a DRM buffer object, DRM device specific
.mmap file operation, called from mmap_region(), takes care of setting PTE
encoding bits in a vm_page_prot field of an associated virtual memory area
structure.  Unfortunately, _PAGE_PAT bit is not preserved when the vma's
.vm_flags are then applied to .vm_page_prot via vm_set_page_prot().  Bits
to be preserved are determined with _PAGE_CHG_MASK symbol that doesn't
cover _PAGE_PAT.  As a consequence, WB caching is requested instead of WC
when running under Xen (also, WP is silently changed to WT, and UC
downgraded to UC_MINUS).  When running on bare metal, WC is not affected,
but WP and WT extra modes are unintentionally replaced with WC and UC,
respectively.

WP and WT modes, encoded with _PAGE_PAT bit set, were introduced by commit
281d4078bec3 ("x86: Make page cache mode a real type").  Care was taken
to extend _PAGE_CACHE_MASK symbol with that additional bit, but that
symbol has never been used for identification of bits preserved when
applying page protection flags.  Support for all cache modes under Xen,
including the problematic WC mode, was then introduced by commit
47591df50512 ("xen: Support Xen pv-domains using PAT").

Extend bitmask used by pgprot_modify() for selecting bits to be preserved
with _PAGE_PAT bit.  However, since that bit can be reused as _PAGE_PSE,
and the _PAGE_CHG_MASK symbol, primarly used by pte_modify(), is likely
intentionally defined with that bit not set, keep that symbol unchanged.

v2: Keep pgprot_modify() untouched, make _PAGE_PAT part of _PAGE_CHG_MASK
    instead (Borislav),
  - also add _PAGE_PAT_LARGE to _HPAGE_CHG_MASK (Juergen).

[1] https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/commit/0f0754413f14

Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/7648
Fixes: 281d4078bec3 ("x86: Make page cache mode a real type")
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: stable@vger.kernel.org # v3.19+
---
 arch/x86/include/asm/pgtable_types.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 447d4bee25c48..0432ed9e59e3e 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -125,11 +125,11 @@
  * instance, and is *not* included in this mask since
  * pte_modify() does modify it.
  */
-#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
-			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
-			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC |  \
+#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |	_PAGE_PAT | \
+			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	    \
+			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC |	    \
 			 _PAGE_UFFD_WP)
-#define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
+#define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE | _PAGE_PAT_LARGE)
 
 /*
  * The cache modes defined here are used to translate between pure SW usage
-- 
2.41.0

