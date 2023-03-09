Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1731F6B2633
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjCIODx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjCIODa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:03:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D955CF4D92
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:00:56 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 583C5660302F;
        Thu,  9 Mar 2023 14:00:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678370455;
        bh=aaF5sPIUMsU7hS70kIpLTU2rsDAJ9y3ZK3OUhGBnqmg=;
        h=From:To:Cc:Subject:Date:From;
        b=jffchyZvvvrIy6wNHhpwtuitMy/2qzMqbSX1ZOo7yKrclb/GSTg+W+0/+R392Q7wS
         dwzvIrHiQ4mYx7xiHQSxKm6+Hnhn8EobCXIjTieuw4q4wx0O5l59KUoYBur0DVUVlB
         eTUvy8viUeWrHGrY/8w8l2IfvLnXIo/FxZ4PnS2t/AIyDOaWw+aAYd61tTrKwCZWAN
         oLqQTnZKCtcXETf7TuefhWMEnPntPa+XqPM2z4Zky5yfK5X9Rq9o5zDzXJbR1PDV+l
         1vwLLRq+5StuAet6A/qOwvSeIlKlvXyl4d0F3wtBO4HKDScSuZ5B45dZezggObkOUC
         wpiqGmCfc4qTg==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai --cc=alsa-devel @ alsa-project . org" <tiwai@suse.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Lucas Tanure <lucas.tanure@collabora.com>
Subject: [PATCH v5] ASoC: cs35l41: Steam Deck Shared boost properties quirk
Date:   Thu,  9 Mar 2023 14:00:51 +0000
Message-Id: <20230309140051.945329-1-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Steam Deck bios old properties. If a Steam deck didn't
upgrade the BIOS, the driver should be able to handle the previous
properties for shared boost types.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
Changes since V4:
 - Add documentation about this quirk

Changes since V3:
 - Fixed missing space in if statement
 - Fix the build issue, as dependency patches are already merged

Changes since V2:
 - sent the wrong patch with missing fixed lines
Changes since V1:
 - else in same line as {
---
 sound/soc/codecs/cs35l41.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 1624510d09c0..9ec01a5f09ca 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1022,9 +1022,21 @@ static int cs35l41_handle_pdata(struct device *dev, struct cs35l41_hw_cfg *hw_cf
 	unsigned int val;
 	int ret;
 
-	ret = device_property_read_u32(dev, "cirrus,boost-type", &val);
-	if (ret >= 0)
-		hw_cfg->bst_type = val;
+	/* Some ACPI systems received the Shared Boost feature before the upstream driver,
+	 * leaving those systems with deprecated _DSD properties.
+	 * To correctly configure those systems add shared-boost-active and shared-boost-passive
+	 * properties mapped to the correct value in boost-type.
+	 * These two are not DT properties and should not be used in new systems designs.
+	 */
+	if (device_property_read_bool(dev, "cirrus,shared-boost-active")) {
+		hw_cfg->bst_type = CS35L41_SHD_BOOST_ACTV;
+	} else if (device_property_read_bool(dev, "cirrus,shared-boost-passive")) {
+		hw_cfg->bst_type = CS35L41_SHD_BOOST_PASS;
+	} else {
+		ret = device_property_read_u32(dev, "cirrus,boost-type", &val);
+		if (ret >= 0)
+			hw_cfg->bst_type = val;
+	}
 
 	ret = device_property_read_u32(dev, "cirrus,boost-peak-milliamp", &val);
 	if (ret >= 0)
-- 
2.39.2

