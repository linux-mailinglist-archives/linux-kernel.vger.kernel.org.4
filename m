Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B176B20F5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjCIKMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCIKMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:12:18 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29103E4DB6;
        Thu,  9 Mar 2023 02:12:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzHUBo6KpdVDWdEiuCSnbns9+3icl6J7PW8osU1Wug2r1VWlj1o0jmLoIJGc3HkcedzA+eyqXGA2bCA/bq3Ait5s5Mn6t1eGDxi3UfpyJY6de2VkUAnmt4o/t8Sd+tZPSrAfSxT7lA9Qkxri8g1m56j+1VrBPDcnr6bzZ4MgHRvexZ7ezTaJJ6yoLPPSRsJUMu/owSVYkueMG7W2md83AumZXCN4CU/MamHarUboLBKtG/LC3BVbBkrS/91UTgz++V7WfaxbHjAQdi6lSe+EJtDvgJJx+SrWK9/5d1+TuHu+9A3H483vtCi2LaF3127ZI38JZGjzsNSU5A6e0zQfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gY6W4wlh43KwuFpKy6hJPU6UY343SCZuOKcWNhvonLo=;
 b=GAFAmEdUOtOfIM0+TYmXoyqJVqgkjnUHFmGD8irW8aB07uiBloOQPQr6Vg1xuX7GaCAh/nGqoPiKX+aZ6QP2VMntd9Xtrdw0sYyOnjMqzffEfoCSqPHUmYMDvaL5bQiyt+zP5Utwx2EcKXAfN9r0R6vQOFM5clVHU2IqCsgpkW4eNtw4MqF29RBmJkIToMZ4LY9FnL87pRlVD+2pukitcZTUaEHlLsfl53wvcA0mBkN9t1g9t+k5C+B0OHm/ks6N9ByiwNuvO9ZYnsn5r7Pbnvbhb6ZAUydmqu70hc6ztuHxcYPKwmwKjX2OK81CP6OdChzBWRi9izsxI+WDTgl97w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gY6W4wlh43KwuFpKy6hJPU6UY343SCZuOKcWNhvonLo=;
 b=OTDGZpwWsFlpmUzE6/E/Rh8h/7DElsk+pIytcs5vljz77qClK1g4IMUbA1xIP/tvWl7DxselRb7MhXzACx5+QioCV5EGWTnG4bUMYyy7KwyxzUjQ3s9NptBXqdEie5LfDClGuO82YqORqypw2MzY/dND2mwALRgwnTifG8QP29w=
Received: from DS7PR03CA0191.namprd03.prod.outlook.com (2603:10b6:5:3b6::16)
 by PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 10:12:13 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::13) by DS7PR03CA0191.outlook.office365.com
 (2603:10b6:5:3b6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 10:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.18 via Frontend Transport; Thu, 9 Mar 2023 10:12:13 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Mar
 2023 04:12:07 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <namhyung@kernel.org>,
        <eranian@google.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@kernel.org>, <irogers@google.com>, <bp@alien8.de>,
        <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 0/3] perf/ibs: Fix interface via core pmu events
Date:   Thu, 9 Mar 2023 15:41:08 +0530
Message-ID: <20230309101111.444-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|PH0PR12MB5450:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7f3283-3841-4988-aa04-08db2086c0c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sUymjZNpB9LRIhOZpXmIOPLPobbNp01j021HT0abQ4WEOWgV7z16AmcoNuubteQ9qg1gNyNtKJsRQICCgyB4eQbvHXwz7GHpZY5NmY9Nm79oDT/ksnIfoRS+hhii5zDk3YT6UtZyufeR58osQH4a7NxhYuhbETmeqiiqiLPqut5+8l9wWXiRAOqsQlmI+qoWraSb99ZkDAqSXYeOWo2lbPJYCBXd8Ra4whAImzcLcxqhRJi+o0NLBo26CkK8BG0jUWFswnD/9IlQl+2nmxb+osIWlhmBK8msskCjJAp70zS29oF/Ru95rUcarxv3HjvvgictB+ONsr3Y/ZWS5UN2wHM8j4Nmk5/Fu5WZFUK6kBETUWQkaitxVnN/O6XjM/Z2HXr1TCQBZCTBbvxzmqJMZ7lKJM8s63jrmeXywp/RA5Cg17XcZI4m6JhXfMieR076uZFct9dlhWc/XY/o4/xfB8PHxoeO8S/eWUvkFAiwTqbcoG2fL73Cc8hYnYG4AQ/RuPVM4oL4akq3plrDeqsIwa2pw/tzPYn6v6em4KbL/snVv0IXfBlV8Cnak7kXwg1aCPI8dw1QYGifNIyCsFRyueEuzoH9mdn+M9ZOaOMMbelSQGkmJ0g3f0zeIhuBXptUgkbUCIMNUlhX2gPkqmXP3piaMmJUgM7kSXR14zw/FhmMlo/CGnn1t4e34MEkIguO75ov4FE8/Qeq6OMnZmDkChjch4WKD5vVOlUDt13qpJc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199018)(40470700004)(46966006)(36840700001)(36756003)(40460700003)(356005)(26005)(316002)(54906003)(41300700001)(5660300002)(478600001)(966005)(7696005)(7416002)(44832011)(8676002)(2906002)(70206006)(70586007)(8936002)(6916009)(4326008)(1076003)(82740400003)(16526019)(81166007)(40480700001)(86362001)(36860700001)(186003)(2616005)(83380400001)(82310400005)(47076005)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:12:13.4358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7f3283-3841-4988-aa04-08db2086c0c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS used to allow event creation via core pmu events with precise_ip
attribute set, but it's broken since late 2019. 1st patch does pre-
req changes, 2nd patch fixes the issue and 3rd patch adds simple perf
test for the same.

v1: https://lore.kernel.org/r/20230302092109.367-1-ravi.bangoria@amd.com
v1->v2:
 - Instead of using pmu capability, use error code -ESRCH to forward
   the event to different pmu.
 - Rebase on v6.3-rc1

Ravi Bangoria (3):
  perf/ibs: Introduce ibs_core_pmu_event()
  perf/ibs: Fix interface via core pmu events
  perf test: Add selftest to test IBS invocation via core pmu events

 arch/x86/events/amd/core.c          | 11 +++--
 arch/x86/events/amd/ibs.c           | 52 +++++++++++----------
 arch/x86/include/asm/perf_event.h   |  2 +
 kernel/events/core.c                | 10 ++++-
 tools/perf/tests/Build              |  1 +
 tools/perf/tests/builtin-test.c     |  1 +
 tools/perf/tests/ibs-via-core-pmu.c | 70 +++++++++++++++++++++++++++++
 tools/perf/tests/tests.h            |  1 +
 8 files changed, 121 insertions(+), 27 deletions(-)
 create mode 100644 tools/perf/tests/ibs-via-core-pmu.c

-- 
2.39.2

