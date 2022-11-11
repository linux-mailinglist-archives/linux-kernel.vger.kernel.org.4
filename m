Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9BA625D54
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbiKKOkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbiKKOjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:39:39 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2BE6584D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:39:29 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l11so7907503edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMEYouN33VXJnGj1szjoBs9S5kXWzk4pLlmEmqoZFno=;
        b=aYLheQpYSAA+nvIa8jyxXle6dr+WMfHP/Q3Xc7+2lnehrlu5Uxzb2AighHNYmghKXh
         XCQvPKImeoie67r83OOlpg4Jg4N7ZI4I9oCgVyQ/O2crwjrallGtflR058/P8LymOWzZ
         e+vsF5mXlwN57u+OUIx04kLjRfdzkol9U6gDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMEYouN33VXJnGj1szjoBs9S5kXWzk4pLlmEmqoZFno=;
        b=6F1TaUsjO9d2o0cY5Gf1gQZlW+vh29VfMU+FjsHzwztWwDkV/uvIfUr/3dlD49AFZe
         1PwE4+IpJsMF42eVdl3Jz4F86vqA3evlxRDZzQU8X8W3n5TAoUvIVYlA8LyowY4ryM1l
         6JPKpTpPN5FtVxqCEXeF79Ku1GQSGY4B+K2lWL1Cebz/W0QhwKSFbjFConehUY5SuR2f
         EZcdF+ddZOy9l2nyv7mEu16XH2nE4pOdF6A80P1YmR5gQcnbFpi3iuxkObMPOUZhKoje
         7ISZGsN71iT2myB4DkKhioA3f36GfzrBWSBhw7jkS4Qht+oKawKQ0jKT6Mbc9fInNZPg
         WmQA==
X-Gm-Message-State: ANoB5pkf4FbGwaH+sOkaMY60NvqrPbC9meZKVrIB4DYiJL78z8FWd85c
        z/DAn3+6Jw4/TcS84TNAMIXuXQ==
X-Google-Smtp-Source: AA0mqf6EZrJe3b/AEPYKxhBsDWFd7mBnEEhN5/HmA8x0PqIa8X/7blYSPJPVgjhCfuRbdElYD/vX3A==
X-Received: by 2002:a05:6402:158c:b0:463:19ca:a573 with SMTP id c12-20020a056402158c00b0046319caa573mr1727365edv.31.1668177567955;
        Fri, 11 Nov 2022 06:39:27 -0800 (PST)
Received: from prevas-ravi.tritech.se ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id jt4-20020a170906dfc400b007a1d4944d45sm945886ejc.142.2022.11.11.06.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 06:39:27 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] iio: addac: ad74413r: implement support for optional refin-supply
Date:   Fri, 11 Nov 2022 15:39:19 +0100
Message-Id: <20221111143921.742194-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
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

The ad74412r/ad74413r has an internal 2.5V reference output, which (by
tying the REFOUT pin to the REFIN pin) can be used in lieu of an
external 2.5V input reference.

Support that case by using devm_regulator_get_optional(), and simply
hardcode the 2500000 uV in ad74413r_get_output_current_scale().

I'm not sure this is completely correct, but it's certainly better
than the current behaviour, where when refin-supply is not defined in
device tree, the regulator framework helpfully does its

  supply refin not found, using dummy regulator

thing. When we then do the regulator_get_voltage(), that dummy
regulator of course doesn't support that operation and thus returns
-22 (-EINVAL) which is used without being checked.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/iio/addac/ad74413r.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 37485be88a63..9f77d2f514de 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -608,7 +608,10 @@ static int ad74413r_get_output_voltage_scale(struct ad74413r_state *st,
 static int ad74413r_get_output_current_scale(struct ad74413r_state *st,
 					     int *val, int *val2)
 {
-	*val = regulator_get_voltage(st->refin_reg);
+	if (st->refin_reg)
+		*val = regulator_get_voltage(st->refin_reg);
+	else
+		*val = 2500000;
 	*val2 = st->sense_resistor_ohms * AD74413R_DAC_CODE_MAX * 1000;
 
 	return IIO_VAL_FRACTIONAL;
@@ -1313,19 +1316,25 @@ static int ad74413r_probe(struct spi_device *spi)
 	if (IS_ERR(st->regmap))
 		return PTR_ERR(st->regmap);
 
-	st->refin_reg = devm_regulator_get(st->dev, "refin");
-	if (IS_ERR(st->refin_reg))
-		return dev_err_probe(st->dev, PTR_ERR(st->refin_reg),
-				     "Failed to get refin regulator\n");
+	st->refin_reg = devm_regulator_get_optional(st->dev, "refin");
+	if (IS_ERR(st->refin_reg)) {
+		ret = PTR_ERR(st->refin_reg);
+		if (ret != -ENODEV)
+			return dev_err_probe(st->dev, ret,
+					     "Failed to get refin regulator\n");
+		st->refin_reg = NULL;
+	}
 
-	ret = regulator_enable(st->refin_reg);
-	if (ret)
-		return ret;
+	if (st->refin_reg) {
+		ret = regulator_enable(st->refin_reg);
+		if (ret)
+			return ret;
 
-	ret = devm_add_action_or_reset(st->dev, ad74413r_regulator_disable,
+		ret = devm_add_action_or_reset(st->dev, ad74413r_regulator_disable,
 				       st->refin_reg);
-	if (ret)
-		return ret;
+		if (ret)
+			return ret;
+	}
 
 	st->sense_resistor_ohms = 100000000;
 	device_property_read_u32(st->dev, "shunt-resistor-micro-ohms",
-- 
2.37.2

