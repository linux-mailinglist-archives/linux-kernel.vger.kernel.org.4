Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7842767942C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjAXJ1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjAXJ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:26:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90989166FE;
        Tue, 24 Jan 2023 01:26:42 -0800 (PST)
Date:   Tue, 24 Jan 2023 09:26:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674552398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D9+4FqzVN6yHwsZH8nmnirIPk/S9zmiwRVxT8drMYYs=;
        b=wc3DZmkhjRDSDejd9PKHVAtlgKYPZKaAIEte1KDNuEkwBtracP4UQ6+HgQbvYQe7F0SveF
        DrxOUIniT7sHsYveZhl1mt7ITSJn1cbS4sDAgVSwYGfTpS9VjZ87Iw+84BRcBFuWB2Co7j
        JTKbyNe1Wpb3v5GrtiuySCSvr8aBsHoe9zpTDxtHtnbs6Fbetik6sopLEJkwPuhnEecLRk
        l272aT+JBBhfW90FBj7hLNDQYAs4j8FRpGday8rH42PJl8Q9IKzP6iF5teysYf51D4d5rD
        sha6zjq0Q0kAsBgDpRyzxQ252iPlNOBQCK/QRhnqYR71Ai/F8nWZLrU6hh2/ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674552398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D9+4FqzVN6yHwsZH8nmnirIPk/S9zmiwRVxT8drMYYs=;
        b=0pzs2sBCoVe/q5wfPUamKAWz9+l4+NNEo5iWckcziG+zZcH7XIdw3p3wEqtp4e0mwMQvYv
        9ZpVNmQCYQ6r6DCw==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230113152039.770054-5-babu.moger@amd.com>
References: <20230113152039.770054-5-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <167455239782.4906.6251371979031301999.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     78335aac6156eadad0025ab34469e2adcc60218b
Gitweb:        https://git.kernel.org/tip/78335aac6156eadad0025ab34469e2adcc60218b
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 13 Jan 2023 09:20:30 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Jan 2023 17:38:31 +01:00

x86/cpufeatures: Add Bandwidth Monitoring Event Configuration feature flag

Newer AMD processors support the new feature Bandwidth Monitoring Event
Configuration (BMEC).

The feature support is identified via CPUID Fn8000_0020_EBX_x0[3]: EVT_CFG -
Bandwidth Monitoring Event Configuration (BMEC)

The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes are set to
count all the total and local reads/writes, respectively. With the introduction
of slow memory, the two counters are not enough to count all the different types
of memory events. Therefore, BMEC provides the option to configure
mbm_total_bytes and mbm_local_bytes to count the specific type of events.

Each BMEC event has a configuration MSR which contains one field for each
bandwidth type that can be used to configure the bandwidth event to track any
combination of supported bandwidth types. The event will count requests from
every bandwidth type bit that is set in the corresponding configuration
register.

Following are the types of events supported:

  ====    ========================================================
  Bits    Description
  ====    ========================================================
  6       Dirty Victims from the QOS domain to all types of memory
  5       Reads to slow memory in the non-local NUMA domain
  4       Reads to slow memory in the local NUMA domain
  3       Non-temporal writes to non-local NUMA domain
  2       Non-temporal writes to local NUMA domain
  1       Reads to memory in the non-local NUMA domain
  0       Reads to memory in the local NUMA domain
  ====    ========================================================

By default, the mbm_total_bytes configuration is set to 0x7F to count
all the event types and the mbm_local_bytes configuration is set to 0x15 to
count all the local memory events.

Feature description is available in the specification, "AMD64 Technology
Platform Quality of Service Extensions, Revision: 1.03 Publication" at
https://bugzilla.kernel.org/attachment.cgi?id=301365

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20230113152039.770054-5-babu.moger@amd.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 2 ++
 arch/x86/kernel/cpu/scattered.c    | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3f5f64b..f6a41ec 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -308,6 +308,7 @@
 #define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for RSB stuffing */
 #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
 #define X86_FEATURE_SMBA		(11*32+21) /* "" Slow Memory Bandwidth Allocation */
+#define X86_FEATURE_BMEC		(11*32+22) /* "" Bandwidth Monitoring Event Configuration */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index d952211..f6748c8 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -68,6 +68,8 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_CQM_OCCUP_LLC,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_CQM_MBM_TOTAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
+	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_TOTAL   },
+	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_LOCAL   },
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index d925753..0dad49a 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -46,6 +46,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
+	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ 0, 0, 0, 0, 0 }
