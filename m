Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3376979F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjBOKdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjBOKdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:33:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE9E40F2;
        Wed, 15 Feb 2023 02:33:06 -0800 (PST)
Date:   Wed, 15 Feb 2023 10:33:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676457183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+EuqJvbhyQpxyfggv0E0bEdlA6kg9fC8C03DEZDIa4=;
        b=wVVvjktf/TCDpvKOfCNsImh/AjGHL4abGkMwlz9k6mwWyOMuuNRDJqCt3sFlklMtlXd0iY
        r5z0wGrFTUg8oiOTXVKvbnNzEk/xCqqAH6Uo5i2y47froFQEDIKxKT3owwVoQ2MkkpyBbU
        enOB0bNDEfJCmCdpYTRZMsqEZ/t2OScn0+noR2TW8c7i0aIaNhjPdC9B36OlHXeVyrjSoT
        6vUZLZvQGAB+g4el3BmWs4mNecC9c1VpsOck+ZlN/Ca6r1BU18Hf6nBB8g5JoItWB7tBwG
        uF64TlypGDm8D1tLTJ2FZksGxb23PZUXRb1dYxaqlhjsc4KL1VDjNdmGKxmBvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676457183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+EuqJvbhyQpxyfggv0E0bEdlA6kg9fC8C03DEZDIa4=;
        b=YL33ux51roOUiyXbqYoBxSyzMykqhJTZiLB3ylPoKMjeLs+V1drE/19Bk3f16ghtAL/2p2
        9F9AAajdYdtxVIAA==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Fix a missed update of user_cpus_ptr
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230203181849.221943-1-longman@redhat.com>
References: <20230203181849.221943-1-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <167645718309.4906.12679309805756202231.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     df14b7f9efcda35e59bb6f50351aac25c50f6e24
Gitweb:        https://git.kernel.org/tip/df14b7f9efcda35e59bb6f50351aac25c50f6e24
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Fri, 03 Feb 2023 13:18:49 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Feb 2023 16:36:14 +01:00

sched/core: Fix a missed update of user_cpus_ptr

Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
cpumask"), a successful call to sched_setaffinity() should always save
the user requested cpu affinity mask in a task's user_cpus_ptr. However,
when the given cpu mask is the same as the current one, user_cpus_ptr
is not updated. Fix this by saving the user mask in this case too.

Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230203181849.221943-1-longman@redhat.com
---
 kernel/sched/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e838feb..2a4918a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2951,8 +2951,11 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 	}
 
 	if (!(ctx->flags & SCA_MIGRATE_ENABLE)) {
-		if (cpumask_equal(&p->cpus_mask, ctx->new_mask))
+		if (cpumask_equal(&p->cpus_mask, ctx->new_mask)) {
+			if (ctx->flags & SCA_USER)
+				swap(p->user_cpus_ptr, ctx->user_mask);
 			goto out;
+		}
 
 		if (WARN_ON_ONCE(p == current &&
 				 is_migration_disabled(p) &&
