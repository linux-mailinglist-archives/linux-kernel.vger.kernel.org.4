Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7D1610A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJ1GoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiJ1GmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:42:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681B91BA1F4;
        Thu, 27 Oct 2022 23:42:19 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:42:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HyeRwTx9QE2PvrbjNs8IROLnWS2slvMmLoZ1ptritHY=;
        b=tONwv+eYyYe+WRYSNNannwL0fBDteHu9Ty9WMhwj1XUV9kU/nrcD3C/SQqINAMfli939et
        0A9QYf6+U0GKUoBt3I/0f9vYQvdPg55Wjin/l/mhvZom55A9NvlBJU3zjOhc/gi5bZ9S8/
        Rfl/WfRhhlRljtmfhbeXw/DpR0rvSFyXU2ue3Vq/mwfq/tDP63yjxZt6XJrttgW2L7cvfK
        tPn0ZjQb/oTC56VLZoR6GoJfG8cfblPhNMHRFNPz9tdocHvZb39V+VWnpvrGte0jMv7ncU
        V/7Du6uE+EWfGiDQ6blR2aILox+i8f2t1P00rSFk85WcMJWaLzWs88k3j+0YrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HyeRwTx9QE2PvrbjNs8IROLnWS2slvMmLoZ1ptritHY=;
        b=vBrUM9YFgM3i99e64u5hgUj0NSVawCqLJyB4s03uEKLV3xxDsaVmczYfULvsfIkw6BUZ5k
        0NPJzh3tZ4WLuWAg==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Consider capacity inversion in util_fits_cpu()
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220804143609.515789-10-qais.yousef@arm.com>
References: <20220804143609.515789-10-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <166693933665.29415.17740207940084118097.tip-bot2@tip-bot2>
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

Commit-ID:     aa69c36f31aadc1669bfa8a3de6a47b5e6c98ee8
Gitweb:        https://git.kernel.org/tip/aa69c36f31aadc1669bfa8a3de6a47b5e6c98ee8
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Thu, 04 Aug 2022 15:36:09 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 11:01:20 +02:00

sched/fair: Consider capacity inversion in util_fits_cpu()

We do consider thermal pressure in util_fits_cpu() for uclamp_min only.
With the exception of the biggest cores which by definition are the max
performance point of the system and all tasks by definition should fit.

Even under thermal pressure, the capacity of the biggest CPU is the
highest in the system and should still fit every task. Except when it
reaches capacity inversion point, then this is no longer true.

We can handle this by using the inverted capacity as capacity_orig in
util_fits_cpu(). Which not only addresses the problem above, but also
ensure uclamp_max now considers the inverted capacity. Force fitting
a task when a CPU is in this adverse state will contribute to making the
thermal throttling last longer.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220804143609.515789-10-qais.yousef@arm.com
---
 kernel/sched/fair.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4c4ea47..919d016 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4465,12 +4465,16 @@ static inline int util_fits_cpu(unsigned long util,
 	 * For uclamp_max, we can tolerate a drop in performance level as the
 	 * goal is to cap the task. So it's okay if it's getting less.
 	 *
-	 * In case of capacity inversion, which is not handled yet, we should
-	 * honour the inverted capacity for both uclamp_min and uclamp_max all
-	 * the time.
+	 * In case of capacity inversion we should honour the inverted capacity
+	 * for both uclamp_min and uclamp_max all the time.
 	 */
-	capacity_orig = capacity_orig_of(cpu);
-	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
+	capacity_orig = cpu_in_capacity_inversion(cpu);
+	if (capacity_orig) {
+		capacity_orig_thermal = capacity_orig;
+	} else {
+		capacity_orig = capacity_orig_of(cpu);
+		capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
+	}
 
 	/*
 	 * We want to force a task to fit a cpu as implied by uclamp_max.
