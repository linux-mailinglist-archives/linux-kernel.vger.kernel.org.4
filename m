Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECB965F221
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbjAERE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjAERDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:03:32 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F60D559F7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:02:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msCcHLC8ksScFkjBqTHc1heC9W9NJNEKmeqZR3V6qOCQa+/u5OYvZCsa0fSnJZ5HKYRaOkHCrZnQ4dORBACvBNaOGcnrhTpVyDFXajt8osZ1K/YDMPeDNelB/IlBsQJdrdRSzF/WGTIxehB42qRuzd77F4bZcp+qKrP5iQv4B5+5rJBl/ne3RFskJVbpBUCOtkbpD5paR0XjTs9VpsZR3xU9BdNbtdOTInHkp1gDXqS+xKqld+XmBOssl6V/zhG2XlzicmucJ23UYffp19Dct2QGU+ImVoOjZiZG8rd6FJYoUrXVeQisjO/GpASYqTer/BVXpJ+TnnPnyl4cNUxwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yodnuGCZ87o1JuAMnZYYOGDIcQwNqxnsFF3l+uMFSN0=;
 b=SfujZpqjb45UyXU9gMYomeijhVJUwAKXakGkZ7lEEc4eJxQUtAIlNBeWxR/ndDuCSQuRUhr32zhao3UJfQjCvFHDmQ2Qeuabqxj1Me0yE3JNUsHU9LlAvBjFmrjHPpAPLIjRjg7eKsUeAQjTFXyYYLy0qZvQkQT+ympmAmUbnhYrxns8KHg65Ht+dyQOFQqKl8DvZumfdOvmHSeec998x0MHTB9clHWTRjr5aFE2F4895F2GhfjmMV3TRChtJ57ioZXxbZfV5vRSAvLtBV9a1s00RwbNjdaZxxvFJrWFo8WoAnL/yYhHgMBghIjKYV3hlVCbIV0s6U1GJTzom2dKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yodnuGCZ87o1JuAMnZYYOGDIcQwNqxnsFF3l+uMFSN0=;
 b=lzlb+iTDkHSWtTkZpa2jzNcKepaVj3VSwHxvz2L6xtDyTwhA+YhTL1E5VMrFqbJNKViS7wSDZJcl1ei11eZdXdAf9OerFax4/4yma0lFvV1RCSNm4xF5SEcmUJBf6FSxSvGfIOTexMs8nWoqYxZeQLIfpRCfKA9rpELQLlzJDx0=
Received: from BN9PR03CA0988.namprd03.prod.outlook.com (2603:10b6:408:109::33)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 17:02:40 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::c6) by BN9PR03CA0988.outlook.office365.com
 (2603:10b6:408:109::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Thu, 5 Jan 2023 17:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5966.17 via Frontend Transport; Thu, 5 Jan 2023 17:02:40 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 5 Jan
 2023 11:02:34 -0600
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
Subject: [PATCH v7 29/45] drm/amd: Use `amdgpu_ucode_*` helpers for GFX6
Date:   Thu, 5 Jan 2023 11:01:15 -0600
Message-ID: <20230105170138.717-30-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT032:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 4796421a-f869-46b4-c72f-08daef3ea79a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LCAfQfMJMFwiAXj6RM/ZoT+nsMRq2Ep9wRdF8bdNQrFnB/BBTK5q5QhTBECnukcepD4KCpeuETU1hEqwwkyuYfvo1j3lQHtJN8tsMPHTqmStbsrbLa/5O6aLbJk/wdVyQ1NeRcwLyKYBpQ/lMv/q8hEA/AVIQT2LL9QVnX/m83RCUlnadVnpkNfmU3p/DVS4diIj/EOP33WjAqmG9ymnACgupJstvA4ZZBOzwpmd7fvOm4lmYWdwfvYmpiS0TG+vuhUpybiRiLUAqwtBZ5+Bi/wi3Y/3MOsahNdIcD9P6H30tGKBgxiBtqvs/si2NBW6rYHr/zmR75+1eYfN/MnQk7XOw7YlNp+B4dBfHEQIu7nFVDYaD4vUC1ZwdiHEZ1lxCOx4872IgrhBWgq560+uGm50kdSwC568UVI2ludzR/sdCEnrLwprabOKBB6i2MIuXbckfDBiQmswuQrlAwvhiv3KwI5gHAXXO2sQgjIV+vD77Pg8g7qwZ0CXfOlbyyvUn9LFB7bsBjGt69+gaFn/xpgFUW0Q12qhG+eFPwq6uqBJGLH49JjigS2J5/PW3MVx2S1/2ScFjym1ixgctLtJxJqkQBJQgFSVDnnpzCxuh8hloMiU+ul/sGbxNGbyZFcNBtEyCUp8mr2aQV0brYc1RVjSURAkrd/ZbwCY2kSNHCiFoXQ3z2djwg0x3FQBdr3uH+BZeXc6/grW4WiiaKvjJAzL+exJFwc1Y3zb1jFjus3g+h0ovrgOGi4pNHiUDCVec30FgTFwaZ71UlTkwL0ecA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(5660300002)(2906002)(44832011)(8676002)(4326008)(8936002)(41300700001)(70586007)(316002)(110136005)(70206006)(54906003)(478600001)(26005)(186003)(336012)(16526019)(7696005)(40480700001)(6666004)(426003)(47076005)(83380400001)(1076003)(81166007)(356005)(82740400003)(2616005)(86362001)(82310400005)(36756003)(40460700003)(36860700001)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 17:02:40.4827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4796421a-f869-46b4-c72f-08daef3ea79a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041
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
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5->v6:
 * Adjust for amdgpu_ucode_release argument change
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 30 +++++++--------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 204b246f0e3f..438eab348fc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -338,10 +338,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-	err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
-	if (err)
-		goto out;
-	err = amdgpu_ucode_validate(adev->gfx.pfp_fw);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
 	if (err)
 		goto out;
 	cp_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.pfp_fw->data;
@@ -349,10 +346,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.pfp_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-	err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
-	if (err)
-		goto out;
-	err = amdgpu_ucode_validate(adev->gfx.me_fw);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
 	if (err)
 		goto out;
 	cp_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.me_fw->data;
@@ -360,10 +354,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.me_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-	err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
-	if (err)
-		goto out;
-	err = amdgpu_ucode_validate(adev->gfx.ce_fw);
+	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
 	if (err)
 		goto out;
 	cp_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.ce_fw->data;
@@ -371,10 +362,9 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.ce_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
-	err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
+	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
 	if (err)
 		goto out;
-	err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
 	rlc_hdr = (const struct rlc_firmware_header_v1_0 *)adev->gfx.rlc_fw->data;
 	adev->gfx.rlc_fw_version = le32_to_cpu(rlc_hdr->header.ucode_version);
 	adev->gfx.rlc_feature_version = le32_to_cpu(rlc_hdr->ucode_feature_version);
@@ -382,14 +372,10 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 out:
 	if (err) {
 		pr_err("gfx6: Failed to load firmware \"%s\"\n", fw_name);
-		release_firmware(adev->gfx.pfp_fw);
-		adev->gfx.pfp_fw = NULL;
-		release_firmware(adev->gfx.me_fw);
-		adev->gfx.me_fw = NULL;
-		release_firmware(adev->gfx.ce_fw);
-		adev->gfx.ce_fw = NULL;
-		release_firmware(adev->gfx.rlc_fw);
-		adev->gfx.rlc_fw = NULL;
+		amdgpu_ucode_release(&adev->gfx.pfp_fw);
+		amdgpu_ucode_release(&adev->gfx.me_fw);
+		amdgpu_ucode_release(&adev->gfx.ce_fw);
+		amdgpu_ucode_release(&adev->gfx.rlc_fw);
 	}
 	return err;
 }
-- 
2.34.1

