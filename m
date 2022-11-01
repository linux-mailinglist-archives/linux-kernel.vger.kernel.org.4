Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E24C615626
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiKAXe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKAXe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:34:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAAC1A805
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 16:34:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l6so14680421pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fiCS58ae4A8sQ9uGla/myzHbwEt2fBq1HAnefdPpGXw=;
        b=Q86fSDNTbms1Mb8JrOYHI1p7oaSFY/zMzgVag9dI/GNGn2oQYG2KaWanrqqryNhN9j
         /o1IYA5nOqK9KoBrUAMx8Ecwoy4hREDsIUikXri20AkUxhiLBGnGM66xHMPV+I+0xFG4
         LFONQS24R+U28wLX94W1q79A5ZLyNEmJmQJZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiCS58ae4A8sQ9uGla/myzHbwEt2fBq1HAnefdPpGXw=;
        b=xFDaslTnWLCX04PPMCZJkH2jsFKnvMRdZ/eHOjjE+i81Sh3cHx1IJMnYZeiSXtXh70
         NmRJiouersrh+8ihSiKyN6+lwpl3GIO2he+2dK90Yfj3otL3OXlX/NnT1NTjKm6NKbiJ
         wSLmV472Nz5Cm/OJIBvaT3YtRgmaOBwkf11F//13cP14iRGnkAWK9QCmgz9sjfI+pYch
         Cz9ZMcUgzTFAkFNi/BCxHkhYvOMHEzhJ7sZGmxI5bR/aWC1cubqEuXajSprhY26Dldg5
         /D3LuGTjI4dgIcAiw5/Qx6K9lcBLF08rA2SeuqYBYFo0Pf0jKwd8NTG/M89CozrK4dTe
         4nfA==
X-Gm-Message-State: ACrzQf3CmENifhfRuqtSmATBUEKQqSbvVJzlWszP8DTHdEaNOWTeIWka
        ixpCAmYu3V7SEC82fIKvpHzUMg==
X-Google-Smtp-Source: AMsMyM72nKPR2ufazXxcn0DYr+8HSKemjmCYJg0pO1CLdZHKdz9XflAKz9Qzy1PCInazElLUrg97Qg==
X-Received: by 2002:a17:902:b70b:b0:186:b014:9609 with SMTP id d11-20020a170902b70b00b00186b0149609mr22177828pls.108.1667345664412;
        Tue, 01 Nov 2022 16:34:24 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:4437:8d79:dd1:7eb8])
        by smtp.gmail.com with ESMTPSA id a19-20020aa79713000000b0056bc1a41209sm7051224pfg.33.2022.11.01.16.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:34:23 -0700 (PDT)
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
Subject: [PATCH] clk: qcom: gdsc: Remove direct runtime PM calls
Date:   Tue,  1 Nov 2022 16:34:21 -0700
Message-Id: <20221101233421.997149-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/clk/qcom/gdsc.c | 64 ++++++-----------------------------------
 1 file changed, 8 insertions(+), 56 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 7cf5e130e92f..a775ce1b7d8a 100644
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
@@ -495,14 +451,11 @@ static int gdsc_init(struct gdsc *sc)
 		sc->pd.power_on = gdsc_enable;
 
 	ret = pm_genpd_init(&sc->pd, NULL, !on);
-	if (ret)
-		goto err_put_rpm;
+	if (!ret)
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
-- 
https://chromeos.dev

