Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D25B73F579
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjF0HV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjF0HV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:21:28 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89BE2D4F;
        Tue, 27 Jun 2023 00:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kg+cvKv9r99adWaqsUsX66R4bs4N/XLAqhTOtxQdpOaYYcTthpHF+Vk+qbocuJE38plU9azg3riK9uUbyofYvhWUZ8OQMmr8UEsv7NHMM4p6FTUZqJ3DDELYF4HNboMQjbEo12HwhS+BhiznNJIWgzY0qxPKqh21+K7vc75HjTfTow1dULzig+muh6g28t2rWPniJ80tsgscRjSxbkbWlqYs5nOwh7wO+umgL3kMtOdFWRXRleYhiH7SDzkhhCGDSb9PBBIsYyx0gjboQpnxuN7FP5QIKsm2x2JyCkxnPxs83F8Yodt6qWY+FM6bHJxasmqSRcJ/Q8cth+CoLxY+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gr/tpHn91muZq/SMbkBuiw/wsHAppbw9sPLHDDI5wAU=;
 b=l/uWPHiI6/6jIeCzvmxqjXH0bJ4kLw5oz3ynOOrc79FdE3Nlxnvi/pM7Mz50poxZASrDi/XRQJMpeiWtg0kE8SvCs5rMqoemhkkHMFQdwDl8SqPSZfJHQmmefjH2Cf+SZbp5sQrsgSLRzTdq2X8fdu7JNibDy3hTuKNdh4AIkb9aluMe+POiLkpnHuWbvaFn0v2Tfvqq/05Ok4VAq54XLV0yYOzdIj7wNQw6qDpqfjghgw9syfTT8R8yNlvwRQNgm6hN5cisJUQ5/dNAjeJjIkNtCYt9FfkyqBvRlpHWSxmtbilbR+lFztDg57C1sKg52Fhqz7v/zLMJMusrYhpsuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gr/tpHn91muZq/SMbkBuiw/wsHAppbw9sPLHDDI5wAU=;
 b=cZX1yBw2XCPqB2nlGm+TXbLG2Lj7OPMjjlG75JYJ6u7KO3iZTIJnqqgrIPZZFyOiHzD4U+IZIp0MqjhoXL4WbPgxhHrhQm+WB2SOx6HjcxrCZ48/26L8NN/0aUHK25kceNreMdFOpLAff+zFS8hQ/0YQ93Z0aa2dN7bYFGYuMV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM9PR04MB8778.eurprd04.prod.outlook.com (2603:10a6:20b:409::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 07:19:52 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 07:19:52 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v3 00/12] Add TJA1120 support
Date:   Tue, 27 Jun 2023 10:18:41 +0300
Message-Id: <20230627071853.106215-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM9PR04MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: f741f398-1361-457f-c3e1-08db76dee627
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FOfSkUP8qmvhSrFRrmuaMNtXESne5l5+GZOigEF6t3WIk8XEf5AI/c1P+WjSHOK7iGHC+LdqUH/nkJ7xnII4FEaCBtyR6jz/fc8TQ1zPC7LkIja/o9apRP1RXRA2bLOilLzlKMNn8gdhQ12z8h9m2wrXGXSUmAr74UoRgGgOnqg6LXiyZ16Ve+yjMWK0WzZ3zWvAf6wNu7aVYc4rSuS3P+jBK5G3WuzoUiFS8uGbKz4HLwrzTqtZaoi5zw7HCtBLwkRpjuf9iY4vxARMAQYmQ2nefSUvatgCAvH2/F6ivJbEkIx63le0canSwTz3rXmbaLgSP5PN8IIYXAy7zsUM9YpaCNrGsQ8+GFmvX9BXmekmmBwdbjttOsrw2LvNJIYwKWK7thDrgAdC/oKT/bDIMUVtcsWRi2Hr+BWqE3XiWVuDThyez248vUgTHM0Je85K2WbulLofaER/EkDspKJ9DInJAhWTy4EL31E+2yx0DwX3bjv/8c0ECJJ6VhywnuT27drB/B4fMgL03oYk1DD5GF1uivM/eGIhWoOPw8PyThjoHUZeneCZ0dOWarlAp1jaQbS1ry+Z7huztqOmjSfOpQ9Wsxo7Bj4lkdCdAhuXXXWdVMZtNe9/FI7UlKZUXucU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(66556008)(66476007)(6506007)(6666004)(478600001)(2616005)(52116002)(83380400001)(26005)(186003)(1076003)(2906002)(6486002)(5660300002)(7416002)(316002)(66946007)(38100700002)(8676002)(66574015)(86362001)(8936002)(41300700001)(4326008)(38350700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3appr0lNdcxOxG05otd91H8/DeFbA6s+gq+1SmdpQR6EShHOBogUyZRL8ao3?=
 =?us-ascii?Q?THerT9cu80ns0MKZFyib3nxegixIp4M3aORJ84Gt3JOK+cpyMeeDPVrbl8lh?=
 =?us-ascii?Q?STUnY2ATsV42jX2U2ikWhkkMGmQE1jujUkI7IO4aiGDf1FALxnOeyv2rXGMp?=
 =?us-ascii?Q?FuXCWtfcs9inFG6/4JvaoGkNmIEgr/Mm4qc8KF5lWaY9T2LoHHo1icERDodv?=
 =?us-ascii?Q?q0g8Ch5Cg051ke9Iho8qcSVaruzk3vUKZzMnPr/lJ8Gl3gwg4LCO0UjBvgY4?=
 =?us-ascii?Q?vJbdjNJ3DSEgvVhpVtGWe8EN7bgG6nnDqEA8dwpyfwWDJIhnAgFulYVNRL1V?=
 =?us-ascii?Q?ed24MfSpgAB7uMNyzQSfz4qI2wFSqaeCW5PUC01MEu2mtg2MFLVUzx9aIRmX?=
 =?us-ascii?Q?eu/yAO8TetZGCtk64kHLS1aIXHyM4u1mMWIlKvQJ3nTZrEC3SpM3ILLq5alW?=
 =?us-ascii?Q?3D3BkugYm6tPkKEElQ4sDSKCKyIcXxaTmscaognKDC1ho4mLl6P5l507Dzb6?=
 =?us-ascii?Q?1QLX4p/UQVUXIdG6TwBEqxUrKqpO5l+kaZI1OLAaXvYAenwA06xYyNcN72Og?=
 =?us-ascii?Q?w/nB1Co6Z6H2nrnPhuUHenJI2hCklB1uC7b/iV8Y0saQAOuWv5pZnkkDJTkC?=
 =?us-ascii?Q?nXvw4DDRjaNzBB0W0r5RWxuaqKOMovh+5kyqvaCBaliuJVi4hCrlKTyKnUpx?=
 =?us-ascii?Q?egAHsVsxyZRYPkwKYEPRYfzTEg+NsphL17e1yh8i5Qc2J3rCsI9x+hSpsVA8?=
 =?us-ascii?Q?WAbd//8pTKDLnj8iK5EVMkpPfPXGrni2B4AYsdAeCNzmWt4czNJAscjOil81?=
 =?us-ascii?Q?+R0bo9GBd89uArur/o66fzwMAX3+r5KNMsCUdWPAKluy95BD3FknOzbjL7F6?=
 =?us-ascii?Q?rJIRvyQcYCMH2qIOem4jihwrU/O86Um7+68DNDNy7LecQBqpxoiRlmAkXSps?=
 =?us-ascii?Q?1AgT6TB0kRcQcwCMf3WrV32V3mvpj/xQlEQ5ZQAPoGeZB9sDPZhXRpL3ePgg?=
 =?us-ascii?Q?tpPwLYHFcxV5QH6xR4/XuTyj+9oWUi4z3fchS1st9Fmi0Yio9JcPAV1XgBVK?=
 =?us-ascii?Q?KqbL6wB9ZNmihu+wt6ULqSpqSWw3bg9S1p8BGmDPIOs6oEwaDwQD7rZfwcHi?=
 =?us-ascii?Q?BgUZAR4atxtF3hODVkKCBMcvfHbMSM+wHX7+SGBFdUOHXmQOGZ6pKcpv63U+?=
 =?us-ascii?Q?8hUoVCVx7f1AaYGZsJRow4avHlQRZr/iJGcuTlSuwjirhmWUFawl1e4jw5OF?=
 =?us-ascii?Q?6G9W1tg1hMH3qBDR15IfPa3NdxpBFVMvlnZfkvIzmDBIrAoXMdsbXawXClmE?=
 =?us-ascii?Q?hsh5cqzxUpZg/l8bkEWBo6QrPhA3ZNHLr9LI0CKwMYLicm4cMQUSgc/Km9CE?=
 =?us-ascii?Q?IuPzWAWN94zyVPVUPHnb9cEp1ET75lwolg5zjDCuYsF0XtM6D2YGa7UejdqK?=
 =?us-ascii?Q?UY2T5W6tp4ZDfYibG6x757dQrMv53TMhIdlekkiCCk5J80J+KTljryrVvdDw?=
 =?us-ascii?Q?fMtZpdAnUWo+izUA42MRuYG8QABeFuW0oDVZI+8nx4zr/UnhvJVdLjMenojO?=
 =?us-ascii?Q?JakJxs/FBCLuAzWMqOX2BFauRJbwkea1mXotU7x5fFDu05U8TGROvSnkzX2N?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f741f398-1361-457f-c3e1-08db76dee627
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:19:52.2894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vs4b+wLFn9ywpYvEzwj4uiDf1oR2iyAqrZUNaY9V+IG7O9y9YcxDcp4MDHEsdJe/Lm9A0+ylLxZJlAwlRgPuhMC9d6l52CgdMQqDu8MkRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8778
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This patch series got bigger than I expected. It cleans up the
next-c45-tja11xx driver and adds support for the TJA1120(1000BaseT1
automotive phy).

Master/slave custom implementation was replaced with the generic
implementation (genphy_c45_config_aneg/genphy_c45_read_status).

The TJA1120 and TJA1103 are a bit different when it comes to the PTP
interface. The timestamp read procedure was changed, some addresses were
changed and some bits were moved from one register to another. Adding
TJA1120 support was tricky, and I tried not to duplicate the code. If
something looks too hacky to you, I am open to suggestions.

Cheers,
Radu P

Changes in v3:
 - merged "net: phy: nxp-c45-tja11xx: add *_reg_field functions" in
 "net: phy: nxp-c45-tja11xx: prepare the ground for TJA1120"
 - rephrased the commit message for "net: phy: nxp-c45-tja11xx: remove RX
 BIST frame counters"

Changes in v2:
- dropped "net: phy: nxp-c45-tja11xx: fix the PTP interrupt
 enablig/disabling"
- added error msgs to nxp_c45_set_reg_field and nxp_c45_clear_reg_field
- used phy_err instead of phy_warn in nxp_c45_write_reg_field and
 nxp_c45_read_reg_field
- removed null checks for .driver_data and its fields
- added 100BT1 and 1000BT1 features bit
- replaced .features with .get_features
- dropped changed on TJA1103 EXT TS behaviour
- improved timestamp reading workarounds
- merged patch "net: phy: nxp-c45-tja11xx: timestamp reading workaround for
 TJA1120" to 9 and 12
- implemented PCS reset workaround in link_change_notify callback

Radu Pirea (NXP OSS) (12):
  net: phy: nxp-c45-tja11xx: use phylib master/slave implementation
  net: phy: nxp-c45-tja11xx: remove RX BIST frame counters
  net: phy: nxp-c45-tja11xx: prepare the ground for TJA1120
  net: phy: c45: detect 100BaseT1 and 1000BaseT1 PMA abilites
  net: phy: nxp-c45-tja11xx: use get_features
  net: phy: nxp-c45-tja11xx: add TJA1120 support
  net: phy: nxp-c45-tja11xx: enable LTC sampling on both ext_ts edges
  net: phy: nxp-c45-tja11xx: read egress ts on TJA1120
  net: phy: nxp-c45-tja11xx: handle FUSA irq
  net: phy: nxp-c45-tja11xx: run cable test with the PHY in test mode
  net: phy: nxp-c45-tja11xx: read ext trig ts on TJA1120
  net: phy: nxp-c45-tja11xx: reset PCS if the link goes down

 drivers/net/phy/Kconfig           |    2 +-
 drivers/net/phy/nxp-c45-tja11xx.c | 1134 ++++++++++++++++++++++-------
 drivers/net/phy/phy-c45.c         |    8 +
 include/uapi/linux/mdio.h         |    2 +
 4 files changed, 873 insertions(+), 273 deletions(-)

-- 
2.34.1

