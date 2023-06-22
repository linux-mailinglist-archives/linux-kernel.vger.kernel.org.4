Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA48773A407
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjFVO7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjFVO63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:58:29 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D9F1FE1;
        Thu, 22 Jun 2023 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+i6JIq0V4nwWMaJmDOwGobgHPpVBj7bJFrC5zzRbZAY=; b=0BXQDtEMunHIKGGWzQCsR0R0Uy
        ktu3uugAKDFMzKqdp6StUy/Lwa6vqx7IcWh9rCG25dRItJMUMge5I8QfA0FSoe/fzSsELi3ApABXb
        Pz8/NL1M6xOFqEGRqiSgl1jzeWKcDMlFg+WfEr9SeM5TLfzlG6C4b+tGsjG5FBLjnTT8=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:55382 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qCLlM-0002fr-L5; Thu, 22 Jun 2023 10:58:21 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 22 Jun 2023 10:57:56 -0400
Message-Id: <20230622145800.2442116-14-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230622145800.2442116-1-hugo@hugovil.com>
References: <20230622145800.2442116-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v4 13/17] rtc: pcf2127: adapt time/date registers write sequence for PCF2131
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The sequence for updating the time/date registers is slightly
different between PCF2127/29 and PCF2131.

For PCF2127/29, during write operations, the time counting
circuits (memory locations 03h through 09h) are automatically blocked.

For PCF2131, time/date registers write access requires setting the
STOP bit and sending the clear prescaler instruction (CPR). STOP then
needs to be released once write operation is completed.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 2eef65232417..3b8718aaadd7 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -33,6 +33,7 @@
 #define PCF2127_REG_CTRL1		0x00
 #define PCF2127_BIT_CTRL1_POR_OVRD		BIT(3)
 #define PCF2127_BIT_CTRL1_TSF1			BIT(4)
+#define PCF2127_BIT_CTRL1_STOP			BIT(5)
 /* Control register 2 */
 #define PCF2127_REG_CTRL2		0x01
 #define PCF2127_BIT_CTRL2_AIE			BIT(1)
@@ -280,13 +281,45 @@ static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	/* year */
 	buf[i++] = bin2bcd(tm->tm_year - 100);
 
-	/* write register's data */
+	/* Write access to time registers:
+	 * PCF2127/29: no special action required.
+	 * PCF2131:    requires setting the STOP and CPR bits. STOP bit needs to
+	 *             be cleared after time registers are updated.
+	 */
+	if (pcf2127->cfg->type == PCF2131) {
+		err = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
+					 PCF2127_BIT_CTRL1_STOP,
+					 PCF2127_BIT_CTRL1_STOP);
+		if (err) {
+			dev_dbg(dev, "setting STOP bit failed\n");
+			return err;
+		}
+
+		err = regmap_write(pcf2127->regmap, PCF2131_REG_SR_RESET,
+				   PCF2131_SR_RESET_CPR_CMD);
+		if (err) {
+			dev_dbg(dev, "sending CPR cmd failed\n");
+			return err;
+		}
+	}
+
+	/* write time register's data */
 	err = regmap_bulk_write(pcf2127->regmap, pcf2127->cfg->reg_time_base, buf, i);
 	if (err) {
 		dev_dbg(dev, "%s: err=%d", __func__, err);
 		return err;
 	}
 
+	if (pcf2127->cfg->type == PCF2131) {
+		/* Clear STOP bit (PCF2131 only) after write is completed. */
+		err = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
+					 PCF2127_BIT_CTRL1_STOP, 0);
+		if (err) {
+			dev_dbg(dev, "clearing STOP bit failed\n");
+			return err;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.30.2

