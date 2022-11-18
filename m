Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3637762ED1A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 06:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240329AbiKRFQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 00:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbiKRFQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 00:16:04 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE21597A94;
        Thu, 17 Nov 2022 21:16:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hf7hCy20kN6nb4iob6A/q8dV3gi/2bcF/ec3nA0YAnqslSgk2xTdFy2/v6vZsw7sCU4+v9iQ+JSDp5zOY7LN+LRW0jk0sQLJKqlPlxKS1RWeRUtcdmtqJbjUAHyedDLC6cXW2BLakwMUJnEbpWHkvMMd8EdWAgPptx0YJMiIr5nRLOnzDyJjj4/cmsexel1tvkK3e1dbAshkhYwRJXC6GHtuvoKbIAm/oWhntxa9ldHYDZdJOUyf6iJwlVG8wH56prS8cq1r1afxJI7ivHmbSmqNDVkZpHXFnKfpL6MzrGJbT0pblCK7FBmUdBYMv4thDQf/zIVCLDGPlZEoEDwt6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Os9Hza53Kna27NSFvmIvLbNUy5I9z9Rd4I0FmBi8tA=;
 b=IoK9068ePwkva5mDOS55jeMZdibqz3NOqWp2IdBYeiSsTPpYT1DJGCVyaZd6yXQU8pXnrUfj7evmqbhjjALajWMukTqTgHHV1zmfD1xm5XwXWsNSViFSXcprUNTgtSmB/3JgtfBvaa4rQwSwnrYqAezYR1PNbbTUhmUuKzGfLz/8yBYKiYdhdonK3ydc5PnVesfJdjcbDWDWeMl5Z5qrwoJo5dUdhfyKTxx3SYF6ivbNOs1CMY3lW2hnFngU1Ig20TE35yKmt6Kg8TXBJiUDgwzpENttTHUFvzbZqp6GCFVBRvfF2bU5Diqc4SVVp+SJD1n6fncScIxXexJJ3KZcLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Os9Hza53Kna27NSFvmIvLbNUy5I9z9Rd4I0FmBi8tA=;
 b=dpDqccaYOT7h7wnDx8PDDIj6ab+lVUJbPE7Pw9tjP6gX3uQav1x9PA9czUH3TbfeVwAFUgyyoWb99hEi1PJTmV1ov8NqArIlMuFef79UyiJqrLYhtv45TyZNc/ns3FFepkWPu/nom0h+LNZcAoo7lwVrGocfpzdiRmtHTtOAT3s=
Received: from BN9PR03CA0796.namprd03.prod.outlook.com (2603:10b6:408:13f::21)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 05:16:01 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::1d) by BN9PR03CA0796.outlook.office365.com
 (2603:10b6:408:13f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Fri, 18 Nov 2022 05:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 05:16:01 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 23:15:57 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <error27@gmail.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH] perf core: Return error pointer if inherit_event() fails to find pmu_ctx
Date:   Fri, 18 Nov 2022 10:45:39 +0530
Message-ID: <20221118051539.820-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3f4cf4a9-55c7-2d47-19ca-cc2edadf95bb@amd.com>
References: <3f4cf4a9-55c7-2d47-19ca-cc2edadf95bb@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: b2805ec1-1c01-44ea-56bf-08dac923fbd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5SojCEIecEY0zoF5EFW8xTNTR2LLlLJn5f1hyxVhHtJjWOYAM97WnZyQDKPizf/2TTSmCX2LOqoZPCALcJbTrlqhjafR7Ty0KFXvPBN8p5uX9bHo25/3ycXH5EGCl95/SLQ3CIAnD44qz3gQYhKU4a53wnzRosEyyrCqBC/LTtBt3qmcQRvp+WB8JuS16xKma45sgxuf4B4TdEhOMShij3GBGBWakCt1jfrp70nBQdh+Ho4TnzrGeHSK74/LIpxR7AfKpNhtrI7ne/QiZz5Yp5VXbJzev1ZX4fBB51zxJO6HShv06FVUQ/3Zq1qGMJCKokhBoiXm9QYpgeVpgyO5X0ebZjWjK4v3TERwLO6+Vymhvv4DN3eAkK3/QW7u8tKh1Sawxo/bNXQ80kQAw/kHpiodn5YjTj2n+r1OmwrFD78sTmcF3MygwjAm0tg8hQ4zYpUgyjx/w0E4Z2PhKMPs+lOg2FKfpKb73a1HV5JyrqbXcVMNr28FdGrHRak1mjiJg8fhLjUiSs0K5Ril3tuWPX6UQuCrxHEtd0aGdvGnQj8V/rC2mrZ/jQn8cHuQvfL5WszhnLW+RKSgc5H+RpNDca4Py71tSk1a9bxd/ip71flLDZZiL40ffQ5e9Qarzf0u0Ch4frht9EK1NIaxG7PV/4AQ0RNIhvBQ1AMKBRw/oQsu6AOVv+Liu4ikfsU75jJjvTQTQEltPXBRrMxbGDpRVOkKyYQPDIVnSF/+2HbHET1jEFgkaf2PVJFKSRgYEr3w
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(1076003)(47076005)(2616005)(36756003)(26005)(336012)(426003)(186003)(16526019)(86362001)(316002)(82740400003)(82310400005)(40480700001)(356005)(81166007)(83380400001)(6666004)(7696005)(8936002)(36860700001)(2906002)(44832011)(6916009)(4744005)(478600001)(4326008)(41300700001)(5660300002)(70206006)(54906003)(40460700003)(8676002)(70586007)(37363002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 05:16:01.1847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2805ec1-1c01-44ea-56bf-08dac923fbd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inherit_event() returns NULL only when it finds orphaned events
otherwise it returns either valid child_event pointer or an error
pointer. Follow the same when it fails to find pmu_ctx.

Reported-by: Dan Carpenter <error27@gmail.com>
Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5f262f91cd31..ce75288cdbae 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13175,7 +13175,7 @@ inherit_event(struct perf_event *parent_event,
 	pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
 	if (IS_ERR(pmu_ctx)) {
 		free_event(child_event);
-		return NULL;
+		return ERR_CAST(pmu_ctx);
 	}
 	child_event->pmu_ctx = pmu_ctx;
 
-- 
2.37.3

