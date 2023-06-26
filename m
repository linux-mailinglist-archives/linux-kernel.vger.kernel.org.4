Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3A373DC74
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjFZKtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjFZKtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:49:39 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA7E10D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+drf+wiylaVkax0XnK63wDKIG8GINBS9AJkwT+ElTQz42CgU7VPNwM5rPJ2ENVzKKkQ+hSlc8RSt5Vv1WlvPrY4a8bl2ceqV8EsWbVcZBD5udvRTHzhYJzgMcZ50CqDUlUX3CERPhENNRB6IaFRRL6oZjU8c8PWfX4IIaeZ5MVQih38aunn+LxTiIfa+AIiwImH3uOrS1NwLNd2Bx0Ar+pJXM+jfObgPc1aIVs7D1u6jH8G32jJGSh1yq7wEjd7XvLi++S+ADqD8slaH3Asvb4CMT19cohjlncWynR1Jk5f2AXsUzUUEjZFm729cDzfqMihruim82GDlkwoYLHC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6aB+WlRzqMc/V9fmqsehMY7bpEID+3jhhJbtBTL3Ys=;
 b=b/ONRDcs5iwoh+0ecNgwz328CbTxafcDjbSvF2AP5/k9+lQiOPVPk3aE4LI/7+BBsW4Ae4M7E3pTp6NOlSLeOI7BpOOtq4NT2psHno0W0CM2BX9DEehF0QPImSwvtTn4+gAUsklgTn48yFkAjXIf36HaiYVK3eFwLydDwd4FNSfp/VlQWtWA+Doa8oWU2zfEcSEFmt4/lOQX0aMeAQ4KouZfDdyFI3fFJRDWa6yBJEUP4OWedp17W6TxlcrcIOI6HtN+/QC/7lkJRxVzRuWUPHB5cjyzWNAvnj6IANV11Kw8lMRrMaSzptpn1AIifmwNYMwi2ogpRrLT1GzzGZnIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6aB+WlRzqMc/V9fmqsehMY7bpEID+3jhhJbtBTL3Ys=;
 b=W/xBoYMCgXjXqrJ4IAlHNqTcFvaeDgUHPuHkgOMzdVScUluNOmgLI6mnoWIjK50qoAEcK+Ff1nHkdz8oMWH+WPYWV/QwHTw6/v5cG2rn7mks53WOOGUCUIsI5Ookisnl1kP/Tb8zojSa/RzQ1BoUXvlSueiP7/Ky9fqdXpsKNa0=
Received: from MW4PR03CA0191.namprd03.prod.outlook.com (2603:10b6:303:b8::16)
 by SA0PR12MB4544.namprd12.prod.outlook.com (2603:10b6:806:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 10:49:35 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::84) by MW4PR03CA0191.outlook.office365.com
 (2603:10b6:303:b8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 10:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 10:49:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 05:49:33 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Mon, 26 Jun 2023 05:49:30 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Mastan.Katragadda@amd.com>,
        <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] ASoC: amd: ps: add fix for dma irq mask for rx streams for SDW0 instance
Date:   Mon, 26 Jun 2023 16:23:50 +0530
Message-ID: <20230626105356.2580125-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626105356.2580125-1-Vijendar.Mukunda@amd.com>
References: <20230626105356.2580125-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT031:EE_|SA0PR12MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 301cf36e-7b7d-427f-31f6-08db763307d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIxf/8jLaVi2VZU41FutIR0CyY3+YzbehWcHvhvWdDR4+TaV9NvXGULIJttRNecsl7DeEie892eU8mQbRq4IXaXF7gS5ar3VfmjFAsAFxBmME5FuKUSlTlIUSEnAD4CLE00mjbVYJUAPMRNCaL8TGnmCgeZYW67+kYQu1zRAgKNCl9u3nkiJ/H78ZTUuXs0gkyOBbp9xSRy96p4KSDolX38eGI6XKay8KufUqCp/UHaL894kzaioMxBPqB8pXJVOrICI8erf6rxWIeC9BXAjzJTJnbmaevc3gGPw8rvTdKCwkKHCAyIBJZPbv2lR+V4SjoOcmx5S1G5JkXozqmAwng7KRbKYboydMnVY1tdEATRuttlCz/XBSUjPIkHzSNWCtwuwTgtd/S0QEb53oBk45u02C60dudDWktdV6wErvfURnycr8wkdJwbPQuJStn0X4I5G5zzkvMYqJeqV6Mt+JiOrA5bbJmSF5gD4UlQvdxFslmLNF8/HSziDOdSXgqKyAF9za//Zxx2ZrTXU/m2TYF9T6KXH6x+p4b43pTzYbvQcDXDXdIOfPVicgPk2RrcYyYtYfPlipwJGfDbl6y/+go7W/C3rg7UiXBmqAOAKSGEqAvn+GlqI5vBvByFp0WekwKVIGKorpnq8o91q+ygOMSvmTrdk9ePZ9rPreMkU7UTohEnUAXKBBA/rM13paGufqixmAwr1XUoSRQ/qczvegew17sGhiEKjIcJyTkbUQUGJkfYGbADsAo9UFAW0oj89uJjPcxOcepndm4Shwk64dQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(7696005)(82310400005)(82740400003)(6666004)(356005)(2616005)(81166007)(83380400001)(336012)(426003)(1076003)(26005)(47076005)(4744005)(186003)(36860700001)(40480700001)(41300700001)(54906003)(86362001)(478600001)(316002)(36756003)(70586007)(70206006)(4326008)(6916009)(5660300002)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 10:49:34.7964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 301cf36e-7b7d-427f-31f6-08db763307d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4544
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the DMA irq mask macro to program DMA irq bits correctly for
SDW0 instance rx streams.

Fixes: 298d4f7b1765 ("ASoC: amd: ps: add support for SoundWire DMA interrupts")

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 733a16e23d32..8b853b8d0219 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -129,7 +129,7 @@
  * 5 (SDW0_AUDIO2_RX)	23
  */
 #define SDW0_DMA_TX_IRQ_MASK(i)	(ACP_AUDIO0_TX_THRESHOLD - (2 * (i)))
-#define SDW0_DMA_RX_IRQ_MASK(i)	(ACP_AUDIO0_RX_THRESHOLD - (2 * (i)))
+#define SDW0_DMA_RX_IRQ_MASK(i)	(ACP_AUDIO0_RX_THRESHOLD - (2 * ((i) - 3)))
 
 /*
  * Below entries describes SDW1 instance DMA stream id and DMA irq bit mapping
-- 
2.34.1

