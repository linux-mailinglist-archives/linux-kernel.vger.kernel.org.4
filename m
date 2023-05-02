Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9996F489E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbjEBQu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjEBQuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:50:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20612.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AF91BF6
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 09:50:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrNYeWDNwLph7ZDRcJC1QeayR/XBpXJA229v9YGdbXgeBoUO1JS6k0vv974VQ66u3Aj5fQYJbPTRa0epM5KLPcQW4bTVa/SDuaWa31At5Eiy2PmLqiGB4sPENvmETVtJ9RRA9vDMhW8CNoEixzBhGYgp1/2mJAI1mKhgyy5JZkvM9qxAoI/ky3CAFRwu6bgFdFyKSfznf2rsd8n4hlzhP/aHLUpvkywoB27wXEPSoOOyrtI9pPA/21WaV5SQICnDsNdWzOc0jeq1YL2KC7d4RwEufYMEb1yuaoqWeJnchmKBn9k07wH/Tg85fqZpm+gOxi959Nb5EUlv5EuvaU332w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoAr4RID1kt0f/l3uo3sZQa9js1EK/IxPQlQw5Q+cEw=;
 b=G/Kr7QA61Ri35SciBhi2Ioh14wzrXKkHAJ9/hGfVs1M/HeARnYmY/eM0LoTb1Rq65boI2hXM0H3LzcvvlNZla8Py7U6OPjr8LrcJqHYye71gvmVx0ALWR5IPNxX88xJK3wodvh5yrTlCeh5AeFCM5VZEPmzXS3KfibaGYAgqYLqssdNP8GU3HE9VAgrkTc7p7HIJWsJ+iypj0eOK0EHAwJCLaeMGyCjBjXL6+IuB8hc4x65Kso3Pf4ZGVEhKfTnAYeO7K56W5BylxlEA+cYCocHu8f9NnbXKrTsPhMp3KsL1L1OId2hxuHrwctRhDxbEVhDIxp312mApxGkJhRvfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoAr4RID1kt0f/l3uo3sZQa9js1EK/IxPQlQw5Q+cEw=;
 b=OhPd6edOMHEEwMfpSbTYQglCoAsSUffSEL4hiHJ0LnkIoRqzt+fMs3GZq56eXSvWCu1fNlHmscK88mbNuVgreDkl+LzDtFpPZuONXb0mtuHh9zwFfolpMqb2K/5HLMifZeThSmrkrvAgu0OYzhxt6a6nSrG6vdxPwNz/w7aYsCw=
Received: from DS7P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::6) by
 PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.26; Tue, 2 May
 2023 16:50:50 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::df) by DS7P222CA0010.outlook.office365.com
 (2603:10b6:8:2e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Tue, 2 May 2023 16:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 16:50:50 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 11:50:48 -0500
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Stanley Yang" <Stanley.Yang@amd.com>, Le Ma <le.ma@amd.com>,
        Mukul Joshi <mukul.joshi@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>, Alan Liu <HaoPing.Liu@amd.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/amdgpu: fix an amdgpu_irq_put() issue in gmc_v9_0_hw_fini()
Date:   Tue, 2 May 2023 12:51:54 -0400
Message-ID: <20230502165155.200068-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|PH8PR12MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ace7366-b3a0-4aaf-57c1-08db4b2d627e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdE4lF7/sE37SxqjEu/rO1roshIt1y4gNZqy939nBnutKNHMWqDRhglbbhsNUtCECdh/KC2X4s03RjhvGcH48/EiWs80U7AwQC4nO1HbCuh6NdCczitPo0eYs0ndYp6ILUxFuR8yQMYtgP+7x1qdo60R7mVOraY5Xnm+OfbLXS1UVLDEgQz9jroog5gwt0AlFoqL2fvjdzb4ngMGHN+wov110YOqQ178/5MAkQoN2SnGkvK7N9LSzeEntPAnzHMK8CdEBEbGS2PhRa9vAXuSJOHXTvr/c4pAnUdT6ijPLhxv6mkRjp53V/bwxAIV2SYotFIzzA2HxghxKJgdZKGWTWNgbeeNZzuw3vbrozJvcVue+oAIJ3R4LnYrdoaMybqLu/FVmkOYm0DwclabeeMOF3s88jCeE7eUmFH8e4tns+CgCwM2uvVGqfdc7rdZgJEMRlRRW7ofgaK983TdK1cGb/IYvno+GBKpq1BndSM4Gxm7rxXqh4KPrOl/A65F86pN7eg50tb6iF+0TLvewh7Qyat8pFRSfn3kNwiVG09HCzXCaqUrsba3ns7L9AQnvAK7Ds6XLdUWgPVIuXkEUiAwu/8+Pl4ZzjJxuyK3hILM55Ppp2Ik6FIQO60+i42tVtelIvl/PeAEfc28coXC4WXdsQgZD0NeyifmJ1iDk5aiuAU7v9NGt6/1B6W0TPd3t/+c83xHTIOnMIUVt8rSSkiKgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(83380400001)(47076005)(36860700001)(2616005)(70586007)(70206006)(356005)(81166007)(5660300002)(36756003)(41300700001)(40460700003)(82740400003)(4326008)(316002)(478600001)(186003)(26005)(16526019)(6916009)(54906003)(1076003)(336012)(2906002)(44832011)(8676002)(86362001)(8936002)(40480700001)(426003)(6666004)(966005)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 16:50:50.0178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ace7366-b3a0-4aaf-57c1-08db4b2d627e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As made mention of, in commit 9128e6babf10 ("drm/amdgpu: fix
amdgpu_irq_put call trace in gmc_v10_0_hw_fini") and commit c094b8923bdd
("drm/amdgpu: fix amdgpu_irq_put call trace in gmc_v11_0_hw_fini"). It
is meaningless to call amdgpu_irq_put() for gmc.ecc_irq. So, remove it
from gmc_v9_0_hw_fini().

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2522
Fixes: 3029c855d79f ("drm/amdgpu: Fix desktop freezed after gpu-reset")
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 290804a06e05..6ae5cee9b64b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1999,7 +1999,6 @@ static int gmc_v9_0_hw_fini(void *handle)
 	if (adev->mmhub.funcs->update_power_gating)
 		adev->mmhub.funcs->update_power_gating(adev, false);
 
-	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
 	return 0;
-- 
2.40.0

