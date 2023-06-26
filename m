Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D589D73DC7A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjFZKul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjFZKuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:50:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4A91736
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+9+yPSZSpY79DLzlhSdc74tw2XzFLTQthSHses/WiBsnGx//eqm3dMBkkOkXv+OnzD5l3oCmqLqO78WCvYzXKnAoCtpkDSJAgQzrylzh4RbwZNrSQcERIzd6KxzgH3JJvRtWJMVtSSDPFPK3Tag9ILKxgNwnqdVThTxhdnFKvy6qE6WTmp/xbLpkOFL/op/5xzx4R5WQnt5nxb145lk1cWkHVMNpGxyvZeAtHEoDIhj3rCkGlqQlWNHW/BRmzq3L72K9X596Yu94CbrAR9cvNrJ3IZ+psdXxyckumlqBwXgFFPM3cUZv9+sP4VUCWnl46r8FTxB14Ha8qvRUisIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpp4MpPrpDTSF1zyIpBkXk8jxuOqcUeidsJmnH9IkRs=;
 b=ocF1ZroMOxJ6ngWe2Si18T9/HA55V/BBMiy4hpQ1y2gFYWh2bqZn5nCOFmk4BFDv8LmA3gB8o0DNSniC300EpvqzM+K8rMDyXotXqhLCePGg4UVhDgbRynzOHrQkpcu++MZKD3W/QZ2GF04xc65H4bKgtbSoqIjSFS4N80xoRrhj5BHSkWGkp5l3MCRRdbjOK/dlj4E09fOqf+p/7p7vaASyiQ1jd37WFudTUsSMHSD5Gqy0IlJ84foShNN5vWIixAhbv50nckkZKtWBsCO4+iGiHy1j/g5SHdULqK+5eW7HAW4cEqIMKqsjUM/x0E+1Te02Q5saR6sanNbHFyjNFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpp4MpPrpDTSF1zyIpBkXk8jxuOqcUeidsJmnH9IkRs=;
 b=diLicSt6OaWUtI7qAu+gV0e2zB5rxtL/SBF/cREzIxe8+UQx6m/d9F/y0V078L+3d6stXmC389ecMQnJrWpMlodXXppQeZ/FSwlEIipjNO4ZpRnmtQvdStgar7IYNNVtxuKnqxGcc9WpVvQjXm6ilFVZOCbbw16IskMDJa3w/oc=
Received: from BN9PR03CA0526.namprd03.prod.outlook.com (2603:10b6:408:131::21)
 by IA1PR12MB7494.namprd12.prod.outlook.com (2603:10b6:208:41a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 10:49:55 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::bf) by BN9PR03CA0526.outlook.office365.com
 (2603:10b6:408:131::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 10:49:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 10:49:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 05:49:54 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Mon, 26 Jun 2023 05:49:50 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Mastan.Katragadda@amd.com>,
        <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] ASoC: amd: acp: fix for invalid dai id handling in acp_get_byte_count()
Date:   Mon, 26 Jun 2023 16:23:54 +0530
Message-ID: <20230626105356.2580125-6-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626105356.2580125-1-Vijendar.Mukunda@amd.com>
References: <20230626105356.2580125-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|IA1PR12MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: bf79c706-f7e6-4a22-a107-08db763313da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0nkjRLiy2RD5bXLWuAqcIOWfewGLMLQUmcLaoAf8zj2SQWKIj9dTYMen6ZI5FeReHNPWSobBlmHwUoRFSQUfKYFvzMZYu3DgmBh/uYjIrHliIuTGOHFX4BvL70db1qhk14T8CNp7cIwls/bSNaH/jGJdB2NGZj3h89SKf2BULvOvAhHgDUO/y9CjbO5w9IlcwCZ5W4yaBqLhZ8WCnU6MgXg9DQajqeaygtzeOE0O7qfulqIcwpcVvcz6xuwc3NOyAQ9NMZwFs+qTupsFW99qk6xUcZxjBjoSRS/S8Z9Kv8iEWm3DCfbalFqTENgcNyNqAVenz1rdmKH1WuhPadoMeIs3TfuACbiYYkc+iLQ7BeA9aPOHm2Uqfa8Bsuo8/qEekzMqPx/ic/Ypa/Q9zGMFTFMGznVKE47zgnCSCC3CHjFx1pu0uUhlJTbLd2a/YUWudjnhlNtBr5Dfep1M6qH6qV3WSRv+8/k+5ZzwIZRWt/GVJ36ghZCbhpsw/TSaJCRti4Fo+SKBppUzl1z3FcSgpf0wKbaz9n/ridCKkfONeUAGijYkOCyxLp8m5JAhlB4UntFtVnokicA0rqMxSeZoAONMTlvDn3QJg4OpC+S0NXv1Vlv5LihIPNi7ePCEvUs+D0BPnFQPiXcCswSMcqXYOaX5cPBDakIuD0uOUGH809dIHa8NJbIF9UsxBQ5YHIlBHT5n8Ob4Hojq3sw2WTHeXZ3kmzmayeS7wK1gw+gYdNhLLL/H5RdyBggtF7X0DpyL59Qf3QBnM0BFbx4c41X+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(8676002)(70206006)(8936002)(41300700001)(316002)(70586007)(6916009)(4326008)(26005)(1076003)(186003)(336012)(2616005)(54906003)(478600001)(7696005)(40460700003)(82310400005)(2906002)(5660300002)(40480700001)(82740400003)(81166007)(356005)(36756003)(86362001)(83380400001)(36860700001)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 10:49:55.1249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf79c706-f7e6-4a22-a107-08db763313da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7494
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For invalid dai id, instead of returning -EINVAL
return bytes count as zero in acp_get_byte_count() function.

Fixes: 623621a9f9e1 ("ASoC: amd: Add common framework to support I2S on ACP SOC")

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/amd.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 5f2119f42271..12a176a50fd6 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -173,7 +173,7 @@ int snd_amd_acp_find_config(struct pci_dev *pci);
 
 static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int direction)
 {
-	u64 byte_count, low = 0, high = 0;
+	u64 byte_count = 0, low = 0, high = 0;
 
 	if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
 		switch (dai_id) {
@@ -191,7 +191,7 @@ static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int
 			break;
 		default:
 			dev_err(adata->dev, "Invalid dai id %x\n", dai_id);
-			return -EINVAL;
+			goto POINTER_RETURN_BYTES;
 		}
 	} else {
 		switch (dai_id) {
@@ -213,12 +213,13 @@ static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int
 			break;
 		default:
 			dev_err(adata->dev, "Invalid dai id %x\n", dai_id);
-			return -EINVAL;
+			goto POINTER_RETURN_BYTES;
 		}
 	}
 	/* Get 64 bit value from two 32 bit registers */
 	byte_count = (high << 32) | low;
 
+POINTER_RETURN_BYTES:
 	return byte_count;
 }
 
-- 
2.34.1

