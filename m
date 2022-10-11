Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8435FBCD8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 23:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJKVZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 17:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJKVZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:25:17 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2053.outbound.protection.outlook.com [40.107.212.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573727B282;
        Tue, 11 Oct 2022 14:25:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JI6983rxYSOCOwWerNkZw01CD4L8AjgoIazY3SGj/OvI3eStJji/MltUc+cDLFdmmu1XgPmb9UWIoGD8Pt0AM53iU8jTxmCCE4xvEkLql/Hp84MBQs8aVUI2ocy0VIZpd3qKV8dwxRqlw4x7Dddenu5e6TQl6ueECYV8xcZnhXX0TceEJfhCVXNMiMY+lQ/LsF5AkfYka1KekZLNanjfybVu/PcgVXZKqKR7GESlIkwtSK7ZxlMlIYrDczZN99p7QoOLGkVnnIt+BP6EIFFcgn+k/o2WAyoGXJrZhwrxQmpT7ssOKsXaNly/eo8iuFN8P6ComCUBuITyy9sSh0kcFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQDd0tQWb3wYIu0lNPhVz5GpYoTRtgN4B5dY7gJsoys=;
 b=SVKZmAjO2cgzIYriN46k25YB2Bz+x/eEpvHB0NwAzbDzQiK7c8sj+QI/tmOJwAGsPhxSHq86/2zaSPkxNfuxPxQkMA1H/T8y0oN5ItkQBdn6BjzQo2Tl+mEphmNvkNad1kQ/+/vWo91Od4hclEddjIeZ5Xwl9Jn8B5R+P63aOMclyE3IpuJLa8Le+I7EIhLrk4MG6mmk3hOG63VmzVj3ntiZQTCxPfjhwOGZ22gL1GK2+ZTi1gHB4t49vbb5kQ0JjDmyTEbO9NcpeeNyfQoO6V5IjToo69LThyEcZFSt/ef9/kdtRqDcOsEN99QyXREl1GIJeZb0VROS76MQf2W4rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQDd0tQWb3wYIu0lNPhVz5GpYoTRtgN4B5dY7gJsoys=;
 b=g7xAJNEutI2lgRgsYQspQZPhsw3hPcLP4SVsqFsy0HKyCwN9SIn3Lwk5fAO4vnsjtDhkzK2SHDim7QLJ70CVqklUHEj5mvOFP9v4WQjm2gMrbLGx2kIZLRi2SaDoGlktOKDgBXR6SVfPPI4+cC5FN+qP7WQoiZtMNmQyw2Zlz+k=
Received: from BN0PR04CA0124.namprd04.prod.outlook.com (2603:10b6:408:ed::9)
 by CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Tue, 11 Oct
 2022 21:25:14 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::64) by BN0PR04CA0124.outlook.office365.com
 (2603:10b6:408:ed::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Tue, 11 Oct 2022 21:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 21:25:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 16:25:13 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 11 Oct 2022 16:25:12 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ben Levinsky <ben.levinsky@amd.com>
Subject: [PATCH v10 3/6] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Tue, 11 Oct 2022 14:24:58 -0700
Message-ID: <20221011212501.2661003-4-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221011212501.2661003-1-tanmay.shah@amd.com>
References: <20221011212501.2661003-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT061:EE_|CH0PR12MB5346:EE_
X-MS-Office365-Filtering-Correlation-Id: de766fad-186b-4fbe-5ef8-08daabcf15f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDPuEH43kS3j+DoIJ69GX9yS7+F0LCKCH4iMUUe6GbdZuXWhG7vLgtWKU9bQdke+Y8rGVWp8pI0J9qt44yGjwcgIxNBe0g40lyrx1fZvXB5aYp+TcxquMW4hdocDSR/RGDuST8B+SwaSS/GFcDtnM4KF6zNPAgqBOD4SSbSvsoLp2qY2XkdYlV6eM6TRFqri00gylTxVQr19Hoiz1wvaJdUiOSTpdy1koRnJxJdy5Gk4B6UxncPv/k7IMxYTyEObINjKioYDPh7/MrR9kwZnf8jfz7TnfRzCdg6r3vELn8bTsrFuaMV9T9uRLI/fnGP2VCeODcYlfTqh47+pj3E0cbJGGhRPZQ/m+ETftIKSlcjQPzSfKeRKdhu3/wT9SsXNiHEiJSkk1Bu199NS98or6rjKPmUX9X89NPp6MxgbMR0R2riJShfKehH6H/KF63ygKMHkYwjmV+Ux2IABH4TvRg2C/2/zXnLzVc5HYuGQn6WcC8lOVzm9A54rutzc6TBsOJ2vdi3DfqCosvp9O5pPrk79iWxvLNsD96kRXz74G433cB2Cf9krMJyE8jZL9t+E8lAsEFVl4zIwj7PHKlss4jBdmTdvKzFU2dN2p41ajRn0IA/DNzWJaEr9WhkTdVOOafQjilt4pooz4vyWn64BfMcQ/64FZAh8/9prm4NIED046F8Qzxl3wlaF2TWNUTq3xpEnzFViwbw6qw2NMza/z/qnbMbujOjQrT2KSnK8lIMsZYlOVJvQOjE7IQbclyqW1bXZ609wmxM+kCP2F2XMVzY5yQwZblX2gVuGex4Tjrw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(36756003)(86362001)(83380400001)(36860700001)(82740400003)(5660300002)(336012)(426003)(47076005)(186003)(1076003)(2616005)(81166007)(356005)(2906002)(6666004)(41300700001)(26005)(6636002)(8676002)(316002)(478600001)(70586007)(70206006)(8936002)(82310400005)(44832011)(4326008)(40460700003)(40480700001)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 21:25:14.0597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de766fad-186b-4fbe-5ef8-08daabcf15f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5346
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Levinsky <ben.levinsky@amd.com>

Add ZynqMP firmware ioctl enums for RPU configuration and TCM Nodes for
later use via request_node and release_node

Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v10:
  - None

Changes in v9:
  - None

Changes in v8:
  - None

Changes in v7:
  - None

Changes in v6:
  - None

Changes in v5:
  - None

Changes in v4:
  - None

Changes in v3:
  - None

 include/linux/firmware/xlnx-zynqmp.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 9f50dacbf7d6..e00a25aa2c17 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -135,6 +135,10 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
+	IOCTL_GET_RPU_OPER_MODE = 0,
+	IOCTL_SET_RPU_OPER_MODE = 1,
+	IOCTL_RPU_BOOT_ADDR_CONFIG = 2,
+	IOCTL_TCM_COMB_CONFIG = 3,
 	IOCTL_SD_DLL_RESET = 6,
 	IOCTL_SET_SD_TAPDELAY = 7,
 	IOCTL_SET_PLL_FRAC_MODE = 8,
@@ -172,6 +176,21 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_MAX_DIVISOR = 13,
 };
 
+enum rpu_oper_mode {
+	PM_RPU_MODE_LOCKSTEP = 0,
+	PM_RPU_MODE_SPLIT = 1,
+};
+
+enum rpu_boot_mem {
+	PM_RPU_BOOTMEM_LOVEC = 0,
+	PM_RPU_BOOTMEM_HIVEC = 1,
+};
+
+enum rpu_tcm_comb {
+	PM_RPU_TCM_SPLIT = 0,
+	PM_RPU_TCM_COMB = 1,
+};
+
 enum zynqmp_pm_reset_action {
 	PM_RESET_ACTION_RELEASE = 0,
 	PM_RESET_ACTION_ASSERT = 1,
-- 
2.25.1

