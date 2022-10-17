Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9019060144F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJQRIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJQRIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:08:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A5771704;
        Mon, 17 Oct 2022 10:08:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3lQqmj7QWPZFiYPJsIwi3pFDmdN1/nZqrHCCXsoXyVqPlVavEBBM/2mH7ZLNScdcMNxyvJxJxRBPn6BTfMDh8no2tuT9ju/bnj+IRsDAvybk/h9QyvLmYqLOpBc+0cSe4ZaPI8BswQPEkB22iTdd8Cjnfc8kDNF0LqKaNTWLPEH/MyYxYdfKdCblK4Qp9wVi6r/x1jueO0iveN7m6CsLuGvyh7crDY03md73ucFFJvCrJipXF24tVTkrJL//jcre5zxs1vwKUnlJx3WsU57yXIQvOxVvkNZmPTh5Rg+BrTlb8QlFhfOGQu9V7CWXZIvwnARQu0cICdoCzOgkq/vcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCj1lfz8Y4RUSNFMuxUNQCaa1l8ltEjk1bkUKWUNQ98=;
 b=ZlcZ43Lc5MoYX61wey5fezDsBFOV9W3psXxfscbRQ3TkMtiRJt5XetpFSkpYaOrdE6ZnZaWjWwhd3rris6vKfAu9AtBikXjSPy73AeMfonS/eQTBRQW5sy2KLITGoMAxruzE1Ls2/oTjnT9rZVwakN72TqAL3d+/gf8frIoMfTV3aqpVrpqr0j3lp95VOg0eSIrtaTzuzw2QeaSQ1jdDgF6EfkGQA5ffCHOGlbf+a5hywi4lzP1uQA6lvLBFMcyrDu6MFHhpr64r2/zk61Y4nfTLpqNsNfMcXjSDajaXNZ6mjg8/lhVbKmuE4t9BgunqONLu721FD0h56o+AMlsLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCj1lfz8Y4RUSNFMuxUNQCaa1l8ltEjk1bkUKWUNQ98=;
 b=I6DERwXgFdtHm10Pplf6lgBi6jr5KxOgEK/CFejHbHQ6wIo+RRY87YAPX97NM2DkjTToe0C8bq5Z5IxGD6Ir64A9tvXvWhejl9TvQbo8Ybc0DOYNgy7q/oia1iGQgoyVQQM8KJOVxm5z6/2fs7h0QlWmhPchTj+DCdwbawDZUVuHF3wjxAjgZeVoqxjjNciJErMNnpWXhfAiOIIu9qGgOLo2Ak735pwRhLduzRQQMF1FbpUQSc37HnHcNbxW3Q8ie9ovY8Ia1j0Yv6s9YHfxVbathm/Ev9rBAxxA65mZkMPHIgOp/nJ1XiYGbI7f6cyUTTPKEC1ONRHfdB3YZTj9Zw==
Received: from BN0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:408:e6::6)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 17:08:07 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::91) by BN0PR03CA0001.outlook.office365.com
 (2603:10b6:408:e6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Mon, 17 Oct 2022 17:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 17:08:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 17 Oct
 2022 10:07:42 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 17 Oct
 2022 10:07:41 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Mon, 17 Oct
 2022 10:07:40 -0700
From:   Liming Sun <limings@nvidia.com>
To:     David Thompson <davthompson@nvidia.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
CC:     Liming Sun <limings@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>
Subject: [PATCH v1 1/1] platform/mellanox: Add BlueField-3 support in the tmfifo driver
Date:   Mon, 17 Oct 2022 13:07:38 -0400
Message-ID: <33bfcba9d1ad5a52ae9a63e817167b9ee3f0123a.1666024788.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1ce5ad-2218-4f8e-6f60-08dab0622972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XchQpoDxzEphVOR50lLD1cS94JCe19NyUDTwj6c6hNWbHk4fv6RwTTToUbpLSgGBjiDk5kxORWOjm4t5xM21UwmChTvCUg7zOvu4F+nFr+G4CpWMsUeRgTkZGJ8OJys3y+yjfvdzL7jFyVzGYKVQ6pedTYLiqGLrrEISoIMNR/kmNJgItH4hDCuWxzIdx+QVYUXDKtovuV3EJYJtQmYa0rNyATkUGgNBARWZqRXuPS6Q0QosTJD5/uQp+mIf/GJHNKfzJKeqPTE9EhLOEsJhgYcYXfKg2T2IJw7KFWZ6sUTu4OPZEGb2hciTCXnK4RHfZk2M2LGINNWTnHJ5gCrA9v1SBxRewFBS0sO3KcLEuPrZbx4/fNfoPtHMgRCdjq9MVFQOb5fG0YELq6cdeMp42dVRo+AW4j43e5AJd9711I9WTJ+EmdLL0MFk22umrlF91Hn6BLtOoGn9Iyz6bvs4lN7YRIKL73sb/tqQjUiUdqCF/gtGJfPxERf28Uec4AFKf+QtST1liDthNe0U3fns1gLA6nphwT02Iz26Ey+99GXsMo2qzu22Kj/3hRIUxJ+ytX0dgxl0oWMEjz6HZ8HWPKO7BcF1wEC1W1iiFo1S5LSdmt575LGm6IE6bxXpCG5xU0YggCWy8VE5yLvqDcti5PxJj0pYTkCOlFjCNYlEf/KDfIRROg+ivX/Cb4IPXfcVnjmwnyx6Lm1LeiqWwIynr/5lZBCwoOyvjB4uy+aScPggkcOxTqxGinknQd9hWXQEN9NDA/w0HItdNhGFqaEVFg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(26005)(41300700001)(40460700003)(107886003)(186003)(2616005)(336012)(478600001)(82310400005)(36756003)(2906002)(7696005)(86362001)(8936002)(5660300002)(82740400003)(36860700001)(110136005)(54906003)(316002)(40480700001)(47076005)(426003)(8676002)(4326008)(83380400001)(70586007)(356005)(7636003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 17:08:07.2651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1ce5ad-2218-4f8e-6f60-08dab0622972
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593
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

