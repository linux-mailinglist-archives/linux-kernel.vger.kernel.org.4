Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BF85B3A29
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiIIOAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiIIOAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6D66D9E5;
        Fri,  9 Sep 2022 07:00:18 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732017;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YCGme84nO6sBKEDLB3+s+9kW6qoJ0d6C7gstoiW8pRg=;
        b=Jy2SUweE1GxMxRsHi1y24sSLE45Pe9f0Cd5WFHIul7vieOHU78YGFkn0Z4gL9SqgfyFCzu
        ndjc0zftnoi0YwMRZUGfgHksKwHN68afM+XP+995HrpFPjQ7Ji+AjFgdUeH0qUstmYFSZ0
        FP7BQdfQgJTmrLbEzJ0mQxirYpd6MD4CdrdlaYkztRsXTOSHBlCPAI3fp6ybJkjW87LEAv
        6P9ftS+8l6C9KVbWofaaTRC+Hn2hIiVT51XDKM0G2nz/2/xZlpQfNvBReqKKNbMfkuobnL
        /Uf7FVsl9pdybvcKmMf9FyuHLScrrAa8Pnt9DsEobblmCmRtCRQmYmANNuRycQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732017;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YCGme84nO6sBKEDLB3+s+9kW6qoJ0d6C7gstoiW8pRg=;
        b=vGmZS6uwK4OoQ0pGgTqGLPJePXIzihTy5SjJiuRZdY1UsI+5QxG6jbJxm8p/FfXp72dCJs
        WpYb5tDggdzdJdAQ==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] sched/psi: Move private helpers to sched/stats.h
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220825164111.29534-5-zhouchengming@bytedance.com>
References: <20220825164111.29534-5-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166273201595.401.8558598021682834136.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/psi branch of tip:

Commit-ID:     d79ddb069c5257a924456eb99b53fc1ea715c0a3
Gitweb:        https://git.kernel.org/tip/d79ddb069c5257a924456eb99b53fc1ea715c0a3
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Fri, 26 Aug 2022 00:41:05 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 09 Sep 2022 11:08:31 +02:00

sched/psi: Move private helpers to sched/stats.h

This patch move psi_task_change/psi_task_switch declarations out of
PSI public header, since they are only needed for implementing the
PSI stats tracking in sched/stats.h

psi_task_switch is obvious, psi_task_change can't be public helper
since it doesn't check psi_disabled static key. And there is no
any user now, so put it in sched/stats.h too.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lore.kernel.org/r/20220825164111.29534-5-zhouchengming@bytedance.com
---
 include/linux/psi.h  | 4 ----
 kernel/sched/stats.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index dd74411..fffd229 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -18,10 +18,6 @@ extern struct psi_group psi_system;
 
 void psi_init(void);
 
-void psi_task_change(struct task_struct *task, int clear, int set);
-void psi_task_switch(struct task_struct *prev, struct task_struct *next,
-		     bool sleep);
-
 void psi_memstall_enter(unsigned long *flags);
 void psi_memstall_leave(unsigned long *flags);
 
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index baa839c..c39b467 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -107,6 +107,10 @@ __schedstats_from_se(struct sched_entity *se)
 }
 
 #ifdef CONFIG_PSI
+void psi_task_change(struct task_struct *task, int clear, int set);
+void psi_task_switch(struct task_struct *prev, struct task_struct *next,
+		     bool sleep);
+
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
  * memory stalls. As a result, it has to distinguish between sleeps,
