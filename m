Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71931703C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242572AbjEOSZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243318AbjEOSZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:25:05 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FB31BFD;
        Mon, 15 May 2023 11:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=xv65otAZpwQe0poNNXfHJow6UPxE0aTdH/CgQXwd/GM=; b=x
        ESn0IxihlZCerMfMRPWlN90vJTk2/Y6YrR1aGBf2bcepWHqjoDn9kKZf7WsRahbCkwlMmBii6OkdX
        qFnv0KXaGoOmUK3GZeEJGUiXfCZwcQSaC3MIdVK3cipvuNttv0KNxZ5txud1sE+BYeYBGfE0LQoZQ
        fKYSWo5dTYd460Kw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:38650 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pycsW-0004X8-Q5; Mon, 15 May 2023 14:25:01 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 15 May 2023 14:23:47 -0400
Message-Id: <20230515182347.2939997-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2] rtc: pcf2127: add error checking when disabling POR0
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

If PCF2127 device is absent from the I2C bus, or if there is a
communication problem, disabling POR0 may fail silently and we
still continue with probing the device. In that case, abort probe
operation.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
V1 -> V2: Removed error message

 drivers/rtc/rtc-pcf2127.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 87f4fc9df68b..d9d3ef373c03 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -703,8 +703,10 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	 * The "Power-On Reset Override" facility prevents the RTC to do a reset
 	 * after power on. For normal operation the PORO must be disabled.
 	 */
-	regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
+	ret = regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
 				PCF2127_BIT_CTRL1_POR_OVRD);
+	if (ret < 0)
+		return ret;
 
 	ret = regmap_read(pcf2127->regmap, PCF2127_REG_CLKOUT, &val);
 	if (ret < 0)

base-commit: e99ab4abebf825de2ce65f6c6c32ee30e00bb077
-- 
2.30.2

