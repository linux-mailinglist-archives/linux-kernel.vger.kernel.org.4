Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBEC652444
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbiLTQFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiLTQEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:04:45 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CE7186BF;
        Tue, 20 Dec 2022 08:04:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOwmNsMNrUd6BGRPihtWetGiPhtJ6pss7GirZwpynnEWZfZ/QnrCcAz2R1X4IvCUbhEHpfzI7QuCFI0db1n6dVc6Evnj8aJPm3vXv/OkUd7ZKThGIrsIHSA2rTLlzeTD8OL4r8agWidp/jhqNtJ740SgtO+ochc6xs5u0u94XFTa3wCE4O2aRBqjU5pPZkB/Fmv3bybJ2oISxGk2GN6zH8KJIvPm4orfdh0NaJB0fCwRfV25UPpgvReQunH2D/aRymksvXc9pephU39LLMnGhlMcaKl8CFdZBtGNPP6cyW5lC9HrZopQisYsrn/EzN+cn5PtFOva4Zz8hAQBMTOe8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCil6ElgDOn+7uCawJScs+LzFmHK33zRGIRwlkx9z50=;
 b=T/nSHaOkEiBG033CV9CZ9cSAnjcvFig5nl6RMV+OJplKP4wWel1nOJBlrviqum2CtJbS8XOqFQ7nfGbAk+mZrZ5nYvgsOx6ZovrzBnWk1F4sSlP663CX8s4A1dZR0ku+AY5vYpO9x0k666oixHsk2ALoFSzDbOyh6SXT78+bgqw52ynW5C4HwcrS/Mh86jVZhkdvprEmI+wbFN/MvykOdassHhpqK5qz2gHQOt4/5eCEi8TQDpJeMBzyg32d6sbqpOz7062qTJGhz7PaPFUClmyuWwis7vM84c5RCpL7QQhdmEQjOvHZdPbPzmnaPz69Gg9VSG6KRvSNmgllNlYMtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCil6ElgDOn+7uCawJScs+LzFmHK33zRGIRwlkx9z50=;
 b=ll6iFnjcLduLc7kDt67lCClKBw6DoEUY1yfiY0S0/Z9arlevJkEOuxdqRtInKUfHIyZ9wSDkBuwUT9Kd99WQd0wOMeZtafyE5gVMZoU3/WaKrVdVxNtPgVh7dQVGC6VaTg+08eYwEAC19G5YLaqyuDyNTnyhqlFnc7urilH3IC/LS8cc9xKyetXXAZPDi/F720blApHBlY7ov15nApnVTDN5s/hqw9zgSvHXA+Ag1ezF3725LjWdWM67WmT4n8WLQl7qF0vrlCDIqHbE1GRoG3o/QpfEVzEza+9yqhXYNITcCAT9P2JbPfho1OQUGqcFT/Cy21mIEPQiatsKAl4L2A==
Received: from MW4P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::15)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 16:04:43 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::2) by MW4P223CA0010.outlook.office365.com
 (2603:10b6:303:80::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 16:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16 via Frontend Transport; Tue, 20 Dec 2022 16:04:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 08:04:42 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 20 Dec 2022 08:04:41 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 20 Dec 2022 08:04:38 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v1 07/10] cpufreq: Add Tegra234 to cpufreq-dt-platdev blocklist
Date:   Tue, 20 Dec 2022 21:32:37 +0530
Message-ID: <20221220160240.27494-8-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221220160240.27494-1-sumitg@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 8351c522-591d-4329-da55-08dae2a3e84d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZUFMRzlAtab0dW8Qrp6jJQOHvBJ9CDH8VKboDlrKVtbjPaT7cuoW6B0UVLHUHwMzXjCQVzi1JuJSiJHfsnIOVRgf/8OMdY1bqrFTnG2+ob3K2r8tmdfTcEqYU4QU8JER8Gx+5WByi4xfMmh5dW7lhIRfF6viEkPF9AHaFo2Gr4/UuwsdZ3yYDjj7NTc1BMt+p+9gBEEqhI/GtDktTne9JpRhY9A1kWjaEyIYjWaiDyC0pQnT06Oc/3iH9rsXlprl6DFkPAeXL0fiZi1M3WuPfnuzFOUJHOozB082aTcZtwTq3QRWPwGfN7nuNvYcBNrqPX8sFmUIH+vBCDVABZ7R/QNOM4/adIFJOPShMOFGEMvBPKv/oIDnT9CTBGk+3GcGI+5U5S3oc4qncgI6DpquIz8PpP+liUEp4XJ1SEnfc6KMyWk7D2X0uKNWhN4xjcf5CWC4ET3FyOqy66JAUZsnfxM2wTZJ23TxDYm1+xtQeyRsDumN7wNAC5uTGs98RE8hu5KgQFCoj86P/caHz6UMcQrhNyZPzAtSbw1Xk7PR8o17l0+UgRFik23IXuuUVAZnFqlQ8ukdXbv7mBQ1MZVADXDzOCOO6CEGL0X27xOmJwD4M9VDXHeFRHXwMmVh37jkXqk1Qcg0PgIojgAB3LopHDYz24mlwTnmV60sNokv/XCHO66FvKeMeUQehnJ+IR8r5sgdjLpc2yoCV/ZkoKbrMRsAS8TSdmtEuAqFYy4Iyg=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(40480700001)(2906002)(86362001)(8676002)(4326008)(336012)(41300700001)(186003)(70206006)(83380400001)(2616005)(478600001)(1076003)(110136005)(54906003)(316002)(107886003)(36860700001)(7696005)(921005)(356005)(7636003)(40460700003)(82740400003)(5660300002)(4744005)(426003)(47076005)(8936002)(26005)(82310400005)(70586007)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 16:04:43.0371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8351c522-591d-4329-da55-08dae2a3e84d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra234 platform uses the tegra194-cpufreq driver, so add it
to the blocklist in cpufreq-dt-platdev driver to avoid the cpufreq
driver registration from there.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 8ab672883043..e329d29d1f9d 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -137,6 +137,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "nvidia,tegra30", },
 	{ .compatible = "nvidia,tegra124", },
 	{ .compatible = "nvidia,tegra210", },
+	{ .compatible = "nvidia,tegra234", },
 
 	{ .compatible = "qcom,apq8096", },
 	{ .compatible = "qcom,msm8996", },
-- 
2.17.1

