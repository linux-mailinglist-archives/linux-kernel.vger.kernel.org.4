Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56E76F4F9C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 07:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjECFCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 01:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECFCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 01:02:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBA22D4C
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 22:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO5vSaKDGNW+wfIEAV8kNO8/h0qleFtecVw0nEvQW6GeHzHvmPh2oEJpKVAai5cpeC/9jS5NIr+QFMIpNqd+cIr2aUnOkQH9om4Z9BHn/CaoTH72jv1RKoLugz9h/YpARSIkyovYVvE18EGk8g4Yw0ob5gjAqvJEAtwkx1P9aowQcX2KWus236+IfyamZ/OargUV3LVQzi1mdt5hERXLn9orxlHzd0Aa0W21tf0UXsuXxv+AMvTBYTEj3BnxUA97rG74tg9pdWaxR5az/r5iTPpFOmJotzKcjZk7XRfy/2439gXKH0HSZjHTrhGjzVw3Kvagsd6VefDuw/Lftl+Ndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiyAps1/+ZeRnfO+qj7w4Xu9qMHzOgtmwjAqspet4N4=;
 b=Vj5ejuqbl66AQNX5dy7I/xS8p9EeMfE8KdWebqOaPj9cgZtEwORqDe43+nax7VuTg1iEbs8A3NqFUXwVZ7dewpV/iGU/udRrhHHgjWsc37ZpV+r00NBmL7SOBpr8tpo5CnZrVtwDtJdLKe+4EEZSLpRIONhmy/UfHMJwybt2c1KMAmkauoZy4p+1syQSfh8IIGWZczVEYDuMumZxC0IvKXKQJD0nnpL8TRAas0CfaQ6+1rLCeUn1NUarxiMOI2S8NGbCoulYbf2DADweY8Y3KYe1oZBg/TdF50p3J2+kRTukHu9qyXLRhRnCeLUavlWEf8+J87NjCuJpqfAQ/H3YsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiyAps1/+ZeRnfO+qj7w4Xu9qMHzOgtmwjAqspet4N4=;
 b=acajbgAqVXbtfV+kJWoiKLu2mqVWc+r/Ws9J/UKkE7BHC2tlOI7i2UzA7nFsWkUe6q4L75WAG0cKp4n4gAMaR+ZBs5JxWx6sr+kDbJzRDs4o9p1EEGGkT9faPK7MjAnskLzi9weFOMgKwNsKfTp2z6Gu2f6ND0dtI7YTeuNMrpQ=
Received: from MW2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:907::23) by
 IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.30; Wed, 3 May 2023 05:02:25 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::64) by MW2PR16CA0010.outlook.office365.com
 (2603:10b6:907::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22 via Frontend
 Transport; Wed, 3 May 2023 05:02:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.22 via Frontend Transport; Wed, 3 May 2023 05:02:25 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 3 May
 2023 00:02:23 -0500
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <michal.simek@xilinx.com>, <tanmay.shah@xilinx.com>,
        <mathieu.poirier@linaro.org>, <ben.levinsky@amd.com>,
        <claudiu.beznea@microchip.com>, <nava.kishore.manne@amd.com>,
        <ronak.jain@xilinx.com>, <marex@denx.de>,
        <roman.gushchin@linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] firmware: xilinx: Update the zynqmp_pm_fpga_load() API
Date:   Wed, 3 May 2023 10:31:58 +0530
Message-ID: <20230503050158.1936467-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT043:EE_|IA1PR12MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 81549d7a-cf4d-4bd7-684c-08db4b939601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I62F7sVoJhoYi53RtOGewUzIXD/y59WsseEwG8a8ptNFdl5mzsuHj3k7lhGD/MkpB8WGiIcr0/aBHBRutc93p48NLjC1WH75TjFE9qyN5audK8fyZpgi4j54wF4ng7HcpkvekN109D6Nx7SGW/d4tDSgakAtWf5l1+BjKqYNPFDFZFaDf2SDJngTI0RfQiCqFCkFQqfGuhCGdAxPtfqOHZYf3EQCgOGXE+ZYRfaKZFj6xdHoPXdTukqQuMQCRp+XmiSiMwurGV+Wr/rdYmisHlk3S2jO5bocjlLm4cjGqVGk+/gQBXEXZ1uH1rpBF8Cgs76PTHwEqpxmsRoI6Uedx/Ga3czscoiB9rnSHsxkKwYSQXIKJeJf+nkUzkDn5JER8Upbd3H0te3WOQ61/y6G1GRznSJBFoCQQSH2eJRmlD8fBdxPfbh2zK5s2IkHgpiJUaQSwPMt9dsdIXhzph+RwsoGYhdOIP/PZQ1jDb8pvP//fpORQQ9lfViwXxj4wrhgfg6uhGqx+/e0xzo3zSfuL/Yigluw0qBoe62TWbcQbQC4JO5sFQdQMPA0kKHNuoz/joLaXWw98Ld9+budCnbrb6UwKZcmWkD4QQhZe8kWrjZxVqnAd92RzbT/83HDcciIFIobb/fOHau4Cy8PekK8JyI8H3i+RHmi6E5RNdTMLCnTGYL83tvx1sowWGZMiidzF5y/8H5EjLWsqjaUDuwoGKONkLEkxvEKJvbxgyCtZcJfqm7kiNPDyGK8Vm2Spo9StrcnvqRhAdNjg7DTWJY4ZwdKKMXMs6XnAFoml8/dNZw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(40460700003)(186003)(70206006)(70586007)(26005)(1076003)(47076005)(426003)(336012)(2616005)(16526019)(83380400001)(316002)(8936002)(41300700001)(15650500001)(8676002)(5660300002)(478600001)(110136005)(6666004)(4744005)(2906002)(36756003)(103116003)(40480700001)(81166007)(356005)(86362001)(921005)(82740400003)(82310400005)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 05:02:25.0601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81549d7a-cf4d-4bd7-684c-08db4b939601
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664
X-Spam-Status: No, score=1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the zynqmp_pm_fpga_load() API to handle the firmware error’s
properly.

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index ce86a1850305..398ab86e2bec 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -942,8 +942,16 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_reset_get_status);
  */
 int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags)
 {
-	return zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
-				   upper_32_bits(address), size, flags, NULL);
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
+				  upper_32_bits(address), size, flags,
+				  ret_payload);
+	if (ret_payload[0])
+		return -ret_payload[0];
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_load);
 
-- 
2.25.1

