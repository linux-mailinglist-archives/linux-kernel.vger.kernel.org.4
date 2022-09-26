Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC865E9CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiIZJKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbiIZJKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:10:42 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BB237FAD;
        Mon, 26 Sep 2022 02:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu+nn4RxLOrOLEbD2OECqtcAG7h7J2GDGbhXghKQhWfVqEqEjlRg7gKN7LX6cg67HuFsWPCtmE/0LbprDJlkeH6EbnPylpaqBf84Gy4Uc/+ZFEofgszoISvn7gX0R0swOH6re0rWB3JcA9hx9kcrT9Chf7V3f8ARa9fWXL2aT/hhgequrIWthWQ9Jxoc7L5H/R5HZyBZyGtdTxXhtFl91Ms0Rpt8jymiMcVD5oeSXO2MNXprmmOm+EPlwxNgcCP3cSLGGhNazMsMI7aCQGD0ERbwS2bAftIaBNnju6apuductEfNzTqZGfIjsLIWX+6aEvhlHE6sx74/LBzWrCWebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usPwwykW6rjBL5AOSLSMbjC2PBwWdMR+9wwcGSmudpw=;
 b=eudsGRvL+eTNVKYuCo/HGaxLmFYwURd9ai64o93ZDSFPEwL/kjGUjwSBkhYW2etp8mwB0OoMrxY9+bH1gTKZhRGa9YHn8QkS6GdNRatfFdYTaHkxB/ZuxCKG6JCdFiJ8sTwWtbo0aOiDamUP/s//X2512M6tTcAI0h/dzIrgYFzYyq7roZvPcwc5clJ0X6So67j8nP5Mx8oJmA8IIxlL9GH/gbwnrXjcn0FqUdjSlBLNsiNZUXOZYjGqGgq79lTD8VOjxv7AQIn3mWO12Ey+lf3bxnnqIArQUn11YycBXfy/9f4J07HJ0mrhfkhQFyfNAQjlADrnwWin+Q+DLlCh/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usPwwykW6rjBL5AOSLSMbjC2PBwWdMR+9wwcGSmudpw=;
 b=QLg3saR3G9XhwNlNGHZzImxGTcjj52LJd1BZIvdvbRy1orGIDLMRQejmKzgON4nXOHfOsMrW0jA4zvLL8TbfxJuNrTZOrE0gXvtdCQz3lJ1bJwSj8+XmqpohNo4EWijd4PKEpQ7GQhzaIbdnBLCN8lWL5T31acDK2vq6Fviqiq2hN5xXC4ZJRiJTBsBk21y/Xt15DvI0Aovnb3y9IBDRZ7Oo42MRXeSDjX9Ybqtw6C4i2clf94Ewjqo+veLG0NUgRy8Tsbcjl1biQwk5P3EGrD+t1at1b74fAnNdc8/23R/MZ9T4SbKo7IQJhermHabrGqLtQjX90LeLC/A02YxwgA==
Received: from BN9PR03CA0972.namprd03.prod.outlook.com (2603:10b6:408:109::17)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 09:10:35 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::6c) by BN9PR03CA0972.outlook.office365.com
 (2603:10b6:408:109::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 09:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 09:10:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 02:10:23 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 02:10:22 -0700
Received: from build-petlozup-20220913T015306864.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via
 Frontend Transport; Mon, 26 Sep 2022 02:10:22 -0700
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
        <p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
        <ulf.hansson@linaro.org>, <kkartik@nvidia.com>,
        <cai.huoqing@linux.dev>, <spatra@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <petlozup@nvidia.com>
Subject: [PATCH v5] soc/tegra: pmc: Add IO Pad table for tegra234
Date:   Mon, 26 Sep 2022 09:10:20 +0000
Message-ID: <20220926091020.3261593-1-petlozup@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|BL3PR12MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d866b2-86c7-4131-86bf-08da9f9ef90e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhXTSMozqlpNdy2tsZOvflO+BwFryQnan0xwUPB/wA9AeU/qSDLPnbnOu+jadAclVOCnVe5dniNN0SoS/NKutgis7KcOJVOCqIb3qaGrYzi3GlfgCUhSs0/bZhnl16Q4xvZnFO8/Bu+DsHm7aW7pmYQS3r3fP65k252LBHdFnOaJLH0JoBYiGQgNbR3KmIE/8l983wADtLkE0GvQsL/N/8Q2eoMSBqzt0pdNiPHxdvDst6yAmiej+8g5texFhWC55VQZJ4wqh3DVlet3cKDBYQ0oGOOk1XwsDs8elhSuvvFn77XUmNl1RjEJmd2XzDcXZGQcWAtcin0yhAAmabl74ya/0L+7MlgqoMhyDWQJZoVphAqbmSJ6j+l1MkQ9cafK4sFnv9FXKS8gbtCcIVKaOrzm7ROm6SUOaSZcZqrdAtp4PAvtZ38BI0fOBLL/7AFidLrCg6D9lknQZvwfau+xH7qGO0ewHXEF8XfArPy0X3hYN4AXDlqBOYICWfB/BcP6MmcTv5URAxW4A5yW4GD5BcKweAPjl+KEf+f//UnquQO5PnoiHdHeQD3azwIGu8YN3enL1ISuZkiXvL7RsxEANCTwsnrWDJvJEKzru+V2E+7O3gErM4KD0owv4sZmnE2EP/A1hbJ8GSCIQo9mN/kBfBV6WhVLzNuu6BV14tpXOXNyzy1NhFoAYjFWUyIcIecsyEycxrIhk55olUK9f0XiGGxzzI7MOn+7I+9MSzZXkE/7myAGpn1r6wgAkVg7YvCVPDeeNG+s3YAEgOZBgvn1iGSFCQZmeqYXzk2O3/qpYxc=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(86362001)(921005)(356005)(36756003)(7636003)(40460700003)(110136005)(82740400003)(4326008)(8676002)(70206006)(70586007)(30864003)(2906002)(8936002)(5660300002)(40480700001)(426003)(47076005)(316002)(36860700001)(2616005)(186003)(336012)(1076003)(7696005)(26005)(478600001)(107886003)(41300700001)(82310400005)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 09:10:35.6443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d866b2-86c7-4131-86bf-08da9f9ef90e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IO PAD table for tegra234 to allow configuring dpd mode
and switching the pins to 1.8V or 3.3V as needed.

In tegra234, DPD registers are reorganized such that there is
a DPD_REQ register and a DPD_STATUS register per pad group.
This change accordingly updates the PMC driver.

Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
v3->v4:
* Addressing the review comments from Thierry Reding.
v4->v5:
* Remove dpd request and status variables from "struct tegra_pmc_regs"
  as they are no longer needed.
---
 drivers/soc/tegra/pmc.c | 707 +++++++++++++++++++++++++---------------
 1 file changed, 439 insertions(+), 268 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 5611d14d3ba2..a27870fe917a 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -269,16 +269,14 @@ struct tegra_powergate {
 struct tegra_io_pad_soc {
 	enum tegra_io_pad id;
 	unsigned int dpd;
+	unsigned int request;
+	unsigned int status;
 	unsigned int voltage;
 	const char *name;
 };
 
 struct tegra_pmc_regs {
 	unsigned int scratch0;
-	unsigned int dpd_req;
-	unsigned int dpd_status;
-	unsigned int dpd2_req;
-	unsigned int dpd2_status;
 	unsigned int rst_status;
 	unsigned int rst_source_shift;
 	unsigned int rst_source_mask;
@@ -1529,46 +1527,21 @@ tegra_io_pad_find(struct tegra_pmc *pmc, enum tegra_io_pad id)
 	return NULL;
 }
 
-static int tegra_io_pad_get_dpd_register_bit(struct tegra_pmc *pmc,
-					     enum tegra_io_pad id,
-					     unsigned long *request,
-					     unsigned long *status,
-					     u32 *mask)
-{
-	const struct tegra_io_pad_soc *pad;
-
-	pad = tegra_io_pad_find(pmc, id);
-	if (!pad) {
-		dev_err(pmc->dev, "invalid I/O pad ID %u\n", id);
-		return -ENOENT;
-	}
-
-	if (pad->dpd == UINT_MAX)
-		return -ENOTSUPP;
-
-	*mask = BIT(pad->dpd % 32);
-
-	if (pad->dpd < 32) {
-		*status = pmc->soc->regs->dpd_status;
-		*request = pmc->soc->regs->dpd_req;
-	} else {
-		*status = pmc->soc->regs->dpd2_status;
-		*request = pmc->soc->regs->dpd2_req;
-	}
-
-	return 0;
-}
-
-static int tegra_io_pad_prepare(struct tegra_pmc *pmc, enum tegra_io_pad id,
-				unsigned long *request, unsigned long *status,
+static int tegra_io_pad_prepare(struct tegra_pmc *pmc,
+				const struct tegra_io_pad_soc *pad,
+				unsigned long *request,
+				unsigned long *status,
 				u32 *mask)
 {
 	unsigned long rate, value;
 	int err;
 
-	err = tegra_io_pad_get_dpd_register_bit(pmc, id, request, status, mask);
-	if (err)
-		return err;
+	if (pad->dpd == UINT_MAX)
+		return -EINVAL;
+
+	*request = pad->request;
+	*status = pad->status;
+	*mask = BIT(pad->dpd);
 
 	if (pmc->clk) {
 		rate = pmc->rate;
@@ -1620,13 +1593,20 @@ static void tegra_io_pad_unprepare(struct tegra_pmc *pmc)
  */
 int tegra_io_pad_power_enable(enum tegra_io_pad id)
 {
+	const struct tegra_io_pad_soc *pad;
 	unsigned long request, status;
 	u32 mask;
 	int err;
 
+	pad = tegra_io_pad_find(pmc, id);
+	if (!pad) {
+		dev_err(pmc->dev, "invalid I/O pad ID %u\n", id);
+		return -ENOENT;
+	}
+
 	mutex_lock(&pmc->powergates_lock);
 
-	err = tegra_io_pad_prepare(pmc, id, &request, &status, &mask);
+	err = tegra_io_pad_prepare(pmc, pad, &request, &status, &mask);
 	if (err < 0) {
 		dev_err(pmc->dev, "failed to prepare I/O pad: %d\n", err);
 		goto unlock;
@@ -1656,13 +1636,20 @@ EXPORT_SYMBOL(tegra_io_pad_power_enable);
  */
 int tegra_io_pad_power_disable(enum tegra_io_pad id)
 {
+	const struct tegra_io_pad_soc *pad;
 	unsigned long request, status;
 	u32 mask;
 	int err;
 
+	pad = tegra_io_pad_find(pmc, id);
+	if (!pad) {
+		dev_err(pmc->dev, "invalid I/O pad ID %u\n", id);
+		return -ENOENT;
+	}
+
 	mutex_lock(&pmc->powergates_lock);
 
-	err = tegra_io_pad_prepare(pmc, id, &request, &status, &mask);
+	err = tegra_io_pad_prepare(pmc, pad, &request, &status, &mask);
 	if (err < 0) {
 		dev_err(pmc->dev, "failed to prepare I/O pad: %d\n", err);
 		goto unlock;
@@ -1686,14 +1673,21 @@ EXPORT_SYMBOL(tegra_io_pad_power_disable);
 
 static int tegra_io_pad_is_powered(struct tegra_pmc *pmc, enum tegra_io_pad id)
 {
-	unsigned long request, status;
+	const struct tegra_io_pad_soc *pad;
+	unsigned long status;
 	u32 mask, value;
-	int err;
 
-	err = tegra_io_pad_get_dpd_register_bit(pmc, id, &request, &status,
-						&mask);
-	if (err)
-		return err;
+	pad = tegra_io_pad_find(pmc, id);
+	if (!pad) {
+		dev_err(pmc->dev, "invalid I/O pad ID %u\n", id);
+		return -ENOENT;
+	}
+
+	if (pad->dpd == UINT_MAX)
+		return -EINVAL;
+
+	status = pad->status;
+	mask = BIT(pad->dpd);
 
 	value = tegra_pmc_readl(pmc, status);
 
@@ -3038,10 +3032,6 @@ static const char * const tegra20_powergates[] = {
 
 static const struct tegra_pmc_regs tegra20_pmc_regs = {
 	.scratch0 = 0x50,
-	.dpd_req = 0x1b8,
-	.dpd_status = 0x1bc,
-	.dpd2_req = 0x1c0,
-	.dpd2_status = 0x1c4,
 	.rst_status = 0x1b4,
 	.rst_source_shift = 0x0,
 	.rst_source_mask = 0x7,
@@ -3285,60 +3275,91 @@ static const u8 tegra124_cpu_powergates[] = {
 	TEGRA_POWERGATE_CPU3,
 };
 
-#define TEGRA_IO_PAD(_id, _dpd, _voltage, _name)	\
-	((struct tegra_io_pad_soc) {			\
-		.id	= (_id),			\
-		.dpd	= (_dpd),			\
-		.voltage = (_voltage),			\
-		.name	= (_name),			\
+#define TEGRA_IO_PAD(_id, _dpd, _request, _status, _voltage, _name)	\
+	((struct tegra_io_pad_soc) {					\
+		.id		= (_id),				\
+		.dpd		= (_dpd),				\
+		.request	= (_request),				\
+		.status		= (_status),				\
+		.voltage	= (_voltage),				\
+		.name		= (_name),				\
 	})
 
-#define TEGRA_IO_PIN_DESC(_id, _dpd, _voltage, _name)	\
-	((struct pinctrl_pin_desc) {			\
-		.number = (_id),			\
-		.name	= (_name)			\
+#define TEGRA_IO_PIN_DESC(_id, _dpd, _request, _status, _voltage, _name) \
+	((struct pinctrl_pin_desc) {					 \
+		.number = (_id),					 \
+		.name	= (_name)					 \
 	})
 
-#define TEGRA124_IO_PAD_TABLE(_pad)                                   \
-	/* .id                          .dpd  .voltage  .name */      \
-	_pad(TEGRA_IO_PAD_AUDIO,        17,   UINT_MAX, "audio"),     \
-	_pad(TEGRA_IO_PAD_BB,           15,   UINT_MAX, "bb"),        \
-	_pad(TEGRA_IO_PAD_CAM,          36,   UINT_MAX, "cam"),       \
-	_pad(TEGRA_IO_PAD_COMP,         22,   UINT_MAX, "comp"),      \
-	_pad(TEGRA_IO_PAD_CSIA,         0,    UINT_MAX, "csia"),      \
-	_pad(TEGRA_IO_PAD_CSIB,         1,    UINT_MAX, "csb"),       \
-	_pad(TEGRA_IO_PAD_CSIE,         44,   UINT_MAX, "cse"),       \
-	_pad(TEGRA_IO_PAD_DSI,          2,    UINT_MAX, "dsi"),       \
-	_pad(TEGRA_IO_PAD_DSIB,         39,   UINT_MAX, "dsib"),      \
-	_pad(TEGRA_IO_PAD_DSIC,         40,   UINT_MAX, "dsic"),      \
-	_pad(TEGRA_IO_PAD_DSID,         41,   UINT_MAX, "dsid"),      \
-	_pad(TEGRA_IO_PAD_HDMI,         28,   UINT_MAX, "hdmi"),      \
-	_pad(TEGRA_IO_PAD_HSIC,         19,   UINT_MAX, "hsic"),      \
-	_pad(TEGRA_IO_PAD_HV,           38,   UINT_MAX, "hv"),        \
-	_pad(TEGRA_IO_PAD_LVDS,         57,   UINT_MAX, "lvds"),      \
-	_pad(TEGRA_IO_PAD_MIPI_BIAS,    3,    UINT_MAX, "mipi-bias"), \
-	_pad(TEGRA_IO_PAD_NAND,         13,   UINT_MAX, "nand"),      \
-	_pad(TEGRA_IO_PAD_PEX_BIAS,     4,    UINT_MAX, "pex-bias"),  \
-	_pad(TEGRA_IO_PAD_PEX_CLK1,     5,    UINT_MAX, "pex-clk1"),  \
-	_pad(TEGRA_IO_PAD_PEX_CLK2,     6,    UINT_MAX, "pex-clk2"),  \
-	_pad(TEGRA_IO_PAD_PEX_CNTRL,    32,   UINT_MAX, "pex-cntrl"), \
-	_pad(TEGRA_IO_PAD_SDMMC1,       33,   UINT_MAX, "sdmmc1"),    \
-	_pad(TEGRA_IO_PAD_SDMMC3,       34,   UINT_MAX, "sdmmc3"),    \
-	_pad(TEGRA_IO_PAD_SDMMC4,       35,   UINT_MAX, "sdmmc4"),    \
-	_pad(TEGRA_IO_PAD_SYS_DDC,      58,   UINT_MAX, "sys_ddc"),   \
-	_pad(TEGRA_IO_PAD_UART,         14,   UINT_MAX, "uart"),      \
-	_pad(TEGRA_IO_PAD_USB0,         9,    UINT_MAX, "usb0"),      \
-	_pad(TEGRA_IO_PAD_USB1,         10,   UINT_MAX, "usb1"),      \
-	_pad(TEGRA_IO_PAD_USB2,         11,   UINT_MAX, "usb2"),      \
-	_pad(TEGRA_IO_PAD_USB_BIAS,     12,   UINT_MAX, "usb_bias")
-
-static const struct tegra_io_pad_soc tegra124_io_pads[] = {
-	TEGRA124_IO_PAD_TABLE(TEGRA_IO_PAD)
-};
+#define TEGRA124_IO_PAD_TABLE(_pad) {                                     \
+	/* (.id, .dpd, .request, .status, .voltage, .name) */             \
+	_pad(TEGRA_IO_PAD_AUDIO,        17,   0x1b8,   0x1bc,             \
+		UINT_MAX, "audio"),                                       \
+	_pad(TEGRA_IO_PAD_BB,           15,   0x1b8,   0x1bc,             \
+		UINT_MAX, "bb"),                                          \
+	_pad(TEGRA_IO_PAD_CAM,          4,    0x1c0,   0x1c4,             \
+		UINT_MAX, "cam"),                                         \
+	_pad(TEGRA_IO_PAD_COMP,         22,   0x1b8,   0x1bc,             \
+		UINT_MAX, "comp"),                                        \
+	_pad(TEGRA_IO_PAD_CSIA,         0,    0x1b8,   0x1bc,             \
+		UINT_MAX, "csia"),                                        \
+	_pad(TEGRA_IO_PAD_CSIB,         1,    0x1b8,   0x1bc,             \
+		UINT_MAX, "csb"),                                         \
+	_pad(TEGRA_IO_PAD_CSIE,         12,   0x1c0,   0x1c4,             \
+		UINT_MAX, "cse"),                                         \
+	_pad(TEGRA_IO_PAD_DSI,          2,    0x1b8,   0x1bc,             \
+		UINT_MAX, "dsi"),                                         \
+	_pad(TEGRA_IO_PAD_DSIB,         7,    0x1c0,   0x1c4,             \
+		UINT_MAX, "dsib"),                                        \
+	_pad(TEGRA_IO_PAD_DSIC,         8,    0x1c0,   0x1c4,             \
+		UINT_MAX, "dsic"),                                        \
+	_pad(TEGRA_IO_PAD_DSID,         9,    0x1c0,   0x1c4,             \
+		UINT_MAX, "dsid"),                                        \
+	_pad(TEGRA_IO_PAD_HDMI,         28,   0x1b8,   0x1bc,             \
+		UINT_MAX, "hdmi"),                                        \
+	_pad(TEGRA_IO_PAD_HSIC,         19,   0x1b8,   0x1bc,             \
+		UINT_MAX, "hsic"),                                        \
+	_pad(TEGRA_IO_PAD_HV,           6,    0x1c0,   0x1c4,             \
+		UINT_MAX, "hv"),                                          \
+	_pad(TEGRA_IO_PAD_LVDS,         25,   0x1c0,   0x1c4,             \
+		UINT_MAX, "lvds"),                                        \
+	_pad(TEGRA_IO_PAD_MIPI_BIAS,    3,    0x1b8,   0x1bc,             \
+		UINT_MAX, "mipi-bias"),                                   \
+	_pad(TEGRA_IO_PAD_NAND,         13,   0x1b8,   0x1bc,             \
+		UINT_MAX, "nand"),                                        \
+	_pad(TEGRA_IO_PAD_PEX_BIAS,     4,    0x1b8,   0x1bc,             \
+		UINT_MAX, "pex-bias"),                                    \
+	_pad(TEGRA_IO_PAD_PEX_CLK1,     5,    0x1b8,   0x1bc,             \
+		UINT_MAX, "pex-clk1"),                                    \
+	_pad(TEGRA_IO_PAD_PEX_CLK2,     6,    0x1b8,   0x1bc,             \
+		UINT_MAX, "pex-clk2"),                                    \
+	_pad(TEGRA_IO_PAD_PEX_CNTRL,    0,    0x1c0,   0x1c4,             \
+		UINT_MAX, "pex-cntrl"),                                   \
+	_pad(TEGRA_IO_PAD_SDMMC1,       1,    0x1c0,   0x1c4,             \
+		UINT_MAX, "sdmmc1"),                                      \
+	_pad(TEGRA_IO_PAD_SDMMC3,       2,    0x1c0,   0x1c4,             \
+		UINT_MAX, "sdmmc3"),                                      \
+	_pad(TEGRA_IO_PAD_SDMMC4,       3,    0x1c0,   0x1c4,             \
+		UINT_MAX, "sdmmc4"),                                      \
+	_pad(TEGRA_IO_PAD_SYS_DDC,      26,   0x1c0,   0x1c4,             \
+		UINT_MAX, "sys_ddc"),                                     \
+	_pad(TEGRA_IO_PAD_UART,         14,   0x1b8,   0x1bc,             \
+		UINT_MAX, "uart"),                                        \
+	_pad(TEGRA_IO_PAD_USB0,         9,    0x1b8,   0x1bc,             \
+		UINT_MAX, "usb0"),                                        \
+	_pad(TEGRA_IO_PAD_USB1,         10,   0x1b8,   0x1bc,             \
+		UINT_MAX, "usb1"),                                        \
+	_pad(TEGRA_IO_PAD_USB2,         11,   0x1b8,   0x1bc,             \
+		UINT_MAX, "usb2"),                                        \
+	_pad(TEGRA_IO_PAD_USB_BIAS,     12,   0x1b8,   0x1bc,             \
+		UINT_MAX, "usb_bias")                                     \
+	}
 
-static const struct pinctrl_pin_desc tegra124_pin_descs[] = {
-	TEGRA124_IO_PAD_TABLE(TEGRA_IO_PIN_DESC)
-};
+static const struct tegra_io_pad_soc tegra124_io_pads[] =
+	TEGRA124_IO_PAD_TABLE(TEGRA_IO_PAD);
+
+static const struct pinctrl_pin_desc tegra124_pin_descs[] =
+	TEGRA124_IO_PAD_TABLE(TEGRA_IO_PIN_DESC);
 
 static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.supports_core_domain = false,
@@ -3403,54 +3424,91 @@ static const u8 tegra210_cpu_powergates[] = {
 	TEGRA_POWERGATE_CPU3,
 };
 
-#define TEGRA210_IO_PAD_TABLE(_pad)                                        \
-	/*   .id                        .dpd     .voltage  .name */        \
-	_pad(TEGRA_IO_PAD_AUDIO,       17,       5,        "audio"),       \
-	_pad(TEGRA_IO_PAD_AUDIO_HV,    61,       18,       "audio-hv"),    \
-	_pad(TEGRA_IO_PAD_CAM,         36,       10,       "cam"),         \
-	_pad(TEGRA_IO_PAD_CSIA,        0,        UINT_MAX, "csia"),        \
-	_pad(TEGRA_IO_PAD_CSIB,        1,        UINT_MAX, "csib"),        \
-	_pad(TEGRA_IO_PAD_CSIC,        42,       UINT_MAX, "csic"),        \
-	_pad(TEGRA_IO_PAD_CSID,        43,       UINT_MAX, "csid"),        \
-	_pad(TEGRA_IO_PAD_CSIE,        44,       UINT_MAX, "csie"),        \
-	_pad(TEGRA_IO_PAD_CSIF,        45,       UINT_MAX, "csif"),        \
-	_pad(TEGRA_IO_PAD_DBG,         25,       19,       "dbg"),         \
-	_pad(TEGRA_IO_PAD_DEBUG_NONAO, 26,       UINT_MAX, "debug-nonao"), \
-	_pad(TEGRA_IO_PAD_DMIC,        50,       20,       "dmic"),        \
-	_pad(TEGRA_IO_PAD_DP,          51,       UINT_MAX, "dp"),          \
-	_pad(TEGRA_IO_PAD_DSI,         2,        UINT_MAX, "dsi"),         \
-	_pad(TEGRA_IO_PAD_DSIB,        39,       UINT_MAX, "dsib"),        \
-	_pad(TEGRA_IO_PAD_DSIC,        40,       UINT_MAX, "dsic"),        \
-	_pad(TEGRA_IO_PAD_DSID,        41,       UINT_MAX, "dsid"),        \
-	_pad(TEGRA_IO_PAD_EMMC,        35,       UINT_MAX, "emmc"),        \
-	_pad(TEGRA_IO_PAD_EMMC2,       37,       UINT_MAX, "emmc2"),       \
-	_pad(TEGRA_IO_PAD_GPIO,        27,       21,       "gpio"),        \
-	_pad(TEGRA_IO_PAD_HDMI,        28,       UINT_MAX, "hdmi"),        \
-	_pad(TEGRA_IO_PAD_HSIC,        19,       UINT_MAX, "hsic"),        \
-	_pad(TEGRA_IO_PAD_LVDS,        57,       UINT_MAX, "lvds"),        \
-	_pad(TEGRA_IO_PAD_MIPI_BIAS,   3,        UINT_MAX, "mipi-bias"),   \
-	_pad(TEGRA_IO_PAD_PEX_BIAS,    4,        UINT_MAX, "pex-bias"),    \
-	_pad(TEGRA_IO_PAD_PEX_CLK1,    5,        UINT_MAX, "pex-clk1"),    \
-	_pad(TEGRA_IO_PAD_PEX_CLK2,    6,        UINT_MAX, "pex-clk2"),    \
-	_pad(TEGRA_IO_PAD_PEX_CNTRL,   UINT_MAX, 11,       "pex-cntrl"),   \
-	_pad(TEGRA_IO_PAD_SDMMC1,      33,       12,       "sdmmc1"),      \
-	_pad(TEGRA_IO_PAD_SDMMC3,      34,       13,       "sdmmc3"),      \
-	_pad(TEGRA_IO_PAD_SPI,         46,       22,       "spi"),         \
-	_pad(TEGRA_IO_PAD_SPI_HV,      47,       23,       "spi-hv"),      \
-	_pad(TEGRA_IO_PAD_UART,        14,       2,        "uart"),        \
-	_pad(TEGRA_IO_PAD_USB0,        9,        UINT_MAX, "usb0"),        \
-	_pad(TEGRA_IO_PAD_USB1,        10,       UINT_MAX, "usb1"),        \
-	_pad(TEGRA_IO_PAD_USB2,        11,       UINT_MAX, "usb2"),        \
-	_pad(TEGRA_IO_PAD_USB3,        18,       UINT_MAX, "usb3"),        \
-	_pad(TEGRA_IO_PAD_USB_BIAS,    12,       UINT_MAX, "usb-bias")
-
-static const struct tegra_io_pad_soc tegra210_io_pads[] = {
-	TEGRA210_IO_PAD_TABLE(TEGRA_IO_PAD)
-};
+#define TEGRA210_IO_PAD_TABLE(_pad) {                                      \
+	/* (.id, .dpd, .request, .status, .voltage, .name) */              \
+	_pad(TEGRA_IO_PAD_AUDIO,       17,       0x1b8,    0x1bc,          \
+		5,        "audio"),                                        \
+	_pad(TEGRA_IO_PAD_AUDIO_HV,    29,       0x1c0,    0x1c4,          \
+		18,       "audio-hv"),                                     \
+	_pad(TEGRA_IO_PAD_CAM,         4,        0x1c0,    0x1c4,          \
+		10,       "cam"),                                          \
+	_pad(TEGRA_IO_PAD_CSIA,        0,        0x1b8,    0x1bc,          \
+		UINT_MAX, "csia"),                                         \
+	_pad(TEGRA_IO_PAD_CSIB,        1,        0x1b8,    0x1bc,          \
+		UINT_MAX, "csib"),                                         \
+	_pad(TEGRA_IO_PAD_CSIC,        10,       0x1c0,    0x1c4,          \
+		UINT_MAX, "csic"),                                         \
+	_pad(TEGRA_IO_PAD_CSID,        11,       0x1c0,    0x1c4,          \
+		UINT_MAX, "csid"),                                         \
+	_pad(TEGRA_IO_PAD_CSIE,        12,       0x1c0,    0x1c4,          \
+		UINT_MAX, "csie"),                                         \
+	_pad(TEGRA_IO_PAD_CSIF,        13,       0x1c0,    0x1c4,          \
+		UINT_MAX, "csif"),                                         \
+	_pad(TEGRA_IO_PAD_DBG,         25,       0x1b8,    0x1bc,          \
+		19,       "dbg"),                                          \
+	_pad(TEGRA_IO_PAD_DEBUG_NONAO, 26,       0x1b8,    0x1bc,          \
+		UINT_MAX, "debug-nonao"),                                  \
+	_pad(TEGRA_IO_PAD_DMIC,        18,       0x1c0,    0x1c4,          \
+		20,       "dmic"),                                         \
+	_pad(TEGRA_IO_PAD_DP,          19,       0x1c0,    0x1c4,          \
+		UINT_MAX, "dp"),                                           \
+	_pad(TEGRA_IO_PAD_DSI,         2,        0x1b8,    0x1bc,          \
+		UINT_MAX, "dsi"),                                          \
+	_pad(TEGRA_IO_PAD_DSIB,        7,        0x1c0,    0x1c4,          \
+		UINT_MAX, "dsib"),                                         \
+	_pad(TEGRA_IO_PAD_DSIC,        8,        0x1c0,    0x1c4,          \
+		UINT_MAX, "dsic"),                                         \
+	_pad(TEGRA_IO_PAD_DSID,        9,        0x1c0,    0x1c4,          \
+		UINT_MAX, "dsid"),                                         \
+	_pad(TEGRA_IO_PAD_EMMC,        3,        0x1c0,    0x1c4,          \
+		UINT_MAX, "emmc"),                                         \
+	_pad(TEGRA_IO_PAD_EMMC2,       5,        0x1c0,    0x1c4,          \
+		UINT_MAX, "emmc2"),                                        \
+	_pad(TEGRA_IO_PAD_GPIO,        27,       0x1b8,    0x1bc,          \
+		21,       "gpio"),                                         \
+	_pad(TEGRA_IO_PAD_HDMI,        28,       0x1b8,    0x1bc,          \
+		UINT_MAX, "hdmi"),                                         \
+	_pad(TEGRA_IO_PAD_HSIC,        19,       0x1b8,    0x1bc,          \
+		UINT_MAX, "hsic"),                                         \
+	_pad(TEGRA_IO_PAD_LVDS,        25,       0x1c0,    0x1c4,          \
+		UINT_MAX, "lvds"),                                         \
+	_pad(TEGRA_IO_PAD_MIPI_BIAS,   3,        0x1b8,    0x1bc,          \
+		UINT_MAX, "mipi-bias"),                                    \
+	_pad(TEGRA_IO_PAD_PEX_BIAS,    4,        0x1b8,    0x1bc,          \
+		UINT_MAX, "pex-bias"),                                     \
+	_pad(TEGRA_IO_PAD_PEX_CLK1,    5,        0x1b8,    0x1bc,          \
+		UINT_MAX, "pex-clk1"),                                     \
+	_pad(TEGRA_IO_PAD_PEX_CLK2,    6,        0x1b8,    0x1bc,          \
+		UINT_MAX, "pex-clk2"),                                     \
+	_pad(TEGRA_IO_PAD_PEX_CNTRL,   UINT_MAX, UINT_MAX, UINT_MAX,       \
+		11,       "pex-cntrl"),                                    \
+	_pad(TEGRA_IO_PAD_SDMMC1,      1,        0x1c0,    0x1c4,          \
+		12,       "sdmmc1"),                                       \
+	_pad(TEGRA_IO_PAD_SDMMC3,      2,        0x1c0,    0x1c4,          \
+		13,       "sdmmc3"),                                       \
+	_pad(TEGRA_IO_PAD_SPI,         14,       0x1c0,    0x1c4,          \
+		22,       "spi"),                                          \
+	_pad(TEGRA_IO_PAD_SPI_HV,      15,       0x1c0,    0x1c4,          \
+		23,       "spi-hv"),                                       \
+	_pad(TEGRA_IO_PAD_UART,        14,       0x1b8,    0x1bc,          \
+		2,        "uart"),                                         \
+	_pad(TEGRA_IO_PAD_USB0,        9,        0x1b8,    0x1bc,          \
+		UINT_MAX, "usb0"),                                         \
+	_pad(TEGRA_IO_PAD_USB1,        10,       0x1b8,    0x1bc,          \
+		UINT_MAX, "usb1"),                                         \
+	_pad(TEGRA_IO_PAD_USB2,        11,       0x1b8,    0x1bc,          \
+		UINT_MAX, "usb2"),                                         \
+	_pad(TEGRA_IO_PAD_USB3,        18,       0x1b8,    0x1bc,          \
+		UINT_MAX, "usb3"),                                         \
+	_pad(TEGRA_IO_PAD_USB_BIAS,    12,       0x1b8,    0x1bc,          \
+		UINT_MAX, "usb-bias")                                      \
+	}
 
-static const struct pinctrl_pin_desc tegra210_pin_descs[] = {
-	TEGRA210_IO_PAD_TABLE(TEGRA_IO_PIN_DESC)
-};
+static const struct tegra_io_pad_soc tegra210_io_pads[] =
+	TEGRA210_IO_PAD_TABLE(TEGRA_IO_PAD);
+
+static const struct pinctrl_pin_desc tegra210_pin_descs[] =
+	TEGRA210_IO_PAD_TABLE(TEGRA_IO_PIN_DESC);
 
 static const char * const tegra210_reset_sources[] = {
 	"POWER_ON_RESET",
@@ -3499,61 +3557,94 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.has_usb_sleepwalk = true,
 };
 
-#define TEGRA186_IO_PAD_TABLE(_pad)                                          \
-	/*   .id                        .dpd      .voltage  .name */         \
-	_pad(TEGRA_IO_PAD_CSIA,         0,        UINT_MAX, "csia"),         \
-	_pad(TEGRA_IO_PAD_CSIB,         1,        UINT_MAX, "csib"),         \
-	_pad(TEGRA_IO_PAD_DSI,          2,        UINT_MAX, "dsi"),          \
-	_pad(TEGRA_IO_PAD_MIPI_BIAS,    3,        UINT_MAX, "mipi-bias"),    \
-	_pad(TEGRA_IO_PAD_PEX_CLK_BIAS, 4,        UINT_MAX, "pex-clk-bias"), \
-	_pad(TEGRA_IO_PAD_PEX_CLK3,     5,        UINT_MAX, "pex-clk3"),     \
-	_pad(TEGRA_IO_PAD_PEX_CLK2,     6,        UINT_MAX, "pex-clk2"),     \
-	_pad(TEGRA_IO_PAD_PEX_CLK1,     7,        UINT_MAX, "pex-clk1"),     \
-	_pad(TEGRA_IO_PAD_USB0,         9,        UINT_MAX, "usb0"),         \
-	_pad(TEGRA_IO_PAD_USB1,         10,       UINT_MAX, "usb1"),         \
-	_pad(TEGRA_IO_PAD_USB2,         11,       UINT_MAX, "usb2"),         \
-	_pad(TEGRA_IO_PAD_USB_BIAS,     12,       UINT_MAX, "usb-bias"),     \
-	_pad(TEGRA_IO_PAD_UART,         14,       UINT_MAX, "uart"),         \
-	_pad(TEGRA_IO_PAD_AUDIO,        17,       UINT_MAX, "audio"),        \
-	_pad(TEGRA_IO_PAD_HSIC,         19,       UINT_MAX, "hsic"),         \
-	_pad(TEGRA_IO_PAD_DBG,          25,       UINT_MAX, "dbg"),          \
-	_pad(TEGRA_IO_PAD_HDMI_DP0,     28,       UINT_MAX, "hdmi-dp0"),     \
-	_pad(TEGRA_IO_PAD_HDMI_DP1,     29,       UINT_MAX, "hdmi-dp1"),     \
-	_pad(TEGRA_IO_PAD_PEX_CNTRL,    32,       UINT_MAX, "pex-cntrl"),    \
-	_pad(TEGRA_IO_PAD_SDMMC2_HV,    34,       5,        "sdmmc2-hv"),    \
-	_pad(TEGRA_IO_PAD_SDMMC4,       36,       UINT_MAX, "sdmmc4"),       \
-	_pad(TEGRA_IO_PAD_CAM,          38,       UINT_MAX, "cam"),          \
-	_pad(TEGRA_IO_PAD_DSIB,         40,       UINT_MAX, "dsib"),         \
-	_pad(TEGRA_IO_PAD_DSIC,         41,       UINT_MAX, "dsic"),         \
-	_pad(TEGRA_IO_PAD_DSID,         42,       UINT_MAX, "dsid"),         \
-	_pad(TEGRA_IO_PAD_CSIC,         43,       UINT_MAX, "csic"),         \
-	_pad(TEGRA_IO_PAD_CSID,         44,       UINT_MAX, "csid"),         \
-	_pad(TEGRA_IO_PAD_CSIE,         45,       UINT_MAX, "csie"),         \
-	_pad(TEGRA_IO_PAD_CSIF,         46,       UINT_MAX, "csif"),         \
-	_pad(TEGRA_IO_PAD_SPI,          47,       UINT_MAX, "spi"),          \
-	_pad(TEGRA_IO_PAD_UFS,          49,       UINT_MAX, "ufs"),          \
-	_pad(TEGRA_IO_PAD_DMIC_HV,      52,       2,        "dmic-hv"),	     \
-	_pad(TEGRA_IO_PAD_EDP,          53,       UINT_MAX, "edp"),          \
-	_pad(TEGRA_IO_PAD_SDMMC1_HV,    55,       4,        "sdmmc1-hv"),    \
-	_pad(TEGRA_IO_PAD_SDMMC3_HV,    56,       6,        "sdmmc3-hv"),    \
-	_pad(TEGRA_IO_PAD_CONN,         60,       UINT_MAX, "conn"),         \
-	_pad(TEGRA_IO_PAD_AUDIO_HV,     61,       1,        "audio-hv"),     \
-	_pad(TEGRA_IO_PAD_AO_HV,        UINT_MAX, 0,        "ao-hv")
-
-static const struct tegra_io_pad_soc tegra186_io_pads[] = {
-	TEGRA186_IO_PAD_TABLE(TEGRA_IO_PAD)
-};
+#define TEGRA186_IO_PAD_TABLE(_pad) {                                        \
+	/* (.id, .dpd, .request, .status, .voltage, .name) */                \
+	_pad(TEGRA_IO_PAD_CSIA,         0,        0x74,     0x78,            \
+		UINT_MAX, "csia"),                                           \
+	_pad(TEGRA_IO_PAD_CSIB,         1,        0x74,     0x78,            \
+		UINT_MAX, "csib"),                                           \
+	_pad(TEGRA_IO_PAD_DSI,          2,        0x74,     0x78,            \
+		UINT_MAX, "dsi"),                                            \
+	_pad(TEGRA_IO_PAD_MIPI_BIAS,    3,        0x74,     0x78,            \
+		UINT_MAX, "mipi-bias"),                                      \
+	_pad(TEGRA_IO_PAD_PEX_CLK_BIAS, 4,        0x74,     0x78,            \
+		UINT_MAX, "pex-clk-bias"),                                   \
+	_pad(TEGRA_IO_PAD_PEX_CLK3,     5,        0x74,     0x78,            \
+		UINT_MAX, "pex-clk3"),                                       \
+	_pad(TEGRA_IO_PAD_PEX_CLK2,     6,        0x74,     0x78,            \
+		UINT_MAX, "pex-clk2"),                                       \
+	_pad(TEGRA_IO_PAD_PEX_CLK1,     7,        0x74,     0x78,            \
+		UINT_MAX, "pex-clk1"),                                       \
+	_pad(TEGRA_IO_PAD_USB0,         9,        0x74,     0x78,            \
+		UINT_MAX, "usb0"),                                           \
+	_pad(TEGRA_IO_PAD_USB1,         10,       0x74,     0x78,            \
+		UINT_MAX, "usb1"),                                           \
+	_pad(TEGRA_IO_PAD_USB2,         11,       0x74,     0x78,            \
+		UINT_MAX, "usb2"),                                           \
+	_pad(TEGRA_IO_PAD_USB_BIAS,     12,       0x74,     0x78,            \
+		UINT_MAX, "usb-bias"),                                       \
+	_pad(TEGRA_IO_PAD_UART,         14,       0x74,     0x78,            \
+		UINT_MAX, "uart"),                                           \
+	_pad(TEGRA_IO_PAD_AUDIO,        17,       0x74,     0x78,            \
+		UINT_MAX, "audio"),                                          \
+	_pad(TEGRA_IO_PAD_HSIC,         19,       0x74,     0x78,            \
+		UINT_MAX, "hsic"),                                           \
+	_pad(TEGRA_IO_PAD_DBG,          25,       0x74,     0x78,            \
+		UINT_MAX, "dbg"),                                            \
+	_pad(TEGRA_IO_PAD_HDMI_DP0,     28,       0x74,     0x78,            \
+		UINT_MAX, "hdmi-dp0"),                                       \
+	_pad(TEGRA_IO_PAD_HDMI_DP1,     29,       0x74,     0x78,            \
+		UINT_MAX, "hdmi-dp1"),                                       \
+	_pad(TEGRA_IO_PAD_PEX_CNTRL,    0,        0x7c,     0x80,            \
+		UINT_MAX, "pex-cntrl"),                                      \
+	_pad(TEGRA_IO_PAD_SDMMC2_HV,    2,        0x7c,     0x80,            \
+		5,        "sdmmc2-hv"),                                      \
+	_pad(TEGRA_IO_PAD_SDMMC4,       4,        0x7c,     0x80,            \
+		UINT_MAX, "sdmmc4"),                                         \
+	_pad(TEGRA_IO_PAD_CAM,          6,        0x7c,     0x80,            \
+		UINT_MAX, "cam"),                                            \
+	_pad(TEGRA_IO_PAD_DSIB,         8,        0x7c,     0x80,            \
+		UINT_MAX, "dsib"),                                           \
+	_pad(TEGRA_IO_PAD_DSIC,         9,        0x7c,     0x80,            \
+		UINT_MAX, "dsic"),                                           \
+	_pad(TEGRA_IO_PAD_DSID,         10,       0x7c,     0x80,            \
+		UINT_MAX, "dsid"),                                           \
+	_pad(TEGRA_IO_PAD_CSIC,         11,       0x7c,     0x80,            \
+		UINT_MAX, "csic"),                                           \
+	_pad(TEGRA_IO_PAD_CSID,         12,       0x7c,     0x80,            \
+		UINT_MAX, "csid"),                                           \
+	_pad(TEGRA_IO_PAD_CSIE,         13,       0x7c,     0x80,            \
+		UINT_MAX, "csie"),                                           \
+	_pad(TEGRA_IO_PAD_CSIF,         14,       0x7c,     0x80,            \
+		UINT_MAX, "csif"),                                           \
+	_pad(TEGRA_IO_PAD_SPI,          15,       0x7c,     0x80,            \
+		UINT_MAX, "spi"),                                            \
+	_pad(TEGRA_IO_PAD_UFS,          17,       0x7c,     0x80,            \
+		UINT_MAX, "ufs"),                                            \
+	_pad(TEGRA_IO_PAD_DMIC_HV,      20,       0x7c,     0x80,            \
+		2,        "dmic-hv"),                                        \
+	_pad(TEGRA_IO_PAD_EDP,          21,       0x7c,     0x80,            \
+		UINT_MAX, "edp"),                                            \
+	_pad(TEGRA_IO_PAD_SDMMC1_HV,    23,       0x7c,     0x80,            \
+		4,        "sdmmc1-hv"),                                      \
+	_pad(TEGRA_IO_PAD_SDMMC3_HV,    24,       0x7c,     0x80,            \
+		6,        "sdmmc3-hv"),                                      \
+	_pad(TEGRA_IO_PAD_CONN,         28,       0x7c,     0x80,            \
+		UINT_MAX, "conn"),                                           \
+	_pad(TEGRA_IO_PAD_AUDIO_HV,     29,       0x7c,     0x80,            \
+		1,        "audio-hv"),                                       \
+	_pad(TEGRA_IO_PAD_AO_HV,        UINT_MAX, UINT_MAX, UINT_MAX,        \
+		0,        "ao-hv")                                           \
+	}
 
-static const struct pinctrl_pin_desc tegra186_pin_descs[] = {
-	TEGRA186_IO_PAD_TABLE(TEGRA_IO_PIN_DESC)
-};
+static const struct tegra_io_pad_soc tegra186_io_pads[] =
+	TEGRA186_IO_PAD_TABLE(TEGRA_IO_PAD);
+
+static const struct pinctrl_pin_desc tegra186_pin_descs[] =
+	TEGRA186_IO_PAD_TABLE(TEGRA_IO_PIN_DESC);
 
 static const struct tegra_pmc_regs tegra186_pmc_regs = {
 	.scratch0 = 0x2000,
-	.dpd_req = 0x74,
-	.dpd_status = 0x78,
-	.dpd2_req = 0x7c,
-	.dpd2_status = 0x80,
 	.rst_status = 0x70,
 	.rst_source_shift = 0x2,
 	.rst_source_mask = 0x3c,
@@ -3656,72 +3747,116 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.has_usb_sleepwalk = false,
 };
 
-#define TEGRA194_IO_PAD_TABLE(_pad)                                              \
-	/*   .id                          .dpd      .voltage  .name */           \
-	_pad(TEGRA_IO_PAD_CSIA,           0,        UINT_MAX, "csia"),           \
-	_pad(TEGRA_IO_PAD_CSIB,           1,        UINT_MAX, "csib"),           \
-	_pad(TEGRA_IO_PAD_MIPI_BIAS,      3,        UINT_MAX, "mipi-bias"),      \
-	_pad(TEGRA_IO_PAD_PEX_CLK_BIAS,   4,        UINT_MAX, "pex-clk-bias"),   \
-	_pad(TEGRA_IO_PAD_PEX_CLK3,       5,        UINT_MAX, "pex-clk3"),       \
-	_pad(TEGRA_IO_PAD_PEX_CLK2,       6,        UINT_MAX, "pex-clk2"),       \
-	_pad(TEGRA_IO_PAD_PEX_CLK1,       7,        UINT_MAX, "pex-clk1"),       \
-	_pad(TEGRA_IO_PAD_EQOS,           8,        UINT_MAX, "eqos"),           \
-	_pad(TEGRA_IO_PAD_PEX_CLK_2_BIAS, 9,        UINT_MAX, "pex-clk-2-bias"), \
-	_pad(TEGRA_IO_PAD_PEX_CLK_2,      10,       UINT_MAX, "pex-clk-2"),      \
-	_pad(TEGRA_IO_PAD_DAP3,           11,       UINT_MAX, "dap3"),           \
-	_pad(TEGRA_IO_PAD_DAP5,           12,       UINT_MAX, "dap5"),           \
-	_pad(TEGRA_IO_PAD_UART,           14,       UINT_MAX, "uart"),           \
-	_pad(TEGRA_IO_PAD_PWR_CTL,        15,       UINT_MAX, "pwr-ctl"),        \
-	_pad(TEGRA_IO_PAD_SOC_GPIO53,     16,       UINT_MAX, "soc-gpio53"),     \
-	_pad(TEGRA_IO_PAD_AUDIO,          17,       UINT_MAX, "audio"),          \
-	_pad(TEGRA_IO_PAD_GP_PWM2,        18,       UINT_MAX, "gp-pwm2"),        \
-	_pad(TEGRA_IO_PAD_GP_PWM3,        19,       UINT_MAX, "gp-pwm3"),        \
-	_pad(TEGRA_IO_PAD_SOC_GPIO12,     20,       UINT_MAX, "soc-gpio12"),     \
-	_pad(TEGRA_IO_PAD_SOC_GPIO13,     21,       UINT_MAX, "soc-gpio13"),     \
-	_pad(TEGRA_IO_PAD_SOC_GPIO10,     22,       UINT_MAX, "soc-gpio10"),     \
-	_pad(TEGRA_IO_PAD_UART4,          23,       UINT_MAX, "uart4"),          \
-	_pad(TEGRA_IO_PAD_UART5,          24,       UINT_MAX, "uart5"),          \
-	_pad(TEGRA_IO_PAD_DBG,            25,       UINT_MAX, "dbg"),            \
-	_pad(TEGRA_IO_PAD_HDMI_DP3,       26,       UINT_MAX, "hdmi-dp3"),       \
-	_pad(TEGRA_IO_PAD_HDMI_DP2,       27,       UINT_MAX, "hdmi-dp2"),       \
-	_pad(TEGRA_IO_PAD_HDMI_DP0,       28,       UINT_MAX, "hdmi-dp0"),       \
-	_pad(TEGRA_IO_PAD_HDMI_DP1,       29,       UINT_MAX, "hdmi-dp1"),       \
-	_pad(TEGRA_IO_PAD_PEX_CNTRL,      32,       UINT_MAX, "pex-cntrl"),      \
-	_pad(TEGRA_IO_PAD_PEX_CTL2,       33,       UINT_MAX, "pex-ctl2"),       \
-	_pad(TEGRA_IO_PAD_PEX_L0_RST_N,   34,       UINT_MAX, "pex-l0-rst"),     \
-	_pad(TEGRA_IO_PAD_PEX_L1_RST_N,   35,       UINT_MAX, "pex-l1-rst"),     \
-	_pad(TEGRA_IO_PAD_SDMMC4,         36,       UINT_MAX, "sdmmc4"),         \
-	_pad(TEGRA_IO_PAD_PEX_L5_RST_N,   37,       UINT_MAX, "pex-l5-rst"),     \
-	_pad(TEGRA_IO_PAD_CAM,            38,       UINT_MAX, "cam"),            \
-	_pad(TEGRA_IO_PAD_CSIC,           43,       UINT_MAX, "csic"),           \
-	_pad(TEGRA_IO_PAD_CSID,           44,       UINT_MAX, "csid"),           \
-	_pad(TEGRA_IO_PAD_CSIE,           45,       UINT_MAX, "csie"),           \
-	_pad(TEGRA_IO_PAD_CSIF,           46,       UINT_MAX, "csif"),           \
-	_pad(TEGRA_IO_PAD_SPI,            47,       UINT_MAX, "spi"),            \
-	_pad(TEGRA_IO_PAD_UFS,            49,       UINT_MAX, "ufs"),            \
-	_pad(TEGRA_IO_PAD_CSIG,           50,       UINT_MAX, "csig"),           \
-	_pad(TEGRA_IO_PAD_CSIH,           51,       UINT_MAX, "csih"),           \
-	_pad(TEGRA_IO_PAD_EDP,            53,       UINT_MAX, "edp"),            \
-	_pad(TEGRA_IO_PAD_SDMMC1_HV,      55,       4,        "sdmmc1-hv"),      \
-	_pad(TEGRA_IO_PAD_SDMMC3_HV,      56,       6,        "sdmmc3-hv"),      \
-	_pad(TEGRA_IO_PAD_CONN,           60,       UINT_MAX, "conn"),           \
-	_pad(TEGRA_IO_PAD_AUDIO_HV,       61,       1,        "audio-hv"),       \
-	_pad(TEGRA_IO_PAD_AO_HV,          UINT_MAX, 0,        "ao-hv")
-
-static const struct tegra_io_pad_soc tegra194_io_pads[] = {
-	TEGRA194_IO_PAD_TABLE(TEGRA_IO_PAD)
-};
+#define TEGRA194_IO_PAD_TABLE(_pad) {                                        \
+	/* (.id, .dpd, .request, .status, .voltage, .name) */                \
+	_pad(TEGRA_IO_PAD_CSIA,           0,        0x74,     0x78,          \
+		UINT_MAX, "csia"),                                           \
+	_pad(TEGRA_IO_PAD_CSIB,           1,        0x74,     0x78,          \
+		UINT_MAX, "csib"),                                           \
+	_pad(TEGRA_IO_PAD_MIPI_BIAS,      3,        0x74,     0x78,          \
+		UINT_MAX, "mipi-bias"),                                      \
+	_pad(TEGRA_IO_PAD_PEX_CLK_BIAS,   4,        0x74,     0x78,          \
+		UINT_MAX, "pex-clk-bias"),                                   \
+	_pad(TEGRA_IO_PAD_PEX_CLK3,       5,        0x74,     0x78,          \
+		UINT_MAX, "pex-clk3"),                                       \
+	_pad(TEGRA_IO_PAD_PEX_CLK2,       6,        0x74,     0x78,          \
+		UINT_MAX, "pex-clk2"),                                       \
+	_pad(TEGRA_IO_PAD_PEX_CLK1,       7,        0x74,     0x78,          \
+		UINT_MAX, "pex-clk1"),                                       \
+	_pad(TEGRA_IO_PAD_EQOS,           8,        0x74,     0x78,          \
+		UINT_MAX, "eqos"),                                           \
+	_pad(TEGRA_IO_PAD_PEX_CLK_2_BIAS, 9,        0x74,     0x78,          \
+		UINT_MAX, "pex-clk-2-bias"),                                 \
+	_pad(TEGRA_IO_PAD_PEX_CLK_2,      10,       0x74,     0x78,          \
+		UINT_MAX, "pex-clk-2"),                                      \
+	_pad(TEGRA_IO_PAD_DAP3,           11,       0x74,     0x78,          \
+		UINT_MAX, "dap3"),                                           \
+	_pad(TEGRA_IO_PAD_DAP5,           12,       0x74,     0x78,          \
+		UINT_MAX, "dap5"),                                           \
+	_pad(TEGRA_IO_PAD_UART,           14,       0x74,     0x78,          \
+		UINT_MAX, "uart"),                                           \
+	_pad(TEGRA_IO_PAD_PWR_CTL,        15,       0x74,     0x78,          \
+		UINT_MAX, "pwr-ctl"),                                        \
+	_pad(TEGRA_IO_PAD_SOC_GPIO53,     16,       0x74,     0x78,          \
+		UINT_MAX, "soc-gpio53"),                                     \
+	_pad(TEGRA_IO_PAD_AUDIO,          17,       0x74,     0x78,          \
+		UINT_MAX, "audio"),                                          \
+	_pad(TEGRA_IO_PAD_GP_PWM2,        18,       0x74,     0x78,          \
+		UINT_MAX, "gp-pwm2"),                                        \
+	_pad(TEGRA_IO_PAD_GP_PWM3,        19,       0x74,     0x78,          \
+		UINT_MAX, "gp-pwm3"),                                        \
+	_pad(TEGRA_IO_PAD_SOC_GPIO12,     20,       0x74,     0x78,          \
+		UINT_MAX, "soc-gpio12"),                                     \
+	_pad(TEGRA_IO_PAD_SOC_GPIO13,     21,       0x74,     0x78,          \
+		UINT_MAX, "soc-gpio13"),                                     \
+	_pad(TEGRA_IO_PAD_SOC_GPIO10,     22,       0x74,     0x78,          \
+		UINT_MAX, "soc-gpio10"),                                     \
+	_pad(TEGRA_IO_PAD_UART4,          23,       0x74,     0x78,          \
+		UINT_MAX, "uart4"),                                          \
+	_pad(TEGRA_IO_PAD_UART5,          24,       0x74,     0x78,          \
+		UINT_MAX, "uart5"),                                          \
+	_pad(TEGRA_IO_PAD_DBG,            25,       0x74,     0x78,          \
+		UINT_MAX, "dbg"),                                            \
+	_pad(TEGRA_IO_PAD_HDMI_DP3,       26,       0x74,     0x78,          \
+		UINT_MAX, "hdmi-dp3"),                                       \
+	_pad(TEGRA_IO_PAD_HDMI_DP2,       27,       0x74,     0x78,          \
+		UINT_MAX, "hdmi-dp2"),                                       \
+	_pad(TEGRA_IO_PAD_HDMI_DP0,       28,       0x74,     0x78,          \
+		UINT_MAX, "hdmi-dp0"),                                       \
+	_pad(TEGRA_IO_PAD_HDMI_DP1,       29,       0x74,     0x78,          \
+		UINT_MAX, "hdmi-dp1"),                                       \
+	_pad(TEGRA_IO_PAD_PEX_CNTRL,      0,        0x7c,     0x80,          \
+		UINT_MAX, "pex-cntrl"),                                      \
+	_pad(TEGRA_IO_PAD_PEX_CTL2,       1,        0x7c,     0x80,          \
+		UINT_MAX, "pex-ctl2"),                                       \
+	_pad(TEGRA_IO_PAD_PEX_L0_RST_N,   2,        0x7c,     0x80,          \
+		UINT_MAX, "pex-l0-rst"),                                     \
+	_pad(TEGRA_IO_PAD_PEX_L1_RST_N,   3,        0x7c,     0x80,          \
+		UINT_MAX, "pex-l1-rst"),                                     \
+	_pad(TEGRA_IO_PAD_SDMMC4,         4,        0x7c,     0x80,          \
+		UINT_MAX, "sdmmc4"),                                         \
+	_pad(TEGRA_IO_PAD_PEX_L5_RST_N,   5,        0x7c,     0x80,          \
+		UINT_MAX, "pex-l5-rst"),                                     \
+	_pad(TEGRA_IO_PAD_CAM,            6,        0x7c,     0x80,          \
+		UINT_MAX, "cam"),                                            \
+	_pad(TEGRA_IO_PAD_CSIC,           11,       0x7c,     0x80,          \
+		UINT_MAX, "csic"),                                           \
+	_pad(TEGRA_IO_PAD_CSID,           12,       0x7c,     0x80,          \
+		UINT_MAX, "csid"),                                           \
+	_pad(TEGRA_IO_PAD_CSIE,           13,       0x7c,     0x80,          \
+		UINT_MAX, "csie"),                                           \
+	_pad(TEGRA_IO_PAD_CSIF,           14,       0x7c,     0x80,          \
+		UINT_MAX, "csif"),                                           \
+	_pad(TEGRA_IO_PAD_SPI,            15,       0x7c,     0x80,          \
+		UINT_MAX, "spi"),                                            \
+	_pad(TEGRA_IO_PAD_UFS,            17,       0x7c,     0x80,          \
+		UINT_MAX, "ufs"),                                            \
+	_pad(TEGRA_IO_PAD_CSIG,           18,       0x7c,     0x80,          \
+		UINT_MAX, "csig"),                                           \
+	_pad(TEGRA_IO_PAD_CSIH,           19,       0x7c,     0x80,          \
+		UINT_MAX, "csih"),                                           \
+	_pad(TEGRA_IO_PAD_EDP,            21,       0x7c,     0x80,          \
+		UINT_MAX, "edp"),                                            \
+	_pad(TEGRA_IO_PAD_SDMMC1_HV,      23,       0x7c,     0x80,          \
+		4,        "sdmmc1-hv"),                                      \
+	_pad(TEGRA_IO_PAD_SDMMC3_HV,      24,       0x7c,     0x80,          \
+		6,        "sdmmc3-hv"),                                      \
+	_pad(TEGRA_IO_PAD_CONN,           28,       0x7c,     0x80,          \
+		UINT_MAX, "conn"),                                           \
+	_pad(TEGRA_IO_PAD_AUDIO_HV,       29,       0x7c,     0x80,          \
+		1,        "audio-hv"),                                       \
+	_pad(TEGRA_IO_PAD_AO_HV,          UINT_MAX, UINT_MAX, UINT_MAX,      \
+		0,        "ao-hv")                                           \
+	}
 
-static const struct pinctrl_pin_desc tegra194_pin_descs[] = {
-	TEGRA194_IO_PAD_TABLE(TEGRA_IO_PIN_DESC)
-};
+static const struct tegra_io_pad_soc tegra194_io_pads[] =
+	TEGRA194_IO_PAD_TABLE(TEGRA_IO_PAD);
+
+static const struct pinctrl_pin_desc tegra194_pin_descs[] =
+	TEGRA194_IO_PAD_TABLE(TEGRA_IO_PIN_DESC);
 
 static const struct tegra_pmc_regs tegra194_pmc_regs = {
 	.scratch0 = 0x2000,
-	.dpd_req = 0x74,
-	.dpd_status = 0x78,
-	.dpd2_req = 0x7c,
-	.dpd2_status = 0x80,
 	.rst_status = 0x70,
 	.rst_source_shift = 0x2,
 	.rst_source_mask = 0x7c,
@@ -3791,12 +3926,48 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.has_usb_sleepwalk = false,
 };
 
+#define TEGRA234_IO_PAD_TABLE(_pad) {                                          \
+	/* (.id, .dpd, .request, .status, .voltage, .name) */                  \
+	_pad(TEGRA_IO_PAD_CSIA,       0,        0xe0c0,   0xe0c4,              \
+		UINT_MAX, "csia"),                                             \
+	_pad(TEGRA_IO_PAD_CSIB,       1,        0xe0c0,   0xe0c4,              \
+		UINT_MAX, "csib"),                                             \
+	_pad(TEGRA_IO_PAD_HDMI_DP0,   0,        0xe0d0,   0xe0d4,              \
+		UINT_MAX, "hdmi-dp0"),                                         \
+	_pad(TEGRA_IO_PAD_CSIC,       2,        0xe0c0,   0xe0c4,              \
+		UINT_MAX, "csic"),                                             \
+	_pad(TEGRA_IO_PAD_CSID,       3,        0xe0c0,   0xe0c4,              \
+		UINT_MAX, "csid"),                                             \
+	_pad(TEGRA_IO_PAD_CSIE,       4,        0xe0c0,   0xe0c4,              \
+		UINT_MAX, "csie"),                                             \
+	_pad(TEGRA_IO_PAD_CSIF,       5,        0xe0c0,   0xe0c4,              \
+		UINT_MAX, "csif"),                                             \
+	_pad(TEGRA_IO_PAD_UFS,        0,        0xe064,   0xe068,              \
+		UINT_MAX, "ufs"),                                              \
+	_pad(TEGRA_IO_PAD_EDP,        1,        0xe05c,   0xe060,              \
+		UINT_MAX, "edp"),                                              \
+	_pad(TEGRA_IO_PAD_SDMMC1_HV,  0,        0xe054,   0xe058,              \
+		4,        "sdmmc1-hv"),                                        \
+	_pad(TEGRA_IO_PAD_SDMMC3_HV,  UINT_MAX, UINT_MAX, UINT_MAX,            \
+		6,        "sdmmc3-hv"),                                        \
+	_pad(TEGRA_IO_PAD_AUDIO_HV,   UINT_MAX, UINT_MAX, UINT_MAX,            \
+		1,        "audio-hv"),                                         \
+	_pad(TEGRA_IO_PAD_AO_HV,      UINT_MAX, UINT_MAX, UINT_MAX,            \
+		0,        "ao-hv"),                                            \
+	_pad(TEGRA_IO_PAD_CSIG,       6,        0xe0c0,   0xe0c4,              \
+		UINT_MAX, "csig"),                                             \
+	_pad(TEGRA_IO_PAD_CSIH,       7,        0xe0c0,   0xe0c4,              \
+		UINT_MAX, "csih")                                              \
+	}
+
+static const struct tegra_io_pad_soc tegra234_io_pads[] =
+	TEGRA234_IO_PAD_TABLE(TEGRA_IO_PAD);
+
+static const struct pinctrl_pin_desc tegra234_pin_descs[] =
+	TEGRA234_IO_PAD_TABLE(TEGRA_IO_PIN_DESC);
+
 static const struct tegra_pmc_regs tegra234_pmc_regs = {
 	.scratch0 = 0x2000,
-	.dpd_req = 0,
-	.dpd_status = 0,
-	.dpd2_req = 0,
-	.dpd2_status = 0,
 	.rst_status = 0x70,
 	.rst_source_shift = 0x2,
 	.rst_source_mask = 0xfc,
@@ -3861,10 +4032,10 @@ static const struct tegra_pmc_soc tegra234_pmc_soc = {
 	.needs_mbist_war = false,
 	.has_impl_33v_pwr = true,
 	.maybe_tz_only = false,
-	.num_io_pads = 0,
-	.io_pads = NULL,
-	.num_pin_descs = 0,
-	.pin_descs = NULL,
+	.num_io_pads = ARRAY_SIZE(tegra234_io_pads),
+	.io_pads = tegra234_io_pads,
+	.num_pin_descs = ARRAY_SIZE(tegra234_pin_descs),
+	.pin_descs = tegra234_pin_descs,
 	.regs = &tegra234_pmc_regs,
 	.init = NULL,
 	.setup_irq_polarity = tegra186_pmc_setup_irq_polarity,
-- 
2.17.1

