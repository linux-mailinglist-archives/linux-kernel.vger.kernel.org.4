Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04906D3DEB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjDCHOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjDCHOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:14:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAFFEF9B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLIB4L9zTlmH11qwjFNJWXHCjh3sOeTVeEzuJNiDDDOIv5c8K6Uut3rV1HX1PNrbZrZgOv9Qe8vF+DnrfiBFUprCh2JQ66RkIBNbB+gKz/AuNfgjRA1n8YtJ4QEdrgJop/ONZbEwezUQzbKztcxyf3sUClHKKXUbjxOVsCn5yYVHgllF35TyI4Epidyr0X/pChRhSTIWZ5eyhqbqODlmpmea0db0JGjayAGCPThrBKr8oZKQz1FkS19W2hOWEYVw7t3Rp8KaRM3h+e7shVQ4MFNEaIrPHvr9GUITx8bXacrBHyYZiTC2BRsrRfDOjngd1YZCumdkkNhEQ2V2CU5TRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3aDbK43nFYU6lt/JaZU4bsa9TW7L4EFVaCfxSnjk74=;
 b=jbTM5F3NXf0uPntVyQFYNHGDffHAw+qx9DOe596cf50MHCAE9hyutF84YMqcZUDZDlBGkQRwqhwvv3G33EyYd14DC1TOBEDJ1e1vNaqT91qwcVkZfpW0ldhcDUkYqwnRSGtYSSovlT7KukEoz5w4hth8GzZEkAX5Mh7q/1rHbIsqrp5N3mYKaCk5Lz3tkASEtt3I1ypzP09Ad7FgRSDcRtVF4C668v3ZCqAYmf4HyvumHgklTyDOANYZEKVcLUgPgHu8h+Q0VVer7Fg2kMx/1bw1jSGbX1favj2Q9nQ0epaiYYNB4PPVb0RqEQDGblljaTur4Dk8+PxmnX3pD8iyXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3aDbK43nFYU6lt/JaZU4bsa9TW7L4EFVaCfxSnjk74=;
 b=Q7vxl/VstpwkIOQxnXMDZaETh5IDOymFPv9VwcNqrVBT319DBwfEmLJjyJe2I4ld3wyhak03REpnwU4SRKu93v9JiSIoNLXRvL9kHR1S/cdrsTXWIi8V31pFcLiJyO3839HOpaxRjaychhtQkX2e05dp6JoZSGMMrPHZBPjTa2I=
Received: from DM6PR03CA0087.namprd03.prod.outlook.com (2603:10b6:5:333::20)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 07:14:13 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::86) by DM6PR03CA0087.outlook.office365.com
 (2603:10b6:5:333::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Mon, 3 Apr 2023 07:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.14 via Frontend Transport; Mon, 3 Apr 2023 07:14:12 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 02:14:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 00:14:10 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 3 Apr 2023 02:14:05 -0500
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
Subject: [PATCH 4/6] ASoC: SOF: amd: refactor get_chip_info callback
Date:   Mon, 3 Apr 2023 12:46:44 +0530
Message-ID: <20230403071651.919027-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403071651.919027-1-Vijendar.Mukunda@amd.com>
References: <20230403071651.919027-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ad219c-428a-4a8b-7080-08db3413070e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hk5texWbCwz6sGwz/6Odf/Du67wegTewwzSahUmTTIunRUS7M9UG9kzMBmTgIO2VOEQZY2jD1pxSNhRAO98AJKU06Q+uFZdwaS/6h2mJA3bo4wdGRPe2Ohx7Th1J3GQbP2lN1oDRE+WEPIQQvA305pXY29rC1ZbEv0rnL+U0yCyKJ9COF6nG1BCPton+M27iUibmUdPVXFkdD9aVBMLwayBhaHf4IMvxh5fwvXl/hEs2evK+rNUxwEtcLkYue3MNcCX40od7MVBdp5HrdMeRDf/t9+q95ol2sHL36VR7ZkAg74JHPb5B+y+YKdgQNfIWejvIhFI7NRc09BLjCbKyLAxSphO4/+brkjO6tZFGB1k3Nbp4QEIAQSrBxlYVX/1C1wBszaEpalxABeKM/isd87XaPQ/C3Sxgbb3TH8D+zFROoP1HEPJcEpoSjbf4L7AR64K413V0TcQ0aYmP0vxbhreNpfOtNC6wYshK7x/Y6xQRWuc6MSlSrUvq/d4esmEjTxvZE6GOtnUzt5pFcy4BT7YCJ2vtNwLOsjdrOlC7ERkvooSUq9U0L6Pgsg0300d6Ty8bYektOK3q38yOcOVXx9dvrw676jWk9sivSGqsltFhrpSZ2DbolBvNlQ11xLwz37Vh7GR7C3KrmYlAhtMIgZi0iXrL3gmyaATFo0o0+cZEgl2VUKwAHgcJCQQ/QsT4+39j5QQl2jPnITzIXxj20CuVI8sgv2HS6vzSETKkPGk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(356005)(316002)(8676002)(82310400005)(41300700001)(6916009)(4326008)(70206006)(70586007)(81166007)(5660300002)(7416002)(54906003)(8936002)(82740400003)(478600001)(86362001)(2906002)(7696005)(36860700001)(40460700003)(47076005)(40480700001)(26005)(6666004)(1076003)(186003)(83380400001)(36756003)(426003)(336012)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 07:14:12.9685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ad219c-428a-4a8b-7080-08db3413070e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move get_chip_info callback to the start of API.
This should be first check in probe() call.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index d5ccd4d09278..e8fe324c23d0 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -470,6 +470,11 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	unsigned int addr;
 	int ret;
 
+	chip = get_chip_info(sdev->pdata);
+	if (!chip) {
+		dev_err(sdev->dev, "no such device supported, chip id:%x\n", pci->device);
+		return -EIO;
+	}
 	adata = devm_kzalloc(sdev->dev, sizeof(struct acp_dev_data),
 			     GFP_KERNEL);
 	if (!adata)
@@ -486,13 +491,6 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	pci_set_master(pci);
 
 	sdev->pdata->hw_pdata = adata;
-
-	chip = get_chip_info(sdev->pdata);
-	if (!chip) {
-		dev_err(sdev->dev, "no such device supported, chip id:%x\n", pci->device);
-		return -EIO;
-	}
-
 	adata->smn_dev = pci_get_device(PCI_VENDOR_ID_AMD, chip->host_bridge_id, NULL);
 	if (!adata->smn_dev) {
 		dev_err(sdev->dev, "Failed to get host bridge device\n");
-- 
2.34.1

