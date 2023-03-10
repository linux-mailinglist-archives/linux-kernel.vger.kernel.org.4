Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C8E6B5257
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjCJUz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjCJUyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A714108691;
        Fri, 10 Mar 2023 12:54:52 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:54:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678481689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3BQ6Dj0915o2oh6XC8SMcFx7nSKPSAYbv3X7E0pFpJE=;
        b=InErSwIbX5cpM5tbV4rL3MbgIZTZhlg1pFBMXLnlpZy0QgJbNNZ0RlH+6kmeEk/Y3/llFZ
        cR9n3scFAo9kHyW6UmZs7HJVwvpkKBOOo9wB0eqtstgxEC4+bMV+3108LooaJX0UHijhJZ
        2MDNZC/VkGDn3xD6dvU6Ufn5ulkRyoAZ4v4t0D0AhXme+6RMVTA9u3nnXvDLIBQnuOtUNc
        W3gg4nyBSKpQ/wTWjOe8Px1gp6gm+FOmCYD59qfMntb5LCC57mCwJKY5Ax8hp36a5OhyXz
        G3XU3n+gaThcaB7hPMTRr6D9i27ufYMoHX5aO7ZhTY2zlqFAoYjwZGsnG+bLug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678481689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3BQ6Dj0915o2oh6XC8SMcFx7nSKPSAYbv3X7E0pFpJE=;
        b=T78SN5kqaIU5OjXbM5Ii6sBfCq+dHGlWCse5SmT7Tf2gd8lsphkSrex9o1WrHS3LvhJx3w
        M7FtJk27Tz9yw9Cw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/cpu: Mark play_dead() __noreturn
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <f3a069e6869c51ccfdda656b76882363bc9fcfa4.1676358308.git.jpoimboe@kernel.org>
References: <f3a069e6869c51ccfdda656b76882363bc9fcfa4.1676358308.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167848168900.5837.11882743962373893734.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     eab89405b6b59947ee29cc21fb39ead66142c9b5
Gitweb:        https://git.kernel.org/tip/eab89405b6b59947ee29cc21fb39ead66142c9b5
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 23:05:52 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 08 Mar 2023 08:44:26 -08:00

x86/cpu: Mark play_dead() __noreturn

play_dead() doesn't return.  Annotate it as such.  By extension this
also makes arch_cpu_idle_dead() noreturn.

Link: https://lore.kernel.org/r/f3a069e6869c51ccfdda656b76882363bc9fcfa4.1676358308.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/smp.h | 2 +-
 arch/x86/kernel/process.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 8f628e0..e6d1d28 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -93,7 +93,7 @@ static inline void __cpu_die(unsigned int cpu)
 	smp_ops.cpu_die(cpu);
 }
 
-static inline void play_dead(void)
+static inline void __noreturn play_dead(void)
 {
 	smp_ops.play_dead();
 	BUG();
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b650cde..f1ec36c 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -715,7 +715,7 @@ static bool x86_idle_set(void)
 }
 
 #ifndef CONFIG_SMP
-static inline void play_dead(void)
+static inline void __noreturn play_dead(void)
 {
 	BUG();
 }
