Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A811677918
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjAWKXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjAWKXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:23:42 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2123.outbound.protection.outlook.com [40.107.215.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1211EFEA;
        Mon, 23 Jan 2023 02:23:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llMxZndJeKYd3N2t92tdQ8BXz9o0+mKjAnCnRJ/gcxdLwxQVR81UKu+JNg7MdoAN6jnUUpUK/uqxctS0squl7+NRbuLEcfigW+0kUtutDJvoSiRAsUOGRUxPf61T1HfmpFTepyX7AFfVVLgWtrMYivR0VvY3yXZw15vcrQmHZjUEyCI4xu79LCTqWrHIFor25MXb6PSPhIo9DaPYQU16OthMr4Bipl6z0g0xu7FhRmdda013pr/wNkMIlRFyit/9Sjy42n9uZNaBobHDAgIN3wYmPmkcdVTvms/fqIb6ttRHkscfv+/2r5ERGdNHRPR5dgYIUQ/JAB5XRyuzvM/Oaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfPIXQJTqPFZmXwEIbY+4sc4dJ+i9MtVHFx5MJ1S3Jc=;
 b=D5Fy00Q4zd/oOSEyKUUH2rgPZ0bJSoL8fYhXsNl4MY/grnjOqOBUhzzNnzk5z5zePz38DGlmYqgiAOAgYulap9CVjluP4E29Z5gl42Vgj4nEV/22ND9Ch9evSmwGRmGR4bVRzb3fvw7o753IX83qL+NuFduuDsungM3HwhHmd0GAOvoFToTO8Vml1S5Sxcc37teup9zI0+uft9baHvjg7VRt1yM7lJ5zY/paNpiNIwoO9aHqEteQcKI2SocmikPEq6+7Ji16kEAsT8cO+3Y5g/JDd5ft84ETLmXt6YLJpvzkTQH0d+3FRI7tdCthEI1AS78PhnRhvxXKySWrKaGBug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfPIXQJTqPFZmXwEIbY+4sc4dJ+i9MtVHFx5MJ1S3Jc=;
 b=RLJaBR4T8kr0rG55JQ4umJULNdNYE+7rSO1yrFAgLM217uC2PpBYDzjSZBXqidCSVc8l4vibuuA9XM8a5QwaKT8lLntKv8rfzM6szJuzqXzp04V5wjkP5gH3SH85qYo2V2p0OZ7S4WNcIUyn6gkAygwISxgbvjJ+mZw08S4rW7WvY5GL7mXpfwt8nqIkQCvvrVhZt9/qjamqEtivBMyVcIdAH4u4s94fJJx97hlPWaIvezWYDqYoNYDzPxYxZqvYKBmdbBCrUFe+gjLUdSSvKVykmIAwlhKqpF4zucXFdAZrMEgNyagSMeskI4dJ649Tll8PB+wXc1XTd2kNQrt1Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.14; Mon, 23 Jan
 2023 10:23:37 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%4]) with mapi id 15.20.6043.016; Mon, 23 Jan 2023
 10:23:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     anarsoul@gmail.com, tiny.windzz@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] thermal: sun8i: convert to use macro
Date:   Mon, 23 Jan 2023 18:23:19 +0800
Message-Id: <20230123102319.37710-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: d318db83-5b97-40dc-3006-08dafd2be3c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YfB8eEqCCp00uARRGk5dMUlYRDvChms+ixJHFKvCOWCIfdKZ+SC1Dm2dhGL4v7XGJF1K5KuteTnn1HPQkt2EOZFcdN/lr5DyXAhPz4MUyqqo73MRxaFl/A0nDMsy16S8jp9Sx1U/OCz3jCrdLmjYA4rLaTPwSwsoVsd+JrluuR8Azu6R+UKxzrPRzE6GXJztA410fi3yukNtbB6kYl+1NwWDciH2UKydismtSqPgqTmDxjtfDka7CqFEuwaGmScLprqXDFbyXLUWdoiE75KglIYIw/OyESXemn9BEXR5E0ipdetPB3bs3WVWsuZjWfEzUDGXVuSpipHgFrmxwAsVCTjucrropjN+JIq33DG3VzymMKKcMxnneK2rt6JbwuVC++sSWEpFNbq+RQC56+KBNFQXTmgIUOHCjWaUidX1JinkK1f+cOO8ONBgCiI0pHfZf8M5zGL1e7lgeudaK8cz63iq13r5oS/qIa91fjmpq0e2sMe08Qhx5pNGmy/rBGuL0kLR3Jjh0tu8D/Kh+4dSkzDXRRATF1cCU/W7GwynaVmcLdaalUlBhGEmRO4w5Uy+st7OzdtwRwV8Erumcef7dmNTS9VcrYNwU2FGwhRkDCnPVIRmeeS+VGjxd/KM56VthujduyUy8kg50f/xl6EzidkGzXY87qW/Wck003gIyHkyFWes4eZGkQ6rXHbtvcwbWm/4mooAX1HcxIrILRtznvU4sCcFBXVfcAhaHsrPRLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199015)(478600001)(52116002)(6512007)(2616005)(6506007)(8676002)(4326008)(186003)(26005)(1076003)(6486002)(316002)(66946007)(66556008)(66476007)(41300700001)(83380400001)(8936002)(4744005)(7416002)(2906002)(5660300002)(38350700002)(38100700002)(107886003)(86362001)(6666004)(36756003)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u166rnaFs92fUNIhmMUwFle2NFkqImjfrQl0jtrOaatmMA1fILVSk2+RNCn4?=
 =?us-ascii?Q?NPcTdk4dPSgAU70+hnaQxXCcYIwW8gSrZhdA1PIgAfIhMGZHhNHDRUvyNb92?=
 =?us-ascii?Q?j1kOGqCwWIvRCEqA1gLhIntpQ70zu6nPzEUfWeMALGQvkIZm3UDRNLcxkxiy?=
 =?us-ascii?Q?IxmhQMdCFI3CTOR397h0t8S0DV5mTscwomloyGcCoPz1Vw2dExc7JK1Yr+qf?=
 =?us-ascii?Q?c6e5NGYqJmARP3nX0vGbuHwvbGZSR9mpY0OKgxwCY6MuKT3i2iLRuFoOscqW?=
 =?us-ascii?Q?HN8M7aDBObEFHS4zg7WoFpi3yNvhX3+c1uEPk7+n6/NmycTWilJ4hN0ySEm/?=
 =?us-ascii?Q?ymI/NXXhvLOwQxYwk2v0NRx0wG5+//Ylgyf8RFS43vBWT0458QfD+4zgXCn/?=
 =?us-ascii?Q?pKzeld1hFNI3XAnP59AS7bl/yN6sSw8R9vItqMFlWT1UYII929zHUkgS/FuY?=
 =?us-ascii?Q?pNhl8wUCXWsQ4ZR0hbWtJArWnQoauw61TB4YkgzMb3NMzIxETxv9AJrEXt+D?=
 =?us-ascii?Q?Du3+H8Cgsl6RDHDPQdWA2py4IOmpk/rmr3+LiA9pd5/IMMorGGR17OCVQ2AO?=
 =?us-ascii?Q?ez9d4IRc961RXg+b2aUlh5uXv4J7nUWQJ0YlrGQdL2fnK9o1Fmmp/lJimxRL?=
 =?us-ascii?Q?4AtM2evTZWuSAQjG0N0GYyYr/tSQwBQNyksknmm1oQV0iX3Zdv1ijiPvgeYm?=
 =?us-ascii?Q?gHEtkiC439Il7nOQCtMSvM65KwdEUMTFLZu4NcMs/N7Yq6OD8DfHlX/+HjHR?=
 =?us-ascii?Q?1xJgYGvWwMKkIH7/1jncheJuHyj1mTVOJ/vkFuDogSsEUy/o3YGZnfTE4RXu?=
 =?us-ascii?Q?KHcVyaEOE8tsu7Mn9qCotF1uD6rbBQzNbWFs3oNZXhOD0/aZPdugB3/lS1su?=
 =?us-ascii?Q?klvFoKCl9ABpnArNH0Jts5oYljlP3fhoVFmukRma9LVUG3a+q12oNSQzIMmx?=
 =?us-ascii?Q?/5CBwmkrHN8Agxj9gNjROwTSWJGDmmv82Wk8V1VK1nepW6JxmeBP9LoWhyP0?=
 =?us-ascii?Q?+teizhF0ur3uAJjIyhaRpEXo02qzrR8Jfz0dNzhzJzQTwe07BKW3CieyZ/jS?=
 =?us-ascii?Q?Xsigpr8SFwCXVx17yL15iWoNx9p2i+HNa9/vcFW6fvcUjXPGoNJewHPP1ADz?=
 =?us-ascii?Q?cezurge69ph0vfa9HoZjRezibW1BKDHA5kB5KvIAz+QD5zPkDzt8wwwp1Lcu?=
 =?us-ascii?Q?XW1rS1DQy0RUszI/LwxvYRCRXGZSROIPd0ua5r26qABjM8vVqQ5H+P40THln?=
 =?us-ascii?Q?Ren8CCKQd9YXwM3NCNrIjOaYGzRot1AO++pjf56jujCkxTY4DOmcVH4dPNGu?=
 =?us-ascii?Q?UWHYjyPijkr8ifpDPwI3pTqRf0sBekgi8oqf78Nppxy6YBC+lKNgc1FS8FGy?=
 =?us-ascii?Q?2+8kzvjuqBltPbOf8BY4PpVV30beARwK+DXLDEqqmlPRas7PxdDZ/6jhzFNY?=
 =?us-ascii?Q?3Co7xb0fMX0wwaelLvAlM9YUk7k/fg/uDRWCqJ+ftVU1e1SiOGrIcX9TpjX0?=
 =?us-ascii?Q?7KsXOH9wAN6IsNqw3M7kL5fGV2ocFHFOnlGZtUxRXoNPou9srBBpRTVBL3fs?=
 =?us-ascii?Q?cyg78uIx0Iqm1stVrFQgQhwsOaISavWvw5MMA6vY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d318db83-5b97-40dc-3006-08dafd2be3c8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 10:23:37.5502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+fUgiCtx2zJgQcTOQLy0UyvkzCJTdu1InE9vADiOC0tgJhMEX4kaM/NUox93lRKfVlAdZzTD3PNZrLd/kVphQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4324
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use TEMP_CALIB_MASK macro instead of raw number.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/sun8i_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index e64d06d1328c..497beac63e5d 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -210,7 +210,7 @@ static int sun8i_h3_ths_calibrate(struct ths_device *tmdev,
 
 		regmap_update_bits(tmdev->regmap,
 				   SUN8I_THS_TEMP_CALIB + (4 * (i >> 1)),
-				   0xfff << offset,
+				   TEMP_CALIB_MASK << offset,
 				   caldata[i] << offset);
 	}
 
@@ -271,7 +271,7 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 		offset = (i % 2) * 16;
 		regmap_update_bits(tmdev->regmap,
 				   SUN50I_H6_THS_TEMP_CALIB + (i / 2 * 4),
-				   0xfff << offset,
+				   TEMP_CALIB_MASK << offset,
 				   cdata << offset);
 	}
 
-- 
2.25.1

