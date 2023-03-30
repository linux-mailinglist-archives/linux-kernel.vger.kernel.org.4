Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1938F6D0BD0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjC3QvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjC3Qur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:50:47 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2092.outbound.protection.outlook.com [40.107.117.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6ABF76B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2V98v1xsp16JasHV9+HSBGKsfz8n2QnNG9Ji3M1PfDYLAufC4U0MU5Jon8RULtHeAjjhjVC7Tox2YBN+jilSSRVvv4gVdcD3qcLImMWT1lOfdgFXM7d6idVT8COM9vKOjaqnPJ0Dm8iJVhW3VwhD3RdpFFUe+yZ5yXdXkj2e8dc0ZFYmRF+jF/3rgpDkitJVxQwjEHoci0Xlw+XJX+/EIJ83l77ZqI0FqWFtbjQYjdKVvd0hbKY9ORGPUs3DM8Ajsjt5EMLMOYzTwXsdZnJPuw7BfIBOfqG6PwtZ6iOTZMvDNDkNEycrG4qq9Nc4Vk1bRuud/4QgCel4m1nt4m55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9jDTYwzuHpy0M7uPUlxv+bYEweovSShVKMF5+6WB5c=;
 b=R91tIAI1tAlUIDgMiEMj1bdSDSqvXOrSialqFyqNioMX2l/ETkplCUPcUcA8uk/qe0W9N3X/SJwWs4ZGG+eIVOnA261eP5BeyvNHQuqV53a3DH/rgYo/Ht1nZAA0G9k1AUAxsLW+2WpWi8Dp9tPxPyubMWp8CSjsawfgFcib/wdx/M5vLnSo+5n9poPVXuADGfGLa9J+A2U0xVtFAxRX0K6cIDro42e74nn0YBqJ5TkGxOLBWIuYTKAi+uruCwuBf+BBR4KyFFtfvyXfP4GDM4EKhjwkuYHSuY9XgXVKI8J0I18mXQr/V4sE1y0gIT7RNsdlOkvUBDeUePS4PHvVVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9jDTYwzuHpy0M7uPUlxv+bYEweovSShVKMF5+6WB5c=;
 b=qFYWvjZC2qw9+DJUmRp7G0EXW+5lFF5bbwHWTZ23nb54XU0hswPEPIrc82ug3hNTIgPFfWfxN59vUWOs/PHeRDrPYkGltH1KTw9CX+0ngbkhFntR+Tzh59hJSjhcoGLjY2tyNvpv26i9eMqnAyWIg8UbfttyYScMWebYpKA83hK344Ikxi8Q5CO+tstIYzaqKRqeoWfSQsALPjiK9UKhF0IzbWXb6Egna0nTRMVwCFwx3faCXEyylvR8uk1rg5e1pVf1SbeJT74KOtg18uQMHlkCzBuIMexujrJ8rEq/zXYQqF1TelvmuzWb0eIQL80HNhLv4gym6XZgKc/PNESyFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SG2PR06MB5335.apcprd06.prod.outlook.com (2603:1096:4:1d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 16:50:00 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 16:50:00 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] f2fs: merge lz4hc_compress_pages() to lz4_compress_pages()
Date:   Fri, 31 Mar 2023 00:49:47 +0800
Message-Id: <20230330164948.29644-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SG2PR06MB5335:EE_
X-MS-Office365-Filtering-Correlation-Id: facdf84c-cc94-4860-1c4e-08db313ecd09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XvnGr8a7TJUl1gz2R2S+zln3mjJFF5GjgzXjNKJmImNnZAvga7kJyRdq7bOwlHGvmj0vN4NpOaJjzPUT1wVRogiGJ+Uvx3999xyclOAiNRYcmKou/sQZhjvfSwah43hpbHGKC0k2+yftmo6uhwyXejsGfwxwwaFbtDiroq7rtkPlg9vsHk0ltDtYEYj50f8GTIQ1FvtXft19rS87fXJn9TJdrSfpKz5r8WIrg8lKR7CNpM0nfZtxmoc/lJoQ8Y7ITeNipy3T/9FCaJj1DuFY4dh/oEzqSyVmM7iQa3FD8p3v7iNSey4wLLLRqiMYRJ/5hhhDNbPQJTRNco7v5Aws4bvoifN9h4YD6LrsuFMFoCz7LUVi5PM/Fnt6njipWm++t8OdhGIdoNrWmtuxpTktWmfBql4mCDkBglKS9qZXvjyaHL8M4cM9WsC9LIBGvEMR7mP4YETdAyxZPkaRa2JFWGTG9tUft3gqT1nlCIxNf5r65tkcC4boco9CkMbdGb/+aSicOuv/SsLyoudXBSW2ETCb9nS5THze9nFgAcO+gXVWkwD3o1jNv5UqYTyYCY01R86s+lBFZKAo0DKNSRGKP8KuZ1tf7mdzn+IhK7vX1P594RGps5esOKkqiDwHy95u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199021)(8676002)(478600001)(86362001)(6666004)(8936002)(66556008)(66946007)(66476007)(4326008)(41300700001)(110136005)(316002)(26005)(38100700002)(38350700002)(1076003)(6506007)(36756003)(2616005)(83380400001)(6512007)(2906002)(5660300002)(6486002)(52116002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1lj/xoS429nSgmS5UNN5u8Tmbw9qR1Uxo02MC2zn+9bCHqsYBuydiAenJz8/?=
 =?us-ascii?Q?boUqIbT+OF0/lp3WISjoHWLBc5lIqC/1aM23B35vikmDPNrSysr4qE1GH3uu?=
 =?us-ascii?Q?sp7GMa6W6Clus+qPgwCVERTWmsXkkOZ4kHgazWhNpY8figSItqQ37GqL9FR6?=
 =?us-ascii?Q?KAkquzQ48v+jFTHhJY7G5R7uyQDI02c6dqyVMC8riGd0fWBK63aKAhH0ua09?=
 =?us-ascii?Q?hPBMBn6XzwfZxu0/O++0JLakY4b0g3T5ZoGs0q5dtXkVq9GRdZv5EOpUZBvt?=
 =?us-ascii?Q?4UijN8f8Z4CyBRzSLiPjcLyjwrnXXWvK7t2YuO9Jvn7pW89Lb787PRZirdwV?=
 =?us-ascii?Q?T37sOgMKVXwaZdC3rFpMyY5BeQtgXju5hRIS7Kznvgo3W+kCq59gI2rF/rSS?=
 =?us-ascii?Q?YlbBCYBpS5H8OPNgzhgqiK9v6OrANpPjGDzS7UANniS4HGOoZ1SwmJTztG1Y?=
 =?us-ascii?Q?pmX5NTBK3OnzRSssv4YIxVd7o7KuFF/FD/eMVdpnZK7uz4csyz4umlY9zYqm?=
 =?us-ascii?Q?DRTxB9hATdzQTIaLPlIQt02zLjlc+ZzGQefbY3CE628jJUwNlvv4zzDbJalA?=
 =?us-ascii?Q?xi6iF1C2xxC85tvSsDTWO3OLaBHArWbFMyYFAiWo8YM5ql+tSLUqKsiWWj5G?=
 =?us-ascii?Q?pcP5wm4upMiVfC3ECZ7FFPJ5huB7kDj6F7hdRclZYq1P+EkrHC6zKn/QZfVN?=
 =?us-ascii?Q?UAlrE5/ALl4b5Afhy8erenyrC1bqYrjv2mapUW0vluXYnKN030h6XYzrpZGD?=
 =?us-ascii?Q?AwM6vTa0NRD+ET8qtklq2QDQt2JJ2oA58HugrLkZRrES/dmWi1bSCzxU7+Yp?=
 =?us-ascii?Q?sAVW5mrFf5D0RvFzNjfAU/Ctd9dGONgi+LluWYDN5UMG+2dhJ8eTWjyNXjfV?=
 =?us-ascii?Q?BDzwgXC0er9vpv6HZMU4J4pPvcKmjtda94WGA3H3F4XJ4Cwfi963v/Gw3Uf4?=
 =?us-ascii?Q?/jhSzPcpF2AeDCGt1P/iKMabUSlOhGoNklankD/JLhS2M/3MdZhBvRmrxqrA?=
 =?us-ascii?Q?y5CNhXNyQSb0RKUFPyFi4H7m+r+sS4DFzBb8F5UGGEH6MoABiRAEZM40PWSX?=
 =?us-ascii?Q?+PwesN7WwMsYqXYAT5AXCLT1+JlTmDaghEfAZ+nQP63RvmMDR6edh1wn8iFq?=
 =?us-ascii?Q?KlIIzCERRUgb/cNlb2VZvzEaTtvudogBTy7Pgu/rk1YxgwKEDI+xJnRE8G6E?=
 =?us-ascii?Q?k2S/PViAFbaWg6z1p+zIsWCvj0Rv2msCOE42IO/c4iT5okVAkD/9eDsVnfZN?=
 =?us-ascii?Q?UUWrN5+STMBuSqJRw2hhdxuuJ7tpvK9WorJJM/zTnh0Cyw0e1WGt6AMnsD6T?=
 =?us-ascii?Q?023mkW28/lyEOWYNihyaNeLRDvEBg/MgyJ50uQeFMtK/GTpduZoXinWXz9PO?=
 =?us-ascii?Q?LjaXKzHvmWSHAv5DM68j7bfPo3ds50kv6VQIYewnIpS6kM+yV4uSBOEJnO8f?=
 =?us-ascii?Q?PFfR9WgDrNlXhtEMmSQXPxMsGc74RL0LoJ59CRP5rqU+Eod25f/rIOeH+Jfu?=
 =?us-ascii?Q?52IlqAOuHvL/HcVx0pszLlplxBZ6ITYA/Yslz2jciV1GZv1/RKBmQcZ1NCwA?=
 =?us-ascii?Q?3HptbkUoxBIaEfmGiN6YmyQrOXQZ2/O1PDdLf7Lv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facdf84c-cc94-4860-1c4e-08db313ecd09
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 16:50:00.1774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1wfjgZgMeuxPBGVi0hIv2bQYmt4XRRt3PkQPJaRtGZgBcx9k+xEjHENNPGXF5gkKZAFvSAcI4WUrGyLk0J1Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5335
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary lz4hc_compress_pages().

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-rebase
 fs/f2fs/compress.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 3182e1506252..f8b15c932c97 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -264,34 +264,18 @@ static void lz4_destroy_compress_ctx(struct compress_ctx *cc)
 	cc->private = NULL;
 }
 
-#ifdef CONFIG_F2FS_FS_LZ4HC
-static int lz4hc_compress_pages(struct compress_ctx *cc)
+static int lz4_compress_pages(struct compress_ctx *cc)
 {
-	unsigned char level = F2FS_I(cc->inode)->i_compress_level;
 	int len;
+#ifdef CONFIG_F2FS_FS_LZ4HC
+	unsigned char level = F2FS_I(cc->inode)->i_compress_level;
 
 	if (level)
 		len = LZ4_compress_HC(cc->rbuf, cc->cbuf->cdata, cc->rlen,
 					cc->clen, level, cc->private);
 	else
-		len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
-						cc->clen, cc->private);
-	if (!len)
-		return -EAGAIN;
-
-	cc->clen = len;
-	return 0;
-}
-#endif
-
-static int lz4_compress_pages(struct compress_ctx *cc)
-{
-	int len;
-
-#ifdef CONFIG_F2FS_FS_LZ4HC
-	return lz4hc_compress_pages(cc);
 #endif
-	len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
+		len = LZ4_compress_default(cc->rbuf, cc->cbuf->cdata, cc->rlen,
 						cc->clen, cc->private);
 	if (!len)
 		return -EAGAIN;
-- 
2.35.1

