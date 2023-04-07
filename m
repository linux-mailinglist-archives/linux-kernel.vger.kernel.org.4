Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04466DAC2E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240664AbjDGLZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjDGLZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:25:38 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0643361AC;
        Fri,  7 Apr 2023 04:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfpVnnLdXmdq3rsyq+lJmc8Z7ojvy7wnqdbb3wBqZajl6yr9gw6/x1qvEKYwb2BvyI0JEg/wvwj6rLIvfQXS+34RIZOltAPRwkqoGWQs4Ch1OymEKMTtzboF43mmXLBb2AQXabRapRnSPfVLK/RE/Cl3J+0wKXw9k/K4NKgo8Oe2EKGxebGTeriEoI4n139gC86Wpa80kRRmhNOPNxNePWtfO1W8bq2bPAdnrnz9SOG6UZWC3WCjB2mCuR2xlAa0zjKbkxPlC59qzZNV8JmwjxrW89lIQZBsHrm/azWekHZ3MLzaJuatSny+bQV26BmXa8XXyCie6DgKU11+jPDdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnBwp7x2NGbi57kXXu8FcG/DkKPsEBLRplDInGSMnxY=;
 b=Q4FcBHaR3Nh3roz2AQdf3R73LdW+Y479QpY2JCnc+Wa8nPLGHn68ZVImF+RAwT90nsoGB8axaZcKkDN4ObKAU/fwtDhL3ple9CTPY1Q+3Su3/l6iq3CE+AtFD0E26BJjqOlbDSbCfl7dKER6QwtEeYUNyOEDbSrWAIvUQHBiZqxs3dUQggzR5u4cPExFZqxYqaOV1GZoRa2h60gKerBdJ0Z4qcqsSOuVWa3sb8psBG3Yb/vSlXdLR651I8xCZyHu9/QUuifU9bF3r6CPkCe6O6LGqR4KDyVzctm4UeNlYfEk7n7A18J0qTTtegobu3qKMRoFe0d9djMgltwriGYDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnBwp7x2NGbi57kXXu8FcG/DkKPsEBLRplDInGSMnxY=;
 b=HwMtyY1w7cd1ARMGubdP7IgD/kHG455aLStFDBjgOtWFv4WC2i2ZbHpXMdWd+Xl4XGWg0dsZqYGGOLRNPxEKMVnUIJC0XYcHC+vd5z0zzMcrTcCAnXARWqYgQ053y60mORtUSgExnsBNMwOZs+xhUpoaxE33MnC8Y96RNbe11nk=
Received: from MW4PR04CA0178.namprd04.prod.outlook.com (2603:10b6:303:85::33)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.29; Fri, 7 Apr
 2023 11:25:33 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::ab) by MW4PR04CA0178.outlook.office365.com
 (2603:10b6:303:85::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34 via Frontend
 Transport; Fri, 7 Apr 2023 11:25:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.21 via Frontend Transport; Fri, 7 Apr 2023 11:25:32 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 7 Apr
 2023 06:25:26 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <namhyung@kernel.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@kernel.org>, <eranian@google.com>,
        <kan.liang@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <leo.yan@linaro.org>, <kjain@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v3 1/9] perf/mem: Introduce PERF_MEM_LVLNUM_UNC
Date:   Fri, 7 Apr 2023 16:54:51 +0530
Message-ID: <20230407112459.548-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230407112459.548-1-ravi.bangoria@amd.com>
References: <20230407112459.548-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 600cabe4-78d8-443c-8c98-08db375acd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CyUatbFRtDhqf2fJi9bxel83HzQpNFrpyn76UB8AHFuLmo7vlsjbuBypEYz8YSLFvbaRPQ9slGAQ3w/6PXLYcpBiQO46ddVRJn4JdUNgb6yujhD5AlBlz9axqah2a9uwQmYKG5eNSpTTUcNTNkvG59H0OKWp/heUOyfAbb4hNJ6GAXkKaWhvCFCMZpcJd2u2OgapgpqHYUZmJyJFGiA9/MI2DLbE9blDgaNHNuQCtxkjjsZ+eyN2btcQBGhiOmeO8YBuaQrWfvphuOkTO2p8OwHRDoz6nBBqn8/R+8+5U+KPccDX6TeBQoxUch7e4dqOjWbFIinNnRqVxiQYTqIltDljKMVllNshgxha+X7jvaNtSP+10D37ELYKTEI+fmrVp639tbHsL+HKuc1aNxxmEy2ULOhuiixumRin20uNqYpBK7fW3n1IFXfyGbJsk6XK49QV0bWu4TZ3MFrhllVeYN+PGMtjkabdXcR0wuwBEk+SAR7ndT8oJUl7vd4h1kCBsB0ZtqUab7iWtzAJHOfZvR785iBtS1/Sl0aEC64Y8yRLdewfmz2KOX5Wfkz1/UNpTiHUNXZ5yfqKjZbMOFJ/IJ3p42V6knroTEq1/EIEjUuY5TiSpcLql4wc8Bo0Lo4qVoj+hlyBVXb8TQJmqD4nVjuC1GEJKM4atNSvryNk6Hk/3Vl5xQi4dF7gp/vNBjGl96MWg0ZxFcn6TmvL5Xu1bkKU0dl9H+kpGfiRkxnwIE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(2616005)(356005)(6666004)(316002)(81166007)(36756003)(40460700003)(82740400003)(2906002)(5660300002)(8936002)(7416002)(36860700001)(44832011)(47076005)(40480700001)(82310400005)(41300700001)(70206006)(8676002)(70586007)(4326008)(4744005)(86362001)(426003)(83380400001)(1076003)(26005)(54906003)(110136005)(336012)(7696005)(186003)(16526019)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 11:25:32.8099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 600cabe4-78d8-443c-8c98-08db375acd0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older API PERF_MEM_LVL_UNC can be replaced by PERF_MEM_LVLNUM_UNC.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 include/uapi/linux/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 37675437b768..39c6a250dd1b 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1339,7 +1339,8 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
 #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
 #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
-/* 5-0x8 available */
+/* 5-0x7 available */
+#define PERF_MEM_LVLNUM_UNC	0x08 /* Uncached */
 #define PERF_MEM_LVLNUM_CXL	0x09 /* CXL */
 #define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
 #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
-- 
2.34.1

