Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3603725FF4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbjFGMrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241077AbjFGMr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:47:26 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8961FDD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:47:14 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f6148f9679so6776882e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686142032; x=1688734032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmd8HT7dYpFwRTq0How6UAlKRFjjp2QQNX4mDltPGDc=;
        b=HBg+TlFMgB3o6cTaUfYJew1Qay1qLLHcPyGSbprNVTSjMoblHCrw2ugrurnH+Kbw8l
         IwOFLfw+Qq9upy6zJyu5GVl0exUC0n2iozSCQiUmAKH96nQj4rAm4wIdzJHZqlbpU/8e
         LqmFvnXGNhsuiVg4HGdKAQpXz5dWxvV8MLeFIkdUfy8EnPHGpU/tZ3y8hRdySi4kI3Ni
         pyOAK730tqsq/MgHOezVmFrkrstPc4JQZGog3gMwuVwQa0BCnPNqNDEN6wgDZNsWN4uK
         DOSQZA8ClDAvkIx/j7qgtkhWH9ScHebJJVtbj08nli8fTLgSqfKP/EFhtNQsR3snjyIm
         UI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142032; x=1688734032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmd8HT7dYpFwRTq0How6UAlKRFjjp2QQNX4mDltPGDc=;
        b=UIthONZSePzHG11DRgns1gej9yrU0vIrIsfwastqjpdnUb6B2VbJOyhJUVq1M8qg0c
         zAs3j4Dj2YuaTj1DIBJAWIWmAN1Wvy5qz2ywvOg95BrzEuBl6YPk1chADhw4pqXO1Y/V
         X1l4AwUIAXbGyQOsPPyr0NXeIjKm6QyccaR+TFI5ZYlk3uZUx/cjmt8tmsmGiri3kXM5
         4mYVefneCvDWfFu9FI6+AH4608cM0jF49BqRcqYmti5wN4jY6ydf11DMHk84LqgbjDD0
         RtzPQSbbzMR3BGfFNZ5/tbh501lr65/MXSCEus+5mxGUnMS28IRDoPZH50Qy4kFTtODJ
         tVgw==
X-Gm-Message-State: AC+VfDydWSSzl+fxRO4SAeXBrufOamE235WKxpyZgUzIJvsiCDoRb68X
        K3GzwmWHC4wCtxnoX+wmP4IAug==
X-Google-Smtp-Source: ACHHUZ5yaVd7KzIOTDmEnIJmHTR8qnWHnno0l6A3omE0ob8X/gHt9eymtj/RgnH2H/2G007jrU6B/A==
X-Received: by 2002:ac2:47eb:0:b0:4f3:87d7:f7a4 with SMTP id b11-20020ac247eb000000b004f387d7f7a4mr2294228lfp.62.1686142032391;
        Wed, 07 Jun 2023 05:47:12 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z7-20020a19f707000000b004f4b3e9e0cesm1781708lfe.297.2023.06.07.05.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:47:11 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/16] OPP: Extend dev_pm_opp_data with OPP provider support
Date:   Wed,  7 Jun 2023 14:46:25 +0200
Message-Id: <20230607124628.157465-14-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607124628.157465-1-ulf.hansson@linaro.org>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow a dynamically added OPP to be coupled with a specific OPP provider
type, let's add a new enum variable in the struct dev_pm_opp_data.
Moreover, let's add support for a DEV_PM_OPP_TYPE_GENPD type, corresponding
to genpd's performance states support.

More precisely, this allows a genpd provider to dynamically add OPPs when a
device gets attached to it, that later can be used by a consumer driver
when it needs to change the performance level for its corresponding device.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/opp/core.c     | 19 +++++++++++++++++++
 drivers/opp/opp.h      |  1 +
 include/linux/pm_opp.h |  7 +++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 79b4b44ced3e..81a3418e2eaf 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1112,6 +1112,15 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 			return ret;
 		}
 
+		if (opp->provider == DEV_PM_OPP_TYPE_GENPD) {
+			ret = dev_pm_genpd_set_performance_state(dev, opp->level);
+			if (ret) {
+				dev_err(dev, "Failed to set performance level: %d\n",
+					ret);
+				return ret;
+			}
+		}
+
 		ret = _set_opp_bw(opp_table, opp, dev);
 		if (ret) {
 			dev_err(dev, "Failed to set bw: %d\n", ret);
@@ -1155,6 +1164,15 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 			return ret;
 		}
 
+		if (opp->provider == DEV_PM_OPP_TYPE_GENPD) {
+			ret = dev_pm_genpd_set_performance_state(dev, opp->level);
+			if (ret) {
+				dev_err(dev, "Failed to set performance level: %d\n",
+					ret);
+				return ret;
+			}
+		}
+
 		ret = _set_required_opps(dev, opp_table, opp, false);
 		if (ret) {
 			dev_err(dev, "Failed to set required opps: %d\n", ret);
@@ -1955,6 +1973,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 	/* populate the opp table */
 	new_opp->rates[0] = opp->freq;
 	new_opp->level = opp->level;
+	new_opp->provider = opp->provider;
 	tol = u_volt * opp_table->voltage_tolerance_v1 / 100;
 	new_opp->supplies[0].u_volt = u_volt;
 	new_opp->supplies[0].u_volt_min = u_volt - tol;
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index b15770b2305e..ee2b3bd89213 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -104,6 +104,7 @@ struct dev_pm_opp {
 	unsigned int pstate;
 	unsigned long *rates;
 	unsigned int level;
+	enum dev_pm_opp_provider_type provider;
 
 	struct dev_pm_opp_supply *supplies;
 	struct dev_pm_opp_icc_bw *bandwidth;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 2c6f67736579..4c40199c7728 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -26,6 +26,11 @@ enum dev_pm_opp_event {
 	OPP_EVENT_ADJUST_VOLTAGE,
 };
 
+enum dev_pm_opp_provider_type {
+	DEV_PM_OPP_TYPE_NONE = 0,
+	DEV_PM_OPP_TYPE_GENPD,
+};
+
 /**
  * struct dev_pm_opp_supply - Power supply voltage/current values
  * @u_volt:	Target voltage in microvolts corresponding to this OPP
@@ -97,11 +102,13 @@ struct dev_pm_opp_config {
  * @level: The performance level for the OPP.
  * @freq: The clock rate in Hz for the OPP.
  * @u_volt: The voltage in uV for the OPP.
+ * @provider: The type of provider for the OPP.
  */
 struct dev_pm_opp_data {
 	unsigned int level;
 	unsigned long freq;
 	unsigned long u_volt;
+	enum dev_pm_opp_provider_type provider;
 };
 
 #if defined(CONFIG_PM_OPP)
-- 
2.34.1

