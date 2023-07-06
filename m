Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BD3749912
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjGFKL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjGFKLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:11:18 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2106.outbound.protection.outlook.com [40.107.215.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DAE10EC;
        Thu,  6 Jul 2023 03:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXESrQoT3eGBnwQVRC9TUfQqijKslI9vCxyH/kApyq2HGuz6D2qrlBgMXdmFgim2nl3XbzhBdHkpaF37PRAe7OK3lx0xcc7eznCgvbaY3GKAglDbXw83oDuhFwm3f7RP8bucVWoexIqvNL0g0HAHKLa6c8av3tCd2dMSwCQXIOSHnYqu77YvBVcRr78wZ7GNRr4U04AKla+idT3hvE3xzbwIKj+7s3/7GK95S9BFSCGP7oqodRORfN0n8UBc2OmX3cR21t9jbxDgbtxi7mh0tsnXNANVN2+iQYfv61sAOCB3YetOitQj4BFyTHoGxrbo8f2O2CzxsEPUjZnI8cV5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMO4tZFG2Hb3/XjMbRj4KhvGd4TY+UTX9//pswTugWI=;
 b=LjT2iMXER920x52JqozzrPj90Te7TnoHCGl/p25MwoXddGVLQpx7pVj7bFwvB2SBLCYwdePIYoH1oxd3EI3wI5rMLt1Aw+XOhCbUNW4nFK/BSyaV2M6ptZ6m5ghwwy+aXk0dgzjHrgKcO8+GqBwZR+9DIYkgnbUEsNqJn0J4/gZYh/HxIdVgpUTaM4eavY7XJ8QyiPCjUpCiKn35TvIRLvsc0XUrhpE5qkMlpqDlCqRi7V4wMKY9Ut7KZFgWKBetDQX7zw6vfOtED8Vf6DxmZqrn5W+kHSNW9QH6RvorROJK4z8JOpzyjFX2F9KzNBOyOOA5iwayOwx0wY+uO/ihLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMO4tZFG2Hb3/XjMbRj4KhvGd4TY+UTX9//pswTugWI=;
 b=XaurrWulzCkn2rxlteHBSIL7gKoE7JEi53dvcj9kxKLeCPfrqvaozUqablHsBOxeFLgDyS4YgSbvX5kDlAQq4tm9r0YKp3DOCwTbVDxUmNtLYHpTNtVemkm11NF/XApKFAudo5W+wvFUp1GDGgrW9kX3qG+e/cRQTQ0MUHj4IZLfgv/mintV5pUWuEUTKuOobQuZrrrpCwL0rewzvYUTGr7KPURrnj/K9o1QxWHAAL8z/EEwRB+OoxOHoyCaUuKGRwFvc2LbrS1gwvK4Mn+hjoffE+47G1HREXVhu294a+5raQQ/I2Sd7OPDjCNInB8u6J2yp37qoOxli7SHig6kjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6447.apcprd06.prod.outlook.com (2603:1096:820:ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 10:11:14 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 10:11:14 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] media: marvell: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 18:10:51 +0800
Message-Id: <20230706101100.75654-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706101100.75654-1-frank.li@vivo.com>
References: <20230706101100.75654-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ad73be-8068-4782-78eb-08db7e09547a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q5S9GnW4KGlGAYw47nnVHX3YL0Uu4pq7sUm2WwjlwzunPBQcNRVYwyHBoJRTafopOML2wymMcXwJuf5WkXqZzcdLVDZZSRdZANew33gxkXPrvL0GG/UoMnHeFwhE9gWEsemUeU70itDeEHczzIZ61JnH8E8RZQi6afWVvKDDTnkM3W2YSlTw+y8ZcvEG0MdqFoVRySxvaQ2yLjZCf2Jn1LRR/qgYb609PK5AwsD7igunE3tESvk/iTYRXUhOCIZ4kOWDdScYdaSt27IK7GYQo0rJiIPMRfTggYH4zqtjt/3A8vkGLFj9b14WpKsVa2PWybvzSUguNLdaaiPBdfj/7uPdkHi44DFpE7fp/OCATaZjBTIUhFbNCFjJoalRW6+pZepP5VTgBORe68qLGI73THGODbRgHF8dY/MZ1xxhbYppWjLtfGRUKh+1L/MgEoXii9dU2oqUNNdWH87rnDL/JpWuFYL9okvCoQMq+j/duEauk780N5K32qXvcKNF/eYq9UBsaFr5i2Px7ZxtLiv/GnOfP4GqexZZOJ8FqcdY/T2MA4RuCEEIvet9svbCF4XQF2ZI5DECNVlWYBy90qjl+OaBp0B9KqgiuV+nsWp1d5Hf4+zHFjul5E+bCUSvnKeI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(8676002)(8936002)(86362001)(2616005)(83380400001)(38100700002)(38350700002)(316002)(41300700001)(66946007)(4326008)(6916009)(66556008)(66476007)(36756003)(52116002)(4744005)(6512007)(26005)(6506007)(186003)(1076003)(6486002)(478600001)(6666004)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VGsNvaQmo0qsWvBp9GUVYtUT/Wt1hNwf9CCFQk/kanMHx1jOmy38L6ceDPH5?=
 =?us-ascii?Q?IZsFKS3S6OEHMQ3MndCjtHC2auFmyRKg6oVyTYjN89xbM7tYlr6tDuLwg1K9?=
 =?us-ascii?Q?RW8Sp8AeQZFapBKvsYbVKc7ZaBM4+AbSHlOyYwMvaDFil/y3Zs02KLqF9MpK?=
 =?us-ascii?Q?2eomlEufyympDUOobzW8K3Ay4ugtr4g2k3eNHHJaAyqiBjiJKg9K7pCoefAN?=
 =?us-ascii?Q?5lv/uN33gAnNPm7Ac8Rbr8lYLgNer2gY3baNFC0w6HkooSN3LXSy6I42vYIh?=
 =?us-ascii?Q?zVKo7j3VhhaiL56iww9YaTbC7naoUhkbLsfeVjogRQCejVtjtNZiIryLbNJo?=
 =?us-ascii?Q?Gm0Fci2X2+dJWI2POlBGW1Pp7AKBip6u3zG8keySKoP0Rm6HfRqgn3b+IF6d?=
 =?us-ascii?Q?1Hevx1P5NJNZF/zcs7x2yjhAc568MzRrpbdlhF3ofyU0NjUwLljYpv/Yxan2?=
 =?us-ascii?Q?45DMg1Eb+LIl3jNI+Y7ysl5T4GRct1EId4J2IjkicnLSsaHYV0X0utUy0j9z?=
 =?us-ascii?Q?WU5JXzrB7M7s7ibWh8TwJ6WmIs5XWH3mWReq46KbHW+9fI8f4uayC0tlz1aK?=
 =?us-ascii?Q?XaxY4u7feDoa0vDs6WXb+1KIyp1Bvo+ox5OeOXx0skFfXWCn3ZAYdU5qz8ov?=
 =?us-ascii?Q?TrOIWCoehBKanAzh1emTqQogWoac+7/ERG/K8f13DQBBmTJ549pswCXmNk0a?=
 =?us-ascii?Q?VFf9e4oMw2NNNN418x0xFXtii4NvudUfuGXJ7hpdR9TnPIFS2X0H/fWK+a7g?=
 =?us-ascii?Q?HgIMmstu+24TRJOZA4f/jTiAfGUcn47hAK89uffl/+R6SQ0x6S4ps2ZPMxnI?=
 =?us-ascii?Q?pHwVqpjJM2q3PlUkipj4Cgty9/Uj9zH0VHWwJjyUc2ziI0y6NXN9r2RbCyzn?=
 =?us-ascii?Q?9ZHM2FtpaOMF+olNL9JbDc/yzc+n6/sL3dKdPiN65qcMMkecWjnZ7HrZ4r+l?=
 =?us-ascii?Q?FyBebYzsHtlPDioDvgq7Cca3Prelymi/p43X8rKe9WZB5JqW8IK+MAZB4ylt?=
 =?us-ascii?Q?eKmoEbx+YA1NZvDkqUvIr0wRt0QVkqoW8xUYOg7LL5dlVtDIuehj0WZof0yB?=
 =?us-ascii?Q?gAC9FiqUKOxKU1rkStZKFQ+JLJYC0KC+o1A5IDuE5znpgJvNtxjHiLlMaXEG?=
 =?us-ascii?Q?4u1EUPxhpKSGYz/LsT7b+mYmREkzpFFPkyxr8S37V8mLDKgEdMQzUdOS3NJN?=
 =?us-ascii?Q?PRdNylGznRtQ6Q/LI5bcHdNrU4sT1uxp20nTY9N1vavcm1/Jfmdnh560zigY?=
 =?us-ascii?Q?sxl2h0porf+d9qZ2yN4OiAqKu1jqU1QzZvMSU8IY10cNuITBDcghSLeG00D/?=
 =?us-ascii?Q?4I2UcW+CmaaUgndgyeOA6ArNU9Ix5yA6JUuD7LG8R90ebjPI+nJXUtTTxol+?=
 =?us-ascii?Q?eX7m8kJr5lRR0JVDhKzFlB6VxCxBw8l1lCtJQwoMJYRAB71so5QgJJDp5X6G?=
 =?us-ascii?Q?6LAcbJ/BZ5oOVome4RZC7sDvjXW+An30PaKgoVAKFVmjQdoiPf5McDbUifl+?=
 =?us-ascii?Q?/8NQuyskaUAtz0rcnEQ884w1FwZ62dJGMcKGJ0tWykL1gP2QrZubZ9nMXu4b?=
 =?us-ascii?Q?WMaUJxVJxz/9Om3IFz0WNGmdFNfpHJX2ZhVPMLAw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ad73be-8068-4782-78eb-08db7e09547a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 10:11:14.2523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HCZgJr6hKAr3YIoCa33C2iAdBLePHd0qKjUx0cpBp4t7r7RVIkWZrSRImLjSQZxnwjNTNG1xzojnMyQdk+gNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6447
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/media/platform/marvell/mmp-driver.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/marvell/mmp-driver.c b/drivers/media/platform/marvell/mmp-driver.c
index e93feefb447b..1e9ad79e53e7 100644
--- a/drivers/media/platform/marvell/mmp-driver.c
+++ b/drivers/media/platform/marvell/mmp-driver.c
@@ -223,8 +223,7 @@ static int mmpcam_probe(struct platform_device *pdev)
 	/*
 	 * Get our I/O memory.
 	 */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mcam->regs = devm_ioremap_resource(&pdev->dev, res);
+	mcam->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(mcam->regs))
 		return PTR_ERR(mcam->regs);
 	mcam->regs_size = resource_size(res);
-- 
2.39.0

