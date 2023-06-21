Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B0738595
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjFUNoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjFUNoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:44:30 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F2D199D;
        Wed, 21 Jun 2023 06:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbEN9mCMHIv6GRwfC9UUBjqYwzzMVreNr1sf4wNrUbb5uOO4LnwfyXNNaxdSocfIJ7xD7qlt1BKQXhq0PtNu4GfMWvum4y9HGPi7l1vSM8Al5cz55vQ3wGTG9M+uWv/D4k/jLY4pomQ1UHk4MLddSOB9enY84+4OYLS/XDJMz1zScfvPE6MAuiYZTilJIQW+SgymXYnUJwjCswoVqA3RwmJFqy1VFOELFpt64LqZbPa+L3jirA/GN31VUfthstkkG8cKIZ4AIPsRKEuQQR/JO1DBuk5XcZ+kYCb6QC4/bu0hfqvtqRcbraIoonADSY7rhUY0EZLn+9nvDfVi9GvgqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bxRUW89IS2RPob1CambtRNJDIe+vIWKZ6XXJlqituo=;
 b=HdXKTCy2UpSRYFASZhGR+3G2qCUxUKoieTEL2/Cqr3DBYDxkARcXTF7qY9Yd75oEqy50RxYRhpuVNhwVkaJHgppsRqeCo1MmfwNwMkOFQKvCEQdXBkQ7kF/UZYwHGtvfUakLU7MrPzET0ZPw8etkkGxN+Xmg+xsKoXYWS0sbLki3Goz8c7SbBOaLzOe5rCl3MGZGllntg+qpJKICqbd6EF3FbIMaf3edcMHFckdRFZg3uSL3Is4zxjApgiD/C73kxDnhzAaa4zA8WxwM0wxcuBcb9V7ptoqTN60ftSBFVxDxTTHfAUb7gihE5KKmuR5PRuNOFaiazC/ETfuCynv3jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bxRUW89IS2RPob1CambtRNJDIe+vIWKZ6XXJlqituo=;
 b=rDNfkQ1KMXPImMO4Dt7QMBV+1SFScdw1X8utwTGHH/acyWg59G8tTSsasamOIPIHqdmeUXD+zp1UjOeMEkW+0UNHHNTaS1hfRF3iBLcmo3laQQ31Svbss0XwK7nHQGuHUR88u0yl0izK6J/wNZX4c+xdKuVzF2Ov1V9fDB/VAAfqdS0EV7cv7kFDJgDu6Ln1CH0eGhVwEmVQvFH4DXNUhZLiPHOAy577INe9lIVEJhIRApi6c839hSV3p9eCFBOFwnDde8rfxxcM2ldRu60flQGNhgbJ+FaA3JREUnHxRxR6C+pjiZqlXSpDBsjqYNmjqPw3ix6zfAS1cgrC2NQnlA==
Received: from SA1P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::22)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 13:44:23 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::97) by SA1P222CA0007.outlook.office365.com
 (2603:10b6:806:22c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Wed, 21 Jun 2023 13:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.19 via Frontend Transport; Wed, 21 Jun 2023 13:44:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 06:44:18 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 21 Jun 2023 06:44:18 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 21 Jun 2023 06:44:16 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <talho@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch RESEND 3/4] memory: tegra: add check if MRQ_EMC_DVFS_LATENCY is supported
Date:   Wed, 21 Jun 2023 19:13:59 +0530
Message-ID: <20230621134400.23070-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230621134400.23070-1-sumitg@nvidia.com>
References: <20230621134400.23070-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6917cb-5ad0-4c32-631d-08db725d9f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fjemLxqa97PWSC+GYOp5isR+Ix2/HixmOKykKGUhljS49vm7CxSy7em6GiuvKl88kz0d4NWoHZ4fTRjHeFWKB5hVHerCT3wJZ5Skw+UdHbZ1mt9zB0ApfiG2c3uQu/IbSqroRPjsjmITg2xDmYvETkn3lA1XBDffYBtsCZjV9SdPtM4nDsDj7NSfs2Vu3cEgG6YZPRga9CqPK2wXgHjg+xJfV2mZP+w8k+Wg0EfvHsBbwWpJrc7AP7j+mxbuGvnm+mmtjnMSDZ/OWJE2vGl8XFGIUX+62h1kxJGBzuXmZvPKO0KXamlZGQ/denbw/p/Ekn+9MUT/KodBQ8f+mZjq268dnep/PWaEmePdLd6UYlP8clgVMyZgVXlR1z7rfL3CIOLswyrhlLmFaHc/2KkF26xaGhJMbtrqum5cc+aOY/oZtODGjEfcGECap59Es/AyBUovHnVaYWxtvKLtXWi768pLqIJdG/Tsgys+Io4vtKIXLnYaPjvtfWMeakcbe2Bztr98GIN3GWhOiE6OOIpT64z1wfDKHRVEKso4Jmxy3WaCvWOEWfX4m1cwI/REExT16BBvTE7578Ab7fr/7pBzS4h6lbSc5CdFgsriov6iDd07RVBEYXnQoROsfURh4ZEU9u18+Ez9PZAHvP19JHz4Ubmgx4cKGQyFKznELF113xTfkSwEKwKk0CfvSUSVxDBCaNcHBUxQC4+1OMS3DRX5PiD493+ZPzfg7osib0Je/vMS4LCA7+QMDI/R/7wpgC5s
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(6666004)(478600001)(54906003)(110136005)(4326008)(47076005)(40480700001)(336012)(426003)(83380400001)(2616005)(86362001)(36756003)(36860700001)(40460700003)(2906002)(70586007)(82310400005)(186003)(7696005)(1076003)(107886003)(26005)(356005)(82740400003)(7636003)(316002)(70206006)(8676002)(8936002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:44:23.6830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6917cb-5ad0-4c32-631d-08db725d9f97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add check to ensure that "MRQ_EMC_DVFS_LATENCY" is supported by the
BPMP-FW before making the MRQ request. Currently, if the BPMP-FW
doesn't support this MRQ, then the "tegra186_emc_probe" fails.
Due to this the Memory Interconnect initialization also doesn't
happen. Memory Interconnect is not dependent on this MRQ and can
initialize even when this MRQ is not supported in any platform.
The check ensures that the MRQ is called only when it is supported
by the BPMP-FW and Interconnect initializes independent of this MRQ.
Also, moved the code to new function for better readability.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/memory/tegra/tegra186-emc.c | 136 +++++++++++++++-------------
 1 file changed, 71 insertions(+), 65 deletions(-)

diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 6ad8a4023dd7..83981ae3ea86 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -155,6 +155,73 @@ DEFINE_DEBUGFS_ATTRIBUTE(tegra186_emc_debug_max_rate_fops,
 			  tegra186_emc_debug_max_rate_get,
 			  tegra186_emc_debug_max_rate_set, "%llu\n");
 
+static int tegra186_emc_get_emc_dvfs_latency(struct tegra186_emc *emc)
+{
+	struct mrq_emc_dvfs_latency_response response;
+	struct tegra_bpmp_message msg;
+	unsigned int i;
+	int err;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.mrq = MRQ_EMC_DVFS_LATENCY;
+	msg.tx.data = NULL;
+	msg.tx.size = 0;
+	msg.rx.data = &response;
+	msg.rx.size = sizeof(response);
+
+	err = tegra_bpmp_transfer(emc->bpmp, &msg);
+	if (err < 0) {
+		dev_err(emc->dev, "failed to EMC DVFS pairs: %d\n", err);
+		return err;
+	}
+	if (msg.rx.ret < 0) {
+		dev_err(emc->dev, "EMC DVFS MRQ failed: %d (BPMP error code)\n", msg.rx.ret);
+		return -EINVAL;
+	}
+
+	emc->debugfs.min_rate = ULONG_MAX;
+	emc->debugfs.max_rate = 0;
+
+	emc->num_dvfs = response.num_pairs;
+
+	emc->dvfs = devm_kmalloc_array(emc->dev, emc->num_dvfs, sizeof(*emc->dvfs), GFP_KERNEL);
+	if (!emc->dvfs)
+		return -ENOMEM;
+
+	dev_dbg(emc->dev, "%u DVFS pairs:\n", emc->num_dvfs);
+
+	for (i = 0; i < emc->num_dvfs; i++) {
+		emc->dvfs[i].rate = response.pairs[i].freq * 1000;
+		emc->dvfs[i].latency = response.pairs[i].latency;
+
+		if (emc->dvfs[i].rate < emc->debugfs.min_rate)
+			emc->debugfs.min_rate = emc->dvfs[i].rate;
+
+		if (emc->dvfs[i].rate > emc->debugfs.max_rate)
+			emc->debugfs.max_rate = emc->dvfs[i].rate;
+
+		dev_dbg(emc->dev, "  %2u: %lu Hz -> %lu us\n", i,
+			emc->dvfs[i].rate, emc->dvfs[i].latency);
+	}
+
+	err = clk_set_rate_range(emc->clk, emc->debugfs.min_rate, emc->debugfs.max_rate);
+	if (err < 0) {
+		dev_err(emc->dev, "failed to set rate range [%lu-%lu] for %pC\n",
+			emc->debugfs.min_rate, emc->debugfs.max_rate, emc->clk);
+		return err;
+	}
+
+	emc->debugfs.root = debugfs_create_dir("emc", NULL);
+	debugfs_create_file("available_rates", S_IRUGO, emc->debugfs.root,
+			    emc, &tegra186_emc_debug_available_rates_fops);
+	debugfs_create_file("min_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,
+			    emc, &tegra186_emc_debug_min_rate_fops);
+	debugfs_create_file("max_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,
+			    emc, &tegra186_emc_debug_max_rate_fops);
+
+	return 0;
+}
+
 /*
  * tegra_emc_icc_set_bw() - Set BW api for EMC provider
  * @src: ICC node for External Memory Controller (EMC)
@@ -251,10 +318,7 @@ static int tegra_emc_interconnect_init(struct tegra186_emc *emc)
 static int tegra186_emc_probe(struct platform_device *pdev)
 {
 	struct tegra_mc *mc = dev_get_drvdata(pdev->dev.parent);
-	struct mrq_emc_dvfs_latency_response response;
-	struct tegra_bpmp_message msg;
 	struct tegra186_emc *emc;
-	unsigned int i;
 	int err;
 
 	emc = devm_kzalloc(&pdev->dev, sizeof(*emc), GFP_KERNEL);
@@ -275,70 +339,12 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, emc);
 	emc->dev = &pdev->dev;
 
-	memset(&msg, 0, sizeof(msg));
-	msg.mrq = MRQ_EMC_DVFS_LATENCY;
-	msg.tx.data = NULL;
-	msg.tx.size = 0;
-	msg.rx.data = &response;
-	msg.rx.size = sizeof(response);
-
-	err = tegra_bpmp_transfer(emc->bpmp, &msg);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to EMC DVFS pairs: %d\n", err);
-		goto put_bpmp;
-	}
-	if (msg.rx.ret < 0) {
-		err = -EINVAL;
-		dev_err(&pdev->dev, "EMC DVFS MRQ failed: %d (BPMP error code)\n", msg.rx.ret);
-		goto put_bpmp;
-	}
-
-	emc->debugfs.min_rate = ULONG_MAX;
-	emc->debugfs.max_rate = 0;
-
-	emc->num_dvfs = response.num_pairs;
-
-	emc->dvfs = devm_kmalloc_array(&pdev->dev, emc->num_dvfs,
-				       sizeof(*emc->dvfs), GFP_KERNEL);
-	if (!emc->dvfs) {
-		err = -ENOMEM;
-		goto put_bpmp;
-	}
-
-	dev_dbg(&pdev->dev, "%u DVFS pairs:\n", emc->num_dvfs);
-
-	for (i = 0; i < emc->num_dvfs; i++) {
-		emc->dvfs[i].rate = response.pairs[i].freq * 1000;
-		emc->dvfs[i].latency = response.pairs[i].latency;
-
-		if (emc->dvfs[i].rate < emc->debugfs.min_rate)
-			emc->debugfs.min_rate = emc->dvfs[i].rate;
-
-		if (emc->dvfs[i].rate > emc->debugfs.max_rate)
-			emc->debugfs.max_rate = emc->dvfs[i].rate;
-
-		dev_dbg(&pdev->dev, "  %2u: %lu Hz -> %lu us\n", i,
-			emc->dvfs[i].rate, emc->dvfs[i].latency);
-	}
-
-	err = clk_set_rate_range(emc->clk, emc->debugfs.min_rate,
-				 emc->debugfs.max_rate);
-	if (err < 0) {
-		dev_err(&pdev->dev,
-			"failed to set rate range [%lu-%lu] for %pC\n",
-			emc->debugfs.min_rate, emc->debugfs.max_rate,
-			emc->clk);
-		goto put_bpmp;
+	if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_EMC_DVFS_LATENCY)) {
+		err = tegra186_emc_get_emc_dvfs_latency(emc);
+		if (err)
+			goto put_bpmp;
 	}
 
-	emc->debugfs.root = debugfs_create_dir("emc", NULL);
-	debugfs_create_file("available_rates", S_IRUGO, emc->debugfs.root,
-			    emc, &tegra186_emc_debug_available_rates_fops);
-	debugfs_create_file("min_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,
-			    emc, &tegra186_emc_debug_min_rate_fops);
-	debugfs_create_file("max_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,
-			    emc, &tegra186_emc_debug_max_rate_fops);
-
 	if (mc && mc->soc->icc_ops) {
 		if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
 			mc->bwmgr_mrq_supported = true;
-- 
2.17.1

