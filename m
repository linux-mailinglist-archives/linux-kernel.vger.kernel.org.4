Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17B964DD9A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiLOPSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiLOPSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:18:07 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7FF19F;
        Thu, 15 Dec 2022 07:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cCTf1P1Ro/N5X79I1I290rP6Jh7qh0U4wx0QBzSmYMQ=; b=FJAEF2V4u9/V8aWleuoaeHIMnh
        YiumC9kpOionkUuDn3/3wSBvR3+mOIl91bpx291TIvTjg0RMth2l7ZmG4uh0HH3w4LSL8AQVWvdJ9
        K2qkLCtmbSfqkOKFE7vFtsiJU85o56xjKD+/etsOa2nYYH0fOkr3i4/abN/otikFaI3Q=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48102 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1p5pmN-0000EC-1u; Thu, 15 Dec 2022 10:04:11 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 15 Dec 2022 10:02:12 -0500
Message-Id: <20221215150214.1109074-12-hugo@hugovil.com>
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
Subject: [PATCH v3 11/14] rtc: pcf2127: adapt time/date registers write sequence for PCF2131
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
 drivers/rtc/rtc-pcf2127.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index e4b78b9c03f9..11fbdab6bf01 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -39,6 +39,7 @@
 #define PCF2127_REG_CTRL1		0x00
 #define PCF2127_BIT_CTRL1_POR_OVRD		BIT(3)
 #define PCF2127_BIT_CTRL1_TSF1			BIT(4)
+#define PCF2127_BIT_CTRL1_STOP			BIT(5)
 /* Control register 2 */
 #define PCF2127_REG_CTRL2		0x01
 #define PCF2127_BIT_CTRL2_AIE			BIT(1)
@@ -70,6 +71,7 @@
 #define PCF2131_REG_SR_RESET		0x05
 #define PCF2131_SR_RESET_READ_PATTERN	0b00100100 /* Fixed pattern. */
 #define PCF2131_SR_RESET_RESET_CMD	0x2C /* SR is bit 3. */
+#define PCF2131_SR_RESET_CPR_CMD	0xA4 /* CPR is bit 7. */
 /* Time and date registers */
 #define PCF2127_REG_TIME_DATE_BASE	0x03
 #define PCF2131_REG_TIME_DATE_BASE	0x07 /* Register 0x06 is 100th seconds,
@@ -307,7 +309,31 @@ static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	/* year */
 	buf[i++] = bin2bcd(tm->tm_year - 100);
 
-	/* write register's data */
+	/* Write access to time registers:
+	 * PCF2127/29: no special action required.
+	 * PCF2131:    requires setting the STOP bit. STOP bit needs to
+	 *             be cleared after time registers are updated.
+	 *             It is also recommended to set CPR bit, although
+	 *             write access will work without it.
+	 */
+	if (pcf2127->cfg->has_reset_reg) {
+		err = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
+					 PCF2127_BIT_CTRL1_STOP,
+					 PCF2127_BIT_CTRL1_STOP);
+		if (err) {
+			dev_err(dev, "setting STOP bit failed\n");
+			return err;
+		}
+
+		err = regmap_write(pcf2127->regmap, pcf2127->cfg->reg_reset,
+				   PCF2131_SR_RESET_CPR_CMD);
+		if (err) {
+			dev_err(dev, "sending CPR cmd failed\n");
+			return err;
+		}
+	}
+
+	/* write time register's data */
 	err = regmap_bulk_write(pcf2127->regmap, pcf2127->cfg->regs_td_base, buf, i);
 	if (err) {
 		dev_err(dev,
@@ -315,6 +341,16 @@ static int pcf2127_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		return err;
 	}
 
+	if (pcf2127->cfg->has_reset_reg) {
+		/* Clear STOP bit (PCF2131 only) after write is completed. */
+		err = regmap_update_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
+					 PCF2127_BIT_CTRL1_STOP, 0);
+		if (err) {
+			dev_err(dev, "clearing STOP bit failed\n");
+			return err;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.30.2

