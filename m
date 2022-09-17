Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F825BB97F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 18:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiIQQmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 12:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIQQmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 12:42:37 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0932303E3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:42:34 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id h28so17920412qka.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LbqcEwrWK8xzGA015vucIgdiMEo2clH8LFFcAywvHQQ=;
        b=WyMg2FBbm/t2DCQzBs99+MvCJHW0x8rLhbPX/j2RGxjVYxVYRycoEUDAFecP1EX/fT
         PBhwMWhxq/aF+d2r1RTwRn4QXPhdGt495Yrkfd2kaQ6mz625FYHGPGTA4+tmP9W3cKNf
         0qnLlsyWq/TNJi0sw1SE2aJ99lvvIKJkHci5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LbqcEwrWK8xzGA015vucIgdiMEo2clH8LFFcAywvHQQ=;
        b=GIlonWvS0aY9lWgk2zqSgLCS5ywOf0dRTL8nmGPkEequY9xXR6v9zuUVoIJVxhPWz5
         BVycgQPGneEOEgVJ5XBKMb7fDTyfsjN28DYt1pXqA5yVJk7MPFyXh9Pnh/JY67xt4hTJ
         J1dac/8mw04kpVXJXJvdY5E7kR/VQNd6AHyow14HPh0TgvqGgjCVKESK1eNVbGd0xQ/g
         5TO9wnrYUNkwx1lmj0u+1F/HQO1iVgMGEJplJ8Wj1cGdk10Ia7GY3IZmqLik/aoIK2mQ
         K7Ww8IxGJMscMEF2X3lV0ug/o+kbmXGDV05BdK1s3mdcWv7boMxjwY6AJfVUONxlybK0
         WKgQ==
X-Gm-Message-State: ACrzQf39arL42dpz5Tgw7IvDavE765lOgGwELD5KF1ptqWx3HLFjuv7B
        xmNbM6jgfAvgV90BG+2uXULackA4qop33w==
X-Google-Smtp-Source: AMsMyM7joNQtb0/LD1ROJWXNvXDA7dYnaBUzWEFaVKlNWDRFSERJUYlikz42Yc+wRk0MtQOPEq6Hwg==
X-Received: by 2002:a05:620a:2681:b0:6b5:b60c:1e66 with SMTP id c1-20020a05620a268100b006b5b60c1e66mr7841048qkp.99.1663432953813;
        Sat, 17 Sep 2022 09:42:33 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id q31-20020a05620a2a5f00b006bb0e5ca4bbsm9479239qkp.85.2022.09.17.09.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 09:42:33 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH rcu/next 3/3] rcu: Call trace_rcu_callback() also for bypass queuing (v2)
Date:   Sat, 17 Sep 2022 16:42:00 +0000
Message-Id: <20220917164200.511783-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220917164200.511783-1-joel@joelfernandes.org>
References: <20220917164200.511783-1-joel@joelfernandes.org>
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

If any callback is queued into the bypass list, then
trace_rcu_callback() does not show it. This makes it unclear when a
callback was actually queued, as the resulting trace only includes a
rcu_invoke_callback event. Fix it by calling the tracing function even
if queuing into bypass. This is needed for the future rcutop tool which
monitors enqueuing of callbacks.

Note that, in case of bypass queuing, the new tracing happens without
the nocb_lock.  This should be OK since on CONFIG_RCU_NOCB_CPU systems,
the total callbacks is represented by an atomic counter. Also, other
paths like rcu_barrier() also sample the total number of callback
without the nocb_lock.

Also, while at it, optimize the tracing so that rcu_state is not
accessed if tracing is disabled, because that's useless if we are
not tracing. A quick inspection of the generated assembler shows that
rcu_state is accessed even if the jump label for the tracepoint is
disabled.

Here is gcc -S output of the bad asm (note that I un-inlined it just for
testing and illustration however the final __trace_rcu_callback in the
patch is marked static inline):

__trace_rcu_callback:
        movq    8(%rdi), %rcx
        movq    rcu_state+3640(%rip), %rax
        movq    %rdi, %rdx
        cmpq    $4095, %rcx
        ja      .L3100
        movq    192(%rsi), %r8
        1:jmp .L3101 # objtool NOPs this
        .pushsection __jump_table,  "aw"
         .balign 8
        .long 1b - .
        .long .L3101 - .
         .quad __tracepoint_rcu_kvfree_callback+8 + 2 - .
        .popsection

With this change, the jump label check which is NOOPed is moved to the
beginning of the function.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5ec97e3f7468..18f07e167d5e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2728,6 +2728,22 @@ static void check_cb_ovld(struct rcu_data *rdp)
 	raw_spin_unlock_rcu_node(rnp);
 }
 
+/*
+ * Trace RCU callback helper, call after enqueuing callback.
+ */
+static inline void __trace_rcu_callback(struct rcu_head *head,
+				      struct rcu_data *rdp)
+{
+	if (trace_rcu_kvfree_callback_enabled() &&
+	    __is_kvfree_rcu_offset((unsigned long)head->func))
+		trace_rcu_kvfree_callback(rcu_state.name, head,
+					 (unsigned long)head->func,
+					 rcu_segcblist_n_cbs(&rdp->cblist));
+	else if (trace_rcu_callback_enabled())
+		trace_rcu_callback(rcu_state.name, head,
+				   rcu_segcblist_n_cbs(&rdp->cblist));
+}
+
 /**
  * call_rcu() - Queue an RCU callback for invocation after a grace period.
  * @head: structure to be used for queueing the RCU updates.
@@ -2809,17 +2825,15 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 	}
 
 	check_cb_ovld(rdp);
-	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
+
+	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags)) {
+		__trace_rcu_callback(head, rdp);
 		return; // Enqueued onto ->nocb_bypass, so just leave.
+	}
+
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
-	if (__is_kvfree_rcu_offset((unsigned long)func))
-		trace_rcu_kvfree_callback(rcu_state.name, head,
-					 (unsigned long)func,
-					 rcu_segcblist_n_cbs(&rdp->cblist));
-	else
-		trace_rcu_callback(rcu_state.name, head,
-				   rcu_segcblist_n_cbs(&rdp->cblist));
+	__trace_rcu_callback(head, rdp);
 
 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
 
-- 
2.37.3.968.ga6b4b080e4-goog

