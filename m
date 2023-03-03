Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1B66A94CD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjCCKEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjCCKEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:04:20 -0500
Received: from out-49.mta1.migadu.com (out-49.mta1.migadu.com [95.215.58.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E202125AE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 02:04:14 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677837853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwgv6vZF0y8lp2WjIbk7DSvdWa3VrwfThseCo0zqB4k=;
        b=X50FDpSrYOh7nBnY9KeIVLLZrMW+Iy3/KCSwe6SBcvXqmo7UH+lYckw7f1hmsp810eH1Wq
        W7G/7JsUCGldKfJzgynYfDjOKbIId0+lRKKHL1CeqWxNyOtsPm9KLoElh9Uuy5pjKzXQBp
        5XNexFSnTTUiA9K0WuOe6wKnIrDudEs=
From:   richard.leitner@linux.dev
Date:   Fri, 03 Mar 2023 11:04:03 +0100
Subject: [PATCH v2 3/3] ASoC: maxim,max9867: add "mclk" support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230302-max9867-v2-3-fd2036d5e825@skidata.com>
References: <20230302-max9867-v2-0-fd2036d5e825@skidata.com>
In-Reply-To: <20230302-max9867-v2-0-fd2036d5e825@skidata.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     Benjamin Bara <bbara93@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184;
 i=richard.leitner@skidata.com; h=from:subject:message-id;
 bh=wYqb5T3X4q78UgSPWnOpqyJNxmqmPsLey2OahM/f3Ks=;
 b=owGbwMvMwCX2R2KahkXN7wuMp9WSGFIYj0mJhCjoW4q/7NLatPNY7qwTx3TOeH6qSFp08MjxmQxs
 y+N5OkpZGMS4GGTFFFnsjbna3XPL3lcq6uTCzGFlAhnCwMUpABMJtWL479+m3rZnYrLP5M9aZ0SrbF
 v3Hryy+KZD+OejF+dt/5m3mpWR4Ve/wXs7qezqf2Elkzu/SR2+IByjmnfocEiGpsWDzH9buQA=
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

Add basic support for the codecs' mclk.
Enable it on SND_SOC_BIAS_ON, disable it on SND_SOC_BIAS_OFF.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 sound/soc/codecs/max9867.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index e161ab037bf7..ae552d72beec 100644
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
@@ -577,6 +579,11 @@ static int max9867_set_bias_level(struct snd_soc_component *component,
 	struct max9867_priv *max9867 = snd_soc_component_get_drvdata(component);
 
 	switch (level) {
+	case SND_SOC_BIAS_ON:
+		err = clk_prepare_enable(max9867->mclk);
+		if (err)
+			return err;
+		break;
 	case SND_SOC_BIAS_STANDBY:
 		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			err = regcache_sync(max9867->regmap);
@@ -595,6 +602,7 @@ static int max9867_set_bias_level(struct snd_soc_component *component,
 			return err;
 
 		regcache_mark_dirty(max9867->regmap);
+		clk_disable_unprepare(max9867->mclk);
 		break;
 	default:
 		break;
@@ -663,9 +671,16 @@ static int max9867_i2c_probe(struct i2c_client *i2c)
 	dev_info(&i2c->dev, "device revision: %x\n", reg);
 	ret = devm_snd_soc_register_component(&i2c->dev, &max9867_component,
 			max9867_dai, ARRAY_SIZE(max9867_dai));
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
-	return ret;
+		return ret;
+	}
+
+	max9867->mclk = devm_clk_get(&i2c->dev, NULL);
+	if (IS_ERR(max9867->mclk))
+		return PTR_ERR(max9867->mclk);
+
+	return 0;
 }
 
 static const struct i2c_device_id max9867_i2c_id[] = {

-- 
2.39.2

