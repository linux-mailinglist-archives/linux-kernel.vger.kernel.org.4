Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EA06F7D2B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjEEGm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjEEGm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:42:56 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373D31635B;
        Thu,  4 May 2023 23:42:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmGfNf2TlemwKHUsqa6gwssLugP9fvQnASFuK9LfuDgmNRH7wLUvEXRsKKkGuCTgaETv4WnMf+EXdXV/C3B5fnU68huSUPljJQJ+oz9Cfcx8N/LACMuE422kILDpZFXHv6K2aLqy18lGxicrAccI3XZ9fDJNF5tgQbH+m2xFjb4vHMklmjcEHdnowKvhI3C5j08i6Bi57tMNjQCSfV11fyU2qIc6UO9Itw2hqg9dnY4PFXpnUJbyMsif/sLAimeMY2aY4+b7DcPr6ptjrVCgn19hngFQqBXHqBZ7GXZJDre1FOl9u3fjx8kF6CnUUrG4KOJZnjgSI2lXbZzHfyOEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEPPfI5vyvBbaI1xDPGUlZiFHwtJTDPhKaxgYSJ+NnU=;
 b=Fg35CXXwK2jJsrZQYnV7HhNTKa8TwDQ8HHkyrBoXJQF+2Epg309TDgZ8lnUBB2SlboLrXzrKETevyWqAFRPkwj3MKnWlw0fcxZxpHBMQ1OrhAGDYGB9AzzvPdVgA5JzyCEMZQrj0P1/ZSkr6lQu8NJ1e5KM6m5SRC9iTb8H5SMjoNi+NmCcgQSvgqLg0Ni67+71uPU7czkqUcYLZ1MTQOjXwkYPjWtWe8H1O97ninQAqw75kQxdeB99jrXLH62Oca4aNgGRyccP8bJ4hL048wkWYUtBND4Dabv9TVCdzaD8dAfvc1dWd7Af6nVzEmB0M+a/edeZdhyC+H9DyQQzoGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEPPfI5vyvBbaI1xDPGUlZiFHwtJTDPhKaxgYSJ+NnU=;
 b=ive1WUhlFqYQH42HC40YVvTEy9IFtcLMsaN885BYik7ogVD1AkokfpE35LEvx9CXTYiYwu2WGbLMYg98IiJoVpyw9xtstT0HXcm5hd9kWDeeq3XtkvwICkvm7Z1AR+9cAD+QBSi4ZtXeTl2FOfbWfxVn+mhWHmFFRFn4a1k97ek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5098.eurprd04.prod.outlook.com (2603:10a6:10:1c::18)
 by VE1PR04MB7309.eurprd04.prod.outlook.com (2603:10a6:800:1a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 06:41:55 +0000
Received: from DB7PR04MB5098.eurprd04.prod.outlook.com
 ([fe80::6418:d0b1:6971:5da0]) by DB7PR04MB5098.eurprd04.prod.outlook.com
 ([fe80::6418:d0b1:6971:5da0%5]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 06:41:55 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: lpspi: run transfer speed_hz sanity check
Date:   Fri,  5 May 2023 14:41:59 +0800
Message-Id: <20230505064159.3964473-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To DB7PR04MB5098.eurprd04.prod.outlook.com (2603:10a6:10:1c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5098:EE_|VE1PR04MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d5f23e-9653-438a-6422-08db4d33d112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LnAZ2MPWLCHhA0K6GiNNEGN3VruGSl32M+6/rCTPcy9NKAcWi17xdmYd12mf5lfWa2H+eQDEXWfINXqm5TA4JgjeZsOgtdxuhIDUkDwLvLh7UloqJt/Agc9Iq4wU0xh9zisWryBrFJWBcKYSFkfqGFSESSP2qdI4VFS9JRJJP7tXg/S9PsD4R7WLA8YJJi+bMfr7bS4YymrNaX/Oct8bavF8EOY68PgjTOXkQEV6vujj9C8ohrItC+V/9N1vwYSS0Alv7JD3bhv4ET27+1FI8xzxD66YQVzP5S+L2x6y2/M0go0sQDvz0KSGFdcza9BfbMIUiQMVlePGQEJTCqNxnCglI6YnizEnISaQ8glcIdSAcPYC9HsCWFbIKP62wakuWQjFAqK9yA3COltHQO0ZBrtJaf+0QocMuyn5bTEqWX1vU7iee1XOCgKs/CvGfCq7RE1N3yKl1jZR+8IlgdKdAdbvCtX7cfCgXG2DYJV4Cs3cDToDBB5VJsGNscHg56f3FPNYWRoTKND+0cdf5URsDVh3NdNyG89D28GZc01lx5d7RZxGb6YKuouCAYC7ZGAcQi0PapbqCuCy4w1aXW5bR8YmOMhWXm6MEIoE9w72UAumiEpsRobBIZmqN3lTeUbf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5098.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(186003)(4744005)(2906002)(2616005)(6506007)(6512007)(26005)(1076003)(41300700001)(316002)(66476007)(66556008)(66946007)(52116002)(36756003)(478600001)(6486002)(6916009)(4326008)(38100700002)(38350700002)(5660300002)(86362001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RTOQKrQ63Lqa1NmckLXpntbQl2TKGwGM7C4PRok9BSvQrY1UrpEGSt9rlQUy?=
 =?us-ascii?Q?1XkC90WIxBhs89eCb1wrj0Lbt9X5ZBLWH/e89u4q8HxtPTZN6oKeB5JtV3aM?=
 =?us-ascii?Q?g/yG8YDOYn5mX3zxVHA91HSp9yDPQO28INGByvh+PfN7By9tXJveVEuCHvJR?=
 =?us-ascii?Q?5VAz/aUjKRCyfZdG/9umaAwywZhMyB6YHl3gFg99JjSexHT4eqnpzjxnxDS9?=
 =?us-ascii?Q?j0kDkzc57hXLhN82mDMFSiU8aa4eyrt6upNje7jdTSytrTpZn3hPq4vnPxC1?=
 =?us-ascii?Q?ZSnkSwe70y2rnyl1gWP5e2gvtZB50Y1QzZwJlffaEsTJKKZ/CFPwtaCHkHuB?=
 =?us-ascii?Q?O9vivOWYkVDZydA+uWymFuEgMG+H4rEVCsLIorNb5ANBxzKRV01zWUP/yeVo?=
 =?us-ascii?Q?1pejAhzxBHrGIodDOPWGB/7uEEzFOO/83zYiRahk1ZAD3gO/HkG+OwDzx6nQ?=
 =?us-ascii?Q?Qiv2oe88UnAQ/Q+aaGYWHHyS9BZoXKv/ql4E6h4eFgXA8XOSc6I7LQvPn/jy?=
 =?us-ascii?Q?va4AANChoWTjPTIUzBPUwMcRgt/UbX4KfxVYYAfJ6SPz5WSKab8ETg27oooA?=
 =?us-ascii?Q?nnJ/cu3kfGCq4kowSAOMVJmd4V24hUlG5AyAO7eTLwi4uyPw0Fi1YSKHAUs8?=
 =?us-ascii?Q?HMXPk1jaW7BQ5BcKY9oiFj2CQX3QQtNA8WxR0P/CVFrtg/vfQnsqxv+N11Xq?=
 =?us-ascii?Q?bSb91n3QMqaErLgJUPJC1RSGYkA55ZXHY2WXJEtOQpyKpidy+fWzfrlcsNrn?=
 =?us-ascii?Q?JOlV63JTMF/AJaxwa1RMTHb2OMatJ8AK488IKAmU8iYugUhElOBoMO9akcDF?=
 =?us-ascii?Q?tMYLKR15kGbrh0kYXShSyGvYBSvV4fF8fSS1Rf71DJ/olhRgtgI5So07kaSX?=
 =?us-ascii?Q?NSaApCIaUC/GtJHQ5GkFg91K+kwu9YFGXfiPJVzEKex1CPYEo2aKZMNFDuFN?=
 =?us-ascii?Q?0mvVrArHMfc9D90ekAptYscMzrSvItCQgI/ylnmydk2SNG5skJYN1xMftutQ?=
 =?us-ascii?Q?cLCCU4h3/qio/wp0sJu/OxdpQF4O19KElUeMx02QwNM2VtZbv/5hseur1ZSI?=
 =?us-ascii?Q?hr0GvFCzm0/iBK3wOs6iXGiIMjDzmVVGFYDakEgTOJdBj+igzKALHAAE15QF?=
 =?us-ascii?Q?To9heRghClSYlBIJR16W9P6khZ4Qx3sbSves1aNg+xJ1+bTqRU8XaFXL9xIr?=
 =?us-ascii?Q?RnlHo6hCzZ5VEgItPDvT+O+CHqcsRKlfVPZPegSsqw5UBa/u80m1VoV4mjIF?=
 =?us-ascii?Q?gVOnA53pQo27T+3Qax+yOMlkzp6C0gpk+bLBsRUrL+58gE7vVf06HeWfvuZd?=
 =?us-ascii?Q?U19CkYokJ/cidfz/MGoZUMnYWemdqTtXkFbnGMUsq8r2kpWqaIoS/zwCYdvC?=
 =?us-ascii?Q?wYzXLjXf3VWxV8Poo5VRG3f4JFX9cJbz7MaKfG6AMazwGKF6rsuEvN44KJke?=
 =?us-ascii?Q?RTF7DF0Mwm9eET8C8oWGzgNcnW4O8nnyupn+kRkiLOUUGaIvBGft2JiyexsB?=
 =?us-ascii?Q?iLeweYK616SXZFb4T5Na0eGQAW/94JUDpVQRapZfzG9QGmgSvo7tyflPm/JP?=
 =?us-ascii?Q?vd7aH4R3GMD82trF/7x+TO3hcOXu3RVwSNk5ospi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d5f23e-9653-438a-6422-08db4d33d112
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5098.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 06:41:55.2418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWUugfgeM29P+r+iUIeSfz8k4mbjeWKgg4HitwTC8ytvk25Yg89qEJ3jwVPCqjx0aTrDQxttCe5N/7Gha7H1oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7309
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid config.speed_hz is 0 when it is a divisor.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 4b70038ceb6b..80f7367095ab 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -303,6 +303,12 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 
 	perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
 
+	if (!config.speed_hz) {
+		dev_err(fsl_lpspi->dev,
+			"error: the transmission speed provided is 0!\n");
+		return -EINVAL;
+	}
+
 	if (config.speed_hz > perclk_rate / 2) {
 		dev_err(fsl_lpspi->dev,
 		      "per-clk should be at least two times of transfer speed");
-- 
2.34.1

