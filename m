Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B8F5B97F3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiIOJrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiIOJpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:45:45 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21B399B6D;
        Thu, 15 Sep 2022 02:45:41 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1663235138; bh=cW5w38A8GLInG+MinVkl6F+e++EU/JdqSt9RzpfaksU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gb+bXPbLB9YOA2ZndnvlCuK62asG96OLytjqpzjFrTgE1DVS18ds4rVYtgdOpecbx
         7a5pk6VpIgyFXcREdSV24QKrvsrX6DfaF/H6X9qicskfheJMuY9ttmqTs/fUNPCDQ1
         YnvPXUTUMpeL/c8fvRSuJyMYGgqsBaZIuH0FQeAY=
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Matt Flax <flatmax@flatmax.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: [PATCH v2 11/11] ASoC: cs42l42: Switch to dev_err_probe() helper
Date:   Thu, 15 Sep 2022 11:44:44 +0200
Message-Id: <20220915094444.11434-12-povik+lin@cutebit.org>
In-Reply-To: <20220915094444.11434-1-povik+lin@cutebit.org>
References: <20220915094444.11434-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace dev_err() with dev_err_probe() in the probe path for consistency
with cs42l83-i2c.c.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/cs42l42-i2c.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l42-i2c.c b/sound/soc/codecs/cs42l42-i2c.c
index 35fecff0f74f..1900ec75576e 100644
--- a/sound/soc/codecs/cs42l42-i2c.c
+++ b/sound/soc/codecs/cs42l42-i2c.c
@@ -25,11 +25,9 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
 		return -ENOMEM;
 
 	regmap = devm_regmap_init_i2c(i2c_client, &cs42l42_regmap);
-	if (IS_ERR(regmap)) {
-		ret = PTR_ERR(regmap);
-		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(&i2c_client->dev, PTR_ERR(regmap),
+				     "regmap_init() failed\n");
 
 	cs42l42->devid = CS42L42_CHIP_ID;
 	cs42l42->dev = dev;
-- 
2.33.0

