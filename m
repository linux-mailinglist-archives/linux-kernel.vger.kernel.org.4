Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C83C681DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjA3WI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjA3WIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:08:16 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CF186B2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:08:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ji+rGmFhK6N+cvVBRGJtmMX84dds583YdSi3YLPoYJRsv5Ip8tLtmluBmhGE1Gr12uD8n51ZrA1NssaoUYjGOwvpfYjrWfduy1qRpun4wz5BiGXS8wE1l1y/GlKKuwTKm79d+AeaATGeaharqnkqO4yBn6OksYhY6NMm4HAUE6hHdFRTwhrcnxdNFnL32ZGQvcumlnmSLcLOAg11ViqCHBNWPL9ZyPuQJUZE+6eNLhXeIW3zJ2BE6VdshR0Sctu62GZXzTVN9k+sx1MIUogt6JqBS6PbZGn9AhZNRB7tozN+BPy3XJT5JMPvKhfnFfUYaFK0sFw4fx77I0+x81NvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7myppTcR7oW5npvdU5XwvzSX65cR7yfxVbtsMstF1lM=;
 b=PZv6iW1084G/iqMJHozQ83t5yRjyVwa+GMOX2R4ebRJpdUnrOoQSp+coTRj7i7Ze6ScLghS4lfCKUzJ1BidqT5ldxY0LV631+gJA/cp1zGESEW9rcO0MhAVseHU0bfb5nY8QYQ6nCTgx5MbKxVK8AwII74clTChu6Z9ZZBvaLHA7NPKVOB73WOtJb+qc5G1LqrWBL/eB8wtfvFJHpr2ATrRwcCSen/GjeVYyqqG0vA7VvKrnbdRfi/JgTpehb+on7f+NaKaH2uiATFUSpZk91ewCfL3DBNRG7iJoOknepW314kcToxCPpWjqKVEB4GhJwMS90RaKQFEDMQsFqMAMiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7myppTcR7oW5npvdU5XwvzSX65cR7yfxVbtsMstF1lM=;
 b=mlGV5BZJJT84p/jw9nWwRO9jQKWBtgmPmNrELgSetAl3y6XqNKmy5IUZj0j7Y5Xd4eUuyYFN2auXtaZjkBc3K1b9bl3dHM28psQZGH29kgzZ5qaMY6mvdZKJQ5CKxV+nCWSKsvG197d/T9QoHh1m2BoACOF8NmNrDqVtLMtCRjw=
Received: from DM6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:5:1b3::39)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.36; Mon, 30 Jan 2023 22:08:12 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::9e) by DM6PR17CA0026.outlook.office365.com
 (2603:10b6:5:1b3::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 22:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.36 via Frontend Transport; Mon, 30 Jan 2023 22:08:12 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 16:08:11 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Jaroslav Kysela <jkysela@redhat.com>,
        Mukunda Vijendar <Vijendar.Mukunda@amd.com>,
        Saba Kareem Syed <Syed.SabaKareem@amd.com>,
        <linux-kernel@vger.kernel.org>
CC:     Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>
Subject: [PATCH v2 5/6] ASoC: amd: ps: Adjust the gain for PDM DMIC
Date:   Mon, 30 Jan 2023 16:07:53 -0600
Message-ID: <20230130220754.8379-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230130220754.8379-1-mario.limonciello@amd.com>
References: <20230130220754.8379-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 406f0b7f-c0d1-41dc-7c5e-08db030e7ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLDCKK0AaeHaf6Q7hAKw4pENjvqbJ6zSMwrYCETAcyJpbs1fxU7/oQcvVsD5iSAMJJXROmuvYmu9Wa8g6+Bs7dKcjTX5nf7JdngYcnO+0DdeZCfbc8F0DaB4vuyG9sl6vo2PAtoZeMSeJuqWDZbhucqi99WNinpGfV5Bv/VIIvIjrmISHg9TNuHTrhYerkHrKtyJN4IDmGNK594iJntZ9jbWZ8CGSthyhrq8+VqDa+5k5Pnj0ZsobTGcakMnJquQWdYTL70BDIjMTUQtunyLodirfKtMitQkUBxlPTloKcWgTUu6EKgRfb3NXikKTWhzW6p7/K6cFvfOJeESlJ0pE4TkncxbvxyvMGJASaZ8MdXzEh/3r7WTIytfwjDTfkM13NJaFurS7I2aE5eaycczbY5JYsUBoiFJ8pRrvCeqJ/Y9kdOOKPppaRPotDjlq0JSDnZYTtHXxC0EQvHa993a4lGfuW27mteOcaPYVNLtjlXFcZxGJXNDMHnB/d486G6OE041IWidRgNnImueTgAIAcyQp6zRSdKqWfOcX2XEKkaJAGmLgN35veBfwtg0eqg6TKWHGugg0t3UtHx1/51+WhDsvDW+koiZECqGrqZhjG81BdTtX5g5TW/hfnlLfUiHjz9SHuMPgCCWwLVIZnfdfGYcVvn2zJfBjWKAMJycmo+6W99F7BurL3fnOXVy6VfUfMoCo/1pt9gP3ue23V9+UegDn60795YqzFWIwy+riDw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(2906002)(5660300002)(86362001)(44832011)(4744005)(47076005)(336012)(426003)(83380400001)(81166007)(8936002)(40460700003)(41300700001)(356005)(36756003)(478600001)(26005)(1076003)(7696005)(6666004)(186003)(82740400003)(2616005)(36860700001)(110136005)(54906003)(4326008)(70206006)(8676002)(40480700001)(70586007)(316002)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 22:08:12.7316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 406f0b7f-c0d1-41dc-7c5e-08db030e7ad2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No issues have been reported yet for DMIC audio level on ps platforms,
but as problems were found both on YC (Rembrandt) and Renoir based
designs it's very likely they happen on ps too.

Increase the PDM gain to solve this problem.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/ps/acp63.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 5e7f9c1c1b0e8..bae8288d8231c 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -30,7 +30,7 @@
 #define ACP_ERROR_STAT	29
 #define PDM_DECIMATION_FACTOR	2
 #define ACP_PDM_CLK_FREQ_MASK	7
-#define ACP_WOV_MISC_CTRL_MASK	0x10
+#define ACP_WOV_MISC_CTRL_MASK	0x18
 #define ACP_PDM_ENABLE		1
 #define ACP_PDM_DISABLE		0
 #define ACP_PDM_DMA_EN_STATUS	2
-- 
2.34.1

