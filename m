Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B29D74E512
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjGKDEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjGKDDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:03:42 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20707.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::707])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FD41708
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:02:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qqw7thCY/U5xpeXj0IiPHQassdwpG0ScXq1dStSWLhai8lf4jAzq7SZvMi8MQ/8vuNa9jtqrilMV/m+bvJWuv1EpF397/ZFJJPGBqwvQ6UGfQkDKkBCGlGAty3yyuvx55kE+7zG9rjRJ+xwEycMdWIJ8SyddBt1iBKtVLPaRMpi3fX2UDPXIicGXu0Ku1XbQ7Y2Nsfme+jlLOF375bw+jbG2wiu1EM50L+NM13VOQZ5meBhT6QSO6HQrhXOE5PNvaC64JsA3hvPrW521RSoCGC7dSWC2bGeW15YmuCSIWPXiuw799EkrKnMBm2kunV6tSpsRVtO5aUZt79mmL/fW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkoDr5p3Q2GpbE+ldBIM9jWwOcHaM1WPRPzATLmcRTE=;
 b=E1Xbz7kyoX8f1inwk0MNL7raMnFJmr3OY2LRL1Au+D+eBc6ilXhqq8rebgJWQXk3LQEn5xLpPml4CZxzRdPKpg6cBmjFvuxKPyarKPQL9ATxIVb0yubTnvUiLorIqfQI5nVVoRHOBe2KEQFRdEvOpan8Zmm+EPrzXZKBuBaXPal1eP9mTxhMVJmst/BevvbKlfjqooOx42YB+dP55M13j/uoceYNfqel17zuJpVsZBpclLMJxt6S7hdyokJjrCjaH6M2PU4+s5Gpu9mrnqRtp2s27EEz2GvhGx7CuSRejyl1eOGEky86bsV1WfBqWi7GpXaVKBTi5f2WazxpCTElJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkoDr5p3Q2GpbE+ldBIM9jWwOcHaM1WPRPzATLmcRTE=;
 b=nzZnIIiT4X+WEqVMb/jmotrM2RTqZjTYnCzC4oCgP7NOUO/PqbP3zNPybWyycZUK6OBiFShgJ96Na6MmvnfDpLL6jbjzNuOs3tP+fCQQjIHB58TG+j9X+3EUAuTYJzSSZqDHdRFwPf/ufwPlBdsovaBGUJ2IQvVsdp2wElyaQWjLOs1V4bgkhMe9/7RY5bhp8KYl9wMc4fQh+QeEZguYp+IiT9qGkx5BxaeHvlsGEz9O+fzRBfIJ3SzZsx4PMmY9s/bt7YUB0slVy8sK0mFiM7hD32lozjkMKqq964evLlGLwf8fSlW7cpEAzSZLYxnzMJx4CbZ0i3NdhTTo7aiDhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB6332.apcprd06.prod.outlook.com (2603:1096:101:123::11)
 by JH0PR06MB6416.apcprd06.prod.outlook.com (2603:1096:990:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 03:02:19 +0000
Received: from SEZPR06MB6332.apcprd06.prod.outlook.com
 ([fe80::2f66:60bb:c980:cd55]) by SEZPR06MB6332.apcprd06.prod.outlook.com
 ([fe80::2f66:60bb:c980:cd55%6]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 03:02:18 +0000
From:   ying zuxin <yingzuxin@vivo.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org (open list:POSIX CLOCKS and TIMERS)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com,
        ying zuxin <yingzuxin@vivo.com>
Subject: [PATCH] time/hrtimer: Use hrtimer_is_queued instead of accessingtimer bits directly
Date:   Tue, 11 Jul 2023 11:01:49 +0800
Message-Id: <20230711030149.55143-1-yingzuxin@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0085.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::8) To SEZPR06MB6332.apcprd06.prod.outlook.com
 (2603:1096:101:123::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6332:EE_|JH0PR06MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 309e4b76-ebf2-4570-b965-08db81bb3cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7M/Rt22S1u797j7yr0J4myOynJViHhOiEgR7A/ylN+X+GuwC5uN1qLfP+0XY1id85qXoVQYFGJWZjijJSsC2wP2n/vQX3lvh/6PwvO7nt/I5K5TVMXFzKhkpEbwiMWmZJGlWiMJkWnxsAaG1iueSHyZUu+Xwy3d2EEe6PNJ3CR/RM9FPL968CU2V0lZLL2nhsbbMPMlPm2tZe60S+selXjOe91xNK0nIBT6/utFW4BOantztTmIOWuaw/E+KfTEAuzCOLVz2htBrsRjkSmPMm3xXH+pHmLVBBCW9+Uh2dnTUqF50TUvfBBf/5MjqS+zQXqaefEOUEb74fs/ubztUyFh31CtH+KeiluN0xxN4DR1/6mwIeKeg5f7q+5kD2D8oDVWmeo6MaD5biQo8EkSoiaJ2HLfUA00EvhIlBX/xUx2I0bksmqIJZ2RJIE5F/EyeMdW1VoalsQGgpqSQmO94FnhycsqkWjbmikG/I7N6Bpo4272Oh8wfYInL9pWIOm81nAEKWY3WiqOb1HOw58ZWhOnM0/9DkEzHgQ7yXfiJZBmsXNIhq/cCXAxvAyyikqU8QFfo53p+yOQJTJT2lSn7M1UxjJmKpdW0V8cTv3dOjqxwm1MvSp0exCy+/sXHtke
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB6332.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199021)(86362001)(5660300002)(8936002)(8676002)(41300700001)(38100700002)(4744005)(316002)(2906002)(66476007)(4326008)(66946007)(66556008)(38350700002)(66899021)(83380400001)(6666004)(6486002)(478600001)(52116002)(1076003)(26005)(186003)(2616005)(6506007)(107886003)(36756003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5p3iNp6546e/wWgSFFb0EeX8LSo7nPPSxmbpF18b9sZWKHgthZNkBXuloWd3?=
 =?us-ascii?Q?QHGpqxYLNXZKTpSdI9R8Xib+SaRv0OV5Jf2VC6fCkfqkx0T6sioLlQkSpHvP?=
 =?us-ascii?Q?V+iLxdOnPpX09SZ2uaM9leOdjqMoafe5ya5cPYsR2Y64o7XRVeCRc2Ty33tP?=
 =?us-ascii?Q?SSogcxOEr4jnXMh7G3sJ2MPWcOSXwrZEtBKsopLRW4qfMaPgDAC16sXa5OF+?=
 =?us-ascii?Q?V2qvSQa1Ft9N3AUYzmWS2hQ35DnUpOfNC43lq4AMyOHR3cbFAtIb/v6mtZ/o?=
 =?us-ascii?Q?qoNSYQIQaODghzKG7TiJzVKvbXtnDNpzb9EERn6GUYX22UbSwDbyna6ZntqA?=
 =?us-ascii?Q?6YvK65lWk2QGt9lk4o9VeNmhOODFx58xPLgcPlFH5vNZyKiUcHfxvzMXceze?=
 =?us-ascii?Q?UiDcwQwrT9jUmjpv0CaX9Zwg2GiYQbpXpsuxmpNAkneQacLBDekZBDQTyaq8?=
 =?us-ascii?Q?9XA1vsIgTl6MJW/PeFjzWKwEz+06f3SMa5gbLe9CDY4InoGp2qezgyDx/NPn?=
 =?us-ascii?Q?kqwPMLiGYqM/807rgCH4IzdeEMhghesc63ARY6akIUPw+osqZuK8cmaQeoei?=
 =?us-ascii?Q?3WHp4nGNMl1I5CHmVU58aSmnW1SpCMtbUB250/CiM1m7Lg3XgLXRFyIToEbg?=
 =?us-ascii?Q?Mug3SIL/VgS6wGxrY9nq67tOLDOBZdGnV5DIyMF9qqi/IeGqh5sjm/xeCl+0?=
 =?us-ascii?Q?w+wndhRhGwNeGRIxd/gKOTLqqY3/uWZEVRJ7KCSe38BTCMBqf7sYKC6rdrxe?=
 =?us-ascii?Q?b0RKDOgIzEFPvohZlsIH4RGhtFXPu1U8Crwh6Ces7GQY6imhKRLumbs2eA/G?=
 =?us-ascii?Q?4nGqAC0xzelWDyV5PAe0fzAXtRCY462PC/UpjZtNEdFJaVm73UaPSb+zSQ0m?=
 =?us-ascii?Q?mJ+pLsLloXbiXETzAJ7PNO2xDprDHSEsmE81W6pTc9V5JuHSeVQednZ7EyOm?=
 =?us-ascii?Q?TTQqh7gc/5XCYTcEKuCIkMpYpE9CeYK82xJkj7ERvQ2ZTNbQY3d7GhidaS51?=
 =?us-ascii?Q?QZZlP1TXHJ+UbE7Lv2GO2rc7u19DCzJUHQRvtqWwG2gkDRE3xTjItKTAE8KM?=
 =?us-ascii?Q?9kz+4ecoaPbCOj0k6Tsa+yFAg7ye6Lr+4p7eCNP26NxzyBi7hOwsbPl2khMv?=
 =?us-ascii?Q?zsFkgn3a4CQGRZDrhDLFuz0u0dp4U2J+1umPXTpO202KRXd3LD2YfHZt/STM?=
 =?us-ascii?Q?mEfTTieNJjL7bx+0tJCe9s2CgH2uxSEP/iv8GTQSyT4+jAYrEWWCaVLnBwL0?=
 =?us-ascii?Q?wErjwZN9Q01a60XzPrCtygBT3fUyFdAvLNyIdwVyCs7L8gFQ2H9jJDxulLDu?=
 =?us-ascii?Q?gmWBmYD3M1dCu+WPm9BeaozeMXM2A0lmV9CuKnktE3lNh1D2NXXkKvkczD70?=
 =?us-ascii?Q?UZfmMd2B9zZnuc/6VcobJIF4428Bma3NFGjLTj1+v9Mxf5ZwEyTA1pAgD4ey?=
 =?us-ascii?Q?yt2+6LEOB/cGYl8nfeVSGb3jw8eBWX9V23JaJMIsAAPr/yqpBNI5cQRr9Giv?=
 =?us-ascii?Q?WZF7Bib9zOhy5t1qVpUwSKWUUbWsNEpvqht5SV9ISIKe2QMLRkzkGMPJO44x?=
 =?us-ascii?Q?xFHsNpBbvI51vpJ1qz4Ph6VHj3CjTLV3b5GUutcI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309e4b76-ebf2-4570-b965-08db81bb3cb6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6332.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 03:02:18.2715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IGwPTSPCUsEysqdrCPAcAHSi6wFN04Doh27ujH8MZeqO+EHja/Z91+HDL2u7ARmV6t1jO2mseH7E8x0D74TUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6416
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hrtimer_is_queued() offers an atomic method to check
whether the timer is on one of the queues, so there is no need
to access the timer bits directly.

Signed-off-by: ying zuxin <yingzuxin@vivo.com>
---
 kernel/time/hrtimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 238262e4aba7..9ffc54fe58dd 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1047,7 +1047,7 @@ u64 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval)
 	if (delta < 0)
 		return 0;
 
-	if (WARN_ON(timer->state & HRTIMER_STATE_ENQUEUED))
+	if (WARN_ON(hrtimer_is_queued(timer)))
 		return 0;
 
 	if (interval < hrtimer_resolution)
@@ -1701,7 +1701,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 	 * for us already.
 	 */
 	if (restart != HRTIMER_NORESTART &&
-	    !(timer->state & HRTIMER_STATE_ENQUEUED))
+		!hrtimer_is_queued(timer))
 		enqueue_hrtimer(timer, base, HRTIMER_MODE_ABS);
 
 	/*
-- 
2.39.0

