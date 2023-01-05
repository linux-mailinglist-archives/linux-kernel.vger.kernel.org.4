Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5519C65F217
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjAEREC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjAERDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:03:11 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005DE32E88
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:02:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6WTXTQ4qT3AFebzqfxRG3L2DOtwY/zeN+cnQ0MizBbrDL7TV2TIYlHStcEevp3jPE/d4wo9oDy2DcEg0u3uc299WtGCzkFkFUdyOoo+w2VazT3SaAoPWxXDvEJWmXC+zHe4sdPwNLADSQVLcxlVQ4PQJFg4ZUNdYFrucF0bVfdowo0qYcuOzneKv46huyw7XO0AGQtl5x2JAS5H0jRTeCWcrjsPuFQNMzv24yoGLUVuyaN9/FCtCYQxpqNCH/NcRgRuFqHvOlUoXQ3PPhzCXtDB/7bvZrKzvQMLltxxBwDJRbP4hX57NijX9SvAMWAJNZ2hiCOoPKQ2kflARPIAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/9pw9tosB9s0uNTOJlk36kKQor2G8SMBda25Ae3eU8=;
 b=D5tXgZ4DYlh+IKIfoXmyTX4b8JaZgndZnFmbO9wwcCxyQftRIpSTxQ2Fppp8JKXHZDscg2hhu4ZyrkyVCKOe9XP6/54RwqBfCP0QdRJ8cQpIRSOTVEBK8iPGkix44xIxyditjyuwGnK21NnWdUi8Y0tMYbYwnO6WfBEGs66F3Vr7QxQ4LF858zcs7ipmk/UCrErg+4WhUDHfS9STso7nzJMUFFyFELUIt6Pc0LzX0f4p48Qs3gABujHbnxj7J7cPVPd6Kd2WXsanhkhM3HIGNiOZvDOYq9H37qeOGbDhu+zsFwFI1nUeXJFpIdwKsL45btGlKz6DRG2J6R5KNv3YHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/9pw9tosB9s0uNTOJlk36kKQor2G8SMBda25Ae3eU8=;
 b=HMBKcdBG6RRnHwcMyJ4S/fQ+bpOQIoY4vE8jgRecpYQ8ecrHJEWXg6n2UhMVy0nzxGOV9IgTadh+3f+8Zw9nCAWnyrRQkGcytCoTPufGIpw9lwcBMjRPRR32qMu2U2v3AIr7LVMOdcpLjtYl5umqdg79cKWwXMRAkju5xUrHB1U=
Received: from BN9PR03CA0964.namprd03.prod.outlook.com (2603:10b6:408:109::9)
 by CH0PR12MB5299.namprd12.prod.outlook.com (2603:10b6:610:d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 17:02:35 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::1e) by BN9PR03CA0964.outlook.office365.com
 (2603:10b6:408:109::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Thu, 5 Jan 2023 17:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5966.17 via Frontend Transport; Thu, 5 Jan 2023 17:02:35 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 5 Jan
 2023 11:02:24 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        <linux-kernel@vger.kernel.org>
CC:     Javier Martinez Canillas <javierm@redhat.com>,
        Carlos Soriano Sanchez <csoriano@redhat.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>, <christian.koenig@amd.com>,
        Lazar Lijo <Lijo.Lazar@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Lijo Lazar" <lijo.lazar@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>
Subject: [PATCH v7 21/45] drm/amd: Avoid BUG() for case of SRIOV missing IP version
Date:   Thu, 5 Jan 2023 11:01:07 -0600
Message-ID: <20230105170138.717-22-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230105170138.717-1-mario.limonciello@amd.com>
References: <20230105170138.717-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT032:EE_|CH0PR12MB5299:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c12a90-ed3f-4939-d3b0-08daef3ea48c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3o2dav2Ha4vFWi1Qc7Mh4VYTpT80Va2xA2DfKsqZW2JGCt7BRre3EGy2bvgDn560Qz3SFaG/H//fHv0oShS0oZWg9IkGi4On1cNguJOJZLDnD8nfNEUsY1eabt1/aad9KrWHVb1ZurKPJsvFscAlJPcAIUbRGPQ/C4n1fxmjrapLk1b+x9iYjTNdvt1ubhtk0HozODYQJcgGsKoTTRJFW0UbGdNKw+ZP7BQk0OOWsZSdXL4Wh2J74ffxgRP3QOfqufUmICAIPEYOfG4hUakROVDj8tLVFHf2+Qqp1BC1u5ZlaAiGRJD5IpLrhm6EkUhPM5QemwkkwJqUb3aNViKPATCl4n2WXM7NO6hfU4hTzwtKZwIfZh26wZYEcNBwPSZpp5zzbwN/PIEi55VCQ8QzwTQ/Lw0Ns8C+QQYvFMmDe9C1pHLMdLOkvl/+dueotaXkao4Jf3rn3bM/Fx667IBvBm8Bp9AsoKSjPCzTtauYKzbzrW5BPR4aDkBLM+le5p3SQA0SN5TTs2R0TuKav8qpKm9/LPuAO6i52wEUG2N/nXjwwY7gImeLSBhVHESAhrGJAUZin4GXbVpjEq0a9+P95+YnPDwlxkfSlYpbWLByYrwR85oKrZlRVT/g21RfONaQbHowTriCo8rGwqsUHW96hala+a23L8Dlf1xArkwgUlrSKh0e9/ZDYHywdkFGt36abk1wIToCYK/9rtA0bkMYEw+huRsKxRZO3dlHgoaSTM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(70586007)(316002)(186003)(70206006)(4326008)(2906002)(54906003)(110136005)(4744005)(5660300002)(44832011)(478600001)(26005)(6666004)(41300700001)(16526019)(7696005)(426003)(86362001)(40480700001)(36860700001)(83380400001)(336012)(2616005)(1076003)(82740400003)(81166007)(8676002)(36756003)(40460700003)(356005)(47076005)(8936002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 17:02:35.3581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c12a90-ed3f-4939-d3b0-08daef3ea48c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5299
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to crash the kernel.  AMDGPU will now fail to probe.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index bdc2bf87a286..8b2f1783f93b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -380,7 +380,7 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
 		adev->virt.autoload_ucode_id = AMDGPU_UCODE_ID_CP_MES1_DATA;
 		break;
 	default:
-		BUG();
+		ret = -EINVAL;
 		break;
 	}
 	return ret;
-- 
2.34.1

