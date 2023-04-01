Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32416D2EB7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 08:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjDAGi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 02:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbjDAGiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 02:38:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0E021A9A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 23:37:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D244821A73;
        Sat,  1 Apr 2023 06:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680331066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K2ik7sM7MKDAhj6hnR4NNX3zRxA2aEkPlgWNeKuOI4M=;
        b=lX+D5IwceSzE0cz8ypRJFts7mCMjDq0IimYmxMR5U7LkjWBGFqNw6+mlan32M26qL1QJEE
        A1v83q6XYc0XyzElJNX+aB2GPCOHzFtG+BMHB93lAZ0AiJSvd0BUGCNKWyndw00psTYQ6J
        3+84JSzgIK60gZvRgUfdBSHCERV2GnI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F059134FB;
        Sat,  1 Apr 2023 06:37:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9+OrITrRJ2RpdwAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 01 Apr 2023 06:37:46 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v5 09/15] x86/mtrr: allocate mtrr_value array dynamically
Date:   Sat,  1 Apr 2023 08:36:46 +0200
Message-Id: <20230401063652.23522-10-jgross@suse.com>
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

The mtrr_value[] array is a static variable, which is used only in a
few configurations. Consuming 6kB is ridiculous for this case,
especially as the array doesn't need to be that large and it can easily
be allocated dynamically.

The "few configurations" are all 32-bit ones, so put the code inside a
CONFIG_X86_32 #ifdef.

Signed-off-by: Juergen Gross <jgross@suse.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
---
V5:
- check for allocation failure (Kai Huang, Boris Petkov)
- add #ifdef
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 4fa3d0f94f39..76f5b5e1128b 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -560,8 +560,10 @@ int arch_phys_wc_index(int handle)
 }
 EXPORT_SYMBOL_GPL(arch_phys_wc_index);
 
-/* The suspend/resume methods are only for CPU without MTRR. CPU using generic
- * MTRR driver doesn't require this
+#ifdef CONFIG_X86_32
+/*
+ * The suspend/resume methods are only for CPUs without MTRR. CPUs using generic
+ * MTRR driver don't require this.
  */
 struct mtrr_value {
 	mtrr_type	ltype;
@@ -569,12 +571,15 @@ struct mtrr_value {
 	unsigned long	lsize;
 };
 
-static struct mtrr_value mtrr_value[MTRR_MAX_VAR_RANGES];
+static struct mtrr_value *mtrr_value;
 
 static int mtrr_save(void)
 {
 	int i;
 
+	if (!mtrr_value)
+		return -ENOMEM;
+
 	for (i = 0; i < num_var_ranges; i++) {
 		mtrr_if->get(i, &mtrr_value[i].lbase,
 				&mtrr_value[i].lsize,
@@ -596,12 +601,11 @@ static void mtrr_restore(void)
 	}
 }
 
-
-
 static struct syscore_ops mtrr_syscore_ops = {
 	.suspend	= mtrr_save,
 	.resume		= mtrr_restore,
 };
+#endif /* CONFIG_X86_32 */
 
 int __initdata changed_by_mtrr_cleanup;
 
@@ -730,15 +734,20 @@ static int __init mtrr_init_finialize(void)
 		return 0;
 	}
 
+#ifdef CONFIG_X86_32
+	mtrr_value = kcalloc(num_var_ranges, sizeof(*mtrr_value), GFP_KERNEL);
+
 	/*
 	 * The CPU has no MTRR and seems to not support SMP. They have
 	 * specific drivers, we use a tricky method to support
-	 * suspend/resume for them.
+	 * suspend/resume for them. In case above allocation failed we can't
+	 * support suspend/resume (handled in mtrr_save()).
 	 *
 	 * TBD: is there any system with such CPU which supports
 	 * suspend/resume? If no, we should remove the code.
 	 */
 	register_syscore_ops(&mtrr_syscore_ops);
+#endif
 
 	return 0;
 }
-- 
2.35.3

