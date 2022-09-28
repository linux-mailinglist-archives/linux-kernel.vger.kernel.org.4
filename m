Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70AF5ED99E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiI1J7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiI1J71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:59:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDD82BCD;
        Wed, 28 Sep 2022 02:59:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZDllF+yzvDxWaRspw6ZK8mEJ/OFlf9Zl58Jfm9PU5ajjARNEETZv8VbyzVyNBLif1PHpEyIAtMr/dhXEMIaJxi6WyO0W08B6ho+RGs58jnBu1//xKRj+wsa8q9g3BKEpbSiSlxrcayU1VAjarkShmaosull21UsNN9fWDrr8tol2fRMQ2LGoHiUrqbEHRB6CvWHeWIHFFlwlDwCwxxYlmEwG6JbcWYssJ7dp/L06sYVB672UMSkbCEz7Tjp6Cbi073V2F0Nblogq+EbkcqURLDPGiZlH9AWoxVfZ+WmjxNsJ8ZbaFOMOzadqUcTwMK+R5zCh60Q6o0GRWJCB0Az/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DeGxgUBJRpfzVWKCL9N8CnPijMTF8INV82CdAozipw=;
 b=jHx+jM5rBoQt3n9UKM5XBAkjvW8lHXAlhAM+pIsT+S5G/pbXsi0o6agbbC2HTpOknoBulfVKTbwQE37HYJTY0npbtsvZXt61KUEJmbE7eWQKk/fX6H6ZdPBZnFTNBZ4+h1gkiFN8vjtVXhmequVkhkSCogZjLuQGUz8qyDfL1i13PUg3ENQusPZYhSsFVD1ZaMGEfNmmzuqttE2INhC9TyitiFMduQDykj8n4JYRrRHwXnrsiRyiiISRe862MxCvTtM6NQCerxzcMdqiy7yMaUNc/dZQI6/Xmb1DRQrxwySLgw+TAyjgtllCj7IFbjwDs34oJJBRZ6Bf1P/8uodnhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DeGxgUBJRpfzVWKCL9N8CnPijMTF8INV82CdAozipw=;
 b=NC43qsFcci5F+W7CjDUqPl6v2iEf8Sl59tvLE7XP0JbWqW+wY6vvtsB10Sa8z+D8OKkZck/tqoFg5vtzrwjywvaaDTPnHNosWjwIW1O3XX8bbt0/D1FNsZOD4qqS58mCJNX72Q9yXDcxCdgnFQw7CusEehxZv34ql+ltqkLNFsg=
Received: from MW4PR04CA0355.namprd04.prod.outlook.com (2603:10b6:303:8a::30)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 09:59:18 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::b8) by MW4PR04CA0355.outlook.office365.com
 (2603:10b6:303:8a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 09:59:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 09:59:18 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 04:59:08 -0500
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
Subject: [PATCH v3 02/15] perf/x86/amd: Add IBS OP_DATA2 DataSrc bit definitions
Date:   Wed, 28 Sep 2022 15:27:52 +0530
Message-ID: <20220928095805.596-3-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 104c225a-aa9a-4e2e-6847-08daa1381c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oeU7h0dAFyY4bigKHoPfPzTON/X5SrZ51YQZSDZPyIy7PghH2HxtLHz2pyPVYDYHE3kbPup7I0BVuVXN7n75x+DI47cXNEaACe0mxRWeVDwoeFWo16qC6DwygOLyvz8fxTl5/5hkIbLPkeOXaPWmjFPcE6PYyyNnFOl9DD1B5x7KDTHl2DEfC+S/fJzIntoGYmGxMQYPHAF5yQ6eZMVusKCRYnrtqWal1h3Gz1VJrlN+PxHXomhXyXlhTUmwT+/FNVhCASHAWSFSROsKU7zUq+h5hnuHRZ/hc9jT+pPLsWSwUi9nVWDArjbzDYrKm+iLLzedsn54ekKCLBXF6jlngoDJWESYj0jRqkBCZuIiCLgBIKJpl+EoPaKPzKPHJjHnc5R4E6Sm1tL5cpzwb0d+Fm4wamFBdY2Y35dr/z6rmWPOMFfpEq7jgWVZwOoprlAFe8wLGWQNUVA/ZcSiiy6YEoY53IXYnRKpSkTyafBo4MiHpmMz0XwMh5SzwAk2g0fBn9kSLcEeJiflvO1oEzdado7L0nN/ZdA4byA9Jv8a11HMzF4kWV4mEuaPwT2hvJowJuBpvXu2/3rFL4zRdAUKlw7BgxOD+FYewX13Oyv16PXSmON1591NNx+/ivm0F3ojVUYdTQ6wrucIEH9I7M8bOHzFYy+jOI+gCKYNXmLvHOYIBN1JCphi2poJ53B46leF1zY3Kivm7qZ1tl7z6eurGg+qRMAvtgYfG8hVNBEOlyuKyE76ODp2qnRSO1LOC4EzTWu2kLzLboTPRm5eJzYN+GreSE5H+p6cAmaqmFwN9ENm65+tyNQ2E31qC9s7+5MH
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(8676002)(70206006)(4326008)(86362001)(70586007)(16526019)(336012)(7696005)(2906002)(36756003)(316002)(26005)(478600001)(81166007)(2616005)(110136005)(426003)(44832011)(356005)(8936002)(5660300002)(54906003)(7416002)(82310400005)(40460700003)(82740400003)(47076005)(41300700001)(186003)(1076003)(6666004)(40480700001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 09:59:18.5418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 104c225a-aa9a-4e2e-6847-08daa1381c0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS_OP_DATA2 DataSrc provides detail about location of the data
being accessed from by load ops. Define macros for legacy and
extended DataSrc values.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/include/asm/amd-ibs.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
index f3eb098d63d4..cb2a5e113daa 100644
--- a/arch/x86/include/asm/amd-ibs.h
+++ b/arch/x86/include/asm/amd-ibs.h
@@ -6,6 +6,22 @@
 
 #include <asm/msr-index.h>
 
+/* IBS_OP_DATA2 DataSrc */
+#define IBS_DATA_SRC_LOC_CACHE			 2
+#define IBS_DATA_SRC_DRAM			 3
+#define IBS_DATA_SRC_REM_CACHE			 4
+#define IBS_DATA_SRC_IO				 7
+
+/* IBS_OP_DATA2 DataSrc Extension */
+#define IBS_DATA_SRC_EXT_LOC_CACHE		 1
+#define IBS_DATA_SRC_EXT_NEAR_CCX_CACHE		 2
+#define IBS_DATA_SRC_EXT_DRAM			 3
+#define IBS_DATA_SRC_EXT_FAR_CCX_CACHE		 5
+#define IBS_DATA_SRC_EXT_PMEM			 6
+#define IBS_DATA_SRC_EXT_IO			 7
+#define IBS_DATA_SRC_EXT_EXT_MEM		 8
+#define IBS_DATA_SRC_EXT_PEER_AGENT_MEM		12
+
 /*
  * IBS Hardware MSRs
  */
-- 
2.31.1

