Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F0D6BBD7D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjCOTon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjCOTog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:44:36 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A8ACA0B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:44:31 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id r5so17505135qtp.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678909470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v18L/HyzbX8RIGPkv74gEAaNuKF2umfPmevTB4XROmQ=;
        b=LAK5vaKQ7yNuOXwJ/bmj+BxFvK6WV9egm/yBtxMZRQ86LkU+ecP3uQvSIt9nrBkN+u
         Zx3IzVf7Qvxjmyq2vNKFl9qY9SmA2yHS3dUcZJYtGNJdYLUNEp14r4a9nDEFBOf2I51P
         K36kb3x302AK7FfweoSCaIdBujCIksdSNSirg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v18L/HyzbX8RIGPkv74gEAaNuKF2umfPmevTB4XROmQ=;
        b=M8oV4xLsK7P6zFpwteiJoXb6gSY9PKxwDGJxixRbz+dYxrX94JpipncPHEEv00Xgid
         RZLwUZMDG2qP5hGPeA1HWQpAk6qPLAHHgbdvWHS6LtyFhSqc4+c0HEReVNytBkOGjkDI
         EfDQXGhVWfjmwpRSghnXZDxntS/1+cNnMYeGJ9AW7RPpfXarUWCGgVFXHhsOF5mjyb4f
         ezVSNJaCrt3crrC8jRDCNRT1+NchUbu+iPsBfSXhtm9SNeZCNJd0z1Z+BdkwDoXVTG3i
         gDz9vueQi9NwVD9m8m0hLfxpkNzPYSNp5QjAXdkMNcfNZJ3aId7BSrMhFhUZ4xQzr8cP
         /Flw==
X-Gm-Message-State: AO0yUKWHVBcBO6Ps8k88WbOHdl4P0Q/6sa3BTYW622BbRw/4eJnINCn6
        tmEOdh3+RJnmVCdiUzPUCjo4y0znVL/xhF20lS0=
X-Google-Smtp-Source: AK7set+1xJxMyUYjCwPpkgFMm3z1hwMdYE1QZynRvOo/9xx1oGT3RffTi7vAUfXL1hJQUwX5WJAIMg==
X-Received: by 2002:a05:622a:174c:b0:3bf:d1b3:2bbb with SMTP id l12-20020a05622a174c00b003bfd1b32bbbmr2125188qtk.13.1678909470197;
        Wed, 15 Mar 2023 12:44:30 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id c15-20020ac8660f000000b003b86b088755sm4346666qtp.15.2023.03.15.12.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:44:29 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zqiang <qiang1.zhang@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/9] rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check
Date:   Wed, 15 Mar 2023 19:43:42 +0000
Message-Id: <20230315194349.10798-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315194349.10798-1-joel@joelfernandes.org>
References: <20230315194349.10798-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

This commit adds checks for the TICK_DEP_MASK_RCU_EXP bit, thus enabling
RCU expedited grace periods to actually force-enable scheduling-clock
interrupts on holdout CPUs.

Fixes: df1e849ae455 ("rcu: Enable tick for nohz_full CPUs slow to provide expedited QS")
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/timer.h | 3 ++-
 kernel/time/tick-sched.c     | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 2e713a7d9aa3..3e8619c72f77 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -371,7 +371,8 @@ TRACE_EVENT(itimer_expire,
 		tick_dep_name(PERF_EVENTS)		\
 		tick_dep_name(SCHED)			\
 		tick_dep_name(CLOCK_UNSTABLE)		\
-		tick_dep_name_end(RCU)
+		tick_dep_name(RCU)			\
+		tick_dep_name_end(RCU_EXP)
 
 #undef tick_dep_name
 #undef tick_dep_mask_name
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b0e3c9205946..ba2ac1469d47 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -281,6 +281,11 @@ static bool check_tick_dependency(atomic_t *dep)
 		return true;
 	}
 
+	if (val & TICK_DEP_MASK_RCU_EXP) {
+		trace_tick_stop(0, TICK_DEP_MASK_RCU_EXP);
+		return true;
+	}
+
 	return false;
 }
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

