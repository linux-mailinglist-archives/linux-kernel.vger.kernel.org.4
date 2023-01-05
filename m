Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6FD65E433
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjAEDrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjAEDpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:45:39 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7561F49159
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 19:44:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzWCKs102LuCONxGMJMoLoXg1OOyWEZgofP10Fqrfd5FQjz4oLabJ1yl81GvlvmEOZclaHdow4nY1ZLX9hUQ86PU+BxQpZrq+HU8s2ldzKTy5uc5hYw/sTU8k54hDvY1U/PXw3+utZavGHFgHdArl7NZ8JcAdCHkgUG1EThwOeHHV55mQVVLIhsaUbQbfFN1PvxBYlemzNM6ekj67RsXVxEqlyy5OCT0B4FsB/bmInF2VfukpZNoJdrAQZybk1Xa2Kbg6rwaBMlY4OvpozIwg9YxRcaAbgABT+7sYLhEEwjz3sx5zbYs063LHSeX030mk+Ht/c1jaKmRiSvf52HJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTFn+vfrPPhT1/97EvqnIqglkwTWz1we5AmNKmyXRTA=;
 b=iGvlzlCju5tY7CN9E+WGByBMHqDyY1dnhk6L1NI/FgkivCKsEb3kneTxyK7AnUMDmT2LlghTcQvI9ixzovOSn6qZCUfveB2ABqHmuv42lBPJvi81r6URTZC1kE82nyk+UrbZGpEOxQJxdNYb/3wUsEe7IDUqiJmMyAYKG0xr4yz2InIfapkmjC0rmCTClPUAAIMBZc+9v+mjPpxAX16xoTE11yeXaxtFAKbDpzZUulBVORUXPuB+WwbE+anS2nIEfMsu/sXPs82kzTZvQk7cNTBxKv/Tu6NAaKgRW03f3kpZNV1P/vXLAnb5sb6Ckj5Ntc8Ftt0WkHCS1tNLt7Fjfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTFn+vfrPPhT1/97EvqnIqglkwTWz1we5AmNKmyXRTA=;
 b=nWVGjsdr97oH9pt9tTDA85GtqGZQaZcirC0I7NoAQGkwURpKYJduyHOVQ04PlpdKH14LXPw5gu4Vdpv7Eqe1WQTB1AeyYXrWSD44IULRCu3+rsvwPHZsf/0GF51NTPf01f7iAhVWOh6bLZAL6rl+PnkBZmHhMX6L2EeUVE1KaHo=
Received: from BN9PR03CA0247.namprd03.prod.outlook.com (2603:10b6:408:ff::12)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 03:44:55 +0000
Received: from BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::23) by BN9PR03CA0247.outlook.office365.com
 (2603:10b6:408:ff::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 03:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT086.mail.protection.outlook.com (10.13.176.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Thu, 5 Jan 2023 03:44:54 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 21:44:53 -0600
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
Subject: [PATCH v6 33/45] drm/amd: Use `amdgpu_ucode_*` helpers for GMC7
Date:   Wed, 4 Jan 2023 21:43:07 -0600
Message-ID: <20230105034327.1439-34-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT086:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 5913e84e-3f4b-4d5f-8f27-08daeecf3578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nwmmSFzNSlr+Tyyl8Zd5V9fQ4dc/fbFVQPstCcjAAyqIQ5ml9WTgZByJtHYeoWI7s9pprRF8XJxLode+YF9XFEfv/zV09vuVIkZNlbUTj+mQl8+XrjgGBFxzrpu0fAETr9jeaQ5J8ayZP49ad5BiGgNc3F2R5jpI+saJ+1b9GjjE2+gg356Qwu62z+vd1XYTWJ9H9NSNhFlyKJzpfYk0hYbTw0vVaM0iBv/VIkrPOsXXvwokd9X7R+Vy06YuGQRa+P+Pvz1V7GLzqq3OX9zqiicn3gjy7GwxkUzGDtYxJY4WcofOB0goi9feavINRw2bScEz5qvVSHOxZdav/WC83QLpECIdevV+0MDyVMZ1QwOikNnVvEcFDqgssT1kPwIVlsOg2UUJaUGKAyUhdn8AvPr4o2Vvvu0ivpO3vA+s32uXArvqBMury6V87W8BiBD0nEzQib8NqwKUgW0f6UXz/zZ9UHbJLxIk/lvXqmuuKtUOUVY+fHgUaU4v7ICINbxyLF6ax81YKcfURiUMt+RUHsYS3UGEsF0Vm+IfVq2K0x3t/XnujbXJkublMlisi+Q77vdQYk02TCKGtAJUANxLBpmQs8vdY4OcsMs7xnay9KJGOnoL5EV9/Ew2qEvaxRaNUKiuU3mQ9N7313pwG3X4gKBsmjMeFMcCc/1Jyc3LIllLhFbAEQbL0oK2M1ZYGLI0kbSUAtCWcSQhPAIAXlL1ju9S7H8tc646rybLPzbOHDU+JyQ9EUlSmtRcpONwXrozBHsG/AM2s9fOzajBhrcmyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(54906003)(186003)(26005)(1076003)(110136005)(6666004)(70206006)(478600001)(2616005)(16526019)(4326008)(83380400001)(336012)(44832011)(8676002)(8936002)(426003)(5660300002)(47076005)(41300700001)(2906002)(316002)(70586007)(36860700001)(82740400003)(40480700001)(356005)(81166007)(40460700003)(86362001)(7696005)(36756003)(82310400005)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 03:44:54.8455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5913e84e-3f4b-4d5f-8f27-08daeecf3578
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
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
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 979da6f510e8..4412e8c65726 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -156,16 +156,10 @@ static int gmc_v7_0_init_microcode(struct amdgpu_device *adev)
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", chip_name);
 
-	err = request_firmware(&adev->gmc.fw, fw_name, adev->dev);
-	if (err)
-		goto out;
-	err = amdgpu_ucode_validate(adev->gmc.fw);
-
-out:
+	err = amdgpu_ucode_request(adev, &adev->gmc.fw, fw_name);
 	if (err) {
 		pr_err("cik_mc: Failed to load firmware \"%s\"\n", fw_name);
-		release_firmware(adev->gmc.fw);
-		adev->gmc.fw = NULL;
+		amdgpu_ucode_release(&adev->gmc.fw);
 	}
 	return err;
 }
@@ -1081,8 +1075,7 @@ static int gmc_v7_0_sw_fini(void *handle)
 	kfree(adev->gmc.vm_fault_info);
 	amdgpu_gart_table_vram_free(adev);
 	amdgpu_bo_fini(adev);
-	release_firmware(adev->gmc.fw);
-	adev->gmc.fw = NULL;
+	amdgpu_ucode_release(&adev->gmc.fw);
 
 	return 0;
 }
-- 
2.34.1

