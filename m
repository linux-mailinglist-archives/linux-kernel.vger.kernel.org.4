Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CA96CF1A3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjC2SDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjC2SDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:03:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491F8448D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:03:14 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o11so15741953ple.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680112993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6V03Dl7GKwTjxa9/dqCdXpCs+Gb6m3RRjNzTYjm37D0=;
        b=l0V61rdY6EunnaZNgcI5I4qIULqB1Mxco9TmPp2lGBxTLk8n/qro5xFqvKhiv9fDTk
         vonJAa95J1P480LcQaaVX64A0Mg4+sMVQWYbBoOKKybFo9RvSk986/Ef44mHE8QZIyqq
         RrHetPQxoN0HWEe9Qz1+mDXXmC7mmIIIvJK2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680112993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6V03Dl7GKwTjxa9/dqCdXpCs+Gb6m3RRjNzTYjm37D0=;
        b=RoK8MKf40VS8s+LJD4V2xGHDnDBsChj1Dv3xqINHMQ1sX2G7iFpxwM3mD5YexwQJQj
         6nT0eiZi12AHdHuzy78/gqu6TEzXIOtoy/cAP1vV+2GJzy4LbbYMVDzDpch+SWemOWrY
         567NaScYo77Yfo564TGkE1HBvailWzdEHG9EOSjTQnB3PWifOpeQHGfLFi/94X2d30/x
         3zgaryhxL8+GdSSlwp/0rpkjZedUbfz0I81weacyBOePrJLtM9xJv8tux8V1sO4e6zdf
         bWOV0amn+Zitu/DwLoyUeX+yKA9WZQgE1x7Rf7D96Ky4hZpWSHuW//oidqeCxOWCyJjb
         m7QQ==
X-Gm-Message-State: AAQBX9fQn8cRyw9K4O51W19ZuFwcZTclgc4yUbwbR8BGFzeQPeaEwDVs
        LonhsF7Tx0Gz++wDh7pBZ6MybcQF+v9MWECoqcc=
X-Google-Smtp-Source: AKy350bnfG5iem0ebQXnFMVPUlPd7dY105vs6hteAZisBzoBpTXjSCaYludjlUSZxI8j3ejuxho5vQ==
X-Received: by 2002:a17:903:189:b0:19c:f476:4793 with SMTP id z9-20020a170903018900b0019cf4764793mr21962896plg.51.1680112993605;
        Wed, 29 Mar 2023 11:03:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:f65f:8d37:f3f6:f4d3])
        by smtp.gmail.com with ESMTPSA id z1-20020a170902834100b001a1b808c1d8sm14537560pln.245.2023.03.29.11.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:03:12 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] regulator: Avoid lockdep reports when resolving supplies
Date:   Wed, 29 Mar 2023 11:02:40 -0700
Message-Id: <20230329110222.RFC.1.I30d8e1ca10cfbe5403884cdd192253a2e063eb9e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An automated bot told me that there was a potential lockdep problem
with regulators. This was on the chromeos-5.15 kernel, but I see
nothing that would be different downstream compared to upstream. The
bot said:
  ============================================
  WARNING: possible recursive locking detected
  5.15.104-lockdep-17461-gc1e499ed6604 #1 Not tainted
  --------------------------------------------
  kworker/u16:4/115 is trying to acquire lock:
  ffffff8083110170 (regulator_ww_class_mutex){+.+.}-{3:3}, at: create_regulator+0x398/0x7ec

  but task is already holding lock:
  ffffff808378e170 (regulator_ww_class_mutex){+.+.}-{3:3}, at: ww_mutex_trylock+0x3c/0x7b8

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(regulator_ww_class_mutex);
    lock(regulator_ww_class_mutex);

   *** DEADLOCK ***

   May be due to missing lock nesting notation

  4 locks held by kworker/u16:4/115:
   #0: ffffff808006a948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x520/0x1348
   #1: ffffffc00e0a7cc0 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0x55c/0x1348
   #2: ffffff80828a2260 (&dev->mutex){....}-{3:3}, at: __device_attach_async_helper+0xd0/0x2a4
   #3: ffffff808378e170 (regulator_ww_class_mutex){+.+.}-{3:3}, at: ww_mutex_trylock+0x3c/0x7b8

  stack backtrace:
  CPU: 2 PID: 115 Comm: kworker/u16:4 Not tainted 5.15.104-lockdep-17461-gc1e499ed6604 #1 9292e52fa83c0e23762b2b3aa1bacf5787a4d5da
  Hardware name: Google Quackingstick (rev0+) (DT)
  Workqueue: events_unbound async_run_entry_fn
  Call trace:
   dump_backtrace+0x0/0x4ec
   show_stack+0x34/0x50
   dump_stack_lvl+0xdc/0x11c
   dump_stack+0x1c/0x48
   __lock_acquire+0x16d4/0x6c74
   lock_acquire+0x208/0x750
   __mutex_lock_common+0x11c/0x11f8
   ww_mutex_lock+0xc0/0x440
   create_regulator+0x398/0x7ec
   regulator_resolve_supply+0x654/0x7c4
   regulator_register_resolve_supply+0x30/0x120
   class_for_each_device+0x1b8/0x230
   regulator_register+0x17a4/0x1f40
   devm_regulator_register+0x60/0xd0
   reg_fixed_voltage_probe+0x728/0xaec
   platform_probe+0x150/0x1c8
   really_probe+0x274/0xa20
   __driver_probe_device+0x1dc/0x3f4
   driver_probe_device+0x78/0x1c0
   __device_attach_driver+0x1ac/0x2c8
   bus_for_each_drv+0x11c/0x190
   __device_attach_async_helper+0x1e4/0x2a4
   async_run_entry_fn+0xa0/0x3ac
   process_one_work+0x638/0x1348
   worker_thread+0x4a8/0x9c4
   kthread+0x2e4/0x3a0
   ret_from_fork+0x10/0x20

The problem was first reported soon after we made many of the
regulators probe asynchronously, though nothing I've seen implies that
the problems couldn't have also happened even without that.

I haven't personally been able to reproduce the lockdep issue, but the
issue does look somewhat legitimate. Specifically, it looks like in
regulator_resolve_supply() we are holding a "rdev" lock while calling
set_supply() -> create_regulator() which grabs the lock of a
_different_ "rdev" (the one for our supply). This is not necessarily
safe from a lockdep perspective since there is no documented ordering
between these two locks.

In reality, we should always be locking a regulator before the
supplying regulator, so I don't expect there to be any real deadlocks
in practice. However, the regulator framework in general doesn't
express this to lockdep.

Let's fix the issue by simply grabbing the two locks involved in the
same way we grab multiple locks elsewhere in the regulator framework:
using the "wound/wait" mechanisms.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
My knowledge of lockdep is not as strong as it should be and my
knowledge of wait-wound locks is not as strong as it should be. That,
combined with the fact that I can't actually reproduce the issue, has
led me to label this as RFC.

I can at least confirm that my system still boots with this patch
applied, but I can't say 100% for sure that this addresses the issue
that the bot reported to me. Hopefully others can review and make sure
that this seems sensible to them.

If this looks reasonable, I can land it and see if that prevents the
bot from hitting this again.

 drivers/regulator/core.c | 89 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 81 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1490eb40c973..822fec20d36a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -207,6 +207,76 @@ static void regulator_unlock(struct regulator_dev *rdev)
 	mutex_unlock(&regulator_nesting_mutex);
 }
 
+/**
+ * regulator_lock_two - lock two regulators
+ * @rdev1:		first regulator
+ * @rdev2:		second regulator
+ * @ww_ctx:		w/w mutex acquire context
+ *
+ * Locks both rdevs using the regulator_ww_class.
+ */
+static void regulator_lock_two(struct regulator_dev *rdev1,
+			       struct regulator_dev *rdev2,
+			       struct ww_acquire_ctx *ww_ctx)
+{
+	struct regulator_dev *tmp;
+	int ret;
+
+	ww_acquire_init(ww_ctx, &regulator_ww_class);
+
+	/* Try to just grab both of them */
+	ret = regulator_lock_nested(rdev1, ww_ctx);
+	WARN_ON(ret);
+	ret = regulator_lock_nested(rdev2, ww_ctx);
+	if (ret != -EDEADLOCK) {
+		WARN_ON(ret);
+		goto exit;
+	}
+
+	while (true) {
+		/*
+		 * Start of loop: rdev1 was locked and rdev2 was contended.
+		 * Need to unlock rdev1, slowly lock rdev2, then try rdev1
+		 * again.
+		 */
+		regulator_unlock(rdev1);
+
+		ww_mutex_lock_slow(&rdev2->mutex, ww_ctx);
+		ret = regulator_lock_nested(rdev1, ww_ctx);
+
+		if (ret == -EDEADLOCK) {
+			/* More contention; swap which needs to be slow */
+			tmp = rdev1;
+			rdev1 = rdev2;
+			rdev2 = tmp;
+		} else {
+			WARN_ON(ret);
+			break;
+		}
+	}
+
+exit:
+	ww_acquire_done(ww_ctx);
+}
+
+/**
+ * regulator_unlock_two - unlock two regulators
+ * @rdev1:		first regulator
+ * @rdev2:		second regulator
+ * @ww_ctx:		w/w mutex acquire context
+ *
+ * The inverse of regulator_lock_two().
+ */
+
+static void regulator_unlock_two(struct regulator_dev *rdev1,
+				 struct regulator_dev *rdev2,
+				 struct ww_acquire_ctx *ww_ctx)
+{
+	regulator_unlock(rdev2);
+	regulator_unlock(rdev1);
+	ww_acquire_fini(ww_ctx);
+}
+
 static bool regulator_supply_is_couple(struct regulator_dev *rdev)
 {
 	struct regulator_dev *c_rdev;
@@ -1626,8 +1696,8 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 
 /**
  * set_supply - set regulator supply regulator
- * @rdev: regulator name
- * @supply_rdev: supply regulator name
+ * @rdev: regulator (locked)
+ * @supply_rdev: supply regulator (locked))
  *
  * Called by platform initialisation code to set the supply regulator for this
  * regulator. This ensures that a regulators supply will also be enabled by the
@@ -1799,6 +1869,8 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	struct regulator *regulator;
 	int err = 0;
 
+	lockdep_assert_held_once(&rdev->mutex.base);
+
 	if (dev) {
 		char buf[REG_STR_SIZE];
 		int size;
@@ -1826,9 +1898,7 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	regulator->rdev = rdev;
 	regulator->supply_name = supply_name;
 
-	regulator_lock(rdev);
 	list_add(&regulator->list, &rdev->consumer_list);
-	regulator_unlock(rdev);
 
 	if (dev) {
 		regulator->dev = dev;
@@ -1994,6 +2064,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 {
 	struct regulator_dev *r;
 	struct device *dev = rdev->dev.parent;
+	struct ww_acquire_ctx ww_ctx;
 	int ret = 0;
 
 	/* No supply to resolve? */
@@ -2060,23 +2131,23 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	 * between rdev->supply null check and setting rdev->supply in
 	 * set_supply() from concurrent tasks.
 	 */
-	regulator_lock(rdev);
+	regulator_lock_two(rdev, r, &ww_ctx);
 
 	/* Supply just resolved by a concurrent task? */
 	if (rdev->supply) {
-		regulator_unlock(rdev);
+		regulator_unlock_two(rdev, r, &ww_ctx);
 		put_device(&r->dev);
 		goto out;
 	}
 
 	ret = set_supply(rdev, r);
 	if (ret < 0) {
-		regulator_unlock(rdev);
+		regulator_unlock_two(rdev, r, &ww_ctx);
 		put_device(&r->dev);
 		goto out;
 	}
 
-	regulator_unlock(rdev);
+	regulator_unlock_two(rdev, r, &ww_ctx);
 
 	/*
 	 * In set_machine_constraints() we may have turned this regulator on
@@ -2189,7 +2260,9 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 		return regulator;
 	}
 
+	regulator_lock(rdev);
 	regulator = create_regulator(rdev, dev, id);
+	regulator_unlock(rdev);
 	if (regulator == NULL) {
 		regulator = ERR_PTR(-ENOMEM);
 		module_put(rdev->owner);
-- 
2.40.0.348.gf938b09366-goog

