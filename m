Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC885652A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiLUADg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbiLUADF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:03:05 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B8E201A3;
        Tue, 20 Dec 2022 16:03:04 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id f18so13444145wrj.5;
        Tue, 20 Dec 2022 16:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DAEA+OzMJ+y7qc8/f9pAlMJNduPlcJJtkAkWJtqKPk=;
        b=DfbUR+JAV41BAWSaslMgK9Rn22HISYIj37yvBSG9dbwFjAUME/dz76yfsip7P4kUXh
         3uozgCxFJ1SbUKVFXez9pd0Gn+/ZJo8MZ+pCAA2vg55MYAqqwNHg9I+GP0WZKoh4MWvY
         w2g4maCwg0g3GGGvXml4rf1WGRoaWA38Js2tFax+rGJAC/UK2P2NEOwSpje2qTarYdWA
         tQ4aTr5MUYbvsfm1T2Z6b0DPrjL90Gc76yKfgn8yk/H9j2fgfAr5Q09ONOuLDui1TyHN
         Wdc+Euh8rXLYzwGg1/OviHP425iut421IetER6yjB890xt4HrSHzWDUw+vNikXpcUYSX
         29GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DAEA+OzMJ+y7qc8/f9pAlMJNduPlcJJtkAkWJtqKPk=;
        b=MKbjWzek9ZlXG4UbfVC9HZRy3OTXvgI00/PDS9okw+MKPBwl4eswktRJAr0X8KI6VU
         eVdoEb+NyUoiekDVdSISqWOiO1rpaRxtY8D+PiEGOn9O/cJj/qYIl/l4PF2RuIszUdEz
         iCaxkj4wxb8VKiOjNc2TwF3yYjzH162qq+C8ZATUkmqRoD5YjPM4hA5oX/tWleD5peD0
         Aqd5h+KLS26Ixu5unmr7f45itYESgUv4K1sTjt78+c94IbCZ+5XTs1q4ipSMxrbRrp3l
         tTMBeh1KuvScOQB8lIBS6ZVDfI3lK92zWKQastYGTft8J0aE3cJLLV54LUeVKodFEHRT
         lL/g==
X-Gm-Message-State: ANoB5plBOXfGEnXoZJtIkOG9Jtb26Gza/GeNVEhjgwO3H6H/Z6RqOuUw
        7EVYHur1EPpdQtJoY/C2/H0=
X-Google-Smtp-Source: AA0mqf6nxxoU7wNuTvAZZ4NmZQscwDQzJEpk+yZ0Zxo++wi+rRc/4uRs5QVSLLPeZ8OT8C75I9uP+A==
X-Received: by 2002:a05:6000:1e1d:b0:242:15d5:2c0b with SMTP id bj29-20020a0560001e1d00b0024215d52c0bmr29936252wrb.22.1671580983240;
        Tue, 20 Dec 2022 16:03:03 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:1595:a48c:95a8:15e0])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b002362f6fcaf5sm13740150wrt.48.2022.12.20.16.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 16:03:02 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 6/9] pinctrl: renesas: rzg2l: Add BUILD_BUG_ON() checks
Date:   Wed, 21 Dec 2022 00:02:39 +0000
Message-Id: <20221221000242.340202-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221221000242.340202-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add BUILD_BUG_ON() checks to avoid overflows for GPIO configs for each
supported SoC.

While at it, for readability set n_port_pins based on the GPIO pin configs
and not on GPIO names for r9a07g044_data as done for r9a07g043_data.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1 -> v2
* New patch
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 03e9462f39b1..8036485f2e92 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1465,6 +1465,12 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	struct rzg2l_pinctrl *pctrl;
 	int ret;
 
+	BUILD_BUG_ON(ARRAY_SIZE(rzg2l_gpio_configs) * RZG2L_PINS_PER_PORT >
+		     ARRAY_SIZE(rzg2l_gpio_names));
+
+	BUILD_BUG_ON(ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT >
+		     ARRAY_SIZE(rzg2l_gpio_names));
+
 	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
 	if (!pctrl)
 		return -ENOMEM;
@@ -1528,7 +1534,7 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.port_pin_configs = rzg2l_gpio_configs,
 	.n_ports = ARRAY_SIZE(rzg2l_gpio_configs),
 	.dedicated_pins = rzg2l_dedicated_pins.common,
-	.n_port_pins = ARRAY_SIZE(rzg2l_gpio_names),
+	.n_port_pins = ARRAY_SIZE(rzg2l_gpio_configs) * RZG2L_PINS_PER_PORT,
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common) +
 		ARRAY_SIZE(rzg2l_dedicated_pins.rzg2l_pins),
 };
-- 
2.25.1

