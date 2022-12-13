Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DC164BE1D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 21:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbiLMUs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 15:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236678AbiLMUsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:48:47 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7EF193C2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:48:46 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id o12so11225974qvn.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/mAzkHKq4wIiV8zGJG5Z4ta1NtZeQngWYqtEq72j8s=;
        b=Nmlbcj+lt1FKvUbPHui2UR4Mnuw5qu7mvQV+fIvRKu/SfijMrqYl6GYbfIwUBm9zpX
         rroQnWImlKdXex5c6VrW5fSJsXFQFjmPZW9miwqosak2X2kLhTlSMit6XCsu98i0sIjQ
         78yxgnE8I3sDlCHFMhVVqCiSzIkmPoGsKVBYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/mAzkHKq4wIiV8zGJG5Z4ta1NtZeQngWYqtEq72j8s=;
        b=EGIuIczpLv0LwDsjujslsz65QiKCzpdM7q72CBdBmdfJZ9gQ/l0njjOO185pr4s8j4
         cd9M4LHuufWQFXtgr3gZXXxhzigsVIBVl6qVL40WOiX2cFs5KSisZrzT6uc6ELaTvBiE
         6U0wXgb7MxscyYKJVnkWXVnWr8vkGK2/mFdzqlfk/VR4oJ4J2EzTrGC1vshJEq4iks3v
         cSY8wpO0b7gmnjlSmyBP2lyyf4TwpGhzrNX4EtMqZLZSsNrYTaL73XqS6cdnwCwl4Z6L
         VsLP9S+gKrRgAf/nf+J8oo0RBBlzVzFcyFGSZ5zLqZGWCdE9QQnNNPQN6JdKgnSx5Ku7
         7GLw==
X-Gm-Message-State: ANoB5pnmuF+ur/+fNYVzIUzn9GBpfBpxRA1Y8FWuHv0TeL0ryIObxaTH
        GkibyHiBkPXLyVJc9T6x9/+jViCCnIVdnbh2
X-Google-Smtp-Source: AA0mqf7uPS5m23dd59Pnh/Yh0b3PScpNumZ/g82OZq5LpWfP7mVPHkBqxpx4Ov06Nm5QDut8cl/tZw==
X-Received: by 2002:a05:6214:14a6:b0:4c6:fa63:60ed with SMTP id bo6-20020a05621414a600b004c6fa6360edmr26313085qvb.47.1670964524781;
        Tue, 13 Dec 2022 12:48:44 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id h3-20020a05620a400300b006fc447eebe5sm8562757qko.27.2022.12.13.12.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 12:48:43 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        connoro@google.com
Subject: [PATCH v3 rcu/dev 2/2] locktorture: Make the rt_boost factor a tunable
Date:   Tue, 13 Dec 2022 20:48:39 +0000
Message-Id: <20221213204839.321027-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221213204839.321027-1-joel@joelfernandes.org>
References: <20221213204839.321027-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt boosting in locktorture has a factor variable s currently large enough
that boosting only happens once every minute or so. Add a tunable to reduce the
factor so that boosting happens more often, to test paths and arrive at failure
modes earlier. With this change, I can set the factor to like 50 and have the
boosting happens every 10 seconds or so.

Tested with boot parameters:
locktorture.torture_type=mutex_lock
locktorture.onoff_interval=1
locktorture.nwriters_stress=8
locktorture.stutter=0
locktorture.rt_boost=1
locktorture.rt_boost_factor=50
locktorture.nlocks=3

[ Apply Davidlohr Bueso feedback on quoting rt_boost_factor. ]

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/locking/locktorture.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index e2271e8fc302..87e861da0ad5 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -48,6 +48,7 @@ torture_param(int, stat_interval, 60,
 torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
 torture_param(int, rt_boost, 2,
 		"Do periodic rt-boost. 0=Disable, 1=Only for rt_mutex, 2=For all lock types.");
+torture_param(int, rt_boost_factor, 50, "A factor determining how often rt-boost happens.");
 torture_param(int, verbose, 1,
 	     "Enable verbose debugging printk()s");
 
@@ -131,12 +132,12 @@ static void torture_lock_busted_write_unlock(int tid __maybe_unused)
 
 static void __torture_rt_boost(struct torture_random_state *trsp)
 {
-	const unsigned int factor = 50000; /* yes, quite arbitrary */
+	const unsigned int factor = rt_boost_factor;
 
 	if (!rt_task(current)) {
 		/*
-		 * Boost priority once every ~50k operations. When the
-		 * task tries to take the lock, the rtmutex it will account
+		 * Boost priority once every 'rt_boost_factor' operations. When
+		 * the task tries to take the lock, the rtmutex it will account
 		 * for the new priority, and do any corresponding pi-dance.
 		 */
 		if (trsp && !(torture_random(trsp) %
@@ -146,8 +147,9 @@ static void __torture_rt_boost(struct torture_random_state *trsp)
 			return;
 	} else {
 		/*
-		 * The task will remain boosted for another ~500k operations,
-		 * then restored back to its original prio, and so forth.
+		 * The task will remain boosted for another 10 * 'rt_boost_factor'
+		 * operations, then restored back to its original prio, and so
+		 * forth.
 		 *
 		 * When @trsp is nil, we want to force-reset the task for
 		 * stopping the kthread.
-- 
2.39.0.314.g84b9a713c41-goog

