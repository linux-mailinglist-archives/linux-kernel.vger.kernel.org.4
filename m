Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA472FF89
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244843AbjFNNKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244507AbjFNNKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:10:36 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2074.outbound.protection.outlook.com [40.107.117.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49E22686;
        Wed, 14 Jun 2023 06:10:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9e9Ob/MTI+oJMTNe2C/f/vyN97fib2gfi74Yv6YEdRQcwPeM5jl1t1frhwdrE/tbsx/SEPwkVP2qsjsgamZrfbhH/FyeV5ZzQJm9B35GRIAxBP6UA0HY7aJFPEKkrtDrM0f1QR3QKBPtPwFwdgyClDrUy+1IxiYzt+Lt4BY1ixhbgUI3a0PW2CU/i+5xxgbP8NZ4cq2OpX3494K1UyLIqyVoImQt4N2GF9QsuUl4CATCR1BzZEo17Opk2EdlpLQDtjl4uMM3/puVsBRjNZLEPp07L32UBVab8KAujAK/UCLMqflcIzsRGeECg+803KJnUWEolkM3R4V+hDUEUvsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3/kQjttex67QkwpBTXM+wPlyHvS/x2L+4xuaVYGg90=;
 b=Rl+79z+oUuQM/xD0inIISWPGd9XP6Z4aN2mDONttkqz3/NC1gumefxVzUH+3hy31N4jF1pBfPI4b26l/j/9cd7L1Hv3b55nGmoa4P2yICB89Ys9VxSJemI1XgA2Zan3zplvZsN3y2PBa9xRwmsxKSOSEawq6IohNBSfjjZZ8V4tNkEKiATL9TpnIsT1kMAsGsAQEIF9N12mYawamnm3HZhMY/ynRi+it3YgkSVx18heFCQ2++UhIdzoOhopI0NculRw53OKdfbgfRIdKmTBEWIaPAN7PB2+NrbDCbibi17tDrF5kIaSztTwAR03mDQCFN4MZJr/zUJBR0KRh0RzsJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=baylibre.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3/kQjttex67QkwpBTXM+wPlyHvS/x2L+4xuaVYGg90=;
 b=OIkocYgRO9XeoNk6tfcPkhtM5JwkhxbrqJ7F0ImCSpQjgF0gdp8vhkipMr4wGiHX3oHfn7db4bN7V4GHZR8p2YTQoFVwTxLDCn1zcd7h7i77TXB6rgwe9PtGeGTk8BuJJJ7xqIXJLjEKY/hKHEpdMud0Ybyv4j2Q/9DRHGSQWpQ=
Received: from KL1PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:820::18) by KL1PR03MB5489.apcprd03.prod.outlook.com
 (2603:1096:820:5e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Wed, 14 Jun
 2023 13:10:26 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:820:0:cafe::2f) by KL1PR01CA0006.outlook.office365.com
 (2603:1096:820::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 13:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 13:10:24 +0000
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 14
 Jun 2023 21:10:23 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server id 15.1.2176.2 via Frontend Transport;
 Wed, 14 Jun 2023 21:10:23 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id D92CE637C4; Wed, 14 Jun 2023 16:10:22 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v17 0/1] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Date:   Wed, 14 Jun 2023 16:10:20 +0300
Message-ID: <20230614131021.253490-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|KL1PR03MB5489:EE_
X-MS-Office365-Filtering-Correlation-Id: b583362e-f639-4131-f7d3-08db6cd8b737
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NctyS6f2dwD45idEzaSYCEz5qXNqFVTYHsXYpVjVwHHqrxuz5caC/Ckc4PYMtgMr0k1tAIcacnNzSDRkqB9eIlFOy/sVOjZTdqjwYcECYmtF5MjNSxO3T2ICQWy4CKqBACW3mzWyo1cCzDZzq8B2lN4NhCcyUTfcJ12/2DUI9iwYUZLFOD/2uhHtIR2sHOIxNafmjeIkAaxG9SnFAgZM5tOFD/MMsEaOVwE8WaxJUnLkiW58KJy0s98ucd7i2vp9uLTifWb6bQM6eBSFNFIyiQ12ALtMa1r5W88havWPqZyvv/kZL0FCSwOGulaYr+B9uHaE/fR1/Ng0RdnuC7pd1HrGAJncslAILRBIS/ZAdf1OSIDwvG5pTzRBtnP/gTcZpAsOpQqa94jgp7Wwf8Hws+Ewj4B9yuAK5WRv8YBjrcoSNFF6X1O7bro4c9rG+cwl+1u16BvRmX/fps+37X2J2XcViVp8bnygcgTCOl7uitGTNicLGcwT11lrIq9+KA1j8lhHQyg3zwISYYNxHruCAsMlP1HDtzHFo2dSkyo+s6SMYv8CYVT5pIFbSlQ+MC6LFtPT15djKcO77C3ighK85cPZw/QzieRZi0DylWA7XWFgLXUBVEByiti/DElwIuxbby2G6xRuJXmmXJZQqR8Je2xah5Kz/B5/SXMI+Y1xEyF2rTqv8txix5T3ISzmxqdV3usPs1FRUX/sUZE4OOJACyb2vFBHFgvs8TUDIUtkOd6U137f2GQO6K9I5tIA0r3JhPjDRVhlqD3jgZRuqMacDsWpNNxyo4whPnSD31ZPfPozlj8fo0tMc/azpewog1DabWIiDnV0164JdYivlQad8p42/SngIMQSoXnJkMZUnXQ=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(4326008)(7416002)(70206006)(316002)(41300700001)(70586007)(42882007)(73392003)(186003)(6266002)(2906002)(42186006)(110136005)(54906003)(8676002)(8936002)(76482006)(5660300002)(478600001)(966005)(36860700001)(40460700003)(1076003)(83170400001)(82740400003)(81166007)(40480700001)(82202003)(356005)(26005)(83380400001)(336012)(36756003)(2616005)(47076005)(82310400005)(55446002)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 13:10:24.5222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b583362e-f639-4131-f7d3-08db6cd8b737
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5489
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds clock support for the Nuvoton 
Arbel NPCM8XX Board Management controller (BMC) SoC family.

This patchset cover letter is based from the initial support for NPCM8xx BMC to
keep tracking the version history.

all the other initial support patches had been applied to Linux kernel 6.0.

This patchset was tested on the Arbel NPCM8XX evaluation board.

Addressed comments from:

 - Christophe JAILLET: https://www.spinics.net/lists/linux-clk/msg85687.html

Changes since version 16:
 - NPCM8XX clock driver
	- Using devm_kzalloc instead kzalloc.
	- Remove unnecessary parenthesis.
	- Modify incorrect spelling.

Changes since version 15:
 - NPCM8XX clock driver
	- Remove unused regs parameter from npcm8xx_pll_data structure.
	- Using index and clk_hw parameters to set the clock parent in the clock structures.

Changes since version 14:
 - NPCM8XX clock driver
	- Remove unnecessary register definitions.
	- Remove the internal reference clock, instead use the external DT reference clock.
	- rearrange the driver.
	- using .names parameter in DT to define clock (refclk).

Changes since version 13:
 - NPCM8XX clock driver
	- Remove unnecessary definitions and add module.h define
	- Use in clk_parent_data struct.fw_name and .name.
	- Add module_exit function.
	- Add const to divider clock names.
	- Add MODULE_DESCRIPTION and MODULE_LICENSE

Changes since version 12:
 - NPCM8XX clock driver
	- Use clk_parent_data in mux and div clock structure.
	- Add const to mux tables.
	- Using devm_clk_hw_register_fixed_rate function.
	- use only .name clk_parent_data instead .name and .fw_name.
	- Modify mask values in mux clocks. 

Changes since version 11:
 - NPCM8XX clock driver
	- Modify Kconfig help.
	- Modify loop variable to unsigned int.

Changes since version 11:
 - NPCM8XX clock driver
	- Modify Kconfig help.
	- Modify loop variable to unsigned int.

Changes since version 10:
 - NPCM8XX clock driver
	- Fix const warning.

Changes since version 9:
 - NPCM8XX clock driver
	- Move configuration place.
	- Using clk_parent_data instead of parent_name
	- using devm_ioremap instead of ioremap. deeply sorry, I know we had
	 a long discussion on what should the driver use, from other examples 
	 (also in other clock drivers) I see the combination of 
	 platform_get_resource and devm_ioremap are commonly used and it answer
	 the reset and clock needs.

Changes since version 8:
 - NPCM8XX clock driver
	- Move configuration place.
	- Add space before and aftre '{' '}'.
	- Handle devm_of_clk_add_hw_provider function error.

Changes since version 7:
 - NPCM8XX clock driver
	- The clock and reset registers using the same memory region, 
	  due to it the clock driver should claim the ioremap directly 
	  without checking the memory region.

Changes since version 6:
 - NPCM reset driver
	- Modify warning message.
 - dt-bindings: serial: 8250: Add npcm845 compatible string patch accepted, due
   to it the patch removed from the patchset.

Changes since version 5:
 - NPCM8XX clock driver
	- Remove refclk if devm_of_clk_add_hw_provider function failed.
 - NPCM8XX clock source driver
	- Remove NPCM8XX TIMER_OF_DECLARE support, using the same as NPCM7XX.

Changes since version 4:
 - NPCM8XX clock driver
	- Use the same quote in the dt-binding file.

Changes since version 3:
 - NPCM8XX clock driver
	- Rename NPCM8xx clock dt-binding header file.
	- Remove unused structures.
	- Improve Handling the clocks registration.
 - NPCM reset driver
	- Add ref phandle to dt-binding.

Changes since version 2:
 - Remove NPCM8xx WDT compatible patch.
 - Remove NPCM8xx UART compatible patch.
 - NPCM8XX clock driver
	- Add debug new line.
	- Add 25M fixed rate clock.
	- Remove unused clocks and clock name from dt-binding.
 - NPCM reset driver
	- Revert to npcm7xx dt-binding.
	- Skip dt binding quotes.
	- Adding DTS backward compatibility.
	- Remove NPCM8xx binding include file.
	- Warp commit message.
- NPCM8XX device tree:
	- Remove unused clock nodes (used in the clock driver)
	- Modify gcr and rst node names.

Changes since version 1:
 - NPCM8XX clock driver
	- Modify dt-binding.
	- Remove unsed definition and include.
	- Include alphabetically.
	- Use clock devm.
 - NPCM reset driver
	- Modify dt-binding.
	- Modify syscon name.
	- Add syscon support to NPCM7XX dts reset node.
	- use data structure.
 - NPCM8XX device tree:
	- Modify evb compatible name.
	- Add NPCM7xx compatible.
	- Remove disable nodes from the EVB DTS.

Tomer Maimon (1):
  clk: npcm8xx: add clock controller

 drivers/clk/Kconfig       |   8 +
 drivers/clk/Makefile      |   1 +
 drivers/clk/clk-npcm8xx.c | 565 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 574 insertions(+)
 create mode 100644 drivers/clk/clk-npcm8xx.c

-- 
2.33.0

