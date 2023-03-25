Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816066C8FCF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 18:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjCYRe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 13:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjCYReG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:34:06 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5458E3A1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:34:00 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id m16so3708014qvi.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 10:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679765640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkqhMIgatpcxnL+zHWHZ8wmMPBfEMgxQ9GLo+81Qz2Y=;
        b=urQ3eGiSW39KOAg6HtdLQrdsQBhLE8fe/4vhcVkRPGPen+juA88G3/CNjtLggI5yz+
         /Hsq3yl9CS37DT4iPWQayHWqbtRy9ZytQ8GAhvPbolMecAoOjwgCOLok1U+uYBLXNFGT
         fF2bATwed5QWM3wvD1atFjToYeb3jtgI3zZSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679765640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkqhMIgatpcxnL+zHWHZ8wmMPBfEMgxQ9GLo+81Qz2Y=;
        b=b9OmN0FfC+lJeTNdF24o1YooetMMrcOod7dB/w2EJElz6Pe9ORgHFRmIr4xr0PXQJP
         NqksVOhRng5WReSUNLkaWN6FS+rsU2+l9/ApdCEdixK9NTw6ArCmCvODZHVv2gGeRNbc
         FWgDKVzYYhfZ8ghPGO1hbU9+i/awX0AgdHcnLkoZPweHFEziRmCGqn73O45jmBSZIK6a
         UVRttUCecPShNsi8Qv7XpO9/G7FZwIiaLk6zkpqoUwqFFGoXSwKULdvUy9Ikk6er9vt9
         +sQNxnSJz8q7VdqHLOhdli7VQbg01s3puQs9dM0HFGg/w0xyZgY3fFv6KmVM36tDak5/
         iigA==
X-Gm-Message-State: AAQBX9cZxF6/QKUch2UlxH7zAi0gm65YXz7Mn5C9CgBKSEB+QPAYBiDZ
        luc5/hbt1imU2jOLGgKUPUS6rOgOhxStnl70HRg=
X-Google-Smtp-Source: AKy350aHEmw9YFemES+YvWFbuHmTRQ1f6F/yTZi3NzBEEE4hql5/JbCy7XCBFuSVU3Z1xg6Fl0ubRA==
X-Received: by 2002:a05:6214:27c6:b0:574:97e9:e21c with SMTP id ge6-20020a05621427c600b0057497e9e21cmr11359421qvb.4.1679765639777;
        Sat, 25 Mar 2023 10:33:59 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id m4-20020ac84444000000b003e37ee54b5dsm6762764qtn.90.2023.03.25.10.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 10:33:59 -0700 (PDT)
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
Subject: [PATCH v2 07/13] rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check
Date:   Sat, 25 Mar 2023 17:33:10 +0000
Message-Id: <20230325173316.3118674-8-joel@joelfernandes.org>
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
index 68d81a4283c8..a46506f7ec6d 100644
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
2.40.0.348.gf938b09366-goog

