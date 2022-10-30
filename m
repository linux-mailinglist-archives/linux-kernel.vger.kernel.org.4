Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65CC6129FB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 11:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJ3KQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 06:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJ3KQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 06:16:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C69EC77F;
        Sun, 30 Oct 2022 03:16:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so3664579pjk.1;
        Sun, 30 Oct 2022 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6BjV3jMnHxiyk9vjlUByFMrcW+i/sskvIB9yrt40dHk=;
        b=b82FV0uPTxO7N0jeVWLEvG6lSGRZag8ko426telOn8QPkZ86ufw0kWLu4O9jNEyvlV
         jzivTXCBC2jKEIFjFHdJgAp470v0jybJSZDBxFCJUORfmpFhKpteWwf29mmwaLJYQP1f
         Wb9Jm8ejN/AZTKNWWkanA+VryNobvnSp+rxrZpkTYQ8FZE/ardFWxtyj72GWnmG237th
         7EjDeL+7Ae9/AWcR8leHhRBgc/039bQ6d5oZgZBtXcb4IYk+6fpKRvjD8dLLcS92ucLD
         Fpq1K+c+EVTsMqotGUVhTc/za5SRhn5iwHS6OCOWp8apDVPHTJE23T09wDpfXIdQD6RQ
         hGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BjV3jMnHxiyk9vjlUByFMrcW+i/sskvIB9yrt40dHk=;
        b=d8aQHoQ4NHwS59D5eeGnNYfKYnxRwwyn+oekFnsEtUMmzwCz9oFYMPGCCSukDv2ji6
         z3VmZD8nq8NU8CtjLOpkz8HnRnxULYzrnRAl6zlbLtmP9KDH/csWb6UYTSxsPOBxLkAI
         xfHPDhoni87sp3weot+gBvWBkBAxqNPnMSWOnx3a4r1+gWg1S0Gol3o17vrGRqIgySga
         YrEDP3yX8+YngiqQOtC9KrRbdASoOFZtTy9g4NzLpjAzd103pswtvWDBk/7uhtwt1JdS
         UY+q9PSkCzLWl7ePWCIEHvzK7U+/dcyv8jK328YQWdMI9UImdyfzlIdLtMYN9XBH6k9i
         41Yw==
X-Gm-Message-State: ACrzQf3fhrzoYIbyEXiA0GCz2kq0c8m6G9v5mBDvo8qzMBA8N6y0wGv+
        qd8hm2OXeYme04vwD6tvq4I=
X-Google-Smtp-Source: AMsMyM6nOEePFc08O6PWhbcUUQFHk+7LRmtGo/1IfWmZgN5+Nh/Ok34dxugyF9j5yBIZnaeP4Xz4bw==
X-Received: by 2002:a17:903:292:b0:186:f931:ec29 with SMTP id j18-20020a170903029200b00186f931ec29mr8555054plr.144.1667125005526;
        Sun, 30 Oct 2022 03:16:45 -0700 (PDT)
Received: from localhost.localdomain (2403-580a-80ed--90b3-8553.ip6.aussiebb.net. [2403:580a:80ed::90b3:8553])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902ce8600b0017ec1b1bf9fsm2461137plg.217.2022.10.30.03.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 03:16:45 -0700 (PDT)
From:   James Calligeros <jcalligeros99@gmail.com>
To:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        linux-pm@vger.kernel.org
Cc:     asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        James Calligeros <jcalligeros99@gmail.com>
Subject: [PATCH v2] OPP: decouple dt properties in opp_parse_supplies()
Date:   Sun, 30 Oct 2022 20:15:46 +1000
Message-Id: <20221030101546.29306-1-jcalligeros99@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opp-microwatt property was added with the intention of providing
platforms a way to specify a precise value for the power consumption
of a device at a given OPP to enable better energy-aware scheduling
decisions by informing the kernel of the total static and dynamic
power of a device at a given OPP, removing the reliance on the EM
subsystem's often flawed estimations. This property is parsed by
opp_parse_supplies(), which creates a hard dependency on the
opp-microvolt property.

Some platforms, such as Apple Silicon, do not describe their devices'
voltage regulators in the DT as they cannot be controlled by the kernel
and/or rely on opaque firmware algorithms to control their voltage and
current characteristics at runtime. We can, however, experimentally
determine the power consumption of a given device at a given OPP, taking
advantage of opp-microwatt to provide EAS on such devices as was initially
intended.

Allow platforms to specify and consume any subset of opp-microvolt,
opp-microamp, or opp-microwatt without a hard dependency on opp-microvolt
to enable this functionality on such platforms.

Fixes: 4f9a7a1dc2a2 ("OPP: Add "opp-microwatt" supporting code")
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
Changes since v1:
Fixed bad reference (opp to opp_table)

 drivers/opp/of.c | 198 +++++++++++++++++++++++++----------------------
 1 file changed, 104 insertions(+), 94 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 605d68673f92..0fa25c3a959e 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -581,166 +581,176 @@ static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 			      struct opp_table *opp_table)
 {
-	u32 *microvolt, *microamp = NULL, *microwatt = NULL;
+	u32 *microvolt = NULL, *microamp = NULL, *microwatt = NULL;
 	int supplies = opp_table->regulator_count;
 	int vcount, icount, pcount, ret, i, j;
-	struct property *prop = NULL;
+	struct property *prop_mv = NULL, *prop_ma = NULL, *prop_mw = NULL;
 	char name[NAME_MAX];
 
 	/* Search for "opp-microvolt-<name>" */
 	if (opp_table->prop_name) {
 		snprintf(name, sizeof(name), "opp-microvolt-%s",
 			 opp_table->prop_name);
-		prop = of_find_property(opp->np, name, NULL);
+		prop_mv = of_find_property(opp->np, name, NULL);
 	}
 
-	if (!prop) {
+	if (!prop_mv) {
 		/* Search for "opp-microvolt" */
 		sprintf(name, "opp-microvolt");
-		prop = of_find_property(opp->np, name, NULL);
-
-		/* Missing property isn't a problem, but an invalid entry is */
-		if (!prop) {
-			if (unlikely(supplies == -1)) {
-				/* Initialize regulator_count */
-				opp_table->regulator_count = 0;
-				return 0;
-			}
+		prop_mv = of_find_property(opp->np, name, NULL);
 
-			if (!supplies)
-				return 0;
-
-			dev_err(dev, "%s: opp-microvolt missing although OPP managing regulators\n",
-				__func__);
-			return -EINVAL;
-		}
 	}
 
-	if (unlikely(supplies == -1)) {
-		/* Initialize regulator_count */
-		supplies = opp_table->regulator_count = 1;
-	} else if (unlikely(!supplies)) {
-		dev_err(dev, "%s: opp-microvolt wasn't expected\n", __func__);
-		return -EINVAL;
+	if (prop_mv) {
+		vcount = of_property_count_u32_elems(opp->np, name);
+		if (unlikely(supplies == -1))
+			supplies = opp_table->regulator_count = vcount;
+	} else {
+		prop_mv = NULL;
+		vcount = 0;
 	}
 
-	vcount = of_property_count_u32_elems(opp->np, name);
 	if (vcount < 0) {
 		dev_err(dev, "%s: Invalid %s property (%d)\n",
 			__func__, name, vcount);
 		return vcount;
 	}
 
-	/* There can be one or three elements per supply */
-	if (vcount != supplies && vcount != supplies * 3) {
-		dev_err(dev, "%s: Invalid number of elements in %s property (%d) with supplies (%d)\n",
-			__func__, name, vcount, supplies);
-		return -EINVAL;
-	}
+	if (vcount) {
+		/* There can be one or three elements per supply */
+		if (vcount != supplies && vcount != supplies * 3) {
+			dev_err(dev, "%s: Invalid number of elements in %s property (%d) with supplies (%d)\n",
+				__func__, name, vcount, supplies);
+			return -EINVAL;
+		}
 
-	microvolt = kmalloc_array(vcount, sizeof(*microvolt), GFP_KERNEL);
-	if (!microvolt)
-		return -ENOMEM;
+		microvolt = kmalloc_array(vcount, sizeof(*microvolt), GFP_KERNEL);
+		if (!microvolt)
+			return -ENOMEM;
 
-	ret = of_property_read_u32_array(opp->np, name, microvolt, vcount);
-	if (ret) {
-		dev_err(dev, "%s: error parsing %s: %d\n", __func__, name, ret);
-		ret = -EINVAL;
-		goto free_microvolt;
+		ret = of_property_read_u32_array(opp->np, name, microvolt, vcount);
+		if (ret) {
+			dev_err(dev, "%s: error parsing %s: %d\n", __func__, name, ret);
+			ret = -EINVAL;
+			goto free_microvolt;
+		}
 	}
 
 	/* Search for "opp-microamp-<name>" */
-	prop = NULL;
 	if (opp_table->prop_name) {
 		snprintf(name, sizeof(name), "opp-microamp-%s",
 			 opp_table->prop_name);
-		prop = of_find_property(opp->np, name, NULL);
+		prop_ma = of_find_property(opp->np, name, NULL);
 	}
 
-	if (!prop) {
+	if (!prop_ma) {
 		/* Search for "opp-microamp" */
 		sprintf(name, "opp-microamp");
-		prop = of_find_property(opp->np, name, NULL);
+		prop_ma = of_find_property(opp->np, name, NULL);
+
 	}
 
-	if (prop) {
+	if (prop_ma) {
 		icount = of_property_count_u32_elems(opp->np, name);
-		if (icount < 0) {
-			dev_err(dev, "%s: Invalid %s property (%d)\n", __func__,
-				name, icount);
-			ret = icount;
-			goto free_microvolt;
-		}
+		if (unlikely(supplies == -1))
+			supplies = opp_table->regulator_count = icount;
+	} else {
+		prop_ma = NULL;
+		icount = 0;
+	}
 
-		if (icount != supplies) {
+	if (icount < 0) {
+		dev_err(dev, "%s: Invalid %s property (%d)\n",
+			__func__, name, icount);
+		return icount;
+	}
+
+	if (icount) {
+		/* There can be one or three elements per supply */
+		if (icount != supplies && icount != supplies * 3) {
 			dev_err(dev, "%s: Invalid number of elements in %s property (%d) with supplies (%d)\n",
 				__func__, name, icount, supplies);
-			ret = -EINVAL;
-			goto free_microvolt;
+			return -EINVAL;
 		}
 
 		microamp = kmalloc_array(icount, sizeof(*microamp), GFP_KERNEL);
-		if (!microamp) {
-			ret = -EINVAL;
-			goto free_microvolt;
-		}
+		if (!microamp)
+			return -ENOMEM;
 
-		ret = of_property_read_u32_array(opp->np, name, microamp,
-						 icount);
+		ret = of_property_read_u32_array(opp->np, name, microamp, icount);
 		if (ret) {
-			dev_err(dev, "%s: error parsing %s: %d\n", __func__,
-				name, ret);
+			dev_err(dev, "%s: error parsing %s: %d\n", __func__, name, ret);
 			ret = -EINVAL;
 			goto free_microamp;
 		}
 	}
 
-	/* Search for "opp-microwatt" */
-	sprintf(name, "opp-microwatt");
-	prop = of_find_property(opp->np, name, NULL);
+	/* Search for "opp-microwatt-<name>" */
+	if (opp_table->prop_name) {
+		snprintf(name, sizeof(name), "opp-microwatt-%s",
+			 opp_table->prop_name);
+		prop_mw = of_find_property(opp->np, name, NULL);
+	}
+
+	if (!prop_mw) {
+		/* Search for "opp-microwatt" */
+		sprintf(name, "opp-microwatt");
+		prop_mw = of_find_property(opp->np, name, NULL);
 
-	if (prop) {
+	}
+
+	if (prop_mw) {
 		pcount = of_property_count_u32_elems(opp->np, name);
-		if (pcount < 0) {
-			dev_err(dev, "%s: Invalid %s property (%d)\n", __func__,
-				name, pcount);
-			ret = pcount;
-			goto free_microamp;
-		}
+		if (unlikely(supplies == -1))
+			supplies = opp_table->regulator_count = pcount;
+	} else {
+		prop_mw = NULL;
+		pcount = 0;
+	}
+
+	if (pcount < 0) {
+		dev_err(dev, "%s: Invalid %s property (%d)\n",
+			__func__, name, pcount);
+		return pcount;
+	}
 
-		if (pcount != supplies) {
+	if (pcount) {
+		/* There can be one or three elements per supply */
+		if (pcount != supplies && pcount != supplies * 3) {
 			dev_err(dev, "%s: Invalid number of elements in %s property (%d) with supplies (%d)\n",
 				__func__, name, pcount, supplies);
-			ret = -EINVAL;
-			goto free_microamp;
+			return -EINVAL;
 		}
 
-		microwatt = kmalloc_array(pcount, sizeof(*microwatt),
-					  GFP_KERNEL);
-		if (!microwatt) {
-			ret = -EINVAL;
-			goto free_microamp;
-		}
+		microwatt = kmalloc_array(pcount, sizeof(*microwatt), GFP_KERNEL);
+		if (!microwatt)
+			return -ENOMEM;
 
-		ret = of_property_read_u32_array(opp->np, name, microwatt,
-						 pcount);
+		ret = of_property_read_u32_array(opp->np, name, microwatt, pcount);
 		if (ret) {
-			dev_err(dev, "%s: error parsing %s: %d\n", __func__,
-				name, ret);
+			dev_err(dev, "%s: error parsing %s: %d\n", __func__, name, ret);
 			ret = -EINVAL;
 			goto free_microwatt;
 		}
 	}
 
-	for (i = 0, j = 0; i < supplies; i++) {
-		opp->supplies[i].u_volt = microvolt[j++];
+	/* No supplies associated with the OPP */
+	if (unlikely(supplies == -1)) {
+		supplies = opp_table->regulator_count = 0;
+		return 0;
+	}
 
-		if (vcount == supplies) {
-			opp->supplies[i].u_volt_min = opp->supplies[i].u_volt;
-			opp->supplies[i].u_volt_max = opp->supplies[i].u_volt;
-		} else {
-			opp->supplies[i].u_volt_min = microvolt[j++];
-			opp->supplies[i].u_volt_max = microvolt[j++];
+	for (i = 0, j = 0; i < supplies; i++) {
+		if (microvolt) {
+			opp->supplies[i].u_volt = microvolt[j++];
+
+			if (vcount == supplies) {
+				opp->supplies[i].u_volt_min = opp->supplies[i].u_volt;
+				opp->supplies[i].u_volt_max = opp->supplies[i].u_volt;
+			} else {
+				opp->supplies[i].u_volt_min = microvolt[j++];
+				opp->supplies[i].u_volt_max = microvolt[j++];
+			}
 		}
 
 		if (microamp)
-- 
2.38.0

