Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129D566971E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbjAMMcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241208AbjAMMcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1FD4319C;
        Fri, 13 Jan 2023 04:31:06 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48P8KVWCYjMGGvLZjw2r6s5bxt15ORTDOcSGZ3/Il2Q=;
        b=xTBd4OWCGmaNV4APjPCKnJixlVG65hrEm5Ok6jXl3FCyCorsFB3TNki09EghgZPw4CeHhF
        t/ZldtXAzNp6IhJelqmJFuyqPhByDrkfj8MaJiJsPXNVIu0FI8+c8as9gUI6+evTSDfbF4
        uhJwlhqTTkv6IbAY8arEmoUfDfG1E/zSsqxbQDDPBvsIyR7Coj/ShvK44PxXwfeR7+9XPU
        QfK30Pb7aBYThjOnBvJNUb40HJqL79n8ODcF67Cq/AfHnUKuyDdnAEyXCGkm3gidPYnWga
        la7KSBgShJNS2MchnO9mMf7c1j1vyWD3w3lJODEGOcz4XeImn258UxIh8Wk/+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48P8KVWCYjMGGvLZjw2r6s5bxt15ORTDOcSGZ3/Il2Q=;
        b=MLW5crS0wxMIz2rrWnMMu75203GVRbIZ0au/pJ7cDipr/UXG2YCyiBs8qwFsbnn/Lg/Jq2
        l1LJ1a7KUMZ1k1DQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle: Add comments about noinstr/__cpuidle usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195542.397238052@infradead.org>
References: <20230112195542.397238052@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306473.4906.1967859270536906724.tip-bot2@tip-bot2>
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

Commit-ID:     0e985e9d22864e29d5d2b3d909ad15134d7f6d46
Gitweb:        https://git.kernel.org/tip/0e985e9d22864e29d5d2b3d909ad15134d7f6d46
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:44:04 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:18 +01:00

cpuidle: Add comments about noinstr/__cpuidle usage

Add a few words on noinstr / __cpuidle usage.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230112195542.397238052@infradead.org
---
 drivers/cpuidle/cpuidle.c      | 12 ++++++++++++
 include/linux/compiler_types.h | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 73f7d8b..500d172 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -252,6 +252,18 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 		instrumentation_begin();
 	}
 
+	/*
+	 * NOTE!!
+	 *
+	 * For cpuidle_state::enter() methods that do *NOT* set
+	 * CPUIDLE_FLAG_RCU_IDLE RCU will be disabled here and these functions
+	 * must be marked either noinstr or __cpuidle.
+	 *
+	 * For cpuidle_state::enter() methods that *DO* set
+	 * CPUIDLE_FLAG_RCU_IDLE this isn't required, but they must mark the
+	 * function calling ct_cpuidle_enter() as noinstr/__cpuidle and all
+	 * functions called within the RCU-idle region.
+	 */
 	entered_state = target_state->enter(dev, drv, index);
 
 	if (WARN_ONCE(!irqs_disabled(), "%ps leaked IRQ state", target_state->enter))
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index d785890..dea5bf5 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -239,6 +239,16 @@ struct ftrace_likely_data {
 
 #define noinstr __noinstr_section(".noinstr.text")
 
+/*
+ * The __cpuidle section is used twofold:
+ *
+ *  1) the original use -- identifying if a CPU is 'stuck' in idle state based
+ *     on it's instruction pointer. See cpu_in_idle().
+ *
+ *  2) supressing instrumentation around where cpuidle disables RCU; where the
+ *     function isn't strictly required for #1, this is interchangeable with
+ *     noinstr.
+ */
 #define __cpuidle __noinstr_section(".cpuidle.text")
 
 #endif /* __KERNEL__ */
