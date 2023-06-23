Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065A273BE71
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjFWScU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjFWSbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:31:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B762724;
        Fri, 23 Jun 2023 11:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3RjnRjlbnC22ZBL2fyEnMlYQwowcp7VsQqttcbZ5eEcQnvsd0i4udqx2+7G4F92PVjMeMqeaknz2oUV+4mLcNGyb6MJwoFfyhjsYbD1Y5axD6balV3u5b66RHcHwrFsR753ea79D92vwJfgMN4Tkb4kXaWVHgqGc8E/K93uL5h1EGC1bxcQvVF5TbNbVatMgVUNc+MjwHED8n0WVxmg/o+fpzGKHOOTPAIXWkV1lN0P3W75mzyGbIT1lggvbp+n3XOH8JHdoAuHZaVh6Jw3ax7vmVsvEtfZ6+MCXjQgPruqThno5LZpgFLhC4fTsLAX/SWKXg6ax1xT9MkPKihheQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJu1uIF/ppRrhvHf5/r5CMoNSxJ7wFkbI8XsrCSl8XY=;
 b=NvgqRewFKZyyCHDJtS37c4IEjSFBHsdprLN6iDUyd9cJl+GlshN8FpXKsFfXIe6rIdQdrSbnjUVg8X1NMmuu8AV3oDFeUOkafFoQaGH+/KkBn1Hba75X1XUsQT8y6ZhBP4XA60SHkj733qK0Ac/2Zh9OxyxWaWAQMpXTICQFY8nbljblYZILzMN/dKNIxhXbFuSIRlNmY2EO580IZ9j9cc+j31k3FyhhUUMykZ6Wnz/zKNyEfS4epsL1ZAHooLbLKT6Pf6Rbtkv9Su+gRz3gB2lVjBLuFi7P0LTXV4sWWaoiXBY4ueU7phpKBmxDr7O0VaGfW9BLPiw9wCn2evCfjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJu1uIF/ppRrhvHf5/r5CMoNSxJ7wFkbI8XsrCSl8XY=;
 b=oiXHNEab98jU1Eginmyv3fw3vSQ8W/M1NmXULBlJGs9bB401/ZL2Bn3Qx5SoIEmgyYquutrPSqwXchKTIOB6IXNPus6khGaLtCCbjOUreVhQ1ee8/r/1D0KpzkOqE2+rXi0OBfJgzIhlUdbWU8j2M7i/IIGErPWJE+E11F5kMqg=
Received: from BL1P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::26)
 by CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 18:31:39 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::98) by BL1P221CA0014.outlook.office365.com
 (2603:10b6:208:2c5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 18:31:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Fri, 23 Jun 2023 18:31:39 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:31:36 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 07/11] crypto: ccp: Add support for getting and setting DBC parameters
Date:   Fri, 23 Jun 2023 08:49:57 -0500
Message-ID: <20230623135001.18672-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623135001.18672-1-mario.limonciello@amd.com>
References: <20230623135001.18672-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|CH3PR12MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c71102e-354d-45cd-6ed3-08db7418156d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Yu15I+9ZjF/JdxPrX61yUIMjdQqt2c/8xWS0PRKLhqkAcYEzPUMRmClVrok+KJQf5PBjBXk9bo72kJfDvIeYMz+HE+LYkMuYQgvk+gV+BEdoPw41M9e+wPsxSHhgVsaiTBVlC11YdMA8J3AuPoR474+ySUqYZMGVqZoA2/gcz09f6LIkLHrboIm4m5LXQzpl2WJYtuTX19YfWsJ6B3Tb8Th2YjoJp8WMedYNj4j5ivhstihzXGUA994QD0hUdf5GURUjW1bKGviYb73MpJ7MhcSQ/9N6wo+CHjTMzOVnH0xIitw6yqyu3POmmDipW1sZPopHkDiSSZ7CWQCQ608yn29y8lwhyun74KVEl2YMVsgVC+Zy84/CXgvwK9BWiaIpF6wb0X6KU6CBw4Kmufa5bbKEZCFl/Vx8nx9sB8yl0uLoyXaE6RwaDh0RHO7/lM7YQip8E0u1Be0WNq1l+lkASQ4qSxJx6p7gsRD2xqwY4IeFdLrsMkkxdDua9oZXn4wq0xH20wzJEB3vuYXF07kecFLBcnJX1skFELWgwfXTf74qq1tzT+PpTSaMDb77jgxfl4d6sjdLnFj45Tkj6qky2W+88jxvFqavzT4W3apZQu85xLyiU4wouJk+JJqq90/Dz4ecqIP2Pi2Ilk+UqkM4oROO/0KfD1rHlFsD7smJyYNlBGlI4ahR6G8C0ZVGe1L6jTb6KL9AJN8Y4+E0hwmcDS2wPtot/028iTei/dSDq5FAMH8vQjhBgd6roVEF1miXPTDG7+/4/r0ZnDKe4D0bA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(2616005)(54906003)(110136005)(478600001)(40480700001)(7696005)(6666004)(186003)(16526019)(41300700001)(4326008)(316002)(83380400001)(47076005)(82310400005)(26005)(426003)(336012)(1076003)(70206006)(70586007)(8936002)(5660300002)(36756003)(44832011)(40460700003)(36860700001)(8676002)(2906002)(81166007)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:31:39.0275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c71102e-354d-45cd-6ed3-08db7418156d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8460
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After software has authenticated a dynamic boost control request,
it can fetch and set supported parameters using a selection of messages.

Add support for these messages and export the ability to do this to
userspace.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * Pick up tag
---
 drivers/crypto/ccp/dbc.c            | 41 ++++++++++++++++++++
 drivers/crypto/ccp/dbc.h            |  6 +++
 include/linux/psp-platform-access.h |  2 +
 include/uapi/linux/psp-dbc.h        | 60 +++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+)

diff --git a/drivers/crypto/ccp/dbc.c b/drivers/crypto/ccp/dbc.c
index c6f5fb3658ca3..839ea14b9a853 100644
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
index 1564351000761..e963099ca38ec 100644
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
index 18b9e0f0cb03b..c1dc87fc536b8 100644
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
index 7443c78ede199..b3845a9ff5fd3 100644
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

