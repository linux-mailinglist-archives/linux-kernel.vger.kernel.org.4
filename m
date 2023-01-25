Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D1467AE94
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbjAYJoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbjAYJoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:44:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549A52726;
        Wed, 25 Jan 2023 01:43:36 -0800 (PST)
Date:   Wed, 25 Jan 2023 09:43:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674639811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vzaEP7E6E1PaybXUfz3v0RQtUATPx3kmREJUUl+Xx80=;
        b=eMG7Pavtv3lgfnqYR/cRzPhsy0TiuRn7yWMRTdBReilm2epvz3mozwC+Ar3RZVvN90mRlW
        PjejF5RDuBgq9jtIFrmkXjD6Z6X5HjtYZvf3mMnLWATGrvBJ2iS5jahF6IvQvgVUhfud8+
        qmyUqXt7u1k/xKqBnoXTW2cOmFyvvsWc2SpGwJsBVNSfHlvDbzUMXiM9aTmOlldLwSuhv7
        oDekFtaNH5Dg7+yBapPKg8SBxjRhc4/qInZwYSfBuYLYABtK6OWQPCtzeapklx1gJ+eKPh
        /jYOG4eGnM9WvKNYZahn8RGLzpD7yssgFd/P0kW+vKBxPryMGWThV/YjlxmwyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674639811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vzaEP7E6E1PaybXUfz3v0RQtUATPx3kmREJUUl+Xx80=;
        b=ofIXQP2O9R4pdYaAw7hB9jcebe6/IZPb0sVs+9OWt6D+Ku6uTQnqoRVyXTl11dMnlTy4qi
        VzWvv6xArPAnGSCw==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/cpu: Use cpu_feature_enabled() when checking global
 pages support
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230125075013.9292-1-bp@alien8.de>
References: <20230125075013.9292-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <167463981101.4906.8494952549894706565.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     ebd3ad60a688131de7df1dd05fd2d7c57f542268
Gitweb:        https://git.kernel.org/tip/ebd3ad60a688131de7df1dd05fd2d7c57f542268
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 25 Jan 2023 08:50:13 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Jan 2023 10:32:06 +01:00

x86/cpu: Use cpu_feature_enabled() when checking global pages support

X86_FEATURE_PGE determines whether the CPU has enabled global page
translations support. Use the faster cpu_feature_enabled() check to
shave off some more cycles when flushing all TLB entries, including the
global ones.

What this practically saves is:

   mov    0x82eb308(%rip),%rax        # 0xffffffff8935bec8 <boot_cpu_data+40>
   test   $0x20,%ah

... which test the bit. Not a lot, but TLB flushing is a timing-sensitive
path, so anything to make it even faster.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230125075013.9292-1-bp@alien8.de
---
 arch/x86/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index c1e31e9..92d73cc 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1205,7 +1205,7 @@ void __flush_tlb_all(void)
 	 */
 	VM_WARN_ON_ONCE(preemptible());
 
-	if (boot_cpu_has(X86_FEATURE_PGE)) {
+	if (cpu_feature_enabled(X86_FEATURE_PGE)) {
 		__flush_tlb_global();
 	} else {
 		/*
