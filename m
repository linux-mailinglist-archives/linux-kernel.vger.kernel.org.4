Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDB465E424
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjAEDqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjAEDpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:45:03 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4364F13D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 19:44:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axoje+9CFTxBe2ItLbsaov3uURTexG3/wwZSb4lV2UEhI2LpjkWzOQ8yDwzdFetNq1u2tJFgJtxyeoUQ9nQUIUiwtrHHIx9B9rFajjPLBcXtCWOMzona7tax6yGBHsABD9+XdMgn8hECtkGYttDbwJOuID2F2w/TtdZUd3X1SlSNGtykiZhocsL1ypNfiYLXcxKs0yD5tmJzP3ILgbOt7DWBjApzhHrl056zuZ7l5+6Yva3IdyPM/G00E7e6YsXZ53/xNlxClM48pGcQBLQO1ihOr1ceiOAUWuHKmVJtcWma1gnGnqoPQrVrH6UwI6cjcwuoNzslgy5rBWYaTp0kjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHueDlVHqW0+eHIRABqnJbo8LqJkO/nE1ACdZ6RTGlg=;
 b=Ff0OXCoGk+grTlcu0wjPCUrF+My5CAbp+67HRpWB5OSNnk3TOpCdiXGmc9tQFR9nIQSbOzlfjSz0mwf8u/EaOs1q5hJDwdznGPzjHyAtAfu85JHPZjyyMgMaa8HmgP3osHOBmFeyPRSbkBMwQ9s20Oi7Ox1KO4r7ntNsxJjGOiXwrgFdZCv8Bvs71M5tBE3Rsx5eidhFJEpcn4qQ1OxNpXrOOA96CEIopiw0/73YykdPJWeO2hdLgUQB/AUowGqHv2HWRgOLufChAQBCiFLjgblIPTsJ6Do2iLopM8ZsLgHm2ddViTnXzzESxP9k65zAz25hGXPnNbqh334WMUIhUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHueDlVHqW0+eHIRABqnJbo8LqJkO/nE1ACdZ6RTGlg=;
 b=xgtuQZF+3aY+p8S4o5Nkw1+pp3ePhpO9VMp6NDHiEBFe7MXIG48DetI0FmS7ucnNeS5XLk4rh5HFTsxNEzbwrBK7WC1kT8jmQJS29ZjU6wiC/n5BRzCmRudg1EuVG+TAz4Lgf5OyPMHvA3G5SOKI60pCiIrX9bHuDBKuBWS1RkI=
Received: from BN9PR03CA0401.namprd03.prod.outlook.com (2603:10b6:408:111::16)
 by BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 03:44:32 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::84) by BN9PR03CA0401.outlook.office365.com
 (2603:10b6:408:111::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 03:44:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.6 via Frontend Transport; Thu, 5 Jan 2023 03:44:31 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 21:44:30 -0600
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
Subject: [PATCH v6 21/45] drm/amd: Avoid BUG() for case of SRIOV missing IP version
Date:   Wed, 4 Jan 2023 21:42:55 -0600
Message-ID: <20230105034327.1439-22-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|BY5PR12MB4918:EE_
X-MS-Office365-Filtering-Correlation-Id: eec5fcda-6516-4ba9-4a2e-08daeecf27ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 57AEjwcDPpunwUuk3Hb5RtwKH/Jih/KERqFNYi82mrvuasSUIA1+1EZIGhX9Fbr/genlr4xM5LvTfWS9NA2PAubV3dGgiOptLz2dUC7e+RxySCalb6PwPydJufk5ulPflCf2+daNLVcRK+kus0zLWBG1E6zRvK/vvPEWBZrWDCpi21LMZ+l1lgG896Jyn2xIzF4aMD84Zxh84IrnD6FA0LbCEWGij7kIARA29AxtFc+ic9oo2nL19sgmMpYWC+VuUD8HuIVIsKzgNu/ao5HoisgJ+2mJhO6gQJLyNYL0R+wIwUR0DfEjQBdaCkb9bv1SGQXf17N53Ak+g31TY34JgU6BJdHIdXSKy9f9CyIE+EZiP550VWyU4xjP3EtJFj0UN/Yrn6zAlCLpBEsP6H7O3WWxbCAiqFYcxBv2Ok+QVrBUQHmxMVk187gAHI0YeOktWx6lRYbYIK3CtF2oi1YFM09TXW8MUK7D6zw42R7THQlZz9YfHpk6UlFq78AsQtSDB6H6hFT/KuUjWEo8MpiaHY0YyxeSyQRMMgU+biRMeTg96Py6fOnuvLEpLd8ffjGPG/2ftC6xBcfNlclGbNMkM+yb5XBUlffkLN5L+Wfaoz1oylewocO4CWznr3KW2tjZMMC18j8BYz7V4O/qoxanS51KL3zXhGtD4iyVo0uwNnZ0usBqutnwvJfEvl8f1vDmLf+/x9b6MeWKBblEOublNygjvlCNN8kQMr6jJImNSls=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199015)(40470700004)(46966006)(36840700001)(6666004)(316002)(356005)(40480700001)(36756003)(86362001)(40460700003)(110136005)(54906003)(478600001)(5660300002)(2906002)(36860700001)(44832011)(83380400001)(4744005)(8936002)(186003)(4326008)(70586007)(70206006)(41300700001)(8676002)(2616005)(82740400003)(82310400005)(81166007)(1076003)(336012)(47076005)(26005)(16526019)(7696005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 03:44:31.7252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eec5fcda-6516-4ba9-4a2e-08daeecf27ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4918
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
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d971e3785eaf..a4a62753bfd6 100644
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

