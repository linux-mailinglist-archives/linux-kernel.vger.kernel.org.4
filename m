Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE715BEDFE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiITTqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiITTq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:46:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A496CF60
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0eObhtkYUrL1I05k23YKhQda/E9uFd5KDKkNOkcZswaVdo9jPR8g1S60hE27HWdIY8iqpXlTqSZP/b1Nf9YF2BAycXUo6OzsfbWiHLRBrbhOt5e8GBPrSHHo259Kjwru/aDV0u4tFYnuPFfKQUtoqjgjFNCh50TKiae7qDHHMVL6xn4RqwQnagTu2V91qWKYbPR8v7pVIm/9NSwhJPXN2wJJFrF3ZQ0lk6X3lCKcs886jPiku92UIB2CbrmWMHN5Eav/x8srfWlmJup1byR/+p6tjJ8Lg9e4jiyE6gP1y2elYXrnOoJ031Vd6nGZhqp2YWpD7TQ9voCPj7MBdotjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0rZCed12r3AjSnCcCX5SoHVltbRbPn8rHjhagGh0XQ=;
 b=LYY26I4H8MqUWjjOTUPv7xWbWxa4dV9kXnaSvSEqhUMwAqAiByz4LajCw7/jbfs1D/U1+BbdYYdClaeOxrV43EaGCLVh2mTRPusciOcSUm3HDPWZF03A7xuKQXyqpuZbUD4frAehfQ5+vyBG4TY37R5y+LPMzNUcsqHwM/rwzHsb83vXtPmYQjYahDRrT3SZkT1x5onHEjjIycee7NIvTaO94axeEUGu5mXi+JZF1/4KWwZzmqdxWnpzsj/XFEOXkit8t+lSDTr1WzBjuq9gTGDXj29XKu4Hybd/KHYUl1fwtwro5/0wCKN3VOMFohEO//DJwa6dWLshLTz3aB0UjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0rZCed12r3AjSnCcCX5SoHVltbRbPn8rHjhagGh0XQ=;
 b=WEsskpZQCIhzcualm3YUKmJxazVZ4AE+L6zdskmxbTlxYgjYyacK7Jp8NxrhW75MbVSz9M8wf0v8znBbwECPKCn7t/7BYC1LRpVMvEjkrKIB1F0YoZCBXU9cKXZPQ5IBF1Ey7BNZCfP4LyAQNueeYzdpu8yN1dw+iwOoEIj2bd4=
Received: from MW4PR03CA0063.namprd03.prod.outlook.com (2603:10b6:303:b6::8)
 by CY8PR12MB7100.namprd12.prod.outlook.com (2603:10b6:930:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Tue, 20 Sep
 2022 19:46:26 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::1c) by MW4PR03CA0063.outlook.office365.com
 (2603:10b6:303:b6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Tue, 20 Sep 2022 19:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 20 Sep 2022 19:46:25 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 14:46:24 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Saba Kareem Syed <Syed.SabaKareem@amd.com>,
        Xiaoyan Li <lxy.lixiaoyan@gmail.com>,
        Travis Glenn Hansen <travisghansen@yahoo.com>,
        Sebastian S <iam@decentr.al>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>
Subject: [PATCH v2 1/2] ASoC: amd: yc: Add ASUS UM5302TA into DMI table
Date:   Tue, 20 Sep 2022 14:46:20 -0500
Message-ID: <20220920194621.19457-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920194621.19457-1-mario.limonciello@amd.com>
References: <20220920194621.19457-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|CY8PR12MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d1e77f-ee08-45a1-796b-08da9b40cdce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mcM1LVAxsdzfqCa4115qzkLYj54gKCBwAa4+ZDbKHvErnTI0N5scVRhwIsSL3M5pc/iEmv1Dry21PPmXpluguPD4vH2Fw04NRRhsl5X4LKFrKxtk64bBcaw3uCDaFBxXo16CfaTQ6hLYwXhvyFNTH6KqGJ90VoKXHdu4l1mjEhScIc/ZBS0rcjpVMEgHrtKgDI7U6xlW7IcEEGmClZ9il1UPFFkkOC1Bk4WiIiyQe9/bnupTUn0dNC1HgK7yrHkg5+tz5vOAdwhJkxtWXzKEGgs6UEkC7qfGmg1kUCM06JzaM7ix20ThtPTHXl+O+Mriorp00RAuv7Irr4wa3XMuIJF2Eb34eL9i4rdKWJo5mMXcMoGIpfjw3+nb3WEdkonv/f5ywmhezBCeS1sETDGLF1JPf6yEtAhhV9IYF6oMIE8kNV2ULvK+HYzmlXGXpHy/XWiIK80VxmXVyIb/mV5IERH+mJL74rCpTD2Nb82a2G10KKxgUBgTMbXDt5ZlGON38rC7gDn67ChFYOl/FMBISlc93lNX7iQgT6Zncu+rX+JH5FtYWVrrNIsR3/aC+U2pnltdJctzgzMoYpvVNL67Oxyqoyc/i1fMkIPJHA9GnqPsm+cnVncQ3nbLWAKMcxl2+Nip7736B4moWVF02/SIVgv1FLFkxc2+QhLdJR0lL8avWkf8T+kVoFq+Z2JaO+t4zQnuy4e7a8hpNE109uZzuN2duyJdTOdMvPKs0Ofq2uKkC0JA9LCHL7C140TNTfqMrAzev+lvxiDpTERE08BFSGGuJhbNoSX/h80ji6C7ATNMdPJmSlIzYYLEuwkTmUJHuOgXimFgJszWq/18WbJh6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(2906002)(2616005)(186003)(1076003)(336012)(44832011)(36860700001)(4744005)(426003)(47076005)(8936002)(5660300002)(966005)(6666004)(7696005)(40480700001)(26005)(82310400005)(40460700003)(316002)(54906003)(110136005)(478600001)(70206006)(41300700001)(70586007)(4326008)(8676002)(16526019)(82740400003)(81166007)(36756003)(356005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 19:46:25.7544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d1e77f-ee08-45a1-796b-08da9b40cdce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoyan Li <lxy.lixiaoyan@gmail.com>

ASUS Zenbook S 13 OLED (UM5302TA) needs this quirk to get the built-in
microphone working properly.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216270
Signed-off-by: Xiaoyan Li <lxy.lixiaoyan@gmail.com>
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index e0b24e1daef3..5eab3baf3573 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -171,6 +171,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21J6"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "UM5302TA"),
+		}
+	},
 	{}
 };
 
-- 
2.34.1

