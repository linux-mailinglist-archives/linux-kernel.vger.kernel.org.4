Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BB2615D1D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiKBHrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiKBHra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:47:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6301B25EA2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:47:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 07CF61F8B0;
        Wed,  2 Nov 2022 07:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667375247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQEtb2vL+iQO4o3v4gnSZ8HiVeg2+FFF5GuRa10reVo=;
        b=XcAg0758gjmv84xLkZT984Qx7dgoXbDg2VgwRDexHARVFS/H9a7bejr26a2+5BXSudfixa
        TGFD3ycnVDrW8J1yLkpHFUxcBiV1J0fryFHTuP+AMoiMCwWXAJEPM8Ni2kt3zvJIY5AZqG
        PjWf0m9dqJ1FFqOf9Z1FczZkNAX5M7s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB5C41376E;
        Wed,  2 Nov 2022 07:47:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sI5FLI4gYmOccgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 02 Nov 2022 07:47:26 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 02/16] x86/mtrr: remove unused cyrix_set_all() function
Date:   Wed,  2 Nov 2022 08:46:59 +0100
Message-Id: <20221102074713.21493-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102074713.21493-1-jgross@suse.com>
References: <20221102074713.21493-1-jgross@suse.com>
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

The Cyrix CPU specific MTRR function cyrix_set_all() will never be
called, as the struct mtrr_ops set_all() callback will only be called
in the use_intel() case, which would require the use_intel_if member
of struct mtrr_ops to be set, which isn't the case for Cyrix.

Note that this patch has already been applied to tip.git.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/kernel/cpu/mtrr/cyrix.c | 34 --------------------------------
 1 file changed, 34 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/cyrix.c b/arch/x86/kernel/cpu/mtrr/cyrix.c
index ca670919b561..c77d3b0a5bf2 100644
--- a/arch/x86/kernel/cpu/mtrr/cyrix.c
+++ b/arch/x86/kernel/cpu/mtrr/cyrix.c
@@ -234,42 +234,8 @@ static void cyrix_set_arr(unsigned int reg, unsigned long base,
 	post_set();
 }
 
-typedef struct {
-	unsigned long	base;
-	unsigned long	size;
-	mtrr_type	type;
-} arr_state_t;
-
-static arr_state_t arr_state[8] = {
-	{0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL},
-	{0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}, {0UL, 0UL, 0UL}
-};
-
-static unsigned char ccr_state[7] = { 0, 0, 0, 0, 0, 0, 0 };
-
-static void cyrix_set_all(void)
-{
-	int i;
-
-	prepare_set();
-
-	/* the CCRs are not contiguous */
-	for (i = 0; i < 4; i++)
-		setCx86(CX86_CCR0 + i, ccr_state[i]);
-	for (; i < 7; i++)
-		setCx86(CX86_CCR4 + i, ccr_state[i]);
-
-	for (i = 0; i < 8; i++) {
-		cyrix_set_arr(i, arr_state[i].base,
-			      arr_state[i].size, arr_state[i].type);
-	}
-
-	post_set();
-}
-
 static const struct mtrr_ops cyrix_mtrr_ops = {
 	.vendor            = X86_VENDOR_CYRIX,
-	.set_all	   = cyrix_set_all,
 	.set               = cyrix_set_arr,
 	.get               = cyrix_get_arr,
 	.get_free_region   = cyrix_get_free_region,
-- 
2.35.3

