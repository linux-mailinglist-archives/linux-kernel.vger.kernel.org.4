Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09982747B53
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 03:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGEB50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 21:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGEB5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 21:57:24 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E89F11F;
        Tue,  4 Jul 2023 18:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0VBbxMj+1ULJBBbuzbfaKH0bj8fAnKQ46Ti2zLoQtQ0ykviDYfoxB/Q3gefIDbFvRIYwdwMayhblTB3eY32zXkZa8eJZqThtvP1jhSUBaDYGubOqjyVt6s4fA2BrRiflIVGBacQpE5AOg7iSyJJMJQnnFpfQxPHV9f5wxC1HzVCzNCrQmBMTgOnuUzA3oJjm99Lghm/ujV5YKDuDlJNIFJIN0W/qCidJriT8bcwuRVlDN6lISJhwMc8BEVUG9J0R0RXWEP/KBPQQkpw2j/l6cR+W9F/BKv3ceYIAE2RYl6+C7JMkV88ZQc+sdK5gqAG1XQ1kPJP0rPtVnqTqEfO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcdVx7gAyEz1LrQATZ8baLIehwlBo8S5APAWjB9xZ0Y=;
 b=mhkJQqRNjFuB2c31deyzD72gHAbYST51fJBMn0sHbqp6YfwR4LW5V9h207ondoa7l9NFGOrVMgUxksYnsEIkz4KnzTynOjLAai7OeyzVffh3SH8Sy8jk7VSEsrohh40i8QjbdEBLIrZgtiPSkRZVeKp54CYOYaQ5GXff5svzia7TE9zPQSBIhyDBmKNBvnSaEcyjuLSuWLldCeoD7id3gVOb1mAdWhyoZ5wnaMjGeXBCWRei0iTLGJH75CsdJKPxhreu035GJI6G3IhH3vgjVU8yzKkxEiBnoy2gkR1/nxcIb1rIvXWz5Du2UzRtgs6Dkd01dTXfTy6dy0iuTGoDNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcdVx7gAyEz1LrQATZ8baLIehwlBo8S5APAWjB9xZ0Y=;
 b=hGzUbwnrcDZmvKl+ytRYO9dmKmdhrfr/SqtJ6RmeSYA1bXjCQQ6zGciKtHn3dSCSlBDNNOADTH5HsBKk+CNi3b0qsUc1z7bJMM1CVeTskkASzS8I7zrqfjDdSmOguoLws9dcjoKySLMp+wZ82NEK7ncJQGnXwrUnIqa92ODZogg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8845.eurprd04.prod.outlook.com (2603:10a6:102:20c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 01:57:20 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 01:57:20 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shenwei.wang@nxp.com,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V4 0/3] correct the lpuart compatible for imx8dxl and imx93
Date:   Wed,  5 Jul 2023 09:55:59 +0800
Message-Id: <20230705015602.29569-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PAXPR04MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: d6cb6b04-bb2e-4d2c-15e9-08db7cfb2ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s3sF/Y7g08DNQUjdt1aR5LQVK0xb8gt/U7V9El909eJKGPCf6UDzWN/6M1Z8RwJlimTeCaM3xxO6bRjhVI7kMC5XzpzNGfuBtGkfBZ+ZCbkeoeavdHSAVx5lHtmE2Q0qZZQW/AeTwmUPoMOvmo4YDFrfVF/fU9Aga/3LxYP8xai+71D8qF+wjpbCBrGpYTtctPGr2KG4Y96aA0Axb6WCPfyj//qiYppJ4FilkzkHavByRmv6ARrRsn5Xi33w6zRMYvpWzJSFobGAoV86Y0OwzjGbOXzetRykz+vASrZXHiEzL2vsank/tBtsZsjHv1egWjQXfHH9EdosRkuGPAsNBo8aQ+h1zloGBhibdG3q2egQScJ1PBZXc3dy9SOhzMmlv8RUl8epKNCcyViDNj8bXDIIDDU5FbeCMpATjG2I/KHBVm+Uwy2k9mHUwbizehZXXCN81EZTxWxh/taDcZKh6EQlojoQMx1qH/PmpBCc0YMDpyFmnKSMLSoz7LNThy7H1C1DYbkBp/IuKLJl6pUXaSPccjDvGgKnLDEmWTbVPzxCIJ+wsrlqFNWa+Rj12wcjSaWYkmPfcZ1wd/5xbYfeKWKYwd2U2TEsWoESIQcV5DkIECzwL+XatzecH9VMT9JhTK+pI+bxOY83ZhJFa4K02C3JXyqMFhoGjBFRuj9K/fq4pzR/neL9lMco2x1x0KWd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(6512007)(1076003)(6506007)(66476007)(316002)(4326008)(38100700002)(66946007)(38350700002)(66556008)(2616005)(83380400001)(186003)(26005)(478600001)(2906002)(4744005)(8936002)(8676002)(52116002)(44832011)(36756003)(5660300002)(7416002)(86362001)(6486002)(41300700001)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SV2dCAORVpgXTm9TJjE1uKXc6iYMX2JhbsoKWAfB/BH0g2Bc99qeDnuaO6HZ?=
 =?us-ascii?Q?fAR0to7gcqXwUDOYGFymTJhMn20UpSyRxHrFnIJqgrHVSqW9uqA6OQVQrwVn?=
 =?us-ascii?Q?ZOh8R1pPJK6WAy87ez+5PPUpjgtNZkopkDUJwJWsv3WB2LRMxxoJ/2ne9pxn?=
 =?us-ascii?Q?CY8IIsxMu6YGYKBHyQlYNWQ1zwBfNp/8fnDmzsWnfUycQK1AJXKC7bCipDjT?=
 =?us-ascii?Q?rNDvZar/CGb9i7O81/yN0E4O5y2BiS4FT9GXybKQ+7We694x4a9LgqngSACV?=
 =?us-ascii?Q?FL7SPrbLhpr5ANS4jpApX1HBDwooDtRCDs330AUMYVKjNNvVEw/cCaAsBsaq?=
 =?us-ascii?Q?v4ZgBZ2FZcOp7GY1ZdGPWOqDPLiMbjrwv3+GosAZ8KMRV2Z1vN8Bqq4ik4+a?=
 =?us-ascii?Q?3fuxITvqv7tnMAjcU3LMY+VlD6eC1DwE38QRFSR1WGN46u5fnHS4ZeUC8qrZ?=
 =?us-ascii?Q?tIOAFGFVZClFI2WsGHVXOkTWYfXwz10dUAs7IkUg75GWAhy0+5VZDZt6BTel?=
 =?us-ascii?Q?9uFPkEE9Z7ZMIgu3CWJc7lRzL5fUQ4pCIm/4f2nHWQEKD5GZu7eZsDm6tRIx?=
 =?us-ascii?Q?MAX3rpgneXyFyzk3psqXzUbI1oMz97R1tsy6TAriG4NQTk3wHhY/tiw44ZSt?=
 =?us-ascii?Q?Z70oGsESJ90OEI4X7L8lHcmD7OOqtT6RHef5FnRK4Uzkw0yL0yNT8PPO4vO6?=
 =?us-ascii?Q?+fCt7lHyaHk1/WfYN/u8NTQqt21h7Gir+VWbITD+kh+MjbOlDe+3ZKVAiEu3?=
 =?us-ascii?Q?/bsZiejFPU97JXkcU0HQiCAw08engo59vxxq1kBcy+7yYkKPYMqDGopjAuXE?=
 =?us-ascii?Q?wS/jt29bxy8r7rMrdObVytQq1zBnOkIKyIycD4JMs6kMWI1KwXxSwgQnjURR?=
 =?us-ascii?Q?wDQCv5tfnrWFFSZG70+oE3DATGjs7btHajEvY0dsybFZ6F8NAGp3MbHJrE2B?=
 =?us-ascii?Q?oG9s2yJDFOqjK5mlIeTxCfAi6uwD2v063hjBoqbPDHUoJjlINo58An/hLF/F?=
 =?us-ascii?Q?jQD7epM4Qe+kLjnLhwfm0NU14tuyPeEEicjV5KC4kyx01oApjzP/3m+mQN86?=
 =?us-ascii?Q?pALoiRetwwt45STVK9AZ5n9heK+Ii6fibNxKxdzkkUIDHZ+3UWNn0n4cZcxo?=
 =?us-ascii?Q?leOEqLbsBZu5bsVA6/40uy5vOPsmb0muEMVJNVjElm31YrSteRe9rXkKTvBH?=
 =?us-ascii?Q?yselowAt/6FbhjS8/46Wj9UZN7NhgFKPwPl/xUwDsttV/xtB5zWMUC7EhsDX?=
 =?us-ascii?Q?tRsZMD2M6fCx0YnzeCsecvOZ6Yw4z439LMxvO+AtP9mxUAvxjKNt3wRDfZYd?=
 =?us-ascii?Q?Cq7xrRNRvCAzfGTlk9o17BjLvyXIvhdfTILSs10oYIbS8szoJFD/7zqoiLiY?=
 =?us-ascii?Q?IJtnMvdUST/Q8CozCcHnGlTfgC/Xnn9oxtBT/MOYujnEFTiSPCyTzc3wjNOQ?=
 =?us-ascii?Q?cm1DwbPgPh2JiZqtHkR9iKQarLuFXF3++ruXs9eU3ncwGxsadvsfbPOInhv6?=
 =?us-ascii?Q?XotT/C9rlODXNqcJ8eIxuU5bCllO27nMb4KP66j1YBnvkUf+HedRSQ4nWUS4?=
 =?us-ascii?Q?qnbZjfsnXTjhU1kSEUcPe7lelsBqzKa7Qt7s/a/0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6cb6b04-bb2e-4d2c-15e9-08db7cfb2ae3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 01:57:20.4531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oC/6iEHp66MZN2FLX1W2SKBIcKXAYGSqmwtcIHxZTuXT3s07a2ueI/NmkdQDOIOQtATb622tAU/X7TyPp3KzhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8845
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set corrects the lpuart compatible for imx8dxl and imx93 platforms,
also correct the corresponding fsl-lpuart dt-binding doc. 

---
Changes in V4
1. add Reviewed-by tag for patch#3

Changes in V3
1. remove the redundant fsl,imx8ulp-lpuart entry in patch#3
2. change const to enum for better readability in patch#3

Changes in V2
1. drop the imx8ulp dts changes in last version patch set
2. add both "fsl,imx8ulp-lpuart" and "fsl,imx7ulp-lpuart" for imx93
3. correct the dt-bindings for imx93 lpuart compatible
---

Sherry Sun (3):
  arm64: dts: imx8dxl: remove "fsl,imx7ulp-lpuart" compatible for
    imx8dxl
  arm64: dts: imx93: add "fsl,imx8ulp-lpuart" compatible for imx93
  dt-bindings: serial: fsl-lpuart: correct imx93-lpuart dt-binding item

 .../devicetree/bindings/serial/fsl-lpuart.yaml   |  6 +++++-
 .../boot/dts/freescale/imx8dxl-ss-adma.dtsi      |  8 ++++----
 arch/arm64/boot/dts/freescale/imx93.dtsi         | 16 ++++++++--------
 3 files changed, 17 insertions(+), 13 deletions(-)

-- 
2.17.1

