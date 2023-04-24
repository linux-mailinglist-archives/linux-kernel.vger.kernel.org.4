Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE976ECC1E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjDXMfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjDXMfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:35:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3348611A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 05:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682339741; x=1713875741;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LQb6t4tK7Ded4s/ZP9FLDT1+Gsn+Vtw0F4s14bxTkfE=;
  b=Wy9odfp4MBL1yz3wt83ReOpjkr+duTJojVUl6nPKtDs5LiUoUBSWx1Sb
   adUG5VlZJDdxyk3KMD5jx4u7YXf43QWKVoAUQyvAoRbIILucSnUC9WQGo
   UKb0XxwzYfu8YPjPPQ05MXrPESUN7zEKk9rA1j9K/9v0CI/uovdrCiH8a
   2RtHezsonfLGbkPPm25Qb9adj7vIHHaq9T05yjNVFFp5icH2n7J9S7Igy
   crdXxu0Jbup870FmPmuE6dMrBLClsr6vIgWBv/SW8FopzELtId9w2dOSa
   7eaAsljSoQpyJvJgrY9jnZX2qFU9ngyySUWEIWupXiJ60EYRAtcFLueR7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="348348908"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="348348908"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 05:35:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="693063701"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="693063701"
Received: from martapio-mobl1.ger.corp.intel.com (HELO jkrzyszt-mobl2.intranet) ([10.213.7.53])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 05:35:35 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Chris Wilson <chris.p.wilson@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [RFC PATCH] x86/mm: Fix PAT bit missing from page protection modify mask
Date:   Mon, 24 Apr 2023 14:35:24 +0200
Message-Id: <20230424123524.17008-1-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
processing paths have then been identified with new test variants that
mmap the objects using different methods and caching modes.

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

Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/7648
Fixes: 281d4078bec3 ("x86: Make page cache mode a real type")
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc: stable@vger.kernel.org # v3.19+
---
 arch/x86/include/asm/pgtable.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 7425f32e52932..f797f8da2e5b6 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -654,8 +654,10 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 #define pgprot_modify pgprot_modify
 static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
 {
-	pgprotval_t preservebits = pgprot_val(oldprot) & _PAGE_CHG_MASK;
-	pgprotval_t addbits = pgprot_val(newprot) & ~_PAGE_CHG_MASK;
+	unsigned long mask = _PAGE_CHG_MASK | _PAGE_CACHE_MASK;
+
+	pgprotval_t preservebits = pgprot_val(oldprot) & mask;
+	pgprotval_t addbits = pgprot_val(newprot) & ~mask;
 	return __pgprot(preservebits | addbits);
 }
 
-- 
2.40.0

