Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4611674C57A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjGIPQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjGIPPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:15:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0017210C7;
        Sun,  9 Jul 2023 08:14:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 426DA60C3E;
        Sun,  9 Jul 2023 15:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9B6C433B9;
        Sun,  9 Jul 2023 15:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915643;
        bh=s/Cb8Zm+6Qly1ZMy/ulzm3Pf5rMTvuUA8VEfjYDv+pQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KPqa0h2bHsz6QeXukBQBVIiMmPVED0dIU/bccwxR6/6nmeEt6J5aL1/FR++y4+fLy
         VWIhjWRAslsctKEHxGkGIcHVd2a1yAT7NITenrV1z3FKEAUpNAW+KSVYTUZMSR2vOd
         Fu42Dq6eoBExaiR+ZICs7vPEBrX7C6lGsq+5pS9z+iESwoZv5KR2kT75Bi1Q4o2EuQ
         j7Dsyjv/bI+bp/kkya3R4XgEtcvDRzZayp7CB2T1nUtG38KhlkfGaFhNraRW9peZwN
         KxNZ7WQTL/gDXa6wDWhOkcc095boRC5zHeWa9ZIi9VsxNZiKFDuFJ6MgsJn+R/ecdt
         HOlPdP07l58ng==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 03/22] wifi: rtw89: 8851be: add 8851BE PCI entry and fill PCI capabilities
Date:   Sun,  9 Jul 2023 11:13:37 -0400
Message-Id: <20230709151356.513279-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151356.513279-1-sashal@kernel.org>
References: <20230709151356.513279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 99ff8da56322cda9eb9b37021e27b127c2d1cad8 ]

Add PCI entry to 8851BE with its device ID 10ec:b851, also fill PCI info
according to its capabilities.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230421024551.29994-3-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/realtek/rtw89/rtw8851be.c    | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851be.c

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
new file mode 100644
index 0000000000000..0f7711c50bd15
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2022-2023  Realtek Corporation
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "pci.h"
+#include "reg.h"
+#include "rtw8851b.h"
+
+static const struct rtw89_pci_info rtw8851b_pci_info = {
+	.txbd_trunc_mode	= MAC_AX_BD_TRUNC,
+	.rxbd_trunc_mode	= MAC_AX_BD_TRUNC,
+	.rxbd_mode		= MAC_AX_RXBD_PKT,
+	.tag_mode		= MAC_AX_TAG_MULTI,
+	.tx_burst		= MAC_AX_TX_BURST_2048B,
+	.rx_burst		= MAC_AX_RX_BURST_128B,
+	.wd_dma_idle_intvl	= MAC_AX_WD_DMA_INTVL_256NS,
+	.wd_dma_act_intvl	= MAC_AX_WD_DMA_INTVL_256NS,
+	.multi_tag_num		= MAC_AX_TAG_NUM_8,
+	.lbc_en			= MAC_AX_PCIE_ENABLE,
+	.lbc_tmr		= MAC_AX_LBC_TMR_2MS,
+	.autok_en		= MAC_AX_PCIE_DISABLE,
+	.io_rcy_en		= MAC_AX_PCIE_DISABLE,
+	.io_rcy_tmr		= MAC_AX_IO_RCY_ANA_TMR_6MS,
+
+	.init_cfg_reg		= R_AX_PCIE_INIT_CFG1,
+	.txhci_en_bit		= B_AX_TXHCI_EN,
+	.rxhci_en_bit		= B_AX_RXHCI_EN,
+	.rxbd_mode_bit		= B_AX_RXBD_MODE,
+	.exp_ctrl_reg		= R_AX_PCIE_EXP_CTRL,
+	.max_tag_num_mask	= B_AX_MAX_TAG_NUM,
+	.rxbd_rwptr_clr_reg	= R_AX_RXBD_RWPTR_CLR,
+	.txbd_rwptr_clr2_reg	= 0,
+	.dma_stop1		= {R_AX_PCIE_DMA_STOP1, B_AX_TX_STOP1_MASK_V1},
+	.dma_stop2		= {0},
+	.dma_busy1		= {R_AX_PCIE_DMA_BUSY1, DMA_BUSY1_CHECK_V1},
+	.dma_busy2_reg		= 0,
+	.dma_busy3_reg		= R_AX_PCIE_DMA_BUSY1,
+
+	.rpwm_addr		= R_AX_PCIE_HRPWM,
+	.cpwm_addr		= R_AX_CPWM,
+	.tx_dma_ch_mask		= BIT(RTW89_TXCH_ACH4) | BIT(RTW89_TXCH_ACH5) |
+				  BIT(RTW89_TXCH_ACH6) | BIT(RTW89_TXCH_ACH7) |
+				  BIT(RTW89_TXCH_CH10) | BIT(RTW89_TXCH_CH11),
+	.bd_idx_addr_low_power	= NULL,
+	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set,
+	.bd_ram_table		= &rtw89_bd_ram_table_single,
+
+	.ltr_set		= rtw89_pci_ltr_set,
+	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info,
+	.config_intr_mask	= rtw89_pci_config_intr_mask,
+	.enable_intr		= rtw89_pci_enable_intr,
+	.disable_intr		= rtw89_pci_disable_intr,
+	.recognize_intrs	= rtw89_pci_recognize_intrs,
+};
+
+static const struct rtw89_driver_info rtw89_8851be_info = {
+	.chip = &rtw8851b_chip_info,
+	.bus = {
+		.pci = &rtw8851b_pci_info,
+	},
+};
+
+static const struct pci_device_id rtw89_8851be_id_table[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0xb851),
+		.driver_data = (kernel_ulong_t)&rtw89_8851be_info,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(pci, rtw89_8851be_id_table);
+
+static struct pci_driver rtw89_8851be_driver = {
+	.name		= "rtw89_8851be",
+	.id_table	= rtw89_8851be_id_table,
+	.probe		= rtw89_pci_probe,
+	.remove		= rtw89_pci_remove,
+	.driver.pm	= &rtw89_pm_ops,
+};
+module_pci_driver(rtw89_8851be_driver);
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11ax wireless 8851BE driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.39.2

