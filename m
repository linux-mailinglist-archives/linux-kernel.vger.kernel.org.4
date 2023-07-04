Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E88747056
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjGDMCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjGDMCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:02:36 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AE3185;
        Tue,  4 Jul 2023 05:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DU8JostUpxQcHE4oHnXLD/5KIHznhCGumBvQxIlk9vqpxXEVwdG5Nf1o6GVj+T7B+TVDdXSuCQa/+r6wCqtQ9DjEL+LFzVZs47jGaq1aIXXKuM5uZOKNLZ/2ACUAqR0vBZLKcoGh4cqaXv4JSlm0jb6x5kxrm3rPJo4ixuumN5OEyRHzGTdG5ZwLgMXm8B7rXSWt0oOTTnI2JrD2fM4yPHJtwCpaTIusYLQuHpgojDOYYC7hl3ONV5rKDXhNFolWvg5OAIBDmKo5mCizAhOjdGfXmGjlRr7nV7RhKcxr5SmO+AKFV89+YoxuWmAFFV4Sec060GpMQqKbZZdJFg9OzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhG4llVftO1x0Ld2SMu4e8/f9ZgjjSIerDolXPVi2wA=;
 b=k+CQU+BhMPUNMasUHu5FQ+qVvGCQBC5c+Ht1Fs/0Y48F4dDeEkIwLgOiIXDgiJHTSFaH2X9+XS0pbYe41kEZc63dBVD4EoPiQYKRCwd9YW6bMbU9hO9c8+KIDHVSBX72g6tEnbtxmIo47AtNoo9KrSSi4HZo/MRULtQ1V7IPlS4fTWI3fk/MJxg35JlKwPtuiqF+uBQN2R8/1l8nd3mMcktZzMKKwcedJJUTfa82ymfzfr5LNAeimvIEhdj7TOj9opFcciZVbuLSlM+FtASnuNauV7/Cd7Iu+77M83O1ioIQ4w05LOmf/lCCLpeFknq34vwTRBxm4ivEWmpLrlt4FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhG4llVftO1x0Ld2SMu4e8/f9ZgjjSIerDolXPVi2wA=;
 b=dkY6QVx9pjur46oXOyyYcx1oMImMh4khw/F1x6ZlAWAvskGYGkNtxTIei5qzpHRwCYyTSRo6uAO9ssxvxACa2yZCU9coMqXa7wrhrnRWr6NMMIIPXhd8xPgmqBvJ9O7PaIJBrnk0hySJIyrDcOGeOQc4+vcL4Z9hIlKhZDuUc5Th0U8STFx7NX0E5tB6S4uJGL1DWO3qUkSDztHlSdlKq5I5Pf6wB6wZM2mAVNhFYM2Qwl1vpbfJw7sQL4Aw7ZQ1FalzkmMy3bU0sq7ocARGaj3EdWtpD0DtiFlL5UJF6C0jY8Rjto4bML74olyFw1n1bvUXJwb3e3YrDCyEHcIyJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6052.apcprd06.prod.outlook.com (2603:1096:400:354::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 12:02:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:02:29 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] reset: qcom: Convert to devm_platform_ioremap_resource()
Date:   Tue,  4 Jul 2023 20:02:08 +0800
Message-Id: <20230704120211.38122-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704120211.38122-1-frank.li@vivo.com>
References: <20230704120211.38122-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f56b129-2f0d-4c97-385d-08db7c868a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQ9XEjR5Ds82gkHaci5Csi4YQiaahP+Wk2Jjy7KgLfQpXkD/1KN2hhhCnZ//AJhNi6Y1+cy3xZzI9Oky2NsBuHOWRCE+RZ0rUQ3YeD6CZBI34gsqWrizvy2RCKHKmrPoV/PpLm701/sRaRb63smVulTcTkpg+j5dNKX7P1DgcNdMmUSzXkIXyFi2D3fsakj8Dea2VnCZgxJmR+KGVupKs76T5StgdDS6Kd3G7R8vigpi7kq+de4OODV0rMcJCTSpvz6PSub1oJK7b/+Hhg1AlRSldsjmb4Wj3JbLvaKBFArcH//eP87mJvGWDvlRxAgJbcSTOIOWmy2obQwU0FR7hBp7EpGBG0laoP+hJhXrZQ8d0kZUNMIv5pV/BFCb4tEylcouSWcUAXX4AvDAygAH1fZpWb4mJ0+bVH8wkz4f3dMUYR5tvYOPrHlPBce5ODBDz1gFERFX64slsesXmPJED5EN2zjl+Wno7u+BwXuOyIpYPuEgyLRWcAIceAipHenb8lh84BxhJqq8lxFz41TqCA5rOAC5A8jOgIGRJ7YZktiB0nsY4ahZ6GbSVbk1mI7eBgJn20Gf4FR/EGS1wqyyv0uAgd7dTtOIREsPkoAaD+cjWDGdDD8EMGEl99OoGCCb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(5660300002)(2616005)(86362001)(8936002)(8676002)(6506007)(52116002)(110136005)(26005)(1076003)(478600001)(6666004)(6486002)(186003)(6512007)(4744005)(2906002)(38100700002)(38350700002)(83380400001)(316002)(66476007)(4326008)(36756003)(66556008)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?reMjrtTYE8YttqHp8/K892R18t6oQGqOzJopF7OGTk8CTVdOpuvdXPj8/9kP?=
 =?us-ascii?Q?o9diqBKjS+C1BjAIA76xG722lRvUqLat0XjKOjiRwpcBeTAu8Qr+XTnFGL3i?=
 =?us-ascii?Q?Lgn3hjXGUYaWix6y+S0OaciFyhtjLkj/747xIYYLEoqppVycFIieRFQ7pmvU?=
 =?us-ascii?Q?S4oWG93OYmdJCpIdvr6jYftKczoQvWVYBsfuFe7Lyrg8OiogWzSmWYfuC6aW?=
 =?us-ascii?Q?c/sw62bS5dE62NCsBE2MPNqrz1yS5PbWDbbmJu84APbPIbq/y7Xa6K8eoBB/?=
 =?us-ascii?Q?NumsCEJMF+FJHCoVrBZjB46IbamKOxwf7y8PgisUUGyaOrioMIGbu7X4mqeJ?=
 =?us-ascii?Q?hirQNsQ3eqJGYas+KWuDuEhMXatz6+n2yqelt6eKnwec0/r0bhiIDV40VxWx?=
 =?us-ascii?Q?2UxZg9uNn7zuf0gHPKzALP85wg+4N7V0kzTvbbM0WfxkCpmL/jzlvYqXjIuP?=
 =?us-ascii?Q?l50jlDvSKpdRbbAa6dlqkWx3xh5hqfB8WfzolNbzshfewt2coG7gfmYEXmnH?=
 =?us-ascii?Q?2Ahk3V/D2Wdb0kImYcEAZUA/SU4emFI9jGgnd8TPKVBZRuy5fJsOW68Qxp3V?=
 =?us-ascii?Q?otl6YcuDC72q/Yeh8itT1p500ggOibx9jLR34sGFJQog+gEmuOQVKm2xYD5S?=
 =?us-ascii?Q?VU9AmLzcDKsshZlRn0pNv5UtyY9Lhxn81gxMMV2UDT+KEekFg4T3gugxJY4V?=
 =?us-ascii?Q?YpZchNfFphHj6Jl5jgfWTzwM/urwVvINr5LDkduGszm0Q47OsPFyvW+PU2iE?=
 =?us-ascii?Q?Ctg1CoLUNmDxO5Qk6UGe0ss74s5UpyEbJmmKtfHIZgvlHdZSOpxwKfO4RY19?=
 =?us-ascii?Q?XAZi4Obti4PHiEW4v5nTZt7oNVTGWflqyO2jBVrAX27XLd0BZF4WehEq1db3?=
 =?us-ascii?Q?8vs8Zba2GCqEaxSzHFJhYNaRxGoOynPzCtiDkJ2mZMkvEwSYQWVjGHjfDUhl?=
 =?us-ascii?Q?F8ra7XUnOhKBs5DKPgJNbA7sSMyvJbEUVEWx+z9xTVKaZS+ORHQrJSNUJ1/S?=
 =?us-ascii?Q?VJ4OnPqYBT6lhr1MeW8Lxko9a8w0VuG1hyZ6ZZVdBiU9qUfA3DzBm8+XbaCd?=
 =?us-ascii?Q?JC632lAHY2IbcOGPY5uIF4efrtc2TQOmTuzR7D9nCJFHHyrSg3hbJ7I092QG?=
 =?us-ascii?Q?qwihxKkww081cwsXUMx/9+1YrIs6bNzUpX5ssLBQq1+x586bdl0zlhHqKmq1?=
 =?us-ascii?Q?mij8toJXVMloDVNvkTuDGg0MQaX+StZpElLv0Vkc8yC/LUvkaBeOiNrr3SU9?=
 =?us-ascii?Q?eAWPj0JShj1T7+n5INQQKnrXQWhrFwExgqzJHrJ6t8P4qnR+X6Zbrzg0ATHQ?=
 =?us-ascii?Q?pPRI9njqDy+l6AiQwRDuWw82OFNHgBUwLBA60WNPu8+/08gi68iDht6i4SZ6?=
 =?us-ascii?Q?T2+9PRIEjRdRHe55J9A238KOd9kjQz6tRaHnlxNZT7KTeJvbdtfXiZl9iDUP?=
 =?us-ascii?Q?So5Ef5MAqUDhCedVgwnjRf8Yt5bwDLr9VBDJEE5j1D4o2+8EN2qKdlDXSGZ0?=
 =?us-ascii?Q?4rAkfaa0lvSmsTutL64gG2zhENcaDbm85ku351n2DKm4pa0pI6vf2yypsIKT?=
 =?us-ascii?Q?M/Vz31NNs0rxEEnBVNlhXX9Be0yPIy2uuDJJK2va?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f56b129-2f0d-4c97-385d-08db7c868a84
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:02:29.7092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IxOyhQHFfaCjUOSgPd/FrW2y/jwig94dlec7VOOvwU9KcwxZGwok3EakhfIsixmoN8dTjWljl8ghHdfZmX0/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6052
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
 drivers/reset/reset-qcom-pdc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/reset/reset-qcom-pdc.c b/drivers/reset/reset-qcom-pdc.c
index f22bb49a4ac8..ab245c701590 100644
--- a/drivers/reset/reset-qcom-pdc.c
+++ b/drivers/reset/reset-qcom-pdc.c
@@ -114,7 +114,6 @@ static int qcom_pdc_reset_probe(struct platform_device *pdev)
 	struct qcom_pdc_reset_data *data;
 	struct device *dev = &pdev->dev;
 	void __iomem *base;
-	struct resource *res;
 
 	desc = device_get_match_data(&pdev->dev);
 	if (!desc)
@@ -125,8 +124,7 @@ static int qcom_pdc_reset_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	data->desc = desc;
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.39.0

