Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842AD6CF571
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjC2VeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjC2VeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:34:21 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5681C211C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 14:34:20 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso4646997pjc.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 14:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680125660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WkYuJ0hK4Ow1RIU997HWW0rJyW0Iw6SB58BrQth/dg=;
        b=aHemX/kNmbdPFWeoF9UwmEMJSF/e5yupqYR5QLDjT0vqstKBULxzCKQ6tI3xsJGaPI
         0I0wwp0iCE0WulfPK9ybDvJk3UQoehvQuDI63T++k6By3sA5ZeJ/6vkRyYLSJOOzjH5E
         NGmo9ASSf019Nejbd8/ZkQW/dQS9kGs/NtOKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680125660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WkYuJ0hK4Ow1RIU997HWW0rJyW0Iw6SB58BrQth/dg=;
        b=F3RatSxgG7l78JnSrKC7UO6SNrdcr0DvrQBO7zFB3waogYvsNAtcjMouXHu718DGRX
         2j8/KGjf6BZqeYvByWsVd1aI8hP+qSP5by3T14W0pmDTAD6c9c5yRhGABt0LAKNj4Aha
         gs//lsxBAIGT19Psc2pw781exvmW8Im5NvSbLTQV7chaU0Y3Md0dBt+h06LN70F30hv1
         zUVfwp6MmFMTQKkPfjrAqm5Xepn1MMpbYVpd2Q3/CnwGtODcyx/k92yxjzFieW0bJXeL
         RBw24u90fG28WydkfdqC0xjxcHi0vWA5HLK1n3s/4VTU/pWOqcHqKYFX9i1FKQbteVAH
         75bg==
X-Gm-Message-State: AAQBX9ew3h9xVPjWpuEv6KZS5ES6fJJE2yI8BS2Z4E2djSiSU6TbbAda
        VhCfJraFPtwA1SFLN8Z2XlgvGA==
X-Google-Smtp-Source: AKy350Z9du1PLfGC0yTqyvvh0H+G2Zy0mEIVPkJfPKyZvGZjbNndkdsph4p2mpcqzZWH3AdAdbc6qg==
X-Received: by 2002:a17:903:2289:b0:1a1:a5ac:29ba with SMTP id b9-20020a170903228900b001a1a5ac29bamr25884401plh.1.1680125659582;
        Wed, 29 Mar 2023 14:34:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:f65f:8d37:f3f6:f4d3])
        by smtp.gmail.com with ESMTPSA id bc9-20020a170902930900b001a20b31a23fsm11705966plb.293.2023.03.29.14.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 14:34:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Collins <quic_collinsd@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        David Collins <collinsd@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/2] regulator: core: Avoid lockdep reports when resolving supplies
Date:   Wed, 29 Mar 2023 14:33:54 -0700
Message-Id: <20230329143317.RFC.v2.2.I30d8e1ca10cfbe5403884cdd192253a2e063eb9e@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230329143317.RFC.v2.1.I4e9d433ea26360c06dd1381d091c82bb1a4ce843@changeid>
References: <20230329143317.RFC.v2.1.I4e9d433ea26360c06dd1381d091c82bb1a4ce843@changeid>
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

Fixes: eaa7995c529b ("regulator: core: avoid regulator_resolve_supply() race condition")
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

Changes in v2:
- Added "core" to the subject line.
- Fixed slowpath bug where we missed updating the ref_cnt / mutex_owner.
- Added Fixes since I realized the problem is somewhat "recent".

 drivers/regulator/core.c | 91 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9a13240f3084..08726bc0da9d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -207,6 +207,78 @@ static void regulator_unlock(struct regulator_dev *rdev)
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
+		rdev2->ref_cnt++;
+		rdev2->mutex_owner = current;
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
@@ -1627,8 +1699,8 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 
 /**
  * set_supply - set regulator supply regulator
- * @rdev: regulator name
- * @supply_rdev: supply regulator name
+ * @rdev: regulator (locked)
+ * @supply_rdev: supply regulator (locked))
  *
  * Called by platform initialisation code to set the supply regulator for this
  * regulator. This ensures that a regulators supply will also be enabled by the
@@ -1800,6 +1872,8 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	struct regulator *regulator;
 	int err = 0;
 
+	lockdep_assert_held_once(&rdev->mutex.base);
+
 	if (dev) {
 		char buf[REG_STR_SIZE];
 		int size;
@@ -1827,9 +1901,7 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	regulator->rdev = rdev;
 	regulator->supply_name = supply_name;
 
-	regulator_lock(rdev);
 	list_add(&regulator->list, &rdev->consumer_list);
-	regulator_unlock(rdev);
 
 	if (dev) {
 		regulator->dev = dev;
@@ -1995,6 +2067,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 {
 	struct regulator_dev *r;
 	struct device *dev = rdev->dev.parent;
+	struct ww_acquire_ctx ww_ctx;
 	int ret = 0;
 
 	/* No supply to resolve? */
@@ -2061,23 +2134,23 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
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
@@ -2190,7 +2263,9 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
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

