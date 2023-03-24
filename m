Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BD76C7D6C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjCXLoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjCXLol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:44:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E991EBC6;
        Fri, 24 Mar 2023 04:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74C0462950;
        Fri, 24 Mar 2023 11:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929D5C433EF;
        Fri, 24 Mar 2023 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679658276;
        bh=wPAS6ORWpk0/rqv+0+dRl7/A22wDG+peNCJdYRP8hWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLGS6aP9edU73NVzzfQw1p+BBQYZtIZrEhN+bgghP87PXz75z5REx14kHpFBaE5Wc
         xfCzjKQ1OCEbUsyTEVQYFV8P7R0NilYFKws4BmjgkvXszIWBWfjHWULWv4Sl6yjWO3
         7JWO7za31Li0YyNhqRZOnrYurX9koO/xV59Es+1wl3bBTzPMqRaHMIZH8TS8o9zOpv
         xW2EyNZw75OIUorfAJNZg+8vOTkaiMAL2l+x+xjmTbWQACi+bCuz1MQmKoCY/+c4BY
         jahOycZ8SYcWFOkgcZFq4sikK3jAvixw3RaKni8yySjsvYF71Z8l2BQLdDb9uCbkyV
         0tUuqZlgnbiKw==
From:   Roger Quadros <rogerq@kernel.org>
To:     Thinh.Nguyen@synopsys.com, stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, vigneshr@ti.com, srk@ti.com,
        r-gunasekaran@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2] usb: dwc3-am62: Fix up wake-up configuration and spurious wake up
Date:   Fri, 24 Mar 2023 13:44:29 +0200
Message-Id: <20230324114429.21838-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316131226.89540-4-rogerq@kernel.org>
References: <20230316131226.89540-4-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly set and clear wakeup config so we don't leave anything
to chance.

Clear wakeup status on suspend so we know what caused wake up.

The LINESTATE wake up should not be enabled in device mode
if we are not connected to a USB host and in USB suspend (U2/L3)
else it will cause spurious wake up.

For now, don't enable LINESTATE. This means wake up from
USB resume will not work but at least we won't have any spurious
wake ups.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changelog:
v2: don't enable LINESTATE wake-up at all in device mode.

 drivers/usb/dwc3/dwc3-am62.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 859b48279658..b22fb78bc8e7 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -60,6 +60,13 @@
 #define USBSS_WAKEUP_CFG_SESSVALID_EN	BIT(1)
 #define USBSS_WAKEUP_CFG_VBUSVALID_EN	BIT(0)
 
+#define USBSS_WAKEUP_CFG_ALL	(USBSS_WAKEUP_CFG_VBUSVALID_EN | \
+				 USBSS_WAKEUP_CFG_SESSVALID_EN | \
+				 USBSS_WAKEUP_CFG_LINESTATE_EN | \
+				 USBSS_WAKEUP_CFG_OVERCURRENT_EN)
+
+#define USBSS_WAKEUP_CFG_NONE	0
+
 /* WAKEUP STAT register bits */
 #define USBSS_WAKEUP_STAT_OVERCURRENT	BIT(4)
 #define USBSS_WAKEUP_STAT_LINESTATE	BIT(3)
@@ -103,6 +110,7 @@ struct dwc3_data {
 	struct regmap *syscon;
 	unsigned int offset;
 	unsigned int vbus_divider;
+	u32 wakeup_stat;
 };
 
 static const int dwc3_ti_rate_table[] = {	/* in KHZ */
@@ -302,12 +310,17 @@ static int dwc3_ti_suspend_common(struct device *dev)
 		/* Set wakeup config enable bits */
 		reg = dwc3_ti_readl(data, USBSS_WAKEUP_CONFIG);
 		if (current_prtcap_dir == DWC3_GCTL_PRTCAP_HOST) {
-			reg |= USBSS_WAKEUP_CFG_LINESTATE_EN | USBSS_WAKEUP_CFG_OVERCURRENT_EN;
+			reg = USBSS_WAKEUP_CFG_LINESTATE_EN | USBSS_WAKEUP_CFG_OVERCURRENT_EN;
 		} else {
-			reg |= USBSS_WAKEUP_CFG_OVERCURRENT_EN | USBSS_WAKEUP_CFG_LINESTATE_EN |
-			       USBSS_WAKEUP_CFG_VBUSVALID_EN;
+			reg = USBSS_WAKEUP_CFG_VBUSVALID_EN | USBSS_WAKEUP_CFG_SESSVALID_EN;
+			/*
+			 * Enable LINESTATE wake up only if connected to bus
+			 * and in U2/L3 state else it causes spurious wake-up.
+			 */
 		}
 		dwc3_ti_writel(data, USBSS_WAKEUP_CONFIG, reg);
+		/* clear wakeup status so we know what caused the wake up */
+		dwc3_ti_writel(data, USBSS_WAKEUP_STAT, USBSS_WAKEUP_STAT_CLR);
 	}
 
 	clk_disable_unprepare(data->usb2_refclk);
@@ -324,16 +337,11 @@ static int dwc3_ti_resume_common(struct device *dev)
 
 	if (device_may_wakeup(dev)) {
 		/* Clear wakeup config enable bits */
-		reg = dwc3_ti_readl(data, USBSS_WAKEUP_CONFIG);
-		reg &= ~(USBSS_WAKEUP_CFG_OVERCURRENT_EN | USBSS_WAKEUP_CFG_LINESTATE_EN |
-			 USBSS_WAKEUP_CFG_VBUSVALID_EN);
-		dwc3_ti_writel(data, USBSS_WAKEUP_CONFIG, reg);
+		dwc3_ti_writel(data, USBSS_WAKEUP_CONFIG, USBSS_WAKEUP_CFG_NONE);
 	}
 
 	reg = dwc3_ti_readl(data, USBSS_WAKEUP_STAT);
-	/* Clear the wakeup status with wakeup clear bit */
-	reg |= USBSS_WAKEUP_STAT_CLR;
-	dwc3_ti_writel(data, USBSS_WAKEUP_STAT, reg);
+	data->wakeup_stat = reg;
 
 	return 0;
 }
-- 
2.34.1

