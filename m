Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F5F5EBF4F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiI0KKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiI0KKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:10:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F039F768;
        Tue, 27 Sep 2022 03:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRj0oJUw6FgpjYEgPfRQL+fzeVtHMU+acGzNAEAT685jMnUJrKXuV115X+29VuulESlRxmx28ggviSqTRFIoCWivK3OIgeZhrGaTtKONhiJ+KXSoGYwLs68jn+vjxxU4rC8uixSC3PFhUc6XM4ySSMuLhZ7oSgyJq+byQVpjnyHKupM1bDUauJA+snuveyZFQQ4wUeBpAXt/r5a+Wr1GXw0pP179BJ9Ytw5vfU3DY/7Kdhss4oIPAT4Qj9U5HlSmIv40ta5cTldTC33leb8+jivyItgFOSsDdZUFtqz0jWZkbXTDJOVb3ksQ6paCQBCbqRXNBFVjq2LOXMJ7/50gew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrH7mXv8Qhft7UcA4wqYTG7iWuUTiv6yT0sZS4USblM=;
 b=NtUL/Qh9rY2RutNrcikVD/e0W/2l4z0xvvtm9wMB74H8MaHooN9bbG+iIFMjKodZYQFEUoRXRzncnllSk+WVHj7Owi+pNvWpHnJVQJpMf3RQ4vQM54mosxZnGykmNH+KN7XwG9P6EzSYWYMewxSkTcr3i+VUd00tEbT69govj7t7VhG2UPnCOFAF2Gm4pf+zQCJRSF1YgcUFg1TIc/EBbIDcUl14jnqyMFOcSICBNYaHUaOlk5AFQl41vYUuPr5sAT1SbVX3QQCxXEZ4fFfAkeOQykafG7WK45P1oTrMdxuBLnBzK/tISYFVsHkOrAUUYltBs9BrDxJmgEDi5HhnLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrH7mXv8Qhft7UcA4wqYTG7iWuUTiv6yT0sZS4USblM=;
 b=rUG4r9PI7w9zk05dqBhNflg6lPuKGe5+t+5GRrTLDV0VAfSy2ADRk/s3SkGmuPuW15+Gy4QANxcXyWSl9SKIgQWm11swHYb/+yTWQD9GqXAKLRWJOu4PQQhHmK5VOwZnAmkpV9VAMVyOLlgs3c/2l2o4Ea6DxrCs65wRqEuw6wQc35FW/wpeV8LnCcb7cxCfw133UKpho0jjyocNrpm7o5N1aNmv1wAhQYonSSQRPlc/9oFka+tkG/wJcLk7K140OdudRtu5DM42PMptaX9+dkn15tTgRHpilexQoy0YSxEsOSwAc8sGm5qzqCWFGZ2CBf8P6zFgJk1cI9FGQDtn4g==
Received: from DM6PR06CA0068.namprd06.prod.outlook.com (2603:10b6:5:54::45) by
 BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 10:10:21 +0000
Received: from DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::41) by DM6PR06CA0068.outlook.office365.com
 (2603:10b6:5:54::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 10:10:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT092.mail.protection.outlook.com (10.13.173.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 10:10:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 27 Sep
 2022 03:10:04 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 03:10:04 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 27 Sep 2022 03:10:00 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v4 4/4] mmc: sdhci-tegra: Use actual clock rate for SW tuning correction
Date:   Tue, 27 Sep 2022 15:39:46 +0530
Message-ID: <20220927100946.19482-4-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220927100946.19482-1-pshete@nvidia.com>
References: <91f09a39-57fa-06a9-6e9e-b3e768d9e26a@intel.com>
 <20220927100946.19482-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT092:EE_|BN9PR12MB5367:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b0e0b1-4081-4c16-2901-08daa0707c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KKAcEm6CbfdoXb0mHf+mPyY/pEzxaBemcYspj1xBLnCOiffy7yRoTegF7sU3Qq0DDAJ2spuAAOgwTx/txrTfP70M0AiyRCNIZo2yKrUGua8MuP6hDey1NknhXnJWknDYGXeVSrL3+nL52+EGaL6Um5OWTtVyAeSoNZVOasFV0xMyM4MeMtiZdMY225WuF8sOoBJXzXaX41gdjRZG+CjjsKR017lIGrBcWwgMlHb83ZLzKmmxKF0bJkM99Y81NmaEElY/LCLnDMmzt7JMooMj2qqeoQC98cHnb/Kn4CWI6mDEEDzFKf34XoKbh9vzbUb+AOExqIQlBrZMOpDNdEdvjvfoXLv3nSeizjsJNbEnPRGiOLcwGAuh2a3ZvH1v4HPkvRJA7ij0n7gWY1xOzhu0todEGm2tYoaDeQlxbKVM789qpFnq5M/lvkzAk46UO50hQKKKXUcD8o76QXJs5K9MbQQouXQYHJrFOTse4UNKyBCKuQtPqcx9VQhWV6FiNhmoorX6ixeps9oM5/nR6qYXG96rQ+kK8jRvkKamoq2kdpDHRN55pxhWf79zn7hpS7A/sUN7DkV0MYFVFl/i8XTF7r8xzVrEVg0bRfGEh8td6cAggpPz+Eg0nELlpNNarOH0NTrvjisruKObGE0EaFQHd45ZW2PoeEomw76lzCcKeGfaowHPwXTxywuNX6b8KVrrQS88HgsTs/XQWXaeCbSa8UYxQRdHBcevYct6jg1e3oYw41zpcmbI1prwnvSyqHk95PicpxtgcmNxLIu4hUGUSA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(356005)(2906002)(54906003)(110136005)(316002)(426003)(40480700001)(5660300002)(7636003)(40460700003)(8676002)(8936002)(36756003)(86362001)(4326008)(41300700001)(70206006)(70586007)(26005)(186003)(47076005)(82310400005)(2616005)(1076003)(336012)(107886003)(6666004)(478600001)(7696005)(36860700001)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 10:10:21.2199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b0e0b1-4081-4c16-2901-08daa0707c9a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5367
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure tegra_host member "curr_clk_rate" holds the actual clock rate
instead of requested clock rate for proper use during tuning correction
algorithm. Actual clk rate may not be the same as the requested clk
frequency depending on the parent clock source set. Tuning correction
algorithm depends on certain parameters which are sensitive to current
clk rate. If the host clk is selected instead of the actual clock rate,
tuning correction algorithm may end up applying invalid correction,
which could result in errors

Fixes: ea8fc5953e8b ("mmc: tegra: update hw tuning process")

Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 61dc5ee0726d..8285b979391d 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -784,7 +784,7 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 		dev_err(dev, "failed to set clk rate to %luHz: %d\n",
 			host_clk, err);
 
-	tegra_host->curr_clk_rate = host_clk;
+	tegra_host->curr_clk_rate = clk_get_rate(pltfm_host->clk);
 	if (tegra_host->ddr_signaling)
 		host->max_clk = host_clk;
 	else
-- 
2.17.1

