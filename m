Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE4374CE9D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGJHih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjGJHif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:38:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC27BB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688974714; x=1720510714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iFLJx5NiOQIeVEKzF4rAwx4P6EJ9+qVukE35Bt4hZAc=;
  b=X8YLm2IMA6WG4r63Dld3QPSbTFwHcbpge163VEot6mZuMsy6m1u1mL87
   vwRWL70fs4OsNS6vPN/XkgUYNrE0ALgVWtJfcMbiXPZ/T/j++2rRqK33u
   gyilXQ+3HvaYythuxLd8JSmJIXmC9d7tS5FXzm4jvpowl57U54R6D8yHr
   19bIltpd22zBgs3FUIGWMXE+ef7hz7hWsifMnnjsfetCuF5TUOrIBqGTx
   yjyP5deMILhrz56wlshHlaKbXzTtfYDMeV5VfLcp1NF8moV9hZIcOp1jl
   GsvzVQuehZkzh+ILbeTZY31SJmvtoKfY/B9UPOuR1EnIi/hpbkzSjeyDA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="354137348"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="354137348"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 00:38:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="755899096"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="755899096"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO jkrzyszt-mobl2.intranet) ([10.213.7.37])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 00:38:29 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH v3 RESEND] x86/mm: Fix PAT bit missing from page protection modify mask
Date:   Mon, 10 Jul 2023 09:36:14 +0200
Message-ID: <20230710073613.8006-2-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

The issue needs to be fixed by including _PAGE_PAT bit into a bitmask used
by pgprot_modify() for selecting bits to be preserved.  We can do that
either internally to pgprot_modify() (as initially proposed), or by making
_PAGE_PAT a part of _PAGE_CHG_MASK.  If we go for the latter then, since
_PAGE_PAT is the same as _PAGE_PSE, we need to note that _HPAGE_CHG_MASK
-- a huge pmds' counterpart of _PAGE_CHG_MASK, introduced by commit
c489f1257b8c ("thp: add pmd_modify"), defined as (_PAGE_CHG_MASK |
_PAGE_PSE) -- will no longer differ from _PAGE_CHG_MASK.  If such
modification of _PAGE_CHG_MASK was irrelevant to its users then one might
wonder why that new _HPAGE_CHG_MASK symbol was introduced instead of
reusing the existing one with that otherwise irrelevant bit (_PAGE_PSE in
that case) added.

Assume that adding _PAGE_PAT to _PAGE_CHG_MASK doesn't break pte_modify()
and its users, and go for it.  Also, add _PAGE_PAT_LARGE to
_HPAGE_CHG_MASK for symmetry.  For better clarity, split out common bits
from both symbols to another one and use it together with specific bits
when defining the masks.

v3: Separate out common bits of _PAGE_CHG_MASK and _HPAGE_CHG_MASK into
    _COMMON_PAGE_CHG_MASK (Rick),
  - fix hard to parse wording of 'what' part of commit description (on
    Dave's request).
v2: Keep pgprot_modify() untouched, make _PAGE_PAT part of _PAGE_CHG_MASK
    instead (Borislav),
  - also add _PAGE_PAT_LARGE to _HPAGE_CHG_MASK (Juergen).

[1] https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/commit/0f0754413f14

Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/7648
Fixes: 281d4078bec3 ("x86: Make page cache mode a real type")
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: stable@vger.kernel.org # v3.19+
---
 arch/x86/include/asm/pgtable_types.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 447d4bee25c48..97533e6b1c61b 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -125,11 +125,12 @@
  * instance, and is *not* included in this mask since
  * pte_modify() does modify it.
  */
-#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
-			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
-			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC |  \
-			 _PAGE_UFFD_WP)
-#define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
+#define _COMMON_PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |	       \
+				 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |\
+				 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC | \
+				 _PAGE_UFFD_WP)
+#define _PAGE_CHG_MASK	(_COMMON_PAGE_CHG_MASK | _PAGE_PAT)
+#define _HPAGE_CHG_MASK (_COMMON_PAGE_CHG_MASK | _PAGE_PSE | _PAGE_PAT_LARGE)
 
 /*
  * The cache modes defined here are used to translate between pure SW usage
-- 
2.41.0

