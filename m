Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9A46BB484
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjCONXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjCONXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:23:42 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D0B525B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:23:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ek18so44347762edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678886619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqhvuVHwpVGYPj1wx2nfChRpVpIaSQgTHV9PFa+xcU4=;
        b=UsAAKnqynOf+CGYjQ+eAfuXtM4OZkXDj+dNmcyHjBiZ8gH+LUv1IEFkcR1KNv3mAbg
         2vCP3Lmn95yeoXEWlzjV8f3RbAtJ0hE0P4SmjtspJKfhJO2Upi+bMtyefb/QFelag0C3
         1/5q7H92YbC4PM8Fgkfm1dGQGWBNVK40elIPH56ubtH1nkf++N5EHIfAV+jdnMdeT0hO
         WvdKXsW9aDx/5gXtJi4Oady7nf04mxv1cdhBW9xg2+2AtfyKbPzf+crEkufH6GMSE9yV
         Eu7J24eEAGSOr1DC0yZw4BV9lRDDGZH26NPaAtJ5MTzDXH3Yr8uUTBL7XoQ7f2myaYUW
         zOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678886619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqhvuVHwpVGYPj1wx2nfChRpVpIaSQgTHV9PFa+xcU4=;
        b=Ay0kpWyAZ8/aKndJBHE/9QA9PdmJ71sR0YL7ij52FllgN5v+TFZu2HTHMoHhxwgG3U
         51P65AqdkbHEhCBba+WjzD2KuO6w2mjOWBnH6yf3RfTnnQpZozr/lGw7KQFNzM4akzWY
         WcaRopi3b2ezvLDlC3D0D9feiDJwr5V8kBWxCWly9nrbfex82ymgdTyo7mhn3XxiI9bx
         6xvI+6letJ5GTYX3cXarpjSk3nSnb7fwWUj6XKcuUmWZK+93ze7LwLl1GnFsQctPSqbI
         2VFNTOlWKbr6qlcxNNQC8izWZdUHHqSiTzMKgUuOY/fc9ZCKbmHdNK/a9e0UR9VZmlcV
         F2ig==
X-Gm-Message-State: AO0yUKUOTwXGhSYjcFzPMNf1iViGO0VCVnPUqERGpsgP4Afe87yHqsEq
        gDP+CU0z5wnX5eonYOw6YEVwlQ==
X-Google-Smtp-Source: AK7set8pwlmsIm8odlhiimk6qn4jYvTXoMnOIO03pAqLGGAYfkZ6JfwzBQxc201BT+jvzeQ9s6qLVA==
X-Received: by 2002:a17:907:2076:b0:878:625c:c8ff with SMTP id qp22-20020a170907207600b00878625cc8ffmr6136496ejb.54.1678886619280;
        Wed, 15 Mar 2023 06:23:39 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id pj18-20020a170906d79200b008b133f9b33dsm2497365ejb.169.2023.03.15.06.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:23:38 -0700 (PDT)
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
Subject: [RFC PATCH 3/5] clk: qcom: gdsc: Avoid actual power off until sync state
Date:   Wed, 15 Mar 2023 15:23:28 +0200
Message-Id: <20230315132330.450877-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315132330.450877-1-abel.vesa@linaro.org>
References: <20230315132330.450877-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
---
 drivers/clk/qcom/common.c | 13 +++++++++++++
 drivers/clk/qcom/common.h |  1 +
 drivers/clk/qcom/gdsc.c   | 26 ++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h   |  6 ++++++
 4 files changed, 46 insertions(+)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 75f09e6e057e..9bcda6952c20 100644
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
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 9c8f7b798d9f..170266b4e9e8 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -61,6 +61,7 @@ extern struct regmap *qcom_cc_map(struct platform_device *pdev,
 extern int qcom_cc_really_probe(struct platform_device *pdev,
 				const struct qcom_cc_desc *desc,
 				struct regmap *regmap);
+extern struct gdsc_desc *qcom_cc_get_gdsc_desc(struct device *dev);
 extern int qcom_cc_probe(struct platform_device *pdev,
 			 const struct qcom_cc_desc *desc);
 extern int qcom_cc_probe_by_index(struct platform_device *pdev, int index,
diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 5358e28122ab..af745907dc49 100644
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
+		genpd_queue_power_off_work(&scs[i]->pd);
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

