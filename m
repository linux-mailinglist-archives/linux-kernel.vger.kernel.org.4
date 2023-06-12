Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94C072C36B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjFLLt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFLLtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:49:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F354C31;
        Mon, 12 Jun 2023 04:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0A++yKU+WfLK+CWdGhtx97zx4Os2DE4WeMPmbWtqOu4jIm205qVxVfZYXx1ssfNindqTv1XVqu7uOZBfpRX4rDo00L8aFAKRAcZAf9uayEwHDLToplT2OzRMH10TEwxxeq7UuMHmroL4fpGbIQcZwkSjxBsbhcM8eokwHfdQbyr3uI+XqiKCLlGhqtlPWC857DxDhlZ9VPgQ6o6OpXkqOQU1O8MeP4R/+tnIQCgdrv4bVb68INGtDFyWn0vyMSBoPEcskT52jXh7Fa3UgFpch0PcAwTRvVZlgSljcVFhDaI6XmqTiN7Ap87ubLYzANFJf48hjUinsqkm++mFF2D7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60/SZl66pKeL5TliYQd3tCPu+Ao3wuYBMaCvGrIgNic=;
 b=W8WWhsScY+pap/UYgqxtJU/OOfikflsDkt4pEyBrrgP63jOS5YEuFAafwi0kDnfR9dCkxYdt1V6lIaZu/cqUgqbJLCENB8Z/d8qk71trYABHRl8J+Z2Y51IppzQ7PNxMRoONtBxapFwzcBCYXr9RrW+CoH4tbu6UPCl64Q4nIZK8SUoVqhvNA5IQ/9SSbke2GeWegIylSL8yY4lV2FTkx+oDVSLODOpOGdyVUH+l89/smizgPAnTahtrULx6AIAHzvbCQNv6CYYMWVHpeoH98yoL/yszH7UPQY383mXRWYDtZHnZZbX0i+604i0hAkwAoSMwgMT3mYoATZMY6BUfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=grandegger.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60/SZl66pKeL5TliYQd3tCPu+Ao3wuYBMaCvGrIgNic=;
 b=ED6gcaes2q0+IhtrI6rx6IYoufZ07mp8TRNFM3NicKf3tGlbbj65TP/wu3NQQq1BOxuLiew5Sd5LZlld/XhgIC1HvQzBcfO5xRxPF4jw8LiA/DxY+soZBVEkvei17XIIaAbV7gGGMTjUs2kbCZfCxx0zqs0J0H0yEQeRTUzL9+8=
Received: from MW4PR02CA0018.namprd02.prod.outlook.com (2603:10b6:303:16d::17)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Mon, 12 Jun
 2023 11:43:15 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::51) by MW4PR02CA0018.outlook.office365.com
 (2603:10b6:303:16d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.33 via Frontend
 Transport; Mon, 12 Jun 2023 11:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.27 via Frontend Transport; Mon, 12 Jun 2023 11:43:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 06:43:14 -0500
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 12 Jun 2023 06:43:10 -0500
From:   Srinivas Goud <srinivas.goud@amd.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <gcnu.goud@gmail.com>
CC:     <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Srinivas Goud <srinivas.goud@amd.com>
Subject: [PATCH 3/3] can: xilinx_can: Add debugfs support for ECC
Date:   Mon, 12 Jun 2023 17:12:57 +0530
Message-ID: <1686570177-2836108-4-git-send-email-srinivas.goud@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
References: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e1b8bd-1f4b-45fc-371c-08db6b3a3599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcK8313Bb1KujL+j+51GZomKi29fFK6fTC/WscBxJTRvWf93qdcaUamt/+ZObzYQPtgv/HPgXu6oV0OxMW/a68e43qEyXbcHwWwShxdVjKNa/T1S+fpGDURp40H6p23XPx5j3ycxpZkgx9P7CeJYf4uxVNd9CLfbCubmXWTpXyAkpp7H+m1PNvtLenuQlxjxY71mhvSZlC5hd/t2D38kpx5fjF3AnMC8V3YWybre80xD0xzAZhcP3csyoAYKoto6toVYK6nCLMYOJH6ym2OYhnIIEl1fZG17Wr2khW3X9S8CNMGPqI4YZQvgwTTsQteRY3iZnTG0bb7xCnmAniOpMguPP9mHwm74t0DUeVgOO8EYKWveN32jFmxbcfRs59lLom+RE7n153yClA1veM9KG6J/NXSEj4tywJ4rWJ5eVvVFSxkj9SSe3BO6WYTjnVx5vM+jS5ta5IkUM0tBAtGG2zrBGpab8RDVaF4ZOHX2867/+jwIK5jYVRm1kcMtiMr572VV3r3gE8eYmyWJ3dpAb2xxl6RB3U2tWb//QHKBNazxnPRTtavGrV13flil9kqG1dzANcbG0WIMRC3xosBKi3CXmks0CRRsw0L/OdOXfREoFhNINhI16F8hpeI12Yp7lpHzl6HQzFTuOdPKI1FU0XGpfdfa6Ioz/9yn25yXw27CUtc9mczzNu4PV9N899kwnlV801VRkZnDUfNTjnxAvwlWo1DoSL9LeOrFiIAp8Ei2MXW2cTEOK/ESQ19RcFQ3d4gxmL+bFFiCQlyUxPRFDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(478600001)(81166007)(356005)(6666004)(70206006)(70586007)(2906002)(82740400003)(36756003)(110136005)(44832011)(7416002)(5660300002)(8936002)(54906003)(8676002)(316002)(86362001)(40480700001)(4326008)(41300700001)(40460700003)(336012)(2616005)(426003)(26005)(186003)(82310400005)(36860700001)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 11:43:15.3159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e1b8bd-1f4b-45fc-371c-08db6b3a3599
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create debugfs entry for reading all the FIFO ECC errors.

Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
---
 drivers/net/can/xilinx_can.c | 62 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 311e435..f7bf31a 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -29,6 +29,7 @@
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
 #include <linux/pm_runtime.h>
+#include <linux/debugfs.h>
 
 #define DRIVER_NAME	"xilinx_can"
 
@@ -183,6 +184,9 @@ enum xcan_reg {
 #define XCAN_FLAG_RX_FIFO_MULTI	0x0010
 #define XCAN_FLAG_CANFD_2	0x0020
 
+/* ECC counters buffer length */
+#define XCAN_ECC_CNT_BUF_LEN	100
+
 enum xcan_ip_type {
 	XAXI_CAN = 0,
 	XZYNQ_CANPS,
@@ -222,6 +226,7 @@ struct xcan_devtype_data {
  * @ecc_1bit_txolfifo_cnt:	TXOLFIFO 1bit ECC count
  * @ecc_2bit_txtlfifo_cnt:	TXTLFIFO 2bit ECC count
  * @ecc_1bit_txtlfifo_cnt:	TXTLFIFO 1bit ECC count
+ * @debugfs:			Directory entry for debugfs
  */
 struct xcan_priv {
 	struct can_priv can;
@@ -246,6 +251,7 @@ struct xcan_priv {
 	u32 ecc_1bit_txolfifo_cnt;
 	u32 ecc_2bit_txtlfifo_cnt;
 	u32 ecc_1bit_txtlfifo_cnt;
+	struct dentry *debugfs;
 };
 
 /* CAN Bittiming constants as per Xilinx CAN specs */
@@ -1736,6 +1742,56 @@ static int __maybe_unused xcan_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static ssize_t read_ecc_cnt_status(struct file *file, char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	unsigned int len = 0, buf_len = XCAN_ECC_CNT_BUF_LEN;
+	struct net_device *ndev = file->private_data;
+	struct xcan_priv *priv = netdev_priv(ndev);
+	ssize_t ret_cnt;
+	char *buf;
+
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	len = scnprintf(buf + len, buf_len - len,
+			"%d\n", priv->ecc_2bit_rxfifo_cnt);
+	len += scnprintf(buf + len, buf_len - len,
+			"%d\n", priv->ecc_1bit_rxfifo_cnt);
+	len += scnprintf(buf + len, buf_len - len,
+			"%d\n", priv->ecc_2bit_txolfifo_cnt);
+	len += scnprintf(buf + len, buf_len - len,
+			"%d\n", priv->ecc_1bit_txolfifo_cnt);
+	len += scnprintf(buf + len, buf_len - len,
+			"%d\n", priv->ecc_2bit_txtlfifo_cnt);
+	len += scnprintf(buf + len, buf_len - len,
+			"%d\n", priv->ecc_1bit_txtlfifo_cnt);
+	ret_cnt = simple_read_from_buffer(user_buf, count, ppos, buf, len);
+
+	kfree(buf);
+
+	return ret_cnt;
+}
+
+static const struct file_operations read_ecc_fops = {
+	.open = simple_open,
+	.read = read_ecc_cnt_status,
+	.llseek = generic_file_llseek,
+};
+
+static void setup_debugfs(struct net_device *ndev)
+{
+	struct xcan_priv *priv = netdev_priv(ndev);
+
+	priv->debugfs = debugfs_create_dir(dev_name(priv->dev), NULL);
+	if (!priv->debugfs)
+		return;
+
+	debugfs_create_file("read_ecc_cnt", 0644, priv->debugfs,
+			    ndev, &read_ecc_fops);
+}
+
 static const struct dev_pm_ops xcan_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(xcan_suspend, xcan_resume)
 	SET_RUNTIME_PM_OPS(xcan_runtime_suspend, xcan_runtime_resume, NULL)
@@ -1974,10 +2030,12 @@ static int xcan_probe(struct platform_device *pdev)
 		   priv->reg_base, ndev->irq, priv->can.clock.freq,
 		   hw_tx_max, priv->tx_max);
 
-	if (priv->ecc_enable)
+	if (priv->ecc_enable) {
+		setup_debugfs(ndev);
 		/* Reset FIFO ECC counters */
 		priv->write_reg(priv, XCAN_ECC_CFG_OFFSET, XCAN_ECC_CFG_REECRX_MASK |
 			XCAN_ECC_CFG_REECTXOL_MASK | XCAN_ECC_CFG_REECTXTL_MASK);
+	}
 
 	return 0;
 
@@ -2000,7 +2058,9 @@ static int xcan_probe(struct platform_device *pdev)
 static int xcan_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct xcan_priv *priv = netdev_priv(ndev);
 
+	debugfs_remove_recursive(priv->debugfs);
 	unregister_candev(ndev);
 	pm_runtime_disable(&pdev->dev);
 	free_candev(ndev);
-- 
2.1.1

