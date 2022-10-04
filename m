Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28435F3B8A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiJDCnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiJDCm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:42:28 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889D423BE2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:42:27 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id s9so7691811qkg.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wlIK2JXtSjygcKXNSyavYIOSGjfzQt35OWNq3l9CMzQ=;
        b=yqwrOX0Wq4xU6MBwIWDL4Ymh4HSJGKo1REcppjJ7gRRk80LtryfoPwVkSFijch8cZp
         kNPmo8hy1q1ly0ZXZ5v0FGlT+7RiddwUib03Z3irE8aSu85n4sZmJq6kAbtpXjHBxbJU
         uuU3o1DlmkCXDvvYWlyql1gjOH7JstQkxWgIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wlIK2JXtSjygcKXNSyavYIOSGjfzQt35OWNq3l9CMzQ=;
        b=kF+n6vdQGDHPS3Emt7G2dB+dE84936+WDkXFXXO+Cw7sS3ncGIqMQETRjrd4S6kdYh
         r+QaAlyoSok97o7cCqk2la2bPxLCHJiikC4AKULUcN24NB6CWqQyc56M2/c9PY6HXJYa
         3I7ZCTja3m35SFa43rswliXF0+4y/tZWx4rEfFYeKU7lNOTo2fxojCLqFZP44MhQZjQL
         MwE+uy6jMPmiIDbd3tqq1kL8AwkrWXLulom4nYzdOdHi/IFuN7BhTryAkswEc9mfs9rX
         WSTDgTX64A4CcMPWUKkr24zD4lZkkAdRvZL8XSYFgDgU3PPGdAJuDoOrBRKCt2RhjW6n
         +zIQ==
X-Gm-Message-State: ACrzQf32jyG/uq/TsP52fC0z8C0gA1yoN3Fm1Bhn2CpqM2kn5q+/69s7
        MUAVZnmmwLpuX767YW7Olo1i9w==
X-Google-Smtp-Source: AMsMyM4VanHW7I4ovQwpeG+2msBNDya7G16RBkcIPiFOlZqHRPRf0ZSQ5Gmin+sPPTXy8X+Kxfl61Q==
X-Received: by 2002:a05:620a:4108:b0:6cf:8490:fa77 with SMTP id j8-20020a05620a410800b006cf8490fa77mr15902266qko.734.1664851346655;
        Mon, 03 Oct 2022 19:42:26 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id 1-20020ac85901000000b0035cf5edefa6sm11793875qty.56.2022.10.03.19.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 19:42:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v7 09/11] rcu/rcutorture: Use call_rcu_flush() where needed
Date:   Tue,  4 Oct 2022 02:41:55 +0000
Message-Id: <20221004024157.2470238-10-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221004024157.2470238-1-joel@joelfernandes.org>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

call_rcu() changes to save power will change the behavior of rcutorture
tests. Use the call_rcu_flush() API instead which reverts to the old
behavior.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcutorture.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 684e24f12a79..fd56202ae4f4 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -514,7 +514,7 @@ static unsigned long rcu_no_completed(void)
 
 static void rcu_torture_deferred_free(struct rcu_torture *p)
 {
-	call_rcu(&p->rtort_rcu, rcu_torture_cb);
+	call_rcu_flush(&p->rtort_rcu, rcu_torture_cb);
 }
 
 static void rcu_sync_torture_init(void)
@@ -559,7 +559,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.start_gp_poll_exp_full	= start_poll_synchronize_rcu_expedited_full,
 	.poll_gp_state_exp	= poll_state_synchronize_rcu,
 	.cond_sync_exp		= cond_synchronize_rcu_expedited,
-	.call			= call_rcu,
+	.call			= call_rcu_flush,
 	.cb_barrier		= rcu_barrier,
 	.fqs			= rcu_force_quiescent_state,
 	.stats			= NULL,
@@ -863,7 +863,7 @@ static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)
 
 static void synchronize_rcu_mult_test(void)
 {
-	synchronize_rcu_mult(call_rcu_tasks, call_rcu);
+	synchronize_rcu_mult(call_rcu_tasks, call_rcu_flush);
 }
 
 static struct rcu_torture_ops tasks_ops = {
@@ -3432,13 +3432,13 @@ static void rcu_test_debug_objects(void)
 	/* Try to queue the rh2 pair of callbacks for the same grace period. */
 	preempt_disable(); /* Prevent preemption from interrupting test. */
 	rcu_read_lock(); /* Make it impossible to finish a grace period. */
-	call_rcu(&rh1, rcu_torture_leak_cb); /* Start grace period. */
+	call_rcu_flush(&rh1, rcu_torture_leak_cb); /* Start grace period. */
 	local_irq_disable(); /* Make it harder to start a new grace period. */
-	call_rcu(&rh2, rcu_torture_leak_cb);
-	call_rcu(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
+	call_rcu_flush(&rh2, rcu_torture_leak_cb);
+	call_rcu_flush(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
 	if (rhp) {
-		call_rcu(rhp, rcu_torture_leak_cb);
-		call_rcu(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
+		call_rcu_flush(rhp, rcu_torture_leak_cb);
+		call_rcu_flush(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
 	}
 	local_irq_enable();
 	rcu_read_unlock();
-- 
2.38.0.rc1.362.ged0d419d3c-goog

