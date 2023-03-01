Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F006A6ACF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 11:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCAKbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 05:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCAKbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 05:31:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CB516AD6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 02:31:19 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E89306602087;
        Wed,  1 Mar 2023 10:31:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677666678;
        bh=vzFNakVN9Hz6Mq+hj/8E8VsX36Db1TbqUhW5lZURMGw=;
        h=From:To:Cc:Subject:Date:From;
        b=jVD9XnkKZQiTHsMCpPzdt/cTLHOKS0KSW7azyI2YUFg8i4anjDfTPHy9WEeg+A9HK
         4fXr0M+18TqDqFYl9vCh85kM9mghU/8vq59YBNGdlqh32ZzHHVmG9jX/ao1xVynR5t
         UGVZB5aBh4D7ixKln4eSl0mtBlq2BLPXQmg7t/neEFBbQB3u4T3apt3N+AcwNxH9V/
         IvFhd+Do3wfmFrewm8CCMpnAvx8Li4UW8jax7raXtzvgvweFJrevvhnNxpFjiss+lT
         MtM3XWvfkBjAVqZGHciXIdpVDBOnESFxwWZ5Qz1yOGDk4hd/4H2V2jupdmEIX5TEDu
         7WaKFb7cxeWTg==
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
Subject: [PATCH] ASoC: cs35l41: Steam Deck Shared boost properties quirk
Date:   Wed,  1 Mar 2023 10:31:13 +0000
Message-Id: <20230301103113.12612-1-lucas.tanure@collabora.com>
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
---
 sound/soc/codecs/cs35l41.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index c223d83e02cf..d5f9eee88cba 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1037,9 +1037,17 @@ static int cs35l41_handle_pdata(struct device *dev, struct cs35l41_hw_cfg *hw_cf
 	unsigned int val;
 	int ret;
 
-	ret = device_property_read_u32(dev, "cirrus,boost-type", &val);
-	if (ret >= 0)
-		hw_cfg->bst_type = val;
+	if (device_property_read_bool(dev, "cirrus,shared-boost-active")){
+		hw_cfg->bst_type = CS35L41_SHD_BOOST_ACTV;
+	}
+	else if (device_property_read_bool(dev, "cirrus,shared-boost-passive")) {
+		hw_cfg->bst_type = CS35L41_SHD_BOOST_PASS;
+	}
+	else {
+		ret = device_property_read_u32(dev, "cirrus,boost-type", &val);
+		if (ret >= 0)
+			hw_cfg->bst_type = val;
+	}
 
 	ret = device_property_read_u32(dev, "cirrus,boost-peak-milliamp", &val);
 	if (ret >= 0)
-- 
2.39.2

