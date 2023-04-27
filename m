Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0386F0E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344286AbjD0Wdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjD0Wdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:33:31 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2104.outbound.protection.outlook.com [40.107.101.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B073A81;
        Thu, 27 Apr 2023 15:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eA3u3U+C0JkwD4tMovOPrBhm/QCZanUtVDQLELnhQ0hnatQdbBlCM6MdjKhr/CK/UGixb6ei0zTofJI32XQY0t2HREv8zPUmP/JYSqcaUh9ybgfKsLvI5RyZ+zo+hWCYuIGauwnxeHmodL9ynAYyU2+NZwuWvlM6Zf/zbo0CKbhsEF67cFooixkHhxho/b4r4JN31BNxM+5tsRwmDSrR0cB3Mm8ydIlMg+LRVh+R7D5WuUF9umtsQvYvP3RM0FgzMijLsF1PeJgskRz1ermWFEEOBB3kqDM6n0EEVMasPMQi35eJomwTGzhEdXurbVv0DAtI8I8lx7bSViYQ07D5hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rakElR9w3RHrRjUKCGkJO56N9mEwNn0OebvRZAJWKy0=;
 b=HltotvIHBsBpZLlLOsJaVSOt/DILQN6ajakyfkYgOpbIbgGeTuVMemtGH8XVS3/whwrLbnaIobehRFu4O8vplfWTDPjs7LvWVKoaOC710Zf23b2LyfFFnZcOOI2ncoeJmhfAV+6FcBQrpPhUK9wmO28wsrZDwd/24lbtpAXuWd8wbQxZhINqevpimSq9Bx94PGDs013zLGZBBQQQRHfUdqDUZJK7aWVs5xATaCN3S7StDzc2Qpe+uWk9tSGsmUwWnqZh5bagfDkmpGKTn57Pa6EB03+BzDidYw15w24gWiMdUJT2pPBQPdJLjRq5Cj8H5PjHLb4VcRLqma8Xx9MnTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rakElR9w3RHrRjUKCGkJO56N9mEwNn0OebvRZAJWKy0=;
 b=PYiAM/aTNfcDvY6Dehy6zLyXFcRHtajXnOv4Mz1Qd/C1RLDTBb+ZNtSOVoYa8+AJZEVY5/ujk+xtLsDiMDyecGqQIb8VRTE3y0UlWexU63rWrpHGkY+GMGN4qPM6sMb8sT33I0ifGObrLNBW0f9nm/2RG4M8Y9feaTnbIwdoaz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BYAPR01MB5239.prod.exchangelabs.com (2603:10b6:a03:8b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20; Thu, 27 Apr 2023 22:33:19 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%6]) with mapi id 15.20.6340.011; Thu, 27 Apr 2023
 22:33:18 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf vendor events arm64: Add AmpereOne core pmu events
Date:   Thu, 27 Apr 2023 15:32:20 -0700
Message-Id: <20230427223220.1068356-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P221CA0041.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::25) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|BYAPR01MB5239:EE_
X-MS-Office365-Filtering-Correlation-Id: 01952496-9260-4d3f-eb09-08db476f661d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hIuPmPFb1ISKdW1YQlkzFqIcWHRaKZPwod8ZXRy4I15j3UEAR2zTgIdABhsLjfaxbwuhcB70phNzxmXW9alL1uug+S/xc+7qzNTQ/PEdwkOCDiZZZsncDmJXPHalUJiv+JKKrauJh5+cdbZNWaJT8nlZVhr83NH2pQOWHoDIUpU7BpLK5Fr9VS8dqK7wc5C9jkytz8UA0o9KxkjHmN5uXPE+qhsoJIs8iXO3Ta+IPMvTISQg09ZjuL529fvN2geGH8H4BtRpWf0oUEbw8zi5hZ3v6GYGNv2VrkiF6d94agVe7c333H4ha9EH1+amUVIs/gjY7gvKicIE6uhVNbRsRVD4adyuBc+He5IicG1WpvZ4SN6Aj0swZFlaIhVPSx/JV1CB8zLCvEPvKKQ8N3BWt571jYS+L8kiNuDK33crlkYqQ1Xb2+uqXI5X19D/wWCmqwVrufpAJQxddsHPsa93LqB/Emz2O8h1xjHaPgl3crVva2UyM3+BC/1TV0GdkUtlGIezSnqtPEDNkIZxTkpZYzviv5/3JsW5Vf3FH/VNV8gg/qIjr/T/DQ4kzc6IoftUNvAbVukx5MU0aZoX43HilE37K+J1bkSbI2UVH4lWK126/SL/MvtoLofem0LlxHW6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39850400004)(451199021)(66476007)(83380400001)(110136005)(52116002)(6486002)(2616005)(478600001)(186003)(6666004)(1076003)(6506007)(26005)(54906003)(6512007)(7416002)(5660300002)(30864003)(8676002)(41300700001)(2906002)(66946007)(38100700002)(66556008)(38350700002)(4326008)(316002)(8936002)(86362001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FZc6rE/HL2SG5/at6YgonPGMAjDrpcCXBlQO77gjf+guCntDFemZe+05egJq?=
 =?us-ascii?Q?QFnoJzXHDuyuYrkpjJBB57oJlOk9H9NnHGbCaUMAXp5wMXj2zJFaygYCOQcu?=
 =?us-ascii?Q?a6Qckyk5Rrq/JNElu6AAOTCDQV5Bud9xXNMCPTqtPFNuhp1ECYxD7pljoztI?=
 =?us-ascii?Q?vlud60gNny1ItiHf+S6Y3zdNSbGYWkkutlunOS1zU6CwkOyQly19pf6Vhn5g?=
 =?us-ascii?Q?5bA8YuK7SEVinRMhaD02sm12d6pNTqhjgJg5xsjlDXryP9x1bXASddPL+L2u?=
 =?us-ascii?Q?gdq5Fw6q4/G+yxD/cRiGCbczCFOvk9PwJZFdiyWhGCqdrTgX/BpNo+NuKu/r?=
 =?us-ascii?Q?euU/+u4LBJLDwut6dzjjtXV1hA32TifqLhHnWf/fon0OrT6j42uvMdk8Yh+S?=
 =?us-ascii?Q?d559QAeHnf4iD2TVnXoKW6tQVPArgso0fadSrx05RWWLg+aT5JmlebBCb47d?=
 =?us-ascii?Q?l/w7PXt0GpAU3WPrzGA06Rta/kK0thN2bEXDyE0eofjNhrfuLQDrmUsiaxZO?=
 =?us-ascii?Q?3/Oy+RjWDLlsl5xTyOcMhMleeed96x2BByCmXqoe0LY1dTp2U0UuS7De4GaU?=
 =?us-ascii?Q?mDAhLC8L4pEagxIquY1aYh5cHuf2hi9Ibb3MIj2NncSEKspLibF70Fx8amt7?=
 =?us-ascii?Q?283Prlecwo+w+mjqb+OanoDn2q2Hv5zQ7cndMxbgzyGICVN+shAP2epp5E5E?=
 =?us-ascii?Q?xxKRefj7xZc1itSIkXc1x2MTiGI3kMYTwsiS9G+7uwQ3GFLx83dB1HX9R0sp?=
 =?us-ascii?Q?KEH55S37afSjhgSqMSO+djNlLE1RhhgniGZ4xI4l11IFn/4wc7c1rHsron6H?=
 =?us-ascii?Q?C9rgc0rval1vaGBMLIJ09omOZFRxAVGU+kxfwQ65ycD8Svi5iHP0QRG7HWnv?=
 =?us-ascii?Q?pTjYAqjufsU1P5w2S/F/iuJAdao1FY9hw3yEOSJltUR4fH+2WtiDrmaTweHY?=
 =?us-ascii?Q?QhmMLg/Mi5ZN9pjh+cVVskBme4210Odcx0wQTNcs5ahrWHAcB/mPk5mRjThP?=
 =?us-ascii?Q?DGYbzGAdzzKpNkHdTsiCmp238+YpBL5EUH962ekiBkrrG02gUhtnWeCJXywB?=
 =?us-ascii?Q?KydtTLuK3ivN4cZz0kCPwydnq9GVD8fyuOEgB+qk/SWed27jbeMd4UEglVOw?=
 =?us-ascii?Q?4TPDOwgcQlwrg3M8+PK06KF5gonM8E1zBk2XP8ydLMtMUq9Yb9l3KJ6YnHtj?=
 =?us-ascii?Q?SWzkhRNRFbRkQS2FwaUVbBLqfe7JmN53NgPjo5f2cXhbcUzb7qdPzSKlcGi+?=
 =?us-ascii?Q?rNBbtZvDzr0QpBqk073ZtfBpOcNKeJtq370hgB7Tbylw8Nx1Y+cUpsl3Kux8?=
 =?us-ascii?Q?S27zanJFJOnUwEaFZ/0pyvJoVVBxmfXLNRbFJhioFjTGAeua3La53ZVlzZBu?=
 =?us-ascii?Q?BrfNpjLlRwVAJP/dowh8UUokv72hP1nA+g6fb8vOF2bSmCeeqfAPk6wEGlt8?=
 =?us-ascii?Q?KFNss7hdxlMkEQ1hf6W1DOUv15S48XXZm0hvgUs6N20QcczKuzYL+gDw9T35?=
 =?us-ascii?Q?FIQcFORKYVl/xe6N7t8DW1NJSC7cZO4CHlLXI0qhGBmZcNvgQQISlKjmAlYA?=
 =?us-ascii?Q?L2QGl1SusxD5wgdFa82ZMGvVCOhQJcBmM2qNJi4gyZ/bGf393qyZSixwqM3y?=
 =?us-ascii?Q?6sPSjypFnfcXZ3LVXboxeyw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01952496-9260-4d3f-eb09-08db476f661d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 22:33:18.6190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPAXuauWFPZK/ZXLfBWgESmF2XbwhTSLGzmaynt6FH1DES5Ff+AvRktBgEvJ4PNR4yP18QLoKRVOgKT2vaMJTQ7Kq+yJFzSRG0xS855eXXbYPWR7OEjiKefWJOwCC5sa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5239
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON files for AmpereOne core PMU events.

Signed-off-by: Doug Rady <dcrady@os.amperecomputing.com>
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../arch/arm64/ampere/ampereone/branch.json   |  17 +
 .../arch/arm64/ampere/ampereone/bus.json      |  32 +
 .../arch/arm64/ampere/ampereone/cache.json    | 104 +++
 .../arm64/ampere/ampereone/core-imp-def.json  | 698 ++++++++++++++++++
 .../arm64/ampere/ampereone/exception.json     |  44 ++
 .../arm64/ampere/ampereone/instruction.json   |  89 +++
 .../arm64/ampere/ampereone/intrinsic.json     |  14 +
 .../arch/arm64/ampere/ampereone/memory.json   |  44 ++
 .../arch/arm64/ampere/ampereone/pipeline.json |  23 +
 .../arch/arm64/ampere/ampereone/spe.json      |  14 +
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 11 files changed, 1080 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/intrinsic.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/spe.json

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/branch.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/branch.json
new file mode 100644
index 000000000000..c751d57f2e19
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/branch.json
@@ -0,0 +1,17 @@
+[
+    {
+        "ArchStdEvent": "BR_IMMED_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_INDIRECT_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_MIS_PRED"
+    },
+    {
+        "ArchStdEvent": "BR_PRED"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/bus.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/bus.json
new file mode 100644
index 000000000000..8623be121818
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/bus.json
@@ -0,0 +1,32 @@
+[
+    {
+        "ArchStdEvent": "CPU_CYCLES"
+    },
+    {
+        "ArchStdEvent": "BUS_CYCLES"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_RD"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_WR"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_SHARED"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_NOT_SHARED"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_NORMAL"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_PERIPH"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS"
+    },
+    {
+        "ArchStdEvent": "CNT_CYCLES"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
new file mode 100644
index 000000000000..fc0633054211
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
@@ -0,0 +1,104 @@
+[
+    {
+        "ArchStdEvent": "L1D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_VICTIM"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_CLEAN"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_INVAL"
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1I_TLB_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB"
+    },
+    {
+        "ArchStdEvent": "L1I_TLB"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL"
+    },
+    {
+        "ArchStdEvent": "L2I_TLB_REFILL"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB"
+    },
+    {
+        "ArchStdEvent": "L2I_TLB"
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK"
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_LMISS_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_LMISS"
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_LMISS"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_LMISS_RD"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
new file mode 100644
index 000000000000..95c30243f2b2
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
@@ -0,0 +1,698 @@
+[
+    {
+        "PublicDescription": "Level 2 prefetch requests, refilled to L2 cache",
+        "EventCode": "0x10A",
+        "EventName": "L2_PREFETCH_REFILL",
+        "BriefDescription": "Level 2 prefetch requests, refilled to L2 cache"
+    },
+    {
+        "PublicDescription": "Level 2 prefetch requests, late",
+        "EventCode": "0x10B",
+        "EventName": "L2_PREFETCH_UPGRADE",
+        "BriefDescription": "Level 2 prefetch requests, late"
+    },
+    {
+        "PublicDescription": "Predictable branch speculatively executed that hit any level of BTB",
+        "EventCode": "0x110",
+        "EventName": "BPU_HIT_BTB",
+        "BriefDescription": "Predictable branch speculatively executed that hit any level of BTB"
+    },
+    {
+        "PublicDescription": "Predictable conditional branch speculatively executed that hit any level of BTB",
+        "EventCode": "0x111",
+        "EventName": "BPU_CONDITIONAL_BRANCH_HIT_BTB",
+        "BriefDescription": "Predictable conditional branch speculatively executed that hit any level of BTB"
+    },
+    {
+        "PublicDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the indirect predictor",
+        "EventCode": "0x112",
+        "EventName": "BPU_HIT_INDIRECT_PREDICTOR",
+        "BriefDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the indirect predictor"
+    },
+    {
+        "PublicDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the return predictor",
+        "EventCode": "0x113",
+        "EventName": "BPU_HIT_RSB",
+        "BriefDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the return predictor"
+    },
+    {
+        "PublicDescription": "Predictable unconditional branch speculatively executed that did not hit any level of BTB",
+        "EventCode": "0x114",
+        "EventName": "BPU_UNCONDITIONAL_BRANCH_MISS_BTB",
+        "BriefDescription": "Predictable unconditional branch speculatively executed that did not hit any level of BTB"
+    },
+    {
+        "PublicDescription": "Predictable branch speculatively executed, unpredicted",
+        "EventCode": "0x115",
+        "EventName": "BPU_BRANCH_NO_HIT",
+        "BriefDescription": "Predictable branch speculatively executed, unpredicted"
+    },
+    {
+        "PublicDescription": "Predictable branch speculatively executed that hit any level of BTB that mispredict",
+        "EventCode": "0x116",
+        "EventName": "BPU_HIT_BTB_AND_MISPREDICT",
+        "BriefDescription": "Predictable branch speculatively executed that hit any level of BTB that mispredict"
+    },
+    {
+        "PublicDescription": "Predictable conditional branch speculatively executed that hit any level of BTB that (direction) mispredict",
+        "EventCode": "0x117",
+        "EventName": "BPU_CONDITIONAL_BRANCH_HIT_BTB_AND_MISPREDICT",
+        "BriefDescription": "Predictable conditional branch speculatively executed that hit any level of BTB that (direction) mispredict"
+    },
+    {
+        "PublicDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the indirect predictor that mispredict",
+        "EventCode": "0x118",
+        "EventName": "BPU_INDIRECT_BRANCH_HIT_BTB_AND_MISPREDICT",
+        "BriefDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the indirect predictor that mispredict"
+    },
+    {
+        "PublicDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the return predictor that mispredict",
+        "EventCode": "0x119",
+        "EventName": "BPU_HIT_RSB_AND_MISPREDICT",
+        "BriefDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the return predictor that mispredict"
+    },
+    {
+        "PublicDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the overflow/underflow return predictor that mispredict",
+        "EventCode": "0x11a",
+        "EventName": "BPU_MISS_RSB_AND_MISPREDICT",
+        "BriefDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the overflow/underflow return predictor that mispredict"
+    },
+    {
+        "PublicDescription": "Predictable branch speculatively executed, unpredicted, that mispredict",
+        "EventCode": "0x11b",
+        "EventName": "BPU_NO_PREDICTION_MISPREDICT",
+        "BriefDescription": "Predictable branch speculatively executed, unpredicted, that mispredict"
+    },
+    {
+        "PublicDescription": "Predictable branch speculatively executed, unpredicted, that mispredict",
+        "EventCode": "0x11c",
+        "EventName": "BPU_BTB_UPDATE",
+        "BriefDescription": "Predictable branch speculatively executed, unpredicted, that mispredict"
+    },
+    {
+        "PublicDescription": "Count predict pipe stalls due to speculative return address predictor full",
+        "EventCode": "0x11d",
+        "EventName": "BPU_RSB_FULL_STALL",
+        "BriefDescription": "Count predict pipe stalls due to speculative return address predictor full"
+    },
+    {
+        "PublicDescription": "Macro-ops speculatively decoded",
+        "EventCode": "0x11f",
+        "EventName": "ICF_INST_SPEC_DECODE",
+        "BriefDescription": "Macro-ops speculatively decoded"
+    },
+    {
+        "PublicDescription": "Flushes",
+        "EventCode": "0x120",
+        "EventName": "GPC_FLUSH",
+        "BriefDescription": "Flushes"
+    },
+    {
+        "PublicDescription": "Flushes due to memory hazards",
+        "EventCode": "0x121",
+        "EventName": "BPU_FLUSH_MEM_FAULT",
+        "BriefDescription": "Flushes due to memory hazards"
+    },
+    {
+        "PublicDescription": "ETM extout bit 0",
+        "EventCode": "0x141",
+        "EventName": "MSC_ETM_EXTOUT0",
+        "BriefDescription": "ETM extout bit 0"
+    },
+    {
+        "PublicDescription": "ETM extout bit 1",
+        "EventCode": "0x142",
+        "EventName": "MSC_ETM_EXTOUT1",
+        "BriefDescription": "ETM extout bit 1"
+    },
+    {
+        "PublicDescription": "ETM extout bit 2",
+        "EventCode": "0x143",
+        "EventName": "MSC_ETM_EXTOUT2",
+        "BriefDescription": "ETM extout bit 2"
+    },
+    {
+        "PublicDescription": "ETM extout bit 3",
+        "EventCode": "0x144",
+        "EventName": "MSC_ETM_EXTOUT3",
+        "BriefDescription": "ETM extout bit 3"
+    },
+    {
+        "PublicDescription": "Bus request sn",
+        "EventCode": "0x156",
+        "EventName": "L2C_SNOOP",
+        "BriefDescription": "Bus request sn"
+    },
+    {
+        "PublicDescription": "L2 TXDAT LCRD blocked",
+        "EventCode": "0x169",
+        "EventName": "L2C_DAT_CRD_STALL",
+        "BriefDescription": "L2 TXDAT LCRD blocked"
+    },
+    {
+        "PublicDescription": "L2 TXRSP LCRD blocked",
+        "EventCode": "0x16a",
+        "EventName": "L2C_RSP_CRD_STALL",
+        "BriefDescription": "L2 TXRSP LCRD blocked"
+    },
+    {
+        "PublicDescription": "L2 TXREQ LCRD blocked",
+        "EventCode": "0x16b",
+        "EventName": "L2C_REQ_CRD_STALL",
+        "BriefDescription": "L2 TXREQ LCRD blocked"
+    },
+    {
+        "PublicDescription": "Early mispredict",
+        "EventCode": "0xD100",
+        "EventName": "ICF_EARLY_MIS_PRED",
+        "BriefDescription": "Early mispredict"
+    },
+    {
+        "PublicDescription": "FEQ full cycles",
+        "EventCode": "0xD101",
+        "EventName": "ICF_FEQ_FULL",
+        "BriefDescription": "FEQ full cycles"
+    },
+    {
+        "PublicDescription": "Instruction FIFO Full",
+        "EventCode": "0xD102",
+        "EventName": "ICF_INST_FIFO_FULL",
+        "BriefDescription": "Instruction FIFO Full"
+    },
+    {
+        "PublicDescription": "L1I TLB miss",
+        "EventCode": "0xD103",
+        "EventName": "L1I_TLB_MISS",
+        "BriefDescription": "L1I TLB miss"
+    },
+    {
+        "PublicDescription": "ICF sent 0 instructions to IDR this cycle",
+        "EventCode": "0xD104",
+        "EventName": "ICF_STALL",
+        "BriefDescription": "ICF sent 0 instructions to IDR this cycle"
+    },
+    {
+        "PublicDescription": "PC FIFO Full",
+        "EventCode": "0xD105",
+        "EventName": "ICF_PC_FIFO_FULL",
+        "BriefDescription": "PC FIFO Full"
+    },
+    {
+        "PublicDescription": "Stall due to BOB ID",
+        "EventCode": "0xD200",
+        "EventName": "IDR_STALL_BOB_ID",
+        "BriefDescription": "Stall due to BOB ID"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to LOB entries",
+        "EventCode": "0xD201",
+        "EventName": "IDR_STALL_LOB_ID",
+        "BriefDescription": "Dispatch stall due to LOB entries"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to SOB entries",
+        "EventCode": "0xD202",
+        "EventName": "IDR_STALL_SOB_ID",
+        "BriefDescription": "Dispatch stall due to SOB entries"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to IXU scheduler entries",
+        "EventCode": "0xD203",
+        "EventName": "IDR_STALL_IXU_SCHED",
+        "BriefDescription": "Dispatch stall due to IXU scheduler entries"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to FSU scheduler entries",
+        "EventCode": "0xD204",
+        "EventName": "IDR_STALL_FSU_SCHED",
+        "BriefDescription": "Dispatch stall due to FSU scheduler entries"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to ROB entries",
+        "EventCode": "0xD205",
+        "EventName": "IDR_STALL_ROB_ID",
+        "BriefDescription": "Dispatch stall due to ROB entries"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to flush (6 cycles)",
+        "EventCode": "0xD206",
+        "EventName": "IDR_STALL_FLUSH",
+        "BriefDescription": "Dispatch stall due to flush (6 cycles)"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to WFI",
+        "EventCode": "0xD207",
+        "EventName": "IDR_STALL_WFI",
+        "BriefDescription": "Dispatch stall due to WFI"
+    },
+    {
+        "PublicDescription": "Number of SWOB drains triggered by timeout",
+        "EventCode": "0xD208",
+        "EventName": "IDR_STALL_SWOB_TIMEOUT",
+        "BriefDescription": "Number of SWOB drains triggered by timeout"
+    },
+    {
+        "PublicDescription": "Number of SWOB drains triggered by system register or special-purpose register read-after-write or specific special-purpose register writes that cause SWOB drain",
+        "EventCode": "0xD209",
+        "EventName": "IDR_STALL_SWOB_RAW",
+        "BriefDescription": "Number of SWOB drains triggered by system register or special-purpose register read-after-write or specific special-purpose register writes that cause SWOB drain"
+    },
+    {
+        "PublicDescription": "Number of SWOB drains triggered by system register write when SWOB full",
+        "EventCode": "0xD20A",
+        "EventName": "IDR_STALL_SWOB_FULL",
+        "BriefDescription": "Number of SWOB drains triggered by system register write when SWOB full"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to L1 instruction cache miss",
+        "EventCode": "0xD20B",
+        "EventName": "STALL_FRONTEND_CACHE",
+        "BriefDescription": "Dispatch stall due to L1 instruction cache miss"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to L1 instruction TLB miss",
+        "EventCode": "0xD20C",
+        "EventName": "STALL_FRONTEND_TLB",
+        "BriefDescription": "Dispatch stall due to L1 instruction TLB miss"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to L1 data cache miss",
+        "EventCode": "0xD20D",
+        "EventName": "STALL_BACKEND_CACHE",
+        "BriefDescription": "Dispatch stall due to L1 data cache miss"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to L1 data TLB miss",
+        "EventCode": "0xD20E",
+        "EventName": "STALL_BACKEND_TLB",
+        "BriefDescription": "Dispatch stall due to L1 data TLB miss"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to lack of any core resource",
+        "EventCode": "0xD20F",
+        "EventName": "STALL_BACKEND_RESOURCE",
+        "BriefDescription": "Dispatch stall due to lack of any core resource"
+    },
+    {
+        "PublicDescription": "Instructions issued by the scheduler",
+        "EventCode": "0xD300",
+        "EventName": "IXU_NUM_UOPS_ISSUED",
+        "BriefDescription": "Instructions issued by the scheduler"
+    },
+    {
+        "PublicDescription": "Any uop issued was canceled for any reason",
+        "EventCode": "0xD301",
+        "EventName": "IXU_ISSUE_CANCEL",
+        "BriefDescription": "Any uop issued was canceled for any reason"
+    },
+    {
+        "PublicDescription": "A load wakeup to the scheduler has been cancelled",
+        "EventCode": "0xD302",
+        "EventName": "IXU_LOAD_CANCEL",
+        "BriefDescription": "A load wakeup to the scheduler has been cancelled"
+    },
+    {
+        "PublicDescription": "The scheduler had to cancel one slow Uop due to resource conflict",
+        "EventCode": "0xD303",
+        "EventName": "IXU_SLOW_CANCEL",
+        "BriefDescription": "The scheduler had to cancel one slow Uop due to resource conflict"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXA",
+        "EventCode": "0xD304",
+        "EventName": "IXU_IXA_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXA"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXA Par 0",
+        "EventCode": "0xD305",
+        "EventName": "IXU_IXA_PAR0_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXA Par 0"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXA Par 1",
+        "EventCode": "0xD306",
+        "EventName": "IXU_IXA_PAR1_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXA Par 1"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXB",
+        "EventCode": "0xD307",
+        "EventName": "IXU_IXB_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXB"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXB Par 0",
+        "EventCode": "0xD308",
+        "EventName": "IXU_IXB_PAR0_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXB Par 0"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXB Par 1",
+        "EventCode": "0xD309",
+        "EventName": "IXU_IXB_PAR1_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXB Par 1"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXC",
+        "EventCode": "0xD30A",
+        "EventName": "IXU_IXC_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXC"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXC Par 0",
+        "EventCode": "0xD30B",
+        "EventName": "IXU_IXC_PAR0_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXC Par 0"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXC Par 1",
+        "EventCode": "0xD30C",
+        "EventName": "IXU_IXC_PAR1_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXC Par 1"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXD",
+        "EventCode": "0xD30D",
+        "EventName": "IXU_IXD_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXD"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXD Par 0",
+        "EventCode": "0xD30E",
+        "EventName": "IXU_IXD_PAR0_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXD Par 0"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXD Par 1",
+        "EventCode": "0xD30F",
+        "EventName": "IXU_IXD_PAR1_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXD Par 1"
+    },
+    {
+        "PublicDescription": "Uops issued by the FSU scheduler",
+        "EventCode": "0xD400",
+        "EventName": "FSU_ISSUED",
+        "BriefDescription": "Uops issued by the FSU scheduler"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on pipe X",
+        "EventCode": "0xD401",
+        "EventName": "FSU_FSX_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on pipe X"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on pipe Y",
+        "EventCode": "0xD402",
+        "EventName": "FSU_FSY_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on pipe Y"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on pipe Z",
+        "EventCode": "0xD403",
+        "EventName": "FSU_FSZ_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on pipe Z"
+    },
+    {
+        "PublicDescription": "Uops canceled (load cancels)",
+        "EventCode": "0xD404",
+        "EventName": "FSU_CANCEL",
+        "BriefDescription": "Uops canceled (load cancels)"
+    },
+    {
+        "PublicDescription": "Count scheduler stalls due to divide/sqrt",
+        "EventCode": "0xD405",
+        "EventName": "FSU_DIV_SQRT_STALL",
+        "BriefDescription": "Count scheduler stalls due to divide/sqrt"
+    },
+    {
+        "PublicDescription": "Number of SWOB drains",
+        "EventCode": "0xD500",
+        "EventName": "GPC_SWOB_DRAIN",
+        "BriefDescription": "Number of SWOB drains"
+    },
+    {
+        "PublicDescription": "GPC detected a Breakpoint instruction match",
+        "EventCode": "0xD501",
+        "EventName": "BREAKPOINT_MATCH",
+        "BriefDescription": "GPC detected a Breakpoint instruction match"
+    },
+    {
+        "PublicDescription": "L1D TLB miss",
+        "EventCode": "0xD600",
+        "EventName": "L1D_TLB_MISS",
+        "BriefDescription": "L1D TLB miss"
+    },
+    {
+        "PublicDescription": "OFB full cycles",
+        "EventCode": "0xD601",
+        "EventName": "OFB_FULL",
+        "BriefDescription": "OFB full cycles"
+    },
+    {
+        "PublicDescription": "Load satisified from store forwarded data",
+        "EventCode": "0xD605",
+        "EventName": "LD_FROM_ST_FWD",
+        "BriefDescription": "Load satisified from store forwarded data"
+    },
+    {
+        "PublicDescription": "L1 prefetcher, load prefetch requests generated",
+        "EventCode": "0xD606",
+        "EventName": "L1_PFETCH_LD_GEN",
+        "BriefDescription": "L1 prefetcher, load prefetch requests generated"
+    },
+    {
+        "PublicDescription": "L1 prefetcher, load prefetch fills into the L1 cache",
+        "EventCode": "0xD607",
+        "EventName": "L1_PFETCH_LD_FILL",
+        "BriefDescription": "L1 prefetcher, load prefetch fills into the L1 cache"
+    },
+    {
+        "PublicDescription": "L1 prefetcher, load prefetch to L2 generated",
+        "EventCode": "0xD608",
+        "EventName": "L1_PFETCH_L2_REQ",
+        "BriefDescription": "L1 prefetcher, load prefetch to L2 generated"
+    },
+    {
+        "PublicDescription": "L1 prefetcher, distance was reset",
+        "EventCode": "0xD609",
+        "EventName": "L1_PFETCH_DIST_RST",
+        "BriefDescription": "L1 prefetcher, distance was reset"
+    },
+    {
+        "PublicDescription": "L1 prefetcher, distance was increased",
+        "EventCode": "0xD60A",
+        "EventName": "L1_PFETCH_DIST_INC",
+        "BriefDescription": "L1 prefetcher, distance was increased"
+    },
+    {
+        "PublicDescription": "L1 prefetcher, table entry is trained",
+        "EventCode": "0xD60B",
+        "EventName": "L1_PFETCH_ENTRY_TRAINED",
+        "BriefDescription": "L1 prefetcher, table entry is trained"
+    },
+    {
+        "PublicDescription": "Store retirement pipe stall",
+        "EventCode": "0xD60C",
+        "EventName": "LSU_ST_RETIRE_STALL",
+        "BriefDescription": "Store retirement pipe stall"
+    },
+    {
+        "PublicDescription": "LSU detected a Watchpoint data match",
+        "EventCode": "0xD60D",
+        "EventName": "WATCHPOINT_MATCH",
+        "BriefDescription": "LSU detected a Watchpoint data match"
+    },
+    {
+        "PublicDescription": "L2 pipeline replay",
+        "EventCode": "0xD700",
+        "EventName": "L2C_PIPE_REPLAY",
+        "BriefDescription": "L2 pipeline replay"
+    },
+    {
+        "PublicDescription": "L2 refill from I-side miss",
+        "EventCode": "0xD701",
+        "EventName": "L2C_INST_REFILL",
+        "BriefDescription": "L2 refill from I-side miss"
+    },
+    {
+        "PublicDescription": "L2 refill from D-side miss",
+        "EventCode": "0xD702",
+        "EventName": "L2C_DATA_REFILL",
+        "BriefDescription": "L2 refill from D-side miss"
+    },
+    {
+        "PublicDescription": "L2 prefetcher, load prefetch requests generated",
+        "EventCode": "0xD703",
+        "EventName": "L2_PREFETCH_REQ",
+        "BriefDescription": "L2 prefetcher, load prefetch requests generated"
+    },
+    {
+        "PublicDescription": "L2D OTB allocate",
+        "EventCode": "0xD800",
+        "EventName": "MMU_D_OTB_ALLOC",
+        "BriefDescription": "L2D OTB allocate"
+    },
+    {
+        "PublicDescription": "DTLB Translation cache hit on S1L2 walk cache entry",
+        "EventCode": "0xD801",
+        "EventName": "MMU_D_TRANS_CACHE_HIT_S1L2_WALK",
+        "BriefDescription": "DTLB Translation cache hit on S1L2 walk cache entry"
+    },
+    {
+        "PublicDescription": "DTLB Translation cache hit on S1L1 walk cache entry",
+        "EventCode": "0xD802",
+        "EventName": "MMU_D_TRANS_CACHE_HIT_S1L1_WALK",
+        "BriefDescription": "DTLB Translation cache hit on S1L1 walk cache entry"
+    },
+    {
+        "PublicDescription": "DTLB Translation cache hit on S1L0 walk cache entry",
+        "EventCode": "0xD803",
+        "EventName": "MMU_D_TRANS_CACHE_HIT_S1L0_WALK",
+        "BriefDescription": "DTLB Translation cache hit on S1L0 walk cache entry"
+    },
+    {
+        "PublicDescription": "DTLB Translation cache hit on S2L2 walk cache entry",
+        "EventCode": "0xD804",
+        "EventName": "MMU_D_TRANS_CACHE_HIT_S2L2_WALK",
+        "BriefDescription": "DTLB Translation cache hit on S2L2 walk cache entry"
+    },
+    {
+        "PublicDescription": "DTLB Translation cache hit on S2L1 walk cache entry",
+        "EventCode": "0xD805",
+        "EventName": "MMU_D_TRANS_CACHE_HIT_S2L1_WALK",
+        "BriefDescription": "DTLB Translation cache hit on S2L1 walk cache entry"
+    },
+    {
+        "PublicDescription": "DTLB Translation cache hit on S2L0 walk cache entry",
+        "EventCode": "0xD806",
+        "EventName": "MMU_D_TRANS_CACHE_HIT_S2L0_WALK",
+        "BriefDescription": "DTLB Translation cache hit on S2L0 walk cache entry"
+    },
+    {
+        "PublicDescription": "D-side S1 Page walk cache lookup",
+        "EventCode": "0xD807",
+        "EventName": "MMU_D_S1_WALK_CACHE_LOOKUP",
+        "BriefDescription": "D-side S1 Page walk cache lookup"
+    },
+    {
+        "PublicDescription": "D-side S1 Page walk cache refill",
+        "EventCode": "0xD808",
+        "EventName": "MMU_D_S1_WALK_CACHE_REFILL",
+        "BriefDescription": "D-side S1 Page walk cache refill"
+    },
+    {
+        "PublicDescription": "D-side S2 Page walk cache lookup",
+        "EventCode": "0xD809",
+        "EventName": "MMU_D_S2_WALK_CACHE_LOOKUP",
+        "BriefDescription": "D-side S2 Page walk cache lookup"
+    },
+    {
+        "PublicDescription": "D-side S2 Page walk cache refill",
+        "EventCode": "0xD80A",
+        "EventName": "MMU_D_S2_WALK_CACHE_REFILL",
+        "BriefDescription": "D-side S2 Page walk cache refill"
+    },
+    {
+        "PublicDescription": "D-side Stage1 tablewalk fault",
+        "EventCode": "0xD80B",
+        "EventName": "MMU_D_S1_WALK_FAULT",
+        "BriefDescription": "D-side Stage1 tablewalk fault"
+    },
+    {
+        "PublicDescription": "D-side Stage2 tablewalk fault",
+        "EventCode": "0xD80C",
+        "EventName": "MMU_D_S2_WALK_FAULT",
+        "BriefDescription": "D-side Stage2 tablewalk fault"
+    },
+    {
+        "PublicDescription": "D-side Tablewalk steps or descriptor fetches",
+        "EventCode": "0xD80D",
+        "EventName": "MMU_D_WALK_STEPS",
+        "BriefDescription": "D-side Tablewalk steps or descriptor fetches"
+    },
+    {
+        "PublicDescription": "L2I OTB allocate",
+        "EventCode": "0xD900",
+        "EventName": "MMU_I_OTB_ALLOC",
+        "BriefDescription": "L2I OTB allocate"
+    },
+    {
+        "PublicDescription": "ITLB Translation cache hit on S1L2 walk cache entry",
+        "EventCode": "0xD901",
+        "EventName": "MMU_I_TRANS_CACHE_HIT_S1L2_WALK",
+        "BriefDescription": "ITLB Translation cache hit on S1L2 walk cache entry"
+    },
+    {
+        "PublicDescription": "ITLB Translation cache hit on S1L1 walk cache entry",
+        "EventCode": "0xD902",
+        "EventName": "MMU_I_TRANS_CACHE_HIT_S1L1_WALK",
+        "BriefDescription": "ITLB Translation cache hit on S1L1 walk cache entry"
+    },
+    {
+        "PublicDescription": "ITLB Translation cache hit on S1L0 walk cache entry",
+        "EventCode": "0xD903",
+        "EventName": "MMU_I_TRANS_CACHE_HIT_S1L0_WALK",
+        "BriefDescription": "ITLB Translation cache hit on S1L0 walk cache entry"
+    },
+    {
+        "PublicDescription": "ITLB Translation cache hit on S2L2 walk cache entry",
+        "EventCode": "0xD904",
+        "EventName": "MMU_I_TRANS_CACHE_HIT_S2L2_WALK",
+        "BriefDescription": "ITLB Translation cache hit on S2L2 walk cache entry"
+    },
+    {
+        "PublicDescription": "ITLB Translation cache hit on S2L1 walk cache entry",
+        "EventCode": "0xD905",
+        "EventName": "MMU_I_TRANS_CACHE_HIT_S2L1_WALK",
+        "BriefDescription": "ITLB Translation cache hit on S2L1 walk cache entry"
+    },
+    {
+        "PublicDescription": "ITLB Translation cache hit on S2L0 walk cache entry",
+        "EventCode": "0xD906",
+        "EventName": "MMU_I_TRANS_CACHE_HIT_S2L0_WALK",
+        "BriefDescription": "ITLB Translation cache hit on S2L0 walk cache entry"
+    },
+    {
+        "PublicDescription": "I-side S1 Page walk cache lookup",
+        "EventCode": "0xD907",
+        "EventName": "MMU_I_S1_WALK_CACHE_LOOKUP",
+        "BriefDescription": "I-side S1 Page walk cache lookup"
+    },
+    {
+        "PublicDescription": "I-side S1 Page walk cache refill",
+        "EventCode": "0xD908",
+        "EventName": "MMU_I_S1_WALK_CACHE_REFILL",
+        "BriefDescription": "I-side S1 Page walk cache refill"
+    },
+    {
+        "PublicDescription": "I-side S2 Page walk cache lookup",
+        "EventCode": "0xD909",
+        "EventName": "MMU_I_S2_WALK_CACHE_LOOKUP",
+        "BriefDescription": "I-side S2 Page walk cache lookup"
+    },
+    {
+        "PublicDescription": "I-side S2 Page walk cache refill",
+        "EventCode": "0xD90A",
+        "EventName": "MMU_I_S2_WALK_CACHE_REFILL",
+        "BriefDescription": "I-side S2 Page walk cache refill"
+    },
+    {
+        "PublicDescription": "I-side Stage1 tablewalk fault",
+        "EventCode": "0xD90B",
+        "EventName": "MMU_I_S1_WALK_FAULT",
+        "BriefDescription": "I-side Stage1 tablewalk fault"
+    },
+    {
+        "PublicDescription": "I-side Stage2 tablewalk fault",
+        "EventCode": "0xD90C",
+        "EventName": "MMU_I_S2_WALK_FAULT",
+        "BriefDescription": "I-side Stage2 tablewalk fault"
+    },
+    {
+        "PublicDescription": "I-side Tablewalk steps or descriptor fetches",
+        "EventCode": "0xD90D",
+        "EventName": "MMU_I_WALK_STEPS",
+        "BriefDescription": "I-side Tablewalk steps or descriptor fetches"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/exception.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/exception.json
new file mode 100644
index 000000000000..ada052e19632
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/exception.json
@@ -0,0 +1,44 @@
+[
+    {
+        "ArchStdEvent": "EXC_UNDEF"
+    },
+    {
+        "ArchStdEvent": "EXC_SVC"
+    },
+    {
+        "ArchStdEvent": "EXC_PABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_DABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ"
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ"
+    },
+    {
+        "ArchStdEvent": "EXC_HVC"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_PABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_DABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_OTHER"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_IRQ"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_FIQ"
+    },
+    {
+        "ArchStdEvent": "EXC_TAKEN"
+    },
+    {
+        "ArchStdEvent": "EXC_RETURN"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/instruction.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/instruction.json
new file mode 100644
index 000000000000..18d1f2f76a23
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/instruction.json
@@ -0,0 +1,89 @@
+[
+    {
+        "ArchStdEvent": "SW_INCR"
+    },
+    {
+        "ArchStdEvent": "ST_RETIRED"
+    },
+    {
+        "ArchStdEvent": "OP_SPEC"
+    },
+    {
+        "ArchStdEvent": "LD_SPEC"
+    },
+    {
+        "ArchStdEvent": "ST_SPEC"
+    },
+    {
+        "ArchStdEvent": "LDST_SPEC"
+    },
+    {
+        "ArchStdEvent": "DP_SPEC"
+    },
+    {
+        "ArchStdEvent": "ASE_SPEC"
+    },
+    {
+        "ArchStdEvent": "VFP_SPEC"
+    },
+    {
+        "ArchStdEvent": "PC_WRITE_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_RETIRED"
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_RETIRED"
+    },
+    {
+        "ArchStdEvent": "CRYPTO_SPEC"
+    },
+    {
+        "ArchStdEvent": "ISB_SPEC"
+    },
+    {
+        "ArchStdEvent": "DSB_SPEC"
+    },
+    {
+        "ArchStdEvent": "DMB_SPEC"
+    },
+    {
+        "ArchStdEvent": "RC_LD_SPEC"
+    },
+    {
+        "ArchStdEvent": "RC_ST_SPEC"
+    },
+    {
+        "ArchStdEvent": "INST_RETIRED"
+    },
+    {
+        "ArchStdEvent": "CID_WRITE_RETIRED"
+    },
+    {
+        "ArchStdEvent": "PC_WRITE_RETIRED"
+    },
+    {
+        "ArchStdEvent": "INST_SPEC"
+    },
+    {
+        "ArchStdEvent": "TTBR_WRITE_RETIRED"
+    },
+    {
+        "ArchStdEvent": "BR_RETIRED"
+    },
+    {
+        "ArchStdEvent": "BR_MIS_PRED_RETIRED"
+    },
+    {
+        "ArchStdEvent": "OP_RETIRED"
+    },
+    {
+        "ArchStdEvent": "OP_SPEC"
+    },
+    {
+        "PublicDescription": "Operation speculatively executed, NOP",
+        "EventCode": "0x100",
+        "EventName": "NOP_SPEC",
+        "BriefDescription": "Speculatively executed, NOP"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/intrinsic.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/intrinsic.json
new file mode 100644
index 000000000000..7ecffb989ae0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/intrinsic.json
@@ -0,0 +1,14 @@
+[
+    {
+        "ArchStdEvent": "LDREX_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_PASS_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_FAIL_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json
new file mode 100644
index 000000000000..0711782bfa6b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json
@@ -0,0 +1,44 @@
+[
+    {
+        "ArchStdEvent": "LD_RETIRED"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_WR"
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LD_SPEC"
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_ST_SPEC"
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_SPEC"
+    },
+    {
+        "ArchStdEvent": "LD_ALIGN_LAT"
+    },
+    {
+        "ArchStdEvent": "ST_ALIGN_LAT"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS"
+    },
+    {
+        "ArchStdEvent": "MEMORY_ERROR"
+    },
+    {
+        "ArchStdEvent": "LDST_ALIGN_LAT"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_CHECKED"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_CHECKED_RD"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_CHECKED_WR"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json
new file mode 100644
index 000000000000..f9fae15f7555
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json
@@ -0,0 +1,23 @@
+[
+    {
+        "ArchStdEvent": "STALL_FRONTEND"
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND"
+    },
+    {
+        "ArchStdEvent": "STALL"
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT_BACKEND"
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT_FRONTEND"
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT"
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_MEM"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/spe.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/spe.json
new file mode 100644
index 000000000000..20f2165c85fe
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/spe.json
@@ -0,0 +1,14 @@
+[
+    {
+        "ArchStdEvent": "SAMPLE_POP"
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED"
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FILTRATE"
+    },
+    {
+        "ArchStdEvent": "SAMPLE_COLLISION"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index f134e833c069..537a4a27917f 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -41,3 +41,4 @@
 0x00000000460f0010,v1,fujitsu/a64fx,core
 0x00000000480fd010,v1,hisilicon/hip08,core
 0x00000000500f0000,v1,ampere/emag,core
+0x00000000c00fac30,v1,ampere/ampereone,core
-- 
2.39.2

