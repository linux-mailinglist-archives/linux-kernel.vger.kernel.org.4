Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C5A64C517
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbiLNIaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237800AbiLNIaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:30:08 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7879F1FF91;
        Wed, 14 Dec 2022 00:30:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaCDbooYUSpzVoelYTnDe+7DDq/ziUBUMn713+h/Ou0YVH5PXdt/k7eSsEchhv1DwIE1HN7TaWOPYsY4uFxqIIcKQQ9v+LAyE5ziwEZ0I6/+mBCzCpRZnG90wOuSXJfeRQTe0ofJRcW3af1O6u1/jqaH9bATLEV8Z1A0H1HWLK4xlRibEpb/hUsPSLClz560Ut+zc5iVpREnDeyP20uL1E0Oc3BRdaFM4YAcGE8YjCF3PjFdUl740YzrEaw6429biLcDTVgzRle1h/KebRijWzTdOW0v7m8XMc3zsE43P9A4Ssw+oqpUysSo5oaWS4VY5Hx+YpyZpclwGBddBLZlJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ec4hqE5XZsdLwgtvKwmazpZCBKeORTgNj00h1CyEEbM=;
 b=MwB1DDihvt+G7ABs5cFl586oBDtQuB9FjIr4+LlbxL10ATs9QsybLo4jilFuiQudMVmqI3L/LKw07rLkO0sOvzMtknHeTa6DZYxlxxrpqXrMBfp7xUVStMJBl51jNEfmTp2SIpBZzeiLZistYatDYF+htCp3zsRNtdoXreAIOfLhm/XcYj738RaZKUajKwvjh2cfUyRrU3UxCX76AMvY5LR+fnHQPdrO9aGLUuu/7RK8dI3GpPWhB3Ppp+wb+XaT2mluPf30r9ZcddMpWURGA90NLoFuXLtdtOPkf0ZYfoVJY2KPz2DsvNjZXXM1d3BS0gWHo1GCvl0qMp8NZzhZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ec4hqE5XZsdLwgtvKwmazpZCBKeORTgNj00h1CyEEbM=;
 b=oRrCYoL8J+TekcekHkNGpMCLc0uZ7GK7+cX2eqje2qlGkiY8SCCeyvcuQ3KRyoqdq6HNRm1KIjWUt9+8D2FskYWWpLda22RS551bqMEeYjsO1ulDW4oSsZQ3KQ6V29L+oLr1DzW+gkiqLlL+1zV+9jXFh69i/h087mb95REyDvs=
Received: from MW4PR04CA0103.namprd04.prod.outlook.com (2603:10b6:303:83::18)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 08:30:01 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::53) by MW4PR04CA0103.outlook.office365.com
 (2603:10b6:303:83::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 08:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 08:30:00 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 02:29:54 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <eranian@google.com>,
        <irogers@google.com>, <jhladky@redhat.com>,
        <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH v2 4/4] perf vendor events amd: Add Zen 4 mapping
Date:   Wed, 14 Dec 2022 13:56:52 +0530
Message-ID: <20221214082652.419965-5-sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221214082652.419965-1-sandipan.das@amd.com>
References: <20221214082652.419965-1-sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|CH2PR12MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: a5227d93-5271-4e7c-4606-08daddad645e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1uHZ7psAIKHOgBGMz6nfpeiELEZaM6mb6pp/3w2HToRE1JVF0GdSIbTIFOp9K4yflcg570MRTipSJJnSGSrWOiC1DwQZX8gEBGwSVbib0XUnDxHsIb4bfQr/ZVjpUG2BRCQhZ6jM+lLFn5GyVS7Ez9VmoxGC7qs9VS3pkun6LWSuzD1JAwyCMAAjrKUGfa+xzZDxQol7HlnP2hPnMYf82eeptn0E86ISozSooKx1s9Hjj4AecZI+pKF24WudfRylZszvfJiQfxO8WWiO4bLAKeuLKvyzSbK82UtZsLFBHlBroz/r7ljnYV7dRB88lLKbgKmZKizr1wX+hP5J5PdaipwqNMDJ62qv2NPfwZJWZ81RbeJDTTwurK84x4Wg2IFAE1oWsBo7Bf5oP9Obg5Uizpjefb3L93jz7scz9hgimRy9Haw6oK8RluVGGaPtoK3yctrHGN3SIEgquK6uX19oeUxCI98i1lPSYFaapf5CHPsiAd16nwORkVOEqoOI049bR4ydSGKwxow6kKWsVE0TwB+CFaVidRVg7Bnn0Z5cSnMzLSoSxuSaT5Ba0n1xQPBQ5juem4GJKnooo9upLeYqqFpVsdSSQ+oskllti5XdvRvQIF9ZBbPWIHu3TxzTFpO/2KhsNnQFfKX/QRJFtR3gCTL5SmvO3VBZGlJKQn6LfFuEytEjW+0wb7HYPibYQLKflUZghUmF8vp4RqG1xVNZF6FuIuUVBr5Y1WZdAE3tebQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(86362001)(478600001)(82310400005)(16526019)(81166007)(356005)(26005)(186003)(82740400003)(8936002)(2906002)(336012)(1076003)(41300700001)(110136005)(54906003)(36756003)(40460700003)(4744005)(83380400001)(44832011)(426003)(47076005)(316002)(7416002)(70586007)(70206006)(2616005)(4326008)(8676002)(40480700001)(5660300002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 08:30:00.7608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5227d93-5271-4e7c-4606-08daddad645e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a regular expression in the map file so that appropriate JSON event
files are used for AMD Zen 4 processors. Restrict the regular expression
for AMD Zen 3 processors to known model ranges since they also belong to
Family 19h.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 5e609b876790..9f9f88f5d117 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -31,4 +31,5 @@ GenuineIntel-6-25,v3,westmereep-sp,core
 GenuineIntel-6-2F,v3,westmereex,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
-AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen3,core
+AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,amdzen3,core
+AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen4,core
-- 
2.34.1

