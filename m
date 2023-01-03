Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2603D65B96E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 03:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbjACClG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 21:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjACClC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 21:41:02 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D95EB58;
        Mon,  2 Jan 2023 18:40:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oH9CwGcwf6NGHe5wbfbn0FnpcmawqJ1JI5X70H8yitbkyTFiJ/UrFxFN6JPgS4jtnjLrQDgW+ARxUgaMXcGmUyKkpdHrIQN/Gpe3oP12qpr3xy7aeEsAnr3P1ZkmARMATXSzj8yxdwD5G2LHRDgRsyT5AVqOMqcp/sA0LIGR6YIt2Xb71PhyaHOfU4uk5roXL8mVnjlgClJP0Kr9HUN2GUV28NcC922YwfyHrXXQ9FalccE0wNAGzscypsw3xtnIZBiI1WFAXIlUx8dF1kFCggsRpAxHL53eZh4Cn+YWR4tgrm4eFKkfyUjgu4G2+y3efZmuxzZov8e9BgNZoAbZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPFl7cHT/SPX/41AIozbIQJoJMr/YNEUJd4RtXfs/Vc=;
 b=VXxGXtM+QFS5/tI1P7xjiP9IFlj9rn68zw1wpskMIytSr91aNpoZm3lihztWbmpb/bsXC/Iw2+katIm32OAGk0KD8zhv6TY+oqbpB7Mu4hSJ6ufO0o+HapC2c/SuTQJSeSRpH2buai/zxLLlCK7rsg2tKaF+XapJb1nah/Zp7e2MWF+06TiJu9jtaWv97zne+Dp+xKBFqGcS22H81j9uuqXN/5UqobWHkBnZaC+V24XsRyCzGqyzdPcITpHTIDs0amDErtLz4JaXbkXqlEt5YT6jdMuWcsVY9XVKQMSMHO9yW+f7f3O+RHelG0rkNhlE41SIWEc+LjFCACHK2a74tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPFl7cHT/SPX/41AIozbIQJoJMr/YNEUJd4RtXfs/Vc=;
 b=Oqc5Bt9myKLqHyT1mF7Vb7DFsL74V75KFs0vhimVfgKsBfWX8iRx3F4NrzXjsMX4NHNZdGhxKod2/TfpKknt1uqI4o3UtlM0AC3rAwCfeLvmy4v0/iKqNZF1U9X8kdq1vAfavUwhDXLgemIlPQC/DwLmJ/QdWtaps9bE6qsa0FkFOoulyGduOQDWzSVVU5q//cUMCAAT/03yhwJGS12m1mv4fnZq1gx5rerjLYY/smWniAZfUZ2/CGYLup/ewqSSF+sk1iMAfTdqY9XbzVHz2OaRqkAf8MonmCkYAND/Rc6Ne2tkCg7DoE3SN4CkGSrxNgk7EWGVpg1kFGEEl4ceAg==
Received: from MW4PR03CA0294.namprd03.prod.outlook.com (2603:10b6:303:b5::29)
 by CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 02:40:52 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::82) by MW4PR03CA0294.outlook.office365.com
 (2603:10b6:303:b5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Tue, 3 Jan 2023 02:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.17 via Frontend Transport; Tue, 3 Jan 2023 02:40:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 2 Jan 2023
 18:40:39 -0800
Received: from 74ef364-lcelt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 2 Jan 2023 18:40:37 -0800
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
Subject: [PATCH v2] ucsi_ccg: Refine the UCSI Interrupt handling
Date:   Tue, 3 Jan 2023 10:40:23 +0800
Message-ID: <20230103024023.235098-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 201f2c55-23ef-4228-32c5-08daed33ee66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: swDZOtYuSLUrfeUBNq2oVvlcYfiA2IxP6+f8abbD/1L5ak/stg8FWTFhFIEG0X761GLHQ0QRAEaGwxnHLFl/K+dYOTLji5R8301N7aRC7mMVfHXVLYZnxflPEwZVvUP5wHNpQoUxPy5Vy2ES7nnUdUUHc2IF7IKWYZ1Gri9EuqtI46AaN/QUT9AjbCJ7/gpxTmHh/T1u2ifz/B99IkvYzzR2tovSTO0auB3nuHZ6U4ie77NwgLs2BOgugNpH2sltN/cTYDRdSr+byEkc6WBb8+8sC/Ls2YxxsjKB5us2z4vzqSUAIfH8Fksoi+iU1lfNHhPN84tJj9Knye37mtYdtJYzUatOG8qsrgfSiVq1/4O2o1yYeYws3Ya+ftsSfN+pY0VzsrZU84YH4UXigqnqB5tCdwKTAXMTtNj6HYU26Hwjt52oGaNheO9Ete25/BR+PM+LELRBMJ60FOGw2GgDAGmFd1OCHFJvwENPazoi0U5lOOMywkt/Fj/4SMARFeBXfadJhaCIdMo7ZuBud7RQcwwv2nB/Any19UwdF8YMdjZMe/Qk71UHkBVG1lhJzvMsTptLc2q6nck3RuxY0Q4HxrECu11EibhUtF7DTu84VhPQ6qah3tXSDQLa7jg86A5MW6CmYdkKaFaWyJaaUxVDsAuU7IVqoQ61mQhpj1sB/EQdDas7iDR4bqmry/4q8qmpAPSySlNel1I6Xmm33XQ755pusKWsYgCthVX/L2R7ugM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(70586007)(5660300002)(316002)(2906002)(54906003)(41300700001)(8676002)(4326008)(8936002)(70206006)(36756003)(478600001)(110136005)(36860700001)(82310400005)(6666004)(107886003)(1076003)(26005)(186003)(16526019)(47076005)(426003)(336012)(7696005)(2616005)(83380400001)(40480700001)(82740400003)(86362001)(7636003)(40460700003)(356005)(22166006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 02:40:52.4042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 201f2c55-23ef-4228-32c5-08daed33ee66
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683
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
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
---
V1->V2
- Fix uninitialized symbol 'cci'
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

