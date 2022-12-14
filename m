Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725BC64C50E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbiLNI1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbiLNI1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:27:20 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20625.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::625])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7390EE2D;
        Wed, 14 Dec 2022 00:27:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTaOmwHHEB/XrustMxUujBk2RSy8Vd81H8ZwB4BelqcPHDUHO/oTuIj0vny/cusGoGVF7df69L5ZigboJ3eRcAR+LeR2M1dj4F7MloqN74Qg6DyuM/y6e5S6ZS+rvymkiSf9qbOZVfBK+f0aUXsLAVyiAI+nQ2sF3dbM2aKykv8TODXIi2DeZsmStceMW7B0JSUBLRsNLR+2jBbC4nxmbQD/8AEHBt/60fc2Z4zRF1skATgMYtoz6/4MJSjwuCrKj2mDG62DtlCXbLG5SxIuEGINCTb5iUTxlj6FD18ZsbGaaUs2a3JqiQtO2Ilf/Bzt3KuLRzcTbfgypl7ImD9iDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyz4pdodgLx+JjZoKdXIEcJK13bvpRTOugScr2fDUeQ=;
 b=hIEgme/CmO8WEPVjMK+7LgXGPxyurrnOJPkAfFxNJKez8ze27xcb12gdU5qn1+qN7tIoss7+FJld7AzHJ8JM42/6xMgDrK9/F1e4YobV2uMdfiPrYFo8pzPO8KnTM1UlYX0Lt3Ntd/6u3bWVGtbg9SMK6oVtWOuQP1Jy36MjwV2tgv0e2hGlc2i3CWrFWKltL6tagqlYYH3e13p+wUzpYdZTFYbOvmF0yaKngj2PNp/5UGfp8oHTd54XlVJzyCfB7GaQl/cjsfURy2vZzTn6lo+DYl1vLHHvI6ChaBF8ju84lFLXqI93f7/NOh8/dOmwQNUUnJGoCq2Q+qKJ6uSTew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyz4pdodgLx+JjZoKdXIEcJK13bvpRTOugScr2fDUeQ=;
 b=P9XczZ0HFBLPErK6oo54O4ZfD+a1UyaFAMjtuNWHpEhDH2bCjNUeigjddnuoWUeD8LnFEsNsRfXhUjhVP4mdE3HgjeyLOq0IaQ0SU51TDuApc35s35MfBOhzxV6NkTTrN0qLRrXKNLgQDoO1GGK65xILUnIHq9DlJRCvkO/snCQ=
Received: from DM6PR11CA0026.namprd11.prod.outlook.com (2603:10b6:5:190::39)
 by DM8PR12MB5429.namprd12.prod.outlook.com (2603:10b6:8:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 08:27:15 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::1) by DM6PR11CA0026.outlook.office365.com
 (2603:10b6:5:190::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 08:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 08:27:15 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 02:27:11 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <eranian@google.com>,
        <irogers@google.com>, <jhladky@redhat.com>,
        <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH v2 0/4] perf vendor events amd: Add Zen 4 events and metrics
Date:   Wed, 14 Dec 2022 13:56:48 +0530
Message-ID: <20221214082652.419965-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|DM8PR12MB5429:EE_
X-MS-Office365-Filtering-Correlation-Id: e34d78cd-39b5-4528-5cd4-08daddad01ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qIIuProRgmK9H+VR+LiS51qRgHM0ndtCDPE3g/E7JgeiSJJMW5Ymp6dAa5wrgYdU5sxm4YOeajP7EUahFScOIkN9nTE14KqpbFMI317+AhqY8jL3hYXZbDKXu02EsxcJ7cg4bkH6iQCMAS/wKxmzS5V2FIPFvW9OBSdVzAuksyl8Igcwtw12ecIfdK3kDbvE0qf/VjQuh/dFxFzIqssD32Djwy4+a3JGVdenEmwTujzCwMhoaX00srACIP7+BIh0w3oSSV7aVvds+nk3PNs72zEz6Gln1VPpJfdFj1gGSAieH2sSZG2z6Ums4wGwRthNinMo+8AdLOJpERmp2YAdyhGyRs3nHoTp5dPWgmwWan7H+tX6j3eTaYQb55qFrMWxDvbzOIMzToWDG4KNy3B8nsJp6/zwbLZrDraPadCxv4jJ0Xj/HrKQYB4sEu+7N+ojEWWgEUIMof2t+xKHevk7rBr5r96HrKfBVgZZh2ZI2tTzRIxWWY5DT/imJ+P1gQw6YDU2HzN/qXIzpEx+OTrNssiW8B85ExHzSLBphS8tu7yxCWgez9F6juzW8SG5yUSvQP9phyB5BvapTvIj0VDTHZ0PgJsx9sLCbV5wEuA2v+mJ9gLUgxPVp7VYcpvEZ+3ssangXqoNwdfq1pNTqn7pKT6VZ/LaHgfcI3FatXoYlsJZBoC8l6JvEsmB5J0iWiwE+GBJRS/qGtj9ViPwifj2NV7GlVpNVO57P2eefqvgvMGgP9nHcpsYg6m3jNTq1Fea9s9g9Yn/EqPjErrxsvashjmDou/eyMfmwGX+AVFwZ3XOy/tPdwKY7yQg2aodB4P4
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(40470700004)(46966006)(36840700001)(316002)(54906003)(26005)(40480700001)(36860700001)(2906002)(6666004)(110136005)(426003)(70586007)(186003)(36756003)(478600001)(356005)(47076005)(70206006)(40460700003)(8936002)(2616005)(44832011)(81166007)(82740400003)(966005)(5660300002)(83380400001)(16526019)(7416002)(336012)(86362001)(8676002)(4326008)(41300700001)(1076003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 08:27:15.6913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e34d78cd-39b5-4528-5cd4-08daddad01ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add events and metrics taken from the Processor Programming Reference
(PPR) for AMD Family 19h Model 11h Revision B1 processors which can be
found at: https://www.amd.com/system/files/TechDocs/55901_0.25.zip

Previous versions can be found at:
v1: https://lore.kernel.org/all/20221207053007.336806-1-sandipan.das@amd.com/

Changes in v2:
- Remove "bytes" from the names of data fabric bandwidth metrics which
  use a scale unit.
- Use better group names for pipeline utilization metrics.
- Move patch that adds family-model mapping to the end of the series for
  avoiding potential build issues.

Sandipan Das (4):
  perf vendor events amd: Add Zen 4 core events
  perf vendor events amd: Add Zen 4 uncore events
  perf vendor events amd: Add Zen 4 metrics
  perf vendor events amd: Add Zen 4 mapping

 .../pmu-events/arch/x86/amdzen4/branch.json   |   82 ++
 .../pmu-events/arch/x86/amdzen4/cache.json    |  772 ++++++++++++
 .../pmu-events/arch/x86/amdzen4/core.json     |  122 ++
 .../arch/x86/amdzen4/data-fabric.json         | 1090 +++++++++++++++++
 .../arch/x86/amdzen4/floating-point.json      |  818 +++++++++++++
 .../pmu-events/arch/x86/amdzen4/memory.json   |  174 +++
 .../pmu-events/arch/x86/amdzen4/other.json    |  138 +++
 .../pmu-events/arch/x86/amdzen4/pipeline.json |   98 ++
 .../arch/x86/amdzen4/recommended.json         |  334 +++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    3 +-
 10 files changed, 3630 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/data-fabric.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/recommended.json

-- 
2.34.1

