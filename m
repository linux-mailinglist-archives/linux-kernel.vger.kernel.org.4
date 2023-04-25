Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2C46EE3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjDYOWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjDYOWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:22:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2411265BC;
        Tue, 25 Apr 2023 07:22:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/HpuL95x2lWkLnG/atLXvEKZsybobFyX3f9UPGUls/YBIRkh8gLy/kp6qtmcZy0JYmlRj5FFUzY2RsUCA5uG3opdLuXq5FfrabAe2S48b8YuQ37DcfdAPMJlsI8qV9DZzBNlQxlB4P+i2c+wf8L6GXeiEBiHIerj3gSHq4/7e/Hryu82w2sIeejvZT7TvXYDBFfxhS4ZcD61hk5FrNsb7fUMN8+VcBVGsappgqtY38tQa0bEJt1SIwhR2D4atV/B2kcvrh+aI3wU9wwN+AmF4/Xn/yDvTIbTeNiP+0EpVb48bBBO3h5vJF4pUzHk7ymgduoo4JSMG2iLj2RNbf8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QN78BLLCyDmGHLPVgA5FQmv700T6UqF8zzywe1Y8+mY=;
 b=bJH9d+H/3uZCsj/f9LZv/zR2zfkhKFPbBn/bEUTvCb/ygBjZMdmMxLaB4vohdbwoW2J6+053b1dJcxJ7vb5DqZPWcT0KjPis8XFDoOwWdDybBttrqdiWbd6S2dNGMNKaKAMu130/0qezA/ErIio00mwGa+joUFJEeRv09KaSG0wsm/n7v4iYhCSLloAE9R+vPg6QR95v+3512jwQBy2aTr1KypziIbeKH0TU8+8N1qhTD0sLEeWg52Sv4dmWjVsxpjlb5vB+qcZtz/mJgaXEr/UWikiphvJ0+FBn1pw2aSvDnYPg8qv5fcvU1MUKcIz9gniz4Rj1iahlBl/dLH9Xjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN78BLLCyDmGHLPVgA5FQmv700T6UqF8zzywe1Y8+mY=;
 b=G93U0okn5NbsUenzzCU4OCK2sfRtb72WaFVDUwGTzJj88KQC+kS0ei3VDw+t6s9e5gN3rafYhZ78SiJMAS63CyH/nnBE3HCRylHvsraZCFuXt1LcpJhj6BnVGxRqMH7v5s0jpdKVSN2E3SFzRjCnwGHvIkT9pNBAF3CukvN7SfI=
Received: from BN9PR03CA0346.namprd03.prod.outlook.com (2603:10b6:408:f6::21)
 by CH0PR12MB5218.namprd12.prod.outlook.com (2603:10b6:610:d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 14:22:38 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::eb) by BN9PR03CA0346.outlook.office365.com
 (2603:10b6:408:f6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20 via Frontend
 Transport; Tue, 25 Apr 2023 14:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.21 via Frontend Transport; Tue, 25 Apr 2023 14:22:37 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 25 Apr
 2023 09:22:31 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <namhyung@kernel.org>,
        <eranian@google.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@kernel.org>, <irogers@google.com>, <bp@alien8.de>,
        <kan.liang@linux.intel.com>, <adrian.hunter@intel.com>,
        <maddy@linux.ibm.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v3 0/3] perf: Rework event forwarding logic
Date:   Tue, 25 Apr 2023 19:52:02 +0530
Message-ID: <20230425142205.762-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|CH0PR12MB5218:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ee4e29-4364-4007-350e-08db45988575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XcEHdLjFcTlAsZijEiVFEjiA4eX0Nk9RdMsyqZCU+5NiZpSklYlIcN/VUeG9R6Gt7DowCYOZGFPlzIPo3XSWpl4SDEKDCQKtNUkgqlFvUaEUOuiEG6YRh68HHtp2Pn2kShfzvKJIU2pKV5g/V/qXRBV3kvF1wMczVtxJ9we0JH1bEzAkpSQ00Y3/OSD8707l7O68AEzmsmy4bwkoUGoWT7fx2xkwdxoREt4x00KVT/Xtnqn3c6p27Av5SBAzU6rrkz57E+FBUddjIXH9rjH0bQOCgrzcc/pgLv6QqNuyjF2qH1v5rlBaL0SSgY60rMZ1hUm9drvAUe9SmQF2nQtr/OU8Ss/aRFIhXxRpbPWcZLKpDQ1BtDy2RwLzZVTI16Bt6ncDZLsoLETQUauxPTAHpgBP/aZSM5/ONzbsWldH6VhiT+xAQwn0T9cCelBhl3BCLfnYzTtNa6bid8rZGCGth9lhVkI3WYd6zdn7Ytyb2+s8hvcJddwoDhAokrSPTs1p9IbZZb8Zt7mIzLt98uKlhU6BDfj1A29Lmg/y2sZ/BBM4EdTNZNJx8WVBX3Gcqo9J+Eis17RN4knluYDOUjv5/vyyEItKdtOLbIuYqzMb4UKNqYhZpJeJLyiQL5gbHlH9d0vQywq8thQW9bGczZ5rvyYV4VV5gY4Kj6wkLJ+x67Zb2ZcuBScjIf2SMx57XsgeUzYVuDVR607+RxP7E1ItOO+YiH7kmMr7T02DpSsYdpc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(36756003)(54906003)(82310400005)(86362001)(478600001)(41300700001)(81166007)(8936002)(8676002)(7416002)(44832011)(2906002)(6916009)(40480700001)(4326008)(316002)(356005)(82740400003)(70586007)(70206006)(5660300002)(16526019)(186003)(1076003)(26005)(966005)(336012)(426003)(83380400001)(47076005)(2616005)(36860700001)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:22:37.8985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ee4e29-4364-4007-350e-08db45988575
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5218
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually events are opened on the same pmu as requested by user via
perf_event_attr->type argument. But certain special events are
internally redirected to different pmu. Currently such pmus needs to
be treated specially and thus requires some gruesome hacks.

An approach, suggested by Peter Zijlstra, to get rid of these hacks
was to overwrite event attributes with new pmu's attribute values
within the kernel and let perf_event_init() retry opening the event
with overwritten values. This patch series implements it.

v2: https://lore.kernel.org/r/20230309101111.444-1-ravi.bangoria@amd.com
v2->v3:
 - Both uses different approach to solve the problem. v2 was using new
   error value -ESRCH to let perf_event_init() try opening event with
   all pmus, hoping that the event will get forwarded to right pmu.
   OTOH, v3 uses different approach as described in the description.
 - v3 also fixes SW pmu to task-clock/cpu-clock pmu event forwarding.

Patches are prepared on v6.3.

Ravi Bangoria (3):
  perf/core: Rework forwarding of {task|cpu}-clock events
  perf/ibs: Fix interface via core pmu events
  perf test: Add selftest to test IBS invocation via core pmu events

 arch/x86/events/amd/core.c              |  2 +-
 arch/x86/events/amd/ibs.c               | 53 ++++++++---------
 arch/x86/include/asm/perf_event.h       |  2 +
 include/linux/perf_event.h              | 11 ++++
 kernel/events/core.c                    | 79 +++++++++++--------------
 tools/perf/tests/Build                  |  1 +
 tools/perf/tests/amd-ibs-via-core-pmu.c | 72 ++++++++++++++++++++++
 tools/perf/tests/builtin-test.c         |  1 +
 tools/perf/tests/tests.h                |  1 +
 9 files changed, 151 insertions(+), 71 deletions(-)
 create mode 100644 tools/perf/tests/amd-ibs-via-core-pmu.c

-- 
2.40.0

