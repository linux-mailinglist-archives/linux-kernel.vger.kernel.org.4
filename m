Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F27073A4E2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjFVP1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjFVP1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:27:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C0E1739
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDoXbTSGBemT0/BssXc3ZcV5S7OrnprUqWDo7jQpxaK38XcxdEcTNGTd9+jcEPmlLgc4aUq7p+viZZurLcnjx4sNPPuKGksMhw9Jc+XHMKxAbz3CI+ev0NNNNRinlxn5PfcDPN65dFlZDn4KQy6IGj9WhfdI2PYuTwAppNKBXyvwyZwlOuD1TY5Xt/5ZR0wr3e2NjbL+3xFLKfK4lA6Z1cVsSC+N/TcaYiUCo3D1EuiGkcDKTAc7Dh8hx3Qx50yuQxm9fV5kLn5CBsxc3kMxDm06I+31ma6IRoHQbUfabCvNCUEFIfO9foiks0SSVz4pGloyuddNqHnCwYMvFfbaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHl3imB2MTXt7pew7uDec0h5NMyhhOl3FKPgVMdbHuw=;
 b=GbtshzSbLH2YDHCyLW6iZ7PpFrNVsX8TBWcXYMjuTcf/i5EPq7EmjDWnpc3tO0fhCM62YqGGqeXXpWO759qe8ey4STT+zAxSBytaxK/AFohflPlAnrUNx1MlH8bMJzc5Hd2n3cq939JFuAFtNfslAUZcFrovMo2brtBQ96I9KYbJzUirxzzT/Fy9q9/u1lQOtIvjgVV/e27KIxXOmX4X579jwTTzecRAC+kitzeaS9fYXVTlS0KlCTR1NHTbyjMF2ZWrJzovv3Ytuco5XU3h0C3NAEJKcSUgoHoi/hbn27rcnumF96cFFuWSiaWpdKSLRm21amEYZFVeSWcfWzLFWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHl3imB2MTXt7pew7uDec0h5NMyhhOl3FKPgVMdbHuw=;
 b=TnjE0i3RK7xf68/unYsvrwZOID6ueJdy3b2vUY3Z4nEdHon3DjmAbYZZNcdKhT1ovQ+XaWLH7TQdKrz9ZoKja0HS8JY7g0Xtnqm0weha6yPsSTONIYe35EXrWp7EoQqkzNK4J/lcgO0MTl15TkivsReQDhqRLKbDCKeGDcPIshw=
Received: from BY5PR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:1d0::24)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 15:26:35 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::39) by BY5PR04CA0014.outlook.office365.com
 (2603:10b6:a03:1d0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 15:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Thu, 22 Jun 2023 15:26:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:26:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:26:33 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:26:29 -0500
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
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/11] ASoC: amd: acp: export config_acp_dma() and config_pte_for_stream() symbols
Date:   Thu, 22 Jun 2023 20:53:52 +0530
Message-ID: <20230622152406.3709231-15-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e82ac4-85d3-4fd5-1325-08db73351071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gDAhX2fAztzW83J0YqCv2cJEQDxOHQXvQXvA4ClKjVpiFdI2ZDSr/b4uxxQqbtRJkT1lv6iHmVbX39zUGWVI4fCAvtqOwHfKPr1ijyby/13Tt0thkigCSn0CFUwsd/JfSiN+2nBKJZEeFfqQuQM1JHX7fnsnkuQumDpat+GuzQ1bqsoof31aDh0DA5/BrY83+t861iGEd4A5E4smUDZDu08p8ujnS8jTAH8V09u6t5WawRQ1PpziRamGqJsm91GDe77Eix5bg1PXgP9OqbJbLBAY+1iTIukpvIgAQ23gIdBsbF4jQfwN3xIpaLO/hgmhtj/9V1bqNBkpxeeVQDdwYdq95siGtg4mQLQMS08hiB1tkEmmT9JSI5pAWkdxvbzg6BciQb0dnU3gsfMqvxGS6Ln+7dEh1hJ2zb17Uiyc0Zc3E7aRhH4ZxtP9M27ed+sqS9ic1sDyAoKnjBqbMuqfjyT5JysK94DwX1/GqrWmTv5BqAbQN3QcXIK5WbdGLt6ilbpPk3N+ZZ5QzgWeRJFYLwwjqPw2ls853XBSuM3KbTezKVP12F3OLa+R7cO+2Fk0rv3t7vx6cbjpwEZv6XGhanFZIS6wJzKTNS5Rrl3zSSnPyCFSE2D73n8vb9KWxL7+ptAwmawkK/g4nOt/Z5lpSYX39uU2YeCep/TS0SKfrMjk2lqjAaJylDITFveLJgnWuJ9kZOvDcLjcz5iDcXcp2S0yzLajZYN97pitb0UagugwlDXI73ulse6aqaxfesJ+jST86Tfxv97OgpbGMc0hXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(36860700001)(5660300002)(36756003)(8676002)(8936002)(82740400003)(356005)(81166007)(2906002)(40480700001)(478600001)(186003)(7696005)(6666004)(110136005)(54906003)(2616005)(86362001)(82310400005)(26005)(1076003)(70206006)(70586007)(336012)(426003)(83380400001)(316002)(41300700001)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:26:34.7801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e82ac4-85d3-4fd5-1325-08db73351071
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371
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
index 447612a7a762..d34271862e42 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -128,7 +128,7 @@ static irqreturn_t i2s_irq_handler(int irq, void *data)
 	return IRQ_NONE;
 }
 
-static void config_pte_for_stream(struct acp_dev_data *adata, struct acp_stream *stream)
+void config_pte_for_stream(struct acp_dev_data *adata, struct acp_stream *stream)
 {
 	struct acp_resource *rsrc = adata->rsrc;
 	u32 pte_reg, pte_size, reg_val;
@@ -144,8 +144,9 @@ static void config_pte_for_stream(struct acp_dev_data *adata, struct acp_stream
 	writel(PAGE_SIZE_4K_ENABLE,  adata->acp_base + pte_size);
 	writel(0x01, adata->acp_base + ACPAXI2AXI_ATU_CTRL);
 }
+EXPORT_SYMBOL_NS_GPL(config_pte_for_stream, SND_SOC_ACP_COMMON);
 
-static void config_acp_dma(struct acp_dev_data *adata, struct acp_stream *stream, int size)
+void config_acp_dma(struct acp_dev_data *adata, struct acp_stream *stream, int size)
 {
 	struct snd_pcm_substream *substream = stream->substream;
 	struct acp_resource *rsrc = adata->rsrc;
@@ -169,6 +170,7 @@ static void config_acp_dma(struct acp_dev_data *adata, struct acp_stream *stream
 		addr += PAGE_SIZE;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(config_acp_dma, SND_SOC_ACP_COMMON);
 
 static int acp_dma_open(struct snd_soc_component *component, struct snd_pcm_substream *substream)
 {
-- 
2.25.1

