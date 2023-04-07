Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B026DAC31
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240686AbjDGL0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240667AbjDGL0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:26:08 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38279AF01;
        Fri,  7 Apr 2023 04:25:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xrzde2Jzm2RGHUn1lj4bQiH5KQUcY+MNAWIcvMg/L+Jqk1KGH5LM5NMtIe+K/YnK+Ysny+d6rEr7F5M1pffZ5s0uyEXo9qQa487KYa/uGSKD+TBNmb+RjNGqE5BN8FHRFmYg80dpkKuzj3Na3xLDhksvv825KE9pb7synJp3WOZVVJRPgV656/8OHyxKyM0GYBe6Uszbw5DqGBqXX5LN57q49NzA9yBDbyD6BmGppq0oAEN1vyvnIXdSPHMH7q6NSpyQVjpVbvB+yE8H/7/uqmuwvl3uuhoTMNywlThFojOsTjr9jml0z7uzGFOugD5nR4JWbMb1Cmwosy5gfeemNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+Jm+VL4MdQvWVf8rzC6Ih0i0u3H+9vD1RZUQRz3+4U=;
 b=Q5fNfpStrCdwPXkZkdnC8EuGPh0HH7vJGCKjEubXWr8XiSyOPXVvKIwVP/C05TDsY+Ks3CFPq0QCZKHuExJs5X/FMF6JkK42+AykuRGCNp8Oz+CvdQv7+wVbgCyGM3FvpC8FO3uFhHOLxIto6c11guDKoAYPp48okb4fvGCC7bb5ZPpKrXxRDesi8Ns6aa1oarBb542MpnEyPVqyyz3sBA/nwKOsMG4PaIY0Biv+FcTZKZQ2vuBejVxInP6V5wTQlA6dzpUeK/DawtmlR8PsVmYanlSSxOf1unmJUDglD4VjMlMSaC6siOOXJsyhgRTbOuQ1SF3Qze+3kXp8Go1NoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+Jm+VL4MdQvWVf8rzC6Ih0i0u3H+9vD1RZUQRz3+4U=;
 b=kk4wK/bq5GFII7EsjE+r7ee4Vk+rhmRA2RJyo6oMrWK7PvaMeFU6+RvURReLQhGdi9h0t+8L9EC+iP+ZWyTcoJsVn59RGDgU1vQeH9faQ6BvyoOybnG5UJ411W/85ZEojh7jZcaGDpbRtKq9O9lr1ALoLtqcSNIV5oweCr8tN34=
Received: from MW4PR03CA0273.namprd03.prod.outlook.com (2603:10b6:303:b5::8)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Fri, 7 Apr
 2023 11:25:51 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::76) by MW4PR03CA0273.outlook.office365.com
 (2603:10b6:303:b5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34 via Frontend
 Transport; Fri, 7 Apr 2023 11:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.31 via Frontend Transport; Fri, 7 Apr 2023 11:25:51 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 7 Apr
 2023 06:25:44 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <namhyung@kernel.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@kernel.org>, <eranian@google.com>,
        <kan.liang@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <leo.yan@linaro.org>, <kjain@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v3 4/9] perf headers: Sync uapi/linux/perf_event.h
Date:   Fri, 7 Apr 2023 16:54:54 +0530
Message-ID: <20230407112459.548-5-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a2a19f4-3ef3-4131-77a7-08db375ad7f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pUOi8Ce3F1UXLdl1e6TJci0V7r1Cjfk3F8a5cjkOHAUcrsud+cis6qCojTNhkO6AmJ+Eie+X88iesjBUjits2woUmMmhSErq6Gazq/lWMXFnzMNJIdFubaRxNuewI8XfNmvdN4GyXRyTS+KI2jviYQCCEDUZALz/hNd4EctwjxsClmU8YBcjitOqMCB/7nhDL2HWRTZmHuSaH6CldWs5kuh/777UMUkgNvc7MOVOcLQHzKgadXCjHdLJnSWMWB52Q4UW5qYHXqy6zrBfQisSCPKrj8yDDvLmu1ecL1ExykDAo+Qlif7Hz4CT3rCDvVKvYuviBnPJ45VHosPi2fuOS8fwvUVwJ+XcYQLqHoQOWVhMXwRkkPXgJpbxtML8jd5/gRH173U0M4hRYB8U88znAZI4IQtCMln5arUGHmeMQ+CZFbUIqnj6fJ0AVYEvmgfyqNofHAgdHJp+Uz7HA4XvcXg9Ju+5WXVrJMnN2gMkmWml9gZU8GObuYnm+ZujEhRqBxD7VDfKC/7AhqCUp9vzvmbk2guM1nR/+KHUaZK2Ct3RWWSBqsigzRFGV9AGxtX6EW18Aga2RmPfVoN0oNjEOfY2Yqc1IPXLYGcFANeg1wmAXfWqbHrzaqiYzIJircF5HGh/AyEmZNoYln17hx+jg1Tk+2q3qzEux6UbRNUQWeZBdeD2lMPvXWMiNVFJyf/Mj8uZtYPYvAnNHpPi8mEYcG8PGIF4IBX7/atwuAYZmgA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(40480700001)(36860700001)(83380400001)(26005)(7696005)(2616005)(1076003)(47076005)(16526019)(186003)(6666004)(5660300002)(7416002)(40460700003)(44832011)(4744005)(41300700001)(54906003)(2906002)(356005)(81166007)(82740400003)(8936002)(8676002)(4326008)(70206006)(86362001)(70586007)(426003)(82310400005)(36756003)(316002)(110136005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 11:25:51.0783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2a19f4-3ef3-4131-77a7-08db375ad7f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... to bring PERF_MEM_LVLNUM_UNC definition to userspace

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/include/uapi/linux/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 37675437b768..39c6a250dd1b 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
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

