Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE08694F43
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjBMS0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBMS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:26:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52198729D;
        Mon, 13 Feb 2023 10:26:24 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:26:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676312782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RxZ6aEw3H1EuT2X6ppE3XEZQ1Z1VXyr9nlIu9qn19Qc=;
        b=iLaTSgQYQET1J7W4wFNlcu0sfv2//HPknQ7hXje8H8+Oc3vRfutPtQmCaKh6nKseuFu9+L
        St7GJjbiJJ/LcUM0M2m9ldPqGaV/odJ/uFXqgeVe+MzAijEVLY/VzTJguC8IktU78DfBzQ
        +AXkiufO417wPkM8qWuCeI6CbcNjhV6bRcpKAjL8iMh2Izt5c94w8xOGIOVTdKoAbfM6ad
        80o2Z9qKOfdvzZPMjvevZIb8PKOfGjD6wfvRtxaiYbyQv2OTjoNOyHCeY58Z4BImc6aGvZ
        LsLhYIkJVlacGqL03HE/LX/4gBW49VE/2TFKOVNXd7mvJU2CrJznWpdbUbdrFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676312782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RxZ6aEw3H1EuT2X6ppE3XEZQ1Z1VXyr9nlIu9qn19Qc=;
        b=SX24IGfI5Ake/fd0DDZE0y/CdLn2+nlRBOspAThuExdM49VdMl0IURXm0myiVO4d3U3zeu
        l28bPq97Q7WbHQBw==
From:   "tip-bot2 for Matt Evans" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/riscv: Patch
 riscv_clock_next_event() jump before first use
Cc:     Matt Evans <mev@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <CDDAB2D0-264E-42F3-8E31-BA210BEB8EC1@rivosinc.com>
References: <CDDAB2D0-264E-42F3-8E31-BA210BEB8EC1@rivosinc.com>
MIME-Version: 1.0
Message-ID: <167631278248.4906.12382142113673648566.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     225b9596cb0227c1c1b1e4a836dad43595c3e61a
Gitweb:        https://git.kernel.org/tip/225b9596cb0227c1c1b1e4a836dad43595c3e61a
Author:        Matt Evans <mev@rivosinc.com>
AuthorDate:    Wed, 01 Feb 2023 19:49:42 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 13 Feb 2023 13:10:17 +01:00

clocksource/drivers/riscv: Patch riscv_clock_next_event() jump before first use

A static key is used to select between SBI and Sstc timer usage in
riscv_clock_next_event(), but currently the direction is resolved
after cpuhp_setup_state() is called (which sets the next event).  The
first event will therefore fall through the sbi_set_timer() path; this
breaks Sstc-only systems.  So, apply the jump patching before first
use.

Fixes: 9f7a8ff6391f ("RISC-V: Prefer sstc extension if available")
Signed-off-by: Matt Evans <mev@rivosinc.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/r/CDDAB2D0-264E-42F3-8E31-BA210BEB8EC1@rivosinc.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-riscv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index d8cb629..5f0f10c 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -192,6 +192,11 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 		return error;
 	}
 
+	if (riscv_isa_extension_available(NULL, SSTC)) {
+		pr_info("Timer interrupt in S-mode is available via sstc extension\n");
+		static_branch_enable(&riscv_sstc_available);
+	}
+
 	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
 			 "clockevents/riscv/timer:starting",
 			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
@@ -199,11 +204,6 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
 		       error);
 
-	if (riscv_isa_extension_available(NULL, SSTC)) {
-		pr_info("Timer interrupt in S-mode is available via sstc extension\n");
-		static_branch_enable(&riscv_sstc_available);
-	}
-
 	return error;
 }
 
