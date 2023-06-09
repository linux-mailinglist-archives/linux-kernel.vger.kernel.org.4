Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5FF728FAD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjFIGNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFIGN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:13:28 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2099.outbound.protection.outlook.com [40.107.215.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15AA1FE6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 23:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYhBu3dNKuK+DV5S8m/NgJNQudjWwbnoUNjnD7+P2PdGtjmTMOnGIPdHA9a7Yt+k0BXMmJ0eSkNu7iQwIpp8+1sOmhoiD3y80qdcyB6b7DQ+B//MrwcmlYvKngwARoC1/aTw+UCHNJUK5ChQMtiev9HPAAgHpA6ThmU7RGwM24cBV00SGIzGXEEkdyIDPf9IUx8jWEIof2kW3TVtc9mRBySdq/RdafezpGIJj9qaT4kZ4Kh2iy1OaWu6OL/NdQ/GYJYMHT+1KiDZkUvm0yaeh4ZwikZ98gdEw4Ve1kS6UOcNuqoRV28NgfE9KTXJIyjSM6IzredO7KjjQGjF1zgmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR8eDubNLV0M7Q4En6QQ+vcxWnjEZ6v4+gVrED9ZkoU=;
 b=DaoMKkOV+wTxwAAIJNKb/l6rmWcx4fe1StaaLrwQbsqkdN+GH1Drwjfq394WJuS0w3RjkZZkHr4z8EtcOQRfzF9GxMok/wLrsnlC1uMEywh+I8QHv8AoNyUHYCkd50LDbwGCyRnIFgrgeoD4v4OfpSjCgBFX3VzdtfK1KLaFoSWMALM+iLWPsFVIDZ81oxgo0ymypVGvIUeojPILToJx6JrpKYbSRiV9pzrLkBd+JoYpWAcB2zguOAR5sYxQtpI8AiDmrUOKZsq6gDRyyeXLeR8rEWq+CDrQd8fE/623hN5762RBfo/8pjjgstYfK5UT7j0AxmvlC2NFl7t3Y2W9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR8eDubNLV0M7Q4En6QQ+vcxWnjEZ6v4+gVrED9ZkoU=;
 b=JDuYmljdjAWnJBJRkna65ySZhiI9kdUH3aXXZjl6IV/q+i1HT6wCXTNF2FtlIdplPUewq35col4H2uJHH4JXvJmSoNw2Dw8fRN6CaY66GMQq5TG/qZHG7/A43lXXeo7feiT0NG65eJZOsdsuOVCyhZGNZiWgeXd2IeS5+odF6DNSCXFJgtsVoZv9CailrzJ5u+wLSioMCW28bwGBsnamsFIGdxYrzLacafD7dC22fPAvBHI48FVo4b46B+JIf/+BYd6Un3vwEhoquM2tJ52524G1zJTea+HWwFmRbCmWrVWJCYPQSdRQ0oOTyoKN/MJ3H4MVQwGe/gqLMmw1D+JbrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SEYPR06MB5422.apcprd06.prod.outlook.com (2603:1096:101:8f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Fri, 9 Jun
 2023 06:13:22 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 06:13:22 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-mm@kvack.org (open list:VMALLOC),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] mm/vmalloc: Replace the ternary conditional operator with min()
Date:   Fri,  9 Jun 2023 14:13:09 +0800
Message-Id: <20230609061309.42453-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:404:15::16) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SEYPR06MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: 82cf24be-465e-4fb4-0768-08db68b0a07c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9pD3OpSsnViq1cET734fOa7AHADphxuBXvVGN6P334NYRPcTcblSg96LxIIJAQnaMYEotck5jWOmRERKAC0zx8S73nOV05QHlYNQMcks43DlYNAjKU42g+lsdcM12LXnt7DSkLjm+7mo2sSThmPcd8dN64rSwQP7jQvzsCxKS73l7xPTgeMcDEKAQa1PYSfpey2415JRH70BtTp2GzBAmn7cQialKr1tgIBHzGP2bOkUyOXTPkRj6vpRLKlfoPwN42ZcH8YmypVmK1AwYu8TEI+HsrJUXEddGo73N8QgMsRCfgTpoGPJbpEbfxNEuMn3vESkywWSrR47Z/9JsMQPFC9MNWNWayCTJ2D0DuynC9lUyIYbvX6XJXkCWQVLqTdzS9RWqjGayLrS+gUQ+mD/QwyB5J/qvYgqrf2pmeqTw6t85T8ZmWhl9iPeOLii+5tuxtb3lH9s71L+ysA6ltOGRuBM0VT8of+zod+LjKbZn4YD6D3fKtyORpeFGr/CGl91dA0vvVl32mTKM6vuC6LvgUO+ffaeOUaQPhbK4KBMeh9PHqWZxfmRK6td2iuBVLqPdB7bg8QaX/yDoo+0kaSlZaEV5l0Ogd6ULFip+F7I/yQzSytEM8W7yiNCnPvjXk6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(186003)(478600001)(6506007)(1076003)(6512007)(26005)(83380400001)(2616005)(6666004)(4744005)(107886003)(52116002)(6486002)(8936002)(86362001)(8676002)(41300700001)(38100700002)(38350700002)(316002)(66556008)(66946007)(36756003)(2906002)(110136005)(5660300002)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v9r7ckQ1L7KN3DSHc7dNSaH4y6K0fRJwiMZFgoJVSYP51FQsCSS1f/okyEQL?=
 =?us-ascii?Q?tLkC0A5ZQmCQbwAutVkNnxQTAUjCh0UbERE+vtTMFZGkPChgkpo2/A/F97Tb?=
 =?us-ascii?Q?U4Yl49QLC/Pe5ye3gIDp6818UxVrIdtRjsmT9AM4FrXusFErsd0NoBppwXu8?=
 =?us-ascii?Q?EloG9GI3zLKei0DfS9+5gTP+hSv1bE88V43CfVS6G8+iAakb5KVtjtHwpP/P?=
 =?us-ascii?Q?kVcTaclQgqbvEuDjvGpS6yR4IIBP+rdiDViVwD6jleKHsC9Q1ieFGwr14Ip/?=
 =?us-ascii?Q?HojZY8YfoCx0ElUBRa0PJF/CF4t7GIcE0FxBRaX/ILZCNTfToC2mwdmLqP2L?=
 =?us-ascii?Q?sffSl+WhrgqNBcX7JfoNAVFCeTi0OyzVSWlxndEofvAB07HArBciKV8X2kFi?=
 =?us-ascii?Q?434XQBtcwn0C2gMWqFmS/X1IqRbCXCOFeB+3esfvi/TnESkGA2SQAcv4NnwC?=
 =?us-ascii?Q?OgEkGCc+vzXfy+E7B2/9K98VwEvoYLq2j7WMhreNfGHLZixAbvTBTw719Swr?=
 =?us-ascii?Q?dHU+YJMyKbBUwQbKZlQG7qnKarEbA3Me8/VsDi997L9ahT3diHjm/COWcdb3?=
 =?us-ascii?Q?BKpc3ovHMUjqllw9lQQJkmz16eCoLThYbaW9WOXXz0BOmH/AaeDpRl/gci0w?=
 =?us-ascii?Q?/SXu9hk8TPa6zS3OZJk439YtpzCvKa6jNuz0Gsc51AN4N5P1xlzffm+X5txB?=
 =?us-ascii?Q?/cN2DH4XfBxf0PhDHI+BvGV4k1WKFYnn0Z/NUFkS+Stv0of1ujLSNqr9kPVU?=
 =?us-ascii?Q?cmGCzB1Ii6ihAeWpFKfW6HrNLksNXImG3f44d6EjpYiuHNvy5D64Pcr91MX8?=
 =?us-ascii?Q?DpdTNG1vLZ8RU/5NIHWZvnxvQNe31dp4cGRerxAC8O4jVuPRoULcd7FN+ZKA?=
 =?us-ascii?Q?6WxmOnYijjfhV8ae4rec/JaP4P5nktcfrat/vu0BTV2NGZa0fKixMZn2eQmh?=
 =?us-ascii?Q?Yf8hj5zn4wgvGtBKSOO1vy0Qn3uOrr39DzO+8NJNsARDGw4d5jXAzMCuIBkP?=
 =?us-ascii?Q?MUmU/bEhJd5ZgkjUpz0sSixnrXDCJivArZgRvTIcVvoeFZVqXgrtoWTe27bA?=
 =?us-ascii?Q?f8SHWZe/Uu5CeUBfKjX92aSfOiI4Io3KFAsCBFSwbrQfd456bAnGVtNXVYrA?=
 =?us-ascii?Q?YNn8mavbljp7tIqnyyZhrvM9374h25H7X7+CTMhaLmJvVrrw8z/166qNNYee?=
 =?us-ascii?Q?QuwuvtUkiEmxRS+rAMDogp35DHJYATyTSHR61Y/mM5EqP7wrNaYbTIt7cXs+?=
 =?us-ascii?Q?cQePTwbjfL0xWf5E4gu2But8WqHt/dzpP2ujsxnD27HIZRsmjf+ON7vsCfzM?=
 =?us-ascii?Q?slf2+1y8hS18fOQQgvZcjZtQeCuKegrkZ/PoIoXdcRMETSxTWI0aIypKxjqH?=
 =?us-ascii?Q?fYL+bX5N3GEdho0INwRa1/q0C6bYF+9G2oNM2EFpV5AgWXqhoQ7ht5yFrdhr?=
 =?us-ascii?Q?ATupYD8jRBJLiHUlSgpwLCtYdsQFtpkN7vwVdTZtUfgMDF6t8mbP7eOdvSve?=
 =?us-ascii?Q?F74Qism6jr+7H4j8TAIjYMiXeFhx1dLXemfVd8OQhTZbQLpYuqFIFX7gHeiD?=
 =?us-ascii?Q?lKoRTuEJKn1xV20yTBNweDg1MkzFUpxaUPbUN+qj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cf24be-465e-4fb4-0768-08db68b0a07c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 06:13:22.4181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oyy19Od75rV5wcu30JY0ST0oPXQdVZHT4nM1e/6MLKpxINR0ZzuD29jMUqUEM0R4O/BgwldpkaOuyMRgc3g12Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5422
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be better to replace the traditional ternary conditional
operator with min() in zero_iter

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 29077d61ff81..42df032e6c27
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3571,7 +3571,7 @@ static size_t zero_iter(struct iov_iter *iter, size_t count)
 	while (remains > 0) {
 		size_t num, copied;
 
-		num = remains < PAGE_SIZE ? remains : PAGE_SIZE;
+		num = min(remains, PAGE_SIZE);
 		copied = copy_page_to_iter_nofault(ZERO_PAGE(0), 0, num, iter);
 		remains -= copied;
 
-- 
2.39.0

