Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EB5694168
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjBMJib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjBMJh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:37:57 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CB719F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:37:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXtK6pR6KviOulpKmfekQkbhK7YdsM14S0QXnnM/lpODZSY+d3WlskWeIFDVPaBTCuxVUsMFJKxacb98RX54DBIsp7XTM0WHXqqqrI0wZjNlB2cOIRn3S+K2ZjJKDBVqix1EBGGrGOwyUdg6DL8q8cucHUCL/bvRoWtai7+J/Mr2h1cTuwYwqjQx+4VJaEd1n3ZtQmXco1saGcMEFOLJllKH8OJqyM6KHU56yqlhqubEA3W3iVb6Bpz7KR6DQgAgHkHVCNANedEh5Zpf8BzY2qGSCJoFRyo4M8WzX9YNeu8w8BGzDzFoQ+VnVJQk+AZwmaQwD5lltC2pV5ywr77Zpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3YvUSXQlNtUs2etgDCKIZ9tSf8j/ZejAQdx8IXNUYg=;
 b=RO/GK+3OuC/2QBHEARORxkLsp5K1OkZmkuJ8FOxrjoudnpP8zDjPDSLB0dMAlAnfFqVMdJEtOEw0pxw70Wikt/VPF2ib9fvLPcQ2sdROO1npuaRlhJtHDJJrOBaaZd0PKmvyFRY2RNqoyN6t+XNPaYkEWaOp93GIor9yF/tIWXf3ITXihmmz6RBR2T4Oh9vbGYQ9xX6FRWcNJF0ANbbTNNiM4c9csxxziGhGVB9oPV+C+loibMtURSGwdHk3aTvvS2KHPRy0+FT8MskSSeurU80MrovPrY3bsL5hpbBpskDyXonaJnb3vBx5zFzVrgIk14VGpwSdAfZfEkOuYP88yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3YvUSXQlNtUs2etgDCKIZ9tSf8j/ZejAQdx8IXNUYg=;
 b=AJMxI3pJZsH18XcGplyBXSfPjCqhtZ3jcqkpU2x8kphnUHs0nsDizAtPZlUvdSif+IaP54UHzvlgonSK5SybMEYxuLAHzl0UeYz4IacNMAXfrQW82ZO/fFM8wtUP2l/2eSGjQHcPodtQyP0bTsSxU2MAqtLS9lkt5S7M6YI1z74=
Received: from BN1PR14CA0023.namprd14.prod.outlook.com (2603:10b6:408:e3::28)
 by SA1PR12MB8700.namprd12.prod.outlook.com (2603:10b6:806:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 09:37:45 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::9b) by BN1PR14CA0023.outlook.office365.com
 (2603:10b6:408:e3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Mon, 13 Feb 2023 09:37:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.24 via Frontend Transport; Mon, 13 Feb 2023 09:37:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 03:37:45 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 03:37:45 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 13 Feb 2023 03:37:41 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <amadeuszx.slawinski@linux.intel.com>, <Mario.Limonciello@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 4/8] soundwire: amd: enable build for AMD soundwire manager driver
Date:   Mon, 13 Feb 2023 15:10:27 +0530
Message-ID: <20230213094031.2231058-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
References: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT032:EE_|SA1PR12MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5e624c-a3fb-4997-31fa-08db0da5f670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raCFHJXYC4N4oIT/5yDsFvRZFMBscOY7JmS75n4/Fvi8lsg8XXbWoqfEiCDYT7gmjQPuneJiVd7ikIbt+z71BkkSYMjo4DSpVlHhe8q0Q1ECSzkMqehCpYJgTevOaklBbcMZcUK2dRCGcRlVOcm+klX+1BsES5BjVEuDBcb0pjkl1YkthJaKm3uwdUBr3nePz/Ya9JZ3gzklsjJj0xwTNrWB1W/NG0hDsvx7kbvy+zhdBPCAfL6IprXxS/t7mELtZWvvtdPa/Y7DJ/FZpAvcOA4tIwxIQMdabaMXjDrrUYhMDPr+3LTnGlO/e9ISNYc+dHB2yEODhX48qOZwfWPXsb1gzkHkRsW955A+POmv25IymiPwBdMi5gU4T5XR1N8JgQrCGXxqxbiwnZzqmb2O2kWH1bkKO4dM4N/TRfBX0rkG90D1pjv4lod6331RlAc2bLZ20xLdyTwUqQQlWXAtWOdrAcx7pifuAm6iVFcTIkjA/zmOlemHrUhIJdkopx0bUF+pMjqefHK4hlsTYuFaOtqO1S/5mxn1T1Ebd6WG5AJIFu4L0tb4Lr72V9eQPXfq56op5Gosunx2cfU2BCDT4VBkxGjYroOreAo/VkRMcWhILSllHOasRVlMdivxzfFWdORTr2v3Q9DWVv+9JL8Hg2LEWwLHWG1Q4d67s0nyQZ4i6u1mSwlDaDZPZM8s3046NirNLb5ZCxeXLTjkhpAD6vFtYu1aFpn/YS432IeGY4A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199018)(36840700001)(46966006)(40470700004)(86362001)(40480700001)(36860700001)(82310400005)(81166007)(82740400003)(40460700003)(36756003)(6916009)(4326008)(70206006)(70586007)(41300700001)(54906003)(356005)(8676002)(316002)(8936002)(2906002)(5660300002)(2616005)(336012)(83380400001)(426003)(47076005)(26005)(7696005)(6666004)(1076003)(186003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 09:37:45.7901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5e624c-a3fb-4997-31fa-08db0da5f670
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8700
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable build for soundwire manager driver for AMD platforms.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/Kconfig  | 10 ++++++++++
 drivers/soundwire/Makefile |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index 2b7795233282..5baf128ae60d 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -46,4 +46,14 @@ config SOUNDWIRE_QCOM
 config SOUNDWIRE_GENERIC_ALLOCATION
 	tristate
 
+config SOUNDWIRE_AMD
+	tristate "AMD Soundwire Manager driver"
+	select SOUNDWIRE_GENERIC_ALLOCATION
+	depends on ACPI && SND_SOC
+	help
+	  Soundwire AMD Manager driver.
+	  If you have an AMD platform which has a Soundwire Manager then
+	  enable this config option to get the Soundwire support for that
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

