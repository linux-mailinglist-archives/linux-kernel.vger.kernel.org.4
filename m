Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F2C74FF2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjGLG3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjGLG3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:29:19 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2092.outbound.protection.outlook.com [40.107.255.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731BE1726;
        Tue, 11 Jul 2023 23:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q60NwVy/Rk/v1QZtq8EZngqwoT5HW2uGa72qcS2yCohxBHUrzF8ocr/G1stIKFeNmtSiqRBXHf3uKRqfRrSUUPEbSu6khVg+uCT1l/GezzTYeWhjQtKlTpfSNXjo9ag+6lfwYqzuj9Yq9srOx13mx1Vu6g4B6/GR9bjmkBtlTERM/8CuNQUkFQYESz4iMbJoAMdUt08ogmtY2O7m46snT1OuurEEzWVkbTTamSJimNDzuodeJSahqyiuM1xHRJC71TOFXgM9pAZPZZbF2hXaT8Xpi/lcxqNXJrvI7by+2qZaDS0Vncu/AISJ+IWdOfJQtXZWWxdoU4GkfFN2OGlnfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fyh5uj2vBRLS52U0JOgxcBp8oPBtrt3xYRqE6xOu/yg=;
 b=Ccf5cE8x6zMCpK9eI+c6DVGXuw9WmaeIfvIGUVRsn4sXxBPjPRVkT4l/AlRJZOpjlxxIk2w0TqzzTmQCE4BB/2KbuBQbn8OfLVXVJVniaXjHeAxOpZW9vwYOMbr9+U0pCx6fKXM6P6uDOs2j55ZrP2CR4SEt5rxfwJ9e43ockMC6Hn/KMoohu7rkpGptIfsrDYOcOGzMZ4cjZYSMz4X1xa/hDKEXPSKRdeYRkiQRF66kDyrd3IFfpg0096Je3sEEdwT/SZzC7Qs2XZ+4xxluI0i3b/mPLMh75C/Gq3sOKSQe6EMZF0YwU16AHZ8IQqQLEIrR29Ftz3NaxUKAZj4U3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fyh5uj2vBRLS52U0JOgxcBp8oPBtrt3xYRqE6xOu/yg=;
 b=QJltsnXk4nb5okzITRk+L20A+Q1Qs9/fzGOzQAXVNs/O37EIr6u1w0GNxOF+fTQO0/ef2ETQnK2YPyyzkzVrony9UOlC0sOFzdrfY3V7Zi1TDxiZCOYN5RrDK8o/lfJV2XfxhH/FQVGePpd1Pn+CVhFmkfdfzSvbA7hwfYgT05Lp+PRGskw/7mZfKLttvZ+pHDUXmoVRZmO5ygM5iU2nrMv2ExPAurFQ4b/iMAVHGPiP98IAlJWpVuxN9AL31+JJkCSFrlB0xTfXTK7GY+KIya5P6FuD3SZjdBAXqZqrLlD/Km7GEVLWN9LhmUJAnLutnrF6Iqv/LCH/sU9zDQJ2Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6672.apcprd06.prod.outlook.com (2603:1096:820:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 06:29:09 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:29:09 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] serial: bcm63xx-uart: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 12 Jul 2023 14:28:40 +0800
Message-Id: <20230712062853.11007-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712062853.11007-1-frank.li@vivo.com>
References: <20230712062853.11007-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: f3defd87-a8db-4eee-c713-08db82a14c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Dg+renFN7iphcoahCzDSz7OTK3dOAqtKD3ZR79ZdP1eXW6NVSvARELYaWD00IgdA2O2n9ea1AE41iB/UYvXM4gZkIgTqMsDaDhAyNIPazRIamK42oPVvZ1CCPXTSB9WnUXdPDqatTMAZ/uxvHeD1yaKfJqfNb8oz1uUqduyJdt8Gi7ciVHQSDmUoWdyZMus1yl6MGRMbrMXY402IOUR/qyMYkaRWihwpYoa20Ez2cYpk+/1iIGLjDeI0/JDEUdOwNXinQy7M99NsxTS5Wfb/3jgtCKC0P1r6Y2OTrUAk/9BHwe3slnJP+NJkRhyyZB6KU+0uO4tlA4cv5dpno1Yh2H3BeN5yCCupq50m/Xy4OqcyQK7WOeJBjW/Zqz0tundaEnfm2AOAzYALO3bVw+GvAh5HHqvItVkeJtu6K+rsqKRLjOgreIGZqUab7zO9s0xNiTjfl39x+Lh8mk8AuH+a8Gl27ULAlwKC+rFB297Bq2LjAT1UNDDRDlv+vp9tiyOnNBhJjWnp39BE8J76+M0i4OGA8AaOro1XJFqE0HAOMhtYRFaZZVwVrgRbG3E3mOeiApZB/mCVf/NfzREsl2L1QTg8GcgHG5NVz9vJtd4WeN1Ilqm91yyhHj+HTocHonH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(86362001)(38350700002)(38100700002)(4326008)(316002)(110136005)(478600001)(41300700001)(66556008)(66476007)(66946007)(5660300002)(6506007)(8936002)(8676002)(2906002)(6486002)(6512007)(6666004)(52116002)(26005)(186003)(1076003)(83380400001)(36756003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xX0D4F0ntWF8im8g79/4L9uMTaZWSuoaSGEpak2lHJT4zPxgZMBEN+zKT6ir?=
 =?us-ascii?Q?vsFb6UiWMbTtxLQiBuBAi4eyStlo+Sz6m1Kbn8Ec7pU3OL4dcyu7rv9Rtw5K?=
 =?us-ascii?Q?8+2e+r9sCrkMepJRbc/Q+IqjN6+h9tXpxqLPDwZ8k0PTO192jPzawgZDYqsh?=
 =?us-ascii?Q?A5HZXGi9Z8uGCjdoGAiLAMxn1ljiwqHxS4FvEX5MoP3jT52YVrIQrGogbfT0?=
 =?us-ascii?Q?9CxPll/D+iirHMQj4jYk4wIUIGeP/eJoig+t8Dkg4MvQILFKbkpsABW6qge/?=
 =?us-ascii?Q?qb9KOMDfPIw64kDyCYxbcNXB4J9hniPBRHZAGbz+1JtP6jnmROVtpqf28tbO?=
 =?us-ascii?Q?JdjbcarjdkO9wBOSS2PdbJBWQsZu1x+AK4jSjTEHLMWTPpJVs41V+AVDC/4/?=
 =?us-ascii?Q?eq/c8ld35PGGB4A21WLmt+YHcLlZyc2gQ7Kd/h9ZDYfSQkl7TuHxOb/3+bnk?=
 =?us-ascii?Q?+Y/9sXX3xdCcI3FZgTDGxEbZoP+reYrGEQA2GspVropYlZRyzh7zsHzFnXKL?=
 =?us-ascii?Q?ISGVpW6p9XEZtXyXPwxbm+g2zc4NHYwJTuCHrrB0sUVZfO9CI134ZeIwE6sG?=
 =?us-ascii?Q?ix5AfpP01nB9IMGIVHUj33kzT3empVnn3qmSk0QuWk+ET1hl4ynwjNl6CGxw?=
 =?us-ascii?Q?IGqGPorlrrTSq5Ns6fXInTp/NraRJxFj4BDYKqey11D1GNWxJo4rC/1BZjGS?=
 =?us-ascii?Q?D9Ny7bwwi4hVwc1O6BbdsWp6ocNmxCBBPSqFQvfRV/xXHAcRExS26BTpWU+n?=
 =?us-ascii?Q?CC5X8z8xJDG50QU04h0rapnj17YYS0xDy4be15kP6jNhgh4uXw+NxNawPojd?=
 =?us-ascii?Q?cbwIW1IHhEY8AykWk3tzSsSa4qLQIJZZJgM9zSjRenBIxAZdEY2IsNkOEPlF?=
 =?us-ascii?Q?9y0B1RRKmuqrE2987HAppBctzpdujRqD+6xqyhlsjNkeLh21cO39D1HP1KEZ?=
 =?us-ascii?Q?QkMSQmUOD2HcmzZC+BebyyYc0CZmgvSkgCLz61G4SykxL+XehFFuEGoZc5yM?=
 =?us-ascii?Q?qSuN+q7NQDNgeJ3guuTjt78zdDvyKi0fgvA648yokz6vzCx0hM7MhftbvojZ?=
 =?us-ascii?Q?mCxBtsuyz7oS+YrdT6LC+JQl3BEPziYGWBm1Y6xXqqK/2KCqaQgeKxSW5edR?=
 =?us-ascii?Q?vEXxuAJUdeBkrPURzSXKImJjWsgrf4bI6gDO1i/VMwIxhXr2Lb6WL55C0G0G?=
 =?us-ascii?Q?0MIDaGb/WxLvqIXwW2fD5aNNJ7LtrDrs3cQ5FQYknuftLFEccBBe9RQNsSj1?=
 =?us-ascii?Q?xcCeaq6owvoAYkViQLGnXW8+farBqMgkKt+6+lSNj640VvBY1ne8Jp1oxNcC?=
 =?us-ascii?Q?VdBji9nNn+3DxQPXXwz6A9Xa9ZJoSWHFj69wjUXThVgeRPUzqkhUgqs6ie7U?=
 =?us-ascii?Q?3XKBV7OsrQwEMVgtA/ifzpMQOZ4XQfTjHI8c/1Kde4QQcX9f1XVn4QR3YSBM?=
 =?us-ascii?Q?uCz8tRQpIo/PYIz30vQQFY09krHB2612byNdWIKSEjoMUbiBi79TVmLYCESy?=
 =?us-ascii?Q?SR8WSMknBDvUctxMbxqFR9rtDOpidwphfU3Q03FKDaLxiu468f2JVKH03usg?=
 =?us-ascii?Q?zvbz5b4HKdTNgzfzBcIKMrRkCJn61l3TimlQl2L0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3defd87-a8db-4eee-c713-08db82a14c84
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:29:09.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWZ55iVSRzKm/PmbsIVfwsvRas7wtqwkadwIExazsYS7g4O8IotjLgWjZZoHv2/ydHnAXp6EO2z8Q8KYPtTTvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6672
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 drivers/tty/serial/bcm63xx_uart.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 55e82d0bf92d..0dd8cceb837c 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -832,14 +832,10 @@ static int bcm_uart_probe(struct platform_device *pdev)
 		return -EBUSY;
 	memset(port, 0, sizeof(*port));
 
-	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res_mem)
-		return -ENODEV;
-
-	port->mapbase = res_mem->start;
-	port->membase = devm_ioremap_resource(&pdev->dev, res_mem);
+	port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res_mem);
 	if (IS_ERR(port->membase))
 		return PTR_ERR(port->membase);
+	port->mapbase = res_mem->start;
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-- 
2.39.0

