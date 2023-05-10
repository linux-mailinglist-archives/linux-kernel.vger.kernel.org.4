Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A096FDF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbjEJNtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbjEJNtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:49:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7022E5FE9;
        Wed, 10 May 2023 06:49:12 -0700 (PDT)
Date:   Wed, 10 May 2023 13:49:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683726551;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sHJS/7EoNzb+6ZuL9sAOr94pTTj6EYKfBFQrZhf/VNM=;
        b=iVN3X91VSPuCjWJO2SZd5Xy8TOoQllZ5oRTxeJ8kcEbg+GcEfBYWWWgY5ZAuAg8ar1P9Fg
        QLElCT0EEHI+9UdQkC+siE2BXmvoR7H/0BHlzOUB8Sn4G2L599fSUszXyiPmtunVOANYYX
        psAqO3wTQTZgHsGSixT+/E7075KjjtHiyqwMKfk0+JxJiQkf3Ii+whsO2Fea2Cd2A0WaPO
        trxlS8kcwcEZMqgxiUAb02TpuTXiKWR4tA/5Gj0SDHzQjxPneaypcTdYDdSbzdZafu4tru
        aGYlzNdbrcRHd0vjEWnf6XTiPl4iFb2EmrL9MoBc5E0V/qvm1xbmDlceuCIf1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683726551;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sHJS/7EoNzb+6ZuL9sAOr94pTTj6EYKfBFQrZhf/VNM=;
        b=U+7eppPQt8Vgv5TrJorYxO1goYPSh/HRPFxXhjPMJkoYxt3FUpsctTZ4OLLXXkULtEu/2R
        FaZK/KH0Gi2iqxAw==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/sched/itmt: Give all SMT siblings of a core the
 same priority
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230406203148.19182-12-ricardo.neri-calderon@linux.intel.com>
References: <20230406203148.19182-12-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168372655068.404.6128574669002418339.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     046a5a95c3b0425cfe79e43021d8ee90c1c4f8c9
Gitweb:        https://git.kernel.org/tip/046a5a95c3b0425cfe79e43021d8ee90c1c4f8c9
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Thu, 06 Apr 2023 13:31:47 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:38 +02:00

x86/sched/itmt: Give all SMT siblings of a core the same priority

X86 does not have the SD_ASYM_PACKING flag in the SMT domain. The scheduler
knows how to handle SMT and non-SMT cores of different priority. There is
no reason for SMT siblings of a core to have different priorities.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Len Brown <len.brown@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406203148.19182-12-ricardo.neri-calderon@linux.intel.com
---
 arch/x86/kernel/itmt.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 670eb08..ee4fe8c 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -165,32 +165,19 @@ int arch_asym_cpu_priority(int cpu)
 
 /**
  * sched_set_itmt_core_prio() - Set CPU priority based on ITMT
- * @prio:	Priority of cpu core
- * @core_cpu:	The cpu number associated with the core
+ * @prio:	Priority of @cpu
+ * @cpu:	The CPU number
  *
  * The pstate driver will find out the max boost frequency
  * and call this function to set a priority proportional
- * to the max boost frequency. CPU with higher boost
+ * to the max boost frequency. CPUs with higher boost
  * frequency will receive higher priority.
  *
  * No need to rebuild sched domain after updating
  * the CPU priorities. The sched domains have no
  * dependency on CPU priorities.
  */
-void sched_set_itmt_core_prio(int prio, int core_cpu)
+void sched_set_itmt_core_prio(int prio, int cpu)
 {
-	int cpu, i = 1;
-
-	for_each_cpu(cpu, topology_sibling_cpumask(core_cpu)) {
-		int smt_prio;
-
-		/*
-		 * Ensure that the siblings are moved to the end
-		 * of the priority chain and only used when
-		 * all other high priority cpus are out of capacity.
-		 */
-		smt_prio = prio * smp_num_siblings / (i * i);
-		per_cpu(sched_core_priority, cpu) = smt_prio;
-		i++;
-	}
+	per_cpu(sched_core_priority, cpu) = prio;
 }
