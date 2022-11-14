Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F799628DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbiKNXlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236922AbiKNXkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:40:52 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F4312778;
        Mon, 14 Nov 2022 15:40:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpO0uqot9dLfv+fqqDhtHLau+h24URkfIebk8Q+DZR+HqsA2U3FNqH2KFXOU3+OxDRCEgp0EFsLGqrLwYJbplbnyqmVKrme79/KOQagGDqLa3UYJT8rmKEXZjcLPxtiifxVBYrj+UFlJRXGixeQ0u/EPOXdgEtMNbAhuckCZ+0awOvaNGy4fQGtJzeuXrqSS5gQTlb1NSmZaL7h/FMZRSWcKch6lDOfuJcgmjvqOd0UqJDpdVFmQYUlmHZfBl/KYm/vz6WA7RDZDD5hVWo+4TY4OcUVJYGoh7qcnTZ376Fk91dSiYw8OpMuN8WbGaoDbtqsq8+WgvYanZlbQW0DCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNIwE8dSb3xUUhPBchaDfkDUIVjPB7WPWbfBZFNCULY=;
 b=VFyV/dEuaYR/jdH0ZYzA6HPGlHYPglXXjpt+2OfibU0JFVZMX5HTLjjiDhuSQlCJs4d1JtgC2NyG6hkh8AzozawXEsyknJplT6mY7OjF5nldIK+BwJA1/gafCpn6+rUV9LAb7FYSYnKK1cCJO4YgpHEtkwMAN9F+4UmDbyj9M2zzk46jnbeipzSf5xGl1dw51YUwFCMBn+0UKwlsPpTc+grFlSVKSXfjfvxnP4TLvjT63hnsXXA6bl6UvMsa2A0fPC//ArxPFBfqXiTNoUhGrMglp/I3uqq6l+Ocmq+KL5yyMUyav2ZzScrZ/pqWpRsI62DYDTXSTRbLhKpRsDZe0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNIwE8dSb3xUUhPBchaDfkDUIVjPB7WPWbfBZFNCULY=;
 b=qiyAq91RkeLDgakk9dFOXmKAi0hA96MprsX31CiUuuZcvv04f9Mq3e9COYtAcjkMZ6UfHCvIfWAYZkFpKLWstY8JSF9B3FGuoMQaEL4z3lSrQt34I4kCyMxmoDqkATjT33G0VIa7qyj8WdwFXX3RUm2pad/nl5EMkj3sGAZ9jXw=
Received: from MW4PR04CA0253.namprd04.prod.outlook.com (2603:10b6:303:88::18)
 by MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 23:40:48 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::96) by MW4PR04CA0253.outlook.office365.com
 (2603:10b6:303:88::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 23:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 23:40:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 17:40:46 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 14 Nov
 2022 17:40:45 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 14 Nov 2022 17:40:44 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@amd.com>
CC:     <bill.mills@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Ben Levinsky <ben.levinsky@amd.com>,
        "Tanmay Shah" <tanmay.shah@amd.com>
Subject: [PATCH v11 3/6] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Mon, 14 Nov 2022 15:39:37 -0800
Message-ID: <20221114233940.2096237-4-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221114233940.2096237-1-tanmay.shah@amd.com>
References: <20221114233940.2096237-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT031:EE_|MW4PR12MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 04924da3-92b0-4b56-d027-08dac699a85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kIiyhf0HDJ/fZeMRsYqRdbXoMa0HEsknmb290PNuyCM+qxvhTmVE0m+vUpq5dy24zRHP69cyJON3TPSFDgFWlvfLR/2g/vyDdWIblywguI16npK5Hxcntn3wVnoSOzXdreCTy8xbkzg1IZSCbghA48cgXrSf808eLVB03/lx1sXtt0jdI4QMATr627g1+5C0zCk069/tX5I0pVEdud8aw5y4IzEDQBnHr3aR9KrIMPku88he/gV/HO325K7n8UpCYXC+bbPF/CanJXg8tSy2vgp54iIDdCWcIW12lEjXcve8JoL2NMVnnZKrnpqs6FLxPh6ZtdAbeXpU1pqZ35yiDBbR76Cm5g299wTszmur8Iwtvf5H+N3gpz4O5HQvmD30RV4Ul2MuZHpzwRUH5jqGurHyYLIcFRr0hQOIYxok3JzacdMxup/d2JuD5vsAmu9Rgc4njF7PtwRvfg6VCic1F5bk0dx2o51DOvgDseUQXuQk5ebhF+AtmabmudIxWHtMJilSL1NFEs2Yus79YBidQYiUA3B0Lif0iCqyWJeM338HUtIybYDULFSJb3i6rdOLuVPTSIeGgT3kB6x225DEn3iTL4sN3T+4nWikU3DiDCm/pPxZfRoYJ7+ytppC1TAcXdGmz+oPWC7J4D15+amC3G/mMMC5lf+wVjBi/p3IS69Z9f4woJZ+OrlPFA5+SWH/ZcwPZnAkPecZNbu6YIcCD9s32EfvCaBHdFW8joU4zsBRE8qEGB+oGhfoWO71itDgql7TIz39qDXsooOrHsucDPPuldjBkljBNm1uJxd2IIY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(36840700001)(46966006)(40470700004)(478600001)(81166007)(110136005)(26005)(6666004)(54906003)(316002)(6636002)(41300700001)(8676002)(70586007)(70206006)(4326008)(36860700001)(40460700003)(356005)(82740400003)(47076005)(83380400001)(2616005)(186003)(336012)(40480700001)(426003)(1076003)(86362001)(8936002)(2906002)(36756003)(5660300002)(44832011)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 23:40:48.2022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04924da3-92b0-4b56-d027-08dac699a85e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263
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
Acked-by: Michal Simek <michal.simek@amd.com>
---
 include/linux/firmware/xlnx-zynqmp.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Changes in v11:
  - None

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

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 76d2b3ebad84..bdbf855b5eef 100644
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
@@ -175,6 +179,21 @@ enum pm_query_id {
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

