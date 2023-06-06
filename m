Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36FB72371B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjFFGEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjFFGDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:03:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B5FE48
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwbUUQTVoU2ZWD0e9pk26scJAYRG2On6IoU1SeXjeFLVoMOpfj2rro7m641dIY0JQaK5N8iSMdtzK449QpBJufeJK2glUxCTAsCCtSTbEI19EmrJo9X8f2U3mWSwDMDSEjbZLb2mcxXYWRe7SAqM42WSpGhBSrWFVA27+whzN3hfHUW2oyXlkvyTiD56PNM/ZJYnQb6h/VQaZvy1Vzvf5qXPH9sshq/ZgVadZbBoiOkAdnFdTwAznu1WlVMN99yRkQMjkobQxdoO9/HxTdiBjg64Lk+g+obxFifTmCSRiWMfsNhA+zgdhfj/JS0XFTUTQ79zYIe9D+Zm4vstxoOiBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrAlUYHeUtL4gjAn69ALnx0Pg3K5Pqzd2f5iFioh42E=;
 b=NGWESBgxTOY+QOrh68XpJS+VJXnC4JsVlscYnUBfAcfbwTjKN9n9uXIBYYudF0Xs+KFF9e2hUoTJQM2CWbd/FPqzyumvY9My2KVSiBjVfHdZ23baTkekWrnnqGczuYaddZoPrLo75DCeZdbQQrUt0zKZYfAIa5vBft2nnvmHWBGgXjJCUSyYSEpoRnndHxiaON1QsrPMxLM013/Kh7/O0hXPC3REThGT1+XrVVyHXscsys+2D9kguDP4IwBXKshc/vzixoQEU+K0OfopuXyAXbOiHzOfXcTmY9XRNYK/f0c7RYjdJjP85PsmZ7cRwTXVvmt77QSmrdzMj1tGXkkYEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrAlUYHeUtL4gjAn69ALnx0Pg3K5Pqzd2f5iFioh42E=;
 b=Nt3ZjfRGgl1nQFtaok/ntoGAlkpdAwS0qtCH1y1yvx/f1fVvEKTD/7b18iqxFrsTkaJrNLcM5ux3jR6il9HB6p/H4e4C5CmQ2BN1ui02XjKcPRAqYR+0767NVaRo8lHV3zPIHUa/1N9Cv6znKYT9EI2bw4od24Xk0kFq0GbbWBw=
Received: from BN9PR03CA0580.namprd03.prod.outlook.com (2603:10b6:408:10d::15)
 by MN2PR12MB4583.namprd12.prod.outlook.com (2603:10b6:208:26e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 06:03:33 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::19) by BN9PR03CA0580.outlook.office365.com
 (2603:10b6:408:10d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 06:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 06:03:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 01:03:32 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 6 Jun 2023 01:03:28 -0500
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
Subject: [PATCH V3 8/9] ASoC: amd: update comments in Kconfig file
Date:   Tue, 6 Jun 2023 11:37:23 +0530
Message-ID: <20230606060724.2038680-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
References: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT019:EE_|MN2PR12MB4583:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a01356f-2610-43bc-56f8-08db6653c276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YU+pncZwt5Kvg+70HKvGOcpd69n7B+G/Gou8mQxA/RnADcF+EMTWNvtiRBMlfAyXQXMYIyjUCX6TZCIN5PGtAzlV07RpsckmcCRXqlqdukBmW0BmYGrDDPcfHUWE4UhL67ZyqKNqFuYaRuZcrzYAMnK8QqsP+DdhqUu1OG+dPHMH7+RJPMvOykBkzc0UwpN4R2lmENb9cK6jdlBqbIyse72LDDyXD/vPuuTpP3ZGJ1L1JVrSnCII3iREWbR8NjPEeUGLHbT4Sl7wNZCt4cR11XunB6Qm4EbafpNCXMMvHnL2uIheg54i02zj7+KaWsrHaxi7AOROqledZbJE1jRR7h6iezAltHwQyHQ4SWlwegZnqcQjbKuKbf0SruueB4aRhXsX7EH3Gq2b1AMMyCVw2iRGQ0tGfv4V2oDnvAwaDjbiMVUykO4ncAvDt+aR4hXIXVZHqEJQwvdosL6zMQ6Fi4A0lZ5Yx5ZeF3x2phBv6DTx7nhTF1GRfVRPSHzW+O/o1k2+qnurx2g2cPG46aD299dojyMgX6zH2U2f64ECFdDUvxG/lQnMx6XTJDPbHJpoQ5DegqWDPXH0WjKjepowJknpoKQrBhCvTWkHrk70HvSWL46/h1Rvu12MoU/Pmg9kp/09RM2OgFyjlIYIIwtBouwq7Jy1gcKoo3L7jIxMS4JtSwMv925ndTNs4HYgwFSVKj+jKHouSd/64/9jBmwPgnbCzWXPPCznJuQQb+KkthyVA/jiJYmAEvMz5K4mR5erWTor9qDN7VYwzB2LsDcorQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(54906003)(40460700003)(40480700001)(478600001)(6916009)(8936002)(8676002)(2906002)(36756003)(15650500001)(4744005)(86362001)(5660300002)(82310400005)(4326008)(81166007)(316002)(70206006)(70586007)(356005)(82740400003)(2616005)(41300700001)(1076003)(26005)(36860700001)(47076005)(83380400001)(186003)(7696005)(6666004)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:03:33.3598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a01356f-2610-43bc-56f8-08db6653c276
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4583
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

