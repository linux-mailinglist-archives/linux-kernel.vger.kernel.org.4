Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF9A610A89
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiJ1Gni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiJ1GmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:42:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3725D1BA1FC;
        Thu, 27 Oct 2022 23:42:17 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:42:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDLKi+FR9oLa+dB38spl3lqT0imIoZKy5gwaFYje73A=;
        b=GFDEWk26Fi6G9EfrotAPmMG+IipvAgOGi81ll86kVEcDw7zxq2JafMs5BA4MAl6XVB8dF3
        WmUDdje4UC8b5rBfcaE9W9yiuG0UKe+vPwqXGLZnEQ+1POiHBh3DiGk0d6Vgq3DeKby0IF
        U09e6HxodxddKtVcHVKT1pv7Gy3QOOCEdgL2ezraPYd/YrYPM8YTxfjDohBbNAmoLIW8DH
        Bue3gHcg88sqGQz3GZJo+ZPlSFiYrTBpFTFFeORordzJTSF+Ia9ld+ZKZlmUAORmIknXU6
        PGSXAcKCh/DsJnhn0WrsFLOSvh3UtVQJADfPtZRWNicPo8LPtJsfaEFiIRZ5xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDLKi+FR9oLa+dB38spl3lqT0imIoZKy5gwaFYje73A=;
        b=wbyU5WjyyQ+2VdmDRqVN97GTyiWjmYQrxY9fnOd/901GF/pYTODanlW6p2zSkkJ9mfqSPu
        EEXJ58PFc5vGWZBg==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add __releases annotations to affine_move_task()
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220922180041.1768141-2-longman@redhat.com>
References: <20220922180041.1768141-2-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <166693933445.29415.8756864522023842425.tip-bot2@tip-bot2>
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

Commit-ID:     5584e8ac2c68280e5ac31d231c23cdb7dfa225db
Gitweb:        https://git.kernel.org/tip/5584e8ac2c68280e5ac31d231c23cdb7dfa225db
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 22 Sep 2022 14:00:37 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 11:01:21 +02:00

sched: Add __releases annotations to affine_move_task()

affine_move_task() assumes task_rq_lock() has been called and it does
an implicit task_rq_unlock() before returning. Add the appropriate
__releases annotations to make this clear.

A typo error in comment is also fixed.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220922180041.1768141-2-longman@redhat.com
---
 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 069da4a..f6f2807 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2690,6 +2690,8 @@ void release_user_cpus_ptr(struct task_struct *p)
  */
 static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flags *rf,
 			    int dest_cpu, unsigned int flags)
+	__releases(rq->lock)
+	__releases(p->pi_lock)
 {
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
 	bool stop_pending, complete = false;
@@ -2999,7 +3001,7 @@ err_unlock:
 
 /*
  * Restrict the CPU affinity of task @p so that it is a subset of
- * task_cpu_possible_mask() and point @p->user_cpu_ptr to a copy of the
+ * task_cpu_possible_mask() and point @p->user_cpus_ptr to a copy of the
  * old affinity mask. If the resulting mask is empty, we warn and walk
  * up the cpuset hierarchy until we find a suitable mask.
  */
