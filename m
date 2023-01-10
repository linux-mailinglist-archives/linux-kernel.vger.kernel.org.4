Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FC766404F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbjAJMUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbjAJMUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:20:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370053AABC;
        Tue, 10 Jan 2023 04:18:41 -0800 (PST)
Date:   Tue, 10 Jan 2023 12:18:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673353119;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fb5b5jauiae9ghxl1JxaYK6Ya2SY98lc1aCms5g0aRk=;
        b=On1VSEdZla0Bmw/KcfSSyN8pkTX2ITn9TzKynwqr7BH9INMDG/Qy0dzlOQkKS1Jz+0CLLi
        2XJh60gRQWkwKy+OXSwl+t9bpiIiXl4m5A4YhTLzIgdFiIZKruR5hNKOJEvp7stFXnggMz
        VUPzB8bntoxeDC/+zIgbn9jpyXnMvM+X6CrydDevGiKpNNizylaXFArE/mYHFvBBvZQl9E
        SxDIiK5k8npeXgF1BhA/hrqYLUzfvHEeQbCyAbLW670jnQRfN/ZwQVjnneSk1/zvNl5q4r
        b1+vKGy/mFywNczg/lnaLIJAregEn9TSxeo45gTe9FMEsHT/sBF0PbJRXErXvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673353119;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fb5b5jauiae9ghxl1JxaYK6Ya2SY98lc1aCms5g0aRk=;
        b=3n/1cgJgSrNLpyQpQCpdyd1NSH5sbc6rqEbPCqJxSiRGJkQE+D3WubjpvyKylx69qrqmmq
        pbeOtVHKrjqPJDDQ==
From:   "tip-bot2 for Ashok Raj" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove redundant extern x86_read_arch_cap_msr()
Cc:     Ashok Raj <ashok.raj@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221128172451.792595-1-ashok.raj@intel.com>
References: <20221128172451.792595-1-ashok.raj@intel.com>
MIME-Version: 1.0
Message-ID: <167335311946.4906.3345016453890514965.tip-bot2@tip-bot2>
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

Commit-ID:     bb5525a50601f8be7d0ffb04740e1714506e60c4
Gitweb:        https://git.kernel.org/tip/bb5525a50601f8be7d0ffb04740e1714506e60c4
Author:        Ashok Raj <ashok.raj@intel.com>
AuthorDate:    Mon, 28 Nov 2022 09:24:51 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Jan 2023 12:40:24 +01:00

x86/cpu: Remove redundant extern x86_read_arch_cap_msr()

The prototype for the x86_read_arch_cap_msr() function has moved to
arch/x86/include/asm/cpu.h - kill the redundant definition in arch/x86/kernel/cpu.h
and include the header.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Link: https://lore.kernel.org/r/20221128172451.792595-1-ashok.raj@intel.com
---
 arch/x86/kernel/cpu/bugs.c | 1 +
 arch/x86/kernel/cpu/cpu.h  | 2 --
 arch/x86/kernel/cpu/tsx.c  | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bca0bd8..19e1ce0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -33,6 +33,7 @@
 #include <asm/e820/api.h>
 #include <asm/hypervisor.h>
 #include <asm/tlbflush.h>
+#include <asm/cpu.h>
 
 #include "cpu.h"
 
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 7c9b589..57a5349 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -83,6 +83,4 @@ unsigned int aperfmperf_get_khz(int cpu);
 extern void x86_spec_ctrl_setup_ap(void);
 extern void update_srbds_msr(void);
 
-extern u64 x86_read_arch_cap_msr(void);
-
 #endif /* ARCH_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index 8009c83..b31ee4f 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -11,6 +11,7 @@
 #include <linux/cpufeature.h>
 
 #include <asm/cmdline.h>
+#include <asm/cpu.h>
 
 #include "cpu.h"
 
