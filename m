Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9C26B5264
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjCJU4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjCJUy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4530136894;
        Fri, 10 Mar 2023 12:54:56 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:54:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678481695;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fq5sDqpaaKjEYwGm+P2VoPuD8L7sJUJkorSkQBagyC8=;
        b=0s0uv9r6TFi6zJQw4lU2L8vBImJZYQOrC2zS3u/DZphFHxoZwgIFjZqYQf0X9y19ytmJKI
        yr0PRQaVjiYkAECH7o3oOgbnL4k/MfI2fow9jI1nEYT4GADNvQn5ADtxrzhwEWD0xec2CW
        4yAZvwXPij/goWnotpXhMtHaDcbpepxOXktga4t0buG3WJiu4lJC6EmbQVRZ7HkLV+k2Pp
        YmKEJSfGak0E01Ohgj2B3b0v47AvLiDOfL0gKqCVH/6+tS6jXwQCY7Sd1cIbMreVla5vHH
        lrxYuGKhuXVn2sI9vW56M/e/PFcS9mVR97z/6iCnURTwNc13AcRMsDkJN54LCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678481695;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fq5sDqpaaKjEYwGm+P2VoPuD8L7sJUJkorSkQBagyC8=;
        b=DWuU2TYoQ0rnG4wCCDlb6q8g7njXwp4VdmoNXU8dEBZg1H4wjDVApYrSxCXVdVPtQqJg6C
        9PDxKjE2XVfpFUDw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] arm64/cpu: Mark cpu_die() __noreturn
Cc:     Mark Rutland <mark.rutland@arm.com>, philmd@linaro.org,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230216184157.4hup6y6mmspr2kll@treble>
References: <20230216184157.4hup6y6mmspr2kll@treble>
MIME-Version: 1.0
Message-ID: <167848169508.5837.542474183671220322.tip-bot2@tip-bot2>
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

Commit-ID:     9bdc61ef27db5eaac48f1cc5deb8224603e79c89
Gitweb:        https://git.kernel.org/tip/9bdc61ef27db5eaac48f1cc5deb8224603e=
79c89
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 16 Feb 2023 10:42:01 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 06 Mar 2023 15:34:04 -08:00

arm64/cpu: Mark cpu_die() __noreturn

cpu_die() doesn't return.  Annotate it as such.  By extension this also
makes arch_cpu_idle_dead() noreturn.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Link: https://lkml.kernel.org/r/20230216184157.4hup6y6mmspr2kll@treble
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/include/asm/smp.h | 2 +-
 arch/arm64/kernel/smp.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index fc55f5a..5733a31 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -100,7 +100,7 @@ static inline void arch_send_wakeup_ipi_mask(const struct=
 cpumask *mask)
 extern int __cpu_disable(void);
=20
 extern void __cpu_die(unsigned int cpu);
-extern void cpu_die(void);
+extern void __noreturn cpu_die(void);
 extern void cpu_die_early(void);
=20
 static inline void cpu_park_loop(void)
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 4e83272..d5d09a1 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -361,7 +361,7 @@ void __cpu_die(unsigned int cpu)
  * Called from the idle thread for the CPU which has been shutdown.
  *
  */
-void cpu_die(void)
+void __noreturn cpu_die(void)
 {
 	unsigned int cpu =3D smp_processor_id();
 	const struct cpu_operations *ops =3D get_cpu_ops(cpu);
