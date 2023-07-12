Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D53750BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjGLPM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjGLPM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:12:27 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8681BD1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:12:26 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8ad907ba4so37108765ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689174746; x=1691766746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECiLeGJkNprLw+g0X3L1cAWQ/zU6I6t8+jDfAyzLBrU=;
        b=RIGQGajl4x6HG/JpHEe5LWkWl3o6uSi4Cjg3mnn+4o9OXlDmdtt2UqZzyDHc+xAdT4
         oQNrjXrGz2nMqkeH2CaT4iSnqTWd8KrEjetpDXUq757pdI1PKkChxJs21v3IvoWL3kIc
         MrDVlIST/yShOiyGSgJSotztHQWCPuddqhasHwpsnUrZEfp+8C3s+wasATRGtRN4Rq7B
         0Y2wnQ9qirTjN8v0GspYswf7TvHxggmPmFIWPxqijq1ha+BFK/rxa7iKtCV61YBhY3tu
         gFfWei7//QnJuS1grZSJrRTq1XxG9QWjgqYV1tNDq4QTgW1BPPONZY1KW4nTR9HfpetI
         5kRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689174746; x=1691766746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECiLeGJkNprLw+g0X3L1cAWQ/zU6I6t8+jDfAyzLBrU=;
        b=YfmkZE/h2lLvpANyQ0tKr4TiuVwnmX5yv5CXQHeCK609hmvwPQrPgBEzW76PhWxWEi
         BjJfAcin7HYylJpb85r/+ivptaamgt4F45M5PRq9n/+AMdLkFxJC42x9tbauiini/6cY
         t6ZXW/EEgBuQMEBRjkpOoEEvRqqoCqIbrbeKs8cC0s4yHHagetBSIjJoTAo6cy1/Hzg/
         bq9i2SyjqOz5yftRBTvAVKDZwlbalDW1rMD4oaRYthWEzcmTGEzaa+cfLGCcsjF81xZc
         irM7BnfjF6rd5f+iqkVW0wt6lL8iODOxuSxqy2znkrbOT32kPP5EWDZuuxZP+AmthgYO
         Q4bQ==
X-Gm-Message-State: ABy/qLa5heC1GZ9Ow0G5mmAE5G3ax8lmnLjqVBXGh0vaiU20G3jtliWt
        CqsrGXFms89NoIGkJNHEwsk=
X-Google-Smtp-Source: APBJJlEz3x4C9lBqp+zKUm5wncQq7Aa5uekWuoz+qkfaXGKTS3GMvF34BoJ/i79KeHAkK42zScjy7g==
X-Received: by 2002:a17:902:c246:b0:1b6:ba60:77f0 with SMTP id 6-20020a170902c24600b001b6ba6077f0mr15260373plg.10.1689174745620;
        Wed, 12 Jul 2023 08:12:25 -0700 (PDT)
Received: from localhost.localdomain ([113.103.7.132])
        by smtp.gmail.com with ESMTPSA id g22-20020a170902869600b001b9cea4e8a2sm4064711plo.293.2023.07.12.08.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:12:25 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        sboyd@kernel.org, mripard@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Guiting Shen <aarongt.shen@gmail.com>
Subject: [PATCH] ASoC: tlv320aic32x4: Fix the divide by zero
Date:   Wed, 12 Jul 2023 23:11:58 +0800
Message-Id: <20230712151158.20378-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of register(NDAC,MDAC,NADC,MADC,BCLKN) maybe zero lead to
divide by zero in clk_aic32x4_div_recalc_rate().And the rate should be
divide by 128 if the value was zero in this function according to the
datasheet.
Add the macro AIC32X4_DIV_MAX to present the 128 and return 0 if failing
to read the value of register.

Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 16 +++++++++++-----
 sound/soc/codecs/tlv320aic32x4.h     |  5 +++--
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index c116e82f712d..5c0a76a4a106 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -321,7 +321,7 @@ static int clk_aic32x4_div_set_rate(struct clk_hw *hw, unsigned long rate,
 	u8 divisor;
 
 	divisor = DIV_ROUND_UP(parent_rate, rate);
-	if (divisor > 128)
+	if (divisor > AIC32X4_DIV_MAX)
 		return -EINVAL;
 
 	return regmap_update_bits(div->regmap, div->reg,
@@ -334,7 +334,7 @@ static int clk_aic32x4_div_determine_rate(struct clk_hw *hw,
 	unsigned long divisor;
 
 	divisor = DIV_ROUND_UP(req->best_parent_rate, req->rate);
-	if (divisor > 128)
+	if (divisor > AIC32X4_DIV_MAX)
 		return -EINVAL;
 
 	req->rate = DIV_ROUND_UP(req->best_parent_rate, divisor);
@@ -345,12 +345,18 @@ static unsigned long clk_aic32x4_div_recalc_rate(struct clk_hw *hw,
 						unsigned long parent_rate)
 {
 	struct clk_aic32x4 *div = to_clk_aic32x4(hw);
-
 	unsigned int val;
+	int err;
+
+	err = regmap_read(div->regmap, div->reg, &val);
+	if (err)
+		return 0;
 
-	regmap_read(div->regmap, div->reg, &val);
+	val &= AIC32X4_DIV_MASK;
+	if (!val)
+		val = AIC32X4_DIV_MAX;
 
-	return DIV_ROUND_UP(parent_rate, val & AIC32X4_DIV_MASK);
+	return DIV_ROUND_UP(parent_rate, val);
 }
 
 static const struct clk_ops aic32x4_div_ops = {
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index 4de5bd9e8cc5..d6101ce73f80 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -223,8 +223,9 @@ int aic32x4_register_clocks(struct device *dev, const char *mclk_name);
 #define AIC32X4_REFPOWERUP_120MS	0x07
 
 /* Common mask and enable for all of the dividers */
-#define AIC32X4_DIVEN           BIT(7)
-#define AIC32X4_DIV_MASK        GENMASK(6, 0)
+#define AIC32X4_DIVEN			BIT(7)
+#define AIC32X4_DIV_MASK		GENMASK(6, 0)
+#define AIC32X4_DIV_MAX			128
 
 /* Clock Limits */
 #define AIC32X4_MAX_DOSR_FREQ		6200000
-- 
2.25.1

