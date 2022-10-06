Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EFB5F6AE1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiJFPnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJFPnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:43:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065B77AC0C;
        Thu,  6 Oct 2022 08:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4iI/q7c1zJt11zcozl7R0oUEujIw7qrXAtsX42rGxzy4WgACeEmxP2Bl1lqylZqfBslEXPF3N5mTKzKOrpbh2LWXS/ytIFxseFVwrSiVJ4C0txRjJ9ohad1PpYP2uKN+IgjamnrjEwh40ufACkppBkf48dMpVDIDHnY4tgzbteaKdr1Y8rBHOJf6a9maQj+fjO5NMHRk5RijlZZl6lpnZd4se1kUkSiOGZPqYafe7wDZQaNGCX9FpREX9V8RkHhLvIi9kvUcofU6ZFqCmkI1zhwYQrRh3BePk60eWUqelW9dfFK6cg7L+82ADFcd8q6dgAluYaWyqavQN4FUNntMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIN1+cc+h/QmDXDtRuxtZ3sFhIayWmy2NseIs0teD7Q=;
 b=S/G8DnYDbhpJXam7lQaZoKu71JGWXyacNQKZaJTvSDsSlOsJQZtZDi/f5f001osDyGFIEO75D5/3nV8pnPJvaFWUU8Ecfxc6AW4H5Ow4kApH46cATU5kqizFQnZYLUuy0mbWtpSgJYRekhkyFJXrZhv1cXu/vBxYG7/FEshFNDvgixgMp7G0ILJ3kuB3pl9ZYrR3LUGtYI5p0+5ccnKI+robBiy/4lkERsKKl12iKO3rVkcBQ/6v6dFRV/dB65GEIEFbfAOFK0J8so+DDmdRaTgeStMEZCU6KMvlardeQTxyAkGi0Y3jgrFEez4P4/RLHE1BOG2dvWwkkoC8bPjUTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIN1+cc+h/QmDXDtRuxtZ3sFhIayWmy2NseIs0teD7Q=;
 b=bfVtd6pj67Ua0+Z2D2U88XNOeK4C951Yi/WWxAJ05UDjPFYy9Hx/YGqX2ePypoPx4wKEbrAnUNvQp1WVNaV9etzOVBDVCUjaqqogVBRDFnDs6cJ79cg7czOX/mHPT5DejGUMrhZCQWwn4SK0RRK2PfqEqwSIv86FbV34nxq96Zk=
Received: from MW4PR03CA0317.namprd03.prod.outlook.com (2603:10b6:303:dd::22)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 15:43:20 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::b) by MW4PR03CA0317.outlook.office365.com
 (2603:10b6:303:dd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Thu, 6 Oct 2022 15:43:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 15:43:20 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 10:42:49 -0500
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
Subject: [PATCH v4 1/8] perf tool: Sync include/uapi/linux/perf_event.h header
Date:   Thu, 6 Oct 2022 21:09:39 +0530
Message-ID: <20221006153946.7816-2-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT031:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d636a7-a260-4072-589b-08daa7b17ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QozkZX08zlNH2k/Rt05YP9hbEht+AqX6uUU6SsreKznOZ7cMn4zT8GR7ZRvxbUnf7EEs6ZqVAE6tqRl/0rmu0U2gAP/rQLYPqjVQJ8eZPYZiaw8IB35DPYOWg4B57icspcr0TGizypScillIN4+c7nsHJ7zD9flKQLFtaCeBLEW+U6LB6wr0jkLgJdunXN7u5RLd0mQhqZk6pfBZgteRfuBqfrorsatxDtHtf2Q6otn9OV4XyhUIZiHuFf6AHvT6tzGV2Zv2TVkVCL+WFqS7MKtRbSTUC7KYxhFe7E0INc237CAYdLdTsH5aiSArIrZxmCv2lhmXTtJNpszBZff0vAVa+AYjAR0h9HUomY6FoFqGj1vT51suY759MfeR5nuM6WeVScQrLQSTJq5ITfVIrdTFs1Pf2lMb12Vd39l9IMrmroc3t1xxoeh7YbuVjRwnLImYbGWuhRy68KiBlKNdE3R7+HVief0QiFCXfpI12SCNnVW4l77HFJrxgdE0vLd5VFnUrDHKWxafwLj5eYkFuZ2IdTwVrMFfkGWAGBSRs40xOHKH/PuMOFT3/76YG/zD1/kuqyN7ODyMZQ2KIiDVtTq2n3JqnJ9k+/l8ilNUCuzOFBiCIB+rKSoZnQVI+AvAJN8aWH8NSP9OM2hrboISuwvEbwhOwFex8bQByZkyyOvQxFl9g7/G1MXsC5Bs+xm0YvcVVTqSQqGXlGA0FegCtf0Y/MqgB5LUnXMUj5nxoRgRuXbIX6pM7/b7GHpvbzrL3lPxfSKVrkGFqHcCJM6deReeeL/rVTa8YN+yqRrHFf2vgzlmf8dGa5xedUit+1j1
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(2906002)(7696005)(7416002)(36756003)(26005)(336012)(82740400003)(6666004)(40480700001)(44832011)(86362001)(82310400005)(81166007)(5660300002)(478600001)(40460700003)(8936002)(41300700001)(356005)(47076005)(1076003)(186003)(2616005)(16526019)(36860700001)(83380400001)(426003)(316002)(70206006)(54906003)(110136005)(8676002)(4326008)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 15:43:20.1834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d636a7-a260-4072-589b-08daa7b17ebf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two new fields for mem_lvl_num has been introduced: PERF_MEM_LVLNUM_IO
and PERF_MEM_LVLNUM_CXL which are required to support perf mem/c2c on
AMD platform.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/include/uapi/linux/perf_event.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 49cb2355efc0..ea6defacc1a7 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1327,7 +1327,9 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
 #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
 #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
-/* 5-0xa available */
+/* 5-0x8 available */
+#define PERF_MEM_LVLNUM_CXL	0x09 /* CXL */
+#define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
 #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
 #define PERF_MEM_LVLNUM_LFB	0x0c /* LFB */
 #define PERF_MEM_LVLNUM_RAM	0x0d /* RAM */
-- 
2.37.3

