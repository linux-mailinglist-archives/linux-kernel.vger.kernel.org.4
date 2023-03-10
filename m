Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC916B4CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjCJQ0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCJQ0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:26:11 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6C310A29C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:22:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy5oIL8wZz9H4Td7msCMqE9TcLG4YHYLShWAan7JA8cuM2E7UkmFmN6q4HihfaTgrRLFch6JUHyn/zaPpTI3pe2Ij2pLMTaYQ2+BYr/a5Ygvc2IHq78vGJGX9lm8zTaS4rvl5TM8KLOUSqEMuzmgmtzlzT2jiiale2lH9qrkZt8ojTVPd7v3MfJU1OwhFV55QQNCp7oElc5/7yTqTFCC5WahwigJym2etcKz42U+U1ikMXOHMUUPMhA6XBGoLSBdJaVuAqO9nxKI4BNfCVmW7KDAfCzzGheG7sdAxLaLFCTVsVfBMMEIb/GDxk/gKVmEHXf3pHaQIXlGqO1ppjWMNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fvAOQfxaPlgicNaCbaA/aLMaa2XDpwKEQXR95J+tCU=;
 b=mWX1cZmObjF4JWULKAPPRBMurM7JHvVuKJBPtPyJA3ecSEu/M9y8OF3r8DcOyb8qlaaEsMD+EnulJMMmlqh8A50mxY69J7J9N2DshJNjwQl5+//of1QTjMmlI/LLF1lh4PK3+3Ewngw0zc2GmbaYe85GJhFpMDuBQiMvjbvoWMO4JNGEvqz3BDBydNln+UdKqt5jUNvMtaIvUQ8MxZnQOnAAcxtgqcTia81OB7nVBbVASrQTJN45zuBeWjKWXZ0DR5AFKWo9Jd/spLmPeEyAGm/ymhyQH6u3kyYDODcT0n4hO391uUToXYeEGHOgs2JvaVfjKslXDOL97Z1a7rR1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fvAOQfxaPlgicNaCbaA/aLMaa2XDpwKEQXR95J+tCU=;
 b=PiKELBh94OE9s8+PHc9Ez5dLsOShViO5R8iV8OCOEjzo+/FrfCa7MX9g7I+Gr4PvtcW8kozR3GWEU2rx4iBNXSo65vcAuoeXBZb2Vc7x2An7RNxhCcQpOXspjy+vmzLZlPB4l9SQkOR9JjdgyNawz8pB5/G73hehlhIVVbRLE70=
Received: from DS7PR03CA0189.namprd03.prod.outlook.com (2603:10b6:5:3b6::14)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 16:22:19 +0000
Received: from DS1PEPF0000E63B.namprd02.prod.outlook.com
 (2603:10b6:5:3b6:cafe::ad) by DS7PR03CA0189.outlook.office365.com
 (2603:10b6:5:3b6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 16:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000E63B.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 16:22:19 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 10:22:19 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 08:22:18 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Fri, 10 Mar 2023 10:22:15 -0600
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
Subject: [PATCH V7 4/8] soundwire: amd: enable build for AMD SoundWire manager driver
Date:   Fri, 10 Mar 2023 21:55:50 +0530
Message-ID: <20230310162554.699766-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310162554.699766-1-Vijendar.Mukunda@amd.com>
References: <20230310162554.699766-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63B:EE_|CY8PR12MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2780e7-dc3b-43c6-2ecc-08db21839f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CVgjElPj4zPsnvWPcCiedZCYLITOD8dq28j01INsNXtu8nh1+rr7BlwpNBw+rBCeSHbw7ja99Bh6gmQUzZKr/P+E1F8QvCt2u2dgu450eCpDvUktb56djoKGeHNBfYixStOHhYUUB84rM+B2lHYh8DnqSKkG2nM5c/4otNxYdBsFNg7bq1mjqE94Ndev6IjBR5dyicj8EijMcscgsI5YGCyvdmVN7E3ytRnrQrs6nGBqslFi7ro+ykXHfLuy7DeMyfx+VQrSaX53GF0WmwdfnbRmJ9v0PR4qV0TQ0SrFVwhiBB1sEayVoo/0GCq1NLvMT6c6JvYWds2ZVOwuQjl8vHCYAQNQNWHjTvmgknwZZI0PLx2sCXn1mYr4sWViLCHHqCRm1SwSHWrIU8D0g3wTwxorW0pNgXwTH8KO00j1zC7hCnt4nEFBp6f/jLpzC7D4FTVu9Jd37Hs09rZMjqZFsiW4w0UpN1ladk8uj8J3/5OQD6KV6Yv15D7idJq6HVC4lzdKvj5IRnYx/wOrRIxqz2K3a9XkiK2RnbS9uQhxhtUw66b7paKcPQTu83Zbm9QvyNdrDIwqZmf4VX+AOZgUoDOpnd9EHaJDXAXUgXj6YalKWxZj2kFL9elA9AHYnwuB+eWD9jaG390HSbbH+b251TIztneMbOW+zwDWwj5BmzPBOUCz4PlcPdxfrlC+AdQrqRU150/SPS0IIpoD7Bq+C8/Ysh4CD6vuqZjtPRUSF4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199018)(40470700004)(36840700001)(46966006)(82310400005)(82740400003)(83380400001)(36860700001)(426003)(47076005)(36756003)(54906003)(40480700001)(478600001)(81166007)(356005)(316002)(336012)(2616005)(40460700003)(7696005)(966005)(6666004)(26005)(8936002)(1076003)(186003)(4326008)(70206006)(2906002)(5660300002)(41300700001)(86362001)(6916009)(8676002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 16:22:19.5542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2780e7-dc3b-43c6-2ecc-08db21839f13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220
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

