Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87216D2EBD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 08:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbjDAGjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 02:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbjDAGir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 02:38:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130AE21AA8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 23:38:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0CFD31FD78;
        Sat,  1 Apr 2023 06:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680331101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E7DHxTtJvlqvZrPXbQiV8NhXaH2BVGP/WAcxWNnt620=;
        b=G372kCwacV4DxPuUb7YsrKwAhoclIcxKTpoMLXIgetyWZQDNwL2mQE7gyFkHku5RACdJgI
        Rg2qoMbOhcsjptTaKLjKxNhMgIQLY4XoxdCloH3/L/Y7eAfEsSQvTRZkJR1OrkxuUvwfwU
        DIGcr9i7AwC2vtvVTTQNIr5v1Nn9WgA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C59F7134FB;
        Sat,  1 Apr 2023 06:38:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z1P/LlzRJ2SZdwAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 01 Apr 2023 06:38:20 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 15/15] x86/mtrr: remove unused code
Date:   Sat,  1 Apr 2023 08:36:52 +0200
Message-Id: <20230401063652.23522-16-jgross@suse.com>
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

mtrr_centaur_report_mcr() isn't used by anyone, so it can be removed.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V5:
- new patch
---
 arch/x86/include/asm/mtrr.h        | 4 ----
 arch/x86/kernel/cpu/mtrr/centaur.c | 9 ---------
 2 files changed, 13 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index b17a66da1237..3aced3568e2b 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -60,7 +60,6 @@ extern int mtrr_add_page(unsigned long base, unsigned long size,
 			 unsigned int type, bool increment);
 extern int mtrr_del(int reg, unsigned long base, unsigned long size);
 extern int mtrr_del_page(int reg, unsigned long base, unsigned long size);
-extern void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi);
 extern void mtrr_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
 extern int amd_special_default_mtrr(void);
@@ -108,9 +107,6 @@ static inline int mtrr_trim_uncached_memory(unsigned long end_pfn)
 {
 	return 0;
 }
-static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
-{
-}
 #define mtrr_bp_init() do {} while (0)
 #define mtrr_bp_restore() do {} while (0)
 #define mtrr_disable() do {} while (0)
diff --git a/arch/x86/kernel/cpu/mtrr/centaur.c b/arch/x86/kernel/cpu/mtrr/centaur.c
index 4466ddeb0125..6f6c3ae92943 100644
--- a/arch/x86/kernel/cpu/mtrr/centaur.c
+++ b/arch/x86/kernel/cpu/mtrr/centaur.c
@@ -45,15 +45,6 @@ centaur_get_free_region(unsigned long base, unsigned long size, int replace_reg)
 	return -ENOSPC;
 }
 
-/*
- * Report boot time MCR setups
- */
-void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
-{
-	centaur_mcr[mcr].low = lo;
-	centaur_mcr[mcr].high = hi;
-}
-
 static void
 centaur_get_mcr(unsigned int reg, unsigned long *base,
 		unsigned long *size, mtrr_type * type)
-- 
2.35.3

