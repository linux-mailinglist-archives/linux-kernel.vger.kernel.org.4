Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338AC6DAC33
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240719AbjDGL01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240689AbjDGL0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:26:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42500AD12;
        Fri,  7 Apr 2023 04:26:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnGvKl/3wcleB/Nlr5H6F+ZEfus3mUuH8sfzXiYv0WsfBWMpV8GuwOinQjRSniCD7gKIsZzdHKcxRrTOvhXmtD0oE+dRZeIT/MGdgfqFPYAfJOy1KYofbu3uIPB6iHI3b/9dmPDyEU43CRc13nCDauuL3DceOz8DKstbPEF+Nm7bwLbOfyhgN9lv908v+hj3ZDWZneCYPYGZ0WpYY8ojSX9GpGl4+3ajf8g70+JSLwKQE/sWgjTZF4/vA/vym7YjjQbQ94/ewBS+1nNL1cn9ltkLWBhAfoleHt1WmqhowjBZa6Rp1iUzWp2+KCkcNMa7tRXtiZk8x6/XGk+EXkCPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIXjBsRFwD8aiFcqlNmrr8MuTjI6tC/t0O3j6SSWkr0=;
 b=Rtz9Zl/g+imkXrCYqDlUBEillhd+BS8HBwYdvG94ZBWOeKZIWi26jdu1ApTt5PSd8/BOAF96Qv/ZxTIuDW+3OQNu25tC+9/Dma+h4uyzYVtqgbMKQUAn3xMk3NbioR1ZtUCFm1iBmVN1wjwvbQQDvVx1ImssL6dkc7+wBDB6SbhpmdGwYyUe7TzLRpIq1ghv0sDiMvld1Kwh3iPQJZlyICFpo6D6Ccn5waOVQQikEi7XjXIklALx/57EI+s89DldSpu/AjiVE6smZrmUvMs4chNciVEAcXWU/WSxahUo8zR8i1oDD3tjGQpbGqrpkjZviNBICi/Y+EIHf8A2W6untg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIXjBsRFwD8aiFcqlNmrr8MuTjI6tC/t0O3j6SSWkr0=;
 b=EUym35ODWcgCP6VWinsGbCPAxRV3zohcSVBqTGkgh+nYJ5h0n6qJOPz0r8m4Y7sUL10O6U/+QM/3nCsr2e08tjjTir2MDvl7TikrLnBHr2LSGiLEtv/Z0HOzKV/IGkFR56kBaEt9MG7KwQYF2ihEXzqnmGm58G7GHx8Cd5qB8wM=
Received: from MW4PR03CA0228.namprd03.prod.outlook.com (2603:10b6:303:b9::23)
 by IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Fri, 7 Apr
 2023 11:26:03 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::14) by MW4PR03CA0228.outlook.office365.com
 (2603:10b6:303:b9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35 via Frontend
 Transport; Fri, 7 Apr 2023 11:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.28 via Frontend Transport; Fri, 7 Apr 2023 11:26:03 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 7 Apr
 2023 06:25:55 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <namhyung@kernel.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@kernel.org>, <eranian@google.com>,
        <kan.liang@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <leo.yan@linaro.org>, <kjain@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v3 6/9] perf mem: Add support for printing PERF_MEM_LVLNUM_UNC
Date:   Fri, 7 Apr 2023 16:54:56 +0530
Message-ID: <20230407112459.548-7-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 905e96db-bfbc-469d-be94-08db375adf4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wMWB//AbCe4zbwKTe6wjoPwc388wwN6JNnSy9TZPGCeQmDHDAYakpUcqr0G9t0+dKgdVunEtuWiNVklEasFwTnJlIwsV7AmftcnDwuIvcsRsV9rpv/2E2Qk1zww4Vd/DrSDJHEVZ2lUXWI2AMyhsZqNPBWAVnIx3ylU0Y1RO+4iayZ1UnGsMVX1597kx+tBF6vXnw2WOTkJwHL48k9udKJjdfBgrumL3UA3QDjwFhGvZZKDXzJc1QQ7cB2zgDaDK5uexQkVA16v/mJpa0OMN5FBXVBGDTY3ueFgir5QgXTZbDV6Ph0iOyrLc/voqCq72x3kZuNHwrgxDi8qhKIyptzbhb+azeWbVbEwUmoo294IiApL4hv+bLqLij7fD47zY/TUFieFAfiHLiRLYMUyL9+fK5ubtW6RRp1OlNbKVqArOfeAgPhIjH7YrGip7+XBkd/6zJEX/tTOUFrL6bj0QJz/kmsGGkr+4LEM6Ul6HZPN5d6ZdK+kvf9RY7S4a374mUQf5RbSYmsNRPqwp7sOaswn6AQSs8+gbNTEhWnxZ/mRLPDAFcPlEYHan8QwvI32U9jNwuuFE006+GaBXIu96yBt5+kCU6fbQEEa/xlCGW9+m9r/ejRRLjaJLEqf7VnHSP/49DYaaRuyM57gOSNWBHeDsx9OoysQqejO6L/2HMygGvaqkc9RrhjG3V1WDKT0jRg5108gPxWm+dfS1yHeitJbWpN6sFNnXpDoiJbaAxkM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(82740400003)(2906002)(44832011)(5660300002)(81166007)(356005)(7416002)(36860700001)(70206006)(4744005)(70586007)(41300700001)(8936002)(8676002)(40460700003)(316002)(82310400005)(4326008)(86362001)(1076003)(26005)(2616005)(47076005)(110136005)(426003)(7696005)(336012)(186003)(40480700001)(478600001)(54906003)(16526019)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 11:26:03.4493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 905e96db-bfbc-469d-be94-08db375adf4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for printing PERF_MEM_LVLNUM_UNC in perf mem report.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/mem-events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index b3a91093069a..3a7c72be8326 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -295,6 +295,7 @@ static const char * const mem_lvl[] = {
 };
 
 static const char * const mem_lvlnum[] = {
+	[PERF_MEM_LVLNUM_UNC] = "Uncached",
 	[PERF_MEM_LVLNUM_CXL] = "CXL",
 	[PERF_MEM_LVLNUM_IO] = "I/O",
 	[PERF_MEM_LVLNUM_ANY_CACHE] = "Any cache",
-- 
2.34.1

