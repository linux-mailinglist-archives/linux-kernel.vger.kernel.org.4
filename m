Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AB4734D40
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjFSIL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjFSILv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:11:51 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2043.outbound.protection.outlook.com [40.107.8.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3A8FA;
        Mon, 19 Jun 2023 01:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOmm1IfvSVXmHznQ7RniADKBXO3hdWTN+HN6+vHdHywuPI76WqJe7YC2DfsSMauAMyY3aiuholA7DloJxKRIYH1UQvG37P63zHYu+BhzYouHvgg+lQNiWOr6/fXBKEPN8vmb2sbJQh60fLnq0Vgko91H9t3zyYxzV42SyxTwB14lysum3X8+b7vhAwP29ZYNNnWxR3R9JoefJyBtDaIE8lnNYL/RM6msfyc034iTxvASCjy7yX8hxtJ1JjMocQD8booqOJpHxYYPLS3g/OlM/pXyzKLQjjVV7lUz+R+R3k5S1RqJEjeXnWXfrL2Ysp8+4kw4lMreB7ZM5W/d3pt6Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRF+GeGHzCavRqiDEj7TTPQcXl6j6VcLnUs5+kOGYSk=;
 b=cuSqLc7T5AjOW9+r/7fYx8194gGyOh3CHpKiylZs9YzyvBWLU+OXmEYeKIKkri0Pg7QFopiHmBABvx/vqW+tEByHjSO2yCzZ72SVaEJ8TNjZG0lOfdvpmHp1jYkKEgiQa3IG9W0GBXI0/AAHJD/ovE5GfpmJeKr/EjdN5LaoHuj/q3uPr25xeZjr4aNCDwvmzl7N+fQZ4qRvB9lwH4E/7thh97aWmSvIEz0TIM00YaicOwO50REwvIEgSDCNR2KXyiEaAq0LCC5ogAula23xuC3oM6zNDFqPnT0wFUnA769XIH0STPM1RN0V2iEQx2zTsMqFrKXnihYKwYabpzD+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRF+GeGHzCavRqiDEj7TTPQcXl6j6VcLnUs5+kOGYSk=;
 b=LhtQxZl413upU8UCLNtXq6zxJTgOhu6Zdnk03ms2kk2sTdGdpdph2svoE3eglnN0evQU0K50uRVYZ2mddqp9bgS72g2IBvyNqkXlVKdQiCRuWoruHNe3bwnlITQ2LrGLjIYfEAwsdjrkLyHRUYh420EX7PWCJlTgr0aG2VUqbw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8119.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 08:11:39 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 08:11:35 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: add earlycon for imx8ulp platform
Date:   Mon, 19 Jun 2023 16:06:13 +0800
Message-Id: <20230619080613.16522-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0194.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::22) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|AS8PR04MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 0243c3e5-638c-4d6b-b367-08db709ccc5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3iJv97f41zTKEH3qO5HaVg8lEsz4iCBbbefpzxPXDIMMNrATpLpTsj3LDhZ8TiM+MKAU8ANZX7/wLibilVg+CQ3Ow7JWN5Ah/xFzzYz+JunmwKKYgP4QUbUbq3FOZk2FbfVPQO8Uit2JKg7B1W/blUyW4IB/MsaDSkd0dTbGUJGoL5oCquaCXh2eGCzaFzYwY4ge3RdnT+JpjkQF/sZubHviabz7RIymq1FmCb4iZyFUfLuC/MeD44MpFGY+y8czOl1tRzJ+2h9RzFPjZ3dMXFVZUKUnQP7Vg9KW6czWQ0ZxOYMKO7Q29r4XCe8GW9job9MO42nGl2YLBBx0ecAgU8p6KjNCWKSKRviLDujNUqAotUf5PmmW7kfeTIlN2ZsZq08CEaoVGxnnH6668ZQAl2Z6nRvKgKkys8aJSIJrUVGCSUubOJnmLaaWyv96pKMFhahG+CfI6y0viSio/lcTBFlgtDYOXDaegls3ygdzXji9j3PrlWgACbj+NM+rxe3cPt7KD9Ww/Iy0Uzmzyj6gFmULMmz/NP5yDpI7Ve8WNNZJRbWOjeTsCIpwYPOOvijq8I3xUL9Dwx5tol2152sJ8Saydj/Ntow87RWFyBX7MECLcdsMG9qcGqBpyZ5GR00qmvKEQlmGpXTZWsd0iaeMkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199021)(478600001)(66946007)(66556008)(66476007)(36756003)(8676002)(4326008)(41300700001)(2616005)(38350700002)(38100700002)(44832011)(6486002)(86362001)(52116002)(2906002)(5660300002)(6666004)(316002)(8936002)(6506007)(1076003)(6512007)(26005)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lYmjGbRsaayH7deYWJgYErG0IltPH/SqQS880k5/B8qQSKhyXV9sCLTKveuT?=
 =?us-ascii?Q?lA8O2zyLRE0fmIXaLWmSR7DSJ6VLAoEm8MrOyK+zlMN9NOxqx/y3186fKB4o?=
 =?us-ascii?Q?LVb3KNorP7QeE5NL5FrRMFufcWrhfihAy1Lyg5KQ8Cr8KrZra86MEbtZxOtm?=
 =?us-ascii?Q?65q/AhrrHC3fdY2m6Gb84o3BlUUR2JWuqyDyok8tKsMGQ9kvxGLEr9AOJwzE?=
 =?us-ascii?Q?tMleY13kLtoFBwJ9nPRBCA+y9KX8h7mf2JHMbXhis+2BO9CLQGT2Pn6E/xiQ?=
 =?us-ascii?Q?7QucHy+M5H2pv9clJjFKo2ePrSmu21XQ8eCcB+rklCQ4xRr6PECAuyDIb1la?=
 =?us-ascii?Q?Xv7Vtd95B8/w2UDwar/aabXOG3T/ubgkzteTBZB+qRSQX048bwUC2wK0mv8V?=
 =?us-ascii?Q?SdDkDMf0g0BOiwMrt/KOy6lGHEH3bLGRfCoZ7yhfZzWBtD02af2n+XA2NtJT?=
 =?us-ascii?Q?oqk/2Otar7WyTsCoc5yeVYVGD8xqhQZdThg01F0aceqUsQjl/TuJmVM0MrQm?=
 =?us-ascii?Q?HOrpgJsxOXxvoc21/Gmymh5Gjz1RmRc/7yaItR/LlmtNlu2Xxy+v9uYdkp0v?=
 =?us-ascii?Q?Zp1rssLMaSw7oym0u0T4fMEf7xtjOtKhK5j3ohQt8IlXnrH502yNFa6fSSpR?=
 =?us-ascii?Q?4yO/8CJSEDOkDxUaGh2HWqymDZMboz04+jjs3+9DZOHbLZyG+61rSlQS5w0g?=
 =?us-ascii?Q?gDCd4qRCnV+Pj7sg9yF/v/vWSbWZIXsz1sT3ZoP2XGdPlCvtfoogOFGyNHsF?=
 =?us-ascii?Q?qCudiS4DxM6Rr1cgUQTjciDI2VMJldMKOUzU1PIxwZzGZDdtt7KAKCXIPFWe?=
 =?us-ascii?Q?GpB8NN9u6pDI3t194Xo6SJjN1tP9rbMhVoI09W5PmXa97SH8wicifJPXm0mj?=
 =?us-ascii?Q?aqlc5uhBfi8pGseQ8Dqb6EJYhYJlf2tnbXa3RetRWBxLOIlfCHaBHuvXFhNV?=
 =?us-ascii?Q?x4WD+7eEulkkR+9JpwAtRmerGVtaI65uMg83wo1kGM+Rz24lILU7s9IzkUn2?=
 =?us-ascii?Q?O8mIgvUCu2wprWyldzczvCWuTAzohwMTrwsB3pBXKYj9b0J85mzVSmSeE3ci?=
 =?us-ascii?Q?mlE0EHFPeRh0019mMZpr9iJ0njVWEC7dcREWbFkAH6a7yWxzVApSoAM74nrR?=
 =?us-ascii?Q?RGkh5Wv/nOEm1xz9nHGG/qI0b4CT0oky79XOGG5bzrw2WGGHYGSgsVvZoFlj?=
 =?us-ascii?Q?U6vCRxqZ5k/RHAxLsdxtzPVG4sAqwKcvtVoE3zauXJsJKV0GPiNYHQSOwQyA?=
 =?us-ascii?Q?mfwtNYkZgE+mcKLbPIHbwok7EDxafPT/DDnYeKML4HZpH4/glJm3crGKubdN?=
 =?us-ascii?Q?1iEtrJ2ZfwS/683xQ2frI1zndXcTxkVl6I/ISbjdK1ymG7y/9cOk7e48iUlW?=
 =?us-ascii?Q?P+rs+MnTV8xOs3v5b3Xn1nG1+DDbPt1ons+TuVgcEDzOw/34PjFc695Gsrbw?=
 =?us-ascii?Q?C1j1JpBB3kxthzyjgS5m4XMrbTmBbAeqe3rs3T4ztSJ6HTIs05U9UuPhtQRG?=
 =?us-ascii?Q?XmOJSVtWejw0Oe7E+g3kxdrFOoOv9ZBg+W+RKfskR2z5OZgv/EAvg6aBNTZX?=
 =?us-ascii?Q?5QOewEHX6cyux4yeiwGa/hmhN6Fa3GP/f8qSoo2N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0243c3e5-638c-4d6b-b367-08db709ccc5d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 08:11:35.2107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuLscKH3v1limlLu5LeGfACJuv/bP6FwvlHsHUouHf00dH4UEPACjA24to2oHIDAO3nDHgW0jik+c2S50waMXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8119
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add earlycon support for imx8ulp platform.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 0dfe1d85462d..4d80fae20177 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2724,6 +2724,7 @@ OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart", lpuart_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1021a-lpuart", lpuart32_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1028a-lpuart", ls1028a_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart", lpuart32_imx_early_console_setup);
+OF_EARLYCON_DECLARE(lpuart32, "fsl,imx8ulp-lpuart", lpuart32_imx_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx8qxp-lpuart", lpuart32_imx_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imxrt1050-lpuart", lpuart32_imx_early_console_setup);
 EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
-- 
2.17.1

