Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3071C65E428
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjAEDqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjAEDpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:45:09 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C41C4FCE6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 19:44:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrGm0gqEfC+TDUoy+BsNwJ8Yj2eegglkkecuvMwCRq8gqsW5WtoLjYLSRj3gHKaFKjuQ4KStv/LlTNvpMeRgEnlGS38cypHBEXTabWuN3CUPk0WSWf8J70Wt1T6Bgips0hVruCPccUuVg075yIKiM9gjrUoQEsNB64HDexBrKlIyzsMNpgIpoUqlRz+neJZQ6Dsn/wSl52rea6me09K5IxsG8whLUgz7bMdV80Uer+X/IySqoGvXQ+ITJpvNtbl+Hf/0R70iV+p9WAsh1LjAzDcbFN6ClUJjrOAYJwj3Sdis2EgyGyb7iALgPi/5NB2IMQEZJ77QcO74kvwXD32Suw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTmz475LLfNC3JCqj9nYLeia7wPkcPqayRO+jK8sSKA=;
 b=F3pML62nPIpJlQvmp9nP2otkICN/TPt+cKoEtxCNWOpGMjb9/X4vuc5wFKtB59ywhFr7gIjuH9huII4yUpC54lAmIH4CsVt2RH51lo2CeVWfLExy38LQbjd7m9oLXXjL8WBRpZ5GoV3LwYkNEu3GbvHFsEkfvzpa9mC6/4nuLJriVtyDsZUoSy1LjR1ex2pYbY+gjgCCdzmReMijuDnRAucfLrjHmP+v17Qvm4iezWKfWoDIIbAPSm46tlSPC7tdrjUwSkOlsWagG3+Z/3RfE3Y0KOj2b85F/uJvpTjp2jbUJ7XrgOYFspCIhVcOvpWE0dGF61hinUUqrxKCSLACYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTmz475LLfNC3JCqj9nYLeia7wPkcPqayRO+jK8sSKA=;
 b=kdOlFWnbBHojr8Su8A3cDvQk72qHSZRgUlnFHfUUnmVSn8vqMxTXVwpzCbpBk2bce4fnGkmlO+GijxGZVVsrxsPamayFgQCFxPZwxpoKBKNFVbS45jb/Zn5++llixolHVwzdijwZkcY2OvFWUkrYW4X36j8uOeCf2rFJ7JQ7DZw=
Received: from BN0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:408:e7::26)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 03:44:41 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::26) by BN0PR03CA0051.outlook.office365.com
 (2603:10b6:408:e7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 03:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.6 via Frontend Transport; Thu, 5 Jan 2023 03:44:40 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 21:44:38 -0600
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
        "Harry Wentland" <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: [PATCH v6 25/45] drm/amd: Use `amdgpu_ucode_release` helper for DMUB
Date:   Wed, 4 Jan 2023 21:42:59 -0600
Message-ID: <20230105034327.1439-26-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT046:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: e1db5a86-f713-46e9-b3a7-08daeecf2d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idQowE7cAniKBOcQ2kDStIKu4EbONFRucrlAzAbVCZVfpC2Ev+AFM14JIF67iudYqaZeppYfWHeRWcviRvjFEn49IKPRYMyTnPNGLOu+nLwZgjmmtbeQvqSfiyPtMK17BeYR36rQbsfuf204L9VQw3lNmaUIo5QjuRviS4+TTdskeA6928fe5FY2Y1V9UomG10sWzWpkY/0is55NMkv3gRJThEcxRN26TWZWZF4qv8iIneWdGwWkcmbQmk59+46T90DayFpNqRZ2Q4zfNC6B7sRlDrTS+CQIWK9EQebBUngw4qGtwB62gviceTaxvuhoXs6PBWARN59eMwpSCmb9oPgmH2bfgpxRAaaBja38+Zq8E5QlIwIodbjUDu/r6zJazzJBFv9oL7Mw7NyZNVNmzTMZoevhJiCfHdLzj29nmbtIKPcmxs0Ff7GyGgTAB98/5Na7lx6g3wK40/w1PCFAY6geHU+8z+1Aw7xmGl5mJatfEdgdaCHzEeC4XtW35Chs7T0dTZi31yuibinZ731SA0+Sd7+UK6Y+BK0VNoAuDoZQuLhFe3hrbYK29h1sIm+//nBb4Y4rGDG36YZvHbG5NlGDOJdwwl8OFa0WWlHnf5yrq3O4o7/4e/tY9z9EilHM/AtALDpRn8qcxOxWqNM+XCsXMWgZybU/lCVdBMSMGXo7qfdVdqrWPILgEyEHGIggWFlXMMtgDNS2uDVrSaPAwa0VHydSkpjcqnX+wI4Za9S0soXEC6RGa0e/jUZocsjpD2NYEwJdCxuN2sWA8mKcpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(26005)(16526019)(83380400001)(2616005)(47076005)(82740400003)(426003)(1076003)(86362001)(186003)(40480700001)(336012)(40460700003)(82310400005)(36860700001)(356005)(36756003)(81166007)(5660300002)(54906003)(478600001)(110136005)(2906002)(8676002)(44832011)(316002)(41300700001)(8936002)(70206006)(70586007)(4326008)(6666004)(7696005)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 03:44:40.8833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1db5a86-f713-46e9-b3a7-08daeecf2d23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `amdgpu_ucode_release` helper is for symmetry on unloading.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5->v6:
 * Adjust for amdgpu_ucode_release argument change
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c8c5d37c8b3a..61c192ead62f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1898,8 +1898,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 	if (r) {
 		dev_err(adev->dev, "amdgpu_dm: Can't validate firmware \"%s\"\n",
 			fw_name_dmcu);
-		release_firmware(adev->dm.fw_dmcu);
-		adev->dm.fw_dmcu = NULL;
+		amdgpu_ucode_release(&adev->dm.fw_dmcu);
 		return r;
 	}
 
@@ -2113,11 +2112,8 @@ static int dm_sw_fini(void *handle)
 		adev->dm.dmub_srv = NULL;
 	}
 
-	release_firmware(adev->dm.dmub_fw);
-	adev->dm.dmub_fw = NULL;
-
-	release_firmware(adev->dm.fw_dmcu);
-	adev->dm.fw_dmcu = NULL;
+	amdgpu_ucode_release(&adev->dm.dmub_fw);
+	amdgpu_ucode_release(&adev->dm.fw_dmcu);
 
 	return 0;
 }
-- 
2.34.1

