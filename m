Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9038C6ADF24
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCGMvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCGMvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:51:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB027E785;
        Tue,  7 Mar 2023 04:51:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5DEF6134E;
        Tue,  7 Mar 2023 12:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FA6C433D2;
        Tue,  7 Mar 2023 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678193504;
        bh=u6uEwsBCL6nGQbSlMqbnHQ+iJaISGHA0T5I3s7tvcwE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=g3lXajyBdXJOqhAyX7z7yVHNS+GdnsiTEzuB9X9yKvEUQfwUeaO64ryFfrTKnYEIp
         OmcBnyxy3Gx9D232f8Mt9FI7sscOP/mV6wMpDUMpVTJsKcz6dHXTXQ+ceAFB5VEXaG
         Bsodoo9BQhKGMZuxdjIzxbKKvrdHZPn5NNdR3ezf0GhJdMJ0wKYQbs97GlJ6c6wWN+
         3bQ4YkezFu+xYEb5a90ta74ESZBbykW92OGTczOGpcnfIZ9kELKGxPiiCinV4HPI8V
         Lmj9+/cDMqocfuxZ6ZKEdy0iJ+8gbloNioNnMwsC/xlLHUzbUdZ/GuENfPWDF7pcyI
         dGRVLnZ75IdnA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 07 Mar 2023 12:51:28 +0000
Subject: [PATCH v2 2/2] pinctrl: at91: Remove pioc_index from struct
 at91_gpio_chip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230216-gpio-at91-immutable-v2-2-326ef362dbc7@kernel.org>
References: <20230216-gpio-at91-immutable-v2-0-326ef362dbc7@kernel.org>
In-Reply-To: <20230216-gpio-at91-immutable-v2-0-326ef362dbc7@kernel.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320; i=broonie@kernel.org;
 h=from:subject:message-id; bh=u6uEwsBCL6nGQbSlMqbnHQ+iJaISGHA0T5I3s7tvcwE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkBzNZSviMNzbuOXjTW1WneZjdKuzkbhnyyUx0YLGo
 1R8WoSuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZAczWQAKCRAk1otyXVSH0IE8B/
 9ru71XlErQlFhf6ZFw2hStyrDioUse0B2y+vjnA3FN64GrhigEY1KJmmEceQAeL3xY66aw90RE4YuY
 d9GC3LzGIms4LvvDIqLJNtCM/BnUeC0KyYnm+S0Qc/L0tvLKOdyTu1goYmMSJKJ3LQWb6EMGNXASAa
 2jRjzcPY4hLtSTzoF/sUA1XyQO3+snbO+y++u0AYjgcZAUhsYMtHTnxsCF1nJcdqzPQciHEgZdalae
 JATQSNDzsA6nxlRuYm0S/LeN97Ry0Hgtfd/EMNufZ3QLFtIlIivxnksNvi+wpjezXyGH9ALhfXJT2d
 Ki5xAm5Gj6G4XMyjEzKxD/3p28bG+N
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pioc_idx member of struct at91_gpio_chip is write only, just remove it.

Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/pinctrl/pinctrl-at91.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 1e083fc7666b..871209c24153 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -42,7 +42,6 @@ struct at91_pinctrl_mux_ops;
  * @next: bank sharing same clock
  * @pioc_hwirq: PIO bank interrupt identifier on AIC
  * @pioc_virq: PIO bank Linux virtual interrupt
- * @pioc_idx: PIO bank index
  * @regbase: PIO bank virtual address
  * @clock: associated clock
  * @ops: at91 pinctrl mux ops
@@ -56,7 +55,6 @@ struct at91_gpio_chip {
 	struct at91_gpio_chip	*next;
 	int			pioc_hwirq;
 	int			pioc_virq;
-	int			pioc_idx;
 	void __iomem		*regbase;
 	struct clk		*clock;
 	const struct at91_pinctrl_mux_ops *ops;
@@ -1849,7 +1847,6 @@ static int at91_gpio_probe(struct platform_device *pdev)
 
 	at91_chip->ops = of_device_get_match_data(dev);
 	at91_chip->pioc_virq = irq;
-	at91_chip->pioc_idx = alias_idx;
 
 	at91_chip->clock = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(at91_chip->clock))

-- 
2.30.2

