Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CB36EBE26
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 11:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjDWJH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 05:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWJHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 05:07:24 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2053.outbound.protection.outlook.com [40.92.53.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AD010D9;
        Sun, 23 Apr 2023 02:07:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rg2ye70yGuR0ol1gEPqmKHvKMcJ3StHTCGNd6zXd3+n3rFWOHoqc5e1UkYrdncJibhUe/vKAoWmErSqlXZmrw8DPO5eLIaFkBnSFixsGm9ZDuaqRRGY/cv2e+IP/dD5CUkuYvhIMo37qFnjGmKS++JLKVDM1iVk3PqqmjwhkCnewBorPr0tdUp6bKB+mDhOJeTVbUhgb4X+0h3KKSkTonfcWdgcYDFsu4gwnoCwv36pgxRJiDbLaLfdCWTy11DxfDrdwb35HlubS9en9/2JhJ3eHqGTXBhJCt7SaQpnEaAm9cGg3FpAy7NM3tcRUtEQoTy/zlpx6xisc62jRny3bYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ajPr7tZ7gzOL2AAofFKGLkONv5fpHrXV9pX+0gP42s=;
 b=ZHiu5pGuWItqIoqsX/drQhQxvAoooRiaQmj8BfqU4OP1OObXp3sTTuE+fbUO9JEcRE6oytVwfSZuKgC/Yrc+jf7wnL1AEsR+fs8ohZVg6FFsLWXnVbXNjw5JJW3+Z62cDqrfGGfqX8rASKXzXi/VZPP9X6WbtixBLkr5aX7slnTb1OjkD6rxGhX/vjGtNNX8oN1QkVvP/4Q0BnkTdd7AaGpH3CNuP/SRnfvRzoCSv7soAucvDPfr1ax5XF6/IyoXd66gRINTUPlGDZPPfcQalrZNzy0NKnfojRUDg0fx5nJy5NByKILkkdi249ETWHamogH4/Fw1RDBU/VWgLrNQPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ajPr7tZ7gzOL2AAofFKGLkONv5fpHrXV9pX+0gP42s=;
 b=u9aijyhFNDJujuROu98qoBRkHzIwymV/GJYk8ich5dr5bBbzuuJdyTLotwZtCHZspU4oLGpRHuS5rkNZuEZ82w4gP1PtwwymJ9LKb79HbPUoNSVoXGIJZ43ijHIP0ItejWeEGyxHsBGccqF2iXf06NkIfwUBjqRDclDYOmTa/4FeXwkAb3+5RaF7q6zobuL+wgNO+xw/M9QzMBu8CpQGxfXZqBhaNOdoAuOEjtJStINWnoVnbG9j5QnXLqeFChKxKZ7phPIcNJ6Y8s5g/buMUmMHL+cuVT0PTaWVx2YuSb/pgzrXRBQ6+JdNLAtKGM0kF17AEMu/SwjX/nVtY6dq/g==
Received: from KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 (2603:1096:820:9a::12) by SEYPR01MB5076.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11; Sun, 23 Apr
 2023 09:07:17 +0000
Received: from KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 ([fe80::5bff:fd7e:ec7c:e9d3]) by KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 ([fe80::5bff:fd7e:ec7c:e9d3%5]) with mapi id 15.20.6340.018; Sun, 23 Apr 2023
 09:07:17 +0000
From:   Yan Wang <rk.code@outlook.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     Yan Wang <rk.code@outlook.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org (open list:GPIO SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] gpio: mmio: restroe get multiple gpio mask
Date:   Sun, 23 Apr 2023 17:06:48 +0800
Message-ID: <KL1PR01MB544800D7E51C9209A9BD998BE6669@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-TMN:  [fhe4TsjhD8S/2z2nNncUhHci38xkQjQYa+UPKqAQ9zw=]
X-ClientProxiedBy: SGAP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::17)
 To KL1PR01MB5448.apcprd01.prod.exchangelabs.com (2603:1096:820:9a::12)
X-Microsoft-Original-Message-ID: <20230423090648.20882-1-rk.code@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR01MB5448:EE_|SEYPR01MB5076:EE_
X-MS-Office365-Filtering-Correlation-Id: a549ac5a-8928-45d5-52d5-08db43da2312
X-MS-Exchange-SLBlob-MailProps: 70qbaZjg4mut0ZTEc/+RhwzsFjQD3otITfzPgwyCuh3DXz2qZZ6IBn1SP72dI6E6t9fdYxuEdZ7617P3ZbTzk/OpEuBrRoQtedzx591hTrW/KUdpUINc6ZLcigV6Z+TxPigBSpPZdNX47KLla6VgHT3WqtkPvhfypKShd7qJh7AbBPKVCrmhqVaSb1en8xpi6Dnv/I7MWLzof9d4TMwycHEuPxAZbbnGu5z5cE+wvKcVaeT0yayS9szhqj8pg/r7WE+dVxVSydNyVS9SqmVzlDlfEI2yeiMm2nidnt5Qrh1LTXepE5+sNMJXXWHUwT5W5544ZGiZQIqY2gWTrpnhKM5U1StISPXOISFGsZsepvxcQRGd/ROmpQfDm3NQgcdys/Vjt6MH5vVjAfdxkiwjXP9WQ9jeaZ//W6lHts0J/ScTGVW7fZH4qCSwijUt2OG2+NiRTjKTpryg0lHcrMTP2u90FvGegAwidCq/UFhUf0H9tG3ZER/8/asrjZDlXVoMgtT9LDmOctxPaVFlsLcGA1oFZl8JPDn59XEuIeJmjYwvWQQopAQEIsZIoSvdb7wFeaIYmF1hdm+8Q2frgt5zzMpufU5tcwAiP9XMAoWHsPVv+pRE0zUhjwhKyn0G+NzcE8RYs/Tve0EdVYY6uf/U9ljYSSok//t+lRUwu5e7+9tEjIXd1g0ZYGZC/yZW+nifidmWsWUFuLXb5FgAu8fofdvrDyLQLcHMNuzma8DI7GACGSg47wKSlA==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0rmyYpytac58hvR7AB9YL3GzhYVY4AmmDsVUSXJVx9ZWni7IS6YeUDJXYWzSwBtaWIFKv7BKvLmxyu1Qe0K+8wlPSNs7TC0Y3N8hiXuIoYAZOQBgDI3slvsWKIWKKMGF/gbn5yMtFNY4shkvq0hcJ/OVeGdc9s9GvuNRkZ5Ig3jb4UIQQGq0sDesQbNT3C/Or5Hk6SvJzwxrHZSk8/iiKVLpKLuW5zwUTvVFiXD2fHUYGWdW4EBbfog/4Bk8A5Ox1rew0R0S5yVmwgaBiBs1NGEeEIBaReY3AQYytkEWwRrodFYW/bYwgflok/bg1svcdNak46KIoVug3+J58tNs04v63jzJ073wptiYLYES4tZQMs6kPeePEFjAlfNVJzyEdVGHCIT7BqeHNeggQGJ5rRKq4l76TeS3T3s0TWDUXD0UHILhqYly4h0vkuZr/Fkiuq7X3eOfyChOiZkzBLF1qHI+Drwe0zdqmK4KIymrbLqOPPIzrz4MJLUzAUB02hm9KLnSIUWktSnQNpOFdmZ0h3fusLxuGoogR6OESsmkM+upX6WTMvckMNQpvvFaoE43TwTrWHRlWOvI+G6cmPJumBpC+xMgljSkmHgGdOBEUPs/GClnKXYNOxSSUR109JA
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VkuU7TOKo0FBWvDuue1hYYt8m5EwHVsDjpiBo3dzfbCBPoX1gRVQ4nt+c9cR?=
 =?us-ascii?Q?Bf4AMuto82outasOc4NVP9XW1Szny1KI1UkyOGDLQ8+FZHT47JFD2gRKl3++?=
 =?us-ascii?Q?HuLXtoY+w6qrE8ZvWz/nN7QsEUNGn2QxK9OcvVPo1vp0SV1rh0EK3njA2hiZ?=
 =?us-ascii?Q?UBOToJvAyajkrO19ySAzv521LNq8PSviiSaj43iRnsotwgx3oWynywSiIeb1?=
 =?us-ascii?Q?Z4dmOESlE40RkCKXKnRwGBBUyQaXVk9fXAXFMQ67nGGeHD1Y34HLHU7cJwXg?=
 =?us-ascii?Q?b5PJxYZPCb0VNu3hUrYzSEpEeaYDGCzPdRVlzgKpAC11fowWoPhd2UDrbqhn?=
 =?us-ascii?Q?juYYwonc3kDaTr3kv8+yvJ1S256Va3Lo+kg9le5gEWSs6N3GmiXDLGjq0c/8?=
 =?us-ascii?Q?oiUtneKyaJAnJGHhBDmaNEDTdaXT+GCznF9vCBxtIGZ2NbKdzyPFpWrFG7V3?=
 =?us-ascii?Q?hS2VTDb9ZMVUwUilcpV0nawMo9nOMYzro2bIGcKo874XxomyRvxjYKEF0kRP?=
 =?us-ascii?Q?LC9/GAeUUkzsLh9kITNyutMUsCEjyWHFQ75MBwgYW+BfuDEvgreOL8RiYhTJ?=
 =?us-ascii?Q?psMksfnpzod1xrzdI2Ynj6ZHHnUAdawawDX7Mwu/h1rW7ABuHfo+8GftMYif?=
 =?us-ascii?Q?RAXyiHvXF4v/ijHG4F1kQRhnJazz99bQSo2wQc66S1sg3LpTX9Owg+t2ZNzo?=
 =?us-ascii?Q?jaS8cAJZKu8QDjXbuABLInbG5EUlkoxqcmgUTnJLYkLiP5n3W5x30AHY5FZ5?=
 =?us-ascii?Q?AWg71pHpdZMRnUoYqUjcPF6kkYVIqR6GyVBXVtbJWGqD0f25OeIk8rFxC1UP?=
 =?us-ascii?Q?EyrDmD6nxFn0DZmXIPj3ikXnuGz6DQx4YhKmrrvBQAqTCA9IEriC5vsxikNW?=
 =?us-ascii?Q?Y+i25Gy6wESgqFn12VAG6hFC4o2AySORwA/zidStE9Tpu0OEvhs38f9TAqO0?=
 =?us-ascii?Q?+Sw3QA4B1BBqr7T6GrvBzHObBMVrGD3i7xjJ41jgm7Lbb+GTPeLbXpMMwoU4?=
 =?us-ascii?Q?4xKQkdLXOpyqWmRZKc0Sk1YIaIe0JGpFRNAUsFG4HVHaVHBFWWRBuik/xqlj?=
 =?us-ascii?Q?XZhXtJgS/RndZMJbAkknNe5tHPOEsjH9V9LywgzyZHcatE2RcgHNHmXzN5Hu?=
 =?us-ascii?Q?e+Hph3Az+lEA9fIZVZwuexVVZLNj6Fp4nBWYcaaZc8Cd+LbZxdqjWE85o0Q4?=
 =?us-ascii?Q?A/gno1onA5plNqBGEvxhlGyV/ixMKbwjsjP6EA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a549ac5a-8928-45d5-52d5-08db43da2312
X-MS-Exchange-CrossTenant-AuthSource: KL1PR01MB5448.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2023 09:07:17.5956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code,should not modify its logic.

Fixes: 761b5c30c206 ("gpio: mmio: replace open-coded for_each_set_bit()")
Signed-off-by: Yan Wang <rk.code@outlook.com>
---
 drivers/gpio/gpio-mmio.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index d9dff3dc92ae..c2347ef3a4df 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -271,10 +271,14 @@ static void bgpio_multiple_get_masks(struct gpio_chip *gc,
 	*clear_mask = 0;
 
 	for_each_set_bit(i, mask, gc->bgpio_bits) {
-		if (test_bit(i, bits))
-			*set_mask |= bgpio_line2mask(gc, i);
-		else
-			*clear_mask |= bgpio_line2mask(gc, i);
+		if (*mask == 0)
+			break;
+		if (__test_and_clear_bit(i, mask)) {
+			if (test_bit(i, bits))
+				*set_mask |= bgpio_line2mask(gc, i);
+			else
+				*clear_mask |= bgpio_line2mask(gc, i);
+		}
 	}
 }
 
-- 
2.17.1

