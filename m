Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549BA652E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiLUIi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLUIiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:38:55 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4151900A;
        Wed, 21 Dec 2022 00:38:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIfKenBbDKlcJDrbY05PSoz3uS3oCO8VY2n2tvE7K7PoEwaHRW481479ZScHRPSUz+kA0g3DR08oAFFTRlqJkuCkZ2RFf0qDl4HdpzvzaasdVINloqkZkj0FPo89rcJ1Cn2AdkhCf+P4NynlMI4S1sgrniIEYvnKPBlfy4+eFolsHnF+hHXF8AAiimDmAz/klij2NASJllrXlU5dY5nqq+BlPE81aPFwk/wMpGIc5bytanPu4IKZDWlKmU+SlvCK/i2XT45IgbJZ2mpUV+738/5d1RhRbHAOv7Rhakqzkafa75ef3x+m3be6ffBmPfJE4iUUMnbZ2up4W5xRghL+Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=km9fV0cRlqiX2JXMFF94a+sU8QImK18P/sLCSxJcEQs=;
 b=COVVqVqZMxI/XyUI+OIuYKp1KR4jo3dzGS6f+iZ7GVUx8Uc6n+3t1yoFmuJ13ZY0V7IWE5NdkhoJ21X9RspOQC3yQc6IQyNf3bdqznILPltwaA8cyO6gPjwcHY4YTw1Wyqml3eC8TBsfDwCcvv9QaDknwMR1glirvseggxbLsjMsWu2Q0eNebrIHPaDgINcQ5Oqv7XXZJOtBDzaynyLVwtew4IOJndtAumiuIZrmtLprIVLClwGgyLYBs1+nYVPF7kUM+iopuvg19fSvA1wFSSiy5JPdM7uS+ykkreyQYwqtZWdTmL3c/BEKuaHZjE3fnexJUFKGF8uwK2Blzat+JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=km9fV0cRlqiX2JXMFF94a+sU8QImK18P/sLCSxJcEQs=;
 b=ofMiqE9BkvW5lLNDcjh8qYuBFMn6cPLJIcBvlIPZRI73ajv7aV53SmRu573QkBDTP4d9SosVsSnx5KCNrysluZJ6IiDUZCCV3LewelSthtOklZVG5K499zgt4FV1MtRgSCpaxharblfUn+kuOSjTGptykmpy42eJUA4ivraKtxFABNxBGb9NHKz99kKMt2ky3Z4V1rFZ9m7XJMFCto5esBKi7sQBar15C/FgFMq+zppVUs+HEpvND4jONr2XRXi3RlyZFJZSkKVY6RJWeE1YacOd7gNvIlZcB9cNTrVsRpZbVOH/OE488dGXAJt/0IFBpGX4ANTmMBIXYDztmpzYYg==
Received: from BN1PR10CA0008.namprd10.prod.outlook.com (2603:10b6:408:e0::13)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 08:38:52 +0000
Received: from BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::67) by BN1PR10CA0008.outlook.office365.com
 (2603:10b6:408:e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Wed, 21 Dec 2022 08:38:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT090.mail.protection.outlook.com (10.13.177.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.10 via Frontend Transport; Wed, 21 Dec 2022 08:38:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 21 Dec
 2022 00:38:36 -0800
Received: from 74ef364-lcelt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 21 Dec 2022 00:38:33 -0800
From:   Haotien Hsu <haotienh@nvidia.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Wayne Chang <waynec@nvidia.com>,
        Sing-Han Chen <singhanc@nvidia.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Haotien Hsu <haotienh@nvidia.com>
Subject: [PATCH] ucsi_ccg: Refine the UCSI Interrupt handling
Date:   Wed, 21 Dec 2022 16:38:12 +0800
Message-ID: <20221221083812.3363045-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT090:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba09d95-8931-4d33-1f38-08dae32ec969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kzeJeGemaY1pDQOukeDFOr0/06Avluj07YIxy1a93ucpGER9+Ykxf3AnICVoNQWrJ+TK65NXhlvGRFn31V0LYPGIEPbRWVOMiCW9f1DCKQgVn95troSyi5WuuNigZl0x2pQnbmh03pmeUFynp/9ky6sI12Rp8X9+a4m1PC+7H6uUfdmCzMw0X//+Vip8/wdblm0FE/Fo6nVPb7P+4wNsMpFZIjwJOyRweNAZ4qXGHXkt6LyW/Sj9fPWTNcE752zAaVG74NSQ9lvUuC+MeOZ7SR8TjrYLS4/LjTe8CVk0I9rWDe7TlkmQ5AM5Zqr/GHNaHDvJOu+NkNrZMVoY7JyiEqE320Hjmj9d7Rlj2BTMFBezj1024hFe074VBcXkf6tZSmHQ7+ZrAF0+ui2pUbyf62UMMxnyIMRwd1goW7UIopx4rsivMp8xrFZ3JzRKaAqo/YVlO2xrT9OT8SI8uQTYCh73BC14No+uwb9FfWf1jzoB+KosoS8k52/l6DjXowt1recEI9U4K63rzOOj/iiC1oCyHE1xnvtlK4E5o5rmFx1SB7r5UwcSO7kkjnXuQBggbpHy0cokbd86Ar+3tezZpInJtZKjPjw0Fda4Ifsng0HPdPFxU17RvWgTyDfHEvAP0929natkzf+L2UyXueRW9vrVq64iChUWaAoxyd9iASYATtfymyYtKbUkBgyGe3CuVlYGdizOzKP/FXy9EvogAA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(107886003)(6666004)(40480700001)(54906003)(110136005)(36860700001)(47076005)(8936002)(5660300002)(83380400001)(426003)(40460700003)(356005)(478600001)(16526019)(26005)(41300700001)(186003)(7696005)(336012)(2906002)(82310400005)(7636003)(70586007)(316002)(4326008)(2616005)(36756003)(8676002)(86362001)(70206006)(82740400003)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 08:38:51.1425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba09d95-8931-4d33-1f38-08dae32ec969
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sing-Han Chen <singhanc@nvidia.com>

For the CCGx, when the OPM field in the INTR_REG is cleared, then the
CCI data in the PPM is reset.

To align with the CCGx UCSI interface guide, this patch updates the
driver to copy CCI and MESSAGE_IN before clearing UCSI interrupt.
When a new command is sent, the driver will clear the old CCI and
MESSAGE_IN copy.

Finally, clear UCSI_READ_INT before calling complete() to ensure that
the ucsi_ccg_sync_write() would wait for the interrupt handling to
complete.
It prevents the driver from resetting CCI prematurely.

Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 84 ++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index eab3012e1b01..f59494aae6b9 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -192,6 +192,12 @@ struct ucsi_ccg_altmode {
 	bool checked;
 } __packed;
 
+#define CCGX_MESSAGE_IN_MAX 4
+struct op_region {
+	u32 cci;
+	u32 message_in[CCGX_MESSAGE_IN_MAX];
+};
+
 struct ucsi_ccg {
 	struct device *dev;
 	struct ucsi *ucsi;
@@ -222,6 +228,9 @@ struct ucsi_ccg {
 	bool has_multiple_dp;
 	struct ucsi_ccg_altmode orig[UCSI_MAX_ALTMODES];
 	struct ucsi_ccg_altmode updated[UCSI_MAX_ALTMODES];
+
+	spinlock_t op_lock;
+	struct op_region op_data;
 };
 
 static int ccg_read(struct ucsi_ccg *uc, u16 rab, u8 *data, u32 len)
@@ -305,12 +314,57 @@ static int ccg_write(struct ucsi_ccg *uc, u16 rab, const u8 *data, u32 len)
 	return 0;
 }
 
+static void ccg_op_region_read(struct ucsi_ccg *uc, unsigned int offset,
+		void *val, size_t val_len)
+{
+	struct op_region *data = &uc->op_data;
+
+	spin_lock(&uc->op_lock);
+	if (offset == UCSI_CCI)
+		memcpy(val, &data->cci, val_len);
+	else if (offset == UCSI_MESSAGE_IN)
+		memcpy(val, &data->message_in, val_len);
+	spin_unlock(&uc->op_lock);
+}
+
+static void ccg_op_region_update(struct ucsi_ccg *uc, u32 cci)
+{
+	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(UCSI_MESSAGE_IN);
+	struct op_region *data = &uc->op_data;
+	u32 message_in[CCGX_MESSAGE_IN_MAX];
+
+	if (UCSI_CCI_LENGTH(cci))
+		if (ccg_read(uc, reg, (void *)&message_in,
+					sizeof(message_in))) {
+			dev_err(uc->dev, "failed to read MESSAGE_IN\n");
+			return;
+		}
+
+	spin_lock(&uc->op_lock);
+	memcpy(&data->cci, &cci, sizeof(cci));
+	if (UCSI_CCI_LENGTH(cci))
+		memcpy(&data->message_in, &message_in, sizeof(message_in));
+	spin_unlock(&uc->op_lock);
+}
+
+static void ccg_op_region_clean(struct ucsi_ccg *uc)
+{
+	struct op_region *data = &uc->op_data;
+
+	spin_lock(&uc->op_lock);
+	memset(&data->cci, 0, sizeof(data->cci));
+	memset(&data->message_in, 0, sizeof(data->message_in));
+	spin_unlock(&uc->op_lock);
+}
+
 static int ucsi_ccg_init(struct ucsi_ccg *uc)
 {
 	unsigned int count = 10;
 	u8 data;
 	int status;
 
+	spin_lock_init(&uc->op_lock);
+
 	data = CCGX_RAB_UCSI_CONTROL_STOP;
 	status = ccg_write(uc, CCGX_RAB_UCSI_CONTROL, &data, sizeof(data));
 	if (status < 0)
@@ -520,9 +574,13 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
 	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
 	struct ucsi_capability *cap;
 	struct ucsi_altmode *alt;
-	int ret;
+	int ret = 0;
+
+	if ((offset == UCSI_CCI) || (offset == UCSI_MESSAGE_IN))
+		ccg_op_region_read(uc, offset, val, val_len);
+	else
+		ret = ccg_read(uc, reg, val, val_len);
 
-	ret = ccg_read(uc, reg, val, val_len);
 	if (ret)
 		return ret;
 
@@ -559,9 +617,13 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
 static int ucsi_ccg_async_write(struct ucsi *ucsi, unsigned int offset,
 				const void *val, size_t val_len)
 {
+	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
 	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
 
-	return ccg_write(ucsi_get_drvdata(ucsi), reg, val, val_len);
+	if (offset == UCSI_CONTROL)
+		ccg_op_region_clean(uc);
+
+	return ccg_write(uc, reg, val, val_len);
 }
 
 static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
@@ -622,6 +684,11 @@ static irqreturn_t ccg_irq_handler(int irq, void *data)
 	if (ret)
 		return ret;
 
+	if (!intr_reg)
+		return IRQ_HANDLED;
+	else if (!(intr_reg & UCSI_READ_INT))
+		goto err_clear_irq;
+
 	ret = ccg_read(uc, reg, (void *)&cci, sizeof(cci));
 	if (ret)
 		goto err_clear_irq;
@@ -629,13 +696,18 @@ static irqreturn_t ccg_irq_handler(int irq, void *data)
 	if (UCSI_CCI_CONNECTOR(cci))
 		ucsi_connector_change(uc->ucsi, UCSI_CCI_CONNECTOR(cci));
 
-	if (test_bit(DEV_CMD_PENDING, &uc->flags) &&
-	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
-		complete(&uc->complete);
+	/* As per CCGx UCSI interface guide, copy CCI and MESSAGE_IN
+	 * to the OpRegion before clear the UCSI interrupt
+	 */
+	ccg_op_region_update(uc, cci);
 
 err_clear_irq:
 	ccg_write(uc, CCGX_RAB_INTR_REG, &intr_reg, sizeof(intr_reg));
 
+	if (!ret && test_bit(DEV_CMD_PENDING, &uc->flags) &&
+	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
+		complete(&uc->complete);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.25.1

