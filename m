Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DF76B0FF9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCHROc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCHROQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:14:16 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBA850733
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:13:35 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c18so10256641wmr.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 09:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678295614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUjr+8cgLd6gmPZkTuHe/Ygcx47oBqmxT7R6x/XWqS8=;
        b=bNWDgPzoLQLOqg8AE6uWEbNXl4zG43Wsz24hnKkhjTSLpa9/N/89UIhg3S2GDsQKKS
         DwdmDgzA2grwz4q8vMc7MvozQO0TnrO7phBtxhNf7SpUOlMUpimX7cKughPMIMYF4Cd7
         YwFqUmpsR5+Yo8mBwA5yq4MR6M4Tx3yYHTfST4xYNdlRshfAglKteDTzAjDSOoJ2xnuM
         IZfUwvwBw8g8EosQZ1uQxleKQk4wwXqjd6YwaT9Qcy+4x01mdWnUM2f0M5y3G9wtCo1t
         4w1vo2ZDFZTUsiA9iIHFGyiEr8TjPbCaPduA5ascX1ukKXeyGzniwrtm7Ow0ZU2BKvds
         fGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678295614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUjr+8cgLd6gmPZkTuHe/Ygcx47oBqmxT7R6x/XWqS8=;
        b=vDADeAr7xtYjp1jPA8Cqc2707fP/HaiX9CddX30qMArPPWz4sIeYO828JJkWg6bkEK
         dFbcwMMLtTFxBtSUsLMguutO+g5o7sB5gij4vW++iQjRJm3yRbk6n95e+l+51SaTppsP
         2o7IUWTlPZqcfPFg+wc42M/EfDsDZ3uxGkR5Z1LUdb6gNHakGAumqJLoW/DhMNZk/0z6
         M0JF2sA3SQGGSWffs5ZVhL8ezIPTq0KQlk3Lcz6LjsKcWzicR8/5HU88nUlE8eFQZRZS
         FsF7JXWBWjse2V4QXLaVPMwV9f+ha0PrA2axR+X8YTxfoKH8E5LTGMrPqNwNQvWKS/iz
         N6Zg==
X-Gm-Message-State: AO0yUKUcNh4v1d1uGZciK8CjqLWF2d+Q9j+jztqWtCDMnaRS2oNJ7bVH
        e0oULVdk0oG9SdNI8hOfQu+8SQ==
X-Google-Smtp-Source: AK7set8Yh5O0bdtUjeaDvGj08rsp9GJ5/mD67z+0ltOWGZ8z+C3oUrBrW9dyzpWyICX3v+qcBJLhFA==
X-Received: by 2002:a05:600c:4f0c:b0:3ea:c100:f18d with SMTP id l12-20020a05600c4f0c00b003eac100f18dmr17273468wmq.9.1678295614088;
        Wed, 08 Mar 2023 09:13:34 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:fe40:3ba4:afe4:4609])
        by smtp.gmail.com with ESMTPSA id l15-20020a1c790f000000b003e0238d9101sm11668wme.31.2023.03.08.09.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 09:13:33 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, kim.phillips@amd.com,
        brgerst@gmail.com
Cc:     piotrgorski@cachyos.org, oleksandr@natalenko.name,
        arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH v14 03/12] cpu/hotplug: Add dynamic parallel bringup states before CPUHP_BRINGUP_CPU
Date:   Wed,  8 Mar 2023 17:13:19 +0000
Message-Id: <20230308171328.1562857-4-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308171328.1562857-1-usama.arif@bytedance.com>
References: <20230308171328.1562857-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

There is often significant latency in the early stages of CPU bringup,
and time is wasted by waking each CPU (e.g. with SIPI/INIT/INIT on x86)
and then waiting for it to respond before moving on to the next.

Allow a platform to register a set of pre-bringup CPUHP states to which
each CPU can be stepped in parallel, thus absorbing some of that latency.

There is a subtlety here: even with an empty CPUHP_BP_PARALLEL_DYN step,
this means that *all* CPUs are brought through the prepare states and to
CPUHP_BP_PREPARE_DYN before any of them are taken to CPUHP_BRINGUP_CPU
and then are allowed to run for themselves to CPUHP_ONLINE.

So any combination of prepare/start calls which depend on A-B ordering
for each CPU in turn, such as the X2APIC code which used to allocate a
cluster mask 'just in case' and store it in a global variable in the
prep stage, then potentially consume that preallocated structure from
the AP and set the global pointer to NULL to be reallocated in
CPUHP_X2APIC_PREPARE for the next CPU... would explode horribly.

Any platform enabling the CPUHP_BP_PARALLEL_DYN steps must be reviewed
and tested to ensure that such issues do not exist, and the existing
behaviour of bringing CPUs to CPUHP_BP_PREPARE_DYN and then immediately
to CPUHP_BRINGUP_CPU and CPUHP_ONLINE only one at a time does not change
unless such a state is registered.

Note that the new parallel stages do *not* yet bring each AP to the
CPUHP_BRINGUP_CPU state at the same time, only to the new states which
exist before it. The final loop in bringup_nonboot_cpus() is untouched,
bringing each AP in turn from the final PARALLEL_DYN state (or all the
way from CPUHP_OFFLINE) to CPUHP_BRINGUP_CPU and then waiting for that
AP to do its own processing and reach CPUHP_ONLINE before releasing the
next.

Parallelising that part by bringing them all to CPUHP_BRINGUP_CPU
and then waiting for them all is an exercise for the future.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Kim Phillips <kim.phillips@amd.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 include/linux/cpuhotplug.h |  2 ++
 kernel/cpu.c               | 31 +++++++++++++++++++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 6c6859bfc454..e5a73ae6ccc0 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -133,6 +133,8 @@ enum cpuhp_state {
 	CPUHP_MIPS_SOC_PREPARE,
 	CPUHP_BP_PREPARE_DYN,
 	CPUHP_BP_PREPARE_DYN_END		= CPUHP_BP_PREPARE_DYN + 20,
+	CPUHP_BP_PARALLEL_DYN,
+	CPUHP_BP_PARALLEL_DYN_END		= CPUHP_BP_PARALLEL_DYN + 4,
 	CPUHP_BRINGUP_CPU,
 
 	/*
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6c0a92ca6bb5..fffb0da61ccc 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1504,8 +1504,30 @@ int bringup_hibernate_cpu(unsigned int sleep_cpu)
 
 void bringup_nonboot_cpus(unsigned int setup_max_cpus)
 {
+	unsigned int n = setup_max_cpus - num_online_cpus();
 	unsigned int cpu;
 
+	/*
+	 * An architecture may have registered parallel pre-bringup states to
+	 * which each CPU may be brought in parallel. For each such state,
+	 * bring N CPUs to it in turn before the final round of bringing them
+	 * online.
+	 */
+	if (n > 0) {
+		enum cpuhp_state st = CPUHP_BP_PARALLEL_DYN;
+
+		while (st <= CPUHP_BP_PARALLEL_DYN_END && cpuhp_hp_states[st].name) {
+			int i = n;
+
+			for_each_present_cpu(cpu) {
+				cpu_up(cpu, st);
+				if (!--i)
+					break;
+			}
+			st++;
+		}
+	}
+
 	for_each_present_cpu(cpu) {
 		if (num_online_cpus() >= setup_max_cpus)
 			break;
@@ -1882,6 +1904,10 @@ static int cpuhp_reserve_state(enum cpuhp_state state)
 		step = cpuhp_hp_states + CPUHP_BP_PREPARE_DYN;
 		end = CPUHP_BP_PREPARE_DYN_END;
 		break;
+	case CPUHP_BP_PARALLEL_DYN:
+		step = cpuhp_hp_states + CPUHP_BP_PARALLEL_DYN;
+		end = CPUHP_BP_PARALLEL_DYN_END;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1906,14 +1932,15 @@ static int cpuhp_store_callbacks(enum cpuhp_state state, const char *name,
 	/*
 	 * If name is NULL, then the state gets removed.
 	 *
-	 * CPUHP_AP_ONLINE_DYN and CPUHP_BP_PREPARE_DYN are handed out on
+	 * CPUHP_AP_ONLINE_DYN and CPUHP_BP_P*_DYN are handed out on
 	 * the first allocation from these dynamic ranges, so the removal
 	 * would trigger a new allocation and clear the wrong (already
 	 * empty) state, leaving the callbacks of the to be cleared state
 	 * dangling, which causes wreckage on the next hotplug operation.
 	 */
 	if (name && (state == CPUHP_AP_ONLINE_DYN ||
-		     state == CPUHP_BP_PREPARE_DYN)) {
+		     state == CPUHP_BP_PREPARE_DYN ||
+		     state == CPUHP_BP_PARALLEL_DYN)) {
 		ret = cpuhp_reserve_state(state);
 		if (ret < 0)
 			return ret;
-- 
2.25.1

