Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6025FED6D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJNLsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiJNLrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:47:48 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A4B103261;
        Fri, 14 Oct 2022 04:47:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id i3so4661036pfk.9;
        Fri, 14 Oct 2022 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IgPegljF0RLQpEgdiqez/xPme+wwmfVw0dJ4ckzbm8=;
        b=hjPRwFaY8TmlpqvsgrhlUUhUEJZs1f6BWnI0q7ZSHRgLgrWOWqAP0v5TFCkUdBUW5G
         EhfeKxxwwhu0xvalEr21olbp3EiwmnPG1vMJIoK4JiF2G+u22g3by4/LqjDbD6C12w/7
         uHixgp2KR0jM9UVvqUWnsMQT8/IFrZk0zp2p9GeGuSPkwv2evVh/GZskJ6ES7ziq9o04
         B5+ZdthiXlENA4QeKeaP9dlqdzF4FfOXFOkd3I8v2FmcE9BsOLnHbsTeTIR/kMwyBvFU
         oU7mzMwbqjEuF0xt3FpIpaWu6i0w037N+K14qQzBkILsjewSqCukVc5ysttdG1LjLxws
         lD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IgPegljF0RLQpEgdiqez/xPme+wwmfVw0dJ4ckzbm8=;
        b=AeAaLON7+cP8sLgcjghoU9eok02n45Doa93RAF0IIZ+lMbl1ujY8+1vPPh7RJ+eNX0
         13HsjAjuvhpvWTv7LbexX9CvGdQd05vaQCVtXxpmSQ7KfSW+KUsiyymD13HFVOCILqxR
         YT/tPPewQOt47LP6UMZlPXWFYKff0PCKVFbOuZP8n1Y1SrDg4UZ3NAewf+qTcAlTH6Up
         v3msPJ/7W5+agzI+DGcL72IkVm0nIsSyAzq743FifMpiq267HqvTVaKObHXHwG+chgpf
         x0JrsL3lhoGU9cSHQQUPxkSlBSesirSRnaZYCTFqiPXuusHRczGqT5YwbapA2mNK2Zaf
         PHFQ==
X-Gm-Message-State: ACrzQf1L5NoVpJBst6Ytgn5khHnHFE9oakZ5q8iQqIfRAzOOX1er8Oyi
        NsJQK/k6b4n5TGdoFWwkU0k=
X-Google-Smtp-Source: AMsMyM7eUfeHyfVlct3+P7ayJRiTZXmkh/kCP95gXq6d2cmAoUUHQYfoy0OsscfvFZFQEudDSCtKaQ==
X-Received: by 2002:a63:2cd2:0:b0:41c:5901:67d8 with SMTP id s201-20020a632cd2000000b0041c590167d8mr4215588pgs.365.1665748053546;
        Fri, 14 Oct 2022 04:47:33 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-2aaa-c1aa-06c8-0e68-c5ee.emome-ip6.hinet.net. [2001:b400:e282:2aaa:c1aa:6c8:e68:c5ee])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b001746f66244asm1606678plg.18.2022.10.14.04.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:47:33 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 08/26] mmc: sdhci: add UHS-II related definitions in headers
Date:   Fri, 14 Oct 2022 19:45:43 +0800
Message-Id: <20221014114601.15594-9-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
References: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UHS-II related definitions in shdci.h and sdhci-uhs2.h.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.h | 210 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h      |  73 +++++++++++-
 2 files changed, 282 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/host/sdhci-uhs2.h

diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
new file mode 100644
index 000000000000..5610affebdf3
--- /dev/null
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -0,0 +1,210 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  linux/drivers/mmc/host/sdhci-uhs2.h - Secure Digital Host Controller
+ *  Interface driver
+ *
+ * Header file for Host Controller UHS2 related registers and I/O accessors.
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ */
+#ifndef __SDHCI_UHS2_H
+#define __SDHCI_UHS2_H
+
+#include <linux/bits.h>
+
+/*
+ * UHS-II Controller registers
+ * 0x74 preset in sdhci.h
+ * 0x80
+ * 0x84-0xB4
+ * 0xB8-0xCF
+ * 0xE0-0xE7
+ */
+/* UHS2 */
+#define SDHCI_UHS2_BLOCK_SIZE	0x80
+#define  SDHCI_UHS2_MAKE_BLKSZ(dma, blksz) \
+	((((dma) & 0x7) << 12) | ((blksz) & 0xFFF))
+
+#define SDHCI_UHS2_BLOCK_COUNT	0x84
+
+#define SDHCI_UHS2_CMD_PACKET	0x88
+#define  SDHCI_UHS2_CMD_PACK_MAX_LEN	20
+
+#define SDHCI_UHS2_TRANS_MODE	0x9C
+#define  SDHCI_UHS2_TRNS_DMA		BIT(0)
+#define  SDHCI_UHS2_TRNS_BLK_CNT_EN	BIT(1)
+#define  SDHCI_UHS2_TRNS_DATA_TRNS_WRT	BIT(4)
+#define  SDHCI_UHS2_TRNS_BLK_BYTE_MODE	BIT(5)
+#define  SDHCI_UHS2_TRNS_RES_R5		BIT(6)
+#define  SDHCI_UHS2_TRNS_RES_ERR_CHECK_EN	BIT(7)
+#define  SDHCI_UHS2_TRNS_RES_INT_DIS	BIT(8)
+#define  SDHCI_UHS2_TRNS_WAIT_EBSY	BIT(14)
+#define  SDHCI_UHS2_TRNS_2L_HD		BIT(15)
+
+#define SDHCI_UHS2_COMMAND	0x9E
+#define  SDHCI_UHS2_COMMAND_SUB_CMD	0x0004
+#define  SDHCI_UHS2_COMMAND_DATA	0x0020
+#define  SDHCI_UHS2_COMMAND_TRNS_ABORT	0x0040
+#define  SDHCI_UHS2_COMMAND_CMD12	0x0080
+#define  SDHCI_UHS2_COMMAND_DORMANT	0x00C0
+#define  SDHCI_UHS2_COMMAND_PACK_LEN_MASK	GENMASK(12, 8)
+#define  SDHCI_UHS2_COMMAND_PACK_LEN_SHIFT	8
+
+#define SDHCI_UHS2_RESPONSE	0xA0
+#define  SDHCI_UHS2_RESPONSE_MAX_LEN	20
+
+#define SDHCI_UHS2_MSG_SELECT	0xB4
+#define SDHCI_UHS2_MSG_SELECT_CURR	0x0
+#define SDHCI_UHS2_MSG_SELECT_ONE	0x1
+#define SDHCI_UHS2_MSG_SELECT_TWO	0x2
+#define SDHCI_UHS2_MSG_SELECT_THREE	0x3
+
+#define SDHCI_UHS2_MSG		0xB8
+
+#define SDHCI_UHS2_DEV_INT_STATUS	0xBC
+
+#define SDHCI_UHS2_DEV_SELECT	0xBE
+#define SDHCI_UHS2_DEV_SELECT_DEV_SEL_MASK	GENMASK(3, 0)
+#define SDHCI_UHS2_DEV_SELECT_INT_MSG_EN	BIT(7)
+
+#define SDHCI_UHS2_DEV_INT_CODE	0xBF
+
+#define SDHCI_UHS2_SW_RESET	0xC0
+#define SDHCI_UHS2_SW_RESET_FULL	0x0001
+#define SDHCI_UHS2_SW_RESET_SD		0x0002
+
+#define SDHCI_UHS2_TIMER_CTRL	0xC2
+#define SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT	4
+
+#define SDHCI_UHS2_ERR_INT_STATUS		0xC4
+#define SDHCI_UHS2_ERR_INT_STATUS_EN		0xC8
+#define SDHCI_UHS2_ERR_INT_SIG_EN		0xCC
+#define SDHCI_UHS2_ERR_INT_STATUS_HEADER	BIT(0)
+#define SDHCI_UHS2_ERR_INT_STATUS_RES		BIT(1)
+#define SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP	BIT(2)
+#define SDHCI_UHS2_ERR_INT_STATUS_CRC		BIT(3)
+#define SDHCI_UHS2_ERR_INT_STATUS_FRAME		BIT(4)
+#define SDHCI_UHS2_ERR_INT_STATUS_TID		BIT(5)
+#define SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER	BIT(7)
+#define SDHCI_UHS2_ERR_INT_STATUS_EBUSY		BIT(8)
+#define SDHCI_UHS2_ERR_INT_STATUS_ADMA		BIT(15)
+#define SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT	BIT(16)
+#define SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT	BIT(17)
+#define SDHCI_UHS2_ERR_INT_STATUS_VENDOR	BIT(27)
+#define SDHCI_UHS2_ERR_INT_STATUS_MASK	\
+		(SDHCI_UHS2_ERR_INT_STATUS_HEADER |	\
+		SDHCI_UHS2_ERR_INT_STATUS_RES |		\
+		SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP |	\
+		SDHCI_UHS2_ERR_INT_STATUS_CRC |		\
+		SDHCI_UHS2_ERR_INT_STATUS_FRAME |	\
+		SDHCI_UHS2_ERR_INT_STATUS_TID |		\
+		SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER |	\
+		SDHCI_UHS2_ERR_INT_STATUS_EBUSY |	\
+		SDHCI_UHS2_ERR_INT_STATUS_ADMA |	\
+		SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT |	\
+		SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT)
+#define SDHCI_UHS2_ERR_INT_STATUS_CMD_MASK	\
+		(SDHCI_UHS2_ERR_INT_STATUS_HEADER |	\
+		SDHCI_UHS2_ERR_INT_STATUS_RES |		\
+		SDHCI_UHS2_ERR_INT_STATUS_FRAME |	\
+		SDHCI_UHS2_ERR_INT_STATUS_TID |		\
+		SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT)
+/* CRC Error occurs during a packet receiving */
+#define SDHCI_UHS2_ERR_INT_STATUS_DATA_MASK	\
+		(SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP |	\
+		SDHCI_UHS2_ERR_INT_STATUS_CRC |		\
+		SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER |	\
+		SDHCI_UHS2_ERR_INT_STATUS_EBUSY |	\
+		SDHCI_UHS2_ERR_INT_STATUS_ADMA |	\
+		SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT)
+
+#define SDHCI_UHS2_SET_PTR	0xE0
+#define   SDHCI_UHS2_GEN_SET_POWER_LOW		0x0001
+#define   SDHCI_UHS2_GEN_SET_N_LANES_POS	8
+#define   SDHCI_UHS2_GEN_SET_2L_FD_HD		0x0
+#define   SDHCI_UHS2_GEN_SET_2D1U_FD		0x2
+#define   SDHCI_UHS2_GEN_SET_1D2U_FD		0x3
+#define   SDHCI_UHS2_GEN_SET_2D2U_FD		0x4
+
+#define   SDHCI_UHS2_PHY_SET_SPEED_POS		6
+#define   SDHCI_UHS2_PHY_SET_HIBER_EN		BIT(12)
+#define   SDHCI_UHS2_PHY_SET_N_LSS_SYN_MASK	GENMASK(19, 16)
+#define   SDHCI_UHS2_PHY_SET_N_LSS_SYN_POS	16
+#define   SDHCI_UHS2_PHY_SET_N_LSS_DIR_MASK	GENMASK(23, 20)
+#define   SDHCI_UHS2_PHY_SET_N_LSS_DIR_POS	20
+
+#define   SDHCI_UHS2_TRAN_SET_N_FCU_MASK	GENMASK(15, 8)
+#define   SDHCI_UHS2_TRAN_SET_N_FCU_POS		8
+#define   SDHCI_UHS2_TRAN_SET_RETRY_CNT_MASK	GENMASK(17, 16)
+#define   SDHCI_UHS2_TRAN_SET_RETRY_CNT_POS	16
+
+#define   SDHCI_UHS2_TRAN_SET_1_N_DAT_GAP_MASK	GENMASK(7, 0)
+
+#define SDHCI_UHS2_HOST_CAPS_PTR	0xE2
+#define  SDHCI_UHS2_HOST_CAPS_GEN_OFFSET	0
+#define   SDHCI_UHS2_HOST_CAPS_GEN_DAP_MASK	GENMASK(3, 0)
+#define   SDHCI_UHS2_HOST_CAPS_GEN_GAP_MASK	GENMASK(7, 4)
+#define   SDHCI_UHS2_HOST_CAPS_GEN_GAP(gap)	((gap) * 360)
+#define SDHCI_UHS2_HOST_CAPS_GEN_GAP_SHIFT 4
+#define   SDHCI_UHS2_HOST_CAPS_GEN_LANE_MASK	GENMASK(13, 8)
+#define   SDHCI_UHS2_HOST_CAPS_GEN_LANE_SHIFT	8
+#define    SDHCI_UHS2_HOST_CAPS_GEN_2L_HD_FD	1
+#define    SDHCI_UHS2_HOST_CAPS_GEN_2D1U_FD	2
+#define    SDHCI_UHS2_HOST_CAPS_GEN_1D2U_FD	4
+#define    SDHCI_UHS2_HOST_CAPS_GEN_2D2U_FD	8
+#define   SDHCI_UHS2_HOST_CAPS_GEN_ADDR_64	BIT(14)
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BOOT		BIT(15)
+#define   SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_MASK	GENMASK(17, 16)
+#define   SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_SHIFT	16
+#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_RMV	0
+#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_EMB	1
+#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_EMB_RMV	2
+#define   SDHCI_UHS2_HOST_CAPS_GEN_NUM_DEV_MASK		GENMASK(21, 18)
+#define   SDHCI_UHS2_HOST_CAPS_GEN_NUM_DEV_SHIFT	18
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_MASK	GENMASK(23, 22)
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_SHIFT	22
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_P2P		0
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_RING	1
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_HUB		2
+#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_HUB_RING	3
+
+#define  SDHCI_UHS2_HOST_CAPS_PHY_OFFSET	4
+#define   SDHCI_UHS2_HOST_CAPS_PHY_REV_MASK		GENMASK(5, 0)
+#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_MASK		GENMASK(7, 6)
+#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_SHIFT		6
+#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_A		0
+#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_B		1
+#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_MASK	GENMASK(19, 16)
+#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_SHIFT	16
+#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_MASK	GENMASK(23, 20)
+#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_SHIFT	20
+#define  SDHCI_UHS2_HOST_CAPS_TRAN_OFFSET	8
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_LINK_REV_MASK	GENMASK(5, 0)
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_MASK		GENMASK(15, 8)
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_SHIFT		8
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_MASK	GENMASK(18, 16)
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_SHIFT	16
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_MASK	GENMASK(31, 20)
+#define   SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_SHIFT	20
+
+#define  SDHCI_UHS2_HOST_CAPS_TRAN_1_OFFSET	12
+#define  SDHCI_UHS2_HOST_CAPS_TRAN_1_N_DATA_GAP_MASK	GENMASK(7, 0)
+
+#define SDHCI_UHS2_TEST_PTR	0xE4
+#define  SDHCI_UHS2_TEST_ERR_HEADER	BIT(0)
+#define  SDHCI_UHS2_TEST_ERR_RES	BIT(1)
+#define  SDHCI_UHS2_TEST_ERR_RETRY_EXP	BIT(2)
+#define  SDHCI_UHS2_TEST_ERR_CRC	BIT(3)
+#define  SDHCI_UHS2_TEST_ERR_FRAME	BIT(4)
+#define  SDHCI_UHS2_TEST_ERR_TID	BIT(5)
+#define  SDHCI_UHS2_TEST_ERR_UNRECOVER	BIT(7)
+#define  SDHCI_UHS2_TEST_ERR_EBUSY	BIT(8)
+#define  SDHCI_UHS2_TEST_ERR_ADMA	BIT(15)
+#define  SDHCI_UHS2_TEST_ERR_RES_TIMEOUT	BIT(16)
+#define  SDHCI_UHS2_TEST_ERR_DEADLOCK_TIMEOUT	BIT(17)
+#define  SDHCI_UHS2_TEST_ERR_VENDOR	BIT(27)
+
+#define SDHCI_UHS2_EMBED_CTRL	0xE6
+#define SDHCI_UHS2_VENDOR	0xE8
+
+#endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 95a08f09df30..64c2d7e78e29 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -43,8 +43,27 @@
 #define  SDHCI_TRNS_READ	0x10
 #define  SDHCI_TRNS_MULTI	0x20
 
+/*
+ * Defined in Host Version 4.10.
+ * 1 - R5 (SDIO)
+ * 0 - R1 (Memory)
+ */
+#define  SDHCI_TRNS_RES_TYPE		0x40
+#define  SDHCI_TRNS_RES_ERR_CHECK	0x80
+#define  SDHCI_TRNS_RES_INT_DIS		0x0100
+
 #define SDHCI_COMMAND		0x0E
 #define  SDHCI_CMD_RESP_MASK	0x03
+
+/*
+ * Host Version 4.10 adds this bit to distinguish a main command or
+ * sub command.
+ * CMD53(SDIO) - main command
+ * CMD52(SDIO) - sub command which doesn't have data block or doesn't
+ * indicate busy.
+ */
+#define  SDHCI_CMD_SUB_CMD	0x04
+
 #define  SDHCI_CMD_CRC		0x08
 #define  SDHCI_CMD_INDEX	0x10
 #define  SDHCI_CMD_DATA		0x20
@@ -60,11 +79,19 @@
 
 #define SDHCI_RESPONSE		0x10
 
+#define  SDHCI_RESPONSE_CM_TRAN_ABORT_OFFSET	0x10
+#define  SDHCI_RESPONSE_CM_TRAN_ABORT_SIZE	4
+#define  SDHCI_RESPONSE_SD_TRAN_ABORT_OFFSET	0x18
+#define  SDHCI_RESPONSE_SD_TRAN_ABORT_SIZE	8
+
 #define SDHCI_BUFFER		0x20
 
 #define SDHCI_PRESENT_STATE	0x24
 #define  SDHCI_CMD_INHIBIT	0x00000001
 #define  SDHCI_DATA_INHIBIT	0x00000002
+
+#define  SDHCI_DATA_HIGH_LVL_MASK	0x000000F0
+
 #define  SDHCI_DOING_WRITE	0x00000100
 #define  SDHCI_DOING_READ	0x00000200
 #define  SDHCI_SPACE_AVAILABLE	0x00000400
@@ -80,6 +107,13 @@
 #define   SDHCI_DATA_0_LVL_MASK	0x00100000
 #define  SDHCI_CMD_LVL		0x01000000
 
+#define  SDHCI_HOST_REGULATOR_STABLE	0x02000000
+#define  SDHCI_CMD_NOT_ISSUE_ERR	0x08000000
+#define  SDHCI_SUB_CMD_STATUS		0x10000000
+#define  SDHCI_UHS2_IN_DORMANT_STATE	0x20000000
+#define  SDHCI_UHS2_LANE_SYNC		0x40000000
+#define  SDHCI_UHS2_IF_DETECT		0x80000000
+
 #define SDHCI_HOST_CONTROL	0x28
 #define  SDHCI_CTRL_LED		0x01
 #define  SDHCI_CTRL_4BITBUS	0x02
@@ -100,6 +134,11 @@
 #define  SDHCI_POWER_300	0x0C
 #define  SDHCI_POWER_330	0x0E
 
+/* VDD2 - UHS2 */
+#define  SDHCI_VDD2_POWER_ON		0x10
+#define  SDHCI_VDD2_POWER_180		0xA0
+#define  SDHCI_VDD2_POWER_120		0x80
+
 #define SDHCI_BLOCK_GAP_CONTROL	0x2A
 
 #define SDHCI_WAKE_UP_CONTROL	0x2B
@@ -110,7 +149,7 @@
 #define SDHCI_CLOCK_CONTROL	0x2C
 #define  SDHCI_DIVIDER_SHIFT	8
 #define  SDHCI_DIVIDER_HI_SHIFT	6
-#define  SDHCI_DIV_MASK	0xFF
+#define  SDHCI_DIV_MASK		0xFF
 #define  SDHCI_DIV_MASK_LEN	8
 #define  SDHCI_DIV_HI_MASK	0x300
 #define  SDHCI_PROG_CLOCK_MODE	0x0020
@@ -139,6 +178,10 @@
 #define  SDHCI_INT_CARD_REMOVE	0x00000080
 #define  SDHCI_INT_CARD_INT	0x00000100
 #define  SDHCI_INT_RETUNE	0x00001000
+
+/* Host Version 4.10 */
+#define  SDHCI_INT_FX_EVENT	0x00002000
+
 #define  SDHCI_INT_CQE		0x00004000
 #define  SDHCI_INT_ERROR	0x00008000
 #define  SDHCI_INT_TIMEOUT	0x00010000
@@ -152,6 +195,9 @@
 #define  SDHCI_INT_AUTO_CMD_ERR	0x01000000
 #define  SDHCI_INT_ADMA_ERROR	0x02000000
 
+/* Host Version 4.0 */
+#define  SDHCI_INT_RESPONSE_ERROR	0x08000000
+
 #define  SDHCI_INT_NORMAL_MASK	0x00007FFF
 #define  SDHCI_INT_ERROR_MASK	0xFFFF8000
 
@@ -178,6 +224,9 @@
 #define  SDHCI_AUTO_CMD_END_BIT	0x00000008
 #define  SDHCI_AUTO_CMD_INDEX	0x00000010
 
+/* Host Version 4.10 */
+#define  SDHCI_ACMD_RESPONSE_ERROR	0x0020
+
 #define SDHCI_HOST_CONTROL2		0x3E
 #define  SDHCI_CTRL_UHS_MASK		0x0007
 #define   SDHCI_CTRL_UHS_SDR12		0x0000
@@ -186,6 +235,7 @@
 #define   SDHCI_CTRL_UHS_SDR104		0x0003
 #define   SDHCI_CTRL_UHS_DDR50		0x0004
 #define   SDHCI_CTRL_HS400		0x0005 /* Non-standard */
+#define   SDHCI_CTRL_UHS_2		0x0007 /* UHS-2 */
 #define  SDHCI_CTRL_VDD_180		0x0008
 #define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
 #define   SDHCI_CTRL_DRV_TYPE_B		0x0000
@@ -194,9 +244,12 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CTRL_UHS2_INTERFACE_EN	0x0100 /* UHS-2 */
+#define  SDHCI_CTRL_ADMA2_LEN_MODE	0x0400
 #define  SDHCI_CMD23_ENABLE		0x0800
 #define  SDHCI_CTRL_V4_MODE		0x1000
 #define  SDHCI_CTRL_64BIT_ADDR		0x2000
+#define  SDHCI_CTRL_ASYNC_INT_EN	0x4000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
@@ -219,11 +272,13 @@
 #define  SDHCI_CAN_VDD_180	0x04000000
 #define  SDHCI_CAN_64BIT_V4	0x08000000
 #define  SDHCI_CAN_64BIT	0x10000000
+#define  SDHCI_CAN_ASYNC_INT	0x20000000
 
 #define SDHCI_CAPABILITIES_1	0x44
 #define  SDHCI_SUPPORT_SDR50	0x00000001
 #define  SDHCI_SUPPORT_SDR104	0x00000002
 #define  SDHCI_SUPPORT_DDR50	0x00000004
+#define  SDHCI_SUPPORT_UHS2	0x00000008 /* UHS-2 support */
 #define  SDHCI_DRIVER_TYPE_A	0x00000010
 #define  SDHCI_DRIVER_TYPE_C	0x00000020
 #define  SDHCI_DRIVER_TYPE_D	0x00000040
@@ -232,19 +287,28 @@
 #define  SDHCI_RETUNING_MODE_MASK		GENMASK(15, 14)
 #define  SDHCI_CLOCK_MUL_MASK			GENMASK(23, 16)
 #define  SDHCI_CAN_DO_ADMA3	0x08000000
+#define  SDHCI_SUPPORT_VDD2_180	0x10000000 /* UHS-2 1.8V VDD2 */
+#define  SDHCI_RSVD_FOR_VDD2    0x20000000 /* Rsvd for future VDD2 */
 #define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
 
 #define SDHCI_MAX_CURRENT		0x48
+#define SDHCI_MAX_CURRENT_1		0x4C
 #define  SDHCI_MAX_CURRENT_LIMIT	GENMASK(7, 0)
 #define  SDHCI_MAX_CURRENT_330_MASK	GENMASK(7, 0)
 #define  SDHCI_MAX_CURRENT_300_MASK	GENMASK(15, 8)
 #define  SDHCI_MAX_CURRENT_180_MASK	GENMASK(23, 16)
+#define  SDHCI_MAX_CURRENT_VDD2_180_MASK	GENMASK(7, 0) /* UHS2 */
 #define   SDHCI_MAX_CURRENT_MULTIPLIER	4
 
 /* 4C-4F reserved for more max current */
 
 #define SDHCI_SET_ACMD12_ERROR	0x50
+/* Host Version 4.10 */
+#define SDHCI_SET_ACMD_RESPONSE_ERROR	0x20
 #define SDHCI_SET_INT_ERROR	0x52
+/* Host Version 4.10 */
+#define SDHCI_SET_INT_TUNING_ERROR	0x0400
+#define SDHCI_SET_INT_RESPONSE_ERROR	0x0800
 
 #define SDHCI_ADMA_ERROR	0x54
 
@@ -262,10 +326,16 @@
 #define SDHCI_PRESET_FOR_SDR104        0x6C
 #define SDHCI_PRESET_FOR_DDR50 0x6E
 #define SDHCI_PRESET_FOR_HS400 0x74 /* Non-standard */
+
+/* TODO: 0x74 is used for UHS2 in 4.10. How about HS400? */
+/* UHS2 */
+#define SDHCI_PRESET_FOR_UHS2  0x74
 #define SDHCI_PRESET_DRV_MASK		GENMASK(15, 14)
 #define SDHCI_PRESET_CLKGEN_SEL		BIT(10)
 #define SDHCI_PRESET_SDCLK_FREQ_MASK	GENMASK(9, 0)
 
+#define SDHCI_ADMA3_ADDRESS	0x78
+
 #define SDHCI_SLOT_INT_STATUS	0xFC
 
 #define SDHCI_HOST_VERSION	0xFE
@@ -661,6 +731,7 @@ struct sdhci_ops {
 	void	(*request_done)(struct sdhci_host *host,
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
+	void	(*dump_uhs2_regs)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

