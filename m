Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E9A6A5C63
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjB1Pvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjB1Pvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:51:33 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D4231E35;
        Tue, 28 Feb 2023 07:51:32 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id i34so41882549eda.7;
        Tue, 28 Feb 2023 07:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUCY23lI6ZJvR/D1w3pZEq+r1szcr1TztpwRWIRWSoQ=;
        b=Z6mCyrlrP7F8GnsWHKAzm2VDvru9DuR70y50S672b+2tf42utVlWYAMTcdZLt9WXud
         /375YOW3sy1WhIXDwbFu/oamI5ub0Gwxn0RPFig7qzRm+eu5gFAqInUCc+ZqmxqBS2Dy
         IBZNVoeXtoZpqSlPuyEYGgx5O9RfwpCFyxMpmx4pYho6KGj9Y4CROqCaYkQKDXfJENq1
         XeCD+kXP/3izj9acGl61Kai8elcAPWB49yjAVn6D6pPPKYoUAIbEAdXytWOdND4loVdR
         zpzHQsNgeVWYpXmLloU8xk4laIlZBO/2KpYPBek9axg7BozJVOgTu/FSFu1IjQPhTOl4
         jDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUCY23lI6ZJvR/D1w3pZEq+r1szcr1TztpwRWIRWSoQ=;
        b=rhgmY6yPB3/DqSE+x6Oxi9QllaNwVCthz7iJj57bZiT1er54RWQA3s3zWyirfVJBm4
         jaecL41r8cRyO6ymayF69B4bnbL9B7R7hE220HD8erV2lXTTA/BwztjzJBiXGdwpCXrK
         FlSOOJbX6kTay0qCEpvWZm7pa1Ti6vOUSUQH6huuTX8iGpGPgVWLkM3tMRt0OJrLggNI
         Gtm5/HAe6tXwMKZRmNPMYePdultbQQr+vv4JFc5Az0Sf8pammU1l2czsL5NMDitZxqzO
         rOjQhq5SNVScDFIQvX8dchIFYJAkGdwdR3mRKpB5jPaTcjU/PTbTN6FIBShdc41rAIIg
         1doQ==
X-Gm-Message-State: AO0yUKXwn8UlHdZNTOqfZvKUA4CubwjuY/7fmwk6jSauKqBOEy6ozSwX
        x5fSMe8mKPtnttVl4YejtoyDLsJ/BhU1PCYQ
X-Google-Smtp-Source: AK7set8VwCCjeSGdZlGi3/DAducTmZMUHb7uOpZwdANzLOxS/Smu4zf8eI0y3Pvle/mxOWaljDsyqw==
X-Received: by 2002:a05:6402:1a39:b0:4aa:b310:b695 with SMTP id be25-20020a0564021a3900b004aab310b695mr3573472edb.35.1677599490660;
        Tue, 28 Feb 2023 07:51:30 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906441000b008d09b900614sm4577153ejo.80.2023.02.28.07.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:51:30 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
Date:   Tue, 28 Feb 2023 16:51:21 +0100
Message-Id: <20230228155121.3416-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
check_cpu_stall.  x86 CMPXCHG instruction returns success in ZF flag, so
this change saves a compare after cmpxchg (and related move instruction in
front of cmpxchg).

No functional change intended.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 kernel/rcu/tree_stall.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b10b8349bb2a..d81c88e66b42 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -760,7 +760,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	jn = jiffies + ULONG_MAX / 2;
 	if (rcu_gp_in_progress() &&
 	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
-	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
+	    try_cmpxchg(&rcu_state.jiffies_stall, &js, jn)) {
 
 		/*
 		 * If a virtual machine is stopped by the host it can look to
@@ -778,7 +778,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 
 	} else if (rcu_gp_in_progress() &&
 		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
-		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
+		   try_cmpxchg(&rcu_state.jiffies_stall, &js, jn)) {
 
 		/*
 		 * If a virtual machine is stopped by the host it can look to
-- 
2.39.2

