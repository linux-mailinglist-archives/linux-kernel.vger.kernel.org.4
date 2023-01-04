Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF0365CCAA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 06:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjADFwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 00:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjADFwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 00:52:20 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7713313DE2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 21:52:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxumAnIDMolj4nNZNrBGl/ZdKJBZ729ufL2PUkvLaYoxnByS6Dcpx1swXz+9wKX1ezX2326ZBHLnvZmNmW/HuNdo+OWr1bP1hlOeZnxk/OOrIlXIgenqZfHEC4iUj9PCQV6bYWBK6nje64KrZdv00yq0GoMA+MvQUY8e5J00MZaeYQfFHXnZ6Q3tEbZQnHvOa953Lrf1YHLIZDuIlln2DZBTyU0nTwTm+J/kOq7bXXxGoOkV3U1B0gjkAoSw5NkMGIAHIbvtXjtlReK1FVrVFpEG1N1FSPHSr1b40F0I5/87VBvwutnuJiabtKs98XDULgMQhC7+5FjFsuv1+b8wlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W063qyT5V4Lac7vqpCyndCjRw7AfdNFpX6Aiz4Z+UKc=;
 b=AeV68j6Haxv/239InPTvS5L1sd5cf+7jpBq2Dgg4Eg2KYzB1Gp3UNi9cbvaN3D0Y1kY29NBGqTTFv3oizh5NzD9erGPUAWMRmvke5+DksvPoyAqLB+WmkNtiNIkH+rFrCrHRKDpV0obO0RGDF2QxY1E0H5rr75h/rxm/uNaBqagFtOfF/QEGNn6b4JtgQH++JPU0OKZV257VEIn06LB3Prr6ioG9zTGQngBCKjLHA3tRTZfw0UAF1uXVP7DeorqYnxWq99B5bsccCpkWntWfn3J8af2RzhFADaKh2+4ftWr0pIeWO91PVl97CIvW0tnHTzj2SVOJQapYAlURJQl9aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W063qyT5V4Lac7vqpCyndCjRw7AfdNFpX6Aiz4Z+UKc=;
 b=eXdfy0OW+lVUTTVo6eghq9bBtC7jR5ZPtxuMS4MJGCOm32D7i/s4rdygnaEiPI5yiNwrupj3OlZ7kAQtcjpiNa276Lr+jBxhFXBXGsxTEky+SXvPU+EJpNNaAOUfXWI1ZcrAAuuBMksEZsRAjraa6xNynkAFKqgeIbJ99o/MJ0s=
Received: from BL0PR01CA0007.prod.exchangelabs.com (2603:10b6:208:71::20) by
 SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 05:52:16 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:208:71:cafe::49) by BL0PR01CA0007.outlook.office365.com
 (2603:10b6:208:71::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Wed, 4 Jan 2023 05:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.10 via Frontend Transport; Wed, 4 Jan 2023 05:52:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 23:52:15 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 3 Jan 2023 23:52:06 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <syed.sabakareem@amd.com>
CC:     <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <basavaraj.hiregoudar@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] ASoC: amd: ps: add mutex lock for accessing common registers
Date:   Wed, 4 Jan 2023 11:24:29 +0530
Message-ID: <20230104055435.321327-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: dec19e1e-11a8-4b6e-8619-08daee17d56e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ip8WcKmjJnwLGrMXWuNOtjBZCHdc0e2KHxEsHViP2rhS5FUzENM0EW7f+gE2F0Zrb9jwPu2VWmeTfkV3mXxdhoRuLJxdMP1ympAVq2Ei11GbUYYGjZ/1SkQ1l4fnExQGIwiHisG8qxGEb8ExeWlFLpvPg+ktNsA3b+8mycX9VSl9uIxNINvHvNOXNH1aDxcJe4cbbcD+deVGB9VqvYQF4NmAVPyZoLIcSZ9sOMgNZdu63y/X4ragF1M8apLcvF+lC0t82L+Qyl08aetJvQJitcJtcFOl9neAT8zMwIeiX1Bry46gga2HhHjayKskUWB8mdmoBDtOJ3KuSyO8wYyozZpXOhMtrxxkECaNNZ79Pj1T8xJDa7qx1v6TbV7XXMNkgEI00JRHwF0U2cJ3PKJFQBoaXWmNvw8Nj9e1CuhxwiL56avkPKpOdkVJfCqLfexUpoFqTnQg10fFMe0a9x08cqm2kFV40D0+ZxEzNRuRz6z243wTOwBgVyPGZ6oQJpteoSPalojQ6vmAvZjtXL3G88KEPD09Y/U3U1t+410z0UKkynnq7/cFM2idJk2OqPUE7kamI6b1d5TzO6mjFi0wMn56k0kMJlF03BWw1uug7igMnPZhq6jI7nwt/4cki70Y378FaUdtRaYgNSqjA3F7nW+c4yBSxAPeEF+zRD7nRt4sanuuuO0DHfTWoYlltqA6sqQe6Xq2Ah8Qg3uMty6sSQrbdQ0ZKUfpAsroenB5Teg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(82740400003)(110136005)(36860700001)(478600001)(40480700001)(40460700003)(5660300002)(36756003)(2616005)(1076003)(8936002)(7696005)(47076005)(4326008)(70206006)(70586007)(41300700001)(8676002)(356005)(426003)(316002)(81166007)(6666004)(26005)(82310400005)(83380400001)(336012)(86362001)(6636002)(54906003)(186003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 05:52:15.8326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dec19e1e-11a8-4b6e-8619-08daee17d56e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mutex lock for accessing ACP common registers across different
modules.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h  | 1 +
 sound/soc/amd/ps/pci-ps.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 8f024cb309c9..47854280dd4b 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -106,6 +106,7 @@ struct acp63_dev_data {
 	struct resource *res;
 	bool acp63_audio_mode;
 	struct platform_device *pdev[ACP63_DEVS];
+	struct mutex acp_lock; /* protect shared registers */
 	u16 pdev_mask;
 	u16 pdev_count;
 	u16 pdm_dev_index;
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 401cfd0036be..6335595ec5b9 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -209,7 +209,8 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
 	case ACP63_PDM_DEV_MASK:
 		adata->pdm_dev_index  = 0;
 		acp63_fill_platform_dev_info(&pdevinfo[0], parent, NULL, "acp_ps_pdm_dma",
-					     0, adata->res, 1, NULL, 0);
+					     0, adata->res, 1, &adata->acp_lock,
+					     sizeof(adata->acp_lock));
 		acp63_fill_platform_dev_info(&pdevinfo[1], parent, NULL, "dmic-codec",
 					     0, NULL, 0, NULL, 0);
 		acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "acp_ps_mach",
@@ -283,6 +284,7 @@ static int snd_acp63_probe(struct pci_dev *pci,
 	}
 	pci_set_master(pci);
 	pci_set_drvdata(pci, adata);
+	mutex_init(&adata->acp_lock);
 	ret = acp63_init(adata->acp63_base, &pci->dev);
 	if (ret)
 		goto release_regions;
-- 
2.34.1

