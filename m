Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687F4634339
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiKVSEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbiKVSEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:04:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1CE6A680;
        Tue, 22 Nov 2022 10:04:50 -0800 (PST)
Date:   Tue, 22 Nov 2022 18:04:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669140289;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+xfy9x2NW4FMPCaywwSS54j1bx8NtMfowq9pHAUhqUc=;
        b=EQFY1DBhD559hIuZyDuW6KjwM0AGmDAI80qJa5m4RoMzUaWUhI2hBEufkUOwc69Q1KFS3V
        HT10SCcvxjC/A3qVR8F8YyRDGKzt0LdQ2VrpmbsqzuAsgH6wSH+q2Md1mZk1a9MleAGdut
        sWhkLEenX3xm3z1mKDluOVCBUrK0NHgMlX3BYU3Svnc/VAEDLwIkDIlVCjU5iosWJGDlxe
        miEaa0OxFlpECvESP23nS7FOfPbessSH2rxm7hAtRvVHZ/sO3/w/PhNk+Bou7RiTPybGza
        7L+rMBoQ+i9G6iQZzcHuGZIHSxNkeONKXDu4gek2EISZwzuEwmgeALHJBj7Vsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669140289;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+xfy9x2NW4FMPCaywwSS54j1bx8NtMfowq9pHAUhqUc=;
        b=eaiNgzGpdbwl9oK43RhrYbtZFWRb13c5iDsTqojrjHDiISvAHfq6URbdpHqUx3JE++8kFc
        cUL0FAtS7CtS3aAA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove X86_FEATURE_XENPV usage in
 setup_cpu_entry_area()
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221104072701.20283-5-jgross@suse.com>
References: <20221104072701.20283-5-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166914028791.4906.13888521355469411255.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d76c4f7a610ac56c5b06e34258859945e77d190c
Gitweb:        https://git.kernel.org/tip/d76c4f7a610ac56c5b06e34258859945e77d190c
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Fri, 04 Nov 2022 08:27:00 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 22 Nov 2022 16:16:25 +01:00

x86/cpu: Remove X86_FEATURE_XENPV usage in setup_cpu_entry_area()

Testing of X86_FEATURE_XENPV in setup_cpu_entry_area() can be removed,
as this code path is 32-bit only, and Xen PV guests are 64-bit only.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20221104072701.20283-5-jgross@suse.com
---
 arch/x86/mm/cpu_entry_area.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 6c2f1b7..42cd96e 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -138,17 +138,13 @@ static void __init setup_cpu_entry_area(unsigned int cpu)
 	pgprot_t tss_prot = PAGE_KERNEL_RO;
 #else
 	/*
-	 * On native 32-bit systems, the GDT cannot be read-only because
+	 * On 32-bit systems, the GDT cannot be read-only because
 	 * our double fault handler uses a task gate, and entering through
 	 * a task gate needs to change an available TSS to busy.  If the
 	 * GDT is read-only, that will triple fault.  The TSS cannot be
 	 * read-only because the CPU writes to it on task switches.
-	 *
-	 * On Xen PV, the GDT must be read-only because the hypervisor
-	 * requires it.
 	 */
-	pgprot_t gdt_prot = boot_cpu_has(X86_FEATURE_XENPV) ?
-		PAGE_KERNEL_RO : PAGE_KERNEL;
+	pgprot_t gdt_prot = PAGE_KERNEL;
 	pgprot_t tss_prot = PAGE_KERNEL;
 #endif
 
