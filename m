Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FD06D3DED
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjDCHO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjDCHOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:14:37 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A79BCDD5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:14:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQTS/qrel6tqWNv4ldUm2bKNtz3InXgpe5lUYNjH/WI39mmNNHA6pnjWbfi+dbR+n/94TZ9xa1OxvubLXcSuAmUDlxpB/+tlgt2lJ7Ocj/RvuRwtkTmC0JqabnOH736rHwgJ6UdAVLrLCWvcR2+W8bzgcHoB2buXM+ttRiIUtPnnhTTrBfrbA3WkPATBRb/jtmJvrOQkzmHJNg44VzM6R1yHvgETYlvjsJLG5CY616NOUDX3g+eKKqvv8TAB4JhhMioB05oWxIJL4CuHt1FldGG4lcignEcVNd6X8q8n7TVv1q4bCeNc591Kms8QMFexb/6InMLyDJ/qFY3Wwjoopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxtL+9QCYmdY/CoHEsuSDuu1PdvAG/8SUQvAnigVXro=;
 b=ii5s6vDfXRoXqXwDRu0ku0DF1gLmP6FBMuji2G9a5qdZAYBpJiv9QRzVSnJTXPNn7wwGYDg34XjzRf58a7ZAHLJVzpvG7sxKfPSQYx2a+4fY1u5v7aklZItA/cr+ZmUGNMEfvabClKjUF3i5M3HU9b9uSTOlvBKrRxHvN0CWmLgjcPI4q199P1ZkJNqeTI5U/Jgq0oSMsVt8ZQBox764zMLMtBzkmY2XPSiBSR+PPaplzTNlyyYwlmcF4XAEIHTmlbwggS6zlp3X1EaDfx0wKm/2FxFn8SKGq8tXmuUf8LhzGEGdMgfQliwLjSFF7hb8EhyfUsBfIN6V4fNj9gbgtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxtL+9QCYmdY/CoHEsuSDuu1PdvAG/8SUQvAnigVXro=;
 b=2OGGo1xEJBZfFbfImU923pXLDUapo5nGDYG4QB+DUKt7QeP6xRKI5VL4GRW+K115KEg0IABFhs6oCm26El2786B3ORsubIU3viBzHpL+Qzm1DLtpDaVxHzVI2dBEVHGbNCFrcYZD0y13uTfcAE6CwiGB6l/MnuuEQ+0+4+jdySE=
Received: from DM6PR03CA0001.namprd03.prod.outlook.com (2603:10b6:5:40::14) by
 DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.33; Mon, 3 Apr 2023 07:14:18 +0000
Received: from DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::b8) by DM6PR03CA0001.outlook.office365.com
 (2603:10b6:5:40::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Mon, 3 Apr 2023 07:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT088.mail.protection.outlook.com (10.13.172.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.26 via Frontend Transport; Mon, 3 Apr 2023 07:14:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 02:14:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 02:14:16 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 3 Apr 2023 02:14:12 -0500
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
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] ASoC: SOF: amd: refactor error checks in probe call
Date:   Mon, 3 Apr 2023 12:46:45 +0530
Message-ID: <20230403071651.919027-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403071651.919027-1-Vijendar.Mukunda@amd.com>
References: <20230403071651.919027-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f9aaf9-ad0c-4182-d4ca-08db341309dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QhmEU7nm6A0GC8FYX8uqJOTM36lohhcRvauoQUKJ+FGZjRPLQSAQE95IZOli04R+HuX/h4k1YAPIjcn/rzl0S6ixyH4cHSaYQmbcHaR+9V0QD68FbcAfSjmc1r38OkRLb9PdZuWnbB4ZluwVOf2YqUGImD1NGOjfa3oMp9dDZNhJOc3982PanuPDFL2tD7mv6Ej6fY+3eV3/gfGbyH2flsoEjQtyH1Yyqx6dO2EFdezU1lapEhWxG7zjFicx14C6g8yW5jlrghaSZGRMsVt06oE2VgP5td9KXbANYUbR8z7indqGrx6/JTKI8oYCEQyu6eptOwhdiOjDAunDVXFKxQwE93YbR7WC+073cnBPkHm65Vl4J1HvbDvqpA+kUZpufyAYBppe2gWfJPA0lbIiOV+9Qn8+nlsAlOGnnZMMptVO30f8HOCYm1xZKwu5qytJnUdFuFL13OrBuPdQhUof/SYeL6I04xnwZ2IiebOqKksBfVNTab0d8mT5lo5BkB7dbISOdyFH1XhCtQuKBPFRJTHyUr5pQfhwrr5hRu5mwZillSaTer9SgtS3FOSOQEcXdshLTLr68Ib+AkTipiymci0cZS2pCPw6yplFU20RiB2+Q0D6cptYLo8cpdVqpR84rCOWwXOopnHXkOqBkd0NRxwaPdqa+jWJR2q+6pe0tNpcRsangD5oHsYZxai6nvj0zUusrCrrHRWh8LDx2MxI4+4F04XI/8BVoZNhK3cA3aE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(356005)(316002)(8676002)(82310400005)(41300700001)(6916009)(4326008)(70206006)(70586007)(81166007)(5660300002)(7416002)(54906003)(8936002)(82740400003)(478600001)(86362001)(2906002)(7696005)(36860700001)(40460700003)(47076005)(40480700001)(26005)(6666004)(1076003)(186003)(83380400001)(36756003)(426003)(336012)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 07:14:17.6766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f9aaf9-ad0c-4182-d4ca-08db341309dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor error checks code in probe() callback.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index e8fe324c23d0..dbf9ee6d79ed 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -503,16 +503,12 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	if (ret < 0) {
 		dev_err(sdev->dev, "failed to register IRQ %d\n",
 			sdev->ipc_irq);
-		pci_dev_put(adata->smn_dev);
-		return ret;
+		goto free_smn_dev;
 	}
 
 	ret = acp_init(sdev);
-	if (ret < 0) {
-		free_irq(sdev->ipc_irq, sdev);
-		pci_dev_put(adata->smn_dev);
-		return ret;
-	}
+	if (ret < 0)
+		goto free_ipc_irq;
 
 	sdev->dsp_box.offset = 0;
 	sdev->dsp_box.size = BOX_SIZE_512;
@@ -528,6 +524,12 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	acp_dsp_stream_init(sdev);
 
 	return 0;
+
+free_ipc_irq:
+	free_irq(sdev->ipc_irq, sdev);
+free_smn_dev:
+	pci_dev_put(adata->smn_dev);
+	return ret;
 }
 EXPORT_SYMBOL_NS(amd_sof_acp_probe, SND_SOC_SOF_AMD_COMMON);
 
-- 
2.34.1

