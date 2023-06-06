Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D7372371A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjFFGEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbjFFGDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:03:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03E6E5E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W37iaPuE4/AUUlmPVAf7IXQ03gNcsptkU49U0kJ/GN7NnUhr6+ayJ0uicOh7hiqOiXU8tq0jxrucNkxvzkvwDV5mR5ODHnVK6O1jU2LkgvRR97Nr7fmX1cM1wywgI9HpVwlmi5mlzdE+TVPR0SPTx5QkKJ9nHVVyhdgUIOTLh+CzKMgvg50bxBPD2hK9ICQuXN23u+kVViEkL6qNUTTk+/3mUJUMDsO7A/x1dZTIz5yq369JrdysMl9ZE2zr5pArE68H09mXZahaDVxtgLCH3er6ndvIHqnce6tI1008FD0VYuRWODoB7Zy33tyIXKeFfHOsYzMWzQ/PVCy+Ean2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJPO76LeVbRLT6xdNfAEfol9vXoNWf/MqxjxFnE4yls=;
 b=UCIFglv1UF5hZxnj84kq+ZYaBesH75Vj6nM6knsPNhMLdVI+3E57P69Qyx4P+iZvy7YOzTrgFcG5adCvnxyo0njxN5H0s2BIZg4GO8Ue3yML0skQhjsvOLZqqOIV8uxs99T1BOibasKPwP+S/JISAGDyoxU4xPjLv4XH7j9pWnrKSo9Z52LyPKnM5Vg9JFg28sMOTs6ioCJ0MPgR5Stx6Ry66puKtXdSnmUm8ILRxZ+5PEuqT/LNKIIPlWlGYinZCmvH489HYDxVCdg9VmwF0fGPEBPW3JMjYjAAb/DgozQAH5SAAvwd9yxOj1jNWlihZ2pZvhxPC5z8bWya35MQNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJPO76LeVbRLT6xdNfAEfol9vXoNWf/MqxjxFnE4yls=;
 b=2+gvkwMMQU5wVAetx7WjCouJjEZjSQA8ZPSCGPIhPr323nwZ8T2GDtEXNgtMm4didI7+Bgus4XLeLFj9d61BlQ/Lp5SWi5OlbDNEbPlK0yNJ4nn+WfTkrXQaxKyhrB4TaPbm5ecUxgacz9+4X/23ZEoPq3TuADNqCMTixp3mgic=
Received: from DM6PR07CA0087.namprd07.prod.outlook.com (2603:10b6:5:337::20)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:03:29 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::ab) by DM6PR07CA0087.outlook.office365.com
 (2603:10b6:5:337::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 06:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Tue, 6 Jun 2023 06:03:28 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 01:03:27 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 23:03:27 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 6 Jun 2023 01:03:23 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        <mario.limonciello@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 7/9] ASoC: amd: ps: enable SoundWire dma driver build
Date:   Tue, 6 Jun 2023 11:37:22 +0530
Message-ID: <20230606060724.2038680-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
References: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SJ2PR12MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b13bec-ad8c-4cf4-82bc-08db6653bf92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QuvxfK9gkBuPpZhKJAhsV+mhSgsEWrMfqvVUdwZcjIcULjCBVK32e0HMBXEiUOnLPvkiB7gJiVDfoD2b7VC5PERGx+CQ49qHIIAGwKcrXnULSnVWoLO0SVJgyO0K7aYzN0u6ehuim2JD+8zxuw6JfjHJezVdk5JKvEiGiU06qgsNQMDsbtVID6YhWANvqoMhaE8vbftqJHM0mA/Bf2BikwFWVraan1E0SnuRBzTv+Fved8BXyGEB1ToUVV3YIfFTmTG/mTDMyhb1NFVEcawiBxkJsoewgSTsATnCTv3hydSqVR4v63C2Y7lrBsAgBCzZT56vTdG/lrsNur1RuGtTEK/mxDIPbfSwBD8yMAUysWxtYeH2JulsyjCrYTgQnynFF9VrO+VfSrfn4J1QUmQtoL+XKglUU3IlhU5ja0lUBK9fmhs7sVBXUuwb5YKx0zptS53RX8xCsD17UdtYJm9Tm/XgWeLgR0HbDhvpMfIphTuEAoeH4jWYDMuAOM+Mx+2tBOPvAnNf2q/b+Ajcd/lfma95CHUj06e9e1EHRU9HRMAgjOG2i9CxV/2o3J7IXi1Q8b6FCEsiRWX0JLloUG6IhkFgIgAlfgdI/quPHw/nw7zcnz47eOUsOzaFf2smuuKTC9fBGGQRTAWgb7THj5JFohon3anfp1mdOO7nQEL7fTM5zP38NmzxpB3vO8JUCYAVWE7pUHlXjLa7iGP1mT1fnMKcnfN+pZGDnbNDbKcXeNEqQDREDEohmRM4t/92v4X2QyUg4oBpSnTaS7oqYB//VA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(426003)(336012)(4744005)(2906002)(47076005)(2616005)(36756003)(82310400005)(86362001)(356005)(81166007)(82740400003)(36860700001)(40480700001)(7696005)(41300700001)(316002)(5660300002)(8936002)(8676002)(54906003)(478600001)(70206006)(4326008)(70586007)(26005)(1076003)(6916009)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:03:28.4488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b13bec-ad8c-4cf4-82bc-08db6653bf92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SoundWire dma driver build for PS platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/ps/Makefile b/sound/soc/amd/ps/Makefile
index 383973a12f6a..f2a5eaf2fa4d 100644
--- a/sound/soc/amd/ps/Makefile
+++ b/sound/soc/amd/ps/Makefile
@@ -3,7 +3,9 @@
 snd-pci-ps-objs := pci-ps.o
 snd-ps-pdm-dma-objs := ps-pdm-dma.o
 snd-soc-ps-mach-objs := ps-mach.o
+snd-ps-sdw-dma-objs := ps-sdw-dma.o
 
 obj-$(CONFIG_SND_SOC_AMD_PS) += snd-pci-ps.o
 obj-$(CONFIG_SND_SOC_AMD_PS) += snd-ps-pdm-dma.o
+obj-$(CONFIG_SND_SOC_AMD_PS) += snd-ps-sdw-dma.o
 obj-$(CONFIG_SND_SOC_AMD_PS_MACH)   += snd-soc-ps-mach.o
-- 
2.34.1

