Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D47669716
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241401AbjAMMch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241200AbjAMMcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA82C42E3C;
        Fri, 13 Jan 2023 04:31:06 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TU+lfLaUryLanpvBA/nBYECxGdFkAGu9d/z6T7Z42Tw=;
        b=lDaH6qPODMl6tw5BHp9hqq31tlpZK1zHNa2WmyGvmienE12oSCGyD7KZX4WSY6qdzDA07+
        k91zu8Y1reJzVEdDGKldTmnAVJzyy5Vs7qzHX+U11CdVvOgq3YTl8+efP9NBTPQAWUtoeq
        LOP3OlvMo8ox34oVXVFpj86vWXZRQ9gQewU+e5mgV1JLSSRp2NlPleRsPkEd0S/NzFnou4
        AYeoaMkSBQOot79sgXb/rxSLu9djTmoFe1qstJs+F8gVN6wUZNzb+8GlCqUKQxWU/8fD2U
        Oro98j1Q9TExw+QlNHBQobZLUKxkon1SChwFwtjFD6delZbEjTmCr7hB4TI3tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TU+lfLaUryLanpvBA/nBYECxGdFkAGu9d/z6T7Z42Tw=;
        b=OmkJuV4f3MBzhMQAoaQi4qPubS+OGIV7ybZPg9dSJsCx9uq5sunH21Q76174b5N3loW9CE
        zRo3qyMR/TSwUlAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] context_tracking: Fix noinstr vs KASAN
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195542.458034262@infradead.org>
References: <20230112195542.458034262@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306437.4906.1206766567988276870.tip-bot2@tip-bot2>
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

Commit-ID:     0e26e1de0032779e43929174339429c16307a299
Gitweb:        https://git.kernel.org/tip/0e26e1de0032779e43929174339429c16307a299
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:44:05 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:18 +01:00

context_tracking: Fix noinstr vs KASAN

Low level noinstr context-tracking code is calling out to instrumented
code on KASAN:

  vmlinux.o: warning: objtool: __ct_user_enter+0x72: call to __kasan_check_write() leaves .noinstr.text section
  vmlinux.o: warning: objtool: __ct_user_exit+0x47: call to __kasan_check_write() leaves .noinstr.text section

Use even lower level atomic methods to avoid the instrumentation.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230112195542.458034262@infradead.org
---
 kernel/context_tracking.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 77978e3..a09f1c1 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -510,7 +510,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 			 * In this we case we don't care about any concurrency/ordering.
 			 */
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE))
-				atomic_set(&ct->state, state);
+				arch_atomic_set(&ct->state, state);
 		} else {
 			/*
 			 * Even if context tracking is disabled on this CPU, because it's outside
@@ -527,7 +527,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 			 */
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE)) {
 				/* Tracking for vtime only, no concurrent RCU EQS accounting */
-				atomic_set(&ct->state, state);
+				arch_atomic_set(&ct->state, state);
 			} else {
 				/*
 				 * Tracking for vtime and RCU EQS. Make sure we don't race
@@ -535,7 +535,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 				 * RCU only requires RCU_DYNTICKS_IDX increments to be fully
 				 * ordered.
 				 */
-				atomic_add(state, &ct->state);
+				arch_atomic_add(state, &ct->state);
 			}
 		}
 	}
@@ -630,12 +630,12 @@ void noinstr __ct_user_exit(enum ctx_state state)
 			 * In this we case we don't care about any concurrency/ordering.
 			 */
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE))
-				atomic_set(&ct->state, CONTEXT_KERNEL);
+				arch_atomic_set(&ct->state, CONTEXT_KERNEL);
 
 		} else {
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE)) {
 				/* Tracking for vtime only, no concurrent RCU EQS accounting */
-				atomic_set(&ct->state, CONTEXT_KERNEL);
+				arch_atomic_set(&ct->state, CONTEXT_KERNEL);
 			} else {
 				/*
 				 * Tracking for vtime and RCU EQS. Make sure we don't race
@@ -643,7 +643,7 @@ void noinstr __ct_user_exit(enum ctx_state state)
 				 * RCU only requires RCU_DYNTICKS_IDX increments to be fully
 				 * ordered.
 				 */
-				atomic_sub(state, &ct->state);
+				arch_atomic_sub(state, &ct->state);
 			}
 		}
 	}
