Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7D472A69A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjFIXMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjFIXL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:11:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBDD2733;
        Fri,  9 Jun 2023 16:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLTaSYtqvpHFqWf13m3+d1tP0ibtEpnmJki2DuQ+/4BD3rygGfXqND+QSJ1XdlOJk8gzllRhLueIn6+awMUxEmxKqeaDnQkLqfxB0/3gcq9oETaWEp6IxyqXBNxGgSqJRX/6IRoeF3Ae2QOo32HVeIuathQcC5QiHPIfhMd+jxi02IX2yDcPRVx7BJEsVZ19lZJ3j6LZMHAJOmuq2cJfrU+E4ehMktVr/CSenJDwA3dXdKV+TnC3p0stRUY4QQ8KzqFyT7jQcItonCM3G6h2VwFc3fmMv2NYFcbUtk3Dhq+id33wE/Nh517P4anlj7y5dbi3UlYjGzBP3MA9a5uSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZCHl5gqvu2XJy4UUHCSna3Q9h/v/AFrQTnwc1eA6jA=;
 b=PI4ykKhUIzb/O0JDxwAWuvt55rpQS7MJb3TdHu503PrwR2Q0UbjkjSGYR1F1eQpQQ3FpSadkr4g2L7RzPmigC6coVvik+ngsUFkab9kEv/VURYJKFOgtyEUxG87IqsXoWPHuNVsERkpkLJ5bezFXANNcZCGDnvfvAELNI7C0amk8bsBBVzha4YIJM65CBlFVLpj0Aj4ZgP6N71ysqvruVAMyC56nxQxbXJN0vTAiSz2imgl808tz60kl4aDeBP2wja40w1GbYwPlo1yVtDtFqA96FyF74H2uJ2Gv9CL7qVGDZXsYsjtCQLimQYT538zZnOyQAtp2tqjjVMNrGqAeAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZCHl5gqvu2XJy4UUHCSna3Q9h/v/AFrQTnwc1eA6jA=;
 b=u+zPSHuQjt1Qo/l7tOYvacqAzobmAuikkdQNEGnKPkpPoV04cgE9x+xlDPaR2tM5DV67sKIaTaGYxBUh91NJ3rtNIm9xhBzlt8OhhMZy9E+xEgpKQkv24bh9hKBeiySx09f+5CL1GzoAftOSy5GlPM576LpwZX/vdxY5LOcb02I=
Received: from BN9PR03CA0087.namprd03.prod.outlook.com (2603:10b6:408:fc::32)
 by MW4PR12MB6681.namprd12.prod.outlook.com (2603:10b6:303:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 23:11:52 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::8) by BN9PR03CA0087.outlook.office365.com
 (2603:10b6:408:fc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Fri, 9 Jun 2023 23:11:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.25 via Frontend Transport; Fri, 9 Jun 2023 23:11:52 +0000
Received: from amd-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 18:11:51 -0500
From:   Baskaran Kannan <Baski.Kannan@amd.com>
To:     <Mario.Limonciello@amd.com>, <babu.moger@amd.com>,
        <baski.kannan@amd.com>, <clemens@ladisch.de>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Enable AMD3255 Proc to show negative temperature
Date:   Fri, 9 Jun 2023 18:11:39 -0500
Message-ID: <20230609231139.3006-1-Baski.Kannan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|MW4PR12MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 3967b918-37aa-4461-e90d-08db693ee92f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pd69VoZHMgrQn+5JVj71DBgZIq6AWWK0a85kQwaTl43AS6GFSvPiN/n3r7MUvFWkB2wPxbOqaWHgabgEVMkgmB+eh4YDy3N2pLJweidfk8a/oCTcg07qBg5lqd9RL81KOwYK53EAaMpnw5iyDCjICnSqswzLf6z/JUDt/DzJbNBx7Qiphu+LtSCyj37vddmr/NOWrbzqi60TDPTXbhnbFrHTPguv1ZoIiy2VEJ/TPPI0eTp8xXVX2IGuleERU4jrySzf+arPg/bZ59fnCsuWLr8rzEOXLlW3bQZvh2XRv1RMiTQXgnhK9CR2s2msJo1Nj0vNGIVi2rddm/Bpw+Nb4qHm5bllm29a20szfRybhw2o9hG/99pC2nbdCSVsZxmVyBVFRZUqRqroJuPRd9yUMP7ffE2rOVCoGPfRisnsC9pdPhAJ+TsGN1xFsjNgnmiQpe5Nz2oIDiKnTtr6v2oqNa+KIZq2be2Z3G9v4m8/Va+4pWUNrDdRuaivXWADKiC10MDUkhcWDAS862EIFBLyoLzLkz0ombAq8ISWAO7giKWswvH3HD8oDG5qhfiovHph89SRGsMs3Sxq2G+FQf02A1U0o0cUT7ihcMKjDV8a1OidP3InWgsitlgRTuRmSs6NppPwruEFMg1h7L57jLCAXJ0azAjuWhyRuQSsVVTpFBCltyKr4div6uLww1XyCz8MxzAlp8HL8G11mMzQXWEnAKnL5PWDODaLfV2r77TN5u5HA6urgP8fNhT61Z7t9tSqic/fPnW/+KqFQntnOgW1YEZOKxJOJ4DR/Wa7qfvxmmo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(8676002)(8936002)(5660300002)(70206006)(70586007)(316002)(41300700001)(110136005)(40480700001)(478600001)(40460700003)(2906002)(26005)(86362001)(16526019)(1076003)(186003)(81166007)(356005)(36756003)(7696005)(82740400003)(426003)(2616005)(336012)(47076005)(36860700001)(82310400005)(6666004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 23:11:52.3708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3967b918-37aa-4461-e90d-08db693ee92f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6681
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

From: Your Name <you@example.com>

Signed-off-by: Baski Kannan <Baski.Kannan@amd.com>
---
 drivers/hwmon/k10temp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 489ad0b1bc74..58e4d90de5e3 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -77,6 +77,11 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define ZEN_CUR_TEMP_RANGE_SEL_MASK		BIT(19)
 #define ZEN_CUR_TEMP_TJ_SEL_MASK		GENMASK(17, 16)
 
+/* AMD's Industrial processor 3255 supports temperature from -40 deg to 105 deg Celsius.
+ * Do not round off to zero for negative Tctl or Tdie values
+ */
+#define AMD_I3255_STR				"3255"
+
 struct k10temp_data {
 	struct pci_dev *pdev;
 	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
@@ -86,6 +91,7 @@ struct k10temp_data {
 	u32 show_temp;
 	bool is_zen;
 	u32 ccd_offset;
+	bool disp_negative; /*Flag set for AMD i3255. Family 17h, Model 0x0-0xf */
 };
 
 #define TCTL_BIT	0
@@ -204,9 +210,15 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 		switch (channel) {
 		case 0:		/* Tctl */
 			*val = get_raw_temp(data);
+			if (*val < 0 && (data->disp_negative == false) ){
+				*val = 0;
+			}
 			break;
 		case 1:		/* Tdie */
 			*val = get_raw_temp(data) - data->temp_offset;
+			if (*val < 0 && (data->disp_negative == false) ){
+				*val = 0;
+			}
 			break;
 		case 2 ... 13:		/* Tccd{1-12} */
 			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
@@ -401,6 +413,11 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	data->pdev = pdev;
 	data->show_temp |= BIT(TCTL_BIT);	/* Always show Tctl */
 
+	if (boot_cpu_data.x86 == 0x17 &&
+		strstr(boot_cpu_data.x86_model_id, AMD_I3255_STR)) {
+		data->disp_negative = true;
+	}
+
 	if (boot_cpu_data.x86 == 0x15 &&
 	    ((boot_cpu_data.x86_model & 0xf0) == 0x60 ||
 	     (boot_cpu_data.x86_model & 0xf0) == 0x70)) {
-- 
2.25.1

