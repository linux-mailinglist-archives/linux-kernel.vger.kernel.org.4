Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A0B63368D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiKVIEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiKVIEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:04:41 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5BC21828;
        Tue, 22 Nov 2022 00:04:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmSKF3192WP+IAQLPARikbsTzQ1z/Daz4jc55Rn8ZyMexluIptjZjyxWHsohIegBk3osnqEUMv1qDE01QM6SbzgTs40JkpxNu8sNlhspXzZ/fbiIETcL1V11iR1fE4yggsx/KfQl/HjpJ34DuysY6xtjH3sAaUH9+e/5APh8nz4g5CtqxNzpf2SO1oS+KZX108xV02JlHm52uLHXCXa2WFGuwC+VdCR48fYWW5dI4Ito6I8S+f6mLAVpBr0mTgS6g2SX76iVGhzPQ3ixWOAHLMHxncN+qXqn5nLCx2lOxvbSW17KIMtVcMbvcgHltTkurZa3eeD7zXybfKj/94m0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDu5X8DbMOBCv73AokZly/dE0dXRH8GnI+5xzL9UCIY=;
 b=CH/W4cnMyWMocjLfkxBOWutSJPC1OhVUFlGLYG2KGd8XHkvD1966W6pPGgOsJ8Y4nnNdKSz2ouo34RgnSs2D4g6hu0nnG74IXghqgWwyJfsGcpY4NOUFhhNhFNQrh1D2s493nsoHKwl4lB7th72p0OZN3bRKfayEOrV4+pmKvjnqNo8VIdQBhnj63G9RYgSL/4ALRjJCRXfloihPbVC8l6SaUy4rAa7HvSc4zvMBQ2N1C/nk3I4sbYPXYA/PAOy/UTQKoBvs6L+wkaglRgBaNGpZ8BtkUX6rA1/mX7DrI+2e7lffSHYBmt795ghkw5IvBparQqwu3kFAn6g1/rXE4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDu5X8DbMOBCv73AokZly/dE0dXRH8GnI+5xzL9UCIY=;
 b=CiAXCAM6Ifc0r8Ehvrrog+MfYhXOud5B5fuHynNN7ACYxVzI7EyUZ+F7VjWLTlZtYO6MIsayy7mzPo0dhCGctBsJbZZqxcrOPt4TXHpzjzMjeExbCZY7rsxJuK6HYHLqJkPYMJzDaTywYpdn8/PcDTQzgWYnonE2YqfZFHUTNPA=
Received: from MW4PR03CA0244.namprd03.prod.outlook.com (2603:10b6:303:b4::9)
 by MW4PR12MB7430.namprd12.prod.outlook.com (2603:10b6:303:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 08:04:36 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::3a) by MW4PR03CA0244.outlook.office365.com
 (2603:10b6:303:b4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 22 Nov 2022 08:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 08:04:36 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 22 Nov
 2022 02:04:32 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <jolsa@redhat.com>, <namhyung@kernel.org>,
        <bp@alien8.de>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH] perf/core: Don't allow grouping events from different hw pmus
Date:   Tue, 22 Nov 2022 13:33:26 +0530
Message-ID: <20221122080326.228-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|MW4PR12MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdda74f-9b20-429a-bab7-08dacc6032c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wv18gGpY1/WlTSdxb0oG402LjBmOePf8KrAdcCD5xG3DJUwOTtNlxGecrgLxpjMLw3piizeXW+2oyUBMUbQvLKml/bRsm3732ghx8CxUjLf0p2MIl2BYXrrvbpry4pPy3EHj1U5Qiu+BYZwam822Iy9aqM/btRJNujuY2wrhNNFRjF0ndEzTPaXL/hKQmHnHDbK5a0CM+38co9dyMTuoVBkqMysRcgW4LK1Mqr4BTyhJTWZci7r9/XbctlRLkVIUlPlKQpvglhKo0xhT3q72u3juE94IkR8OGYHfIpGMGZVM3p15cBvU29hb5EHA++3cmxotZsCGI7/X25cLmPABnY2KN33ccEdjx/x9AA+P0xmlXxZfAAXj+Se0HWA/IA409vcofZEORJvPOennIxJ6AH71guclTwU2P05YW7SRKJ8LWXPI2QlklB5ESo/XQkk3VwGM/yVtE5aN22E5jXkisbcS8jh3ZUQiALFEoD4u6cQcAt5qYn3ZfHZ50JnCvvtzO2j72J+6ChRJYKvJjw/kKrKD0Uu3O9AHZSPhtcoyKVuLo/xntY8hediXSJGiI1O8TrCKzAxzEHqKvNRU0hHBJXNXYjIoERphhomVsH4MdjeHC7MS0ZyQfF4alE+Gc446bUSxvJ30BJdPl9e9rt6f/2qPIPl9vJk0F2GK2PJeNq2cq4q+RA8Pg2+bRVWTXtOzpZ2+8xedkZadq0rBuoGcNK1CEa259QPC7QmnYsckLxw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(478600001)(54906003)(7696005)(6666004)(26005)(86362001)(82310400005)(40480700001)(4326008)(8936002)(41300700001)(70206006)(40460700003)(6916009)(70586007)(5660300002)(316002)(44832011)(8676002)(36756003)(2906002)(83380400001)(16526019)(36860700001)(82740400003)(2616005)(47076005)(1076003)(426003)(186003)(336012)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 08:04:36.5792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdda74f-9b20-429a-bab7-08dacc6032c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7430
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Event group from different hw pmus does not make sense and thus perf
has never allowed it. However, with recent rewrite that restriction
has been inadvertently removed. Fix it.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 kernel/events/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5f262f91cd31..4ee866ef075d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12499,15 +12499,21 @@ SYSCALL_DEFINE5(perf_event_open,
 			 * perf_event_pmu_context.
 			 */
 			pmu = group_leader->pmu_ctx->pmu;
-		} else if (!is_software_event(event) &&
-			is_software_event(group_leader) &&
-			(group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
-			/*
-			 * In case the group is a pure software group, and we
-			 * try to add a hardware event, move the whole group to
-			 * the hardware context.
-			 */
-			move_group = 1;
+		} else if (!is_software_event(event)) {
+			if (is_software_event(group_leader) &&
+			    (group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
+				/*
+				 * In case the group is a pure software group, and we
+				 * try to add a hardware event, move the whole group to
+				 * the hardware context.
+				 */
+				move_group = 1;
+			}
+
+			/* Don't allow group of multiple hw events from different pmus */
+			if (!in_software_context(group_leader) &&
+			    group_leader->pmu_ctx->pmu != pmu)
+				goto err_locked;
 		}
 	}
 
-- 
2.38.1

