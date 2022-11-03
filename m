Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16232617B44
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiKCLB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiKCLBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:01:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E307B7FD
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:01:40 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d10so1248395pfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 04:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKnEZG0ef1w3+ZtyBo/x5Fjh/UyIelJHnysoJI3A1/8=;
        b=M/k9L/GATSz3t4hC6JTpBUGIjCJJ+L5qRie3ARsFP0YAVMwwS8hJcprzYnjHgBiZFC
         JQsycKDKpqWj8grx1dC5NEnjUIk2Sc4Nh3jWiqN8/ECXYdWtTAaKHZo0qV2rKIek12Xw
         2TVsLH4Cz4GmkwcJSrR59QhTA1KmNdS1Hw2fx2ZHK9H+yr3QfkFuQO9DL47np6DRic4g
         Un5TVyF+TMYrtZWrYQ8QvE16ARmZMQV7rFI0AUa/2h+CxzLhQIiulGBW1W3ced9RNGCD
         dG++DjXtkjNM4EfSy61SpEIHefsrFsX67Swfdbwko9yf3HirK83PtIZ3o7uSCPnQ2hEn
         tm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKnEZG0ef1w3+ZtyBo/x5Fjh/UyIelJHnysoJI3A1/8=;
        b=P9V/x/CWeyEL2gg+ZD2R6S/1BtnIcMZaB+vuOz494y3hitDD4phEFt4r006ylrmmap
         m8D3zX8i9JkPXzNtTBMxc1YpQB/QiPnKhddLxjgFnUk7ke6q0U8SoNvsRwzD+IFPSpHj
         IFoVnwYc5kirE6YiNUYNluFOMjgsZSZATFxudxddMSN/7gzHC+18ZjYqcnFCrAtSlTal
         26h0MSg5T9A/H3vC3rnrCiN4/1m+E+mvKn5N8jKceWlxyLzEBhq5rCa+6hxQ63t+LUiv
         AQRdfa510HJmcNhv6y/UvIEjmRv/lO4801fSv9P/6mlDw/r1LUhQ/y/9pei0A7JZ3tuE
         85pQ==
X-Gm-Message-State: ACrzQf0pKIB4beG7NJHNahXMnihFxFKBgtbGuGZuwjATtIH37Hfk7B35
        sj4GH8XQmBpEdaZByotB80xg0g==
X-Google-Smtp-Source: AMsMyM4dVhJX1yGhZhr6WzIziWnaGlZDw/A/iObTpehlPp5zHnq37z035BHCsoaJg+MsELfh+4zvqg==
X-Received: by 2002:a63:106:0:b0:460:64ce:51c4 with SMTP id 6-20020a630106000000b0046064ce51c4mr25372692pgb.17.1667473299580;
        Thu, 03 Nov 2022 04:01:39 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090ab88900b0020d39ffe987sm699759pjr.50.2022.11.03.04.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 04:01:39 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     James Calligeros <jcalligeros99@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] OPP: Simplify opp_parse_supplies() by restructuring it
Date:   Thu,  3 Nov 2022 16:31:07 +0530
Message-Id: <bf7e6e072ed166c11c687200df53aec8d7446182.1667473008.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1667473008.git.viresh.kumar@linaro.org>
References: <cover.1667473008.git.viresh.kumar@linaro.org>
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

opp_parse_supplies() has grown into too big of a routine (~190 lines)
and it is not straight-forward to understand it anymore.

Break it into smaller routines and reduce code redundancy a bit by using
the same code to parse properties.

This shouldn't result in any logical changes.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 216 ++++++++++++++++++-----------------------------
 1 file changed, 81 insertions(+), 135 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index e010e119c42b..e51c43495e21 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -578,179 +578,126 @@ static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 	return false;
 }
 
-static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
-			      struct opp_table *opp_table)
+static u32 *_parse_named_prop(struct dev_pm_opp *opp, struct device *dev,
+			      struct opp_table *opp_table,
+			      const char *prop_type, bool *triplet)
 {
-	u32 *microvolt, *microamp = NULL, *microwatt = NULL;
-	int supplies = opp_table->regulator_count;
-	int vcount, icount, pcount, ret, i, j;
 	struct property *prop = NULL;
 	char name[NAME_MAX];
+	int count, ret;
+	u32 *out;
 
-	/* Search for "opp-microvolt-<name>" */
+	/* Search for "opp-<prop_type>-<name>" */
 	if (opp_table->prop_name) {
-		snprintf(name, sizeof(name), "opp-microvolt-%s",
+		snprintf(name, sizeof(name), "opp-%s-%s", prop_type,
 			 opp_table->prop_name);
 		prop = of_find_property(opp->np, name, NULL);
 	}
 
 	if (!prop) {
-		/* Search for "opp-microvolt" */
-		sprintf(name, "opp-microvolt");
+		/* Search for "opp-<prop_type>" */
+		snprintf(name, sizeof(name), "opp-%s", prop_type);
 		prop = of_find_property(opp->np, name, NULL);
-
-		/* Missing property isn't a problem, but an invalid entry is */
-		if (!prop) {
-			if (unlikely(supplies == -1)) {
-				/* Initialize regulator_count */
-				opp_table->regulator_count = 0;
-				return 0;
-			}
-
-			if (!supplies)
-				return 0;
-
-			dev_err(dev, "%s: opp-microvolt missing although OPP managing regulators\n",
-				__func__);
-			return -EINVAL;
-		}
-	}
-
-	if (unlikely(supplies == -1)) {
-		/* Initialize regulator_count */
-		supplies = opp_table->regulator_count = 1;
-	} else if (unlikely(!supplies)) {
-		dev_err(dev, "%s: opp-microvolt wasn't expected\n", __func__);
-		return -EINVAL;
+		if (!prop)
+			return NULL;
 	}
 
-	vcount = of_property_count_u32_elems(opp->np, name);
-	if (vcount < 0) {
-		dev_err(dev, "%s: Invalid %s property (%d)\n",
-			__func__, name, vcount);
-		return vcount;
+	count = of_property_count_u32_elems(opp->np, name);
+	if (count < 0) {
+		dev_err(dev, "%s: Invalid %s property (%d)\n", __func__, name,
+			count);
+		return ERR_PTR(count);
 	}
 
-	/* There can be one or three elements per supply */
-	if (vcount != supplies && vcount != supplies * 3) {
-		dev_err(dev, "%s: Invalid number of elements in %s property (%d) with supplies (%d)\n",
-			__func__, name, vcount, supplies);
-		return -EINVAL;
+	/*
+	 * Initialize regulator_count, if regulator information isn't provided
+	 * by the platform. Now that one of the properties is available, fix the
+	 * regulator_count to 1.
+	 */
+	if (unlikely(opp_table->regulator_count == -1))
+		opp_table->regulator_count = 1;
+
+	if (count != opp_table->regulator_count &&
+	    (!triplet || count != opp_table->regulator_count * 3)) {
+		dev_err(dev, "%s: Invalid number of elements in %s property (%u) with supplies (%d)\n",
+			__func__, prop_type, count, opp_table->regulator_count);
+		return ERR_PTR(-EINVAL);
 	}
 
-	microvolt = kmalloc_array(vcount, sizeof(*microvolt), GFP_KERNEL);
-	if (!microvolt)
-		return -ENOMEM;
+	out = kmalloc_array(count, sizeof(*out), GFP_KERNEL);
+	if (!out)
+		return ERR_PTR(-EINVAL);
 
-	ret = of_property_read_u32_array(opp->np, name, microvolt, vcount);
+	ret = of_property_read_u32_array(opp->np, name, out, count);
 	if (ret) {
 		dev_err(dev, "%s: error parsing %s: %d\n", __func__, name, ret);
-		ret = -EINVAL;
-		goto free_microvolt;
+		kfree(out);
+		return ERR_PTR(-EINVAL);
 	}
 
-	/* Search for "opp-microamp-<name>" */
-	prop = NULL;
-	if (opp_table->prop_name) {
-		snprintf(name, sizeof(name), "opp-microamp-%s",
-			 opp_table->prop_name);
-		prop = of_find_property(opp->np, name, NULL);
-	}
+	if (triplet)
+		*triplet = count != opp_table->regulator_count;
 
-	if (!prop) {
-		/* Search for "opp-microamp" */
-		sprintf(name, "opp-microamp");
-		prop = of_find_property(opp->np, name, NULL);
-	}
-
-	if (prop) {
-		icount = of_property_count_u32_elems(opp->np, name);
-		if (icount < 0) {
-			dev_err(dev, "%s: Invalid %s property (%d)\n", __func__,
-				name, icount);
-			ret = icount;
-			goto free_microvolt;
-		}
+	return out;
+}
 
-		if (icount != supplies) {
-			dev_err(dev, "%s: Invalid number of elements in %s property (%d) with supplies (%d)\n",
-				__func__, name, icount, supplies);
-			ret = -EINVAL;
-			goto free_microvolt;
-		}
+static u32 *opp_parse_microvolt(struct dev_pm_opp *opp, struct device *dev,
+				struct opp_table *opp_table, bool *triplet)
+{
+	u32 *microvolt;
 
-		microamp = kmalloc_array(icount, sizeof(*microamp), GFP_KERNEL);
-		if (!microamp) {
-			ret = -EINVAL;
-			goto free_microvolt;
-		}
+	microvolt = _parse_named_prop(opp, dev, opp_table, "microvolt", triplet);
+	if (IS_ERR(microvolt))
+		return microvolt;
 
-		ret = of_property_read_u32_array(opp->np, name, microamp,
-						 icount);
-		if (ret) {
-			dev_err(dev, "%s: error parsing %s: %d\n", __func__,
-				name, ret);
-			ret = -EINVAL;
-			goto free_microamp;
+	if (!microvolt) {
+		/*
+		 * Missing property isn't a problem, but an invalid
+		 * entry is. This property isn't optional if regulator
+		 * information is provided.
+		 */
+		if (opp_table->regulator_count > 0) {
+			dev_err(dev, "%s: opp-microvolt missing although OPP managing regulators\n",
+				__func__);
+			return ERR_PTR(-EINVAL);
 		}
 	}
 
-	/* Search for "opp-microwatt-<name>" */
-	prop = NULL;
-	if (opp_table->prop_name) {
-		snprintf(name, sizeof(name), "opp-microwatt-%s",
-			 opp_table->prop_name);
-		prop = of_find_property(opp->np, name, NULL);
-	}
-
-	if (!prop) {
-		/* Search for "opp-microwatt" */
-		sprintf(name, "opp-microwatt");
-		prop = of_find_property(opp->np, name, NULL);
-	}
+	return microvolt;
+}
 
-	if (prop) {
-		pcount = of_property_count_u32_elems(opp->np, name);
-		if (pcount < 0) {
-			dev_err(dev, "%s: Invalid %s property (%d)\n", __func__,
-				name, pcount);
-			ret = pcount;
-			goto free_microamp;
-		}
+static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
+			      struct opp_table *opp_table)
+{
+	u32 *microvolt, *microamp, *microwatt;
+	int ret, i, j;
+	bool triplet;
 
-		if (pcount != supplies) {
-			dev_err(dev, "%s: Invalid number of elements in %s property (%d) with supplies (%d)\n",
-				__func__, name, pcount, supplies);
-			ret = -EINVAL;
-			goto free_microamp;
-		}
+	microvolt = opp_parse_microvolt(opp, dev, opp_table, &triplet);
+	if (IS_ERR_OR_NULL(microvolt))
+		return PTR_ERR(microvolt);
 
-		microwatt = kmalloc_array(pcount, sizeof(*microwatt),
-					  GFP_KERNEL);
-		if (!microwatt) {
-			ret = -EINVAL;
-			goto free_microamp;
-		}
+	microamp = _parse_named_prop(opp, dev, opp_table, "microamp", NULL);
+	if (IS_ERR(microamp)) {
+		ret = PTR_ERR(microamp);
+		goto free_microvolt;
+	}
 
-		ret = of_property_read_u32_array(opp->np, name, microwatt,
-						 pcount);
-		if (ret) {
-			dev_err(dev, "%s: error parsing %s: %d\n", __func__,
-				name, ret);
-			ret = -EINVAL;
-			goto free_microwatt;
-		}
+	microwatt = _parse_named_prop(opp, dev, opp_table, "microwatt", NULL);
+	if (IS_ERR(microwatt)) {
+		ret = PTR_ERR(microwatt);
+		goto free_microamp;
 	}
 
-	for (i = 0, j = 0; i < supplies; i++) {
+	for (i = 0, j = 0; i < opp_table->regulator_count; i++) {
 		opp->supplies[i].u_volt = microvolt[j++];
 
-		if (vcount == supplies) {
-			opp->supplies[i].u_volt_min = opp->supplies[i].u_volt;
-			opp->supplies[i].u_volt_max = opp->supplies[i].u_volt;
-		} else {
+		if (triplet) {
 			opp->supplies[i].u_volt_min = microvolt[j++];
 			opp->supplies[i].u_volt_max = microvolt[j++];
+		} else {
+			opp->supplies[i].u_volt_min = opp->supplies[i].u_volt;
+			opp->supplies[i].u_volt_max = opp->supplies[i].u_volt;
 		}
 
 		if (microamp)
@@ -760,7 +707,6 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 			opp->supplies[i].u_watt = microwatt[i];
 	}
 
-free_microwatt:
 	kfree(microwatt);
 free_microamp:
 	kfree(microamp);
-- 
2.31.1.272.g89b43f80a514

