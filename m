Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C5F5BC1AC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 05:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiISDPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 23:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiISDPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 23:15:18 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F180A12D18;
        Sun, 18 Sep 2022 20:15:14 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 28J3EGkP013488-28J3EGkS013488
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Sep 2022 11:14:20 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marc Zyngier <maz@kernel.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] gpio: tqmx86: fix uninitialized variable girq
Date:   Mon, 19 Sep 2022 11:12:49 +0800
Message-Id: <20220919031250.770285-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongliang Mu <mudongliangabcd@gmail.com>

The commit 924610607f19 ("gpio: tpmx86: Move PM device over to
irq domain") adds a dereference of girq that may be uninitialized.

Fix this by moving irq_domain_set_pm_device into if true branch
as suggested by Marc Zyngier.

Fixes: 924610607f19 ("gpio: tpmx86: Move PM device over to irq domain")
Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
v1->v2: modify fix method to moving irq_domain_set_pm_device into
if true branch as suggested by Marc Zyngier
 drivers/gpio/gpio-tqmx86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-tqmx86.c b/drivers/gpio/gpio-tqmx86.c
index fa4bc7481f9a..e739dcea61b2 100644
--- a/drivers/gpio/gpio-tqmx86.c
+++ b/drivers/gpio/gpio-tqmx86.c
@@ -307,6 +307,8 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 		girq->default_type = IRQ_TYPE_NONE;
 		girq->handler = handle_simple_irq;
 		girq->init_valid_mask = tqmx86_init_irq_valid_mask;
+
+		irq_domain_set_pm_device(girq->domain, dev);
 	}
 
 	ret = devm_gpiochip_add_data(dev, chip, gpio);
@@ -315,8 +317,6 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 		goto out_pm_dis;
 	}
 
-	irq_domain_set_pm_device(girq->domain, dev);
-
 	dev_info(dev, "GPIO functionality initialized with %d pins\n",
 		 chip->ngpio);
 
-- 
2.35.1

