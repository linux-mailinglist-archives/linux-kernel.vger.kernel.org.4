Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B4968D09A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjBGH37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjBGH3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:29:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E88B37B59
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:29:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AD38333E13;
        Tue,  7 Feb 2023 07:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675754973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JQKD/lPKkbb0qc+8vhUXutdmkqWMq0MqdsxYYVlo8yw=;
        b=rhN5jlM6O0ZsxdaBTemQtSJgkBZPcxAZaNNtQJLq5Ihc0NbsHPi20j4I7fjRtIto2K4d4X
        zIDf3658nAGwSKwguO4O/FDqknFHsNoGM589ogc/tD0JkZ0n9T3dret8xtcVctvZFUQg5h
        qphoyoKo95W/LGOBbq3SIF1tfcz1TUM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54F1713A8C;
        Tue,  7 Feb 2023 07:29:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 83VgE9394WPaUQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 07 Feb 2023 07:29:33 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org, Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 5/6] x86/mm: only check uniform after calling mtrr_type_lookup()
Date:   Tue,  7 Feb 2023 08:29:01 +0100
Message-Id: <20230207072902.5528-6-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230207072902.5528-1-jgross@suse.com>
References: <20230207072902.5528-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
would only be to map the same region with smaller pages instead using
the same PAT type as for the large mapping.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/mm/pgtable.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index e4f499eb0f29..7b9c5443d176 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -721,8 +721,7 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 	u8 mtrr, uniform;
 
 	mtrr = mtrr_type_lookup(addr, addr + PUD_SIZE, &uniform);
-	if ((mtrr != MTRR_TYPE_INVALID) && (!uniform) &&
-	    (mtrr != MTRR_TYPE_WRBACK))
+	if (!uniform)
 		return 0;
 
 	/* Bail out if we are we on a populated non-leaf entry: */
@@ -748,8 +747,7 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 	u8 mtrr, uniform;
 
 	mtrr = mtrr_type_lookup(addr, addr + PMD_SIZE, &uniform);
-	if ((mtrr != MTRR_TYPE_INVALID) && (!uniform) &&
-	    (mtrr != MTRR_TYPE_WRBACK)) {
+	if (!uniform) {
 		pr_warn_once("%s: Cannot satisfy [mem %#010llx-%#010llx] with a huge-page mapping due to MTRR override.\n",
 			     __func__, addr, addr + PMD_SIZE);
 		return 0;
-- 
2.35.3

