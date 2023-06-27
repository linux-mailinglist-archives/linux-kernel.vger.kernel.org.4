Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF91373F5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjF0H3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjF0H25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:28:57 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A99B30EC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:28:19 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id A3F4520C08E6;
        Tue, 27 Jun 2023 00:28:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A3F4520C08E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1687850898;
        bh=rDEzAo1VXiqZ899g34kuC/RyTIU/6VEVuMbphol/K90=;
        h=From:To:Cc:Subject:Date:From;
        b=eHqDSHgaNLW4PuVGscrgqX+BPFfVXaaTGgU2mhwcXz5xx+XneMb8R44FzIk7m6nW2
         IPAz2VRxb/eIIHw3XspUTYo6kHx0rn6uyO8kHhejcIqP6vOSITUtfFl+d1L7tTWwD7
         tAy6Dc20gvpk19edsnxxn0iRTShJZFvoCsgFJwe4=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org
Cc:     ssengar@linux.microsoft.com
Subject: [PATCH] x86/numa: Add Devicetree support
Date:   Tue, 27 Jun 2023 00:28:02 -0700
Message-Id: <1687850882-22554-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper-V has usecases where it need to fetch NUMA information from
Devicetree. Currently, it is not possible to extract the NUMA
information from Devicetree for x86 arch.

Add support for Devicetree in the x86_numa_init function, allowing
the retrieval of NUMA node information from the Devicetree.

Additionally, relocate the x86_dtb_init function before initmem_init
to ensure the Devicetree initialization prior to its utilization in
x86_numa_init.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/Kconfig        | 1 +
 arch/x86/kernel/setup.c | 2 +-
 arch/x86/mm/numa.c      | 3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c531b16ee0bf..a2ada193b2d8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1567,6 +1567,7 @@ config NUMA
 	depends on X86_64 || (X86_32 && HIGHMEM64G && X86_BIGSMP)
 	default y if X86_BIGSMP
 	select USE_PERCPU_NUMA_NODE_ID
+	select OF_NUMA if OF
 	help
 	  Enable NUMA (Non-Uniform Memory Access) support.
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index fd975a4a5200..940c92a6a5e9 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1220,6 +1220,7 @@ void __init setup_arch(char **cmdline_p)
 
 	early_acpi_boot_init();
 
+	x86_dtb_init();
 	initmem_init();
 	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
 
@@ -1261,7 +1262,6 @@ void __init setup_arch(char **cmdline_p)
 	 * Read APIC and some other early information from ACPI tables.
 	 */
 	acpi_boot_init();
-	x86_dtb_init();
 
 	/*
 	 * get boot-time SMP configuration:
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 2aadb2019b4f..a6d3d331fda2 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -11,6 +11,7 @@
 #include <linux/nodemask.h>
 #include <linux/sched.h>
 #include <linux/topology.h>
+#include <linux/of.h>
 
 #include <asm/e820/api.h>
 #include <asm/proto.h>
@@ -733,6 +734,8 @@ void __init x86_numa_init(void)
 		if (!numa_init(amd_numa_init))
 			return;
 #endif
+		if (acpi_disabled && !numa_init(of_numa_init))
+			return;
 	}
 
 	numa_init(dummy_numa_init);
-- 
2.34.1

