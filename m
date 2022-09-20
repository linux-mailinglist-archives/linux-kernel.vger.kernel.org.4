Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF355BDB03
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiITDzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiITDzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:55:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AC343625;
        Mon, 19 Sep 2022 20:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1IBRojyt6iIe3Qnf41tIVXyzfV8wQGgazgPGxEmcLWX6QTGBoNgyAlQycQqdDU7Wd/G0uuAaEdq+kS2PSJYyOu1d05DEgz+Lmi4j0xVMOV5nTsgQpsoZQWRnrfriX6Oj0uIY8V+jtNc9fM+hj6hai6/SR11pzvy9Ra9S/KbDNVW6MxDeQxgz78WG80dJLQJIXLGt9pbh/8zqdAnXSi94nP1LQ+tOwZ8r4RqLiDs/v0NRH2fvO0+SDRwa5MPi8JEG3OK4VE4BMYUvF6xzU9gbQSfJ7LAygT1A62chyT8m9IT8D1MTrvlo6ISUIqFUhGl1DO6HWCx4GU3KNp2uU0SBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNrm99Zsno6pXsY5Zo7SSWrPRI7gGnFGKaNE1ihZoGk=;
 b=DHGVrY0lmB5lt46nuoNE+tjFYFyr2GMafuL/OmRZ/hrx8g32bzaLu6GG5UgjVMwpVEYaGau1Tddyfa7f05DsPCAOnmEIrGo9OFMbruTT6z2uw3n3DEgBej3CvjG6AlIRvKLblg7FhtQWjZJFNVKdnIFR8BTyAbw0ZIV1374vccNZqFVpK6GSj5gYykxVnbnLlmSk+X7YM9z7l9yr7Ow8dSzW0bM6nzO1j8f3BD0YIoOlvahp6X3S3ZTXxzoVMRtHSGvG9GCmCtQzVlRlqr8vwkNU/Y/+2kokWv1EwyLvS7SW8xjB+wDEbEOM/+Axk9/AHk4VHnezR0QdvVZpmrH6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNrm99Zsno6pXsY5Zo7SSWrPRI7gGnFGKaNE1ihZoGk=;
 b=IgjveFOcS9Dc7rCWempSzyqC4ojRqfTc5o1sECxX8ohlaOvh/+Jo8xEzKyctdBxSVfpCEeF1VYZqG5ZRTSLm3wa8BcKprWn9zbQKdppzfyVxmXtQuytGzPBRnKX54OsRhkn9fXR75kM5uQS/tAqJaWwaky4dJwx231zZ4aNbEgm42rKUnoYGuElqdIhZzjTpwAxSWLqK8UmiHMwrkQqsPNkiYLUc8xAZJhU19IPfJOg3pCvRHeU7naeNL/oO/dLCwd/tzgyQGOU6jsvLdKUAmW9+/CAU5ERPUbwTg2EL3SqZc2tUOphRs90C29ZezBxVhU5VTodjt/s1NkVUrB6WyQ==
Received: from DS7PR03CA0139.namprd03.prod.outlook.com (2603:10b6:5:3b4::24)
 by DM6PR12MB5007.namprd12.prod.outlook.com (2603:10b6:5:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Tue, 20 Sep
 2022 03:55:36 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::67) by DS7PR03CA0139.outlook.office365.com
 (2603:10b6:5:3b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 03:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 03:55:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 20:55:27 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 20:55:27 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 19 Sep 2022 20:55:26 -0700
Received: from build-petlozup-20220913T015306864.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29
 via Frontend Transport; Mon, 19 Sep 2022 20:55:26 -0700
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
        <p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
        <ulf.hansson@linaro.org>, <kkartik@nvidia.com>,
        <cai.huoqing@linux.dev>, <spatra@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <petlozup@nvidia.com>, Viswanath L <viswanathl@nvidia.com>
Subject: [PATCH] soc/tegra: pmc: Support software wake-up for SPE
Date:   Tue, 20 Sep 2022 03:55:13 +0000
Message-ID: <20220920035513.670740-1-petlozup@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT022:EE_|DM6PR12MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1f9d9d-dc40-4f89-43e0-08da9abbf994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yWVO08asasFEke9/oA+jUznXDgyjWXDS16yTSSC4pusOsmW5MnNtZbba5h9jaikDCAQHm3Bf7OFBip9kuGe1SEqthnxvL2S2QBYWF7p61Pktn0tfKsRSpRbB9nWDIBVMJo8YxfFY26kSTcu2D/q2rvZM2q/RnG/rdkMpOAFQB/ZjkmTuI1xvgm3dedW5F/G78LOgf9EB/1Pmwy7t8Pxvgh1tHtSRRegs201j94w/UJjDUzP5QtpeUpdOqRWTVZZnN9kGxfKfvapx6nLac/9k9HYWleDlZpd6thiQZRP3tQIedf3rxxRFieQUX5CD6s2zi7T1/pIBC1D/6xEJs2dtbo0BtUzpAsYi0NQf20RheY93o1cUu4/fCI+fJCzclrdrQxi/wjTz34tFWAZKv/UxCUBK4aDgLxi5TZd6DXGnk+9cXCDz7vLezBXGEPWdpgURPnavrq7YL5uTGNJMtcIArymSD+QKBuGZQuWmYfwq/yZ+ijFz8qHF9TRvJzWxy5T6udXphwYq/enlH+XbMiM4sOrS4Dk5NivAOFQ86z/kve9U0XFMFsEN3HJ82LO3CSscHkskZo6f5Yiy1J3m3hhbpFyLfAUiZz9r8KqLSJFRE0A8Q9fHw0hpjrtankLeOCp2eWdKq6jZDz/mgIvu0VG/PL6xFPGaIxEaJGNif40onmvwisFmth5zX3gIDabdCl2Putkjw86SM/jld/X8SQOjp7q/VK/0OROA0sKPUz+2ynmJ1VatJBhVtTa40zk7+GgpSbG2o+5AKr6rxm0c23an2u+VqFpHYG9a3jOYS/FWNIc=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(26005)(7696005)(2616005)(356005)(478600001)(2906002)(5660300002)(82310400005)(36860700001)(82740400003)(7636003)(36756003)(86362001)(921005)(40460700003)(426003)(186003)(1076003)(6666004)(107886003)(47076005)(83380400001)(40480700001)(41300700001)(4326008)(336012)(54906003)(8676002)(70586007)(70206006)(316002)(8936002)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 03:55:36.1589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1f9d9d-dc40-4f89-43e0-08da9abbf994
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5007
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sensor Processing Engine(SPE) can trigger a software wake-up of
the device. To support this wake-up for the SPE, set SR_CAPTURE_EN
bit in WAKE_AOWAKE_CNTRL register associated with the wake-up for
the SPE. This SR capturing logic is expected to be enabled for wakes
with short pulse signalling requirements.

Signed-off-by: Viswanath L <viswanathl@nvidia.com>
Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index f275af15f2d0..02878ea2632c 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -176,6 +176,7 @@
 /* Tegra186 and later */
 #define WAKE_AOWAKE_CNTRL(x) (0x000 + ((x) << 2))
 #define WAKE_AOWAKE_CNTRL_LEVEL (1 << 3)
+#define WAKE_AOWAKE_CNTRL_SR_CAPTURE_EN (1 << 1)
 #define WAKE_AOWAKE_MASK_W(x) (0x180 + ((x) << 2))
 #define WAKE_AOWAKE_MASK_R(x) (0x300 + ((x) << 2))
 #define WAKE_AOWAKE_STATUS_W(x) (0x30c + ((x) << 2))
@@ -198,6 +199,8 @@
 #define WAKE_NR_EVENTS		96
 #define WAKE_NR_VECTORS		(WAKE_NR_EVENTS / 32)
 
+#define SW_WAKE_ID		83 /* wake83 */
+
 DECLARE_BITMAP(wake_level_map, WAKE_NR_EVENTS);
 DECLARE_BITMAP(wake_dual_edge_map, WAKE_NR_EVENTS);
 
@@ -375,6 +378,7 @@ struct tegra_pmc_soc {
 	void (*setup_irq_polarity)(struct tegra_pmc *pmc,
 				   struct device_node *np,
 				   bool invert);
+	void (*set_wake_filters)(struct tegra_pmc *pmc);
 	int (*irq_set_wake)(struct irq_data *data, unsigned int on);
 	int (*irq_set_type)(struct irq_data *data, unsigned int type);
 	int (*powergate_set)(struct tegra_pmc *pmc, unsigned int id,
@@ -2447,6 +2451,17 @@ static int tegra210_pmc_irq_set_type(struct irq_data *data, unsigned int type)
 	return 0;
 }
 
+static void tegra186_pmc_set_wake_filters(struct tegra_pmc *pmc)
+{
+	u32 value;
+
+	/* SW Wake (wake83) needs SR_CAPTURE filter to be enabled */
+	value = readl(pmc->wake + WAKE_AOWAKE_CNTRL(SW_WAKE_ID));
+	value |= WAKE_AOWAKE_CNTRL_SR_CAPTURE_EN;
+	writel(value, pmc->wake + WAKE_AOWAKE_CNTRL(SW_WAKE_ID));
+	dev_dbg(pmc->dev, "WAKE_AOWAKE_CNTRL_83 = 0x%x\n", value);
+}
+
 static int tegra186_pmc_irq_set_wake(struct irq_data *data, unsigned int on)
 {
 	struct tegra_pmc *pmc = irq_data_get_irq_chip_data(data);
@@ -3078,6 +3093,10 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pmc);
 	tegra_pm_init_suspend();
 
+	/* Some wakes require specific filter configuration */
+	if (pmc->soc->set_wake_filters)
+		pmc->soc->set_wake_filters(pmc);
+
 	return 0;
 
 cleanup_powergates:
@@ -3889,6 +3908,7 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.regs = &tegra186_pmc_regs,
 	.init = NULL,
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
+	.set_wake_filters = tegra186_pmc_set_wake_filters,
 	.irq_set_wake = tegra186_pmc_irq_set_wake,
 	.irq_set_type = tegra186_pmc_irq_set_type,
 	.reset_sources = tegra186_reset_sources,
@@ -4024,6 +4044,7 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.regs = &tegra194_pmc_regs,
 	.init = NULL,
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
+	.set_wake_filters = tegra186_pmc_set_wake_filters,
 	.irq_set_wake = tegra186_pmc_irq_set_wake,
 	.irq_set_type = tegra186_pmc_irq_set_type,
 	.reset_sources = tegra194_reset_sources,
@@ -4182,6 +4203,7 @@ static const struct tegra_pmc_soc tegra234_pmc_soc = {
 	.regs = &tegra234_pmc_regs,
 	.init = NULL,
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
+	.set_wake_filters = tegra186_pmc_set_wake_filters,
 	.irq_set_wake = tegra186_pmc_irq_set_wake,
 	.irq_set_type = tegra186_pmc_irq_set_type,
 	.reset_sources = tegra234_reset_sources,
-- 
2.17.1

