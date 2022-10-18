Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE5C602FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiJRPaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiJRP3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:29:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AC6DFE3;
        Tue, 18 Oct 2022 08:29:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bp11so24124201wrb.9;
        Tue, 18 Oct 2022 08:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OcUgEYWsogjtXYmjJAjt9KOoJyA65cec5okYPWW3wOI=;
        b=EIqT9tBypYZiETkmd/KQhtgcdgf36aQXJriK/p4+mskN6WYba67CXLYKnXPkn7qaiW
         wZWEe6qt5/H/NfL0eTY6FEHeq8g06oTKMpehMKMkUHBrm/YTOkA1xmofn2wyR5nWkjv2
         hzhlmYqYOcHKM5+QxiVgGzjo/cdQUVv53geXwRgJTpxE4r7nwggD4pdzB5EM3G+7DkvA
         oqT3sUGzfdkonHCWtZ+DuH5cFCFGxMsfBrq167jelkmbEvrD16dXTQvtj//LtfcW3lVu
         foeJoeB7s9mGxfXO1FxOPGoT2ElhRfUae0le/PIihAZZnYXnpVzaSaM0ffDtnRuujYJ3
         63JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OcUgEYWsogjtXYmjJAjt9KOoJyA65cec5okYPWW3wOI=;
        b=RZKwaJn4L/9V3nuKT0nMsoy5ydSI/TT4ldvglGAdmqCqeIRpyyXUu4Mvmddpodd6wl
         DxOmB/ElRk/59lC8NI3Oo6ZVtJMtxP/5QD9Xc6SFzHCqMbcOZE9+DpGv5gfnX4C7/Pt7
         CY5OOrwaH3LPKkAkp/1cES+GQELVRgmiOrDlZNMSfTZjDHNzitMsoFSoHxXSyyn4BChh
         knJgfJRArMiba8xfFNvXvfw5EiwOoCLFNAKrOEyuqTKGjSfrZPv2doE2k68QGNP4m+u2
         cRZkS0FrkToSOuZaoNSu/cXxgECCLfohbCewmcI/QFihB7bdDCmEs1y2kKRKOOB2awin
         aHqA==
X-Gm-Message-State: ACrzQf1n9nK4laPBJdUXnggt6SDO5altgAQmqSWAoRPO3JdwsQKJ/mbi
        Q26I3x/xvhMM9EKptJAL6PA=
X-Google-Smtp-Source: AMsMyM7io7Q5lPf+K/noqHzklRH19otd294uVn3Z0/nAt187zLdS6NOS9BxV2da82p3UsfzvVP54ZQ==
X-Received: by 2002:a5d:5a11:0:b0:22e:3ed1:e426 with SMTP id bq17-20020a5d5a11000000b0022e3ed1e426mr2254890wrb.642.1666106969765;
        Tue, 18 Oct 2022 08:29:29 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id x6-20020a5d54c6000000b0022e2c38f8basm11194074wrv.14.2022.10.18.08.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:29:29 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: twl4030: make read-only array ramp_base static const
Date:   Tue, 18 Oct 2022 16:29:28 +0100
Message-Id: <20221018152928.942186-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only array ramp_base on the stack but
instead make it static const. Also makes the object code a
little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/twl4030.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index e48768233e20..9c50ac356c89 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -700,8 +700,10 @@ static void headset_ramp(struct snd_soc_component *component, int ramp)
 	struct twl4030_priv *twl4030 = snd_soc_component_get_drvdata(component);
 	struct twl4030_board_params *board_params = twl4030->board_params;
 	/* Base values for ramp delay calculation: 2^19 - 2^26 */
-	unsigned int ramp_base[] = {524288, 1048576, 2097152, 4194304,
-				    8388608, 16777216, 33554432, 67108864};
+	static const unsigned int ramp_base[] = {
+		524288, 1048576, 2097152, 4194304,
+		8388608, 16777216, 33554432, 67108864
+	};
 	unsigned int delay;
 
 	hs_gain = twl4030_read(component, TWL4030_REG_HS_GAIN_SET);
-- 
2.37.3

