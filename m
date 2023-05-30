Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576A171691D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjE3QWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjE3QWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:22:01 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 161C49D;
        Tue, 30 May 2023 09:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ru5cR
        PmsF9ZMmZyJkpTmhO87sRRfpND2S5AIZbRneS8=; b=hbgaKTL4OdWrbkFZELrqA
        mQC+RbpjIo2yYZixv5gmZbNify5YQpkeZt+cg9cV5IK+NliPHjJD4flcoMMImgVw
        hsuuo72k2wier9iOeZrHLP8Cuwhah41soLks8C5JC12mBN6abVRqVIYsHIYrcNet
        LnAK/aQMLnnOQTfzYDg5XE=
Received: from lizhe.. (unknown [120.245.132.246])
        by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wB39k5TInZkiwMYBA--.49914S4;
        Wed, 31 May 2023 00:21:06 +0800 (CST)
From:   Lizhe <sensor1010@163.com>
To:     andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, linux@armlinux.org.uk,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lizhe <sensor1010@163.com>
Subject: [PATCH] drivers/gpio : Remove redundant clearing of IRQ_TYPE_SENSE_MASK
Date:   Wed, 31 May 2023 00:20:34 +0800
Message-Id: <20230530162034.4004-1-sensor1010@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB39k5TInZkiwMYBA--.49914S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFy8uF1xGF4rZF1fZw1fZwb_yoWDKwb_Cw
        n5Kay3Xw4rtFn8ZrnIka1xZrZFyw4DW3Z5urn5t3ZxArn5Zr13ursrW3WSyFW5Zr4I9FWU
        tayrCr4avFW7AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKGQ6JUUUUU==
X-Originating-IP: [120.245.132.246]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBXhN-q1aEBo2lAwAAsm
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before executing microchip_sgpio_irq_set_type(),
type has already been cleared IRQ_TYPE_SENSE_MASK, see __irq_set_trigger().

Signed-off-by: Lizhe <sensor1010@163.com>
---
 arch/arm/plat-orion/gpio.c | 1 -
 drivers/gpio/gpio-mvebu.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index 595e9cb33c1d..863fa497b1a2 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -364,7 +364,6 @@ static int gpio_irq_set_type(struct irq_data *d, u32 type)
 		return -EINVAL;
 	}
 
-	type &= IRQ_TYPE_SENSE_MASK;
 	if (type == IRQ_TYPE_NONE)
 		return -EINVAL;
 
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index a68f682aec01..34fd007b0308 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -505,7 +505,6 @@ static int mvebu_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	if ((u & BIT(pin)) == 0)
 		return -EINVAL;
 
-	type &= IRQ_TYPE_SENSE_MASK;
 	if (type == IRQ_TYPE_NONE)
 		return -EINVAL;
 
-- 
2.34.1

