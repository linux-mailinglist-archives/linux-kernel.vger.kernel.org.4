Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489D46169FC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiKBRH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiKBRHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:07:22 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D23120A1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:07:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so2483239pji.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 10:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z60DP3IMVx0PgF9XoRWoSbcT5zhGjG4qF0GcGyDN/6s=;
        b=dvi2lMLG9DYOkxlDlG+HeXOP5KkxvRZBS+MOB8MTFmsk3QF8Lh/Ro4/mVsgpL3Aunr
         AsMjm0RamScqgwwyFA7tgIy3o0mrT6S911XO3cuvQmMZ1Ok5Zq7sB18wZ7vyTZJPD+2r
         qMw+fBY8W8hCAM2urjRUmMSa98yJwipB6d+Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z60DP3IMVx0PgF9XoRWoSbcT5zhGjG4qF0GcGyDN/6s=;
        b=PBF9ATTsrudQ/PtlkPFKgPgaGfiN0fy3+zyTMtmq7jMjHJ4WC9kcTnGwyMeMSWy/FR
         wXcbBBVtdvb6nHJ61cYRq/o9giraUUgR7pDgOg4MYTFDGhmCrWiD/+nNlA+mb5X9xDSi
         gHfMwR3r08ZHFTINyLDoZcsrfuA/uUHA4Esi2C79M4aS7cnapWAqA/cbRx6zlaXyB8qW
         F+yOlx2Nw2e33JBsoy8+Ffc9HxFS9ansBc9bBYCdTSqLPjEW6LitXUkiInLfkZ6DZTQx
         EG84z/ppJLlsU+8sgcLdP3MyzPFALKbBJfeyBYd9EpT1D4D8VHlE5mLFiEvSBdm3qVZ9
         pZHQ==
X-Gm-Message-State: ACrzQf3Z2MzgE3fU4D4GarVk6iJGatvhVo9ywY2Yi7q3i7ZZ5WXKj5fR
        V+ngcmpv2inKczfeY1qoy4DRwY+iauwSZA==
X-Google-Smtp-Source: AMsMyM6AKNnkgiRFAAD+XCA6VVUXb4HIYP5FrlTYKEIt8bl3YKcjm6xD5pfY3uA8JhL9icd3Hx4X4A==
X-Received: by 2002:a17:902:dac3:b0:186:a437:f4b8 with SMTP id q3-20020a170902dac300b00186a437f4b8mr25604701plx.70.1667408839962;
        Wed, 02 Nov 2022 10:07:19 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:4437:8d79:dd1:7eb8])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090a2a8600b002137d3da760sm1685034pjd.39.2022.11.02.10.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:07:19 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] clk: qcom: gdsc: Remove direct runtime PM calls
Date:   Wed,  2 Nov 2022 10:07:17 -0700
Message-Id: <20221102170717.1262547-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We shouldn't be calling runtime PM APIs from within the genpd
enable/disable path for a couple reasons.

First, this causes an AA lockdep splat because genpd can call into genpd
code again while holding the genpd lock.

WARNING: possible recursive locking detected
5.19.0-rc2-lockdep+ #7 Not tainted
--------------------------------------------
kworker/2:1/49 is trying to acquire lock:
ffffffeea0370788 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x24/0x30

but task is already holding lock:
ffffffeea03710a8 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x24/0x30

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&genpd->mlock);
  lock(&genpd->mlock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by kworker/2:1/49:
 #0: 74ffff80811a5748 ((wq_completion)pm){+.+.}-{0:0}, at: process_one_work+0x320/0x5fc
 #1: ffffffc008537cf8 ((work_completion)(&genpd->power_off_work)){+.+.}-{0:0}, at: process_one_work+0x354/0x5fc
 #2: ffffffeea03710a8 (&genpd->mlock){+.+.}-{3:3}, at: genpd_lock_mtx+0x24/0x30

stack backtrace:
CPU: 2 PID: 49 Comm: kworker/2:1 Not tainted 5.19.0-rc2-lockdep+ #7
Hardware name: Google Lazor (rev3 - 8) with KB Backlight (DT)
Workqueue: pm genpd_power_off_work_fn
Call trace:
 dump_backtrace+0x1a0/0x200
 show_stack+0x24/0x30
 dump_stack_lvl+0x7c/0xa0
 dump_stack+0x18/0x44
 __lock_acquire+0xb38/0x3634
 lock_acquire+0x180/0x2d4
 __mutex_lock_common+0x118/0xe30
 mutex_lock_nested+0x70/0x7c
 genpd_lock_mtx+0x24/0x30
 genpd_runtime_suspend+0x2f0/0x414
 __rpm_callback+0xdc/0x1b8
 rpm_callback+0x4c/0xcc
 rpm_suspend+0x21c/0x5f0
 rpm_idle+0x17c/0x1e0
 __pm_runtime_idle+0x78/0xcc
 gdsc_disable+0x24c/0x26c
 _genpd_power_off+0xd4/0x1c4
 genpd_power_off+0x2d8/0x41c
 genpd_power_off_work_fn+0x60/0x94
 process_one_work+0x398/0x5fc
 worker_thread+0x42c/0x6c4
 kthread+0x194/0x1b4
 ret_from_fork+0x10/0x20

Second, this confuses runtime PM on CoachZ for the camera devices by
causing the camera clock controller's runtime PM usage_count to go
negative after resuming from suspend. This is because runtime PM is
being used on the clock controller while runtime PM is disabled for the
device.

The reason for the negative count is because a GDSC is represented as a
genpd and each genpd that is attached to a device is resumed during the
noirq phase of system wide suspend/resume (see the noirq suspend ops
assignment in pm_genpd_init() for more details). The camera GDSCs are
attached to camera devices with the 'power-domains' property in DT.
Every device has runtime PM disabled in the late system suspend phase
via __device_suspend_late(). Runtime PM is not usable until runtime PM
is enabled in device_resume_early(). The noirq phases run after the
'late' and before the 'early' phase of suspend/resume. When the genpds
are resumed in genpd_resume_noirq(), we call down into gdsc_enable()
that calls pm_runtime_resume_and_get() and that returns -EACCES to
indicate failure to resume because runtime PM is disabled for all
devices.

Upon closer inspection, calling runtime PM APIs like this in the GDSC
driver doesn't make sense. It was intended to make sure the GDSC for the
clock controller providing other GDSCs was enabled, specifically the
MMCX GDSC for the display clk controller on SM8250 (sm8250-dispcc), so
that GDSC register accesses succeeded. That will already happen because
we make the 'dev->pm_domain' a parent domain of each GDSC we register in
gdsc_register() via pm_genpd_add_subdomain(). When any of these GDSCs
are accessed, we'll enable the parent domain (in this specific case
MMCX).

We also remove any getting of runtime PM during registration, because
when a genpd is registered it increments the count on the parent if the
genpd itself is already enabled. And finally, the runtime PM state of
the clk controller registering the GDSC shouldn't matter to the
subdomain setup. Therefore we always assign 'dev' unconditionally so
when GDSCs are removed we properly unlink the GDSC from the clk
controller's pm_domain.

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Taniya Das <quic_tdas@quicinc.com>
Cc: Satya Priya <quic_c_skakit@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Reported-by: Stephen Boyd <swboyd@chromium.org>
Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain support")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1 (https://lore.kernel.org/r/20221101233421.997149-1-swboyd@chromium.org):
 * Fix ret thinko
 * Update kerneldoc on 'dev' member

 drivers/clk/qcom/gdsc.c | 62 +++++------------------------------------
 drivers/clk/qcom/gdsc.h |  2 +-
 2 files changed, 8 insertions(+), 56 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 7cf5e130e92f..36d44eec03b6 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/ktime.h>
 #include <linux/pm_domain.h>
-#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset-controller.h>
@@ -56,22 +55,6 @@ enum gdsc_status {
 	GDSC_ON
 };
 
-static int gdsc_pm_runtime_get(struct gdsc *sc)
-{
-	if (!sc->dev)
-		return 0;
-
-	return pm_runtime_resume_and_get(sc->dev);
-}
-
-static int gdsc_pm_runtime_put(struct gdsc *sc)
-{
-	if (!sc->dev)
-		return 0;
-
-	return pm_runtime_put_sync(sc->dev);
-}
-
 /* Returns 1 if GDSC status is status, 0 if not, and < 0 on error */
 static int gdsc_check_status(struct gdsc *sc, enum gdsc_status status)
 {
@@ -271,8 +254,9 @@ static void gdsc_retain_ff_on(struct gdsc *sc)
 	regmap_update_bits(sc->regmap, sc->gdscr, mask, mask);
 }
 
-static int _gdsc_enable(struct gdsc *sc)
+static int gdsc_enable(struct generic_pm_domain *domain)
 {
+	struct gdsc *sc = domain_to_gdsc(domain);
 	int ret;
 
 	if (sc->pwrsts == PWRSTS_ON)
@@ -328,22 +312,11 @@ static int _gdsc_enable(struct gdsc *sc)
 	return 0;
 }
 
-static int gdsc_enable(struct generic_pm_domain *domain)
+static int gdsc_disable(struct generic_pm_domain *domain)
 {
 	struct gdsc *sc = domain_to_gdsc(domain);
 	int ret;
 
-	ret = gdsc_pm_runtime_get(sc);
-	if (ret)
-		return ret;
-
-	return _gdsc_enable(sc);
-}
-
-static int _gdsc_disable(struct gdsc *sc)
-{
-	int ret;
-
 	if (sc->pwrsts == PWRSTS_ON)
 		return gdsc_assert_reset(sc);
 
@@ -388,18 +361,6 @@ static int _gdsc_disable(struct gdsc *sc)
 	return 0;
 }
 
-static int gdsc_disable(struct generic_pm_domain *domain)
-{
-	struct gdsc *sc = domain_to_gdsc(domain);
-	int ret;
-
-	ret = _gdsc_disable(sc);
-
-	gdsc_pm_runtime_put(sc);
-
-	return ret;
-}
-
 static int gdsc_init(struct gdsc *sc)
 {
 	u32 mask, val;
@@ -447,11 +408,6 @@ static int gdsc_init(struct gdsc *sc)
 				return ret;
 		}
 
-		/* ...and the power-domain */
-		ret = gdsc_pm_runtime_get(sc);
-		if (ret)
-			goto err_disable_supply;
-
 		/*
 		 * Votable GDSCs can be ON due to Vote from other masters.
 		 * If a Votable GDSC is ON, make sure we have a Vote.
@@ -459,14 +415,14 @@ static int gdsc_init(struct gdsc *sc)
 		if (sc->flags & VOTABLE) {
 			ret = gdsc_update_collapse_bit(sc, false);
 			if (ret)
-				goto err_put_rpm;
+				goto err_disable_supply;
 		}
 
 		/* Turn on HW trigger mode if supported */
 		if (sc->flags & HW_CTRL) {
 			ret = gdsc_hwctrl(sc, true);
 			if (ret < 0)
-				goto err_put_rpm;
+				goto err_disable_supply;
 		}
 
 		/*
@@ -496,13 +452,10 @@ static int gdsc_init(struct gdsc *sc)
 
 	ret = pm_genpd_init(&sc->pd, NULL, !on);
 	if (ret)
-		goto err_put_rpm;
+		goto err_disable_supply;
 
 	return 0;
 
-err_put_rpm:
-	if (on)
-		gdsc_pm_runtime_put(sc);
 err_disable_supply:
 	if (on && sc->rsupply)
 		regulator_disable(sc->rsupply);
@@ -541,8 +494,7 @@ int gdsc_register(struct gdsc_desc *desc,
 	for (i = 0; i < num; i++) {
 		if (!scs[i])
 			continue;
-		if (pm_runtime_enabled(dev))
-			scs[i]->dev = dev;
+		scs[i]->dev = dev;
 		scs[i]->regmap = regmap;
 		scs[i]->rcdev = rcdev;
 		ret = gdsc_init(scs[i]);
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 981a12c8502d..47de72834a85 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -30,7 +30,7 @@ struct reset_controller_dev;
  * @resets: ids of resets associated with this gdsc
  * @reset_count: number of @resets
  * @rcdev: reset controller
- * @dev: the device holding the GDSC, used for pm_runtime calls
+ * @dev: the device providing the GDSC
  */
 struct gdsc {
 	struct generic_pm_domain	pd;

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
https://chromeos.dev

