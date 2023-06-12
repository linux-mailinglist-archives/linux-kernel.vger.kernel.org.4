Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD7972BEAF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjFLKTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjFLKOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:14:14 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B095FEF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:55:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKMai5YlLnSk/84xYedaqhno6RuSW5Cv4bT+lPJwBIInzmeaHPSmJv3r20VeG4p1gCJetL0+T6ZSggaEi4v6MHz6r4A6FRle8ffzHxncLkIK2iPCcfjlQGhJO5dg/LMEpYSJRHjva+/DrJU4h+f81tTIv4DLc9KomEdidWFIU8nW0+RToi1Dw9URQCcnVZWWiR2mU4c8zPgbV35y5dkZma6KboyRGBVEfQFy6Ed0+rm+3L6Am1mu7uDSJKFCpG4bL++CHWiruylgPDfH2Dc9rw/TKCD+6QBDenK5kDhKEHAflVeZzjBcRxmLcpqNvaKFR0kdUeAX73raqxrRNEZRoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrAlUYHeUtL4gjAn69ALnx0Pg3K5Pqzd2f5iFioh42E=;
 b=ah91c4aw6b8RIpTT5FWhuUdGvC8AFPvbnFOfJTtKQLWBdxCUHgnQIT7FM1GC5TvldEUhcCJUJxyYLQFVnlnNtBnMUhLJyBkwMtfJBsBhPEEGoSGUHmSYLIQRkc3icCzD+3DwguLsygzSI/73msRhun88KPeKj0c3iWsx9oFD6hl1aiXDcg7uHBD40HN6M5nvcazXIuXL6G89hUUJ6c7zxPNXTEwSEwSgPs3lzDc/FgJtOyYd9CvKB2mASbNT7axY6li7Tq1j/KDbjWmbO9apL/Dudx2aRTUzxdGsH3I8i7QbHihouTR3u6Hrvm5DdMqc81c/2R3hibz+xYgKj6REjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrAlUYHeUtL4gjAn69ALnx0Pg3K5Pqzd2f5iFioh42E=;
 b=qEAEp3Is8AuuYYnjdL9Ur40B9ckgWfVeOrQlL/nKGLzyZ6zRhOLiFWNJBEbHkK+VO8cWCIMhaanKp3Co/5s20QgYKM2t1dNdYb0MaHNoy8VbZY+m96hd0josQdKWxre6M3fDM0pcUkFRP+QfnZKYKa05zTvOOd3m6Fsg3wuw70g=
Received: from MW4PR04CA0202.namprd04.prod.outlook.com (2603:10b6:303:86::27)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 09:55:43 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::19) by MW4PR04CA0202.outlook.office365.com
 (2603:10b6:303:86::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 09:55:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.21 via Frontend Transport; Mon, 12 Jun 2023 09:55:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 04:55:41 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Mon, 12 Jun 2023 04:55:37 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        <mario.limonciello@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 8/9] ASoC: amd: update comments in Kconfig file
Date:   Mon, 12 Jun 2023 15:29:02 +0530
Message-ID: <20230612095903.2113464-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
References: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: 31fd0ebf-3bda-4336-9fa3-08db6b2b2f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpWMXuhapSjNv2lB7Th2W8ngdnWMd0SLG1U19h5iYEkn29maOdhmKO0S/ESUKRwdOECLgzjUHdDesvhCv9W8e4j+SIGSuSmMmrFeitj5rPxOpe99sBoeR7+R7M2SZNGJ7hzN7iDeyNK2OCstYio44AzIVcoyjDxNepK4Fg/fjVMSUhlwSYHcVyennHMAGbRwX/L1Rh29KHoEuMUN8iOvGnttXXzM9+5xk8VrPQaYf86elcNjXEV2cGqx7gBSQEjTJRAyMF6mirJcYFfgiT6cIJX381tyWpWUqtvzHxfAV9/3wHQfBmXBDJAHmg8G8JLQxSY/SNu2X/v6lmvvdO4icUA7vGO8Vit8K4XiQXaDw/0VchK5na3yQFc4XHdNiYM3JJMFTs/SJ/nPsQMbVzzmHnCaamYQjL3KkNlu8q49LMV0AU6N1pMcinfnQDlc3GWX62uqY+hVzpRv3LbnZYVL2SgdkGxSw2J3L/vL9uq31p71OEtRJpm93Y7JJ1A6V5aM2khbX8M304Lr1GZ3VqAx/xq5sl2jyfwd1Yslkh0jMUsUQGVaKvY4EECp+dEZcfKsU388zWBZKa16ueZ9U41/GnUun68ENSRFc/kZq3RAZH0TMGBCUdt8pYHO9Gx59olaZ/pUJJe4g6cKeaaPnKKaHGb6uqjhQEvqegg4E40gCHpZ/sETJFqaEf+Pe8tv9kFMES0ND1OKYgDJ8voEsZdCTJWbEWQx1k8PcGLhGBVSqrr+K9wTMj+3qykbpq27jjrawbeR56zLDXdvQim1+pTLxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(54906003)(5660300002)(4326008)(6916009)(8936002)(8676002)(41300700001)(316002)(4744005)(186003)(2906002)(15650500001)(478600001)(70206006)(70586007)(6666004)(7696005)(40460700003)(1076003)(82740400003)(356005)(81166007)(40480700001)(36860700001)(26005)(83380400001)(426003)(336012)(47076005)(36756003)(82310400005)(86362001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 09:55:42.3431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fd0ebf-3bda-4336-9fa3-08db6b2b2f5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update comments in Kconfig file for Pink Sardine platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 08e42082f5e9..2f0d444b21fa 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -136,7 +136,8 @@ config SND_SOC_AMD_PS
         help
           This option enables Audio Coprocessor i.e ACP v6.3 support on
           AMD Pink sardine platform. By enabling this flag build will be
-          triggered for ACP PCI driver, ACP PDM DMA driver.
+          triggered for ACP PCI driver, ACP PDM DMA driver, ACP SoundWire
+          DMA driver.
           Say m if you have such a device.
           If unsure select "N".
 
-- 
2.34.1

