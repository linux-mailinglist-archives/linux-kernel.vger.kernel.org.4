Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AF65ED9B6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiI1KDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbiI1KCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:02:30 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2069.outbound.protection.outlook.com [40.107.96.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35167B3B24;
        Wed, 28 Sep 2022 03:02:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AylNU3GaqrFFoJjsSVWiGZztEdiH0UYWNPHRp7HT6dhK7cxCsvp0rG3sRIta+kn+fsuwfJ9TlwUsPlknV0JZvv7DcgUrrG1Ghz0mGA6eZTz9CbDfuVFdHq8vsOqCRy6uk/9d5Ds6vmWTCDwWM0Go3fewQGQhwkRrgOFesGWDXU6CTe/2VL/0/2CooP2OAaTqKklnMvHaXLChTPtBBYEJo3R0EpkK7InE6lfOLZYb9sDGjjBgdAdDOtUM61mnMTnaUF1EGk/uDvTqkdFQcGuYUHVF79RPmitZZaDsRWh9fcIlrTxqY+8uXMJq6+KMuVdXiT025EnN/WT7T+5B1ENDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGKTZbaDGaaWlfBLO8QfKv3yE+RdpuOcqsJ2SjW7PDw=;
 b=JitTIRQllPBRQQmrGeEj5oY5eWdezk0xRexuwGHw1rc/KxQIwZS8/GUkT6llkmRtRjEiHJpqmPJELfAsZ9gdO1Lx4DX/IVA0NIAY21mHS0rJv6Zum101uHRiFBaAYMEEr4xtxb9nVE7NQxZlqQvL1f+sPqrXRJwqNEI4Jpjx0It3pCHeyXYTRTs3lJgZa32BzAMuHr04yw5ZL0LBmnHbcg6BGW18r97dLePbJ0HG4Xd+UtVRMzF2xKidJuewo+S5FtzL2xMq8MK7T7Wau/AA/nWmgwXlvvwwuPCUWrP7OImglvkE7XK6HlgOHj/+mxoPwqOv3eG4uULdlvjM1CtkTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGKTZbaDGaaWlfBLO8QfKv3yE+RdpuOcqsJ2SjW7PDw=;
 b=bZpGxpKpV9YkhyQmwq/ncU/xiug06fCd/Kd819jwhAAJWdYxdqa7PQHOPE15KFWyj5OESqZV71xXS2HEq36+L4nchI4A+5jDgGB3CcW4MkArol2JVsX0QXkyVoRi3Zk6BWUqu+PU/zt+rh3I44/N6XazDTNKkTWjGuUND/p1gU0=
Received: from MW4PR03CA0325.namprd03.prod.outlook.com (2603:10b6:303:dd::30)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 10:02:09 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::8e) by MW4PR03CA0325.outlook.office365.com
 (2603:10b6:303:dd::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.27 via Frontend
 Transport; Wed, 28 Sep 2022 10:02:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 10:02:08 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 05:01:59 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <eranian@google.com>, <irogers@google.com>, <jmario@redhat.com>,
        <leo.yan@linaro.org>, <alisaidi@amazon.com>, <ak@linux.intel.com>,
        <kan.liang@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v3 14/15] perf mem: Use more generic term for LFB
Date:   Wed, 28 Sep 2022 15:28:04 +0530
Message-ID: <20220928095805.596-15-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928095805.596-1-ravi.bangoria@amd.com>
References: <20220928095805.596-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT056:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 09826188-06b9-4a93-267a-08daa1388154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l7yJyRil4fx0hS2b9kCwVqcjWwnlVz451LM14J0DN2PnSLGnFV1QTX5ZyP1tHU5Gp31p2Rba6dM2hFrf2TcOVZJWQKmTc6pPyV2E37jm0uYl0NYLuGclqDWLFWiHIT3P/FgDmeZclZiDfiwKOepvBmqrlxb6ykcm2Ewf0eRCwGOZUL8EQzVo8CmY3oECWYQAM/EhyAlMgpWPEtjMzb431y+iwLtjnblQPxJjSsjLWtbGOndqplSs1mQ4xzmIhqJndysKvU7ONHpIbUHzuEzWQtGJuisrAe6FKngo4nZ9xTjqO5Ozpg56LX7wAbZXIR7Qpkzmb5nQiCCHowXDv4NxrPdyfaLurge6zVb6O7kaEpW+Lt6HEed3W6/BRKKH0MkSHSlDYZ0zCZuLBm0/66khh4HCNt/LMO6y2j8iuVz5bs5uM+rWxT3gGqmjBpSJ0KGfpJ+hnyBVnY15vzTta6RgEoLhbvgybw8rLntkZNC8LaZJsdhHvU6imk63D4M278//YYC7lEsJrnXdK5JGEr0s+z91vduNyqeoR6Ir4SJpkdPJDmhrcnyG0wZr7HwdMX+A+CrP+B/1nqK5rqnAveqnp+qLLC8Fk+AMiQ7ECuQuGwpIeKJPsmv9uaOKU7XI3NQvPns0S6m/yNSt+BCTGW+QDK7YdrWsxt24EyMDqbIp8eZhKGlgWAjVQDuMbiHfa6iqD/7v1dVX96okp6mu2USHFwHuAMrEpqNmlISEUzz3Rt/ZybXBF+djx1H78Dpf2ZKYh6KrKhWN1agtThY6JDVejcgjpASqy6jG91P5QuY+RA3fCeFBRHoFZFTm28HsoJujMP1zz7478Wv1eh3Iso/luA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(2906002)(44832011)(7416002)(5660300002)(4326008)(40480700001)(36756003)(82740400003)(47076005)(8936002)(41300700001)(70206006)(70586007)(316002)(8676002)(81166007)(110136005)(54906003)(356005)(40460700003)(478600001)(2616005)(86362001)(82310400005)(7696005)(186003)(1076003)(26005)(6666004)(36860700001)(426003)(83380400001)(336012)(16526019)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 10:02:08.4487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09826188-06b9-4a93-267a-08daa1388154
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A hw component to track outstanding L1 Data Cache misses is called
LFB (Line Fill Buffer) on Intel and Arm. However similar component
exists on other arch with different names, for ex, it's called MAB
(Miss Address Buffer) on AMD. Use 'LFB/MAB' instead of just 'LFB'.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/mem-events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 4553b4389b17..a1838a641777 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -282,7 +282,7 @@ static const char * const mem_lvl[] = {
 	"HIT",
 	"MISS",
 	"L1",
-	"LFB",
+	"LFB/MAB",
 	"L2",
 	"L3",
 	"Local RAM",
@@ -298,7 +298,7 @@ static const char * const mem_lvlnum[] = {
 	[PERF_MEM_LVLNUM_EXTN_MEM] = "Ext Mem",
 	[PERF_MEM_LVLNUM_IO] = "I/O",
 	[PERF_MEM_LVLNUM_ANY_CACHE] = "Any cache",
-	[PERF_MEM_LVLNUM_LFB] = "LFB",
+	[PERF_MEM_LVLNUM_LFB] = "LFB/MAB",
 	[PERF_MEM_LVLNUM_RAM] = "RAM",
 	[PERF_MEM_LVLNUM_PMEM] = "PMEM",
 	[PERF_MEM_LVLNUM_NA] = "N/A",
-- 
2.31.1

