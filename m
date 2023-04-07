Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06A16DAC36
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbjDGL1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240118AbjDGL1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:27:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150FC61B0;
        Fri,  7 Apr 2023 04:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RH+svxe74n/y7kKondXAfZq7np3SSWFwAsyf5LMEVeEjbT1VeVDgVKqCWwtdbCgeH2X8qScXD7nG7GULGb2lk/pCxr1Duz+uGsoXNcV65oLx5u28bY0LxxP8ajf6AW/vLuxcWa21Uwq7jyA7bziFNvL/ioJ0dc2/2AJt9Xc7VszkrfdRuq6Ez7uF0nVoP/jW6aVkDxs+m0D2i8vhMevz30ovn3PSz374u461+sb2MmDWQNHLNCCMK4rDkJnxQfI3VQiFvmoBXYXS24ApWheD7cv/nEvA/fiNShIgWmOJp8nMly9TBLFkiJAbuYee0AbHBkKgW8+rbewW0XWHpY4rCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OB9U1d/zkV9tn3HzRN0vhF/uHyfA40rdlvgDdSUhTs=;
 b=N3vH72ijNVnjJ4ivKpps35oxFCvyCZOTb81O0jHao9+NfLuDX2iDAxfb3jc8ZiCAiND/ihSJ4a/prdVEk7WUQ9CKPTLsNAS0ibacnY3T7vCS5OkVxap6ATknXAyVJ5/euUM273saTDbhAVmBvwXbUvJHJU12FRznny6dZBLP9cUY0oE1nYjRX7r2H09oi0lIlwTOopknR7bS7dcQ4QAAVJRjQ1F0oHz75ounC/ooBMTo+X7OOCAonEwrQccmWpwSrPcFWzkzq8dUAhhQL1MnNI+W1LqsOCw3fA4oS3Olp+d+wM1YmAf+u83TSbeWUDQAAXXDjAPtJGbgRA4OfoMo+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OB9U1d/zkV9tn3HzRN0vhF/uHyfA40rdlvgDdSUhTs=;
 b=V2iM4MKPW15MLzrQjvzBwG0uLCG6jv0BZoNPEas9wZ/14PktqhyEHKBrJyu5XLi8SaDGB2SIF1X7CjBKyri4cGDpLO5zX2Pl1f3SGlsrZtyF34QnnJUo81x1OfcJfHyMdgBIRCBFpWCyHta45a4fsi7C63NJCE+oOCRPHZvIPqg=
Received: from MW4PR04CA0154.namprd04.prod.outlook.com (2603:10b6:303:85::9)
 by DM6PR12MB4514.namprd12.prod.outlook.com (2603:10b6:5:2a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Fri, 7 Apr
 2023 11:26:20 +0000
Received: from CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::6a) by MW4PR04CA0154.outlook.office365.com
 (2603:10b6:303:85::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31 via Frontend
 Transport; Fri, 7 Apr 2023 11:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT115.mail.protection.outlook.com (10.13.174.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.19 via Frontend Transport; Fri, 7 Apr 2023 11:26:19 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 7 Apr
 2023 06:26:13 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <namhyung@kernel.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@kernel.org>, <eranian@google.com>,
        <kan.liang@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <leo.yan@linaro.org>, <kjain@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v3 9/9] perf script ibs: Change bit description according to latest PPR
Date:   Fri, 7 Apr 2023 16:54:59 +0530
Message-ID: <20230407112459.548-10-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT115:EE_|DM6PR12MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: 6836474b-08bf-439a-d685-08db375ae8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DT/nd3FyOQR33RoqG2MibU5tDdLeGjV1mKOnNaYHiBztMDCFie00xUN9fvoaRHbT6sPwJnVp8yS5OWLtfoOvQC/TWV3uqr3CNXr080+5zQCe83OhhU8LuoodQYc6RzQX+bWeyuNWL7DAbAQH4ZA8Pj7/D/xMF37JZzyvuQkse0yLtLeUnH08Rh6iKZ4pNHKq03g4++yyFj/oixGRK5JXsyIf2k7gMZdKw6tmx9jDQsStnBFX1yvgPaPNh4qDRog+r6uJUAPNfx+uKbRfD7JAH1fNl3xWCoMkPmdgaUOMBuDUxn3UP7PTXq5jb1YgUnu8yB03sMfSuleWSfk+/BEFBHRJJERjuRfogYI7pF91VmZgnTUZqMD0Ql5U7u8/TAFEhwibaM/nkd8v9Lk0dDru4jRSd6AZ9nVmlGHpYVL+dTA3KFiGEsTVNhUDLxU48v8jBdQWJOsoTjXXlZyBnRvBVY2B+08RLskibJkJiSbvKEf0QmOOeOq+nMmD+uYKyM8Rs4gcAgqkHcqq6boCFyq3oAP71AJxTb9kzyID2NUn0pdTQaH6KZX8bVj1aYznj8326NRaLx9Lp8p6LJIa0Ar1eQxbt+9+DgDkIATzG8EOkTSjsQVeypy5IKYOsjdDzgPnVlT55NGso9gru2XVjxp7gs5SOdwhFM26AHPaUoTW22CqkLeGuMdDP+kNRj1Hum4HX8BOS49YmtRlqKlGlNI5SqABEklHw/V5vUCrkkZAzW8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(426003)(336012)(2616005)(186003)(16526019)(1076003)(83380400001)(26005)(6666004)(2906002)(70586007)(70206006)(54906003)(41300700001)(8676002)(4326008)(316002)(7416002)(5660300002)(478600001)(7696005)(44832011)(40480700001)(8936002)(110136005)(81166007)(356005)(82740400003)(36860700001)(82310400005)(86362001)(36756003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 11:26:19.3424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6836474b-08bf-439a-d685-08db375ae8c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4514
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the IBS_OP_DATA2 bit descriptions were stale (taken from old
version of PPR). Change it according to latest PPR.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/amd-sample-raw.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index b0e70ce9d87a..6a6ddba76c75 100644
--- a/tools/perf/util/amd-sample-raw.c
+++ b/tools/perf/util/amd-sample-raw.c
@@ -105,17 +105,17 @@ static void pr_ibs_op_data2_extended(union ibs_op_data2 reg)
 	static const char * const data_src_str[] = {
 		"",
 		" DataSrc 1=Local L3 or other L1/L2 in CCX",
-		" DataSrc 2=A peer cache in a near CCX",
-		" DataSrc 3=Data returned from DRAM",
+		" DataSrc 2=Another CCX cache in the same NUMA node",
+		" DataSrc 3=DRAM",
 		" DataSrc 4=(reserved)",
-		" DataSrc 5=A peer cache in a far CCX",
-		" DataSrc 6=DRAM address map with \"long latency\" bit set",
-		" DataSrc 7=Data returned from MMIO/Config/PCI/APIC",
-		" DataSrc 8=Extension Memory (S-Link, GenZ, etc)",
+		" DataSrc 5=Another CCX cache in a different NUMA node",
+		" DataSrc 6=Long-latency DIMM",
+		" DataSrc 7=MMIO/Config/PCI/APIC",
+		" DataSrc 8=Extension Memory",
 		" DataSrc 9=(reserved)",
 		" DataSrc 10=(reserved)",
 		" DataSrc 11=(reserved)",
-		" DataSrc 12=Peer Agent Memory",
+		" DataSrc 12=Coherent Memory of a different processor type",
 		/* 13 to 31 are reserved. Avoid printing them. */
 	};
 	int data_src = (reg.data_src_hi << 3) | reg.data_src_lo;
-- 
2.34.1

