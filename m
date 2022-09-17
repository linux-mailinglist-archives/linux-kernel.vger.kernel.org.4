Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191E35BB97E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 18:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIQQmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 12:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIQQmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 12:42:36 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B7B2F678
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:42:34 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id l14so10485462qvq.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=W20sVr4rHsYJL/FKcEAa6dXGu1RHDwQdwaDFAlx3ULo=;
        b=uHIj9ohx6d/ikjQUH9MJsZfu/j/LooTs088y2mOsZ7N/UW6p5VqrtfTdkxJu4dTLO9
         dI+OHDQizo/UIdP8y7bRLnQMGJcr0bulMfrIjDxsnsn1rINWrRQ7Qc7W+R6iba6C9DUL
         /mZGnML0/7+6LWpSZGZC5FgZlRWwDkLl3avUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=W20sVr4rHsYJL/FKcEAa6dXGu1RHDwQdwaDFAlx3ULo=;
        b=qhVbgU/+ZmqiydsJNW7XbTREgZTDQLGGZRI31JUQmjz5EFSx2w/bsr93NMMgtQp6Ny
         nyfYgAuRFxOZAFjSFDZcuReAJZCN8VGflhqZ3p8zp6cuDM+qiPGWFFOBpUNJhA3b/c0c
         AZzJttzggdg+AL8AlTUWNcv04NFlt92Lzsovo5eQ1aKRTxQ1IbI7naQnkcmX4C0qX2GI
         1A/YEok2EAU8IK1+Bo7J4bs33TrybTTaLxBE3ChmKe/e6adsB8IjQUMExQjJ5Ni/Uc7N
         qHQNwRT9fQRWhRq7Ba5EPeVL9jnxzo8p1nyjXgi0AYXMoKtsmthn5cYbSO2/qp6sTrhf
         mZig==
X-Gm-Message-State: ACrzQf02ZBr07z7k8Y2zLqViRBVCA1eFeM4A+ZJVEW0yakU0jy5RaS4B
        Xysj1oIeyTZozkFrlKvV3fzxcA==
X-Google-Smtp-Source: AMsMyM6CVm//iVr2UMSIXomdq/E4kcyBPnoaIHoLb5h5yloPlLl+1C4yIDBz1aMUo9ZUdvIXPLlYig==
X-Received: by 2002:a0c:f084:0:b0:49e:7bc1:26a3 with SMTP id g4-20020a0cf084000000b0049e7bc126a3mr8842257qvk.107.1663432953226;
        Sat, 17 Sep 2022 09:42:33 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id q31-20020a05620a2a5f00b006bb0e5ca4bbsm9479239qkp.85.2022.09.17.09.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 09:42:32 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH rcu/next 2/3] rcu: Fix late wakeup when flush of bypass cblist happens (v6)
Date:   Sat, 17 Sep 2022 16:41:59 +0000
Message-Id: <20220917164200.511783-3-joel@joelfernandes.org>
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

When the bypass cblist gets too big or its timeout has occurred, it is
flushed into the main cblist. However, the bypass timer is still running
and the behavior is that it would eventually expire and wake the GP
thread.

Since we are going to use the bypass cblist for lazy CBs, do the wakeup
soon as the flush for "too big or too long" bypass list happens.
Otherwise, long delays can happen for callbacks which get promoted from
lazy to non-lazy.

This is a good thing to do anyway (regardless of future lazy patches),
since it makes the behavior consistent with behavior of other code paths
where flushing into the ->cblist makes the GP kthread into a
non-sleeping state quickly.

[ Frederic Weisbec: changes to not do wake up GP thread unless needed,
		    comment changes ].

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 0a5f0ef41484..04c87f250e01 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -433,8 +433,9 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) ||
 	    ncbs >= qhimark) {
 		rcu_nocb_lock(rdp);
+		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+
 		if (!rcu_nocb_flush_bypass(rdp, rhp, j)) {
-			*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 			if (*was_alldone)
 				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 						    TPS("FirstQ"));
@@ -447,7 +448,12 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
 		}
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+
+		// The flush succeeded and we moved CBs into the regular list.
+		// Don't wait for the wake up timer as it may be too far ahead.
+		// Wake up the GP thread now instead, if the cblist was empty.
+		__call_rcu_nocb_wake(rdp, *was_alldone, flags);
+
 		return true; // Callback already enqueued.
 	}
 
-- 
2.37.3.968.ga6b4b080e4-goog

