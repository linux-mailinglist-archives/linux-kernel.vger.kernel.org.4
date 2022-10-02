Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A085F23AC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 16:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJBOoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 10:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJBOoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 10:44:22 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2062.outbound.protection.outlook.com [40.107.212.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D8B1F2FC;
        Sun,  2 Oct 2022 07:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABIIjhTx1XMhpq54eYhXc3J1UC63ACVOCqKyxztpf7m3y+Q+sBY5MhLqpdVqQ9MNDhHaR3d9zWBaBHMq/Cn/ZiuZShko+zhbd2DiRLpoMAzXBs0VQRWjx4huchaZ5QPGociPMANWZtq544Osoae7wI+ZFLZM8euJ6f3CDDbIBrPAhCFdPy4v9q1KUl+UBgUgUNX7e9izmQq72q8H9IHSgVAn03gxzbCgPWHKq360dVm8G1vjGkUrBHC61ZIJ84cFXLKQtuJ9CPPT1QIGbQ7LbWeyZ040UlD6KsEfQX5vhAst3FH1VTTriN4ARIJY7ZX49l+axJ7OdDzM5kcVFwViGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F9DC/83pl69DzVDKbDFXUiU55f8L29gVBYdDT6jjdQ=;
 b=E+0rgL/ebp9bLZSAyCicU5zUdlt1yjBh+c0daEBshKEk1dfDGw96eO9xuMQYxGBDgeSaxuXC83WnH+JoPUx+MKW0nOhNuBEaDdUEEY0sRcE7PUh48d1I9fiOFsnVjEczFWqv8OVpYWVRi73DB2SKZ5Ypm+r5Ud4Rfv5Lai8ZerNP6jcohj0xW85GRqKDfgkQc71xEtkZAuw3+9/Ie3ECMu/c+Q4yZJahDdE1VJxJvZCdqQLJgmyTKD0cHStHWphh4+ZxR1WY4SPvpmgw2luyjYeBcYl1NKZ/8FAgAp+X3mVTjf9uHof5x9VBEE06LVpJhBt4RmZeDNwHWPSeEdZcRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F9DC/83pl69DzVDKbDFXUiU55f8L29gVBYdDT6jjdQ=;
 b=qLSf6Em/VMoGWI/JwSYVZJFlIpbNp8YLiYBR04X/Xf0rUzzwgNO8gMlLYoRA6aF3XwDDC54r3J5jgRtQMYqx2CmU5b4XddwRfM1A2IhuI7z+xB4OYE+aMduhKp13ZRXNieWUDW0JOvbhgYd0sWCzm4dfbDrucwXS12MV5xPKw9WOdcXetRcNRg1A0fkHTTKpOwU7J4dIB5VeznE6Mn5ECdKYoMDVIv+wrdLKi2bW0MHW3hChD6Wc1ow79or/JZ9nasgaKsXfURutV8w19StXx67U9NVxcFMi78cAJ9/peWKdaSLha7EYvsaYDg2PfE26A7cZOo2tmvFpk+mfqEV/Vw==
Received: from MW4PR03CA0238.namprd03.prod.outlook.com (2603:10b6:303:b9::33)
 by SA1PR12MB6776.namprd12.prod.outlook.com (2603:10b6:806:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sun, 2 Oct
 2022 14:44:18 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::74) by MW4PR03CA0238.outlook.office365.com
 (2603:10b6:303:b9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Sun, 2 Oct 2022 14:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Sun, 2 Oct 2022 14:44:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 2 Oct 2022
 07:44:18 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sun, 2 Oct 2022 07:44:17 -0700
Received: from build-petlozup-20220913T015306864.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29
 via Frontend Transport; Sun, 2 Oct 2022 07:44:17 -0700
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
        <ulf.hansson@linaro.org>, <kkartik@nvidia.com>,
        <cai.huoqing@linux.dev>, <spatra@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <petlozup@nvidia.com>, Prathamesh Shete <pshete@nvidia.com>
Subject: [PATCH v2] soc/tegra: pmc: Process wake events during resume
Date:   Sun, 2 Oct 2022 14:44:09 +0000
Message-ID: <20221002144409.102132-1-petlozup@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT043:EE_|SA1PR12MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfd28e1-7081-4f9a-bfa2-08daa484960a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJSCK/FvHemtUdFrPiQuS972E7CcnsnLY1caPWlF6850wnvbPTlxBMUjaRAMhjvA/bsohUqlpc72RSoIqIaBXeCzBGzSpbKs1GO+JVyTCFYSgNC/pZmsi/tEKkthQ/zkSXM3aPczZ8vJ9sFJ8iZFfbWQazU/mba9IvAojYnwIElBKRX24kzHI9hy/oeJSklPwQOWls4h54BUMMzpNQsuSGkzrk5zmyeS1RLsHDNrUmQgcuo6cG5MU4ukD81XM+UW7tuQvzHUgF7AyhArIglyfZSff+U9c8DejvFk2MnD9Hzd9zeeQFASf6XrcJPN2ncIvgxg8/FwCWF4RSZlUoLtfFg+jnxeoxU/GS0UwfQoCWB3NtrUdgVlb4+NcjGPl55Wwqza6D0pZaLY5BjH1sOa7lfxd/cnsRJqFSeiwQxR8QwdSlu1UyolX+G5BsI/LBF2vgLLr4jG7UDLJMoqIId+pyzCpo87dGFwZnhsfOdIHZkrWua7hW9qRVchqFLrPauf7/k8pOEj5yImCc1xqL2wC1f/MGzxG+ImIK0hVxBI3m2sX/IWeH4pqVm6MCUoNhoOT7GmYYiQ1bBWBSq/bhoHMl2Dl6JZ/qsKHipL+gk7ir0+7FE9YZ7nlKg4mkEScRPyiwAbVDIjAreXTPE2gRZLys0usyLLr4nSf9VBGLvqDPsLK0MAbimQc3x0r9NcHlX1ILOPzzRhqLAWQa4jAniBbsWrfahbW2KIhLzQ3zBSGHUXXrIn9z7VV12gjpc5jkQ/dx2KY6RgyTS6X46Q+jiyOvbuvIoKLX07LNxXIkdcXGg=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(2616005)(26005)(107886003)(6666004)(7696005)(316002)(54906003)(4326008)(8676002)(70586007)(70206006)(478600001)(36756003)(110136005)(82310400005)(82740400003)(86362001)(40480700001)(921005)(356005)(40460700003)(7636003)(83380400001)(336012)(1076003)(186003)(47076005)(426003)(36860700001)(5660300002)(8936002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2022 14:44:18.5334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfd28e1-7081-4f9a-bfa2-08daa484960a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6776
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During system resume, translate tier2 SC7 wake sources back into
irqs and do generic_handle_irq() to invoke the interrupt handlers
for edge triggered wake events such as sw-wake.

Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 66f94c011528..d166048de83c 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -23,6 +23,7 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/irqdomain.h>
@@ -3151,6 +3152,46 @@ static void wke_clear_wake_status(void)
 	}
 }
 
+/* translate sc7 wake sources back into irqs to catch edge triggered wakeups */
+static void process_wake_event(unsigned int index, unsigned long status)
+{
+	unsigned int irq, wake;
+	irq_hw_number_t hwirq;
+	struct irq_desc *desc;
+
+	dev_dbg(pmc->dev, "Wake[%d:%d]  status=0x%x\n", (index * 32) + 31,
+		index * 32, (u32)status);
+
+	for_each_set_bit(wake, &status, 32) {
+		hwirq = wake + 32 * index;
+
+		irq = irq_find_mapping(pmc->domain, hwirq);
+
+		desc = irq_to_desc(irq);
+		if (!desc || !desc->action || !desc->action->name) {
+			dev_dbg(pmc->dev, "Resume caused by WAKE%d, irq %d\n",
+				(wake + 32 * index), irq);
+			continue;
+		}
+		dev_dbg(pmc->dev, "Resume caused by WAKE%d, %s\n",
+			(wake + 32 * index), desc->action->name);
+		generic_handle_irq(irq);
+	}
+}
+
+static void tegra186_pmc_wake_syscore_resume(void)
+{
+	unsigned int i;
+	u32 status;
+
+	for (i = 0; i < pmc->soc->max_wake_vectors; i++) {
+		status = readl(pmc->wake + WAKE_AOWAKE_STATUS_R(i));
+		status = status & readl(pmc->wake +
+				WAKE_AOWAKE_TIER2_ROUTING(i));
+		process_wake_event(i, status);
+	}
+}
+
 static int tegra186_pmc_wake_syscore_suspend(void)
 {
 	wke_read_sw_wake_status();
@@ -3828,6 +3869,7 @@ static const struct tegra_pmc_regs tegra186_pmc_regs = {
 
 static struct syscore_ops tegra186_pmc_wake_syscore_ops = {
 	.suspend = tegra186_pmc_wake_syscore_suspend,
+	.resume = tegra186_pmc_wake_syscore_resume,
 };
 
 static void tegra186_pmc_init(struct tegra_pmc *pmc)
-- 
2.17.1

