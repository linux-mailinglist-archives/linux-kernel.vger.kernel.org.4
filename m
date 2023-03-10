Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4026B52C5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjCJVZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjCJVZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:25:20 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9106B30EB3;
        Fri, 10 Mar 2023 13:24:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLnSNujZnzZ8Wy7YyccLSaP4qqRg3VUEd5+YA1ziF/sBMDyUZQCb9JTIc+AKkwgWMZDYytjG5pFjjX093lVKX1IMYTO4ccjpTClZ13sRGmBh6wzmBUtTEJB3Oj7JWrcu/Py0En52tMihv7S029X1Mx1IWe4FGBINFyh/GkPX+VmBINZv5HoANxfyjn0TrLmBBskZwk0QXRVBNsKiFbHROK0jAUOnkibI/9gM6GKp7+wsuhlDWxP7kWRgBhV+sHZW1yiAAPnPhioSnTH0nUe+3w3AhRHFFm6glQFPA27+0OgauWURGJaKSP6GHOam4iJTK9moeQpn1Vlrp9X7ZiSHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVmG8q9riLCYn//zWKQ8FRdHrtalOkTEWH2u57Q5/VE=;
 b=TD0pk2L5xPjFz/CPsEwkM4eHiFwC/MzAznRYUunwi3ErI7O3ItkzC7pHIic0CFFYOimFRRadyDkiT85HB5YPjdeRvYewOrc52BQD6NlYekTcD6wcmA2PLaqHg0W+AruKJtOztQ3T10yot8YVkpt/+YoJ2l72R9t9pwc0E5BBz4XCLMTM8MeBjbDTSijiqCgjLPneNuCc+ptlEAcqrgsoKm7VruPbOKJDcFjajvk3B2Uqe0pf6SM6JWmzKuWC3fa96NnLF6L4m1Ui1fk/ziZUi1Tba0m3UR+L5pxoaYwH0C3a+3oCY5FrfkUM49CBGtM5wxxcc+IEjaKVXndjWcFVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=semihalf.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVmG8q9riLCYn//zWKQ8FRdHrtalOkTEWH2u57Q5/VE=;
 b=tt8BEbChSh7xcevL9l+Sd+kmlfcv4W6uGN6K6lYjvQ+Y1a2u71AtDcTVvWGp7WiAziZBj/pY7W0uBSQRWbV2dznoVY7PrGp3Nm9R8gtLtNyWKeLkhhWV80GEMeYlorjqRUJc5w/UztHebkkj80raVQSsXlcxLI8qkpUz7fUSi7A=
Received: from DM6PR05CA0037.namprd05.prod.outlook.com (2603:10b6:5:335::6) by
 DM4PR12MB5325.namprd12.prod.outlook.com (2603:10b6:5:390::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Fri, 10 Mar 2023 21:22:34 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::c) by DM6PR05CA0037.outlook.office365.com
 (2603:10b6:5:335::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 21:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.20 via Frontend Transport; Fri, 10 Mar 2023 21:22:34 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 15:22:33 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     =?UTF-8?q?Jan=20D=C4=85bro=C5=9B?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        <Rijo-john.Thomas@amd.com>, <Thomas.Lendacky@amd.com>,
        <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "John Allen" <john.allen@amd.com>
CC:     <Felix.Held@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 7/8] crypto: ccp: Add support for ringing a platform doorbell
Date:   Fri, 10 Mar 2023 15:19:50 -0600
Message-ID: <20230310211954.2490-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310211954.2490-1-mario.limonciello@amd.com>
References: <20230310211954.2490-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT062:EE_|DM4PR12MB5325:EE_
X-MS-Office365-Filtering-Correlation-Id: 581324e9-0827-440f-d0b8-08db21ad90b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1A+ALOHf7qI+XJEH3WdEVwcNuwSLbxfQWXT/vsaVDZ3iec8xcdr72iboXfAKj6EuBLiDXf10N5khQpmH+dLzATFGRGg7RUEOva1D2J2jcDISjTsygdbXjuSC7NDfNiLhl0Y0lbUzawpKp8PNYGXiaASVfBbfhrpBnnVFvMxOqGEs15SSZK7aDnggWpUxJCRsNlh7snddRLD2spONl4mJEBmoeG5/pnIWQqCdk0+2xK07d1henJve3z08/Q9XuEe868RaoiAB3NsvTKtnxD5VT12CTau/NZzBuWP9XrFHFsBhOTC8lQm0LfmAj8M2hVCGrH0fIXwAXPUCQFgoHqS5GLWASslHT02TH1XSYVwHpTv34Mat+mL/4uMgO5K9RJ7Bww3qWBbVIZvdG8++qCtQPJmWqXAfejNYfqycr8gq1dmaReaNelUyzck2Q5waHYe+qhETAVnle4oGclRBWy1gfWwOxXDbgbcoc8p6yKG4abmoIzFt3AAD4Pl5/ybP1+JVVooB3QWfxpMkwX0ZmyvOKI2OL4Fudb0UvXl+PYTNv19K3HeD/A4k+Gwrtwyq+Vrs0nZYdEeUGUtBYgL0iu1US3bUVGYLY/9pJ37ePZCd1s/K/BHp+z2OKB/MMOfcRW+OMcnJNlQnodK/K5Jwko8SViEsftf5yb6Zc0Y1XEbp10EUwSBuLBBULYCs0o0/mSBTGhE5JgM94yCaMqm2mvfoRC0J84FQgCAUKYJXBUhHf+2vpyUgK41HvAl++6qAY1f
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199018)(40470700004)(46966006)(36840700001)(44832011)(36756003)(40460700003)(5660300002)(83380400001)(47076005)(426003)(7696005)(82310400005)(26005)(6666004)(966005)(1076003)(16526019)(2616005)(186003)(336012)(356005)(8676002)(70586007)(4326008)(40480700001)(70206006)(41300700001)(8936002)(316002)(110136005)(86362001)(54906003)(478600001)(6636002)(36860700001)(82740400003)(81166007)(2906002)(36900700001)(134885004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 21:22:34.3103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 581324e9-0827-440f-d0b8-08db21ad90b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5325
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
v3->v4:
 * Add a missing check for doorbell status at start
 * Fix spurious __iomem
v2->v3:
 * Squash register values in
 * Use command and button registers
 * Correct register values for incorrect ones previously shared
 * Use a unique mutex
v1->v2:
 * New patch
---
 drivers/crypto/ccp/platform-access.c | 66 ++++++++++++++++++++++++++++
 drivers/crypto/ccp/platform-access.h |  1 +
 drivers/crypto/ccp/sp-dev.h          |  3 ++
 drivers/crypto/ccp/sp-pci.c          |  2 +
 include/linux/psp-platform-access.h  | 15 +++++++
 include/linux/psp.h                  |  3 ++
 6 files changed, 90 insertions(+)

diff --git a/drivers/crypto/ccp/platform-access.c b/drivers/crypto/ccp/platform-access.c
index 9cc0c60bbf7b..b51fb1196932 100644
--- a/drivers/crypto/ccp/platform-access.c
+++ b/drivers/crypto/ccp/platform-access.c
@@ -20,6 +20,14 @@
 
 #define PSP_CMD_TIMEOUT_US	(500 * USEC_PER_MSEC)
 
+/* Doorbell shouldn't be ringing */
+static int check_doorbell(u32 __iomem *doorbell)
+{
+	u32 tmp;
+
+	return readl_poll_timeout(doorbell, tmp, tmp != 0, 0, PSP_CMD_TIMEOUT_US);
+}
+
 /* Recovery field should be equal 0 to start sending commands */
 static int check_recovery(u32 __iomem *cmd)
 {
@@ -132,6 +140,62 @@ int psp_send_platform_access_msg(enum psp_platform_access_msg msg,
 }
 EXPORT_SYMBOL_GPL(psp_send_platform_access_msg);
 
+int psp_ring_platform_doorbell(int msg)
+{
+	struct psp_device *psp = psp_get_master_device();
+	struct psp_platform_access_device *pa_dev;
+	u32 __iomem *button, *cmd;
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
+	if (check_doorbell(button)) {
+		dev_dbg(psp->dev, "doorbell is not ready\n");
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (check_recovery(cmd)) {
+		dev_dbg(psp->dev, "doorbell command in recovery\n");
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (wait_cmd(cmd)) {
+		dev_dbg(psp->dev, "doorbell command not done processing\n");
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
@@ -140,6 +204,7 @@ void platform_access_dev_destroy(struct psp_device *psp)
 		return;
 
 	mutex_destroy(&pa_dev->mailbox_mutex);
+	mutex_destroy(&pa_dev->doorbell_mutex);
 	psp->platform_access_data = NULL;
 }
 
@@ -159,6 +224,7 @@ int platform_access_dev_init(struct psp_device *psp)
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
index f5a03cd11f10..aca3b148af93 100644
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
+int psp_ring_platform_doorbell(int msg);
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

