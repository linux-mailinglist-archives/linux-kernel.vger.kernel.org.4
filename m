Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6BC65B793
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 23:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjABWSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 17:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjABWSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 17:18:32 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C150E95AB;
        Mon,  2 Jan 2023 14:18:30 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bk16so14354033wrb.11;
        Mon, 02 Jan 2023 14:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCEtTHiR9P25/MahGBhdYLRuSe7FIhD6edeJkbM8vCk=;
        b=YqEIRGFcf2s2llJhfFfahgwrHH1990lEdX6TaPnFol9D6H9zwGWYQddAG+TS9/BHib
         0DjJ4rwCQrLjoii0jED2rK+ova8L/Ufo95wgZnrDUcflZP5hmeuwCDpjDaEjYKoAiRLE
         PdG950kADq1yZZTTQg8iSgJJg1cQTjcsD93KkG0a6Scx/uZqzCSjV/RNoAX/Br0suVoF
         FIpiak6U9cHL97ky14eBH/igEzwyt3JXKHJBFrZEvWYMNvFTciQu8w3QHHTUK81a0SRF
         KFT2zPH44t8ZzGIU4ZssUcVj4YEiiEoMqwTetROfD0xb2zUr8wx5JQUsEf44ktv88DPE
         0+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCEtTHiR9P25/MahGBhdYLRuSe7FIhD6edeJkbM8vCk=;
        b=VdDs8uTz6FXdjIykTMoQdCpeTHtLaUg4ENycmbNDXn/LjuIVb11is8FY5abgzc1u+a
         t6AcVZzmJMpe31tmiSeO/kPsHStEzy2li4VneargCt5TivLazQffdLShDa+5O9LCgozy
         FA1cVhO8iq8XwzkSdWBCLFchTfDVpiINhgBn1fYm7gRO8GbAVYLokK377+/M27cwAtWX
         VFpPMkpVqwiJ5KrLA32zRn7/UeApNziBkyyJ+RXVZ2Mk/F3xjb8hCgnbbUH+ty5nZx7O
         lrjD6uHzCEjvInBSS2U+bkQaUi02QWaYveubcC9721yHlS9E9quhXEeG1Qc1edIJr0v0
         m4Ig==
X-Gm-Message-State: AFqh2kp1zqqlMF2GS4xVX8n5mqQvzKZiq6CPve0aT5ZWLhBP6jaflmbW
        x6CCvwfQ/slCBtIYkNVfAT4=
X-Google-Smtp-Source: AMrXdXt/pm8wOQbm2+iT2ucpjvtK4gdYjTXztTckgkxYOwBwdRAngIa+Xe9M09uZ66YKs2k614PXVg==
X-Received: by 2002:a5d:6e08:0:b0:236:84b5:6658 with SMTP id h8-20020a5d6e08000000b0023684b56658mr26519706wrz.64.1672697908889;
        Mon, 02 Jan 2023 14:18:28 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:8a7:e535:b020:566a])
        by smtp.gmail.com with ESMTPSA id n14-20020adfe34e000000b002366dd0e030sm29872463wrj.68.2023.01.02.14.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 14:18:28 -0800 (PST)
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
Subject: [PATCH v3 3/6] pinctrl: renesas: rzg2l: Add BUILD_BUG_ON() checks
Date:   Mon,  2 Jan 2023 22:18:12 +0000
Message-Id: <20230102221815.273719-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230102221815.273719-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v2 -> v3
* No change

v1 -> v2
* New patch
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 6f762097557a..04b31f0c6b34 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1468,6 +1468,12 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
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
@@ -1531,7 +1537,7 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
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

