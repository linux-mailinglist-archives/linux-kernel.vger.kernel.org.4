Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A6C6BD078
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCPNMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCPNMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:12:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC08DC8892;
        Thu, 16 Mar 2023 06:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E75762013;
        Thu, 16 Mar 2023 13:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79822C4339E;
        Thu, 16 Mar 2023 13:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678972355;
        bh=7E1F1HujeKXETEZ4kPVIQu6ehkDfj+ztaIBRYcJcu18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jomVkmsc2gTsM46uTbphUsj1cw/S/gkHSKxZG1YC6g0ElVmzkoZNTUxyyEs6cIDsA
         mGoT2AGrMM6isbR9jU12g0dDwWosDKVU4aFd0ZgOHlhpO7woOrQcQKY4kFkDzyoxau
         ZBQmf84N37idtAV2Idui76kdC9iSOX1LobYzBgZyRII2Mz336k/S/zYDTurboxfc9x
         AGzX/kuzrPSURDXwlS3Jj1CB18hG4Eymg6l1RMjGhLRFkB2YE31Dq5506t0Kl4RLJ1
         0k1+1NgAJJESQ6kD4cBvzJwAfLRClbpvf9TcU5wbhJIEpZeBZ3Jf5CIuzw46lMxeFx
         aIf8uDOnvcayg==
From:   Roger Quadros <rogerq@kernel.org>
To:     Thinh.Nguyen@synopsys.com
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        vigneshr@ti.com, srk@ti.com, r-gunasekaran@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aswath Govindraju <a-govindraju@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/3] usb: dwc3-am62: Add support for system wakeup based on USB events
Date:   Thu, 16 Mar 2023 15:12:24 +0200
Message-Id: <20230316131226.89540-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316131226.89540-1-rogerq@kernel.org>
References: <20230316131226.89540-1-rogerq@kernel.org>
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

From: Aswath Govindraju <a-govindraju@ti.com>

The USB2SS IP in TI's AM62 SoC is capable of supporting wakeup from
deep sleep based on the following events,

1) VBUS state change
2) Overcurrent detection
3) Line state change

Wakeup from these events can enabled by setting their corresponding bits
in the WAKEUP_CONFIG register. The events to be enabled are decided based
on the current role of the controller.

When the role of the controller is host, the comparators for detecting
VBUS state change are disabled while entering low power mode. This is done
as VBUS state is not used in host mode and disabling the comparators helps
in reducing the power consumption. So, wakeup from VBUS state change should
be disabled in host mode. While operating in peripheral mode all the wakeup
events can be enabled.

Therefore, add support for the same in the suspend/resume hooks.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/usb/dwc3/dwc3-am62.c | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 173cf3579c55..867bfa1252b8 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -17,6 +17,8 @@
 #include <linux/regmap.h>
 #include <linux/pinctrl/consumer.h>
 
+#include "core.h"
+
 /* USB WRAPPER register offsets */
 #define USBSS_PID			0x0
 #define USBSS_OVERCURRENT_CTRL		0x4
@@ -45,6 +47,10 @@
 #define USBSS_PHY_VBUS_SEL_SHIFT	1
 #define USBSS_PHY_LANE_REVERSE		BIT(0)
 
+/* CORE STAT register bits */
+#define USBSS_CORE_OPERATIONAL_MODE_MASK	GENMASK(13, 12)
+#define USBSS_CORE_OPERATIONAL_MODE_SHIFT	12
+
 /* MODE CONTROL register bits */
 #define USBSS_MODE_VALID	BIT(0)
 
@@ -233,6 +239,9 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	reg |= USBSS_MODE_VALID;
 	dwc3_ti_writel(data, USBSS_MODE_CONTROL, reg);
 
+	/* Device has capability to wakeup system from sleep */
+	device_set_wakeup_capable(dev, true);
+
 	/* Setting up autosuspend */
 	pm_runtime_set_autosuspend_delay(dev, DWC3_AM62_AUTOSUSPEND_DELAY);
 	pm_runtime_use_autosuspend(dev);
@@ -281,6 +290,22 @@ static int dwc3_ti_remove(struct platform_device *pdev)
 static int dwc3_ti_suspend_common(struct device *dev)
 {
 	struct dwc3_data *data = dev_get_drvdata(dev);
+	u32 reg, current_prtcap_dir;
+
+	if (device_may_wakeup(dev)) {
+		reg = dwc3_ti_readl(data, USBSS_CORE_STAT);
+		current_prtcap_dir = (reg & USBSS_CORE_OPERATIONAL_MODE_MASK)
+				     >> USBSS_CORE_OPERATIONAL_MODE_SHIFT;
+		/* Set wakeup config enable bits */
+		reg = dwc3_ti_readl(data, USBSS_WAKEUP_CONFIG);
+		if (current_prtcap_dir == DWC3_GCTL_PRTCAP_HOST) {
+			reg |= USBSS_WAKEUP_CFG_LINESTATE_EN | USBSS_WAKEUP_CFG_OVERCURRENT_EN;
+		} else {
+			reg |= USBSS_WAKEUP_CFG_OVERCURRENT_EN | USBSS_WAKEUP_CFG_LINESTATE_EN |
+			       USBSS_WAKEUP_CFG_VBUSVALID_EN;
+		}
+		dwc3_ti_writel(data, USBSS_WAKEUP_CONFIG, reg);
+	}
 
 	clk_disable_unprepare(data->usb2_refclk);
 
@@ -290,9 +315,23 @@ static int dwc3_ti_suspend_common(struct device *dev)
 static int dwc3_ti_resume_common(struct device *dev)
 {
 	struct dwc3_data *data = dev_get_drvdata(dev);
+	u32 reg;
 
 	clk_prepare_enable(data->usb2_refclk);
 
+	if (device_may_wakeup(dev)) {
+		/* Clear wakeup config enable bits */
+		reg = dwc3_ti_readl(data, USBSS_WAKEUP_CONFIG);
+		reg &= ~(USBSS_WAKEUP_CFG_OVERCURRENT_EN | USBSS_WAKEUP_CFG_LINESTATE_EN |
+			 USBSS_WAKEUP_CFG_VBUSVALID_EN);
+		dwc3_ti_writel(data, USBSS_WAKEUP_CONFIG, reg);
+	}
+
+	reg = dwc3_ti_readl(data, USBSS_WAKEUP_STAT);
+	/* Clear the wakeup status with wakeup clear bit */
+	reg |= USBSS_WAKEUP_STAT_CLR;
+	dwc3_ti_writel(data, USBSS_WAKEUP_STAT, reg);
+
 	return 0;
 }
 
-- 
2.34.1

