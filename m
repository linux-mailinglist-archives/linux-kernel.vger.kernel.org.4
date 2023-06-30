Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA30E74357E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjF3HGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjF3HGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:06:17 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB0A199
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 00:06:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWxPHAWUgCQJrzeATPosgkAsea2HnM3t+T/T7WGQuOFGWU5BN6O59MU908/ygMKJpPMaYkhkk6lrTGQmFNyblxQ8EouJwJqKBmXzg/a0OzltqXiWwRDwEFcqMm5e3bPoTvVlfc3BIttoKivjERYXSzmczzpdsCGcOJAkikykp2+K39Bn2hdBUFSbIsSq8SRYXaw8TcoH80k8MiagmPxlOOcPOmn+sqtiIwLeP/7PmzyJc6XnB+m9TEQVrAcLhwFwXQkJ0+eya36ikEkvRsM9DixGsF+Mi7+K1IhVyfjUFcJeVblAnqqpqjD5+Gt+rooNw5XkCYxOFnsS6NXHCy/cWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuFMKD7yIcNFzIGWp009gnyt/GUGBjoGMbbqB9G1aOI=;
 b=kHD7kGA5awsvpE2ZKJqaLkVC4Ya2Yx8uZDXqIOWeYpQxT0Z05OGk3yr2tP2+j5ud3mn5DXJa6pCekLVBekZ+kkdM9TZoAXify7Q71IOroaeo7vK2f6f611jDwpQTlkhzocBgRBzm27QUHlkQx19629LsHwC4KeTaWg1FqhYiduruUKiSqmtJQ+edeeK9N6c/a2KafOEtD/y24hn0GzEPcD+FuWHn9hGBrXtg7P/KABzYh2R4fm8G7KipR6KZ3TL31KQuOXoln/Ngl4M/gac99ebs1DQJ3CQgPtHL9v+irLtp287tCx+FBHEPHjqYwtAGl1z/f2D01bDnzxVSgfkgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuFMKD7yIcNFzIGWp009gnyt/GUGBjoGMbbqB9G1aOI=;
 b=MjYOBpjW+A/sdudUI0uc9iWboCPen1kznuRkJZ2C5J5FAvHaNHN+Wi0h6G6JetFdjdF/5gUcPJdl53rjUjW2bG7jT0axnhPPXUMVyOujQBvZ6mJXQnGtYcwX1ri29vlwRySqAb473Rrm2oXM0iDOyL+dy8j5oN/nKmiLHqid1Qs=
Received: from MW4PR04CA0250.namprd04.prod.outlook.com (2603:10b6:303:88::15)
 by MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 07:06:11 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::f3) by MW4PR04CA0250.outlook.office365.com
 (2603:10b6:303:88::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 07:06:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 07:06:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 02:06:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 02:06:09 -0500
Received: from mastan.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Fri, 30 Jun 2023 02:05:52 -0500
From:   Mastan Katragadda <Mastan.Katragadda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <vijendar.mukunda@amd.com>,
        <Arungopal.kondaveeti@amd.com>, <vsujithkumar.reddy@amd.com>,
        <venkataprasad.potturu@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: SOF: amd: add revision check for sending sha dma completion command
Date:   Fri, 30 Jun 2023 12:35:42 +0530
Message-ID: <20230630070544.2167421-1-Mastan.Katragadda@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: f2beed3f-26dd-4677-65cf-08db79387c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: poyV4lC/z4tJ/Rz87ImdvaWDJeW8MtFRQVGLz/5mHjI172rILDRCJCUuK2cUq24LW9LIb/cSbbrBZMdmV2csmuEs9TVFJXjg1r+vVWQCsKZMHALWMJZNozlMsQ2HSAaFtY4KgbVYzX/kS4DTdxLAm2XlFKFN8RALlRsoxwTv6fCBJ6mosyYGo8n3c+3Uv7KjCihyYOp3lMmXPl8G0U5xeBQKXbDljIEGMDvsmlgOOoVQdXF9idK+8GCeIOw/0acnA67Evdmji9iVXosHtKtobetNSWm26jMCqAcnnfwj29kNaSmosIWfGAyabfugi6wFp1le2AxzXfzFMP1j9TE4jKRBmyNf7F2kxwD8yiz5XKfvsb7DrqleWjN3OuKYCGsu4geyxMPWnAB6rkZ0GvF6lbHjKr6xWSlyQf3+Uf2LmfPUyMzkoz21cEGgbC7ce4mcQ/NkuYSIKcL6TUpPYVTMCPx5tII/vvkX7XtIobPokCitD+kw0DFci35pyk1HTj//Qon0K9lhbJa7IliTZjIvQK6hgw9mGIJx0SzytGIbP2+0F4bOsVB8TIRRYEuYdxTmCzV6DroRPa83BRGfRq0SWmvsqWeRFdqjE9Dtv+CWCyfH9T4NBCwwqQHjXk8QiKIlzZGQQzSbbxDxmnRcITdAG2QoA2EwvaR6DD3CEj9lLK1XFhllqZG+K1q2Bbq7zoEa4+V4o5Fq+E6+4zyJdNiTDUAQ+FHRd9+wz20XFgfHxNBjs4dgQUvczvcxMRLVws78rs1F6+eg2CvtlIepBrvVIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(83380400001)(7696005)(6666004)(54906003)(478600001)(70586007)(1076003)(2906002)(81166007)(186003)(26005)(82310400005)(316002)(41300700001)(70206006)(7416002)(5660300002)(8676002)(356005)(6916009)(8936002)(36756003)(4326008)(86362001)(82740400003)(336012)(2616005)(40480700001)(47076005)(36860700001)(40460700003)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 07:06:10.7549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2beed3f-26dd-4677-65cf-08db79387c08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238
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

ACP driver should send SHA DMA completion command to PSP module for RN
platform only.
Add a revision check for RN platform.

Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
---
 sound/soc/sof/amd/acp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 2ae76bcd3590..afb505461ea1 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -217,6 +217,7 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 			      unsigned int image_length)
 {
 	struct snd_sof_dev *sdev = adata->dev;
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	unsigned int tx_count, fw_qualifier, val;
 	int ret;
 
@@ -251,9 +252,12 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 		return ret;
 	}
 
-	ret = psp_send_cmd(adata, MBOX_ACP_SHA_DMA_COMMAND);
-	if (ret)
-		return ret;
+	/* psp_send_cmd only required for renoir platform (rev - 3) */
+	if (desc->rev == 3) {
+		ret = psp_send_cmd(adata, MBOX_ACP_SHA_DMA_COMMAND);
+		if (ret)
+			return ret;
+	}
 
 	ret = snd_sof_dsp_read_poll_timeout(sdev, ACP_DSP_BAR, ACP_SHA_DSP_FW_QUALIFIER,
 					    fw_qualifier, fw_qualifier & DSP_FW_RUN_ENABLE,
-- 
2.25.1

