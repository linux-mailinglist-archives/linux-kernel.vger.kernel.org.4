Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355227472D0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjGDNhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjGDNhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:37:45 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803DEE75
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:37:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUrlHEqCe3vrNAicrkPOpqKCJkvtbnhQQzhL/2qOSzMtjcTFYOQG7scKh3Hw51XPG4Qsp8dnwtAqXezcA7J7bM9IfvzP9TPRkKj4JVukW4GgwlmUMvq/9sj6lOKm6C+koPKVRmiGEDUiCGq/tw2F77xPIeXsGkArvqLSdT7odgY254qOtLfxzyy0eKK32+O0gSWL0NAr656BvUwpxBsd+xcSaCFTmL/L09PLQuucHFiJZCl6dw4iAr+EqSqGi2Ykl8Y2soNh53oBY9IpTd8fVQBa/9h3qfwLXB+S1KoCw4oO9kNlsw+S7IDdISuSNVuU1Iw93Uv9Rz7BVAVrFPczUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJPIRECYJn09RPhsMsgoeJPDjegjbkvDGII+htDGeqA=;
 b=UbRIy7ktMazrC7e9Qk+ST75l6hd0Vz2uE1cy6IYPVcNkcdw6TZBp8EOif1m9wV04mZpekK8VYkavEAZlwNxEl5bOJnb1U21EEcCYoy0yHQrktGLg8cfdOqvCIXsjpxQcx5EczHPsbymqvHUzsJv9Bzdk1VlmQNJQxuDzwc3RdrtDwNLjoPERPJi3BGFNCWCG6M8Avqbi8syR1mloNqULDAP1q4H72frVKR6JLrGrwfAn9GglCZ8XDlCqLB1M6dtVO7kRlJ8Uu/uqgaqS8iSRlGx6enDhIDrz1UKV1ch9Gr98C5KMTsE+njgQhKz+5nop2UpTYq5R2kZDcxc5Wf7NTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJPIRECYJn09RPhsMsgoeJPDjegjbkvDGII+htDGeqA=;
 b=VBZwbxDO3YoSde1i8f2s/1LkEgUDcFglBtALkahKzUEOf67f8BzuT09qvlcbwUBPkWsGE3DKLpSVSUQpEE4OK/WEqg4sqlZVsMNOJjnxNhe8DUhZngRwmt4TYSt0TIF2O9i1CJVxTwC/XCwMPfbhNgKk6Q7MzmRCSuHxFr/687SuPBiaTnefkqMNWGFeinFfhZis4M0/b3RrmI5WYzJ+lroME7trjwy8t2lBm7CZkPM6cWFGw1xrayfRDvXhiHs3PJpYATBaPnprX+lxRIgTMqXtudeaDg6GHjJ6GuYBULtoifxWBIobYQMYgnhoJgGQ0rz4pyePwrV+vA+TTL6C3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5708.apcprd06.prod.outlook.com (2603:1096:400:270::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 13:37:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 13:37:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] mailbox: bcm-pdc: Use devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Jul 2023 21:37:23 +0800
Message-Id: <20230704133726.28861-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704133726.28861-1-frank.li@vivo.com>
References: <20230704133726.28861-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::21)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 58486684-175b-46f2-53fb-08db7c93d47b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yq0FVlDTHzRYvUMXLE/0X1JnJeVjGpu4+x9MMw5rmXqoTiaRiDcPQzHgYCEvy6yYiQr7IGiPBhxOah4O3DDsmBmN4qwfHDF1irWzSNBZ0Rv6U1nx7wpgvxE1L1C4bJ95hRsLA0TjTiloiFbQUrFCQ9qAhmCjaPY/YXJbX/72fs9CYcpcPvrC6GlOjjmKfOMtHKxh0NhTJaNm7gpC6exD/I0fYXD5BxKOk2JENt2UtmcmrB7gd9282AUXZSP18YBfV4/N1Gk4xuYGfX68H0ItFhOuUY6VWMZIOT/ZsYFAmnMpb6ZuOIvy+H1vxqPCeFl7R2UDZfAlTOZDz5v5PVphMxf9yICRMJuCI1xepvdKsdsvgx/dhAW+LqQKWU4fuUuCxa0xqELrg7o/+LpJ4c+SE7BCyeEY300Hj286u2A0vOlYsCdPciVwKct54HZ8O8zURZgWpNxBF9MxCADPSQDjFacHyN7lUbSIUEBrgV/CO79wbxUxmKDtt8uYZYyBOquT+YdY9vFTUgufNLaqbSzgqGgrpMR4vkpHueoHQH251GFId0KMYM6YqUds/SIyP8AoIJXWauS51kPPVLh/j2jjSpqIG5AcFkc7a2PeYp8PoCuNv15e8aCrtVe7T66w6qBk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(4326008)(316002)(66946007)(66556008)(86362001)(186003)(6916009)(26005)(6512007)(66476007)(1076003)(6506007)(83380400001)(2616005)(2906002)(6486002)(38100700002)(6666004)(15650500001)(52116002)(38350700002)(5660300002)(478600001)(8676002)(8936002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uy+RoMvBrscefefaOTOqZOf8ywPy+gqWlJdvDHyPb6krHwu2VXP4HUIry3Nw?=
 =?us-ascii?Q?SFIXhUgBWEwSCIGZvwdEg7D1TtrdgGCblcmmvGfqMVy4jM98Jf0XerB7w3Cp?=
 =?us-ascii?Q?tXZvDlO6HJ1GhCHHt6sCUESDmcBNQAyLtIMm6FInsP80YRTH2rqYyPd2Ntia?=
 =?us-ascii?Q?/llkkf1T08TTD/i5XgPuDh6UNoicKu9aI9D4qCDIwfvdlF39c6AuWQ9aP59r?=
 =?us-ascii?Q?Qvn+PqoZSBJX89ZIEno7zwvEpabHB0/yYfUWTqzNEjH26+w06j6j3E0Wo4Je?=
 =?us-ascii?Q?uocfP8sbOP6JLsu35E4jbDR8OIZrz4t2QUgLlVySW1jHN55yFezmG1Z0b8vg?=
 =?us-ascii?Q?vmAfmSM9u+V8OjyES4EBCL9yJ/GEasf2TFaclO2J6L7f0lDP4H+QbFoJ2een?=
 =?us-ascii?Q?i9QaCwEvWUcZFDyo3Oa5LktXj/DWOAbBLNzorUBT5J1ixNz35MdC+QaI0dUA?=
 =?us-ascii?Q?HL5Ly4LpS9Mu7V0wNi9jTaqOB7YrNZYd+H8c4kXW6aSxGOFBZ5GVEtyR2ePb?=
 =?us-ascii?Q?YfDq097zGwh2Y+R015AQCbXrgmK8WBNu5d9wg2/PuLlPGuBIu0bUsZJ03zm6?=
 =?us-ascii?Q?c7X56HfXnYtgIXNYcFNesh8LvEDmAoD9cdESjZQklbEklp/dQtZnqab37aUq?=
 =?us-ascii?Q?xFOnGwVuriK288+MtrC5K8irhoh1TVhrNIwMP66/t6RovQ0L+0Zp+xhkLAKf?=
 =?us-ascii?Q?yPzkkY1klnsLU83wiC1Jd4KF+RpeJTpKjIWinC2IlQ7B6APybLGh+LXArVMY?=
 =?us-ascii?Q?wBOTK2LwlW25Qa26HCD6XbVQMTV1jk1tQviOQ5PiGtZaapsbhinu8H0231Lx?=
 =?us-ascii?Q?e+81YWvpGVvhfptMaDITIraAk54q8p4BHd10DJwkWO10lQfU77MLWgj2mWC5?=
 =?us-ascii?Q?4Vn9Saq1iChtvzYKzoBQTzoFAavPTuZcu+E8Cq2t44UTy9u7/fcajfAiTtrj?=
 =?us-ascii?Q?eNoQeW/rBGc7tkboX7avNntpDDwqddZq1FMTL3uH16dgNSvRcflXF+zu3hgh?=
 =?us-ascii?Q?rxC83+qJ2YK7x7kjMsdTOfjU0x4tXTlA9w91cBIdT4M0V6tNl1eLFn83Gnso?=
 =?us-ascii?Q?hPw+g4ysjFfoY5KrGjZgAcIaiquMvPgsBFSZreTXavdDbpTY15iJfg9dcIpA?=
 =?us-ascii?Q?Q6qZXQhwJTtV8judTtJqGGFLR7Nw9wwYvrGHDKm/TB0jU3URmwMrGYTKAU9i?=
 =?us-ascii?Q?uoRNMW1d0Cydln5JXMoHrqfQZw9vpRu3EZGON8NLm6bgy/ZzsDh65C7ipfWm?=
 =?us-ascii?Q?2qHpdB0HGvx5hnjmp/0pllR7n1vFt6BGMyCF1YJv5PwjQvwj++aX8ZJZjE4z?=
 =?us-ascii?Q?OGmanzF3RM8sEpCxivwEMkWu2AwggaGc6NutnVYMsOB6MNWK7Vn1IuA92cha?=
 =?us-ascii?Q?fNDoGeGYZ/Rvrbkbl3RJ2yEbcgoM7OpdhNKwmDsaPgfD/5ygGPt5IktaJOzK?=
 =?us-ascii?Q?m+8hNqYb12F8MxjfdRRyBqdTGk+uyhl8+RA+miMHmGhpIad3gJX+5btZBL5W?=
 =?us-ascii?Q?tTg7cID7jAfxoT2Xae9hXp+xg6Leb4IO2qLf2DN+b1gv2IoQ6pOU/I+J7nuy?=
 =?us-ascii?Q?ocVwzqZfSTWJiSEDIezHugnJ/tA++k1b3BuS2nCS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58486684-175b-46f2-53fb-08db7c93d47b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 13:37:37.1651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8w0CNUGkX0dyWS5LYWSo5VYzizr0cMO1jjIY5yeLtOF8kco0eqNclCYnLLYxL7146Vha3tLXlJGV2FM/DoHIJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5708
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
---
 drivers/mailbox/bcm-pdc-mailbox.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index 8c95e3ce295f..053532522669 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -1566,19 +1566,13 @@ static int pdc_probe(struct platform_device *pdev)
 	if (err)
 		goto cleanup_ring_pool;
 
-	pdc_regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!pdc_regs) {
-		err = -ENODEV;
-		goto cleanup_ring_pool;
-	}
-	dev_dbg(dev, "PDC register region res.start = %pa, res.end = %pa",
-		&pdc_regs->start, &pdc_regs->end);
-
-	pdcs->pdc_reg_vbase = devm_ioremap_resource(&pdev->dev, pdc_regs);
+	pdcs->pdc_reg_vbase = devm_platform_get_and_ioremap_resource(pdev, 0, &pdc_regs);
 	if (IS_ERR(pdcs->pdc_reg_vbase)) {
 		err = PTR_ERR(pdcs->pdc_reg_vbase);
 		goto cleanup_ring_pool;
 	}
+	dev_dbg(dev, "PDC register region res.start = %pa, res.end = %pa",
+		&pdc_regs->start, &pdc_regs->end);
 
 	/* create rx buffer pool after dt read to know how big buffers are */
 	err = pdc_rx_buf_pool_create(pdcs);
-- 
2.39.0

