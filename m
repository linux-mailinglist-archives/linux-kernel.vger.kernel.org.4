Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059037047DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjEPIdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjEPIdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:33:03 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D86E1FE9;
        Tue, 16 May 2023 01:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jv2YNweVHEDHsm5FUIgORwy3EuWikFjne+B802BXgo9wLNxiVnR61vORI3u4PB7umi3gEyGKd6r5OTrldqc9zSAIkU2fhcONUlylSsPW22T8wPJwuWIjLhWszEsxj3EcLdF3mvktEA3gC6AaJsPUJy+H7OthiePc3uc3XFk+oqy5VJWiWEYn9L7vSCDHexravwmVQeLCo21dSWhmK3jTRpZpiNVPF9HN+EiexSSD35wuvVdMsi7k70oXpAMK49X6ARTGOE3FD345mqk41DjN3Cs+8zfVIlEZ6r7i86ulouzquWtstYqQJ7pAbFcO8tbTnGLg6WXGk18Vhx9e8q0PTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uEbUWdVOB7cvQ313rvHf/jWacp0flkUcbe6vHJat24=;
 b=SGSn+npLDwk1VJHivfNdGwDb4lFCepHFlsDlFD8/NGbJUak5PZ4l+0VB9JMKUV2Al+GotN9gQOTuRIwcYhj+AObWONGeNwKJgITt+xk0UKtxbTi6h17W/mxzXDsw2qJeOSEhBXvgrZNrrjz0cYkdatZ31aq1EBrcb8N0whZwyEvPp9c/wsXlKXqo1Jo2OZdob7LymYWJFcF9vAuMqyUFOpkHAC+paZ8A4eEKe8CcvsqnHVj1FAjOzpZ9F3HRT/LIBVeGsyiwpOx5JiKoyNkGOheYbXExbcphkUdz+QqGt9malH35VxAlC+X+MQIbZCQNltDmJU97XhF9lGBLJJpIIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uEbUWdVOB7cvQ313rvHf/jWacp0flkUcbe6vHJat24=;
 b=j5BzxH768mOq08iaYO0Rsw0hCFSDODIVc4VCxKHbRDsCecY4k6lFQtNw+R8WDH4yFTylj3AGaEpF5MOTZmeo346eXsEEj6vbfT5Qrz9ITgyGwYyT7ZjpfNOUmGgVLf4WOH3pwUPZH4ZT2WkaYTWIZmUWWAIxZLfspYoAYAi99X4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7002.eurprd04.prod.outlook.com (2603:10a6:10:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 08:32:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 08:32:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     amitk@kernel.org, rui.zhang@intel.com, andrew.smirnov@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, alice.guo@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/3] thermal: qoriq_thermal: support TMU 2.1
Date:   Tue, 16 May 2023 16:37:43 +0800
Message-Id: <20230516083746.63436-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:4:7c::27) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: e1017040-be59-4678-1845-08db55e82504
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OLMCTCG/b1TLDNbBZaYzq95afArpPBEsJG74orClEqo8KOutTvd6VTA62czR5F8eXjl0+3nu8DMpV1Pr6F4H5rsKc9mptLyHO1oY/JLMw6WGUU5O9leG+Z7ImE9wgngnIatArRMJsXnZmK8SO4NqyS5cwluBjt6Si0keomU5Wgb+s4jScqulLVKQr9pLVxJLl8XwaGk65dDg6YT25g52ITe9tUqaFha95m0fhunHLaWQKzQHDd+6bNLlTL86qDjtzRY8TEgAMnD8ptqojYR0+PmBppI2KMXt/GcAsx3AepPTlftYiJ4fAo1LjloRqI9xEvrh+4c1FSlsemZ47jk8AGChQdJ3CR5lGnNnpmvNuE6tn6T+rYEC5Hj6+Wj4BSd65IwUBiSX6n1x1JvcEid7vOuncKdubAd7dbkDHIErfEnHy/x2JRGr0ylowaskBL5BlP0S43nV25s6C8GjNz9iCqxGe0lNpOOdUXo4F7XeHIPrP8mhabwANDRNNXcIZj7GHXXZ7wAof0jWx1fER7Jp1F9jXMg9vGUZBY9oAPEUEA1A2Mp7zvc3xTwJSkq3TqGz3qpUB+Pct8K13LjxV2PBhruWu4BAKquJ0zXkAULFsH7ChZUARH3xyg0Jl3gxYf5U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199021)(86362001)(41300700001)(316002)(38350700002)(5660300002)(38100700002)(7416002)(66476007)(478600001)(2906002)(4744005)(4326008)(8936002)(66556008)(66946007)(8676002)(52116002)(6486002)(6666004)(6512007)(26005)(6506007)(1076003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1iNT51jvMibCyN6kqJIVTuypmngWjfLvN/O73IgrjHWJA7W395ceHL8MIU6p?=
 =?us-ascii?Q?PeJVuB+ykyT4IWkHOkD6xg+eh/+mBHYMZCqQxEn1WpGIfMQCC9gvendy4QvF?=
 =?us-ascii?Q?hVFh6ZCZ8xgdD84ddncRCyYhzZR5qvrD2ei3KLAQCv+VfJT07D1Yx0D46nAy?=
 =?us-ascii?Q?DXghiLZz7Qnhk4LQ2VotNGYXEgIW4WchCKZdavY3gtc1m7btJ+wpyPlbe6Np?=
 =?us-ascii?Q?aHOWPCW2qeIxmWjU3wO/4dqVlkJQNc7N6TUpApNnkFEDyS/ct7XXvgWaZldw?=
 =?us-ascii?Q?SV6p3wFrZLaRO0tL5B4fY2e4RbeLoLQ+2fXnfbxo1Qg9/xtYup/Uk1UY7HEV?=
 =?us-ascii?Q?vNxHN8lHlBvFzbvLICCw8mjHfODhUclghej+nP9dooqgz2C0G6DJQYJIKJad?=
 =?us-ascii?Q?+NKA3S9wMrjNXZAj/59j1cyISpET3/wfKrxuGDqUGTzYvchwWSl2KIfkhxit?=
 =?us-ascii?Q?FsMGm50Nxx/zKsRsg+cWrRUGHnL//CzTiem4MsAwA8iwP+3JVI80Rs71IpIE?=
 =?us-ascii?Q?ntFG2ocBOv6Cv3t8GjM/YBp3LiWdm8SiAZG4becIgIoX/3dfK6KnCbO0TV4g?=
 =?us-ascii?Q?agpHptaVzy+mfZ8JBDXl8ZWGwFKmfyKLnXpqXV4Abg5L+b9SPPA+OAB3thq3?=
 =?us-ascii?Q?EKNyDCGdueEINBrIg1esLittlO3Vb/WSNRUgOumc27WKolX1y17Niur/4p0F?=
 =?us-ascii?Q?UgaAkjrchyTa15JBuz09qT0O4W74NNjXh6dUjWwlhG3MnfjcuXLqcebGknl4?=
 =?us-ascii?Q?p+YAYlla088REU3qBKlFD9e27G/BWonDan8JqVKNRo6N87ABwZWuZwgwSeDP?=
 =?us-ascii?Q?zp9QAh/k6a+20P0MKinFIoSj2HJvs5m0xGZHNtI9LhzpG5+C26fRFkZOgBCg?=
 =?us-ascii?Q?K4ptaxPwZH/1i5swsbQe455Z8bAo/7Y0YILzWxSbX5GAUheYkpYAq6EOabso?=
 =?us-ascii?Q?Sl+Qxy8k+1AlwcwW/jVHGIAWOd963r20yvKrEruCb69PGKkVl4VdYXoFSB1c?=
 =?us-ascii?Q?oAt/48gcw0f7B3P4HnP6NHE48IXgAWJdJEV6EV7KZRzr7dT73wX9b5vz4v81?=
 =?us-ascii?Q?V06BUHpJVMZrlAjNGyMuXwOzUSnvS5xy342EMYM65CFbzY1wbcnNR6m+QV8J?=
 =?us-ascii?Q?b92f2b/ElON1+JA2bvDkGiAyPDoiVHcI3fsDHTwz6h0lWqD/TzG3OplJTDb/?=
 =?us-ascii?Q?avKFIiIL7q62p1JKBLMuUDKDGmp7WEAklUSYP6GxPF0j1Ef8Yp8d6bqROwFg?=
 =?us-ascii?Q?mpBnv0RLc8JKrsfrBRGSja9VB/XQFUwTI6pOiBpKHzRXb2eCpILJqNcOhNuh?=
 =?us-ascii?Q?WB3zNB43X8DKi65r16AiTnD0GuY4ERtS3C160WIp6kUg5jxQmxm6p/yrNcoQ?=
 =?us-ascii?Q?o43l0jbMblt5vGF+B8A360g+h1kqwSp5jpflaouImKO+aU/vlvhFX+SP06Md?=
 =?us-ascii?Q?pMmM8I7a7cVeiBh4KB7jYauuRwblP23WWD0N2HwopucQp56isUhEN5w9y5LR?=
 =?us-ascii?Q?3n42ihXsfMumSP3MEwCa3lFSA13458KHDumtr9nopEtl/96W0aKnjb0zpbR9?=
 =?us-ascii?Q?eZgDK6lR+tXJnnTffW9Q3hUpYvPf/aL5AJ386rMp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1017040-be59-4678-1845-08db55e82504
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 08:32:55.0040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2T7M8Xc470ZDxArINImzk5IYpkjes5vxrCLqvzDFSaEXdAZdp1kTiT8MF+mUkxs6/K2raVVuoxFBJEZl/8kCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7002
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX93 use same TMU IP as Qoriq, but with version 2.1, so update
the driver to support 2.1.

This patch also includes a fix for i.MX8MQ

Pankit Garg (1):
  thermal: qoriq_thermal: No need to program site adjustment register

Peng Fan (2):
  thermal: qoriq_thermal: only enable supported sensors
  thermal: qoriq: support version 2.1

 drivers/thermal/qoriq_thermal.c | 48 ++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 19 deletions(-)

-- 
2.37.1

