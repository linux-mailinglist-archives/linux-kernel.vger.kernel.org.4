Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A024686FF4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 21:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjBAUpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 15:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjBAUpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 15:45:09 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2873178ACE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 12:44:55 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m7so18494526wru.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 12:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTNF1JvfCDajsaqBdlIe78iIn+/3qna+HTWlbtJK4ls=;
        b=PHsc2s0l5yODha3GL0699EVouPw2t2VyZ/NpijjKErd/Wse0mkuoPmiTOTBFK5druj
         O+8z9IC64HBK0PtRhvS00L1CHOP2Tt1XQgtckGVJrZCTenGyOpEdLF2JkiQ5W6uThjvg
         tMwTIAehAFNjejO5Fr1XdrMjLCqVEk0WzwMrrB1yFj9MMznXnzgGoYBfY9Q/uxOzjYYW
         iEpO5m6XjptcngDjwzD6aUIAmWwlDi3xWVhjEBAqmAIBiPGHAO6Z+AQUXn6HQwvkOdfm
         I8kjD6IWRNSzffMbkewI0/3WzZrr5qqOUkRNV+5PWo7liabF2u7hWJKLTAXVYKwlCHV0
         w+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTNF1JvfCDajsaqBdlIe78iIn+/3qna+HTWlbtJK4ls=;
        b=sSbDhwZVULgb0lnpZTIYRO3V4b+qwL3s4mW4O0qZmzz+jgZc5qnnY7y2j7bxLAX0DL
         MbkYgadzfdJRCOLRNOS1Bn/B+ZgjviLlOwqs4fyD6X5n4+0m5Tv71uFbu+i2HnzCuMRn
         o5kP5oou0nYGufa86RICLvCpXKkKdRCMCZHJTHMWOICLacQ3E+mceM+5YrC3IRZVwrqA
         NDoX2roaWMNuZ+0JMG/UKpt5PmlJSCTsbrJ7xAbG3zQY8ed4eZ5J6cyhVEsTPqcXSLZi
         YHuBIE06pYOmq2K6TK3obR2uGXNUymz884flqv1Pau8nHaQVJjiqeVkMl3aU6Mf+8IZh
         I8iA==
X-Gm-Message-State: AO0yUKW1Y7mVJqb1QcdWjG4xWT9U2XaY3mbRnOR+PSqJn2uW4iTM+zpl
        +/LSjzEvVpbaIHiY2cPaGoIvcA==
X-Google-Smtp-Source: AK7set9K2jZQ3dASQTukVtaV7ib8QH+uixLDVCS8g+33bcBHV6hPhsVaFGTs1vQxeonMHtYAgViYGg==
X-Received: by 2002:a5d:560e:0:b0:2bf:cfb4:817c with SMTP id l14-20020a5d560e000000b002bfcfb4817cmr3484247wrv.35.1675284293632;
        Wed, 01 Feb 2023 12:44:53 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:7611:c340:3d8d:d46c])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d598f000000b002bdff778d87sm19993584wri.34.2023.02.01.12.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 12:44:53 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com, David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH 7/9] x86/smpboot: Send INIT/SIPI/SIPI to secondary CPUs in parallel
Date:   Wed,  1 Feb 2023 20:43:36 +0000
Message-Id: <20230201204338.1337562-8-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230201204338.1337562-1-usama.arif@bytedance.com>
References: <20230201204338.1337562-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

When the APs can find their own APIC ID without assistance, we can do
the AP bringup in parallel.

Register a CPUHP_BP_PARALLEL_DYN stage "x86/cpu:kick" which just calls
do_boot_cpu() to deliver INIT/SIPI/SIPI to each AP in turn before the
normal native_cpu_up() does the rest of the hand-holding.

The APs will then take turns through the real mode code (which has its
own bitlock for exclusion) until they make it to their own stack, then
proceed through the first few lines of start_secondary() and execute
these parts in parallel:

 start_secondary()
    -> cr4_init()
    -> (some 32-bit only stuff so not in the parallel cases)
    -> cpu_init_secondary()
       -> cpu_init_exception_handling()
       -> cpu_init()
          -> wait_for_master_cpu()

At this point they wait for the BSP to set their bit in cpu_callout_mask
(from do_wait_cpu_initialized()), and release them to continue through
the rest of cpu_init() and beyond.

This reduces the time taken for bringup on my 28-thread Haswell system
from about 120ms to 80ms. On a socket 96-thread Skylake it takes the
bringup time from 500ms to 100ms.

There is more speedup to be had by doing the remaining parts in parallel
too — especially notify_cpu_starting() in which the AP takes itself
through all the stages from CPUHP_BRINGUP_CPU to CPUHP_ONLINE. But those
require careful auditing to ensure they are reentrant, before we can go
that far.

[Usama Arif: fixed rebase conflict]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 arch/x86/kernel/smpboot.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 44e9f7ae5afc..060813411f85 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1329,9 +1329,12 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
 	int ret;
 
-	ret = do_cpu_up(cpu, tidle);
-	if (ret)
-		return ret;
+	/* If parallel AP bringup isn't enabled, perform the first steps now. */
+	if (!do_parallel_bringup) {
+		ret = do_cpu_up(cpu, tidle);
+		if (ret)
+			return ret;
+	}
 
 	ret = do_wait_cpu_initialized(cpu);
 	if (ret)
@@ -1353,6 +1356,12 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
 	return ret;
 }
 
+/* Bringup step one: Send INIT/SIPI to the target AP */
+static int native_cpu_kick(unsigned int cpu)
+{
+	return do_cpu_up(cpu, idle_thread_get(cpu));
+}
+
 /**
  * arch_disable_smp_support() - disables SMP support for x86 at runtime
  */
@@ -1543,6 +1552,10 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
 		do_parallel_bringup = false;
 
+	if (do_parallel_bringup)
+		cpuhp_setup_state_nocalls(CPUHP_BP_PARALLEL_DYN, "x86/cpu:kick",
+					  native_cpu_kick, NULL);
+
 	snp_set_wakeup_secondary_cpu();
 }
 
-- 
2.25.1

