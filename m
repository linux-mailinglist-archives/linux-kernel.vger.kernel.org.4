Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BAC725FF1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240909AbjFGMro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241066AbjFGMrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:47:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9D71FC1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:47:10 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f62b552751so4169454e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686142030; x=1688734030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFOFaTdB/ZAJjZPTuGERS2BWBk3lHevQSrGw284LH/A=;
        b=VDnMswoWv3vXbGiOyeKlRwDyVh+DQTlDneRSvPwp7iemvODyTy+cM31LXX6NhCSYbA
         wTp4dDrlmRGPT4rHQejDkJL38iDAByWnVWHOYDsn6Z29FjXHNbLtjIcGlRPvSV8J7P0m
         bjIIl2WKPB2zY4LQlV/w4+wswycvn99VC2JJNz4COf/zUUPzxQ/TwHV5kjJPX1ODiGuc
         23HhM4aGDRjmBGGjoKBDghYwVN7RGThmU66R2/MoS+gKsN0Me0hsrzrAnpOyBQej785l
         efeqj5qSS9SeXJPEm4g2001M65IDuIuO8Ao9+Dkoe+bMRwwYZPufT5nQKEP9U4jhUjDT
         VZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142030; x=1688734030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFOFaTdB/ZAJjZPTuGERS2BWBk3lHevQSrGw284LH/A=;
        b=LiVT3W8U4MQro/IMks8tj2RbdPsxf8aAZPyW8SOjiIefxcKx1fOmNkqlmQub8MBsol
         tzWYjmgY4V7wlYx7ysYCwcpxieY0Kz7TssnjcoNjN3nGZzSdv0aSXh667/QlG8zrVChw
         p7amKl4h4opIkSDInmcPW7QoC59iqn61Vr3I++ACZnP7jS8//hK/2KMbh1x53bOc2xo8
         uxHaiDsXLhUU0uwD1v/Ty48NGhBroLtsbplBknlmkUid1p40sLuVuavHyfPYrNhck/ky
         yp+yFq9x49A9LpErbMogL7NvU55pecpi5kBL6gBWI+Rq+EEj8GdxiBmvi2YRfwaXjmNu
         6rZQ==
X-Gm-Message-State: AC+VfDzlNBVPzziRF8/5lpFsP7qi8cqbL3W4pEPArtiTfF4bw19jhsZD
        tERtDpoz2/NswjNPxthTh8W2/A==
X-Google-Smtp-Source: ACHHUZ5wwtUo78oY555XmA9CeIllwbLEbC2LxOMp8LF9LoXOjriV0ZXhcNiRJoFkEDLb/DqT8FOxkA==
X-Received: by 2002:ac2:5108:0:b0:4f4:b592:74ab with SMTP id q8-20020ac25108000000b004f4b59274abmr1853886lfb.62.1686142029801;
        Wed, 07 Jun 2023 05:47:09 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z7-20020a19f707000000b004f4b3e9e0cesm1781708lfe.297.2023.06.07.05.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:47:09 -0700 (PDT)
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
Subject: [PATCH 11/16] OPP: Add dev_pm_opp_add_dynamic() to allow more flexibility
Date:   Wed,  7 Jun 2023 14:46:23 +0200
Message-Id: <20230607124628.157465-12-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607124628.157465-1-ulf.hansson@linaro.org>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_pm_opp_add() API is limited to add dynamic OPPs with a frequency
and/or voltage level. To enable more flexibility, let's add a new
dev_pm_opp_add_dynamic() API, that's takes a struct dev_pm_opp_data*
instead of list of in-parameters.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/opp/core.c     | 49 ++++++++++++++++++++++++++++++++----------
 drivers/opp/of.c       | 11 ++++++----
 drivers/opp/opp.h      |  2 +-
 include/linux/pm_opp.h | 18 ++++++++++++++++
 4 files changed, 64 insertions(+), 16 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 954c94865cf5..0e6ee2980f88 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1921,8 +1921,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
  * _opp_add_v1() - Allocate a OPP based on v1 bindings.
  * @opp_table:	OPP table
  * @dev:	device for which we do this operation
- * @freq:	Frequency in Hz for this OPP
- * @u_volt:	Voltage in uVolts for this OPP
+ * @opp:	The OPP to add
  * @dynamic:	Dynamically added OPPs.
  *
  * This function adds an opp definition to the opp table and returns status.
@@ -1940,10 +1939,10 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
  * -ENOMEM	Memory allocation failure
  */
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
-		unsigned long freq, long u_volt, bool dynamic)
+		struct dev_pm_opp_data *opp, bool dynamic)
 {
 	struct dev_pm_opp *new_opp;
-	unsigned long tol;
+	unsigned long tol, u_volt = opp->u_volt;
 	int ret;
 
 	if (!assert_single_clk(opp_table))
@@ -1954,7 +1953,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 		return -ENOMEM;
 
 	/* populate the opp table */
-	new_opp->rates[0] = freq;
+	new_opp->rates[0] = opp->freq;
 	tol = u_volt * opp_table->voltage_tolerance_v1 / 100;
 	new_opp->supplies[0].u_volt = u_volt;
 	new_opp->supplies[0].u_volt_min = u_volt - tol;
@@ -2738,10 +2737,9 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
 }
 
 /**
- * dev_pm_opp_add()  - Add an OPP table from a table definitions
- * @dev:	device for which we do this operation
- * @freq:	Frequency in Hz for this OPP
- * @u_volt:	Voltage in uVolts for this OPP
+ * dev_pm_opp_add_dynamic()  - Add an OPP table from a table definitions
+ * @dev:	The device for which we do this operation
+ * @opp:	The OPP to be added
  *
  * This function adds an opp definition to the opp table and returns status.
  * The opp is made available by default and it can be controlled using
@@ -2754,7 +2752,7 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
  *		Duplicate OPPs (both freq and volt are same) and !opp->available
  * -ENOMEM	Memory allocation failure
  */
-int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
+int dev_pm_opp_add_dynamic(struct device *dev, struct dev_pm_opp_data *opp)
 {
 	struct opp_table *opp_table;
 	int ret;
@@ -2766,12 +2764,41 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	/* Fix regulator count for dynamic OPPs */
 	opp_table->regulator_count = 1;
 
-	ret = _opp_add_v1(opp_table, dev, freq, u_volt, true);
+	ret = _opp_add_v1(opp_table, dev, opp, true);
 	if (ret)
 		dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dev_pm_opp_add_dynamic);
+
+/**
+ * dev_pm_opp_add()  - Add an OPP table from a table definitions
+ * @dev:	device for which we do this operation
+ * @freq:	Frequency in Hz for this OPP
+ * @u_volt:	Voltage in uVolts for this OPP
+ *
+ * This function adds an opp definition to the opp table and returns status.
+ * The opp is made available by default and it can be controlled using
+ * dev_pm_opp_enable/disable functions.
+ *
+ * Return:
+ * 0		On success OR
+ *		Duplicate OPPs (both freq and volt are same) and opp->available
+ * -EEXIST	Freq are same and volt are different OR
+ *		Duplicate OPPs (both freq and volt are same) and !opp->available
+ * -ENOMEM	Memory allocation failure
+ */
+int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
+{
+	struct dev_pm_opp_data opp;
+
+	memset(&opp, 0, sizeof(opp));
+	opp.freq = freq;
+	opp.u_volt = u_volt;
+
+	return dev_pm_opp_add_dynamic(dev, &opp);
+}
 EXPORT_SYMBOL_GPL(dev_pm_opp_add);
 
 /**
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 8246e9b7afe7..b96f6304f497 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1079,13 +1079,16 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 
 	val = prop->value;
 	while (nr) {
-		unsigned long freq = be32_to_cpup(val++) * 1000;
-		unsigned long volt = be32_to_cpup(val++);
+		struct dev_pm_opp_data opp;
 
-		ret = _opp_add_v1(opp_table, dev, freq, volt, false);
+		memset(&opp, 0, sizeof(opp));
+		opp.freq = be32_to_cpup(val++) * 1000;
+		opp.u_volt = be32_to_cpup(val++);
+
+		ret = _opp_add_v1(opp_table, dev, &opp, false);
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP %ld (%d)\n",
-				__func__, freq, ret);
+				__func__, opp.freq, ret);
 			goto remove_static_opp;
 		}
 		nr -= 2;
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 2a057c42ddf4..b15770b2305e 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -255,7 +255,7 @@ struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
 void _opp_free(struct dev_pm_opp *opp);
 int _opp_compare_key(struct opp_table *opp_table, struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table);
-int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
+int _opp_add_v1(struct opp_table *opp_table, struct device *dev, struct dev_pm_opp_data *opp, bool dynamic);
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
 struct opp_table *_add_opp_table_indexed(struct device *dev, int index, bool getclk);
 void _put_opp_list_kref(struct opp_table *opp_table);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index dc1fb5890792..305cd87b394c 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -92,6 +92,16 @@ struct dev_pm_opp_config {
 	struct device ***virt_devs;
 };
 
+/**
+ * struct dev_pm_opp_data - The data to use to initialize an OPP.
+ * @freq: The clock rate in Hz for the OPP.
+ * @u_volt: The voltage in uV for the OPP.
+ */
+struct dev_pm_opp_data {
+	unsigned long freq;
+	unsigned long u_volt;
+};
+
 #if defined(CONFIG_PM_OPP)
 
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
@@ -142,6 +152,8 @@ void dev_pm_opp_put(struct dev_pm_opp *opp);
 
 int dev_pm_opp_add(struct device *dev, unsigned long freq,
 		   unsigned long u_volt);
+int dev_pm_opp_add_dynamic(struct device *dev, struct dev_pm_opp_data *opp);
+
 void dev_pm_opp_remove(struct device *dev, unsigned long freq);
 void dev_pm_opp_remove_all_dynamic(struct device *dev);
 
@@ -297,6 +309,12 @@ static inline int dev_pm_opp_add(struct device *dev, unsigned long freq,
 	return -EOPNOTSUPP;
 }
 
+static inline int
+dev_pm_opp_add_dynamic(struct device *dev, struct dev_pm_opp_data *opp)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 {
 }
-- 
2.34.1

