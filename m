Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5468873E13F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjFZN5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjFZN5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:57:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1745210CF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:56:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YB9LEs5+gmXKFYcPPXFCztbRhUfvHDIMCrVWTqqxZDEm4Rst7hSmMCcCgmU+ajhp+loWBXCx6hCDxg+84WYJodkFiaQim8kUKGRN/8FBcvDcKIrfVGNy0eYEXIdCG3JSD5a307VUvfKcwWKxBnqTFt3xMuKnSXJNisu+GeHI5KMzB5/kin+xdLEgnldNdp/48n5pp9ioTbd+HrvsGKs+z0PHS5shOwcCuTavnbL9eiCKbfAwOtCA4LKHrmLpX13CvLcGRAwr6MPMqSa/qE455Dj1y3NryN5em2ZxCZlQ6kkf9vQHH2xUD9hKtA5KUCVSvAssZi0R89e0/R/U0FWXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1gJUJChraGI/0cF68p/+kGmZoqkKWvMw/xcvMoaTYc=;
 b=KHu21pEXGMhNGbc6BU92zsWAaQqJsgmHkAw4SHBfvo+XPwb0/ajQp7dOD+45gLwAUGKThWbt3qFCWgD5U5RYvQHvW837Mh5nfuRGIFMp388ICZqEw7EkdtnYANYXG9URjxCMFN8Ua/uyS4ALGOnvDy9MhrnvgavXHRWP8YCERZMZZohzfKeydetDZa4BIPHbUpBp0kQSxI72P2MzbNm7pzO1gNG4N8bCW0UeUPSwOy3h5FhTLCzDAz/y4Tem8aD7kQUy819bQOwd6nHF0Besx2YrXxPZOmhP7s6bq0XeRypbMrb+ei888hO119HZ/kAjZcmBKqWYPeMN1ylaL+w53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1gJUJChraGI/0cF68p/+kGmZoqkKWvMw/xcvMoaTYc=;
 b=SKefDmv6osAYaMgB2MJJ8/BM9e0c/wsE2eBa0lkWp8bFRyqsQ/SQvOuUlqd7/5JFDBM4nv6WfeHbEHtyVrQReIoHul5XNMiaRZ8el9kXIf9VN+KBIxmlG0kRaRIzmdmrcNa5UOAJzsX9v4OWLqa/NtmPu0L8XQkrR4/QtwQx3+k=
Received: from BN9PR03CA0273.namprd03.prod.outlook.com (2603:10b6:408:f5::8)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Mon, 26 Jun
 2023 13:56:39 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::22) by BN9PR03CA0273.outlook.office365.com
 (2603:10b6:408:f5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 13:56:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 13:56:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 08:56:39 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 26 Jun 2023 08:56:35 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/10] ASoC: amd: acp: store xfer_resolution of the stream
Date:   Mon, 26 Jun 2023 19:25:10 +0530
Message-ID: <20230626135515.1252063-7-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626135515.1252063-1-Syed.SabaKareem@amd.com>
References: <20230626135515.1252063-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4f708a-aa21-4a09-b93e-08db764d2a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GyyH0thC/rAgLXinZviIpvsyrkb8aRgvFaQpdZgpAUX0afw16uAjj9FoINpBrP4YSmo0zvmwtiunzdoDnShyxxUv/aN/cKxSB2AFx4mI5GOPg7nWA70wd5XnTtwyaWD2bWVaGM+Ybki5nCWP8JP6VgNZOqgsCY9a3Y/A6vXOnXLozX5/1xyL4cYj/JUnSO6e0q7m7HxNJ2ItwCFlkCEkQbLzFUuMc5QwGyWln1HO61YUWrugUgRn18JFKM+gnixwv2LN1MVjVE/TCHZ5kBKElFnH081EB4OWZS0C1+0JFdYccsXgtbd1UGDjKnXMpvUvjvEFV1GYlVVT8iKfYP7W34ht0/h4MJ5hGW6hW592gMQ/cDBsIeqepU6Ne8WaeiBlo1H2mrLn+qWW9O0+qNftkaPPc/MHOpUUiKThpvXrBft4AFex6X+rQGoXfcjOXLxvrCxKknbOyrjUptw46VEKOTk19A2I3bOW65y2w8oDH8OVEVpIGOm+8H9r6Gq9sLlNgPGzdIOa2NoMO4/XK/qRTSaCE6RAzWpKHljV3i2HnkQh7IWoNkZ/xvTto0vhgda9KbYVvIIl0hhgbZ77uoCwR+Q2Pyra3adeI9DTRth+3YcemSpH1SO5rhgYk+svupDpynGnyGOzJleO7ttP01iDjh6KTQF1/HMgua+dJl5wxTUV0mmPfd5x8eVpXo3Xq3QYGAvQ/OsxCJGD8b7ePF4aRtzpKnEqM22sEv25U6WrZlwP0DNLs5i3d0RjGZbciJ8QIoOIYm+rVlF6Gcz1wLytMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(2616005)(2906002)(40460700003)(336012)(426003)(1076003)(4326008)(26005)(186003)(316002)(70206006)(36756003)(70586007)(40480700001)(356005)(82740400003)(6666004)(81166007)(110136005)(54906003)(86362001)(478600001)(36860700001)(41300700001)(47076005)(82310400005)(7696005)(8936002)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:56:39.6687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4f708a-aa21-4a09-b93e-08db764d2a4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the 'xfer_resolution' of the stream in private data structure,
it will be used to reprogram the xfer_resolution for the active stream
during system level resume.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-i2s.c | 2 ++
 sound/soc/amd/acp/amd.h     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
index 09b6511c0a26..09dc5f2c0bfc 100644
--- a/sound/soc/amd/acp/acp-i2s.c
+++ b/sound/soc/amd/acp/acp-i2s.c
@@ -149,6 +149,7 @@ static int acp_i2s_hwparams(struct snd_pcm_substream *substream, struct snd_pcm_
 			dev_err(dev, "Invalid dai id %x\n", dai->driver->id);
 			return -EINVAL;
 		}
+		adata->xfer_tx_resolution[dai->driver->id - 1] = xfer_resolution;
 	} else {
 		switch (dai->driver->id) {
 		case I2S_BT_INSTANCE:
@@ -167,6 +168,7 @@ static int acp_i2s_hwparams(struct snd_pcm_substream *substream, struct snd_pcm_
 			dev_err(dev, "Invalid dai id %x\n", dai->driver->id);
 			return -EINVAL;
 		}
+		adata->xfer_rx_resolution[dai->driver->id - 1] = xfer_resolution;
 	}
 
 	val = readl(adata->acp_base + reg_val);
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index f53613216397..38c152c6c8c6 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -166,6 +166,8 @@ struct acp_dev_data {
 	struct acp_resource *rsrc;
 	u32 tdm_tx_fmt[3];
 	u32 tdm_rx_fmt[3];
+	u32 xfer_tx_resolution[3];
+	u32 xfer_rx_resolution[3];
 };
 
 union acp_i2stdm_mstrclkgen {
-- 
2.25.1

