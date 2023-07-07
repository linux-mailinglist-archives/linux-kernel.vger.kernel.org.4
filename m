Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6C974A9B9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjGGEJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjGGEIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:08:34 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2139.outbound.protection.outlook.com [40.107.117.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9002102
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDzQs4QYLasDVr/Zl+mC/X7NH6tcFr8i5IVbZaVUSNzEiOW8akfsVGgFJPETSgVCqSo3oyDHb893QlqRF7G5GchlwQaQZ8ruCA8phwvxdwSdtgkO81OHBk32UG2a3jN0q8pWwskcRutaXoSUQNohYkIIQYWQTk1TwBmGjMBGo8YCmGzsNg0DdV+tL8tNYSdaEP5mdaAn4tquBogU/Wlu7uef/hdFOVBrnuE1Kk/4RfHI7RJLe9n1NrYM5oc98jMkHnzo2vI9h6hW75DDOiCUFNvUppoIqY2a2z8qKjkLibO2rfH3NqLNRfCDv7xcUxiOG3I/XSv8gJIwZFxLtPstDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ex5qMBJhPDKU9mlUo7og/N+zrqM9JiXGgE1OAbeDZoA=;
 b=mben+RHxb8ZT/Pqm5TcHyktexfQxPCJuikP7imhX4MTuG34s8f48bgyhlPOwtlUpSNkOTxJr53NRFeg1mzSacUSLSCVLqKsylqYzjVa1iSkZeAa3uFrQ47Ql8a2ELOp78pNoxprqSoU1bXSw2205PrVhEf3u2eT554XM53LWS3nsBURN0It0X+MUGrfRmk97BOI2JC+4rNDalWbnQfZRapv74G3uOlzBmpDB0w1J6HtLWjokNwfCXXMdMlh1IUkYyydUIPI9TLwTau+WzUWr4M1nq7UimCpjUMrKQqiXPdjaxBY127D5AyqlpIr3luCnV4imxF59FWfp+RbRxs6gBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ex5qMBJhPDKU9mlUo7og/N+zrqM9JiXGgE1OAbeDZoA=;
 b=H18dDafHqbdoF46OJKCfLax+kLF9WVtXJsKH+f5lDClfj2T5tTlvfzTnSwkvrMrcubzHh/58kySxaNx6SEzaEMRqQTH079WP0HhnsHOi49kJWTFYB449nue0OCivxg/FG4JBGqhNoha+r0LqaJsITG4pAwfH+YnYK43iEWJoosAsoANeVJbxdwzpKq7fxS/J6sj7pUvtzaUNMrQvIrsCaLOigHYqK3ugwKOneBcUdf+9LXQx3hmy+ZSEXFHQYjkyDtab5Kv/BAHrQIIrjhj0iUzcR1NTVK5chPPX/FuDWWpkpOwfO8y344xV963EC0um2XfLWKpo7MI8LdLHN6K0NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5470.apcprd06.prod.outlook.com (2603:1096:400:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 04:06:58 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 04:06:58 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/18] mtd: plat-ram: Use devm_platform_get_and_ioremap_resource()
Date:   Fri,  7 Jul 2023 12:06:17 +0800
Message-Id: <20230707040622.78174-13-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707040622.78174-1-frank.li@vivo.com>
References: <20230707040622.78174-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5470:EE_
X-MS-Office365-Filtering-Correlation-Id: f8206cb7-daa0-45e1-5395-08db7e9f9ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wt2ED02qokqI/sqBEGN6Y+cTurMk12sSkjMbJIkZATZE4HLPevkVO1Ys9h9HdDejm6PwnsO1XjrZp73tnMacdEUnD4FbXO/mflqTL2Y4YWYsRKL1yARX82ok61WOQrvr8mrKAG4XZu/Ax8dq+xuWAhYbkgLDFNoKeHxkxald62ztR2RL4H1pD36RkqTKfcIIZz0OO5vloSxRSvLFSdimJDqopZcprJHIX+9NSf7LLFDgooMcnjDIRdF9fZYC0M3KI+ekuyOJeIILsP3HRAd70jd25vq6Hb9Z1IBZuWgemRONsfQyvH/YasUWaVoRm29GLP6CSR8bBhPQ7h//56x0Nqt0Z9lt+42AlfRNYs3dvp3BN6QUT/ceTZaKE7nC02ErfdlQ1dyNGBUnbi2oCgyou6G1jswrogf8/fqGnhdZDI9iKPWvMvYADXQ42okBv6IGGIUQofbQXW6I5fmjRMOAhXYvCAJBzPWi0HMGTAVAKpHAJQMfg7Ymt3tSvZmZa7MacNXZUIS28SWQhPsiA0NdBo8XJLYZz7ACiyLEjYlAskC4XlrS9D/VUYkOacdk6lF0BXI2Iuwm+4g3UcZL2NkQOB5jcx/1+D0M5usvVAUGYnqSay6qehGfSbG83qHYqMyX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(478600001)(6486002)(52116002)(6666004)(110136005)(26005)(186003)(6506007)(1076003)(6512007)(2906002)(4744005)(316002)(4326008)(41300700001)(66946007)(66476007)(8936002)(5660300002)(8676002)(66556008)(38350700002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ne1rxtTyhEDY0hyeLctEhOvcD0DyjNxbwTLmMq9dpcnZOSnlHw+GNDoJ6N0H?=
 =?us-ascii?Q?v0WQ7VNW/IURgQ8q/gV7VTyFJk/RwBo5cwwg1wSG9t7u5xnZfibBiLLDh7dQ?=
 =?us-ascii?Q?+wfE+TcNjJ0MrKc/c9gQc59KHGUL7PMPdSbJxHuV6XcRV71MQEBueqi+/Ca/?=
 =?us-ascii?Q?BL3/GvQdLGu1gyGfnxmpZPqpmCPwYgDeWP8y5I8lijpEaTbkyNfWENBba+aC?=
 =?us-ascii?Q?RwBwjuzENKfYT40tkYxg+NmpgOW7CCWmuKvYIvXjkMcPvbQexya9QfZ5KL2O?=
 =?us-ascii?Q?BGXgHOqTtU0E/kxA7wx69D1LTXa/sSg9aib3b/HIkg5eyIu7vWRnHpVHn5jx?=
 =?us-ascii?Q?vejgKg61J59+/PyqDNy2ykAB3momC4T9R72ZE18uLrmbwSJPqG0cT5opSx7W?=
 =?us-ascii?Q?TF2notQEsNs7aVYU/dHDeh1JBTm3gDgPy+QCDKeLJ9Y0Kgo61/rLfaYBtl1I?=
 =?us-ascii?Q?nQ7ntWyWIJbgqSPylgKRCqkQEiM5cgjG1zJ85Om8dv/sSyGJSlGqApXhawpk?=
 =?us-ascii?Q?WsZ6ZLRQJlLWU7UDe+Z4w33SMnU6q5D9Z2ogv988IYDGbWG2RTfeAx68tCyq?=
 =?us-ascii?Q?gGM38KwsnZgmkzIHLZKGmlBjGQqnIY4Q5McQzEkJhMnsze9ZKIj/qX5qE6LP?=
 =?us-ascii?Q?GjkcUIrZOArB3A6BCgsIWKS1gUx0OvFpt1K9VNu+E2lVqizsqzArSpFAccES?=
 =?us-ascii?Q?CLBCig9YAz5rncoF2WM20VyOjnnpTxJ5C7ECXkUpglYSkxG5c/J3iuPjS29C?=
 =?us-ascii?Q?ODrOde97vYjhKmQ8xsHqrB+HKOXUw8plRjC8AjaEq3lYK0qxPRaQbmHQi07W?=
 =?us-ascii?Q?QqPXjTZht1ADP7zIYtHvy18blmKOqwvJhd/TJeXfuiKbhV2XXk4dlvERrW42?=
 =?us-ascii?Q?54wMd4MZQ2Xx4u9Llo5IEDtISRg++ITkPQ102vV8bv+42sCVjAcPPHOFNjlm?=
 =?us-ascii?Q?6CSy6SiRFYfUigMcAW7Apym5Prg+Xp6amyDXj4Vst2feohOZG7rlQyDQpK4r?=
 =?us-ascii?Q?qMQBx4paxdO997+LrDIAfc2sFd8T2QC1Cf2WHbQC81Ygsh9AHZlFbCIjceKM?=
 =?us-ascii?Q?ikcd1XYF3BAxnc/aureGcSNcpLO8L4/DfOqW9XLqIbIDbmYn/iFuWYLk/uau?=
 =?us-ascii?Q?eP3jEONDC2HqdN3NTZ+xfxNQKTtslaz5gYrcFsVtMkKIAb08MkSS8igx+lb/?=
 =?us-ascii?Q?tfjcQ4JjI9QSR9Z5rwt5XxdCzhG/UB+/z41tWE7DvofmTdsyNVJhH9tUqe4j?=
 =?us-ascii?Q?WL1rovOSPkJNTIk0xi3iMup1rqvm+lF5F24HGByEGWYWINzaUOvYJE+VFRAQ?=
 =?us-ascii?Q?PNjsE21Eg73mfVDFtyzGM14APoZzByPvfzFzT2I6H1sAzIiTxkalUYv+mYWw?=
 =?us-ascii?Q?dC610/qyb1+hNN6vMoULfeq3SouHMJqfCvT+XEDEfudlm1+3EIX79ZaPbBdN?=
 =?us-ascii?Q?IRGL2KxF9wc80Eb9C3RXVVlrM219+3cNql3P+7OJwUGTOAkR8AsXiU6p3yPE?=
 =?us-ascii?Q?C/GEn0tfE9swbCTWezpvy0Fj51PiIalqrp96WyJJGH0cxnt7rI81tfOae8Oh?=
 =?us-ascii?Q?XFh6Gq35aM1T0lj/e3rI9H3ItBlxxVV+zP0awW3L?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8206cb7-daa0-45e1-5395-08db7e9f9ba4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 04:06:58.1429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFfK7dlfKS3IDXcKZmCb3kImpBqnfwZiU96xQqiA63jkTkSv16yokhY14iDPcjs2XiwImSFm5Nfg6xOwMrfRng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5470
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mtd/maps/plat-ram.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/maps/plat-ram.c b/drivers/mtd/maps/plat-ram.c
index cedd8ef9a6bf..4c921dce7396 100644
--- a/drivers/mtd/maps/plat-ram.c
+++ b/drivers/mtd/maps/plat-ram.c
@@ -123,8 +123,7 @@ static int platram_probe(struct platform_device *pdev)
 	info->pdata = pdata;
 
 	/* get the resource for the memory mapping */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	info->map.virt = devm_ioremap_resource(&pdev->dev, res);
+	info->map.virt = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(info->map.virt)) {
 		err = PTR_ERR(info->map.virt);
 		goto exit_free;
-- 
2.39.0

