Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A6F6E856D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjDSW6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjDSW5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:57:37 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002148689
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:57:22 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b8b19901fso482898b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681945042; x=1684537042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWZTrwd5TxmiYLg/mD/63PXcodsl+Y0F8uDPTGYpPFY=;
        b=ENMXPNPKpUB8x1TeX9CInNTf6Pzm3ER8KeB8ofn5pxz8+lYuSyslgYS+81+WV7V/1A
         LEf1UqVF5i1wcOYXFEEwNvpTG7LVOyK7V5Mhz7v0lcNNeXQSBJN/9y2kPBa/eges+Jb3
         b6xm1J9kPVn558DdKvWhugxeLv8noIfLhyE0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681945042; x=1684537042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWZTrwd5TxmiYLg/mD/63PXcodsl+Y0F8uDPTGYpPFY=;
        b=FvMZAIicvty5bpZJe+ih745/7PxOVk8Y/I0a7HUf2hxGoydAb36HAzrsT2NFSJ+jvF
         wfpzZowD+sPiMQlT1rnN6Su1XCV9UPYfGVOuJKmPukhiLpPU8+TIThN3H30Ag2WSz/+r
         jaFNVxPHlU4hV3Zcs2vQBYnAuOKFt+0yzD2oV0sNr2Lqnp4Q0OU0tCQcm/hhfl2N7HcZ
         t3UJj7r6/hUl+wSudyLW4EDI3oM3ciZPOB6Mz50KNmZ8XjLKv+Yh4kRT3HnDo/riooho
         smz8CCRoYHEFPXycISBN7lIBmpoMwkTNPsr/JW4K/nyJwwJjKcaxRzDE+4JCXng8/Yup
         WM/A==
X-Gm-Message-State: AAQBX9eerhJnrCTIEjRyDUir0CZJQX38adsN7IEqfmbp6VU03n7YTMv2
        m/LR0SLrgzb4gFbl1eJtOcVlaw==
X-Google-Smtp-Source: AKy350bzal91TPSNwTZw0WiWqcU5p5zvcdk0BkVsNFuBNbks1jS5AwavXMPCBAcH6HwZUkYAxgIWew==
X-Received: by 2002:a05:6a20:8b2f:b0:cc:5f27:d003 with SMTP id l47-20020a056a208b2f00b000cc5f27d003mr42212pzh.56.1681945041867;
        Wed, 19 Apr 2023 15:57:21 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8b1:fa03:670e:b784])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090aea8f00b00246ea338c96sm1847101pjz.53.2023.04.19.15.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:57:21 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 09/10] arm64: kgdb: Roundup cpus using IPI as NMI
Date:   Wed, 19 Apr 2023 15:56:03 -0700
Message-ID: <20230419155341.v8.9.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230419225604.21204-1-dianders@chromium.org>
References: <20230419225604.21204-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sumit Garg <sumit.garg@linaro.org>

arm64 platforms with GICv3 or later supports pseudo NMIs which can be
leveraged to roundup CPUs which are stuck in hard lockup state with
interrupts disabled that wouldn't be possible with a normal IPI.

So instead switch to roundup CPUs using IPI turned as NMI. And in
case a particular arm64 platform doesn't supports pseudo NMIs,
it will switch back to default kgdb CPUs roundup mechanism.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 arch/arm64/kernel/ipi_nmi.c |  5 +++++
 arch/arm64/kernel/kgdb.c    | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
index c592e92b8cbf..2adaaf1519e5 100644
--- a/arch/arm64/kernel/ipi_nmi.c
+++ b/arch/arm64/kernel/ipi_nmi.c
@@ -8,6 +8,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/kgdb.h>
 #include <linux/nmi.h>
 #include <linux/smp.h>
 
@@ -45,10 +46,14 @@ bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 static irqreturn_t ipi_nmi_handler(int irq, void *data)
 {
 	irqreturn_t ret = IRQ_NONE;
+	unsigned int cpu = smp_processor_id();
 
 	if (nmi_cpu_backtrace(get_irq_regs()))
 		ret = IRQ_HANDLED;
 
+	if (!kgdb_nmicallback(cpu, get_irq_regs()))
+		ret = IRQ_HANDLED;
+
 	return ret;
 }
 
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index cda9c1e9864f..2c85bc1df013 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -17,6 +17,7 @@
 
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
+#include <asm/nmi.h>
 #include <asm/patching.h>
 #include <asm/traps.h>
 
@@ -354,3 +355,20 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 	return aarch64_insn_write((void *)bpt->bpt_addr,
 			*(u32 *)bpt->saved_instr);
 }
+
+void kgdb_roundup_cpus(void)
+{
+	struct cpumask mask;
+
+	if (!arm64_supports_nmi()) {
+		kgdb_smp_call_nmi_hook();
+		return;
+	}
+
+	cpumask_copy(&mask, cpu_online_mask);
+	cpumask_clear_cpu(raw_smp_processor_id(), &mask);
+	if (cpumask_empty(&mask))
+		return;
+
+	arm64_send_nmi(&mask);
+}
-- 
2.40.0.634.g4ca3ef3211-goog

