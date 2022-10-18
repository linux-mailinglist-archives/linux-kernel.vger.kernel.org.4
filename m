Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5909A602FBA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiJRP3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiJRP3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:29:08 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC979BC614
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:29:06 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id i21so15547763ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eICgBxGNGKtE/hLPDQo1kEkz5yh4bfsSzqIE+62FuGc=;
        b=j6s/UUFbfhlBYCdMnWA56JZ+mwYLJIEgwXMq32ZQS1GcetQZ+NJTTy1Aj1+LLmDgB3
         GEOhnN1Y6hIMvy4XhvzVzpYUDDn4/BbsB3kb4jeIiJfwUsDhNZ7+2ze8DwPOFohEHrr8
         lncpiqcR6imDPWMC3S8/Rj0dbcYGw4y4lpv7fn0+ayfHy4mDUEE14aIzLXHH7TjSf0+U
         z/xy8ddv/dCz7VR+LIjWh2HtKFN8R5DOdbCJuEUFtL/x8YjQXVp3aLF0H/YI+QsJC8qT
         xEohCYEaRTC0JuhfrXqB+oXYVypynotGxAvo/o0/yhKGCTimVGCkN75okRTM4UxkE1R5
         Jjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eICgBxGNGKtE/hLPDQo1kEkz5yh4bfsSzqIE+62FuGc=;
        b=l760Br4Yx0YDXHulR1UFVZgeaMYRzJDfhlKqZkQVj70ufQAbekiStHUp+7kHG7UJwP
         Aa5srAD8ubwZvdj7+lIY3z4PBEhF5AWY2i+MfmrarkEuU6lUJ/1JKYQ20XUyIqXTQXIR
         qx4ZjUjGawESQNV6bSy1VjjtruOcIYUGf1Q6hqGPaD6VWB0aRBk/s+Nl3yvOiKqPW8K8
         11WX3R22p/37s+HyXYFNvYjST+7hD4nqRZu7X74f+HDa0fPC7/q21qJXJGmY+JVgTAA+
         V6dAT9d9XtsCLd3bPQwYD8hey4rMgdTZpHijCSht5tBBXDVnXA+FrW2pHcy8UdTEDU1o
         FwmA==
X-Gm-Message-State: ACrzQf0xjENUC+tcSXbYQzUBzck80mt2/nPgKeoJGdGqEWwQeJImf/cZ
        8oMXrPHc6ooKCTHOJH6z2YXRIw==
X-Google-Smtp-Source: AMsMyM5qhaVBssZvOHRNlLw80I2tI7dTKVHV+IiYnqI+ykB7zJd2VTKRq2WEJFEzjNDnR7jMsGtqxg==
X-Received: by 2002:a2e:a589:0:b0:26f:d394:dbe2 with SMTP id m9-20020a2ea589000000b0026fd394dbe2mr1327724ljp.485.1666106945164;
        Tue, 18 Oct 2022 08:29:05 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id a9-20020a05651c030900b0026ddd41aecasm1998617ljp.135.2022.10.18.08.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:29:04 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] soc: qcom: rpmh-rsc: Write CONTROL_TCS with next timer wakeup
Date:   Tue, 18 Oct 2022 17:28:37 +0200
Message-Id: <20221018152837.619426-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018152837.619426-1-ulf.hansson@linaro.org>
References: <20221018152837.619426-1-ulf.hansson@linaro.org>
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

From: Maulik Shah <quic_mkshah@quicinc.com>

The next wakeup timer value needs to be set in always on domain timer
as the arch timer interrupt can not wakeup the SoC if after the deepest
CPUidle states the SoC also enters deepest low power state.

To wakeup the SoC in such scenarios the earliest wakeup time is set in
CONTROL_TCS and the firmware takes care of setting up its own timer in
always on domain with next wakeup time. The timer wakes up the RSC and
sets resources back to wake state.

Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # SM8450
---
 drivers/soc/qcom/rpmh-internal.h |  3 ++
 drivers/soc/qcom/rpmh-rsc.c      | 61 ++++++++++++++++++++++++++++++++
 drivers/soc/qcom/rpmh.c          |  4 ++-
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 7866bb1e5361..39f53586f724 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -112,6 +112,7 @@ struct rpmh_ctrlr {
  * @tcs_wait:           Wait queue used to wait for @tcs_in_use to free up a
  *                      slot
  * @client:             Handle to the DRV's client.
+ * @dev:                RSC device.
  */
 struct rsc_drv {
 	const char *name;
@@ -127,12 +128,14 @@ struct rsc_drv {
 	spinlock_t lock;
 	wait_queue_head_t tcs_wait;
 	struct rpmh_ctrlr client;
+	struct device *dev;
 };
 
 int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
 int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
 			     const struct tcs_request *msg);
 void rpmh_rsc_invalidate(struct rsc_drv *drv);
+void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv);
 
 void rpmh_tx_done(const struct tcs_request *msg, int r);
 int rpmh_flush(struct rpmh_ctrlr *ctrlr);
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 8e01697f59af..25b838bf9078 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/ktime.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
@@ -25,6 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/wait.h>
 
+#include <clocksource/arm_arch_timer.h>
 #include <soc/qcom/cmd-db.h>
 #include <soc/qcom/tcs.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
@@ -49,6 +51,14 @@
 #define DRV_NCPT_MASK			0x1F
 #define DRV_NCPT_SHIFT			27
 
+/* Offsets for CONTROL TCS Registers */
+#define RSC_DRV_CTL_TCS_DATA_HI		0x38
+#define RSC_DRV_CTL_TCS_DATA_HI_MASK	0xFFFFFF
+#define RSC_DRV_CTL_TCS_DATA_HI_VALID	BIT(31)
+#define RSC_DRV_CTL_TCS_DATA_LO		0x40
+#define RSC_DRV_CTL_TCS_DATA_LO_MASK	0xFFFFFFFF
+#define RSC_DRV_CTL_TCS_DATA_SIZE	32
+
 /* Offsets for common TCS Registers, one bit per TCS */
 #define RSC_DRV_IRQ_ENABLE		0x00
 #define RSC_DRV_IRQ_STATUS		0x04
@@ -142,6 +152,14 @@
  *  +---------------------------------------------------+
  */
 
+#define USECS_TO_CYCLES(time_usecs)			\
+	xloops_to_cycles((time_usecs) * 0x10C7UL)
+
+static inline unsigned long xloops_to_cycles(unsigned long xloops)
+{
+	return (xloops * loops_per_jiffy * HZ) >> 32;
+}
+
 static inline void __iomem *
 tcs_reg_addr(const struct rsc_drv *drv, int reg, int tcs_id)
 {
@@ -756,6 +774,48 @@ static bool rpmh_rsc_ctrlr_is_busy(struct rsc_drv *drv)
 	return set < max;
 }
 
+/**
+ * rpmh_rsc_write_next_wakeup() - Write next wakeup in CONTROL_TCS.
+ * @drv: The controller
+ *
+ * Writes maximum wakeup cycles when called from suspend.
+ * Writes earliest hrtimer wakeup when called from idle.
+ */
+void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv)
+{
+	ktime_t now, wakeup;
+	u64 wakeup_us, wakeup_cycles = ~0;
+	u32 lo, hi;
+
+	if (!drv->tcs[CONTROL_TCS].num_tcs || !drv->genpd_nb.notifier_call)
+		return;
+
+	/* Set highest time when system (timekeeping) is suspended */
+	if (system_state == SYSTEM_SUSPEND)
+		goto exit;
+
+	/* Find the earliest hrtimer wakeup from online cpus */
+	wakeup = dev_pm_genpd_get_next_hrtimer(drv->dev);
+
+	/* Find the relative wakeup in kernel time scale */
+	now = ktime_get();
+	wakeup = ktime_sub(wakeup, now);
+	wakeup_us = ktime_to_us(wakeup);
+
+	/* Convert the wakeup to arch timer scale */
+	wakeup_cycles = USECS_TO_CYCLES(wakeup_us);
+	wakeup_cycles += arch_timer_read_counter();
+
+exit:
+	lo = wakeup_cycles & RSC_DRV_CTL_TCS_DATA_LO_MASK;
+	hi = wakeup_cycles >> RSC_DRV_CTL_TCS_DATA_SIZE;
+	hi &= RSC_DRV_CTL_TCS_DATA_HI_MASK;
+	hi |= RSC_DRV_CTL_TCS_DATA_HI_VALID;
+
+	writel_relaxed(lo, drv->base + RSC_DRV_CTL_TCS_DATA_LO);
+	writel_relaxed(hi, drv->base + RSC_DRV_CTL_TCS_DATA_HI);
+}
+
 /**
  * rpmh_rsc_cpu_pm_callback() - Check if any of the AMCs are busy.
  * @nfb:    Pointer to the notifier block in struct rsc_drv.
@@ -1035,6 +1095,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&drv->client.batch_cache);
 
 	dev_set_drvdata(&pdev->dev, drv);
+	drv->dev = &pdev->dev;
 
 	ret = devm_of_platform_populate(&pdev->dev);
 	if (ret && pdev->dev.pm_domain) {
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 01765ee9cdfb..3a53ed99d03c 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -450,7 +450,7 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
 
 	if (!ctrlr->dirty) {
 		pr_debug("Skipping flush, TCS has latest data.\n");
-		goto exit;
+		goto write_next_wakeup;
 	}
 
 	/* Invalidate the TCSes first to avoid stale data */
@@ -479,6 +479,8 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
 
 	ctrlr->dirty = false;
 
+write_next_wakeup:
+	rpmh_rsc_write_next_wakeup(ctrlr_to_drv(ctrlr));
 exit:
 	spin_unlock(&ctrlr->cache_lock);
 	return ret;
-- 
2.34.1

