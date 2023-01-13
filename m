Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4136669731
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241466AbjAMMfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241163AbjAMMcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DF7559C1;
        Fri, 13 Jan 2023 04:31:13 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XmlS8EOv1e3rHzLjqaJ8PDK8nkn49/W6t330MrJ1iQs=;
        b=3KftdnkZ+uTCYFtlvPe7u+/Gs2qNEFEhCTboFyADy7csCdYdSuNg/EKLqKOpZzL1kO+2U9
        NO7fGY5uegG0ZavBvPNPGBrWpqjZ2xV+qBQRwbs4WVNE8RzUSeDWtoWwqbdD1WUcLAgqRO
        TeR2wuGnAKpzJWaeXuCL7mTFeFK7hmD+j5oB5WbpGqBZyaEG4cy1735f3pMdjZHqxPp92B
        OhdmcEjjwNIiTlqibeNarLMYy0Ey3oWSQxAZ/CDGXbTMQdM+t28LpxNQaP3ATDxbdryyE+
        LH82aLMh81iLzGdP+dcT2zO5PA0lBFrd/ifP8llJ4WV70Fk5oClX4EPubtzAzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XmlS8EOv1e3rHzLjqaJ8PDK8nkn49/W6t330MrJ1iQs=;
        b=UkEKSRX0/g8V4JpnV+PP/5McyhWtEmwnG9cFXJltGOKa/IAVezxVc9cWYoCS0h1Nu1/Ix1
        9ocvyu6d7O7xKqBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle, intel_idle: Fix CPUIDLE_FLAG_IBRS
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195540.556912863@infradead.org>
References: <20230112195540.556912863@infradead.org>
MIME-Version: 1.0
Message-ID: <167361307215.4906.2346441819750127043.tip-bot2@tip-bot2>
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

Commit-ID:     9b461a6faae7b220c32466261965778b10189e54
Gitweb:        https://git.kernel.org/tip/9b461a6faae7b220c32466261965778b10189e54
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:34 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:15 +01:00

cpuidle, intel_idle: Fix CPUIDLE_FLAG_IBRS

objtool to the rescue:

  vmlinux.o: warning: objtool: intel_idle_ibrs+0x17: call to spec_ctrl_current() leaves .noinstr.text section
  vmlinux.o: warning: objtool: intel_idle_ibrs+0x27: call to wrmsrl.constprop.0() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195540.556912863@infradead.org
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 drivers/idle/intel_idle.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d970ddb..aac6d81 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -86,7 +86,7 @@ void update_spec_ctrl_cond(u64 val)
 		wrmsrl(MSR_IA32_SPEC_CTRL, val);
 }
 
-u64 spec_ctrl_current(void)
+noinstr u64 spec_ctrl_current(void)
 {
 	return this_cpu_read(x86_spec_ctrl_current);
 }
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index f060ac7..7b996a0 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -181,12 +181,12 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
 	int ret;
 
 	if (smt_active)
-		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
 
 	ret = __intel_idle(dev, drv, index);
 
 	if (smt_active)
-		wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
 
 	return ret;
 }
