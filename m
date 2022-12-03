Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F98C641721
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 14:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLCNvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 08:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiLCNvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 08:51:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B038122B34;
        Sat,  3 Dec 2022 05:51:15 -0800 (PST)
Date:   Sat, 03 Dec 2022 13:51:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670075473;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+XUwHrsrE6DfDCNkWoJz1FGQB8HJEOn2bw8jH7Zsoy8=;
        b=ASMHKnA9rhxXeLDKq6Ag2vtLejeG33U4JgIedX65g7JM2s29LRuw5ZGZx9atAKt37ZGFRy
        LiQvKiUXeemntG+iSQzJ06DR9lqfwyxr/M9Tl3JLEOu0oMIKMaAF/pGuqhsdJAb2JK6Cc6
        37pyyHvFEUgddNv4cpD7wg+xGzRIpCHByWIDqHze0DZKN+gmVQx9ctUvVa1VbtUag4fgIQ
        VKElhP7F2ZKPfr9EdDrAHujBKNwFQvbZhSLW/yeH09VPiRjfFy1s141S74fQ6/aXyUFrQ/
        sx/JNvKahTh0Lt99V0Zvd3JlEamJYlXBqJX8a3+JbrEi5Hd+cJo+Y91atm/J6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670075473;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+XUwHrsrE6DfDCNkWoJz1FGQB8HJEOn2bw8jH7Zsoy8=;
        b=YviRu5o/EuWfGn6Etokb2Ohb3rKN8fM3hJvxHKa1xsO8BMiKuW1tWqr/xchzFqSAShiSdI
        NeTAWrjC0Tq2cCDg==
From:   "tip-bot2 for Ashok Raj" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Do not print microcode
 revision and processor flags
Cc:     Tony Luck <tony.luck@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221103175901.164783-2-ashok.raj@intel.com>
References: <20221103175901.164783-2-ashok.raj@intel.com>
MIME-Version: 1.0
Message-ID: <167007547263.4906.10472927215347122978.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     5b1586ab064ca24c6a7a6be7a9d0cb9e237ef39a
Gitweb:        https://git.kernel.org/tip/5b1586ab064ca24c6a7a6be7a9d0cb9e237ef39a
Author:        Ashok Raj <ashok.raj@intel.com>
AuthorDate:    Tue, 29 Nov 2022 13:08:26 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 03 Dec 2022 14:41:06 +01:00

x86/microcode/intel: Do not print microcode revision and processor flags

collect_cpu_info() is used to collect the current microcode revision and
processor flags on every CPU.

It had a weird mechanism to try to mimick a "once" functionality in the
sense that, that information should be issued only when it is differing
from the previous CPU.

However (1):

the new calling sequence started doing that in parallel:

  microcode_init()
  |-> schedule_on_each_cpu(setup_online_cpu)
      |-> collect_cpu_info()

resulting in multiple redundant prints:

  microcode: sig=0x50654, pf=0x80, revision=0x2006e05
  microcode: sig=0x50654, pf=0x80, revision=0x2006e05
  microcode: sig=0x50654, pf=0x80, revision=0x2006e05

However (2):

dumping this here is not that important because the kernel does not
support mixed silicon steppings microcode. Finally!

Besides, there is already a pr_info() in microcode_reload_late() that
shows both the old and new revisions.

What is more, the CPU signature (sig=0x50654) and Processor Flags
(pf=0x80) above aren't that useful to the end user, they are available
via /proc/cpuinfo and they don't change anyway.

Remove the redundant pr_info().

  [ bp: Heavily massage. ]

Fixes: b6f86689d5b7 ("x86/microcode: Rip out the subsys interface gunk")
Reported-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20221103175901.164783-2-ashok.raj@intel.com
---
 arch/x86/kernel/cpu/microcode/intel.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index c4a00fb..4f93875 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -554,7 +554,6 @@ void reload_ucode_intel(void)
 
 static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 {
-	static struct cpu_signature prev;
 	struct cpuinfo_x86 *c = &cpu_data(cpu_num);
 	unsigned int val[2];
 
@@ -570,13 +569,6 @@ static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 
 	csig->rev = c->microcode;
 
-	/* No extra locking on prev, races are harmless. */
-	if (csig->sig != prev.sig || csig->pf != prev.pf || csig->rev != prev.rev) {
-		pr_info("sig=0x%x, pf=0x%x, revision=0x%x\n",
-			csig->sig, csig->pf, csig->rev);
-		prev = *csig;
-	}
-
 	return 0;
 }
 
