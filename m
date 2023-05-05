Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1BA6F8539
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjEEPDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjEEPDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:03:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD8917FDA
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 08:02:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f199696149so13445705e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683298977; x=1685890977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnwRc6d0+9EWZZzimRgYOvHwHdEA2vECtr+bww8AbFg=;
        b=FibUsG3XI9Lq7wQ10qHYw/Bvt6sUQW4LEEw3nWXXvzewtyxloN0yZOkBzvfttujGim
         vFuP0GcJta/xmjbRYfKkiefgfPljvOLCmDY+0Tgsdsp19o9n5gEKo1Gj1zbWYg7Nf2tZ
         UCrzqRNmkJMrp7xnq9s9QSQ/LnF+qK7X/2Jh6eNcQxEdIEL/sVMzTsHZ57nTC/44lee1
         p2eCF1D9kOyvOCrc0QSM1K23acPCaZeJAuKMf4omicQI9iSY8qLbrYMEfImx8ioyAKxe
         W1OfYq9B+1cLYhMFilkzud3FPlXJD9hk2esMl5kBpPXhYS0V/WTtByoTE7bcB+wBw1tJ
         mcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683298977; x=1685890977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnwRc6d0+9EWZZzimRgYOvHwHdEA2vECtr+bww8AbFg=;
        b=fnZLdyqjotsO1+HmFQGMWDf4YcgtG8A+xMvu2Th5LW+klTFbU5bpMUkGk//GghykT4
         0/AWEpJSLqHxayx7P7eL03HPmXEvRI3ZovlTFswHew3lAvL69iy4vAZ4T3HacAZgcEDG
         CkZntVandN2mAp8BoJg2qTmEkkmB65aRoMtmp2DiQynIszQ39X6KhraWRl2dMiX9Anm3
         B3NRkFhrIt9NvlJmX2zdsKWh7hz4RNbXmTepK9N/Pq9Yk/7r4iFktj4ncJvR6X/Ndv+q
         iet7yK5rFkxob7oP8j7PJYQvNZEBdEXSvmydIbJ3W5h6961XNqoSj618Z2ceZcJ4UdA+
         evwA==
X-Gm-Message-State: AC+VfDzQVNwdzX2kiRShSwHL4JRboKzw6sJTnmsI/jNpEPxwltpLhYVd
        rFoRVimfaOBkxtXUwOxgf51aBA==
X-Google-Smtp-Source: ACHHUZ4orA7JAVJkHC48E6ikDofmVT5wSbQFY3BgobWZT+r3BuhvDX8LQwhPbFjsUaNlsygGnWg7Fg==
X-Received: by 2002:a05:600c:2293:b0:3f3:1fa6:d2a8 with SMTP id 19-20020a05600c229300b003f31fa6d2a8mr1436996wmf.25.1683298976745;
        Fri, 05 May 2023 08:02:56 -0700 (PDT)
Received: from hackbox.lan ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id a6-20020a1cf006000000b003f0aefcc457sm8262189wmb.45.2023.05.05.08.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 08:02:56 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: [RFC PATCH v4 2/2] PM: domains: Skip disabling unused until sync state
Date:   Fri,  5 May 2023 18:02:41 +0300
Message-Id: <20230505150241.3469424-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505150241.3469424-1-abel.vesa@linaro.org>
References: <20230505150241.3469424-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By storing the status of the domain at boot, specified by the provider,
we can decide to skip powering 'off' the domain on the late initcall,
strictly based on the status boot being 'on' or 'unknown', and then
assume the provider will disable it from its sync state callback.
Also, provide a generic genpd sync state callback for those providers
that only need that when they state synced.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/base/power/domain.c | 51 +++++++++++++++++++++++++++++++++++--
 include/linux/pm_domain.h   |  5 ++++
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 33a3945c023e..9cc0ce43b47b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -125,6 +125,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_unlock(p)			p->lock_ops->unlock(p)
 
 #define genpd_status_on(genpd)		(genpd->status == GENPD_STATE_ON)
+#define genpd_boot_keep_on(genpd)	(!(genpd->boot_status == GENPD_STATE_OFF))
 #define genpd_is_irq_safe(genpd)	(genpd->flags & GENPD_FLAG_IRQ_SAFE)
 #define genpd_is_always_on(genpd)	(genpd->flags & GENPD_FLAG_ALWAYS_ON)
 #define genpd_is_active_wakeup(genpd)	(genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
@@ -654,6 +655,29 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
 	queue_work(pm_wq, &genpd->power_off_work);
 }
 
+/**
+ * pm_genpd_power_off_unused_sync_state - Power off all domains for provider.
+ * @dev: Provider's device.
+ *
+ * Request power off for all unused domains of the provider.
+ * This should be used exclusively as sync state callback for genpd providers.
+ */
+void pm_genpd_power_off_unused_sync_state(struct device *dev)
+{
+	struct generic_pm_domain *genpd;
+
+	mutex_lock(&gpd_list_lock);
+
+	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
+		if (genpd->provider->dev == dev && genpd_boot_keep_on(genpd)) {
+			genpd->boot_status = GENPD_STATE_OFF;
+			genpd_queue_power_off_work(genpd);
+		}
+
+	mutex_unlock(&gpd_list_lock);
+}
+EXPORT_SYMBOL_GPL(pm_genpd_power_off_unused_sync_state);
+
 /**
  * genpd_power_off - Remove power from a given PM domain.
  * @genpd: PM domain to power down.
@@ -674,6 +698,12 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	unsigned int not_suspended = 0;
 	int ret;
 
+	/*
+	 * If the domain was left enabled at boot stage,
+	 * abort power off until sync state is reached.
+	 */
+	if (genpd_boot_keep_on(genpd))
+		return -EBUSY;
 	/*
 	 * Do not try to power off the domain in the following situations:
 	 * (1) The domain is already in the "power off" state.
@@ -763,6 +793,12 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 	struct gpd_link *link;
 	int ret = 0;
 
+	/*
+	 * Just in case this is the first power on request, mark the boot
+	 * status of it as 'off'.
+	 */
+	genpd->boot_status = GENPD_STATE_OFF;
+
 	if (genpd_status_on(genpd))
 		return 0;
 
@@ -1095,8 +1131,16 @@ static int __init genpd_power_off_unused(void)
 
 	mutex_lock(&gpd_list_lock);
 
+	/*
+	 * If the provider has registered a 'sync state' callback,
+	 * assume that callback will power off its registered unused domains,
+	 * otherwise we power them off from here.
+	 */
 	list_for_each_entry(genpd, &gpd_list, gpd_list_node)
-		genpd_queue_power_off_work(genpd);
+		if (!dev_has_sync_state(&genpd->dev)) {
+			genpd->boot_status = GENPD_STATE_OFF;
+			genpd_queue_power_off_work(genpd);
+		}
 
 	mutex_unlock(&gpd_list_lock);
 
@@ -1124,6 +1168,9 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 {
 	struct gpd_link *link;
 
+	if (genpd_boot_keep_on(genpd))
+		return;
+
 	if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
 		return;
 
@@ -2064,7 +2111,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->gov = gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	atomic_set(&genpd->sd_count, 0);
-	genpd->status = boot_status;
+	genpd->status = genpd->boot_status = boot_status;
 	genpd->device_count = 0;
 	genpd->provider = NULL;
 	genpd->has_provider = false;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index c545e44ee52b..86bb531a319c 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -132,6 +132,7 @@ struct generic_pm_domain {
 	const char *name;
 	atomic_t sd_count;	/* Number of subdomains with power "on" */
 	enum gpd_status status;	/* Current state of the domain */
+	enum gpd_status boot_status;	/* Boot state of the domain */
 	unsigned int device_count;	/* Number of devices */
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
@@ -233,6 +234,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		  struct dev_power_governor *gov,
 		  enum gpd_status boot_status);
 int pm_genpd_remove(struct generic_pm_domain *genpd);
+void pm_genpd_power_off_unused_sync_state(struct device *dev);
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_genpd_remove_notifier(struct device *dev);
@@ -281,6 +283,9 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
 	return -EOPNOTSUPP;
 }
 
+static inline void pm_genpd_power_off_unused_sync_state(struct device *dev)
+{ }
+
 static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 						     unsigned int state)
 {
-- 
2.34.1

