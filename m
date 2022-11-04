Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8612619E9E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiKDRYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiKDRX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:23:27 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883FC4731D;
        Fri,  4 Nov 2022 10:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewnHGpMVUtWaESLZppwQx4DACY1Z8a+1iORSbwGyTj/DtdpffobjrCuM21Tvw07rYiAE//Dh/Q6RPMRfxnjlqNCPKG9XP0lDZEiX7yZCMkzTGtTyIZWjLul8NBDq/HHUm9U1hxA2iHtcqz2TDEtki0CImgpZugXk+8clZL19PfLajKWhjnhRq0GQOViDFBRS/rSfNlzvWevnUOkcuB/nmHobaoL27oSMgdTMVWVBRAxsm3OZ5Pz8i/+xxf9LqP1ojuHVmH0bw8OF72Yx5Eee9FumsB0a2xEDyMCIGASV8vCoiDb5DBSCQKBcAebSKU9pG+XINzl6ZAtqlAjcOIcbWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lZ5t2n2MSaWX0gayeZNSpE11BjHn25Har8HX5pXVqs=;
 b=BE6R0bQUebTsQZB4LuUSQCLzlk4Mr8FYnlli/QnT9taI2FFeL1zWJBfrHTe/hqdcEYXd/Jjsj/zxS3dNqZdMJhvmngpS4t2/OcVLV57RjASqmXJWv1gIacDF4SzVFsmWGQRg1PEm01Hiy6dMyJuOduBN1vB2arA05fEsrc1XAILz3mDJv8NqDDFD/Bk7XwPXe/FrVuqhO1rMwzhlkJX4Rj0fMUQgbqBitHLSom8E2gFdn2s+qya5OtKfyQxssz3ENEc/qJuraiM1qtK00WymC9xuixgM0ljaY3f7q/qbSx/gB7Gy2ODAziaAnc/0mRAfiUae9lMD0vSOD0F9kWx6wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lZ5t2n2MSaWX0gayeZNSpE11BjHn25Har8HX5pXVqs=;
 b=Fg9O8tUydWvdVCrxXKpm180pTDZy4gsrZ74kTgz2QtOH3Huu+dIBs17V+9vS/mrW5nAdrKaWN/Yl+NLXBW+k+ly3zEoDPowmrgc21XL4yRXzSc1BszyC+2B7ipfN9Dj1fse/gEpLsEJDsUT1bdxShWra0FbGR8JKTA/mk5Rd4/eZzjonWhRompmvC8GvNDD6jwfiOCfF0P56LLAzxeKv+54l2PE2odDLh+o4hJ0/fu26vagpIn9wKyxsH6dVZKPjAKETA+FLSbKdho3m4zBQwMsQfeIrj1Q8C5vBn5H67TO1nYLqYN+DuBDW/lEgfUnJDO1ogxtEVTclvvXlAx4S2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
Received: from AS2PR08MB8808.eurprd08.prod.outlook.com (2603:10a6:20b:5f4::14)
 by PAVPR08MB8917.eurprd08.prod.outlook.com (2603:10a6:102:329::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Fri, 4 Nov
 2022 17:22:57 +0000
Received: from AS2PR08MB8808.eurprd08.prod.outlook.com
 ([fe80::70e0:3947:9bd5:39bf]) by AS2PR08MB8808.eurprd08.prod.outlook.com
 ([fe80::70e0:3947:9bd5:39bf%4]) with mapi id 15.20.5813.008; Fri, 4 Nov 2022
 17:22:56 +0000
From:   Nate Drude <nate.d@variscite.com>
To:     Andreas Klinger <ak@it-klinger.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eran.m@variscite.com, Nate Drude <nate.d@variscite.com>
Subject: [PATCH] iio: adc: hx711: remove errors during deferred probe
Date:   Fri,  4 Nov 2022 12:22:43 -0500
Message-Id: <20221104172243.1004384-1-nate.d@variscite.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:610:b3::20) To AS2PR08MB8808.eurprd08.prod.outlook.com
 (2603:10a6:20b:5f4::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8808:EE_|PAVPR08MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 94953016-fbf3-47a7-0888-08dabe8936f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HhBRRqNjC+eSxuNqWdkESZWgMxQwqTYz468bLNEq+DaZ4PZzZeczEa+6PUKRNDvjGHokeYEIPATB/ZqYpsgbrzrjtl7Z9y3X8Vjn3pptAXMF1wJX7LwFLPJguneVb2EcntULKDmrEky9+nrwvWwvQ+cmP3sFOEHwxIzziYg8oEsLpCKuFl36W8sFjSefOGBKjM6r7TY/Uo8ZGjbA2A5gkq8DNKm5ko1rXqqacf9SvEYOK1VZn8wI6vGnmpDS6zlojZCcmrlIbRQj+aoiB1vWYsj47zCkWTUXukaorogxPni0ok2Uc8csy3gCTZt5BwDRFZy60b0IZWCUPVW9ejgc0MKC4OMR8wfq+DnVG68/D9UOHGY2glFIBvVzDh9Vgs4dMuYrwCi5YTsvqlavIq18Uc3rJX3oHonh+Ydkb4V3XVWOOYYrs4QN5MfSAjnSt1VaV3wf8Fg9jebC4cMaeSpYFLCLZFQeOpHU+5e7S7K7xdf/Krl9fmXgrVWKrFPYze3HQJ9Mf+Ax6oILYj1xmzUlT0gIA8ZRccAmAXgXlLX1GzPnnsa1KD5QpCMuK8nPrlMfYwPYBVuqSxq6dBz0GyQyTED3BsVAgfXHEhDXB81WprJwJ3xOYy0PFxiq78+BBqJvnmCv2poV+V0WbSyGGzl4pi8MUPbsWztilurWzxbDfvJbC5MkwialDYx6+2CaF9T+mqU5dGfmMa6zK7TllQjhqnp98OL/TDUuKLzLOs0idwyhrN2U6cA3plLv9WYAT3bAjJM+Ac7ZqkMXkIqh3JrmkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB8808.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(136003)(346002)(39840400004)(451199015)(66946007)(478600001)(6506007)(38350700002)(6486002)(38100700002)(52116002)(4326008)(26005)(8676002)(36756003)(66556008)(83380400001)(2906002)(66476007)(186003)(1076003)(86362001)(41300700001)(5660300002)(8936002)(6512007)(6666004)(110136005)(107886003)(2616005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qQBxojgaftIT5AbbH9MsS0/q1s82uGCbtHY9oBzIJnMX8RdAkXguPjeKFBs6?=
 =?us-ascii?Q?8kn+Q3xvlhmxOIuZhAUlzg10rqaNADsw1dY0Ap1n2OLeo8Qg/yrJSd4smKNf?=
 =?us-ascii?Q?Uaz/kgmsWXUnKZ/inGMQqCvtkwAKFVN5+OVdg7hG6QyhtUGg5EuuIeXKC7YN?=
 =?us-ascii?Q?LTo9QnMsyTfp0DmOybYOgf0DxmcPZ5LRfRMI7qAK6n75SiIiqoYLnP8z50x3?=
 =?us-ascii?Q?X5eHECee69zKwFZcSuoyjnin8TK7ZWdS6QRtRSRj2ucLVf6lxoxMhsn2DAFn?=
 =?us-ascii?Q?JcFQCA3TP0kYmQDcBM7J/N7SOvq/QAahyYq9vA02LWtMVVTZtxmyryB3UvcM?=
 =?us-ascii?Q?3JoQtlHKn6wBW12yCskAXXe0jzHvmGAbUvbpGxs8RFxMFzFvhjZ7/imX+Uva?=
 =?us-ascii?Q?nC7NugRCkVN4vmIUb4tJQ6/p2Zm7Fj6591mRIy1XpQjl5keikRsFnEe2ikbJ?=
 =?us-ascii?Q?7/1P80CpDftw6AScKO18ddPypt1KlxUFRmur2L4QwiGHVlBxqOweaPybl9Cg?=
 =?us-ascii?Q?2fTI3V9Wt07tS9gcuoMON0c6W3ktnnrwfnSw457ZhGcFVHh21MN38sC6vlhh?=
 =?us-ascii?Q?3hKQyep2RIdOPELcplHp/UGv92d7Ch9eGgt0GBV7qyp3PMjs3Bp5a3z37WB+?=
 =?us-ascii?Q?oAD/wGzEW9k8E/2VPuBISKDHF+CA5SaOqfYhuf39QKNYyahNh2eU+9YWkmVd?=
 =?us-ascii?Q?IuUIg5c43kcofS71aZz7QQ82FnGizepY7giKZT7gPMgL5phR2PUt9wUHOXhR?=
 =?us-ascii?Q?wiqudYJQr0TdL5tUUjpKzwdO0LfZgkyYJ1PQy/hi2xqUfApp1vorFgv5/y/c?=
 =?us-ascii?Q?L/6Vf2T8n2qvAwtEKmkMgOj3C1ka+GMeprezXneq6Jwsxtcgk40HTQA5KuAk?=
 =?us-ascii?Q?u9V62pg2iPcYH0AQZoCBf3LzeQta65MPzP+Y2WKkY36hhrj04SM0mat2ByTH?=
 =?us-ascii?Q?ksGt08Wd2Etyz0rJ1URRutQfWUUdrUzUfdktXUII/XN64przas1cmAInVEtA?=
 =?us-ascii?Q?nD9YtydneIHqWDhQlKFvY+IjanzEGHOh16pUk5PTBczodrQx3vBzbLtpx3t5?=
 =?us-ascii?Q?P2VVT7VcbvAFmEeohETkawsiiqOfHWYcQT9jIBzoee9YU2iQEMA8oQZ+xu1N?=
 =?us-ascii?Q?kcL8wUjq+bdyurw5er9iIenn/CScUdrZabeoiJQo4M7nJAd7I4tdZ/ZRVKQO?=
 =?us-ascii?Q?SopfUuFwfdaLrXdPF8BsdrOeFddLw7vosLu4P/TeWY5aR8UgZoBRK4N+UbYP?=
 =?us-ascii?Q?3cszlNpO6cG5mTqobnFVrducTNKEYlmx4aAGrPlP3jfVYWWpi0x4+1eh0YF7?=
 =?us-ascii?Q?MHEmVHYZEDzrWSQpMvmZIIdAyQOZHZqLBn63OtcHgn0G0rZzFXdQ4aLPNW/I?=
 =?us-ascii?Q?KgoToOed/t6Hq48SQGOr4ReapFz6zoHLOtRaeVufp2gOFePrEPki0nBszqPD?=
 =?us-ascii?Q?gB5eVWuRmIiT9vr2kniGMPeNbJnU6p6x6ALu4nV90DjpZlQtvtPkGiCBYGhp?=
 =?us-ascii?Q?yePlMg2NiDLEPgc17TbFz6NqBz1Zf34m4pqJg6YnyWjCWpiogcXnCljI8A6+?=
 =?us-ascii?Q?vE1RMI4GXF2fr0clhYbu+yxnYwPgK3/yxgGAuiJL?=
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94953016-fbf3-47a7-0888-08dabe8936f3
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8808.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 17:22:56.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdbyK+nurBt0duBlqvEQmKvP+Y7wM1JH8soBxqIAm9GZaNmH2Jh19XVaAusNBFh8w8vyurco7U/76Vzx5InvKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8917
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes noisy kernel messages like "failed to sck-gpiod" or
"failed to get dout-gpiod" when the probe is deferred.

Signed-off-by: Nate Drude <nate.d@variscite.com>
---
 drivers/iio/adc/hx711.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index f7ee856a6b8b..8ba4a5b113aa 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -482,8 +482,9 @@ static int hx711_probe(struct platform_device *pdev)
 	 */
 	hx711_data->gpiod_pd_sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_LOW);
 	if (IS_ERR(hx711_data->gpiod_pd_sck)) {
-		dev_err(dev, "failed to get sck-gpiod: err=%ld\n",
-					PTR_ERR(hx711_data->gpiod_pd_sck));
+		if (PTR_ERR(hx711_data->gpiod_pd_sck) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get sck-gpiod: err=%ld\n",
+						PTR_ERR(hx711_data->gpiod_pd_sck));
 		return PTR_ERR(hx711_data->gpiod_pd_sck);
 	}
 
@@ -493,8 +494,9 @@ static int hx711_probe(struct platform_device *pdev)
 	 */
 	hx711_data->gpiod_dout = devm_gpiod_get(dev, "dout", GPIOD_IN);
 	if (IS_ERR(hx711_data->gpiod_dout)) {
-		dev_err(dev, "failed to get dout-gpiod: err=%ld\n",
-					PTR_ERR(hx711_data->gpiod_dout));
+		if (PTR_ERR(hx711_data->gpiod_dout) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get dout-gpiod: err=%ld\n",
+						PTR_ERR(hx711_data->gpiod_dout));
 		return PTR_ERR(hx711_data->gpiod_dout);
 	}
 
-- 
2.38.1

