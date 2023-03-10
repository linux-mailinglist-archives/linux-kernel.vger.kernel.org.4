Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204646B525F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjCJUz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjCJUyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED7712049D;
        Fri, 10 Mar 2023 12:54:54 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:54:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678481693;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L17bxhc1nYD/tz0DM5CC/W5V0gu76UwGFu/bp0qzPV0=;
        b=sSSWHQ3Ep1fhApERvC5oeVCU0pFjp02Pwf02BoU+vrCG/bEcBLW8AnMYjI6JvxR3SycOzg
        QAiDDpMr6QZrPSudcBAiPH9UAT+so+5BJ/lum4BIRGx9pRhufX2kT5NrNTmgdBR9ft0aV8
        mKqgjbn1hT5+qxItxGs+eQuJAoedhSMjumtF2dxAoN+9PTyBRx6yDzIQvNtFfNZ+UqnvU2
        OzgevvswkoUNjh7YOJx7PnQj7pjFoRxXyafkmTU9kqHu6pMuNmtG1fVslP6HdzA3HLd6k0
        XD197OSl+35F1UaZNNIH7vRBIzD0VyeVRwKJsrMeQAvuGaSjcZ/hQWfXV23A4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678481693;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L17bxhc1nYD/tz0DM5CC/W5V0gu76UwGFu/bp0qzPV0=;
        b=TnoM7//t+hC9qUBXupRziZ6M1mRhHC6lyYq7bXeYilpx4mVc5Tn73zezPZ7MeYRA2rJiKr
        ry+d5dZNTS4C1SDQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] mips/cpu: Expose play_dead()'s prototype definition
Cc:     Florian Fainelli <f.fainelli@gmail.com>, philmd@linaro.org,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230216184249.ogaqsaykottpxtcb@treble>
References: <20230216184249.ogaqsaykottpxtcb@treble>
MIME-Version: 1.0
Message-ID: <167848169292.5837.17701216467607173037.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     142dbcf3b6a93ecfe8ccbee60c611175f5459c23
Gitweb:        https://git.kernel.org/tip/142dbcf3b6a93ecfe8ccbee60c611175f54=
59c23
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 16 Feb 2023 10:42:52 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 08 Mar 2023 08:44:19 -08:00

mips/cpu: Expose play_dead()'s prototype definition

Include <asm/smp.h> to make sure play_dead() matches its prototype going
forward.

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Link: https://lkml.kernel.org/r/20230216184249.ogaqsaykottpxtcb@treble
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/mips/cavium-octeon/smp.c | 1 +
 arch/mips/kernel/smp-bmips.c  | 2 ++
 arch/mips/kernel/smp-cps.c    | 1 +
 arch/mips/loongson64/smp.c    | 1 +
 4 files changed, 5 insertions(+)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 89954f5..4212584 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -20,6 +20,7 @@
 #include <asm/mmu_context.h>
 #include <asm/time.h>
 #include <asm/setup.h>
+#include <asm/smp.h>
=20
 #include <asm/octeon/octeon.h>
=20
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index f5d7bfa..51d5dae 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -54,6 +54,8 @@ static void bmips_set_reset_vec(int cpu, u32 val);
=20
 #ifdef CONFIG_SMP
=20
+#include <asm/smp.h>
+
 /* initial $sp, $gp - used by arch/mips/kernel/bmips_vec.S */
 unsigned long bmips_smp_boot_sp;
 unsigned long bmips_smp_boot_gp;
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 4fc288b..00a0e25 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -20,6 +20,7 @@
 #include <asm/mipsregs.h>
 #include <asm/pm-cps.h>
 #include <asm/r4kcache.h>
+#include <asm/smp.h>
 #include <asm/smp-cps.h>
 #include <asm/time.h>
 #include <asm/uasm.h>
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index 660e1de..4e24b31 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -14,6 +14,7 @@
 #include <linux/cpufreq.h>
 #include <linux/kexec.h>
 #include <asm/processor.h>
+#include <asm/smp.h>
 #include <asm/time.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
