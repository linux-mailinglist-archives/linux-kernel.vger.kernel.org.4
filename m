Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05AD6D2EBB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 08:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjDAGjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 02:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjDAGip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 02:38:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A468B20DB7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 23:38:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6510F1FD6D;
        Sat,  1 Apr 2023 06:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680331095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PLhZnRzaTF/w19VvaTwREzeMUwLtgou6VVO1Iy9aXOI=;
        b=hlJX4+mn92AjAhl6PYx0T3gUWvKaL2etfSkUjXhW4rfmimMPLmlIg0hjuaB7X7gZP/vVQ+
        0wYDXpajnNGpXf6sBmava6k/WHQ2InPTViQQljFPd1R7lLImrKDpprLUmY4nHw4wKvj18x
        Gi+mz7kqtLf55Tk2X+Cq4e90o84NV7U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 10565134FB;
        Sat,  1 Apr 2023 06:38:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2ZmXAlfRJ2SQdwAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 01 Apr 2023 06:38:15 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v5 14/15] x86/mm: only check uniform after calling mtrr_type_lookup()
Date:   Sat,  1 Apr 2023 08:36:51 +0200
Message-Id: <20230401063652.23522-15-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230401063652.23522-1-jgross@suse.com>
References: <20230401063652.23522-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today pud_set_huge() and pmd_set_huge() test for the MTRR type to be
WB or INVALID after calling mtrr_type_lookup(). Those tests can be
dropped, as the only reason to not use a large mapping would be
uniform being 0. Any MTRR type can be accepted as long as it applies
to the whole memory range covered by the mapping, as the alternative
would only be to map the same region with smaller pages instead, using
the same PAT type as for the large mapping.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
---
V3:
- adapt comment for pud_set_huge()
---
 arch/x86/mm/pgtable.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index e4f499eb0f29..15a8009a4480 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -702,14 +702,8 @@ void p4d_clear_huge(p4d_t *p4d)
  * pud_set_huge - setup kernel PUD mapping
  *
  * MTRRs can override PAT memory types with 4KiB granularity. Therefore, this
- * function sets up a huge page only if any of the following conditions are met:
- *
- * - MTRRs are disabled, or
- *
- * - MTRRs are enabled and the range is completely covered by a single MTRR, or
- *
- * - MTRRs are enabled and the corresponding MTRR memory type is WB, which
- *   has no effect on the requested PAT memory type.
+ * function sets up a huge page only if the complete range has the same MTRR
+ * caching mode.
  *
  * Callers should try to decrease page size (1GB -> 2MB -> 4K) if the bigger
  * page mapping attempt fails.
@@ -718,11 +712,10 @@ void p4d_clear_huge(p4d_t *p4d)
  */
 int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 {
-	u8 mtrr, uniform;
+	u8 uniform;
 
-	mtrr = mtrr_type_lookup(addr, addr + PUD_SIZE, &uniform);
-	if ((mtrr != MTRR_TYPE_INVALID) && (!uniform) &&
-	    (mtrr != MTRR_TYPE_WRBACK))
+	mtrr_type_lookup(addr, addr + PUD_SIZE, &uniform);
+	if (!uniform)
 		return 0;
 
 	/* Bail out if we are we on a populated non-leaf entry: */
@@ -745,11 +738,10 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
  */
 int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 {
-	u8 mtrr, uniform;
+	u8 uniform;
 
-	mtrr = mtrr_type_lookup(addr, addr + PMD_SIZE, &uniform);
-	if ((mtrr != MTRR_TYPE_INVALID) && (!uniform) &&
-	    (mtrr != MTRR_TYPE_WRBACK)) {
+	mtrr_type_lookup(addr, addr + PMD_SIZE, &uniform);
+	if (!uniform) {
 		pr_warn_once("%s: Cannot satisfy [mem %#010llx-%#010llx] with a huge-page mapping due to MTRR override.\n",
 			     __func__, addr, addr + PMD_SIZE);
 		return 0;
-- 
2.35.3

