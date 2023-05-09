Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5236FC8D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbjEIOYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbjEIOYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:24:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B6B13C0D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:23:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24A0DFEC;
        Tue,  9 May 2023 07:24:25 -0700 (PDT)
Received: from e126864.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4407D3F663;
        Tue,  9 May 2023 07:23:38 -0700 (PDT)
From:   Kristina Martsenko <kristina.martsenko@arm.com>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/11] arm64: mops: handle single stepping after MOPS exception
Date:   Tue,  9 May 2023 15:22:32 +0100
Message-Id: <20230509142235.3284028-9-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230509142235.3284028-1-kristina.martsenko@arm.com>
References: <20230509142235.3284028-1-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a MOPS main or epilogue instruction is being executed, the task may
get scheduled on a different CPU and restart execution from the prologue
instruction. If the main or epilogue instruction is being single stepped
then it makes sense to finish the step and take the step exception
before starting to execute the next (prologue) instruction. So
fast-forward the single step state machine when taking a MOPS exception.

This means that if a main or epilogue instruction is single stepped with
ptrace, the debugger will sometimes observe the PC moving back to the
prologue instruction. (As already mentioned, this should be rare as it
only happens when the task is scheduled to another CPU during the step.)

This also ensures that perf breakpoints count prologue instructions
consistently (i.e. every time they are executed), rather than skipping
them when there also happens to be a breakpoint on a main or epilogue
instruction.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/kernel/traps.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 32dc692bffd3..4363e3b53a81 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -563,6 +563,12 @@ void do_el0_mops(struct pt_regs *regs, unsigned long esr)
 		regs->pc -= 8;
 	else
 		regs->pc -= 4;
+
+	/*
+	 * If single stepping then finish the step before executing the
+	 * prologue instruction.
+	 */
+	user_fastforward_single_step(current);
 }
 
 #define __user_cache_maint(insn, address, res)			\
-- 
2.25.1

