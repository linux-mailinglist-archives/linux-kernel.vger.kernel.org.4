Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026DC6C13C7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjCTNmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjCTNmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:42:32 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76FCF97D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:42:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r11so46912239edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679319749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPUxYFnkGMoE5avSL4JFzjtLyBuUkiovE45vzPm5gIE=;
        b=qDgGGZj4rTh9vnjkTHytvQnecNq3U/8RsnWgvn0sR57EYqL/Tk27hjcIYNMQMAfHcj
         Ly/dojV9xXN6PUxnU0zzDS4hqZ6OBxig+eFKGKlhvM9EJA92rLXvzCMFYbwAl1ZAwjZH
         BJ0JSiMmvmhHjUzIM6uiHD1xrCflH+W/dtwOlQSXt7+qMYN31DPIIlzuv7okpLvIrskM
         ioUKKh5/KOJhfNKWsQUeCvxtsp0VyOiJUBj6qgUzyeVuZhbLRgbGEYyiREU0ZERUHhn5
         xBOiBXl1fkDQsFj9ggEELJ/W6bNs09FZcaJ3juwjNS2RGiEW/6KdfN2nOrSVkGJRZg1X
         Bj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679319749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPUxYFnkGMoE5avSL4JFzjtLyBuUkiovE45vzPm5gIE=;
        b=v8Pu05rcJcyVp6MvatooIMT/38ebbo5FroLTZWT/7I7WIOaJkiKQXQcaQwUBKwQs8P
         g7A99DjyLyO3w8m4I4+WacFQp83u6qUxr6WDrhUycFqxoTeTggU1ODTNgnBN1Uy6u0Vr
         m/BJLabz9V3B3RpQuvTOzzQAvgPGUeDCmXoQ633v5b+IkTsjW7GsAizLvYuPVFpRq4ub
         s6lmiIrdncVDnkqrEKAa9CYmS0czaZbAKY2d4CeqGfVtx4m11od9IHOuLA5YCDOKP2Kk
         BfFeEs1TP3EfzS5CAtAGuTsuWm2/WPnXUV6dmXcFlr8Dg68S/YSrOLD0qp5ARmwZa26u
         N0pw==
X-Gm-Message-State: AO0yUKXTsCuH++UDnyhoyMsIqfxjHJ6FcDtOlpTydfIIzzB5TOyUE2je
        qxmHHkEkaXQAwNOCJuKXZQyooQ==
X-Google-Smtp-Source: AK7set9MXHEJtUYrxRfCKi0r5p0hqHTOQrRzxZchU9k4CB8noF1liekyd/seH/UA43C9v9iMsMnztw==
X-Received: by 2002:a17:906:1906:b0:925:1d1d:6825 with SMTP id a6-20020a170906190600b009251d1d6825mr9770894eje.42.1679319748816;
        Mon, 20 Mar 2023 06:42:28 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u23-20020a170906409700b009334a6ef3e8sm2368602ejj.141.2023.03.20.06.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 06:42:28 -0700 (PDT)
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
Subject: [RFC PATCH v2 3/5] clk: qcom: gdsc: Avoid actual power off until sync state
Date:   Mon, 20 Mar 2023 15:42:15 +0200
Message-Id: <20230320134217.1685781-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320134217.1685781-1-abel.vesa@linaro.org>
References: <20230320134217.1685781-1-abel.vesa@linaro.org>
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

In case there is a sync state callback registered for a provider,
do not actually power off any gdsc for that provider until sync state
has been reached and return busy instead. Since the qcom_cc is
private, add a helper that returns the gdsc_desc based on the device of
the provider. Finally, add the generic gdsc sync state callback to be
used by the platform specific providers.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
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

