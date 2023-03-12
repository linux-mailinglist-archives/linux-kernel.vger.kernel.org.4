Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA416B627A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 01:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCLArX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 19:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCLArT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 19:47:19 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B6B6BC38;
        Sat, 11 Mar 2023 16:46:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SA26QM+oMX2mjVA4Qzm5c1x5qqvE2sty/5W0YHqfjOPjIx5QDmd2HWm9i9axzB/TXcmUZicP4xTLR7d8lcQhGwLh6Jjpt3opM2P1ea0JHWVzqLqzUhrT/YhY47M/lUq4ELqeWcMBZsopj9QGEFpx/KCrmhmGKHigPgkxrERaZ7KZQfk7L5SPUGvPp1nOzMQpy3oGOwJoAmlSvHqYo/pT9cSvfBNMhWMfkv3e73H9S6BJveOPgTVXJrOg8EPqKdjzhFKaVMahVGh0zdZGnbDBHK3Vzz1yvmx7uqBIsJcwNgZSI7tiPX+KHPk9ITyEBzCkHxDIeryWQfUvuDdjpRbbWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymfACAjSLWbCk+4U3bvrCLTQlZYsf0VDrwtsvVsOjLE=;
 b=IUswKfbSVsAasqWNN3+QNgE01dr4qsJ8HlaZFPMsc1a2jTUBhCU0hhfRkCw1sUz3cJo6yIQJR95InktanOmaf5uWY7579z8Pp010Gw6zPpX/ZCmwbYHtxvJKVQvewHAbDouHl1pAL2XDQiUhKVkQuwwYB4X74D9rhmtIysx0sN+lA7T5FG/pPN+OZqvKF4DLCNBskylu6gN9nH/h8kD4OB09uT4w6XgYYlbmgaF5CnCSCzXk5Ta3BB7qWgo5ALE5AGxhvfrcmAfIus5aGdTGx5Bqer6gaIo8WUiUIiU5KaWtcYWilIPlQtylfX0ujkzWaZ1rcWB4758FjpEHXzOuJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymfACAjSLWbCk+4U3bvrCLTQlZYsf0VDrwtsvVsOjLE=;
 b=Ck9RiXge0QexozE5FqsPZ9SjY2/EVWR2vFGkXTJjv0O8b0azeAhCvb+k+LuVjieX7l38w61KkxdSE/86RtVieu4OdG4qPjlwuSv2pZNuMBzL8QmdAklQSXrOkQRnWZD22IAy1A3RfkBJ+O5mBfIE0J/Ue9c6yA6cpfcyy8vp3tA=
Received: from DM6PR07CA0040.namprd07.prod.outlook.com (2603:10b6:5:74::17) by
 DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.23; Sun, 12 Mar 2023 00:46:32 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::2a) by DM6PR07CA0040.outlook.office365.com
 (2603:10b6:5:74::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23 via Frontend
 Transport; Sun, 12 Mar 2023 00:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.23 via Frontend Transport; Sun, 12 Mar 2023 00:46:32 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 11 Mar 2023 18:46:27 -0600
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <gsomlo@gmail.com>, <gerg@linux-m68k.org>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v11 11/15] mmc: sdhci-cadence: Enable device specific override of writel()
Date:   Sat, 11 Mar 2023 16:44:41 -0800
Message-ID: <20230312004445.15913-12-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230312004445.15913-1-blarson@amd.com>
References: <20230312004445.15913-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|DM4PR12MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d53063-4179-4c28-cf97-08db2293399a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tHfSsIu0501wbm/WxSVNReo2go6anzwi5A8CRydHOkxqqt6bR8sfGs+rN/Ce4owqLU35oeU0cW4w59lvdsroZKnrOOAgb9YxiCTc4Vp+N8cfiQIkISqpyA4JZkTVrUU4tyfZdflHLSX4875pZX4LjlOzHW5vU4U2Bmmj49syQWCVput2OdD//U8bukIRWBdFw8XDOKXu9HOPfd9qLkiEMk923NrmYAzAPR0ASRSwH6qDAw8/Ky86QXvyJ6QPr09YPjxbr7MZAhkUyKeRsnuVha8lXvqIFhE2ALuEI6Ott9h00MEGfzxOrB4+bAHoouIh9M9gEY23RG9kAiyKBwyF6RIwej0jICOLMHbK0OGCIQA4bG1Ohb8lNln1X4Ozgv5nkatNnjteYUYOE4tDNp8tWr0WrMQoP9d03tA/WhkAtdyvraMP7cWx+VS0OJ9MBkOf3iYVK9a0UMlB9IheeYAXfWls+1yJpBXemuMx86GUkJjti+jWE1EbbLTgI45Qhv+BQNd2R5Z1cPoZKKM7bNhtqsS0QXaUEUbo9ct+deNjF187g8xbeZOkE8xG/kVsGPuuRPN7wz1d2X4K2MaEdeJgTDKxgc3cfphPQpDPavcqQ1MV5rVmflBgHAkbR6wEm8hPAYZAYAziIemaxqFOShZcNzCT0aYkdadddr4k5f+vbBwmBNyNcLrAcClI7UbAYkMaedAWvg1Iy2Jjp/fUc5WeaUk6jak7EStb+s4F3U/NXo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199018)(40470700004)(46966006)(36840700001)(2906002)(6666004)(478600001)(356005)(36756003)(186003)(26005)(1076003)(16526019)(40460700003)(2616005)(8936002)(336012)(40480700001)(426003)(47076005)(83380400001)(41300700001)(82310400005)(70206006)(70586007)(4326008)(6916009)(8676002)(5660300002)(7406005)(7416002)(54906003)(316002)(36860700001)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2023 00:46:32.4259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d53063-4179-4c28-cf97-08db2293399a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoCs with device specific Cadence implementation, such as setting
byte-enables before the write, need to override writel().  Add a
callback where the default is writel() for all existing chips.

Signed-off-by: Brad Larson <blarson@amd.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

v10 changes:
- The 1st patch adding private writel() is unchanged.  The 2nd patch is split
  into two patches to provide for device specific init in one patch with no
  effect on existing designs.  Then add the pensando support into the next patch.
  Then the 4th patch is mmc hardware reset support which is unchanged.

v9 changes:
- No change to this patch but as some patches are deleted and this is
  a respin the three successive patches to sdhci-cadence.c are
  patches 12, 13, and 14 which do the following:

  1. Add ability for Cadence specific design to have priv writel().
  2. Add Elba SoC support that requires its own priv writel() for
     byte-lane control .
  3. Add support for mmc hardware reset.

---
 drivers/mmc/host/sdhci-cadence.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 6f2de54a5987..708d4297f241 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -67,6 +67,7 @@ struct sdhci_cdns_phy_param {
 struct sdhci_cdns_priv {
 	void __iomem *hrs_addr;
 	bool enhanced_strobe;
+	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
 	unsigned int nr_phy_params;
 	struct sdhci_cdns_phy_param phy_params[];
 };
@@ -90,6 +91,12 @@ static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
 	{ "cdns,phy-dll-delay-strobe", SDHCI_CDNS_PHY_DLY_STROBE, },
 };
 
+static inline void cdns_writel(struct sdhci_cdns_priv *priv, u32 val,
+			       void __iomem *reg)
+{
+	writel(val, reg);
+}
+
 static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
 				    u8 addr, u8 data)
 {
@@ -104,17 +111,17 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
 
 	tmp = FIELD_PREP(SDHCI_CDNS_HRS04_WDATA, data) |
 	      FIELD_PREP(SDHCI_CDNS_HRS04_ADDR, addr);
-	writel(tmp, reg);
+	priv->priv_writel(priv, tmp, reg);
 
 	tmp |= SDHCI_CDNS_HRS04_WR;
-	writel(tmp, reg);
+	priv->priv_writel(priv, tmp, reg);
 
 	ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_HRS04_ACK, 0, 10);
 	if (ret)
 		return ret;
 
 	tmp &= ~SDHCI_CDNS_HRS04_WR;
-	writel(tmp, reg);
+	priv->priv_writel(priv, tmp, reg);
 
 	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
 				 0, 10);
@@ -191,7 +198,7 @@ static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 mode)
 	tmp = readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
 	tmp &= ~SDHCI_CDNS_HRS06_MODE;
 	tmp |= FIELD_PREP(SDHCI_CDNS_HRS06_MODE, mode);
-	writel(tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
+	priv->priv_writel(priv, tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
 }
 
 static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
@@ -223,7 +230,7 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
 	 */
 	for (i = 0; i < 2; i++) {
 		tmp |= SDHCI_CDNS_HRS06_TUNE_UP;
-		writel(tmp, reg);
+		priv->priv_writel(priv, tmp, reg);
 
 		ret = readl_poll_timeout(reg, tmp,
 					 !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
@@ -386,6 +393,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	priv->nr_phy_params = nr_phy_params;
 	priv->hrs_addr = host->ioaddr;
 	priv->enhanced_strobe = false;
+	priv->priv_writel = cdns_writel;
 	host->ioaddr += SDHCI_CDNS_SRS_BASE;
 	host->mmc_host_ops.hs400_enhanced_strobe =
 				sdhci_cdns_hs400_enhanced_strobe;
-- 
2.17.1

