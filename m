Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FC4683593
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjAaSr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjAaSrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:47:17 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0D5589B3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:47:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=li9DctEoKprLLvdtsOBXTQWIQj9FODte5ohCDtrlbzB1VQrlY1wlp8p+rjpISMeCAR7YOKvCS2T2wrPmEWm1YJ/XuJOdRE8vUwKrau5UfBKO9zRZFa6JzYOss4DT0RooNJ+pAKI6/xl2zn+OzYuNJ76cynnrBHHJrBCQ3WnimJgwWHgXxixfgXGIGF6szWdogmqqYc4q7ebTAU+AfeyjGF/H7rF09rahTsbjmEL5+EifjVspgCblB6OlnhJortJvHU/FeCysSVZN8fKXZkneYIM3sQG4LcuKMh+Ebn7FYgEnizZF4FOV/I/kHLD+4BzLj0Yn/3/gohm0HHypTfdEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7myppTcR7oW5npvdU5XwvzSX65cR7yfxVbtsMstF1lM=;
 b=IJot68EsR//7Ys4Q2ZebsEIOTeD+NW18mwkh6NYK6zQoOk6CCJjql+A1LXLaTQTEAsRniXTltZP1CxHcUSfeLpSJ8uxCD9/Jp6dqKX2YU96OHTslcySpia0EQ7C7PMfNW7uHVF59YfpzIpOWH9cS1bhdatOc/7gNzUC5lY2FZbjEDeBvorYOiHVGGuMEu/ugheNSUKnxTmiRYqfVFW3RaFCSHrrRPh0/zx/jw9EmDlLT1me0vh6Ny5q/wtQ36v74COHjigChdyfgTl6BVOjv1xViLF6LgfVXdjuNv+U/+YDkzhFNOo5VuxJ7RKJpvDf13QVerExffpXd621szjwDTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7myppTcR7oW5npvdU5XwvzSX65cR7yfxVbtsMstF1lM=;
 b=TZrFdgIiBjcm7Li+wljLFxCBLhfRyPO2rq9eHVmslNXVY7ixLusDaO17EnNSrZT4SXxtUBa+AtcYYGd6DYCGjTCo59rI1e/vctlqiEgyi3uIkh+m+DQJ22yetcmqPcgSfFFnQbnOCPCy6vvy/iGpJwcaUM7FbG9cHWZlquC4caQ=
Received: from BN1PR10CA0030.namprd10.prod.outlook.com (2603:10b6:408:e0::35)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 18:47:12 +0000
Received: from BL02EPF0000C409.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::e2) by BN1PR10CA0030.outlook.office365.com
 (2603:10b6:408:e0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 18:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C409.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Tue, 31 Jan 2023 18:47:12 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 12:47:11 -0600
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
Subject: [PATCH v3 5/6] ASoC: amd: ps: Adjust the gain for PDM DMIC
Date:   Tue, 31 Jan 2023 12:46:51 -0600
Message-ID: <20230131184653.10216-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230131184653.10216-1-mario.limonciello@amd.com>
References: <20230131184653.10216-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C409:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b00ed1f-e7e2-4e09-77c9-08db03bb90b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQDAkiXbjouX4fXFf5aUr/6pcEfJBEn/jgu7MCqXLkdHBCnD+YzcJ+wfqYXFWvdXbl9614joQQIH1RSOVQ08tXQGbSR8mz+ZHOT6lDeVFohLxG6N4Q/QmAvzdaZdsZ/4eee7lLs3jcclZ5OyilO19D9c+xh69t6ToxYcTwjSwjHs5ENP8wEXGasQTdiTRtMxQ/ozxTe7V4vvx6kZuhteXNe/LjqL1muZ9WUapUZDs5tXQvKt99iUXwRuRaVFmCz+8bKR/AYAs/lHlVRBnP/gZEP5VV13Ttz1ATPTSVUG20PcEzhGsFX3ODxYSxXw1e4Gxd3Ln6WYcuNBvjJgfO+aluq6FegL0XsmDIyIuSDLHlrAVENK2HQZIf7KbSMPQ/QFs1zcj+DVbi9tDToYhw83uTEm/OeflaUalfjpt1currVnNAGQ3dTl971nqCZLuauYIMx3noOVCVGqrshwtzzw1M/RfGXt92m4BuGaXCsXMYtHcV5z1TVIyPbbnHepa+KNs2d6FN1Lu8uBdywgLcf6korHIbULg68NWKRlkuvBxfKsV3ZgEfaz6oKis+F32es0i355xd8McAT30feGFBaeAjZ029+CK2Ktv15vrXenTaOHOgC89iWKRFfCICI/QsXDZSgDv0zJewa13XgaHaZNi22g5dUs4Xd8R/RBEOzuHOw2NEPzYqSpxgCjEH9yKBhpV1yktAkjt5/JXAe6H1VeOpT37+DJiYR+Fm/X6LEGfhI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199018)(36840700001)(46966006)(40470700004)(44832011)(83380400001)(82740400003)(47076005)(2616005)(336012)(426003)(356005)(82310400005)(2906002)(7696005)(36756003)(81166007)(36860700001)(40460700003)(1076003)(86362001)(478600001)(186003)(26005)(16526019)(6666004)(40480700001)(8676002)(8936002)(4744005)(70586007)(41300700001)(4326008)(70206006)(110136005)(54906003)(5660300002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 18:47:12.4036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b00ed1f-e7e2-4e09-77c9-08db03bb90b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
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

