Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3375D6C29E5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCUFfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCUFff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:35:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321311F92F;
        Mon, 20 Mar 2023 22:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2ILVMGg8vOp4TP9VMYTKFZp7G489xfNyhYIpTubEKqNNDc5ji8KwhnTe083iMj+jjVPQWvmdPDYLJIVkFX6yebYEvhwRjX2yUhfldFwSTA6lkpHyldOdlwJ7NJm4Oaa9bReyAw6ADNJbVAW+1KW0OP0cmTJXHxJ4tLay8IpzgKKwrjTLlgc0BexYzzbt/qyjmCMDcX+awLocuHTpZXfQXgqJzEJMc3xRcYGRi20TH71KLaMs8UA+IjhVAgtAByMuF1IyhQmWchASJPt2AG9BrjzTvOFuk0Pc+8vBqaIeQLhl6Bi9TC9qDzZzLb0vli0Fenk0qiAeOlIZOFBo2yK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=em2WKHdphSWEBzT622szO6xsFNYNKys9bL7PGdNfLeo=;
 b=bN6Bvmsx7PHUjfn8fsoO/T5yLzpfGSpFGVGMwSo42kdDNdGEcGRs0WDmBHHmywI3atR34l8MayvTfF4C0ABOHX31EE5Od0Ypuiok1ZQxSo1BcqiIpwnnP+gb3v33ZWC26cAWw85kjQXJ3d7CJvO+GGmGQQfbJ1o1o/Nn6YU8ClrsnrJTTucb0g5A5ygcijDR0T3KLIQ5VF7YbvhvVSl/7UC8Ooel91Cp1PLhKHw80qkZnbCilDoeDdk1sJVb7+Oa3dFFcSyon8byzGXVCRRZI9sTp0Wb292/V7EtDKHW/B6COiv3WS40kEbme9sc3NjjKrMi3I9sdHAfKtqOD/Ix4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=em2WKHdphSWEBzT622szO6xsFNYNKys9bL7PGdNfLeo=;
 b=MjNir0yx6kJNQZ4sYug0+H/Q9QkQRC4zL4pecvD7wlzbV0Sh/rI2cyyC2E+LwRxMRyn2miZUcjYuKyfXPkqairBRIrjWlJkRta3nIQw6lpkh3TcClXzyKnX/NjXrJBxR4Bvq4akevUpLbxdAYvL2DfPWLwMWIDggkW33vTVjdyE=
Received: from DM6PR06CA0039.namprd06.prod.outlook.com (2603:10b6:5:54::16) by
 DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Tue, 21 Mar 2023 05:35:27 +0000
Received: from DS1PEPF0000E64C.namprd02.prod.outlook.com
 (2603:10b6:5:54:cafe::c5) by DM6PR06CA0039.outlook.office365.com
 (2603:10b6:5:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 05:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E64C.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 21 Mar 2023 05:35:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 00:35:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 00:35:17 -0500
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Mar 2023 00:35:14 -0500
From:   Harsha Harsha <harsha.harsha@amd.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michals@xilinx.com>
CC:     <saratcha@xilinx.com>, <git@amd.com>,
        Harsha Harsha <harsha.harsha@amd.com>,
        Dhaval Shah <dhaval.r.shah@amd.com>
Subject: [PATCH V2 1/4] firmware: xilinx: Get the SoC family specific data for crypto operation
Date:   Tue, 21 Mar 2023 11:04:43 +0530
Message-ID: <20230321053446.4303-2-harsha.harsha@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230321053446.4303-1-harsha.harsha@amd.com>
References: <20230321053446.4303-1-harsha.harsha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64C:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: e2872d9f-5c3a-4f45-b967-08db29ce1305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9tgG33Q+4ln54j56GF+kxn0A2tDfoeolYKneL+pKAqqnCBtiDCVAYw07J24bCEjfwlLBHzp2ClEjbTS33vZTUxTzHUn9PgV3zrWvN6IIuHyL8pp48o32gc9xmbYZGIwBFQeKwDtTrUsXU678i+cpQBd9altPbzNKu+VFX2j0zkMdP+5/bDP8ntNqPH8mVgp8TQ0L2QyjD2EwElcdy22umgiHbEP/g3sY5cmn40HPmrDi5ZWNAUd6EcqdYaj81XAYB3WecGJRkQmh9Zq51KVeihE5cVyHaye3447rH/sLZC3xK47swd0JMALyaBIjsZD73E4zEz7P1bXdNLlZ1L/U2KuF1azUN0Dnh4bO9/3IscqFXenTDwypj0sgIkJJVrb34yXFKJmhiVDCx6Npbvy4Hc/jK5gfx0koP4hhBk4ZzRZWoqLtnQ2m+zrEdEGOfar4W/vEYgv8hbXc8bPTf7yycYDT6DXF+v5z30oRZ4ndtJpxdhHxyCkAqfk6nK0DQb50w3OrShyCqxYkJCZpO3FvV8UCdppIWwfBDeGyTjQMxDM1OlVG339DqGCyQds+iPypmHCuyt0azYwOJKDbjkFm60ppC9r8GmPiyWaB5xF7oSV6Zk3znEUFJB1lOgLzsCcAqglBiikFvaBzW/GFBHEn76irbdJDZV5BcUd+LfIawsXMSqLGIwClfpQrfQ0oX0lCjWK32knCpTyGSawEI/3ichzy8+E/sq35O8m4iZ2eXyWlDECQeYRkteQHbInWYfxa1D/oMEh8Umc84cjrlImlcp0kcXhJ1qc3tSBfVs1VFvPQyiAmnWlGoiBG0APIjQ4
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199018)(40470700004)(46966006)(36840700001)(82310400005)(83380400001)(426003)(47076005)(2616005)(86362001)(82740400003)(336012)(81166007)(110136005)(356005)(36860700001)(40460700003)(8936002)(4326008)(8676002)(36756003)(2906002)(70206006)(70586007)(44832011)(41300700001)(40480700001)(316002)(5660300002)(26005)(478600001)(1076003)(186003)(54906003)(6666004)(15583001)(36900700001)(2101003)(358055004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 05:35:26.1263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2872d9f-5c3a-4f45-b967-08db29ce1305
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get family type and sub-family type of SoC and on basis of that, return the
data specific to the SoC which can be used for the required crypto
operations.

Signed-off-by: Harsha Harsha <harsha.harsha@amd.com>
Co-developed-by: Dhaval Shah <dhaval.r.shah@amd.com>
Signed-off-by: Dhaval Shah <dhaval.r.shah@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 79 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 34 ++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 129f68d7a6f5..10ae42a2ae22 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -339,6 +339,8 @@ int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 
 static u32 pm_api_version;
 static u32 pm_tz_version;
+static u32 pm_family_code;
+static u32 pm_sub_family_code;
 
 int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
 {
@@ -404,6 +406,78 @@ int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_get_chipid);
 
+/**
+ * zynqmp_pm_get_family_info() - Get family info of platform
+ * @family:	Returned family code value
+ * @subfamily:	Returned sub-family code value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	u32 idcode;
+	int ret;
+
+	/* Check is family or sub-family code already received */
+	if (pm_family_code && pm_sub_family_code) {
+		*family = pm_family_code;
+		*subfamily = pm_sub_family_code;
+		return 0;
+	}
+
+	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
+	if (ret < 0)
+		return ret;
+
+	idcode = ret_payload[1];
+	pm_family_code = FIELD_GET(GENMASK(FAMILY_CODE_MSB, FAMILY_CODE_LSB),
+				   idcode);
+	pm_sub_family_code = FIELD_GET(GENMASK(SUB_FAMILY_CODE_MSB,
+					       SUB_FAMILY_CODE_LSB), idcode);
+	*family = pm_family_code;
+	*subfamily = pm_sub_family_code;
+
+	return 0;
+}
+
+/**
+ * xlnx_get_crypto_dev_data() - Get crypto dev data of platform
+ * @feature_map:	List of available feature map of all platform
+ *
+ * Return: Returns crypto dev data, either address crypto dev or ERR PTR
+ */
+void *xlnx_get_crypto_dev_data(struct xlnx_feature *feature_map)
+{
+	struct xlnx_feature *feature;
+	u32 v, api_id;
+	int ret;
+
+	ret = zynqmp_pm_get_api_version(&v);
+	if (ret)
+		return ERR_PTR(ret);
+
+	feature = feature_map;
+	for (; feature->family; feature++) {
+		if (feature->family == pm_family_code &&
+		    (feature->subfamily == ALL_SUB_FAMILY_CODE ||
+		     feature->subfamily == pm_sub_family_code)) {
+			api_id = FIELD_GET(API_ID_MASK, feature->feature_id);
+			if (feature->family == ZYNQMP_FAMILY_CODE) {
+				ret = zynqmp_pm_feature(api_id);
+				if (ret < 0)
+					return ERR_PTR(ret);
+			} else {
+				return ERR_PTR(-ENODEV);
+			}
+
+			return feature->data;
+		}
+	}
+	return ERR_PTR(-ENODEV);
+}
+EXPORT_SYMBOL_GPL(xlnx_get_crypto_dev_data);
+
 /**
  * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
  * @version:	Returned version value
@@ -1855,6 +1929,11 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 	pr_info("%s Platform Management API v%d.%d\n", __func__,
 		pm_api_version >> 16, pm_api_version & 0xFFFF);
 
+	/* Get the Family code and sub family code of platform */
+	ret = zynqmp_pm_get_family_info(&pm_family_code, &pm_sub_family_code);
+	if (ret < 0)
+		return ret;
+
 	/* Check trustzone version number */
 	ret = zynqmp_pm_get_trustzone_version(&pm_tz_version);
 	if (ret)
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index b986e267d149..cd5acfa29cbc 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,20 @@
 /* PM API versions */
 #define PM_API_VERSION_2	2
 
+#define ZYNQMP_FAMILY_CODE	0x23
+
+/* When all subfamily of platform need to support */
+#define ALL_SUB_FAMILY_CODE		0
+#define VERSAL_SUB_FAMILY_CODE		1
+#define VERSALNET_SUB_FAMILY_CODE	3
+
+#define FAMILY_CODE_LSB		21
+#define FAMILY_CODE_MSB		27
+#define SUB_FAMILY_CODE_LSB	19
+#define SUB_FAMILY_CODE_MSB	20
+
+#define API_ID_MASK	GENMASK(7, 0)
+
 /* ATF only commands */
 #define TF_A_PM_REGISTER_SGI		0xa04
 #define PM_GET_TRUSTZONE_VERSION	0xa03
@@ -475,12 +489,27 @@ struct zynqmp_pm_query_data {
 	u32 arg3;
 };
 
+/**
+ * struct xlnx_feature - Feature data
+ * @family:	Family code of platform
+ * @subfamily:	Subfamily code of platform
+ * @feature_id:	Feature id of module
+ * @data:	Collection of all supported platform data
+ */
+struct xlnx_feature {
+	u32 family;
+	u32 subfamily;
+	u32 feature_id;
+	void *data;
+};
+
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 			u32 arg2, u32 arg3, u32 *ret_payload);
 
 #if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
 int zynqmp_pm_get_api_version(u32 *version);
 int zynqmp_pm_get_chipid(u32 *idcode, u32 *version);
+void *xlnx_get_crypto_dev_data(struct xlnx_feature *feature_map);
 int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out);
 int zynqmp_pm_clock_enable(u32 clock_id);
 int zynqmp_pm_clock_disable(u32 clock_id);
@@ -561,6 +590,11 @@ static inline int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
 	return -ENODEV;
 }
 
+static inline void *xlnx_get_crypto_dev_data(struct xlnx_feature *feature_map)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata,
 				       u32 *out)
 {
-- 
2.36.1

