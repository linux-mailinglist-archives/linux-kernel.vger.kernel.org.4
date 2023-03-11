Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29BB6B5FEB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 19:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCKS6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 13:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjCKS6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 13:58:32 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DAD199D1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 10:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=KhYiG1xwG75j/m4nN11yvPZyD/EP6q8Om6mxEW7VxKE=; b=J0KNh8ieMEvow7Qf+IZUZ/m9Mm
        4YBnxhCSTC8+6Hf5+XKwqP9L5PbvWLj+rUojAQHCXQR0EY9R7qqwNLLkD7J0GcCaYtahjcCKXCz60
        njxkj7OEZTrKDxQuhw7IvpPg/ZsFnyUB5mgpmtIxB3VsYEmGFIeYozn+hs2/7to34you3XIatOLqs
        rOeogKxnV/rpWGqznjCM5dLmOiqr88xOoos0STrzzWuG3BE8NrPbe4eAClGaVzcE//bo2LSbFHC7t
        aCdr2TqmAHlgtK0TTbSMOUamPKrTUqckzJOdf5vX6njZsurw28ygWvIss730vO/mXlDQb8rRcFHiK
        0OhSmsTA==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <anuradha@debian.org>)
        id 1pb4PW-006WT1-OS; Sat, 11 Mar 2023 18:57:43 +0000
From:   Anuradha Weeraman <anuradha@debian.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Anuradha Weeraman <anuradha@debian.org>,
        Juergen Gross <jgross@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jan Beulich <jbeulich@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Fix W=1 kernel-doc warnings
Date:   Sun, 12 Mar 2023 00:27:22 +0530
Message-Id: <20230311185725.51937-1-anuradha@debian.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973; i=anuradha@debian.org; h=from:subject; bh=K0lshucZ88gFfolU97hD8tw0yzsKdVnpEdfEp8vvJmg=; b=owEBbQKS/ZANAwAKAWNttaHZGGD9AcsmYgBkDM8TWSCaZQnin6ntuPXIoXFkAHhI1JQFWFfaL yqUJq/EWPOJAjMEAAEKAB0WIQT1a48U4BTN710Ef8FjbbWh2Rhg/QUCZAzPEwAKCRBjbbWh2Rhg /aJKD/4ruZdLjIkxG9JGzklR0WYO2ZzQICSaqz0vykTlTfJoazQ/xUI/IHgP41l8K4dVt5M8+ky F4YGvcNbO61X3OAe27WBq3S/BJhYqJ4uWedWvxDssrJTp9CjhOTlVVDsNYGdlCqxCjY3mTD0S/V lnhIYglMXD+ZcUxT8IPIk9oc8BcLea7/2Y8Xn1MWHSqrzf59cYYANmEqpErndHN7yrbDogItTka QpkDA39F3NYcbvB9E1UNsnMwKsIbf2AVpVLH1m1ugq8+NCAUS1ChHY3J4/EGeLR+ITn8xbPwWVk DSi7wzQOUSvQTd/lHPgtY3f7qgM0gh698ofaB0jcKr4aw6YOfGeZraGX09jz9f1Y8lSwvdZ9+ly drt7oXGbXropgCi047A0KKfr6+pWYwgoHYGu8qdjM7UcjELsr6qIvD9BGbY5nawLj4Pe6ap6Sqr RJ7XkC8/W9Jcy6PCPODgLFRPjQvYG+p/2aiZ79j0YbI5bWSU6lpFRHrfI0pFXHQyC0dIb69x5+V mxSMwZ6ScEWc8flLl07IFNNZHeIyWg9/PYJKaPPO1+RIasYxPY1hPmjbH9PU9NHXvZbkGZU6GGs XVBh2NXvKj91RiockEYpjtU1kdnJKza1x5qAl8K0TrM+ZF3kah2Qi7F/4amIlaJKqcmFiqdTXzR 077UBSNw0DDvo/w==
X-Developer-Key: i=anuradha@debian.org; a=openpgp; fpr=F56B8F14E014CDEF5D047FC1636DB5A1D91860FD
Content-Transfer-Encoding: 8bit
X-Debian-User: anuradha
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 kernel-doc warnings for:
  - arch/x86/lib/insn-eval.c
  - arch/x86/mm/pat/memtype.c

Signed-off-by: Anuradha Weeraman <anuradha@debian.org>
---
 arch/x86/lib/insn-eval.c  | 6 +++---
 arch/x86/mm/pat/memtype.c | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 558a605929db..0bc9d87ab95d 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1129,15 +1129,15 @@ static int get_eff_addr_modrm_16(struct insn *insn, struct pt_regs *regs,
  * get_eff_addr_sib() - Obtain referenced effective address via SIB
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
- * @regoff:	Obtained operand offset, in pt_regs, associated with segment
+ * @base_offset:Obtained operand offset, in pt_regs, associated with segment
  * @eff_addr:	Obtained effective address
  *
  * Obtain the effective address referenced by the SIB byte of @insn. After
  * identifying the registers involved in the indexed, register-indirect memory
  * reference, its value is obtained from the operands in @regs. The computed
  * address is stored @eff_addr. Also, the register operand that indicates the
- * associated segment is stored in @regoff, this parameter can later be used to
- * determine such segment.
+ * associated segment is stored in @base_offset, this parameter can later be
+ * used to determine such segment.
  *
  * Returns:
  *
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 46a00aa858b6..380bec99fab5 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -700,6 +700,7 @@ static enum page_cache_mode lookup_memtype(u64 paddr)
 /**
  * pat_pfn_immune_to_uc_mtrr - Check whether the PAT memory type
  * of @pfn cannot be overridden by UC MTRR memory type.
+ * @pfn: page frame number
  *
  * Only to be called when PAT is enabled.
  *
-- 
2.39.2

