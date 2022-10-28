Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD606611BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJ1U4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJ1U4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:56:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADF5226E7E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:55:58 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B45B7660294B;
        Fri, 28 Oct 2022 21:55:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666990557;
        bh=fWR6lgaHeOPHW1FSsPg4QG/1KgRcjLHEyF+Wsu51etk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UrmysWN2I9Qqpva8V2G9/hL5C9jyElZSwIVdheQjvOtBk3gQCViqJgDYmils7P/pZ
         eOWqWMsy2u2qZ/kU8sKUykuSbFvINlb1MgLt+qy0rx0njLcGBNxdic9cGyX1zzYe1W
         WWiZU+htGxfrXsql80TI6Vx+TUyljCwi1ysLqfm159j9awR5ENR17JpW6ICMdiAh53
         bponcNnEUG+c/bCRIQ42WjekH5YQgEn9JLJDz0biUcGsLcB0KhSBN5Qnp8P8qF78WQ
         6Wj8FC3Hq2N0DZRFiKk0zRShwOhwXL9xV+plvKI7i5zZiFIt8YhZndIZXF1lVh/V+R
         xEKm5UboxXncg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] ASoC: rt5682s: Support dbvdd and ldo1-in supplies
Date:   Fri, 28 Oct 2022 16:55:37 -0400
Message-Id: <20221028205540.3197304-6-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028205540.3197304-1-nfraprado@collabora.com>
References: <20221028205540.3197304-1-nfraprado@collabora.com>
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

Add support for the dbvdd and ldo1-in supplies.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 sound/soc/codecs/rt5682s.c | 22 ++++++++++++++++++++++
 sound/soc/codecs/rt5682s.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
index 80c673aa14db..de686004e504 100644
--- a/sound/soc/codecs/rt5682s.c
+++ b/sound/soc/codecs/rt5682s.c
@@ -44,6 +44,8 @@ static const struct rt5682s_platform_data i2s_default_platform_data = {
 static const char *rt5682s_supply_names[RT5682S_NUM_SUPPLIES] = {
 	[RT5682S_SUPPLY_AVDD] = "AVDD",
 	[RT5682S_SUPPLY_MICVDD] = "MICVDD",
+	[RT5682S_SUPPLY_DBVDD] = "dbvdd",
+	[RT5682S_SUPPLY_LDO1_IN] = "ldo1-in",
 };
 
 static const struct reg_sequence patch_list[] = {
@@ -3089,6 +3091,14 @@ static void rt5682s_i2c_disable_regulators(void *data)
 	if (ret)
 		dev_err(dev, "Failed to disable supply AVDD: %d\n", ret);
 
+	ret = regulator_disable(rt5682s->supplies[RT5682S_SUPPLY_DBVDD].consumer);
+	if (ret)
+		dev_err(dev, "Failed to disable supply dbvdd: %d\n", ret);
+
+	ret = regulator_disable(rt5682s->supplies[RT5682S_SUPPLY_LDO1_IN].consumer);
+	if (ret)
+		dev_err(dev, "Failed to disable supply ldo1-in: %d\n", ret);
+
 	usleep_range(1000, 1500);
 
 	ret = regulator_disable(rt5682s->supplies[RT5682S_SUPPLY_MICVDD].consumer);
@@ -3150,6 +3160,18 @@ static int rt5682s_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
+	ret = regulator_enable(rt5682s->supplies[RT5682S_SUPPLY_DBVDD].consumer);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to enable supply dbvdd: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_enable(rt5682s->supplies[RT5682S_SUPPLY_LDO1_IN].consumer);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to enable supply ldo1-in: %d\n", ret);
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

