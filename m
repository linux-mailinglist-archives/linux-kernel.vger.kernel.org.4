Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB966F8083
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjEEKDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjEEKDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:03:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4099019;
        Fri,  5 May 2023 03:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwaPVR79d8gAtTi3x2uElkJK45Wyd/n+1zYuVrN83yw5u2wMAgn1lPDagxU6KK4sLw9HFxkBl/fCsQy1MU8lvzZ+n2kFWBHgBhqXcZCpXYXl2kx/Toj9jQNzZBlF0fL8ezDzGXGICA+MTYykkXV4qhq3w+0mvCe6FZHsahSKO1nxzfLPU24dLHuTdtfwebW0ybOuMjSrrZncZ4LsiH8kxydxvl6GP1VNvIg/mSVVQkU1T26/H7h9EeT6f7H2iuCy69zVdAlCpJbiLyiR/uq/GTLutL9yXQRlj8IGCCvOt7uY93dGF2+Cfr1g+tej+Mmk8ahJK6Ci5PhGsyNMVYwlog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jutWhOYcfhVltBsmhAGpFE40+Id0JaupsxHlGmdKoQs=;
 b=kVffDqrzfT5KKMNTy1/aSJWRR8/CTMES+gbt3aMZ1KKYUxwsBzRVtLwqAzO/bsbqUdSQUp5Sg2lFmRDMZ2cFQCobpQaDCKd0TxMQTyTcqfbmb8nqaqAHLDMrEOUjD/cJ7e8kcYGpq3nI7yc1QQ4NGV3nZc8EmBIsFtn5omE14/pE0LbOPJsAaoTPDtxlrUUxqr2KB85A2p6uA/aqckASjij6owriQHEP8nxj30DJGr4BmB2xrHPsDOzmulCE7l3Z3Y07OfXaAf3Gvz3cFdxHtjqyBrBSEjwllYlO5Fv8gf9bedffBfvSt+kMSYvhenHaCHdd/I9xKSRWSI7hlsFEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jutWhOYcfhVltBsmhAGpFE40+Id0JaupsxHlGmdKoQs=;
 b=vtfwj851ysWwcZevhbksX8DYkCB0WcfsS/mb46U4ktix4DABLP+cBlzd1TPLWEopdayv/+4hiuz0Uibmpe5B8pO7Pkt8ZXeTiDE0bEZb3KQYKyugCqZ+hV7yH1k0ZgMFbF+jn0jPNdFjBh/sF2JJzbsey8sQZbebgwfopYmHglo=
Received: from MW4PR04CA0093.namprd04.prod.outlook.com (2603:10b6:303:83::8)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 10:03:07 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::e4) by MW4PR04CA0093.outlook.office365.com
 (2603:10b6:303:83::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27 via Frontend
 Transport; Fri, 5 May 2023 10:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.27 via Frontend Transport; Fri, 5 May 2023 10:03:07 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 5 May
 2023 05:03:02 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <terrelln@fb.com>,
        <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 1/2] perf script: Skip aggregation for stat events
Date:   Fri, 5 May 2023 15:32:53 +0530
Message-ID: <83d6c6c05c54bf00c5a9df32ac160718efca0c7a.1683280603.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: aacdbb1c-2af7-48dd-30f5-08db4d4fecd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bW3wqHOlIezOBYj/Ym4/VnO6c9WNqo6EfkS+1trlI06FTRwMwWrk/o7bB6yAYNLrxNnbm4mcMbQAeBiTJ+K4CxlQ1AHlRVrt+CYRuOqYNoR2pYKskcq/mNyHlKcTiVO+IV/b1UxiKTgNNtyMwl+Y9Fa2a9U2LdjWyra7MNX81221y/wmvb5h2t27TaL/rLRVfv5N4uUpawg18dB/mCL9Kck6ClNpMzt8rOdYn+gLVp7RwnDcCAgs79ADehQH6Axk5i53jvYKNgv6fgV13+lQaq/UwH0girQ8xhMPKbnGu8vuO9PtpcBHcpjexFe5CLjF+j29RzLgrEAtDPjsvqfhJYe7sipqPp9EjOOZjMVAhPeC+pgMVTPK2c+DBNuWQCQpPuhQ7JcM8t3t9uj30drMeDAUgdLUQawL4oD5Y2jDlnTisN9OuVBBdL9Nd6QFG0RMSYrewjTLz4M2HlqV77k8ORyIQUh5J93OGTEuGBCa5jjipK4MDPccn0xLMc1i7IuHkrnptIaTJCsdE8lU1V4hhyZV2wtpdcTOo8HhEzJ38DWf0D/9rFmzg/SYxJaLtpjUClI0llYT/w3HZv1RjWEJZlzRd8VXWnwBCKvBmzbVZ2ELsJcWK7/qAHVVSiw3Y4cMXr7AHg+Mr8JnFl1HkTtWfL4Zmfhq9ctLtWDazH0hDX3Rw5pwaRlCT96ys1ksAA6giictEJ6YTu0FACd6Je59lfbtal/jbHqKcVuphCaP03zhGjT8GWzorBSQyRXlJGP2mD3SbXe3nDNa9lsVD9TSEUhOu2V1mA7qEYF1k25ULfE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(44832011)(70206006)(70586007)(41300700001)(4326008)(8936002)(8676002)(7416002)(5660300002)(26005)(54906003)(478600001)(316002)(6666004)(110136005)(2906002)(83380400001)(40460700003)(47076005)(336012)(426003)(2616005)(16526019)(186003)(36860700001)(81166007)(82740400003)(356005)(40480700001)(86362001)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 10:03:07.2069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aacdbb1c-2af7-48dd-30f5-08db4d4fecd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The script command does not support aggregation modes by itself although
that can be achieved using post-processing scripts. Because of this, it
does not allocate memory for aggregated event values.

Upon running perf stat record, the aggregation mode is set in the perf
data file. If the mode is AGGR_GLOBAL, the aggregated event values are
accessed and this leads to a segmentation fault since these were never
allocated to begin with. Set the mode to AGGR_NONE explicitly to avoid
this.

E.g.

  $ perf stat record -e cycles true
  $ perf script

Before:
  Segmentation fault (core dumped)

After:
  CPU   THREAD             VAL             ENA             RUN            TIME EVENT
   -1   231919          162831          362069          362069          935289 cycles:u

Fixes: 8b76a3188b85 ("perf stat: Remove unused perf_counts.aggr field")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Cc: stable@vger.kernel.org # v6.2+
---
 tools/perf/builtin-script.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 006f522d0e7f..c57be48d65bb 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3647,6 +3647,13 @@ static int process_stat_config_event(struct perf_session *session __maybe_unused
 				     union perf_event *event)
 {
 	perf_event__read_stat_config(&stat_config, &event->stat_config);
+
+	/*
+	 * Aggregation modes are not used since post-processing scripts are
+	 * supposed to take care of such requirements
+	 */
+	stat_config.aggr_mode = AGGR_NONE;
+
 	return 0;
 }
 
-- 
2.34.1

