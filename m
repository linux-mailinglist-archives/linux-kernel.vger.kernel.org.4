Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6116A81AC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjCBL5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCBL5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:57:31 -0500
Received: from out-39.mta1.migadu.com (out-39.mta1.migadu.com [IPv6:2001:41d0:203:375::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596AD37569
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:57:23 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677758241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sredrf5PjZ7jQFXwhsTWfhRpimvvGAc4wV/iwzTmZq0=;
        b=p3i2oWfXX64J/GM40FQzzz9ICV3FS6E6pH4lDCCyy7YOp2GeNRWM0L6LgWvaaDUFYG8nrS
        JsC4lt9h3nfU1JJGScOJBu6/x+XrQKJnq360TuI5WChEuOL3dC/CGCuPgG3RaxCBz9v/4o
        SuxS+lrnpNYeCA30kp61Se0VWYaGU0A=
From:   richard.leitner@linux.dev
Date:   Thu, 02 Mar 2023 12:55:03 +0100
Subject: [PATCH 3/3] ASoC: maxim,max9867: add "mclk" support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230302-max9867-v1-3-aa9f7f25db5e@skidata.com>
References: <20230302-max9867-v1-0-aa9f7f25db5e@skidata.com>
In-Reply-To: <20230302-max9867-v1-0-aa9f7f25db5e@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1453;
 i=richard.leitner@skidata.com; h=from:subject:message-id;
 bh=t7JeLv5Avx9AQ87GdXmgLhpXQCWm8ePC8Uj/0k4VhNI=;
 b=owGbwMvMwCX2R2KahkXN7wuMp9WSGFIY+uU7ly5v9/95II6d2/TEmpl/JRpjl/9oubQ0q6J9w9Pg
 BJ1PHaUsDGJcDLJiiiz2xlzt7rll7ysVdXJh5rAygQxh4OIUgImcimX4p+Rb7Xtxr/wJwSKfq3Jq+z
 3TBM53av9zm7Gv/Nbi8hlPpjH8lanmVk9hWxPJdoeZ6dvrUyq+6x84Fxjm/T4//3H/R2tLZgA=
X-Developer-Key: i=richard.leitner@skidata.com; a=openpgp;
 fpr=3F330A87476D76EF79212C6DFC189628387CFBD0
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Add basic support for the codecs mclk by enabling it during probing.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 sound/soc/codecs/max9867.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index e161ab037bf7..b92dd61bb2b2 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -6,6 +6,7 @@
 // Copyright 2018 Ladislav Michl <ladis@linux-mips.org>
 //
 
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -16,6 +17,7 @@
 #include "max9867.h"
 
 struct max9867_priv {
+	struct clk *mclk;
 	struct regmap *regmap;
 	const struct snd_pcm_hw_constraint_list *constraints;
 	unsigned int sysclk, pclk;
@@ -663,8 +665,18 @@ static int max9867_i2c_probe(struct i2c_client *i2c)
 	dev_info(&i2c->dev, "device revision: %x\n", reg);
 	ret = devm_snd_soc_register_component(&i2c->dev, &max9867_component,
 			max9867_dai, ARRAY_SIZE(max9867_dai));
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
+		return ret;
+	}
+
+	max9867->mclk = devm_clk_get(&i2c->dev, "mclk");
+	if (IS_ERR(max9867->mclk))
+		return PTR_ERR(max9867->mclk);
+	ret = clk_prepare_enable(max9867->mclk);
+	if (ret < 0)
+		dev_err(&i2c->dev, "Failed to enable MCLK: %d\n", ret);
+
 	return ret;
 }
 

-- 
2.39.2

