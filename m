Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EC25B80C5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 07:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiINFUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 01:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiINFU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 01:20:28 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F4B5FAEA;
        Tue, 13 Sep 2022 22:20:27 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 28E5K8mB021556-28E5K8mE021556
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 14 Sep 2022 13:20:12 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marc Zyngier <maz@kernel.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: tpmx86: fix uninitialized variable girq
Date:   Wed, 14 Sep 2022 13:18:42 +0800
Message-Id: <20220914051842.69776-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongliang Mu <mudongliangabcd@gmail.com>

The commit 924610607f19 ("gpio: tpmx86: Move PM device over to
irq domain") adds a dereference of girq that may be uninitialized.

Fix this by initializing girq and checking irq before invoking
irq_domain_set_pm_device.

Fixes: 924610607f19 ("gpio: tpmx86: Move PM device over to irq domain")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/gpio/gpio-tqmx86.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-tqmx86.c b/drivers/gpio/gpio-tqmx86.c
index fa4bc7481f9a..bdef182c11c2 100644
--- a/drivers/gpio/gpio-tqmx86.c
+++ b/drivers/gpio/gpio-tqmx86.c
@@ -231,7 +231,7 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct tqmx86_gpio_data *gpio;
 	struct gpio_chip *chip;
-	struct gpio_irq_chip *girq;
+	struct gpio_irq_chip *girq = NULL;
 	void __iomem *io_base;
 	struct resource *res;
 	int ret, irq;
@@ -315,7 +315,9 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 		goto out_pm_dis;
 	}
 
-	irq_domain_set_pm_device(girq->domain, dev);
+	if (girq) {
+		irq_domain_set_pm_device(girq->domain, dev);
+	}
 
 	dev_info(dev, "GPIO functionality initialized with %d pins\n",
 		 chip->ngpio);
-- 
2.35.1

