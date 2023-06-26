Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40DC73DC78
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjFZKu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjFZKuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:50:16 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD368F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFvl3xZlEqP19qEDDkKWIxRROrDctcUoKFxBpvPQ+Pd9cDWhJp+RJkXig/vVznyjA0IV+s0MPkkZlKtJuAPxQvIFkYfcQpC029pzgGbH+SqYwyDY6QpibCsSQbLTygH/r/zZ7PeYv7T98PFubVh+rs19BpGsZdP3Yv7tLUNcOfUoT08uas7F/hd4WRitLKxHwZ0iyubxtR60dPyJeqJwszdSPUADPBLs3q9T1fQy+ctiKJIKX2ae0cPxLu/3vakvFv0j421lgHnPU9wC9sLqgNpjUg/oooDq7j9ukGO25gU0Q9LFFOlLD/8yTGDrLBy/YKbpZdwnTp4bQ39tCpma9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjqQAsDOlDDkBXLiTHkmm1YDk8BAH5Guh6jH+qFjGqA=;
 b=Odxs6s2yokVyDeW1Q7lHIdCg7F4tDz4Ltjh/5tZZgyXLVcdefgRbfUXwIaTHivbMn/gOaTKCajeeuzVb6g7wfuaY23q8Xj4NcyjgWo2QeTRK8nF+cqZVPTPnLs/ZY43gtHJEaD1FwD9o4J8wW9XslhACKwORHLnD/Q/vKFl12PDHWQKqEhcAAsqjmsvCq6iZs0t1COnvBsUs/pUNHGyqjqjLtn3fmKkXPVeHb19vFpUVG0jPzU0C4fmA5xkGu7ajxZWoQ7ohXrqjKH2YfiwQyrUpLtBlhhj17pRmYEeK2uR8rUcDq8seeCias7sUnoAB8HEG+MGDYUL7+xmPTED4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjqQAsDOlDDkBXLiTHkmm1YDk8BAH5Guh6jH+qFjGqA=;
 b=LUlSMUaFBCivVFd4Q4ymZyNlyt1iQ4E0kzPLBv04XfpsjjuUhSY5ZRQcUlSvXzGUFpJvGaylf4+tYHlosefly7vPRwT2lVEMceHK5mOtGRsPfYpriFcKqqTY9os18Cbn1C6zRHFl+WpquvYEUbHvZSvIUJWUS/4BYAm4UG+cfxA=
Received: from BN0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:408:e7::27)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 10:49:50 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::6) by BN0PR03CA0052.outlook.office365.com
 (2603:10b6:408:e7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 10:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 10:49:50 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 05:49:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 26 Jun
 2023 03:49:49 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Mon, 26 Jun 2023 05:49:46 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Mastan.Katragadda@amd.com>,
        <Arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] ASoC: amd: ps: fix byte count return value for invalid SoundWire manager instance
Date:   Mon, 26 Jun 2023 16:23:53 +0530
Message-ID: <20230626105356.2580125-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626105356.2580125-1-Vijendar.Mukunda@amd.com>
References: <20230626105356.2580125-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: e351118b-0f2b-435b-9b6d-08db763310f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /MLY5Ma2dPrs+QHWTFA2x5oaqGJcCDGsuZMHnhPAWlR7hDFPLZA4JCpVfPCtkp1kPstV9p6KMLIf7sfEoiaWRg7izxkoGapEk6HI+s6GjHLf+BdkBcpios5BSYQvIkQRh4nTZHfoLIW5dd8xFYF2csZUa5Jiu+FAV3OeOuE0JBDQb092wmNsST+MSiYW1sx+/CFkGr9KBEjGRuM4alvzqDg6zyf//O2NWIUAE/nQStbwCLvHw/GZ2r1u/PMFu2rOouUiuTUfiOq9wo8ZKNNC+kc73PBWEyZxMa36QTXVg2cOePg5TXJNuWFT0AMpR2WsVNMrT9jnI9A+v0Tsz8gND1FIr9y6Y5igMPrIt+DXtmcxZmbmTTW6irgh2uQZU5et3udpUQoZO22iWvTWzFQjQUTdll9/6i46ywsW39npCyKUH+x7DFDF/DVoPb0wjfPvcdP8/8g8OKpsHl3KNBAr3xznvMiIc8fXWoV2SONSL/Pc1wco3Y4pwwuZF08o13c621sFty0ZAxPNQ6vDMk5wWuPuQ9YXtghWHJWzbm5l74tUbNPK9HWtDdR/+Y/VDp9rkGMrYW4+l2MGPHDuK2wXPonrjKFQveoCkhBHanb4wNMHqlxld4wLFmbkA8xBane9CT9K+zacTWmqe1mDWUb16W6uyYbFQRBwmTIO9CRYTFfqn3RumYetiU4jsmc7Ub6dUntC54Q+xuWodr3jPGu8v6I9iset1Euo8bkElOo4GoEKlOvQ7WsIpqftODjf2tHZMJChQS9Cc545QS1oj1oR8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(2906002)(4744005)(7696005)(82310400005)(82740400003)(6666004)(356005)(2616005)(81166007)(83380400001)(336012)(426003)(1076003)(186003)(26005)(47076005)(36860700001)(41300700001)(40480700001)(86362001)(54906003)(478600001)(316002)(70586007)(70206006)(4326008)(6916009)(8936002)(36756003)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 10:49:50.2595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e351118b-0f2b-435b-9b6d-08db763310f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acp_get_byte_count() function should return zero bytes instead of
-EINVAL for invalid SoundWire manager instance.

Fixes: f722917350ee ("ASoC: amd: ps: add SoundWire dma driver dma ops")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/ps-sdw-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
index 000ab5d96815..324c80fca672 100644
--- a/sound/soc/amd/ps/ps-sdw-dma.c
+++ b/sound/soc/amd/ps/ps-sdw-dma.c
@@ -318,12 +318,13 @@ static u64 acp63_sdw_get_byte_count(struct acp_sdw_dma_stream *stream, void __io
 		pos_high_reg = sdw1_dma_ring_buf_reg[stream->stream_id].pos_high_reg;
 		break;
 	default:
-		return -EINVAL;
+		goto POINTER_RETURN_BYTES;
 	}
 	if (pos_low_reg) {
 		byte_count.bcount.high = readl(acp_base + pos_high_reg);
 		byte_count.bcount.low = readl(acp_base + pos_low_reg);
 	}
+POINTER_RETURN_BYTES:
 	return byte_count.bytescount;
 }
 
-- 
2.34.1

