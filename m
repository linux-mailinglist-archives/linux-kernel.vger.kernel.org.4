Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B0574A9AB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjGGEGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjGGEGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:06:42 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2103.outbound.protection.outlook.com [40.107.117.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA831FD8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2iK9HNCwYIWZthKbeOZ07NRiL6ZgkntfebdqAQJf9YM76VueRIKQD0OcbPUuEV6m6IC+1Tx2DfUGwqpK6RLC9Y2X9axrw1a9q7NI58xOcG4dOrp4TLpuAubbljCwQ4IOM2OMBjmaeEzJQEpYTMaX07lfFFt7N5W8LFwgCgnPTK4PSOc1wVw44w+m7kSbjkIjHa16wkVa8tdbl3nVoP2C2zSzJTqywXi3MImi3b1Z8HVqCGsEhj1pJgI71DE959Lq44m060o/D99oTaLYjQ5+MSS+5lM4sah6vIVQoSMlWn91sjNG855mw3/McDJg4s4BpffkqfwfDFnQQBDKdXXTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KW9CPVjpjNwBilYdO7l2jc/rsyVj9Yu4udnRwh901K8=;
 b=gDWDltraHIJE+mwMB3votALiII4gVOFxb0HQZrQwJFRMlhoTAZWbuxiNL+/9UTxLkBS+WOqABu53WKWXBJZ5eVOek6xv7EnSp92eAUV6A6+HLoSdZ8FOTFfASY/L0beTxwaHgDygBhAZESMYpGfdHWMTlLu/PjjYn4EeVIg1H3058O54qXf6I9GX7AKsBq0G8qW2QdSy0zemiHMm4zVt8oMhz8gWaEPvXZ+iSu0GAc7gwinkFKg42kiLZ3fNBvnsjNA4yYHt9HL43+g91wb+uH+xAQRe3hhze+d3xNS4835H6dklmFgGW38HrVVQcTibcV/cj4YzRILanwyE0SEYPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KW9CPVjpjNwBilYdO7l2jc/rsyVj9Yu4udnRwh901K8=;
 b=D+cwlUNiiex2VDTZyaSSZz0riX4eWoXoctPouBzwT7P91qH+QlnGfNTXKGSMDs6pY/ocYpyqmXxJfJBWu/MIUj7O6too+pkeSQjbFe9mryu0EEH1W3BL95AioF07bxa93OXXKBFsH0Tb2KfZys/usx55pCSefCnZ1aWMnzkGR7Z8WzSjxMPmJ++F2miKOqi2lefVpeYJmgQlN41v4Xvskk0ndaRg4jH/1R8MTzXIN3CootT7Z33z2b32YyTWkLlUYVM/Nfo/+gjjqZTUwBSzRFERcYOb3ufF/1y8+9fJps/IXDerk9GIZ780d/1IzSOpvwdM7F+xF2qdmLg6jp4F/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5470.apcprd06.prod.outlook.com (2603:1096:400:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 04:06:40 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 04:06:40 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/18] mtd: rawnand: sh_flctl: Use devm_platform_get_and_ioremap_resource()
Date:   Fri,  7 Jul 2023 12:06:08 +0800
Message-Id: <20230707040622.78174-4-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 86bea49a-1b09-40a2-641e-08db7e9f912f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbv/acj9YWepplY9C2KwWfnHUoK3lhU2JPX1rV4etAsDPJXcnUO6uy8q/4tarjPOlKTRvTfIsr5YTlnGnZb1zEO+marsKvYJm6lXPDNORVMB/TMv5rXf6RBjgnn+5ox2ixjTHScsJUfvH7ratWE2zY57ASDLQIwIlf6adl9bLVA9l/4Qk6/vxU0uBy/4HibtwQKtF6410xCtZsTbiP9f9tlQw+NSH+HywUX7x3TOEJeAYxFIEpkQ4YXH3pvN0EArJXkaHsD+uN0P97fw5c+U27xLOez6AvXMaxu/zyYFVQCgibuUJE/cCJ2BuHEbmirKlQ7zRr0xjwZTCt8jLRCNpCxTxTCRgyLd0h5juUB4lX+K3QlGsajdRKOwcNEAormzLr1D2GA0GCuKR681wy9EweBTSnv4jAHPjMYFDFes+c/Eq0oCg0vChjAyVCt1QDhQaAaPCmd9Jqr/kehdvQog020QjpY/+t8Td2s0PLTHFZOZzGQNu6tp5b8RY2scfU06x15Fmv2UKrEWKHXY0lRiYl6nH8e54U1yrjKeOiM4bxMlLG2QcaYFKAhCb2y2DxVJihFvOmgZiBgWQKaAwppOQ+4SrajsSMaKg2s3GQG0m45KPC0UG37v4jC2IJ55xkbv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(478600001)(6486002)(52116002)(6666004)(110136005)(26005)(186003)(6506007)(1076003)(6512007)(2906002)(4744005)(316002)(4326008)(41300700001)(66946007)(66476007)(8936002)(5660300002)(8676002)(66556008)(38350700002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e2gCSOcOk9OFJRJyVWD7mMn1FWp356IN3SLAwZUVW6mN5uvLWYVNmkMSmq4u?=
 =?us-ascii?Q?RGfyQCbo9hnIZ6hESRXvMEpT7JR9J6EMehqnLfJPMJZ3hzoWeeSECCU8ttEC?=
 =?us-ascii?Q?svPPSDdp5Nz8c8DaEhZ0jrOQW6kjjpvr8iWx5COkhp9JFj1b/iOSw7mJAITG?=
 =?us-ascii?Q?s1LBEmdSGcWboF1CG6sTxGUqJlrn7rMQUAI0VE25JMBr6s6EyXbNOhWshTMg?=
 =?us-ascii?Q?H6MWjSBVIIjJbrVgdrrSPhO/451QgltCfU8bhiqX+/+vT35c0xomODgjN2CU?=
 =?us-ascii?Q?n0/XrNOxs2W2H5vZF90KwS8UTYisFOLPLIZ/TOPoDc0/Pyb98EMDDEV9honA?=
 =?us-ascii?Q?A2j9BY/JilWqGCXyfQ5mR8TrxBgIDW7XJCUZ/KpJR8X70ySzoAZhy07IgGCh?=
 =?us-ascii?Q?UQQ8ubRGBXn9e6BKWvncF2Al4mNsupiE34H4E5LB8oSPtrs2NPwPDWjG456d?=
 =?us-ascii?Q?XDVY19XXottU39Ly95oJCjbAMlJzLKZbfYCURb9XSGEk0V846qrQqyO3+6iN?=
 =?us-ascii?Q?YUYf6ubeJRxqbd2jlPUhFnBA8uz+K1rZ69X6wnyMu1MkUYQoVoH4fFZjxZBd?=
 =?us-ascii?Q?vG09G/4sOTjisJl5/jDJ9d0G/QuzqZ2JPX84AiKuCIq5CArNdCw6JyfMPpIC?=
 =?us-ascii?Q?8HJZgAPBcNHOMmdZnuTX0F7lf2XxuNvkmlRdKtk/z1KUoXeGblxDtEPXN5c3?=
 =?us-ascii?Q?9SccRXwnFRKMHvKzb8v0HJ+sWKdRaAqQxEGalsJ09UPHQEcdRzsRbpZpEMTk?=
 =?us-ascii?Q?RAsb2c/m9/hK76Su8yJ/HNhC6OWRs+KClOTf/orhoLn0i3Z5Oy/1ng8ajIfT?=
 =?us-ascii?Q?e0Bm0+HuxBAV9rrQ/3ieoqGW7BpMcnYI3EcPShPVN0wGek00Ouk/UTh7uJKs?=
 =?us-ascii?Q?lZ8Pk5zclxuagVlGGPg8+2gPUZlJdAVfTrnTs7E9DrlDZBdJnxu8DLON3Yor?=
 =?us-ascii?Q?JEKkxJAxRh9JxmO00QMsNF9yUc3VhJlctnhH+rLr6nQlNG3egY5/ymNah/R8?=
 =?us-ascii?Q?vLgehn85x7H75k+S2bQSpnL9lUg/5Hv7+MJu13ZHY9Ki6o2u1EvjN+XIt0Dc?=
 =?us-ascii?Q?6xZ/M1xm09LnGyN+4d8s2hItqi3CBwN+GNUurnR89gMlm0fBpkeVSZypmbK4?=
 =?us-ascii?Q?cK7UiMVRKfGgI8m495QoYg4liEXgCyftQ5KQDBtS3bGutWAD4D+1IORdGKWZ?=
 =?us-ascii?Q?NwKZk+ZNZo2cROZM8PcNOyqsqu9MRw7eSeENrSysvxR6Ugi591Uh58CpkyVm?=
 =?us-ascii?Q?FkdYtER2H5Om7HZKLSQ7FYaz2om6zLuBIr7wNHBd0EEOeoyqFKHHzjKmXGxg?=
 =?us-ascii?Q?l2h9GpzpW5Zl12d3W6qqLlUpA2S6ztZsY9vBwF8AdDXzZL2Mu4jbruYV06sd?=
 =?us-ascii?Q?nBIk4nsdkJUgy/2+xN1K1zkGNuYPLmHzbdN1GA052zVen71Y/uHK1YTgaUVp?=
 =?us-ascii?Q?fG0VXxsh/OCaG7zXGqwwCnd31gfCYbqnqzqWTUwBOJoMVEeAPOsu2nYZPj3E?=
 =?us-ascii?Q?GuMNU3LByOyk5hOe8u8xXR6DEaHc41xPPa9HwEsSOddl80X4r+DqhP9k60Mr?=
 =?us-ascii?Q?48vIVyYYNnm7Nw03t2WOCW5t4++wjnhm2BOcBBw/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bea49a-1b09-40a2-641e-08db7e9f912f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 04:06:40.6125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8xtbfpc+FHtaisDWqWJ9o6K11LWdemr05UP6cc3EtjTWECtwguM05VHAt4/iHhlnoNWysyg6cT/5f5KkZAbPw==
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
 drivers/mtd/nand/raw/sh_flctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index 63bf20c41719..db243b54c953 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -1124,8 +1124,7 @@ static int flctl_probe(struct platform_device *pdev)
 	if (!flctl)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	flctl->reg = devm_ioremap_resource(&pdev->dev, res);
+	flctl->reg = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(flctl->reg))
 		return PTR_ERR(flctl->reg);
 	flctl->fifo = res->start + 0x24; /* FLDTFIFO */
-- 
2.39.0

