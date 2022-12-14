Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566DB64C297
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 04:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbiLNDNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 22:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiLNDNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 22:13:48 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DF912AEB;
        Tue, 13 Dec 2022 19:13:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjnIt2rk2AdzOWsUO21ZQOzAQECYHks3UtLkVVv3IwHKyE6378r1Cg9Q3fCDVYZWvXSwz6FycLprDVFrrjDz7GMsoyp9OJWe5AOaCCAHe3ddwoL2OLBdmKqWGRD/an3R6OEYKSux+sc/ft9kSruTCmq655uJRQzQDJYRgz44qTU2fEep41m338VXMrOn28QollQQKU62w3LXwU6UbzRs4Kg5qUCV5o4y6IFwiW4LFtHW8Xw/4E9sOAzXtXKyWZeVGvprjYkAVJxhFGRRqzdLC03qlB2hob+pXivWMgFz0WFZo0HAXZFHKmdB7WJi0Di1BVff1EXt6lk4IQZL3NK1uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6j6owex0Nd1JUfe4YRHEu4nROrZNb8rpABMlo3Dq9yY=;
 b=eJ1TKQZmuPu1I72e/ychf7ia71xeKtV5+qJHRayWsYxqCaFc+380RQeLLwEc+q9yyM+VzzBNOCjVQX8zhhDdjVonvKR67zO3fD1Ej1wS2m+6SMIfk//oofu3I8wI+YRDT+wH0SpH0V6jY42TIxAPa7UJZ/wAQ7IHfXFlEisXusnxfngPOlANaLtdsG5BDIaWqk3vHOJUhAG7zmuufo5EDGhh6EXEZhceMBAFB8wL616fREyeMHtT0yWY6oH71tR/J3sooEfN2kQS4MzLnVZATWOnYcaCeEfKYcFjR/bsjziEzNJJr0k2kjDk3xDd2LnVCpdMGwvdoz2hTD4OLe/ZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6j6owex0Nd1JUfe4YRHEu4nROrZNb8rpABMlo3Dq9yY=;
 b=VBdI1Qi9Odu/rsv3ArBhWhP+bXs1KrNe0CXWAGX/nz4g0ZfX3nBqrib56B2MCt3+IWRCcTeVsIiMZDGmuiLnaTczOlTNi57OlDvEzJHfl2NVvQtD8CYGZTt9wJxMRdEIm6EH4RlyKPPKoTN6BmzY+NSfWsQoJYT/aoL6gkKez68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB8316.eurprd04.prod.outlook.com (2603:10a6:10:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Wed, 14 Dec
 2022 03:13:44 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::aaa8:55c6:bc8b:6bd1%6]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 03:13:44 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 0/3] tty: serial: fsl_lpuart/imx: improve the TX break settings
Date:   Wed, 14 Dec 2022 11:11:34 +0800
Message-Id: <20221214031137.28815-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DB9PR04MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d0f475-70d1-41d1-d4fd-08dadd81344d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihPMpFPQ292t/lrGBUuYzq+pDaAUALrkV6eULhTB/tVD1O3+sBvIYedQnybp9c0pBV+p37ubQGz+VrNGGFNrDQXtlJYE3rYb43/wz2tlwrbae3fIP4wJNr9Qc/sKfdb9jOyQS7A4Z3iemqg/oPtuXw4AZNOrtUFo53pybLiuOPHOz3Z8WxDFrcxFVxo9IdNPSmjUwPq1w7KbUndfgO8Y0InbHZ6RVO0W9XH+Rmg002j/XFdX4e7YL9uewc7Mk44q+5Z5hCDXNPPmYGVIqGIzDmtzAYogpszm/IbYQkvlrMtRfQuiOJV24fy9ppieSIB9aL2e+obMw3ejIUty7Rz7EXKgZTxikbdhi/QdnqLVOO4aaReuwWwXC9mdV10TtLwuVzoMFPet9R/TrtTIyNde7pSHEo4BnqBqB30aW1no84/jLMAO4vJUoIBcKilaU6u37GeOHC1wWOvo7HsDpbjfV3klX7LIf2uote4ViZE+4HOS9h8PBIx2LVbnftfc0BzmnGJS57azWRVBFc6n6SWnDk8X1GQn17CnEbLrTWn1uOjPEE+T4gwAtTWO1ZjV9i49oGy4t2+Ue3up9cM8s57BRuovq8W+7emypWqNfjFLAUZH92frKZ+c8JMB+Mm6RcxpDjBvp3svx1pHB8D8dXmKWDTSSMpGK3dKw8mU91Pg8oSA/uAUQVaiOC1GJScJjace
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199015)(36756003)(478600001)(52116002)(44832011)(6666004)(41300700001)(66946007)(2906002)(4744005)(38100700002)(38350700002)(5660300002)(86362001)(6486002)(2616005)(66476007)(1076003)(6506007)(8676002)(316002)(66556008)(4326008)(6512007)(186003)(8936002)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Al96LWOwXRQO2rK2SxhmdUSjF0FaGZvSY9ojV3M2DuEZIcCQPlgeyx/2yoJ3?=
 =?us-ascii?Q?kPnYHP6h6fTRyxv1TxFjRjmefFRB8+HAquS/X6b7i7/UDte4wlUtXgOAc4M3?=
 =?us-ascii?Q?Dm3D9s7BSCkXXkJdB/YWnz9K7O/wG8mSF9kHNi4+QK7lCX8ow49hzqSZUYIK?=
 =?us-ascii?Q?9eAgV/C8N2lu8sPMEAJbRyAFolus4c9avCISR2SHMv+7HQuxk10WdSBLZKNN?=
 =?us-ascii?Q?gvUj/ChyZyJ3RvAHhAYZD74YKjnz+lfwR6dSuefwegORQbDiFNVGEr9HCKZl?=
 =?us-ascii?Q?sTb5AvzsheKYSmgaIJkSFy73tm0kAvXi9WlP6NfPhYJeHhAvBi10Em2xgtad?=
 =?us-ascii?Q?xSakTQJtmPCbJeqMslFhT8s7oKiCwT4n/zNxYCSMCRoYn1k6FJo8FlpUT3w4?=
 =?us-ascii?Q?eCro+CDkIMw9QuIQA6EV0xW0VJ833hGXXbv+nvSjD36DJnYD4c390RyAoTAg?=
 =?us-ascii?Q?P3EVmJDvo5m/eNsm+NYOozPK6PwgSP1NGoyMNWFpDTizLAh4zjbFODMX+dzx?=
 =?us-ascii?Q?SGs0u+bLAZj/RmlVd9wWnl6l0vZpUmuejrW4Z8g6VEHlXE4S/40nA9m8i+p0?=
 =?us-ascii?Q?srl2z6LSjeM2NYKFeO2nDBKoyxHIRCHLjrABv2sxLkwHVnn7MIs02I8akDkH?=
 =?us-ascii?Q?oyFjyCyUkI8iigEC9m44VVbJ3T9+ldlVcxnUkPvM1TrGgBFRO9j2ztVwVcLH?=
 =?us-ascii?Q?33+7dhvNbdS8DBlm70gF8T2qZMH7dp/zPX2dXl8uqTWpv9ojrrstbpheB3Pn?=
 =?us-ascii?Q?17FZcMztkIHfm46xlOJHVX7g68Ste26S3j29N0oVSHftF1lp0cY6Fl8QUdGU?=
 =?us-ascii?Q?OY/wpjA8mN7gPI1ubtLuTvfcBopNyG8WwaSn45Kcy7Y84HMYAbNBC1NtZ/9a?=
 =?us-ascii?Q?L3gXdryBrOGJEXejj0kGea8soaInVqBC3zCSy+pGamwxUbU/3rIh/+TN5ufI?=
 =?us-ascii?Q?nVyGVTnNq4iVcVO6+U+UO3aq07ztGWaB/aiQ9RsNxRfSC9TMYy5aLD9AM4Nu?=
 =?us-ascii?Q?sRId0J1/fKoQB+BzOJyT6zT6PZIxuoThZ8vJ49VKuCo8LUdEM1lmgyWXun8T?=
 =?us-ascii?Q?sEnsehSv0Eu4jxF2cMb3DREYgaAdNILsXGbD0SM/5g5ym1bl1lKAihdJUQp2?=
 =?us-ascii?Q?CT1mIXx5MatZcPeAHNp29XGQ4DIKLBGeQjx8BUtJpRmuMqXYuAEA83YOkbXH?=
 =?us-ascii?Q?QztL3eGA3R3+AxsusmrtKw3M6k1SHQMSBIOFvQUkr1Pw0Dc+JrtPpEuiEZ3s?=
 =?us-ascii?Q?h5Kim5m0KN4BUd4nqbIonNXQ8BbaQ7pktHKIwIHh4oCbsQGr36aaMCbQmrYK?=
 =?us-ascii?Q?XYH4QbQDE+T0LwJkvwGwGmh2njvcPDypChbcTAINhOiJMJJ9ZJXjZhnsQb7r?=
 =?us-ascii?Q?TOsN6gLT5dfIBBAWlD3okaJ0AoRh8Eg3HSQ2JniinngQpy3mn+xbyoNiR+f1?=
 =?us-ascii?Q?i9ad7LpIr2cm7572bLlhlpfdPRRqDcOfq9im9iEAA16qEgAczo2NL3V5fzn/?=
 =?us-ascii?Q?rgJpRkxhVJJ6mfR0tm3ZGiUPAA5zl6H+IwR4WQWpa3w3NRL/04Ot94tMQEdj?=
 =?us-ascii?Q?J6tG2d0naaUnqLuPDkeYNPw+8iQ6KjKRsE/BaT4D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d0f475-70d1-41d1-d4fd-08dadd81344d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 03:13:44.4085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6O5ZO/fsZgOUPCFA2wVVtnZO+jlwJlHOUvnKTASNhVnOiwyASwX8+lfZxG51U6oQqah+D0L/JcnuJbPicfsPkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8316
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set improve the TX break settings for lpuart and imx uart driver.
Add workaround patch for a LPUART IP bug about sending break signal. 
Also disable the break in .shutdown() for lpuart and imx uart like other uart
drivers.

This patch set has been verified on imx8mm(imx uart) and imx8ulp(lpuart).

Sherry Sun (3):
  tty: serial: fsl_lpuart: disable the CTS when send break signal
  tty: serial: fsl_lpuart: disable the break condition when shutdown the
    uart port
  tty: serial: imx: disable the break condition when shutdown the uart
    port

 drivers/tty/serial/fsl_lpuart.c | 28 ++++++++++++++++++++++++----
 drivers/tty/serial/imx.c        |  3 ++-
 2 files changed, 26 insertions(+), 5 deletions(-)

-- 
2.17.1

