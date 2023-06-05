Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5007722854
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbjFEOI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbjFEOIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:08:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5F5E49;
        Mon,  5 Jun 2023 07:08:15 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:08:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Kb8ggiqGNt/KIP6O4DQ2argUL9ZpkFBooFelw+TaMk=;
        b=E/uU3kROn8LS1g8ciw72wiWWc4vmZldzurMoSACt58YdKcIyFobI8z+H2MEV5N6rOf4J+6
        0/7FdRHA6nEkpdVX7ohajJX/xIMmcGgnYt7gVP+r4qdrK2S+13OY6/tlxOsUx0CgJlW7bt
        PuPv0qjpKVxt0Qujgbk76g7TrKZga31NZf+UWnlrXmwYuxLNMf1tTLUzuSKIe2NJFWDkPO
        XvYzD7VzjQObns+LdLr6WITzxAcofkijHvyKmFgPyLSUwNLqpfEg0aVeC44/KdwJ/05Jk2
        xFLvrwKVhJ4xvtignObn/v4WId16Zd9WlWZZxAHf3+sJ8cq7SV1/yDOy58QJyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Kb8ggiqGNt/KIP6O4DQ2argUL9ZpkFBooFelw+TaMk=;
        b=bqA5xzVuTLXTTSHYpPGD+go31gLU1KuFqgL2F+2Td7qT8ub2qUmg4g/d/mDOnthNpyaUep
        V3jU6vFuzA93A4DQ==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/mm: Only check uniform after calling mtrr_type_lookup()
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230502120931.20719-16-jgross@suse.com>
References: <20230502120931.20719-16-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <168597409343.404.684368670702488833.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mtrr branch of tip:

Commit-ID:     12f0dd8df14285a5604f35ed3af8b8c33e8fd97f
Gitweb:        https://git.kernel.org/tip/12f0dd8df14285a5604f35ed3af8b8c33e8fd97f
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 02 May 2023 14:09:30 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 01 Jun 2023 15:04:33 +02:00

x86/mm: Only check uniform after calling mtrr_type_lookup()

Today pud_set_huge() and pmd_set_huge() test for the MTRR type to be
WB or INVALID after calling mtrr_type_lookup().

Those tests can be dropped as the only reason not to use a large mapping
would be uniform being 0.

Any MTRR type can be accepted as long as it applies to the whole memory
range covered by the mapping, as the alternative would only be to map
the same region with smaller pages instead, using the same PAT type as
for the large mapping.

  [ bp: Massage commit message. ]

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20230502120931.20719-16-jgross@suse.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/mm/pgtable.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index e4f499e..15a8009 100644
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
