Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BBB5B7F35
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 05:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiINDMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 23:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiINDMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:12:48 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09C36CF54
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 20:12:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w20so1718673ply.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 20:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Ru/J57bKYILUKFipBlhIw83PvGlUWh882vmvyBi7Ppo=;
        b=EhQ1a6FHsjcONdLKhZQEAPbglYOd4CBescJyriBTJj8+A53IqRootIFPtUUCL4oG1m
         hIvlZ9NsD0oGScx9MMY3Gy/aT1SoYC/MejdRBlCwb4Y9QXJ0YSyAqNbDaDYIAf5syb/q
         plNDPHp0gHeyJImSJ6ucv3gsORDOOHbe4BC7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Ru/J57bKYILUKFipBlhIw83PvGlUWh882vmvyBi7Ppo=;
        b=5V+yi61BfHkqlq7OeRIk/1oGXcQvLsiU7SH9emfK3iHtvyvZaGYmkZV6kUptK4SLQd
         eDXjEC1vMexWEH7AoSYtlsBX9ss/uWLPmvdwH7OZW4TpCIlcIR++GzF4RE/L2ithhoHy
         KRLe8bONMH63095/Di6wojqHlCDuM7/AhnYFHJsVlssFbQzMMnmUAuR9JIfPPFxuaYJD
         1RNVA+w+gdEfinqD2nQj2PU7XJCgVkPPEE8U6FTKAtkuY8Pv4isUqPKpwd0MNrQDK6P3
         M8B67x1ES/iahox0Ofn56BqTpy42yV32bnEWDVyzDgE2XI7o17qYEdF1oVELpfHTTDDh
         LBYg==
X-Gm-Message-State: ACgBeo0o9R+S3G0ZRdBddMcNtEb1OLFoaaunt8YgBPP2uNxUVUmnJyT1
        pfX99jfITmYuaZYiAa/P0p6pqg==
X-Google-Smtp-Source: AA6agR5GmHRqaTG/+yzg03cabUk4aN8uXhW1lkkDGgX7gqTXoYZvQtnNYufHIkIdthFpK0/3bwX+Aw==
X-Received: by 2002:a17:902:cccb:b0:178:2a5e:b6e7 with SMTP id z11-20020a170902cccb00b001782a5eb6e7mr14471471ple.49.1663125165490;
        Tue, 13 Sep 2022 20:12:45 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b0016dcbdf9492sm9236737plr.92.2022.09.13.20.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 20:12:44 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chen-Yu Tsai <wenst@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v2] ASoC: rockchip: i2s: use regmap_read_poll_timeout to poll I2S_CLR
Date:   Wed, 14 Sep 2022 03:12:34 +0000
Message-Id: <20220914031234.2250298-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regmap_read_poll_timeout to poll I2S_CLR.
It also fixes the 'rockchip-i2s ff070000.i2s; fail to clear' when
the read of I2S_CLR exceeds the retry limit.

Fixes: 0ff9f8b9f592 ("ASoC: rockchip: i2s: Fix error code when fail
to read I2S_CLR")
Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
---

changes in v2:
  - Remove unused variables.
  - Refine debug messages.

 sound/soc/rockchip/rockchip_i2s.c | 41 ++++++++++++-------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index f5f3540a9e18..28c86f5e435e 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -126,7 +126,6 @@ static inline struct rk_i2s_dev *to_info(struct snd_soc_dai *dai)
 static int rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 {
 	unsigned int val = 0;
-	int retry = 10;
 	int ret = 0;
 
 	spin_lock(&i2s->lock);
@@ -163,18 +162,14 @@ static int rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 						 I2S_CLR_TXC | I2S_CLR_RXC);
 			if (ret < 0)
 				goto end;
-			regmap_read(i2s->regmap, I2S_CLR, &val);
-
-			/* Should wait for clear operation to finish */
-			while (val) {
-				regmap_read(i2s->regmap, I2S_CLR, &val);
-				retry--;
-				if (!retry) {
-					dev_warn(i2s->dev, "fail to clear\n");
-					ret = -EBUSY;
-					break;
-				}
-			}
+			ret = regmap_read_poll_timeout(i2s->regmap,
+						       I2S_CLR,
+						       val,
+						       val != 0,
+						       20,
+						       200);
+			if (ret < 0)
+				dev_warn(i2s->dev, "fail to clear: %d\n", ret);
 		}
 	}
 end:
@@ -188,7 +183,6 @@ static int rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 static int rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 {
 	unsigned int val = 0;
-	int retry = 10;
 	int ret = 0;
 
 	spin_lock(&i2s->lock);
@@ -226,17 +220,14 @@ static int rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 						 I2S_CLR_TXC | I2S_CLR_RXC);
 			if (ret < 0)
 				goto end;
-			regmap_read(i2s->regmap, I2S_CLR, &val);
-			/* Should wait for clear operation to finish */
-			while (val) {
-				regmap_read(i2s->regmap, I2S_CLR, &val);
-				retry--;
-				if (!retry) {
-					dev_warn(i2s->dev, "fail to clear\n");
-					ret = -EBUSY;
-					break;
-				}
-			}
+			ret = regmap_read_poll_timeout(i2s->regmap,
+						       I2S_CLR,
+						       val,
+						       val != 0,
+						       20,
+						       200);
+			if (ret < 0)
+				dev_warn(i2s->dev, "fail to clear: %d\n", ret);
 		}
 	}
 end:
-- 
2.37.2.789.g6183377224-goog

