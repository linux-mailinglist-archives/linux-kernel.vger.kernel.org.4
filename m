Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417A065BBD9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbjACIQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbjACIP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:15:57 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD001273;
        Tue,  3 Jan 2023 00:15:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wt1ZXcALfrTKTfzaoKhyNI8YzHwn4WofY+5ow8F0O6no3u61zKi0NQn2QxY7sRroJ7zKdKbV9je5oyVOIHr+JbkYkuRCBMtqxgliSfUIOfi80ecbaHAfnBdf97MxHc8jwe5NzedPby9fm3dGRf7zHHhMFK75znmR+xdpHtZJ4T+yKTM9iGk/7K7swOb6jpqBsUELaXDxHrGGntxVbPAWeCX5Tm8FI3OG+VTfr3NIAqawS9qNhejhZG5jmasai9OKXVtc9CS/YZG6V2IpA5BdcIM55/4i+KjOn2lGbPKQt6I8bry7kf43Ft/1dnHrsjy8YsGMtdve/gnrGt3cQaduKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2kWH0GfBGcoohxGBJ72vuFXou8+Y1tU8ziscxEROuM=;
 b=l7nrXxkoyyzlfjiRY0HvUmIi9xVB6qK1On3re/8kWXJJqzxi5vT+a3JZQgVEOmryCGYtu4QivMg7fVIMh5nCGOd5Ag6A2CswMQnPjLKhUbPEsbtsgg5NxSACV7eRo3TxVl88NOSqFhhqL4zdTQmqcWqt39hJ8rG9rxnAh8FLIForxqn86hMcjpTWenlnZHluwX6sp++keWZAvE1ruGxLMp/KK6Q6auMt8kz7k2Z/dZg9xmtqPmZ0lxgJABu6658mwjkr0hxii20n5oRn7fEdzVqMHHM4Vwnc47BnKaZNqOXjGNVjCQWH+eWCrRhdujADuPLagxI5K+BqzNwmkNsPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2kWH0GfBGcoohxGBJ72vuFXou8+Y1tU8ziscxEROuM=;
 b=dp3xWXcIyRaM4Lx6S8ReeMbssQp/POjmcmwuA04zyZ80QDOSIz7SOsUMEp+/aw2kqlN1fT9Wj5ndbAkreyjJurJWLDhU0TNopDT7/HgSAihOYrytHpZus9R2Dlcu17UoRS500hU992IRAwkyVuj58DmOyOmOG7vu7AlbGLUCeV7T1ypds4JV1sVB8we+osX7vN4pFnK7tmElkRgUnKFaZXnxH9KQVyzZY0QP4hRpRbxqkX/H/emxxqTIs90smbpGXXFsAxKmbra62M8NCnmY9NJsPfnAuJ/QeEC3YYoHEHt78KROiG5cC8iEzc+pUvmIegI0Bztlf97gqQ/P5qRNsQ==
Received: from DM6PR08CA0027.namprd08.prod.outlook.com (2603:10b6:5:80::40) by
 BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.18; Tue, 3 Jan
 2023 08:15:54 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::46) by DM6PR08CA0027.outlook.office365.com
 (2603:10b6:5:80::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Tue, 3 Jan 2023 08:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5966.18 via Frontend Transport; Tue, 3 Jan 2023 08:15:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 3 Jan 2023
 00:15:45 -0800
Received: from 74ef364-lcelt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 3 Jan 2023 00:15:42 -0800
From:   Haotien Hsu <haotienh@nvidia.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Sing-Han Chen <singhanc@nvidia.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        Wayne Chang <waynec@nvidia.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Haotien Hsu <haotienh@nvidia.com>
Subject: [PATCH v3] ucsi_ccg: Refine the UCSI Interrupt handling
Date:   Tue, 3 Jan 2023 16:15:31 +0800
Message-ID: <20230103081531.423017-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a8f08c-25f5-4c1c-1c25-08daed62bb93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 410LpM50hGbu8tQFf2cc7hX7Za34PJWakFl1NMTPGx8VWhG0bCoS2YPJ1lcka8ubdZtPRp1eGdsYbVX2ueCFFfBjoaNZF79y3Y3Agkv1YUnjeMm2k0ZVvobTDlkl3dBvEtLhXyYVuZfppQVUKzdydZXzH+4J/xFee/vQZTHKOs8BnIcip6Mqb304LUKbnu9XgC37mGcm8C8fQKltgqsv2+sMiQTg8W0BmuTMOb2f260x+/fXVP4sY8qJPXIvhrCBtfXi3VaNuvaJfWafyRQ+xsYhtUKZm8aF/tOcoVz0IfSWJO1Ex6cAPGvuzK0xDdG45fpg67P63tf7ksqSXkYBfNdNpQTfRKI212JzIK4giHqg+jVXBK5TLCVIvOHo2CIaRhCjX7nCWdij6h0ei3A5Ep1U4MqedMOQZZUkos77dG6a0nTlWIeaYBxWx+6B8AKI0FsrMyH+kILVDDj+pCjZf0PJMbX4WIY4VdOakrbYOpB/zLmiLVAcr8bhHTn/ay0pEXR1ig9x45tfNb0GNYygpZ7isDfmxkdJc2oenAZ/VxE7Vtuogca0Z6d/6JAFm4+P5Tt+9KgQoax/WkjsJwsu+S9kvjc576eu9l6C+UaNS8b8rY6RfqZRpFSBqz2wkMYSWPKsTCYB5lfmqQCDS1rqCf1nrUmXe4YwYUqdiE/Gl2Fc4HlHoLjB/oat+mwSrS2I+yok6ftoa8KbXfFklbo+eg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(46966006)(36840700001)(54906003)(110136005)(316002)(16526019)(36860700001)(70206006)(26005)(8936002)(82310400005)(8676002)(36756003)(4326008)(186003)(41300700001)(70586007)(86362001)(336012)(7696005)(426003)(107886003)(83380400001)(47076005)(1076003)(6666004)(2616005)(478600001)(7636003)(40480700001)(82740400003)(2906002)(356005)(5660300002)(22166006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 08:15:53.4342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a8f08c-25f5-4c1c-1c25-08daed62bb93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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
V1->V2
- Fix uninitialized symbol 'cci'
v2->v3
- Remove wrong Reported-by tags
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 86 ++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index eab3012e1b01..b35a3a97c9fb 100644
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
@@ -616,12 +678,17 @@ static irqreturn_t ccg_irq_handler(int irq, void *data)
 	struct ucsi_ccg *uc = data;
 	u8 intr_reg;
 	u32 cci;
-	int ret;
+	int ret = 0;
 
 	ret = ccg_read(uc, CCGX_RAB_INTR_REG, &intr_reg, sizeof(intr_reg));
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

