Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E173D73759E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjFTUEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjFTUDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:03:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6AD1727
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-970028cfb6cso799400566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291421; x=1689883421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdgC3Azugwc5mt6u8ZricLJq3eD0D+n/vIOu1NtFkBc=;
        b=DnJlOTx41PtsBrbI5U984ahVPuWCkueNZPSk9Zxln09q3PeoHA2BmfCZEhtTwmq+Tj
         8a1eCl44BsJiOVrXmr/ht20CM88VMZlW/hB2fI9heD/t/qAAjj+J08bCcS+jn8lEAzwD
         rCDB+Ep9g/Bqz2+qpOIHMZ00vKNuuQ2KBhDo9oy+dWhghhlcemfkpecOSEi6mdYzTmqP
         pDTeCeHnpcHJDXax4Lt16gMbcN7qR4TmJnp1298ptSoi+xsMuv9BcmJ+PZ3H806qLUP8
         toKFdkVNH6nfZ7y1+DIQRiMPQD6vt1a5v0ZbElUWWdmJtFfWyw9gyzHZZZMFDcMrBJpT
         3zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291421; x=1689883421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdgC3Azugwc5mt6u8ZricLJq3eD0D+n/vIOu1NtFkBc=;
        b=A0fxpZgxQVnG+6N5k46tETD1YCgllG73EbRYgWgJ+EILV82Dz8109FxkgZz7bEeeZy
         lp4wDdpvtNfrgADn9530IX0CwWbm+yXkNZxx2Dv6ZPJuOQKh4Wmdd5hduOZ3iA/6StT0
         IwqP68yG1DKf5QuH7GnH0tS3IZKVXg7trYLYqbo79saL4MnU11+SFCUkDCK3e2puTr1/
         LcRDV62wCyyUkWyKcej7jLN3BBCYEhbY/TnkAIV4HoNh0EC9389F17X/xNf+wcAlDhMy
         r3RKhMi0vOxPdgslQovdBHbuwYA14qwWTYHSj8nbpWoUSoqceACjid996+cvGL296iV/
         2TSQ==
X-Gm-Message-State: AC+VfDzlbQ93QKa+BGCb6hZJSoG+RLUIavIqMWEBk4a+aNE6uqm0+fyX
        dCnI5O8dwth4dC51BAeeK3w=
X-Google-Smtp-Source: ACHHUZ4iJDFvUEsPGQNsNbgDXi+OZ8rpO0wa54IauUDFNxLrHa2lDYKEqoWapjwUOeaRn3wwDSxmqw==
X-Received: by 2002:a17:906:d54f:b0:988:a632:774a with SMTP id cr15-20020a170906d54f00b00988a632774amr7089419ejc.27.1687291421516;
        Tue, 20 Jun 2023 13:03:41 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090617d500b00977e0bcff1esm1947064eje.10.2023.06.20.13.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:03:40 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Tue, 20 Jun 2023 22:03:03 +0200
Subject: [PATCH RFC v4 10/13] regulator: implement
 mon_disable_reg_set_{higher,lower}
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-dynamic-vmon-v4-10-4d3734e62ada@skidata.com>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
In-Reply-To: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

The mon_disable_reg_set_{higher,lower} properties disable all dt-enabled
monitors when the value of the regulator is changed to a higher or lower
one.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/core.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b37dcafff407..74b9c12d38e9 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3643,6 +3643,7 @@ static int _regulator_call_set_voltage(struct regulator_dev *rdev,
 				       int min_uV, int max_uV,
 				       unsigned *selector)
 {
+	const struct regulator_desc *desc = rdev->desc;
 	struct pre_voltage_change_data data;
 	int ret;
 
@@ -3654,7 +3655,18 @@ static int _regulator_call_set_voltage(struct regulator_dev *rdev,
 	if (ret & NOTIFY_STOP_MASK)
 		return -EINVAL;
 
-	ret = rdev->desc->ops->set_voltage(rdev, min_uV, max_uV, selector);
+	if (min_uV > data.old_uV || max_uV > data.old_uV) {
+		ret = monitors_disable(rdev, desc->mon_disable_reg_set_higher);
+		if (ret)
+			return ret;
+	}
+	if (min_uV < data.old_uV || max_uV < data.old_uV) {
+		ret = monitors_disable(rdev, desc->mon_disable_reg_set_lower);
+		if (ret)
+			return ret;
+	}
+
+	ret = desc->ops->set_voltage(rdev, min_uV, max_uV, selector);
 	if (ret >= 0)
 		return ret;
 
@@ -3667,6 +3679,7 @@ static int _regulator_call_set_voltage(struct regulator_dev *rdev,
 static int _regulator_call_set_voltage_sel(struct regulator_dev *rdev,
 					   int uV, unsigned selector)
 {
+	const struct regulator_desc *desc = rdev->desc;
 	struct pre_voltage_change_data data;
 	int ret;
 
@@ -3678,7 +3691,18 @@ static int _regulator_call_set_voltage_sel(struct regulator_dev *rdev,
 	if (ret & NOTIFY_STOP_MASK)
 		return -EINVAL;
 
-	ret = rdev->desc->ops->set_voltage_sel(rdev, selector);
+	if (uV > data.old_uV) {
+		ret = monitors_disable(rdev, desc->mon_disable_reg_set_higher);
+		if (ret)
+			return ret;
+	}
+	if (uV < data.old_uV) {
+		ret = monitors_disable(rdev, desc->mon_disable_reg_set_lower);
+		if (ret)
+			return ret;
+	}
+
+	ret = desc->ops->set_voltage_sel(rdev, selector);
 	if (ret >= 0)
 		return ret;
 
@@ -3780,7 +3804,8 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 	int best_val = 0;
 	unsigned int selector;
 	int old_selector = -1;
-	const struct regulator_ops *ops = rdev->desc->ops;
+	const struct regulator_desc *desc = rdev->desc;
+	const struct regulator_ops *ops = desc->ops;
 	int old_uV = regulator_get_voltage_rdev(rdev);
 
 	trace_regulator_set_voltage(rdev_get_name(rdev), min_uV, max_uV);
@@ -3819,7 +3844,7 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				selector = ret;
 				if (old_selector == selector)
 					ret = 0;
-				else if (rdev->desc->vsel_step)
+				else if (desc->vsel_step)
 					ret = _regulator_set_voltage_sel_step(
 						rdev, best_val, selector);
 				else
@@ -3874,6 +3899,14 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 out:
 	trace_regulator_set_voltage_complete(rdev_get_name(rdev), best_val);
 
+	/* if setting voltage failed, ignore monitoring error. */
+	if (ret)
+		monitors_reenable(rdev, desc->mon_disable_reg_set_higher |
+					desc->mon_disable_reg_set_lower);
+	else
+		ret = monitors_reenable(rdev, desc->mon_disable_reg_set_higher |
+					      desc->mon_disable_reg_set_lower);
+
 	return ret;
 }
 

-- 
2.34.1

