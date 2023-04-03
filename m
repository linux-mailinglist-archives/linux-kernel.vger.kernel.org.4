Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755BD6D3DEA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjDCHOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjDCHOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:14:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E22EDBD1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShSk7m/69omrko/AJThzaTB/y5GXp7nn7x3vvfepWMPS5LaICvCVsxEddIl5slgt9wfdaTcP+/XDnLGPxPkUNGYwul4LJtGupOO37UTXfHFOY8qXHh81jiKQ/0CyyfvZvXqQRTPHrDvsyNfxYMcdtT0v+sMA406wd8qgdlYGn4g4tqOMY4rnoSGMNb2MEkoyvjRg8gElrK8h300YuKZYiYsTbCSFUkqpOnrMDIAQkfCO48T3QxoCUjzM7xHw/TQhKVJkiQqu8CYV4nsIX4mrcQOaR+m6jaIZsyfJahknrdnlA2IeE7y1ffYfCJUufG0pMAXLwNafG+chp3c+RXh/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYOQUaRANHm3nHfpODC+EOHWLnrfIxGi+XUDviy7VX4=;
 b=EGri17jFEW47d9w0yTa/zEqI9zWjaCo0GATw4NEXyc0jj4ZSv/MjJqUPyIvp76w8xsob4DztnYmVklrccc3E13tghq93jgwdlogp/YzPYQ6Cfapacif4nw59khMUdmwc++QYGgtLrIAK15v2zZVhGfknqqJOmKXsJeKAu2MyxlzZbD1au2HCTTPG9BfCM42Z5RqFBFHp4p/YbbnWsIFmlbuvdvsAjREVX597WsXTJXdFWPFIw10zspYu6mm96dKz/LBfbbozs3bFo6d3ePmf/lNJ3AI5OqVaFNrSVWevsp75Y04LsjE6rd+XK1DlD6wHvOM3322SCfyOjw0Jqc+5Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYOQUaRANHm3nHfpODC+EOHWLnrfIxGi+XUDviy7VX4=;
 b=tz0p4Jydj8JFFjs58U4JmDJJhbQTr7mFBZClaz/FKbHKuXsRXCV5wAa0CnmoASziQQuLuQ2tHh8VGkF7i5rvYo8hzqNChes8MIpW4/tGi3jDNJnSKmkKiIQHBDg5/Aax9ehRkt9wUU79sSXqXMwCJNlRo5clsTaspzYdh+KxlJc=
Received: from MW4PR04CA0319.namprd04.prod.outlook.com (2603:10b6:303:82::24)
 by DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 07:14:10 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::77) by MW4PR04CA0319.outlook.office365.com
 (2603:10b6:303:82::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Mon, 3 Apr 2023 07:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.16 via Frontend Transport; Mon, 3 Apr 2023 07:14:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 02:14:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 02:13:39 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 3 Apr 2023 02:13:34 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Bard Liao" <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "V sujith kumar Reddy" <Vsujithkumar.Reddy@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Rander Wang <rander.wang@intel.com>,
        Zheng Bin <zhengbin13@huawei.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] ASoC: SOF: amd: remove unused variables
Date:   Mon, 3 Apr 2023 12:46:43 +0530
Message-ID: <20230403071651.919027-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403071651.919027-1-Vijendar.Mukunda@amd.com>
References: <20230403071651.919027-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: fde34700-27ca-4fd3-f3fd-08db34130578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWIkpO0fBzlzPA/Cfs9a2INgS5rIy0LjY523NGhPvqsgXwOciWkge5WuyGSspBBcXfe9QFE3AFGrc6rNm8nfUmoyjh/Swkyb3ZmKAcX0gkX3ukavTTX0PBBVDwiYz4btXX9dY10Cl+VKsbqR5NGD8GtpS4N62sjwA5hT/56rxHHwaF7REoQXacdbZaleoeZ9e+Q2ZjuQyFtJLESB80hP/Lz7LxRcDwiT6+pOeVXrSvCyV0fdjzEuAfMxVuaskagode2fD8Qh/pEoTw9QC+n6cH7+bDVJ2oGgPXJAHP1vcJlDUGyQrsmqX0BNBaizl+uzKLPMQRnSjs7wY1uSsMKmAbTpJkvThhiA1So4MHkVuSit0elXsNZF1w3pEdQvFC7CaEeAbx6Odoi+zXOjGT/r+mO71qThdO4hzQyCY/1TQYR8haxtLfQVG3EA9R0heyrn+nYKiMQSwYPuz3YmtxZUxAuI1nfP8M86UTdx9BvaD0sb5rJL4TL6ZRMeZDmLcs22JbBEp5ER2teJYf6FNqcY4o+qanQ/DM5HOAieAR6k8+AnadMWnFzkUbKr9i7hAAjRFt2T38whqX9CI+aLknpWR8IxzI2YY4EDJa/HqGX5oke3UdM0WS+VTJ8jhNVgEcrc5Da17hbROPZOwY3V92I9RR+kt8jGndqoXIfix+eliWfDl2QvZxJ6i8uSOrDKI3riy4l9LGujfi+LMJfqRuUL704ubNSQjBQ/TwNlhH46J7E=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(86362001)(82310400005)(2906002)(36756003)(40480700001)(2616005)(7696005)(336012)(83380400001)(426003)(186003)(47076005)(1076003)(26005)(6666004)(8676002)(4326008)(6916009)(70586007)(36860700001)(478600001)(70206006)(40460700003)(41300700001)(81166007)(82740400003)(5660300002)(356005)(7416002)(54906003)(316002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 07:14:10.2330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fde34700-27ca-4fd3-f3fd-08db34130578
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variables - i2s_mode, i2s_pin_config_offset from code.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp.h     | 2 --
 sound/soc/sof/amd/pci-rmb.c | 2 --
 sound/soc/sof/amd/pci-rn.c  | 2 --
 3 files changed, 6 deletions(-)

diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index d7fc24917b3c..fd04e5ae7303 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -158,12 +158,10 @@ struct acp_dsp_stream {
 struct sof_amd_acp_desc {
 	unsigned int rev;
 	unsigned int host_bridge_id;
-	unsigned int i2s_mode;
 	u32 pgfsm_base;
 	u32 ext_intr_stat;
 	u32 dsp_intr_base;
 	u32 sram_pte_offset;
-	u32 i2s_pin_config_offset;
 	u32 hw_semaphore_offset;
 	u32 acp_clkmux_sel;
 	u32 fusion_dsp_offset;
diff --git a/sound/soc/sof/amd/pci-rmb.c b/sound/soc/sof/amd/pci-rmb.c
index d0a56e8f09c0..2b84f95072d3 100644
--- a/sound/soc/sof/amd/pci-rmb.c
+++ b/sound/soc/sof/amd/pci-rmb.c
@@ -31,12 +31,10 @@ static struct platform_device *dmic_dev;
 static const struct sof_amd_acp_desc rembrandt_chip_info = {
 	.rev		= 6,
 	.host_bridge_id = HOST_BRIDGE_RMB,
-	.i2s_mode	= 0x0a,
 	.pgfsm_base	= ACP6X_PGFSM_BASE,
 	.ext_intr_stat	= ACP6X_EXT_INTR_STAT,
 	.dsp_intr_base	= ACP6X_DSP_SW_INTR_BASE,
 	.sram_pte_offset = ACP6X_SRAM_PTE_OFFSET,
-	.i2s_pin_config_offset = ACP6X_I2S_PIN_CONFIG,
 	.hw_semaphore_offset = ACP6X_AXI2DAGB_SEM_0,
 	.acp_clkmux_sel = ACP6X_CLKMUX_SEL,
 	.fusion_dsp_offset = ACP6X_DSP_FUSION_RUNSTALL,
diff --git a/sound/soc/sof/amd/pci-rn.c b/sound/soc/sof/amd/pci-rn.c
index faab4c33a24d..a17b15552a7d 100644
--- a/sound/soc/sof/amd/pci-rn.c
+++ b/sound/soc/sof/amd/pci-rn.c
@@ -31,12 +31,10 @@ static struct platform_device *dmic_dev;
 static const struct sof_amd_acp_desc renoir_chip_info = {
 	.rev		= 3,
 	.host_bridge_id = HOST_BRIDGE_CZN,
-	.i2s_mode	= 0x04,
 	.pgfsm_base	= ACP3X_PGFSM_BASE,
 	.ext_intr_stat	= ACP3X_EXT_INTR_STAT,
 	.dsp_intr_base	= ACP3X_DSP_SW_INTR_BASE,
 	.sram_pte_offset = ACP3X_SRAM_PTE_OFFSET,
-	.i2s_pin_config_offset = ACP3X_I2S_PIN_CONFIG,
 	.hw_semaphore_offset = ACP3X_AXI2DAGB_SEM_0,
 	.acp_clkmux_sel	= ACP3X_CLKMUX_SEL,
 };
-- 
2.34.1

