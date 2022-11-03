Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B62617B45
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiKCLCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiKCLCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:02:01 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B861146D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:01:55 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 4so1610731pli.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsmUR9VBjzdfb/PGMg0vmzjLCq4QjfuLi4iPrW87qL0=;
        b=GHinC0PrjwVZKhYfmM8nt17mNc2XQ9VSl2eWqe4GgpapVAog+Tw41GRAzFQDLdwSfh
         3U27PBnVZm8Z31LLeWf798nvm6I8hmccO+gZsY8kqIMjeRMuE6yovKGZTftmyFWoNXMx
         nQX/kahB2mbF7pom1+RpekbBuhWNpUUy/17bBbYAvjDZPAp5bqtFuWwQ7ii4/apHMqQ+
         v5qdpSlzR0b4MQuhEkxaKojApu8ykXPymUmAb63meFdW3KxBXuYS4SBRtkmJIs4YHBrR
         jeSy+UfYb4f/uBYwd9A/FslWy97JajxeHtcU1FLdd60oolyMEa/NwIYdHCCx5TozlFZ4
         C/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsmUR9VBjzdfb/PGMg0vmzjLCq4QjfuLi4iPrW87qL0=;
        b=L+UF2fcBiBxURJs2w8a4wnkJB/fGZg3nlCLVzolu6gsb8umoizaUxg4mjcVV+JEl4n
         iM6PMFHT7IEgt/ijLVV4j+iy2gBIQJcFf2sqGYqnB8r4q1k67HZMtVfFcfvvoq5GVTG1
         ZBZE9kDv6F4lKNodki3QKwQD3wLt8aiwGFAnAyicGtSqjAbDv/6/sBkc/KGeG8JN9ind
         v299bEL17PFMFX47+cbLLmCAQDOHRkUWYx3G67s3X15RVZ0UBLkRbRNud1zhfAjLfGuI
         xPCLqQymk2o6zi1mUl4IsgMVXUMDKbozoenJHTVqlCvYWAObIdfWusIo5fbYYcnDY2aP
         1eVA==
X-Gm-Message-State: ACrzQf14f4ca7TnIb+lpvp5lI3bnFZLCkUD7ZLq4TO6TMZopGiCEvPyT
        TMV86WVRo8wIz55GqHB0PyNjfQ==
X-Google-Smtp-Source: AMsMyM6XSKlbSK0JuqjYQIz/h/+VQHH4mk0vaC5SsBya5JFSTXHYTK4fF7hmoELCXp9bmqBQJsmNNw==
X-Received: by 2002:a17:90b:3690:b0:213:c985:b5ee with SMTP id mj16-20020a17090b369000b00213c985b5eemr25247343pjb.192.1667473314641;
        Thu, 03 Nov 2022 04:01:54 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id b33-20020a630c21000000b00461b85e5ad6sm560176pgl.19.2022.11.03.04.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 04:01:43 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     James Calligeros <jcalligeros99@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/5] OPP: decouple dt properties in opp_parse_supplies()
Date:   Thu,  3 Nov 2022 16:31:08 +0530
Message-Id: <5acd93462bff6c108d65802fd39f6002dfadd1a0.1667473008.git.viresh.kumar@linaro.org>
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

From: James Calligeros <jcalligeros99@gmail.com>

The opp-microwatt property was added with the intention of providing
platforms a way to specify a precise value for the power consumption
of a device at a given OPP to enable better energy-aware scheduling
decisions by informing the kernel of the total static and dynamic
power of a device at a given OPP, removing the reliance on the EM
subsystem's often flawed estimations. This property is parsed by
opp_parse_supplies(), which creates a hard dependency on the
opp-microvolt property.

Some platforms, such as Apple Silicon, do not describe their device's
voltage regulators in the DT as they cannot be controlled by the kernel
and/or rely on opaque firmware algorithms to control their voltage and
current characteristics at runtime. We can, however, experimentally
determine the power consumption of a given device at a given OPP, taking
advantage of opp-microwatt to provide EAS on such devices as was
initially intended.

Allow platforms to specify and consume any subset of opp-microvolt,
opp-microamp, or opp-microwatt without a hard dependency on
opp-microvolt to enable this functionality on such platforms.

Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
Co-developed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2: Rewritten by Viresh on top of his changes.

 drivers/opp/of.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index e51c43495e21..273fa9c0e1c0 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -654,9 +654,12 @@ static u32 *opp_parse_microvolt(struct dev_pm_opp *opp, struct device *dev,
 		/*
 		 * Missing property isn't a problem, but an invalid
 		 * entry is. This property isn't optional if regulator
-		 * information is provided.
+		 * information is provided. Check only for the first OPP, as
+		 * regulator_count may get initialized after that to a valid
+		 * value.
 		 */
-		if (opp_table->regulator_count > 0) {
+		if (list_empty(&opp_table->opp_list) &&
+		    opp_table->regulator_count > 0) {
 			dev_err(dev, "%s: opp-microvolt missing although OPP managing regulators\n",
 				__func__);
 			return ERR_PTR(-EINVAL);
@@ -674,7 +677,7 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 	bool triplet;
 
 	microvolt = opp_parse_microvolt(opp, dev, opp_table, &triplet);
-	if (IS_ERR_OR_NULL(microvolt))
+	if (IS_ERR(microvolt))
 		return PTR_ERR(microvolt);
 
 	microamp = _parse_named_prop(opp, dev, opp_table, "microamp", NULL);
@@ -689,15 +692,26 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 		goto free_microamp;
 	}
 
-	for (i = 0, j = 0; i < opp_table->regulator_count; i++) {
-		opp->supplies[i].u_volt = microvolt[j++];
+	/*
+	 * Initialize regulator_count if it is uninitialized and no properties
+	 * are found.
+	 */
+	if (unlikely(opp_table->regulator_count == -1)) {
+		opp_table->regulator_count = 0;
+		return 0;
+	}
 
-		if (triplet) {
-			opp->supplies[i].u_volt_min = microvolt[j++];
-			opp->supplies[i].u_volt_max = microvolt[j++];
-		} else {
-			opp->supplies[i].u_volt_min = opp->supplies[i].u_volt;
-			opp->supplies[i].u_volt_max = opp->supplies[i].u_volt;
+	for (i = 0, j = 0; i < opp_table->regulator_count; i++) {
+		if (microvolt) {
+			opp->supplies[i].u_volt = microvolt[j++];
+
+			if (triplet) {
+				opp->supplies[i].u_volt_min = microvolt[j++];
+				opp->supplies[i].u_volt_max = microvolt[j++];
+			} else {
+				opp->supplies[i].u_volt_min = opp->supplies[i].u_volt;
+				opp->supplies[i].u_volt_max = opp->supplies[i].u_volt;
+			}
 		}
 
 		if (microamp)
-- 
2.31.1.272.g89b43f80a514

