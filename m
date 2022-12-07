Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC835645371
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiLGFat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLGFap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:30:45 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3A354B1B;
        Tue,  6 Dec 2022 21:30:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcTn9patkeo4fJzq1nEKqml/foxALRmYnuDnS2kQNnrUZnoTabjiCx/jO1LRLCfH1mLVyyMV8cZHfCfSmAndrABaRS0x91sqa9z1IUPOMgjWzUXU7K/7GpT2RNISunVXvMNeitM5FVreJpAYN8vJbz4QBZ+Zg1WkNkLSKWHm4BGU8p2Y+IFKm3Jm2zn+o2qWSdOgEan7qVWigaGn0Ct0gK6KdsyGGqBXrvpiHYaDfnQE1pQht78GLZFS57Jru8pXCJHTlctBe++9VYMroo4NpoHm8jjBDeC9beohDzsOw1cGMlmgLHk5XKGRSqjmUMonNDurJ1e86SpG9U4F8x/Q7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGBFbaTvbX2b16LIoxddaSfRtYdiIdUDfF5mgs3ARjo=;
 b=lj++rVUF7HvRJ/IGwB8fnPBbE02Wk5ybUg54oUOeuUEpX4ljxsMwaV8NS0H25D8BMoaMmFTYk+1MzDXogKIrn19ltVKlbutdJLtcFz4cuHjNMLSt/81GvpBTkMwqFZNV1USRskjtIqptrvApF0Vbpf8puX8oa3DRpb54MNA9FUPYnlpJGshfzzMWsxn678gtoqnQjxH6MywsNnWprNx4s65xroZ1X/lCOD7rUPuFuDhZlfD5KXE7VOL7npKwxgXd0jnWYnKszPvcMnDfwZ9vwmVF05MePd7hjvC2yY2djudiQJ1kaf9iTsyHwCm25GR1aTDtZGXsDV71FiJgx/HGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGBFbaTvbX2b16LIoxddaSfRtYdiIdUDfF5mgs3ARjo=;
 b=efGU34SSLz0s5ry05LYjWDHw33sRzaigDIUzGVcQW6d9FoYDsvjF0JCNkI3qB/ypx2O/C58Mfu7APosLv4urMsivFtgNUPspxWo+pNjMLbPEXmdHCzWnrhIG4dVhMwy2t89LdItnqTYjJCyr6+51uG//AIEbQQbFUMEJfhcNKOg=
Received: from MW4PR03CA0031.namprd03.prod.outlook.com (2603:10b6:303:8e::6)
 by CY8PR12MB7097.namprd12.prod.outlook.com (2603:10b6:930:63::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Wed, 7 Dec
 2022 05:30:43 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::c3) by MW4PR03CA0031.outlook.office365.com
 (2603:10b6:303:8e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 05:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.14 via Frontend Transport; Wed, 7 Dec 2022 05:30:42 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Dec
 2022 23:30:36 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <eranian@google.com>,
        <irogers@google.com>, <jhladky@redhat.com>,
        <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 0/4] perf vendor events amd: Add Zen 4 events and metrics
Date:   Wed, 7 Dec 2022 11:00:03 +0530
Message-ID: <20221207053007.336806-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|CY8PR12MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: b03f7d18-653e-44fb-7f3d-08dad8142f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3t3+bLEe9xTn3dV6n1yGHfXFkhvgCEIS0aF0GmAKmT3dOQphlHUl/1rOjUcEre0SGThKEVHLqso3Vjpz35I5yMPR4E7mzmBLjHxET5EIG6cBpstG6YfESg/p4rwmJ4+5zINI19/Qge9yLvhMD/DMzDMlI/sNM8g2IwI2HXwhZ81CM+6fzzigqw2b+axwWtlP4kIo9zxgxvnKvM4HTo1taPkiVctv+t/QaDFKO3z145Otw922Qrr8Qe8RJHbmEnhaBxgKnEaR49qokK0fCQW6hUGk+UND8PSPRzOKf1yrmY9NTAHA06fT9l/QoRKRU9saxUhfVI9C8yGU85BLiEseYuhfzUYbh7mt5GjNCTQrdV7FV4SIocamVlijRZddlwvObO+okawjhrbHeA/p71G/x6aA7AXhA96y3VOstH3obeNf6s3yhrv86uGMlr4Z2QN5Lu86VrIaP78CBVP8SBIHCFXs+AtXZ3Isx6QTA+wc+mGgV/hS0lnQJvYOB4WfXuyNiD2gbVS1xSc8L1QQI/cm8TRDpaKLtMbUxcpQL4UxWnaVdMlarVfvSxkF54NDAjJJ/zNlrDijmhyz2ATlCX7W7WMFWuiz2sp5oeEpzgdMJdhTPeK0wud64z2fCx6ijskyOXytzPH/udq4qNKz4SGKp6NGx7TrJ8macVNdQ74qJhdk2EYJN128u5IgF8Aew8nvECN76Ypxw6KaZZ7eFtL/944e93NrSF0qPbAYXYJflGIop0Roa1lwJzaaPbX7yL9X3Rk5GVDGN414/KWTA143QA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(86362001)(40460700003)(83380400001)(336012)(426003)(47076005)(16526019)(966005)(478600001)(40480700001)(36756003)(26005)(1076003)(36860700001)(82740400003)(2616005)(81166007)(82310400005)(356005)(7416002)(4326008)(5660300002)(44832011)(6666004)(54906003)(186003)(70206006)(8676002)(110136005)(41300700001)(316002)(8936002)(70586007)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 05:30:42.6322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b03f7d18-653e-44fb-7f3d-08dad8142f1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7097
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add events and metrics taken from the Processor Programming Reference
(PPR) for AMD Family 19h Model 11h Revision B1 processors which can be
found at: https://www.amd.com/system/files/TechDocs/55901_0.25.zip

Sandipan Das (4):
  perf vendor events amd: Add Zen 4 mapping
  perf vendor events amd: Add Zen 4 core events
  perf vendor events amd: Add Zen 4 uncore events
  perf vendor events amd: Add Zen 4 metrics

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

