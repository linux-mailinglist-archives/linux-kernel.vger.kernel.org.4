Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115B06A89B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjCBToY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjCBToC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:44:02 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957B258B4B;
        Thu,  2 Mar 2023 11:43:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhwUG7YbF8gl+rDrCE6RXYfKVnueiIaxdOo0KyU0OsbQm6Cg/N7XxUNy3DHNSH5sgNbN4svI3cvDG46v2umF0JH7sheAKwRcSnS7G2Rgvu7UToxcMwnOvvCuAkROkyn4r6kFg6TBePCAoIBWOZ76gO7NexzwLaWQeg5M0a4FJv3r+PMmyGTffF5IeKCiS6xWyc1oweK6MeyUK9/svdOFAQi4ebP8aQDDkKDYoNv3HDQRFUyZx2rRHtVtqrBQTK8PiZbNQAvCSGiyFa6x4KkMmV/1NC8tirsR6BAVL6XpX4mNKoqXUQP89w2GZkJQVa0GGAuQMhkeIYXM+F9e/LUPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s37fTeFDkcK8QJ01FeyF0CA9erfiM7clF+ueBoMu37s=;
 b=BhEAJEJJ0g4Fx5O0OyfM4OxirAmL4n4ZEL2oX6fuplUs5ZBizuMEcKx2oT3YzxNoTdXPsx+/ikHN+tzokr6Yo7l/3Xk19NRncBbBO/csG2ubupb9hY/FptV+deqAmJmPFTbGZcsq9vT2MagC1KRXScgZl4nLGaGuwxg0F9iMFQCV4in5/wVsEpX3X+MF9wn0xt9t5zNn3ZmxGEG0gxizD1J9Ex1M1XsHBDLvpHpGNLK8Rzy3IUjKzHTzKW1bbTK36eWadZY4myYiUjGADXyhCPwvFxzKykju48bjcr6uPRXwO9c7Y9M6M2dpxsb49CR7HGAHv5PD56e1wJpa2+PZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=semihalf.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s37fTeFDkcK8QJ01FeyF0CA9erfiM7clF+ueBoMu37s=;
 b=N6v5VXtx6HRi7I/EuF2UlnImSAZIquD5Ga65DIk8LtIxcRe3x+OXR596bCdrEe1iyHWrM55PtBCYz6/6PqqAzP2rzdkKBK/Ia5U2PN8Nc8ETeliU6qBWxymCdGnxYRRMUaU7hYMrHRNXoDpezTtPoZ6BLSHTz4MM9y0EDXcKrDQ=
Received: from BN9PR03CA0928.namprd03.prod.outlook.com (2603:10b6:408:107::33)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Thu, 2 Mar
 2023 19:43:22 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::a3) by BN9PR03CA0928.outlook.office365.com
 (2603:10b6:408:107::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 19:43:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.20 via Frontend Transport; Thu, 2 Mar 2023 19:43:22 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 13:43:21 -0600
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
Subject: [PATCH v2 7/9] crypto: ccp: Add support for ringing a platform doorbell
Date:   Thu, 2 Mar 2023 13:42:30 -0600
Message-ID: <20230302194235.1724-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230302194235.1724-1-mario.limonciello@amd.com>
References: <20230302194235.1724-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: 1096de2f-4834-4269-c8e0-08db1b56620c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0AMaahyjxiCWh8xvSkiK5WjWjRVvgirBKQBidhyE78FhvEYqVqY2gA/Kr2KXyrb6i5Ay3utnmBSrnTD+hMUt71Sd1b+M9JrKuqXKGuP/YrchGcm6nC3CDzqmeIMAlRdV6BYXU48AYJPJbjLD/+D7aJIP1P3mTpGtVja3yMcn6qP2bknzP/JO38uptdMP4nTPh2hUCzsIkcOPHY2RqqMeD2sDXCA24Wh/VBnkFjdoGvkCxbmON0qSyDsT/tbekQr6LrvYkU7CYAi8hkkwus0QzPbFjzkEjYDnecGdypkmvUZNEA05CBNRInGFRwlg6OOAD8K8ar1CO4hiUmGyoYFDu0r5GB7U8hu6Q6qSmcjk82LrmzXN6m6S7nI1dKqNX+PBkmzHCIbY5Urrmefy0nH3NhbyMEEtJBCxUZUeTmFLHpXSwP5Ts/l9syCAwbcTqKcx9FiQ6ht7vJoDmEYAbGz23q6VSSi1g2EE1Gs9rO1aTI9ZJajq8pZRjnUJs2YYjlh5YVItuvUPN0j8V3QFkPTrDpp0C6JfwuRx1UWh9L5A9/6yC3IPs9J3kxRoPFVztU/VO9J2WQmnig34ejzDmqdRUEVeYMwM6g5ZYc0LsMumAceYI7XpIVWaPHr9c50Oh9/j1oWPwJBvolah9XgpJA2Ya+x0QmI8AcorpcV9wZCIk0ne9/wpfv5Zi0FeUR9xX4P2XaZqmO/0qWBzZGlNcpfW6IoLiqFVi+djZDTBwIVaFg2S2v4p3vAm5RlN2y7yp3RR
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(478600001)(110136005)(83380400001)(6636002)(316002)(54906003)(426003)(86362001)(7696005)(2616005)(82310400005)(36860700001)(336012)(81166007)(47076005)(26005)(36756003)(966005)(186003)(82740400003)(16526019)(356005)(1076003)(40460700003)(6666004)(40480700001)(2906002)(70206006)(8936002)(44832011)(5660300002)(41300700001)(4326008)(70586007)(8676002)(36900700001)(134885004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 19:43:22.8887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1096de2f-4834-4269-c8e0-08db1b56620c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
v1->v2:
 * New patch
---
 drivers/crypto/ccp/platform-access.c | 47 ++++++++++++++++++++++++++++
 drivers/crypto/ccp/sp-dev.h          |  1 +
 include/linux/psp-platform-access.h  | 15 +++++++++
 include/linux/psp.h                  |  3 ++
 4 files changed, 66 insertions(+)

diff --git a/drivers/crypto/ccp/platform-access.c b/drivers/crypto/ccp/platform-access.c
index af3a1e97abfe..0763389a2814 100644
--- a/drivers/crypto/ccp/platform-access.c
+++ b/drivers/crypto/ccp/platform-access.c
@@ -135,6 +135,53 @@ int psp_send_platform_access_msg(enum psp_platform_access_msg msg,
 }
 EXPORT_SYMBOL_GPL(psp_send_platform_access_msg);
 
+int psp_ring_platform_doorbell(enum psp_platform_access_msg msg)
+{
+	struct psp_device *psp = psp_get_master_device();
+	struct psp_platform_access_device *pa_dev;
+	u32 __iomem *drbl;
+	u32 drbl_reg;
+	int ret;
+
+	if (!psp || !psp->platform_access_data)
+		return -ENODEV;
+
+	pa_dev = psp->platform_access_data;
+	drbl = psp->io_regs + pa_dev->vdata->doorbell_reg;
+
+	if (!drbl)
+		return -ENODEV;
+
+	mutex_lock(&pa_dev->mutex);
+
+	if (check_recovery(drbl)) {
+		dev_dbg(psp->dev, "in recovery\n");
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (wait_cmd(drbl)) {
+		dev_dbg(psp->dev, "not done processing command\n");
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	drbl_reg = FIELD_PREP(PSP_DRBL_MSG, msg) | PSP_DRBL_RING;
+	iowrite32(drbl_reg, drbl);
+
+	if (wait_cmd(drbl)) {
+		ret = -ETIMEDOUT;
+		goto unlock;
+	}
+
+	ret = 0;
+unlock:
+	mutex_unlock(&pa_dev->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(psp_ring_platform_doorbell);
+
 void platform_access_dev_destroy(struct psp_device *psp)
 {
 	struct psp_platform_access_device *pa_dev = psp->platform_access_data;
diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
index 5ec6c219a731..87c0b9350bc2 100644
--- a/drivers/crypto/ccp/sp-dev.h
+++ b/drivers/crypto/ccp/sp-dev.h
@@ -54,6 +54,7 @@ struct tee_vdata {
 };
 
 struct platform_access_vdata {
+	const unsigned int doorbell_reg;
 	const unsigned int cmdresp_reg;
 	const unsigned int cmdbuff_addr_lo_reg;
 	const unsigned int cmdbuff_addr_hi_reg;
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

