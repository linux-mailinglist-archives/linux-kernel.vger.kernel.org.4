Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2CB74AE5D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjGGJ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbjGGJzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:55:47 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2138.outbound.protection.outlook.com [40.107.255.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165BD1BEE;
        Fri,  7 Jul 2023 02:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AP4wlFeaQEgQRMXw+XwPZMtmXy2jF8B0elKC1LOvaapDDfVML3ur6sJZiYSmv13iEORMeU5aer/Ho5PsMlNe3iuCwSMhPyC+31UGS02LKqe+8JlHbz+WdshqagrRe/OsVL77J9KdiQ7JIVazWlenJWQ85/WLn8hlcv+Qa4GCr7hi+OfvfkxZDSDjd5+msI5LZb0TB1lj/X1Z0IQdIaUEV9yEx0hRUW47HQMYkDqMbxAe8OfMELezfDhHvX62mjXy2Gr81sfA+kBGcVMGpXDDuc386QeVJBzlENrDr/L+UfMlQHG9gTOydc35ErQRu/MJqDL8IQSkHN9tDxOnBIrIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4I/mwc09ffvaDEMugdzolQ1SUKOTSVAVCt8sK8ABcJk=;
 b=ICHZYMQseO4lxBmQuwHXwJn2R2XViTapafBzSSu4k9ObP9GOqxXodAdoZKFeNd0+eqIHDld0TP035CuDtLLtNlzerrI0vwAbQx6TszMJvowiMuhs1XD7V0HnVFROQCOe5LEfqVOnBeUnIWCTNHCSerE5sP28Vujhqef2tCELmjpBUfr+fDwKHcw2lZDi3l+GdigAxZCFGZdbT3bJLmNLUWuTRAmQNTvx7VWEL3vsMD2yZ3WhkLu75Q0SMGSQjUWkU47aVkHza4WadaHkgXGu7OCU4aLgDqj0mQMUaOqEL7+RjEMSWtvq1UYO8Mag9vTosWEHAaqJVkObD87xepOSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I/mwc09ffvaDEMugdzolQ1SUKOTSVAVCt8sK8ABcJk=;
 b=ZIX6TFczR24druyIV35b3mEbbfomss3F/OHu3SOmQdW6dLmBJ9Tll7u72+FwmNHaQdQnICDJLna0RD5v1U8d3S8S7fKG8kU7fLFlQSCIItTU3YO44KerHbg/mT0hsDbJ2Rzojm6RZiPxsI3uKo8UX9hwOz1L6U3aE/r4INQ9MjBDxmP9QS4eE4z/q2/m2L2bJJ0X1Gfy5KMw9Yn5UI+EdCgCrZ5qoVXynfeMNinnuUzYVdA4jBKctA1JlPLokKxSGpqqfJWVm6vrhoGuQUQO8jKyHu4BQ6j0px4PaTRrECwbXYZaWwY2eECjPAz26/4HOKNOZJ1iE4UD1AnqGOGF9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4356.apcprd06.prod.outlook.com (2603:1096:820:6d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 09:55:43 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 09:55:43 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/11] ata: pata_ftide010: Use devm_platform_get_and_ioremap_resource()
Date:   Fri,  7 Jul 2023 17:55:12 +0800
Message-Id: <20230707095513.64224-10-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707095513.64224-1-frank.li@vivo.com>
References: <20230707095513.64224-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5b9101-9910-4918-c655-08db7ed05404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyCgdGGFUEdL/7bSwxJ61PnkC4FdB09CaQAscC0MH0b64GFUc7jAQEKuv24pHziRQ25yh0BPKeMIQPG7xNvXLmn1o0DLmJzCW8uk8+RjMtcDV0TdXv38POC/CcQIhWxyX+BEhf6E2ZLIhFgGpH6Po5JEBVak1PcYBvv0ER2Ljuh92nuRLHq1AeG9zrbgqUflBHD711IgIt/bq3MfAAkqci/fenyHpwkxG9hfHHDno0yMZTS4PMjsZYGf+4IrzJxvra8PUYDQ6i8/D2QzHOk7zGXyaXDZE7O7DB1yhWmNgAYzPvRkrsvmZhcs2t5k+xV8ko69p0rGajuwOJiWtLucPdnvr+4SFPzviHSuVqTGi2tl7LDL1RN0V74utydtDB+MPSotGSUhE4rUnZE1FsCq5e8n+YAnJ42cIUExQ4pSZ4WTTogRchxnZask+B4gzwkFf1niUDhjWdSh9pUWCMMAjcvjECVkEVXybZ2kRRaCfFhGQLocM8rpOV4IjSZZIrUezxcc6If/fdv7jxeequHZDEnIsNEpT/+JSo61tZweZt77FI03WvHXoDN44nNvh58jvwrOvXUjtQzhXxx5CMJ0RxwUlrGOt1ZZTWU1ja3+CP4gy9CedQ/F+0qJV/O8UJh0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(38350700002)(38100700002)(2616005)(186003)(6506007)(26005)(4744005)(41300700001)(8936002)(5660300002)(66476007)(6486002)(2906002)(52116002)(36756003)(86362001)(110136005)(316002)(66946007)(1076003)(6666004)(6512007)(478600001)(83380400001)(66556008)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BZnLIyZS3VmgKygfbRcw1nU/MXyQkb6rDU4jp+if0N1KWcRyJ6qA9Bm6Qvmu?=
 =?us-ascii?Q?q1hFIywElzPwr9IObdK+Xo7w6hy15ZZpbbrh8qHjai0V0hc9lnFKzGyEMP4e?=
 =?us-ascii?Q?pnAzkRznWrFFKuuz5zOUJsz13VLAs5psJr8ARlACDlnSJhoQQ1SxMaR52YOE?=
 =?us-ascii?Q?aZHDJyQUjDOn5pEmSnhe+X54hnTkNmjf3dDSbORZ3IdyfPMsSaVtjERqkjOU?=
 =?us-ascii?Q?ml+k/+kg2AFqLPs1EIRAKJcE7uTWZJvLKU6bF+WABA91VsbB04sNOT5gr9qc?=
 =?us-ascii?Q?I6YhuTMSSKqoZE5F2/85IB31F3U2AP/ILMaZzuNj8pTY7eyoRCRx2rC7r2Hw?=
 =?us-ascii?Q?ywB0O38OO/ptT24F1ys57E2M7s/crS1/lsjMdKdKpujeHpuUo0smk6GFSqd8?=
 =?us-ascii?Q?d2ZB6bpzWemlNeP7HMQUH3xbVlF/zo3xu/WA1OIVqBajguTMXocMrSsddD9+?=
 =?us-ascii?Q?B5o4buj4T2Riaid2HGyJjcLVzKvouFZg7SB97AKSiGPXypMzxs5IpAeys5DX?=
 =?us-ascii?Q?JgjwCN3fti9iqwL3cM8oDpZ429FaVLDb7ND8YJJ//q+0u1Vdk7zVFkfBUqx0?=
 =?us-ascii?Q?mWHHfpPqQ/OChGuogaNDtYklGuTkKqwRgrCBi0Ooc8s7TK0NXV+ajDghzIo9?=
 =?us-ascii?Q?pdu7w8uBb1epKN6RKzYDB3VN4WBO0QUxXKdyssrY4Bd4JrM1T3o4YquWtwvy?=
 =?us-ascii?Q?Ebb+ytSTO/fmeLEpdLbVDe4k9Q2d0kBx5Ne9vRITcR2Vi/tXp0hiqV1Hd1gU?=
 =?us-ascii?Q?9KNIxMcdzBsTDsjz/RAhi9WQJCAi61OlAFVab1k8zjDYP7lyRos/vdQ2zbMX?=
 =?us-ascii?Q?UJBrSSuZJlgBQ0wzq4P/9gnI5sKcHmENcDQJnEvDEOl0s6NUSlpRTQVcXDjZ?=
 =?us-ascii?Q?YCa3dLqGMr0ueNNNuuAcXfBy7Y5UgdwCAc4yk3FgpVAbuQALd8hmG1FfoNsD?=
 =?us-ascii?Q?8PhU9lH4NK7OpJDbM0mMkpWDpS2uGd2gTQrUxP/sO2CjRn9g6s1vL+WFEHL3?=
 =?us-ascii?Q?KvIABfAKL24angPnGtJGDrJQ0wVsAW2pfXTXy/omVWNyiROAPh/v59R/p9KV?=
 =?us-ascii?Q?sOSufrruWVtNYP9oJ8g4ZwCMdzL20PU+8Vl/VCNbX22mXGqckysk6+QxVhXc?=
 =?us-ascii?Q?yEitrJPuXAMIwG8BkiSsNwdA0gEXulCec/zluoH50qRYOH+nMecwuv8eInBp?=
 =?us-ascii?Q?+ADMzMkwM+fgvYBxchh0MwcNyyV+TalYt0gGEPSZ89YdlHK2HLzzIVZ/T09u?=
 =?us-ascii?Q?pLrZ4XBPg+VaungSOVcmWgYIIz7eETzpxjAhxZb4LaHns/y4hFjtVZT02Fhz?=
 =?us-ascii?Q?QSw6utKyiqDknM13a/dEPh30OQgpCdHLllkemAp5fCZO4cDJ4UXt1FoaimgJ?=
 =?us-ascii?Q?L5LLtziURHCRj+N3ynC+bkcbFEpHmlhcEuves6Afw3FKyPItZ7hOvLbHD4zi?=
 =?us-ascii?Q?oJUXZmU4oUK5WpId6xwzxhS61oMtLIkdne/6VClZXkW00X6ikHtwqScIOXvd?=
 =?us-ascii?Q?2IXwDJnSANBccI+MgFm9qortES+1aGRrSVGr021DJKGREDFb3uW1teVtfdxj?=
 =?us-ascii?Q?PU2syqY1v+OaL62lqZWPFozCExyzJIYs0sawpK+I?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5b9101-9910-4918-c655-08db7ed05404
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 09:55:43.3138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sh4e3ElvzlHrXSiSejANlvnFptgmeojiLkSh/X/rPAj2D7pByXVAvlvUFSi+ZNWCQqHjakX0dXG1134FRkvhIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4356
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/pata_ftide010.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index 6f6734c09b11..c6f60f1a908f 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -470,11 +470,7 @@ static int pata_ftide010_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	ftide->base = devm_ioremap_resource(dev, res);
+	ftide->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(ftide->base))
 		return PTR_ERR(ftide->base);
 
-- 
2.39.0

