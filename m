Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307296CAEF6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjC0Tix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjC0Tio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:38:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A312738
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:38:42 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eh3so40650964edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679945921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsEPgMY5BFjwdL0oALK9gMsrag92KFHyzI19rln1PIE=;
        b=OyLa/9dGtp66ezkTixrZsqvmqd5gqTBnNDqdv73CyVFo8D4VcoVzTZbABOcXWtHl+e
         OZkxQEn/l7GGqXQ2OuwEOhxhhhHpVTT+VRragVayCD+FzaUwhB9SOX1HDP3SM8tanc1Q
         2eBuOlJgjKRAuZIGIDS2/XVY/2YuXfBf9UP6Tv1wrblkNMsDC8SrJjO39/AHv3UDjQEq
         4lXOEcE5NfWgXhpW1rFxLXv0bDQjjKi0Gks5y94sP6UukKf2pFCQfR2wNG+nxnOu+iId
         FCwp1tCh8lni/MYxM0esvUWWi2fT3+sDloxAV5P+CFSCLW3oWOXfKtxdQRV4xLg7MvrD
         boWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679945921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsEPgMY5BFjwdL0oALK9gMsrag92KFHyzI19rln1PIE=;
        b=BgT+XbMaTNLB6ftcVoLfh8nCa0mZ4qynDt7v3TFJmJMoUtV8knLUTD4b4oMwKRnAWz
         uJ+uoGeUtKBE0a/tu2n2Dw2uq2uqUwyEYiNYkgYENRglh56CH+PdWrSS2nMzBvUAOUK2
         xeliRdrySkrUGC7LbimbggDTOANz4yCzNEgvEgC6CmNs3NbEPK4akzYSZ3JhFS6AdlgH
         feBvCmQeVCiOBo4H6xweJcd8Tz11VEzC/c92AdRgmvD5RfMqcJQgEYoP/JlJ/qzy3F45
         J+DBaoB5iM6eCeqdJ/3zOYAi79yzvCMUEb0y68ywI/vJg8kwo55PpvIlgKaalZmVXla/
         wswA==
X-Gm-Message-State: AAQBX9e6tap87jFAR5sY8koh7CEp0/CiXdgCsBs3L+AqUMg6ivf3Q12X
        GeGeLTO16vpOAo1B3fI5MrVC5Q==
X-Google-Smtp-Source: AKy350ZwNF8Xu5+4eGdhXdHDrA1hqhB2p4RHUk+qIBtKBTqrNiayByfa35LNiX6/ZISwTisJWl5iGg==
X-Received: by 2002:a17:906:8398:b0:900:a150:cea3 with SMTP id p24-20020a170906839800b00900a150cea3mr13197868ejx.9.1679945921642;
        Mon, 27 Mar 2023 12:38:41 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id kb1-20020a1709070f8100b00933c4a25735sm11701254ejc.100.2023.03.27.12.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 12:38:41 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 3/4] clk: qcom: gdsc: Avoid actual power off until sync state
Date:   Mon, 27 Mar 2023 22:38:28 +0300
Message-Id: <20230327193829.3756640-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327193829.3756640-1-abel.vesa@linaro.org>
References: <20230327193829.3756640-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case there is a sync state callback registered for a provider,
do not actually power off any gdsc for that provider until sync state
has been reached and return busy instead. Since the qcom_cc is
private, add a helper that returns the gdsc_desc based on the device of
the provider. Finally, add the generic gdsc sync state callback to be
used by the platform specific providers.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/qcom/common.c | 19 +++++++++++++++++++
 drivers/clk/qcom/common.h |  2 ++
 drivers/clk/qcom/gdsc.c   | 26 ++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h   |  6 ++++++
 4 files changed, 53 insertions(+)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 75f09e6e057e..d7fd1b170c1c 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -20,6 +20,7 @@
 struct qcom_cc {
 	struct qcom_reset_controller reset;
 	struct clk_regmap **rclks;
+	struct gdsc_desc *scd;
 	size_t num_rclks;
 };
 
@@ -234,6 +235,13 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
 	return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
 }
 
+struct gdsc_desc *qcom_cc_get_gdsc_desc(struct device *dev)
+{
+	struct qcom_cc *cc = dev_get_drvdata(dev);
+
+	return cc->scd;
+}
+
 int qcom_cc_really_probe(struct platform_device *pdev,
 			 const struct qcom_cc_desc *desc, struct regmap *regmap)
 {
@@ -251,6 +259,8 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 	if (!cc)
 		return -ENOMEM;
 
+	dev_set_drvdata(dev, cc);
+
 	reset = &cc->reset;
 	reset->rcdev.of_node = dev->of_node;
 	reset->rcdev.ops = &qcom_reset_ops;
@@ -267,6 +277,9 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 		scd = devm_kzalloc(dev, sizeof(*scd), GFP_KERNEL);
 		if (!scd)
 			return -ENOMEM;
+
+		cc->scd = scd;
+
 		scd->dev = dev;
 		scd->scs = desc->gdscs;
 		scd->num = desc->num_gdscs;
@@ -319,6 +332,12 @@ int qcom_cc_probe(struct platform_device *pdev, const struct qcom_cc_desc *desc)
 }
 EXPORT_SYMBOL_GPL(qcom_cc_probe);
 
+void qcom_cc_sync_state(struct device *dev)
+{
+	gdsc_sync_state(dev);
+}
+EXPORT_SYMBOL_GPL(qcom_cc_sync_state);
+
 int qcom_cc_probe_by_index(struct platform_device *pdev, int index,
 			   const struct qcom_cc_desc *desc)
 {
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 9c8f7b798d9f..1bea04da0a00 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -61,9 +61,11 @@ extern struct regmap *qcom_cc_map(struct platform_device *pdev,
 extern int qcom_cc_really_probe(struct platform_device *pdev,
 				const struct qcom_cc_desc *desc,
 				struct regmap *regmap);
+extern struct gdsc_desc *qcom_cc_get_gdsc_desc(struct device *dev);
 extern int qcom_cc_probe(struct platform_device *pdev,
 			 const struct qcom_cc_desc *desc);
 extern int qcom_cc_probe_by_index(struct platform_device *pdev, int index,
 				  const struct qcom_cc_desc *desc);
+extern void qcom_cc_sync_state(struct device *dev);
 
 #endif
diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 5358e28122ab..ea7d753a38ef 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -15,6 +15,8 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
+
+#include "common.h"
 #include "gdsc.h"
 
 #define PWR_ON_MASK		BIT(31)
@@ -319,6 +321,9 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	struct gdsc *sc = domain_to_gdsc(domain);
 	int ret;
 
+	if (!sc->state_synced)
+		return -EBUSY;
+
 	if (sc->pwrsts == PWRSTS_ON)
 		return gdsc_assert_reset(sc);
 
@@ -365,6 +370,7 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 
 static int gdsc_init(struct gdsc *sc)
 {
+	struct device *dev = sc->dev;
 	u32 mask, val;
 	int on, ret;
 
@@ -452,6 +458,9 @@ static int gdsc_init(struct gdsc *sc)
 	if (!sc->pd.power_on)
 		sc->pd.power_on = gdsc_enable;
 
+	if (!dev_has_sync_state(dev))
+		sc->state_synced = true;
+
 	ret = pm_genpd_init(&sc->pd, NULL, !on);
 	if (ret)
 		goto err_disable_supply;
@@ -496,6 +505,7 @@ int gdsc_register(struct gdsc_desc *desc,
 	for (i = 0; i < num; i++) {
 		if (!scs[i])
 			continue;
+		scs[i]->dev = dev;
 		scs[i]->regmap = regmap;
 		scs[i]->rcdev = rcdev;
 		ret = gdsc_init(scs[i]);
@@ -536,6 +546,22 @@ void gdsc_unregister(struct gdsc_desc *desc)
 	of_genpd_del_provider(dev->of_node);
 }
 
+void gdsc_sync_state(struct device *dev)
+{
+	struct gdsc_desc *scd = qcom_cc_get_gdsc_desc(dev);
+	struct gdsc **scs = scd->scs;
+	size_t num = scd->num;
+	int i;
+
+	for (i = 0; i < num; i++) {
+		if (!scs[i])
+			continue;
+
+		scs[i]->state_synced = true;
+		pm_genpd_queue_power_off(&scs[i]->pd);
+	}
+}
+
 /*
  * On SDM845+ the GPU GX domain is *almost* entirely controlled by the GMU
  * running in the CX domain so the CPU doesn't need to know anything about the
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 803512688336..e1c902caecde 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -35,6 +35,7 @@ struct gdsc {
 	struct generic_pm_domain	pd;
 	struct generic_pm_domain	*parent;
 	struct regmap			*regmap;
+	struct device			*dev;
 	unsigned int			gdscr;
 	unsigned int			collapse_ctrl;
 	unsigned int			collapse_mask;
@@ -73,6 +74,8 @@ struct gdsc {
 
 	const char 			*supply;
 	struct regulator		*rsupply;
+
+	bool				state_synced;
 };
 
 struct gdsc_desc {
@@ -86,6 +89,7 @@ int gdsc_register(struct gdsc_desc *desc, struct reset_controller_dev *,
 		  struct regmap *);
 void gdsc_unregister(struct gdsc_desc *desc);
 int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain);
+void gdsc_sync_state(struct device *dev);
 #else
 static inline int gdsc_register(struct gdsc_desc *desc,
 				struct reset_controller_dev *rcdev,
@@ -94,6 +98,8 @@ static inline int gdsc_register(struct gdsc_desc *desc,
 	return -ENOSYS;
 }
 
+static inline void gdsc_sync_state(struct device *dev) { }
+
 static inline void gdsc_unregister(struct gdsc_desc *desc) {};
 #endif /* CONFIG_QCOM_GDSC */
 #endif /* __QCOM_GDSC_H__ */
-- 
2.34.1

