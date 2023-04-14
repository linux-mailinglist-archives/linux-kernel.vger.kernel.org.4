Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A426E2118
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjDNKj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjDNKjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:39:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D292705;
        Fri, 14 Apr 2023 03:38:58 -0700 (PDT)
Date:   Fri, 14 Apr 2023 10:38:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681468735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=npO0D8Vo1wi+XzrnkB7csP/fIIyWYUfjkdVUgReY53c=;
        b=A7ITVD5z2LZfawIZmtS+A8f4v7WCbTB+de9e2gLPZkKdteGOU19R6wCl3lRGlKbGvQjcqS
        ip4cg+5s6kLWcS/jzBMMjN/QUUzxePMTuiA3sD4+5jlrMlhnMXYZB4R07pd2q9/j7D5emN
        SMU6hkl2CDYSFpDJBBBtcpyoqdY/7dVZBxOFD+pKDa1Fyh1hwUp7Q/U7tUO8n6sZxKC32i
        aQk1krwE1h1guuHwDVnpTBh1zDXE9MKpMim2gHZ0fni5zOlpfVOo5repxOhx1fsTdil5sm
        EM7vzxI7nYiS15GjC/1fhWJaklohWNngx5cGBswKQsy6+kAog4ndv7s7H8Q73g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681468735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=npO0D8Vo1wi+XzrnkB7csP/fIIyWYUfjkdVUgReY53c=;
        b=57toTX39E09HdmdfFYwWKbbd2OYhoqNeuOfSpJDaTNy05QzNK2fJYCely2pasgKHpGN5yl
        lGkzclmI6bd81bDg==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Do not taint when late loading on AMD
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230411125056.2333-1-bp@alien8.de>
References: <20230411125056.2333-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <168146873499.404.13384379805660350129.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     7bc9c1df89a3e5496ace55c198ff09409da0feb0
Gitweb:        https://git.kernel.org/tip/7bc9c1df89a3e5496ace55c198ff09409da0feb0
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 03 Mar 2023 12:46:49 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 14 Apr 2023 12:27:36 +02:00

x86/microcode: Do not taint when late loading on AMD

Describe why the concurrency issues which late loading poses are not
affecting AMD hardware, after discussing it with hw folks. Thus, do not
taint when late loading on it.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230411125056.2333-1-bp@alien8.de
---
 Documentation/x86/microcode.rst      | 10 ++++++++++
 arch/x86/kernel/cpu/microcode/core.c |  9 +++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/x86/microcode.rst b/Documentation/x86/microcode.rst
index b627c6f..15b52e2 100644
--- a/Documentation/x86/microcode.rst
+++ b/Documentation/x86/microcode.rst
@@ -208,6 +208,16 @@ Basically there is no way to declare a new microcode update suitable
 for late-loading. This is another one of the problems that caused late
 loading to be not enabled by default.
 
+AMD
+---
+
+Late loading on AMD does not have the concurrency issues described
+above: when loading is attempted on T0, the T1 is quiesced and does not
+execute instructions. Therefore, even if a higher priority interrupt or
+a fault happens, the whole core will see it either before the microcode
+patch has been applied or after. In either case, T0 and T1 will have the
+same microcode revision and nothing intermediate.
+
 Builtin microcode
 =================
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7a329e5..22cf57c 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -440,9 +440,6 @@ static int microcode_reload_late(void)
 	int old = boot_cpu_data.microcode, ret;
 	struct cpuinfo_x86 prev_info;
 
-	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
-	pr_err("You should switch to early loading, if possible.\n");
-
 	atomic_set(&late_cpus_in,  0);
 	atomic_set(&late_cpus_out, 0);
 
@@ -498,7 +495,11 @@ put:
 	if (ret == 0)
 		ret = size;
 
-	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
+		pr_err("Late microcode loading is dangerous and taints the kernel.\n");
+		pr_err("You should switch to early loading if possible.\n");
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	}
 
 	return ret;
 }
