Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5635F6AE4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiJFPoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiJFPoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:44:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F35576973;
        Thu,  6 Oct 2022 08:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHtl3a1M29D6KU5sYCUeT0AfWuvXrdnaMsjPY9gE+dXwW+AkvXqxT6jeNo7PuKwRLrEeTShQSPMJJk48wqB4EvxfbR5ugiCmclNekXtiWMZOB+zZkmjfMB9pLDN6AZdQYpWDYO7uDUP9Q7fVfXHs0RKd8xzwisOTu7phGg8UfTGJ0DFaLFyKP/+ujIi94phiGFqTID/0MRf0FswaRIxLDSccawGAiKXBFglAjPLD1YreB6haU8XHwRvnL22NwuxY3Uh4CEhYRnvjCTE5mn0uoqbay948dFosyWOfaIQq92WiETLNM1I5atqqWGoCd8dWd6vCYvKuxXAG2F8HLJLG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZTAEIfqigTN//6pLLkeRZJ+V5NyiSbkpjpzIgUChOI=;
 b=WG1z62iv6rfEzwz/LKMXCbnzq9HzwvUAby4Mido0NC2A3ViXGmGXue9yc7FKFVsaea/nz2BCUTzjed1ieppSDqTbQihQk379rJKH37EBOlFra+BLFzWQfmuIDBLuGjOF7YqP0s+9u7MLRDnTYAiPyw30UWMOXeDebZqkxU4mL352yD8jDzXmkchZ0AZKPGZv6GBb9YIBAzfHyQ7RUU3rsBvE6vBbJV5PoRlHb2+vN7dp6nFitNvIAVfEVeFhO4ghE4e/iyrqA23ueh2kJ+x8nfi2lzOlOX2zpEZRKTxoI/92G8bBknDC3XZ+ToUAtzlif+eqCz9oI8A+HVU4edReJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZTAEIfqigTN//6pLLkeRZJ+V5NyiSbkpjpzIgUChOI=;
 b=Qpxtum2KZP8xuyC+Zklm4zAGV37LOosSdKEOEFZ1R/2uzHQtI/DInKq34hRA6PI2Ge/hrSEWTCCh5zhEka2JGz8cyDWTNXfTPTBEPBbdvP0CCYd/bvVSAk8uEjj/W5n5Jd6/pRg6D86wIJNNToNcKlQTf+foeudURYeOWj+6B1g=
Received: from MW4PR04CA0220.namprd04.prod.outlook.com (2603:10b6:303:87::15)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 15:44:20 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::58) by MW4PR04CA0220.outlook.office365.com
 (2603:10b6:303:87::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28 via Frontend
 Transport; Thu, 6 Oct 2022 15:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 15:44:19 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 10:43:26 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>, <peterz@infradead.org>
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
Subject: [PATCH v4 3/8] perf mem: Add support for printing PERF_MEM_LVLNUM_{CXL|IO}
Date:   Thu, 6 Oct 2022 21:09:41 +0530
Message-ID: <20221006153946.7816-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006153946.7816-1-ravi.bangoria@amd.com>
References: <20221006153946.7816-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: c677ab71-d3e2-4df0-5302-08daa7b1a1eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzUYuqgkP0tfiT11+98YWrWPTLPjKawKjjbZTc1Ba6dTQFgg2i0SPEW7HIhRgym73ZeZS7wQ9KHsVzMgcIpdfptfSm/tIJ03iy7PdTIQJAyZMwAFlZp7c/HE9SgkvAQYissww5edNJe8b1SplEPIfURprg6nralvOqs+2WMuzkBKPWhRTEBteRSjE/z27JLRLj4b3qrfq4e7eoFgfzx9HhynbpzPgAdGulQakE3i37Stne/Q+SbeSi6Ccyx6rynZgRlUXFHdOYO7j/YXGbloY7Zx10bChACbPK9pteN+uPhsWjeofqTlpS9GgA2CuLqxHAxOSuJYtByOKHh7kVvUWe7G8gj/y0Pg7BLD4A5tmotVrg6KDUQkhBz+ocB7Au7+6t6b3jeoCi+6FM8rUyngu8JWrDcYl5ZrcSvl5ONf2X0Pt6Ima8G9IqfFjrXdMKLZwdiizKn6090/OdFivlzawv7qpPstVR6riLRFMM0yzKK3H+2iOEHZoMn7Rm3ehGD4QLM6g7TIayZrF2rihmm26njZSu8C0/Dl6kr/j1z7Gng5k0JhlRpWGa83FsRUttn1V3tYggZ+3/QHrDO+Tmftyom59jGoy/ktROPyP5EBQTm8l8qJ17KYHNrKiPap3+/QrclO5ZQiy/wUV3sWhMfp94WvuaPySV27qiDe2NzoJeWQLWrqVeiuDaJzjd7Faj/1yON7iib7yd+IhLfStztzUUUAAgfyKzptCFKfB59EahsRcoH6tqPG4WKwJsKg9iRJm4KWPiaNQIxXGbAJyqI/wBk7oH7M8yOEgPjoBuYrXxdIYdIGR2KG8TpMthAjROpZfgJ+cjMB10yizH7/13zMtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(70206006)(36756003)(8676002)(4326008)(70586007)(186003)(36860700001)(41300700001)(5660300002)(7416002)(356005)(82740400003)(8936002)(40460700003)(40480700001)(1076003)(86362001)(26005)(316002)(16526019)(6666004)(426003)(2616005)(47076005)(336012)(110136005)(7696005)(82310400005)(54906003)(478600001)(2906002)(81166007)(44832011)(4744005)(83133001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 15:44:19.2075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c677ab71-d3e2-4df0-5302-08daa7b1a1eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for printing these new fields in perf mem report.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/mem-events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 764883183519..8909dc7b14a7 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -294,6 +294,8 @@ static const char * const mem_lvl[] = {
 };
 
 static const char * const mem_lvlnum[] = {
+	[PERF_MEM_LVLNUM_CXL] = "CXL",
+	[PERF_MEM_LVLNUM_IO] = "I/O",
 	[PERF_MEM_LVLNUM_ANY_CACHE] = "Any cache",
 	[PERF_MEM_LVLNUM_LFB] = "LFB",
 	[PERF_MEM_LVLNUM_RAM] = "RAM",
-- 
2.37.3

