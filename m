Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBC2602FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiJRP3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiJRP3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:29:05 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D4EBC470
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:29:03 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bs14so18394309ljb.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIHoKtHeSXxO4LyumWrPFFvJIZDXMTgh9sxej2UY0h8=;
        b=ulojaKy3M1drjBcgrb1mzDHoG+uItWDuJtCaHGJjQ6TIdrtO+ld+au0G1cRkuqshxX
         ocsXpsvyJB1HI1dOxz8sbq8W13zZY1n5/ZKBgmug5nYHYKrFsqERMFqGNRJSqTsvWKHv
         TKXVGDmwApwYIeOIk1Hagu15w2TEGrCLxqKkhHazm5nlj6uKamdNFnrsWwO/jQVe1lPz
         7INPAf1g80y9Kct8CCgGDukNh4bMBfelb03s85FVMnEZQMpCd4C4Cp+sUj+5hSm2WbyV
         Waey7h8guz3nY5O/b86ccfu4U3xrmYLAEK64yaLkkE4fMuqlhYytNOMdzzJQVhjTgoQ8
         c+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIHoKtHeSXxO4LyumWrPFFvJIZDXMTgh9sxej2UY0h8=;
        b=E8NdZlogY+ud9LkKtc0JwbXv3sAE/fGXWNeJjgSrAULr0lNt+OWjWmBYCFpvtqCO3W
         7dxJlz6qwe1TWpBTqU2H50kMKaFtBdxOAY4e0uAwR4TdTGNKV5TCSE+Bdev0FS4caToh
         eHBnAWsC8th/13PHNfqLliySVrnSmoRcm0j+qZx5VFhjL7h+tr1SNTyNMzO68YeL47Cz
         +juTfpucI830/hJfSU0psdCFLxqGnhqrpEBUv7cz2BNXlO4YLp7j2vE6xqB/TruHUZTv
         00qLgR3A3+1UQymXOXTXoXKIlxWuiHADCKndDfQN76/ApAM6XnhJ7YnZM/oiw99iCnCD
         gntg==
X-Gm-Message-State: ACrzQf0WbFoN7NlkCCuG5X+Z2uW7pYzOQYyBWgaFgwLb7lv53/Y+FJsp
        j6TE0bl/rKF97xr7gqs4wrPcYg==
X-Google-Smtp-Source: AMsMyM7Lnlfo/C5FfOheCUeX2VF68lasQDCGHJb3QbFFdQS7PHctLGJF2qqJ5+5pQI8l2taaidSE8w==
X-Received: by 2002:a2e:2c12:0:b0:26f:e87b:d3aa with SMTP id s18-20020a2e2c12000000b0026fe87bd3aamr1306358ljs.315.1666106941260;
        Tue, 18 Oct 2022 08:29:01 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id a9-20020a05651c030900b0026ddd41aecasm1998617ljp.135.2022.10.18.08.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:29:00 -0700 (PDT)
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
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 4/6] PM: domains: Store the next hrtimer wakeup in genpd
Date:   Tue, 18 Oct 2022 17:28:35 +0200
Message-Id: <20221018152837.619426-5-ulf.hansson@linaro.org>
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

The arch timer cannot wake up the Qualcomm Technologies, Inc. (QTI) SoCs
from the deeper CPUidle states. To be able to wakeup from these deeper
states, another always-on timer needs to be programmed through the so
called CONTROL_TCS.

As the RSC is part of CPU subsystem and the corresponding APSS RSC device
is attached to the cluster PM domain (through genpd), it holds the
responsibility to program the always-on timer, before entering any of these
deeper CPUidle states.

However, programming the timer requires information about the next hrtimer
wakeup for the cluster PM domain, which is currently only known by genpd.
Therefore, let's share this data through a new genpd helper function,
dev_pm_genpd_get_next_hrtimer().

Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
[Ulf: Reworked the code and updated the commit message]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # SM8450
---
 drivers/base/power/domain.c          | 26 ++++++++++++++++++++++++++
 drivers/base/power/domain_governor.c |  3 +++
 include/linux/pm_domain.h            |  7 +++++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index ead135c7044c..c2dec386c72e 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -494,6 +494,31 @@ void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_set_next_wakeup);
 
+/**
+ * dev_pm_genpd_get_next_hrtimer - Return the next_hrtimer for the genpd
+ * @dev: A device that is attached to the genpd.
+ *
+ * This routine should typically be called for a device, at the point of when a
+ * GENPD_NOTIFY_PRE_OFF notification has been sent for it.
+ *
+ * Returns the aggregated value of the genpd's next hrtimer or KTIME_MAX if no
+ * valid value have been set.
+ */
+ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev)
+{
+	struct generic_pm_domain *genpd;
+
+	genpd = dev_to_genpd_safe(dev);
+	if (!genpd)
+		return KTIME_MAX;
+
+	if (genpd->gd)
+		return genpd->gd->next_hrtimer;
+
+	return KTIME_MAX;
+}
+EXPORT_SYMBOL_GPL(dev_pm_genpd_get_next_hrtimer);
+
 static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 {
 	unsigned int state_idx = genpd->state_idx;
@@ -1994,6 +2019,7 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 		gd->max_off_time_ns = -1;
 		gd->max_off_time_changed = true;
 		gd->next_wakeup = KTIME_MAX;
+		gd->next_hrtimer = KTIME_MAX;
 	}
 
 	/* Use only one "off" state if there were no states declared */
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 282a3a135827..cc2c3a5a6d35 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -375,6 +375,9 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	if (idle_duration_ns <= 0)
 		return false;
 
+	/* Store the next domain_wakeup to allow consumers to use it. */
+	genpd->gd->next_hrtimer = domain_wakeup;
+
 	/*
 	 * Find the deepest idle state that has its residency value satisfied
 	 * and by also taking into account the power off latency for the state.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ebc351698090..1cd41bdf73cf 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -17,6 +17,7 @@
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
 #include <linux/cpumask.h>
+#include <linux/time64.h>
 
 /*
  * Flags to control the behaviour of a genpd.
@@ -95,6 +96,7 @@ struct genpd_governor_data {
 	s64 max_off_time_ns;
 	bool max_off_time_changed;
 	ktime_t next_wakeup;
+	ktime_t next_hrtimer;
 	bool cached_power_down_ok;
 	bool cached_power_down_state_idx;
 };
@@ -232,6 +234,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_genpd_remove_notifier(struct device *dev);
 void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
+ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -293,6 +296,10 @@ static inline int dev_pm_genpd_remove_notifier(struct device *dev)
 static inline void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
 { }
 
+static inline ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev)
+{
+	return KTIME_MAX;
+}
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
 #endif
-- 
2.34.1

