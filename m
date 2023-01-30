Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3568F681704
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbjA3QzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbjA3Qyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:54:49 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405C93D935
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:54:47 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ud5so33627862ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufhJAWNpVWI5s+uFKzVFnYTvPvLzKFeYy7PIx77olTQ=;
        b=GOoodPz+j/Nj3krXYVUmcMvp7eE4Q9UnmiITSbTtixmCz/KCJv/O6ZSWAte9XLOJNx
         EoYDCRXJVT4C5BBRlNTB2AwOe3F5exjMz23eDTpl/ISOgpFuMd53TJYDzlc5yzTq0Q7p
         FV8E3uD+zyzedG3+64Q1DBSYdkCJiTZwLdzg/d2/7czrMJcFhH1iRpoAwM/jQleWbbkX
         0adA11S0DNb1eY4JMhEBvQmCWXkctklrW47nmZ0StqH446q98+48qUNgmYQDdDgWUQKT
         e9+p+kIOvT7lwhLsKDdg23VtyqMAIK/V+wUt8RPWnJHYWWKB0yA2q7wUhTaQAI8kSjxs
         ErUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufhJAWNpVWI5s+uFKzVFnYTvPvLzKFeYy7PIx77olTQ=;
        b=JnrLZjrQ34fYM8AOQehw0aCuxtwzjQzfNKBHU/7kBdgAi40doHLX/URnfr+bm1yllo
         cRA+U4sdXwnz3sN7hp3ZfbZy58X3aZ5nvp5LDeJXALXIngIg7SJU3jBDfzpsy7uKA+iZ
         F72AxajU//JN3kNjODyNZRCkzXMMMIeqmAsRVFDDq9RiTIWnHBA3FsaJl6jAivn66Tca
         5oqpAI5PaURaBJ/Z/uzGeutL71TG9rdFik2ztbgPw++mbsOFDRqNveLNDCvwXfC3NgZj
         TvLE9kQiGlLITNeP03WuMBO8oNKvkNzPdGi/1KBVzd9x19DYtEDBK3A5Rlst+vU56b6r
         haoQ==
X-Gm-Message-State: AO0yUKXMwY2Z6/A/u2zGfkoIQKbcIFpd4sOm2VXqxnxFlPv4SXAOjRwE
        +sYsK3q4iIEBeE1GpaQQdTTsVw==
X-Google-Smtp-Source: AK7set9N7uRLgO4eAE1Paw3D3zsrQ3qY4m8inwATd9YUXZRpAgs/GLFR396GwUyTsSUXxvW6BwSHjA==
X-Received: by 2002:a17:907:8b90:b0:87b:db63:1e18 with SMTP id tb16-20020a1709078b9000b0087bdb631e18mr122730ejc.71.1675097685873;
        Mon, 30 Jan 2023 08:54:45 -0800 (PST)
Received: from localhost.localdomain (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id lj14-20020a170906f9ce00b0088744fc7084sm2590651ejb.38.2023.01.30.08.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 08:54:45 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] pinctrl: pinconf-generic: Add an overridable way to set bias property
Date:   Mon, 30 Jan 2023 17:54:35 +0100
Message-Id: <20230130165435.2347569-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130165435.2347569-1-konrad.dybcio@linaro.org>
References: <20230130165435.2347569-1-konrad.dybcio@linaro.org>
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

We came to a point where we sometimes we support a few dozen boards
with a given SoC. Sometimes, we have to take into consideration
configurations which deviate rather significatly from the reference
or most common designs. In the context of pinctrl, this often comes
down to wildly different pin configurations. While pins, function and
drive-strength are easily overridable, the (mostly) boolean properties
associated with setting bias, aren't. This wouldn't be much of a
problem if they didn't differ between boards so often, preventing us
from having a "nice" baseline setup without inevitably having to go
with an ugly /delete-property/.

Introduce logic to handle bias-type, a property which sets a single
boolean type of bias on the pin (more than one type of BIAS_ does not
make sense, anyway) to make it easily overridable.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pinctrl/pinconf-generic.c       | 35 ++++++++++++++++++++++---
 include/linux/pinctrl/pinconf-generic.h |  1 +
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 365c4b0ca465..b99c2a85486e 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -206,11 +206,38 @@ static void parse_dt_cfg(struct device_node *np,
 			 unsigned int count, unsigned long *cfg,
 			 unsigned int *ncfg)
 {
-	int i;
+	int i, ret;
+	u32 val;
+
+	/* Let's assume only one type of bias is used.. as it should be.. */
+	ret = of_property_read_u32(np, "bias-type", &val);
+	if (!ret) {
+		/* Bias properties end at idx PIN_CONFIG_BIAS_PULL_UP */
+		if (ret > PIN_CONFIG_BIAS_PULL_UP) {
+			pr_err("invalid type: %u\n", val);
+			goto generic_parse;
+		}
 
-	for (i = 0; i < count; i++) {
-		u32 val;
-		int ret;
+		pr_debug("found bias type %u\n", val);
+		/*
+		 * Properties between PIN_CONFIG_BIAS_PULL_DOWN and PIN_CONFIG_BIAS_PULL_UP
+		 * have a default value of one, others default to zero.
+		 */
+		cfg[*ncfg] = pinconf_to_config_packed(val, val >= PIN_CONFIG_BIAS_PULL_DOWN);
+		(*ncfg)++;
+
+		/* Start the generic property read loop where bias properties end. */
+		i = PIN_CONFIG_DRIVE_OPEN_DRAIN;
+	} else {
+		/*
+		 * If we don't set bias through bias-type, search for all DT
+		 * properties like nothing ever happened.
+		 */
+generic_parse:
+		i = 0;
+	}
+
+	for (; i < count; i++) {
 		const struct pinconf_generic_params *par = &params[i];
 
 		ret = of_property_read_u32(np, par->property, &val);
diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index d74b7a4ea154..bcf68ba1ea46 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -117,6 +117,7 @@ struct pinctrl_map;
  *	presented using the packed format.
  */
 enum pin_config_param {
+	/* Keep in sync with dt-bindings/pinctrl/pinconf-generic.h! */
 	PIN_CONFIG_BIAS_BUS_HOLD,
 	PIN_CONFIG_BIAS_DISABLE,
 	PIN_CONFIG_BIAS_HIGH_IMPEDANCE,
-- 
2.39.1

