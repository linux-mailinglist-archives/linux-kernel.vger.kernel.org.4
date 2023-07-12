Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006FD7504A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjGLKfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGLKfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:35:03 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5968C19BC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:34:43 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6686c74183cso6015839b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689158082; x=1691750082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G245auPlBN/AlAfPgO6K5LYN8BR3lAyMz9zmggmAIq8=;
        b=ZJIcYP4pLAFRLwuQE1JWyOrkHtQVWOxTrlLVcatKi8D/Freeu00WECdCK4D7tWnOB9
         llntvO/Za7zn6FyP7C9UltOsf9dciKgtmWULaXV26uyfhalMT7wqvtbJ6IdaMXoQQGze
         rkE76+eAz5SKW97wG8Vm8xwO08sqj883hszolFtVFYrfhH7DDW1dlW0eb60LFN2glrbR
         5UR2ONL1MJCNo6EhkQu3NGWmkc+ICngsAZoSL7mWDrXzDuK5+zLybt4bc3tKjQ6RXDXv
         MR6QrHMbtoF/l1ymuxy71S6ps89Ye7sqcRQ3PEdNMTa9mDXUW56/AUeWTblw7bDeS2Vg
         A2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689158082; x=1691750082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G245auPlBN/AlAfPgO6K5LYN8BR3lAyMz9zmggmAIq8=;
        b=cdkZbWLW6yYC8eas28ODcTqHjxncVSfdPHMjrDUVBJIamiHR9IatkIogQdbvb1+p8j
         sonHJX4EYNPixU8PQDF0O1KZ7mfx6X26f3bfuuPWWSlRqTIJtVnKwcJSAu0vta5W9tY9
         FX2iTlDlEtFLhzTEPsqAdxQdJLd4tQJLGwZFYJq1TRcFEOOyj4bIxnhpScfLOj5oT98P
         NZQQgiKVU9+V3TkuzXLkLaVsxF/I1CDUNLfanHMZxm9N7M0TRLTR9PI08jYYjDLLBDUg
         Dm+fr3+g6OvhbpeICuYTzDtNT2Rw508VqPEBmruITLIzbDGimqyGEGq/ZdUsPjOQtg9u
         BMig==
X-Gm-Message-State: ABy/qLbBGY/0qnfMuvEeUNp8yi/dU7av8UZZn3Nlxu08afDZIacpWUDw
        x8BFkE8a68GPhelaFcZZgKzf
X-Google-Smtp-Source: APBJJlG1JfoMj1wlrW/ydPke6J20AxWonjdZGXOTNdvTLThWvWboymVu02OZ3n+Hp2ovXa5SDDE7TA==
X-Received: by 2002:a05:6a00:99c:b0:666:e621:d83e with SMTP id u28-20020a056a00099c00b00666e621d83emr24934997pfg.13.1689158082357;
        Wed, 12 Jul 2023 03:34:42 -0700 (PDT)
Received: from localhost.localdomain ([117.207.27.131])
        by smtp.gmail.com with ESMTPSA id k15-20020aa790cf000000b00666b3706be6sm3247860pfk.107.2023.07.12.03.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 03:34:42 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 10/14] scsi: ufs: core: Add OPP support for scaling clocks and regulators
Date:   Wed, 12 Jul 2023 16:02:05 +0530
Message-Id: <20230712103213.101770-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFS core is only scaling the clocks during devfreq scaling and
initialization. But for an optimum power saving, regulators should also
be scaled along with the clocks.

So let's use the OPP framework which supports scaling clocks, regulators,
and performance state using OPP table defined in devicetree. For
accomodating the OPP support, the existing APIs (ufshcd_scale_clks,
ufshcd_is_devfreq_scaling_required and ufshcd_devfreq_scale) are modified
to accept "freq" as an argument which in turn used by the OPP helpers.

The OPP support is added along with the old freq-table based clock scaling
so that the existing platforms work as expected.

Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/core/ufshcd.c | 142 +++++++++++++++++++++++++++++---------
 include/ufs/ufshcd.h      |   4 ++
 2 files changed, 113 insertions(+), 33 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 983fae84d9e8..119496bb11fb 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/pm_opp.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched/clock.h>
 #include <scsi/scsi_cmnd.h>
@@ -276,7 +277,8 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba);
 static void ufshcd_resume_clkscaling(struct ufs_hba *hba);
 static void ufshcd_suspend_clkscaling(struct ufs_hba *hba);
 static void __ufshcd_suspend_clkscaling(struct ufs_hba *hba);
-static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up);
+static int ufshcd_scale_clks(struct ufs_hba *hba, unsigned long freq,
+			     bool scale_up);
 static irqreturn_t ufshcd_intr(int irq, void *__hba);
 static int ufshcd_change_power_mode(struct ufs_hba *hba,
 			     struct ufs_pa_layer_attr *pwr_mode);
@@ -1087,15 +1089,31 @@ static int ufshcd_set_clk_freq(struct ufs_hba *hba, bool scale_up)
 	return ret;
 }
 
+static int ufshcd_opp_set_rate(struct ufs_hba *hba, unsigned long freq)
+{
+	struct dev_pm_opp *opp;
+
+	opp = dev_pm_opp_find_freq_floor_indexed(hba->dev,
+						 &freq, 0);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	dev_pm_opp_put(opp);
+
+	return dev_pm_opp_set_opp(hba->dev, opp);
+}
+
 /**
  * ufshcd_scale_clks - scale up or scale down UFS controller clocks
  * @hba: per adapter instance
+ * @freq: frequency to scale
  * @scale_up: True if scaling up and false if scaling down
  *
  * Returns 0 if successful
  * Returns < 0 for any other errors
  */
-static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
+static int ufshcd_scale_clks(struct ufs_hba *hba, unsigned long freq,
+			     bool scale_up)
 {
 	int ret = 0;
 	ktime_t start = ktime_get();
@@ -1104,13 +1122,21 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
 	if (ret)
 		goto out;
 
-	ret = ufshcd_set_clk_freq(hba, scale_up);
+	if (hba->use_pm_opp)
+		ret = ufshcd_opp_set_rate(hba, freq);
+	else
+		ret = ufshcd_set_clk_freq(hba, scale_up);
 	if (ret)
 		goto out;
 
 	ret = ufshcd_vops_clk_scale_notify(hba, scale_up, POST_CHANGE);
-	if (ret)
-		ufshcd_set_clk_freq(hba, !scale_up);
+	if (ret) {
+		if (hba->use_pm_opp)
+			ufshcd_opp_set_rate(hba,
+					    hba->devfreq->previous_freq);
+		else
+			ufshcd_set_clk_freq(hba, !scale_up);
+	}
 
 out:
 	trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
@@ -1122,12 +1148,13 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
 /**
  * ufshcd_is_devfreq_scaling_required - check if scaling is required or not
  * @hba: per adapter instance
+ * @freq: frequency to scale
  * @scale_up: True if scaling up and false if scaling down
  *
  * Returns true if scaling is required, false otherwise.
  */
 static bool ufshcd_is_devfreq_scaling_required(struct ufs_hba *hba,
-					       bool scale_up)
+					       unsigned long freq, bool scale_up)
 {
 	struct ufs_clk_info *clki;
 	struct list_head *head = &hba->clk_list_head;
@@ -1135,6 +1162,9 @@ static bool ufshcd_is_devfreq_scaling_required(struct ufs_hba *hba,
 	if (list_empty(head))
 		return false;
 
+	if (hba->use_pm_opp)
+		return freq != hba->clk_scaling.target_freq;
+
 	list_for_each_entry(clki, head, list) {
 		if (!IS_ERR_OR_NULL(clki->clk)) {
 			if (scale_up && clki->max_freq) {
@@ -1331,13 +1361,15 @@ static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba, int err, bool sc
 /**
  * ufshcd_devfreq_scale - scale up/down UFS clocks and gear
  * @hba: per adapter instance
+ * @freq: frequency to scale
  * @scale_up: True for scaling up and false for scalin down
  *
  * Returns 0 for success,
  * Returns -EBUSY if scaling can't happen at this time
  * Returns non-zero for any other errors
  */
-static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
+static int ufshcd_devfreq_scale(struct ufs_hba *hba, unsigned long freq,
+				bool scale_up)
 {
 	int ret = 0;
 
@@ -1352,7 +1384,7 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 			goto out_unprepare;
 	}
 
-	ret = ufshcd_scale_clks(hba, scale_up);
+	ret = ufshcd_scale_clks(hba, freq, scale_up);
 	if (ret) {
 		if (!scale_up)
 			ufshcd_scale_gear(hba, true);
@@ -1363,7 +1395,8 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 	if (scale_up) {
 		ret = ufshcd_scale_gear(hba, true);
 		if (ret) {
-			ufshcd_scale_clks(hba, false);
+			ufshcd_scale_clks(hba, hba->devfreq->previous_freq,
+					  false);
 			goto out_unprepare;
 		}
 	}
@@ -1421,9 +1454,22 @@ static int ufshcd_devfreq_target(struct device *dev,
 	if (!ufshcd_is_clkscaling_supported(hba))
 		return -EINVAL;
 
-	clki = list_first_entry(&hba->clk_list_head, struct ufs_clk_info, list);
-	/* Override with the closest supported frequency */
-	*freq = (unsigned long) clk_round_rate(clki->clk, *freq);
+	if (hba->use_pm_opp) {
+		struct dev_pm_opp *opp;
+
+		/* Get the recommended frequency from OPP framework */
+		opp = devfreq_recommended_opp(dev, freq, flags);
+		if (IS_ERR(opp))
+			return PTR_ERR(opp);
+
+		dev_pm_opp_put(opp);
+	} else {
+		/* Override with the closest supported frequency */
+		clki = list_first_entry(&hba->clk_list_head, struct ufs_clk_info,
+					list);
+		*freq =	(unsigned long) clk_round_rate(clki->clk, *freq);
+	}
+
 	spin_lock_irqsave(hba->host->host_lock, irq_flags);
 	if (ufshcd_eh_in_progress(hba)) {
 		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
@@ -1438,12 +1484,17 @@ static int ufshcd_devfreq_target(struct device *dev,
 		goto out;
 	}
 
-	/* Decide based on the rounded-off frequency and update */
-	scale_up = *freq == clki->max_freq;
-	if (!scale_up)
+	/* Decide based on the target or rounded-off frequency and update */
+	if (hba->use_pm_opp)
+		scale_up = *freq > hba->clk_scaling.target_freq;
+	else
+		scale_up = *freq == clki->max_freq;
+
+	if (!hba->use_pm_opp && !scale_up)
 		*freq = clki->min_freq;
+
 	/* Update the frequency */
-	if (!ufshcd_is_devfreq_scaling_required(hba, scale_up)) {
+	if (!ufshcd_is_devfreq_scaling_required(hba, *freq, scale_up)) {
 		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
 		ret = 0;
 		goto out; /* no state change required */
@@ -1451,7 +1502,9 @@ static int ufshcd_devfreq_target(struct device *dev,
 	spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
 
 	start = ktime_get();
-	ret = ufshcd_devfreq_scale(hba, scale_up);
+	ret = ufshcd_devfreq_scale(hba, *freq, scale_up);
+	if (!ret)
+		hba->clk_scaling.target_freq = *freq;
 
 	trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
 		(scale_up ? "up" : "down"),
@@ -1471,8 +1524,6 @@ static int ufshcd_devfreq_get_dev_status(struct device *dev,
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 	struct ufs_clk_scaling *scaling = &hba->clk_scaling;
 	unsigned long flags;
-	struct list_head *clk_list = &hba->clk_list_head;
-	struct ufs_clk_info *clki;
 	ktime_t curr_t;
 
 	if (!ufshcd_is_clkscaling_supported(hba))
@@ -1485,17 +1536,24 @@ static int ufshcd_devfreq_get_dev_status(struct device *dev,
 	if (!scaling->window_start_t)
 		goto start_window;
 
-	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
 	/*
 	 * If current frequency is 0, then the ondemand governor considers
 	 * there's no initial frequency set. And it always requests to set
 	 * to max. frequency.
 	 */
-	stat->current_frequency = clki->curr_freq;
+	if (hba->use_pm_opp) {
+		stat->current_frequency = hba->clk_scaling.target_freq;
+	} else {
+		struct list_head *clk_list = &hba->clk_list_head;
+		struct ufs_clk_info *clki;
+
+		clki = list_first_entry(clk_list, struct ufs_clk_info, list);
+		stat->current_frequency = clki->curr_freq;
+	}
+
 	if (scaling->is_busy_started)
 		scaling->tot_busy_t += ktime_us_delta(curr_t,
 				scaling->busy_start_t);
-
 	stat->total_time = ktime_us_delta(curr_t, scaling->window_start_t);
 	stat->busy_time = scaling->tot_busy_t;
 start_window:
@@ -1524,9 +1582,11 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
 	if (list_empty(clk_list))
 		return 0;
 
-	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
-	dev_pm_opp_add(hba->dev, clki->min_freq, 0);
-	dev_pm_opp_add(hba->dev, clki->max_freq, 0);
+	if (!hba->use_pm_opp) {
+		clki = list_first_entry(clk_list, struct ufs_clk_info, list);
+		dev_pm_opp_add(hba->dev, clki->min_freq, 0);
+		dev_pm_opp_add(hba->dev, clki->max_freq, 0);
+	}
 
 	ufshcd_vops_config_scaling_param(hba, &hba->vps->devfreq_profile,
 					 &hba->vps->ondemand_data);
@@ -1538,8 +1598,10 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
 		ret = PTR_ERR(devfreq);
 		dev_err(hba->dev, "Unable to register with devfreq %d\n", ret);
 
-		dev_pm_opp_remove(hba->dev, clki->min_freq);
-		dev_pm_opp_remove(hba->dev, clki->max_freq);
+		if (!hba->use_pm_opp) {
+			dev_pm_opp_remove(hba->dev, clki->min_freq);
+			dev_pm_opp_remove(hba->dev, clki->max_freq);
+		}
 		return ret;
 	}
 
@@ -1551,7 +1613,6 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
 static void ufshcd_devfreq_remove(struct ufs_hba *hba)
 {
 	struct list_head *clk_list = &hba->clk_list_head;
-	struct ufs_clk_info *clki;
 
 	if (!hba->devfreq)
 		return;
@@ -1559,9 +1620,13 @@ static void ufshcd_devfreq_remove(struct ufs_hba *hba)
 	devfreq_remove_device(hba->devfreq);
 	hba->devfreq = NULL;
 
-	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
-	dev_pm_opp_remove(hba->dev, clki->min_freq);
-	dev_pm_opp_remove(hba->dev, clki->max_freq);
+	if (!hba->use_pm_opp) {
+		struct ufs_clk_info *clki;
+
+		clki = list_first_entry(clk_list, struct ufs_clk_info, list);
+		dev_pm_opp_remove(hba->dev, clki->min_freq);
+		dev_pm_opp_remove(hba->dev, clki->max_freq);
+	}
 }
 
 static void __ufshcd_suspend_clkscaling(struct ufs_hba *hba)
@@ -1646,7 +1711,7 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
 		ufshcd_resume_clkscaling(hba);
 	} else {
 		ufshcd_suspend_clkscaling(hba);
-		err = ufshcd_devfreq_scale(hba, true);
+		err = ufshcd_devfreq_scale(hba, ULONG_MAX, true);
 		if (err)
 			dev_err(hba->dev, "%s: failed to scale clocks up %d\n",
 					__func__, err);
@@ -7666,7 +7731,7 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	hba->silence_err_logs = false;
 
 	/* scale up clocks to max frequency before full reinitialization */
-	ufshcd_scale_clks(hba, true);
+	ufshcd_scale_clks(hba, ULONG_MAX, true);
 
 	err = ufshcd_hba_enable(hba);
 
@@ -9185,6 +9250,17 @@ static int ufshcd_init_clocks(struct ufs_hba *hba)
 		dev_dbg(dev, "%s: clk: %s, rate: %lu\n", __func__,
 				clki->name, clk_get_rate(clki->clk));
 	}
+
+	/* Set Max. frequency for all clocks */
+	if (hba->use_pm_opp) {
+		ret = ufshcd_opp_set_rate(hba, ULONG_MAX);
+		if (ret) {
+			dev_err(hba->dev, "%s: failed to set OPP: %d", __func__,
+				ret);
+			goto out;
+		}
+	}
+
 out:
 	return ret;
 }
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 6dc11fa0ebb1..9f61b6d56d11 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -407,6 +407,7 @@ struct ufs_clk_gating {
  * @workq: workqueue to schedule devfreq suspend/resume work
  * @suspend_work: worker to suspend devfreq
  * @resume_work: worker to resume devfreq
+ * @target_freq: frequency requested by devfreq framework
  * @min_gear: lowest HS gear to scale down to
  * @is_enabled: tracks if scaling is currently enabled or not, controlled by
  *		clkscale_enable sysfs node
@@ -426,6 +427,7 @@ struct ufs_clk_scaling {
 	struct workqueue_struct *workq;
 	struct work_struct suspend_work;
 	struct work_struct resume_work;
+	unsigned long target_freq;
 	u32 min_gear;
 	bool is_enabled;
 	bool is_allowed;
@@ -870,6 +872,7 @@ enum ufshcd_mcq_opr {
  * @auto_bkops_enabled: to track whether bkops is enabled in device
  * @vreg_info: UFS device voltage regulator information
  * @clk_list_head: UFS host controller clocks list node head
+ * @use_pm_opp: Indicates whether OPP based scaling is used or not
  * @req_abort_count: number of times ufshcd_abort() has been called
  * @lanes_per_direction: number of lanes per data direction between the UFS
  *	controller and the UFS device.
@@ -1021,6 +1024,7 @@ struct ufs_hba {
 	bool auto_bkops_enabled;
 	struct ufs_vreg_info vreg_info;
 	struct list_head clk_list_head;
+	bool use_pm_opp;
 
 	/* Number of requests aborts */
 	int req_abort_count;
-- 
2.25.1

