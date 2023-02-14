Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5134C696863
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjBNPrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjBNPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:47:15 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A9E29419;
        Tue, 14 Feb 2023 07:47:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGUQOvV3nx77UQI8RCkZ21zomEUiOEnsHfUSPN1Owlge8FZPtqcVPdpA1/XCqfWWv/iRJvb0bYqEpAJIGdMySEnNaTXohWY5o4yehNXRyfLGrN0JgrSiWYz0LrGhViTqOmdyGvFPI35UPOkb8GzhtFBxZkFxDrY0jXiZE1rpaaNqRp61+7AixQkhiTCnTWPuGRkRamEsOlhaEQ5U8dl67yyMtSj9uuX17bCsVM61tL2iCfUDoaR2p+wsg0yFzvBf+Kz+NOWemxbv28EwCZLpfEtDW98V+aLjoM0mtND/HT9RABfuscFYCZipRp82Sx47J681BTIzCsCH0QYaytnfeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5ICP+N+nPY3NL8L2EypujKXcsxWO7mxHlHtIoD3Vbo=;
 b=XNz4MVKa7UGA1RoQOScSaaVzxE3q9+w6TNQoWUo2gzGXgfC1tkVIjx1A4NzoeHDUMkQQW/q8dGTcywDyg6FzkAAVTV9vWYWih67REEtaqaUyPgpT05iRMnrB7wCpSEWCBzl3qYL7mJvduEGUos0CmMhXSzYgXfPrCiVFZUf8vCnGctZNJO0HZ77ylTgSuIkiRnO2VHuwrY2X9BrkfvIHWlMIXex3MhOG7vqNW7rBxPHmlfIELUZhFeFJZSmhQXIpLBTeE/pOGVvZ2KBZUMcweyoY08ILuX7E2PBSfRkHDFJdPJNfIziy52tFTHgJscfBDwNtAppgIdQjag8TfWo/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5ICP+N+nPY3NL8L2EypujKXcsxWO7mxHlHtIoD3Vbo=;
 b=sQVahbXNiVE2kdwI8MvwpKkrz2qmPJqKp/sVdhmBex6MUHTFuBsd2rHpeDPaPC6LVJJS3MChO6iWOZBk/PQpKt7JOt4uOdiwkMehzhPL1Qe7vJ2mVlCFujE4Xu7zZR8XuWbMJTsACkGcgbLmDtpmjSyb2EYdYuJRPYm59XgoOT8=
Received: from DS7PR03CA0261.namprd03.prod.outlook.com (2603:10b6:5:3b3::26)
 by DM4PR12MB6615.namprd12.prod.outlook.com (2603:10b6:8:8d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26; Tue, 14 Feb 2023 15:47:13 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::c1) by DS7PR03CA0261.outlook.office365.com
 (2603:10b6:5:3b3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Tue, 14 Feb 2023 15:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.24 via Frontend Transport; Tue, 14 Feb 2023 15:47:13 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 09:47:11 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mika.westerberg@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Yehezkel Bernat" <YehezkelShB@gmail.com>
CC:     <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] thunderbolt: use `tb_eeprom_get_drom_offset` to discover DROM offset
Date:   Tue, 14 Feb 2023 09:46:46 -0600
Message-ID: <20230214154647.874-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230214154647.874-1-mario.limonciello@amd.com>
References: <20230214154647.874-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|DM4PR12MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aae9e30-532f-49ed-0bd5-08db0ea2bd91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHqonHCQotnje0bEWCwGLfenaXCi+yoF7fIlEr0KtMrpmQ//AOZiKOqkWtQN+uuIIoFz4zehGuVbOkEMo4w2VbqMoIQoZXs/6VdW/rSgkejhFAy4aZ4hndP9Ov9V9grbpqqM1AfDQEL+OQoz2tbYgi1m7Zsos+Jwilu3E7+CgiOjkjaPOstfiiZUyHpRltjy5woe3/ZVxeSXGUNRtLxvHXtL4ysinT5MIf8tTrHznRNqoMYemfG1nJ/J9xEeHSYfZoiBbv7TbPWl0jL2vj1auSvPbheQghbHHI9jfLJaU69J6e/IGZ4KOVBhs9UdJBJApYoFAAYZz5RcoV6H2c2Rcopkhm/taueo+t3LTDXCl1lG3jXtRF/0B0zGwdtGZGl0ClVhpGEaVvm48erU3BAsFFOMwkPU8sGeZr9SFlV3KDXYfP5UKaPhv64c8jAAwIzruKTsnqcldrO7MfoGjRdI/8x89q3L1ZxnSiYEzioMXOL9+IRJMvo8WTwBffmSM8fHXjpumpo9Kk+suRfSIQoiede+wzN2Yywc/LrBAaGzjDQhfMc7gvrChOqK9pnw56NF/6gcIc8p4pP/GGsZRz+xcpYjbcB/mcp927S/gKSw+dNAmw/qmVx2WWPsmPjITOtfz02dbqiFXBaKicYPGlf/8Ai9T7kjsXpiO82Yx1heKiLwyBrM+HDKOZM5NBqjYFMcpJB8BAtT1N9AQpiqR9YWW81ahsvYh27++C8GWmDmvpiRz/JongM7/Mo5ivxChPSs
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199018)(40470700004)(36840700001)(46966006)(478600001)(41300700001)(4744005)(5660300002)(8936002)(110136005)(54906003)(40460700003)(82310400005)(8676002)(7696005)(70206006)(70586007)(86362001)(4326008)(316002)(83380400001)(426003)(47076005)(336012)(186003)(26005)(6666004)(44832011)(1076003)(40480700001)(356005)(2616005)(36756003)(16526019)(2906002)(81166007)(82740400003)(36860700001)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 15:47:13.0166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aae9e30-532f-49ed-0bd5-08db0ea2bd91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6615
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static function `tb_eeprom_get_drom_offset` has more safety guards
for the DROM offset fetching.  Use this instead of just `tb_sw_read`

No intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/eeprom.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index d9d9567bb938b..82124e9db755c 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -471,14 +471,13 @@ static int tb_drom_copy_efi(struct tb_switch *sw, u16 *size)
 
 static int tb_drom_copy_nvm(struct tb_switch *sw, u16 *size)
 {
-	u32 drom_offset;
+	u16 drom_offset;
 	int ret;
 
 	if (!sw->dma_port)
 		return -ENODEV;
 
-	ret = tb_sw_read(sw, &drom_offset, TB_CFG_SWITCH,
-			 sw->cap_plug_events + 12, 1);
+	ret = tb_eeprom_get_drom_offset(sw, &drom_offset);
 	if (ret)
 		return ret;
 
-- 
2.25.1

