Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921015B329E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiIIJA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiIIJAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:00:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F2154673;
        Fri,  9 Sep 2022 02:00:18 -0700 (PDT)
Date:   Fri, 09 Sep 2022 09:00:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662714017;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=za5Ye11Srx+C4dsuaoqgcQVtLwRXeAjNo3NbNXMfiyo=;
        b=sVPNyOUFIjEw4KBxPJtZJ1osIpZ2a//JShp2UNAlhxtXYewsEZ3UFSCSWoJsnBAAXJJjMN
        yU0YtAFGxy76zbUAs/YSvROqjkQMm8Olellsk1vAdWnTopiiKEwemolQIZw772QE4qITLT
        tcDLyTRCz27B16aNVS8hT4lKN6cXBnXwJbTjk5P8O4XKfIx2THQv1u5Y++/VM39+U4MHOi
        pZtTyzkfbVbJyBvCIisyE01HnK77VJRZr3Ok8vJC49tCvzigCxtP6CUP24ZsMJN+oDjwbz
        JAW0yTPbnjy3PV/bUKVIfpNf9lqfeDi6x8YfQZcB0F75PBUrqYyzxNkODXAemg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662714017;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=za5Ye11Srx+C4dsuaoqgcQVtLwRXeAjNo3NbNXMfiyo=;
        b=xMA0RtBlhJPNPgN7gelX9+C/5J++7D1fK2pJ/nsy0ZGPq5auniB/Haec+XVyo1QSmMfq+z
        cz32IAs+sSbTysDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Show PF_flag holes
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YxctoffFFPXONESt@hirez.programming.kicks-ass.net>
References: <YxctoffFFPXONESt@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <166271401564.401.13463209336005229265.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fb04563d1cae6f361892b4a339ad92100b1eb0d0
Gitweb:        https://git.kernel.org/tip/fb04563d1cae6f361892b4a339ad92100b1eb0d0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 06 Sep 2022 13:27:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:53:51 +02:00

sched: Show PF_flag holes

Put placeholders in PF_flag so we can see how holey it is.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/YxctoffFFPXONESt@hirez.programming.kicks-ass.net
---
 include/linux/sched.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4c91efd..15e3bd9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1722,7 +1722,9 @@ extern struct pid *cad_pid;
 #define PF_MEMALLOC		0x00000800	/* Allocating memory */
 #define PF_NPROC_EXCEEDED	0x00001000	/* set_user() noticed that RLIMIT_NPROC was exceeded */
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
+#define PF__HOLE__00004000	0x00004000
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
+#define PF__HOLE__00010000	0x00010000
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
 #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inherit GFP_NOFS */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */
@@ -1730,9 +1732,14 @@ extern struct pid *cad_pid;
 						 * I am cleaning dirty pages from some other bdi. */
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
+#define PF__HOLE__00800000	0x00800000
+#define PF__HOLE__01000000	0x01000000
+#define PF__HOLE__02000000	0x02000000
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
+#define PF__HOLE__20000000	0x20000000
+#define PF__HOLE__40000000	0x40000000
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
 
 /*
