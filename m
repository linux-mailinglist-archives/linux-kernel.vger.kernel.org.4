Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE2D72F659
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbjFNHbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbjFNHbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:31:08 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2136.outbound.protection.outlook.com [40.107.22.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8C998;
        Wed, 14 Jun 2023 00:31:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeEqgj7FiwFgNlRCl63yunja26e9nPh4tvg3i9+JhewkT+t7cJsATotbZJl1gd4hq/AZUqxt1pqMQ0aJDdxslFPGenOOxmH2yjC8vkcfGzK3lVkt3uBbLXjuMNLye0HcYGVfY5d3TGJmYBK3r1Wj/dfnjOVQt7eoiXPiSeia+Jiby4y/XsJwn7b9c+KwuAYK6uxdjgARtQp40wb8W0hdgsD5PvsDfrJYTzjAB89Ytw8/h/4l4hy74e7rJmhnO7CIb4Vu776UWiIqg5BKziu5Qvdaj/6Aen8iGd9c9xsEUvQrSgCRPnn6Ol6KmrDnuffBu12UzJCfVntq62S7dKxdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=763gNq6HC+K4L927KHAwojvCPYeNSfj/w1ElciVOHeQ=;
 b=IHAzKZgg6aCFxGD33cqojgDFv5yQGfWhTkG0PQxV8te27gjxXtVpnX5v1x4S8FjfqXG5RfCMV7iXYMAgZ+y6M0JEObQOlyKRa+9hnC3/WV5Tj7fL9OL4OW9ziP6Sdc1L5XLuwKoYwVeVTKD4+RDd1ZTB0MNhYJhQcD+LbnBco5KzLh3kZQh0tirNW7CS/FiMJk9dyP2FwRL90+Xs8dV9kTTNqoEnM/X2DU6DDZ74Y3H98Oq2zm9jScQFBeTqwe6IRBqUdFamagmynN5pQX/WM/Xj/Q5P/o9u/2lsY/rxUZDREU/qyCnsZJYmwilKaFLOzQ52uZ5XfP85Io9NBnTTbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=763gNq6HC+K4L927KHAwojvCPYeNSfj/w1ElciVOHeQ=;
 b=qlVFP4RnQuRzq1U5+xAw8vSr8NqDnMb4NqY6VQRdfSvZZUfDMMi5+biLBtTmKsZ81U34xcL7tfqs2XULNyCZ/pBXnhQyki6HDoH+WQmayGFcdQy/Rpg13t4485WE/TX0OxAd8dsWvpvXWMdVaein/gPXzduHSC0IXmm1ChCtJRvoKT7U15h5MlP4HEdxcLuvfPrMzItfKdbXXdLHrz7nLLWEQzpFKu82chId6+wwlQg9CVVrDcc1qdSBJU22Izz/4sZuOaPuNLtUjXj6x+MSb17vRTC884x9rAFVAmMgS91PM7ME2lkWEcJSPtw60CdNpA9m4u9ZR4+821dpgBtaPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from PA4PR03MB7488.eurprd03.prod.outlook.com (2603:10a6:102:bc::11)
 by AS1PR03MB8238.eurprd03.prod.outlook.com (2603:10a6:20b:471::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 07:31:00 +0000
Received: from PA4PR03MB7488.eurprd03.prod.outlook.com
 ([fe80::fce6:c9d6:1685:4973]) by PA4PR03MB7488.eurprd03.prod.outlook.com
 ([fe80::fce6:c9d6:1685:4973%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 07:31:00 +0000
From:   Markus Burri <markus.burri@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markus Burri <markus.burri@mt.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH v3] iio: ado: ad7192: Add error check and more debug log
Date:   Wed, 14 Jun 2023 09:30:33 +0200
Message-Id: <20230614073033.2497318-1-markus.burri@mt.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To PA4PR03MB7488.eurprd03.prod.outlook.com
 (2603:10a6:102:bc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR03MB7488:EE_|AS1PR03MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: 81224b9a-a8af-4a1c-733c-08db6ca94d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7XQTZRJE/s1MeVUJsnElmaefmlXJVTb7P2FcE3lafW4Uq1+0d4Jcz1G+77+WnAHD3CIOIA8eXkdkECi52Tb73Y7TTRyqxLigjT9oZYxoMdwSeua3ZMLk6xGFrqh3R2bbCyo0BS9TZ4eSJjTViHVEIIB4fyQbVzOConGkR8BIkNXzv/MeglpAIBlFAlNiEh6Usk7X/ws4CswVgQSn7iSiYTxfKBGdokf1ivBlsl9/pP3Cu0d45BX7GHZJseLGYpXCx1DMHiK/fCPhqoszpHBLjjb9Pi4bbsrYkD/EjRy5ef/aS/rsVEmHIsNTZBYbVC0HQvq04tSkXVlErohy4/qxIAhAH4lAjeibNosTlf3CROKeiJWwF/vBfiin6u5UdOa251hF28SWyfE9N4pRVUOJ/SaFcg00/sXQlW1iOuzYRBj3Q71X7WS7Sgo4da6EiKek6uuRsQYk8nIEucxmQ3/O2n609hQaWr5SsuX+2qjKuX9pUlVdNCTWysC/KHJ8yusdMd9Hu8J50P341mRyVvA8vZhEurSUvNYO34xhUfYqWjSYA4biWeTCrDczl1FhT9SXdYGp96nC81orVHJq276sAcmQo94T6N1Py8E0SlrE6W/lTauWrRj4HHg1hcCJcFU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7488.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(8676002)(8936002)(2906002)(5660300002)(316002)(66476007)(66556008)(66946007)(4326008)(6916009)(38100700002)(83380400001)(54906003)(41300700001)(2616005)(36756003)(38350700002)(478600001)(186003)(6512007)(6506007)(1076003)(26005)(6666004)(52116002)(6486002)(44832011)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6DrXQiP7BZMNjHp18bCsYS31EB7joYuB7R3rUCc5hCRhTRWADmOvUIhERB/v?=
 =?us-ascii?Q?RLNPsJ1ojkx1UyE0IFbsTxQI4emuSBBqf2g2ytq7uFvcV92BkcZ4+IIdcpen?=
 =?us-ascii?Q?TRj3SOqWjCWiGUlZ2Y/92Z1H/Mgr4Xq/cjZa/l0k93U9PvNxSK3DIq0uJCEK?=
 =?us-ascii?Q?/16Z+PRaf9CH5Q/I8X6/3dA9MAMJY7SMUwDs1wIYjTG9Jt2wRipwk0EfmQKD?=
 =?us-ascii?Q?+lwWUvn2NFqX9vkHhdCB4UXXP7s+yz1tw1wumXJkp5fHXPfp3bFHZav7iVAa?=
 =?us-ascii?Q?+9A/jQSm0ZV+XW1U66mPjNUWNelt7vjtn8Rzm8yKpUQrSZGe0gw069CVigj5?=
 =?us-ascii?Q?Olys30oOHEs+yDjzgqLUnkzjlL8NDRNn+UHMBe7UWoCEfmjFm19aXsxfNTws?=
 =?us-ascii?Q?qlVx++b8WYgU1bZSjIRr8j6QKT0EBALJob759R3JtXL2Zmw6u3Y8TPixwjwj?=
 =?us-ascii?Q?objKdsCd1/4iR3vgizS+66hLPPGdnfTkNfAFKiWFPZvjkL3/HzJDIiW1havy?=
 =?us-ascii?Q?gGQO+5ksbUHwAJdyA85EU2hGifOh58QOBY55DcvULeEhtR60PmqAtiNJ9dUL?=
 =?us-ascii?Q?6DSLSDrg0BhAd4gs9ClrAtc/DFz9kI7A/Pg9q9LQfFDNpF6uDStHJs3FLuzb?=
 =?us-ascii?Q?P/eom2+hXQ4DykXZG/Qvg6WZn5PdHvKfZj1xHL9W3frNVCSlSS3fNn5xNIdU?=
 =?us-ascii?Q?ltoskomCsBNvc2LlWXN/jf0EGmsqAMZDuQUDKF/k8ci56Luoh7ucvZMgp9Ad?=
 =?us-ascii?Q?27k6iu8V9VtWn+GzqOa5kC0T8cA6g8wELXczJExWmx81D/97Z3tHaT3mQKUN?=
 =?us-ascii?Q?Xic7SbQQBOyz3wVup5XQMW73BWv8yOYHl1hceCUOEuDwAR2n/LZBQGykp7yZ?=
 =?us-ascii?Q?0yY4C57aG+hfrMR4p1sLnwXBv+eMkdzKxnjJSazdu+P7XIbwHB1HWdKs/GCx?=
 =?us-ascii?Q?7JlxPjTbD8OGSPqnQky6P7k8eZsKg65K+4efg+cPGyH4v1CkFROytiU4RfWE?=
 =?us-ascii?Q?fhIePWd9MMSltbst6FrNKw18Tb4enJ2xa25Z+iLfqD5KQek9O3mFBBZJ+kng?=
 =?us-ascii?Q?7dOwNLa1pq2LN3QnHEg6hu6Bey/RJLuBkmtavB92rD1XLHfSAzcsI/5osoH6?=
 =?us-ascii?Q?H8Whyf48FL0pyjfgFv9K0gMASXEtcWRAHOyDK6a9msEjXulGVchII7juyI+3?=
 =?us-ascii?Q?yUCZMpMzDKdU5/DI8j7/MqoPS6BF9R9s+7Docb6bCTp+nPUyphXEb1JA8QeP?=
 =?us-ascii?Q?7o6yYI17ROzdXC/bEDkNnfX1oiGnyfV06BpZgjTZpZTXPsF5X+JIX4HagzVj?=
 =?us-ascii?Q?dLgfWtLCM/BvgCAlovxTzAmF0/JPpjQh5QpFiWMtGrVr+YX4WNQwHK9dgxfZ?=
 =?us-ascii?Q?v+9UiGOLeM9Mu9MZ9snncLMo3V9E9x0uH3PoFqdvsnXoO6tJrZ/Sk0CuJRNV?=
 =?us-ascii?Q?ZD2Ij7/jP9zWdEf62qaiN1eE3N1Zcoc+OpmqIaeDM3dv8kYtYj0FY/Bw+GIw?=
 =?us-ascii?Q?QaYj5m68ImR8nN5e95FM8D/sAJBxub9b0qWfHQNc5/keEs64Ya0Dv7deq24b?=
 =?us-ascii?Q?8ZSNYKNQeKRB+AXjhKgW1p+kZ6RpCU2t9BwyoNag?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81224b9a-a8af-4a1c-733c-08db6ca94d42
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7488.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 07:31:00.5393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFSmtRHjLGNT0/bfJB9ARUGc6q4s/8tcnE8YSE2rgE+RMZ9j41G3zsrodOm+P6zwga3XHUk0thoHofwBwVslHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR03MB8238
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print read and expected device ID as debug warning.
Add error check for ad_sd_init() result.

Signed-off-by: Markus Burri <markus.burri@mt.com>
---
 drivers/iio/adc/ad7192.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index d71977b..220c3b7 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -403,8 +403,8 @@ static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
 	id &= AD7192_ID_MASK;
 
 	if (id != st->chip_info->chip_id)
-		dev_warn(&st->sd.spi->dev, "device ID query failed (0x%X)\n",
-			 id);
+		dev_warn(&st->sd.spi->dev, "device ID query failed (0x%X != 0x%X)\n",
+			 id, st->chip_info->chip_id);
 
 	st->mode = AD7192_MODE_SEL(AD7192_MODE_IDLE) |
 		AD7192_MODE_CLKSRC(st->clock_sel) |
@@ -1049,7 +1049,9 @@ static int ad7192_probe(struct spi_device *spi)
 	else
 		indio_dev->info = &ad7192_info;
 
-	ad_sd_init(&st->sd, indio_dev, spi, &ad7192_sigma_delta_info);
+	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7192_sigma_delta_info);
+	if (ret)
+		return ret;
 
 	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
 	if (ret)
-- 
2.39.2

