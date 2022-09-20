Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C255BEDFD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiITTqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiITTq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:46:29 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD4A6CF47
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:46:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVnLM9Ybng14O8MxFqcKDwQYs3dDU+csz+zuSD81Ti2fR1bPt9YT0iVzRgXPzzbKsVC4cnUaD4zKgPf4c5XK7DpHXFpOwmqGQQGNNbS5VbTUZ2M9da52rpnvDGv4jB4jWxmJKwvfukDdu1rmE6+I7emf0kCXMgyNq4PrLx8uu4B/28+YgHo5q0J+OKz64TX9xe7jjpfjUxLzeSBpU0ftYe96gBYQUjyFKnoeDmGeEuib84+B0BaFr20DcwBW4oDzRoDl+Ca+Ogkas9aPNKydrmZsjiCrMdLDj4LgFuQJ8xvcqucLQ4bnBk2ee7OLY0xCmYGxvnk83TeDx5CO/wWeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rJ3sNGeSi2CiODjEOTLym8GZM3kHeZ7oqJNIfNhJhQ=;
 b=RGmxufBcPbszsNC0Td3GjIfusGGC7rDoNJfeY1yqpGa7vN+rprkssDhSH8h/tibqrKW56Na2g/D0x4r23IPdoVBHzYVXCDADKhxB/ilf6IV4osmi7hsPYUjm7sKzTOEamcaWBcPCgP8JOzEDoOkrSKwKZrW/aaMncMeRzzpq0A6foFElw8XqJEFg4fSllNZxkdrIMGjb2Ue4QxLcvczoL4A833CTqbCWw6b6i5IoR6almviVFeNZdvTevY+Td+sSB4cRwEvCqrG1UyjqZ9ahXsiNkxVBnzWs/zuCTwjkW7STwUfnJR1g5aHGCoaHwPcfBN55La3pIkkGr09RGOTdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rJ3sNGeSi2CiODjEOTLym8GZM3kHeZ7oqJNIfNhJhQ=;
 b=cst7D0GBDCKTf62DR4UxDG0z6pGUNQnptqAdYtpz7VxRcnOwEAUZKZ1iABbkWnFneOGsPDEw7XNqWhvoXm6oCdHrwm1VTUtJx6+q0IB71psnhcKk8CNEi/k3wIZksX8DjOa0wAgWfyIIlzJTRQsuV/HvnpXcn3wZUbiWesXWWak=
Received: from MW4PR03CA0078.namprd03.prod.outlook.com (2603:10b6:303:b6::23)
 by MN0PR12MB6030.namprd12.prod.outlook.com (2603:10b6:208:3ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Tue, 20 Sep
 2022 19:46:26 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::f5) by MW4PR03CA0078.outlook.office365.com
 (2603:10b6:303:b6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Tue, 20 Sep 2022 19:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 20 Sep 2022 19:46:26 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 20 Sep
 2022 14:46:25 -0500
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
Subject: [PATCH v2 2/2] ASoC: amd: yc: Add Lenovo Yoga Slim 7 Pro X to quirks table
Date:   Tue, 20 Sep 2022 14:46:21 -0500
Message-ID: <20220920194621.19457-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|MN0PR12MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a357f6-1fae-4c3b-fd78-08da9b40ce34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gc1cyZrlpH2ZxBlKkieZklw2wvrtjjCuwluME0bBEU61SVfsLDHQJautM+pxJ4jZRcFOAkFW7jASTJVWQiUfoVc5NAnw5Uol3wOll/+jBe4GPtwYwznVH20ovfoLbrPCwpUNYb8kfjzAbHKcFHkYlUXOIsXaWP93ya4fBFMkWh63q9YJXb8D8yoidmOCvvy6BAu14Si2bEvTRACli5kto04egD4lIZe45wZOo5RS1OxgnDQW2xTBA3/uQuOrKdIhy673atMUMVWwHKu/7Wk3GAlrw768rOX/hLgICLCriLjxsKP3C/fylsYDLWxvTvPCNWunkcZfx3bpFHHHTBGl49N3Qwgc44sZDYsqu7JpeDO0jmsvCVs6tsrDdKRu+bksB6bDnswcVzH7j4GN0vDs2NNVbxcCiLcAZy6unXS9Hzi82cZ8Wo/MjrBYFFw+A2rayglsMdxWwk2zRFbMcoE8MTISndCly16BzfwR44z7CVfKMc43FeT63syso6GX7xycja+HyDnnqzk31TFHcc0hZX34xLKzXlKFyWzZmToB/XXarNYCrLlEnhPauf40l1hXACQS2Um7f50WboGdKDHirvq8aOK4L6h7sPkIQTWK4R+C5f2eEaaunlLJO5Fm8Jcrw8suXys0GnHPhB8t5p2gUn3J+BalMtHiCIXP2Qcy0NzGmvkvLkOYNI5/vLJUG5jSeqCJ4IfPkdMDcgszcYFWoB7fAs3ImW8Mi15HyvxPw86eThvcE3x9NCQwDJSC2uRK6qJmm0PFh7M46qVAjjHpSxoQJvsHMB9xc+jalfsNNreo5qYz9Rizvbo1Aim3L1cDoy3cgk4Kn72m18H5ZH498g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(40460700003)(86362001)(36756003)(81166007)(40480700001)(5660300002)(316002)(54906003)(110136005)(478600001)(82740400003)(966005)(36860700001)(8936002)(47076005)(4744005)(70586007)(44832011)(4326008)(70206006)(2906002)(8676002)(82310400005)(7696005)(26005)(41300700001)(6666004)(356005)(16526019)(336012)(186003)(2616005)(1076003)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 19:46:26.4263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a357f6-1fae-4c3b-fd78-08da9b40ce34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6030
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo Yoga Slim 7 Pro X has an ACP DMIC that isn't specified in the
ASL or existing quirk list.  Add it to the quirk table to let DMIC
work on these systems.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216299
Tested-by: Sebastian S <iam@decentr.al>
Reported-and-tested-by: Travis Glenn Hansen <travisghansen@yahoo.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 5eab3baf3573..2cb50d5cf1a9 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -171,6 +171,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21J6"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.34.1

