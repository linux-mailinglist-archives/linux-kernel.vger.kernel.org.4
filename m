Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADE1671466
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjARGji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjARG00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:26:26 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1616392BE;
        Tue, 17 Jan 2023 22:16:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kko+xHrh28WVzwVRbe5pmzBaYaxDKxXof3Ugpk5ZnnPV8agmiV1lnWNIJrUhsG/yGEqANKVKhxEisU5+sme8zODZgL8jH+1nt1vqKq7SLhuf9BjPsWP9jfnlPNurMKwu1/sVoX5NAc8A42RrWgnlK1ucO06zrZAa+MllyVFbv5x57uUgmAWdNtqW9vPfqSTXoY4DqSsLWxy/4rcLEpknp1ori5irK5lJdaGiCtvgiVZEnaVplYxi7QlC9HJH0qk3223TDF8ARjAkUHeQpshzQrK6LfldqLPxEniL31dDWCl3LVXYkFSVqV9r3Z1BLSazLpW1ogqf4lG7ILd/+OmhjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnOTzyaFmHKD1XejeQe9TaohrpLDNpYaKYSvJm6bGgE=;
 b=e60fDHhOkl8C3UgRSf2NsOEzH2eB0NUMVGNLjHWqxPzGq+09cjNgqjCyEkqDhcZDL+SLE3IGvDJIExbpPUS4RFBQCU/4zILuvanMB8mphrnKKPgjqB+Xd0BWV/atNazM6Ik99pVDlN6O9WlTdRsVeM78wyakxFjwMyw54z86vLFwqR0G1h7T38ek/ZTrPP7AaCyy3otWdR9Yd7JGokQVRRQcIOXLkudWhixly5fR8W5STNg2GPXKkQ9RMihvK1MwSuq73U1G3LZlMbBwDAYpgajLw1BVu4hblBszh3qDufyDga1FlpgkgkYsOBvxfziZXTMF8o2rSMBrhBmFaWHDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnOTzyaFmHKD1XejeQe9TaohrpLDNpYaKYSvJm6bGgE=;
 b=I6vJUkrzIjdc6mDTmJRpuTAB7PGoL3OCmQPQ9O+c+f4OKbDLWi2WHOGJQwQTtR4FEHfr38ZigF97PupRj1pH8RSpq5/Aw8RJL6VBd+hQPCjxaUv9JYv9yki9+Gz2S1wNN8MY761IB89gdQBsWu24VLarPoQAaOG5ZDSyty1dmFRd9GRDpWVmGKfF24JslX19ZjHGxiagHz6Srb/VCCU5RzkSOSMAN56ZJSXmMoji2M8V8zCLpo/bad0lj/+YOQyNvfEuCbIdqVg5evda7uFPFYaNJ5mGNauZ560G+yNRrz0HxaEnUUv+GDdXLjvGKE2t6xzuFZ/ehN/1LeBQFTcXUQ==
Received: from SJ0PR03CA0358.namprd03.prod.outlook.com (2603:10b6:a03:39c::33)
 by CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 06:16:06 +0000
Received: from CO1PEPF00001A62.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::44) by SJ0PR03CA0358.outlook.office365.com
 (2603:10b6:a03:39c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 06:16:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00001A62.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11 via Frontend Transport; Wed, 18 Jan 2023 06:16:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 17 Jan
 2023 22:15:43 -0800
Received: from 74ef364-lcelt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 17 Jan 2023 22:15:41 -0800
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
Subject: [PATCH v4] ucsi_ccg: Refine the UCSI Interrupt handling
Date:   Wed, 18 Jan 2023 14:15:23 +0800
Message-ID: <20230118061523.1537992-1-haotienh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A62:EE_|CY8PR12MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f621f5-801e-479e-90c8-08daf91b7af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hcBSqYmZO5cGC18ps1MPpPdCs9aCTSZi/dIW4w1E8K57gDQbyrVFbMZ24V3GL8Jl20dcZZq33vL90nCLCxB4alCYVOHuoRD4VqitYqDu5oxbzyGslBeRn92kG8DHAMiqDh146s0nREC2102Zt4txxfPa4iJ2mc+TjYIfkLvw0cCMdeu9LDX9wEM/H6vPuitermPl5skYQQPZ3rLWlslkROIxvB2in4dsfjgLdpqEabfycnScsQd956G1NjgBd7sWQz6sAnax7BM1fkCcWSlZ+4jr43YAjwUeUjBOy/jlC+5KIOZ1ErAjvtixRXuRJIKulv7Z9PNAZivHljgrvqyUXZVqZ2y7XDA+8+RnQejk7IpeSeKZd2IRJ8EeCGvfZnSgpT/Nsmj6/hXQXsilzLjXXSK2KNoUINjacVReYC9Q0qpnHjUv1efQPDD72XOJ5pOCTSMHFDu8367e2xYSqZMaWXPYV5U+EVp/lPcBabVaPiBu8uOewtKi1A4fzef32DrcDFRT9gm2OOvy3pFm1XDrLrUZMnRujQLWFoQVWvaCxSZDTNKhG4eBszXcZKF8nY6ctdUXCMkK5NhvK0mlZCeUAAD50nudQc8bMlbCCff5BCx39sl3JjY6W+gIXeeP7L8ZywyUzh75+YQSv4WzfXADSNoNC6rAMmEEeXwIjlrK3ym43LeF4FMovEePoAtmPwSifzC6sACka7fnVgsHMZ6VmA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(83380400001)(8936002)(41300700001)(5660300002)(4326008)(8676002)(70586007)(47076005)(426003)(82310400005)(86362001)(2906002)(40460700003)(70206006)(36860700001)(36756003)(40480700001)(356005)(7636003)(82740400003)(6666004)(2616005)(7696005)(107886003)(478600001)(186003)(26005)(16526019)(110136005)(1076003)(316002)(54906003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 06:16:04.7195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f621f5-801e-479e-90c8-08daf91b7af6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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
- Remove misusing Reported-by tags
v3->v4
- Add comments for op_lock
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 90 ++++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index eab3012e1b01..532813a32cc1 100644
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
@@ -222,6 +228,13 @@ struct ucsi_ccg {
 	bool has_multiple_dp;
 	struct ucsi_ccg_altmode orig[UCSI_MAX_ALTMODES];
 	struct ucsi_ccg_altmode updated[UCSI_MAX_ALTMODES];
+
+	/*
+	 * This spinlock protects op_data which includes CCI and MESSAGE_IN that
+	 * will be updated in ISR
+	 */
+	spinlock_t op_lock;
+	struct op_region op_data;
 };
 
 static int ccg_read(struct ucsi_ccg *uc, u16 rab, u8 *data, u32 len)
@@ -305,12 +318,57 @@ static int ccg_write(struct ucsi_ccg *uc, u16 rab, const u8 *data, u32 len)
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
@@ -520,9 +578,13 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
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
 
@@ -559,9 +621,13 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
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
@@ -616,12 +682,17 @@ static irqreturn_t ccg_irq_handler(int irq, void *data)
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
@@ -629,13 +700,18 @@ static irqreturn_t ccg_irq_handler(int irq, void *data)
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

