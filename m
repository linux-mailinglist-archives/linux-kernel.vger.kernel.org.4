Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9062D6B21BD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCIKnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjCIKmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:42:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A4B4DE05
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:41:37 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F9956600367;
        Thu,  9 Mar 2023 10:41:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678358496;
        bh=rDJinSTUl2SsH8QxrfLak8PdCTIdyoUhmTvkTCGkzYo=;
        h=From:To:Cc:Subject:Date:From;
        b=fQJfGcZyxHN9NztsOTxKsUDBJzvCBZkVDSAAIKlQDt9L7iXyQeJ4AMHAt6gQrr512
         M53fwrObR19IFUblv8aG6YmKgUJUmgdKYaqxtPhhQNJ+W/+QqC5bSnCitbbLxkNs0f
         qoF5sGNGHeY9cKWGqXYFvs+BsbcmgQt6MPE3UK5XxBhcHrSTsYFXDHwYpingZRLsT8
         3ob296muTtPud5Cb6B+q+OsCoRejKQiq5GiEwPI6nqsSSCh1IQwKNm7ACoFEuMOxCU
         xtsVV7SiVaN0KjlJXrJRYf3VhFUcPZdLOftRYP56pc95gQKEbkzm2GoxkRdyQHT/b5
         7SKOk8J6sD6qg==
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
Subject: [PATCH v4] ASoC: cs35l41: Steam Deck Shared boost properties quirk
Date:   Thu,  9 Mar 2023 10:41:33 +0000
Message-Id: <20230309104133.537056-1-lucas.tanure@collabora.com>
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
Changes since V3:
 - Fixed missing space in if statement
 - Fix the build issue, as dependency patches are already merged

Changes since V2:
 - sent the wrong patch with missing fixed lines
Changes since V1:
 - else in same line as {
---
 sound/soc/codecs/cs35l41.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 1624510d09c0..2803ff0f0003 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1022,9 +1022,15 @@ static int cs35l41_handle_pdata(struct device *dev, struct cs35l41_hw_cfg *hw_cf
 	unsigned int val;
 	int ret;
 
-	ret = device_property_read_u32(dev, "cirrus,boost-type", &val);
-	if (ret >= 0)
-		hw_cfg->bst_type = val;
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

