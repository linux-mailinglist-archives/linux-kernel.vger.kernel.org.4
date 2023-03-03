Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80526A9C63
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 17:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjCCQwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 11:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjCCQvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 11:51:46 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607615D8AF;
        Fri,  3 Mar 2023 08:51:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dt0iWX9g3Gev+HG/4BBiN/Jo9OZ5AVwkwfBGncyQ3BlhcP/OYL+KkrtF4YgKBpzteqst+pwCi+lCWE4bUG4/DUb/BID9S/j866jkXJ+qJelH7KGeurI7v2Kzc9fK8mH3KElgVH1lycyU/F6mZbEpf+YuME2YtuYJU/aKoAmNud9pa8ttblbh4QfTKV8x+aXXAUMR7AAo0Dn6GPSEvXrh9cWYIc3UrCLZGEEQ9H3aFJKQgRP2TLlSKT3KQUjP+vauyOGho2+69ywEiL2j1OUUuxziZMgEHKbBFc5qtlNcRZok1B/5Wu+oEblBpzr0yEyzgUMMNoKNEjp0ScmZ5F0nDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTOA2pGzGS2CG8HkmedAOIZUgq3WZCkt4YllrcWGz0w=;
 b=PTPVqHKxbXPyINIUvEfVhMr6Tgh0FXyQDEPbiN/DOWHfz8XSqrHh2HEbqwPq7Ezj9adix/qkpNnSRqviLSjDl6XD9TDo1m8oodUDVbyBEbF3vB041zjsHHK6k+Jlz8jR3H+8mSpKho4G/SfonD8YjLABqtXrr/eKFstqA5rQrgyuG4bF05f6jvKLOEyJaym45j15xG9eYeURijLGMYw8cArKqiKRB2tsdPgj0WA2ftabdSt6SyMJuonGWavqHz/9sZ3RCGpEHG8sEbk8t7+sl1dQn6fs/whkFki5V2qSm/sE4mbzqhGg7wl39D8u0NchChINyvKD8KqjHvrIqI5SLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=semihalf.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTOA2pGzGS2CG8HkmedAOIZUgq3WZCkt4YllrcWGz0w=;
 b=wNdzB20YvtRGtykbVfSnZiBpcs7jvy7ksUPkgwHOKpLfvkuiZ7YZJoXfBlTnpI8FOtyn4IFz73/F0Zgs3W4R+qjEMH3mqgeDfhZEKHfNsp3fJbz+xE2ZVQqPhJztajINUc4jSmWwkBCf79dAXav8ixCNPheCOKCczMk+ITU3WaM=
Received: from MW4P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::33)
 by BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 16:51:17 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::74) by MW4P220CA0028.outlook.office365.com
 (2603:10b6:303:115::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 16:51:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.10 via Frontend Transport; Fri, 3 Mar 2023 16:51:16 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 10:51:15 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     =?UTF-8?q?Jan=20D=C4=85bro=C5=9B?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        <Rijo-john.Thomas@amd.com>, <Thomas.Lendacky@amd.com>,
        <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "John Allen" <john.allen@amd.com>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 7/9] crypto: ccp: Add support for ringing a platform doorbell
Date:   Fri, 3 Mar 2023 10:50:45 -0600
Message-ID: <20230303165050.2918-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303165050.2918-1-mario.limonciello@amd.com>
References: <20230303165050.2918-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT010:EE_|BY5PR12MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: 500244f8-5fba-43b8-09b1-08db1c0781c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8wcBofJz/qbVR9EmRPDxpv1E5ftVahdOBrCx3uAkeOkanIYZ/xm84dAGt8bXnJiNOvtStrvr10EVfqhHasY9XX5PzC4WEtuxDXOe/Q4NRCocbbJDYV3w6d28N6oHWmvYasa5xyOwVwAlcZzqUZ5hOuaMlRHrh65tst3jLqgD4z3cK0tXrllH3tln+AoWPrrj3EMagiccaEFbvn6qrChgF2C5RhH7n55/o7fxGtGhwBWMcRsXaLDQXdwXrQilqXIWcQfJoMy92hdgCzBaAezxEuUibHGKmKdK+wMIwuQtqAqgZGEbPY+E09zWVg/Sk3qtoKZvIFrt1HQEiy2XIz4GjkR8DoRf1K+/oyuOyypcIzVJasgS2bNHcQQ70GAJzcUSKWA5Xg8YJxpO/zgrTgeoDh8s0SrtfwHjZ2LFPmuierK1j+IfZmuOKRxdj972zQSVKVqrUxKMk5IDxZ0x8uJ7lgF3HyL5b2yj0iknH/rfmV5OiokJmfRCVXm3L70W42u/hDgmzZ4rYENAg1o14a8bdmSRahXPNIx5XopQEJzIEMhTNx6Rga6eYJM2oy9cC6UvA4eCY7YgCpmF0dKa6wHtNXuwKNhEyxdCn+j3k739BRmTApnK7O9QQOdubUGJN3463sc1ZDoVLFPNgTTTtea8LxCoQZZan32G3RUzgVQZ1lPtTH1SwbrYj2tz7uEqr5t+KISoz8cb8xJw1yWKY8juD5QTEP7JYhwCf/Uo8R2Ndpj5PsAbbFyxlRfcdcn7UPPc
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199018)(36840700001)(46966006)(40470700004)(2906002)(70586007)(82310400005)(70206006)(316002)(8676002)(966005)(44832011)(8936002)(40480700001)(36756003)(41300700001)(4326008)(2616005)(40460700003)(426003)(83380400001)(47076005)(336012)(186003)(6666004)(16526019)(7696005)(110136005)(54906003)(356005)(6636002)(478600001)(86362001)(1076003)(36860700001)(82740400003)(81166007)(26005)(5660300002)(36900700001)(134885004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 16:51:16.8886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 500244f8-5fba-43b8-09b1-08db1c0781c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms support using a doorbell to communicate. Export
this feature for other drivers to utilize as well.

Link: https://lore.kernel.org/linux-i2c/20220916131854.687371-3-jsd@semihalf.com/
Suggested-by: Jan Dabros <jsd@semihalf.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Squash register values in
 * Use command and button registers
 * Correct register values for incorrect ones previously shared
 * Use a unique mutex
v1->v2:
 * New patch
---
 drivers/crypto/ccp/platform-access.c | 52 ++++++++++++++++++++++++++++
 drivers/crypto/ccp/platform-access.h |  1 +
 drivers/crypto/ccp/sp-dev.h          |  3 ++
 drivers/crypto/ccp/sp-pci.c          |  2 ++
 include/linux/psp-platform-access.h  | 15 ++++++++
 include/linux/psp.h                  |  3 ++
 6 files changed, 76 insertions(+)

diff --git a/drivers/crypto/ccp/platform-access.c b/drivers/crypto/ccp/platform-access.c
index d7669a44dcfe..332e12637d48 100644
--- a/drivers/crypto/ccp/platform-access.c
+++ b/drivers/crypto/ccp/platform-access.c
@@ -132,6 +132,56 @@ int psp_send_platform_access_msg(enum psp_platform_access_msg msg,
 }
 EXPORT_SYMBOL_GPL(psp_send_platform_access_msg);
 
+int psp_ring_platform_doorbell(enum psp_platform_access_msg msg)
+{
+	struct psp_device *psp = psp_get_master_device();
+	struct psp_platform_access_device *pa_dev;
+	u32 __iomem *button, __iomem *cmd;
+	int ret, val;
+
+	if (!psp || !psp->platform_access_data)
+		return -ENODEV;
+
+	pa_dev = psp->platform_access_data;
+	button = psp->io_regs + pa_dev->vdata->doorbell_button_reg;
+	cmd = psp->io_regs + pa_dev->vdata->doorbell_cmd_reg;
+
+	mutex_lock(&pa_dev->doorbell_mutex);
+
+	if (check_recovery(cmd)) {
+		dev_dbg(psp->dev, "doorbell in recovery\n");
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (wait_cmd(cmd)) {
+		dev_dbg(psp->dev, "doorbell not done processing command\n");
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	iowrite32(FIELD_PREP(PSP_DRBL_MSG, msg), cmd);
+	iowrite32(PSP_DRBL_RING, button);
+
+	if (wait_cmd(cmd)) {
+		ret = -ETIMEDOUT;
+		goto unlock;
+	}
+
+	val = FIELD_GET(PSP_CMDRESP_STS, ioread32(cmd));
+	if (val) {
+		ret = -EIO;
+		goto unlock;
+	}
+
+	ret = 0;
+unlock:
+	mutex_unlock(&pa_dev->doorbell_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(psp_ring_platform_doorbell);
+
 void platform_access_dev_destroy(struct psp_device *psp)
 {
 	struct psp_platform_access_device *pa_dev = psp->platform_access_data;
@@ -140,6 +190,7 @@ void platform_access_dev_destroy(struct psp_device *psp)
 		return;
 
 	mutex_destroy(&pa_dev->mailbox_mutex);
+	mutex_destroy(&pa_dev->doorbell_mutex);
 	psp->platform_access_data = NULL;
 }
 
@@ -159,6 +210,7 @@ int platform_access_dev_init(struct psp_device *psp)
 	pa_dev->vdata = (struct platform_access_vdata *)psp->vdata->platform_access;
 
 	mutex_init(&pa_dev->mailbox_mutex);
+	mutex_init(&pa_dev->doorbell_mutex);
 
 	dev_dbg(dev, "platform access enabled\n");
 
diff --git a/drivers/crypto/ccp/platform-access.h b/drivers/crypto/ccp/platform-access.h
index c3a97893320d..a83f03beb869 100644
--- a/drivers/crypto/ccp/platform-access.h
+++ b/drivers/crypto/ccp/platform-access.h
@@ -24,6 +24,7 @@ struct psp_platform_access_device {
 	struct platform_access_vdata *vdata;
 
 	struct mutex mailbox_mutex;
+	struct mutex doorbell_mutex;
 
 	void *platform_access_data;
 };
diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
index 5ec6c219a731..1253a0217985 100644
--- a/drivers/crypto/ccp/sp-dev.h
+++ b/drivers/crypto/ccp/sp-dev.h
@@ -57,6 +57,9 @@ struct platform_access_vdata {
 	const unsigned int cmdresp_reg;
 	const unsigned int cmdbuff_addr_lo_reg;
 	const unsigned int cmdbuff_addr_hi_reg;
+	const unsigned int doorbell_button_reg;
+	const unsigned int doorbell_cmd_reg;
+
 };
 
 struct psp_vdata {
diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index 18aa902eb5ce..b5896f7af7ab 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -365,6 +365,8 @@ static const struct platform_access_vdata pa_v1 = {
 	.cmdresp_reg		= 0x10570,	/* C2PMSG_28 */
 	.cmdbuff_addr_lo_reg	= 0x10574,	/* C2PMSG_29 */
 	.cmdbuff_addr_hi_reg	= 0x10578,	/* C2PMSG_30 */
+	.doorbell_button_reg	= 0x10a24,	/* C2PMSG_73 */
+	.doorbell_cmd_reg	= 0x10a40,	/* C2PMSG_80 */
 };
 
 static const struct psp_vdata pspv1 = {
diff --git a/include/linux/psp-platform-access.h b/include/linux/psp-platform-access.h
index f5a03cd11f10..1e1d0e077cec 100644
--- a/include/linux/psp-platform-access.h
+++ b/include/linux/psp-platform-access.h
@@ -35,6 +35,21 @@ struct psp_request {
  */
 int psp_send_platform_access_msg(enum psp_platform_access_msg, struct psp_request *req);
 
+/**
+ * psp_ring_platform_doorbell() - Ring platform doorbell
+ *
+ * This function is intended to be used by drivers outside of ccp to ring the
+ * platform doorbell with a message.
+ *
+ * Returns:
+ *  0:           success
+ *  -%EBUSY:     mailbox in recovery or in use
+ *  -%ENODEV:    driver not bound with PSP device
+ *  -%ETIMEDOUT: request timed out
+ *  -%EIO:       unknown error (see kernel log)
+ */
+int psp_ring_platform_doorbell(enum psp_platform_access_msg);
+
 /**
  * psp_check_platform_access_status() - Checks whether platform features is ready
  *
diff --git a/include/linux/psp.h b/include/linux/psp.h
index d3424790a70e..92e60aeef21e 100644
--- a/include/linux/psp.h
+++ b/include/linux/psp.h
@@ -23,4 +23,7 @@
 #define PSP_CMDRESP_RECOVERY	BIT(30)
 #define PSP_CMDRESP_RESP	BIT(31)
 
+#define PSP_DRBL_MSG		PSP_CMDRESP_CMD
+#define PSP_DRBL_RING		BIT(0)
+
 #endif /* __PSP_H */
-- 
2.34.1

