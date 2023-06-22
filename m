Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C143C739FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjFVLgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjFVLf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:35:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF95268F;
        Thu, 22 Jun 2023 04:35:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KP4tYwuD9/dMUNF+MQy27gQ+5GrwrwJ3Uisfzw4SySX2RJXGkchl4HM/8dCYhMWg81YV+RMDmNkb1KApYwpGuV62EuFzoEj2iFmr8ogmTGfQ8KgPme71dQNSV73omPaZ9MahKgyoc/SIZ+OpdZV7Y2Sqfif2iP8e65XCliAsUe/9PFC71Hht/yLvbuRV8+Qz7NOe02rpiXV/wqbveFD1mWd0IghbFGUJJVRr5iM2gLPKHz574OGINgu+i75YKm5SnNv75cA6kQ0GMEGcJMusgkNI9HuC7sL3vibhqnvzUpt4HAZR1qa9soo+/lCx4jWg4/xZPf4rpGi6BDPqKZF2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkxqy/MuPBKrFxC3rb5vuwr5GhxPJZyxVr1KdKBwpUc=;
 b=EIX073bxskkNZQCX2IDuTT4VQf/WKTf5sR04Sh7+jQdCsh5WARZ1Xon2n8E89i/sTKtgBe9jpTg4SCW6nCqyqRMnzRJ8RffZPRbb2zscPi5oI5TaveAn74qPNUV7hoAlZSxJ8JV6oGKQV89gTb6o1rIg22wtCL3C5474UwsGBbYfLCSZTel9XBqIyjnnyYRk4yi0SCksLsjqjLqagYdIkEeZb+9n1fwNiKNKzWZlKc4D0Gx7wyHYKUGsyB2eVD2GDU6mnTYzYH46tNxXxgkj5IWunzxywSEpJ4fkGI46bRfjYJHO119RADwbDO6wbcvLMVdoyKCpZ+C9QvxMRT4zeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkxqy/MuPBKrFxC3rb5vuwr5GhxPJZyxVr1KdKBwpUc=;
 b=gTvMrZodM/b5idBev0v9C3l01m4LnS6QIDU3C44EZMxViLQ7EVcif8fcdMQ/qRmMe5KZgWMHJY+i6sBOwr/rNp+o9hQqpwolkoehqhQ60CzaEp443kuEZ2dIMVwTN5/MJs7inpKtXeeRsoLlwUpgKGdllVMb+/WRSDo5xShLD5XqGOGEbmtoPG51hUalKGDBxZ9gOJxDa6Y+jZSTJw8ypC2d2y8AQyv6usm1iLlxLUFRpeBQaG6/TnfhyN0eXoCHhr7wdffCBeWMvlgmil+bLrxc46fY+WEEja8XFBW+Vke5gDE61JmN1xG3f0RFHSeFu4zUDa4nZ9VkvLEl4chglg==
Received: from CYZPR19CA0022.namprd19.prod.outlook.com (2603:10b6:930:8e::25)
 by SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 11:35:03 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:8e:cafe::39) by CYZPR19CA0022.outlook.office365.com
 (2603:10b6:930:8e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 11:35:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23 via Frontend Transport; Thu, 22 Jun 2023 11:35:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 22 Jun 2023
 04:34:51 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 22 Jun
 2023 04:34:50 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 22 Jun
 2023 04:34:47 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>, <sheetal@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 6/8] ASoC: tegra: Remove stale comments in AHUB
Date:   Thu, 22 Jun 2023 17:04:14 +0530
Message-ID: <1687433656-7892-7-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
References: <1687433656-7892-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 1734b9f8-aac4-4575-7bd4-08db7314b825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1KePkMOJsm+ofOIzLvU/pI7NcS/anfbu7+C6gs1oNY3XhEsx7J+k5GKzXVM1dMZKCH3QnrXy/2qkAWCTQKddI87HqYZUZC4+jc+uGiyoY66TB3CVr3tbRr0o3YgBqhKA6CARmkYOzR6ANltPBr6afEnpiNAmURNWJfS7Spn3TvmROMaNFt8I1C/4y9Pi4ExDK0VGQ5M9fwYHB9RVSlq2WBanrp2Hn4Pvhu3dVuyLf/0uwy7kQBIaezvL9CZRI6Bvn1iSB7cSDguKrIWWTOYBPis6tLASRPOYnC0CgkyipdsH9fTIHTGDZDvpK+69RyQwUWAz5g8KaWiEnH3B+HGtalwXIbYfbrQBUz+ZrSoVqNmbyvrchZSJ/7ROb/HRNxsFwwgMqO65+NjW1LYd15G2cl20p3Q+C1TYw48cDL2iEgTst40LFVFlF8LR2YMu69akbrGa2CiMFdOg5YkzX1nDDwVM56moL2N3AC6L/MSDUqm2L6djKzEZp7TeeWaVfTU7+aAyniG+c9CWOrjtHarPzda+kK70AQdADfyQZDigOKQNutEOTsSupQRxjCKsAH3+6bugPOWcNHQEvacAF/Djkr3OYQrDIFgOdUcXhca/J84wefGtxQhbLOBG2Zj7m2SDu6KFCTCZ5dNO3MOClj41apdX3Iskbi4ZBuxvK5IvWkGbWV58siGxTC/19H9+9L5PXs4v3UuoONz19yuAba0glX83i04bJCepWjtXPGcT5fcxukxjIaoVPN+xJJ03LcT
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(7696005)(356005)(36756003)(7636003)(82740400003)(86362001)(82310400005)(4326008)(40460700003)(41300700001)(8676002)(40480700001)(5660300002)(26005)(107886003)(8936002)(7416002)(478600001)(83380400001)(186003)(2616005)(2906002)(47076005)(426003)(336012)(316002)(70586007)(6666004)(54906003)(70206006)(110136005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 11:35:02.8124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1734b9f8-aac4-4575-7bd4-08db7314b825
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove stale comments in AHUB driver which is related to DAPM
widgets and routes. This is misleading otherwise.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/tegra/tegra210_ahub.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/tegra/tegra210_ahub.c b/sound/soc/tegra/tegra210_ahub.c
index 8c00c09..3f114a2 100644
--- a/sound/soc/tegra/tegra210_ahub.c
+++ b/sound/soc/tegra/tegra210_ahub.c
@@ -712,11 +712,6 @@ MUX_ENUM_CTRL_DECL_234(t234_asrc15_tx, 0x68);
 MUX_ENUM_CTRL_DECL_234(t234_asrc16_tx, 0x69);
 MUX_ENUM_CTRL_DECL_234(t234_asrc17_tx, 0x6a);
 
-/*
- * The number of entries in, and order of, this array is closely tied to the
- * calculation of tegra210_ahub_codec.num_dapm_widgets near the end of
- * tegra210_ahub_probe()
- */
 static const struct snd_soc_dapm_widget tegra210_ahub_widgets[] = {
 	WIDGETS("ADMAIF1", t210_admaif1_tx),
 	WIDGETS("ADMAIF2", t210_admaif2_tx),
@@ -1092,11 +1087,6 @@ static const struct snd_soc_dapm_widget tegra234_ahub_widgets[] = {
 	{ name " XBAR-Capture",		NULL,	name " XBAR-TX" },      \
 	{ name " Capture",		NULL,	name " XBAR-Capture" },
 
-/*
- * The number of entries in, and order of, this array is closely tied to the
- * calculation of tegra210_ahub_codec.num_dapm_routes near the end of
- * tegra210_ahub_probe()
- */
 static const struct snd_soc_dapm_route tegra210_ahub_routes[] = {
 	TEGRA_FE_ROUTES("ADMAIF1")
 	TEGRA_FE_ROUTES("ADMAIF2")
-- 
2.7.4

