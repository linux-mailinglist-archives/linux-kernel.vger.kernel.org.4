Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CF569C830
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjBTKCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjBTKCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:02:02 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F34E18B24
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:01:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1x0mhYjgZW4OikW29ymqqAeEpmDijjRYJR2asQB83mUKrTTICMxuHtw9oJUbkUU1xNFNjbRTT2EMeHYqL7jDTK5K/VFtWzO0Fp8ys3BZlM25TIs9P3dtelbGOiJw48C3ZDOsRyHIpArmeRTryO4Esf+8ZdpvGExRIXjX7J2GjAWQQpQKaAliUaH5QtBSOyrzNUmedipWDVVxzvgDOm0bAMU5w8LiYGaD0zkOIXn1rscCDmJ3mqP8fuWYYt0B5sZFDIuXDbtbY2vNoC4GMonIgKH0zBCC1w/CiaMrusk4Dt2jaMlqMcoLIHSvz37i8inJ26MZNg03SXLV+BbW9RbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xv07jA+/eL69iRpQLwjC5Fpf3SD7Lei4pML164kGXTs=;
 b=b0EnoWisfRTSAZBV7+dfijc7lK1aKZnhargSW4lOWl3y1d9tBljMkIVmISzbb7sYvA0dZyj22p83cFSeUnUgnG85AeybWseBclmVUr803qvKUdD3M5va92Uszh1ApmMgIOCPr5nCPiUaMTLSDq7LDt/QQa+IGC+Ef0pzlF2Y4asXcmQSalrzkcjzyZyUZgIJ6TIv89D+zBw4oc5EMTpu/qvjqqe0qsgt8//55fw5Cxt8BMg6qFZov3VBL6v9DIxOtmb7yhShywFR13aSe1JE9hF6qkDeH/yNDclXm4yf104JlcIvxVA/M7MeXlJT7Qx799GHNamqAQt2SAWgIz2pKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xv07jA+/eL69iRpQLwjC5Fpf3SD7Lei4pML164kGXTs=;
 b=lKZ/Qu7/yC/PuL+rT9navvBvUnfio5hJK4UFQ2BdswbtntRTf8zLH64aMTwzAlwttAOa4G131u/27wpBpLgbEWrxJXl/g/amKsR66c5EL6PhCBgsU7oPxcgJ4s8GKFyUFl6k8hBPZvak2xTzWjB/CIBws6JjEsybMBtXozeCliA=
Received: from MW3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:303:2b::27)
 by BN9PR12MB5228.namprd12.prod.outlook.com (2603:10b6:408:101::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 10:01:49 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::14) by MW3PR05CA0022.outlook.office365.com
 (2603:10b6:303:2b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15 via Frontend
 Transport; Mon, 20 Feb 2023 10:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.20 via Frontend Transport; Mon, 20 Feb 2023 10:01:49 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Feb
 2023 04:01:47 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Feb
 2023 02:01:46 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 20 Feb 2023 04:01:43 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>,
        <amadeuszx.slawinski@linux.intel.com>, <Mario.Limonciello@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 4/8] soundwire: amd: enable build for AMD SoundWire manager driver
Date:   Mon, 20 Feb 2023 15:34:14 +0530
Message-ID: <20230220100418.76754-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220100418.76754-1-Vijendar.Mukunda@amd.com>
References: <20230220100418.76754-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|BN9PR12MB5228:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b3db49-1270-4a49-663b-08db13297bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50hUmMqfPcsZI6KRiJ/zDNg1SPxuCjvhYqqNx3MvfwxxfuC6wb+JA5jxaQWLqn0ZfxMAcnrRe6C1FyH5zqNPw/xxojyc+l1vo8idQthz4i8lBnWK+30xyYSsTUVN/fJdrZbO2tomw2K1SiUW8fdfxBJ4KOqyLLyXEtp5pNObtfeYIKzN4sMNoy2JkalB86zkymUjnyBmeNNG2F8Z+zV2nxBebxK8SBXHdT9Lsmr97sS4i/lYLFRnTD4FPiz89h9cutn/STOtWlss9MTK5awO+bDyPIXcOlDDcCs0a5H4wT86D1J2g3Q7AeHPkkUN4MSHyKllSdz7AMI6WWlK1rTb1nVO0Wb90M8eUs6Jl26xqq37jiJPTWILPM1tvPJAK/GIuhOb7lbFrWweR8hisgPaOKJ8z7Rmt9MXPvPS2Y3vqtWQaPPclNO+AJMSne9YrGscyBlRsXOUC0CZrT4u1TVLWt01bPwAveLoPb+KAPMvxMI6GsLbojhaosKPEATVm4aPOu2djB6a1nvk1SSfqcjdJls3kxxMCNk0McuyEPb7TjBSqF870WMhotmsxQqd1F6Gl+AQa7DIdP0XtXq58PE8h0NkeamxVeeZVFHzQgbsS0Oi6SUtXxJpMIFDmNahSzHUUV5nToTdGAQI6x8XGRq+/cKIveLnFduyvSOftedvRiCkivZptPjL3qfaoSsyTX+A6qXXM8m4l3hh2QVuC6Yt2tfQ4/lKRGwSNmSOJzB3niY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(83380400001)(40480700001)(336012)(70206006)(70586007)(8676002)(7696005)(54906003)(40460700003)(426003)(478600001)(47076005)(316002)(1076003)(186003)(356005)(26005)(8936002)(2616005)(5660300002)(36756003)(4326008)(6916009)(41300700001)(82740400003)(6666004)(86362001)(81166007)(82310400005)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 10:01:49.5933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b3db49-1270-4a49-663b-08db13297bfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5228
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable build for SoundWire manager driver for AMD platforms.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
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

