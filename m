Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12CA705284
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjEPPoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjEPPoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:44:18 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2070.outbound.protection.outlook.com [40.107.6.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C3093E0;
        Tue, 16 May 2023 08:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9SuZcek2PDppiIzx+DC2MOSvY9/uuScv9De8cOiwwEh/+6VctASEhHdbKtkQszm6uEYCby7Au2mtlLhs+g4+Z5mixyU3heIXzJL8AS+A7euZ0JLsReeeN5M8FDhmo+sSTcGt2gLq0dAv3brtKW9zAC4cUDya79NaYAh6+FSxs29R1mRE9uiimQ1g7qG4JEOJRx3oI6B9uwa21gNyLiH3iJH0hFTfxnAkMj0shmJGuKeZza3B3OZSuCaD/CzpIYCInPaxWdFamRc8DADcFiLewF3o5HS+YePZNcRlw6bEQ5mETnt0Hd+kb3e4hiVLpZNPimDRx3rheB3psBdyZZARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ufwrk3zSCeYlo5Nt1ddQQIbHORNCJO0m+VNlmGgjY4k=;
 b=HoZk1EFkKK4RuGsqViW3TZQ4wNeBMSGwE5G94DFBWBqO0fcTrl/4G8Q9auza1GrPN6pFvt+POw+mCdBr7aX96VeTG1yOBYu0qnG4G379fz127mmfr3+RuvYApneNOwTicKRoiDG+aXLdG50ddDXvayTspoI3J7UKT5dih4E9oNxxhp0gL6AiQjdxpi/ZcmprqujbkNw9ImiP05pN1HvKGCRwYUuwJMTj0mrrEqsgZkQLGoWGbk1J5ozV7HbhImiGJo37bakMYMAXAymRcZw6oIfPjdFPa+0rx1ZbsHHsmcoGzWfur8Hp35f8SUq1dRRax2k3LsvjO9sE0grNPwGMmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ufwrk3zSCeYlo5Nt1ddQQIbHORNCJO0m+VNlmGgjY4k=;
 b=dG80wmzOmn0TGARNHXD6EjEAQGXmp3aYJPLerAiTDOJu75aoL+jTmmDB3xZFOQ3ZC8mz667UVA8tYKeTfRbCAvGpxeuF1HIV2ivhKzHITtfazR3UnsNktIsRQDD+cFjycLRF4TIxpDL1jgqut58joOxrB8xtdy5v1tSz7/Vu0aU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9008.eurprd04.prod.outlook.com (2603:10a6:102:20d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 15:44:05 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 15:44:04 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, fushi.peng@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v4 3/6] phy: cadence: salvo: add bist fix
Date:   Tue, 16 May 2023 11:43:26 -0400
Message-Id: <20230516154329.3155031-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516154329.3155031-1-Frank.Li@nxp.com>
References: <20230516154329.3155031-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:a03:100::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d739f33-b62c-43f3-9ad4-08db562460d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8hHJxgl/RbBhxdcKYfLpxLusFmNbppqAH0Ig6oqQKio14lbYUeo5QS6tgIkDGJl4D8Y5ro87OKaaMD2d7Ns+YZDpXc+OGcLvjhVckscC9Mq/OyAxAQDREP1CmyyoYYxbWYtgNgR0R7jLrEG9nS9kJqKTvKf9FaBwqsQqiFFZAtsM3LGbBCfXikB2ceaF48TmYb5DxgfOCLPijx0xuvPia1ROV8VCH+Ovf3PdqdtB6zE3fb7ToORS8Qws6v3I188H6P0MsarY7frh6fFEnh7mLI3V2PTEJsg8I/KyOJStx+3qrUSy7UdfhXWsrGDwlIWysu7KXtO44aJg/ZpSIBzHuTKsVQ444g0iIGRw0vsZu2hexiU46NYGlDIAPaeR6cHZB36MluJd52wsGdemDmNbT98bBCzDEz7WiXOiqlN73Ev726fLE8b3x0JHFR9qTwVbGfuJv6W8z4aNv6LbTIbPEV1ry0K/XXVckiyqYtEo80QxZDG0e15KkDy5fh8eD0rO61jnxvXmeSN2MKzBcEQqGDPriuwflQOfwNaf1PO9k6d7boL4g69MrCMN0/rbZRYFMNsfBA7pjs3orMHYHzfsZGfu2ToqgcBJSD3XnCqWXXa08DjBUWdxbHhjRFwnBgO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(66476007)(66556008)(4326008)(66946007)(478600001)(6506007)(186003)(6512007)(38100700002)(38350700002)(83380400001)(2616005)(36756003)(8676002)(8936002)(41300700001)(2906002)(52116002)(6666004)(7416002)(6486002)(316002)(86362001)(5660300002)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lskkYrIwJxgIUezGXaLpJx7kuXE92o6qVqO+Q53WxSmQiQpTrbpSfGSvW9gI?=
 =?us-ascii?Q?BYIwNEXJ69u/rWxG76IN6h4VmherplVY3cs1G2eo/781ftAi4F414BPcvYyf?=
 =?us-ascii?Q?tBJfcV3RmlOhyciAPORTki/lMb7jblQrM4cAYSuvsDdk8qdiITqDj2WSQDbn?=
 =?us-ascii?Q?5vN/OYKizSmVmgZFNOOtgkZDUS3XkL22eWSrsMacwolaUKXNWSfikAgiA4Xw?=
 =?us-ascii?Q?NLVBxv4o5A//5RKEQZPL7Sb86v3qew9ebca4fm7inv5vwdaGUt9qXizAHrCP?=
 =?us-ascii?Q?09s5lguYdUi4pLtbIVZyK9IhJls6Pce6VGoCW8ONHM555trN1k9ouUQWrn/d?=
 =?us-ascii?Q?fhyuPh4lYY7ysjLYa/45UbzBlDYckSQQmGEooYhxNCgihNIP018kOKu+pUg5?=
 =?us-ascii?Q?iWmFMFGfWy8cQD9/Ufbf41e9ktPBG2LPki4mRAF2oX/la6pokeL+fieU4gej?=
 =?us-ascii?Q?86u5W7Dh64H3kvi5rwLFNdyNIPrMt6jKz5i7Fg/RI4WXRNYdWsitHxlytxGk?=
 =?us-ascii?Q?JXknUM1v5GMJ80BXHWjxqH8+s7fYCQ0t/JqEfkt5XLuIBYPRaQbThtJgjmRF?=
 =?us-ascii?Q?GmNvZIo6VZe+lcnOOHCF2L1M5YYivx2iSabcJkvGjz6iW/f67tWiG3YRhx1i?=
 =?us-ascii?Q?clDyt7MihxWzKhcZvtIIX4MEbvGsXcAq9spR6fjTtevyJUDyqDJUDUzJng6Z?=
 =?us-ascii?Q?DKzuYVmOt3qW/O/N+j+gt1BTDIcZeKeGGoCROoLEGHYuYraWxkv4eAk7Pifd?=
 =?us-ascii?Q?AmZB7qUshsaGKtSuotsG6lRrSIRlMVaMbepDNooec15VwfbKaS4fKa1Msf5X?=
 =?us-ascii?Q?xhGfYdSWHq5jWCqq01TeFLggA2iMZi+nCe8lYUZCUrNh67enwwm3T+vZ3nCg?=
 =?us-ascii?Q?tH/8anK2eH3VUzl8OSGdzFHHUpKYgOsA6HCBhnKHrMQ8RLuzf7wfyd3/H4Nw?=
 =?us-ascii?Q?/MTVX1z9caQzv7+H6ngT17i+HBklIOIIYYUNz9BeshplG2WTm/qzBOgFniVm?=
 =?us-ascii?Q?DgVG6ZJe46pYD0Mjm9bMVuLQ5JheVnVYuZzWmqayHXIWy/15IgLHj8Iebn5L?=
 =?us-ascii?Q?zokmBd17s1SawlIC68IfDtbi6AbCDCmjPwfBzoVaaCoBsjubuleWpTp6Lnwk?=
 =?us-ascii?Q?RoIUgfctT4AqeOaPzki1PcrmXqZz8vyv+k47BF3BSke/s01UkmjB1HcQFxqL?=
 =?us-ascii?Q?k7GwA9u/CSBur69H/mjRAe3CjlXoM2RdMkMLhECRKdtmKa0tvkg8E/jeMz+s?=
 =?us-ascii?Q?SZjfdzdHWEGGJlAOKWGfKUAd/vVwMn3ysz2pBjbpmiA3oPi7xGT483rhZiu7?=
 =?us-ascii?Q?HKXjx9vC8tdhsD0l2YyQuI4VNm62IoopLWzsO0uKJzuLc6kiltzFNGjW2V8N?=
 =?us-ascii?Q?OVVufd090WhWtffNe9JcirKPI+hqWDV83fbM6xEvmFE+HEbQl+yFQXsPPKaA?=
 =?us-ascii?Q?PnaGEyWUwDH0tzj/tO9SSz8ip8DKx7QlfHiwu2y/sJKiDRTaO00lTPZL6OP9?=
 =?us-ascii?Q?hYd3155O1Wl8Xj2FoXwDnPG0PZhnyFG/UiUAScM7YtEOdDFLhLYKycQ1uY1u?=
 =?us-ascii?Q?zpHNneNE47fWvE80M0OwXg2JTRyV6YkH/u3ZkYK4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d739f33-b62c-43f3-9ad4-08db562460d4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 15:44:04.9567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idUhHDqjP3OWtNQ5dY6SxlbMmIBSsLi1e2S1zRqeV2Q31kCepyhdPmUqZBhbbu/25Np+Lr4Uhw5ySN6raRPgmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Chen <peter.chen@nxp.com>

Very limited parts may fail to work on full speed mode (both host and
device modes) for USB3 port due to higher threshold in full speed receiver
of USB2.0 PHY.

One example failure symptom is, the enumeration is failed when connecting
full speed USB mouse to USB3 port, especially under high temperature.

The workaround is to configure threshold voltage value of single ended
receiver by setting USB2.0 PHY register AFE_RX_REG5[2:0] to 3'b101.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/phy/cadence/phy-cadence-salvo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadence/phy-cadence-salvo.c
index 2e3d4d8fb8eb..b9866dc146ce 100644
--- a/drivers/phy/cadence/phy-cadence-salvo.c
+++ b/drivers/phy/cadence/phy-cadence-salvo.c
@@ -91,6 +91,7 @@
 
 /* USB2 PHY register definition */
 #define UTMI_REG15				0xaf
+#define UTMI_AFE_RX_REG5			0x12
 
 /* TB_ADDR_TX_RCVDETSC_CTRL */
 #define RXDET_IN_P3_32KHZ			BIT(0)
@@ -247,6 +248,8 @@ static int cdns_salvo_phy_init(struct phy *phy)
 	cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_REG15,
 			 value | TXVALID_GATE_THRESHOLD_HS_0US);
 
+	cdns_salvo_write(salvo_phy, USB2_PHY_OFFSET, UTMI_AFE_RX_REG5,
+			 0x5);
 	udelay(10);
 
 	clk_disable_unprepare(salvo_phy->clk);
-- 
2.34.1

