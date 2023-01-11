Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0F66656CA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbjAKJCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbjAKJB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:01:56 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA9E10541
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:01:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPNp4SRKG5beJIUobSv1BCkhRMQTUyufhoo4C4fGjxtoKbr/cn+u0GhbChOvio04GYZfn0/E5htbvjTRd9ySAxmGgxwbOwH0Msi6j1JoukR1nuqqigu9z2sRMLpkvuaRc6UEf/2Y8ll+0VDIj4kN77DNYH5fIt+dLwpCtx+Fa/owRSIbx7IezW0FAZ4sO+zNSK83qM25RSIYNM/viyc6f0dOXqoa9s5n9EogESuVN/xFgBMCu/NAzN6qIy44YEjR5a8voeUNC/2CP5+q+6sqmLlGuxekVsGFUXOGqEZcVqymGCIyKuVuRNr72xLzJG9Bgc1kY9RVidpirS2TGFcW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgIVun9p3HbmExWmkSyPXi0ZP4KKvEqfg6Tx/AxFJHU=;
 b=eeb/Ag3//IByCDHD72P1+noCK2IPU8Re0Tgo23Z+sRum4h5deCGv94IY5BRslITy10eQNwBMQQ5c2lemNKwqZRPEVCNxGMTSzYg/zPMUe9PwOgYziLtrCR01yqJObVPgxcvFEEcuzlqm1nkoAgLkA8czZTgaoC1sdIHkEIzYx222Fg2Fa6osT8s3GT4AGi7Lpg4maYHm3s/QRcuV8MHj991z1KAh0+0wQfk+K/YuhMtn+ujggMl5mwcMotqf3kIs70gZeU2EXzbFz21Fn0cKY3lkkbqhyXcRyf7AP9mgBWW+SYS6awXncCcMq2lJjZsTi+KQd09gwhnGXCqYuXlkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgIVun9p3HbmExWmkSyPXi0ZP4KKvEqfg6Tx/AxFJHU=;
 b=jIgQKPx2mK9F0FMqgdO7chrNf+g6WZi6B4p6/fRhlDlqKTDR0gPT443XRN4XZ/hvXdymN9xy9ZmyGa4rBxxVPaqJm42YTneaBDXl+zYMVbNRsZMtxrVlsZRAKHxGe5laTM6Abin80Pp95lyhJYdv0rMzbqUIO+QuBTEpdZ8xAfU=
Received: from DS7PR05CA0096.namprd05.prod.outlook.com (2603:10b6:8:56::28) by
 SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Wed, 11 Jan 2023 09:01:48 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::b9) by DS7PR05CA0096.outlook.office365.com
 (2603:10b6:8:56::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12 via Frontend
 Transport; Wed, 11 Jan 2023 09:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Wed, 11 Jan 2023 09:01:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 03:01:46 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 03:01:46 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 11 Jan 2023 03:01:10 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <vkoul@kernel.org>,
        <alsa-devel@alsa-project.org>
CC:     <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <Mastan.Katragadda@amd.com>,
        <arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/19] ASoC: amd: ps: enable Soundwire DMA driver build
Date:   Wed, 11 Jan 2023 14:32:13 +0530
Message-ID: <20230111090222.2016499-11-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|SN7PR12MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a3b59d-4ab8-414b-155e-08daf3b27858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZMbO/9xkQz7wjpRoyTZrkwLdPuKL41/F1K56Bs+sHwf7C98Bu9nv7i+Yr0Vw0Zn05KyltXKs1+zAod+IsDUMzGD75uJm5BYslei7bHPf66iE4+7FWCOMsudWL+7CRNR4Ps9kaYruh8NfNzq24iM/oL6tQbIi0E+5OsrF2Pk92RWWEmh1x+IpE6JF2DQdlxIjTdY2CX7YRM4HGp3JBqZeyrJlX5Vh/Gw+N31fUGjNlPdejPKINehRKppc+RyuoTOUK5qgg64FfoaysDpizLWfKRGH/SOuIKhvFiU3Oo4c+pMncn5JRzpafMfCygGxNHihjcb22AQa+1zmR+xIXRuKn/kzmGRPjwEMdHRb8eIV74w+mYPAD5oS2/c/XSwNY0sYzsnfDpxXpyPQNcvvHqXvinw4xCW7NqhVcqFuZC4ZfD8smtSpWCfXGu0PHj1J6PSq3VMWEYYHhJNpdBktDlIQyvxwFDOYZDELVwsKayT3r2wy8fdWgo/3vIUqdnlM+rinxI0TJUcMxzZtx0C+YstccNoBoT7PCJ425UzfBaJbZ5BYgWPzAJup5m3yAT8yZHDmUlR2s22jAX17FIR5hiiEbGW6/6Az/TYMeNDvxMb0GMtsnAYq7ixcmpBau00F720QJzlNOtXW1lnmrL2yx3LQ/dfazCjbGCXDebzm0DQq11t2nz8PdrP1zYmsTisXsVzKDOOpJBslIGlsAfmWC/K3Qz9cjNbtfa97lR2D/zjWh8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(426003)(81166007)(41300700001)(356005)(47076005)(478600001)(1076003)(40460700003)(86362001)(110136005)(54906003)(2616005)(316002)(336012)(7696005)(82310400005)(186003)(26005)(40480700001)(70206006)(70586007)(4326008)(8676002)(36756003)(5660300002)(36860700001)(2906002)(4744005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:01:47.4332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a3b59d-4ab8-414b-155e-08daf3b27858
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Soundwire DMA driver build for PS platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/ps/Makefile b/sound/soc/amd/ps/Makefile
index 383973a12f6a..a3da8670e3e2 100644
--- a/sound/soc/amd/ps/Makefile
+++ b/sound/soc/amd/ps/Makefile
@@ -3,7 +3,9 @@
 snd-pci-ps-objs := pci-ps.o
 snd-ps-pdm-dma-objs := ps-pdm-dma.o
 snd-soc-ps-mach-objs := ps-mach.o
+snd-ps-sdw-dma-objs	:= ps-sdw-dma.o
 
 obj-$(CONFIG_SND_SOC_AMD_PS) += snd-pci-ps.o
 obj-$(CONFIG_SND_SOC_AMD_PS) += snd-ps-pdm-dma.o
+obj-$(CONFIG_SND_SOC_AMD_PS) += snd-ps-sdw-dma.o
 obj-$(CONFIG_SND_SOC_AMD_PS_MACH)   += snd-soc-ps-mach.o
-- 
2.34.1

