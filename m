Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620136260AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiKKRuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiKKRuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:50:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2545A78782;
        Fri, 11 Nov 2022 09:50:06 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:50:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668189003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/M7S9czl9l5Pm5Q6ZrOdlNcR7jX39FnWeWvm4H7tNT4=;
        b=UV7VaeG1V5L2i6GNTHsx4ygpNynDfl3Yx4hNIb04TOwXxe4qt8yU+DTdKDCCrFjsrsETOV
        qtTkcwPP4Sm+PzE9u/prjcKSXkunSgKBfbAlenMgelfUWTUBC7W5Ax8/HIvMcDqRsVIDA7
        FSmvvycGoKX3CtzWvmNwlF/30UMg00rowaI1SE41DMS7XJ05dWoqIU02jy9gjxSLA18egx
        WPV/fksv/2Usi9wevP6Zhdzo5KeOEVnPp6/M4F5LDjfxOMhf3DzZ01MZdBoYXZSJ0h0ujT
        P2GiMqmYZ2bnw9gFJiq/txhtUAGhqAnomHFJ+OeJeOsy8abU18pdVUj3RwnkZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668189003;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/M7S9czl9l5Pm5Q6ZrOdlNcR7jX39FnWeWvm4H7tNT4=;
        b=qS5UulMPFjeD7FiFpTrzgrr/QR0B0nRgWyRrSEMU89FJbS7nYjscVXMQUWD3tnkr9/awK7
        PORyMnILaAVp/RCQ==
From:   "tip-bot2 for Tony W Wang-oc" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/acpi/cstate: Optimize ARB_DISABLE on Centaur CPUs
Cc:     "Tony W Wang-oc" <TonyWWang-oc@zhaoxin.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166818900226.4906.17553043807216439790.tip-bot2@tip-bot2>
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

Commit-ID:     dacca1e5e75d7c1297f1334cdc10491dcdd1b2b8
Gitweb:        https://git.kernel.org/tip/dacca1e5e75d7c1297f1334cdc10491dcdd1b2b8
Author:        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
AuthorDate:    Mon, 07 Nov 2022 11:34:49 +08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 11 Nov 2022 09:42:05 -08:00

x86/acpi/cstate: Optimize ARB_DISABLE on Centaur CPUs

On all recent Centaur platforms, ARB_DISABLE is handled by PMU
automatically while entering C3 type state. No need for OS to
issue the ARB_DISABLE, so set bm_control to zero to indicate that.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/all/1667792089-4904-1-git-send-email-TonyWWang-oc%40zhaoxin.com
---
 arch/x86/kernel/acpi/cstate.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 7945eae..401808b 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -52,17 +52,25 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 	if (c->x86_vendor == X86_VENDOR_INTEL &&
 	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
 			flags->bm_control = 0;
-	/*
-	 * For all recent Centaur CPUs, the ucode will make sure that each
-	 * core can keep cache coherence with each other while entering C3
-	 * type state. So, set bm_check to 1 to indicate that the kernel
-	 * doesn't need to execute a cache flush operation (WBINVD) when
-	 * entering C3 type state.
-	 */
+
 	if (c->x86_vendor == X86_VENDOR_CENTAUR) {
 		if (c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0x0f &&
-		    c->x86_stepping >= 0x0e))
+		    c->x86_stepping >= 0x0e)) {
+			/*
+			 * For all recent Centaur CPUs, the ucode will make sure that each
+			 * core can keep cache coherence with each other while entering C3
+			 * type state. So, set bm_check to 1 to indicate that the kernel
+			 * doesn't need to execute a cache flush operation (WBINVD) when
+			 * entering C3 type state.
+			 */
 			flags->bm_check = 1;
+			/*
+			 * For all recent Centaur platforms, ARB_DISABLE is a nop.
+			 * Set bm_control to zero to indicate that ARB_DISABLE is
+			 * not required while entering C3 type state.
+			 */
+			flags->bm_control = 0;
+		}
 	}
 
 	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
