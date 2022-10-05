Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC365F5BBB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiJEVar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiJEVac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:30:32 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801A54DB1B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 14:30:31 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id u28so11052842qku.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 14:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=R2ZKUrFXgP6240cfRnrcVHGBE6FyMef2CoJJC1TNRaY=;
        b=WQ5VZvdty0IFh7yA88+NVxUJ8Ljlwz9CnK+JUAg7YJdg0YQ8w56hb+ds4g3yPZHDew
         rW5i68QTtSjxacyd6AVvcF5m8pPHx4fJs5iS9x9Shmd2oJgoIcHPpsyIaeLiwItrrm9u
         nw40667OLgEpCFXO1tUGEXvwoXyXhB9tgdSr8iTcqu8XcY4kX3T5SRxNeLBrb9CVOblw
         DmZOkyz7hUeLTeDHrYJwA4KN4apuFjnzGz/bScgNVnPJwaoHWqAUfb3E9caaqVQri/aj
         qKMwBdmiRQCHhl447vtFA6qEz5w6GTBnqTjk6utOfqGyRVANOIkCCQf9/JnTJJlPfdrj
         15Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=R2ZKUrFXgP6240cfRnrcVHGBE6FyMef2CoJJC1TNRaY=;
        b=lA2jX12POhm0yqralkFPguTrUk3DCjnJkvG5ncGSVmooAATBzgTxIjba4i0X4ZHHo2
         Rd4aB5EpaedEeetH+MreLrNVQPg3iDqRGKsaIpw6fni+XudHQ09qBkRBeYqrmgcw9N0B
         +BpMdWbPuIvHur8bs0Moxljl4iZhKQRlEtVlbw2R+7DQ2K+T+Q5zch9ZAWdy6nqgSC9p
         wLiiGzzthHXKNR9/ITdazQYqL6jhaUYEKd1uto66lHiMkOSQZ+TFJ3+4Z1lsBEkarT65
         HKvJYxc83jsFG0RkROpgEMVMWuzXhWYiYxyiTLkFEaGeCDkenRyVWoc0akZexMS/v2Ti
         LmIQ==
X-Gm-Message-State: ACrzQf0/emSR1phkdRmbKv2mn2e7IB9btFti4yCJ20IkhJUwu5wBquiM
        YCv1LqFl7HApJf0sqQt3RZs=
X-Google-Smtp-Source: AMsMyM6nSdy12cyHcn97o5dKTimboFCTm3ypGKBPAnCTOaztKz0d2e1saOFfBwI1swn8Q78Ic8BlHA==
X-Received: by 2002:a37:5a04:0:b0:6e0:a338:5f12 with SMTP id o4-20020a375a04000000b006e0a3385f12mr1120701qkb.420.1665005430453;
        Wed, 05 Oct 2022 14:30:30 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s22-20020a05620a255600b006b929a56a2bsm20058566qko.3.2022.10.05.14.30.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2022 14:30:30 -0700 (PDT)
From:   justinpopo6@gmail.com
To:     alcooperx@gmail.com, kishon@ti.com, vkoul@kernel.org,
        f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH 3/6] phy: usb: Migrate to BIT and BITMASK macros
Date:   Wed,  5 Oct 2022 14:30:15 -0700
Message-Id: <1665005418-15807-4-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1665005418-15807-1-git-send-email-justinpopo6@gmail.com>
References: <1665005418-15807-1-git-send-email-justinpopo6@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

Using BIT and BITMASK macros makes it much easier to read and make
modifications. Also reordered some constants to be in numerical order.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c | 68 +++++++++----------
 drivers/phy/broadcom/phy-brcm-usb-init.c          | 80 +++++++++++------------
 2 files changed, 74 insertions(+), 74 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
index 430a8ae..26e9585e 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
@@ -18,14 +18,14 @@
 #define PIARBCTL_CAM			0x00
 #define PIARBCTL_SPLITTER		0x04
 #define PIARBCTL_MISC			0x08
-#define   PIARBCTL_MISC_SECURE_MASK			0x80000000
-#define   PIARBCTL_MISC_USB_SELECT_MASK			0x40000000
-#define   PIARBCTL_MISC_USB_4G_SDRAM_MASK		0x20000000
-#define   PIARBCTL_MISC_USB_PRIORITY_MASK		0x000f0000
-#define   PIARBCTL_MISC_USB_MEM_PAGE_MASK		0x0000f000
-#define   PIARBCTL_MISC_CAM1_MEM_PAGE_MASK		0x00000f00
-#define   PIARBCTL_MISC_CAM0_MEM_PAGE_MASK		0x000000f0
-#define   PIARBCTL_MISC_SATA_PRIORITY_MASK		0x0000000f
+#define   PIARBCTL_MISC_SATA_PRIORITY_MASK		GENMASK(3, 0)
+#define   PIARBCTL_MISC_CAM0_MEM_PAGE_MASK		GENMASK(7, 4)
+#define   PIARBCTL_MISC_CAM1_MEM_PAGE_MASK		GENMASK(11, 8)
+#define   PIARBCTL_MISC_USB_MEM_PAGE_MASK		GENMASK(15, 12)
+#define   PIARBCTL_MISC_USB_PRIORITY_MASK		GENMASK(19, 16)
+#define   PIARBCTL_MISC_USB_4G_SDRAM_MASK		BIT(29)
+#define   PIARBCTL_MISC_USB_SELECT_MASK			BIT(30)
+#define   PIARBCTL_MISC_SECURE_MASK			BIT(31)
 
 #define PIARBCTL_MISC_USB_ONLY_MASK		\
 	(PIARBCTL_MISC_USB_SELECT_MASK |	\
@@ -35,46 +35,46 @@
 
 /* Register definitions for the USB CTRL block */
 #define USB_CTRL_SETUP			0x00
-#define   USB_CTRL_SETUP_STRAP_IPP_SEL_MASK		0x02000000
-#define   USB_CTRL_SETUP_SCB2_EN_MASK			0x00008000
-#define   USB_CTRL_SETUP_tca_drv_sel_MASK		0x01000000
-#define   USB_CTRL_SETUP_SCB1_EN_MASK			0x00004000
-#define   USB_CTRL_SETUP_SOFT_SHUTDOWN_MASK		0x00000200
-#define   USB_CTRL_SETUP_IPP_MASK			0x00000020
-#define   USB_CTRL_SETUP_IOC_MASK			0x00000010
+#define   USB_CTRL_SETUP_IOC_MASK			BIT(4)
+#define   USB_CTRL_SETUP_IPP_MASK			BIT(5)
+#define   USB_CTRL_SETUP_SOFT_SHUTDOWN_MASK		BIT(9)
+#define   USB_CTRL_SETUP_SCB1_EN_MASK			BIT(14)
+#define   USB_CTRL_SETUP_SCB2_EN_MASK			BIT(15)
+#define   USB_CTRL_SETUP_tca_drv_sel_MASK		BIT(24)
+#define   USB_CTRL_SETUP_STRAP_IPP_SEL_MASK		BIT(25)
 #define USB_CTRL_USB_PM			0x04
-#define   USB_CTRL_USB_PM_USB_PWRDN_MASK		0x80000000
-#define   USB_CTRL_USB_PM_SOFT_RESET_MASK		0x40000000
-#define   USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK		0x00800000
-#define   USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK		0x00400000
-#define   USB_CTRL_USB_PM_XHC_PME_EN_MASK		0x00000010
-#define   USB_CTRL_USB_PM_XHC_S2_CLK_SWITCH_EN_MASK	0x00000008
+#define   USB_CTRL_USB_PM_XHC_S2_CLK_SWITCH_EN_MASK	BIT(3)
+#define   USB_CTRL_USB_PM_XHC_PME_EN_MASK		BIT(4)
+#define   USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK		BIT(22)
+#define   USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK		BIT(23)
+#define   USB_CTRL_USB_PM_SOFT_RESET_MASK		BIT(30)
+#define   USB_CTRL_USB_PM_USB_PWRDN_MASK		BIT(31)
 #define USB_CTRL_USB_PM_STATUS		0x08
 #define USB_CTRL_USB_DEVICE_CTL1	0x10
-#define   USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK	0x00000003
+#define   USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK	GENMASK(1, 0)
 #define USB_CTRL_TEST_PORT_CTL		0x30
-#define   USB_CTRL_TEST_PORT_CTL_TPOUT_SEL_MASK	0x000000ff
+#define   USB_CTRL_TEST_PORT_CTL_TPOUT_SEL_MASK		GENMASK(7, 0)
 #define   USB_CTRL_TEST_PORT_CTL_TPOUT_SEL_PME_GEN_MASK	0x0000002e
 #define USB_CTRL_TP_DIAG1		0x34
-#define   USB_CTLR_TP_DIAG1_wake_MASK	0x00000002
+#define   USB_CTLR_TP_DIAG1_wake_MASK			BIT(1)
 #define USB_CTRL_CTLR_CSHCR		0x50
-#define   USB_CTRL_CTLR_CSHCR_ctl_pme_en_MASK	0x00040000
+#define   USB_CTRL_CTLR_CSHCR_ctl_pme_en_MASK		BIT(18)
 
 /* Register definitions for the USB_PHY block in 7211b0 */
 #define USB_PHY_PLL_CTL			0x00
-#define   USB_PHY_PLL_CTL_PLL_RESETB_MASK		0x40000000
+#define   USB_PHY_PLL_CTL_PLL_RESETB_MASK		BIT(30)
 #define USB_PHY_PLL_LDO_CTL		0x08
-#define   USB_PHY_PLL_LDO_CTL_AFE_CORERDY_MASK		0x00000004
-#define   USB_PHY_PLL_LDO_CTL_AFE_LDO_PWRDWNB_MASK	0x00000002
-#define   USB_PHY_PLL_LDO_CTL_AFE_BG_PWRDWNB_MASK	0x00000001
+#define   USB_PHY_PLL_LDO_CTL_AFE_BG_PWRDWNB_MASK	BIT(0)
+#define   USB_PHY_PLL_LDO_CTL_AFE_LDO_PWRDWNB_MASK	BIT(1)
+#define   USB_PHY_PLL_LDO_CTL_AFE_CORERDY_MASK		BIT(2)
 #define USB_PHY_UTMI_CTL_1		0x04
-#define   USB_PHY_UTMI_CTL_1_POWER_UP_FSM_EN_MASK	0x00000800
-#define   USB_PHY_UTMI_CTL_1_PHY_MODE_MASK		0x0000000c
+#define   USB_PHY_UTMI_CTL_1_PHY_MODE_MASK		GENMASK(3, 2)
 #define   USB_PHY_UTMI_CTL_1_PHY_MODE_SHIFT		2
+#define   USB_PHY_UTMI_CTL_1_POWER_UP_FSM_EN_MASK	BIT(11)
 #define USB_PHY_IDDQ			0x1c
-#define   USB_PHY_IDDQ_phy_iddq_MASK			0x00000001
+#define   USB_PHY_IDDQ_phy_iddq_MASK			BIT(0)
 #define USB_PHY_STATUS			0x20
-#define   USB_PHY_STATUS_pll_lock_MASK			0x00000001
+#define   USB_PHY_STATUS_pll_lock_MASK			BIT(0)
 
 /* Register definitions for the MDIO registers in the DWC2 block of
  * the 7211b0.
@@ -86,7 +86,7 @@
 
 /* Register definitions for the BDC EC block in 7211b0 */
 #define BDC_EC_AXIRDA			0x0c
-#define   BDC_EC_AXIRDA_RTS_MASK			0xf0000000
+#define   BDC_EC_AXIRDA_RTS_MASK			GENMASK(31, 28)
 #define   BDC_EC_AXIRDA_RTS_SHIFT			28
 
 
diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadcom/phy-brcm-usb-init.c
index a7f8b3d..a1ca833 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
@@ -21,57 +21,57 @@
 
 /* Register definitions for the USB CTRL block */
 #define USB_CTRL_SETUP			0x00
-#define   USB_CTRL_SETUP_IOC_MASK			0x00000010
-#define   USB_CTRL_SETUP_IPP_MASK			0x00000020
-#define   USB_CTRL_SETUP_BABO_MASK			0x00000001
-#define   USB_CTRL_SETUP_FNHW_MASK			0x00000002
-#define   USB_CTRL_SETUP_FNBO_MASK			0x00000004
-#define   USB_CTRL_SETUP_WABO_MASK			0x00000008
-#define   USB_CTRL_SETUP_SCB_CLIENT_SWAP_MASK		0x00002000 /* option */
-#define   USB_CTRL_SETUP_SCB1_EN_MASK			0x00004000 /* option */
-#define   USB_CTRL_SETUP_SCB2_EN_MASK			0x00008000 /* option */
-#define   USB_CTRL_SETUP_SS_EHCI64BIT_EN_MASK		0X00020000 /* option */
-#define   USB_CTRL_SETUP_SS_EHCI64BIT_EN_VAR_MASK	0x00010000 /* option */
-#define   USB_CTRL_SETUP_STRAP_IPP_SEL_MASK		0x02000000 /* option */
-#define   USB_CTRL_SETUP_CC_DRD_MODE_ENABLE_MASK	0x04000000 /* option */
-#define   USB_CTRL_SETUP_STRAP_CC_DRD_MODE_ENABLE_SEL_MASK 0x08000000 /* opt */
-#define   USB_CTRL_SETUP_OC3_DISABLE_MASK		0xc0000000 /* option */
+#define   USB_CTRL_SETUP_BABO_MASK			BIT(0)
+#define   USB_CTRL_SETUP_FNHW_MASK			BIT(1)
+#define   USB_CTRL_SETUP_FNBO_MASK			BIT(2)
+#define   USB_CTRL_SETUP_WABO_MASK			BIT(3)
+#define   USB_CTRL_SETUP_IOC_MASK			BIT(4)
+#define   USB_CTRL_SETUP_IPP_MASK			BIT(5)
+#define   USB_CTRL_SETUP_SCB_CLIENT_SWAP_MASK		BIT(13) /* option */
+#define   USB_CTRL_SETUP_SCB1_EN_MASK			BIT(14) /* option */
+#define   USB_CTRL_SETUP_SCB2_EN_MASK			BIT(15) /* option */
+#define   USB_CTRL_SETUP_SS_EHCI64BIT_EN_MASK		BIT(17) /* option */
+#define   USB_CTRL_SETUP_SS_EHCI64BIT_EN_VAR_MASK	BIT(16) /* option */
+#define   USB_CTRL_SETUP_STRAP_IPP_SEL_MASK		BIT(25) /* option */
+#define   USB_CTRL_SETUP_CC_DRD_MODE_ENABLE_MASK	BIT(26) /* option */
+#define   USB_CTRL_SETUP_STRAP_CC_DRD_MODE_ENABLE_SEL_MASK BIT(27) /* opt */
+#define   USB_CTRL_SETUP_OC3_DISABLE_MASK		GENMASK(31, 30) /* option */
 #define USB_CTRL_PLL_CTL		0x04
-#define   USB_CTRL_PLL_CTL_PLL_SUSPEND_EN_MASK		0x08000000
-#define   USB_CTRL_PLL_CTL_PLL_RESETB_MASK		0x40000000
-#define   USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK		0x80000000 /* option */
+#define   USB_CTRL_PLL_CTL_PLL_SUSPEND_EN_MASK		BIT(27)
+#define   USB_CTRL_PLL_CTL_PLL_RESETB_MASK		BIT(30)
+#define   USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK		BIT(31) /* option */
 #define USB_CTRL_EBRIDGE		0x0c
-#define   USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK		0x00020000 /* option */
-#define   USB_CTRL_EBRIDGE_EBR_SCB_SIZE_MASK		0x00000f80 /* option */
+#define   USB_CTRL_EBRIDGE_EBR_SCB_SIZE_MASK		GENMASK(11, 7) /* option */
+#define   USB_CTRL_EBRIDGE_ESTOP_SCB_REQ_MASK		BIT(17) /* option */
 #define USB_CTRL_OBRIDGE		0x10
-#define   USB_CTRL_OBRIDGE_LS_KEEP_ALIVE_MASK		0x08000000
+#define   USB_CTRL_OBRIDGE_LS_KEEP_ALIVE_MASK		BIT(27)
 #define USB_CTRL_MDIO			0x14
 #define USB_CTRL_MDIO2			0x18
 #define USB_CTRL_UTMI_CTL_1		0x2c
-#define   USB_CTRL_UTMI_CTL_1_POWER_UP_FSM_EN_MASK	0x00000800
-#define   USB_CTRL_UTMI_CTL_1_POWER_UP_FSM_EN_P1_MASK	0x08000000
+#define   USB_CTRL_UTMI_CTL_1_POWER_UP_FSM_EN_MASK	BIT(11)
+#define   USB_CTRL_UTMI_CTL_1_POWER_UP_FSM_EN_P1_MASK	BIT(27)
 #define USB_CTRL_USB_PM			0x34
-#define   USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK		0x00800000 /* option */
-#define   USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK		0x00400000 /* option */
-#define   USB_CTRL_USB_PM_XHC_SOFT_RESETB_VAR_MASK	0x40000000 /* option */
-#define   USB_CTRL_USB_PM_USB_PWRDN_MASK		0x80000000 /* option */
-#define   USB_CTRL_USB_PM_SOFT_RESET_MASK		0x40000000 /* option */
-#define   USB_CTRL_USB_PM_USB20_HC_RESETB_MASK		0x30000000 /* option */
-#define   USB_CTRL_USB_PM_USB20_HC_RESETB_VAR_MASK	0x00300000 /* option */
-#define   USB_CTRL_USB_PM_RMTWKUP_EN_MASK		0x00000001
+#define   USB_CTRL_USB_PM_RMTWKUP_EN_MASK		BIT(0)
+#define   USB_CTRL_USB_PM_USB20_HC_RESETB_VAR_MASK	GENMASK(21, 20) /* option */
+#define   USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK		BIT(22) /* option */
+#define   USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK		BIT(23) /* option */
+#define   USB_CTRL_USB_PM_USB20_HC_RESETB_MASK		GENMASK(29, 28) /* option */
+#define   USB_CTRL_USB_PM_XHC_SOFT_RESETB_VAR_MASK	BIT(30) /* option */
+#define   USB_CTRL_USB_PM_SOFT_RESET_MASK		BIT(30) /* option */
+#define   USB_CTRL_USB_PM_USB_PWRDN_MASK		BIT(31) /* option */
 #define USB_CTRL_USB_PM_STATUS		0x38
 #define USB_CTRL_USB30_CTL1		0x60
-#define   USB_CTRL_USB30_CTL1_PHY3_PLL_SEQ_START_MASK	0x00000010
-#define   USB_CTRL_USB30_CTL1_PHY3_RESETB_MASK		0x00010000
-#define   USB_CTRL_USB30_CTL1_XHC_SOFT_RESETB_MASK	0x00020000 /* option */
-#define   USB_CTRL_USB30_CTL1_USB3_IOC_MASK		0x10000000 /* option */
-#define   USB_CTRL_USB30_CTL1_USB3_IPP_MASK		0x20000000 /* option */
+#define   USB_CTRL_USB30_CTL1_PHY3_PLL_SEQ_START_MASK	BIT(4)
+#define   USB_CTRL_USB30_CTL1_PHY3_RESETB_MASK		BIT(16)
+#define   USB_CTRL_USB30_CTL1_XHC_SOFT_RESETB_MASK	BIT(17) /* option */
+#define   USB_CTRL_USB30_CTL1_USB3_IOC_MASK		BIT(28) /* option */
+#define   USB_CTRL_USB30_CTL1_USB3_IPP_MASK		BIT(29) /* option */
 #define USB_CTRL_USB30_PCTL		0x70
-#define   USB_CTRL_USB30_PCTL_PHY3_SOFT_RESETB_MASK	0x00000002
-#define   USB_CTRL_USB30_PCTL_PHY3_IDDQ_OVERRIDE_MASK	0x00008000
-#define   USB_CTRL_USB30_PCTL_PHY3_SOFT_RESETB_P1_MASK	0x00020000
+#define   USB_CTRL_USB30_PCTL_PHY3_SOFT_RESETB_MASK	BIT(1)
+#define   USB_CTRL_USB30_PCTL_PHY3_IDDQ_OVERRIDE_MASK	BIT(15)
+#define   USB_CTRL_USB30_PCTL_PHY3_SOFT_RESETB_P1_MASK	BIT(17)
 #define USB_CTRL_USB_DEVICE_CTL1	0x90
-#define   USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK	0x00000003 /* option */
+#define   USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK	GENMASK(1, 0) /* option */
 
 /* Register definitions for the XHCI EC block */
 #define USB_XHCI_EC_IRAADR 0x658
-- 
2.7.4

