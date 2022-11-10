Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B5E624A53
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiKJTIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiKJTHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:07:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A1B52888
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:06:22 -0800 (PST)
Received: from Falcon9.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C6DDB6602A34;
        Thu, 10 Nov 2022 19:06:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668107181;
        bh=AWn2hMQjAaWJ1yIP6Ub6bVX80rgEocaexixG2fBvbEc=;
        h=From:To:Cc:Subject:Date:From;
        b=J7jstCegJdnMChsGzYEVIeUtXBat6bnIgQ1Be2G+DXquqZv3j1330qoVfyE485Y2p
         reDS3oHVjfsqMtFOPaynMp3hqvzGp8zVX2rgJFkW7xq5b+Cr+4vL1YSAYS3se1lCvj
         b3lUyhIpTDwAs6ujL4jz1P+pzWbUX1qlq792H3OnvrGLyi6SoSQGmoF5r1v5wVz3Yl
         5j08klmvrfq+adYP7HNXXeSrIUaB0i/eGsjB034BLvzgehdOO34/7plHOX2gkmWdAA
         Okk53+12zgevZI5L+y7wXFYPpI8hGWfUTtoGqxnT+fT2pSgWkr4rMa0vg0iIb7QgxU
         9F2Xt3KDN2/bw==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org (moderated list:NXP SGTL5000 DRIVER),
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH] ASoC: sgtl5000: Reset the CHIP_CLK_CTRL reg on remove
Date:   Thu, 10 Nov 2022 14:06:12 -0500
Message-Id: <20221110190612.1341469-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.38.1
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

Since commit bf2aebccddef ("ASoC: sgtl5000: Fix noise on shutdown/remove"),
the device power control registers are reset when the driver is
removed/shutdown.

This is an issue when the device is configured to use the PLL clock. The
device will stop responding if it is still configured to use the PLL
clock but the PLL clock is powered down.

When rebooting linux, the probe function will show:
sgtl5000 0-000a: Error reading chip id -11

Make sure that the CHIP_CLK_CTRL is reset to its default value before
powering down the device.

Fixes: bf2aebccddef ("ASoC: sgtl5000: Fix noise on shutdown/remove")
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 sound/soc/codecs/sgtl5000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 4b2135eba74d..a916f4619ea3 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1794,6 +1794,7 @@ static void sgtl5000_i2c_remove(struct i2c_client *client)
 {
 	struct sgtl5000_priv *sgtl5000 = i2c_get_clientdata(client);
 
+	regmap_write(sgtl5000->regmap, SGTL5000_CHIP_CLK_CTRL, SGTL5000_CHIP_CLK_CTRL_DEFAULT);
 	regmap_write(sgtl5000->regmap, SGTL5000_CHIP_DIG_POWER, SGTL5000_DIG_POWER_DEFAULT);
 	regmap_write(sgtl5000->regmap, SGTL5000_CHIP_ANA_POWER, SGTL5000_ANA_POWER_DEFAULT);
 
-- 
2.38.1

