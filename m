Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64FF6C599A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCVWtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjCVWsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:48:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C6E10D4;
        Wed, 22 Mar 2023 15:48:53 -0700 (PDT)
Date:   Wed, 22 Mar 2023 22:48:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679525332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=94IWON34Zkdpip/3iKIcCWqin5aEhz0xQbr2Iwre6K4=;
        b=znVzLFVvxK0QXKmCxWwsGvyAuLCqhAi12H3dHGN7dmNkDmSi2VZUFZwHI94sx8b4drrjGB
        1Va1hHEuzEFTya75TzCiBPS+byl9Kzb38AZsAeC1towF0vSrD5AchwbohRBPsmULSKrXq5
        Fit4lhvrp6ofGiG7aGGCx+ZD7OyDSyJ5ejWFA8DlhUGPZKGp1w0IU9vYisd0IN4ED8SlvF
        NavX9gv5ZPc7CT5uVunzzOsdmViisnUgXcire9mGP7L06s7WLOlfuorpW2er3u8oRu9puJ
        qxZUYNeSdbO4mjWnsb6OlgcMRo67HnIPSPumMZAlP7d3YyhfruXyueox6iAhnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679525332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=94IWON34Zkdpip/3iKIcCWqin5aEhz0xQbr2Iwre6K4=;
        b=kcB/6idXSj7OcRYvXO4RkBvWsFtNVPfHkpnK2LstwClo9SvOAgsf0/lM5sa0aZfh/RjInr
        kCuxlst7ioJV5/AQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] livepatch: Convert stack entries array to percpu
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230313233346.kayh4t2lpicjkpsv@treble>
References: <20230313233346.kayh4t2lpicjkpsv@treble>
MIME-Version: 1.0
Message-ID: <167952533158.5837.17769419178497550655.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e92606fa172f63a26054885b9715be86c643229d
Gitweb:        https://git.kernel.org/tip/e92606fa172f63a26054885b9715be86c643229d
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 13 Mar 2023 16:33:46 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Mar 2023 17:09:28 +01:00

livepatch: Convert stack entries array to percpu

The entries array in klp_check_stack() is static local because it's too
big to be reasonably allocated on the stack.  Serialized access is
enforced by the klp_mutex.

In preparation for calling klp_check_stack() without the mutex (from
cond_resched), convert it to a percpu variable.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230313233346.kayh4t2lpicjkpsv@treble
---
 kernel/livepatch/transition.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index f1b25ec..135fc73 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -14,6 +14,8 @@
 #include "transition.h"
 
 #define MAX_STACK_ENTRIES  100
+DEFINE_PER_CPU(unsigned long[MAX_STACK_ENTRIES], klp_stack_entries);
+
 #define STACK_ERR_BUF_SIZE 128
 
 #define SIGNALS_TIMEOUT 15
@@ -240,12 +242,15 @@ static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
  */
 static int klp_check_stack(struct task_struct *task, const char **oldname)
 {
-	static unsigned long entries[MAX_STACK_ENTRIES];
+	unsigned long *entries = this_cpu_ptr(klp_stack_entries);
 	struct klp_object *obj;
 	struct klp_func *func;
 	int ret, nr_entries;
 
-	ret = stack_trace_save_tsk_reliable(task, entries, ARRAY_SIZE(entries));
+	/* Protect 'klp_stack_entries' */
+	lockdep_assert_preemption_disabled();
+
+	ret = stack_trace_save_tsk_reliable(task, entries, MAX_STACK_ENTRIES);
 	if (ret < 0)
 		return -EINVAL;
 	nr_entries = ret;
