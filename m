Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06E0734856
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjFRUu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjFRUuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:50:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AC5E4D;
        Sun, 18 Jun 2023 13:50:01 -0700 (PDT)
Date:   Sun, 18 Jun 2023 20:49:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121399;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S2grR4taeojETLKA4WB7/rLhdtfB3E8NAr9445/B/eU=;
        b=Ha5vnXTvzB2l57TwS5mO8LbrMe3VdI6vCKyERKehtNNz2byTLtp2Oe1VZihzbjHpkeA11x
        s3AUayRsHTJ+pfLXeme08pz+zo0ZBoqY410bZ2TsiOh8UsO7skMpi1Q6OF5KnM4q+oudXD
        bSYyAxWVOtvHBb5++Ppf0MTU42K8a3dMyqC1+US9KrSbcCT4htdHJcULtGLvFzRMCYXJqF
        Vey6emGhcZugTYOAvoNNAlP67iBYc9ikE+7kJ/YTUHICSsUsi0NUm890LokzCVBDL6kVvh
        hgL/NgWbXLJpdVUlUNjw5WCq9mlzGQF4kw2Qn4VkfeMFVXhKJv5V2T5Zs0d5NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121399;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S2grR4taeojETLKA4WB7/rLhdtfB3E8NAr9445/B/eU=;
        b=zVXqQibN52woeXBIInlKZx9vYjmtOCkFA+9fgeqC6cMFySahMhoxNp5tfeK9E+qDchKNDs
        m0+ciI0jFyuoDMAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Add proper comments in do_timer_create()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.619897296@linutronix.de>
References: <20230425183313.619897296@linutronix.de>
MIME-Version: 1.0
Message-ID: <168712139917.404.9575558212543207671.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     52f090b164b59c06a4da87c0599424809a6bba16
Gitweb:        https://git.kernel.org/tip/52f090b164b59c06a4da87c0599424809a6bba16
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 18 Jun 2023 22:41:51 +02:00

posix-timers: Add proper comments in do_timer_create()

The comment about timer lifetime at the end of the function is misplaced
and uncomprehensible.

Make it understandable and put it at the right place. Add a new comment
about the visibility of the new timer ID to user space.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.619897296@linutronix.de

---
 kernel/time/posix-timers.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 54adb4c..20d3b99 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -529,12 +529,17 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	new_timer->sigq->info.si_tid   = new_timer->it_id;
 	new_timer->sigq->info.si_code  = SI_TIMER;
 
-	if (copy_to_user(created_timer_id,
-			 &new_timer_id, sizeof (new_timer_id))) {
+	if (copy_to_user(created_timer_id, &new_timer_id, sizeof (new_timer_id))) {
 		error = -EFAULT;
 		goto out;
 	}
-
+	/*
+	 * After succesful copy out, the timer ID is visible to user space
+	 * now but not yet valid because new_timer::signal is still NULL.
+	 *
+	 * Complete the initialization with the clock specific create
+	 * callback.
+	 */
 	error = kc->timer_create(new_timer);
 	if (error)
 		goto out;
@@ -544,14 +549,11 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	WRITE_ONCE(new_timer->it_signal, current->signal);
 	list_add(&new_timer->list, &current->signal->posix_timers);
 	spin_unlock_irq(&current->sighand->siglock);
-
-	return 0;
 	/*
-	 * In the case of the timer belonging to another task, after
-	 * the task is unlocked, the timer is owned by the other task
-	 * and may cease to exist at any time.  Don't use or modify
-	 * new_timer after the unlock call.
+	 * After unlocking sighand::siglock @new_timer is subject to
+	 * concurrent removal and cannot be touched anymore
 	 */
+	return 0;
 out:
 	posix_timer_unhash_and_free(new_timer);
 	return error;
