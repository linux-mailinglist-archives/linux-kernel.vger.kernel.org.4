Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAE772FF84
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241150AbjFNNKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244866AbjFNNKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:10:04 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2059.outbound.protection.outlook.com [40.107.215.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE98193;
        Wed, 14 Jun 2023 06:10:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WusgbmlkpjecovosO/3+J2Kx8W7ss6070rJ21vAgYBWKklMOWy1IvPhIeSahaWUgxD+Q0jjmCcHwNZrZ5rhyFTMk0yZbhGXrbrAXZjd96/eSplttGx/kXd2SSFPxdAMDO8URmnlNjOQdHHdSdiI0jZgWeS13fOENpxmtMz6CV4FPzm5TAOY9A35wIiAGpKzzhfsQEDP7L3ONnVLv2NW6YHLwtf7GeMsy4oPbSp2Dvjne8ysZOcErVlfrhJYMLq4RI/IWA90IUriz4XlJbF70sX8MPuZGFqAMzhy+7lrgRyQeEATK4Y6TVnDxD1R/+G9zP7eQRvNv+7R6TOc3R/dTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mx9TlUQh6dss02agMHqrRcdVOwYeX9VysKp3VlZPzg=;
 b=AnxEHUk9Be8DJjYFq5EJtnSXMjyfj720Qd4vbsFdRUso46F2TmgXJPpnaLjXeIiwdkX2Th+m8csiLZfDNQ6tYedbzanXUnzSEj/tBG0F/UFX4kUb8h6xaWigV59X9PY+ziyokIgtupfoi9qYQ8L2VbCG81BaE8bafWP+BjTBj/pDz0hSD5D9kCkrOdFDVJbCMgKNetqXP1cPcheXURGCqVTOlnPeAYc6XeACsJbFt5NycKGlvcfHEC+KceeiwNAH+iocqboqOvWaEcRu9ikU5qR/JFHeFJ47qv1CoO9XbiZHzUuagsYbyLSMu9Hg54zCF2w0gnuUgnY36HiugAoo6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mx9TlUQh6dss02agMHqrRcdVOwYeX9VysKp3VlZPzg=;
 b=sfQen9bEyQA1vz+2CgAJf/dp4NXdGNJo89y7j3E52+00dWG+NDBjwGw8rD4Ux0fu6lDIofNbU9GND/KbUBa6M5sezedTlcMZar5LG3YqdycxzQhUQ9qJHZvcYC/tYAb4YyoZZg4g8v554p2GPGkxm5edKhtXNCJRtbtE4WtygnQ=
Received: from SL2P216CA0129.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1::8) by
 SI2PR03MB6710.apcprd03.prod.outlook.com (2603:1096:4:1ea::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.44; Wed, 14 Jun 2023 13:09:58 +0000
Received: from PSAAPC01FT028.eop-APC01.prod.protection.outlook.com
 (2603:1096:101:1:cafe::91) by SL2P216CA0129.outlook.office365.com
 (2603:1096:101:1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 13:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 PSAAPC01FT028.mail.protection.outlook.com (10.13.38.119) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 13:09:57 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 14 Jun
 2023 21:09:56 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Wed, 14 Jun
 2023 21:09:55 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server id 15.1.2176.2 via Frontend Transport;
 Wed, 14 Jun 2023 21:09:55 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id CD36D637C4; Wed, 14 Jun 2023 16:09:54 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v16 0/1] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Date:   Wed, 14 Jun 2023 16:09:49 +0300
Message-ID: <20230614130952.253349-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAAPC01FT028:EE_|SI2PR03MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1141e4-f389-4cf6-158d-08db6cd8a6fb
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqaR/W1o9yU5nfTQ03Iu7PUbWEw8JlWWBBZWlLf2fbOB/txqrj8CY02OE6NMLpCynBTrC+z2N2vCUfGxs72XSFizG/QdLuIH5FOf81oD4LUVTcXEKtiFF7vBzjufav0t0bC8yTcb2ObWknrYpvmLthqyZLairn8vbKPPs8/hUjgP7RTsSj/nc+Xgq30nxsOY68gSf6RQ3q0kHX0YIa/f4/pr326d2Y47UcDL219bZTsoKcl/TEluPiXlJ0sIOGNUUEd8VIWUxhbgxoDYClJAI7xXz213/s5FxL/3VT6BRKavcnvdQorhVMnZzOphW1jKku4AcPN5y9Xnxax5bsIJXyAniRxXBfxBcfqWHy8U1YTuqUJbpBd15jeeuHZr0FHk2R+/y3TKrMv3KeuQYnSRgyhykmnmpbIAJSVZ3nUhZ1cOGjxwd0q1fjC0kmBvn3HrIZL8gRKk5OTr+vfXMMpCSAUHlFzqg6XFYhf1s49EXfFr6x1rF4k6/EOzbqG0avaihuqiwZJfyqbyBFWiCfRT6ArLo77zHttwKzIbKhabIUz2gTjTRp6Ho36PI9I6mjC0DG2f77jSZkOGf77pPDe0X4ztiIrzhZt3F0wTdRV5EdgH30SFo1uepOVZLN5WSgM68zcHxeng62UygsVI5Kk+UMDhcif7wV7Cs50WMt8daHa9TXn7PHvEej6otOYLug/mK6AgHhUqSoaWOQfYaRvFQpGiIIA/hrSx1GN4frzW+ZcTzZQeNxXZ6LjxhL80HfZoCl39gCXnGIshRtONXZrUvVaD1FIRy9abz3NQvDpMSip6SrZ1IBB8HDdT5kzafwx1Y+bDnEXeM/pjaQ2kwApnWvTN1/SahvVb28JoPZwEmuc=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(336012)(40460700003)(47076005)(83380400001)(2906002)(2616005)(40480700001)(83170400001)(81166007)(356005)(82740400003)(36860700001)(36756003)(5660300002)(82310400005)(55446002)(966005)(41300700001)(70206006)(70586007)(316002)(4326008)(6666004)(8936002)(8676002)(478600001)(73392003)(186003)(6266002)(42882007)(76482006)(1076003)(7416002)(26005)(82202003)(42186006)(54906003)(110136005)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 13:09:57.2172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1141e4-f389-4cf6-158d-08db6cd8a6fb
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT028.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6710
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

 - Stephen Boyd: https://www.spinics.net/lists/kernel/msg4729384.html

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
 drivers/clk/clk-npcm8xx.c | 566 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 575 insertions(+)
 create mode 100644 drivers/clk/clk-npcm8xx.c

-- 
2.33.0

