Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7130A612738
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 04:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiJ3Dp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 23:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJ3DpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 23:45:22 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B318C1CB1E;
        Sat, 29 Oct 2022 20:45:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 4so8139623pli.0;
        Sat, 29 Oct 2022 20:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BwhVxH6+5OWtP082m2xk09j2x10NS4/31/SB9Rk2Jg0=;
        b=a9JEvml13xWrlvhcbv7VNRMCA1KULeQuFDRTiPo1vfcrxjWGAzvS6hIxa4rD632Iqh
         HG4q/ia7STDdiFBW+8dtUU824p5TUZPhpxci87EXN56WMVzfK9iYoztDhzCdj7DhsbQ6
         uf/uM0KLYoWvCHqQrDcSUe4wkBQ3T1GM9H3+ZrEB1Uw1FYb513vT2VqxDuxt849JRRyw
         hkIaK75ntk1dhXUgRx5WLxhUEj+rd+FCF0qy74RA1s3dJQIew3yNk3zm2QZT/cnMaXnl
         4g2ADiIAoT9SXFkTT7Pr3/SvKeQLFXEbbIjZblYuofRYiWKTUFQlr5Fj+awEprZxsQIy
         8M0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwhVxH6+5OWtP082m2xk09j2x10NS4/31/SB9Rk2Jg0=;
        b=CWVIx9u0+Rm870gswKwzmS9vCQPOb49NUAy7RCFLXqSR4vu7bExR4acsSmlGDy9nHs
         oGHczny1Z20jnVi9WWN/+1FdFmskOeDEboc4X0067qfBw5o/TH1H7NLix+/ggxnxJQWp
         b1VXrwQazd636QotTT3J1PDqeZfxEHlJprhJm7s3YOfGBs/jUkci9vK+eFrGbf4SGmA2
         IbHO1/w2bBLeJUFLFdVjuMbWklX2TB9ZUSV9Jw9e/RjG7BlWyK5LkA7KOnEjuksmYBcL
         M/2tWQKPf6BszfgCP4bXbPLYolFMGYERsAjy9qiw1h7Z97oZIPQFXM0yaeQ2vtvriYJD
         4UFA==
X-Gm-Message-State: ACrzQf1pK2GI0gtt6dWz2baQOp8ebuEMdJ/nK0J1uGFfWSBw0iBSOqfc
        rsIlj8V2hr/19g5Dp+MTnwk=
X-Google-Smtp-Source: AMsMyM7Sxn19VvY9vh5kgpQYX3t6Hoyo4xeN5A+C0pXLH6hsPPFYgfgKmaBzudKdh58IzdOTl1DUVA==
X-Received: by 2002:a17:90b:17c2:b0:213:8ff3:a472 with SMTP id me2-20020a17090b17c200b002138ff3a472mr7538470pjb.13.1667101514125;
        Sat, 29 Oct 2022 20:45:14 -0700 (PDT)
Received: from localhost.localdomain (2403-580a-80ed--90b3-8553.ip6.aussiebb.net. [2403:580a:80ed::90b3:8553])
        by smtp.gmail.com with ESMTPSA id 137-20020a62178f000000b0056c0cde1a16sm1876954pfx.134.2022.10.29.20.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 20:45:13 -0700 (PDT)
From:   James Calligeros <jcalligeros99@gmail.com>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, asahi@vger.kernel.org,
        James Calligeros <jcalligeros99@gmail.com>
Subject: [PATCH] OPP: decouple dt properties in opp_parse_supplies()
Date:   Sun, 30 Oct 2022 13:44:15 +1000
Message-Id: <20221030034414.24672-1-jcalligeros99@gmail.com>
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
+		opp->regulator_count = 0;
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

