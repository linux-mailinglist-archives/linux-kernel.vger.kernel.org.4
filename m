Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AC36012D3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJQPit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJQPio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:38:44 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D87A537D2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 08:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmwjjNv9fzok547CrFnknavXAtZl0XU91k577OQNyGJnqzTb/kjMKk7q6SypjKzSx2GlYxVD3YdYXpSCZVnBvENjPfOUieZJDFuHl42DvvfLLWi+afCgu4E5/p5SpCIsEvCnvEknffuIvWh3qM6sUi7PNNhXx/PoQXRY1LYOI8AGD/7N4dTMwVcltHv6TcguWbkz8QI0Inju1WghXAJSIWJYQGvjVlyOVGggb0/qGTS+czRkGR4o6rH3X1R8RXCTgZWbVL/PQB+5WiuZaFpmIhVZ3wsz0UHiMEErcXggmnLfTkGRuf3V/3K8zQEeEzaLsf8bqBa4aAp+Mg0XBRvwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6WVApdS6BGCmMOVhoXqBil3KBAnR7k5liuzeDdmD3Q=;
 b=bMXuGsW3aB1b0gx2FR/ugRIOCxJ472LlxaE1aeM/NKwNGw7K/HB8Yl5sDSAlEAG0ktE2j1LbPvB6kxVBE0/5Q2y31jCPNeoLjzI70yw216Xlcs2/iPhVwpRjRMAuliLpMcoVJGnhR3TE1IvstyuOatGYDuJp6CUTVXX/IBXorQ130HORrv7VzTaInD5BwhqbKqTUcav+5rS/GXCkaqu3SG1afqU9AO3P94ie48Qm9upVxVglRTajnrHtvqJIWH/tLmDFy1PMB3hT2hHcOw7/dFN9bc1yXnUTKRGFNJrB5SfiFHrVzWKyZXaSh23jCNk8tKjTbk4BNscLGnVsa+MlBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6WVApdS6BGCmMOVhoXqBil3KBAnR7k5liuzeDdmD3Q=;
 b=pXYZB0EGBcLOlSZNCgbfL0SkHyuvYmIttMWRFNVunBFXzVfyq6WXWbRgEvh4NNmZRUkGDojJVKqQq2RjZikMpNp/dOx7fa2MofH78f+d3MRniFnRc8nI8ljzT2Ndr1m/8gkb8YgrN0eo/8OI1K8LCFBrF4INN1mX2xzLvXMfmfo=
Received: from DM6PR02CA0073.namprd02.prod.outlook.com (2603:10b6:5:1f4::14)
 by BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 15:38:41 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::37) by DM6PR02CA0073.outlook.office365.com
 (2603:10b6:5:1f4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Mon, 17 Oct 2022 15:38:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 15:38:40 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 10:38:38 -0500
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     Roman Li <roman.li@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
        "Harry Wentland" <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alan Liu <HaoPing.Liu@amd.com>, Alex Hung <alex.hung@amd.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/amd/display: add an ASSERT() to irq service functions
Date:   Mon, 17 Oct 2022 11:38:35 -0400
Message-ID: <20221017153836.65515-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|BN9PR12MB5356:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da8b8f5-a00d-45e6-c0ca-08dab055aa92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QMx6xWspfjZEuipcuS03pxxRZw44jkZVkcubZMBvedWO7fp+sEmxHh/e3ehvSXkCEAo15LfZjfp4W3/3HF3DNhjaqyEUktDbRvdEucqwotRgibdJsAmtZaqxoJlXEJdtdLxDDC/+2iiC2kHVCbmlJIlhS7ztLg4P5+M3ihZxFdoqgfv9QopfskHtE+I7kNdxvIqH2nqrTBkLPIYNTUyO1PAXKt6WgGDnc4/lOIUW9r61pLLvdXJ9gyZ9fns7ouszoMH4z9x981chPlMuF7sILZGOAZv9Z0Y0t9qbPm6j6VdB9+fKKu7o9p/CGTnKR/YFNsNeaqpidSaUmAQWNz4wgi0bSsKR44URFD4RkgxQtRoerXLa0W+6uUgD/MM4HuBDijyBLM6skLWZVzZzLd96T8k5vovC3MSkynLKyuIt0NgzXhkqvSOYYdHhCoRkp/IX4yKDIVPvsD9rQ9JBkHE/lj5E5UjwJosfK67wf5604RDQyI99Gj68ev8fBzgFkBmbPBJzDhurTWNMtVWVr2Qwebz0QqWyOJ2XAgJWP967BOnULZVvNngzWwtv+cztcmWO/i+CscaO2KcTCiZB546ZU+6+vLAVZUrll7GC8ugcuyXLevEMruCzlsBkAnXSh79qUaJxs62UU1xpIyGe7upJ2yHuYdCn6c+kKH3qPRyHleOwSITzaNJqfVgUDQi304BK/yPunxTywqn6d9dxMNPYWkCh3Uvu/NsltCrq9jq/nJo+FT026HVj/pvW9yUl2fSkcoePJJspZvkJPKtuJQ54IeKisiIPSsz3ETu0q9DiWttMjncPb1zQZKZWPZeMvPi4kc6mS/WGZeksFTD0Wz0RQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(36860700001)(86362001)(2906002)(5660300002)(44832011)(82740400003)(336012)(2616005)(426003)(47076005)(16526019)(186003)(1076003)(6916009)(356005)(81166007)(83380400001)(26005)(7696005)(316002)(478600001)(54906003)(70206006)(70586007)(8936002)(82310400005)(40480700001)(41300700001)(4326008)(6666004)(40460700003)(8676002)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 15:38:40.6018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da8b8f5-a00d-45e6-c0ca-08dab055aa92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5356
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if we encounter unimplemented functions, it is difficult to
tell what caused them just by looking at dmesg and that is compounded by
the fact that it is often hard to reproduce said issues, for instance we
have had reports of this condition being triggered when removing a
secondary display that is setup in mirror mode and is connected using
usb-c. So, to have access to more detailed debugging information, add an
ASSERT() to dal_irq_service_ack() and dal_irq_service_set() that only
triggers when we encounter an unimplemented function.

Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
v2: detail specific instance that I'm interested in and use ASSERT()
    instead of WARN().
---
 .../gpu/drm/amd/display/dc/irq/irq_service.c    | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
index 7bad39bba86b..3d6ab4fd25cb 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
@@ -112,8 +112,15 @@ bool dal_irq_service_set(
 
 	dal_irq_service_ack(irq_service, source);
 
-	if (info->funcs && info->funcs->set)
+	if (info->funcs && info->funcs->set) {
+		if (info->funcs->set == dal_irq_service_dummy_set)
+			DC_LOG_WARNING("%s: src: %d, st: %d\n", __func__,
+				       source, enable);
+
+		ASSERT(info->funcs->set != dal_irq_service_dummy_set);
+
 		return info->funcs->set(irq_service, info, enable);
+	}
 
 	dal_irq_service_set_generic(irq_service, info, enable);
 
@@ -146,8 +153,14 @@ bool dal_irq_service_ack(
 		return false;
 	}
 
-	if (info->funcs && info->funcs->ack)
+	if (info->funcs && info->funcs->ack) {
+		if (info->funcs->ack == dal_irq_service_dummy_ack)
+			DC_LOG_WARNING("%s: src: %d\n", __func__, source);
+
+		ASSERT(info->funcs->ack != dal_irq_service_dummy_ack);
+
 		return info->funcs->ack(irq_service, info);
+	}
 
 	dal_irq_service_ack_generic(irq_service, info);
 
-- 
2.38.0

