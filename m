Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBF973DC73
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjFZKtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFZKth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:49:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530C010D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrS8CMKTuhJsk6UXNjoRsI5vyUJgmieSei+qEbZh8zXowu1G5VTqM3AQ8X464PvSnwzdewQW+cx/5tspLkwid6c9WnooI97T4FJGoGLmsUQXlxhB/PBwW7ftGWEN1kiVYCPzRi8qWOvLGq7RouusTjas00qmM8wUTMkuTjAqKgJM0cupQf4UiR7tHcHA9gSj5zZbjPMPk49F4QhHMvFnM+bn79gyLLbOqLl6WVl/zw9Z2Qp+aH5JG2rbEdYXUw2475u9GPH6OnHshc/vGw18YqfbEEfhzO3Wu4bDOqVyaG7d2PpeRdtDqvCUQ24I/kkQVvbUo6MR44QWOOiUEslNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W25PCIQtrqSR/2RyQHi3bguFladghcAJ45xobGw6ji0=;
 b=SQ9foh429Eg8IHvwrB7eVUeBy50JZp2aEgFW5zsWELjdYJ4gQwMB5bM+ozt2ElzG03kfCU+FVlRn57Qi8BEby4h3aUwUogx76VATgzxu2m4bs1/44kGB5afITMaQ6ejyN/kbZGNs2N9jLS5KG7APAStImmAVgnPFFfy7yoA4kqQaQVxT3rnxgIOrRmzaE+fyeXXtVyCmeCcdv2Dgboc+HOTW6nItx3/oaJPxTGE+Wa8RQ+o09NNWQ4iyyykYxHbXQHeSkRI7/eWBufldwBhJux0rwrIc+8MGAHySQMAuZRc2/bCQT5Uqy9fNLPBPelBfuTDnxEdiw8wGaBS0dbbsJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W25PCIQtrqSR/2RyQHi3bguFladghcAJ45xobGw6ji0=;
 b=vI8Bgnz2ynneWhmWx+ub9cR9WfaDw/NwWZGFvTpN0jA7028ZvXJFxP2QyhUQVfq8AbTA1cwdAZKqJfDeTqh8i/IdwUGc1Lr4Egv6uynj6fWgnlGRmXzWnCxWwcxoQbUOuGNjL+cQHKI/qWIwZOXgIKonmScPWex89jxPd7dQV9o=
Received: from MW4PR03CA0204.namprd03.prod.outlook.com (2603:10b6:303:b8::29)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 10:49:29 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::d2) by MW4PR03CA0204.outlook.office365.com
 (2603:10b6:303:b8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 10:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 10:49:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 05:49:27 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Mon, 26 Jun 2023 05:49:24 -0500
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
Subject: [PATCH 1/6] ASoC: amd: ps: add comments for DMA irq bits mapping
Date:   Mon, 26 Jun 2023 16:23:49 +0530
Message-ID: <20230626105356.2580125-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 4440eeff-f82d-4fa7-fcbe-08db76330434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TIzvj2pQl/phlP1ZXEPpjGEL+QdqWK0IewbSPVOxx2Zlh0+5/UF0rcNokD4ahfwtgyOmfxkeSz46JK6WktSRnH7fyvxuyCS3jPJKB/oxck7jJQqtYVUaHX/bwva1pYiWCqX9ERetYhJC3NNbyDEOqMuChmYtwudL5RsZrDw11oOxMye9VvrfPJfvnnnCTVd7QM1yCULYn+zvHzPStwj5cIXZYfi2GgqGjIzDyJ7R4SeOAgJXxdINsK9KyOxFNXAxVw/ehgc7ADp0uI9d6cEAIobIwFXLbRGyc/hKy7TT4KNrtePGcuDBvYOf6JgbZRG/tFRUSQW2aa+cQy0T61uicXsNur2CM53lAWB11RSneR3kdtg/RmenqKj4NlGJ5GMhycrP/Mj4IWnUp4UNNnwgn/WL7F5/7hScGktxXFr0XzofdVhB0MVxW6VliJaQZSUlKOQ+hWWR7LY5/JSIFlu+wx2QFK26lKaWjL4dgJqLd3g/P7sEsWLkAPpvAzCigUXbdRIRShm0e1z6OqBUQxrO5FY2kEI/CZNHq/uc+5/kHkDBvEAgHCPcWDLimEuu/c4whdtVr4afOPvRv80RZKJMM4GLtCjyOr8k329o/p4mAhxbaq+lkU5ju8E/VEUpjrqjBqICXS0rV8uSxJoTUBB+xqvXsXlNw4u+YFfKfLd0Fho4BeWcSIsb1HTzQdyd5tE3HxMemXDs/JM2O2xyzEwOyC2zYVmU+2yyoiy3Yfa7Y7UybdxXL8sVf9LC1ys11OEABwIAh0KYrF6dBHzFOYri5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(82310400005)(47076005)(478600001)(7696005)(2616005)(54906003)(426003)(336012)(6666004)(1076003)(26005)(2906002)(186003)(5660300002)(70206006)(40460700003)(36756003)(356005)(4326008)(81166007)(70586007)(82740400003)(40480700001)(8936002)(8676002)(41300700001)(316002)(86362001)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 10:49:28.7485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4440eeff-f82d-4fa7-fcbe-08db76330434
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add comments for DMA stream id and IRQ bit mapping in
ACP_EXTERNAL_CNTL & ACP_EXTERNAL_CNTL1 registers for
SDW0 and SDW1 manager instances.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index e96e6dc9d90f..733a16e23d32 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -116,8 +116,28 @@
 #define ACP63_SDW0_DMA_MAX_STREAMS	6
 #define ACP63_SDW1_DMA_MAX_STREAMS	2
 #define ACP_P1_AUDIO_TX_THRESHOLD	6
+
+/*
+ * Below entries describes SDW0 instance DMA stream id and DMA irq bit mapping
+ * in ACP_EXTENAL_INTR_CNTL register.
+ * Stream id		IRQ Bit
+ * 0 (SDW0_AUDIO0_TX)	28
+ * 1 (SDW0_AUDIO1_TX)	26
+ * 2 (SDW0_AUDIO2_TX)	24
+ * 3 (SDW0_AUDIO0_RX)	27
+ * 4 (SDW0_AUDIO1_RX)	25
+ * 5 (SDW0_AUDIO2_RX)	23
+ */
 #define SDW0_DMA_TX_IRQ_MASK(i)	(ACP_AUDIO0_TX_THRESHOLD - (2 * (i)))
 #define SDW0_DMA_RX_IRQ_MASK(i)	(ACP_AUDIO0_RX_THRESHOLD - (2 * (i)))
+
+/*
+ * Below entries describes SDW1 instance DMA stream id and DMA irq bit mapping
+ * in ACP_EXTENAL_INTR_CNTL1 register.
+ * Stream id		IRQ Bit
+ * 0 (SDW1_AUDIO1_TX)	6
+ * 1 (SDW1_AUDIO1_RX)	5
+ */
 #define SDW1_DMA_IRQ_MASK(i)	(ACP_P1_AUDIO_TX_THRESHOLD - (i))
 
 #define ACP_DELAY_US		5
-- 
2.34.1

