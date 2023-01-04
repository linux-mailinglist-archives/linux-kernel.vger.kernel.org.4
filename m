Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4713D65DAA8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239922AbjADQsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239754AbjADQrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:47:07 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FDB43A18
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:45:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnbnTniOHtANeiD4Ge7puPWodtjLQn2DvZM5kDKl1C3+ratuDVTu/tAdA+CNeZ3Juo4/4+5XSEa3g+r1kUzrRDMsZJNC2BFc7MtZ70/f0zsWUhWvhAxPMGdCuNdyhFnrtSkbkPikctDxuzRMGuT/GWjQmXi6/TZItUaYBC92TQ4DxJDw1LjjI2SndQOjAeotH6fhQg2C/waHYN9BdWxI5GYcMlsPeJfliixzJEIqbr72xsluwpPOVrk2MNp31Q2iKb0N8aNpOEdt1cLD+SEQqmFucZAOkE/ZNawF3qUfobMsEC2HBfXXSBQm0n+lnvLXqfditZBcMPdprdqf1rWV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0OdBV0RYOpDJ+5mnXhWrtN8vEHDBZnpKlxrb98oruQ=;
 b=dw+qJZVXeJtuGFSy8IDZBZqeZJsDE/QU/nhH2wEbIOpD74h6BuyY3K4YaIojFd+GDHoUhiOIPQerMyso47x6aN2R9Lg9w5htxgvAgCNoBBJUXezMLHVXvJC1+X3toUWLOW+kIx0Bn/qdlowK3TP0FarQVgzyMllDvw2vTJ3eUVKx6tGDmcmDp5IyxiFFOcAWplWwvho2087R+rQuhPNl4QIzqP/ERvTyiV0lARi8fSOrFUbRe4uP1dV4Cj2vWJb2DOmeHa79BcGDqJ4g9mBybN1m69bFrqfBjZwGxH264n+AuHnagOlSrsjPjnyDN+z3BljadqBBzYjEPHOQskuMlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0OdBV0RYOpDJ+5mnXhWrtN8vEHDBZnpKlxrb98oruQ=;
 b=X1MOBJTggC7DgZ1r2HG9JWSMLi/Fc7EfSVH+BM7NLJCehTUw7cSAe7B7sl0PIBMaUk/uRDp6pg6/uR5cihG5Tm5l3tJZlVVNWQByH+g/pXff4TwyCE3SK/uAL1ZHC22lPzQ43TyWWV76IhOFfPxE5H1bM3YyUuJV5vueBogH56A=
Received: from MN2PR14CA0002.namprd14.prod.outlook.com (2603:10b6:208:23e::7)
 by SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 16:44:36 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:208:23e:cafe::83) by MN2PR14CA0002.outlook.office365.com
 (2603:10b6:208:23e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Wed, 4 Jan 2023 16:44:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Wed, 4 Jan 2023 16:44:36 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 10:44:34 -0600
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
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: [PATCH v5 40/45] drm/amd: Use `amdgpu_ucode_*` helpers for CGS
Date:   Wed, 4 Jan 2023 10:40:29 -0600
Message-ID: <20230104164042.30271-41-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230104164042.30271-1-mario.limonciello@amd.com>
References: <20230104164042.30271-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: 5646aa53-d8ce-474d-ce38-08daee72f6cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pqXqdnGtTTrhLNYAjx4uFp2zets09uj8umBMOj0L2h6glPN7Op95rIYm6TXTM3avkrdr5EGbiwt4lR876+T8z7gdEp+j+laiOQZfL/qevl9kxG0Cam3yQJJMVo55e77hw4X0kRqjuOYudsOHKTVA8mWRgVrP9XISVwrnaVMseUy7WrfemMj8QxbmuyO/jASx5Mcg/aWPqLULlFdQuLn/wmjHkJim4ekFhncPF2QQjbI9dAaHtKn9Eo5C09HIEnwxh/Mdyc5oZpUJiF0NOzmGgiMmqIWv5buWn1CuHgn3WIAj26/m70eKME/sjIqFh2+weLhjluPoVREy38uc2A2n8kyrspIAAe5xjJPA7Lxq21v+85IS0wAPud+nLJVEP3C/++/lrGpmEziiz+7YwZ2YxVfyTp44KKIL4XRW4cN11Q1d8xbzvx9HAi9WwZk5nNMLtuOQlUATcMHW7/yrP0kAU9ZULne+6cwxe4Q/62FfQZIaQz+7JzEh3PWHbxJKng5IE+V0DUdOUBal6R7itOzHvOKxEtRspM4iijBA3kuext/C5mDYbneLGn0AZ+WjgpcjlDwKrNMQbtsc3++G+eBDhdmmYKEEwlLcNlzkosabQ209o5idqlAGlWPo2LsdIaGmU4+1LuhyAEf8sEw18btDWsGk+WsJkapX957DC+kXravE+FkUZXjE7Bc432w/p64WmE285xHxONqAT0lbFjHBRjDVIbP3+NDv6XeE3w8HkfqRZAm3S4zoFHTYMojWQIlbZv4NV2ETqUzeCqNJP+k5MQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(16526019)(6666004)(26005)(186003)(1076003)(2616005)(478600001)(110136005)(7696005)(36860700001)(70586007)(70206006)(8676002)(4326008)(8936002)(47076005)(41300700001)(426003)(336012)(83380400001)(44832011)(5660300002)(2906002)(40480700001)(82740400003)(356005)(81166007)(86362001)(40460700003)(316002)(54906003)(36756003)(82310400005)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 16:44:36.0268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5646aa53-d8ce-474d-ce38-08daee72f6cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `amdgpu_ucode_request` helper will ensure that the return code for
missing firmware is -ENODEV so that early_init can fail.

The `amdgpu_ucode_release` helper is for symmetry on unloading.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index f1a050379190..151a313fc2a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -411,17 +411,10 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 				return -EINVAL;
 			}
 
-			err = request_firmware(&adev->pm.fw, fw_name, adev->dev);
-			if (err) {
-				DRM_ERROR("Failed to request firmware\n");
-				return err;
-			}
-
-			err = amdgpu_ucode_validate(adev->pm.fw);
+			err = amdgpu_ucode_request(adev, &adev->pm.fw, fw_name);
 			if (err) {
 				DRM_ERROR("Failed to load firmware \"%s\"", fw_name);
-				release_firmware(adev->pm.fw);
-				adev->pm.fw = NULL;
+				amdgpu_ucode_release(adev->pm.fw);
 				return err;
 			}
 
-- 
2.34.1

