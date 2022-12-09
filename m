Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B022D647C32
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 03:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiLICXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 21:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiLICXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 21:23:17 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91ED7E82D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 18:23:16 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id d2so2274699qvp.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 18:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2b/sZ9jI9aIRINGgpdUltcdiC3pzQWLssaao35HJYo=;
        b=ZXZThAQGCrHzd8Mtyytkv7XseMPXLiVrRNG3vwiqOggKoh72F8Jp5F6Qugq29GRXQj
         D8k3dbLXnLvbGULthZ47qgUPk5wqI6krXyFD+Zq65wjPjdVwCctSwivTEVOpWx5gG38v
         FH/RwUMEVqVEHf5DGXUl7vxkT5I44G54sKifU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2b/sZ9jI9aIRINGgpdUltcdiC3pzQWLssaao35HJYo=;
        b=VKK2iO0u+2l3ZvNnGGvmil9i4Nsqumc/pK1uMYD/URKIQGPm3hUNoARca4/0NSfzny
         siN7WIgqLDyLSBb2ZPgeZevv+wPHnM1ArJ4SFY4GXQaCFlGXJ5FCAGSnYm4QcHR0BfHS
         3c2wKyqkmLD4BdlXwc/Rcc6c+/bpWFNBbuMrcsoLYkjtT6h/XPDgqL9JoB0ouLc/DFxK
         pFHqWaWJvzQ5v0wNSzIrfCMGt8EK4GThW6d6Q35q0AZjB63h5N7vQOZunyR5O1cpOoOv
         WOdK4Egcnmo4OSAEIrb4ATaSwWw2c/ak4UedjSxJuDzLzAfr1V1yJi2zX7lT6ZYU3cd5
         TGkQ==
X-Gm-Message-State: ANoB5pnXGi1WHVX3xaSVqJc8W1e1TsVD2pDTyd6x2Lf0wC6I7G5iC6T9
        0qT7KAnN291BhFCDncbLgjpUduK5+TsxYJB/
X-Google-Smtp-Source: AA0mqf65RSrBccsvLXFeld9BE4bVnBSw2M+c3Tj1UNSvqQs6VSchfcrA/ZaoRvme1rDcJZsB6Rz8dw==
X-Received: by 2002:a05:6214:5a85:b0:4bb:62f2:e726 with SMTP id ln5-20020a0562145a8500b004bb62f2e726mr6147039qvb.42.1670552595092;
        Thu, 08 Dec 2022 18:23:15 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id dm15-20020a05620a1d4f00b006feb0007217sm129812qkb.65.2022.12.08.18.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 18:23:14 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        connoro@google.com
Subject: [PATCH v2 2/2] locktorture: Make the rt_boost factor a tunable
Date:   Fri,  9 Dec 2022 02:23:05 +0000
Message-Id: <20221209022305.321149-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221209022305.321149-1-joel@joelfernandes.org>
References: <20221209022305.321149-1-joel@joelfernandes.org>
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

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/locking/locktorture.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 8968fd65a90d..b64a528e511c 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -48,6 +48,7 @@ torture_param(int, stat_interval, 60,
 torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
 torture_param(int, rt_boost, 2,
 		"Do periodic rt-boost. 0=Disable, 1=Only for rt_mutex, 2=For all lock types.");
+torture_param(int, rt_boost_factor, 50, "A factor determining how often rt-boost happens.");
 torture_param(int, verbose, 1,
 	     "Enable verbose debugging printk()s");
 torture_param(int, nlocks, 1,
@@ -133,12 +134,12 @@ static void torture_lock_busted_write_unlock(int tid __maybe_unused)
 
 static void __torture_rt_boost(struct torture_random_state *trsp)
 {
-	const unsigned int factor = 50000; /* yes, quite arbitrary */
+	const unsigned int factor = rt_boost_factor;
 
 	if (!rt_task(current)) {
 		/*
-		 * Boost priority once every ~50k operations. When the
-		 * task tries to take the lock, the rtmutex it will account
+		 * Boost priority once every rt_boost_factor operations. When
+		 * the task tries to take the lock, the rtmutex it will account
 		 * for the new priority, and do any corresponding pi-dance.
 		 */
 		if (trsp && !(torture_random(trsp) %
@@ -148,8 +149,9 @@ static void __torture_rt_boost(struct torture_random_state *trsp)
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
2.39.0.rc1.256.g54fd8350bd-goog

