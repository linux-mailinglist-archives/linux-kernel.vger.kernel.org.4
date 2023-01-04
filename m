Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA7365DA92
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240118AbjADQpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239969AbjADQoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:44:18 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C85943185
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:43:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JG7u5tAS1F3NsVtOSgr4ywfKOpMxSnrGa0X9twgXs2FpQrVZR+8DwjtjvFuQk4FCniaObPd0xc1EgZHCF5GAGHjuwUisiRDFWDuVxx2/GpQUriamfv60JzmslHJDoa48jbAySEooUePSBWg6MwD+f3YiQbwGvp/cNgpchEfyKeSODfsVWvfZ+JcRJfwpdb4TJUUGD4JdWugtt+2v6AFosEBQoRIrHkyggqXeqn4nK5+7XZd4T5QN/iNjbaY1aHsdtWLxDJM6ir2rDwLobvTAkJS5yyE33O/dsrSg9s7J/Gom03ENX4ZIrL2SW5ar9BBg7clSUQC9F9ShacprJLLMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5tZzvWFUFU9Jcg17/eLNItQmoD+0xjyJ1Jwtysv6Uc=;
 b=ORLO9/FoT+4+711XohhtSUdbAix02UrRbBSJyWA7J862+QN906qvB4xJ9LYkjuJhHSqf5i0cRMB651o5kCjQVV2hUoDTh8X219W+D0D+mKOjmKmhGG68Pp3KPZ0h/kDWEdURxEbH8/nQci/a/R04MjnRiNio9hU1OfcR/uzs6w8PjIzZitRF/YRdTP77QOkN2TB1TJiV47fcY3Dr47BJYJlIl5L6dbjYlKsQHFYu9lFO5yLrzqPb0EPO0Jnw+U2aq+PaQgwBbNZBRLvWB3FAK+g9nANi7R389ZW2cKfwD3AUMsqYs9qQtTPfZ9h93NXydbpz3+IT8GbnSH56dJdFAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5tZzvWFUFU9Jcg17/eLNItQmoD+0xjyJ1Jwtysv6Uc=;
 b=v82tAkQnmjSuB2yjo55kCHAmFihz5f2kd/RgJA380sQ2wzHTSQEgTVHroomBxViPJEZzXKDZ0V8xfXWbyxxx8M5PRpWXua/4MK7C7MR+JsUgVR+eurin1R7JF3C5dzMyXAklGKw1Jt2Wg9bfZdsFX2IZoqOauq0x5oeKx9dQ3V4=
Received: from BN9PR03CA0604.namprd03.prod.outlook.com (2603:10b6:408:106::9)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 16:43:06 +0000
Received: from BL02EPF00010207.namprd05.prod.outlook.com
 (2603:10b6:408:106:cafe::3f) by BN9PR03CA0604.outlook.office365.com
 (2603:10b6:408:106::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Wed, 4 Jan 2023 16:43:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010207.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Wed, 4 Jan 2023 16:43:06 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 10:42:54 -0600
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
Subject: [PATCH v5 14/45] drm/amd: Use `amdgpu_ucode_*` helpers for GFX9
Date:   Wed, 4 Jan 2023 10:40:03 -0600
Message-ID: <20230104164042.30271-15-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00010207:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 32da0e1b-84d4-4ae6-1e3a-08daee72c141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yjgLU9IB8UrSZdUFn6Uu+LT96usstVjl+UCxvvpYfJUT2+aKFIQbgMniYFMKjlg8vYt7YrWDBN2YVfBn7EpHrsAk6idvj3tM+pcmNWD79Re1jQ/PwByA5apcHWOghqxiRsaL8rletOqq0BYBv9cOTEkU+3zgCtBEgefr6TxR560zCXeKpBryn6IFGZ51WDO+lAhc/tJzkctGUxni5OdCgLvqGNgRTwUpQwYbFLrbX2FsI+CEjjU5kGLO4N1qQXkqmKCSqxdvKM6AR+MeTNlG+fbxwRcP6tH4nVYHkk7ctj2Ts6Og6VPxw3t4ktX9bM1LvnsfneQHbF7V9lNXsuWZ2TeATEfmNFz4CF75zIEqBJ+ElkuGM2vWXUniBkx71Dlg8/9Sz3KIV+iGq1amARvAnw6Lj1XSC3hDO5aaVnyD/QAQDaHvMppxzeGogLcUcdugQXA4srGq2Jb+N44u2famA+CQ+MyE+fG+GesmQOXgVJOaxCZe8eZDeNIb4Og+b4SgA2K/fEhivYnpIg3uVldX2bzZkfhRmVoJAS5EQKrcDLQst2uT4O8A9yc6CSrlxhHWMjW+1Jbq5jZdsJallS8oHtD0oODVDAsRtlHtt0Xw403OTunASI07hKOLeyVXkLM+x8yPhWSTi18o0WFyagHrajtsWd2nP6RnL+VmVAmX9kzvVzxmRFUgP7IxHc7uI2mHBXNvmyRbSwZj5h8XgY4pA1W4IVy+2kDyklsMyvqYsMEV65ZyUnZcWgPKojBfxrjjCS4S23772Rn3jLxgWJCJAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(54906003)(26005)(186003)(478600001)(110136005)(1076003)(6666004)(2616005)(316002)(70206006)(70586007)(16526019)(4326008)(336012)(426003)(8936002)(5660300002)(83380400001)(44832011)(47076005)(41300700001)(2906002)(8676002)(36860700001)(82740400003)(40480700001)(356005)(81166007)(40460700003)(86362001)(7696005)(36756003)(82310400005)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 16:43:06.1674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32da0e1b-84d4-4ae6-1e3a-08daee72c141
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `amdgpu_ucode_request` helper will ensure that the return code for
missing firmware is -ENODEV so that early_init can fail.

The `amdgpu_ucode_release` helper will provide symmetry on unload.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 82 +++++++--------------------
 1 file changed, 21 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f202b45c413c..3ae46eab693c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1078,18 +1078,12 @@ static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 static void gfx_v9_0_free_microcode(struct amdgpu_device *adev)
 {
-	release_firmware(adev->gfx.pfp_fw);
-	adev->gfx.pfp_fw = NULL;
-	release_firmware(adev->gfx.me_fw);
-	adev->gfx.me_fw = NULL;
-	release_firmware(adev->gfx.ce_fw);
-	adev->gfx.ce_fw = NULL;
-	release_firmware(adev->gfx.rlc_fw);
-	adev->gfx.rlc_fw = NULL;
-	release_firmware(adev->gfx.mec_fw);
-	adev->gfx.mec_fw = NULL;
-	release_firmware(adev->gfx.mec2_fw);
-	adev->gfx.mec2_fw = NULL;
+	amdgpu_ucode_release(adev->gfx.pfp_fw);
+	amdgpu_ucode_release(adev->gfx.me_fw);
+	amdgpu_ucode_release(adev->gfx.ce_fw);
+	amdgpu_ucode_release(adev->gfx.rlc_fw);
+	amdgpu_ucode_release(adev->gfx.mec_fw);
+	amdgpu_ucode_release(adev->gfx.mec2_fw);
 
 	kfree(adev->gfx.rlc.register_list_format);
 }
@@ -1257,43 +1251,28 @@ static int gfx_v9_0_init_cp_gfx_microcode(struct amdgpu_device *adev,
 	int err;
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-	err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
-	if (err)
-		goto out;
-	err = amdgpu_ucode_validate(adev->gfx.pfp_fw);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-	err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
-	if (err)
-		goto out;
-	err = amdgpu_ucode_validate(adev->gfx.me_fw);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_ME);
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-	err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
-	if (err)
-		goto out;
-	err = amdgpu_ucode_validate(adev->gfx.ce_fw);
+	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_CE);
 
 out:
 	if (err) {
-		dev_err(adev->dev,
-			"gfx9: Failed to init firmware \"%s\"\n",
-			fw_name);
-		release_firmware(adev->gfx.pfp_fw);
-		adev->gfx.pfp_fw = NULL;
-		release_firmware(adev->gfx.me_fw);
-		adev->gfx.me_fw = NULL;
-		release_firmware(adev->gfx.ce_fw);
-		adev->gfx.ce_fw = NULL;
+		amdgpu_ucode_release(adev->gfx.pfp_fw);
+		amdgpu_ucode_release(adev->gfx.me_fw);
+		amdgpu_ucode_release(adev->gfx.ce_fw);
 	}
 	return err;
 }
@@ -1328,10 +1307,7 @@ static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_kicker_rlc.bin", chip_name);
 	else
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
-	err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
-	if (err)
-		goto out;
-	err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
+	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
 	if (err)
 		goto out;
 	rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
@@ -1340,13 +1316,9 @@ static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
 	version_minor = le16_to_cpu(rlc_hdr->header.header_version_minor);
 	err = amdgpu_gfx_rlc_init_microcode(adev, version_major, version_minor);
 out:
-	if (err) {
-		dev_err(adev->dev,
-			"gfx9: Failed to init firmware \"%s\"\n",
-			fw_name);
-		release_firmware(adev->gfx.rlc_fw);
-		adev->gfx.rlc_fw = NULL;
-	}
+	if (err)
+		amdgpu_ucode_release(adev->gfx.rlc_fw);
+
 	return err;
 }
 
@@ -1371,12 +1343,9 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
 	else
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
 
-	err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
 	if (err)
-		goto out;
-	err = amdgpu_ucode_validate(adev->gfx.mec_fw);
-	if (err)
-		goto out;
+		return err;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1_JT);
 
@@ -1386,11 +1355,8 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
 		else
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
 
-		err = request_firmware(&adev->gfx.mec2_fw, fw_name, adev->dev);
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
 		if (!err) {
-			err = amdgpu_ucode_validate(adev->gfx.mec2_fw);
-			if (err)
-				goto out;
 			amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
 			amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
 		} else {
@@ -1402,17 +1368,11 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
 		adev->gfx.mec2_feature_version = adev->gfx.mec_feature_version;
 	}
 
-out:
 	gfx_v9_0_check_if_need_gfxoff(adev);
 	gfx_v9_0_check_fw_write_wait(adev);
 	if (err) {
-		dev_err(adev->dev,
-			"gfx9: Failed to init firmware \"%s\"\n",
-			fw_name);
-		release_firmware(adev->gfx.mec_fw);
-		adev->gfx.mec_fw = NULL;
-		release_firmware(adev->gfx.mec2_fw);
-		adev->gfx.mec2_fw = NULL;
+		amdgpu_ucode_release(adev->gfx.mec_fw);
+		amdgpu_ucode_release(adev->gfx.mec2_fw);
 	}
 	return err;
 }
-- 
2.34.1

