Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345B968BE1E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBFN3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFN3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:29:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F33159FB;
        Mon,  6 Feb 2023 05:29:17 -0800 (PST)
Date:   Mon, 06 Feb 2023 13:29:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675690156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Snt1HVBoVURizE40ikwhMIUzzxmPLegER7XUaky9JDA=;
        b=2y5oNjVSq/3uMFfV1s1wMQX2H96l/QJQTcaruTSg1SvhQ3evM77uViJzvNz1G9+NnOZVJZ
        ObCImZFptXe0gMbIn678P1Vmk8AUoK99n2bVuk0KktmsnwGSHOO2PAYJtOmesazhkd29cD
        DGrdRbs/irE6q9c473y5xspmWeoCtEAh5Z9iaRRKs2IA56t3CpvhUW/IzJ4S2pJw6BYXfG
        hc53dBCOrgcrgkExegZ1pUL99sduvnzK72DPiXJ2QTSxh55SkmHUsYTPImqLmytnm+CU1R
        xLp7wBGDCxXSFol8CDDfKR9uJ5K+m/35CfPNQOk+GtF5pEMer3QvdO6m+XFCvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675690156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Snt1HVBoVURizE40ikwhMIUzzxmPLegER7XUaky9JDA=;
        b=Rv+nHG0ncx8v5jBMVIj4uir+g9L331x7EprRv9auTHOpx4yTvreDc4iZrZw9yt0+t1VFwE
        RfiMlb9acDyTZAAQ==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Use atomic64_try_cmpxchg() in
 __update_gt_cputime()
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230116165337.5810-1-ubizjak@gmail.com>
References: <20230116165337.5810-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <167569015564.4906.9965184663618799874.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     915d4ad3830aa1a2dafda9b737749fb410cb9790
Gitweb:        https://git.kernel.org/tip/915d4ad3830aa1a2dafda9b737749fb410cb9790
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 16 Jan 2023 17:53:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 06 Feb 2023 14:22:09 +01:00

posix-timers: Use atomic64_try_cmpxchg() in __update_gt_cputime()

Use atomic64_try_cmpxchg() instead of atomic64_cmpxchg() in
__update_gt_cputime(). The x86 CMPXCHG instruction returns success in ZF
flag, so this change saves a compare after cmpxchg() (and related move
instruction in front of cmpxchg()).

Also, atomic64_try_cmpxchg() implicitly assigns old *ptr value to "old"
when cmpxchg() fails.  There is no need to re-read the value in the loop.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230116165337.5810-1-ubizjak@gmail.com

---
 kernel/time/posix-cpu-timers.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index cb925e8..2f5e9b3 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -243,13 +243,12 @@ static void proc_sample_cputime_atomic(struct task_cputime_atomic *at,
  */
 static inline void __update_gt_cputime(atomic64_t *cputime, u64 sum_cputime)
 {
-	u64 curr_cputime;
-retry:
-	curr_cputime = atomic64_read(cputime);
-	if (sum_cputime > curr_cputime) {
-		if (atomic64_cmpxchg(cputime, curr_cputime, sum_cputime) != curr_cputime)
-			goto retry;
-	}
+	u64 curr_cputime = atomic64_read(cputime);
+
+	do {
+		if (sum_cputime <= curr_cputime)
+			return;
+	} while (!atomic64_try_cmpxchg(cputime, &curr_cputime, sum_cputime));
 }
 
 static void update_gt_cputime(struct task_cputime_atomic *cputime_atomic,
