Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB5264D8B0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiLOJgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiLOJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:36:37 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2BB2981A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:36:36 -0800 (PST)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E21F98546A;
        Thu, 15 Dec 2022 10:36:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671096994;
        bh=vUFV5R8bOhefsqOpqWAdoI5RFb/9UxmbNJq1tx/Av7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRrPSD+QLVUK3bepqgOCbe1axpXNykKURsTidZFGb2i2YHXhFlYKXkVB3df1TllF9
         cee8OuERe/R8yjf67/nDbOdl+ZV57tykGA3vsSCscbzk+BLAdQtOGyIPCeuZydFMKt
         uTzrY2xSzlRoQMb5MuCE/gyvmv+v7MO4W0DPJA2CKRof26JAhrEryHfcWaVJYLvaKT
         D5O6ursxmW1VLyAiInpTi+Mv7mEO+WRkWWAe8rbLj7g8CcXK6yRzXZods/jwRbUmxm
         IywzQZWnSkAXjsYV/GH8Vtudl/SAR5G0P6q1bJyIgSMWs7+ZeHje1F9V4lA1DohMkx
         X/t6BZBh0oErg==
From:   Lukasz Majewski <lukma@denx.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Stephen Kitt <steve@sk2.org>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 3/3] ASoC: wm8940: Read chip ID when wm8940 codec probing
Date:   Thu, 15 Dec 2022 10:36:15 +0100
Message-Id: <20221215093615.3794156-3-lukma@denx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221215093615.3794156-1-lukma@denx.de>
References: <20221214123743.3713843-1-lukma@denx.de>
 <20221215093615.3794156-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wm8940 provides the chip ID information via I2C. In this
patch this information is read and if not matching expected
value, the probe function is aborted.

This prevents from using (i.e. inserting) other wm89* modules
which use the same I2C bus address.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
Changes for v2:
- None
---
 sound/soc/codecs/wm8940.c | 11 +++++++++++
 sound/soc/codecs/wm8940.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 1b02d5e8a007..8eb4782c9232 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -760,6 +760,17 @@ static int wm8940_probe(struct snd_soc_component *component)
 	int ret;
 	u16 reg;
 
+	/*
+	 * Check chip ID for wm8940 - value of 0x00 offset
+	 * SOFTWARE_RESET on write
+	 * CHIP_ID on read
+	 */
+	reg = snd_soc_component_read(component, WM8940_SOFTRESET);
+	if (reg != WM8940_CHIP_ID) {
+		dev_err(component->dev, "Wrong wm8940 chip ID: 0x%x\n", reg);
+		return -ENODEV;
+	}
+
 	ret = wm8940_reset(component);
 	if (ret < 0) {
 		dev_err(component->dev, "Failed to issue reset\n");
diff --git a/sound/soc/codecs/wm8940.h b/sound/soc/codecs/wm8940.h
index 0d4f53ada2e6..86bbf902ef5a 100644
--- a/sound/soc/codecs/wm8940.h
+++ b/sound/soc/codecs/wm8940.h
@@ -95,5 +95,8 @@ struct wm8940_setup_data {
 #define WM8940_OPCLKDIV_3 2
 #define WM8940_OPCLKDIV_4 3
 
+/* Chip ID */
+#define WM8940_CHIP_ID 0x8940
+
 #endif /* _WM8940_H */
 
-- 
2.20.1

