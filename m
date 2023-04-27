Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5F66F0820
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244187AbjD0PVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244175AbjD0PVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:21:14 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10F9468E;
        Thu, 27 Apr 2023 08:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKIIHMWlW88hnZS91DEQI7L6H/MShWSBGj2Zx31leA6pGkPACfvWqOSuXNfdxbKuoaLczDMjXxaUXcnty4JhHiZVxY1jh3My85ZQcVBoH136Z5UtFLU+FCdzLedI2hBNDdjFbeqHWKN14kBsolIkFz3XoBAQvg/hMEJeaXhqupGZA4em67rgrLax/FyROa+cReZ8IeGQgVvNDzSdQn9sOpuspGTUjqhHORy6bOmut3fpC9hilvyjf+daMkEdr9eUW/qZ2Yr5F8n50JusfwZAuzSkS5xpkRdI0wl7fpCd2XxE6LELHRwxiD+zKlSjE+8nchtpg+BI8USaqcTNT1R4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuKSwq/JgPh/mNy/cYNItg8tKfd4PjHAKP0dTRKgAto=;
 b=CFrH1hKi/gJ3SUFKvlCpZ6s95OaVAyz+jjGOGMN0vBf+EUEhbAOxVEZN0x+UcToucGvP5VN5s4L7gvgNGxLlsUgMPOqMUj3IIZHtOusvZhZE7b63uZgNsYrY22Ux7GaGpMgvU1XzKaiUZymTxxH4394Gpwkh/NN23fO7bUvJ4DY3CG3KnZ7fvt+M8OCMa/iJqZluB/v0JGTqm2pp5O+g2aMacrjwx3h+1ljaHwSE9OO/JJGryEVcr0qmwVwr+5a5AzYaHD5ioejKD6LELdRZwMMA5O4zY+0taayjyRyEqr/Su1rknH8lEefeVV17hhYp5VU1+MRNL/62zsZjiXmjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuKSwq/JgPh/mNy/cYNItg8tKfd4PjHAKP0dTRKgAto=;
 b=Wk9Is4C4bddUB1FnCFiI+F7o26xBNsBhkF+Y4ia+pcJ0wvPjSbD7D77RHdWrH7BVHWsIK6kbF8uQL5A/k6mewLv2IFDo6wU17G4G/LlraPlAi83PKR/uZF5JHCBr8gmJZ9Fb2NMqIk+kQhKuOOPoYWJvrZYWWpO2Hf5uwaN5z/8B7dZnfhucJ77jUvUiF/kHt/lpQPHul+WP94NBaaSTXwfhuuG3HlPUiN9QINhE04pwxiNNXGNpKr4c6lsVXZ98seONSdSQm81iV+wXlVvak1e2lwhq5gzkJlpKoDn6ytrCEeRw6tMqII0WpAmiuVi7GOzpbEWt8I6Z86HNmaQ6XA==
Received: from DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) by DB9PR10MB8076.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4c3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 15:21:08 +0000
Received: from DB5EUR01FT019.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:46b:cafe::a8) by DUZPR01CA0029.outlook.office365.com
 (2603:10a6:10:46b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 15:21:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT019.mail.protection.outlook.com (10.152.4.249) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.21 via Frontend Transport; Thu, 27 Apr 2023 15:21:08 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 27 Apr 2023 17:21:07 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.115) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 27 Apr 2023 17:21:07 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Simon Guinot <simon.guinot@sequanux.org>,
        Henning Schild <henning.schild@siemens.com>,
        Xing Tong Wu <xingtong.wu@siemens.com>
Subject: [PATCH v2 1/1] gpio-f7188x: fix chip name and pin count on Nuvoton chip
Date:   Thu, 27 Apr 2023 17:20:55 +0200
Message-ID: <20230427152055.18380-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230427152055.18380-1-henning.schild@siemens.com>
References: <20230427152055.18380-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.115]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT019:EE_|DB9PR10MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: d224baed-93d9-476f-61d9-08db47330690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLkSu/28QBSia6+GwFMqhPfJJb/IkVGrkfC4LItZgi19+dwacE2KFWDIfRUHf7iRD/lKsqW8pgg0QJaVOR6mInwKTqqgX6iERoWmbaSwkXEpZeI2t7u2MbYVnoJnTlrJwAauo/LFPcZN1ip3fdTuXPNAodzbMd3Fha5bMBkNThRY7FZ4dh1ge4S4xcuJmZSTjwointmT81njxKMcqXE/aF8/NOg8ByIgLR8zksV8jA2u563EtbwUq0Ph8wyjefBt+zqJKTMkhE20HuWGM5/4NM59FwwK3zeqpuvNVeIl17jaW+vo7dw7fSPkSv2PXYpbfi/YMfqJa2ayqtMFapo0bvUnUMlU1cI/9My3h++FwhcK65WsEiqGOz/zxjk3pBpGTgw7losdGvT0RfR17XOzcGAWHe0qXyEewz95tlC5dn96a5PGjc+70S6t6qxbhuak1B6JAWW0hNb9zfjHkmZovCfkowHsMlri1PotR/dPvJiPsE/xz0h8MrDI3sLbyHefk6Cn8P1zOFs1RYHeIbYsoLvMgzcoTyLDGbidn7iIZ+4ARenYOnerGQ9gfGjAZf745v2xYJ2k0aDhOpVMho4PNv0QJYVHgxyGNSlcAgqdyb9bJGIdsNKvz2ZYU8ydTW+0o48Pygh+gR05ShqhmV105beAyX3QJLHsUkURJJibGy1F74RZqpCz1/IGzGI8273h4wiKu59RAfLMg3UbRnWhLR2dJAHUP85RbJQbqOkzUAI=
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(2906002)(86362001)(36756003)(82310400005)(40460700003)(40480700001)(6666004)(2616005)(36860700001)(4326008)(83380400001)(336012)(47076005)(186003)(956004)(16526019)(26005)(1076003)(107886003)(110136005)(70586007)(478600001)(70206006)(82740400003)(41300700001)(8676002)(82960400001)(81166007)(316002)(44832011)(8936002)(5660300002)(54906003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:21:08.1253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d224baed-93d9-476f-61d9-08db47330690
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT019.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8076
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fact the device with chip id 0xD283 is called NCT6126D, and that is
the chip id the Nuvoton code was written for. Correct that name to avoid
confusion, because a NCT6116D in fact exists as well but has another
chip id, and is currently not supported.

The look at the spec also revealed that GPIO group7 in fact has 8 pins,
so correct the pin count in that group as well.

Fixes: d0918a84aff0 ("gpio-f7188x: Add GPIO support for Nuvoton NCT6116")
Reported-by: Xing Tong Wu <xingtong.wu@siemens.com>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/gpio/Kconfig       |  2 +-
 drivers/gpio/gpio-f7188x.c | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index badbe0582318..14b655411aa0 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -879,7 +879,7 @@ config GPIO_F7188X
 	help
 	  This option enables support for GPIOs found on Fintek Super-I/O
 	  chips F71869, F71869A, F71882FG, F71889F and F81866.
-	  As well as Nuvoton Super-I/O chip NCT6116D.
+	  As well as Nuvoton Super-I/O chip NCT6126D.
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called f7188x-gpio.
diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index 9effa7769bef..f54ca5a1775e 100644
--- a/drivers/gpio/gpio-f7188x.c
+++ b/drivers/gpio/gpio-f7188x.c
@@ -48,7 +48,7 @@
 /*
  * Nuvoton devices.
  */
-#define SIO_NCT6116D_ID		0xD283  /* NCT6116D chipset ID */
+#define SIO_NCT6126D_ID		0xD283  /* NCT6126D chipset ID */
 
 #define SIO_LD_GPIO_NUVOTON	0x07	/* GPIO logical device */
 
@@ -62,7 +62,7 @@ enum chips {
 	f81866,
 	f81804,
 	f81865,
-	nct6116d,
+	nct6126d,
 };
 
 static const char * const f7188x_names[] = {
@@ -74,7 +74,7 @@ static const char * const f7188x_names[] = {
 	"f81866",
 	"f81804",
 	"f81865",
-	"nct6116d",
+	"nct6126d",
 };
 
 struct f7188x_sio {
@@ -187,8 +187,8 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 /* Output mode register (0:open drain 1:push-pull). */
 #define f7188x_gpio_out_mode(base) ((base) + 3)
 
-#define f7188x_gpio_dir_invert(type)	((type) == nct6116d)
-#define f7188x_gpio_data_single(type)	((type) == nct6116d)
+#define f7188x_gpio_dir_invert(type)	((type) == nct6126d)
+#define f7188x_gpio_data_single(type)	((type) == nct6126d)
 
 static struct f7188x_gpio_bank f71869_gpio_bank[] = {
 	F7188X_GPIO_BANK(0, 6, 0xF0, DRVNAME "-0"),
@@ -274,7 +274,7 @@ static struct f7188x_gpio_bank f81865_gpio_bank[] = {
 	F7188X_GPIO_BANK(60, 5, 0x90, DRVNAME "-6"),
 };
 
-static struct f7188x_gpio_bank nct6116d_gpio_bank[] = {
+static struct f7188x_gpio_bank nct6126d_gpio_bank[] = {
 	F7188X_GPIO_BANK(0, 8, 0xE0, DRVNAME "-0"),
 	F7188X_GPIO_BANK(10, 8, 0xE4, DRVNAME "-1"),
 	F7188X_GPIO_BANK(20, 8, 0xE8, DRVNAME "-2"),
@@ -282,7 +282,7 @@ static struct f7188x_gpio_bank nct6116d_gpio_bank[] = {
 	F7188X_GPIO_BANK(40, 8, 0xF0, DRVNAME "-4"),
 	F7188X_GPIO_BANK(50, 8, 0xF4, DRVNAME "-5"),
 	F7188X_GPIO_BANK(60, 8, 0xF8, DRVNAME "-6"),
-	F7188X_GPIO_BANK(70, 1, 0xFC, DRVNAME "-7"),
+	F7188X_GPIO_BANK(70, 8, 0xFC, DRVNAME "-7"),
 };
 
 static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
@@ -490,9 +490,9 @@ static int f7188x_gpio_probe(struct platform_device *pdev)
 		data->nr_bank = ARRAY_SIZE(f81865_gpio_bank);
 		data->bank = f81865_gpio_bank;
 		break;
-	case nct6116d:
-		data->nr_bank = ARRAY_SIZE(nct6116d_gpio_bank);
-		data->bank = nct6116d_gpio_bank;
+	case nct6126d:
+		data->nr_bank = ARRAY_SIZE(nct6126d_gpio_bank);
+		data->bank = nct6126d_gpio_bank;
 		break;
 	default:
 		return -ENODEV;
@@ -559,9 +559,9 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
 	case SIO_F81865_ID:
 		sio->type = f81865;
 		break;
-	case SIO_NCT6116D_ID:
+	case SIO_NCT6126D_ID:
 		sio->device = SIO_LD_GPIO_NUVOTON;
-		sio->type = nct6116d;
+		sio->type = nct6126d;
 		break;
 	default:
 		pr_info("Unsupported Fintek device 0x%04x\n", devid);
@@ -569,7 +569,7 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
 	}
 
 	/* double check manufacturer where possible */
-	if (sio->type != nct6116d) {
+	if (sio->type != nct6126d) {
 		manid = superio_inw(addr, SIO_FINTEK_MANID);
 		if (manid != SIO_FINTEK_ID) {
 			pr_debug("Not a Fintek device at 0x%08x\n", addr);
@@ -581,7 +581,7 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
 	err = 0;
 
 	pr_info("Found %s at %#x\n", f7188x_names[sio->type], (unsigned int)addr);
-	if (sio->type != nct6116d)
+	if (sio->type != nct6126d)
 		pr_info("   revision %d\n", superio_inb(addr, SIO_FINTEK_DEVREV));
 
 err:
-- 
2.39.2

