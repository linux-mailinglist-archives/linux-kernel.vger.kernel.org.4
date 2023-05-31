Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F8D718231
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbjEaNkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjEaNkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:40:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5D7107;
        Wed, 31 May 2023 06:40:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A550561527;
        Wed, 31 May 2023 13:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9D2C433B0;
        Wed, 31 May 2023 13:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540430;
        bh=e7tWL6wTRy34K2JWIZX6jDI78R1WuLGLxqA768ehrHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hB+DoPs6kfrJ6VlLkF8ayBBzfZQBhu//QPtg6w9Kz8yvT+sf7uEdhQfdCeE+fstei
         ASQnNNGl0oUevmN6ic+8LY99ScNt1qB3eHhbkF4ECUQYtqtj2e8/OVfaFjxrbjU3uZ
         ydN6FchSRxKtQK1IfIZuhIxx8VU2PNqdcDxqA8j5F0bNeJxbRuDGdHfHxY/zBTWmLW
         lhoU9H5l2HrtW4CSfrJjeM/80KsE6tEHldh2YXP9ywJoK3vc3XtPBRD/XOWmeNSLKB
         bZ3zKzlPc7N8s565Jbz8WPtLZSKbuY+w22aLbEr5Fk2xR1OD6vngAJmgcgS92eKt1S
         BP05du6fukByg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Milo Spadacini <milo.spadacini@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 06/37] tools: gpio: fix debounce_period_us output of lsgpio
Date:   Wed, 31 May 2023 09:39:48 -0400
Message-Id: <20230531134020.3383253-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134020.3383253-1-sashal@kernel.org>
References: <20230531134020.3383253-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milo Spadacini <milo.spadacini@gmail.com>

[ Upstream commit eb4b8eca1bad98f4b8574558a74f041f9acb5a54 ]

Fix incorrect output that could occur when more attributes are used and
GPIO_V2_LINE_ATTR_ID_DEBOUNCE is not the first one.

Signed-off-by: Milo Spadacini <milo.spadacini@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/gpio/lsgpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/gpio/lsgpio.c b/tools/gpio/lsgpio.c
index c61d061247e17..52a0be45410c9 100644
--- a/tools/gpio/lsgpio.c
+++ b/tools/gpio/lsgpio.c
@@ -94,7 +94,7 @@ static void print_attributes(struct gpio_v2_line_info *info)
 	for (i = 0; i < info->num_attrs; i++) {
 		if (info->attrs[i].id == GPIO_V2_LINE_ATTR_ID_DEBOUNCE)
 			fprintf(stdout, ", debounce_period=%dusec",
-				info->attrs[0].debounce_period_us);
+				info->attrs[i].debounce_period_us);
 	}
 }
 
-- 
2.39.2

