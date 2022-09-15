Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20075B97F2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiIOJqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiIOJpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:45:43 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD4D99B5A;
        Thu, 15 Sep 2022 02:45:40 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1663235134; bh=BTEvJw27Nhc3mokcYBqX/ytgif77xcp9KsV69JU4ANA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=s2QTzLGnbirfxygkHhR0TmtusTpo2Jfj9pbSPU2u97JK+7bk1bBdddcMbuHYzLrhT
         FowN8VHGtSppIGoqd+kLw2nlxTcgZQhOk5WOmABgx18Q3RZTddu+vfoKoDto+gslCa
         XvB3+9rwMlzjJzhpt5tiwJQPWbuhiL9p9kSJ4zOs=
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
Subject: [PATCH v2 05/11] ASoC: cs42l42: Split cs42l42_resume into two functions
Date:   Thu, 15 Sep 2022 11:44:38 +0200
Message-Id: <20220915094444.11434-6-povik+lin@cutebit.org>
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

From: Richard Fitzgerald <rf@opensource.cirrus.com>

On SoundWire the system resume cannot restore registers until the
host controller has re-enumerated the peripheral.

This patch splits cs42l42_resume() into two functions, one to
power up and the other to restore registers, ready for adding
SoundWire support.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/cs42l42.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 427b29db2252..156d1b181cef 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2183,6 +2183,15 @@ static int __maybe_unused cs42l42_resume(struct device *dev)
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
 	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
 
+	dev_dbg(dev, "System resume powered up\n");
+
+	return 0;
+}
+
+static void __maybe_unused cs42l42_resume_restore(struct device *dev)
+{
+	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
+
 	regcache_cache_only(cs42l42->regmap, false);
 	regcache_mark_dirty(cs42l42->regmap);
 
@@ -2195,6 +2204,17 @@ static int __maybe_unused cs42l42_resume(struct device *dev)
 	mutex_unlock(&cs42l42->irq_lock);
 
 	dev_dbg(dev, "System resumed\n");
+}
+
+static int __maybe_unused cs42l42_i2c_resume(struct device *dev)
+{
+	int ret;
+
+	ret = cs42l42_resume(dev);
+	if (ret)
+		return ret;
+
+	cs42l42_resume_restore(dev);
 
 	return 0;
 }
@@ -2413,7 +2433,7 @@ static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
 }
 
 static const struct dev_pm_ops cs42l42_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(cs42l42_suspend, cs42l42_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(cs42l42_suspend, cs42l42_i2c_resume)
 };
 
 #ifdef CONFIG_OF
-- 
2.33.0

