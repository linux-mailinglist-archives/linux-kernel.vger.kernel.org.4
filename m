Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A2B6F1E55
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346556AbjD1S4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346545AbjD1S4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:56:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBA0659A;
        Fri, 28 Apr 2023 11:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjWruWPzY0sZwFTIWCCHXAaoDvCl4HV3VqD8Q0nzSxtZuL2A+919zKrLWma2BbOvQv5FF1uSzQFCHH9dWqElWkCF2MeHnvwMgTlDcWTFnKDD/jkUf1NFDDRVnaSwRrCeszEghejDb0cuFyNA4BXGS9zwO/AgVttHm3bjkNLGSGErt21WPfbco0fjJnykvkGTP+21oQy7NBOfj2TeajOuh+9KxB1kk5pzbYfe7wJ3Uflq7NNsfQl2ASWpOpcMX3jEfdfhIwSEkuMq+RuMpWHRlLy8l2/rssYzBspXN2mk1ArTWMC9/DcYlyewrBxVE/hHfllaDnw+iFKk47pOfnZSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aS8JSioac+K5cQTdnoc+oQ3hySJkWDuNq/W398kLq/w=;
 b=mVDuJioyJcsUD267AuBe5iJ7HvyjifR6ErWswm5GfKmoAiX1vzGu50D7HAQs81Rz+0ISpb1V5m2rKQpQ0BrYtLyOhAbLINEQq0VEO/6WtRuBTMMsLZ0WJIDn9PtiiSbnfOcCIkCb5Vsh7NNFHC3c3GEbyBiGlrE8UDzwkkZRJsg1jT2I0DpmuFiBgUUcxNcv/pspna4S4uDCw8cVYt9j90MyPK8Pymdt2BjiPHnoVjKfn3g/6c5K8gtMn2QEUXy0xraucM+e0dWjYlIrmB0Nox9PEONOUNEHx5nWxbWxitcOVpI7aeFaL8lKJp/0SrlCe2fyJansgsC/aB2UiFeLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aS8JSioac+K5cQTdnoc+oQ3hySJkWDuNq/W398kLq/w=;
 b=Heb98Bry/+zMqFffrvTEUtRWOjBbtwDLqdYPZSjhI6HPX2hjWCfe5rPXsgDiaZtM31OBbfEtsWTQ8RzAFdD+Sw0JmphFxaKWha8+FYCDd/wp9Wf1MwA6eum12KRWqO+HkpxZvOcJ9z5V4lBjZw/ulAXoOXsl9xE70eEQKtBPTKY=
Received: from DM6PR11CA0069.namprd11.prod.outlook.com (2603:10b6:5:14c::46)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 18:56:12 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::7f) by DM6PR11CA0069.outlook.office365.com
 (2603:10b6:5:14c::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 18:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.23 via Frontend Transport; Fri, 28 Apr 2023 18:56:12 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 28 Apr
 2023 13:56:08 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
CC:     David S Miller <davem@davemloft.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/10] crypto: ccp: Add support for getting and setting DBC parameters
Date:   Fri, 28 Apr 2023 13:55:37 -0500
Message-ID: <20230428185543.8381-8-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230428185543.8381-1-mario.limonciello@amd.com>
References: <20230428185543.8381-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT045:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: 2429067a-ee09-47ea-c1e6-08db481a3c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jcCoQPnH0N6a2w/A/robeilUgdZa1UpH2pZnVnz2xBdj+30qV3DrEcddHiScmpOQe7mo3T629CbrhSmyAEHQIMZ9g2vGeI4PrDCIH7RLWwpKGZvfNHebiijR75aEQggCVfU27dWcxN65AVriw5x0HGKhMlC0/Y2eHaOFSybBUO0Zxmje+SLOL7ipQe3G5JCe8S2Hmat8fg2UPrxprGwBpy5lvZmYPWSTpdIUqqhpkggujYG7y4bOUsmpyBO9EghZmMkWlgFmfHpdM1x5cq37AGdsq0G7BktIXQYorti/V6Hwlbj3bOqio5iOQTIW6lMjjrDdfu6KgssYm8oy/8RVOm6rVNl91CQ+PdqArFHuxYP2uNLOOtgniPqQTjAr2OnGzX/Pt0pTeAB/waaaiD37HJZGWPoeBGhSVeaGYyqpKiKBbTVZXnO3A3mVpcjjgOKYWYjxEh3ndUixuwvrDIylmTizegFAjybSpmP9QkZ6q8xvIdfj+h6II4tmd9n6GDYau+rrvgSIYYQ1y184qF2uBJtS5DFuUGJWRplKcz0oZs7gvNhIExMxFlEJDJUplCs6+rCWIS47f6a1lJX5e4ZIVHFyNZfv+71T1K8FKJhHLl0fzclokkCouGP/HFneMU/aI52+beeBXUB3Iukxgcu++4ihwTsLZADyb/v43z61DeGmo76ZWfH9QjOvXmXNm4XqX92oMOuw+GHWcXXvLvt3XDI2yjlHcoPLDy7IdleDbJ4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(110136005)(54906003)(7696005)(426003)(4326008)(83380400001)(6636002)(36756003)(82310400005)(86362001)(41300700001)(8936002)(6666004)(8676002)(2616005)(478600001)(16526019)(44832011)(186003)(316002)(26005)(70586007)(5660300002)(1076003)(336012)(70206006)(81166007)(47076005)(40460700003)(36860700001)(356005)(2906002)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 18:56:12.1402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2429067a-ee09-47ea-c1e6-08db481a3c5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

