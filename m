Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581105F6AE3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiJFPnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiJFPne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:43:34 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B770C1496;
        Thu,  6 Oct 2022 08:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wx7nX4SwaSeI85kM1SDO3zMjpgU0mh1BdyJkt3FVXxKYbo9T+oK+hLYNBjxz1sQvHHxg4DIh3W3+nwCUy219Vwk/lu5sFGcyyp63re9RmYXlzzlQaTLC6xVipMVcFJcXw1yBlYyL/pR45JID5RBHB+q3kibRLBImElsAJORAbIxqld+G1YrPJkybvvGmVnZ9bVYv82gt6lNssS4Rq4WDhjmEXhmqsnHpfg6hUWnoHG3CQ+6k0PtgXgX3/dqeKbwad6QejM6u0hGdEmSFMGEaDiBsyDbHu0FuqMcrUP348/bMefPEq0kZNp1OEszfkZgikSiV3Bmhv0T7BWZt9fl98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6aJFFjeWm9c2Dov9na4r1H9gHhNI9XdZez3t2qSvGQ=;
 b=Lfg3GiwY61+DvkZIM/VtirAgXB8/o7n0g34ySAX3/o2FIiT9y3YJYhpOUqx/OcdasSdh5fyM33oDKR7vNlYOYfnzpkr3DToE1Uh7xdOXz8Xj3mBO5MaaQ5KbB7rJqs2RaQ6ihDbn01wRChyTRoqScEZpQO7gZb6pLAGBEgFqe89Xq21+fadnCAnUZ28XNMne8hOGM0cCraWuv3vM2GFReR0XqnALPoMIhU4wxTLBZMW/8PpYCB7buVolZ+F2GG6iwRV/wOFn8YaUEl8HiYnGjHEeVec5qKsoRpzbUbCodxIxoLq/uLkZBC6XVBGBidohv5HkCPaI6u+YOA/99W7tIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6aJFFjeWm9c2Dov9na4r1H9gHhNI9XdZez3t2qSvGQ=;
 b=BkOwvYTVrzS2uSmlEzmUSpnOas23rcwAFss/gy+aO8OUoeSy9MnBvm0ap12GMPXUG5Wo+wrmxCYsnxaPLkA8Gkd/edMKCVm3txG04Lc2sDymLWH4hkxlLnRtnS63aGzw6xQsBuD30+cLx81S12OhyDhXdlqgk5ITpL3QhXWmsT0=
Received: from MW4PR04CA0329.namprd04.prod.outlook.com (2603:10b6:303:82::34)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 6 Oct
 2022 15:43:28 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::4f) by MW4PR04CA0329.outlook.office365.com
 (2603:10b6:303:82::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28 via Frontend
 Transport; Thu, 6 Oct 2022 15:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 15:43:27 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 10:43:19 -0500
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
Subject: [PATCH v4 2/8] perf tool: Sync arch/x86/include/asm/amd-ibs.h header
Date:   Thu, 6 Oct 2022 21:09:40 +0530
Message-ID: <20221006153946.7816-3-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d88d869-f7b0-41a1-84e1-08daa7b18307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btcKlduWjXFY/hQqu1hxOueyN2eaHiw9QvGJeLrSaGZKCcZbhGtXmWkNyhpSZMpXeghvc0M+Yin5tIsfXJ+bjVSFlawAP597xGP9yXrzHEVR8WcIPHOjdrO2xKUGjH3fIbmb/CLfESBCM48WYM6yer+N3Z6U5hIdd1TE5TMslKF39h/nYN9OPNTCOHO05c0E4ftQjKyjJUi0BA2K5hheOCazElMy6HuT/T3zr2GtsHxxLaWX7aGeoqTPVIQ6PoLdpG05F2xX9Ucuec0TFmfj4tsNuhua0ugyF9erdA1qfxHxcELmbUirL2H775Q5JK5q5uYRwELG65QchtKKPWl2tKXj6zrWmtJHL4c1nHXHHNbEn6PDCXv777PnLJIk5bLImrmTegAtT3kghN1V9cu017AF7xwB4tkyl3pO+dZi3IN5NaZfHGcU2poYzZ0mK46IQv22sX3IakLFYHmmCccQgz3CJy69/9FNXG/HIBH0VhPqeHgdShFsJzHl/0JxeM1knDZsgdtdK1WVhuVjREkd8qan8jcwTYQO8mvis9kmQE8mDPcfGf+E4ytOon/tK1MgOWwWJGGDIOvDB3m8dH4FHkySZa6yfI7cbqWSXZi8/UBSmqWXXe/vyL0eDcZR3jpk2ZbtNnHzR9oJ4aKko+t+D0PfQ9yjYugVA1iIQRmYSDqDmfYyDYR1fRDWjKhMRAXU7BzaOSDo+av642qVpDHdlD30nF0y1m2Jz4c7/mqNFbftBhX4N8id9xwDrS4o6xd4svAQ+Zumm139XbJsdT8JY7Sa15Sh6lvHeViwfADJw+eC0jEqCtXTcnvCKSfWlTy1
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(26005)(5660300002)(426003)(336012)(2616005)(1076003)(40480700001)(47076005)(86362001)(186003)(36860700001)(7416002)(356005)(82740400003)(40460700003)(44832011)(41300700001)(82310400005)(7696005)(8936002)(6666004)(70206006)(478600001)(16526019)(2906002)(70586007)(8676002)(316002)(36756003)(4326008)(54906003)(110136005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 15:43:27.3829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d88d869-f7b0-41a1-84e1-08daa7b18307
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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
2.37.3

