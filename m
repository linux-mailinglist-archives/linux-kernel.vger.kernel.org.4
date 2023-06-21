Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD35738559
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjFUNgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjFUNgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:36:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BB31998;
        Wed, 21 Jun 2023 06:35:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnBoRDi83W5tuMBRVRQ5yi66VO1Gel9MW5jsMkDSgL+tApHnnigZM0VgLcj3vbN8InegPhhqtNa8zJFN1B/SL/RYfvkjL/2Tfphk7TPekWq1jJGNCrOVfsPtp1h/OHnuhrMVjYW83zr+6lvwia02wo6vhVoQ6lLRjpyLUFbNTwyOLLtzHWGCoWvgEKANr3Lb3xQJFlLSEGDSVM1XdIa0TQS5mVYeDeN0f3Xx71gbydSJ6TSO33sQOKj+zZ3mB5oh3pwZaHlfLx1Z9aJYVO9ZATslY/Q6VeHN+hUexf8mqi7M78+/w40SGRlKhiaSj2fmFXMkstXpC4GBUyU7ZxyJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bxRUW89IS2RPob1CambtRNJDIe+vIWKZ6XXJlqituo=;
 b=oYxK4kfDm85i6Z+NlrXaIV38bJ54d6QkUtloWqmzsDtYHGQZwy9FVtcxJyrXMOhS7UlgDEP+YJtaMQzbxT09H6DoFzP2J49+5wIGhPKpWU4lDQORGqogGjp+n+bydUi7XONpgDOFIM2YsODkI4YvYQSBWBOPHSeNBbaO52/f/9w5vYcPGLEM0DEAZKBtTJgcaputCILIXmfJQqN4AW8Bpp7uLH8x3zESkfrcvX7x5zszkxjWbnnA25HpNIAoudJki2gK5K97AlYWN3SQ3a4J5GqqQfMsDyUFpBNzaXyucbMxZRyvKol1QNgfgA/kmbnAHFUjO9O81Q3RPPxMPycFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bxRUW89IS2RPob1CambtRNJDIe+vIWKZ6XXJlqituo=;
 b=LPgkYUFP8KUIMKQKCaAHRXmPMAU8SMtjVl7ntk2zXzAJcpdEf820OlPOAtiVqdmCUZTiurqZMaW7A35mE8RKMfTL17I+WClVVEM4qgggCgPvi92ozrIcwMNAnEcWWMiA75YDY33Nkhc42spSSxWzgoC0EblV9EcAYsSLNbxFm6J6iKoWORHRJ+AESvmXGfs7t0PoiKgXfxgZq49k/uiUQ3tGIaJYkVGFpWUwzBjrkwxLpjf4qHT0krF15HKpOiRn7db7h3Fbguq6SAZlXNsqGvFStzDZNfkjwIiu6S6chJtk6S1p/bDkSoSpx8ts7cTkezu5yMc+CXvcJ/et7eiAaw==
Received: from SA1P222CA0048.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::23)
 by SN7PR12MB7108.namprd12.prod.outlook.com (2603:10b6:806:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 13:35:53 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::3f) by SA1P222CA0048.outlook.office365.com
 (2603:10b6:806:2d0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Wed, 21 Jun 2023 13:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 13:35:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 06:35:40 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 21 Jun
 2023 06:35:40 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 21 Jun 2023 06:35:38 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <talho@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch 3/4] memory: tegra: add check if MRQ_EMC_DVFS_LATENCY is supported
Date:   Wed, 21 Jun 2023 19:05:25 +0530
Message-ID: <20230621133526.22492-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230621133526.22492-1-sumitg@nvidia.com>
References: <20230621133526.22492-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|SN7PR12MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bec7874-e0a9-465d-3751-08db725c6f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fa9W9aBxVbDJaOsYODHmVIrZ7YbY7LT+XdeWWF8AlgQmLsZ1KFkdPHB/cljFphlLIbW7N36L9l3ehaQz6C9kJ9yO/EDAe5+4VMK+AxhFaaSqx25UMTOtTjy6K8blUlzSsVvgpsBrIyATys7U/YyJQCkHnHnpGMjAk6QppPcnNcSexXX7HFJOf9BBio1sfqvHGvOLyFPPnA07OGq173y4UJeXym7YNx8w+1KlkNN8P1Rsc4/YV5M+7EE8Kw1UPUcBcm4aTZ6xe9INH/mlUY48juYFWPvXDWKQ4wHr8SeJsl40xRlA8nV4jXcqYDkAbH/qPyOB/O8m00P4G4UlFiawYc46np1aozpTobCekRi4RFG8au11Zcag3PzKLCKG6W/iz0mwEf/EzlhfYA6zy6XwYh0eu5dnf8NTyqcD4xR3mH4NJ1Xgu4aDYs5uMqCJWJNTLdfV6/xnwhaAq4GlYwYHBGQGsJ0xxB0wlMs+kSQORMWA+RIg7bIXScVrCB9vtIWF/bOuJHQHmgYAbpm5y8K+xn3oOawDOjUbRNTPU5VdWg891jyGwdBYXLC5oQNag8hBaCMOi3IahKFGtEhxNyjDqrjVcOFgDKMfJ0ebkr+oB5zvTGM6NeXoSoFkw2/UvhkEnOiccNlTzzYFCqqfbQld1rxMUUEpsHYsPh7Ua1/AU6ANsx2fySwhAj8/qc+1MkXbv1E+0SYBdmQcj5KFzP0UecWb7ESAtmsde0dm7K1hvxAZk3adXk0MrOSurt669Nci
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(7696005)(478600001)(6666004)(36860700001)(336012)(47076005)(186003)(426003)(36756003)(83380400001)(82310400005)(86362001)(7636003)(2616005)(356005)(1076003)(82740400003)(40480700001)(107886003)(26005)(4326008)(70586007)(70206006)(316002)(8676002)(8936002)(5660300002)(41300700001)(2906002)(54906003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:35:53.2260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bec7874-e0a9-465d-3751-08db725c6f58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7108
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

