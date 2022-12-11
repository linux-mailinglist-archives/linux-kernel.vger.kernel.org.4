Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AE364964E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 21:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiLKUny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 15:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiLKUnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 15:43:50 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2070.outbound.protection.outlook.com [40.107.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70B7DEB1;
        Sun, 11 Dec 2022 12:43:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWpC4n4JTB2ZilfU0dLVsbxFwFyw8tvm6Gu9/jVWMykzgixObDVujRcCudT4fHKFTXYmrCF+RKowBPEsuQ0+uwkAy5z910iRrg22PRdggRbeURj2lUCQ0iJfrRV+9EO9hEr2dzmAxZ+gbvMkF3yBK1/STDvLI8/FhQPUPMfQKs4dCY9F0Yp7QPSasxr2udmiHzvD/dq0XtvNqAlkqI44Lxpr8w5h5N1wjODyaTE3SH4eui+7rEoVu5JxAIk1IR7DDf9TKAlF5BQadH3+h4Nk7GAP98gaIn5ad8DPsDYCPkChPChKGv1jyeyw3gP9jcv82Ba9YAqyYthE0BfUixvk4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDyZJRCrujwlM72AYubigNoPblhwgLarE7/jHC/ZMaY=;
 b=TgHKFWo994aSPRQBCz3dWT5n74GPVLhYChBKl6p8S6z+1Q9zirIKYfsupbCmNSGgnWiTNUxvTzJQ9s92RwCUBvT4VsYACVXrdUBkAOj+v9pYjmay1PFvrwc884clh5CQuCECA8HrzWZYP/tcss2ICzTw9ecCST1o9/oKznGCF1KcHXUDcA3O9boBP/fi9tuar6AqS4CG5YKu28i9vaMfEXjXdakuFaZLb1Z9X5pUSJrek7+9kTUG1a3ph7s7mASBO8hS9mPwqJ5M0pRXIb4Sla2IoE8rhZXuXGKRKZUICDmZdDONY1luXwEY8u3MRBF+oBHrQnTPKPqDnOfNJ0GeaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDyZJRCrujwlM72AYubigNoPblhwgLarE7/jHC/ZMaY=;
 b=D2JrsNa4/6PkPN3+S/cjyJT6tGKmtys5qeug21JJlKbus//kSaxAiIEfMoJQ9TowAqY+WntAQ86Ghjs/B2FjvS43Os7KOh8/vlGFX6q2ODxFAbbOdfbC6wGZJrWgs41Q5XJqPlL2cRrl4/SKH00v6vc5NkWxllYeAzvMx4UK/to=
Received: from TY2PR02CA0038.apcprd02.prod.outlook.com (2603:1096:404:a6::26)
 by TYZPR03MB5884.apcprd03.prod.outlook.com (2603:1096:400:124::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sun, 11 Dec
 2022 20:43:40 +0000
Received: from TYZAPC01FT056.eop-APC01.prod.protection.outlook.com
 (2603:1096:404:a6:cafe::5a) by TY2PR02CA0038.outlook.office365.com
 (2603:1096:404:a6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Sun, 11 Dec 2022 20:43:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 TYZAPC01FT056.mail.protection.outlook.com (10.118.152.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.20 via Frontend Transport; Sun, 11 Dec 2022 20:43:39 +0000
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.7; Mon, 12 Dec
 2022 04:43:39 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 12 Dec 2022 04:43:38 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 061D0637C4; Sun, 11 Dec 2022 22:43:37 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v14 0/1] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Date:   Sun, 11 Dec 2022 22:43:23 +0200
Message-ID: <20221211204324.169991-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZAPC01FT056:EE_|TYZPR03MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: aa64655c-2be3-4baa-8b44-08dadbb86274
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Z+eLhbLj0KhA4PH+DVkMRr1oIJKjZIMrl/hqlunrRPljkxtWVMMEaulVw+hzfMZGzWaVBJGwB+GRgV9EqVdsDT8WM/OOWl4V42ijPngCw31QQJhiqffk7MDblxULAGOvHgzAU3yUNGmaNve/y2OBTsRZm7wbHWYPlBlWpdQ6XsQMfEuEAoK4YiH8CXjVQsA5ne5OfprELigxvr73xur9I1dK+7df0l3CdC4Muu4oiQOtSBdcmSkb1iDGwT0EQGeraJgU6AS+zK+9jK1hCk67DUyyG7txSMZGPtrHnEIn4+lwRAffuKWK2pvsnWS6s7/XZAuWlFgoFQT8HO+VqBD4V+nwuECsRswi/VzJkGv9vHxKoOOb0wdvwPhuiAoMyu4kDOFvxkma1bUdOAsOlgbr3By8lapTWpadTU1hEmfkUwDx9dL0JXJcoHt73VNS8zyIWUeJihw6pxY420Nt+hMt6UAzaNArODZZ+mHBmSDw2isII+sKtMKEz1qOiw/+8D9MsZhgaOMmEqXfzhTLwwy85zRPyswByGskhxcrKZS1xoUojsGayX7l7xnu33Sa98s7PBRUOqOi96a+kXpI1Q8Ni/iWpF5TNC0Iy8T5DQiBst0sOD2ycdJxeT7o/4BmjRNujMKJpwMVLYiKjqTg0KReEl4SEEHQbbf0SIfgQQe5ZbGH15jD8C6oTtHfGwGfmwODRdmOMsqCzxX+HEx/MwK3wYpb0kayM+fDLrGXAjsYHvB1vDIYZpot4phkkjtiGpPHrBFsbeJvUl1od8ncZLkTGguiRZ9P7aDNtjtaGfY6W1VSykh5yznwAJFfoSHmhJudlHkV9qSLYXSGOGV9h8bEb5/iDMWIqIvEetQEd+MrTE=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230022)(4636009)(346002)(39850400004)(396003)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(478600001)(6666004)(966005)(82310400005)(82202003)(6266002)(186003)(26005)(83380400001)(36906005)(1076003)(316002)(42186006)(40480700001)(7416002)(5660300002)(2906002)(54906003)(70206006)(36756003)(70586007)(36860700001)(4326008)(42882007)(73392003)(336012)(76482006)(2616005)(8676002)(110136005)(47076005)(83170400001)(8936002)(356005)(81166007)(40460700003)(55446002)(41300700001)(82740400003)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2022 20:43:39.7836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa64655c-2be3-4baa-8b44-08dadbb86274
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT056.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5884
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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

 - Stephen Boyd: https://www.spinics.net/lists/kernel/msg4620417.html

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
 drivers/clk/clk-npcm8xx.c | 650 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 659 insertions(+)
 create mode 100644 drivers/clk/clk-npcm8xx.c

-- 
2.33.0

