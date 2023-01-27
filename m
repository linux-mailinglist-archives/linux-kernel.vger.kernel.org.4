Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AD567E05C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjA0JfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjA0JfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:35:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9FD12E;
        Fri, 27 Jan 2023 01:35:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10B80B81FFC;
        Fri, 27 Jan 2023 09:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235ECC433EF;
        Fri, 27 Jan 2023 09:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674812116;
        bh=LPd2/+DNZCkY5p5deZreyittH8sSRzRvsSNwqIpMuYA=;
        h=From:To:Cc:Subject:Date:From;
        b=Nf2qF5iW5lj87KbIONJvmol6A9SpHMRLErxIiND8HR5I+m7gOhlPosNfV8Vz6OX34
         dCjpgjj4iVL4WfAioaK2oKhnbH12MGO0Qllo+momxq3pCdKCcBRcb1elbhtOrguvUS
         7IvEJ0eeXEcecMon+Llk/3T5BO1sNTLAgHF7HyvJk0seSHZYzmnuHkefnS/gIqjahI
         ExTM4Srqpe9Rk/kZIKa7t7L2Q8UYxadClJJO2VKlWkZzv4kOMoeZVZd8wCScVP833/
         4YnmsbbmeZbpfyIbWVUrkcMabP/iE7fGMeQr82YMjGhxdzOG8FBf2xU8cg2KtgMsIm
         veUsXcWJ3yl2A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: ep93xx: remove unused variable
Date:   Fri, 27 Jan 2023 10:35:05 +0100
Message-Id: <20230127093512.2066158-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This one was left behind by a previous cleanup patch:

drivers/gpio/gpio-ep93xx.c: In function 'ep93xx_gpio_add_bank':
drivers/gpio/gpio-ep93xx.c:366:34: error: unused variable 'ic' [-Werror=unused-variable]

Fixes: 216f37366e86 ("gpio: ep93xx: Make irqchip immutable")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpio-ep93xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 192be99b1392..6cedf46efec6 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -363,8 +363,6 @@ static int ep93xx_gpio_add_bank(struct ep93xx_gpio_chip *egc,
 
 	girq = &gc->irq;
 	if (bank->has_irq || bank->has_hierarchical_irq) {
-		struct irq_chip *ic;
-
 		gc->set_config = ep93xx_gpio_set_config;
 		egc->eic = devm_kcalloc(dev, 1,
 					sizeof(*egc->eic),
-- 
2.39.0

