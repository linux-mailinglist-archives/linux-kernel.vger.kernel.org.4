Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E8D74357F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjF3HG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjF3HGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:06:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC76810F8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 00:06:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LD3pKCQ/WeU+gzlmF+5kshEqWiGUqjxtcNOjGm6PjM4ofTA5tAGBHUpCv2SfxyKO8FfjPDpzPAAgbQ6euJz7fgsujLGhv5EH/uMEKNPxnei4jtVbJ3tiUYSPFQ4jVDvHquXsUjDeZzFaPkiIeAs2u1/TkRQPCusNmkpBifC7pXbQIpHb6nmBHy9pDVw/4Whqe035JJ4MHOSC0TsmdC4fQCTo7cWiO4yR/jLC9VOfvyVQ6OGRNccrpU9F90O9Lqly3QBDQRfVE4XewlG6DTkk3U7i5mZKKJVwQTMImSEHX7AUBimAoh6O/RcgTJJNmwoPzHfPXtIGm6y4G0KMTnkskA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiSTON/LT+DJq1L7PPgM6zWQ7KjeH+GUxRBrqrMWSBc=;
 b=iykWnc0ME487npvQEAhO7xhNpTyLRK5frNVgANr1frC14OWDVMem0tDbCaEYjHBKBrnOv308WCpXWbGl0xlybT62z+Bj6qjSXxtYd/sSMAEFfoxXbB3v9mclYqgwdAM7YcU/IwWKAjZhjCG407pCSS0dKHBjkthIjvptIMqaUuBOxJxvLsDs8ADQauE8aZ3Dww9TF5GFCnusG0M60t0Ko39+qxGorpOgk1eLXXBV2LXk+pD1GvI9Up7vpxoa4yWcVt+NI+uJ5m5uQr8VJvm58w9hLAsw9Dk4vQPqqZpJ2Xj8EakkcKl4dB5bTG6Z2ZR+zm17BaG5+AmRhVuxnTQHwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiSTON/LT+DJq1L7PPgM6zWQ7KjeH+GUxRBrqrMWSBc=;
 b=ipWqNu6joHcad/OJbM9rAVeOatnNZReJxRCo5qYMG5mjmsKtmKQA/XwAKVxtPf3fJAaAEtG2D/VLVw4dqnVsPj6Vh55aTNg4RwHnN7Oh/ZcLOfUA7Lop9cVNf98YjSWHfWR0I7to7OpV7LFkIrxm+id7Zaebm+llFdNFZ+whLec=
Received: from DS7PR03CA0333.namprd03.prod.outlook.com (2603:10b6:8:55::15) by
 CH0PR12MB5220.namprd12.prod.outlook.com (2603:10b6:610:d3::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.19; Fri, 30 Jun 2023 07:06:40 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::f8) by DS7PR03CA0333.outlook.office365.com
 (2603:10b6:8:55::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 07:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.43 via Frontend Transport; Fri, 30 Jun 2023 07:06:40 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 02:06:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 00:06:30 -0700
Received: from mastan.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Fri, 30 Jun 2023 02:06:11 -0500
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
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Paul Olaru <paul.olaru@nxp.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: SOF: amd: refactor PSP smn_read
Date:   Fri, 30 Jun 2023 12:35:43 +0530
Message-ID: <20230630070544.2167421-2-Mastan.Katragadda@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630070544.2167421-1-Mastan.Katragadda@amd.com>
References: <20230630070544.2167421-1-Mastan.Katragadda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|CH0PR12MB5220:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7a888b-5bc1-474e-fe32-08db79388dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yy7RcAj458X943fDZX5mUkOrouqo6I10snrb9uar+fY+UODQywOzaFtlspO+uIBV3+ZqGh7H1a02Hr8kIKVLEoZjs9fGlHwaUu4ZXGWr1VNIk8s96Z5rSXicrGaw0Z54JzNHevujB1XLT+6Xqn1b5F14IaXKLsTCpTpGd9QGJY3AD05Mv0St1f7unEQWaxc4W6WWylXbmafrgLkUweI5Xlc5dgo6kp1vH8qVghSP1dVutTWRn2Laqoej55gaNB+s4J78Str6lPehC+/Y8ZHR65nwddOhX1PDQE+lQtmXnvIzhcOIPqHLVmMQZBwD4yqqfPZwpdW169eEG3LfN7C5TD/yiTnGGmbqLEfGVO0xb02VuVusv7T3qxS02Zz4Hdi/MsyjqT8IPEDK6VqLMGrA2tlNvQyrckw2X2TnPMn4vPP3ag82+MUV/ztD46p5zBIplQWuxP04HqUB+yBUPLvGLQ2+Rb5RikAYtJqa7gNSOcz+uyJs1iJkwmaTE37L1Xb1r43r3fMwV8XsXOr+BnJQ3uXNd+MQO0lW0GafFIR5ILeTt36zYyQbdOHYHOyvGpJRtwIaltS4VFAcZp/QLCSxU9ONLaOpEBDkKafLpUdaAswWPydB/CPot7+c0aWpzkISAjm6JfQI/o9JzNdI7LLSb87NqON/5xkYJ71bhox+LFJT6pMcn1AGTSSbT7IunOa+GytXECCLy0BTC5bgnhp5QFT2I/C04rJwUAda9OM4DvIwvWHfIs3ui30MfS5Q/q3HRMQGazkO9nS6r1M1mwoelA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(86362001)(54906003)(8936002)(8676002)(5660300002)(82310400005)(7416002)(26005)(1076003)(7696005)(478600001)(6916009)(4326008)(70206006)(70586007)(41300700001)(316002)(6666004)(186003)(2616005)(2906002)(47076005)(40460700003)(83380400001)(336012)(426003)(36860700001)(40480700001)(36756003)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 07:06:40.5666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7a888b-5bc1-474e-fe32-08db79388dbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5220
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

Use the read_poll_timeout marco for PSP smn_read calls.

Signed-off-by: Mastan Katragadda <Mastan.Katragadda@amd.com>
---
 sound/soc/sof/amd/acp.c | 34 +++++++++++++++-------------------
 sound/soc/sof/amd/acp.h |  4 ++--
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index afb505461ea1..c450931ae77e 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -28,12 +28,14 @@ static int smn_write(struct pci_dev *dev, u32 smn_addr, u32 data)
 	return 0;
 }
 
-static int smn_read(struct pci_dev *dev, u32 smn_addr, u32 *data)
+static int smn_read(struct pci_dev *dev, u32 smn_addr)
 {
+	u32 data = 0;
+
 	pci_write_config_dword(dev, 0x60, smn_addr);
-	pci_read_config_dword(dev, 0x64, data);
+	pci_read_config_dword(dev, 0x64, &data);
 
-	return 0;
+	return data;
 }
 
 static void init_dma_descriptor(struct acp_dev_data *adata)
@@ -150,15 +152,13 @@ int configure_and_run_dma(struct acp_dev_data *adata, unsigned int src_addr,
 static int psp_mbox_ready(struct acp_dev_data *adata, bool ack)
 {
 	struct snd_sof_dev *sdev = adata->dev;
-	int timeout;
+	int ret;
 	u32 data;
 
-	for (timeout = ACP_PSP_TIMEOUT_COUNTER; timeout > 0; timeout--) {
-		msleep(20);
-		smn_read(adata->smn_dev, MP0_C2PMSG_114_REG, &data);
-		if (data & MBOX_READY_MASK)
-			return 0;
-	}
+	ret = read_poll_timeout(smn_read, data, data & MBOX_READY_MASK, MBOX_DELAY_US,
+				ACP_PSP_TIMEOUT_US, false, adata->smn_dev, MP0_C2PMSG_114_REG);
+	if (!ret)
+		return 0;
 
 	dev_err(sdev->dev, "PSP error status %x\n", data & MBOX_STATUS_MASK);
 
@@ -177,23 +177,19 @@ static int psp_mbox_ready(struct acp_dev_data *adata, bool ack)
 static int psp_send_cmd(struct acp_dev_data *adata, int cmd)
 {
 	struct snd_sof_dev *sdev = adata->dev;
-	int ret, timeout;
+	int ret;
 	u32 data;
 
 	if (!cmd)
 		return -EINVAL;
 
 	/* Get a non-zero Doorbell value from PSP */
-	for (timeout = ACP_PSP_TIMEOUT_COUNTER; timeout > 0; timeout--) {
-		msleep(MBOX_DELAY);
-		smn_read(adata->smn_dev, MP0_C2PMSG_73_REG, &data);
-		if (data)
-			break;
-	}
+	ret = read_poll_timeout(smn_read, data, data, MBOX_DELAY_US, ACP_PSP_TIMEOUT_US, false,
+				adata->smn_dev, MP0_C2PMSG_73_REG);
 
-	if (!timeout) {
+	if (ret) {
 		dev_err(sdev->dev, "Failed to get Doorbell from MBOX %x\n", MP0_C2PMSG_73_REG);
-		return -EINVAL;
+		return ret;
 	}
 
 	/* Check if PSP is ready for new command */
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index dc624f727aa3..c3659dbc3745 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -61,12 +61,12 @@
 #define HOST_BRIDGE_CZN				0x1630
 #define HOST_BRIDGE_RMB				0x14B5
 #define ACP_SHA_STAT				0x8000
-#define ACP_PSP_TIMEOUT_COUNTER			5
+#define ACP_PSP_TIMEOUT_US			1000000
 #define ACP_EXT_INTR_ERROR_STAT			0x20000000
 #define MP0_C2PMSG_114_REG			0x3810AC8
 #define MP0_C2PMSG_73_REG			0x3810A24
 #define MBOX_ACP_SHA_DMA_COMMAND		0x70000
-#define MBOX_DELAY				1000
+#define MBOX_DELAY_US				1000
 #define MBOX_READY_MASK				0x80000000
 #define MBOX_STATUS_MASK			0xFFFF
 
-- 
2.25.1

