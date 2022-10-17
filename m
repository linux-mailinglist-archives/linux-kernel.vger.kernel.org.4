Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38F76011B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiJQOyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiJQOxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:53:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7401968898;
        Mon, 17 Oct 2022 07:53:32 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:53:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666018410;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZruSc3Kfq+CYiRFjzBS2291CgL3iuGM3Epn6RFXv1ZU=;
        b=EtevFTpWdhgRrpZTJUIzSBs/J7IuT0U+1Ef5M2FhvOWc1G8KaW8MUnt0h/AVUqrY2l0x9w
        6JTlYe06sxuaB6sktk3eDXPEtiLnUV5YU4ppzb+uMgHnQoiLwnIjU+N+FU9ta9RA3ZeF+3
        ThVolQD0JRbj023LKFbjQG/4odrbqAe070Av2DQOeg/juTNCMunrmG4GJudijneegaq2Ra
        Jr/lsPWiWWqd4nkO1JDOjDne1/sOQO1ALcfKNxJXbmJuVnyrGegUdE9DjSGstb/Ofsgx5U
        ZTXBI0aciu3YZH/KkdSG9Wu0E7G/3MIr8/zjZm5xxl7SXLKvlqpH4a889d66rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666018410;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZruSc3Kfq+CYiRFjzBS2291CgL3iuGM3Epn6RFXv1ZU=;
        b=JHaLEc+4nSZCGo3V/6mL1qHoKPEVj7D+oJBeLDzXSZRtTr/z4WIB6ot8ECclRJtVkILQhP
        nzpr7cRjybzjm+BA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/retbleed: Add call depth tracking mitigation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220915111149.029587352@infradead.org>
References: <20220915111149.029587352@infradead.org>
MIME-Version: 1.0
Message-ID: <166601840880.401.15353726051870422822.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     d82a0345cf218f5050f5ad913e1ae6c579105731
Gitweb:        https://git.kernel.org/tip/d82a0345cf218f5050f5ad913e1ae6c579105731
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 15 Sep 2022 13:11:38 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Oct 2022 16:41:20 +02:00

x86/retbleed: Add call depth tracking mitigation

The fully secure mitigation for RSB underflow on Intel SKL CPUs is IBRS,
which inflicts up to 30% penalty for pathological syscall heavy work loads.

Software based call depth tracking and RSB refill is not perfect, but
reduces the attack surface massively. The penalty for the pathological case
is about 8% which is still annoying but definitely more palatable than IBRS.

Add a retbleed=stuff command line option to enable the call depth tracking
and software refill of the RSB.

This gives admins a choice. IBeeRS are safe and cause headaches, call depth
tracking is considered to be s(t)ufficiently safe.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111149.029587352@infradead.org
---
 arch/x86/kernel/cpu/bugs.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index da7c361..e6c23ea 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -787,6 +787,7 @@ enum retbleed_mitigation {
 	RETBLEED_MITIGATION_IBPB,
 	RETBLEED_MITIGATION_IBRS,
 	RETBLEED_MITIGATION_EIBRS,
+	RETBLEED_MITIGATION_STUFF,
 };
 
 enum retbleed_mitigation_cmd {
@@ -794,6 +795,7 @@ enum retbleed_mitigation_cmd {
 	RETBLEED_CMD_AUTO,
 	RETBLEED_CMD_UNRET,
 	RETBLEED_CMD_IBPB,
+	RETBLEED_CMD_STUFF,
 };
 
 static const char * const retbleed_strings[] = {
@@ -802,6 +804,7 @@ static const char * const retbleed_strings[] = {
 	[RETBLEED_MITIGATION_IBPB]	= "Mitigation: IBPB",
 	[RETBLEED_MITIGATION_IBRS]	= "Mitigation: IBRS",
 	[RETBLEED_MITIGATION_EIBRS]	= "Mitigation: Enhanced IBRS",
+	[RETBLEED_MITIGATION_STUFF]	= "Mitigation: Stuffing",
 };
 
 static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
@@ -831,6 +834,8 @@ static int __init retbleed_parse_cmdline(char *str)
 			retbleed_cmd = RETBLEED_CMD_UNRET;
 		} else if (!strcmp(str, "ibpb")) {
 			retbleed_cmd = RETBLEED_CMD_IBPB;
+		} else if (!strcmp(str, "stuff")) {
+			retbleed_cmd = RETBLEED_CMD_STUFF;
 		} else if (!strcmp(str, "nosmt")) {
 			retbleed_nosmt = true;
 		} else {
@@ -879,6 +884,21 @@ static void __init retbleed_select_mitigation(void)
 		}
 		break;
 
+	case RETBLEED_CMD_STUFF:
+		if (IS_ENABLED(CONFIG_CALL_DEPTH_TRACKING) &&
+		    spectre_v2_enabled == SPECTRE_V2_RETPOLINE) {
+			retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
+
+		} else {
+			if (IS_ENABLED(CONFIG_CALL_DEPTH_TRACKING))
+				pr_err("WARNING: retbleed=stuff depends on spectre_v2=retpoline\n");
+			else
+				pr_err("WARNING: kernel not compiled with CALL_DEPTH_TRACKING.\n");
+
+			goto do_cmd_auto;
+		}
+		break;
+
 do_cmd_auto:
 	case RETBLEED_CMD_AUTO:
 	default:
@@ -916,6 +936,12 @@ do_cmd_auto:
 		mitigate_smt = true;
 		break;
 
+	case RETBLEED_MITIGATION_STUFF:
+		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
+		setup_force_cpu_cap(X86_FEATURE_CALL_DEPTH);
+		x86_set_skl_return_thunk();
+		break;
+
 	default:
 		break;
 	}
@@ -926,7 +952,7 @@ do_cmd_auto:
 
 	/*
 	 * Let IBRS trump all on Intel without affecting the effects of the
-	 * retbleed= cmdline option.
+	 * retbleed= cmdline option except for call depth based stuffing
 	 */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
 		switch (spectre_v2_enabled) {
@@ -939,7 +965,8 @@ do_cmd_auto:
 			retbleed_mitigation = RETBLEED_MITIGATION_EIBRS;
 			break;
 		default:
-			pr_err(RETBLEED_INTEL_MSG);
+			if (retbleed_mitigation != RETBLEED_MITIGATION_STUFF)
+				pr_err(RETBLEED_INTEL_MSG);
 		}
 	}
 
@@ -1413,6 +1440,7 @@ static void __init spectre_v2_select_mitigation(void)
 		if (IS_ENABLED(CONFIG_CPU_IBRS_ENTRY) &&
 		    boot_cpu_has_bug(X86_BUG_RETBLEED) &&
 		    retbleed_cmd != RETBLEED_CMD_OFF &&
+		    retbleed_cmd != RETBLEED_CMD_STUFF &&
 		    boot_cpu_has(X86_FEATURE_IBRS) &&
 		    boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
 			mode = SPECTRE_V2_IBRS;
