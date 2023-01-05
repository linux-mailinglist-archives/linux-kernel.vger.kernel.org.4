Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65C465E439
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjAEDrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjAEDpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:45:44 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C07F4F100
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 19:45:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFx/a+59RVDaAstVrUDy12p/NMAPssmNoRR0JB40TqvHH+dAxNzZA+dH7J+sMb5S5rFixSTpCfiXMp1iD9kVv78O8CXUYoilyE9jynGcazJdFDZat/oi1cSl4HhIi5Bb+scHwOgmXrumT35sMZ3ROIUMf01ms4pdhBj4gwNPTdyqRCPRgjK7A68aNCR6c5ZkYZCw52qp6rrrBty8/eVYWpaFlsZ/aTwazlIa9+ifVVPBjCiTAyhhW3gn0Jbg03YgPhEfpCRb7QGOZGRBfx1hA+AVkzb46zMxacr2A+i60VLav6+CJY7Vt/eLKG7Djc3opiH4v+mFr4lyB9jV6NVPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L//ZsFpgQOYsSDONnOnKRjWrLXjvRmDRSiW54sB0xRk=;
 b=C3PSUxC3CnwIPY5HBY6ao+v3Lxv0pCSz/4FFeqwe3Zkg2/TeIc6Ujd7pkaXk+ZIxkepI8mI2BjBuCmPgPMXkSs98HXsy4fU5VLsUmMtOkpTqwAtKasrjKHUFw3z4+BpWomTv11ORd60+A5sgrJuSwdM3/f2QEcpc8IsYsyC0TWeRZwztLASi/bkciWCFYgVLExahVLUUTcF/lw09HA8SuPrlyn1Kl4zsPeU6X9lb5X4TZCCFQtZI3aMYJBx04VFLorrXXzPEX1SJM9ImF7wmm93KK0FTor8b4FVhbiDPmTnpkwGhTQnJLab3ZAZCHl/p0oUi7sfLaRwcUyJtgSwONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L//ZsFpgQOYsSDONnOnKRjWrLXjvRmDRSiW54sB0xRk=;
 b=Z+uYcZewGN37e3yLeOJWVS4Tp/ocIR0+W/sqnHx5FtvrOiva/asHwvGAiH/zq7dJLmrEEP3HRYNxSkgt6i27jpARvek6vAPCjezU945Y0UHzRuD892OWXW4HaY4gnO93D6j8iNaG0u32DumOnLLLB7VxOf8g0a/rQaCl4UNdxnk=
Received: from BN9PR03CA0554.namprd03.prod.outlook.com (2603:10b6:408:138::19)
 by SJ0PR12MB6965.namprd12.prod.outlook.com (2603:10b6:a03:448::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 03:45:08 +0000
Received: from BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::4e) by BN9PR03CA0554.outlook.office365.com
 (2603:10b6:408:138::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22 via Frontend
 Transport; Thu, 5 Jan 2023 03:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT077.mail.protection.outlook.com (10.13.177.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Thu, 5 Jan 2023 03:45:07 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 21:45:01 -0600
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
Subject: [PATCH v6 38/45] drm/amd: Use `amdgpu_ucode_*` helpers for UVD
Date:   Wed, 4 Jan 2023 21:43:12 -0600
Message-ID: <20230105034327.1439-39-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230105034327.1439-1-mario.limonciello@amd.com>
References: <20230105034327.1439-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT077:EE_|SJ0PR12MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: cef281ce-4341-4af6-418a-08daeecf3d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h3jTE+f8qRwYTrwXI+SrQi8HtGatYnS5BFtrfhgKdjMRrsBpPjYU8xMW8rvp7WcBi7SndKwm+0wgl5JFKcoqah5cDELRCBess7WFA5RLnx+nog3Juh+jnZXsvcqPQTsLjvHGVzKmY9vl5rmwyBHRQ9lOYFadAqQzAYppAbkozT2bT2S4ln4An+SjJIqlUIGtit32cyiAq8gecjes9d31D+g8x2VKRlpIKCGrmLJXUNK4lgTGAlgvUYi3+3rQ7hYLxC4iYCn3Vx68NYJCFLw2zmtKUBSOQw9QefBz/AOQ3Lh+8Y+TNY69yWxucS5VQzwp7ugf2/cB1Tb/4F+NdENdRxrFkvHTa8WrggMtckP6aPMq7HUZKubP2nhmd2vhygzT/fFQUV4Lcx43uSyCmUZTY8T6tK2X5A2B22VhOKBfZyul7dv1dbA1wmn01YeOb+idgbU6PrHD79jjswNFs3/s8jGpOBxg92vI0uteV1Q1oionYW8jOQsMF56ZrYyeeSEutWDon7njPTlnclNFNRqUdQ3eFDgYLXwfxGRgyCHfdUI8Unk9zAAnoBl37hudcGbSeaQYxgVQPcF7amZa4maznTMErbxo8nFyzHINr34HGFW92Ytbu9MASdSEqupcMChzor6PmC10MOH65IgOVZF0I+8v+00O2HNIvxFEFLwMyhE28hzvCZhcx6/GZgzYNmndJs1Yr7pK6tYCzt6X5WxlriTLGlZ7K5dJ6hKO1Lswurvh7qXWzZ5VMvT0E44Ka5cY+56sZ34qpz6JsikBFCJrwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(47076005)(83380400001)(426003)(82310400005)(16526019)(26005)(336012)(2616005)(186003)(6666004)(1076003)(40480700001)(7696005)(86362001)(40460700003)(36860700001)(36756003)(82740400003)(356005)(81166007)(41300700001)(4326008)(8676002)(2906002)(5660300002)(44832011)(8936002)(478600001)(70206006)(70586007)(316002)(54906003)(110136005)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 03:45:07.9336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cef281ce-4341-4af6-418a-08daeecf3d43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6965
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5->v6:
 * Adjust for amdgpu_ucode_release argument change
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 6eac649499d3..482fcf71d1c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -260,19 +260,11 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	r = request_firmware(&adev->uvd.fw, fw_name, adev->dev);
-	if (r) {
-		dev_err(adev->dev, "amdgpu_uvd: Can't load firmware \"%s\"\n",
-			fw_name);
-		return r;
-	}
-
-	r = amdgpu_ucode_validate(adev->uvd.fw);
+	r = amdgpu_ucode_request(adev, &adev->uvd.fw, fw_name);
 	if (r) {
 		dev_err(adev->dev, "amdgpu_uvd: Can't validate firmware \"%s\"\n",
 			fw_name);
-		release_firmware(adev->uvd.fw);
-		adev->uvd.fw = NULL;
+		amdgpu_ucode_release(&adev->uvd.fw);
 		return r;
 	}
 
@@ -394,7 +386,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
 			amdgpu_ring_fini(&adev->uvd.inst[j].ring_enc[i]);
 	}
 	amdgpu_bo_free_kernel(&adev->uvd.ib_bo, NULL, &addr);
-	release_firmware(adev->uvd.fw);
+	amdgpu_ucode_release(&adev->uvd.fw);
 
 	return 0;
 }
-- 
2.34.1

