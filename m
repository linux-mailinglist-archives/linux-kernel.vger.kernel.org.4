Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB4F699938
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjBPPtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjBPPtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:49:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B335D2A9B3;
        Thu, 16 Feb 2023 07:49:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D99D614E2;
        Thu, 16 Feb 2023 15:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694EEC433EF;
        Thu, 16 Feb 2023 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676562579;
        bh=PBNlK9rtfW1dG51G1QB8MZVifuDiQ041ABguCzvNxA4=;
        h=From:Subject:Date:To:Cc:From;
        b=lVek7JFKejce7ovZSe2LcNc5bKHhxsZnQElQv/H/fW0ZvCrbTFZ+F/dDUBqdSrW4B
         Im/Uh2CFic0HuwBJLW7R70qBqBtLN++NJCu99HsiXnQ+SvrIeLYdd5kZ09U4LFRbUp
         O4fYiwJNSKmW8OwnAbNmQ/7G7PLWTjN/dNM9T9+e7ABrYugQ4qJJWj7udEkhGaNOfz
         B86HPPiznr81dwDWrQzeVd4w0313da5i9/LvpeA+gYkLtLphNpzeSH5S4z57UE2Luo
         JnC6tfLPUQIgjCO6YstbXJDE7w+4ev1NZhh6a1/nvIjKdXguUa2l8P/dF7UqY3oI/w
         TX4h0XA196jOQ==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] pinctrl: at91: Minor cleanups
Date:   Thu, 16 Feb 2023 15:43:56 +0000
Message-Id: <20230216-gpio-at91-immutable-v1-0-44f52f148ab9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADxP7mMC/x2NQQqDMBAAvyJ77oKJpDT9Sulhk6660ETJxlIQ/
 97Y4zAMs4NyEVa4dzsU/ojKkhuYSwdxpjwxyqsx2N4OvTVXnFZZkKo3KCltlcKb0Q1jDN67YG8
 OWhlIGUOhHOezTaSVyynWwqN8/7vH8zh+SF3ukH4AAAA=
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=799; i=broonie@kernel.org;
 h=from:subject:message-id; bh=PBNlK9rtfW1dG51G1QB8MZVifuDiQ041ABguCzvNxA4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj7lCOQtQLLr3GltNzFAjCukyvl+/E3m3W0SqzcSv0
 BNUabCuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY+5QjgAKCRAk1otyXVSH0IjKB/
 90yp6ct2s6QD1slshxgCeB9ZfneCsVtFP2k6fg5ViobDKnK4JMiTgTEup9dZ6cmjxvwy8iYKTNgLGs
 hyKy3IjdS1KH3Tufwa4Ceb+DeM0G5VZOCic+Pat0e+wh+E8+7rhHQCJ2agl7Au/woKTi40dgpKPwuU
 Rs+yRGmb+HnVZxJ6Cwii+B8PylJQEnkGnwVwLg2PVhIaS85KcrZVR0EAGKptKbFH7oKib7JwRqsOei
 QdAJFGehzWVRWmllStBNpCx3lByh63zG2YvKmZlZQfvQGLDDOhoNuluIGXmLve9LiXtXLcm0QRNBso
 ogH5rRf+rGJx/HzTi19626N2R5u11y
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few cleanups for the at91 driver, making the GPIO irqchip
immutable and removing an unused member from the driver data.
The driver is still using statically assigned GPIO numbers, we
can't just remove that since the driver itself is still relying
on them even if there are no longer board files for this
platform.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      pinctrl: at91: Make the irqchip immutable
      pinctrl: at91: Remove pioc_index from struct at91_gpio_chip

 drivers/pinctrl/pinctrl-at91.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230216-gpio-at91-immutable-53fcb995b285

Best regards,
-- 
Mark Brown <broonie@kernel.org>

