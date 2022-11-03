Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A9C618784
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiKCSbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiKCSar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:30:47 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB9213D50
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:30:34 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 78so2382350pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 11:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TDOYrT1aiWJGxrv6BRAem0JFk91bj7PzXDhoApaXwO8=;
        b=D7ZGfSOj/qtrzusHPX590eFqJeVg3VGN8nwEpQOe3wSudDV2YMcBEgiOqJnaPfQMf3
         wPKpM6jUawNuNE7HYJmgfP96KVcfyjjRR7XLv4jf1GoaQsidgk6AExs3oaOJ/W0yLXjG
         tDipkSGVsb0yRvIKDTKLFobr5aHP4nWweK94U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDOYrT1aiWJGxrv6BRAem0JFk91bj7PzXDhoApaXwO8=;
        b=o/XUYkf4pKoq411v+/C7jUjscj8wUQlBOiq/kM9kySW3wGIM37MDxWhJgrE1zk4hmk
         tN1agDRiLtg3b5aOeFpFnB4BO12ddSn7PlgpifKIVQuHbnJKYykyQuxVAQKwHS/doZzq
         hLEcqjbBC0efjpqGceh9gEliLiz9ljgmCP7uLnRTLemOLDmjdWkFL5PKsVRb5tOH9RxG
         xQ7jsgU0eoPptoSCpC087kTN+gBMr1wIAHwBLQY7j0va0d5KWvFyXl2HcjbI7Wlk7uRr
         UGt+TxmGdpzb/JeBEgcRagThQutycq6T9ejvWQ2lttZtNTG7tVMlJg+da+7tTXGF9Ye2
         vhSg==
X-Gm-Message-State: ACrzQf2mOkzrxKW4nAwe4Ga9sQRUWhKwsKoDdw8UD+2TsyHtJBAG+FXa
        doFPVmjZ93Jui4AW6/AM6pJsmg==
X-Google-Smtp-Source: AMsMyM5Lrlv/yvNWbwjH93LEqgF7lyiKnwbXAK83y4hlvCQYhtaZvb/vYiL6XNs8ZQgJoGsqzbmabg==
X-Received: by 2002:a65:5809:0:b0:46f:6afe:77a8 with SMTP id g9-20020a655809000000b0046f6afe77a8mr26679846pgr.206.1667500233697;
        Thu, 03 Nov 2022 11:30:33 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:4b5a:4cb1:40d2:6d1d])
        by smtp.gmail.com with ESMTPSA id h136-20020a62838e000000b0056283e2bdbdsm1049198pfe.138.2022.11.03.11.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:30:32 -0700 (PDT)
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
Subject: [PATCH v3] clk: qcom: gdsc: Remove direct runtime PM calls
Date:   Thu,  3 Nov 2022 11:30:30 -0700
Message-Id: <20221103183030.3594899-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We shouldn't be calling runtime PM APIs from within the genpd
enable/disable path for a couple reasons.

First, this causes an AA lockdep splat[1] because genpd can call into
genpd code again while holding the genpd lock.

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
genpd itself is already enabled.

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Taniya Das <quic_tdas@quicinc.com>
Cc: Satya Priya <quic_c_skakit@quicinc.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Reported-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/CAE-0n52xbZeJ66RaKwggeRB57fUAwjvxGxfFMKOKJMKVyFTe+w@mail.gmail.com [1]
Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain support")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v2 (https://lore.kernel.org/r/20221102170717.1262547-1-swboyd@chromium.org):
 * Drop dev assignment and remove struct member
 * Update commit text, add link to report

Changes from v1 (https://lore.kernel.org/r/20221101233421.997149-1-swboyd@chromium.org):
 * Fix ret thinko
 * Update kerneldoc on 'dev' member

 drivers/clk/qcom/gdsc.c | 61 ++++-------------------------------------
 drivers/clk/qcom/gdsc.h |  2 --
 2 files changed, 6 insertions(+), 57 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 7cf5e130e92f..0f21a8a767ac 100644
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
@@ -541,8 +494,6 @@ int gdsc_register(struct gdsc_desc *desc,
 	for (i = 0; i < num; i++) {
 		if (!scs[i])
 			continue;
-		if (pm_runtime_enabled(dev))
-			scs[i]->dev = dev;
 		scs[i]->regmap = regmap;
 		scs[i]->rcdev = rcdev;
 		ret = gdsc_init(scs[i]);
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 981a12c8502d..803512688336 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -30,7 +30,6 @@ struct reset_controller_dev;
  * @resets: ids of resets associated with this gdsc
  * @reset_count: number of @resets
  * @rcdev: reset controller
- * @dev: the device holding the GDSC, used for pm_runtime calls
  */
 struct gdsc {
 	struct generic_pm_domain	pd;
@@ -74,7 +73,6 @@ struct gdsc {
 
 	const char 			*supply;
 	struct regulator		*rsupply;
-	struct device			*dev;
 };
 
 struct gdsc_desc {

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
https://chromeos.dev

