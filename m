Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13968703C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244703AbjEOSTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244679AbjEOSS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:18:28 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on20616.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A282883F6;
        Mon, 15 May 2023 11:17:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuq6Udw+4uTF19emuhruZIAN1gGqEoafP8FMVw6SIDdxQEywYejkxPRuAO4pCEx4tohnFAjgkjsVu+ni4+ZmLGotPpOZA31kGfkFx7Rl30CSWXg115Z8xKw2qJ3KhR4USi80JOedWye9KLSBYdWeNEXgSsh50nP6CjNRsJady+fV1ECnXXXTmc1MjtaQ/mKLPLQvX+C8f6Eu5FRVUUpQ2u90wgyFGPtfNQ1XoK1M6EWsjbJN2UwWI71MB2nzhsOJg+nZ8MV6vZBy9mjkO1WlKyDMZDeZ6jLpvxz0x8inOe51GE/6vCq7VFJPvV6N4NIlzEMHQDPkNTvLUlrXRktjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqhkWZwDG5VioOSbhs4fYAQDv4nuNYRKeWh2V4DCCsA=;
 b=MZJfywDkK5pHrFV39jBSK5H1/Y5pmklKDmttI88QE8Nl7+W/zbX4qEw/ouE4ZXjv7+zgT1QEZWljDVBVxiYuJ4P6Pq64/SYzsXLVCf83ifxHgUu1f1Hne4lzyo+qBuQwzDw8wko1np+4yKhDhscmuOh8gUO4OSW1/xUXWZsrvEQsHpIEc9nm7eXvUfVTg6LEFmzU3MKrdTHqg48rrMGv48hsaJt8WxQ9sdCSUFNT1hOPmOXCK72T/7YUpixzT8bjuTtn1xop742QwvSWW/RL6QXPgRp+s+ld7FnQa7rP5IM2Q3fhSjBgvjC2k8VvguxKDOUPK+xwLvzf0qNNGdxE1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqhkWZwDG5VioOSbhs4fYAQDv4nuNYRKeWh2V4DCCsA=;
 b=WcAPUBgwYWjLTZE27j9DnBJ1ejiORLiS8DsE9yKPfVJY+W9ezrQgX5SsK8KpISwA+mJ/2DYNdl+H9ZBmxlUgYYOSjD2T7U3mlxwWdxbL15Yatft4dCpTRUUCtppuu4iGeRJDdVf+hLtoPbFk5aC+3clRixRzeo7N4sU1MD/nuXc=
Received: from BN9P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::16)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 18:17:47 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::72) by BN9P220CA0011.outlook.office365.com
 (2603:10b6:408:13e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 18:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 18:17:47 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 15 May 2023 13:17:43 -0500
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <davidgow@google.com>, <gsomlo@gmail.com>,
        <gerg@linux-m68k.org>, <hal.feng@starfivetech.com>,
        <hasegawa-hitomi@fujitsu.com>, <j.neuschaefer@gmx.net>,
        <joel@jms.id.au>, <kernel@esmil.dk>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <p.zabel@pengutronix.de>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <walker.chen@starfivetech.com>,
        <will@kernel.org>, <zhuyinbo@loongson.cn>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v14 7/8] spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
Date:   Mon, 15 May 2023 11:16:05 -0700
Message-ID: <20230515181606.65953-8-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230515181606.65953-1-blarson@amd.com>
References: <20230515181606.65953-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fafd6c0-7389-4e27-f381-08db5570af98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uxysr0xdNe4uJ9ETbgW0IpQSKqgQn75WlDwPtev7xoQ7ihux+oNceRVsvNWUfFu495BhlbiDNLdsyZrZH1L1fmBtIK7BsgYT5+cDhYUrMsyGEZZiU5yLIbWnAm9hdnyvcod4aUgKvL9yHmQVJMghsmeOAN65dnuWesq+y/FwaJka3sNHnsu2NTSMdLlvvcvIiLmhJZAilU2l6Y/ejhe/blv0lIuvJh4rbtqqSCEXo48nLXG+eeA1P/2vCl+jOBG0PT8s24FB6ShoBJDT89DfZ/Wo4ZQjH4yQsMK169SeoEXnnE74SUfwe2dsC8F15bdu38cQO4kJeiG6kh5zmgYulQ1hSNg2QjO00/GxQCX+9EvAKVptKO3VtMuVAGTOX55mAcU46O2it6O/2JaDUu1yQGudAcnHQYBRDSBCt9Brtjx1OKhQ/dh9Lom3w0DMp67lhCI2MqLxEBnEBkDKBhz39gR2TpKKN9hSClJBUvo9XkeKqGDA4FEarcXM7gI2IDqg37ghHwHfe5kZmQIDZDR74wzBMz2zB6+yS0d+ZgPzSYb14ggAl40y1tjssrF6iPqft3WwPmC450D4+krA6XjE6nDg66uewAHVKDK0xexB6f7aSmTW32zbwQKjbns3PWuR1XZPmsJwpfsfnl6jnVKp+ZLijFA2txY4TS20Q/1TXl968W8bIjfg+h3DsQzj80SQKy9amHbcuMc5Z2qRLxbz7uE4FdUVqMFNomIwF3cfhqy2ApXletYAv60L2ACnn2Cc4xX0UywSRuCT5shVDjEzqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(7406005)(2906002)(40460700003)(356005)(316002)(41300700001)(5660300002)(8936002)(7416002)(8676002)(36756003)(82310400005)(81166007)(40480700001)(6666004)(36860700001)(478600001)(426003)(336012)(1076003)(26005)(16526019)(186003)(2616005)(4326008)(47076005)(6916009)(82740400003)(70206006)(70586007)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 18:17:47.3166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fafd6c0-7389-4e27-f381-08db5570af98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD Pensando Elba SoC has the Cadence QSPI controller integrated.

The quirk CQSPI_NEEDS_APB_AHB_HAZARD_WAR is added and if enabled
a dummy readback from the controller is performed to ensure
synchronization.

Signed-off-by: Brad Larson <blarson@amd.com>
---

v14 changes:
- Rebase to linux-next 6.4.0-rc1

v9 changes:
- Rebase to linux-next 6.2.0-rc1

---
 drivers/spi/spi-cadence-quadspi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 6ddb2dfc0f00..620316ab70ef 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -40,6 +40,7 @@
 #define CQSPI_SUPPORT_EXTERNAL_DMA	BIT(2)
 #define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(3)
 #define CQSPI_SLOW_SRAM		BIT(4)
+#define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -90,6 +91,7 @@ struct cqspi_st {
 	u32			pd_dev_id;
 	bool			wr_completion;
 	bool			slow_sram;
+	bool			apb_ahb_hazard;
 };
 
 struct cqspi_driver_platdata {
@@ -1027,6 +1029,13 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	if (cqspi->wr_delay)
 		ndelay(cqspi->wr_delay);
 
+	/*
+	 * If a hazard exists between the APB and AHB interfaces, perform a
+	 * dummy readback from the controller to ensure synchronization.
+	 */
+	if (cqspi->apb_ahb_hazard)
+		readl(reg_base + CQSPI_REG_INDIRECTWR);
+
 	while (remaining > 0) {
 		size_t write_words, mod_bytes;
 
@@ -1754,6 +1763,8 @@ static int cqspi_probe(struct platform_device *pdev)
 			cqspi->wr_completion = false;
 		if (ddata->quirks & CQSPI_SLOW_SRAM)
 			cqspi->slow_sram = true;
+		if (ddata->quirks & CQSPI_NEEDS_APB_AHB_HAZARD_WAR)
+			cqspi->apb_ahb_hazard = true;
 
 		if (of_device_is_compatible(pdev->dev.of_node,
 					    "xlnx,versal-ospi-1.0"))
@@ -1885,6 +1896,10 @@ static const struct cqspi_driver_platdata jh7110_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE,
 };
 
+static const struct cqspi_driver_platdata pensando_cdns_qspi = {
+	.quirks = CQSPI_NEEDS_APB_AHB_HAZARD_WAR | CQSPI_DISABLE_DAC_MODE,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -1914,6 +1929,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
 		.compatible = "starfive,jh7110-qspi",
 		.data = &jh7110_qspi,
 	},
+	{
+		.compatible = "amd,pensando-elba-qspi",
+		.data = &pensando_cdns_qspi,
+	},
 	{ /* end of table */ }
 };
 
-- 
2.17.1

