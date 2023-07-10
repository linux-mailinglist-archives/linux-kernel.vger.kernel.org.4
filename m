Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525CD74D2A1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjGJKCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjGJKCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:02:04 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7304626B6;
        Mon, 10 Jul 2023 03:00:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jm0IbutqUg4meYIGi8puRNO4x71nRzYLZUW8esomc8A2vFj/JcXiOHANDLoPzEwuA3uYh53to3kqIz0J+vNS8mvuP6PWMX2lYodFSCETgIc8pQ9pfQKx7Jk2fc/DGQV3BGt+665mnfMuZt7oED8HKI3EEVawkQVgQ+YPao2jXzznafvBFPRv+AiTPkcGPoo+IZxoPyDlOjR2XqIZj9WmMPTsdBb2jqXmsrDTbVs9xpEMLYaTTx4wrl0jZBYlpOjMLcuhRBg1lrjwhM2huFoz/ZOzaB+ZK4fNk0Vv7mZZIOxoPqNgIV1DuDFRF+zDFl9Nmxt9rqgrUhOgLWQL+jb3nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNQY+M8646iviKgkJhuurqleLIh9tBVfZXn3ABuGKro=;
 b=jJw9ob0jZoUjHFyZnu9y9LOmpjYWIVPsJC+AY3Lr/KQxVEgp8q4RpesPRBzY0btoY1XEmahoR1BKbTcKB6DBRLcYBy24VLVHymi9xjETO/pZzGCh13ii3SBjFVgV25t7tDo1Jz47wJEpg8mfOnEcBiHDLfFRiNaJD2gA/vGn7SUp03cEz7FLM0dFsnEdCUAZxicyXWariP6Int/V40fWlS8uH8kOjU1wFZ4QGsQnciPI76/SbHBCP7e0TzDbi0bCuKwKt5JjPbEgYv62HJxvGKNPv445fcCFlIZOOewMR+x/HzAXvkOlDjIzJgk/XuMK4EWmosKEF89Q8QJiSkkp9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNQY+M8646iviKgkJhuurqleLIh9tBVfZXn3ABuGKro=;
 b=PAaa8LXn9+GuiIohtYbPgXfvEZpWH+scQ/FqQg0T3VYw/GpSslJMPY0CHt5/rXOHraR9ogCHXPaT9cEmrmP+oiIBgxIRiIjbADXQHcZzb8LJOGI2OyLRmVyLZmPZbTgUX1TO4O/HR6Pdvrpqp+Jj/PqomTwkl15pFoNjbJBvPWmdxefgM/opL482uu2+ULxgjmr4tLc336OQklozsO0b/j7g3CvAl480Vqrf66bwf+SK7lSaFT6jHN8VAc3twEWmiVf2nYo2kknw5Pf34HtDWLgYtNydrI50YaVlBHNSex+1C1Q+IwJuXMLk2JQD6SU3ZKYwk9jtMvvjS2tIcpQEpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3963.apcprd06.prod.outlook.com (2603:1096:4:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 09:59:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 09:59:42 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/21] thermal/drivers/sun8i: convert to use devm_request*_irq_probe()
Date:   Mon, 10 Jul 2023 17:59:06 +0800
Message-Id: <20230710095926.15614-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230710095926.15614-1-frank.li@vivo.com>
References: <20230710095926.15614-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0167.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB3963:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e67ee2-d5be-4d2e-1e89-08db812c61a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9MgY98Xvf3bmpRH066PloCXVc/aTi4r1DIDk82Xt7EfBVeYKKCpSLam6k9GBL3Md48kGJF6quz/A7GqmPfANu7yRnQ0+apbsZcDCvlin8DFFAT9o4q/KvJsgL7hsodfnYLc9pn0aXl/cpTpgi0CvBM34yKTaXvGqq3604Kblp2WUPI4KZuDn/B5czlLNIFEOjTjuEH81Hcl9SFg7F/ze12SkQQKrPtQ2Lc8Tzd79ji0JbnWTLs/yCZktPMwBUyPScNJdxTc4kSf+nQ0N+H22tFY2RfNYhNnN9r/JQVzW0lCxqFBmA0HHDNLxab0fJNyumUA5qVp465HIDm9MRJh0JDUSP1hW4u1jOaCJuSz8neVhq79RPD0UeeGr3zKPozJ486QmI65kW2Gn/fxay7lDixRiSPj9kFLbdibWMKhzI3Ilg+qmnK7rCw41VT77swMzEdbzLax7FnEjqO7dyWqRjU/2srBxwq14zz0Hp6MuQV+XkDSHjPHUsiMNsfI8WkEl29gNSjLtibrsTBBB2m22WBZR8mZlml3bpR0wubDDT3OO+IaNIoK6ncLF7dL0bjqgItRLZFHizkwvhGXHGYrQ2WBcZWKFEBfhka+dqPMx4v3eVYcFHePTA+KuoYNBamr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199021)(86362001)(38100700002)(38350700002)(36756003)(6666004)(6486002)(52116002)(110136005)(54906003)(6506007)(26005)(186003)(1076003)(6512007)(2616005)(7416002)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(66574015)(83380400001)(4326008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkwyNjB6dFpwTzNSa1B0bU5lRS8vWFFGVER2dlJwUEZGNFRqVDBNSEZCTXJG?=
 =?utf-8?B?eVlwa0d5c3dIb3U0dmFOb1JTNmZ1c3NFVWZ2eXhsY2VqQkhUb1ZiT1o4eDho?=
 =?utf-8?B?ZW1UakVwZW0rb1c3N1U2Ry9xVWlGak8xUHc0NWFRSEJLRDFSNmozMjFZTGx6?=
 =?utf-8?B?U1pZcEx1ZWMvMFRLRnhtUmtiOFJnQWp0eG1tdy95ZU5ra3hDSDd0RFpISTlV?=
 =?utf-8?B?Zko1SlUrMUU5TkpvL2w4T3MvQmowd1o1ajBvTTNybFRlWk1wNDFhV1ZJZC9J?=
 =?utf-8?B?cUFEb2NpQXcxUm0yMlFqSlU3TVhCVEZOUngrc2I0dzU2VUc3TXJLQ2ZPR3lz?=
 =?utf-8?B?TE51TDYxV2gxR2ZPRStoU1NpN0h2UjN6MjA5MEd3UGwxS3pYM1hLYXVNYVpE?=
 =?utf-8?B?VWJ5Y2hiejh6dmVBMmNUZnZNdGxadUxickg4c3N4WW1ldkloTGF5QmRDWEdS?=
 =?utf-8?B?L08yQzV1TlJSZlVocjNGSVA4SzQ5UkFTWlNPemIrQkFLVGhIU2RXdGZiVjZL?=
 =?utf-8?B?UG1jQlNpNytvUEVIQzZ4WW5ia25PUjdqRnVQK2NONDlWR2pzWUgxZllMaUZp?=
 =?utf-8?B?Tmg1Z0J1VFYxekl3eXQvQWREczJMLzZsZjRkOXIvZHRLdWlIZWR1T0tIOTZo?=
 =?utf-8?B?MHR1aDVUb3I5ZnJWOFRjcG93WGFEOTNSamdwNGRyMGIrZGhPcnpQYXgycW9T?=
 =?utf-8?B?U2xJMGIzWmc5NUZPNmEwU3NYSHRWTnRTdnZXcS84OUx0Zm03Sy9Oek51d2hT?=
 =?utf-8?B?R3lZN2lhb2I4bVp5a3NTU2VicW5HNHNnT2tydDdqQjBTQ1JUeXlEcUhQcjJ4?=
 =?utf-8?B?SER4S0VOd2pETWs4Q2xhRXcyTVhwOUU0aUdVNFExM2cyM242bENYemI1K1ZL?=
 =?utf-8?B?MTdCZml1V2tIaGVqaWgvZ1dwNm0vZzE3NTFTeWR5MHU2b2ZxWHRkNDBQZEQr?=
 =?utf-8?B?N1AwbDZSdlBHMkZQUTFTNE55aFBMQVROMzVBeHdjNFRsNHEvTm5rUW1oZ081?=
 =?utf-8?B?Vm15NjVpeWdIZlRaTkxvSy84OXdadXB6djBJOWdKcUlaenFyWitTVHRKcEtr?=
 =?utf-8?B?emNraDRVOXBFRlBOcWpBQ0l6ekJVZEJGcE1UMnE3b0Q0eWVoRnZpTXNyNUd0?=
 =?utf-8?B?Ti9DSWN5NWpXZXhBWFFiUVU5Z2hlVTM3OEVBYXNOL1dvMVVmc1hCRHdodE5C?=
 =?utf-8?B?UUVsUzBSa1V3STJyMmdnMTV6RkttcXhzZzg3bldubEVUNjN3NStYcXVpUkg1?=
 =?utf-8?B?WEoxb3FHMzI1YWdYMVcwYUNHdlZ4dC9KVWM5c04wQUJGdWtnN0tNNzkxQTBt?=
 =?utf-8?B?RW1XVHdSWVBBenFFdFlRcElqd0ZKenFmYStCMEJCbkhlUWt1KzJiTXQ3ajVJ?=
 =?utf-8?B?K3NpQ05SSi9XcWJBM2F2NStpRE5jaUY4eENVcTR5d3pUUHdGaTRZVU5ZZnB0?=
 =?utf-8?B?OVliMHJhZW0zV0svbWs4N2JkblA2dmNDVE5uYWdwdzdNQmxMeHdmSnROWElB?=
 =?utf-8?B?Z1FDSWFDRjJGMFlReTU1YWdGNkVLOXNMZjNpR25USjlrTUVHcng5QkRXZTda?=
 =?utf-8?B?V1V2czBDWWFJb1pvd241QmtjVHZWQW9uRGVsWmZTMDZlOWZEeGpVM0lob0Ra?=
 =?utf-8?B?RlBRbkFzY2RncU9hS2ZVN1VjWEtiY0xMNG4rWnFrdUZMQnB3OXZ1LytuYXl1?=
 =?utf-8?B?ZmZmN0ZFS21YMUxTUlE4S1pqYWVEQlh3amJqQm9mb0FodWhmN2tFaEFRL2Jt?=
 =?utf-8?B?T0ZpbEJPakJXcTV6ZmxPQ0hKc1lyaGF0dzVqKzlMeEdndG02amZlMEZ2VFls?=
 =?utf-8?B?TXJGQ2RwdTV4eVlwZnF2RGt2OWE0SjFMbDZmbGY2VUY3bXUvSUpFdFZBT1h2?=
 =?utf-8?B?OThKNGVCWHl4TmM1WENlOGVkdk9kMmlDN09OWWdkVnNGdk82S1Nkc0cwYjFp?=
 =?utf-8?B?NmJwNHpZMElGVWpJbDF5Z1NrcnZsT05jWk16SDU1bGh1TzFYOW9lQ2JKQVJU?=
 =?utf-8?B?WlNFTmh0cThLM3Jzd3cwZk9hOCtJUmNnVWJOU3pBQW5QUnJuNlppTVhyUGd1?=
 =?utf-8?B?d1ZIL3kxMWI3Q3YyMDJIazVRWE1UYjNtaTVERG9wN1dLNkpTYUZ5aGRlUUxM?=
 =?utf-8?Q?M06WLnJwRgvnvJ3VmPFiMiUti?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e67ee2-d5be-4d2e-1e89-08db812c61a3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 09:59:42.0657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYpUdDD5ef3C27UvlB9hX7fo1lzj6lz64Q/8OWPM1nrWjeizx+hX9OfMsHDqAZRvl0+doGVH2z9s0V4/b5S/xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more than 700 calls to devm_request_threaded_irq method and
more than 1000 calls to devm_request_irq method. Most drivers only
request one interrupt resource, and these error messages are basically
the same. If error messages are printed everywhere, more than 2000 lines
of code can be saved by removing the msg in the driver.

And tglx point out that:

  If we actually look at the call sites of
  devm_request_threaded_irq() then the vast majority of them print more or
  less lousy error messages. A quick grep/sed/awk/sort/uniq revealed

     519 messages total (there are probably more)

     352 unique messages

     323 unique messages after lower casing

         Those 323 are mostly just variants of the same patterns with
         slight modifications in formatting and information provided.

     186 of these messages do not deliver any useful information,
         e.g. "no irq", "

     The most useful one of all is: "could request wakeup irq: %d"

  So there is certainly an argument to be made that this particular
  function should print a well formatted and informative error message.

  It's not a general allocator like kmalloc(). It's specialized and in the
  vast majority of cases failing to request the interrupt causes the
  device probe to fail. So having proper and consistent information why
  the device cannot be used _is_ useful.

So convert to use devm_request*_irq_probe() API, which ensure that all
error handling branches print error information.

In this way, when this function fails, the upper-layer functions can
directly return an error code without missing debugging information.
Otherwise, the error message will be printed redundantly or missing.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/sun8i_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 195f3c5d0b38..a952804ff993 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -512,9 +512,9 @@ static int sun8i_ths_probe(struct platform_device *pdev)
 	 * registered yet, we deffer the registration of the interrupt to
 	 * the end.
 	 */
-	ret = devm_request_threaded_irq(dev, irq, NULL,
-					sun8i_irq_thread,
-					IRQF_ONESHOT, "ths", tmdev);
+	ret = devm_request_threaded_irq_probe(dev, irq, NULL,
+					      sun8i_irq_thread,
+					      IRQF_ONESHOT, "ths", tmdev, NULL);
 	if (ret)
 		return ret;
 
-- 
2.39.0

