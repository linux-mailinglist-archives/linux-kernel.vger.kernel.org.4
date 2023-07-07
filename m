Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DDF74A9B8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjGGEJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjGGEI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:08:29 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7CC2103
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSibSDJg+dziZZPkGvp6T+j3GS2M6UWEjLs4FuNzRS/vj77aY6EJnw0GlL8nWOjAl6AuqlEBGZfY+fXRrcCztVRph6dlfTOwfEqtfzFyl07NJ3mqWhu/Pi98EImvvr7KW6FQ+KDuVwVw578yzYA/E5yV/ZOO0bKufVkuV3KPuq722k4Bw4OizXUVkkOtzal2F6XrN7LnFt4DmBxz4cBU7IWV9+dmGRzw6oBivdubBUUuCM6ZdKy7WlNQMawA5m5+c8kqfPQNZ6l5+G8M3trfbPeNrU3bd875Ba9u0F2yShGBjEbyBxbj+PmjgFqa66IBsHGQh6OeOR9jJurjiFQQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3B+SLIcgP87LG6wrX/sVGPC2eK5c8Quj0o2bFw8EGs=;
 b=NVluT0xzuRTtDrAlQSzwHs5l44NlQkD/FzUA5+HAOQMhvpZJynIe4vdp8gorFbCg7i7uPOcCmCsA289A3gTzGvztFXujmKbGE7z/QQCu/EWMtBsr0ItxEM76jVUUQwqWUzRW8IZ2pnndqT6vRMQ1H3b7R5EauYq4g9s4NAprcuPGST8jDY4A6rW8UnpYppYRDw9I9skB3zAbC5l0sk8vMsN3ffq/aO1oFWKaNaEW+SH17zs0JZneyz8VlNhIdVmHmievOZkAWgl0ugUXmWlx8LxAMPhQaawKadm1ZxJ9y6jOJiGX9AhiGEzCiyp+jH3QnrYXxdzTL25Rm+icoP3KMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3B+SLIcgP87LG6wrX/sVGPC2eK5c8Quj0o2bFw8EGs=;
 b=HGU8ZvzTG3shzzsGZX523L8An44+A9RhPNH2jtOOLEYyjQXe/A4W8csSvGzk3wFYorrxfyTQZe5goYKMjtkIwyossCCB95tVw4HqiCkjda2kRNUKdscYyleojjpfHVOM5U/gGoxpAjnbEv6ADZWq44/07xKRf0TkyBTN1aipuphNXc6vFAmRUvoAtT/YCxGxFHlqQbIolYQ9SavSkPcNcJ+INqp9/6qyn8zt34TAk8Zj23JBtccnqkgvt8aG9HhosXVHyPW2imepYs24PKs5dKbUeQg1lUGddvNpkofz3Fes/9ZhgsxEEEakAaGic2krbcH4GVLm6NQMcf7eypljVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4238.apcprd06.prod.outlook.com (2603:1096:400:82::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 04:07:06 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 04:07:06 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 18/18] mtd: physmap-core: Use devm_platform_get_and_ioremap_resource()
Date:   Fri,  7 Jul 2023 12:06:22 +0800
Message-Id: <20230707040622.78174-18-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: d25e9eb9-5f6d-4ffb-7698-08db7e9fa0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OXRx5JdqlnQbr6ZJC54DwVv+4/vk68fhcQ9SCjTESgjZF+Hue/Opp+2tm1BRD7+MEr/1TyIXjeIDI6wId/ec6aXnsJO+11nU/CQ58Gyv674VcCSjkxtoHmkJlRQFK6lfrM9SCiMObUGXzqWpeRYNIjspWQDJwzxa2brFHrp8lucs9zDD0j/netsfxhWzN5HuWM7SmobFzubkHECh7+1ZjR4JY/M+NYHWG/DaSyfHL7c6jm/AMH8gAq5aHiSAnEKcZzdqQneKEaNR3Zvnz2Wo+rK1uek+MZNko4FmS1Zje6F+P+I6mJ475BBJuwZMgtikGbxCfSQbl8Fu1cJwAJdUP1lHyOVPpsZm7QLmh4yOlO5AN4HEgNZUfz42ZMHyrxT8HUm/qfXE0hQHSgU1Y5Un7i3oRgJg1066Zz5Er+/O8rKL+3egj0mUCawz0GaM4snXr8E7nPpnxBpC9X3/pRBfbhSaK0Xc/6Pnla0crqwfvwbT86fPkwk8H1BP4w16z+AeF4l4xrlUkl3MzAVnPJGvKEeo+0/w8hqS34lchxlUkbvVcE9yYpvseAWRk0LP3es49T+leeDRfbSg+/tIH1lxVFDonMAvy4FqzNJNcYoFS0em2by83+JJAqGZfkElzSco
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(66946007)(41300700001)(4744005)(478600001)(6512007)(110136005)(86362001)(316002)(38100700002)(52116002)(38350700002)(6666004)(6486002)(83380400001)(66476007)(36756003)(66556008)(4326008)(2616005)(2906002)(1076003)(5660300002)(6506007)(186003)(8936002)(26005)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zQOawX0GkAFmJS397VSjnJNCeHgTfWqMxrN/ZuO/Jy3cGoMniBkMGzP9ebYN?=
 =?us-ascii?Q?NcVjGMF4rSSZLYPL86yPLsMYht7WyeKqC3JxfkyctUWGNmq35VQIggKjfDjJ?=
 =?us-ascii?Q?htmi0dU8Ls+87cqHoItc7GjvLeMRzKrQB/SPmGlA0cVcoq2gaEUNuROm+N+8?=
 =?us-ascii?Q?TaKh9leGBWfSU1ElPj87Fk5afoeMUrj64iws32nZsqOKK7W5XGIs2ZOl9Qnv?=
 =?us-ascii?Q?40D287pPixfKv9S6iXae4bzh7Rkrp72gMnGt3SmpsFoYAkbW7DI1ApOf7qKG?=
 =?us-ascii?Q?CsTAiBPo+I/X4L5jKYoQIVcPE/mglopZ5IrCn7ktDeCRZ6kJ7t8SQpBwEqG8?=
 =?us-ascii?Q?hyu8Tq4QnoE0B1wiM/Lawe2pc24cbpT2rlKOUIYDS/RUDy/sPK/ospOCVSZI?=
 =?us-ascii?Q?jWMAyQlfTob6gHiDPHmhjeorHS1D16K3pcXQ9gIlHYw9vPQM0I7+aPbY9M6Y?=
 =?us-ascii?Q?sRcx4ppoFN/NY3S5zM15BZhQiUEYHvfiypweAbOfakHrqPpqPW8opCzK2BmY?=
 =?us-ascii?Q?SV+UkoNEK6CBTnqExIe2D5UMjoVpIuROgcgWC3Vxm9Ny75qU+9vqYewffWxI?=
 =?us-ascii?Q?AZgVHPmG4cr2s0V7BZ7gqGx8kgQXW9ubERGeR72hbsXEWARuQYK5A74muv6K?=
 =?us-ascii?Q?vJ1B78Bm3HCXGzgfKwWC6Z1rDeoiNreq8/VgU3HBK9VAPuOUSbgbByu67gIk?=
 =?us-ascii?Q?E/JFJlfDU5ttitd/1PECZfLrVv8143qij02h/z8bcgzv4P+bw9PANpK+GsUJ?=
 =?us-ascii?Q?EpEcv2ktl+5y09UWV3/bAwysCwSXHfX5YCsT6rCGmzStCaUfV8979EzGES3S?=
 =?us-ascii?Q?2CzNo66iTD/8b7y7VVes2RHk7eEs7vKUDBH5Myr99raBgkz60l1yEi1//Uoo?=
 =?us-ascii?Q?NIWFiWM7bbXdPn/X27o1sNWoXHX91riqrVgYT0PMGsuriORtv3QitSUD5gn9?=
 =?us-ascii?Q?oLNdaB7AjX8cLt/IpPU6QYO87R2wkQfDyaBIndxN0JwywKv8nmOXGcD5dXZ+?=
 =?us-ascii?Q?1EToz/Rm3xh4lvPDA4TcZMI47e4nJH/XW6yw0l1yt+skyeKdiitg3VqrnZz3?=
 =?us-ascii?Q?nQPeRHcxemVNz5YdRv5tANqr2ZrNIXXMTK9Z5GJsFnyXl/Kmxizhnad2k9vc?=
 =?us-ascii?Q?2rMY3f0MUL+uu9UC8syVo+F8s935mC8sxTaQr0le9Gj1adzm/I9GDIKuN9Pe?=
 =?us-ascii?Q?TVk/ev4BZ3oAzdHFgcthUN7+qVsA1FKd1JqUs12V0oQLwqe2yiZ1vTkjQs3M?=
 =?us-ascii?Q?MrH+YimT0WmYbMHewWdo9agvA+Cyl43XiFUWTfGm+3yrQW/hf3YkUKgHq/S7?=
 =?us-ascii?Q?Jp5aXxw1WvqANmUFx71E9wKgFtEtVAVr4CnUF++1oiYpiIqUVpnL9ciOxL85?=
 =?us-ascii?Q?rXhIFs9ISC5BcOpbRU+qCyCb9k/ktM9+Aca9ch4WJZfaS+HNWiIiAFor8A3g?=
 =?us-ascii?Q?WkkFpyzELphzvPgZRA96cduIvk3MFkmP7C1Nmh0e2T1BeMefNlHDCg4C4k5A?=
 =?us-ascii?Q?6UmYX29sj2cImdjFU63us4UxvjQyEbDXkjyJpN4J6bCqfT5NI2+20LjnKQs5?=
 =?us-ascii?Q?kExtK8qHAOUt4XJfD1Z7LHwVzdj5hGRWhWnu8Nma?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25e9eb9-5f6d-4ffb-7698-08db7e9fa0b7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 04:07:06.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqfchJHMVLlrKd5XY1c0luc2rBFZ9svev9OJ21LegYPsyROW8uMCSJmlId8YTZCBGhGFEUP3/FIJwklBK4BRmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4238
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
 drivers/mtd/maps/physmap-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-core.c
index c73854da5136..78710fbc8e7f 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -508,8 +508,7 @@ static int physmap_flash_probe(struct platform_device *dev)
 	for (i = 0; i < info->nmaps; i++) {
 		struct resource *res;
 
-		res = platform_get_resource(dev, IORESOURCE_MEM, i);
-		info->maps[i].virt = devm_ioremap_resource(&dev->dev, res);
+		info->maps[i].virt = devm_platform_get_and_ioremap_resource(dev, i, &res);
 		if (IS_ERR(info->maps[i].virt)) {
 			err = PTR_ERR(info->maps[i].virt);
 			goto err_out;
-- 
2.39.0

