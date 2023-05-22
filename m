Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE4470BFBB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjEVN1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjEVN12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:27:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EB2A0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=To6Ao062k8aQ5gGTaEDEdiY53NByrXepevaas/yS88nk+7WdKJpg0ZWE873bUinaxPwh7Ms+QzwW5Tf+A5uw/tZ5QFViErzDYo2R6/bpmNQ7UW1zHPtjLXd0QQZjNV6JWAZSDVR3f6ZK4j2Kas4/z6C78+Bv0Ed9wlmsgkRPS19iwnWVdwEc1iu0QKb7qubw8excbE4HIg6tVeXJZJX6Yohf50LPQVQlWstgZ+r1k6YDoT+vYloU9K+ynr2CZEZrx93yEzaG1CZPTHbN28x+/F2fkgKR9Wi6LBTWYzw7RxY+WHk6JbrtURZqQToJtu8jdIoJUx9yXj5ovawFPZBwzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJPO76LeVbRLT6xdNfAEfol9vXoNWf/MqxjxFnE4yls=;
 b=Ob01qGYA+zCkAUJwlQ/rojKz69OQ8cI5zddpeE7ld1LD4o8XGCBdWhikP1CwMdSiBjohomDRG0v6oYWYYh9pXC0AFNop0e+JP0wGu4xWgCIYutUVcTwh6XLZeT2FY42kJlMR3vnh2WQSNfWfpbjRurv3kIU6thB5IgG0I0vjNO3veZ3fgdrvoF5SXYTqIFgQWS1QwBSMYFoKa8LtOVA3OAbfPNgD/yIkXlpwGNFO3RwjFD4vqjHrh3bZT2m3o4hHSs5lsAzBiKOknba7OkKupWsydXcE6lLUcFcFg/pjBuIQv/vhWMvW3DpJky+E/UCdOj+mq8auZuIRsvFUBLkfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJPO76LeVbRLT6xdNfAEfol9vXoNWf/MqxjxFnE4yls=;
 b=QuN+DVNI4tl8Oh6E60aFNMKOiCn+3ZuXHH2ENaIs/scuH8HqkpzXiQovxXhni+qMCJBiX1aSwVjVDDDLnCKwzxyXEi2AaiIAamJG85PH3iJzYtSSXbWY8AKDJlKojEKhN/vOoTVK/97n1DDmcf9qAllA5F6quBiqoe6IsJSjjLw=
Received: from BYAPR07CA0075.namprd07.prod.outlook.com (2603:10b6:a03:12b::16)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 13:27:13 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:12b:cafe::bf) by BYAPR07CA0075.outlook.office365.com
 (2603:10b6:a03:12b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 13:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 13:27:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 08:27:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 08:27:12 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 22 May 2023 08:27:08 -0500
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
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 7/9] ASoC: amd: ps: enable SoundWire dma driver build
Date:   Mon, 22 May 2023 19:01:20 +0530
Message-ID: <20230522133122.166841-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
References: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: a33dd319-4eb1-4235-766f-08db5ac840ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6eZGlCNSQoQVeW2U2LtXELpH1Dj0mFfbc9iiStlAg+s120cNJQWWyXtUACMQG9Mw2xjp0VkYiFvIZO6VHRbSobdkScmdgpsMf6hfUozB9TEB/EH5dGZx6bqXdfvx6GtsTtHlaijXCb6OVKvLAyyd54/isjg/XJfA7NnBYidiKpbmxx6rOxOijMUHgbB5HA2oW77EU1Ybef0yv8tsUzkGa8XtQ+oabYFiXMV2J5ZC5MPxizIcNFayB0PcKBCNHPJT4517R9J48hSQJuBSS0qtoHQsZvcpSlxQTYHyNlLI0Adx1KPDHPiRTCButSq7nyFjbk4vQaoHzkO9Nu9nLEJG1pRXUHt3z5EavXdIbfc8BfaG9F1u3/6G8/8Db5Dr2vbY5DOwggiRgOQp+YMAKYWUk4aqnl/bGj1KiX6QCimFnJxy5WKorm05DdFSPknyt66R2vzPFj/IyaEU/fa2/Vh5XpRIq703j1g1l8YBXN5+wi6e2TfoaAVwDtOc/8HCCudpg9oyigT8FTcbxjuIFYkYRg4PbBD9I2WeNGmTJOO8BbLtFcgBtgpp9ZXDphP26wlE9FjDr/m1P3FIRMWs9LkKlcEXNmAOaXlujwotM7kptwhSapeBFii/YaA/UiedarsVeS2hEvib85myHvYyntLgZIzD3d7sc8t5Y7QOqMZbEamAoWZBQk+7NDmfqX6UEGShcEXXb5tl8AX3ItjHBIllgCVNa2yhmOTlBtdfRyA3QLslnz+KVvF2MQ1y6zuV4T52NM3S6c/DsLeTXvyKMxW4GQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(6666004)(86362001)(36860700001)(316002)(54906003)(478600001)(41300700001)(7696005)(70206006)(4326008)(6916009)(70586007)(8676002)(8936002)(81166007)(356005)(5660300002)(82740400003)(40460700003)(426003)(336012)(2616005)(36756003)(82310400005)(47076005)(26005)(2906002)(4744005)(186003)(1076003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 13:27:12.6654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a33dd319-4eb1-4235-766f-08db5ac840ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SoundWire dma driver build for PS platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/ps/Makefile b/sound/soc/amd/ps/Makefile
index 383973a12f6a..f2a5eaf2fa4d 100644
--- a/sound/soc/amd/ps/Makefile
+++ b/sound/soc/amd/ps/Makefile
@@ -3,7 +3,9 @@
 snd-pci-ps-objs := pci-ps.o
 snd-ps-pdm-dma-objs := ps-pdm-dma.o
 snd-soc-ps-mach-objs := ps-mach.o
+snd-ps-sdw-dma-objs := ps-sdw-dma.o
 
 obj-$(CONFIG_SND_SOC_AMD_PS) += snd-pci-ps.o
 obj-$(CONFIG_SND_SOC_AMD_PS) += snd-ps-pdm-dma.o
+obj-$(CONFIG_SND_SOC_AMD_PS) += snd-ps-sdw-dma.o
 obj-$(CONFIG_SND_SOC_AMD_PS_MACH)   += snd-soc-ps-mach.o
-- 
2.34.1

