Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D8964DEC6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiLOQig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiLOQic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:38:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41941B794;
        Thu, 15 Dec 2022 08:38:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60E0DB81BA1;
        Thu, 15 Dec 2022 16:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DD5C433EF;
        Thu, 15 Dec 2022 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671122309;
        bh=LtPCFB4V5acknIfWU3F4wsNAnbz+KIAtyg0mtXMQWrM=;
        h=From:To:Cc:Subject:Date:From;
        b=i27Oha7ARR2shAbNBwOWm9Gvo6ud+O5kgC1Nt8Al88aXIaNkEciVfu4FIvMcC2f+S
         fIAGhucXXYmAHTR6uJpBTrbTLQxn+qTdB+GboCfhjioRLJVlxw5ZU8qiHU4PB9bC8B
         xLmz67VRT6YtM/ydtdjY1B4gK6zLHj/2VQzvtGCv5WHsv2w2DSxAvtVsklSfoRbKI5
         gVdIuiHV91k9kjHv/WMUZ40p/62kLJeEZBk7GR8SkXJZ3gHUwGpnaH9iKJ76PeO8zb
         yD9AVHlg+Bvp2kCXy/D3Ez6/TWyCoMcJaJyyPM6taMfThURBwh1kyesXv6GkJt5Nwg
         kUcXf9fCJPXyg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        William Dean <williamsukatube@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: sp7021: fix unused function warning
Date:   Thu, 15 Dec 2022 17:38:10 +0100
Message-Id: <20221215163822.542622-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
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

sppctl_gpio_inv_get is only used from the debugfs code inside
of an #ifdef, so we get a warning without that:

drivers/pinctrl/sunplus/sppctl.c:393:12: error: 'sppctl_gpio_inv_get' defined but not used [-Werror=unused-function]
  393 | static int sppctl_gpio_inv_get(struct gpio_chip *chip, unsigned int offset)
      |            ^~~~~~~~~~~~~~~~~~~

Replace the #ifdef with an IS_ENABLED() check that avoids the warning.

Fixes: aa74c44be19c ("pinctrl: Add driver for Sunplus SP7021")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/sunplus/sppctl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/sunplus/sppctl.c b/drivers/pinctrl/sunplus/sppctl.c
index 2b3335ab56c6..25101293268f 100644
--- a/drivers/pinctrl/sunplus/sppctl.c
+++ b/drivers/pinctrl/sunplus/sppctl.c
@@ -499,7 +499,6 @@ static int sppctl_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 	return 0;
 }
 
-#ifdef CONFIG_DEBUG_FS
 static void sppctl_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 {
 	const char *label;
@@ -521,7 +520,6 @@ static void sppctl_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 		seq_puts(s, "\n");
 	}
 }
-#endif
 
 static int sppctl_gpio_new(struct platform_device *pdev, struct sppctl_pdata *pctl)
 {
@@ -550,9 +548,8 @@ static int sppctl_gpio_new(struct platform_device *pdev, struct sppctl_pdata *pc
 	gchip->get              = sppctl_gpio_get;
 	gchip->set              = sppctl_gpio_set;
 	gchip->set_config       = sppctl_gpio_set_config;
-#ifdef CONFIG_DEBUG_FS
-	gchip->dbg_show         = sppctl_gpio_dbg_show;
-#endif
+	gchip->dbg_show         = IS_ENABLED(CONFIG_DEBUG_FS) ?
+				  sppctl_gpio_dbg_show : NULL;
 	gchip->base             = -1;
 	gchip->ngpio            = sppctl_gpio_list_sz;
 	gchip->names            = sppctl_gpio_list_s;
-- 
2.35.1

