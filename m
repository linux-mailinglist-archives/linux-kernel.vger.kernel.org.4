Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DF46F7CF9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjEEGgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjEEGf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:35:59 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4D81569C;
        Thu,  4 May 2023 23:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgrxPbX/TI/jbnULlinIdK40R4t5C5H4vlpSPfn6ig0vThXk8RpdtYEtZhiuBBP3N+fNZCqKR8pW/qY/TXiL8ZKNPxkc55OGQNSEcIcoj4tkfQ4OCJqa7jzyZ7wruc90rwrmgMWk/59asylfzW6tRhwgqPHBxbcSNtkqwR3CHQATarlThH9bZRZclNpqNwLqeLnlmSmRH1Mx/v1gbe77GeCthsl2NqH+06XWUmluUWlMIqMchKC9ycHZM1TGviARgQCOOnMUTvAp8/hCUptpxCwdC4fkt6o3+YOPSlj981sl/rXplyDzHhibU38goawUTb2HXb5PZ4IocGOW79Txow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oT4/cNEYdhzglCURY7KL42hOCaBa1CD0zTuB17CkvcE=;
 b=koH65ej4DUGvHJ4OEaOZ2G7tXzWSHOdExTAuThU8p6cwnAGK1qT7tNBPRSTZ4ki1wAxJEBlzBei4t/n45EQgHyFlnm16tVieLrnyGKCT12dybTCxCBcOcFV8yJ4FyIDdi/q3umTiuirEENPKZjM4Hlpleu6EYkKnHtJJdQX3uv0LAGjT3kdu7JIQ598AfjWYdhvhNwyj/E7pOj2IpQ+GjDLOKmSWaLoTTFG4mmI7XyImvvGKfxSCAjCtalTFGe6FxZ74a7q+3pXkwQrJg+CD/m0A5GPh7ocE9PHa/CHtj6DSBhwj5pVUxgUvqNw6hIkkVb6IFDUnhrMgq4f0V9g10g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oT4/cNEYdhzglCURY7KL42hOCaBa1CD0zTuB17CkvcE=;
 b=OSBDLiM/b6VC9VobvU9G0GKneGuxT4ejbYFDSZCFIJV9bXHcmH3wCfZfJcmldlJneIPqdeQFN8sFbo9hY1IkPyyrbBtpmy30kSAqmTqhYz7q7p4ZBxipl0u7TjYe8F9LVAbEj3TMkZsr1wUe//4TXAs6gSZcLmuv8VHosarY7dg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5098.eurprd04.prod.outlook.com (2603:10a6:10:1c::18)
 by DU2PR04MB9132.eurprd04.prod.outlook.com (2603:10a6:10:2f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.25; Fri, 5 May
 2023 06:35:56 +0000
Received: from DB7PR04MB5098.eurprd04.prod.outlook.com
 ([fe80::6418:d0b1:6971:5da0]) by DB7PR04MB5098.eurprd04.prod.outlook.com
 ([fe80::6418:d0b1:6971:5da0%5]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 06:35:56 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: lpspi: disable lpspi module irq in DMA mode
Date:   Fri,  5 May 2023 14:35:57 +0800
Message-Id: <20230505063557.3962220-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To DB7PR04MB5098.eurprd04.prod.outlook.com (2603:10a6:10:1c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5098:EE_|DU2PR04MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d95bc8f-6500-467b-9907-08db4d32faed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a40XweubFGWSsL2oF/MKXTqX/gMMeYXdn/EYCnzVlPI6mKErqQjVdCJM2P11ywvbh4IkRL7LZ0M33E7sbsXisFyc3Bp76NjMsY3kDv00i4FssSqu4eBz/ZvnUNm/qz3D6A7PVycEyVGwesClyhmQQ43+mqNFpzhdwcIfrVD04eJfMoVOw+XrhLhs5VQGmsLq44+ra3ZNrflbINZI4KA3JByxyHsn5U+Ut7Q+skq9OTG3xw81Is0Uwp4+vzsx493FcnhArHoOC5bUdtHSqognVXyL7sOysbXvkeUWF9oUESzoDbNjZswd4KsvdUwnA+vsNgKx+xjNXpHrNzAN0Y8KhDG1wR/M4OVZgnZSt1+v9aUgKilKFiu0UofgXB+ZK6TGgZxsMAPug8ltt8vaIUDM1fdO0EryeakxNdOxBxtLYuFu46phDycU70n8Yy7AixJWf1rJY7JwvCYK3vAcdgdCmVM/SmKZtI35ZdnJZWP7duWBRK8WrkVyhAyHPbqWWrOB6otVacsExieQYiaq+fDAu+itpbkLdZME4G/UqJnpYXOIhm77/i5XTHbNt8zrTIGzuD7KVSA+OsZP/qUG9DKoNLLzbCMPuiIclS0s5q4GaMPdqsQqQv1BoXBI+G2PlEfO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5098.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(38100700002)(478600001)(38350700002)(8936002)(5660300002)(8676002)(86362001)(1076003)(26005)(6506007)(6916009)(66946007)(6486002)(66556008)(52116002)(6512007)(2906002)(83380400001)(4326008)(41300700001)(186003)(4744005)(66476007)(2616005)(36756003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a9pgBCE/Q6WE+xkqSw1J5/zXAVdEKP6ilgYzdvfO9koy3tdTCifbgVkjdiqq?=
 =?us-ascii?Q?q6f2QM91VrYyByDI9zUPKj+/AvB/8xTBpyvNXAAJUkZdoPz387wveSWcEqZp?=
 =?us-ascii?Q?0sbgOEnaatgLVLp5Sh+X1XfmKTvpwQ1nH080+OaB4HJYjMICSRyVC6JxayLC?=
 =?us-ascii?Q?x1rTEnS2nfMetXkx2ENNhOtK2/NG38tMLw+mvHwvDE/WoHc1XBwLaA4NTsp2?=
 =?us-ascii?Q?v6HBAVKVThAe4y76RIh90/W0oy98uEEWyV0rUGZx89sLWzjRHr/AsrqYji5C?=
 =?us-ascii?Q?L/OR918Q5JrfLF/cWiafE/HeKalsxRFmtrkvQNvu6jyNNmHCfHFYhvsa/0+9?=
 =?us-ascii?Q?SqUy7ot2C0zSQ6mIeve9jYheX5Z/3CSREYBI/G44bo5X/oaVxKG3XyyerOat?=
 =?us-ascii?Q?bv0lUr8KLoueVgiQBsIfXz23oJPQzOoIlWGlL1cq5nXrTlbHc++Pzwi8cqRJ?=
 =?us-ascii?Q?JWQh3KIFLHciSOR1BGHVjsTBOucdWRpO7XiD3IUBF2fywJ02L8YhegYlHBTj?=
 =?us-ascii?Q?raA3gFrVnmsckQMIYCfTdPUzDaje3e6ngOA1p8oU/70Y58WafuIR02+Jq69O?=
 =?us-ascii?Q?gPa5nd618rySd6EPLAzoiI651stkHTx9tZMLt9g1+rZpWei2h+62/29pVvxv?=
 =?us-ascii?Q?xApiw6OwnWGRLr6POHDoyC9ikfOOiieTq5zHHYDuRzJ+Zz5SXeKZsoG2wrP/?=
 =?us-ascii?Q?AvkhlyK98oG8wG2RnlMl8S+lvtdg7OKSwL/egXueyLSzCNy+oJ6z+NgCRsvL?=
 =?us-ascii?Q?3jAZZY1eMiAXq298l2Qh9UAF7Idjbx5p9Jdq9zpMLEZooxsR52Ac9lT8ht49?=
 =?us-ascii?Q?CJIi6AKVjR7Kspg3OqljCaATfU+QcH1olLhzGuR47udWsRXQRuVarij8QzMq?=
 =?us-ascii?Q?SBUaqd1ws4m+/LZWPqGG3bfPzlxBetGGcWm+uzrnlYvJLLE4xHoRVFTEx3CC?=
 =?us-ascii?Q?9fSirnROjGtn3j0/Pgkcyv3TOeNmEdu9kYBuOBAVBSKpuL8SNca8hznlzkCl?=
 =?us-ascii?Q?ljx+PpqyI0G/noGPk6fD3qgBrMqEL6e0xcSX85D72kWz9VG6BI/E4+8Yf0FS?=
 =?us-ascii?Q?kN2I0U3vv6d+uFLbvbxRiGxhKp/H58hO6bbO6RA0mIgo8NAi+puj5MAaxahx?=
 =?us-ascii?Q?CjCbyiPnuI8XaEWzhAIIN07TecG4yq1Wr/yvl7IPUk9VFCutR9XE/nIHzerw?=
 =?us-ascii?Q?RYprYxmG9L6IC/SFQJiTBMYr3gdPrfjPJDudKtbjS3BTOI36BlRqT2JoCFyG?=
 =?us-ascii?Q?QZF6HVoJHtaSGubaYrtzuU/5Ap3UsBBZPnj10JzAfJ9NCQUHRdOTAyjKfLvi?=
 =?us-ascii?Q?n80T9VyoXofan5x5POiTw94+g6YeJt1FWx2fnJxvpKZpoET3R2FlHfm4Vq58?=
 =?us-ascii?Q?zngT5B93DtHa79gvHYkIyL0eICTLp+3fWbSmUYwacCur6AAMgN4YIcOtvPyA?=
 =?us-ascii?Q?kV3zIPrf1/mWJAdhdXnAwt8K/r2s5BPc6UJp8i/2hzOO+hfObgtNfAV1Iu8R?=
 =?us-ascii?Q?8iuTZmNcEoEYQnEqkuge0sm95/gwopJfFo213lyeG4twELlpKRZoBYUIzePg?=
 =?us-ascii?Q?SniIn9fdTlldLi05THYLzejmx3XsZB9aROzSS02a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d95bc8f-6500-467b-9907-08db4d32faed
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5098.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 06:35:56.0684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hanv0/v+vlUg1yk+ov7T7x/A00vssKTJAdt35AnBqwpBNaPNFvnK0KHVWZH9X9ivR2BbKLYVCoKvDOSZk2SBkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9132
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When all bits of IER are set to 0, we still can observe the lpspi irq events
when using DMA mode to transfer data.

So disable irq to avoid the too much irq events.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index f2341ab99556..4b70038ceb6b 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -910,9 +910,14 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	ret = fsl_lpspi_dma_init(&pdev->dev, fsl_lpspi, controller);
 	if (ret == -EPROBE_DEFER)
 		goto out_pm_get;
-
 	if (ret < 0)
 		dev_err(&pdev->dev, "dma setup error %d, use pio\n", ret);
+	else
+		/*
+		 * disable LPSPI module IRQ when enable DMA mode successfully,
+		 * to prevent the unexpected LPSPI module IRQ events.
+		 */
+		disable_irq(irq);
 
 	ret = devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
-- 
2.34.1

