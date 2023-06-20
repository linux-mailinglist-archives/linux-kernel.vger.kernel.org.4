Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2908773677C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjFTJRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjFTJRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:17:41 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F01D118;
        Tue, 20 Jun 2023 02:17:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQZIYtsoTLGWjqcwWJ4J4xRJKIYCR3hl0XBdrGXF5vfa/5pM+TyilMKjaC8V4weRzOAwnP12g3SC6JoV+WS3gmGPrC/feZM94TvPlXUORaJXWHvHaAgWZSteBISklzbPlcQJryfCihfYewnthgkwzO28bTvlkNOBtEKy1WoUhTWBzsY6tRjAD+NVdrik6WGOxxtvkaGvOfZnLtITm1RioGoE5EHytGsKtahwZgTlHbtOnMQHEgV6HpCOP1kMbpww1MzvqFSIN4SEuA+vagp1ryEO1n1PcW862zeAE/b7yO87hhIZVOwrjK521ZcYCjcUaHu+q/ZK3s/JumuGRrBAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeTBvG7R616+0p6sBWqCbNMdYVuefjMqfvrbqUWT1d8=;
 b=JVWJet7Ekj9BinlaqXN+W2WPWwkFsc1vySqgMUN1YAJWJudv1z6qlG/Giz35FRIJpZdgVpMO/VzZWHPGnEkmqhEQDwAgdWipuKR6Ok4Fd8bqQSTUwQG7Ckh9s+FJuvmOdcAMko1p2y+Vwnf9a2BJY7HhWTqwhUMwyhzLgEUvGuWgSa+XVxULaFRZdo5NMnL6DsFZucuxbXi4Olc1pPG58kxcCS8eKhKZbssxjdxG5obBPalMIb80UA6m8bDCK8tq/99ShRZX5eiUpDMAyLsft9WsFu0Qr3YZQG4MHc1YZhCYS+Pq3lkjC3WKthphJWY8Nb13LhgPF58HwZbtcSyhYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeTBvG7R616+0p6sBWqCbNMdYVuefjMqfvrbqUWT1d8=;
 b=xHy9rl67RoLbndl5LxQvyLSMEsR8gJrbQp+3P++32CmYvRR8H9O/KaVT5KkT8ruaNUrbF3payAVNyvjOlsuj97sTeqfsD2uWoL78uDuzZyedq5G9wJgjcm3xI68tQ2nsVO0+i3hYwtidNpLppJhxL6ZQf6EeOS5ec8gYQSuTaug=
Received: from MW4PR02CA0009.namprd02.prod.outlook.com (2603:10b6:303:16d::20)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 09:16:53 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::5d) by MW4PR02CA0009.outlook.office365.com
 (2603:10b6:303:16d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 09:16:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 09:16:52 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 04:16:48 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <acme@kernel.org>, <irogers@google.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <bp@alien8.de>,
        <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH] perf/amd: Prevent grouping of IBS events
Date:   Tue, 20 Jun 2023 14:46:03 +0530
Message-ID: <20230620091603.269-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 3981712b-bc01-4870-5b1a-08db716f163d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsvmXMGHRw18T56FPDiEZBRHcTrf2r7IVKwZvPJhBUQSZlvEbjPDMxeyUQXwCqdRNQKhDVCDVSVHIr0wBS5oU7O73KwH7+gYSr6uuJ6fS9dWLzKvxzDBCm3naW8jUz0r6y31sB/hCxH8ONWXAJQTF3B18zLaMI0cwDuykybck39G87vnG77nd1xHYjmjhpp2WmqXXRYXVx/s4mJu5JK9rPFRBBRnfDyXG/yu3ClgdVx3ZooaDz4xO05+uxp45Mo/MEpn7qoR5wKhHH55/Nr3KdkKXUO5/fevHW6sYrkE843stqs0dzHKrRU/iHPPFBkEWmMrkrNXB7bYjX9Y0t3CAxO26/goNHlEB96T0K+v5D0Jl8QENUbhKbpy2klS6aFZZVtq66ZddqkwSX3WVyU5yyXwvD/H19thjfzEfBQ49qnl+rMON4ScjxXASUefOIDpWQdQDYVr8OkI9U3dkQQPguiFv59sl8u7HP9gB0iI6AJV1U1a7pkDGtCDRHyGuc4yDEcNmNOckC2LFaRe84fkPXwVtd8eKqrMNKevtuXae6pO55UTk2WHk/Z/qHCjL0RWPhjo886RYc6iDMWr7xUCR6F/VyoQPg5CriWgkcOnnrUxGjA69NOcv/aiA5+2Fz0as/3KNfwmD0hHwFiWleJEsrVA0nn7JLqL843Lj2TZYNnhW+obReBzfRChr6LmmT2xzoP+fyUxQbXaqaCiqpSaCoFzdqeikZX9IHnpK4H/gmiz6kQX+L9WE2UarkUZAvxkvHPJiiBGG55UE9MaVyYnDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(47076005)(83380400001)(7696005)(54906003)(6666004)(316002)(8676002)(8936002)(36756003)(86362001)(26005)(1076003)(4326008)(186003)(16526019)(426003)(6916009)(41300700001)(5660300002)(2616005)(82310400005)(336012)(70586007)(44832011)(70206006)(82740400003)(40460700003)(81166007)(356005)(40480700001)(478600001)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 09:16:52.9766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3981712b-bc01-4870-5b1a-08db716f163d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
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

IBS PMUs can have only one event active at any point in time. Restrict
grouping of multiple IBS events.

Reported-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 371014802191..74e664266753 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -247,11 +247,33 @@ int forward_event_to_ibs(struct perf_event *event)
 	return -ENOENT;
 }
 
+/*
+ * Grouping of IBS events is not possible since IBS can have only
+ * one event active at any point in time.
+ */
+static int validate_group(struct perf_event *event)
+{
+	struct perf_event *sibling;
+
+	if (event->group_leader == event)
+		return 0;
+
+	if (event->group_leader->pmu == event->pmu)
+		return -EINVAL;
+
+	for_each_sibling_event(sibling, event->group_leader) {
+		if (sibling->pmu == event->pmu)
+			return -EINVAL;
+	}
+	return 0;
+}
+
 static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_ibs *perf_ibs;
 	u64 max_cnt, config;
+	int ret;
 
 	perf_ibs = get_ibs_pmu(event->attr.type);
 	if (!perf_ibs)
@@ -265,6 +287,10 @@ static int perf_ibs_init(struct perf_event *event)
 	if (config & ~perf_ibs->config_mask)
 		return -EINVAL;
 
+	ret = validate_group(event);
+	if (ret)
+		return ret;
+
 	if (hwc->sample_period) {
 		if (config & perf_ibs->cnt_mask)
 			/* raw max_cnt may not be set */
-- 
2.41.0

