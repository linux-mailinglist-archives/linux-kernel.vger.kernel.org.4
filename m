Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840315F116F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiI3SRL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Sep 2022 14:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiI3SRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:17:08 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC2AC6971
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:17:05 -0700 (PDT)
X-QQ-mid: bizesmtpipv603t1664561732tz35
Received: from SJRobe ( [255.121.89.3])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 01 Oct 2022 02:15:31 +0800 (CST)
X-QQ-SSF: 01100000009000F0Z000B00A0000000
X-QQ-FEAT: KzokuMsy9J0pMqAkv2dvK58mQOF5DBYUygI6O9im+92owyXFDGj5W7JeSlGSA
        Oe/5VwiuAIvIAnJKKWuyxDXfwFvKi701H3ylfklFPoGtrlAy0x+rsMRgkb91/K1R33WdjqA
        SUk4xRJXlPzbfSVOWFqDeRzSvHZUxVpBm05LGVZgEocLkN0p0ySVEyE6m4MD3HK5+XoKleX
        SkJG4Y5treuH6vjpV1b6YexLKRFDvPrXw7NnNxHfzfFmZBRmmOXknA5ENJqYshVcDEn6I0N
        Q7pv5f0zz5B/YnCcU0U5uimeSl7zfCGAGKRAm0lW1nZa4Vl7hB+0rEoJ4ksDzxEqi7/3D9u
        0PWwpuWZeZJ0mZ90Cc=
X-QQ-GoodBg: 0
From:   <soha@lohu.info>
To:     <gregkh@linuxfoundation.org>
Cc:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Wende Tan'" <twd2.me@gmail.com>
Subject: [PATCH] platform: use fwnode_irq_get_byname instead of of_irq_get_byname to get irq
Date:   Sat, 1 Oct 2022 02:15:29 +0800
Message-ID: <0E39B15006ADC205+02a601d8d4f8$a00a09e0$e01e1da0$@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: fr
Thread-Index: AdjU8Rq0bEYQpY6wRseuzIiSRju+zw==
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:lohu.info:qybglogicsvr:qybglogicsvr3
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 02df97f4d814b9893eef2c2118b85d2b4b9d61ae Mon Sep 17 00:00:00 2001
From: Soha Jin <soha@lohu.info>
Date: Sat, 1 Oct 2022 00:26:04 +0800
Subject: [PATCH] platform: use fwnode_irq_get_byname instead of
 of_irq_get_byname to get irq

Not only platform devices described by OF have named interrupts, but
devices described by ACPI also have named interrupts. The fwnode is an
abstraction to different standards, and using fwnode_irq_get_byname can
support more devices.

Signed-off-by: Soha Jin <soha@lohu.info>
Tested-by: Wende Tan <twd2.me@gmail.com>
---
 drivers/base/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 51bb22898..968f3d71e 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -441,8 +441,8 @@ static int __platform_get_irq_byname(struct platform_device *dev,
 	struct resource *r;
 	int ret;
 
-	if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
-		ret = of_irq_get_byname(dev->dev.of_node, name);
+	if (!dev->dev.of_node || IS_ENABLED(CONFIG_OF_IRQ)) {
+		ret = fwnode_irq_get_byname(dev_fwnode(&dev->dev), name);
 		if (ret > 0 || ret == -EPROBE_DEFER)
 			return ret;
 	}
-- 
2.30.2


