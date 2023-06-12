Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC4772C36A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjFLLtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjFLLtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:49:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A392876BE;
        Mon, 12 Jun 2023 04:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JggPwJDWGgD6NaxvpkEpypgBnTySM883o/zT1uFkMHXobl6KnYPAlPVa0oTEN2kRLlrv/unAyjuxC0arMro7qmZRG+rE32KS69MuIOMrt84OQAm0JBaK8XhFbR0tYUr0TqJjQhEORvXjFyiZXw5tRjAoGx60ZnhGICUkK9My2RlzjFCGow4U1eMhVCtXKrxxY2acpt3w15HlaD7Is0FvtsSHwE+aQbGYouha0QF2bY/J1iu5e7Zmk/YpRqE3wniEkZsWP3xT9F/gFl5CbGNSDodpuU0XNOY187ASQvtSgGeNXETFWY72AIHl8zNVQtHszq4hbfxoap03QATSXEcFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZHdKAYiCdpWimF0+yz/CkLK0qNV5lfZFjYduZ+8sa0=;
 b=ZcUJSBrn5xFDw7E2KecdHBQSVDRupcWhL0OK/Yo/uNKYOAZNzw118V6hnFQ5bgbhRxAVJ6VtwJlO+jIPX8bksYSJK6swhIhy8lnwBTxkqODqxBPONbdwh5Ne6TTaCOIdcAPmrdcQLrHK499LV1W7qzIcdqPgR7C0BCHAeBJx5FbfPPUsVwcayszA0tNRWUVnZ3Eq9V87uhm/nRsNKB1yAZKSjgQZe2Eu5WFP4l1FiDuOZ7cV9mH0NmwSeSuBY3QZla2Mq8kUsCgay7j5uzEUZgmMUmlBUEGlIXhYPWcgJjqlNYQkSZF5Hc4CzGCbAQ/MsFUrj6SSQgaiiC/KCBrmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZHdKAYiCdpWimF0+yz/CkLK0qNV5lfZFjYduZ+8sa0=;
 b=TmC0KLIge0kybmIZTeyPEbQwQrbx/GBuqjiIY8A5vk7JMEZWXF5EDjF1KKnHZDyJXvzDdfz65NdHbH7axus/0TMyfknoKX8IZKF+kObstMhhlsB1F3GN8x/bNJBDfph8qIzbm/yhmRBX5S7833oKpI6L39Xy+nJ8Li/a3w4kA2E=
Received: from MW4PR04CA0304.namprd04.prod.outlook.com (2603:10b6:303:82::9)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 11:43:12 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::a6) by MW4PR04CA0304.outlook.office365.com
 (2603:10b6:303:82::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.33 via Frontend
 Transport; Mon, 12 Jun 2023 11:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.31 via Frontend Transport; Mon, 12 Jun 2023 11:43:11 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 06:43:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 12 Jun
 2023 04:43:10 -0700
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 12 Jun 2023 06:43:07 -0500
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <gcnu.goud@gmail.com>
CC:     <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH 2/3] can: xilinx_can: Add ECC support
Date:   Mon, 12 Jun 2023 17:12:56 +0530
Message-ID: <1686570177-2836108-3-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
References: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: 41545624-5ce5-4555-966b-08db6b3a335c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S76Cp+cW83rGLrUYeUsVijIIfT7tMGWViTyphSwFAZrvC0xIvKW4SN/xQ0wjsDMI9U9ejz60EJ7ncUCmdkQuvz/4Z//6fzb8KfqN+skEu452rs/6skeVTMMt+4vFF4pZa6NDNAtDsN0WjKMLc0rfYJFLKpk9hr8DlmzFmtq9T17obLTJDbPCm2xA9TD9sTPbRwUbsf/v8LwXNQjO6YqPlPvdlLZT/0tiy8wuC2lw4hjKKif1vWfXvb9wp7s1yxN4aJHiE4yrIJ468y2dQXohotsw9cmPYdEndRPOHAALXLl5WBEnU1E4i64VGJV0h1xzjzzHMmGvkZy794gsiSOmKmLIN4v7MZh04z36gdJvq5q1NSlfyFZnykkiSQY7FY8jB8pAgfTuC4JVo1XUejhzpcHXb1ppMZ3Tnl0gh4HC4hi41ViNWj9A3SAstY7FU8FyR3y6Ovhmd23JYqxbap2/nM7Q6K54piZ5e5F68xU9P92Ch+Iwv+Ke9/8ejVw+B5Yg2puvvo1gHkYDxqigH2l+vurzYGbe3DvPoi633atqAMvNt8mVPAhRofHbcEFy0HO96i/rJvDOBBuc9oNpdQ2ON5/odsozcvOtf8k4EbJ1wkVhZVL0YQapzAxVtyV/N5EjsK5A4B14chIoohw8f4TB6rezUJp+nJYBBw6MRX0gQXaN+q+c0bk4tK/hnWuP1RoDk82cFBzZSCV2phxNYfFXHzwKmEj7BFyzHwW9B1NUSrC4sbS8YWiBhVrJbr/fZiU1EHjYxtOOkVlmUhTI65hjMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(6666004)(47076005)(36756003)(426003)(336012)(83380400001)(2616005)(86362001)(82310400005)(82740400003)(356005)(81166007)(26005)(40480700001)(36860700001)(186003)(2906002)(110136005)(54906003)(316002)(7416002)(4326008)(44832011)(70586007)(70206006)(41300700001)(5660300002)(478600001)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 11:43:11.5475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41545624-5ce5-4555-966b-08db6b3a335c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ECC support for Xilinx CAN Controller, so this driver reports
1bit/2bit ECC errors for FIFO's based on ECC error interrupt.
ECC feature for Xilinx CAN Controller selected through
'xlnx,has-ecc' DT property

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
---
 drivers/net/can/xilinx_can.c | 109 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 43c812e..311e435 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -63,6 +63,12 @@ enum xcan_reg {
 	XCAN_RXMSG_2_BASE_OFFSET	= 0x2100, /* RX Message Space */
 	XCAN_AFR_2_MASK_OFFSET	= 0x0A00, /* Acceptance Filter MASK */
 	XCAN_AFR_2_ID_OFFSET	= 0x0A04, /* Acceptance Filter ID */
+
+	/* only on AXI CAN cores */
+	XCAN_ECC_CFG_OFFSET	= 0xC8,	/* ECC Configuration */
+	XCAN_TXTLFIFO_ECC_OFFSET	= 0xCC, /* TXTL FIFO ECC error counter */
+	XCAN_TXOLFIFO_ECC_OFFSET	= 0xD0, /* TXOL FIFO ECC error counter */
+	XCAN_RXFIFO_ECC_OFFSET		= 0xD4, /* RX FIFO ECC error counter */
 };
 
 #define XCAN_FRAME_ID_OFFSET(frame_base)	((frame_base) + 0x00)
@@ -135,6 +141,17 @@ enum xcan_reg {
 #define XCAN_2_FSR_RI_MASK		0x0000003F /* RX Read Index */
 #define XCAN_DLCR_EDL_MASK		0x08000000 /* EDL Mask in DLC */
 #define XCAN_DLCR_BRS_MASK		0x04000000 /* BRS Mask in DLC */
+#define XCAN_IXR_E2BERX_MASK		BIT(23) /* RX FIFO two bit ECC error */
+#define XCAN_IXR_E1BERX_MASK		BIT(22) /* RX FIFO one bit ECC error */
+#define XCAN_IXR_E2BETXOL_MASK		BIT(21) /* TXOL FIFO two bit ECC error */
+#define XCAN_IXR_E1BETXOL_MASK		BIT(20) /* TXOL FIFO One bit ECC error */
+#define XCAN_IXR_E2BETXTL_MASK		BIT(19) /* TXTL FIFO Two bit ECC error */
+#define XCAN_IXR_E1BETXTL_MASK		BIT(18) /* TXTL FIFO One bit ECC error */
+#define XCAN_ECC_CFG_REECRX_MASK	BIT(2) /* Reset RX FIFO ECC error counters */
+#define XCAN_ECC_CFG_REECTXOL_MASK	BIT(1) /* Reset TXOL FIFO ECC error counters */
+#define XCAN_ECC_CFG_REECTXTL_MASK	BIT(0) /* Reset TXTL FIFO ECC error counters */
+#define XCAN_ECC_1BIT_CNT_MASK		GENMASK(15, 0) /* FIFO ECC 1bit count mask */
+#define XCAN_ECC_2BIT_CNT_MASK		GENMASK(31, 16) /* FIFO ECC 2bit count mask */
 
 /* CAN register bit shift - XCAN_<REG>_<BIT>_SHIFT */
 #define XCAN_BRPR_TDC_ENABLE		BIT(16) /* Transmitter Delay Compensation (TDC) Enable */
@@ -198,6 +215,13 @@ struct xcan_devtype_data {
  * @bus_clk:			Pointer to struct clk
  * @can_clk:			Pointer to struct clk
  * @devtype:			Device type specific constants
+ * @ecc_enable:			ECC enable flag
+ * @ecc_2bit_rxfifo_cnt:	RXFIFO 2bit ECC count
+ * @ecc_1bit_rxfifo_cnt:	RXFIFO 1bit ECC count
+ * @ecc_2bit_txolfifo_cnt:	TXOLFIFO 2bit ECC count
+ * @ecc_1bit_txolfifo_cnt:	TXOLFIFO 1bit ECC count
+ * @ecc_2bit_txtlfifo_cnt:	TXTLFIFO 2bit ECC count
+ * @ecc_1bit_txtlfifo_cnt:	TXTLFIFO 1bit ECC count
  */
 struct xcan_priv {
 	struct can_priv can;
@@ -215,6 +239,13 @@ struct xcan_priv {
 	struct clk *bus_clk;
 	struct clk *can_clk;
 	struct xcan_devtype_data devtype;
+	bool ecc_enable;
+	u32 ecc_2bit_rxfifo_cnt;
+	u32 ecc_1bit_rxfifo_cnt;
+	u32 ecc_2bit_txolfifo_cnt;
+	u32 ecc_1bit_txolfifo_cnt;
+	u32 ecc_2bit_txtlfifo_cnt;
+	u32 ecc_1bit_txtlfifo_cnt;
 };
 
 /* CAN Bittiming constants as per Xilinx CAN specs */
@@ -517,6 +548,11 @@ static int xcan_chip_start(struct net_device *ndev)
 		XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
 		XCAN_IXR_ARBLST_MASK | xcan_rx_int_mask(priv);
 
+	if (priv->ecc_enable)
+		ier |= XCAN_IXR_E2BERX_MASK | XCAN_IXR_E1BERX_MASK |
+			XCAN_IXR_E2BETXOL_MASK | XCAN_IXR_E1BETXOL_MASK |
+			XCAN_IXR_E2BETXTL_MASK | XCAN_IXR_E1BETXTL_MASK;
+
 	if (priv->devtype.flags & XCAN_FLAG_RXMNF)
 		ier |= XCAN_IXR_RXMNF_MASK;
 
@@ -1121,6 +1157,56 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 		priv->can.can_stats.bus_error++;
 	}
 
+	if (priv->ecc_enable) {
+		u32 reg_ecc;
+
+		reg_ecc = priv->read_reg(priv, XCAN_RXFIFO_ECC_OFFSET);
+		if (isr & XCAN_IXR_E2BERX_MASK) {
+			priv->ecc_2bit_rxfifo_cnt +=
+				FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_ecc);
+			netdev_dbg(ndev, "%s: RX FIFO 2bit ECC error count %d\n",
+				   __func__, priv->ecc_2bit_rxfifo_cnt);
+		}
+		if (isr & XCAN_IXR_E1BERX_MASK) {
+			priv->ecc_1bit_rxfifo_cnt += reg_ecc &
+				XCAN_ECC_1BIT_CNT_MASK;
+			netdev_dbg(ndev, "%s: RX FIFO 1bit ECC error count %d\n",
+				   __func__, priv->ecc_1bit_rxfifo_cnt);
+		}
+
+		reg_ecc = priv->read_reg(priv, XCAN_TXOLFIFO_ECC_OFFSET);
+		if (isr & XCAN_IXR_E2BETXOL_MASK) {
+			priv->ecc_2bit_txolfifo_cnt +=
+				FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_ecc);
+			netdev_dbg(ndev, "%s: TXOL FIFO 2bit ECC error count %d\n",
+				   __func__, priv->ecc_2bit_txolfifo_cnt);
+		}
+		if (isr & XCAN_IXR_E1BETXOL_MASK) {
+			priv->ecc_1bit_txolfifo_cnt += reg_ecc &
+				XCAN_ECC_1BIT_CNT_MASK;
+			netdev_dbg(ndev, "%s: TXOL FIFO 1bit ECC error count %d\n",
+				   __func__, priv->ecc_1bit_txolfifo_cnt);
+		}
+
+		reg_ecc = priv->read_reg(priv, XCAN_TXTLFIFO_ECC_OFFSET);
+		if (isr & XCAN_IXR_E2BETXTL_MASK) {
+			priv->ecc_2bit_txtlfifo_cnt +=
+				FIELD_GET(XCAN_ECC_2BIT_CNT_MASK, reg_ecc);
+			netdev_dbg(ndev, "%s: TXTL FIFO 2bit ECC error count %d\n",
+				   __func__, priv->ecc_2bit_txtlfifo_cnt);
+		}
+		if (isr & XCAN_IXR_E1BETXTL_MASK) {
+			priv->ecc_1bit_txtlfifo_cnt += reg_ecc &
+				XCAN_ECC_1BIT_CNT_MASK;
+			netdev_dbg(ndev, "%s: TXTL FIFO 1bit ECC error count %d\n",
+				   __func__, priv->ecc_1bit_txtlfifo_cnt);
+		}
+
+		/* Reset FIFO ECC counters */
+		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET, XCAN_ECC_CFG_REECRX_MASK |
+				XCAN_ECC_CFG_REECTXOL_MASK | XCAN_ECC_CFG_REECTXTL_MASK);
+	}
+
 	if (cf.can_id) {
 		struct can_frame *skb_cf;
 		struct sk_buff *skb = alloc_can_err_skb(ndev, &skb_cf);
@@ -1348,9 +1434,8 @@ static irqreturn_t xcan_interrupt(int irq, void *dev_id)
 {
 	struct net_device *ndev = (struct net_device *)dev_id;
 	struct xcan_priv *priv = netdev_priv(ndev);
-	u32 isr, ier;
-	u32 isr_errors;
 	u32 rx_int_mask = xcan_rx_int_mask(priv);
+	u32 isr, ier, isr_errors, mask;
 
 	/* Get the interrupt status from Xilinx CAN */
 	isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
@@ -1368,10 +1453,18 @@ static irqreturn_t xcan_interrupt(int irq, void *dev_id)
 	if (isr & XCAN_IXR_TXOK_MASK)
 		xcan_tx_interrupt(ndev, isr);
 
+	mask = XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
+		XCAN_IXR_BSOFF_MASK | XCAN_IXR_ARBLST_MASK |
+		XCAN_IXR_RXMNF_MASK;
+
+	if (priv->ecc_enable)
+		mask |= XCAN_IXR_E2BERX_MASK | XCAN_IXR_E1BERX_MASK |
+			XCAN_IXR_E2BETXOL_MASK | XCAN_IXR_E1BETXOL_MASK |
+			XCAN_IXR_E2BETXTL_MASK | XCAN_IXR_E1BETXTL_MASK;
+
 	/* Check for the type of error interrupt and Processing it */
-	isr_errors = isr & (XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
-			    XCAN_IXR_BSOFF_MASK | XCAN_IXR_ARBLST_MASK |
-			    XCAN_IXR_RXMNF_MASK);
+	isr_errors = isr & mask;
+
 	if (isr_errors) {
 		priv->write_reg(priv, XCAN_ICR_OFFSET, isr_errors);
 		xcan_err_interrupt(ndev, isr);
@@ -1783,6 +1876,7 @@ static int xcan_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv = netdev_priv(ndev);
+	priv->ecc_enable = of_property_read_bool(pdev->dev.of_node, "xlnx,has-ecc");
 	priv->dev = &pdev->dev;
 	priv->can.bittiming_const = devtype->bittiming_const;
 	priv->can.do_set_mode = xcan_do_set_mode;
@@ -1880,6 +1974,11 @@ static int xcan_probe(struct platform_device *pdev)
 		   priv->reg_base, ndev->irq, priv->can.clock.freq,
 		   hw_tx_max, priv->tx_max);
 
+	if (priv->ecc_enable)
+		/* Reset FIFO ECC counters */
+		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET, XCAN_ECC_CFG_REECRX_MASK |
+			XCAN_ECC_CFG_REECTXOL_MASK | XCAN_ECC_CFG_REECTXTL_MASK);
+
 	return 0;
 
 err_disableclks:
-- 
2.1.1

