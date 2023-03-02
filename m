Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547B76A7B47
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCBGTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjCBGTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:19:12 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9544D2E80E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 22:18:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DapJqIwwqCNXAhEYzb+FJyD4+xqClFeu50+2aLrVRCHxCbRwA9NYqKwrGMbl4tT3tdW8EFQ4qscBfRkxO/nHpOR/yQyu3uumGddIx8cuZ/3FkAFH3Ln98UwjGaRrIKeGoh5Xu0SLPSCTu7SwBUuMOLM7mLscRzHqUdNZPrp9NExjQirid0aA7lFchjQfZ/2tvpZg9sIJi1oxIIvEFB5bryJMT4eoHzyE2C4t5sz+7aMkdZyBeim+RvOkY2+PvALlSIRNgR9RJt4Lh72x+gX9D9sdEIveRnLOjTR57XpKAHi6/vi8aUQ50H1VjmmZD6c8vJHG1wK0yaQyJQIFUYvDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fvAOQfxaPlgicNaCbaA/aLMaa2XDpwKEQXR95J+tCU=;
 b=Y/uDTEkz+U/+MqIW3m82reizp4c77Y/6yFs19+fQroYzp2hrSTyS55mj3wBJqqhMrqEC+kcw3J7ElW29o4VrVxqbd8KkH6oW2g3JjmeTB1lecWq1CsoFjQ6CmfpvPAyymatb3TMZXHL5J6RDSttM8+k17ELpAL4s1UZ+NmWZNDPS8goBkdit0uijU76LCx4roNLxXVnZoYwMriItXsJ2o52lVNSJDgMquo3MQQ5EW1QqrRowRTW/BrrMzVoepCAQ1UeqykYSvolFzF/zxH0qAus0kRlV1JdLGYN7oTp42BE/LQRfCNex1hLFWRTTUI9DqXzQgZkY4Rr3jexP1CKMyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fvAOQfxaPlgicNaCbaA/aLMaa2XDpwKEQXR95J+tCU=;
 b=oblOfZ3BSNqemaqy/YpD4dvphdCY1cnikeFQIS4pFbxwqgHX+WImvBC0Lh7eTDrP/7IzJK81QilaTFnnM3k8lSRPUgzQqEb3z5dbwvB8cwKWocxprw0MGCiWAUZhvXcYl8biU/tjAQf2d5vH58xXHMDIYc0UfXk/s0DAOFlPdB4=
Received: from DM6PR07CA0099.namprd07.prod.outlook.com (2603:10b6:5:337::32)
 by DM6PR12MB5005.namprd12.prod.outlook.com (2603:10b6:5:1be::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 06:18:49 +0000
Received: from DS1PEPF0000E654.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::12) by DM6PR07CA0099.outlook.office365.com
 (2603:10b6:5:337::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 06:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000E654.mail.protection.outlook.com (10.167.18.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 06:18:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 00:18:38 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Thu, 2 Mar 2023 00:18:34 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <amadeuszx.slawinski@linux.intel.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V5 4/8] soundwire: amd: enable build for AMD SoundWire manager driver
Date:   Thu, 2 Mar 2023 11:51:03 +0530
Message-ID: <20230302062107.207845-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230302062107.207845-1-Vijendar.Mukunda@amd.com>
References: <20230302062107.207845-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E654:EE_|DM6PR12MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ad2cc2-f446-4383-da4c-08db1ae5fcac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKSSPrc0PN2TF5j2hkGI5gV1PkfnHLOr7ZM7fYIKb93qHifzFjturnJmvq6PMrI9K+tpGTX/wR0tXEvlYFyz87aBA0wt4z+L2n/RTj0LLherW8fA+35ba0/0E0ZO9DUuo9Mp8not5P8leRzvcisMEnJmVVGLTpZX6+dkIUHbpNWGcdaEPdNAT9/hzZLP0NgAteGFiXI3gC+ydfpqOGnr0Rx9fsa8s4vL7r4zPyigSOftpGZULMjOKiKdojNd2I4riRjm5bsc0vNXWtfdKBrFRggeMYU3LHgkdIQeIO1WWFxqGYkMX3cSzLpTwbguJRXasywYg7fg74WXEaMIIqh0TcjOD+w/OYIArx1tixqt4/PVkGf704M1+HBQI/SCCd68nSTL4wkJnwfGAv8xw7dB/fwtmyoEaoCjrsiHgei/iy4ppKnz6QR/LhNldlSErkktYdI1LrQG3Lld2EkNHwlEyWDtFokHyLjGAgtbA/82q7OJsvpuRJth71b/Jwym9g3/CUwRjnwJagCmb8uZRaUaaJAHwTG7JUkd+rHCG3SvOypSYdNT05jWsD5moV1nLKbgkU3p2PCxJcVL9hm/LgXWEkbONJI63vvwMbulA4F7IoOTsZMemFybBtmpHgdzKTDxfq2H98pCPJbKjhCoqV+kXnw6fAR0dINJHj6ftK8tVPkVT+IMJDHiZi3JFEcYRPBatEx2zTE8Tke+B3WokmkthhUt9M9LbDt6ikMaKi8S5lA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(36756003)(6666004)(1076003)(966005)(2616005)(186003)(336012)(26005)(316002)(6916009)(41300700001)(54906003)(4326008)(70586007)(8676002)(7696005)(2906002)(8936002)(5660300002)(478600001)(81166007)(82740400003)(40480700001)(82310400005)(356005)(86362001)(47076005)(36860700001)(83380400001)(70206006)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 06:18:49.1295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ad2cc2-f446-4383-da4c-08db1ae5fcac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E654.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5005
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

