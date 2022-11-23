Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2430634CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiKWBVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbiKWBVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:21:20 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E821623B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:21:19 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id x18so11567196qki.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Xn44YesMZuZ8Y4WLRq4kq1k9pek4ng6uS2E49EtvTo=;
        b=X1sloOlgGllcTjloaNOVgImsa3WWDB0rKo/V4rhEpZ6lwZVuZCGd5Ry70nxVZf3tCD
         Kwd1kV+FCfUtXRqFb5UhftZHXOx2NDkiV9j1kNON7jw4FxVtyzI+o3GjiYcP57lxHRyX
         l5PuyYEojNSISBrTYWZMPdiOMOxz/AtOwfM3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Xn44YesMZuZ8Y4WLRq4kq1k9pek4ng6uS2E49EtvTo=;
        b=Qn1ox2QKolfF/711kQpySiRanXZEX4Ukqq3tHAlpaQy/NoaKIikZszxo3zo33DR8sR
         vj22dr9gzgCkLnKywOjBeG8MBU9BWSFYZ+dw2cVK0hhWKi4+aqQS+lLPUEBNM7PibWOl
         wDz7JaaV3dJdFOwVhD34fCbvUyN7qOlZASVNXDqC3QSUSIqdh4ntc/QwC68udPRPtv7D
         9SZajbQu4xRVdCaskciQv/xxq+loditdyZZKhFhl+GekiEm4PDDGPqe+2cGIZieuo2ho
         +JhKILfkgKKTxbGdDNhoA4NseHaHJEORK764vYjqtjj5olJJAj8Jn/bZfavFNd+OfkvB
         kd+w==
X-Gm-Message-State: ANoB5pnwavNiEUlmT5Vsse9UlxGD80Vd5MCMY8guUxdv+g1OzC456ssU
        AKCf4PYkmetrX3J6tQrOhJ6hilNUanmH1g==
X-Google-Smtp-Source: AA0mqf7MLAkSje6Pt2VcpKfquMHKbWhD/gitl9fSJQ2nxO3ekqrUFA8tF3Uid0LuBU0OPi8/kaD3HQ==
X-Received: by 2002:a37:cd7:0:b0:6fa:1e59:4b72 with SMTP id 206-20020a370cd7000000b006fa1e594b72mr22925074qkm.247.1669166478871;
        Tue, 22 Nov 2022 17:21:18 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id gc7-20020a05622a59c700b0035ce8965045sm9096026qtb.42.2022.11.22.17.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 17:21:18 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Connor O'Brien" <connoro@google.com>
Subject: [PATCH RFC 3/3] locktorture: Make the rt_boost factor a tunable
Date:   Wed, 23 Nov 2022 01:21:04 +0000
Message-Id: <20221123012104.3317665-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221123012104.3317665-1-joel@joelfernandes.org>
References: <20221123012104.3317665-1-joel@joelfernandes.org>
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

The rt boosting in locktorture has a factor variable large enough that
boosting only happens once every minute or so. Add a tunable to educe
the factor so that boosting happens more often, to test paths and arrive
at failure modes earlier. With this change, I can set the factor to
like 50 and have the boosting happens every 10 seconds or so.

Tested with boot parameters:
locktorture.torture_type=mutex_lock
locktorture.onoff_interval=1
locktorture.nwriters_stress=8
locktorture.stutter=0
locktorture.rt_boost=1
locktorture.rt_boost_factor=50
locktorture.nlocks=3

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/locking/locktorture.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 5a388ac96a9b..e4529c2166e9 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -47,6 +47,7 @@ torture_param(int, stat_interval, 60,
 	     "Number of seconds between stats printk()s");
 torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
 torture_param(int, rt_boost, 0, "Perform an rt-boost from the writer, always 1 for rtmutex_lock");
+torture_param(int, rt_boost_factor, 50000, "A factor determining how often rt-boost happens");
 torture_param(int, verbose, 1,
 	     "Enable verbose debugging printk()s");
 torture_param(int, nlocks, 1,
@@ -132,15 +133,15 @@ static void torture_lock_busted_write_unlock(int tid __maybe_unused)
 
 static void torture_rt_boost(struct torture_random_state *trsp)
 {
-	const unsigned int factor = 50000; /* yes, quite arbitrary */
+	const unsigned int factor = rt_boost_factor; /* yes, quite arbitrary */
 
 	if (!rt_boost)
 		return;
 
 	if (!rt_task(current)) {
 		/*
-		 * Boost priority once every ~50k operations. When the
-		 * task tries to take the lock, the rtmutex it will account
+		 * Boost priority once every rt_boost_factor operations. When
+		 * the task tries to take the lock, the rtmutex it will account
 		 * for the new priority, and do any corresponding pi-dance.
 		 */
 		if (trsp && !(torture_random(trsp) %
@@ -150,8 +151,9 @@ static void torture_rt_boost(struct torture_random_state *trsp)
 			return;
 	} else {
 		/*
-		 * The task will remain boosted for another ~500k operations,
-		 * then restored back to its original prio, and so forth.
+		 * The task will remain boosted for another 10*rt_boost_factor
+		 * operations, then restored back to its original prio, and so
+		 * forth.
 		 *
 		 * When @trsp is nil, we want to force-reset the task for
 		 * stopping the kthread.
-- 
2.38.1.584.g0f3c55d4c2-goog

