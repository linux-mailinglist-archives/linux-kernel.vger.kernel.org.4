Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AC6602D12
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiJRNdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiJRNda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:33:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4ACCC815;
        Tue, 18 Oct 2022 06:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyT79YxEWm9U4GlhDLbrgRGKUoCS6L/atjF+aBWjKp5MYcYdIPTVgoja81V29eYwEHMMYNX3gJevJ4CbKN6N4QCSX6e4wtQaeO6kxF+bVVZiimg5eaKgMolH/+O6Ghrgvn848csOnbZ0N3DMhaWAn18dccm8T65JQ9HRg/Lg5pI4gXAQoNxwf/j7mpir7LKVFj16kWVRxbqQCdd5zj9asWaBfy6XRrh+4eBAICf3sXfNck/+ZOnabDzElk/WbfEHqAOyiRom1CL12ghVCe46pzw8KkG93vwdDhtFJ9sKsrPQbBj0P3ZltcQeh4qnXDY48VPeiX/unJDcNgClieIULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10s4CjBrsu9hE9Rt1846piEuEC9u933AntOHWfRMQN0=;
 b=UcqRTiuX8yPEWZHRkSCYrzB3LXlLtzcTp8k6Lved2Aqy4TX7LDlh6DBAPgJPTzXKlFF1x0mHbPC3La1LtwHk1kcJCGS8IVkrUsarswx1UuMpG1AGIBZaE2e/MKt9RlPGJT/cPM6W0hxQ2APVfv7Pr4LwtGWTAPotLBoduA7awM6dE9xuNZJReF0xBnam/+IZUwJ550S+GtR9QlHlGS/b1WAMjKFCUar2cR/1S8v70iFd2qvkPF137FA9eFKyE/lzMGYXcGCyomKWKDn9V7MsrTMgHoIvYVZIpnSdINds39auWjyTschDRchFnPs06xJUM1OGPePBBtXe6/BXweIE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10s4CjBrsu9hE9Rt1846piEuEC9u933AntOHWfRMQN0=;
 b=Nx1LbgrXmG1qjs5CDA5GKzMuMFzMHfngjF8Ll75PrYR7kfXipDa9+QCDnR8PJPxy1IxB6kY4238xTdJxFZfxG+Ap5xu2mFWF83/4lOfLDFLGwIeACS8ckQfMfrw4A62+QsUj/MVPNUJY4T1JThRtdC0TTPr03JLPOQokjoI+dp87V5ySNB5Jm3IlkNpiHcsHLoXAm5KX4qmqoET28H8ARbvLV4zrk7Eo+BwQw7r6BuxaxQIoEy0JafAsjx6HH+YowjihFU1RxgGYYK4A1KsiHwlvfpudRkTAxfoFRNvJMVlYdUOBqQHwWoydnen1ftuaBrmrMlG9qwjd4ZfmI5YHhQ==
Received: from BN0PR03CA0015.namprd03.prod.outlook.com (2603:10b6:408:e6::20)
 by IA1PR12MB7566.namprd12.prod.outlook.com (2603:10b6:208:42e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 13:33:26 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::b5) by BN0PR03CA0015.outlook.office365.com
 (2603:10b6:408:e6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Tue, 18 Oct 2022 13:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 13:33:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 18 Oct
 2022 06:33:12 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 18 Oct
 2022 06:33:12 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Tue, 18 Oct
 2022 06:33:11 -0700
From:   Liming Sun <limings@nvidia.com>
To:     David Thompson <davthompson@nvidia.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     Liming Sun <limings@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>
Subject: [PATCH v2] platform/mellanox: Add BlueField-3 support in the tmfifo driver
Date:   Tue, 18 Oct 2022 09:33:03 -0400
Message-ID: <20221018133303.243920-1-limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <33bfcba9d1ad5a52ae9a63e817167b9ee3f0123a.1666024788.git.limings@nvidia.com>
References: <33bfcba9d1ad5a52ae9a63e817167b9ee3f0123a.1666024788.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT012:EE_|IA1PR12MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: c4303b86-ae4f-49c5-72b5-08dab10d55d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vSBLQYpFvhTu7RVijkLvN8gEVr4am2Yh+XQq91UyDBG3yLoR82xdyd3ZXz5PEVWus5OjPbRT/2ysaDIFjR1Q1NJykwT3B5Mojs0nCGk/npo4bYabfRWQ1Oe9gaqTfD6tDksd59Q27+Cg4/lQaWCje6gk3adrldSVrwW0HoOp3PRgLbfut9XtYGJUytLad1i2fXGRje5o756cNHiwRa/jBAHrP282pPJJu1zFY1gQKNbxf2BNPktkPWF9eTsLy+Zi3cYEPyn+49e5pbzJaSCxNmV9ulBBdDBIWQkrPyqN0xOX10LED7Q5VGVvyH4+nyA3FRBdsjLvZvRD3WlVEJyyHeT1Nm3dShUcKUAT3yt15GoM+PN+LAYFNwk623bQrusDvrNR3UQddUatHJWQgcvYhNPMCYPklY/N9NwJ6Bn34/eBwubPLGO4c7gU8P6iesjs5mFdPjQBgKEAEHXy2o66+8oMc8bPQcjx+LxOpz73ARVKZUGQ+aw296+sX0jjO66XIte9Wvnx+VGR/fDCA2JyGm0q6ZfyXJM1PnYprLvAT22pG87Vmm6J9EFchY6jUvXuJjZgpQz3dzpa8i8cGHTXloE65iTH2KWIvNEqFM1KmU1mUJXGBn14NVZMMP/Q3WrYmoigVZUnNXKnZUNM2OZSFbxDEEEYoCWBCfTnoBglEycj/oE5WDIL+wLANYwtsOTkvTd3SBdBbHpqy7Bu4d4ofsBhZo3T6D+GT5yN6lhQub6n3jRJk6GJTYEKmw/1Tc6hcW3XFSfRyjo+pdsQ5OCnRA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(2616005)(83380400001)(336012)(478600001)(1076003)(186003)(426003)(7696005)(47076005)(26005)(107886003)(40480700001)(5660300002)(2906002)(6666004)(40460700003)(36860700001)(54906003)(110136005)(316002)(70206006)(4326008)(8936002)(41300700001)(82310400005)(8676002)(70586007)(86362001)(36756003)(356005)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 13:33:25.6746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4303b86-ae4f-49c5-72b5-08dab10d55d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7566
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BlueField-3 uses the same control registers in tmfifo access but
at different addresses. This commit replaces the offset reference
with pointers, and set up these pointers in the probe functions
accordingly.

Signed-off-by: Liming Sun <limings@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
---
v1->v2:
  Resend with updated reviewer list
v1: Initial version
---
 drivers/platform/mellanox/mlxbf-tmfifo-regs.h | 10 +++
 drivers/platform/mellanox/mlxbf-tmfifo.c      | 86 ++++++++++++++-----
 2 files changed, 74 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo-regs.h b/drivers/platform/mellanox/mlxbf-tmfifo-regs.h
index e4f0d2eda714..44fb8c5b1484 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo-regs.h
+++ b/drivers/platform/mellanox/mlxbf-tmfifo-regs.h
@@ -60,4 +60,14 @@
 #define MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_RMASK		GENMASK_ULL(8, 0)
 #define MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_MASK		GENMASK_ULL(40, 32)
 
+/* BF3 register offsets within resource 0. */
+#define MLXBF_TMFIFO_RX_DATA_BF3	0x0000
+#define MLXBF_TMFIFO_TX_DATA_BF3	0x1000
+
+/* BF3 register offsets within resource 1. */
+#define MLXBF_TMFIFO_RX_STS_BF3		0x0000
+#define MLXBF_TMFIFO_RX_CTL_BF3		0x0008
+#define MLXBF_TMFIFO_TX_STS_BF3		0x0100
+#define MLXBF_TMFIFO_TX_CTL_BF3		0x0108
+
 #endif /* !defined(__MLXBF_TMFIFO_REGS_H__) */
diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 1ae3c56b66b0..91a077c35b8b 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -47,6 +47,9 @@
 /* Message with data needs at least two words (for header & data). */
 #define MLXBF_TMFIFO_DATA_MIN_WORDS		2
 
+/* ACPI UID for BlueField-3. */
+#define TMFIFO_BF3_UID				1
+
 struct mlxbf_tmfifo;
 
 /**
@@ -136,12 +139,26 @@ struct mlxbf_tmfifo_irq_info {
 	int index;
 };
 
+/**
+ * mlxbf_tmfifo_io - Structure of the TmFifo IO resource (for both rx & tx)
+ * @ctl: control register offset (TMFIFO_RX_CTL / TMFIFO_TX_CTL)
+ * @sts: status register offset (TMFIFO_RX_STS / TMFIFO_TX_STS)
+ * @data: data register offset (TMFIFO_RX_DATA / TMFIFO_TX_DATA)
+ */
+struct mlxbf_tmfifo_io {
+	void __iomem *ctl;
+	void __iomem *sts;
+	void __iomem *data;
+};
+
 /**
  * mlxbf_tmfifo - Structure of the TmFifo
  * @vdev: array of the virtual devices running over the TmFifo
  * @lock: lock to protect the TmFifo access
- * @rx_base: mapped register base address for the Rx FIFO
- * @tx_base: mapped register base address for the Tx FIFO
+ * @res0: mapped resource block 0
+ * @res1: mapped resource block 1
+ * @rx: rx io resource
+ * @tx: tx io resource
  * @rx_fifo_size: number of entries of the Rx FIFO
  * @tx_fifo_size: number of entries of the Tx FIFO
  * @pend_events: pending bits for deferred events
@@ -155,8 +172,10 @@ struct mlxbf_tmfifo_irq_info {
 struct mlxbf_tmfifo {
 	struct mlxbf_tmfifo_vdev *vdev[MLXBF_TMFIFO_VDEV_MAX];
 	struct mutex lock;		/* TmFifo lock */
-	void __iomem *rx_base;
-	void __iomem *tx_base;
+	void __iomem *res0;
+	void __iomem *res1;
+	struct mlxbf_tmfifo_io rx;
+	struct mlxbf_tmfifo_io tx;
 	int rx_fifo_size;
 	int tx_fifo_size;
 	unsigned long pend_events;
@@ -472,7 +491,7 @@ static int mlxbf_tmfifo_get_rx_avail(struct mlxbf_tmfifo *fifo)
 {
 	u64 sts;
 
-	sts = readq(fifo->rx_base + MLXBF_TMFIFO_RX_STS);
+	sts = readq(fifo->rx.sts);
 	return FIELD_GET(MLXBF_TMFIFO_RX_STS__COUNT_MASK, sts);
 }
 
@@ -489,7 +508,7 @@ static int mlxbf_tmfifo_get_tx_avail(struct mlxbf_tmfifo *fifo, int vdev_id)
 	else
 		tx_reserve = 1;
 
-	sts = readq(fifo->tx_base + MLXBF_TMFIFO_TX_STS);
+	sts = readq(fifo->tx.sts);
 	count = FIELD_GET(MLXBF_TMFIFO_TX_STS__COUNT_MASK, sts);
 	return fifo->tx_fifo_size - tx_reserve - count;
 }
@@ -525,7 +544,7 @@ static void mlxbf_tmfifo_console_tx(struct mlxbf_tmfifo *fifo, int avail)
 	/* Write header. */
 	hdr.type = VIRTIO_ID_CONSOLE;
 	hdr.len = htons(size);
-	writeq(*(u64 *)&hdr, fifo->tx_base + MLXBF_TMFIFO_TX_DATA);
+	writeq(*(u64 *)&hdr, fifo->tx.data);
 
 	/* Use spin-lock to protect the 'cons->tx_buf'. */
 	spin_lock_irqsave(&fifo->spin_lock[0], flags);
@@ -542,7 +561,7 @@ static void mlxbf_tmfifo_console_tx(struct mlxbf_tmfifo *fifo, int avail)
 			memcpy((u8 *)&data + seg, cons->tx_buf.buf,
 			       sizeof(u64) - seg);
 		}
-		writeq(data, fifo->tx_base + MLXBF_TMFIFO_TX_DATA);
+		writeq(data, fifo->tx.data);
 
 		if (size >= sizeof(u64)) {
 			cons->tx_buf.tail = (cons->tx_buf.tail + sizeof(u64)) %
@@ -573,7 +592,7 @@ static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo_vring *vring,
 
 	/* Read a word from FIFO for Rx. */
 	if (is_rx)
-		data = readq(fifo->rx_base + MLXBF_TMFIFO_RX_DATA);
+		data = readq(fifo->rx.data);
 
 	if (vring->cur_len + sizeof(u64) <= len) {
 		/* The whole word. */
@@ -595,7 +614,7 @@ static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo_vring *vring,
 
 	/* Write the word into FIFO for Tx. */
 	if (!is_rx)
-		writeq(data, fifo->tx_base + MLXBF_TMFIFO_TX_DATA);
+		writeq(data, fifo->tx.data);
 }
 
 /*
@@ -617,7 +636,7 @@ static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo_vring *vring,
 	/* Read/Write packet header. */
 	if (is_rx) {
 		/* Drain one word from the FIFO. */
-		*(u64 *)&hdr = readq(fifo->rx_base + MLXBF_TMFIFO_RX_DATA);
+		*(u64 *)&hdr = readq(fifo->rx.data);
 
 		/* Skip the length 0 packets (keepalive). */
 		if (hdr.len == 0)
@@ -661,7 +680,7 @@ static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo_vring *vring,
 		hdr.type = (vring->vdev_id == VIRTIO_ID_NET) ?
 			    VIRTIO_ID_NET : VIRTIO_ID_CONSOLE;
 		hdr.len = htons(vring->pkt_len - hdr_len);
-		writeq(*(u64 *)&hdr, fifo->tx_base + MLXBF_TMFIFO_TX_DATA);
+		writeq(*(u64 *)&hdr, fifo->tx.data);
 	}
 
 	vring->cur_len = hdr_len;
@@ -1157,7 +1176,7 @@ static void mlxbf_tmfifo_set_threshold(struct mlxbf_tmfifo *fifo)
 	u64 ctl;
 
 	/* Get Tx FIFO size and set the low/high watermark. */
-	ctl = readq(fifo->tx_base + MLXBF_TMFIFO_TX_CTL);
+	ctl = readq(fifo->tx.ctl);
 	fifo->tx_fifo_size =
 		FIELD_GET(MLXBF_TMFIFO_TX_CTL__MAX_ENTRIES_MASK, ctl);
 	ctl = (ctl & ~MLXBF_TMFIFO_TX_CTL__LWM_MASK) |
@@ -1166,17 +1185,17 @@ static void mlxbf_tmfifo_set_threshold(struct mlxbf_tmfifo *fifo)
 	ctl = (ctl & ~MLXBF_TMFIFO_TX_CTL__HWM_MASK) |
 		FIELD_PREP(MLXBF_TMFIFO_TX_CTL__HWM_MASK,
 			   fifo->tx_fifo_size - 1);
-	writeq(ctl, fifo->tx_base + MLXBF_TMFIFO_TX_CTL);
+	writeq(ctl, fifo->tx.ctl);
 
 	/* Get Rx FIFO size and set the low/high watermark. */
-	ctl = readq(fifo->rx_base + MLXBF_TMFIFO_RX_CTL);
+	ctl = readq(fifo->rx.ctl);
 	fifo->rx_fifo_size =
 		FIELD_GET(MLXBF_TMFIFO_RX_CTL__MAX_ENTRIES_MASK, ctl);
 	ctl = (ctl & ~MLXBF_TMFIFO_RX_CTL__LWM_MASK) |
 		FIELD_PREP(MLXBF_TMFIFO_RX_CTL__LWM_MASK, 0);
 	ctl = (ctl & ~MLXBF_TMFIFO_RX_CTL__HWM_MASK) |
 		FIELD_PREP(MLXBF_TMFIFO_RX_CTL__HWM_MASK, 1);
-	writeq(ctl, fifo->rx_base + MLXBF_TMFIFO_RX_CTL);
+	writeq(ctl, fifo->rx.ctl);
 }
 
 static void mlxbf_tmfifo_cleanup(struct mlxbf_tmfifo *fifo)
@@ -1197,8 +1216,15 @@ static int mlxbf_tmfifo_probe(struct platform_device *pdev)
 	struct virtio_net_config net_config;
 	struct device *dev = &pdev->dev;
 	struct mlxbf_tmfifo *fifo;
+	u64 dev_id;
 	int i, rc;
 
+	rc = acpi_dev_uid_to_integer(ACPI_COMPANION(dev), &dev_id);
+	if (rc) {
+		dev_err(dev, "Cannot retrieve UID\n");
+		return rc;
+	}
+
 	fifo = devm_kzalloc(dev, sizeof(*fifo), GFP_KERNEL);
 	if (!fifo)
 		return -ENOMEM;
@@ -1209,14 +1235,30 @@ static int mlxbf_tmfifo_probe(struct platform_device *pdev)
 	mutex_init(&fifo->lock);
 
 	/* Get the resource of the Rx FIFO. */
-	fifo->rx_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(fifo->rx_base))
-		return PTR_ERR(fifo->rx_base);
+	fifo->res0 = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(fifo->res0))
+		return PTR_ERR(fifo->res0);
 
 	/* Get the resource of the Tx FIFO. */
-	fifo->tx_base = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(fifo->tx_base))
-		return PTR_ERR(fifo->tx_base);
+	fifo->res1 = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(fifo->res1))
+		return PTR_ERR(fifo->res1);
+
+	if (dev_id == TMFIFO_BF3_UID) {
+		fifo->rx.ctl = fifo->res1 + MLXBF_TMFIFO_RX_CTL_BF3;
+		fifo->rx.sts = fifo->res1 + MLXBF_TMFIFO_RX_STS_BF3;
+		fifo->rx.data = fifo->res0 + MLXBF_TMFIFO_RX_DATA_BF3;
+		fifo->tx.ctl = fifo->res1 + MLXBF_TMFIFO_TX_CTL_BF3;
+		fifo->tx.sts = fifo->res1 + MLXBF_TMFIFO_TX_STS_BF3;
+		fifo->tx.data = fifo->res0 + MLXBF_TMFIFO_TX_DATA_BF3;
+	} else {
+		fifo->rx.ctl = fifo->res0 + MLXBF_TMFIFO_RX_CTL;
+		fifo->rx.sts = fifo->res0 + MLXBF_TMFIFO_RX_STS;
+		fifo->rx.data = fifo->res0 + MLXBF_TMFIFO_RX_DATA;
+		fifo->tx.ctl = fifo->res1 + MLXBF_TMFIFO_TX_CTL;
+		fifo->tx.sts = fifo->res1 + MLXBF_TMFIFO_TX_STS;
+		fifo->tx.data = fifo->res1 + MLXBF_TMFIFO_TX_DATA;
+	}
 
 	platform_set_drvdata(pdev, fifo);
 
-- 
2.30.1

