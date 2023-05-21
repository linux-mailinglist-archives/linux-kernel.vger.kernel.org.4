Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0B970AE56
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 16:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjEUOcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 10:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjEUOcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 10:32:13 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2054.outbound.protection.outlook.com [40.107.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F85EBE;
        Sun, 21 May 2023 07:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjD1alLhZN85NwhDejYmkfwOagiwqWB6yKssbhYUW6R+uWaOLnhw+2vqKEoRu1NjYjxouDqU4vsb/LSkjojCGr8mRrH/pKNSb0Ss8AKjy+HJrw01q9dIjNU4GI49pFeCyZCquAb1uCxGcsUl1a+YU8ANEiCScrSRKbZhcTqLmbhh9Rg2Az8LYlCgnb3epzbqBVDaB7416rzp+eeHGzrvih83FhApxlC8OApM8prfYC56/vamk3C/7G0QbTUQ2mY0X9gZhzlpYB9JPPJ/wxk6OJ74S/6pDoVIj7kn3GY/UfsGVUYk1sL17ndomaGDPT/ORxgbuktOJYti3dWBbk7bFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mx9TlUQh6dss02agMHqrRcdVOwYeX9VysKp3VlZPzg=;
 b=iv1cKUH1zk3UXMC+cC8D72pB4VNmLlqaxrO1uOeSiSu4d9gu2DFDdvqs5yAp6R4utxOiZ2TWBZFsv+Y2Iz7WNf85EFC1Gce7oki6xlWoIOujB6nY5OxnDt13Cx1hqKNEsiANDfbr0zgcMmyEyGPjqnHgljnvd58DNn7hyz5iciBqCsqRdCHFlKl863YmeipTgCU677jRYiKecM0+ZcgVHzITx70hFQJlUvSZxIfNQb6QmGLedThUWXMz7Mvx+ASBJLgWXkw8vQGaBk+4h4p3fYiIyux5kePTAiC2HPGo6Aaww3Cb/Y+jR3r0e3+x7INr/6o4uWH9azxT13tufNI7ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=baylibre.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mx9TlUQh6dss02agMHqrRcdVOwYeX9VysKp3VlZPzg=;
 b=srUIy8FZIStHJHvsyBpvyIaA++jEO8+JLdaHcECBh76aQ+HwrHlBKBQgpGa5DXFns8iwtnjjdeNi5xi+4JtBviOBmD+b1vySafU6kT+VMeSvCwc5tI3JUK2XqClteOoSTsJNrS9QkED/M+YMDv/RfP9GO1yjJyXSCvmjTaXcs8w=
Received: from TY2PR01CA0006.jpnprd01.prod.outlook.com (2603:1096:404:a::18)
 by PSAPR03MB5720.apcprd03.prod.outlook.com (2603:1096:301:8c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Sun, 21 May
 2023 14:32:07 +0000
Received: from TYZAPC01FT020.eop-APC01.prod.protection.outlook.com
 (2603:1096:404:a:cafe::bb) by TY2PR01CA0006.outlook.office365.com
 (2603:1096:404:a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27 via Frontend
 Transport; Sun, 21 May 2023 14:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 TYZAPC01FT020.mail.protection.outlook.com (10.118.152.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6433.13 via Frontend Transport; Sun, 21 May 2023 14:32:06 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 21
 May 2023 22:32:05 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Sun, 21 May
 2023 22:32:05 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server id 15.1.2176.2 via Frontend Transport;
 Sun, 21 May 2023 22:32:04 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 199DA62E6B; Sun, 21 May 2023 17:32:04 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v16 0/1] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Date:   Sun, 21 May 2023 17:32:01 +0300
Message-ID: <20230521143202.155399-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZAPC01FT020:EE_|PSAPR03MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 569d739e-fbdb-43d4-7501-08db5a0826f4
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19rlkZIbCa/xEdsmiKtqzxa+Kvh9fpEFaX9tDdCo1Rz/VqpkZzl73xLCWit7LphMUTVHKNZMEYtikfEfBE5WQexcmRoCiBkYm9cN+o0hjWoY0idsj8T85Gobjy4gkm9SUsE7ugLvjHNzZX+2flLsW6lWGrTlJ7nzRxd13C4dtq22hKKZhmPvZMz0ZC5CpIRGsX18upCayNsdWU4L2kmUV9d5MMHzmiv4PjGTuwhym+gXIRuXFSMRrGz65+0ds0ox6hcGXc0FOmYXcIq0be5k3KUb2xpQ0D92YPP8el4Vy+G2NVVS2Wi5rfluB6R5yFtUWmeGbz1sXxwMG5XiBpNaEukcYFQ2n4AYIamzVKRlCrJQyvrcsjppjbP1gR2M164qAL97WG15c5hePYEoXVKLPSgXfvcpn4E9vcMnB40AhQW8ooPFneRFJeba2E+sqQ6dr2mNh40NcGx3wrRvdZ+Rbkzf2qgLgEYTxL6AC0oHETztR+DleU9i52cLO7sSdH/RLKTa9DN4XVh1wpmX8i8xCtnTxtgy/EOyFYC1sY7muXEtRJZlAKF4Cu3Yu4qx1q0ZS5TJSnN80cLwjRQXM+/Q+tNBLAuIDPd1hrT+ECvHlOR3HgGLaC1yMUPVLC8tNeSx1PAgZy/dc5Iuo4o1HpNde/nairrRP2Sa6H6/VJBCnfEmoLYFu6FzyG0Up6kLaxGjoZhdAlYm37pkGpJp2wxkavWjQ1oVE8the2k0IBZNOLn/zowcCApP3uE0M78QVfIOns1GiK47w0xNAtxr3DdHu42e8rnJiV2ckPTyME5JseVv4zmb1/tc9IJr2K4A3qEQoXUBeEneFUcZ+JVeJV+osU/GSC6DCXRYp+GknYYcAYw=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(346002)(396003)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(2906002)(5660300002)(83380400001)(47076005)(7416002)(8676002)(8936002)(41300700001)(70206006)(70586007)(4326008)(76482006)(42186006)(54906003)(316002)(36756003)(110136005)(40480700001)(6666004)(478600001)(966005)(336012)(42882007)(2616005)(1076003)(26005)(81166007)(356005)(55446002)(82310400005)(36860700001)(186003)(6266002)(73392003)(82202003)(40460700003)(83170400001)(82740400003)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2023 14:32:06.2069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 569d739e-fbdb-43d4-7501-08db5a0826f4
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT020.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5720
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

