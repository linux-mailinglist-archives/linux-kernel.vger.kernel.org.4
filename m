Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EA664DD94
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLOPSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLOPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:18:04 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E6C19F;
        Thu, 15 Dec 2022 07:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=z+IHwHSu5unAUaaw4EDPAX6GeAr53Ixz/aN3zTKz0e8=; b=Qku3p+XT555mojQSydWem3v8Yu
        4EdXOoOaYhhR0PqwTE6//CqdXVbuZuAbLuh8SRYy5VeN4VYAgHOZPvqUTP11SIA7rfdhX2b5iH0SU
        m+KitC3I3DikYQdv+e+pNipccXr3B7J44CYgxgYo7KsucDRgjAERvYj0/NpMlJIsiZQg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48102 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1p5pmK-0000EC-D5; Thu, 15 Dec 2022 10:04:09 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 15 Dec 2022 10:02:10 -0500
Message-Id: <20221215150214.1109074-10-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221215150214.1109074-1-hugo@hugovil.com>
References: <20221215150214.1109074-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v3 09/14] rtc: pcf2127: set PWRMNG value for PCF2131
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Default PWRMNG[2:0] bits are set to 000b for PCF2127/29, but to
111b for PCF2131.

Set these bits to 000b to select same mode as PCF2127/29.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 68af4d0438b8..241189ee4a05 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -53,6 +53,7 @@
 #define PCF2127_BIT_CTRL3_BLF			BIT(2)
 #define PCF2127_BIT_CTRL3_BF			BIT(3)
 #define PCF2127_BIT_CTRL3_BTSE			BIT(4)
+#define PCF2127_CTRL3_PWRMNG_MASK		GENMASK(7, 5)
 /* Control register 4 */
 #define PCF2131_REG_CTRL4		0x03
 #define PCF2131_BIT_CTRL4_TSF4			BIT(4)
@@ -1129,6 +1130,20 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 	regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
 				PCF2127_BIT_CTRL1_POR_OVRD);
 
+	/* Make sure PWRMNG[2:0] is set to 000b. This is the default for
+	 * PCF2127/29, but not for PCF2131 (default of 111b).
+	 *
+	 * PWRMNG[2:0]  = 000b:
+	 *   battery switch-over function is enabled in standard mode;
+	 *   battery low detection function is enabled
+	 */
+	ret = regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL3,
+				PCF2127_CTRL3_PWRMNG_MASK);
+	if (ret < 0) {
+		dev_err(dev, "PWRMNG config failed\n");
+		return ret;
+	}
+
 	ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_clkout, &val);
 	if (ret < 0)
 		return ret;
-- 
2.30.2

