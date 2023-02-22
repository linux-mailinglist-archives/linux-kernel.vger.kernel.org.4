Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6C769F32C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjBVLHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjBVLHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:07:11 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93A6392B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:07:03 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q189so3858307pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDg7lq2x44X37ra1GNdaDrKzjiETRuIzGhmCMqpU5cE=;
        b=r1B1OjeRgYE2hqrawLKj4xpLJVqD/NOJn2YO5tpvGrJoVa63RKypdjpj7HIRczRaRq
         4EJSObe8KfRHFxJGyQ/5jOv5SajH0HE7OCEeJuBmMwMUwQjgw96J13XWoBgSvhs68U4u
         oMFV2k0JCMxS0aFax7sI1VqIq1Blgx2Z9M9xJAR3b5/N1z699TcZHAcRIYFDq5vzfm4E
         oMRdVlhqbsVRnpS7qVtEJuDP0ffT/nlbbiryV/2HEPVWlknxa0uNTpfuQ2rDBjfyUdt3
         wEgbEl7QURSywxkwf3cxQGTzx1qsPwfjyqxd5P+yeUUHcI1fZJ6eyAiJhDxzat3cRYM6
         yz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDg7lq2x44X37ra1GNdaDrKzjiETRuIzGhmCMqpU5cE=;
        b=pRA51AyvKzlyNXXXg4dyH7k9Fpwt2j9wHnFXyv4PciIOYWZZ/1s5auRcp6m7DyUmbv
         YwC4+yzRbrHlmy4d5E7xdtx3i+6EmRVWrhi644sdryEISL4QBnhzftdJcq2mVN+MLZXX
         vMfCJQOAtz7YN4ycYDrxL8OpfFExuYDnynmP08kX55VlZ38vm6KMeX/2+NhL+MkzgJ5l
         xg/DQei+jpN0pr9PNk0nB/Pw/l0KyISefK2p47pdKToVGLjqGIkp72rk6DkMDs1ZIGdp
         4eQJkqZ2IXCLV2QvkYgw82SJXOPZrZAM7itijtK1O6QBsrHCk3q1R0VNzofFaKpk+Lqh
         ozfQ==
X-Gm-Message-State: AO0yUKUiyQ6jXxUpP2UPgFoq7hqob4gsqwDjHCNVn+/NqAa6PxgwvjdT
        XJXggLQMOHa4USVaP0DY+HUmZw==
X-Google-Smtp-Source: AK7set9fKC+RycmDf0F/GqylOk93+YTe3GQqwm+VQ6ERcOpZORV12Lo/ieqtt/fuMQqEOwm55GXHRw==
X-Received: by 2002:a62:52d5:0:b0:5a8:ad9d:83f with SMTP id g204-20020a6252d5000000b005a8ad9d083fmr6289573pfb.24.1677064023416;
        Wed, 22 Feb 2023 03:07:03 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm4822377pfd.186.2023.02.22.03.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 03:07:02 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jun Nie <jun.nie@linaro.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] OPP: Allow platforms to add a set_required_opps() callback
Date:   Wed, 22 Feb 2023 16:36:39 +0530
Message-Id: <c71a39caa8f1c64c24ce0c4ba070fc8b5226747d.1677063656.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1677063656.git.viresh.kumar@linaro.org>
References: <cover.1677063656.git.viresh.kumar@linaro.org>
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

We currently configure required-opps only for genpds, as we aren't
really sure what's required of the other use cases. This patch allows
platforms to add their own set_required_opps() helper.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
Jun,

I think this can replace the cpufreq notification from the devfreq driver
(get_target_freq_with_cpufreq()), which is used currently only by
mtk-cci-devfreq.c. Instead of the notification, the aggregation of the requests
for the devfreq device can be done within this callback.

What do you say ?
---
 drivers/opp/core.c     | 35 +++++++++++++++++++++++++++++++++++
 drivers/opp/opp.h      |  4 ++--
 include/linux/pm_opp.h |  5 +++++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 954c94865cf5..22985ad7af79 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2421,8 +2421,35 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 	mutex_unlock(&opp_table->genpd_virt_dev_lock);
 }
 
+/**
+ * _opp_set_required_opps_helper() - Register custom set required opps helper.
+ * @dev: Device for which the helper is getting registered.
+ * @set_required_opps: Custom set required opps helper.
+ *
+ * This must be called before any OPPs are initialized for the device.
+ */
+static void _opp_set_required_opps_helper(struct opp_table *opp_table,
+					  set_required_opps_t set_required_opps)
+{
+	opp_table->set_required_opps = set_required_opps;
+}
+
+/**
+ * _opp_put_required_opps_helper() - Releases resources blocked for
+ *					 required opps helper.
+ * @opp_table: OPP table returned from _opp_set_required_opps_helper().
+ *
+ * Release resources blocked for platform specific required opps helper.
+ */
+static void _opp_put_required_opps_helper(struct opp_table *opp_table)
+{
+	opp_table->set_required_opps = NULL;
+}
+
 static void _opp_clear_config(struct opp_config_data *data)
 {
+	if (data->flags & OPP_CONFIG_REQUIRED_OPPS)
+		_opp_put_required_opps_helper(data->opp_table);
 	if (data->flags & OPP_CONFIG_GENPD)
 		_opp_detach_genpd(data->opp_table);
 	if (data->flags & OPP_CONFIG_REGULATOR)
@@ -2546,6 +2573,14 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 		data->flags |= OPP_CONFIG_GENPD;
 	}
 
+	/* Required opps helper */
+	if (config->set_required_opps) {
+		_opp_set_required_opps_helper(opp_table,
+					      config->set_required_opps);
+
+		data->flags |= OPP_CONFIG_REQUIRED_OPPS;
+	}
+
 	ret = xa_alloc(&opp_configs, &id, data, XA_LIMIT(1, INT_MAX),
 		       GFP_KERNEL);
 	if (ret)
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 2a057c42ddf4..54cfeb894f5d 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -35,6 +35,7 @@ extern struct list_head opp_tables, lazy_opp_tables;
 #define OPP_CONFIG_PROP_NAME		BIT(3)
 #define OPP_CONFIG_SUPPORTED_HW		BIT(4)
 #define OPP_CONFIG_GENPD		BIT(5)
+#define OPP_CONFIG_REQUIRED_OPPS	BIT(6)
 
 /**
  * struct opp_config_data - data for set config operations
@@ -235,8 +236,7 @@ struct opp_table {
 	bool enabled;
 	bool genpd_performance_state;
 	bool is_genpd;
-	int (*set_required_opps)(struct device *dev,
-		struct opp_table *opp_table, struct dev_pm_opp *opp, bool scaling_down);
+	set_required_opps_t set_required_opps;
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index dc1fb5890792..5a8c0cc50c96 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -64,6 +64,9 @@ typedef int (*config_regulators_t)(struct device *dev,
 typedef int (*config_clks_t)(struct device *dev, struct opp_table *opp_table,
 			struct dev_pm_opp *opp, void *data, bool scaling_down);
 
+typedef int (*set_required_opps_t)(struct device *dev, struct opp_table *opp_table,
+			struct dev_pm_opp *opp, bool scaling_down);
+
 /**
  * struct dev_pm_opp_config - Device OPP configuration values
  * @clk_names: Clk names, NULL terminated array.
@@ -76,6 +79,7 @@ typedef int (*config_clks_t)(struct device *dev, struct opp_table *opp_table,
  * @genpd_names: Null terminated array of pointers containing names of genpd to
  *		 attach.
  * @virt_devs: Pointer to return the array of virtual devices.
+ * @set_required_opps: Custom set required opps helper.
  *
  * This structure contains platform specific OPP configurations for the device.
  */
@@ -90,6 +94,7 @@ struct dev_pm_opp_config {
 	const char * const *regulator_names;
 	const char * const *genpd_names;
 	struct device ***virt_devs;
+	set_required_opps_t set_required_opps;
 };
 
 #if defined(CONFIG_PM_OPP)
-- 
2.31.1.272.g89b43f80a514

