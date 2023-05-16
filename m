Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED83A7048B4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjEPJLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjEPJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CAC46B3;
        Tue, 16 May 2023 02:10:04 -0700 (PDT)
Date:   Tue, 16 May 2023 09:10:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228201;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7OQzWFkolSQOsYYqsopCAhFmKyFXUNICSAqEkkq6TPM=;
        b=CAGLXJfz/VTiIvUNFib/jcfAdQHMkWT4UzffgdXqUOakBbMp3nUjAa9TiXPDvXSCe0pSwn
        GMnWq/AOzFb2Zi3exTyHcXRIVtPfzIqVHnRxks5ik8+1N2K1R3k8/54oCEIsQGLWiPcKNM
        ZvlKmYXxXht5NzYDYghE9BbcjXmyWGZZYMlwLBPPQ7ZZ154SV740vkWSkXy1W/39eNRhMn
        3wdVBOAumpeSOG6Boso7imJFhGLxQnXSU+9sZn0hZMUesSleHZCT+zbb201RH4eFz4xh2t
        m4i+HX315mwqGTS+aGjSuKRTqYdKl5sNOmrugOEIwK3HN4dUlYHbCZii7oM59A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228201;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7OQzWFkolSQOsYYqsopCAhFmKyFXUNICSAqEkkq6TPM=;
        b=u3rck7Jq3dXi9fDsHqNFllI13hwWSNrq8c3H/sN07OnzZReOd/XsZnXCjvQTkYsbqwo4a4
        45RslNeuW/hdzDAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/cpu/cacheinfo: Remove cpu_callout_mask dependency
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205256.035041005@linutronix.de>
References: <20230512205256.035041005@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422820087.404.16340728818249846173.tip-bot2@tip-bot2>
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

Commit-ID:     a32226fa3b7d33d380494cf94cf1d4f8ebb70004
Gitweb:        https://git.kernel.org/tip/a32226fa3b7d33d380494cf94cf1d4f8ebb70004
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:44:52 +02:00

x86/cpu/cacheinfo: Remove cpu_callout_mask dependency

cpu_callout_mask is used for the stop machine based MTRR/PAT init.

In preparation of moving the BP/AP synchronization to the core hotplug
code, use a private CPU mask for cacheinfo and manage it in the
starting/dying hotplug state.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205256.035041005@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 4063e89..8f86eac 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -39,6 +39,8 @@ DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 /* Shared L2 cache maps */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
 
+static cpumask_var_t cpu_cacheinfo_mask;
+
 /* Kernel controls MTRR and/or PAT MSRs. */
 unsigned int memory_caching_control __ro_after_init;
 
@@ -1172,8 +1174,10 @@ void cache_bp_restore(void)
 		cache_cpu_init();
 }
 
-static int cache_ap_init(unsigned int cpu)
+static int cache_ap_online(unsigned int cpu)
 {
+	cpumask_set_cpu(cpu, cpu_cacheinfo_mask);
+
 	if (!memory_caching_control || get_cache_aps_delayed_init())
 		return 0;
 
@@ -1191,11 +1195,17 @@ static int cache_ap_init(unsigned int cpu)
 	 *      lock to prevent MTRR entry changes
 	 */
 	stop_machine_from_inactive_cpu(cache_rendezvous_handler, NULL,
-				       cpu_callout_mask);
+				       cpu_cacheinfo_mask);
 
 	return 0;
 }
 
+static int cache_ap_offline(unsigned int cpu)
+{
+	cpumask_clear_cpu(cpu, cpu_cacheinfo_mask);
+	return 0;
+}
+
 /*
  * Delayed cache initialization for all AP's
  */
@@ -1210,9 +1220,12 @@ void cache_aps_init(void)
 
 static int __init cache_ap_register(void)
 {
+	zalloc_cpumask_var(&cpu_cacheinfo_mask, GFP_KERNEL);
+	cpumask_set_cpu(smp_processor_id(), cpu_cacheinfo_mask);
+
 	cpuhp_setup_state_nocalls(CPUHP_AP_CACHECTRL_STARTING,
 				  "x86/cachectrl:starting",
-				  cache_ap_init, NULL);
+				  cache_ap_online, cache_ap_offline);
 	return 0;
 }
-core_initcall(cache_ap_register);
+early_initcall(cache_ap_register);
