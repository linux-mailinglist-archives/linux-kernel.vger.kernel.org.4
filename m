Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091D35EFF66
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 23:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiI2VvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 17:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiI2Vuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:50:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3462126B41;
        Thu, 29 Sep 2022 14:50:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buUUgo/vRYtLclX9hUWGJpn1Z1U4VTm2tz2h0RGH1pkjF0QraUKhzDIFUxgEtvR1Iudrvf9r2u3J7yqq1YHvFWRm9qq+5iCvGIEgYXdgXvRj++CPqC1bfMcavFx976MbDXZakJO24TRIwBif83FbTa24Fym/WgLn7WNCzMEw/ONJjfV3rnRMLZlnuAqHxhdIoSAtun2ZE4oRqkRWDUImeKnt4ski/8uuyc18UVC4xmZtNazXWYzyC2XtXcWdixtZdOvObpVjAhMmrHIrHhdM7AZkpDtQdo1r71/ODSGjuEUrrh8e/+UOSGMiI5iiQ8xgTmir7fMp8dKJlRTNCRBisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/Q9wvhaHxs6BcPbn3N/RKR5gBIk17FVX4BGCJ2qLUI=;
 b=PHzDgPrWJpVXqGqU0a7nwHvFcNfuMjwBdD4v5aLLe8ttXjiPlDXGQVCq7pqReD0nJ2bbk4gJjICeMB5R9nZSug6cKHlPAlMSa2KSFwpj8YCh46ER3PEBjH5dUlBA4HxbJPXrrDzo6QoNPimcY9w8E/HrBsqbhSkQHFE1RLraWOk6t3uYeISrV43SNtgW/vo7yULhPZJMRA9X9pLRLENEb8YLbGc2PlXNrvX7v7nPYeHnjWt3/4eGJgIbPikcgshfBMvIWwgyrnrGfH9nTK7cESIWBefTEry2uvauawrjXeQM4YOG62Ys8h30pUAi6YnoXc6lKcRO3dNSxeNDIKi/Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/Q9wvhaHxs6BcPbn3N/RKR5gBIk17FVX4BGCJ2qLUI=;
 b=BQ+3gEtOdejZVgEo+ILGheSXntjWkWpbq/uwIIDctbf9EsS8qNAV5vfdMxZvWRz8s++P1uZV81eOfsMKbV6EcMyIcbuuPhXWfzdc9b9134D/LIydT07DuI6tK3dmfSlOUGLy2y8164WA2/8fgMTYEnuv41/3AkRDGMtwaHMWTsY=
Received: from DS7PR05CA0102.namprd05.prod.outlook.com (2603:10b6:8:56::22) by
 DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17; Thu, 29 Sep 2022 21:50:52 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::a8) by DS7PR05CA0102.outlook.office365.com
 (2603:10b6:8:56::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.13 via Frontend
 Transport; Thu, 29 Sep 2022 21:50:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Thu, 29 Sep 2022 21:50:52 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 29 Sep
 2022 16:50:51 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] platform/x86/amd: pmc: Dump idle mask during "check" stage instead
Date:   Thu, 29 Sep 2022 16:50:42 -0500
Message-ID: <20220929215042.745-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT028:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: d5bc4cfc-d1ab-413e-fc49-08daa264adba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVaqJKOtsfU3a2SH3ZYD5/PL6L3zBJng2oPZOQQv5ipSpvAH3RwxJVcRSvLhpqzI1Jo6n8fYjctWIl/dYjzs7KCzRGI543zoVQwZnW18Idva21/utTxGRC+Wl6u3jxUMQAbmp+MclJATdnk1EoDPQT5NMXJBzXrgyPwt4UzIFHMCR/URBe5eQdTi0o0BsMUceSaNyVt5GbH2ay4uW9vzZ7VBJ49VZBfSEi6mf19Cp4TDhLa6COFI7QTuEm80VSEhw1wwB8ZbHr7v4GySkggt6TOcrwUAEu9c9dufbBzyOFrMN2JeNhB8oWQpFGz2cmrCXo66rGOsOx1tf6ZB6Q492eO5rrrDy5FajYGiIECg780h2MRbVf/9XuPfupcnF/C4aSOLYkyMgS0VG+zz2SN8HGAzHwVwQbCIL5oW+xTu3fNkpxcyC21J9HjTkZjcGHHBMKDu5LB7pg+d+XSe7a00iYdVgoQcjYCjj1E5lFGP0J3ZXPUJmbEB+ZsgYNsDsIJQ6fzV0OBCVOdw/5xSRppLNnyHDcv3n8RltHpSuasLOUqK8wCFeZX/Q32twLcqicIEzROFnZICLrK7s5Hrl5ODeb+hwOKrPVZWKiOQjNAtm22apchCdD52nkc/zBdjcIbCb+fPoBjgaghTDSoPBP6jMf22yVM/QBLhEV9o24C5hhuvthsOMNzFePy+dgCT+nK68lBoJ8GnyLKX9nK73nV1jGxfYcU7X50pE2VW9p3BwBvZ4b2EOwtksb0ZyeiaXhOSSfUI8oImj8EwH20jLJQF7K03RHc2Vy4dUTavd3o7xySs63mbtPyWfXVKYkzNvhlBSYvI18iDEfwUh3WKR3dv3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(426003)(7696005)(86362001)(26005)(16526019)(54906003)(82740400003)(186003)(1076003)(110136005)(6636002)(2616005)(336012)(36860700001)(316002)(8936002)(2906002)(83380400001)(41300700001)(47076005)(81166007)(4326008)(8676002)(70586007)(40480700001)(70206006)(966005)(478600001)(40460700003)(66899015)(82310400005)(6666004)(5660300002)(44832011)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 21:50:52.0551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bc4cfc-d1ab-413e-fc49-08daa264adba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idle mask is dumped during the "prepare" and "restore" stage
right now, which helps to demonstrate issues only related to the
first s2idle entry.

If the system has entered s2idle once, but was woken up never
breaking the s2idle loop but also never went back to sleep we
might still have another issue to deal with however.

Move the dynamic debugging message here so that we'll catch it on
each iteration.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216516
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 047e47449ff93..ce859b300712b 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -719,8 +719,6 @@ static void amd_pmc_s2idle_prepare(void)
 		}
 	}
 
-	/* Dump the IdleMask before we send hint to SMU */
-	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
 	msg = amd_pmc_get_os_hint(pdev);
 	rc = amd_pmc_send_cmd(pdev, arg, NULL, msg, 0);
 	if (rc) {
@@ -738,6 +736,9 @@ static void amd_pmc_s2idle_check(void)
 	struct amd_pmc_dev *pdev = &pmc;
 	int rc;
 
+	/* Dump the IdleMask before we add to the STB */
+	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
+
 	rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_S2IDLE_CHECK);
 	if (rc)
 		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
@@ -757,9 +758,6 @@ static void amd_pmc_s2idle_restore(void)
 	/* Let SMU know that we are looking for stats */
 	amd_pmc_send_cmd(pdev, 0, NULL, SMU_MSG_LOG_DUMP_DATA, 0);
 
-	/* Dump the IdleMask to see the blockers */
-	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
-
 	rc = amd_pmc_write_stb(pdev, AMD_PMC_STB_S2IDLE_RESTORE);
 	if (rc)
 		dev_err(pdev->dev, "error writing to STB: %d\n", rc);
-- 
2.34.1

