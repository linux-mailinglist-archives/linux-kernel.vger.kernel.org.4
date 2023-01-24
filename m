Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F3E67942D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjAXJ1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjAXJ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:26:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C403EC6F;
        Tue, 24 Jan 2023 01:26:42 -0800 (PST)
Date:   Tue, 24 Jan 2023 09:26:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674552398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qBHFgcaEcxCbJ7SxUpWAqaqoMPzAcjZlzyfygvrnkQk=;
        b=RXdOuvn6rlxrkus98XtVA4j1lMLAuVPzgjhnIy1hrkajWPfPtOPtQWDNO5RvIlyV4+/p8e
        e9a6rrkFH4l7qSyq4/EbzZXHaADTfHMRlEWuO+w3Fy487jUsXTXBaZX0TD7+oHSNEuLmG0
        pWp08OcU80uYRQ/gC9QQoK/ifT9f/32J/GJFeflRuVksAWKWAys1J96GbaKtDb58xaSySI
        wc1ttxRT2Ka05wI+WJjRMy5zhnfZit6773+b/6NUuANTYqgPHjR5puS5yVnrnt0Q0XFEjF
        SyTyk7CMbc3ykOK5j38TFxfkUc1t7I3Qv2iVnYrUxqm4svx9Fw0hjkqY2L46mQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674552398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qBHFgcaEcxCbJ7SxUpWAqaqoMPzAcjZlzyfygvrnkQk=;
        b=LWQqDlGWxF8wxMVnsHqmQEpMBjyiDBxP89FomWdWb2eUD2xQ4UDmM1VE+lu4eW44cg9v6K
        vds0Aw0aLjT4obAA==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230113152039.770054-3-babu.moger@amd.com>
References: <20230113152039.770054-3-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <167455239836.4906.13232602625549629109.tip-bot2@tip-bot2>
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

Commit-ID:     f334f723a63cfc25789b1cdf70a08ffbaea4bf2e
Gitweb:        https://git.kernel.org/tip/f334f723a63cfc25789b1cdf70a08ffbaea4bf2e
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 13 Jan 2023 09:20:28 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Jan 2023 17:38:17 +01:00

x86/cpufeatures: Add Slow Memory Bandwidth Allocation feature flag

Add the new AMD feature X86_FEATURE_SMBA. With it, the QOS enforcement policies
can be applied to external slow memory connected to the host. QOS enforcement is
accomplished by assigning a Class Of Service (COS) to a processor and specifying
allocations or limits for that COS for each resource to be allocated.

This feature is identified by the CPUID function 0x8000_0020_EBX_x0[2]:
L3SBE - L3 external slow memory bandwidth enforcement.

CXL.memory is the only supported "slow" memory device. With SMBA, the hardware
enables bandwidth allocation on the slow memory devices.  If there are multiple
slow memory devices in the system, then the throttling logic groups all the slow
sources together and applies the limit on them as a whole.

The presence of the SMBA feature (with CXL.memory) is independent of whether
slow memory device is actually present in the system. If there is no slow memory
in the system, then setting a SMBA limit will have no impact on the performance
of the system.

Presence of CXL memory can be identified by the numactl command:

  $numactl -H
  available: 2 nodes (0-1)
  node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
  node 0 size: 63678 MB node 0 free: 59542 MB
  node 1 cpus:
  node 1 size: 16122 MB
  node 1 free: 15627 MB
  node distances:
  node   0   1
     0:  10  50
     1:  50  10

CPU list for CXL memory will be empty. The cpu-cxl node distance is greater than
cpu-to-cpu distances. Node 1 has the CXL memory in this case. CXL memory can
also be identified using ACPI SRAT table and memory maps.

Feature description is available in the specification, "AMD64 Technology
Platform Quality of Service Extensions, Revision: 1.03 Publication # 56375
Revision: 1.03 Issue Date: February 2022" at
https://bugzilla.kernel.org/attachment.cgi?id=301365

See also https://www.amd.com/en/support/tech-docs/amd64-technology-platform-quality-service-extensions

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20230113152039.770054-3-babu.moger@amd.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 6101247..3f5f64b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -307,6 +307,7 @@
 #define X86_FEATURE_SGX_EDECCSSA	(11*32+18) /* "" SGX EDECCSSA user leaf function */
 #define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for RSB stuffing */
 #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
+#define X86_FEATURE_SMBA		(11*32+21) /* "" Slow Memory Bandwidth Allocation */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index f53944f..d925753 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -45,6 +45,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
+	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ 0, 0, 0, 0, 0 }
