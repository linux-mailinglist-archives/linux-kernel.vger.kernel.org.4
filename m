Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773446AE07D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjCGN2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjCGN2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:28:20 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CD35BBD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:27:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWOot65iAI/4Gn281ocWJseQHqMhNmsV0xZb8fioGiZfFnQ1d9e1iIU/uJpKDlnngpAJ1OoGzkLAfL2ZxXygyAjPCT8b8AnS7qlPbIy2OnQa+5S5mXkeeq5XjpHz5BOeC7Rea0PpO2ChHWdH8nDMMZxuuCJHxHQ69MS/uH76Xs3ny2lp8k52700A57GKbVgDJIMVg4Rd2D6+6B7Nr9ViG7LTHpsm06G2NfSg2p+eRLrIdDroE7MHpAyjtC+lx6yWzFlIrzm+75RA/cdurXWPKe+Je/PTVwXjiU1hetOsifgDIZTUjHNy+seaJmBid40sBR0dzk+xTgwYIqDBsHkQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fvAOQfxaPlgicNaCbaA/aLMaa2XDpwKEQXR95J+tCU=;
 b=lQj1eo9pxPwK9OjsrnSTMOFlyyvU1CPj6YNhha3hk2KjJna+JgCIzsrMNXidIo+kaddtor6lUtXaCmZHEkuBsyxRX5Ze/HP8hBQ2Mw281MM6Lh65230VJFM+Bk8ff2zc6f9+pHuuisfgB3oA9X/giLNNIENRDf+b5BIW1oPkFt37PMqeB2TJ5fV4DLRvB6aLI6uFx3kflntcjflzRT9uZRvSXCAZx5I/VPr5mYeNxIfH74DKcTMppANhRW8I5qNfWCuKuFEbwCg4uFkhtao40sepI2KG9lW+Hlwl8cgIRUfU9ItMWJw3o0/n1JzA01neQ3V66eDf34wwaqkAxFTiGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fvAOQfxaPlgicNaCbaA/aLMaa2XDpwKEQXR95J+tCU=;
 b=StYxF7spD6Et9fJxoxc3r7H7rjkoFz2J6awlG2gy+GmlBjnQkJoYGLVr1/qHKRMSje9Y/Ds1O5JjX5NaYkPA7//nf0uAehn5MgcK+VX2FDqVVpR1X8Xzt6FxoRt68SRB03VPBFHPn1yw1+gsr6Hwbhvhsv28gBJPm4h56qgYEs4=
Received: from BN0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:408:e6::18)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 13:27:51 +0000
Received: from BL02EPF0000EE3F.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::d6) by BN0PR03CA0013.outlook.office365.com
 (2603:10b6:408:e6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Tue, 7 Mar 2023 13:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0000EE3F.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.12 via Frontend Transport; Tue, 7 Mar 2023 13:27:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 07:27:51 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 7 Mar 2023 07:27:47 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <amadeuszx.slawinski@linux.intel.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        <claudiu.beznea@microchip.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V6 4/8] soundwire: amd: enable build for AMD SoundWire manager driver
Date:   Tue, 7 Mar 2023 19:01:31 +0530
Message-ID: <20230307133135.545952-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
References: <20230307133135.545952-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3F:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b061ba-b572-4132-c64b-08db1f0fc079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rjyuB4IaWfdOCEXdVtGeaxveEmGz54f/UnIBOEWncEAw1KvVU5mibIvjbe91H8cJnfjmLmvQ7pV3XRy3zUpFiqgX6ZvgU/+g5wrmtDieXT5MTNOswY9zEU1fz8c5uhEcG0haq3hog7aDgqkStRAhkrlwtG/vaLlTDBH7tWuvTbDqeRffXiSe+T39XkPk1c8yw7r0lH7ru9CyDvoKa3ercAubS1CCI1stxH5p6QfGRfkP7I4m7Np7fnJFJYhE+3olhK+oizlXg9HtvJrzIL/POzvwRthptB8976ya8lAlB8DNWO8SNknqTGN8u+pwlhhiAyKJ5TrdYQva8rDSw0SMabMb71ReD5ZD24tYyjq5EnfLlTO3zb/QsN4dRdHQl+2suBxts1n0WhSfGhZWPrGu1NCOoBMvIgmr6HSTB+dvTzljnJbnViXfGyBLbSlK2EOmH4+L0nIzmhu6WtQ+SQUxyJJnPZhJPZsYuA7VD2J+k4tX4m0PSopNoYSXmnE6GmsVEwC/qGtoTcpNhInsi3imWkEAC0Lnn/O4jbullMh6NehGqq8OMffM90Xc2rS8l0qePNy8aNanQ/umUpBIbClcFVK8+1IlgzzsSO32gnCv+BXs/lnKzP907sMApCxlcetdFxA/oYNPpJUvu319eFPPMig0oDcnGosTi/X1tk+KFAXKVyoh9+LbiJymqO34h7wf45RfoWAfPYvAMMppxW8HkKjgCqeCvnYXUxvAHKkjb0M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199018)(46966006)(36840700001)(40470700004)(2906002)(5660300002)(8936002)(41300700001)(4326008)(70206006)(6916009)(83380400001)(8676002)(70586007)(54906003)(316002)(6666004)(7696005)(478600001)(966005)(40460700003)(1076003)(2616005)(36756003)(40480700001)(47076005)(426003)(336012)(86362001)(186003)(82310400005)(81166007)(82740400003)(26005)(356005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 13:27:51.6764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b061ba-b572-4132-c64b-08db1f0fc079
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable build for SoundWire manager driver for AMD platforms.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/lkml/20230220100418.76754-5-Vijendar.Mukunda@amd.com
---
 drivers/soundwire/Kconfig  | 10 ++++++++++
 drivers/soundwire/Makefile |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index 2b7795233282..983afe3570b2 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -46,4 +46,14 @@ config SOUNDWIRE_QCOM
 config SOUNDWIRE_GENERIC_ALLOCATION
 	tristate
 
+config SOUNDWIRE_AMD
+	tristate "AMD SoundWire Manager driver"
+	select SOUNDWIRE_GENERIC_ALLOCATION
+	depends on ACPI && SND_SOC
+	help
+	  SoundWire AMD Manager driver.
+	  If you have an AMD platform which has a SoundWire Manager then
+	  enable this config option to get the SoundWire support for that
+	  device.
+
 endif
diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index ca97414ada70..5956229d3eb3 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -26,3 +26,7 @@ obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel.o
 #Qualcomm driver
 soundwire-qcom-y :=	qcom.o
 obj-$(CONFIG_SOUNDWIRE_QCOM) += soundwire-qcom.o
+
+#AMD driver
+soundwire-amd-y :=	amd_manager.o
+obj-$(CONFIG_SOUNDWIRE_AMD) += soundwire-amd.o
-- 
2.34.1

