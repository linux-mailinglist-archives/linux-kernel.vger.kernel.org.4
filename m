Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E73F74D93C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjGJOnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjGJOm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:42:59 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1462E18B;
        Mon, 10 Jul 2023 07:42:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-668730696a4so2331468b3a.1;
        Mon, 10 Jul 2023 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689000173; x=1691592173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jx0rTJY91xvaQO/TKwPm2MfB02bi+/9KtpDn9uAHcho=;
        b=BaX/TdJNkMOeu71/s1YnZl7NwNOjCRvo/4yDAbgbPpEqviYNVfvMk6VuLHEC4EuFjB
         SJw9EVS4/0cLperDC3szvFsoapqJuJLBUi1TKwyvummRI5t7m3tXizVHwwP8+bedr9mx
         Jvm+dgvw52gegqiDU8TUF2p0f2VWzy9bqefYnxHUMNkuW1vV5oOTKFsb6x9Mm1HVXH2J
         DfStSFh/OdJbAsZQGFqLZYwq0+55wnwy6UXvra6Pbel5Fljub/LosbTJ9agvGuKWX/l8
         bsVvSMxUjKPtAHYLZ9ngawpJN+ZIQnhy0fpxYelJskX5Sy3yizFLAgPZS7CWHlpgmptU
         q6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689000173; x=1691592173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jx0rTJY91xvaQO/TKwPm2MfB02bi+/9KtpDn9uAHcho=;
        b=d7x/O8a7SO5OiVV5BuYf8fEqQ4EVzebF6FK2x1HbQgWJCsJXUAgm49WvO7hRlwudzN
         USTFgkWirpdvVpEbK2hwYkavxus83XVTQhZApwNebCGvpJrLSyWtJ+780P1YUWl9pm0t
         TXrLtHdqf4tRu4qK11bq6Z0RpE5WB9vlxxwVf6KdAucariPXUY9nDi4DxzRnYdyGm5AR
         zOtEITK4B2yDXgvG7pAvniUfHd0egT5MHHpnrsYeU75BHgXzHe7UvWL+R7MRcNO5UHPk
         v0smn4lE0E7J0hTdutDRYHsXZofg+GG96qC8pOki4ykeHl5LUkXnoQTWybN53RwjCoSS
         oSTw==
X-Gm-Message-State: ABy/qLZsDq5l/oaTHtC2JLOPaDVQbG7ay9DaJuR8YmnEsgRtNetgXIDR
        csc2T3DZbWi+yQeTiaPkws4=
X-Google-Smtp-Source: APBJJlG4ILjGGQTzQYCI6CAHyAwtuAbhfIFLmm3ZoCnt2osr6fteqliUBcyIAYRfWTW3HZoYDOJtig==
X-Received: by 2002:a05:6a20:186:b0:131:f504:a631 with SMTP id 6-20020a056a20018600b00131f504a631mr776129pzy.51.1689000173423;
        Mon, 10 Jul 2023 07:42:53 -0700 (PDT)
Received: from localhost.localdomain ([113.66.181.235])
        by smtp.gmail.com with ESMTPSA id jh5-20020a170903328500b001b53be3d942sm8415122plb.232.2023.07.10.07.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 07:42:53 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     claudiu.beznea@microchip.com
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guiting Shen <aarongt.shen@gmail.com>
Subject: [PATCH] pwm: atmel: enable clk when pwm already enabled in bootloader
Date:   Mon, 10 Jul 2023 22:42:14 +0800
Message-Id: <20230710144214.63343-1-aarongt.shen@gmail.com>
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

The driver would never call clk_eanble() if the pwm channel already
enable in bootloader which lead to dump the warning message of "the pwm
clk already disabled" when poweroff the pwm channel.

Add atmel_pwm_enanle_clk_if_on() in probe function to enable clk if the
pwm channel already enabled in bootloader.

Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
---
 drivers/pwm/pwm-atmel.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index cdbc23649032..385f12eb604c 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -464,6 +464,29 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
 
+static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm)
+{
+	u32 sr, i;
+	int err;
+
+	sr = atmel_pwm_readl(atmel_pwm, PWM_SR);
+	if (!sr)
+		return 0;
+
+	for (i = 0; i < atmel_pwm->chip.npwm; i++) {
+		if (!(sr & (1 << i)))
+			continue;
+
+		err = clk_enable(atmel_pwm->clk);
+		if (err) {
+			dev_err(atmel_pwm->chip.dev, "enable clock error\n");
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
@@ -504,6 +527,10 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, atmel_pwm);
 
+	ret = atmel_pwm_enable_clk_if_on(atmel_pwm);
+	if (ret < 0)
+		goto unprepare_clk;
+
 	return ret;
 
 unprepare_clk:
-- 
2.25.1

