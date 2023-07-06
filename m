Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A421E749730
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjGFIQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGFIQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:16:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D161982
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:16:03 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51d946d2634so622477a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 01:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1688631362; x=1691223362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MwhGXVbpyW7QZfWhQZ06L6pd7GPVWoOBooUvPzw56Y0=;
        b=ouPNzmID1yqGEv788RGmeUJ8ULIA4KpwiYj8S1vp7f3utnzQJXfxKaOeJ6IU/TU28i
         pagKGFK2Ff9mMkwFYY1M+QKexLm9vgu2zVRBhfY+kbb1PXbrsRrpKTUjFwplSnhRf96s
         isV9iK7WoRd8iIgun3HPNkx7QX2aYXfsP7rOo/VyjwJxCQPYahQn/EEwZmLGFuBCCdNO
         akGqY5IGw7KvYrqZSbdR/iEvv/qRsgZObx0G/gZR2ldZPnQyqSCTAinW0JsXEzSZIPwj
         yGQpnrUYQ9LTnYzL7UzvoDzQQhadC6uzrXTuRuO/rKLi8CkwaqIMviN6RcsPNdaEMPJ0
         8prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688631362; x=1691223362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwhGXVbpyW7QZfWhQZ06L6pd7GPVWoOBooUvPzw56Y0=;
        b=Sd4wLKnYQKkoXDx4rFDiCqlmxF1YkHpS+5+LV2oDt8YuZsbJX0ffE6F+J+imSRCOK/
         XJPCfBroSVSJr+e4C39SZd0zZvRkqvEalGjClDJio5gGfe0h84TklGG4HCfhwkgUn6qt
         U0hZ19bnGGMZ89fNo2GKRXMsMF4tclFu1Dp1nZMiUGVWnnmC4ixh8Ddq8yYhAyxp6uj4
         el0e3+Uq7w0GXuus260FwPkXLon6T+cp3JffAZwWVRjHc+8tMajyIHf9Bxd6FjrKkEZg
         AJE8185uaPTkKaWcyIMQhIAAwXs8QT+qW6vPIBqa1+XD1DgQ5MgANtS3GmqLfkGTiBA3
         cRBw==
X-Gm-Message-State: ABy/qLYkk6TncP3e1/GXgI3fYjEphrz+6m5cyzvYJ5MPY7sBu4mR75LK
        HrqmNy/awzp25B3t5O3ReJL8eQ==
X-Google-Smtp-Source: APBJJlGXZ37ZNT+r0LgYupdqeE60aVZISQuMjkf12+gdCtairiP3dB62U7w0DeY7P+YZ5nKsbvSU6A==
X-Received: by 2002:a17:906:198:b0:98d:f11e:4816 with SMTP id 24-20020a170906019800b0098df11e4816mr795357ejb.29.1688631362038;
        Thu, 06 Jul 2023 01:16:02 -0700 (PDT)
Received: from localhost.localdomain ([82.79.69.144])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090607c800b0099364d9f0e9sm478096ejc.102.2023.07.06.01.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 01:16:01 -0700 (PDT)
From:   Alexandru Ardelean <alex@shruggie.ro>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        olteanv@gmail.com, alex@shruggie.ro, marius.muresan@mxt.ro
Subject: [PATCH 1/2] net: phy: mscc: add support for CLKOUT ctrl reg for VSC8531 and similar
Date:   Thu,  6 Jul 2023 11:15:53 +0300
Message-Id: <20230706081554.1616839-1-alex@shruggie.ro>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VSC8531 and similar PHYs (i.e. VSC8530, VSC8531, VSC8540 & VSC8541)
have a CLKOUT pin on the chip that can be controlled by register (13G in
the General Purpose Registers page) that can be configured to output a
frequency of 25, 50 or 125 Mhz.

This is useful when wanting to provide a clock source for the MAC in some
board designs.

Signed-off-by: Marius Muresan <marius.muresan@mxt.ro>
Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
---

The original patch was done by Marius.
The final (upstream) version was done by Alex.

Tested on VSC8531.

 drivers/net/phy/mscc/mscc.h      |  5 ++++
 drivers/net/phy/mscc/mscc_main.c | 40 ++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index 7a962050a4d4..4ea21921a7ba 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -181,6 +181,11 @@ enum rgmii_clock_delay {
 #define VSC8502_RGMII_TX_DELAY_MASK	  0x0007
 #define VSC8502_RGMII_RX_CLK_DISABLE	  0x0800
 
+/* CKLOUT Control register, for VSC8531 and similar */
+#define VSC8531_CLKOUT_CNTL		  13
+#define VSC8531_CLKOUT_CNTL_ENABLE	  BIT(15)
+#define VSC8531_CLKOUT_CNTL_FREQ_MASK	  GENMASK(14, 13)
+
 #define MSCC_PHY_WOL_LOWER_MAC_ADDR	  21
 #define MSCC_PHY_WOL_MID_MAC_ADDR	  22
 #define MSCC_PHY_WOL_UPPER_MAC_ADDR	  23
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 4171f01d34e5..61c1554935ce 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -618,6 +618,41 @@ static void vsc85xx_tr_write(struct phy_device *phydev, u16 addr, u32 val)
 	__phy_write(phydev, MSCC_PHY_TR_CNTL, TR_WRITE | TR_ADDR(addr));
 }
 
+static int vsc8531_clkout_config(struct phy_device *phydev)
+{
+	static const u32 freq_vals[] = { 25, 50, 125 };
+	struct device *dev = &phydev->mdio.dev;
+	u16 mask, set;
+	u32 freq, i;
+	int rc;
+
+	mask = VSC8531_CLKOUT_CNTL_ENABLE | VSC8531_CLKOUT_CNTL_FREQ_MASK;
+	set = 0;
+
+	if (device_property_read_u32(dev, "vsc8531,clkout-freq-mhz", &freq) == 0) {
+		/* The indices from 'freq_vals' are used in the register */
+		for (i = 0; i < ARRAY_SIZE(freq_vals); i++) {
+			if (freq != freq_vals[i])
+				continue;
+
+			set |= VSC8531_CLKOUT_CNTL_ENABLE |
+			       FIELD_PREP(VSC8531_CLKOUT_CNTL_FREQ_MASK, i);
+			break;
+		}
+		if (set == 0)
+			dev_warn(dev,
+				 "Invalid 'vsc8531,clkout-freq-mhz' value %u\n",
+				 freq);
+	}
+
+	mutex_lock(&phydev->lock);
+	rc = phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_GPIO,
+			      VSC8531_CLKOUT_CNTL, mask, set);
+	mutex_unlock(&phydev->lock);
+
+	return rc;
+}
+
 static int vsc8531_pre_init_seq_set(struct phy_device *phydev)
 {
 	int rc;
@@ -1852,6 +1887,11 @@ static int vsc85xx_config_init(struct phy_device *phydev)
 		rc = vsc8531_pre_init_seq_set(phydev);
 		if (rc)
 			return rc;
+
+		rc = vsc8531_clkout_config(phydev);
+		if (rc)
+			return rc;
+
 	}
 
 	rc = vsc85xx_eee_init_seq_set(phydev);
-- 
2.40.1

