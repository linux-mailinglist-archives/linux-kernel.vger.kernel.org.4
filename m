Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C87E623D43
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiKJITX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiKJITV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:19:21 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20068.outbound.protection.outlook.com [40.107.2.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAA01F2C9;
        Thu, 10 Nov 2022 00:19:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgSzxPsLwOkbHzgnwnpoORmWHkprbGkjuA3eXJ7hSI5c8VYB8zY+XqyJtstzTl7hp55ojRMoqFXuVG0qyGgv9lbdN2Lhtp3OBh4seHzEMy7Bq1CJ7YwYpVV1QDwFbwmCmgM4CEKXFHbvrrMawni56JpliZrmRNK9qSpzFO5VJHHSca2ypJ4q5cmURWiXCOIjlibmkWt7Pi88XbL+5KDCg4Z4QcTfTcmoUqDfa7HT9lY1ZnA3WAFYmsqEBBbjtZCJjDrAQK0/B1uxGwMmlOe9uD6EkJiTXI374s3F/KDwA1EHldQXM8Lbrw/i1zXZbvZZ/0d7tke7CV7BZS7xPzbbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpN65ttr+LuYJR352BwpbxLf08fKrTjh3TB7w/nWpsE=;
 b=TMZJ4hXG4A0dTwfJbqI/i7LKTrgTCIhdIuca0ZbHTG3EUaS7et1MTQllzhqKc5YI3Dj+ly/te9C4HQi/+GgGfcfgLHYkKQP49vLmRlJPM1p2VUFfaX4rebWjEGvAZQbCqAYrCO8MXIpuWony5TzBksX3QsvlaplVlQrgH62LMeXAPDfqP0jLrpo49wNSQSfOw93OUCKaVVXgC+3v3MUwa85BEPcocEpQi2YMxwYBF06gUNKzbDJvdzgRaA8CDKgpcsT/FtJ9sRIQnugNsTs46vOHM+cv1gh3srM0Q2QcYbs0eAahqWRdfnpuMq+Ph/PSRyPEYxq2CAzzXhrYCHMgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpN65ttr+LuYJR352BwpbxLf08fKrTjh3TB7w/nWpsE=;
 b=nrsb5YSj99HNZnCOf1fS7Mf6jJNe2W0kT2wFckI9bpPB9H/jYZG4pxHI1t7wIIh21TpSOCGNVHvxvlLbUWj/xFMcYL6HEzRQXLXFE/AVZ3CDOIJdl60pJJrn4lJs2wmdVEGq1zBMILiSDm4++XGnQPnuo24pkPgQj1ulIOxzzVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Thu, 10 Nov
 2022 08:19:17 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 08:19:17 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     michael@walle.cc, jingchang.lu@freescale.com,
        tomonori.sakita@sord.co.jp, atsushi.nemoto@sord.co.jp,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2 0/5] fsl_lpuart: improve Idle Line Interrupt and registers handle in .shutdown()
Date:   Thu, 10 Nov 2022 16:17:23 +0800
Message-Id: <20221110081728.10172-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS8PR04MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: c11ecd86-bb58-435d-86d4-08dac2f44257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mp/tA+0Y5vU/38g8fEjLbRaigqolGAG8WYGHuknzFinW4nyJXKxp08SP7pHAkzmROQZGXBlycFIpSsMPkrxGlMehT2JFJ4M2JYYdGwOZu8Na53QM3b1it7Ml0/JrdWChShkXRBGy7RGD2nCRvWLBUa5wF+wA+yEbh94etAVsHuIsMXsvRP7ivVPH6KFysn9TuQUIG7GhsfTjG6bGoxTGJD+BVngjjJoSNWM2w+TU68y5/g7xV5shHwzuw7WIcWdDi5w1KxmVRhrOiA8hJpzGgb6wO/mHHYfYVH1Zpqn4vezzw8mt6neneiyVqnvaLuqkJATtFkBmAommY3MlEi3WCXRo/ZVdKIZsshnvt7eYb9yQQvhPG3vLfiRURjJgync9Haed4LVumDVrx7S/FmQRME47OfhPJ5t7D5xxQFazydUvuJyvk4U7k5FNhflQ9ffwLgI1JKPUZv2tYU5tV8DZznULjoFImuNO1F4uJGjdGWefHesCvKW3TgKD5CRbRfXUe6npkr+8xj+qis92c+2FkgI/TTHE88CpyhVxVEuEHKt1gxI/AW/mbmjZYUqD+ImJ5c+2uMIHxo625MpwNy3saA156m3eMCy1g1cH7kh8+lBZFvupKSu1ITvXl4MNKOzB+ZuuemrIrV0QnX4YEVzIT0sPW4vICQW55i2uJ/nRp2cK6GvXcc3w9acBLoWykVUe/dfg+nezDOYZusoeWUO0O8US8gEP4GWXg7wabkjIxjqLyTAuRKoa3bV5Hx1tRj/dNGgohUogPpcQhVgnwWFtkPrVp4fol8zku4uTppSuRt4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(6506007)(38100700002)(38350700002)(36756003)(86362001)(26005)(2906002)(478600001)(6666004)(186003)(41300700001)(6512007)(316002)(66476007)(6486002)(44832011)(66556008)(4744005)(83380400001)(66946007)(8936002)(2616005)(1076003)(52116002)(8676002)(5660300002)(4326008)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0sk+KnVb6m+qZWgKnHasmVrRLjb7AUPCE6kr8/Kp5SeLx/CtxlBTrrdwdljY?=
 =?us-ascii?Q?vc0nvCRffE3r7ehcShRct0Rsl88k7Q8x/jIToGAVx/SOzBQNuTwUf/GAmc1M?=
 =?us-ascii?Q?0q87HbBaLCqfjlBMuJ8lHY4pVsUyEGtVihCg9Oe+EjjaKd6U63JzcaUMdsyS?=
 =?us-ascii?Q?9XSbGI9KzAb7wy9SNMy5V3l28m7aQVswkwho/GdeYce+pWXOaxuVIK3fNYzs?=
 =?us-ascii?Q?7NEfK7oxyQHzNoi0ABfBba6QbTXosfksIkXsUE+tA9v5SftF/pZvUmyjFKp7?=
 =?us-ascii?Q?sN+i36sc0k/YXxoB7wRWwd4dnyE/YUw/DRF9dSZu8oA3eUMrjEQ3MFP6V7+E?=
 =?us-ascii?Q?hW24ZiVwabWc6TewjusHVgzwuW3r4g9MfE0kTPVLcshFLClcioiMdFhYg0tr?=
 =?us-ascii?Q?7JbMuH7bkjycIT167nSwGqo1LGxHtKjoeeH0kanSet7D2UaYcKG3eG/TnrgX?=
 =?us-ascii?Q?7d4x2QnD58+yDFzkBS1Yu6tvj8sJ0SVwa3y9+Glhrimrm+XRd3zL6Eo89MIz?=
 =?us-ascii?Q?F1vKxJQVafi3CRKhWzk80fdbf+nVKvId9u1GxkdzLj6NPl6S1a84B/eqgPgz?=
 =?us-ascii?Q?hAJrTk2jHtcJI/LtppRdYwmO0OhOQ8Nrthob8ta3dS57ULhy2589r9jURUxC?=
 =?us-ascii?Q?UwrJls+J5hkeEj7PScgoSGfdRQDhmi3GLYMOv7RmPCK8fKnaUKA8dYwKZ/0R?=
 =?us-ascii?Q?IzU/0koyD+AUZPNEnbmLTSEHc3nnYiK82tcMPTrmz8d2MTaY1KWgc70pwsfB?=
 =?us-ascii?Q?QLOeM3hHuPqJLQhomHGKb3HLixnget6iHiaVX9D2iusnqOjY0SpwzZ0T0//S?=
 =?us-ascii?Q?FkpAccNDNtSLLRkzJbhgQjVbMZP+GapKAm2iCH08wrFeUKmdtcz8bX1Ylm6w?=
 =?us-ascii?Q?NhYH1NsYrxuQFikLgDM3VCi8Ovx+DEg9cFJzB2xzBhUKCFHQtujjKYRGIePS?=
 =?us-ascii?Q?/8xZFY2mTua3ihh2hz8P3fVfwvCwgqxKjalqPc569B76/cqzNEXbkcLrInZV?=
 =?us-ascii?Q?g4itoZNhm9zN+cJqcsoLQvgvOX2hHIfxPMTUdfO31SGvixRFuZDyG5IcyMBM?=
 =?us-ascii?Q?cJZbxLyhtNO+FZdWgu+Uk4yJJst+OumoPEmoTJN6x7QiCicAaJkTyAPm0PG6?=
 =?us-ascii?Q?lK42kf6JKNR1wCGuZi0KVRjd7W88q5I4kSyYukAO2+TbKLvexVGi1tQusVd+?=
 =?us-ascii?Q?6G7hPs2s+wiOOJW7olVqec5MUJcgZYm49IGf25hFlFBW/yf7WsZEEm0DJ11t?=
 =?us-ascii?Q?kXBRq7QurFy+1XJrtGO3q1MVdS2ouXJSc3Vk0NOXyW8ZJUPBm/KajVAeo56C?=
 =?us-ascii?Q?G79mXIoeNw2UaFjvil7y9I6Lx+iTeGjnA+1gd3Rf4oeNe0AQ83F2Cxw4sPwl?=
 =?us-ascii?Q?hlxgf22iJgy29f6h1H47QFc9XEx1Yw6Qa+VOwOgZFDb6vBDKxwSIn0uhUMfW?=
 =?us-ascii?Q?F4qa1Io406Fm+KZQk7jxv32OGAsqstBZLDGccF9x/Ny4FmlKfectoA2I8QOK?=
 =?us-ascii?Q?EyflfqnVDOsXYYR+RWvXXEeziRir4WvVbEV53SyQkKMiNjo41rDDmVwJmmKn?=
 =?us-ascii?Q?+hWDIofvlFkQwqSbxx5KPenfsZz8mfPB5T6g1J7B?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c11ecd86-bb58-435d-86d4-08dac2f44257
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 08:19:17.0780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIggexyFUINxoFGXo8RA13VRAooAzW/lTh7hbcWnBcq8Ib+PVWCh9hvBCkPvN4/ZVeYc42iTJ5mCg4kGf4keZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset improve the Idle Line Interrupt for lpuart driver, also handle
the registers correctly for lpuart32 when closing the uart port.

Patches have been tested on imx8ulp-evk platform.

Sherry Sun (5):
  tty: serial: fsl_lpuart: only enable Idle Line Interrupt for non-dma
    case
  tty: serial: fsl_lpuart: clear UARTCTRL_LOOPS in lpuart32_shutdown()
  tty: serial: fsl_lpuart: clear UARTMODIR register in
    lpuart32_shutdown()
  tty: serial: fsl_lpuart: disable Rx/Tx DMA in lpuart32_shutdown()
  tty: serial: fsl_lpuart: clear LPUART Status Register in
    lpuart32_shutdown()

 drivers/tty/serial/fsl_lpuart.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

-- 
2.17.1

