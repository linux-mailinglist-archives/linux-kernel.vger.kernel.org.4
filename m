Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36C1600143
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJPQYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiJPQXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:23:49 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611A53ECC6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:23:43 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id z8so6500213qtv.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8qbMoDbUFjsjnsgxbcBmmoHnL4WHNlLEOswqF5VihY=;
        b=cPVn8FK4CZBrAZ54M7KyfKKXkgSC09g74rPm8n5OxaX0too8i+UKW9oibRperEQbdB
         caGBzcF4Y/av5TTpiExqn2n7TqsKqj+ELYhFHnNn+EX5s3NPocr8W/EUabv236NHx3at
         EM0iYxYDDNzjjFxe4XpBuqZJ9v6kXZ2zkQ9gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8qbMoDbUFjsjnsgxbcBmmoHnL4WHNlLEOswqF5VihY=;
        b=jkmamF0slqXl+sDNUaEJb2VuDSokeo0lPVfx3ywiCPpqxnkdWSYJRCESby+kpIAZxl
         q6lI+9lv2vf/T7JfXckuUHZ4UKWhjT6X0NYNpbut+TlB7ZaC2pLuw8gRzezHYPNti55e
         p+jMR5gJmO+1xnkPeQ2yrDkkciMNzs1Ma/8LITw7h8p4tCB6dBndMOAtKHJdrdAo14gP
         IvIXorvdr1wppTWaUn3A0e+ASNN+KL8PjJHT/jPlaJeglok3F+EUN0Ps3WkDud5otCbH
         rs+RhVSLeI6R7nPPVDUNGyf0DvHsk3K+pCJxyU5iG2+xLyspAjSWHy30Ahuzteq3Wxmu
         W3YQ==
X-Gm-Message-State: ACrzQf0iHrt0nql85MDaR+ehdLPhqocYtLpt7MoKvO6puzREiyNlgdIv
        x2uJNDu0OMueO/9hIkkeS4+0VA==
X-Google-Smtp-Source: AMsMyM4aRlBR8reojoEP7avo2GL0SxBHG/lxbAZy6E7ZYAuokZLaPUCTHS9KEDoDufg0ICgXfqQZGg==
X-Received: by 2002:ac8:5c45:0:b0:39c:dcea:c552 with SMTP id j5-20020ac85c45000000b0039cdceac552mr5547567qtj.128.1665937420317;
        Sun, 16 Oct 2022 09:23:40 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87ed3000000b003436103df40sm6001207qtj.8.2022.10.16.09.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 09:23:39 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v9 09/13] rcu/rcutorture: Use call_rcu_flush() where needed
Date:   Sun, 16 Oct 2022 16:23:01 +0000
Message-Id: <20221016162305.2489629-10-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221016162305.2489629-1-joel@joelfernandes.org>
References: <20221016162305.2489629-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
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
2.38.0.413.g74048e4d9e-goog

