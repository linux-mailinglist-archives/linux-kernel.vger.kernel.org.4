Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346146CBB7D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjC1Jue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjC1JuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:50:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A2B6A62
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:49:08 -0700 (PDT)
Received: from localhost (unknown [188.24.133.76])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 099B9660313B;
        Tue, 28 Mar 2023 10:49:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679996946;
        bh=tvwdoB9D+B+grzUkDaRMsZodsfqatGfdvkJIH90Q3x0=;
        h=From:To:Cc:Subject:Date:From;
        b=VcXeONKxGtgjVV1ohFWVXUPTtzQgKtyRCQY0iyS/y2g3wxS7Xj08zPk+gUfPV/jPw
         2VzpE4j2GzbRQJeC/NjxDebmBf/mEhiazT6g22hKAJbK3kavZ3/uuX3QToEHV0pP5p
         hfpg+oY0mlsJsSsmulZZM12RPD7KzAp//VkXiV77GJ3Q92131OvaANhPHvdOVJHqdz
         4aXWsjKVE3tWI3gOPeRPqZ2H+i1hlh1S0ueHfZoJBp0cFt6ei69MyUgzCON28NhPlI
         2LlxjGvZ/wUW6yGkqwpQ602BXSDzIF3YZrDEeTL08RSO/UgSvLriZ3cBf8LtTd9jIU
         zVovuvuPORC6A==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH] ASoC: es8316: Handle optional IRQ assignment
Date:   Tue, 28 Mar 2023 12:49:01 +0300
Message-Id: <20230328094901.50763-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is able to work fine without relying on a mandatory interrupt
being assigned to the I2C device. This is only needed when making use of
the jack-detect support.

However, the following warning message is always emitted when there is
no such interrupt available:

  es8316 0-0011: Failed to get IRQ 0: -22

Do not attempt to request an IRQ if it is not available/valid. This also
ensures the rather misleading message is not displayed anymore.

Also note the IRQ validation relies on commit dab472eb931bc291 ("i2c /
ACPI: Use 0 to indicate that device does not have interrupt assigned").

Fixes: 822257661031 ("ASoC: es8316: Add jack-detect support")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/codecs/es8316.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 056c3082fe02..f7d7a9c91e04 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -842,12 +842,14 @@ static int es8316_i2c_probe(struct i2c_client *i2c_client)
 	es8316->irq = i2c_client->irq;
 	mutex_init(&es8316->lock);
 
-	ret = devm_request_threaded_irq(dev, es8316->irq, NULL, es8316_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_AUTOEN,
-					"es8316", es8316);
-	if (ret) {
-		dev_warn(dev, "Failed to get IRQ %d: %d\n", es8316->irq, ret);
-		es8316->irq = -ENXIO;
+	if (es8316->irq > 0) {
+		ret = devm_request_threaded_irq(dev, es8316->irq, NULL, es8316_irq,
+						IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_AUTOEN,
+						"es8316", es8316);
+		if (ret) {
+			dev_warn(dev, "Failed to get IRQ %d: %d\n", es8316->irq, ret);
+			es8316->irq = -ENXIO;
+		}
 	}
 
 	return devm_snd_soc_register_component(&i2c_client->dev,
-- 
2.40.0

