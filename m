Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704A463BEC7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiK2LUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiK2LUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:20:14 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38B65CD1F;
        Tue, 29 Nov 2022 03:20:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3NVPh7eu0WzZ9LOUApuXq63/bPjA+wGsKxyTqtGjgL7i8laj3sm80Tqe1SCoVCuXqnqg6nonunR+Y93kbCBn97N142YlP7X1u4HyB3AKHwDpy+mbJRQK7g2vDPYIBF9DAQG0e4szc5iYCQYJHzlWMCNYy8AX3nZjZ5PDUzBb+IGkQFLzqkJ7IzYeNbBgAknxNIdFQaoylME+uqHvPi/8Dr/mzfZCA96hBIzMjJLmjAlrK9tk7s1BvljChIKi3xSDMPYIHAfA5NgTW5q0upYzL2sUBug3d9wfYEd3AoN9BSbzZmO4I1OpqcmL0osxVZZ6ztYroUwgWoC+U+rq9qGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ooajfqJWe7OUG7py4DSXgA/GjTJhL+3Ey83dgCbkzg=;
 b=e68pWXNCFFBShrKvxfvXJ0V2Ey1v6N0rtFpmgKd+WSzKwl7vdQOQp+9V20Yes3UZd2BlWeznZk20dxmByC89Pm+XB6wWKaplk/4B8vTLkTlu4GvfuAenC1mhnJrN5uGefIk1ErUtkJmSdHXLCU0LTPqL0Je3H1Y6Lb7NCEnxQaYKHmj7L1DJPu8h/HcVy35t3PnPyQfkMT1JXQBdrdO/NmTVGgVDVE781553+8ynEWbzzX0ZhK3FiBBDDMzS4I4SqTNey7uzE9ots9fGYwpXczHWFOec8AMRWNh3wUNzqjYc/JdjEhHbUSfyMxSxAI8JL1Z8BbKU0dR28uznQzp4jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ooajfqJWe7OUG7py4DSXgA/GjTJhL+3Ey83dgCbkzg=;
 b=KpXx9RySuiStCU1ePeQv65C+qsB/Zz4ST3A8y7QzqBv69+6WABqlqL41MGYC/3PARyCRfiD26A0XL59eLvj+qiSwkf1mgpJu1VauSY/eQgNRo/Dm/ZsI4C4VSaxbqCnJ1TbJQ1lUauHygYji6J63DGkUQWDE7LeuPqByI5veG4Y=
Received: from DM6PR13CA0066.namprd13.prod.outlook.com (2603:10b6:5:134::43)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 11:20:11 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::88) by DM6PR13CA0066.outlook.office365.com
 (2603:10b6:5:134::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Tue, 29 Nov 2022 11:20:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.22 via Frontend Transport; Tue, 29 Nov 2022 11:20:10 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 29 Nov
 2022 05:20:04 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <mark.rutland@arm.com>, <kan.liang@linux.intel.com>,
        <adrian.hunter@intel.com>, <alexander.shishkin@linux.intel.com>,
        <carsten.haitzler@arm.com>, <leo.yan@linaro.org>,
        <maddy@linux.ibm.com>, <kjain@linux.ibm.com>,
        <atrajeev@linux.vnet.ibm.com>, <tmricht@linux.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH v2 0/2] perf test: Add event group test
Date:   Tue, 29 Nov 2022 16:49:44 +0530
Message-ID: <20221129111946.409-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba45d54-9e3f-4529-97c7-08dad1fbade3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QVmCuxxh5ckbgQFzzS00RDWhhmqKL2S/E+PijzJVri8d9VMkGvlnFJKqV4/bEN1jQb44KerkZgl1ibaSzlVbIUEgIhQHP42vXkgLbkZ53JhNqJKQhzHtD7QSY8Gu+ByPqPfKYHHsDd6p7np4WvLEtcfmXC6sBQfZZasQkhJOx/1a0/HOKPHyaGBNv3yFKTo83UgGNBFNmR8Mo+vgp/C+7G3sWRBs+PRY+QKhvnJ8FW6Lb+oMNCmTOkgDqHAwcUj3IeXPSBEgiNX9fIjYfyecmhZb1DNs0wW+MU8f8VjvGmIMTKwSxn35AbNgL8IrKOTG+IE5cnoEuknLAjypkG/QIvYgu04ITBCpy4+LJFt9eoQZ3biozb5X/fE8fMBvzzORkfBnR2xpqArLgraLJnFIwX3kNe0U10ybyVWsn+tTPVSXAbUtg6B45OVHJiYjBVdbO/3yu3RAPIcBkUFkxBBG9CLMpZ+VRMhJcNpuVRoHR9ROwyVUJ97VhILrlqKDIz56lre6SU0n4lvTrv0kh+g2EDw3NR3SaLLgJss9dvBC994Spf2TNKubL6r2kZ3eM2njjhnkAr9vbejKrmOe79EeW6cWTlFtr1G5lAtBhO4/XjEXfLLxA/FyIbnh0Ob+wxcxvSkfjtfoMTuj1RZmie8Zuvo8Jx+KlPKM+79bbTsZ1s5hRLscgnaQd9Zwuk+ftF3ZlaL1AFGQWVjqEifGKnRn9f11rCXwd6Q7e2Ayg65y5T8HPTuok3G3WqCv8MsfpWf8Qkp0QZQ5MGQMKozneU48mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(54906003)(86362001)(83380400001)(36860700001)(6666004)(478600001)(7696005)(966005)(41300700001)(336012)(2616005)(316002)(6916009)(40460700003)(426003)(8936002)(47076005)(5660300002)(40480700001)(7416002)(44832011)(81166007)(356005)(2906002)(70206006)(26005)(82740400003)(8676002)(4326008)(16526019)(36756003)(1076003)(186003)(70586007)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 11:20:10.9935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba45d54-9e3f-4529-97c7-08dad1fbade3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple events in a group can belong to one or more pmus, however
there are some limitations to it. One of the limitation is, perf
doesn't allow creating a group of events from different hw pmus.
Write a simple test to create various combinations of hw, sw and
uncore pmu events and verify group creation succeeds or fails as
expected.

v1: https://lore.kernel.org/r/20221125032018.962-1-ravi.bangoria@amd.com
v1->v2:
 - #1 is new. It makes pmus list variable non-static and moves
   it to a new file.
 - Instead of hardcoded uncore pmu configuration, iterate over
   pmus list and use whichever first uncore pmu is available.

Ravi Bangoria (2):
  perf tool: Move pmus list variable to new a file
  perf test: Add event group test

 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/event_groups.c | 109 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 tools/perf/util/Build           |   1 +
 tools/perf/util/pmu.c           |   2 +-
 tools/perf/util/pmus.c          |   5 ++
 tools/perf/util/pmus.h          |   9 +++
 8 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/event_groups.c
 create mode 100644 tools/perf/util/pmus.c
 create mode 100644 tools/perf/util/pmus.h

-- 
2.38.1

