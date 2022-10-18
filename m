Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E032602FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiJRP3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiJRP3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:29:04 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577CDD2CC5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:28:59 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bu25so23198867lfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/0uCXFANsoh0DiFy9dIOdQIaRdJECgtgeqYv4vuwUA=;
        b=vNt+110Y7Gze3Oupa9oWy7MGrfPQGa+VRB7raEBf7jWSRnlAfXjtRi5QANEZt/HWCr
         CVQ9bZtQfmtqUYetmVfyt/Vc1Pfy5aXhAChdOxO/jeuLongT0CdZytmGEHexof7ANQqe
         5U1yCBzVnTE2jlY9AL+k1gXKBnfl1+QnPynXEJmEpAJJdCuLVZEKsrLQAc/4WD4SNrGl
         w3y/MKx1arEHDu0YkHuN5j6kJsICoxxz1k7HXX5iuaAuZT2YnRTPvAFSLUKvPdzzmMLf
         Sa/qInkeJkBcFJQtJYpSsK4pQlImVBwB9WMmP40hJHwAkr+lATznD0LSEVvGlYDwH1dg
         lPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/0uCXFANsoh0DiFy9dIOdQIaRdJECgtgeqYv4vuwUA=;
        b=2ak//Of1nuOTClrAXdmG9jGEzp0ieMhmmTnCZmRNxrc9g7G7JMsMPyResT5ER5LXGB
         i8GsgIlNIr7J5/xONyqfD8O9+VnI0BHTFbZ6gJK3htH4tlDRx+47fMCovRLw7/pi/6+9
         SrHav5agAp78zd0EK/bW36cAr6wCEscxOM2xH8+hngjp5kE/lpssCzym3ixZaZQiZlu9
         YA2KKDe07Gawt9PuKnlpKP5kxU/2CjYPacwd1lwMjKDoXrtc4O/9xuDlnhXRoH+Ig5iJ
         R6cYzF0Da1nOUHrg3nGIp7sBbZxTHvfauBA6U9tJZeBQetdVzv+WXVhv7Ws2lO+4P1Xy
         V/zg==
X-Gm-Message-State: ACrzQf3zhCwXplpRveu63Yq/75oSccGVubI5vpF8dObkdsxxeZxIiVBM
        v/XEZM7OMUe6GnUEfQF5YpEBEg==
X-Google-Smtp-Source: AMsMyM7gNzMcIjqn02rOsijVxVqxkNCt4Go0GYZ3+pJXlqgozqDRhSH94go9wd1eZgA7THXsfX0Qug==
X-Received: by 2002:ac2:4dab:0:b0:4a2:7344:3d65 with SMTP id h11-20020ac24dab000000b004a273443d65mr1255244lfe.315.1666106937599;
        Tue, 18 Oct 2022 08:28:57 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id a9-20020a05651c030900b0026ddd41aecasm1998617ljp.135.2022.10.18.08.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:28:56 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 2/6] soc: qcom: rpmh-rsc: Attach RSC to cluster PM domain
Date:   Tue, 18 Oct 2022 17:28:33 +0200
Message-Id: <20221018152837.619426-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018152837.619426-1-ulf.hansson@linaro.org>
References: <20221018152837.619426-1-ulf.hansson@linaro.org>
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

From: Lina Iyer <ilina@codeaurora.org>

RSC is part the CPU subsystem and powers off the CPU domains when all
the CPUs and no RPMH transactions are pending from any of the drivers.
The RSC needs to flush the 'sleep' and 'wake' votes that are critical
for saving power when all the CPUs are in idle.

Let's make RSC part of the CPU PM domains, by attaching it to the
cluster power domain. Registering for PM domain notifications, RSC
driver can be notified that the last CPU is powering down. When the last
CPU is powering down the domain, let's flush the 'sleep' and 'wake'
votes that are stored in the data buffers into the hardware and also
write next wakeup in CONTROL_TCS.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # SM8450
---
 drivers/soc/qcom/rpmh-internal.h |  4 +-
 drivers/soc/qcom/rpmh-rsc.c      | 67 ++++++++++++++++++++++++++++++--
 2 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 344ba687c13b..cd3d6ce137e3 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -97,7 +97,8 @@ struct rpmh_ctrlr {
  * @rsc_pm:             CPU PM notifier for controller.
  *                      Used when solver mode is not present.
  * @cpus_in_pm:         Number of CPUs not in idle power collapse.
- *                      Used when solver mode is not present.
+ *                      Used when solver mode and "power-domains" is not present.
+ * @genpd_nb:           PM Domain notifier for cluster genpd notifications.
  * @tcs:                TCS groups.
  * @tcs_in_use:         S/W state of the TCS; only set for ACTIVE_ONLY
  *                      transfers, but might show a sleep/wake TCS in use if
@@ -117,6 +118,7 @@ struct rsc_drv {
 	int id;
 	int num_tcs;
 	struct notifier_block rsc_pm;
+	struct notifier_block genpd_nb;
 	atomic_t cpus_in_pm;
 	struct tcs_group tcs[TCS_TYPE_NR];
 	DECLARE_BITMAP(tcs_in_use, MAX_TCS_NR);
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 01c2f50cb97e..050b5f5c9f62 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -14,10 +14,13 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
@@ -834,6 +837,50 @@ static int rpmh_rsc_cpu_pm_callback(struct notifier_block *nfb,
 	return ret;
 }
 
+/**
+ * rpmh_rsc_pd_callback() - Check if any of the AMCs are busy.
+ * @nfb:    Pointer to the genpd notifier block in struct rsc_drv.
+ * @action: GENPD_NOTIFY_PRE_OFF, GENPD_NOTIFY_OFF, GENPD_NOTIFY_PRE_ON or GENPD_NOTIFY_ON.
+ * @v:      Unused
+ *
+ * This function is given to dev_pm_genpd_add_notifier() so we can be informed
+ * about when cluster-pd is going down. When cluster go down we know no more active
+ * transfers will be started so we write sleep/wake sets. This function gets
+ * called from cpuidle code paths and also at system suspend time.
+ *
+ * If AMCs are not busy then writes cached sleep and wake messages to TCSes.
+ * The firmware then takes care of triggering them when entering deepest low power modes.
+ *
+ * Return:
+ * * NOTIFY_OK          - success
+ * * NOTIFY_BAD         - failure
+ */
+static int rpmh_rsc_pd_callback(struct notifier_block *nfb,
+				unsigned long action, void *v)
+{
+	struct rsc_drv *drv = container_of(nfb, struct rsc_drv, genpd_nb);
+
+	/* We don't need to lock as genpd on/off are serialized */
+	if ((action == GENPD_NOTIFY_PRE_OFF) &&
+	    (rpmh_rsc_ctrlr_is_busy(drv) || rpmh_flush(&drv->client)))
+		return NOTIFY_BAD;
+
+	return NOTIFY_OK;
+}
+
+static int rpmh_rsc_pd_attach(struct rsc_drv *drv, struct device *dev)
+{
+	int ret;
+
+	pm_runtime_enable(dev);
+	drv->genpd_nb.notifier_call = rpmh_rsc_pd_callback;
+	ret = dev_pm_genpd_add_notifier(dev, &drv->genpd_nb);
+	if (ret)
+		pm_runtime_disable(dev);
+
+	return ret;
+}
+
 static int rpmh_probe_tcs_config(struct platform_device *pdev,
 				 struct rsc_drv *drv, void __iomem *base)
 {
@@ -963,7 +1010,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 		return ret;
 
 	/*
-	 * CPU PM notification are not required for controllers that support
+	 * CPU PM/genpd notification are not required for controllers that support
 	 * 'HW solver' mode where they can be in autonomous mode executing low
 	 * power mode to power down.
 	 */
@@ -971,8 +1018,14 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	solver_config &= DRV_HW_SOLVER_MASK << DRV_HW_SOLVER_SHIFT;
 	solver_config = solver_config >> DRV_HW_SOLVER_SHIFT;
 	if (!solver_config) {
-		drv->rsc_pm.notifier_call = rpmh_rsc_cpu_pm_callback;
-		cpu_pm_register_notifier(&drv->rsc_pm);
+		if (pdev->dev.pm_domain) {
+			ret = rpmh_rsc_pd_attach(drv, &pdev->dev);
+			if (ret)
+				return ret;
+		} else {
+			drv->rsc_pm.notifier_call = rpmh_rsc_cpu_pm_callback;
+			cpu_pm_register_notifier(&drv->rsc_pm);
+		}
 	}
 
 	/* Enable the active TCS to send requests immediately */
@@ -985,7 +1038,13 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, drv);
 
-	return devm_of_platform_populate(&pdev->dev);
+	ret = devm_of_platform_populate(&pdev->dev);
+	if (ret && pdev->dev.pm_domain) {
+		dev_pm_genpd_remove_notifier(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
+
+	return ret;
 }
 
 static const struct of_device_id rpmh_drv_match[] = {
-- 
2.34.1

