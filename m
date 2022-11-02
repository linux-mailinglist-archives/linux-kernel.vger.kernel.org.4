Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D45615D25
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiKBHsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiKBHsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:48:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850F62715C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:48:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 464841F90F;
        Wed,  2 Nov 2022 07:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667375292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ux8/e9Woh3s8p0UvLOFok/6CxUvIyieZjB6VEj7G4a8=;
        b=BIorFGSD6wNJyIneTrGhMbM4cpdb9OTImr4C9otIkeQZVL7lnzgyvPA8CsLuyN0l2YqmHM
        nGYCHKnnM3D3c6q7keXpI43++4UBPl2PSwnPM4alZ0kEpqRScZt9i0vYpgGtp4GVwvzrRf
        5O76h1edklbFA2nKkv0ZVGlxJwBCvKM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 071DA1376E;
        Wed,  2 Nov 2022 07:48:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Cb9oALwgYmP/cgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 02 Nov 2022 07:48:12 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 10/16] x86/mtrr: get rid of __mtrr_enabled bool
Date:   Wed,  2 Nov 2022 08:47:07 +0100
Message-Id: <20221102074713.21493-11-jgross@suse.com>
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

There is no need for keeping __mtrr_enabled, as it can easily be
replaced by testing mtrr_if to be not NULL.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V4:
- new patch
V5:
- rebase
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index a468be5d778f..f671be9823b6 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -59,11 +59,9 @@
 #define MTRR_TO_PHYS_WC_OFFSET 1000
 
 u32 num_var_ranges;
-static bool __mtrr_enabled;
-
 static bool mtrr_enabled(void)
 {
-	return __mtrr_enabled;
+	return !!mtrr_if;
 }
 
 unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
@@ -755,18 +753,17 @@ void __init mtrr_bp_init(void)
 		}
 	}
 
-	if (mtrr_if) {
-		__mtrr_enabled = true;
+	if (mtrr_enabled()) {
 		set_num_var_ranges(mtrr_if == &generic_mtrr_ops);
 		init_table();
 		if (mtrr_if == &generic_mtrr_ops) {
 			/* BIOS may override */
-			__mtrr_enabled = get_mtrr_state();
-
-			if (mtrr_enabled()) {
+			if (get_mtrr_state()) {
 				memory_caching_control |= CACHE_MTRR | CACHE_PAT;
 				changed_by_mtrr_cleanup = mtrr_cleanup(phys_addr);
 				cache_cpu_init();
+			} else {
+				mtrr_if = NULL;
 			}
 		}
 	}
-- 
2.35.3

