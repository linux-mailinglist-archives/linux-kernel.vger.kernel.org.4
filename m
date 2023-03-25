Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E8C6C8FD2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 18:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjCYRec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 13:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjCYReH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:34:07 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EA3CA37
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:34:02 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a5so4504496qto.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679765642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QibGVAzBv0gTWQqE5TFgxflup7tk3PummO3A7I5nlFU=;
        b=Bitiwir0A9IEj0P20k33ypH0Yu5zV4sW3y+VbbmcQ3jA6Nw5b2VS13k98mZrzbC630
         re3JkfEMsrpKvdzMDtvWdQOgOvAHYSdj4qWTk+3WFFSEZJYUii/o8lbJ/uIyU9P+yTcs
         eil2loMErO49vAu9dR/zDfZq5DfkTdczeMp8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679765642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QibGVAzBv0gTWQqE5TFgxflup7tk3PummO3A7I5nlFU=;
        b=fhJPHnbP5J3nhg0Wl2qNoAAsmoLgeqGzojhPuU0gnF1UsPbBCqwZ7QarlCXyZNdq6x
         PeGxkscdx7MWlst1QNgQaKuHm8LEIjnUOsy0Ry+1GwT73x59odJFhEnFEadZ5nms4TVf
         JxBxZiKC2tlKQagMnwoAhg4VdQGdm9ovCt8gBrzdm5bImd4x11ZCOQmyioim1aXqdTB5
         DM8z5upX3+eDJ/yn7rrJM0PMWeyE8M/wB5XcqC0TBbr8GFDeGm7eDi4191gktwbuE4eY
         5t4jicTnbDetC1q2IMREZFVbJb9sPQpkmfQbc0hva+y8nZ5IA/sX3lZarhfbMqIM99NY
         tSOg==
X-Gm-Message-State: AAQBX9el5uGthstIYTyFAWYnycyOignSU/G63aXqrsI73Uw0MamFfs/W
        g4t6vf5vQ5akz6PEAGh0XD7c/NqPpeDtbbmKgww=
X-Google-Smtp-Source: AK7set/c+utZD7KsGUN+joNbxXwpbhjNKkljJ/zT/1BqFUiu6jbDVCKWmia3xO9V96K6lYkSph7hzA==
X-Received: by 2002:ac8:7c48:0:b0:3e3:8bcd:23cb with SMTP id o8-20020ac87c48000000b003e38bcd23cbmr10851438qtv.29.1679765642081;
        Sat, 25 Mar 2023 10:34:02 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id m4-20020ac84444000000b003e37ee54b5dsm6762764qtn.90.2023.03.25.10.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 10:34:01 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>
Cc:     rcu@vger.kernel.org
Subject: [PATCH v2 09/13] rcu: Remove never-set needwake assignment from rcu_report_qs_rdp()
Date:   Sat, 25 Mar 2023 17:33:12 +0000
Message-Id: <20230325173316.3118674-10-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230325173316.3118674-1-joel@joelfernandes.org>
References: <20230325173316.3118674-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

The rcu_accelerate_cbs() function is invoked by rcu_report_qs_rdp()
only if there is a grace period in progress that is still blocked
by at least one CPU on this rcu_node structure.  This means that
rcu_accelerate_cbs() should never return the value true, and thus that
this function should never set the needwake variable and in turn never
invoke rcu_gp_kthread_wake().

This commit therefore removes the needwake variable and the invocation
of rcu_gp_kthread_wake() in favor of a WARN_ON_ONCE() on the call to
rcu_accelerate_cbs().  The purpose of this new WARN_ON_ONCE() is to
detect situations where the system's opinion differs from ours.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8e880c09ab59..e80e8f128c57 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1955,7 +1955,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	unsigned long mask;
-	bool needwake = false;
 	bool needacc = false;
 	struct rcu_node *rnp;
 
@@ -1987,7 +1986,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		 * NOCB kthreads have their own way to deal with that...
 		 */
 		if (!rcu_rdp_is_offloaded(rdp)) {
-			needwake = rcu_accelerate_cbs(rnp, rdp);
+			/*
+			 * The current GP has not yet ended, so it
+			 * should not be possible for rcu_accelerate_cbs()
+			 * to return true.  So complain, but don't awaken.
+			 */
+			WARN_ON_ONCE(rcu_accelerate_cbs(rnp, rdp));
 		} else if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
 			/*
 			 * ...but NOCB kthreads may miss or delay callbacks acceleration
@@ -1999,8 +2003,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		rcu_disable_urgency_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
-		if (needwake)
-			rcu_gp_kthread_wake();
 
 		if (needacc) {
 			rcu_nocb_lock_irqsave(rdp, flags);
-- 
2.40.0.348.gf938b09366-goog

