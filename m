Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046D96175B7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKCEjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiKCEjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:39:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E8017435;
        Wed,  2 Nov 2022 21:39:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aq+s+WYgXuWGQ8eAxQQubO+o3k/lUrRz3a1yBLsMehhHJkihXwyLX+8qw7uiLDjph7oTtZLYmnUQ6/bT+pGi9MnSOcjzIHvar8PB5YuAv8w+xGJu2XvVG8R2koD65ReoOJi9F5is/O1jsV0X2ZGrWAc84iF1XF10OjQtnzsHR6o555HqO6bduneRgmzSbESC0QPqES3SCXqjI72WjSwMbnQjHl9lc2BKXy2fFhDTm2MIrYtTnHD5fktJ09EpWx3FDmGoWHPzgKlridevFCFsGQSEdSfJjlWQoWs/HMTl6R4S3KQy0X6nJhP3uNmFzqBpcxqTf8BwJdhh27QSwt0r1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4RZIQ1Di7dneZqytQHdUTk6Ta6ap9bGCfe5EgqxPxI=;
 b=hIfYHrnjmF+aAWU9688tYHlFqHqJwy1B0iZg1Y60im/Z2C/lU0ipBLTJisvcGIMHi5c7mjG8hw9qYY5JrSZGYchh9ADspHNWQJ8O3IJSSJ2PlHGQuf4Ug0H0FMLkcz+rXaSL0QYzicXZX5/fhbDq7WINf63Z2wUQlgFPslRbWs8BVxL0cCQagSJ1iLeQu3KtJTLXN+JlGhdxGaTxrp4wiaDs9V2dGr8e7xfbal78sb75X+Z/NjZGYoRV4ukiWGAHeA78q1f39lPHlkp9PPr8Hw4DHunvd2xoSuBylOULdFRM3KyXJiJnep23jY0eOoYxjqLAbEFla6X3DX9nzylaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4RZIQ1Di7dneZqytQHdUTk6Ta6ap9bGCfe5EgqxPxI=;
 b=hukOlJncMJL0LYaSmZVTQz5sjq2Egwpq1/3hGPStbCHcYu+NMeTGx4So8rZFjjlWqGYrU4OcRzvTML3BEvDydc0FZc7PZ8Ah2RW0jxmTBN/eWHRe33L0gxJm/KR4nfvQhxbg/70qsF1VSv7GW2bWpzFc7+/rNUlTLhpa58AbPIfQYX4SFbC6WEn6xpkSMSmnsi4FsxOaa5vjroWXJbLhW4yKPgXlAqUmxuE7fcjJ5BSjaCD+mLBqVDe7+Qr3mMRqcpnLTq3k3LW6Cq3eaSc7B1u+56cV3HcweJFCN4OwlRarhUqcMj2PA5j97MmKpsxeca0T1vSPKMHsCMvIHHOr6Q==
Received: from BN9PR03CA0395.namprd03.prod.outlook.com (2603:10b6:408:111::10)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Thu, 3 Nov
 2022 04:39:37 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::24) by BN9PR03CA0395.outlook.office365.com
 (2603:10b6:408:111::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Thu, 3 Nov 2022 04:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 04:39:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 2 Nov 2022
 21:39:23 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 2 Nov 2022 21:39:19 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 2 Nov 2022 21:39:14 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <joro@8bytes.org>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <will@kernel.org>, <iommu@lists.linux.dev>, <robin.murphy@arm.com>,
        <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v10 4/4] mmc: sdhci-tegra: Issue CMD and DAT resets together
Date:   Thu, 3 Nov 2022 10:08:52 +0530
Message-ID: <20221103043852.24718-4-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221103043852.24718-1-pshete@nvidia.com>
References: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
 <20221103043852.24718-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT057:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 145f2f1d-eb54-46f6-7234-08dabd5569a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L0JnOLDUlALpyaJKgaBReVaQ1VHMFEy5WvspdC+OUVKkD6xU3RfgFT7fs6rCSbIRvl0ZcVZyVnoMnF7UI3tZEoLzKbcDDxlhDA7ZMxh73Plsg50jfuZ+6v4x0Y4mLeJzUZug4fk2EDtGQI0yTCbS70vDRVv/nB3FOUb2o3xFYcVOO10klmen0CMnOZAfr3/6NPrZP3Eu4awZxscXHd8/BU5sAPoCHvqrraPe9tArVIFer/rKMAWhaVxRN+taeMTybSlkH92xtnnHKy1fhY7e6fsP1bg+vJXRyygoAnXTLEMDcgKKYF1JMEXAKkB/nUVwlF+zyYHBP/JhkVOOe2t2bxm8e0noD4sKnvV8pW0X0qjqKzJlP+iCXz5B766r37kFl4W9CtE0w3FZuBWako5yLtI+Pr1ixiIb1gE5CL60mN4D6vq1rVrQ89jRARuajAkO/f/OgRy0uaW2pv0A0xEbsZlOaJTu38rYYEU1LWiyT3epDO9sjfqYXGaBkE4vkkBMB0iSh/d4VyX2Yd+zBA/msH5lflqcwlFoJs+qsQ1hSq9erW9hfzssu5SP+iC7YB8EAa4EcpsyEK5FvysbF3ZKoWkJn3alDTgoS93yekzafA/TKDDIE50YGOv92GTu5A8QD6kVrj9GtSgn/dYlCGyrPztMWHez0OLeLaBWmYTJQLH6avW/zZQ6g6r8DDP3zDlnvYcpflUR+D+bQBBlcN3YP7cJiaPPfo6T7FGYGiIUdS32VoaM2ac/dLrN9gGjlE/qcDqJDFVFKQmYCoblRjUPkQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(26005)(186003)(86362001)(4326008)(70206006)(316002)(8676002)(82310400005)(8936002)(70586007)(478600001)(41300700001)(110136005)(54906003)(40480700001)(7636003)(356005)(6666004)(36860700001)(82740400003)(7696005)(83380400001)(40460700003)(107886003)(2616005)(426003)(47076005)(336012)(2906002)(1076003)(36756003)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 04:39:36.6726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 145f2f1d-eb54-46f6-7234-08dabd5569a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error condition to avoid system crash
Tegra SDMMC controller requires CMD and DAT resets
issued together. SDHCI controller FSM goes into
bad state due to rapid SD card hot-plug event.
Issuing reset on the CMD FSM before DATA FSM results
in kernel panic, hence add support to issue CMD and
DAT resets together.
This is applicable to Tegra186 and later chips.

Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 3 ++-
 drivers/mmc/host/sdhci.c       | 5 +++++
 drivers/mmc/host/sdhci.h       | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index e44060cceb68..7cb3bf34a176 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1531,7 +1531,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
 	.ops  = &tegra186_sdhci_ops,
 };
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2b5dda521b0e..8512a69f1aae 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -270,6 +270,11 @@ enum sdhci_reset_reason {
 
 static void sdhci_reset_for_reason(struct sdhci_host *host, enum sdhci_reset_reason reason)
 {
+	if (host->quirks2 &
+		SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER) {
+		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+		return;
+	}
 	switch (reason) {
 	case SDHCI_RESET_FOR_INIT:
 		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d750c464bd1e..6a5766774b05 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -478,6 +478,8 @@ struct sdhci_host {
  * block count.
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+/* Issue CMD and DATA reset together */
+#define SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER	(1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.17.1

