Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023146DAC2D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbjDGLZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjDGLZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:25:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2D25FCB;
        Fri,  7 Apr 2023 04:25:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pwcx+o32MZMvswaLqLFm81nDmmrGtfgpMedVFtmQ9oHvb0v9CJVLdvILUKmO0NilJ+ye+Ph31LEkhwOGcDFOlIMqrEG6D1iGfCR+ZoqyP7Z8YQHMqhQjRhYgCV4zmmtt+UxThzq9ZR9nVRYYzNsW/V2zobO+3ByOfgph/KTiWXWRFMlHuR3z47XUXxF010UyDq2vRh0b+t634rLKVpVbE/Gx3foSdjC51CfKE3FJHPXa5vizcmNajs+skjwikCOpBG/oXogZ4tugpjm8JnJ0nU13nJ6BaUIkvUTFji0myQjL0eKL6Vh+7KGEmPQ0y0dCuRaPpTNOmezgVNa7hF6tUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ou1aFKh8fZk1FPFyYv2HMqvSg4tlihDTQ/3AqwI+8c=;
 b=AUOR7+hRUzyt6TMiyx9zShcNG1gwXgpOQg3HCdb2zVSww3ycN1Jn5HF6TkCD2zU7CSH3A59Mrsbjp2T2ctZv7uXElrMrFFwGidLaGpvBS7y0GCp8Cm5LrvB0lOZfvgqEr+d9+IdSVSBdGT6+lSrkLgSvVM7j42drAQRAM/IAT3n5T6rJNO40MTyqnpEQFYVzb1rzxTXLlW+WuVJhiF/2CG7Blyt0BzhUX6XYqScTTR/OOxphRPYuDxhtImTWlyaCdZ/euSgjUjwUCm49neOSSJyZoeQh3Y7k9mvEpfW+b1HkffZLfjXqh1Ltg9x6aMFsnRJFvWhXm+Opcho1BE6WQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ou1aFKh8fZk1FPFyYv2HMqvSg4tlihDTQ/3AqwI+8c=;
 b=d9iVKY5uh20EP02iZaMF7omfjNRp+aiVqju3OATgvbyq13V8DaKzmQxwKjYxDWvv4XWP0j4gXKbepDxw/lEgLA3BoZ09xZc1MXMWFoCJz0M+u6JzjNm/fZbzn1ZaRGfE8K74EzBFh/ZK8XKGfjlPguTDrsv5RagpGkPddTaz6fg=
Received: from BN9PR03CA0550.namprd03.prod.outlook.com (2603:10b6:408:138::15)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Fri, 7 Apr
 2023 11:25:19 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::1b) by BN9PR03CA0550.outlook.office365.com
 (2603:10b6:408:138::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34 via Frontend
 Transport; Fri, 7 Apr 2023 11:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.35 via Frontend Transport; Fri, 7 Apr 2023 11:25:18 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 7 Apr
 2023 06:25:11 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <namhyung@kernel.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@kernel.org>, <eranian@google.com>,
        <kan.liang@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <leo.yan@linaro.org>, <kjain@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v3 0/9] perf/mem: AMD IBS and generic tools improvements
Date:   Fri, 7 Apr 2023 16:54:50 +0530
Message-ID: <20230407112459.548-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT011:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d25cd36-21d8-4728-d06f-08db375ac486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXgErr9/28mLcRvlB26MCRlqq6UCgIXfxxBj08kqgqRprW1vncd9eT0+AP9srZpyZdIxUHC8u/NZ0cIK0XDmg9USGyF4D9zJdoTt+sRAimiPrnH+TYF8ib+cLdAiXfdlrQIHF33sLPn1wtMq5c9anoRM6XQXMYN0/oM1z6BNjY89t/uSjEKo3Rar1ntDzH3UQ6pwIhmAyPSNI7A3UhRt+1q247/QS07UeKtlFCOcoUWiJX//dQxEhgOFpm5oLYI8yuQJzQFTFaqVNZFV7BHgypKI/61BF08bDqesMKTxR3f0Fp9Y18lF/8Kwe2we/XlTpoDr8guzw7H/EddmAQLRbMP8E9wvZAuslJrz50SEELeKGHy+GFLPzH7nH0UT2AVCQUi/07vjII61wAtUr4GOBxM01QBZat+f6xVERlhsgwpltWg0LEwBpz59n2D5KWBLcRPFxHELOtaRW56zz+VfcugKL2Bf8wHpG6w8r7hylpvTdKwbMfQdl1jDYW4pslfBQpovMZsXPbQx53/xwtFTFFvIUJ9akXBs3t/7LGX68LaGEe33Ut9SySrFIUNxUJeBN9IiErJMIqeR3Wdijvh48M7aRiuyQS0PBxH7ZxVSNDg1xaR63ThfWsqG7c2wuB4JcCehY0Q+IjC7NbqpPuRdUsWod4h5KXZBHc4JUjtkx9KHTBc8uM8wnLprSlTf0LnkpoIlbXLCmPK4T0cN3kanUU6M/nsQyNi6RKGG2+8aaEkyJavgkaO8YN+BG7VADBnq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(356005)(7416002)(5660300002)(81166007)(36860700001)(44832011)(336012)(82310400005)(47076005)(426003)(36756003)(83380400001)(316002)(2616005)(86362001)(40460700003)(478600001)(16526019)(7696005)(6666004)(186003)(40480700001)(26005)(966005)(8936002)(82740400003)(54906003)(41300700001)(8676002)(110136005)(1076003)(70206006)(70586007)(4326008)(2906002)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 11:25:18.6186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d25cd36-21d8-4728-d06f-08db375ac486
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel IBS driver wasn't using new PERF_MEM_* APIs due to some of its
limitations. Mainly:

1. mem_lvl_num doesn't allow setting multiple sources whereas old API
   allows it. Setting multiple data sources is useful because IBS on
   pre-zen4 uarch doesn't provide fine granular DataSrc details (there
   is only one such DataSrc(2h) though).
2. perf mem sorting logic (sort__lvl_cmp()) ignores mem_lvl_num. perf
   c2c (c2c_decode_stats()) does not use mem_lvl_num at all. perf mem
   prints mem_lvl and mem_lvl_num both if both are set, which is ugly.

Set mem_lvl_num, mem_remote and mem_hops for data_src via IBS. Handle
first issue using mem_lvl_num = ANY_CACHE | HOPS_0. In addition to
setting new API fields, convert all individual field assignments to
compile time wrapper macros built using PERF_MEM_S(). Also convert
DataSrc conditional code to array lookups.

Interpretation of perf_mem_data_src by perf_mem__lvl_scnprintf() was
non-intuitive. Make it sane.

v2: https://lore.kernel.org/r/20230327130851.1565-1-ravi.bangoria%40amd.com
v2->v3:
  - IBS: Don't club RmtNode with DataSrc=7 (IO)
  - Make perf_mem__lvl_scnprintf() more sane
  - Introduce PERF_MEM_LVLNUM_UNC, set it along with PERF_MEM_LVL_UNC
    and interpreat it in tool.
  - Add PERF_MEM_LVLNUM_NA to default data_src value
  - Change some of the IBS bit description according to latest PPR

Namhyung Kim (1):
  perf/x86/ibs: Set mem_lvl_num, mem_remote and mem_hops for data_src

Ravi Bangoria (8):
  perf/mem: Introduce PERF_MEM_LVLNUM_UNC
  perf/mem: Add PERF_MEM_LVLNUM_NA to PERF_MEM_NA
  perf headers: Sync uapi/linux/perf_event.h
  perf mem: Add PERF_MEM_LVLNUM_NA to PERF_MEM_DATA_SRC_NONE
  perf mem: Add support for printing PERF_MEM_LVLNUM_UNC
  perf mem: Refactor perf_mem__lvl_scnprintf()
  perf mem: Increase HISTC_MEM_LVL column size to 39 chars
  perf script ibs: Change bit description according to latest PPR

 arch/x86/events/amd/ibs.c             | 156 +++++++++++---------------
 include/linux/perf_event.h            |   3 +-
 include/uapi/linux/perf_event.h       |   3 +-
 tools/include/uapi/linux/perf_event.h |   3 +-
 tools/perf/util/amd-sample-raw.c      |  14 +--
 tools/perf/util/event.h               |   3 +-
 tools/perf/util/hist.c                |   2 +-
 tools/perf/util/mem-events.c          |  90 ++++++++-------
 8 files changed, 132 insertions(+), 142 deletions(-)

-- 
2.34.1

