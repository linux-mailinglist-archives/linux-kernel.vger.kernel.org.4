Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE0474A915
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 04:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjGGCmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 22:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjGGCmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:42:46 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770D319A0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 19:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXjDtNJ2mmaPFa5caZlZ39kpF8IpLjcBjZghh2rhvkuMouW9Mqg3yTfwFeJJ6O7agifWKApHTd7DW+A65v6aWd7Ru6mt4W9E89M6eygzmzqF5dHITbdwVMtMdmL+SR6B1L/qnfwoEKbx62ruExxZpzy8z37QFr6gy375YI2h9cRX6sEoOMlCrIOcFbTdTMt+8XHoy3BcRJVXGe5LuM4ilYhs21oGLh0ETAbYpSMe+SX/cJXsrhnF/qKMVZlw8cZHvdDcC1WcuL9ndvHjbpSHgLkwcEs9rA22XihKqJshbW8km3uzGqxhE16jUxkK4z2rpXAn+csoby7w8g+nER64kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGGHqFDuoboytLMRjkf5bxlXtznNaniCA29z+3D4DpE=;
 b=O6Ljgh1yqv31OMbG13crJOqWxGTVZG+Qe+/dPS5U2Fa2DuUQiHbHFfD3j0S3ANtW3euin8Y5pLJ8zLpGApiz/H+kjZeZSNo21kgJ1wYDazQCiCI/iguEjVQBNf1TYGOkpW+RKYAYv75ohmHC2HxMMvgvvORDt+fbZYlhYuTDG3BtZ35xnqfFt3uTSoPy7qgjGcQ/NRHqTpVk7kEBWScKXSZ0cJ0+zBrvthcjxvYvuJnjiEo7v7qppI6WCEntrRmG2BhYHkzNp5PLYpwgZGMNA801L7ly1Pg+gwc7odQTxPI/c+EhXaHPjpTgIInu8xhC2QIesOKH5Q7f+/kqelZ1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGGHqFDuoboytLMRjkf5bxlXtznNaniCA29z+3D4DpE=;
 b=RlzwXwBXu+JKs2+i37SQZ+P2CZrMmDm21gS7jnV77BJSzDswrHxVy0vb6H67InO1ZdO9oGY9xcZQXwsANtBI2ZWhtS2rWMmbBoWpNHNif4Zvo1z0ZnGa3qVpdivLATEo+0vNUeEJzCuAFv3IQ+Iy04XoH/BN7KvvGB1mqdMBuZddrE9XmR957M0Lm+HpVM3wflp9OjXCw/ZcVKneZcp+aeW1fNMw1M4BxjEOuAV4vZ1wGYk+vWtPXZUhR04FCwtQvbluxUYbHGfDH5oFu6iiAJaezZO/x2Ojwk4OHu0pemshhvodVjlUaJzdTdO/e6dIcUsSQbKJdbWKce+YE0AdOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4482.apcprd06.prod.outlook.com (2603:1096:820:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 02:42:39 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 02:42:39 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@amd.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] misc: xilinx_tmr_manager: Use devm_platform_get_and_ioremap_resource()
Date:   Fri,  7 Jul 2023 10:42:23 +0800
Message-Id: <20230707024224.78907-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707024224.78907-1-frank.li@vivo.com>
References: <20230707024224.78907-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:3:17::36) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a2b1c6-7bf1-4098-3675-08db7e93d435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1uALAY23RggdRKGRvH/uG3+8sCNeLz+IARdtMnWTze8JTfzzCZJZbgtyWBCh/b4d46v35U+tXFzaGQmQTlskl7Pi6kA2PEUljJNZ3N+aIENg2G55Awf6KUgHeU1mi5ksovqTBScJW2tPlb5XRsqqHvyOz6+P56+oDjovbr3Zn4Dj4uZvr40qW9rFNLq6O+NQY1GcRKbuqfW6qmegcU2ymu986yKFRRojujncSHnqGAZEaKwrEchSWrVoNEPKTxzjx9jI8ghARo8OaueSpKxwuMiWKFMaPa0ivFR4XA9Udyxw9mWrdjRXdu2tr5dWYKF2qejaIMafQykw9+sK6CAak/yvhcQVEu0Vf80rbiuTxHUPrWrW9UnIFGJ5lR54LyWkdKS3lLN1coyNAEep4V6x3+WxawUKZNoB3iVox6si/o3zcBkvDO5IPTJ1ASh874DeZR+1SURP91KdG6SbQoYtvqGs2wCbBBTl/MNP/i1r1/c7Su9jD7IYPbif/nrtXgv0fkejY1b7pca0XWppiZRj0iZtkAOC/FWJunU24id+jE1L4RjY65D0LZn8B+iL2inRkwypIQNy2F3/ZdU41tdQ6sKiYDIjz34gVOxSbiU4Q7hDhh+JcgBt003KSwHXIohz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199021)(6506007)(83380400001)(38100700002)(86362001)(36756003)(38350700002)(110136005)(6512007)(6486002)(6666004)(52116002)(8676002)(8936002)(5660300002)(478600001)(316002)(4326008)(2906002)(41300700001)(66476007)(66946007)(66556008)(4744005)(186003)(2616005)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ngj//CwXPmYE8tyUWyGOZLu1byxHhf9QwcONjoaUff99akz83kBlb92b6Zb?=
 =?us-ascii?Q?JfNYUYjVgov2n4QjWPc43jtAOJQlpE5MjxISNuMTaS9kMQa0KVhfpJuPnCR1?=
 =?us-ascii?Q?gSCal7DLKwY1pi80Qo6NJE60OnQv2qtWS3fCOGjhVXm9Jr6O99B1VeJT43AP?=
 =?us-ascii?Q?ShB3UWLCydeJIZh3h/6EP8jtI1fNT1RwK/ua3NNYYf+UgRTAIku/gkQCT8iS?=
 =?us-ascii?Q?aBwjm+C8JRpz2zIdSGjFR28gzM925lK7Rt/WQnd7xiJ6iudun97sDki/ZH8G?=
 =?us-ascii?Q?jQsote3D9ASdFIenx4f8jIxSuVosgfKxtB5tP+V/+pASMzFpCVCftozxGVp0?=
 =?us-ascii?Q?CwgZ3Vz8WVk5W6LfkhYHlZYKkYK6T0aia9tPALbJc9DEQubAQFLWlvsk46Ko?=
 =?us-ascii?Q?Z2dVjJsJKcjRKWHJUwB8sUXWdhdZTjQJiHR7v9psEf5r0yLVWwN1Ko6mXPa4?=
 =?us-ascii?Q?hpAb+swQKFAa53j+bxjdyPpvg/ulydRJg/uL5nswWvG7YL5/MrEKuBhdk690?=
 =?us-ascii?Q?2topTfcn0zLk7zIlsmcOiSFP7Ps1VvtnkVhSbU7IXpErQojuiZQR5x+DQlW4?=
 =?us-ascii?Q?NGyeHIEEgomwT1vvFjDg30A1X/tWKL4ZoXuBKKRkEBi8mNTjVwk3LooTverS?=
 =?us-ascii?Q?gcYjIZnXHo+LQWaX9ZdTEheeywlSKI5qVy/7B4mjj8CZ0Nu+GXHwp9hQItps?=
 =?us-ascii?Q?9AYZxiZNqajIWjLg0BsH7yA1pHiP4EUN6cyuuQ7lPplek6XEgvgm/6CwGm7V?=
 =?us-ascii?Q?D2nePPw1Wic4mgCIpZaS+ZgG5KI3VXhwLAkP0fYgz2A9soPyxBaJWMYhXVQA?=
 =?us-ascii?Q?TqcdNTpRS7wCOe6UzN6hp2buyQZIvZfkWi9+9B9vcoblviZw48cYXXnTs++5?=
 =?us-ascii?Q?/yTtQFb3MvIlC5rxsc8mXfwBrAe64HDPK9aKmZX7uqASdkqFYFUy3yLMSCsl?=
 =?us-ascii?Q?ouAuAy8gVSOv1EuSWx0Hhf9HKhmLjlTQBJ9lpD+OBQ49JaiYBtSv6avOvP5D?=
 =?us-ascii?Q?HLYb8BnCeQPUQfeMotj3GgM9G1Wp+OZDd1oATYZ0To272W0JuYTOmYANrkl3?=
 =?us-ascii?Q?vPuyGZPkR/yxtOVOrs5AI+TmqjIda4hmO8uWiKYE3gympUijMEZ5bKNQj/Xp?=
 =?us-ascii?Q?YfcktdwvExxShIEEyHa9FY2K2RfskWFvIGaw6Y9+093U+RfjC5JZkK3aU5F1?=
 =?us-ascii?Q?MtgdCc/172oQZyDwO+h3EdPd9fZ0+6kr5raRhUuzab+oiGVRaS8o1qaPXjFF?=
 =?us-ascii?Q?oWMUw3f1tlr9+d9xUCEGG1wv3T4Se+HHzGWUk9KVpXV0qgJ0PLcDO63A7AoU?=
 =?us-ascii?Q?YHAffj14Rf89psqaFgfxATvT+1mXVCddmzgbnQk3E9+xDVPhPSInn1PvZYqd?=
 =?us-ascii?Q?8XHwTrhFrMRUkQe29FKexT9xkp3sdBr16ooeMs/xDYqtTe9VMviPRJZg65IM?=
 =?us-ascii?Q?GnU/BafggCv1jMKOWot6s2Ij8wvdMxVb9RaEMLmV30wf5WbNcWpg2NaC1YZq?=
 =?us-ascii?Q?jUWfmTj6mRSDzSP/vvvFiSwC5vTKBtQ9mgnt6s4l71HRxsuptmwH+ag9+WSy?=
 =?us-ascii?Q?iNLy9YqB+v9Vzw057I1A8HpDU2tnLmzEbTGue3bN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a2b1c6-7bf1-4098-3675-08db7e93d435
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 02:42:39.0923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGPCkytHgj6+iiXa6K1p4pCBucqLlvJcv9CW8JN6zoqiO0Rh0mGKqEqXfv8Vjr77C9g54+WYL8UjLg/OreRERQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4482
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
 drivers/misc/xilinx_tmr_manager.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/xilinx_tmr_manager.c b/drivers/misc/xilinx_tmr_manager.c
index 0ef55e06d3a0..2e7a5f37a01f 100644
--- a/drivers/misc/xilinx_tmr_manager.c
+++ b/drivers/misc/xilinx_tmr_manager.c
@@ -170,8 +170,7 @@ static int xtmr_manager_probe(struct platform_device *pdev)
 	if (!xtmr_manager)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	xtmr_manager->regs =  devm_ioremap_resource(&pdev->dev, res);
+	xtmr_manager->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(xtmr_manager->regs))
 		return PTR_ERR(xtmr_manager->regs);
 
-- 
2.39.0

