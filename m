Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBED1669749
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbjAMMdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241266AbjAMMcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA9B4D72A;
        Fri, 13 Jan 2023 04:31:10 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pWTyKo6K3mnhY0i107QBhzwJ+zxlbYLQ92Q1X5DIbIY=;
        b=JAmhDchAM1H/s7LwB1vriHvxIShDQhVkW4/C7nA7mV1ktLQd4qqPwx6Zp1zXRxN3EcJvfk
        l5lMrEa/xly9VZRIJF8xRQylFgtiXf9opzjeTHnW+Y+5PYmMU3TlZpXR99gVSGvzqs5AjU
        37tQ6ezIDKxUNRs3NQDnxhOLk+nuv2Q4A2HjOnxQugDNpdfEHZh4H/qnh9JxPmaVt2pV2X
        UNRMxOKBbiIgQB17nEGs/E7ZaL6Nyh8r/O3f8RNmwG4LlRgvcd3TLc+9PHaoDKvprsrXER
        cUfPXtPAUr4x87Zmf/HoLjKLkerdzzlre+bsZ7phza9xjKHXAZRa9bzrpB2e2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pWTyKo6K3mnhY0i107QBhzwJ+zxlbYLQ92Q1X5DIbIY=;
        b=r3v4QUhG2p7+kJjjTFdL47QjNDvpJnwO44Rvxz3RAYOmlPGM26f4sl86FuqqHKsKNVorNU
        UvmFjniiLR9/sBAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arm64, riscv, perf: Remove RCU_NONIDLE() usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195542.151174682@infradead.org>
References: <20230112195542.151174682@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306587.4906.6872487884714268270.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1c38b0615f84f622cd6c821aa40be60fc7f7a096
Gitweb:        https://git.kernel.org/tip/1c38b0615f84f622cd6c821aa40be60fc7f7a096
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:44:00 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:17 +01:00

arm64, riscv, perf: Remove RCU_NONIDLE() usage

The PM notifiers should no longer be ran with RCU disabled (per the
previous patches), as such this hack is no longer required either.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195542.151174682@infradead.org
---
 drivers/perf/arm_pmu.c       | 11 +----------
 drivers/perf/riscv_pmu_sbi.c |  8 +-------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 9b593f9..c34d5fe 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -758,17 +758,8 @@ static void cpu_pm_pmu_setup(struct arm_pmu *armpmu, unsigned long cmd)
 		case CPU_PM_ENTER_FAILED:
 			 /*
 			  * Restore and enable the counter.
-			  * armpmu_start() indirectly calls
-			  *
-			  * perf_event_update_userpage()
-			  *
-			  * that requires RCU read locking to be functional,
-			  * wrap the call within RCU_NONIDLE to make the
-			  * RCU subsystem aware this cpu is not idle from
-			  * an RCU perspective for the armpmu_start() call
-			  * duration.
 			  */
-			RCU_NONIDLE(armpmu_start(event, PERF_EF_RELOAD));
+			armpmu_start(event, PERF_EF_RELOAD);
 			break;
 		default:
 			break;
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index f6507ef..7b2288d 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -771,14 +771,8 @@ static int riscv_pm_pmu_notify(struct notifier_block *b, unsigned long cmd,
 		case CPU_PM_ENTER_FAILED:
 			/*
 			 * Restore and enable the counter.
-			 *
-			 * Requires RCU read locking to be functional,
-			 * wrap the call within RCU_NONIDLE to make the
-			 * RCU subsystem aware this cpu is not idle from
-			 * an RCU perspective for the riscv_pmu_start() call
-			 * duration.
 			 */
-			RCU_NONIDLE(riscv_pmu_start(event, PERF_EF_RELOAD));
+			riscv_pmu_start(event, PERF_EF_RELOAD);
 			break;
 		default:
 			break;
