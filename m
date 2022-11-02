Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C619616BF2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiKBSUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiKBSUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:20:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734772F03B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:20:17 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E344E6602948;
        Wed,  2 Nov 2022 18:20:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667413216;
        bh=OfMwEPRyzP69cf0RbqYMeq7wYptVsG5Ag1i1BjFEAS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T8GiEKHc8UtFOYUTrPUOVTnAL1fBOP0leZVHpAvJGznyzxuomjwzC3xFcrlqgcaZc
         NH9gSfQTB9k1f8OysAGYkJ1DakMgh5w2EA9ZxzAx/3ryKYPQB7RBMefBi6dvDuHkLY
         H919o8MLhJMWZcghrXV0ISVX8ePMgHnBUbjBXSpl8GWUdvqbYuT8ZQAn7TpMMaJGLH
         5IoTZBAQm/H5616oyeO4wl9DmQCCQrT/CVSXHFmquP5cc/KCe4Ai1OeGrQYhcs0Xqy
         X3VHib7o3BtzrR0Fup7JIMtXosIlpWL+RsME7YyYkpXgRJKOWs3LFVNrhxREIdRDW7
         pZ16b9a1UcSfw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] ASoC: rt5682s: Support DBVDD and LDO1-IN supplies
Date:   Wed,  2 Nov 2022 14:19:59 -0400
Message-Id: <20221102182002.255282-6-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102182002.255282-1-nfraprado@collabora.com>
References: <20221102182002.255282-1-nfraprado@collabora.com>
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

Add support for the DBVDD and LDO1-IN supplies.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Made names uppercase

 sound/soc/codecs/rt5682s.c | 22 ++++++++++++++++++++++
 sound/soc/codecs/rt5682s.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index 80c673aa14db..f5e5dbc3b0f0 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -44,6 +44,8 @@ static const struct rt5682s_platform_data i2s_default_platform_data = {
 static const char *rt5682s_supply_names[RT5682S_NUM_SUPPLIES] = {
 	[RT5682S_SUPPLY_AVDD] = "AVDD",
 	[RT5682S_SUPPLY_MICVDD] = "MICVDD",
+	[RT5682S_SUPPLY_DBVDD] = "DBVDD",
+	[RT5682S_SUPPLY_LDO1_IN] = "LDO1-IN",
 };
 
 static const struct reg_sequence patch_list[] = {
@@ -3089,6 +3091,14 @@ static void rt5682s_i2c_disable_regulators(void *data)
 	if (ret)
 		dev_err(dev, "Failed to disable supply AVDD: %d\n", ret);
 
+	ret = regulator_disable(rt5682s->supplies[RT5682S_SUPPLY_DBVDD].consumer);
+	if (ret)
+		dev_err(dev, "Failed to disable supply DBVDD: %d\n", ret);
+
+	ret = regulator_disable(rt5682s->supplies[RT5682S_SUPPLY_LDO1_IN].consumer);
+	if (ret)
+		dev_err(dev, "Failed to disable supply LDO1-IN: %d\n", ret);
+
 	usleep_range(1000, 1500);
 
 	ret = regulator_disable(rt5682s->supplies[RT5682S_SUPPLY_MICVDD].consumer);
@@ -3150,6 +3160,18 @@ static int rt5682s_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
+	ret = regulator_enable(rt5682s->supplies[RT5682S_SUPPLY_DBVDD].consumer);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to enable supply DBVDD: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_enable(rt5682s->supplies[RT5682S_SUPPLY_LDO1_IN].consumer);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to enable supply LDO1-IN: %d\n", ret);
+		return ret;
+	}
+
 	if (gpio_is_valid(rt5682s->pdata.ldo1_en)) {
 		if (devm_gpio_request_one(&i2c->dev, rt5682s->pdata.ldo1_en,
 					  GPIOF_OUT_INIT_HIGH, "rt5682s"))
diff --git a/sound/soc/codecs/rt5682s.h b/sound/soc/codecs/rt5682s.h
index 45464a041765..67f86a38a1cc 100644
--- a/sound/soc/codecs/rt5682s.h
+++ b/sound/soc/codecs/rt5682s.h
@@ -1438,6 +1438,8 @@ struct pll_calc_map {
 enum {
 	RT5682S_SUPPLY_AVDD,
 	RT5682S_SUPPLY_MICVDD,
+	RT5682S_SUPPLY_DBVDD,
+	RT5682S_SUPPLY_LDO1_IN,
 	RT5682S_NUM_SUPPLIES,
 };
 
-- 
2.38.1

