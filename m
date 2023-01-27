Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADFC67EA50
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjA0QDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbjA0QCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:02:53 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3E288CC4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:02:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oS86atTSDIuU0myHWzGCUgM+N6BKIvA+5acveQV7DVPkbO6VuBhTBUSc8Y5DireUAMOPPf1KB9Wxa4aEkwMnLe2WA9m9ZTP5XXT+bvGMuiwzjqKsU0M3v9cEoJ5tuYN+RbPv42KpkgUX8SV3x/KhYHH9lZii8jhYbP5sv+tO7PeHCDrgaNYT4ETTbt9opdaxVe1nE0FosYuxA17xCIn+ZoABgcCgGvcfNUe3YJG+RnoOB1eV0U0LAQcm0S0CpNmqOnOL69Uyj23DsmjacVDUmBIxNxI7cgcKj/1iK20mHfWwRe8rCVFHcaqFT6t8TggLzSbcffhHdEm6G4KYih2yVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7myppTcR7oW5npvdU5XwvzSX65cR7yfxVbtsMstF1lM=;
 b=Fyr6xFrrqUBroqwc1q67OTBGyvyZvxi7OkOtHDyQ4hTPwUmEmIvG3vKo6ZP66VGnCc9D27eONeO6EOVSAFamQiCQ3+gYsFoBsdEkNP0k3eVFm1CKkkg7ucXMPyZ++R17/xAaLy+QRKLrtKjUk48inA5Syn+k5W434S2T0kA2SzT+qrRM1RIX8bj2H9yPGy/786Z6MlHq0lbKK1Yd+VbRtJ1XW+IiAhaPLLqD8KXOu03HXe5ibkmyGhUmgdLziX6EaV8+Sw3PvCUzJ0BO/sCturfosUQo7rvRZylsv9rfWVHjxQFmpuberIPfM4D52cjwNgY4oG99vlGlQBSca4oplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7myppTcR7oW5npvdU5XwvzSX65cR7yfxVbtsMstF1lM=;
 b=YgOjhGtqqEV9fCujtbCnRMNEGhzsDzNSPPib86qyvRUUK9oJy8v3QgVMM9A8DHH+wAghoQnjPuDTjaSM7Kdd3W/QIGyHfdcyw34m3aGDVKGlOL77ji93BwUUEgIZVMmCbsLWhnVQI1Eqobdm3V9I1XOug8JoZFks7jJQDZXJxiQ=
Received: from MW4PR03CA0176.namprd03.prod.outlook.com (2603:10b6:303:8d::31)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 16:02:18 +0000
Received: from CO1PEPF00001A5F.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::d4) by MW4PR03CA0176.outlook.office365.com
 (2603:10b6:303:8d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Fri, 27 Jan 2023 16:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5F.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.10 via Frontend Transport; Fri, 27 Jan 2023 16:02:17 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 10:02:15 -0600
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
Subject: [PATCH 5/6] ASoC: amd: ps: Adjust the gain for PDM DMIC
Date:   Fri, 27 Jan 2023 10:01:32 -0600
Message-ID: <20230127160134.2658-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127160134.2658-1-mario.limonciello@amd.com>
References: <20230127160134.2658-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5F:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 96515621-b8fb-4344-dbff-08db007fdd6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bxxWCbbkJZP7TY2sS8z+3HGAMEw9AsVv6WQlVCs7fMh2SFWSmCWrwWCRrdRsIRoyo70pLu9i87eoFLSV+g93gsNgTWabn0c2D6cPA5t8uyy+XQuZS29kxmrb0hlxRdEUj2Xg4yHCGTl8/2jpx4YrEir4vf5C14xDyrrb7RZVURDhDc1y05Cwus1xj/Q+CrIQ9SHKiGlFSn8rSPzgmCx5tKtWovlZz8JNqkfqSDRmJ+1z/C6Jya7OpqNLLx3MQ76SCKX8wIfzZBq2h0WduemkdeveeD5Yi1QYGfYNitDkDirac9jKbd75sOvA2T2Nfih15OKN0KoBjbEEpQEv6hqv0InpRgIKFyGGi8mF6/l01xavpQlIevV6lgtDlNFoS4XYAc+go1BpnnOqtmjwwo+RrU69YWHRkWrjy/dECMBv7WKHsnpc4nbhBFeJnAO297c2C/1YybxjT+m++qazPCibP0KPMwGM+f6w/Ys+/YuO0PoUjQ1xlbxTsSyvaQrUE3Ay0GX8iMOzwyhg6JgLlL1lnJhhSaBmeT7aFLdSOtFSU7lT1mf5YGOa5RmAK7jTqL+9Ms/1n1P2I970XYdA6aex7cRHKplEQ84B2TdO8nGCpHD8eLDdCpjS6+rN6XGb74adKeUp1xrpR9AO7lFKCEO53xcy3/KHFsMioEfDOlzw1ZiCSXrzpKYI8N9mG3H/RSRP23vZlvG6suvk6ZUQa1gKawhy1cGB1cJI82+11CtHfzc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199018)(36840700001)(46966006)(40470700004)(7696005)(186003)(16526019)(26005)(478600001)(47076005)(336012)(2616005)(82310400005)(426003)(83380400001)(6666004)(316002)(54906003)(41300700001)(8676002)(81166007)(356005)(1076003)(70206006)(82740400003)(110136005)(8936002)(4744005)(40460700003)(44832011)(86362001)(4326008)(5660300002)(70586007)(36756003)(40480700001)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 16:02:17.7174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96515621-b8fb-4344-dbff-08db007fdd6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623
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

