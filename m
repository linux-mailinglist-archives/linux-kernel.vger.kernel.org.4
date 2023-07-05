Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869A4747C58
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjGEFYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjGEFYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:24:03 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E710710E3;
        Tue,  4 Jul 2023 22:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyK8V4cHfZynFjTtzkpttyUswvuU5fhKAxcs0swuPaj33PW6G/Yn7VwPIuQaCzD1A8Ruv/Hy2sDubeeyUwayAdWuTVvUT0M6SbDZb/PJS/R7AGTfB3x99/bB4kRkWl1FbZgKZk0syh4XEe5X1yd/O0bkp+VjltVvdhGlUjuczSyjlyqnqIUMWU5nsgIsgtuxdJydumy9pmBcRFzrKq3Fs+4xbPrxz6CT9k3xG1ZPK/mHcuCPxtRipMfsyUVy6ZWQ1YvYWjyNHXPkc0/SK2rFH9fo30nEKkbj6dbA5yXAQtT8OJ9i0dPYkciGZ+ZkaMYqbCeqCS3ZNLoeHisIPslbBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPpuSsCI7Q2eXUj008fHD1fYS04V73KqpGD2e0H4Qqs=;
 b=fcPZ7s5tE3Ru0DkJPbhf/Yeg0D6vS5hrTzHK8m9Nl5RFY2UHbUs1dnlx0c2p94x18h9OVYkYRuKPhAI2OHPGc7KuX0vcQay27qDnPZMsREs/GOS2GCNJexpeL1yb+jwnnVYnJCG8LdbHlBFfuv2PhE3JMxgr9uPlY/V5RC/nMoGHYWI25FfoSVTwUdVuAdeMH4gqDHc6nCgpuX9R5q/B6cdlRn4q3q/TL/tlawnMQN3kzercXKeMTXYvzf8+6+/z74TMfWH25/az74HoARinLoHlCXXgjzhzhPO3mvDFOXh1icem8eFA9G8YmKf5MlErPstnjXKkvffQmT7U1p9K4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPpuSsCI7Q2eXUj008fHD1fYS04V73KqpGD2e0H4Qqs=;
 b=UahRgxWALBqsDdVv3ynlQCdQ7xlkKsCuy4DKoB1TiNsIkgitcloCj3wk8MQEtl+6J5/peZ1SEp29iKbZoBqk8nxumBtcPDq5ui2o1G4pr8JxF2dGOUIxminuCN1iYr7QSIu+3MBu/l9w8ajo7ZwcFl5I7t2v/GNMbXd51FE5sJxeYdvcznrwxR9dPEp6xc1Z/+fwKPVpq5LjMthSZgK8cJdfq5rBHhrDc7dV6BYOE5lRt6VMAwO4C87TKFTr18MRkxJfXEhDJagtk+B8mfM7YhVu1uR2x5RqbDqFbRhEvxUrxXVYfhjp1Fp5gtCTft3bWds32NOLXdoDJJDmNcd54g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5123.apcprd06.prod.outlook.com (2603:1096:400:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 05:23:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 05:23:59 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] Input: lpc32xx-keys - Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 13:23:38 +0800
Message-Id: <20230705052346.39337-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705052346.39337-1-frank.li@vivo.com>
References: <20230705052346.39337-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a89cc7e-d82a-4943-5111-08db7d180967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FhUARDHSo5lXlV43SXPdOozoc0U1jSk8DU6mQa55FZokiMwuD1DidvbXyQz/PS7FINg/0GjX2iMuvkrhzhakNPKXC8nAN+qrTwW1WSRLBUNaTtdWumoR+Sh2lzNplmwIe0WrcUvnTX/WB3sPWXqXI5g8fR7avl0HFdnffVYWIkTKL4HkFO2Hp6LiKR8Czj7bjhCilnClSo+wFJIJz5NXY/kpQon1ATshDZSew+9k7u6KZPM8HTR7VBv+qbtwZYf3IO6A6XOj6xj8ZntibJr/sNN89du7vwljU3oP89oWJjUuRQEPk7FXAzyn1O39Mp366qK0ZJJI8SlwR9GdwV7h6PvvyHt3G3pChLsPHlyyyF+KWl/wywIMjHFq1Yr1LZTS25irxeQufQoQc9xNhiWrCsMJR8tTTTbNbMfcKbbFqdTYxLbWVboWfoTBJUytSTe4cZ05RQejtQIxJJV3p511i11c5j88wCkURqs/XxSS08dsI8TtjakpvFhUWs8kARODEK+7LBw8I1C6zRStq/su5M7UIlhn69ZZsfOwMCtFFNtqIU7/1ZLeJcLkxYjwACqXiDqercLI0wM9gVpBTo8y2XMvvT6hjXoA1g7diFz5nHSBrkXQZqUQGs4z7CWT7yL1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(396003)(366004)(136003)(376002)(451199021)(41300700001)(38100700002)(6486002)(38350700002)(6666004)(83380400001)(1076003)(6506007)(2616005)(52116002)(186003)(26005)(6512007)(110136005)(86362001)(478600001)(66476007)(316002)(2906002)(66556008)(4326008)(66946007)(8936002)(8676002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bZ/fqZbsZfjmjUn47Kl0J6UExQhZqvKfLxXmPGmJIl+6UFKihkL3ZEikCBCO?=
 =?us-ascii?Q?THFJO740PR2fmxQEzmpEE14M2ZP9LO/et0uqEEKjHmrU7VTO6rAOvqd8PJZJ?=
 =?us-ascii?Q?vJOSbrO4FJgi6hJl0iSTQjexQJIx1bkwaCQhLB28rfTghk10XEoDvccaGF15?=
 =?us-ascii?Q?Adb1wXCDVcpcPHS94uoj2ZfI6lb7gz0HeBBAtYimOcODbUJyXUAZDqj1tjog?=
 =?us-ascii?Q?3yq3Yhj9sEtbSQ72/FglyiqYHSkOrl885LGMPKDOK3O9MRiEL5nHsQGNTgWe?=
 =?us-ascii?Q?d8vqOZYXIJZLzq91SM4ljCu5KHuQoSQv1Xfz1j8qlkaeCm6NPPyWdm+/MxPT?=
 =?us-ascii?Q?7Ura5j3pydaf+4ihkqmrlHXisFQKKKzJU1yEO+FjY1E9/Sq5CF5H/qyyD3UF?=
 =?us-ascii?Q?2qp/UEEkhsrXCy2YdA8wG1dPpqq3T4Ils3mVfBaR1ZIGFG3MetZI/19CNhCx?=
 =?us-ascii?Q?1yULXWpSTi2NwYSsiSap8DbrENWVu406PyuSW9A4QIsKxGH8cxXak6pDoPug?=
 =?us-ascii?Q?I2B+WkhfRfBrwXvqLgHpekklxLSfmqZ+ADq6Owakmo+n0Clw6POu2A2TLctZ?=
 =?us-ascii?Q?7GlbYsedhT1hCiv+XfWCsWbUwuQeEBgHH7RK32UJZEknfFxV8ZVPX2XU8As0?=
 =?us-ascii?Q?NRuansjgSi0b2/1MUyyaWhy9CgXfoi3s4SjoXBODuhKYt3sSQh7Z+2fVuh/9?=
 =?us-ascii?Q?c3SjW8AWmrEfypoQakzCrd8LH9dsFHnDahDKM/unGPhectcw0TSZMTNAgO3W?=
 =?us-ascii?Q?SeSqrZjauK4uFXcWJVgvFzh7/kKrNIGLnmBI4eY769fUhVIsZ79dbLGfhpxb?=
 =?us-ascii?Q?F4IJdTKLNsAjLh2UTmLbEXb/c6AZCQWMFJRFgSZI+408Yz68ZGzu6lW1N4MN?=
 =?us-ascii?Q?x5QlXV+U4qay8iV1/4xLEsmydvKOTqy6VUtnzePhIGBvi+Jr2VnEAVK3mkzp?=
 =?us-ascii?Q?5fIiRKe/d/VKF6qm+9Vshv5mADSB2z4S8BdKjdIgPpgPc+DwSJ2DSePkRO2q?=
 =?us-ascii?Q?DRrVli0xxtH3YiZkSmQDeDYEthOWGy1UoZB/tkNPZgMYYquunpyZTk9X1kWg?=
 =?us-ascii?Q?GF4Pau7wfRiMKxiB0xmHM69zggMeOH89LOH8MKFwDJC2dAK97sERWDnlAssm?=
 =?us-ascii?Q?y3ByrBMhsdpxBJWqoco4Y4JlW9XfV6G7ME0Tm8LUTgZXCmIpHTkZxVgR3ivV?=
 =?us-ascii?Q?bUPref3QSOI9zNqX1QAqs/LmTBUzjGNv7unX5a6H5QBM7w+cqAC9woM5cuYM?=
 =?us-ascii?Q?yZXx/5TcpOWFr8GoLdfG2L+LZhVR/j3POqAYLCuV8YU9+Zesn+LUy9KVcgGv?=
 =?us-ascii?Q?kB+g81AawUKUGuPsyWTTi20qGggwNS1CHoowcehpDowKbtyiktcPdRqlTNvv?=
 =?us-ascii?Q?xRzH0vx1B7NORmpImLRjvUhtSVIQv/bk8TOrZHiHLXLhRu+8jcd4hrqpTyaQ?=
 =?us-ascii?Q?AhQExx7jqdmG1ZaftPS9MfzHfNBOaF/3dFMGvsvESMmJ7yb8ODt6KyGpT+Hr?=
 =?us-ascii?Q?MhQdC+kUtSomCKWvwTji3WWLNH2cPWeMs9Wmw5j4cv7O1BMCKt1F1E0vYsEB?=
 =?us-ascii?Q?qsrnOUl9jTS0yKkKMwNYvx9ckpAR7UxHIw8yy79N?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a89cc7e-d82a-4943-5111-08db7d180967
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 05:23:59.6414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZ/LGX7n8xXyzJQWDT6KJYwmjdhY0ed4qdsraTkTRIi0k90Xzx2i+8SJJd86IFFElEXKD8giu3gLssGNBoqnmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/input/keyboard/lpc32xx-keys.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
index 911e1181cd6f..322a87807159 100644
--- a/drivers/input/keyboard/lpc32xx-keys.c
+++ b/drivers/input/keyboard/lpc32xx-keys.c
@@ -160,17 +160,10 @@ static int lpc32xx_kscan_probe(struct platform_device *pdev)
 {
 	struct lpc32xx_kscan_drv *kscandat;
 	struct input_dev *input;
-	struct resource *res;
 	size_t keymap_size;
 	int error;
 	int irq;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "failed to get platform I/O memory\n");
-		return -EINVAL;
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return -EINVAL;
@@ -221,7 +214,7 @@ static int lpc32xx_kscan_probe(struct platform_device *pdev)
 
 	input_set_drvdata(kscandat->input, kscandat);
 
-	kscandat->kscan_base = devm_ioremap_resource(&pdev->dev, res);
+	kscandat->kscan_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(kscandat->kscan_base))
 		return PTR_ERR(kscandat->kscan_base);
 
-- 
2.39.0

