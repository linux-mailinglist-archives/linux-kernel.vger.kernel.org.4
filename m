Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2B272371D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjFFGE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjFFGD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:03:59 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EA3E54
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjN7sETqQjN+0Tk5cIqWoYkN9Qr6IIKrvc245AfYHCzGxTTtyVqQbV2ym9THrAYvaoUrYJsCNIARtwoGYA2S1Ovh30CJakYmqwD/8eqnVf1SZLrIlvOkhxYrq5gLhr8tbGqvGB7jKueWt7eWTWR93geNLSciqDyZfxbGSZAKALVhQZWp0KXBzrJ31Ztjktevw5+ueUsQlApb8eEGcgok56MfL3y84XvDjCKmgCboeWv7qTRPURA9JLjYlHPYD2K1UtE4zVZPBAcPuO8aeWX4mzpj23UEzNBHp0els+DXqxTIGaDNWcmlNP/yrK3uVaVs9voWYUTtOWpSqbXwhF2sEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfBlY1Gx+MjR87EMVid2SbT2roCNykSYFrwd1Z3V1AA=;
 b=mAmwTGxEhXqumVdDQXX597RXgQMFqJYxOM8CyWNpBaRc7wa6QKYgJu6uDozMQRUUH1eXx/+rRIMMd/V55VjA/1CPLytcyyfQ4nrUB8Ex4ZzB0Po8gVXNL91gkkeAZzbeGvvQ+bXsD6qa3UuTruw5z1rDlFNZZeHgtpUW6tkBCx2i1jYQ+gHX3hFNi6+R6aGyVgbKcl2xk+B/R+nJp96luS93QL1i8n8jZh+Cdc3qYSs6r0VNUw38z8mzX5BSCqGbvhBGOnaQ8V1i5U0nByWux5wTkylxAJ2KW1xDkWn0JK7kpmIzfIMl+dgORIO8SZ9K4VDJalgpZ2vZHFvlBW9kGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfBlY1Gx+MjR87EMVid2SbT2roCNykSYFrwd1Z3V1AA=;
 b=TIFCs7zuckXPGqD451Lg1zfZ87krZIVLpBm9iw78V3TopB87gQSiQw219ot1IZtlNjjHExkMd80P6rWzT1D5Y0uwkMhfi94ZNMrBwZu6Mjklr4ZPVQvIJ+2UvGAoQSh+001El5nLMrKRDBlbASomDiJcMtKb6szbb6/m252f8tg=
Received: from DM6PR04CA0001.namprd04.prod.outlook.com (2603:10b6:5:334::6) by
 SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:03:50 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::ed) by DM6PR04CA0001.outlook.office365.com
 (2603:10b6:5:334::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 06:03:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Tue, 6 Jun 2023 06:03:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 01:03:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 01:03:39 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 6 Jun 2023 01:03:35 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        <mario.limonciello@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 9/9] ASoC: amd: ps: Add SoundWire specific checks in pci driver in pm ops.
Date:   Tue, 6 Jun 2023 11:37:24 +0530
Message-ID: <20230606060724.2038680-10-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
References: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 7404d5a3-6691-4510-13f0-08db6653cc9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsmXgiOv1/w6QTgq5d3MtLHeo5xa/xGAViZWugJS+w9fG4QU/l870wUwj3Ce0MtkeMllwBQ1WnA1ihbkeTSI06AAUrvjjRjWc+3DDOXsyhepbREdz7QReES2AOe3y4ATgccYc8pncMuS1IT8iw7zUFFtROeQ0/dMyWO5vEitMOwB4V9d75J68IM9wcVeUU4ToRgQ8x7fU2VbJe+9HjQaSNIylK1UQ6XrH0aM9qSVyP8jADdw8bBX1Ls9hAZlZVddqVK+Bv5WPlNREkr7wavL4sZTKhZciySIx+53q8IwxknZA6C4Gz4+JxNCsJ/ZldE+v3iiHUlwpg6SCP3w5AEkCqZUGuHnnHBzZFEs0IFSPoiFE6aA9cdu1Yk8al33cWJFLPkb3ifxQ29pFa7vWDG54IhUX88JzAY8o7rTjNEAudwGhOVTL7O6FFUllC4/2VZtJZal0kRNVhORhEdVgqa8fCS31RHAeG+0c6DMQVkSY3GpmkocIXMaCdWpbm+qjokMMoCT69HALojqLWHCIEm6V4k2hgt99pNBQhtH8s2fkjvFNkvcYrYSst35kQC0TzkCie4X720LiSBTnOBYK7udyxM2g7Xmlo57QqRC3jXtQ4Vplg7RzEE/SNViRmmPGrLot2oHfJw2hZz03odwzKZ95Nt2NmUsV1Omq/T+24Tsm1Nvwrwuku/xBHKFowNIgiw+lGilmRflP1dAc/zTc/JcGW67Sq0Qgo3IGnMyy8XWWevFG2CAXIzVrCubzvFOPZquscuthTYvDIIaWNLs51kwGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(41300700001)(316002)(54906003)(81166007)(356005)(82740400003)(5660300002)(8676002)(2906002)(70586007)(6916009)(70206006)(4326008)(8936002)(478600001)(6666004)(40460700003)(82310400005)(7696005)(86362001)(186003)(2616005)(36756003)(426003)(336012)(36860700001)(40480700001)(1076003)(26005)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:03:50.3284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7404d5a3-6691-4510-13f0-08db6653cc9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD SoundWire manager supports different power modes.
In case of SoundWire Power off Mode, ACP pci parent driver
should invoke acp de-init and init sequence during suspend/resume
callbacks.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/pci-ps.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index daf54fe9cafd..5802a701b3b1 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -662,10 +662,15 @@ static int snd_acp63_probe(struct pci_dev *pci,
 static int __maybe_unused snd_acp63_suspend(struct device *dev)
 {
 	struct acp63_dev_data *adata;
-	int ret;
+	int ret = 0;
 
 	adata = dev_get_drvdata(dev);
-	ret = acp63_deinit(adata->acp63_base, dev);
+	if (adata->pdev_mask & ACP63_SDW_DEV_MASK) {
+		if (adata->acp_reset)
+			ret = acp63_deinit(adata->acp63_base, dev);
+	} else {
+		ret = acp63_deinit(adata->acp63_base, dev);
+	}
 	if (ret)
 		dev_err(dev, "ACP de-init failed\n");
 	return ret;
@@ -674,10 +679,15 @@ static int __maybe_unused snd_acp63_suspend(struct device *dev)
 static int __maybe_unused snd_acp63_resume(struct device *dev)
 {
 	struct acp63_dev_data *adata;
-	int ret;
+	int ret = 0;
 
 	adata = dev_get_drvdata(dev);
-	ret = acp63_init(adata->acp63_base, dev);
+	if (adata->pdev_mask & ACP63_SDW_DEV_MASK) {
+		if (adata->acp_reset)
+			ret = acp63_init(adata->acp63_base, dev);
+	} else {
+		ret = acp63_init(adata->acp63_base, dev);
+	}
 	if (ret)
 		dev_err(dev, "ACP init failed\n");
 	return ret;
-- 
2.34.1

