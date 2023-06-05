Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E81F722EB4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjFESat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjFESaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:30:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CC9D3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 11:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvGkE3yjVtsOfLUuJ/Xzk9+cWcw07fIUS4coOB8r3e9gn6W9KnHkV2F1QLC+okQOabcC+fUZGYYXs+ZsvsycRWgBjaYwTzgn6esoknm4cufEC1pqKrMyycei28FKTw4m/HS+njxWLyQtkzbAiluJ0Tap3bGrNQM09T7eiHZbuXq7iCelZ0dHjkR9NXgZaWY6UOddW0PvQ2TRCUQ073CmYUbnhl6fHNt2I1THamiYFOw1g/lCkY+5EYQYBqmgqTy0P/sctciB7uEJUQUAC9c6BuufZhYD0WikTD7VyVZau0wev2L7vpm7Lb/kemMFN7Z2QX3y1N00IUeqUYytDJs8Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kzE+nv2w3IJ6pA6dosaCMc5GFlUjjXxgTDlJ4osg6E=;
 b=anGjcpRaUMTkR5kj7IXJV0zSXiXj410k83RySphuA6eXSB4bJa3Tw02j9Cx9AtYGogncyRghkucxwRMW576X8zXtHtZfpa4ykxizdGpoLla5QKsSm4RjTq2lCE6GLqsrPsf8+zCJV7Mh3UDHJ/VjiwwbeGY1Pc+8eqTI/pCNubDnBwGmEpbJn/kwaf0oUOsvLDg1ZRYAdk8vUSH8UnrfrvLEe9m337OIGEn5QobLjS6RbtAcNr2lQAZFP37QdpkN2Zz6G53HBsuwOPsApG0r5RZ842IKxi4Qmv872TUddiu2dcnlIZJz+J1kcEiSC5rRz1HXlJgeOoUiSfDfdhycUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kzE+nv2w3IJ6pA6dosaCMc5GFlUjjXxgTDlJ4osg6E=;
 b=nCJHIYQ2GcshyeLwttoewaJcvkbDWPFBHrsftS+jQM5Eu1N3oHKLcm6l5J0RP9tAtdb6vscU383M4vl5lIZfwmQFpl5kGld57LIFTpBtYk6cp/7pH9pNQQF8DenJDVtX65OtpWWFP1JNZQkCAzxIKz+aGaoHTsJVbMiufRFl/DQ=
Received: from DS7PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:3bb::17)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 18:30:42 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::2e) by DS7PR03CA0072.outlook.office365.com
 (2603:10b6:5:3bb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 18:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 18:30:42 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 13:30:36 -0500
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Charlene Liu <Charlene.Liu@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        "Paul Hsieh" <Paul.Hsieh@amd.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
        Jun Lei <Jun.Lei@amd.com>,
        Pavle Kotarac <Pavle.Kotarac@amd.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
Subject: [PATCH 1/2] drm/amd/display: mark dml31's UseMinimumDCFCLK() as noinline_for_stack
Date:   Mon, 5 Jun 2023 14:30:04 -0400
Message-ID: <20230605183007.204399-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f05a18-d0ed-488f-b125-08db65f2f841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EvTBFpUG9ZGfEMneAAX0da6Wzm/hVhPT4XWRhY12dU5l6BeB0Ujcyg76MjRpszsh+tdkZGoGcNvR7M8wU2zO/0Q3va3/HNM/9SwhamycHUSGZc3PAP3gROtkUMP3dEM+BQ04GWsGwsVa6YydOmL3gf4XBqR/5RlzawVzZrAhv6SNpO1hXKlzt0jB3WoHlSGkcFw8z7gKXuNRm0sJuHpdxANf1DBdnSZeyVJKsIOBvfJXph332SXUEqcF1f5XNec2fVep4T2PFrK5DG/q0wuFvBPA69tiJ5oUMKzZ3ZODXtP6ifRWMMyG6CS17gXSxTfRB18SRHgmhfDbUdZCaMPwVXrKI7DOMFYZ16PnpIfIhmQaOxgvXzpmnYPHTWG+hN0ryQiu9nNRTRCvzvlWFMAJujpxK/TGrJAWNzgO6KGbxUgxiL0s0AHHhmHijFRdZ91TiOHcY55zQb+cu1nfSEZsl0PmuuPSqA5WnHKL9oeAc1/m/aaHKVbEB9KyMNSA8fRofeVv3V+JYnmwQNL1RqvgWVlno4D/OJEZXecMTQzOA3ID7PrO//dc43YzLZm2/0U6ElB8wKAEX18Fwmmy4oZbu+Rx0Jzdrfp2EzIeuihWtVHseeKUPho8WI82xDFeV1KZjTPEKMIh/oOpqANJfax25dmYQKs9YDosf/lL0cYVWzIanFn9Z+rHvsov7fAw4o+J3kwu1iX4EiusMI013xe2Rsi6c/ujI5MbUGcFY+YfKv20brbi8OIMbiqKC3aqJQaTFi42ZX6BmBR6MxGxfLNc2ji6URr+2eUMTznsoueo/A0Ob+WEIvSxpnC+LXUIwOGj
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(8936002)(8676002)(478600001)(54906003)(41300700001)(5660300002)(6666004)(316002)(1076003)(16526019)(26005)(44832011)(7416002)(186003)(4326008)(70206006)(70586007)(6916009)(2616005)(83380400001)(40460700003)(2906002)(47076005)(336012)(426003)(81166007)(356005)(82740400003)(40480700001)(36860700001)(82310400005)(86362001)(36756003)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 18:30:42.3821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f05a18-d0ed-488f-b125-08db65f2f841
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang reports:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3797:6: error: stack frame size (2632) exceeds limit (2048) in 'dml31_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
 3797 | void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
      |      ^
1 error generated.

So, since UseMinimumDCFCLK() consumes a lot of stack space, mark it as
noinline_for_stack to prevent it from blowing up
dml31_ModeSupportAndSystemConfigurationFull()'s stack size.

Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 01603abd75bb..43016c462251 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -7032,7 +7032,7 @@ static double CalculateUrgentLatency(
 	return ret;
 }
 
-static void UseMinimumDCFCLK(
+static noinline_for_stack void UseMinimumDCFCLK(
 		struct display_mode_lib *mode_lib,
 		int MaxPrefetchMode,
 		int ReorderingBytes)
-- 
2.40.1

