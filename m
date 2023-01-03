Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD5E65C992
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 23:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbjACWVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 17:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbjACWUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 17:20:24 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F17415FE6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 14:19:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BT5Aff5bp1Y+nA85/fO/q8DUDNokwnIDC+njA0bzbyjkxEOWERbVsjPdfqlElXqBnuVoWngUcp5imD+NhCdWX/RbqFeCKwLTX0/kbO1amx4Dnv6oMMCDAKXrr+O6SwmxLx+BUv8YCw//iC9oF6xl2PMMq0wC4ICnv+D0X6FRDnCUS3B1C+F+p1d5n5DbUGjncLCfCwLjR2Iv2CRTQPqS1nJHpp6ZWhxIzqd7VBrxJPzM/MUdElx4k97azuE8bNh2GBjDfv5pehgl9J4fPWYFzLG/ZeIrAYTrEfRZPhRXSUjf5Fl/oKw0HGw/KnPwLN9JVPFHtpXBdzdDXheqLsFiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owFI5WW0iZ7ADRKTLxiwUeFtCqLd8InZ4zFuMsMZkjU=;
 b=Si72h8NgM+4pv3IMZka6j2pdIEywh/RANIjrHtNWDqrVn4lqs/dIcofaUhUEtcrYcBHjtHqhSe3pCz56WJrceha9vJiH1tB9S1hdgfBHyZ4rsD3YGyNtXa4p4TlF2mljyzZKCeHX5ywW+7xEdH5vWVBtECKDTwXMYWnEFLPkjpnWKsp0PKrRhLAdMvaDUrIFPuzAuByLvL4kSm04hg+ZPeTbCI95ApiWbVfODyyp/RqZZraFbV5/vk59J1sRUQF8AMSq3R8aMpM0EvMCbN7LQD7yws/NKMesG+5bthTqLPDDqK752hpu9ecMX3och0GBdndU3UNzNUrNuYOuEVhz8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owFI5WW0iZ7ADRKTLxiwUeFtCqLd8InZ4zFuMsMZkjU=;
 b=3YFLN1DK20NXbWEtNinswJQ1sE+5XQjYmdpSwSHlDrYOSxqfPY6JDqwN0fTQOS2yS1tGB2OEf7ce1g2xVEZMweWrVxWIpFPJNEhFu8HvcPL7ov7BGj2K05ZKy/N7tkuehqJ++wv61rFxjGiZWEMjjbBzrK/vGfmQif/19rj8XJE=
Received: from DM6PR10CA0015.namprd10.prod.outlook.com (2603:10b6:5:60::28) by
 IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 22:19:46 +0000
Received: from DS1PEPF0000E654.namprd02.prod.outlook.com
 (2603:10b6:5:60:cafe::d0) by DM6PR10CA0015.outlook.office365.com
 (2603:10b6:5:60::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Tue, 3 Jan 2023 22:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E654.mail.protection.outlook.com (10.167.18.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Tue, 3 Jan 2023 22:19:46 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 16:19:45 -0600
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
Subject: [PATCH v4 16/27] drm/amd: Use `amdgpu_ucode_load` helper for GFX10
Date:   Tue, 3 Jan 2023 16:18:35 -0600
Message-ID: <20230103221852.22813-17-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230103221852.22813-1-mario.limonciello@amd.com>
References: <20230103221852.22813-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E654:EE_|IA1PR12MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6f8631-c0a8-4d37-7271-08daedd89f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdsjxwHfYwFvLAf/azkt3ToC870S1CtxzUMrnzSDN3SebMuUwwDaT1YuJuiEpmWwflROlfyogWZyYb91vtH4311HRygF7KTJ4toC76ZrxhJTgV0DcUlu1nSFm6yH0vZJ/ywIn44IYzZzARbtmactH4WbkUwwKgydFcf+67ELq9JsJt/1p4CjLRTEhkXGp81IpXzgZl4qiQcdPGGMAOYsl+AX4JJAfrpHwrAAeVC4wepEjTpY64AEOJsJQ1Y9tlig47rUz0rLVLxUkFTHx2lWpc+4Ct3ddv1rVkVmZOOGH1CdBzjxsktym0O9cYA40AeLkJfSIp5nVINk4jf88OJ46hH0ZIXAsAAoT0LhXJ4FBTbrBDxJI2LiHWcdbPxf0GGldD+Npvu0gcPAvAS1iierZpkeJIN4GakCD1bQbWBKGA3UnqFLzmDLQiJII1PppGqeIIbAJL6cDNVxkF12NnFx3ek+WvYFMxOQjdoYbB+FHZPdgu1r/qOyvdrtSHHVyeF5/E89+4xPwFdyAQjrSDt7tB49Rh6/us+Mom3ztdVYQUW2aiuwjYIlCQP//7rguMDaZTJ4ik8/GDFMpn0Ci23LfaX8nW9QDqDewvXG1RwAhB06tpbdOvNFwt6MBFkWs+WlWlRsjGA9QyCX7PIqDajcJ1c5XOwmtkGbKC0Hi3HfRtHOLg0aEbz84Wnp20FZ5VwwHOmCnWu+ZIJKwfuV5OwHlRNqH95OCRS0HsvjXoLDos0nViAGiQuRDMYU68cRBdgKmqkx8wV9PcQ87G5F/a31roLXdqaRm2TuwL8bV7tAAoM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(16526019)(26005)(6666004)(186003)(2906002)(478600001)(7696005)(54906003)(336012)(70206006)(2616005)(1076003)(4326008)(70586007)(8676002)(40460700003)(41300700001)(47076005)(426003)(316002)(40480700001)(83380400001)(5660300002)(82740400003)(36756003)(82310400005)(44832011)(110136005)(8936002)(36860700001)(81166007)(356005)(86362001)(22166009)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 22:19:46.3765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6f8631-c0a8-4d37-7271-08daedd89f1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E654.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `amdgpu_ucode_load` helper will ensure that the return code for
missing firmware is -ENODEV so that early_init can fail.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * New patch
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 35 ++++++--------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 49d34c7bbf20..5f6b59e23313 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4030,41 +4030,31 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp%s.bin", chip_name, wks);
-	err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
-	if (err)
-		goto out;
-	err = amdgpu_ucode_validate(adev->gfx.pfp_fw);
+	err = amdgpu_ucode_load(adev, &adev->gfx.pfp_fw, fw_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me%s.bin", chip_name, wks);
-	err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
-	if (err)
-		goto out;
-	err = amdgpu_ucode_validate(adev->gfx.me_fw);
+	err = amdgpu_ucode_load(adev, &adev->gfx.me_fw, fw_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_ME);
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce%s.bin", chip_name, wks);
-	err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
-	if (err)
-		goto out;
-	err = amdgpu_ucode_validate(adev->gfx.ce_fw);
+	err = amdgpu_ucode_load(adev, &adev->gfx.ce_fw, fw_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_CE);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
-		err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
-		if (err)
-			goto out;
+		err = amdgpu_ucode_load(adev, &adev->gfx.rlc_fw, fw_name);
 		/* don't check this.  There are apparently firmwares in the wild with
 		 * incorrect size in the header
 		 */
-		err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
+		if (err == -ENODEV)
+			goto out;
 		if (err)
 			dev_dbg(adev->dev,
 				"gfx10: amdgpu_ucode_validate() failed \"%s\"\n",
@@ -4078,21 +4068,15 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec%s.bin", chip_name, wks);
-	err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
-	if (err)
-		goto out;
-	err = amdgpu_ucode_validate(adev->gfx.mec_fw);
+	err = amdgpu_ucode_load(adev, &adev->gfx.mec_fw, fw_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1_JT);
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2%s.bin", chip_name, wks);
-	err = request_firmware(&adev->gfx.mec2_fw, fw_name, adev->dev);
+	err = amdgpu_ucode_load(adev, &adev->gfx.mec2_fw, fw_name);
 	if (!err) {
-		err = amdgpu_ucode_validate(adev->gfx.mec2_fw);
-		if (err)
-			goto out;
 		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
 		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
 	} else {
@@ -4103,9 +4087,6 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 	gfx_v10_0_check_fw_write_wait(adev);
 out:
 	if (err) {
-		dev_err(adev->dev,
-			"gfx10: Failed to init firmware \"%s\"\n",
-			fw_name);
 		release_firmware(adev->gfx.pfp_fw);
 		adev->gfx.pfp_fw = NULL;
 		release_firmware(adev->gfx.me_fw);
-- 
2.34.1

