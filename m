Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E332E70E181
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbjEWQOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbjEWQOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:14:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119B8C2;
        Tue, 23 May 2023 09:14:00 -0700 (PDT)
Date:   Tue, 23 May 2023 16:13:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684858438;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1o3nB3jocoaLuOI5Obrg0Pu8tnjT0B5WS7aKcG30c3Y=;
        b=Q4wL1SOb9nb9hZJ1ZPygVvgEoQvInC21KXzRQtsc/lO3otIZhyvgiBCTSA1UYwMD16KNrF
        zrV8is0x6hkvRMom/DUqX56fqXhwg6iBByudcInyhv5xMTOvmRIjq8Y5ry1Di2UuM/Tb47
        hM7fWJtDadpsE/FKSCkk4gVJJ7m5ifLyiRnXH7anDyoYRM+xa2i4Tp7TMXibLGmLaVDwsH
        hEqLP82Rewf2Y6G8wGcqCvnvYokBJR+fPYF1Vg3Ltp6vARkxW90dQzC62i/XioLPljtCgT
        9Pz8vWVB4IxhhRSvNE8EYDzlWKBlGngsRkDvTHKQNb+8DW1UJ0cpNZ37lmQbRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684858438;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1o3nB3jocoaLuOI5Obrg0Pu8tnjT0B5WS7aKcG30c3Y=;
        b=Vmkwzh/2Q4t7kGk6VPI59MRREU6bQWu0aOWjFj/YXYkWApAM2zdfCBYGJvBhBkryOcKayc
        2ZenPJQsd0wG1AAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Fix off by one in cpuhp_bringup_mask()
Cc:     Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87wn10ufj9.ffs@tglx>
References: <87wn10ufj9.ffs@tglx>
MIME-Version: 1.0
Message-ID: <168485843734.404.16847199234383553669.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     06c6796e0304234da65e70577f354cb194086521
Gitweb:        https://git.kernel.org/tip/06c6796e0304234da65e70577f354cb194086521
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 23 May 2023 01:12:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 23 May 2023 18:06:40 +02:00

cpu/hotplug: Fix off by one in cpuhp_bringup_mask()

cpuhp_bringup_mask() iterates over a cpumask and starts all present CPUs up
to a caller provided upper limit.

The limit variable is decremented and checked for 0 before invoking
cpu_up(), which is obviously off by one and prevents the bringup of the
last CPU when the limit is equal to the number of present CPUs.

Move the decrement and check after the cpu_up() invocation.

Fixes: 18415f33e2ac ("cpu/hotplug: Allow "parallel" bringup up to CPUHP_BP_KICK_AP_STATE")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/87wn10ufj9.ffs@tglx
---
 kernel/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 005f863..88a7ede 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1770,9 +1770,6 @@ static void __init cpuhp_bringup_mask(const struct cpumask *mask, unsigned int n
 	for_each_cpu(cpu, mask) {
 		struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
 
-		if (!--ncpus)
-			break;
-
 		if (cpu_up(cpu, target) && can_rollback_cpu(st)) {
 			/*
 			 * If this failed then cpu_up() might have only
@@ -1781,6 +1778,9 @@ static void __init cpuhp_bringup_mask(const struct cpumask *mask, unsigned int n
 			 */
 			WARN_ON(cpuhp_invoke_callback_range(false, cpu, st, CPUHP_OFFLINE));
 		}
+
+		if (!--ncpus)
+			break;
 	}
 }
 
