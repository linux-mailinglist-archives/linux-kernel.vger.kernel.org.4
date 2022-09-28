Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327995EDFCA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiI1PJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiI1PJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:09:05 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A6C240A6;
        Wed, 28 Sep 2022 08:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+sQizu4oh0a/whEB5MKaZJ2zRppjqhfkPIVhJku6W/TW8hWnkYTJkmPi6ZWoFnQYBksveyjKzlFHPoL0ONvIgdcjfYIy8CLBCjm2V1jXPSPnamas0lWIbhxgeaTuJlwO/ZMSi7DpqoHKqMXrZqCthu5QDyMJkCVX6ycthoHkfxBHMnj2Hv4ljdELn4oqzQd+YEsH4HlFZYkvL62H4CQDKjXhjlSMLDf2hLbYPAff8/J2C8Uv9YY9FJZVuCfwkoTBjsxOR1iiLxhkV6qfLB6bQUKYI+elwcuShZdfqz1Wc3PV9IdhBm4lOQJZOJMT7Qusy3HFYQQby6uBXioBnX+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fxx5Htn+v5iOBVI4QyYJKGUBhv7T7MRyr/5pnrcfi4c=;
 b=PB9IG+oNBeRhDHaxL9IgvZP547mpDKAnq5SOLEEqa5+YXR5bfgBNYiuk87OOMvxC8F+Scx92zWo5NniM13r3IMbKr2uZkmcsZYi2acvTvaVD88lnWZGoYVUSlRliDy8N1A6t7L/6X5gqFsubeD+r3mVfoYDKWjFhLVR3nXagwZoDB9Z1COVakGyBSo6e6gvaTbqGCurErHG1s0QfWqTME2OhyUXa6n5FmWWDcgHn0xNUMV2D4IyOLAef7grGgDL+fB5v7jZsrN2uoljWGdE621k7/felFv2nMl+3vByLLDDiyUM4OI2VAGVmIdntM8CyL8/v6pLvWt4HT5mnPkdbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fxx5Htn+v5iOBVI4QyYJKGUBhv7T7MRyr/5pnrcfi4c=;
 b=LaYG8jqJIzrSlthVD+BqQu39zXUxulUFm1V5grJ/gtG0fPbOQGmqGiH4M0Pc/P18sK4tnDJv+VJ5vG8BaH++XrZRuLO+VSfOQA2SgHTWE9npNp49RoxM4Egl6rK1nPDZpDv89PQt6RXKTK61WafscPLtLVcHr+hzPX2CQq42IlIWQJ5OGaCD5vzqFMiGi983yQ9HeSfIdsMzLrkQoWHUwXRIX0E3WSUAVYyT0kJ+C53WhyoCC5CBvMKrhX5qP1obaaqMV4kawdpa3B+ioTbz6o9IqE3+wstlmXARMTENq6hH8dM0OTZxN+yS07mJVSjuyzDlZfCMnMOxA0v8Nmq9RA==
Received: from MW4PR04CA0164.namprd04.prod.outlook.com (2603:10b6:303:85::19)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 15:08:58 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::68) by MW4PR04CA0164.outlook.office365.com
 (2603:10b6:303:85::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 15:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 15:08:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 28 Sep
 2022 08:08:43 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 08:08:43 -0700
Received: from waynec-Precision-5760.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via
 Frontend Transport; Wed, 28 Sep 2022 08:08:42 -0700
From:   Wayne Chang <waynec@nvidia.com>
To:     <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <waynec@nvidia.com>, <Sanket.Goswami@amd.com>,
        <singhanc@nvidia.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] usb: typec: ucsi_ccg: Disable UCSI ALT support on Tegra
Date:   Wed, 28 Sep 2022 23:08:40 +0800
Message-ID: <20220928150840.3804313-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT066:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8e6422-6bd5-4306-7046-08daa1635e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 49Py5QasBoUm6dayaCwChb1Cs/TbZ+Tl95Do7GFbdtJkll+BTNBZr7UjHT4P3hYLQYUcZHFo0eK3CuPh41NjvxCRb9CZShoc7JUFPk/cFGys3PTtAyC6VzzRgIOSJxEWWbUAj63Ync6ue3xjzXMrcD6fYwm6l3jcL7ZxFMjRngcIAL+AgXABVdKpnUAa9RPcWePqNEYzTyNVutPx6qbn0a85AjoOprGpywk56196VxRh43Gb718TbfAJTA6IvYTs39iGuKjgqW/234F47fOh0hqXlmaH2TTQlPg3W0Ra601bKGbJc/qBS3PE41854pMZn41eLahp8nCTWSyjiHkjRqWs7zubZVtQBSbh9OKNxug9xzJNlbwA2duzL1kLjXIQBAw0/FeZ4ocLD69PEHg3ezX60fcrtQAeNHqW8TWuTb+xsDbMCMCzPdygKbFtNHApLhbl8x2ZyOmMkKwwgXvWgbFdPldxp1EtonzH1STj8xf41EuC2KjSeNjCwYrQJLlLaPd0ocBkuZR4QUU0u21sGaMKT/tP1jnu2Ci8frbdchzbTOVoDF2c19TWdxN4NaJNG1mTBU5QWoNngVdAmeQBqMaRMCtxFZTSuq0Xrg59eszVx/KX3pB0/l0+mv2wb5S0pI5osNQwdrZrOTuK2XeyMG98zI7/XIrbNUJl7lvUBgdeXvJquuFNrQ+j/sP2hFzRttsVCVg+tcEBEZzCyby9ef7Nh56h9wEdFD1HkNvPsu2rdZ0r7fw3dRVswDGCPiA9cK2iHph6T7768otO5gmQow==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(82310400005)(54906003)(36860700001)(7696005)(36756003)(2906002)(82740400003)(110136005)(40480700001)(41300700001)(8676002)(40460700003)(70586007)(70206006)(356005)(4326008)(86362001)(7636003)(316002)(26005)(478600001)(8936002)(5660300002)(426003)(83380400001)(336012)(1076003)(47076005)(2616005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 15:08:58.1603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8e6422-6bd5-4306-7046-08daa1635e5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sing-Han Chen <singhanc@nvidia.com>

Firmware built for Tegra doesn't support UCSI ALT command and has known
issue of reporting wrong capability info.

This commit disables UCSI ALT support when reading the capability on
Tegra.

Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
V1 -> V2: updated the commit message and removed the unnecessary changes for RTX
We are now enabling the NVIDIA Tegra products on upstream kernel.
The change is to add the Cypress cypd 4226 support for NVIDA Tegra
products including Xavier AGX, Xavier Orin and the upcoming products.
The Cypress cypd4226 is not enabled in current kernel codebase.
And thus, we shall not need it for stable kernels and backporting

 drivers/usb/typec/ucsi/ucsi_ccg.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 5c0bf48be766..cbd93f893e48 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -125,6 +125,11 @@ struct version_format {
 #define CCG_FW_BUILD_NVIDIA	(('n' << 8) | 'v')
 #define CCG_OLD_FW_VERSION	(CCG_VERSION(0x31) | CCG_VERSION_PATCH(10))
 
+/* Firmware for Tegra doesn't support UCSI ALT command, built
+ * for NVIDIA has known issue of reporting wrong capability info
+ */
+#define CCG_FW_BUILD_NVIDIA_TEGRA	(('g' << 8) | 'n')
+
 /* Altmode offset for NVIDIA Function Test Board (FTB) */
 #define NVIDIA_FTB_DP_OFFSET	(2)
 #define NVIDIA_FTB_DBG_OFFSET	(3)
@@ -513,6 +518,7 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
 {
 	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
 	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
+	struct ucsi_capability *cap;
 	struct ucsi_altmode *alt;
 	int ret;
 
@@ -536,6 +542,12 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
 				ucsi_ccg_nvidia_altmode(uc, alt);
 		}
 		break;
+	case UCSI_GET_CAPABILITY:
+		if (uc->fw_build == CCG_FW_BUILD_NVIDIA_TEGRA) {
+			cap = val;
+			cap->features &= ~UCSI_CAP_ALT_MODE_DETAILS;
+		}
+		break;
 	default:
 		break;
 	}
-- 
2.25.1

