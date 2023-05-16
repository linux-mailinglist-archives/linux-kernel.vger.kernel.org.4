Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7AB704A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjEPKcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjEPKcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:32:05 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17B66E8D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItxhwPCtzU6J1WJkZslKKBAKKbYUaeesUTWAMmS7DXngadluc1Sd+H+VwbVM0/wGAEomlFWFJ+xakJ2cLtyHeQu8gZisrjdI04EQKe4U3NdXR1thY4KTGV9nBN66VTkV5cASQR/Ce0qMgoepK6SyS0bO4kJhweogvM757Lf6UnMWajoKCub0H1WgZ4MTQhODKPuMnBPM053NDxyLpHXYiTWnnx4ZZ7z6tpb7joCQw1ZRWIXkJkiHQnpfdjZzUWeH+A7AMCtOpuknRAkSM9QqM1zqztX0acCnz1elTmOQEeoXgEVeGvoUQaDLCZOSl2TQ2szPxgIUYiO0GblcPnuZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7q3wqp9JZp8Irn02OQgfhfVYR1Zfs9mn0nnSp9Y7xs=;
 b=Qb8rkuOA+wVDrJosEg7hEk1+HiCv4iwgUZHm3Llz50uz5HJ6UzvLX55UDQag9RkMWXcFwUkS2R5A40Wi5xvvv++NBpa5H3bZUAnfNqr5DyVVZjMF9nY2ObXWGBt6ldw6ucOlKmwv0ZZy5W3dJjs0Nmedeodmj8eTMB3cWeO4SESYVz0DIo5Nl7/E2Rj2518GYs2PUBn1rpq5aJwEAPf1Lbl6ygTB2A17ThpZSq8imJ0nq/SHsgvneGvJOZz1rORcPH7dkk5i3qQyQ+I5qUiRePgywLemyTceyB1ydNeqFEIDcURK+NYGhHXvpUhmz6A3mI/2+vCKkBz/qy+4s40SpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7q3wqp9JZp8Irn02OQgfhfVYR1Zfs9mn0nnSp9Y7xs=;
 b=MID3B4kyGUddVAN0m+I1nAZB1EceNrmceametARFGonVF6xza4B02N3Zg2M4MwOJnQnPFgjzGNxuec9gglYPcfCQxESvCjTMQLNnWZgXBFN3pVMy5lBqsq3bH7e+5I4A7qBe3M2g7wh8xl91DJV0FCtZW9PU6ry7SFvbMycRPlA=
Received: from DS7PR03CA0329.namprd03.prod.outlook.com (2603:10b6:8:2b::33) by
 SA3PR12MB9091.namprd12.prod.outlook.com (2603:10b6:806:395::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 10:31:31 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::9f) by DS7PR03CA0329.outlook.office365.com
 (2603:10b6:8:2b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 10:31:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 10:31:31 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 05:31:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 03:31:30 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 16 May 2023 05:31:27 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <--to=broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Mastan.Katragadda@amd.com>,
        <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Syed Saba Kareem" <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/9] ASoC: amd: ps: enable SoundWire dma driver build
Date:   Tue, 16 May 2023 16:05:41 +0530
Message-ID: <20230516103543.2515097-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
References: <20230516103543.2515097-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|SA3PR12MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: 15419734-288f-4dbe-a057-08db55f8b728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eknqLTDf05PmQMXXjczJVVorHP0eKLtYx2ZdLPOr4KfYLeo0/KSDLuiwZXHBehHnpMHntmsDVXo1csClVUPg/Wv+Skvobo64ac9F+FPK5HdNg4DYUNkJduTLy2LfedQb3dAa3f2LIf5SMXiv8SRh5TAPGbqrpATI6LoH6tpsQTUZLEecu49qDOWPAUmpK/KlJd2TISQHYvgEbqUs7JbO7d69040VfnqYmH9UYw3gIGWMwZ0eLQiQr0B9rK9jiwdAnkjKtRIE8r9HuPVmUs6ifQJbpv6eBkOU2qc/0WX4JfsXuFvayVQe4vMr5KojzN1YBz+9/F/jNp27dkrfA5kryrvTAy34wKosYXODn1Z104i0tfkuUSqIuSc70jyNIXbPhbhIuu9OLZMv+qTBznXOclGFYYwudobx+VOgnAXYSCCAxrcophWTO4NDb2RSPcmdXWjVbD0tRyeH+3soModleHaV+1sZiuAwWGwU8jQXRe2PbfwmdZA7PZEAesRJ5sp7+R9NytJLFrer8R1rRyrxVQDkrj79pLKHY7oPf4A3eL+ZU4S8WdZKx+d6C5/CmGad52NSDdp3p96BCntbL653rsaTFbqRwHQ4Fhc6UnTwjjHJDFWy6A+6zlOJj1HLYg/z1XcEmItwOgxsKsSk7IVC1bRMOgPbG31iKw7WQnqGE8Vus7x341XFdPJSfK2HrnF5W1u64rEkF+H65wH5WElAy5UtgVpIT+008Bu3SdRmL+1ZOyL/lkJQfTJRdy3wzSMQ8loX5d9A7OIjC6RpYhRuzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(81166007)(478600001)(54906003)(82740400003)(40480700001)(82310400005)(70206006)(36756003)(36860700001)(4326008)(316002)(70586007)(2906002)(4744005)(47076005)(356005)(8936002)(26005)(186003)(86362001)(8676002)(1076003)(336012)(41300700001)(6666004)(426003)(7696005)(5660300002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:31:31.5263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15419734-288f-4dbe-a057-08db55f8b728
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9091
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

Enable SoundWire dma driver build for PS platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/ps/Makefile b/sound/soc/amd/ps/Makefile
index 383973a12f6a..126a973ea5d7 100644
--- a/sound/soc/amd/ps/Makefile
+++ b/sound/soc/amd/ps/Makefile
@@ -3,7 +3,9 @@
 snd-pci-ps-objs := pci-ps.o
 snd-ps-pdm-dma-objs := ps-pdm-dma.o
 snd-soc-ps-mach-objs := ps-mach.o
+snd-ps-sdw-dma-obj := ps-sdw-dma.o
 
 obj-$(CONFIG_SND_SOC_AMD_PS) += snd-pci-ps.o
 obj-$(CONFIG_SND_SOC_AMD_PS) += snd-ps-pdm-dma.o
+obj-$(CONFIG_SND_SOC_AMD_PS) += snd-ps-sdw-dma.o
 obj-$(CONFIG_SND_SOC_AMD_PS_MACH)   += snd-soc-ps-mach.o
-- 
2.34.1

