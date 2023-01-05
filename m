Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6236365E432
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjAEDrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjAEDpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:45:40 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0014915D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 19:45:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIEIMPPUPAvQPrwQ3t+Z+bLOqfkJzsS3FvPN6IHNXWnXEqYWaTWYxy//Xybcn7fBibO8+rjhv5ud7hceqS14Ss+TpuOuEzX5pzV8nWKeoMpy1J0lE/sdRmsYpJrR1YAi+A6tpZWn45AjeNZuE8UGwcE5VjgNfI7u1aMOqXM93FtMi/7K/X71RmeiMtmT+bT+oj8fqx+df+2O9uDQY7wNplMuPeWXKzLz+Eo8l730JWTs5XnQYK+5qwdKtvMNjnBm3Tje29StZolBmyiKlgzbRBaep/jxG++NjeWW58+qUNi1uin/xpRZjikCdkfR1Uva7iKWE6vhAuBAmyVypRQCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydvkp6aWWB+/P/7JdgT5npR6EoQAWBWPkalIcwgRZpI=;
 b=m7A8Qbn/wGXusbLr+xXbm9zSh8QnaVKW15MeKu+VWudfAuBq/hGB6hicBnYPz1QcxhFVGRBkhR2q/pc1GmFX0KfriXqxAHhPrd50wGrT8g5iNc3oYLHjAAP/IoSjEJKuW3uMQr/xSG44ZDatQBQyTJNL4gHk+kW4EL5kXblz+qDPNHmj4LDyKqtGSoaer9W3xZ6FSdv6zZusumBVLW196NiD3ZMGSHPkSXns0vTJulRzZZaNCvY9JuE5Ye7nR5FZ4A+z2aacXtacIZeAkUMGAMpUsZn1aaOr+QkpiAGexUR4mpnwIEOOfDwNoW7YmnqCC1apiqhO8TVGg16zDT30+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydvkp6aWWB+/P/7JdgT5npR6EoQAWBWPkalIcwgRZpI=;
 b=AmCLwZwvmTMdeEBddhfoiFk+yGLZXCoZkDfDYqT7arZ1kK745xZ6pVaNt9A6tB/vlj6FSZabQ4VjQQRgcgQw5X453riocYIGKxGA7VaJbpL4R2Q5ycdLHyATYW3eVTz7PzCYYjp2qJdKlxsLi8IYPEjh3eI6Av0WInCOGHSW+Fk=
Received: from BN7PR02CA0020.namprd02.prod.outlook.com (2603:10b6:408:20::33)
 by PH7PR12MB6467.namprd12.prod.outlook.com (2603:10b6:510:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 03:45:00 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::88) by BN7PR02CA0020.outlook.office365.com
 (2603:10b6:408:20::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 03:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5966.18 via Frontend Transport; Thu, 5 Jan 2023 03:44:59 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 21:44:58 -0600
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
Subject: [PATCH v6 36/45] drm/amd: Use `amdgpu_ucode_*` helpers for SDMA3.0
Date:   Wed, 4 Jan 2023 21:43:10 -0600
Message-ID: <20230105034327.1439-37-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|PH7PR12MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 5916db2a-7865-4bf8-2fe4-08daeecf3842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhSjGEp8NAkVeWgBrjnfxCXEj4AFdXwOBb1oeVg8pLCYgCzcioMywNvv1SB99miXpOUaErLLnNmBlpUZrTHeL8EHRm0ZIN9yyEdCj6sfjX7073Rgp74jjIA+0nBkSIC7ce42sGzg+hKSsEG61kdZ3C3V/LjOGH+9qDYn05WudbnxmxnAYd3cvVVNefKCCf/hQzhfWn7v5R2lgrDT3SwWxEEeFWBeA4jasIF/CJhqYrQ5wEZEjpN+WkplexPorxmKdcjCaF/WSSD+n1pAku6INeC4WTA5mJU7isdLzjmOh6TkJeH1oDQnXxvPNlSWsdkhZmzQEhmozPh7Ge6LqzLKlj9z/JMK8+Kk2ASdadrQWt/exPOjL/DnqfEN11ahc5Nv2jSyoEd5cPN7qK8tz1s2Rwo1YcU4Jydo5/vVylbtwda3WHW4UpqRpio7adAtFKdDMJ1dI97inbA5j/2jv5SP+TGjevzTlU/eagQXJ+PWgpw5weuVN3OQ4uxlo7K9C7j0wfRqKPddEZkVfhDeyw72VHTRGVuAvJHTk4zA1dipSjC+CPH95tyi2xILp4BibC56gwod2EsE2H23hxhiKhOnz8wCSJv4u0zag6DQaKj9HaQ0hpX7FpJrtr0ly8ObfmjCs3uhGXw16hYR6vLFxZhxjTgDlErxIe8Kzulb0gQjs4vf3+WCGPVgLu5FhCbihhZjhP3tYSsy5F7smtV3nStgM0Pk9bOWeUTxFkTxlifxihezMOS4avjpghDudwk+jnXQ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(44832011)(8936002)(356005)(5660300002)(82740400003)(2906002)(83380400001)(426003)(36860700001)(47076005)(86362001)(41300700001)(54906003)(70586007)(70206006)(81166007)(110136005)(40480700001)(82310400005)(6666004)(7696005)(4326008)(40460700003)(478600001)(2616005)(16526019)(1076003)(186003)(316002)(8676002)(26005)(336012)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 03:44:59.5380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5916db2a-7865-4bf8-2fe4-08daeecf3842
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6467
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
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 486d9b5c1b9e..e572389089d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -250,10 +250,9 @@ static void sdma_v3_0_init_golden_registers(struct amdgpu_device *adev)
 static void sdma_v3_0_free_microcode(struct amdgpu_device *adev)
 {
 	int i;
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		release_firmware(adev->sdma.instance[i].fw);
-		adev->sdma.instance[i].fw = NULL;
-	}
+
+	for (i = 0; i < adev->sdma.num_instances; i++)
+		amdgpu_ucode_release(&adev->sdma.instance[i].fw);
 }
 
 /**
@@ -309,10 +308,7 @@ static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
 		else
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma1.bin", chip_name);
-		err = request_firmware(&adev->sdma.instance[i].fw, fw_name, adev->dev);
-		if (err)
-			goto out;
-		err = amdgpu_ucode_validate(adev->sdma.instance[i].fw);
+		err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw, fw_name);
 		if (err)
 			goto out;
 		hdr = (const struct sdma_firmware_header_v1_0 *)adev->sdma.instance[i].fw->data;
@@ -332,10 +328,8 @@ static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
 out:
 	if (err) {
 		pr_err("sdma_v3_0: Failed to load firmware \"%s\"\n", fw_name);
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-			release_firmware(adev->sdma.instance[i].fw);
-			adev->sdma.instance[i].fw = NULL;
-		}
+		for (i = 0; i < adev->sdma.num_instances; i++)
+			amdgpu_ucode_release(&adev->sdma.instance[i].fw);
 	}
 	return err;
 }
-- 
2.34.1

