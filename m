Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFAC6D16C5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 07:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCaF1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 01:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCaF1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 01:27:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F3710265
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 22:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXbGr4kfK46V/vzCBMCFpxhfeGo4v/kJIIdR/3PuStRrMezmqXUdFe1S7PkShWMu2z4jtCz2M+sT+4kuRLibashLHtiUYc015MleXvsMtBpOJ8PYL6kg4mMQK1a0BzCz3GAoOfUODwu+AG0581ZuBL0I8ZGYciqTiMDek0b+aTcQSt5CXGGNyKo83pULt8oCxPNNSrwtw3Zq25j1qdugoOANApE8W2XvBLuKmtXxbdcWhYoLqv/nrweXLPC0l/vliSQN5sJs7uOSKs1NldQY33+c5rhdk4GrBC2qUoERebbUd7EeRWCZKucIcGHtFmUIUDKTqDeRwBTjuZbGAeDbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtDPyohLcoy6IvzgvDqahn0qJUo3VZPIjkEGfKxDKUk=;
 b=A3yiJeC4HtnL08ADiE3UqMxL17AomNmGnrogEQAOBSzDd+r2+6MMT+R7dTYkzAOXfYhsxKhkp68vk+BjHVf67rx6EFOh2PepK94MImzdVcIgCSa0ohdwjN93Ca+Lucrnuc5SnhnosfRYf7qkjQGxEcz0Y5o7t54I9UpHZ0ThvEUqp8R5CKIfoscUR0TZdJKL4mmwHK+rCwu5pwv/rNgEAZCIKfCRKAfNN+iJFRIZPioY4VlFiSBdX0X5GWPQqAY6e+gA25ZfCyC15A/yZPJRCQwQ9YE69Ldj8zANQGPko8+XiTxpgGVSESy2beu73iWqMBrb3RhqD4lQ8TZN8jnI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtDPyohLcoy6IvzgvDqahn0qJUo3VZPIjkEGfKxDKUk=;
 b=II5cbTqIBFNMSbek+KuM9cfGx/Ohx5xkiPW8025fjipSx9pFdVmSUZrFGidRTiSNhoAazA7YyINzWxxa3gxC7/AHz8HJH84h/NaHnYRJIkFQUlB0IY06hBp4tCCcBkKKRTHS7M2awzbidKoqLQ4bRcmr1IXftToT/nMBzNoPBVE=
Received: from DS7PR03CA0213.namprd03.prod.outlook.com (2603:10b6:5:3ba::8) by
 PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 05:26:58 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::3b) by DS7PR03CA0213.outlook.office365.com
 (2603:10b6:5:3ba::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Fri, 31 Mar 2023 05:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.14 via Frontend Transport; Fri, 31 Mar 2023 05:26:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 00:26:57 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 31 Mar 2023 00:26:54 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: ps: update the acp clock source.
Date:   Fri, 31 Mar 2023 10:50:23 +0530
Message-ID: <20230331052102.2211115-1-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT112:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0788dd-3856-49ac-7ae4-08db31a88c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2UU6M7ed/n9Uvh4cvP2VYKIjvPhNj7VlhXr2yDtsfhGy3setmfwFTotcsLnhZZUEaERy+E5//LZJH8Xv55qOj2Is3gb7GKqTJ87SkRwY+RFP3Q7uBonmhATGgGox6N8BPFqR4NnQ5QoryiOne/uDwrqGNFnwxvmmVg2eAbHR1xQxEMCELZnREwwuywk8kn4r2XQP0/4mZnlOlcADTREEhfHR03+BWNQo6ClRUuqLfY9XXs8oqUNtZSkzAZjzlx/YqOPhTrfY77pfb+I5dSPAAsXgznbXnU0/yEtIOvlP75nF/qs2+k/qGXRa9J/120Uv7gcNYzqsEnMCZiEWmwa1QQuIhsQc3Vk1dDkMp45T2+fjI6aff9LyJwH9JSir3PSN0faQabipsVE7QS+7o9MavUlGpkKaKxKMVJVMAOBTWrwaFpXt9xp70X53RtI0drb+B94q7Min4szROJkgugiWHCyHwQAyHp4pNrAJTGHDsAa95bPQJyPer1zkKENxiqFIkSaGsSTlY6qjsd2ERGd3T/v+tOO/mlV87ICnVMQdnkY4wpCFW869q3O7p6jrpbSK6l9acLg3wjtHYqcZR9BBuhlC8SkfJdz4NNztbqaBXVwk+nTbdRvlq7A0/iGHlh6hiRj3ns245Rvpx9y8VMIxzUxo56mx1Awn5kJyMtpMobNbz/kW/xow/lT0QclCL79VAoveMldu5lpagbg5AFf4BC1vsfS0c7Vw+ESFqPhozm4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(41300700001)(8676002)(8936002)(82740400003)(356005)(81166007)(86362001)(40480700001)(40460700003)(2906002)(4744005)(26005)(1076003)(7696005)(6666004)(83380400001)(47076005)(2616005)(36756003)(426003)(336012)(186003)(36860700001)(82310400005)(316002)(4326008)(70586007)(70206006)(478600001)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 05:26:58.3616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0788dd-3856-49ac-7ae4-08db31a88c80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updating the clock source from ACLK to default clock

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/ps/pci-ps.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index e86f23d97584..688a1d4643d9 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -91,7 +91,6 @@ static int acp63_init(void __iomem *acp_base, struct device *dev)
 		dev_err(dev, "ACP reset failed\n");
 		return ret;
 	}
-	acp63_writel(0x03, acp_base + ACP_CLKMUX_SEL);
 	acp63_enable_interrupts(acp_base);
 	return 0;
 }
@@ -106,7 +105,6 @@ static int acp63_deinit(void __iomem *acp_base, struct device *dev)
 		dev_err(dev, "ACP reset failed\n");
 		return ret;
 	}
-	acp63_writel(0, acp_base + ACP_CLKMUX_SEL);
 	acp63_writel(0, acp_base + ACP_CONTROL);
 	return 0;
 }
-- 
2.25.1

