Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246EE7509DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjGLNoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjGLNoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:44:09 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB9B1BD5;
        Wed, 12 Jul 2023 06:44:06 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6686708c986so6339425b3a.0;
        Wed, 12 Jul 2023 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689169446; x=1691761446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9/dLQLgKmsLxbd3aGxhVA74ctHdZI0VI9d8S6+Rzsw=;
        b=mryBbePbwMBVx6XGrEXzXAOuHLh3UqdMw2WuA+6wIgGA/md7XMF35wZg3SodGqNqiL
         mGoA2T44pMO+KhpVvMgq+ThpLjCcQlA0RqJ3dnEoD7m8S4+LmshSNmGjBDFeWnnxJFWY
         UwRwq5/ZKqJ2H7b73YoB3fZKN35IEUNucCWhwe3FdzVI81TWEwWdBvTob7ztjYidCAYu
         lL/qSNW6pqCaV3HvhA9rB7nxLv/+MxwNqjld9rX5OVnMue2gNLAlvVqrRhEbXNZfExtJ
         RXR10sbFrRjfPDYh70iQt64CkjcVwo/sDmpvMxw+cS29hpSGNRhbs2VXvGex+fi/6Jrk
         wXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689169446; x=1691761446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9/dLQLgKmsLxbd3aGxhVA74ctHdZI0VI9d8S6+Rzsw=;
        b=kajPjiDx0pELERFhhr+N26lZEywbc1aGxA04Btu/wWgIDPIoEZnvWPEYkFZATZY1bS
         kRHDcItgnA11kH8uOdYhj2d2X/Ib0y+o/zyBufQplaPfKrUpZtlkuLR8mMVPiqeTEiaK
         I6vGbbWCMSxiYuPuZmpPXoc42DBCfmbLzWCWD2YoQ8g0eepXsA5rWsFh7nyQSGT4tNVD
         WiMwGuky/soacsUEvOhe+nmrtXqX5UaoACswzIbUAvl7wuWRqHVFILgxDS0iNvqUQ82n
         HCI/NCHHPwn8jdEYcPD4C4J5f7F5Tbj0yqNvBkZI7D63LMwLRlW5QO93bGnpM7G/1jK1
         m49g==
X-Gm-Message-State: ABy/qLalARzZxTkgRSP3IoWMOnnq13lsp/2hOuJhFxhuikl2TyDgZPY2
        9Txy6AvRg8XHehStAIF35/w=
X-Google-Smtp-Source: APBJJlFqHYLPdidDJKh9YQWr3Pa5Bs3cdRBuunViOZ2SQO2tSMkp40pycRZcxbqDjBdj+InFa7/FaA==
X-Received: by 2002:a05:6a00:b51:b0:668:8545:cbeb with SMTP id p17-20020a056a000b5100b006688545cbebmr26295423pfo.15.1689169445774;
        Wed, 12 Jul 2023 06:44:05 -0700 (PDT)
Received: from localhost.localdomain ([113.103.7.132])
        by smtp.gmail.com with ESMTPSA id c3-20020aa781c3000000b0067978a01246sm3775641pfn.14.2023.07.12.06.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 06:44:05 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     claudiu.beznea@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guiting Shen <aarongt.shen@gmail.com>
Subject: [PATCH v4] pwm: atmel: Enable clk when pwm already enabled in bootloader
Date:   Wed, 12 Jul 2023 21:43:47 +0800
Message-Id: <20230712134347.14897-1-aarongt.shen@gmail.com>
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

The driver would never call clk_enable() if the PWM channel was already
enabled in bootloader which lead to dump the warning message "the PWM
clock already disabled" when turning off the PWM channel.

Add atmel_pwm_enable_clk_if_on() in probe function to enable clock if
the PWM channel was already enabled in bootloader.

Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
---
 drivers/pwm/pwm-atmel.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index cdbc23649032..28ea0f7267ca 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -36,7 +36,7 @@
 #define PWM_SR			0x0C
 #define PWM_ISR			0x1C
 /* Bit field in SR */
-#define PWM_SR_ALL_CH_ON	0x0F
+#define PWM_SR_ALL_CH_MASK	0x0F
 
 /* The following register is PWM channel related registers */
 #define PWM_CH_REG_OFFSET	0x200
@@ -464,6 +464,37 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
 
+static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm)
+{
+	unsigned int i;
+	int err;
+	u32 sr;
+
+	sr = atmel_pwm_readl(atmel_pwm, PWM_SR);
+	if (!(sr & PWM_SR_ALL_CH_MASK))
+		return 0;
+
+	for (i = 0; i < atmel_pwm->chip.npwm; i++) {
+		if (!(sr & (1 << i)))
+			continue;
+
+		err = clk_enable(atmel_pwm->clk);
+		if (err) {
+			dev_err(atmel_pwm->chip.dev,
+				"failed to enable clock for pwm #%d: %pe\n",
+							i, ERR_PTR(err));
+
+			while (i--) {
+				if (sr & (1 << i))
+					clk_disable(atmel_pwm->clk);
+			}
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 static int atmel_pwm_probe(struct platform_device *pdev)
 {
 	struct atmel_pwm_chip *atmel_pwm;
@@ -504,8 +535,15 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, atmel_pwm);
 
+	ret = atmel_pwm_enable_clk_if_on(atmel_pwm);
+	if (ret < 0)
+		goto remove_pwmchip;
+
 	return ret;
 
+remove_pwmchip:
+	pwmchip_remove(&atmel_pwm->chip);
+
 unprepare_clk:
 	clk_unprepare(atmel_pwm->clk);
 	return ret;
-- 
2.25.1

