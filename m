Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3546709E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjESRa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjESR3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:29:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2C610F0;
        Fri, 19 May 2023 10:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bjz2RJ4Q28cksrrJankz+O/I2b0n8f/jB6i20wkZENDESsKByX01o5PsdEHQmMM1Som0ldMGVOaN+6/kRYSpIr/CjhBMzgEFHNr5ZeTmInk0pyMG5DkGH3tUlESkMwixQL/GjnONRcEnrOYgULxpDR/S/NEfwmOx6x7/hwVe3EZVH7pqXBh8tOlWOWRAPBgq+0EwWCu8VJoXfvEYjwEyLclvDYtUgx6Z2lJF4i/jv9z61Ei5VKEIp4uteMXGU3D4N7UItTIsW1EDimfO7hx/AOw6rCj93HHyCgwnKCmx0xZJyy51usUnOna0fEGAMiLnvvAvaLX04N8l1s3IyIXBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aS8JSioac+K5cQTdnoc+oQ3hySJkWDuNq/W398kLq/w=;
 b=nWn/NYlcEpvZEP4uWZ/U/wbG5iMdV7RSgS0aki81Y3bkluoDkSIR/wYKI4KcZKkTl3lyYWPBQcIeM/9TQimi/NU4Gl8yex90AhV1+8SXM0nvWCGfTBID9TDOPK5MCeGFTdh6ichmcKSeyB6dt2VWzdYLj4jZ/EVaY73SsZlNGVWH7xiQh54M03/CVn/Jz3cZy33yT1BoXAYpUmGo7V2kLYHaNWxwNPqqEbDegAL7prDBaO1MIdCcrUHr+7Sa/Rc8wV4FIz5N5xXYdz/cs8twB9D4uk0L2wy2XkOb1PA2sgiHN+nnG8Gvfn0Qeq7rQy5PyNFY5JWQeHhx9VtxSdHyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aS8JSioac+K5cQTdnoc+oQ3hySJkWDuNq/W398kLq/w=;
 b=5iYi602Jovqe9+n+uhA7mvYkrQu8XvsF0puaDikTHa+Dn5JBN770vcpG329hSDs5jPdaA/hjIq8LKDXAREsuQSvtSqjtQ7ickc2DtPHbz8frpGjomK1SKArCi5PUwZ9i4iuweOaqYUDso9LQ1PZm4XHlMjF2amLVDVzPGwAYegs=
Received: from DS7PR05CA0085.namprd05.prod.outlook.com (2603:10b6:8:56::15) by
 BL3PR12MB9051.namprd12.prod.outlook.com (2603:10b6:208:3ba::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21; Fri, 19 May 2023 17:29:07 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::6f) by DS7PR05CA0085.outlook.office365.com
 (2603:10b6:8:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.7 via Frontend
 Transport; Fri, 19 May 2023 17:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 17:29:07 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 12:29:05 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     John Allen <john.allen@amd.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 07/10] crypto: ccp: Add support for getting and setting DBC parameters
Date:   Thu, 18 May 2023 22:24:45 -0500
Message-ID: <20230519032448.94279-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519032448.94279-1-mario.limonciello@amd.com>
References: <20230519032448.94279-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|BL3PR12MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: aeadc324-9aa3-45f3-0126-08db588e8cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o5Mar65pjOwErDzPxMMu8IrUpKRBPG55GDgslCwLxPfJNh/ATdW1x5fsrtXaxqLX5pv8UrIQLxHuKNQm+nBWpiQxWfY2l/ErOHqp//XPgLcLTxs0bnaWKnMrN/SYb9PyYNRRtXFTLmnoe1S541+ykVibO+061jw2x64n/L98PfWU9Pk7UmoALezJEu+RUQzMbuIiDpAYFWmf5xp+OsPILOPbHeyjmHtdweqFZ2piqB2dG6MSt+YriMachZXkSDmLwcVaKELLYFipf15jc8BZ76QMPhByyQ0MqxwDKh3ZfXke21jfXtmjubODg0ddm2r3JeCeTd9U5QiPTJHA5Id+ISNtZYn6fohFw8gW0LY4ceXfQ3T8cUOq/Ig0T9XlhKuRBGGi9awp0wrOiJTmmkMvF2ahZJtIuYPtzteUeaZXsUky0XPq1gQ2egoY5jzSKYaw4NgnswpD8AShb4o1hDMtx237INpKvf+7fw8eJ5JhuHiQMJ/YD4UfO/u6T44jrx1+fvvClSrrj6sAtHTU7bYWNTfKn2dFUiV92hmJ6cB86e7BNCBVkyrrLneyu6//Mc2IWJUSIJOb8ZwF48XrtHpSmHjuDnmLddHVp5YeQOj9PANZX8087PcTdXo3ejvVGh2m9w6G5UrH2RMz+jCRoOGx3DqTEW3vx/uQQaSfynNzqsrvKEEXwPcq7kRq2+enp5KDY9x7+ydVfqf4EZsLH7uMsdDj/Sc3/qMC47uI9/RPjJeWfSugA7iilR9bj4G6sZ/SALnQfJdjuw2wBaA3ArQcZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(70206006)(70586007)(4326008)(82740400003)(8676002)(8936002)(40480700001)(316002)(110136005)(54906003)(478600001)(41300700001)(7696005)(6666004)(40460700003)(86362001)(2906002)(81166007)(356005)(26005)(36756003)(1076003)(44832011)(36860700001)(186003)(336012)(82310400005)(16526019)(426003)(47076005)(5660300002)(2616005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 17:29:07.1221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeadc324-9aa3-45f3-0126-08db588e8cb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9051
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
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

