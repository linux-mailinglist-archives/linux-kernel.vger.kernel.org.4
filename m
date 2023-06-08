Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AB17287D0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbjFHTN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbjFHTMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:12:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8F830DE;
        Thu,  8 Jun 2023 12:12:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixAgYMRCF59pA5ZqcNuZbIbjPDCDapKET4qLskT0LI4+VJLfM4t6aEYznz/4Vzij3RD5cXlO3vSK85bGtUpNSsPERLKyxOIB4XvOfD8UBXxvDMdXw+IDwZikHQxo8JqfZzMTghPkzrmjMqVmPI2/wuaqY6PGspuRRu/yzUemHnZaqS4SvBcG9Wo+tKF5gKU9n25Vu6GTNS9+33HddNyzXG7cmsuNYl9owDfA1MbrMO9gq8neaaEc7HKwSNPtFXJN9evKE7QWLBp+HnkmdFPJa5DeSPenfaj0+ITQFJUA6pgX7c9bOKemDKqpKBAfwFuJs1HUI6xkLcPYlWSBrt+7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aS8JSioac+K5cQTdnoc+oQ3hySJkWDuNq/W398kLq/w=;
 b=VU6/EHqJ5T7g69qJqB+Wzdb+WTndCXSGsF60WttzWJmBs1+IWWGzzzT6EPZ6+YD4OsHZM7+Apbox1NvPjSxK8KtIC0sV5jTk0+j/uKRasWM4oY+oYT8nTxZm8a5TuRZwRUJE28/z0caAPmrsH6cOi3JZZuPBEcXujfh4J6JIKs7yZcuuceBuUJc06jt+/ZC735B/SzefP9DAJG02fwk+l5R7+eP3BtLb5VaefwchEU2j1khuGss26g/bLqnyUIZO1WCz32eRxUBlxbnS6bEaHn8UwxLRj37HtTDaCFk62w5IA6ZHt5qzOs6Z1fQFcLDdDx2/Pd+vmDanrMRivkB51A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aS8JSioac+K5cQTdnoc+oQ3hySJkWDuNq/W398kLq/w=;
 b=qp5ksFo1Z8QpDUP8EGxHX8QS8N22VoSxWFEPpRUgaj6hVSY+tQ2azHlMe48bRZyuMghCDd3mZT0ycS0P8kUMzcl6EZCIY0Bu14GfZb6YoF51jlg5UgumHy7eNqAlq7XGG9jFo47Jz8YgXFvCd3JbEkYfXrjzojzA+OP2+LgL9gE=
Received: from MW4PR04CA0256.namprd04.prod.outlook.com (2603:10b6:303:88::21)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 19:12:32 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::5c) by MW4PR04CA0256.outlook.office365.com
 (2603:10b6:303:88::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Thu, 8 Jun 2023 19:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.0 via Frontend Transport; Thu, 8 Jun 2023 19:12:32 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 14:12:27 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 07/11] crypto: ccp: Add support for getting and setting DBC parameters
Date:   Thu, 8 Jun 2023 06:17:53 -0500
Message-ID: <20230608111757.32054-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608111757.32054-1-mario.limonciello@amd.com>
References: <20230608111757.32054-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: 67791033-2c34-433c-e097-08db68544f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YY/Gk5fotRWbe6oaBwSqnkqF4qpYVUK0oPVzoMbod7qTY6LH0XOc2zhiBwuiOr8/fDLuzxX2GbwPqgBnlXjDcRUeF5Vib49Jq8DJoFqiBQ13FOfaoHR/kdF3S1i18l4AGvPboUOXFO/Oriqsucy5tROq6I+pkGzqLcHEwna+mTEE7Nj57VA9egNWOFjuWyzEnIQGBdUc4QtDQuudOEfNL2gZ/py1RJBRY5HSKHCnVO5TZ52a2eSWB6ODOhVKi6rhoHr7K2qNHsG1uHUX1HGQZhsPTymME0q7olnYsKwm3cXOYztgwDeK3pYwaP/w3Tajct1EAr9KdYHVrMDmLiBWx5yRxPVufMDyB82xmgKk9VgbCeR3zGCNyBzaYLKnPkkGuaY/WzEBfc7Aumm3702Qb9Cw4ktZB+o+CwgeVardxX7KVyqg7ExV5WAv5I8MRuyXXIacKADqinclzx8MmmxzED7G/RzS3EhWF0IPXYLqHl8zq63n6kUaD1AdbT4EfbtOQXG2d/dwV9Wu/9wa0kS5BuL4J3QGK8Kk4VxflmkrJgXMqnPEBhcpgh7aEvANYt5cv/EAVt4unYNMX3nboYW+62+T0DCIpxsL6+dGZt3TOq8cKDMrnjThyvhGGinYZkhD7X2/llwsfdlTRi8n2YxnVNwr1fSjKU9qSGLSLrySJaUAgHThpmS0f0yxYy4SBZIrEEB53XePOGpRWQVVGt/jkfu4fmhafYRWW80U29rSY2pJu17qFWkFOgX4cCD1xoOEywOerghmsoM77ECj6FQTqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(83380400001)(40460700003)(336012)(47076005)(426003)(2906002)(2616005)(36756003)(86362001)(82310400005)(356005)(82740400003)(81166007)(36860700001)(40480700001)(41300700001)(316002)(6666004)(5660300002)(8936002)(186003)(8676002)(110136005)(7696005)(478600001)(54906003)(70586007)(70206006)(4326008)(1076003)(26005)(16526019)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 19:12:32.1383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67791033-2c34-433c-e097-08db68544f76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After software has authenticated a dynamic boost control request,
it can fetch and set supported parameters using a selection of messages.

Add support for these messages and export the ability to do this to
userspace.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/dbc.c            | 41 ++++++++++++++++++++
 drivers/crypto/ccp/dbc.h            |  6 +++
 include/linux/psp-platform-access.h |  2 +
 include/uapi/linux/psp-dbc.h        | 60 +++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+)

diff --git a/drivers/crypto/ccp/dbc.c b/drivers/crypto/ccp/dbc.c
index ca7ec528536b..89976d6b9109 100644
--- a/drivers/crypto/ccp/dbc.c
+++ b/drivers/crypto/ccp/dbc.c
@@ -74,6 +74,30 @@ static int send_dbc_nonce(struct psp_dbc_device *dbc_dev)
 	return ret;
 }
 
+static int send_dbc_parameter(struct psp_dbc_device *dbc_dev)
+{
+	dbc_dev->mbox->req.header.payload_size = sizeof(dbc_dev->mbox->dbc_param);
+
+	switch (dbc_dev->mbox->dbc_param.user.msg_index) {
+	case PARAM_SET_FMAX_CAP:
+	case PARAM_SET_PWR_CAP:
+	case PARAM_SET_GFX_MODE:
+		return send_dbc_cmd(dbc_dev, PSP_DYNAMIC_BOOST_SET_PARAMETER);
+	case PARAM_GET_FMAX_CAP:
+	case PARAM_GET_PWR_CAP:
+	case PARAM_GET_CURR_TEMP:
+	case PARAM_GET_FMAX_MAX:
+	case PARAM_GET_FMAX_MIN:
+	case PARAM_GET_SOC_PWR_MAX:
+	case PARAM_GET_SOC_PWR_MIN:
+	case PARAM_GET_SOC_PWR_CUR:
+	case PARAM_GET_GFX_MODE:
+		return send_dbc_cmd(dbc_dev, PSP_DYNAMIC_BOOST_GET_PARAMETER);
+	}
+
+	return -EINVAL;
+}
+
 void dbc_dev_destroy(struct psp_device *psp)
 {
 	struct psp_dbc_device *dbc_dev = psp->dbc_data;
@@ -135,6 +159,23 @@ static long dbc_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			goto unlock;
 		}
 		break;
+	case DBCIOCPARAM:
+		if (copy_from_user(&dbc_dev->mbox->dbc_param.user, argp,
+				   sizeof(struct dbc_user_param))) {
+			ret = -EFAULT;
+			goto unlock;
+		}
+
+		ret = send_dbc_parameter(dbc_dev);
+		if (ret)
+			goto unlock;
+
+		if (copy_to_user(argp, &dbc_dev->mbox->dbc_param.user,
+				 sizeof(struct dbc_user_param)))  {
+			ret = -EFAULT;
+			goto unlock;
+		}
+		break;
 	default:
 		ret = -EINVAL;
 
diff --git a/drivers/crypto/ccp/dbc.h b/drivers/crypto/ccp/dbc.h
index 156435100076..e963099ca38e 100644
--- a/drivers/crypto/ccp/dbc.h
+++ b/drivers/crypto/ccp/dbc.h
@@ -38,10 +38,16 @@ struct dbc_set_uid {
 	struct dbc_user_setuid		user;
 } __packed;
 
+struct dbc_param {
+	struct psp_req_buffer_hdr	header;
+	struct dbc_user_param		user;
+} __packed;
+
 union dbc_buffer {
 	struct psp_request		req;
 	struct dbc_nonce		dbc_nonce;
 	struct dbc_set_uid		dbc_set_uid;
+	struct dbc_param		dbc_param;
 };
 
 void dbc_dev_destroy(struct psp_device *psp);
diff --git a/include/linux/psp-platform-access.h b/include/linux/psp-platform-access.h
index 18b9e0f0cb03..c1dc87fc536b 100644
--- a/include/linux/psp-platform-access.h
+++ b/include/linux/psp-platform-access.h
@@ -10,6 +10,8 @@ enum psp_platform_access_msg {
 	PSP_I2C_REQ_BUS_CMD = 0x64,
 	PSP_DYNAMIC_BOOST_GET_NONCE,
 	PSP_DYNAMIC_BOOST_SET_UID,
+	PSP_DYNAMIC_BOOST_GET_PARAMETER,
+	PSP_DYNAMIC_BOOST_SET_PARAMETER,
 };
 
 struct psp_req_buffer_hdr {
diff --git a/include/uapi/linux/psp-dbc.h b/include/uapi/linux/psp-dbc.h
index 7443c78ede19..b3845a9ff5fd 100644
--- a/include/uapi/linux/psp-dbc.h
+++ b/include/uapi/linux/psp-dbc.h
@@ -45,6 +45,23 @@ struct dbc_user_setuid {
 	__u8	signature[DBC_SIG_SIZE];
 } __packed;
 
+/**
+ * struct dbc_user_param - Parameter exchange structure (input/output).
+ * @msg_index: Message indicating what parameter to set or get (input)
+ * @param:     4 byte parameter, units are message specific. (input/output)
+ * @signature: 32 byte signature.
+ *             - When sending a message this is to be created by software
+ *               using a previous nonce (input)
+ *             - For interpreting results, this signature is updated by the
+ *               PSP to allow software to validate the authenticity of the
+ *               results.
+ */
+struct dbc_user_param {
+	__u32	msg_index;
+	__u32	param;
+	__u8	signature[DBC_SIG_SIZE];
+} __packed;
+
 /**
  * Dynamic Boost Control (DBC) IOC
  *
@@ -84,4 +101,47 @@ struct dbc_user_setuid {
  */
 #define DBCIOCUID	_IOW(DBC_IOC_TYPE, 0x2, struct dbc_user_setuid)
 
+/**
+ * DBCIOCPARAM - Set or get a parameter from the PSP.
+ *               This request will only work after DBCIOCUID has successfully
+ *               set the UID of the calling process.
+ *               Whether the parameter is set or get is controlled by the
+ *               message ID in the request.
+ *               This command must be sent using a 32 byte signature built
+ *               using the nonce fetched from DBCIOCNONCE.
+ *               When the command succeeds, the 32 byte signature will be
+ *               updated by the PSP for software to authenticate the results.
+ */
+#define DBCIOCPARAM	_IOWR(DBC_IOC_TYPE, 0x3, struct dbc_user_param)
+
+/**
+ * enum dbc_cmd_msg - Messages utilized by DBCIOCPARAM
+ * @PARAM_GET_FMAX_CAP:		Get frequency cap (MHz)
+ * @PARAM_SET_FMAX_CAP:		Set frequency cap (MHz)
+ * @PARAM_GET_PWR_CAP:		Get socket power cap (mW)
+ * @PARAM_SET_PWR_CAP:		Set socket power cap (mW)
+ * @PARAM_GET_GFX_MODE:		Get graphics mode (0/1)
+ * @PARAM_SET_GFX_MODE:		Set graphics mode (0/1)
+ * @PARAM_GET_CURR_TEMP:	Get current temperature (degrees C)
+ * @PARAM_GET_FMAX_MAX:		Get maximum allowed value for frequency (MHz)
+ * @PARAM_GET_FMAX_MIN:		Get minimum allowed value for frequency (MHz)
+ * @PARAM_GET_SOC_PWR_MAX:	Get maximum allowed value for SoC power (mw)
+ * @PARAM_GET_SOC_PWR_MIN:	Get minimum allowed value for SoC power (mw)
+ * @PARAM_GET_SOC_PWR_CUR:	Get current value for SoC Power (mW)
+ */
+enum dbc_cmd_msg {
+	PARAM_GET_FMAX_CAP	= 0x3,
+	PARAM_SET_FMAX_CAP	= 0x4,
+	PARAM_GET_PWR_CAP	= 0x5,
+	PARAM_SET_PWR_CAP	= 0x6,
+	PARAM_GET_GFX_MODE	= 0x7,
+	PARAM_SET_GFX_MODE	= 0x8,
+	PARAM_GET_CURR_TEMP	= 0x9,
+	PARAM_GET_FMAX_MAX	= 0xA,
+	PARAM_GET_FMAX_MIN	= 0xB,
+	PARAM_GET_SOC_PWR_MAX	= 0xC,
+	PARAM_GET_SOC_PWR_MIN	= 0xD,
+	PARAM_GET_SOC_PWR_CUR	= 0xE,
+};
+
 #endif /* __PSP_DBC_USER_H__ */
-- 
2.34.1

