Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E435ED9AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiI1KBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiI1KAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:00:38 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BCA9E2E5;
        Wed, 28 Sep 2022 03:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQl597kWiKpnUucvEDV4no3DAk1oA/phNy8/YXOpRz4tiR4pDUXSvHXHscmovvp7gFLihBJqvHClxQzxqZXCbjKyX3fro8Nh9Snd4/7njz0dQ8l8dFXeRrz+WCyH/NbW4Pqqdz86NWDh43CJjFAImUdHHxUQfkn5vs6NNrvhbWX2bIgfIHPN5B5QjySsPgcCoj0CsOuexWGl2xMy6f9zXrQOXA86C693u0Jr5GoaJOpp67qwH6g+UKsJtp9ABkXCFJRBDOGBJ6szKapnoVBcU6HqYw5Qya0gKWiZ9m80Rm2bNcM4qpk7viSqm1nBUIRmD6CYHdQlpKh2yUABw2yH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k37lOUvgmPSy1f/5GfcZRZd3syztZFTXSVK6HjuQ8TU=;
 b=i2x7NiLp/yz+o1F69TkjXW79xRxzw95+GkUARLBA5QUrpUgH1szUrEE0sAnARn+Rrl7VWJk0JNdQEK4HYSEnnwwZ8F2d0tk4XAmNEKyIMUTh7fb9lXzY8pxeME2kkaWxz0lLcHiAsedqVttoxrnbIVTLIm2WOzpHjlUyZT0//PRE9ySIoD3OuR99RTWbNGDBkX9kKF+F3f4exV6SqQTGeZ0CugNUrJvi42Pc3k4u/HmLTvbBmjnPp0nmaD6HlE5uFMRbl/gTh11kOaelCZFJX5XfbYHxbIrJJRg0UzOfibnfagSzSxXVc/hVcWswx1JVPnnPZTWk1tK/qCjeqO+zOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k37lOUvgmPSy1f/5GfcZRZd3syztZFTXSVK6HjuQ8TU=;
 b=aMxuf27WE6SL5/pJp7tf9IyOuUS1vh9M3nuYP2IPUUQuktxK/D/houqfmCY2gyHGogA9OvBc+YNl2/HAXu8UoU3qAwaMFqxC1jKyaWo71Y0W3Hv29i7nhYpwPcr3Dc71vu2Us3FS+boULr4bGfYewRIPFRdbAEhynLI63VMG1+U=
Received: from MW4PR04CA0368.namprd04.prod.outlook.com (2603:10b6:303:81::13)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 10:00:30 +0000
Received: from CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::9f) by MW4PR04CA0368.outlook.office365.com
 (2603:10b6:303:81::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 10:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT113.mail.protection.outlook.com (10.13.174.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 10:00:30 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 05:00:21 -0500
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
Subject: [PATCH v3 09/15] perf tool: Sync arch/x86/include/asm/amd-ibs.h header
Date:   Wed, 28 Sep 2022 15:27:59 +0530
Message-ID: <20220928095805.596-10-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT113:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 59156ade-8a5c-4a3d-65d9-08daa13846e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKqtHZQOrwijImMD+SkF9Ds34+0xciJBVsSBwW88OQQdNSPIQuuAUXxYsGnUhWn5JycpzSkBFMsf+KTELwAhduMkLOnaSLIAn+AqBzEYbMthCUF37IPuZFVCFLqG/dzVvJ8O+KZ/8f/WkQqRg9hGaBPCOxWyfT45gFUEv2NqygcsoaLz3r850HZtl08S67vuCZhVz1vXAbfni5bJC3735g+8V5fiMvFEuiyTiCxF3cbmZWPQfOEFMY40dP0uCEbPBY2d2BkPd9me/veGHaiENzUslbUSkrjydoFrRqZ4m5wHAUtYEeO0oSnx1S168u/tGy6h5Vq18IzTbzr+AE34PTTaNjdvoav4JZgeOTvzuqJ3yGJ+ZjVXw/8x4AVB8W7FaIoGQy35LZwukgRtzO0H2TKz9f/DeVXELvtFyjwrgDp6UD4NcifuhSDQ/f6T/O/SMazOjB6JgobaHmoFdBYIp8YplNX4w0jRJfUgbl482JNOmFQ7KOIHF+SnZBSBzVM9qxfyjYe+SgvGAX4WckV1MxdlGMQHI+wM8gmKlK1kIN7NPt/PsXoZu89hHs9wp2qG0SdPWusGqnzPdIvgx5iXeD4DMXFHer9ZILh+HLKV7UZ2PsUOyfGL+YchQkZVZeBqTzxu16MQ3x8W9BL05fPsRFa31KummyxvpZjTTHEXmAqARELcSeBm6aJazKvny2nWZUc/CFWTP8fLpcbw8CrmbnM7EafS7U3G9wlA+0epyWnk12r+OtABe8OahfTG5khmXwqBq3Hbp+JMa9seqGPNtlRdJN4zQu7wd9OXgxLIvz3c4grt9bJ5Zd5Af7cZgvuv
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(86362001)(356005)(36860700001)(36756003)(2906002)(1076003)(5660300002)(16526019)(2616005)(41300700001)(186003)(82310400005)(6666004)(336012)(44832011)(478600001)(40460700003)(40480700001)(7696005)(426003)(47076005)(316002)(7416002)(110136005)(26005)(54906003)(70586007)(4326008)(8676002)(8936002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 10:00:30.4020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59156ade-8a5c-4a3d-65d9-08daa13846e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although new details added into this header is currently used by
kernel only, tools copy needs to be in sync with kernel file.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/arch/x86/include/asm/amd-ibs.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/arch/x86/include/asm/amd-ibs.h b/tools/arch/x86/include/asm/amd-ibs.h
index 9a3312e12e2e..93807b437e4d 100644
--- a/tools/arch/x86/include/asm/amd-ibs.h
+++ b/tools/arch/x86/include/asm/amd-ibs.h
@@ -6,6 +6,22 @@
 
 #include "msr-index.h"
 
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

