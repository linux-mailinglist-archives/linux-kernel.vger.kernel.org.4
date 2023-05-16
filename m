Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F057052A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjEPPrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbjEPPrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:47:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B468729B;
        Tue, 16 May 2023 08:47:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B3D863B8A;
        Tue, 16 May 2023 15:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61C1C433EF;
        Tue, 16 May 2023 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684251994;
        bh=dXBlQ/V//CAld9Zb0TbDNQnCZz81ajEyrr7yhy/j8jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekO8uOzS8UOBScCg/Eh5rmcljFMrzvgoFeydWN9s7Ug6v4YpN5EjcFc7ItImF46UX
         csbTFJ1XI5ClMr6WUYgu1zQ06BkjA0Hfi5zf/XSWCqngzJdgK2qGraMs5u3Kp+XHYF
         2VxYNEAdnVKZI84Bi1390uylmUVmpcgAiAlmrw6mFN/u1kmIqArSy2RBMA9agzdHzJ
         jfmQhITUEAiE2FVI2bP6BaT/qAHp87HicOfHVpAuPrb/ki6SPIN5o2EIw2mEdDoU/r
         Zzoemkp11xwa4EI/lLeUkPxZrABeYu8yF2MCq+QuQG7GESwmZizdtO5iQ628kfFFSL
         Br9U7WFehk8IQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 05/16] ARM: kprobes: avoid missing-declaration warnings
Date:   Tue, 16 May 2023 17:45:54 +0200
Message-Id: <20230516154605.517690-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516154605.517690-1-arnd@kernel.org>
References: <20230516154605.517690-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

checker_stack_use_t32strd() and kprobe_handler() can be made static since
they are not used from other files, while coverage_start_registers()
and __kprobes_test_case() are used from assembler code, and just need
a declaration to avoid a warning with the global definition.

arch/arm/probes/kprobes/checkers-common.c:43:18: error: no previous prototype for 'checker_stack_use_t32strd'
arch/arm/probes/kprobes/core.c:236:16: error: no previous prototype for 'kprobe_handler'
arch/arm/probes/kprobes/test-core.c:723:10: error: no previous prototype for 'coverage_start_registers'
arch/arm/probes/kprobes/test-core.c:918:14: error: no previous prototype for '__kprobes_test_case_start'
arch/arm/probes/kprobes/test-core.c:952:14: error: no previous prototype for '__kprobes_test_case_end_16'
arch/arm/probes/kprobes/test-core.c:967:14: error: no previous prototype for '__kprobes_test_case_end_32'

Fixes: 6624cf651f1a ("ARM: kprobes: collects stack consumption for store instructions")
Fixes: 454f3e132d05 ("ARM/kprobes: Remove jprobe arm implementation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/probes/kprobes/checkers-common.c | 2 +-
 arch/arm/probes/kprobes/core.c            | 2 +-
 arch/arm/probes/kprobes/opt-arm.c         | 2 --
 arch/arm/probes/kprobes/test-core.c       | 2 +-
 arch/arm/probes/kprobes/test-core.h       | 4 ++++
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/probes/kprobes/checkers-common.c b/arch/arm/probes/kprobes/checkers-common.c
index 4d720990cf2a..eba7ac4725c0 100644
--- a/arch/arm/probes/kprobes/checkers-common.c
+++ b/arch/arm/probes/kprobes/checkers-common.c
@@ -40,7 +40,7 @@ enum probes_insn checker_stack_use_imm_0xx(probes_opcode_t insn,
  * Different from other insn uses imm8, the real addressing offset of
  * STRD in T32 encoding should be imm8 * 4. See ARMARM description.
  */
-enum probes_insn checker_stack_use_t32strd(probes_opcode_t insn,
+static enum probes_insn checker_stack_use_t32strd(probes_opcode_t insn,
 		struct arch_probes_insn *asi,
 		const struct decode_header *h)
 {
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 88999ed2cfc4..3ee0e3024ff0 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -233,7 +233,7 @@ singlestep(struct kprobe *p, struct pt_regs *regs, struct kprobe_ctlblk *kcb)
  * kprobe, and that level is reserved for user kprobe handlers, so we can't
  * risk encountering a new kprobe in an interrupt handler.
  */
-void __kprobes kprobe_handler(struct pt_regs *regs)
+static void __kprobes kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p, *cur;
 	struct kprobe_ctlblk *kcb;
diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
index dbef34ed933f..7f65048380ca 100644
--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -145,8 +145,6 @@ __arch_remove_optimized_kprobe(struct optimized_kprobe *op, int dirty)
 	}
 }
 
-extern void kprobe_handler(struct pt_regs *regs);
-
 static void
 optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
 {
diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index c562832b8627..171c7076b89f 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -720,7 +720,7 @@ static const char coverage_register_lookup[16] = {
 	[REG_TYPE_NOSPPCX]	= COVERAGE_ANY_REG | COVERAGE_SP,
 };
 
-unsigned coverage_start_registers(const struct decode_header *h)
+static unsigned coverage_start_registers(const struct decode_header *h)
 {
 	unsigned regs = 0;
 	int i;
diff --git a/arch/arm/probes/kprobes/test-core.h b/arch/arm/probes/kprobes/test-core.h
index 56ad3c0aaeea..c7297037c162 100644
--- a/arch/arm/probes/kprobes/test-core.h
+++ b/arch/arm/probes/kprobes/test-core.h
@@ -454,3 +454,7 @@ void kprobe_thumb32_test_cases(void);
 #else
 void kprobe_arm_test_cases(void);
 #endif
+
+void __kprobes_test_case_start(void);
+void __kprobes_test_case_end_16(void);
+void __kprobes_test_case_end_32(void);
-- 
2.39.2

