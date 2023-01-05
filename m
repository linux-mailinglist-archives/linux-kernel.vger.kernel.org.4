Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19CC65E3FA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjAEDpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjAEDoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:44:37 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06E64F124
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 19:44:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1XVSh30ZE7QaJSm4DWrqIlEW+f5bTLchcIy0z1+2NSm5bz3f/xPBUIu99RBHK+jf2twb603ePPKKTeeP8S5BFpdhaOdUpa1KlsDXj8exZHR2G6N3fyGSJNI9puUqMp+RN8wnyK80wz5lyO8tb33N60pnfuAnM5Ndyr7ZJhVrsQHH9cev/UkAVA3MYgjHwbHLkJPekaKgwpECCYfOAMicyidLHdSsWei4LLerlsGoZ62KCa5eARiwrOmW2/8W0dxEDJ8U9hzOPjOEB21brC1jTqAbQeEFUWWM553m1S52305bPiAaNXHk2q3Hjsql3/VqsVQCyZFmnP7CGAA3fvmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lv0UDHFnh6a7L8oEWvUz02GfHiA1TfFsX17bOCkos3g=;
 b=iGtxOOfyqHEZZoYf4Xe3RFdCrojouFsbx0gU+60X18DZQexpXXUEMoG4cDrCisf2Xf6Dg8t2HdByXgrDKwc6JEZLDNutctBLAVrR0UjaMfV5hbRceYKfrUzewiV9MrulFK9sFUobcYQvd1xn6174GvodEKv3tn+gL58yeRllnvYGjXlOakLvfVgbR4ccjVMwGtQaN2SyrhtGELxcyb/AH9UFWi0fcVmrdevV12+huMR/83paKrMU4p27J7bSZnrDdcRr3FTX1JCoyqg1nZjS0RPZif8xOiveMAN2AOxW2B4Zl6IltykyR9PjwvCmaNBvvlBC+FF//H3+MOibdYoXFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lv0UDHFnh6a7L8oEWvUz02GfHiA1TfFsX17bOCkos3g=;
 b=2DQ2OAYpgvTGpeS5Z5/g3fZkTDH2eRpe2GiWDOdST15BvTGa2YnolFJ47fj6Nd9vl2dWA/Yaplnbr0+CKn/JIj+Wp7glHi2j9AR5QRHduZlFtTjB1GjAgjNv59iHbbrp3grOAPXMNrASa1fJ+0IwQDD6xCWGNteS+QDlyoHCYoI=
Received: from BN0PR04CA0053.namprd04.prod.outlook.com (2603:10b6:408:e8::28)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 03:44:17 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::b) by BN0PR04CA0053.outlook.office365.com
 (2603:10b6:408:e8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 03:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5966.18 via Frontend Transport; Thu, 5 Jan 2023 03:44:16 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 21:44:14 -0600
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
Subject: [PATCH v6 13/45] drm/amd: Remove superfluous assignment for `adev->mes.adev`
Date:   Wed, 4 Jan 2023 21:42:47 -0600
Message-ID: <20230105034327.1439-14-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT109:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: d63b3729-8901-4aef-976e-08daeecf1eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1EV99ji14hyJM6zJkN5da2oeSl8RUkUEYzWl7eiinJmW3AEsBQdKkMxOjwSyYPZB28LxO+ejFbh0OJZSy6w1ezXSIzL4el5/JLmwJ8IMl+fLBnSz3DH55BmrNUALJVWb5ZVNQBb/OWqcscWltPwoNes5e82RBt1NQ/Dtn6talCvxs9eN50E+R4KxETz978QxP3MZav6MZEoVZ4/Z9icls4b6zOaObZ/b4EWmjPsCwhvy0O7a5l3yXUPvLKza3wkv3FcBZUt9XfBaLNIttanZaeTjq23QLXQDPmeQUU0WzfadWHUDo3f99arXUrwYFmiQWIEAH0V5ZIj5Va12FgkkXUNuoxQmwoDgRWX//+lLnfB2AtA7lvpS5ZbPu594T4829HgRJY227iu1y3rQRlmnWfpvy74mn1CdEWbVw31r5//J5Pd/WiDQAfEaSVkx7+prDcNzwaRUxpHj9540r7eyIWDmcncIaOc6MI7P2mXDE8K/UTOHAM95M6fWJPR7CfXGgaWGdl0mpazuAKp6Gk+zpP5Fp7iuG5Cyey1eDN3hsCSMolRMZQlvTh8MRMDX0pn8bSN5Lxok0bCsU65oi7a5LF/Kuct8QksddhU3ro8FzNKm8uXqbuShWoum1kWjD9HRY4JkURhFx+PTA33nRH4sZLjN/IhQne0d6ZlfIzzA26UTiwsqwsCUqGGpp0e3Cm8hTM7tgUlGUDCQ/IffpFFer8HBBusRbGKNcjiYpo1+SFf8cbI0XnlmY402EPbn3VZno3tTUU+UPTnjRFZdizskA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(5660300002)(2906002)(44832011)(8936002)(41300700001)(4326008)(8676002)(316002)(70206006)(70586007)(54906003)(110136005)(478600001)(7696005)(2616005)(1076003)(40480700001)(26005)(16526019)(186003)(336012)(82310400005)(6666004)(426003)(83380400001)(47076005)(82740400003)(81166007)(356005)(40460700003)(36860700001)(86362001)(36756003)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 03:44:16.6801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d63b3729-8901-4aef-976e-08daeecf1eb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`amdgpu_mes_init` already sets `adev->mes.adev`, so there is no need
to also set it in the IP specific versions.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 1 -
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 7848b9de79ce..2e2062636d5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -924,7 +924,6 @@ static int mes_v10_1_sw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int pipe, r;
 
-	adev->mes.adev = adev;
 	adev->mes.funcs = &mes_v10_1_funcs;
 	adev->mes.kiq_hw_init = &mes_v10_1_kiq_hw_init;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a0125e103007..a36b0f14ff92 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1013,7 +1013,6 @@ static int mes_v11_0_sw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int pipe, r;
 
-	adev->mes.adev = adev;
 	adev->mes.funcs = &mes_v11_0_funcs;
 	adev->mes.kiq_hw_init = &mes_v11_0_kiq_hw_init;
 	adev->mes.kiq_hw_fini = &mes_v11_0_kiq_hw_fini;
-- 
2.34.1

