Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8616658FB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjAKK00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjAKK0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:26:24 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1150AE55
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:26:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG9Y9mLZbRuF6U7b+RuZUFB2RVVP6z53fdHHePYBIYRM1hIN3fvJdNDoNqRvVJQVT4gZarH/L2EEG/TfXhcVMmPN/VpUIwoS7Xj+VEqMDeCw+8/PL5H8MSyMLgYYkvfwto2xk2oUg0uxZd55EmcJA9mRWi4Vvp97Y3UDQPAQquKtnYQtUWG9wAsug5OcuUnEoCH/1oEotVcuCjH1a3hUdL/8qVlap+07s07ZuNGOwXbbyv7yBmP9h+RRDFVqm5ddHEDRAV06EANWnepo5+RQ/87IDvuNcNfDgd1ZR2cExU/o4oS3rrfJr5GF6Sngi1BcbC+AWMiEqpKylk05NMG6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBlsFihXnlnx6+iBGtFiaR/Xnzf9JlYuXLuqiBhedNQ=;
 b=nfDJ+rSR2i1evXTkXJqA+aZEC4J7WMV+6OCtzZkTDr7RnNamjiHULzrT+PRz6EJsMdGUffRN4QTC/9UFG5l6K2/lzxhKuURHNRaKNpjzXTs4gGOEfRwoSKWTbiQm+vrWnzFcH36T+REG4ach6JExs5ZpnI64Xp25ssWm/yYzm5BcKaeZIh298MlnoMoyl/0YFJ/C7LKDroaTVzKaljD6/yqxP8DDG63f5LygDlxe4WOHNqMjEb9gcUHq0ttBfpSUmzNETxlNEyg1PwRnAWBaY4o8cYEhJZUDfpCreXED81k9mWAnPcpVcGz8rHFTnHYg6Cl8X3G0TheJlF9MCIdtUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBlsFihXnlnx6+iBGtFiaR/Xnzf9JlYuXLuqiBhedNQ=;
 b=NbmQ44FBhUeBf8fP9pE5nWYG1gIQEmiDvTnSEW20Cs28O3Eu1msHQhLIWdnwv/pRk1maAEwIYUQSY7tOxYPy/6Fk/3aaMDyP3wPaecLgjeBjQ31LUaKp8l6IUBxJr+JWPgkpknQyARC8TCRHZKaIWwroN+ZHe1an3/XAkcuEB08=
Received: from MW2PR16CA0041.namprd16.prod.outlook.com (2603:10b6:907:1::18)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 10:26:20 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::5f) by MW2PR16CA0041.outlook.office365.com
 (2603:10b6:907:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Wed, 11 Jan 2023 10:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Wed, 11 Jan 2023 10:26:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 04:26:19 -0600
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 11 Jan 2023 04:26:14 -0600
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <shansheng.wang@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linkt <xazrael@hotmail.com>,
        Xiaoyan Li <lxy.lixiaoyan@gmail.com>,
        Leohearts <leohearts@leohearts.com>,
        "Artem Lukyanov" <dukzcry@ya.ru>,
        Brent Mendelsohn <mendiebm@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: yc: Add DMI support for new acer/emdoor platforms
Date:   Wed, 11 Jan 2023 15:51:23 +0530
Message-ID: <20230111102130.2276391-1-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 0687e553-6a74-4378-4574-08daf3be481c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ju/3vSZyizG/QcRXNarr/v/g32Q3SL4LvmA7EI4xZBooMluaPPrs7ad7k+f8NSljkqhxhfed78jNL2oFDZBNUh5kpbErPFFABrCqQjIp813saottJks/Y7sidmgbMjmMAGdpLEv3sLV67i6XTCNnUfV3k0SkNedbTHNXKSEJdClD9R8Hgz9Luy3ZdIw/YffXdg22bR26nOKJBaGbL6e6WtUZN8ahF6oEC3gfEVyNFZsOu6BqEs9H+WBVXfCJFlt3iqZOcS7x9Y/VuRwTh11kreo4HP0x+tPFWPEvEyfDn1tCvpyOW9Ko3nrNrVBgzZ59sWGUw9KzDL35xxddlvVvh7lBQItUx3nQ0WcxG3ouf15LsPzjSmd5t1ofRDupVlo3llQlsUmZ+58DZ2RcEJnroxzKUbyE+2nfuEbncI1ZFLzuqanRj0TTK1ozM1W0N80PvtzjJCqbx6QSOLmMVak5vTh49/XIhnQaIzfj8hTYryQEsQFpdrW4/dK4GgXSPfcRlI0pJfJbRGJoj31LY3XoSBaodQCI8MlJKQCDrnNh0a6iTCsyeNbd9Lt0tF0cRay9DuVt5R+oUkE+i5mBKYnhbt16/hl2T9uWiBWwlHI9lpNk0twr5ZnAf03rwpUB986WsSCVyedr8t815/1MSiFaRUKcd1D7vu/u/+1vF7L8QMwcSvhd7jf3z+A1uyaJKqR56ISE5757wd05J7UWb/U7lRrAXLTu6EFb3z0VYg7hkKpRwATmXVDDoCP9onFxnOdF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199015)(40470700004)(36840700001)(36756003)(86362001)(7416002)(8936002)(5660300002)(40460700003)(4744005)(70586007)(426003)(336012)(7696005)(26005)(186003)(478600001)(6666004)(2616005)(1076003)(356005)(8676002)(4326008)(70206006)(41300700001)(316002)(82740400003)(82310400005)(36860700001)(40480700001)(32650700002)(81166007)(110136005)(2906002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 10:26:20.3619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0687e553-6a74-4378-4574-08daf3be481c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding DMI entries to support new acer/emdoor platforms.

Suggested-by: shanshengwang <shansheng.wang@amd.com>
Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 0d283e41f66d..00fb976e0b81 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -234,6 +234,20 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Blade 14 (2022) - RZ09-0427"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "RB"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Swift SFA16-41"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "IRBIS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "15NBC1011"),
+		}
+	},
 	{}
 };
 
-- 
2.25.1

