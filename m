Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5200E6981E9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjBORZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBORZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:25:45 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFBCEC4B;
        Wed, 15 Feb 2023 09:25:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBNwRk0q9LWojR9zYhScH5LWdhZEPOmOi3MhHz5PSk7/YonWW/wAzRCb1ykTgm3zpZ9iFThMJDwWsf1sI7PSXoPbCLwRhPzaz71Pgi0NZQrs0KtBBUimc3QK9BRaujWde6wQcdNNNUMK6mYI8UvCjwxygmDZXPSR8r1OVMikxWOQ69odYHGaVQClrnKhtZbPJ4ZRcDgAdFZLT9wlcYM7eoKT9OiEdRonYE1ozhCx14IMzX2z3VfjGR738bEFdUi+zkq4N1KX67W1sgD/Lb+pos2WgF1ZPNMC8GxGfqZdsrvxSpYPZ3iEDL6qee9bGSgUkXUkZjAvubN8AdSaIrlhcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URgtI+FFhjL41dItnndjjqhbgFoErg3/ObhvX551pHI=;
 b=R4Ahecm/WeP1ovbutu/Lk8wgu0QuBmjZEy1dAFSbmEJfrnZvD8Ynp/FvDkCZQfKjtrFCRXMga86FPZghnc3qLjtranKOGwKZo0r+tt/Hfp1tj5u14MFWqKEOLUUUtS/cMalySxQXsBi99UtIiHG1mZlaLYY6+TqZU1GrsjUn5j9y9yd4BuA8arXns5MFjMFVOT5YLFDgfqGttAz3512EgdG5WaOJHbXCgOwQTf1ozWT7G/WBUzoANMa+RnWQpleNG2AEVRG2gxbGgClJFTa+zM0R9Wy58Wbd2G9h4RA7W0hx4YTaQLyh5tAwFPYaIyMDdth6q0H0xO+pIq6e/gZ3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URgtI+FFhjL41dItnndjjqhbgFoErg3/ObhvX551pHI=;
 b=hB5VAa5swG+9EXjzyZGM82Htfey5Bhhmt/p+CmP/jFFcllyBYxmM532qKrAGudPG10EBxIBxS9C4ygBtzd5MEUNaeGp60ESdN8n/oiiOM2tKKJYWV9tMqx5IO/72jmcIDdXR5C+f7eYHXeI7xm9K5Mp7TrO0gn1vK4hlwVKB13E=
Received: from BN8PR03CA0003.namprd03.prod.outlook.com (2603:10b6:408:94::16)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Wed, 15 Feb
 2023 17:25:37 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::9b) by BN8PR03CA0003.outlook.office365.com
 (2603:10b6:408:94::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 17:25:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 17:25:36 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 11:25:36 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
CC:     <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] thunderbolt: use `tb_eeprom_get_drom_offset` to discover DROM offset
Date:   Wed, 15 Feb 2023 11:25:20 -0600
Message-ID: <20230215172520.8925-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230215172520.8925-1-mario.limonciello@amd.com>
References: <20230215172520.8925-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|PH7PR12MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d91e9d-b628-4d70-4261-08db0f79a6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/+gMAi4AzyeqqjBqrTKwdP7UrGQ7U5wKd+SMsVzJs8m0StKAKq9bt/vXb+Ot06WiHz0v2S3CbaPwiJjwBzaDk2xnWTFx0HqxzBWrPwDicaXfTggbUIVKkAwRpNWOfCK1VGuBg7buspnx8VBp6+Kcfi1AhEdAF1x97iIYCZI7SmT3m+YiR0hW3dEEz1O5kreL62e6HfBnVmJwaMRdO+AWA7V+bJl2Rc1jMyO5ncQJSoxVpkG0ZIMbYsplnmDUn5m9V/iQFPUKOsNJLP/zkbm+E61S3TD1V6CvUQ4q85x0oxu7oyL9CGBrHho+Hj7EM0lVpCMxRe83sdNQF8MZ57rVrzlYBAYY/wUwp7NzA7Z9FxZslv6kIF4S2pKz/tk0PfT26iB6uDjGeNEHFGnzUMt+F86C1doPoIpCC+J4tq/EHYuoAXd/jnatfYSJDdxMXh1HC63eR4cBkjAtBh5SH/MCtXFYL9FweybXwMb3LUls8tQdNCmgcRnxR1ozf5bz/g6qhLVeHM4iPtXYiUDI9bUOwdJTpzHEMyk3a+RTCAyTEYETSOX4juAQeWkY1NFKjBoB8R43xf+jJbxQ6/gcppVhjQQT6hR7Y338QO/C/e80lGqgbcTuqK1avVKM8EKc642z1eFT6bId0L1MVPavPc9z30MzOmPtzAHPZBJaxA1HchGaiaLEfqoSP03QhRkEWdgcIABMWQwmstqPMsf9ns4vERPBc1J4bX1sHw+raLNnLphkLLDOeaHtxIGkSWXqZ0O
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(5660300002)(82740400003)(356005)(36756003)(41300700001)(36860700001)(81166007)(86362001)(82310400005)(2616005)(1076003)(336012)(83380400001)(40460700003)(2906002)(47076005)(186003)(426003)(44832011)(8936002)(6666004)(16526019)(26005)(4744005)(478600001)(110136005)(40480700001)(316002)(54906003)(8676002)(70206006)(7696005)(4326008)(70586007)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 17:25:36.9073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d91e9d-b628-4d70-4261-08db0f79a6f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585
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
index d1be72b6afdb..b6572a893579 100644
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
2.34.1

