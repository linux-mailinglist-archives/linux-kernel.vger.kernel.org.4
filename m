Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6846AB575
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCFEKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCFEK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:10:26 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8F6126F1;
        Sun,  5 Mar 2023 20:10:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOuIaDBzd69AE/TFKQ9rMwJ+Eun3j5NmZB74oyEXY2WJHY3+vMmjw+/aKsU3IfCrgC/awuMzsUcbWSQmqs5tLmt1T7bcP7OHVHc/yqmWc+zJP9iOPzQG28Mgb9mErsgYBO4F9tlMw8ChHSyVyN39iUm1ryAcYiXKcDgApLoyH1HbimzprnvBE5LzLnMbGN7JyK+MTGRZ3pCDSYwSWAHvFvlyL5L4XahxUMVjt57AvDmDstqVeLBiP3R4lW15YyleI23Ou5DY/xyzyRsPxxAq1p9MFH0Ofmh5v9Y+MBfULiObJnJDzJHVjwmrCvYeG+tQ4yL+dfRvNui9XNnGzR4qzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ySdHjvqPD2IJ3gba6AToCVSRy6+aFFE/eKjtYItYvA=;
 b=OgcoAeWFyX8TSor6eONBx4sA0l/b0Z0SJXQSkHkgb/tQ3u8EBG9hYhDahSw1givSP89oyaudGaxk9h5LsR3O2FJbb0IJ5clVzsBl0Tu8qK2W+VoombucsP52mKsEKXO8zgy9aoKTr1xLWIJsAlUTzAAtZ44L87Oe/rezUxKolag6LL04MxvCRE3OZhsVMyh8OV3wbk6yEhQtFzJidc5GA04de5S/Bo/FAljplNIp+/PfEioQcSkUF1InIgizUCANvmfj7alnoM7F6t2VHBVHYm6lZblJ2X6WCL1VpQAbZp4j+XR7nkp4oMLnUL7aDJjYvPblzDUTjEdPvd1XPSpGvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ySdHjvqPD2IJ3gba6AToCVSRy6+aFFE/eKjtYItYvA=;
 b=OGYGk18eFfLHzKafVDpRHdC3aaq6voJJrC4qyhzrbBKAqMCPp8me4PI2hgtzj4Lz38kSdTeY5DejfwZx7XchOcS4DImHQMgPu02scFGoKsYsSZLI/wtc+CYd5oPlWQHqZohz/0spQEODkrlE0BxUkKLtJuwdxyCxSTmKxLEfMyE=
Received: from BN0PR04CA0183.namprd04.prod.outlook.com (2603:10b6:408:e9::8)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.25; Mon, 6 Mar
 2023 04:10:19 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::49) by BN0PR04CA0183.outlook.office365.com
 (2603:10b6:408:e9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 04:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 04:10:19 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 22:10:02 -0600
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
Subject: [PATCH v10 11/15] mmc: sdhci-cadence: Enable device specific override of writel()
Date:   Sun, 5 Mar 2023 20:07:35 -0800
Message-ID: <20230306040739.51488-12-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306040739.51488-1-blarson@amd.com>
References: <20230306040739.51488-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a388ecb-be6d-4c37-6a49-08db1df8b2e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rIWuN3VCQ9uAozWG0U3likikbebsMkZqX+VPHNg9oQ5TbZZmnz9ETOEtzX7W3B74QxWEqxT7F+KFXEtyjhKMPdz0aQPjf5ewPtfpw7I/PxZd83YWwaz55Q0WH7sXRAjl8diYE8c0LfR8xS+5E78OAcx/8Q0IqDAfckYVY5+g1uynGMQbUXanDr6AchwM89e/Ua1tAhdPWeQwySqiXyLRTywPu1KgeyNjQpmfiHEHt8Ih3/b0SLaPjX7aGV38t3o/CMN+JXDUUPjQHycsZgUl8SPHz4SffnirlwQsWUESfGw9DHLespg+VG3UuhYli1OyON9KCU/L+P3LdAwiVLm1spOxrwB4oQnStpXD+3KNk9ed28iIcQ46GkBmHDbzOxF7E9D5wbNRh0x0i7aIPyVfunHi7V5viTqkp7COpulaMxdblFJptz0lNa3eex8tTd6NPkS4u6ZWByERlbaJD6pzHqN6SSgRw+eVhW+1z7SPupuEPJPM9L2hs5xiK0Ku6KoJqzxttUjmwTG3gTtW7r1gwxmjxMWHK7BdCTMBkcahLb5kXT7g9n8u47NT3N/F824kNeLrEU+I04bYcPP/dfnPRWh5+DIjQcfsMLi9hDsDe79Qd4OAw5Y/m5jiMrEs55L9EEvdeW/ft/AJKCWwewWye/ZwLKYXgYFiS1O7nXc8l1k4uCmKqVF8wmeEGcPKEbRbyajaIWa0Yl9U2PfYAnMbqiahfkXl0kxsc7ydTl4SdX0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(83380400001)(36860700001)(426003)(36756003)(40460700003)(6666004)(478600001)(8936002)(5660300002)(7416002)(82740400003)(7406005)(81166007)(356005)(40480700001)(82310400005)(2906002)(16526019)(2616005)(336012)(1076003)(26005)(186003)(8676002)(70206006)(70586007)(6916009)(316002)(54906003)(47076005)(41300700001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 04:10:19.3012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a388ecb-be6d-4c37-6a49-08db1df8b2e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoCs with device specific Cadence implementation, such as setting
byte-enables before the write, need to override writel().  Add a
callback where the default is writel() for all existing chips.

Signed-off-by: Brad Larson <blarson@amd.com>
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

