Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1951E73E141
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjFZN5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjFZN5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:57:04 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F8810DB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJIV+PLdpKIsF6yVM/wJhhUQ2PcsqWcmUmjZgsnZCnqoZy/cGVabkR8QWTVrjXBFyWUDjhirmaMVJt96b5mD2j6mrIpqJnixNaZ3D3Ys34h7vdlyjonDshEp+YskpZ9g+hW/RU2X92hdy09CvbrXxIq86XE7QylkDIpJqnBQOvA+e0aTVfIEX7WjZmf7wMXUfTLvAFjFZKtkPn83xoi4ckMOrgkGIx6K4hJd+zGLum3/6AbAcaeF1OABlbBMtyLLcHwKU9xcwlLcfKRMrxZ8RBlUH5f6oGU+tbkjp/vBBOzAHw9mBgUfY3oZHhTrRBttTYcNuekq+l8DhmBh1ELUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOnJef8syakP4Nd9/X35rupQoVDOYtVqpnltYtSmxW4=;
 b=ZsJhGOJeQlOGSnWZgc/iEGMUB4xlX1+JMcAXTILZrRYcsmJEuFJBFWpjTnUwKhYsl5jc6f9dD53shk55nHRhJHfSpnZZCsWlTOBCtimM0N2vmwQ19kFHPJq12wmh3AFjqU4urf47e8lTYY0QqqKFkl52iO7uwVisWCM/DE2lt5ocRFESHbHWaPrn9qt3jHueBwzfm5Vk8M9NVn1Q7mKTP3auckmQUyMkd7JqEbLwWLr8sxrnVAasU3TJLOS7ocByrMSfBo3HfZVzUGF+dYH/y4D9oEYmYT2Htk8/ZBNGnVJxo0O+1hOJy7kd4tSsIBBPQnZ51gO+LJa+YMRqZVQt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOnJef8syakP4Nd9/X35rupQoVDOYtVqpnltYtSmxW4=;
 b=2AUZp0aufShz/wQHrVDYkyvfz59KdkWAc9UaXQlFGhyyexo9DtIBByWTi3v3rWTy+u4TcL/WoFeS0lrZuXA2WyDCUvzoeNbHIg9nh7Q4C1XrEcyNgB+gDhuf++b8+UUYMunx8A3seEWJY7/KKXdrmWNuTk1Se0+EDD8+MwNlpXo=
Received: from BN9PR03CA0402.namprd03.prod.outlook.com (2603:10b6:408:111::17)
 by DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 13:56:45 +0000
Received: from BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::17) by BN9PR03CA0402.outlook.office365.com
 (2603:10b6:408:111::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 13:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT110.mail.protection.outlook.com (10.13.176.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 13:56:45 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 08:56:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 26 Jun
 2023 06:56:45 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 26 Jun 2023 08:56:40 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/10] ASoC: amd: acp: export config_acp_dma() and config_pte_for_stream() symbols
Date:   Mon, 26 Jun 2023 19:25:11 +0530
Message-ID: <20230626135515.1252063-8-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626135515.1252063-1-Syed.SabaKareem@amd.com>
References: <20230626135515.1252063-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT110:EE_|DS7PR12MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: d96855de-db05-4974-2ec2-08db764d2de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thK4D01c3ay9AeLhleXhOFW2SPc3eR7fE9K78oLrxTwd01y3f5kTeT3mdUmZ/Ig2GpfmApn56u0jCRsNi65Vx4SLqC7Shicsc+Zi3yotE6DMY5yxUAoMd8ZP11woQ2mv9jPr0/6Zbzy52dWcVJaI3sJk1JIUZPzl9FvbIEHF35TnAfSGunM4jl8HRqqPRRkcnXEkRj+A7u4J8M2PXtPC545lCupvtcZhWIIuxIlhJrxrYuipyAEY2047oWW42U5zlTyyoCUe66IJXV0C1xBGl2KPTKzbPJ+XpAB8IRfHKV0SPkD2UdveamHdYkXKC4jAlLMNeudxZ77LEAL4l2K72vahZzTSnIm00oIH5RPgaYIy9L7Ow60wqFByKS+Q06NMhBpoTZl1q+Ev45o+XXOJCMeTUXyPaD3LvOu62YCDSGjPQieg8C10BSQOEVOVXMIh11YdOb8vus6nIxHtQHjHJUdQi4l17RnvE1rpGfDo5NiIZGyuOg4wZiOWjjf0hd7hIHnmooD26agmfG+tB3HxMFUJxNd9LzNSHLUhtXOOJkC8TB/CvuqZ+0wuVDUfWnXb5zBDYTahjWB3U6cmohz/BD7WGBtt43gO2j3snmSGsRzG/KNckhED8on0VVR8uzDm0WpRTLoFuyC+sqqtjOwOCf3nXv/OJe+7JNdd/XhKVnCV7w+CbBByStDMf7qISw+cYkVnOpNcCpDoR3AQOadqgPGfpF/u7NHve+6zidFdk2A3c9J9VIjICE/D+AuPRRir3hLLTM4Ksy9+Ey7rs2T+ZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(47076005)(40460700003)(8936002)(36860700001)(8676002)(5660300002)(36756003)(82740400003)(81166007)(356005)(2906002)(478600001)(40480700001)(186003)(6666004)(7696005)(54906003)(2616005)(86362001)(110136005)(26005)(1076003)(70586007)(82310400005)(336012)(83380400001)(426003)(4326008)(41300700001)(70206006)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:56:45.7101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d96855de-db05-4974-2ec2-08db764d2de2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export config_acp_dma() and config_pte_for_stream() functions.
These functions will be used to restore stream configuration during
system level resume.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-platform.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index f220378ec20e..f516daf6fef4 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -127,7 +127,7 @@ static irqreturn_t i2s_irq_handler(int irq, void *data)
 	return IRQ_NONE;
 }
 
-static void config_pte_for_stream(struct acp_dev_data *adata, struct acp_stream *stream)
+void config_pte_for_stream(struct acp_dev_data *adata, struct acp_stream *stream)
 {
 	struct acp_resource *rsrc = adata->rsrc;
 	u32 pte_reg, pte_size, reg_val;
@@ -143,8 +143,9 @@ static void config_pte_for_stream(struct acp_dev_data *adata, struct acp_stream
 	writel(PAGE_SIZE_4K_ENABLE,  adata->acp_base + pte_size);
 	writel(0x01, adata->acp_base + ACPAXI2AXI_ATU_CTRL);
 }
+EXPORT_SYMBOL_NS_GPL(config_pte_for_stream, SND_SOC_ACP_COMMON);
 
-static void config_acp_dma(struct acp_dev_data *adata, struct acp_stream *stream, int size)
+void config_acp_dma(struct acp_dev_data *adata, struct acp_stream *stream, int size)
 {
 	struct snd_pcm_substream *substream = stream->substream;
 	struct acp_resource *rsrc = adata->rsrc;
@@ -168,6 +169,7 @@ static void config_acp_dma(struct acp_dev_data *adata, struct acp_stream *stream
 		addr += PAGE_SIZE;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(config_acp_dma, SND_SOC_ACP_COMMON);
 
 static int acp_dma_open(struct snd_soc_component *component, struct snd_pcm_substream *substream)
 {
-- 
2.25.1

