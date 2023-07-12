Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D52A74FFAF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjGLGs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGLGsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:48:55 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2117.outbound.protection.outlook.com [40.107.255.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9DB1703;
        Tue, 11 Jul 2023 23:48:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8iuBUs+57/QGNecfOKksBXmeBEoikMx9wt5/UPKTglDe8jO+bgd8rNceTuhZb3YsoKQTnG/Q4Ybc5gNVjkbT4vftbmNBdfxSjYM+p3XLdpYU5l1zTwP55u8cW1a9jWONE+DNkYbmear1ypyNH55WCDr0UKLQwU5+eCpZOHT1SzNRWeeMQAgMI8IqpPCLbjg/K4fkXfh1/nCYwcq+QUl25LpZUvPCPONiZuC+tK+q5imOsGtdNU153E7hp2tPzgpQKCuGLHQekPSI8IKWvlI/WOmRFbGli6Frv5w0FFx0l+68Gk9Pi647CTaZ4Bwg6HGWgfRSkkzh+iRDjev894c4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikpvjf+fMeFM6mGyz04VZzdPjgSYvDlKytRFM8Kq7hk=;
 b=G/dGqRE170qAlTyhsfJ0ViSQVDIFNjysRrz8Znay3ptog9hqCJO/rryqllUzLDQth9ygwxBofWoC2Sa2Hfqn5/SPwmZtN1UeeLyXw5eBDUJtk6GM3TfShpwp06W1Lllkl0QU1nFVFntXJr2Ws/yk54UTax5a8nwxtMii0hxI1s/jCea/T3LOOHxz9o6q72yBAFQ/JdV/9VzDgXpmBF84/4QBkCkoaTPBbLfhpXCT3mOKoJymXChrtzObdl7WI/KL9QUPHD4sC3WTQw+zdMFk5okg2yBj9yjigIeHS7/eByrlG23/Lm8QFPWzUwg1delg+bgibHPbktlMzp9g7B8JVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikpvjf+fMeFM6mGyz04VZzdPjgSYvDlKytRFM8Kq7hk=;
 b=hfZCwJTqRgu0cXg5tqM91khrJgUw4zMB3kI4mrn4xyITTmaTeq+bm1COeJqNb71+y6YwXuAN6lkpTc6loSqT3K9SFDzCTT3Xn2y0ms9Uqh1oz6RWaSYtr+knsoyOu6RIqgG5H/EoowRAyjYe8EyHXchMABWaitOwOAblP8okJd+dQ1wjqnOgJJpoGovVQUqbFR6N2l92BEUbJBbisRkhyoAEjUkhc28es15ivDvtGrl5wFhQ3RrCOPrJ4jm4CujTfXo8CBPyPF/OMZMmH4ubGHnMEZaRju6AfB50CzNJvSvCjQi6DQt0yGyNrpudk62R+EqgRa9/8k7FET5ZKs5hxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6432.apcprd06.prod.outlook.com (2603:1096:101:16f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 06:48:43 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:48:43 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-cadence: Delete unmatched comments
Date:   Wed, 12 Jul 2023 14:48:32 +0800
Message-Id: <20230712064832.67091-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 45611ab3-784a-4dcb-c8e8-08db82a40854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1PSlxSJ/eeyZrzcJZBukWSmMZcTwgVpN12Mkgr28H/bVUHJFSaIom482HUruCSP9gVZkiDpAI4S/fxhHWK58INXLdQzExSdH7+E6WuTWGiqbo5bbdRQ2XMNE8wa9U/IMESVa5QXUiA+Mmww1HZgf7NNWm/sPOlL2OiGebdOoY493u30CFn9+gth/7YYgTOCituM2MvvtlWnFjaAlZdEFRxKAv4UuYc5zKFFCPZ/VEZfdzbUHwWSE05CJq9Vad1OaeUkmz55ATxT0CgfbjgmVjibjgTSeZwz6Vlyd3kRwvj6Qw/0qKItx3C859DRPVbZ508DdtB7Zy19D663HclpGu7KT/4UldQGn6OpQ8lyWJ91XTuElAIK3VCLf9y9Ky2Lr0kVFpvDX/DufAQD953VQ2A1x9Ts4RzvdNPoEwYguJVcTShaRZynl2Bg6XkztkwNKj7v1ybGf6b3z2ycos846Lgk4Xh/0InOalIySDscUL+RVY5cJOe19vloDg0xKZIEnsfQQlUshxlOI42a7yZ8uQlL5BsJ9x8YoxGqXGAdC12RRWqN7eLnQN6xpAoifM+tq1PmANKipxQNcFDdlT7fgUQoIRT8uwUlAfCxNkoG25uuY1DDCaxtpWlIpapcOlUQH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(41300700001)(316002)(8676002)(8936002)(6512007)(478600001)(52116002)(66476007)(66556008)(6486002)(4326008)(6916009)(66946007)(83380400001)(1076003)(6506007)(6666004)(38100700002)(38350700002)(86362001)(36756003)(2906002)(26005)(5660300002)(2616005)(186003)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jN3Qslx6f8hrh/PdrLHPChPbYEO6v+pl9dTojR2NzfYu7Qn/HZy3cth9Knum?=
 =?us-ascii?Q?+VavDwLFnR/cvsfu6QxzG4RkigUoOs2e7QhWnG9AzKg7PqApa4qplxK6ZTk8?=
 =?us-ascii?Q?ZRraBNOH4pVGym4wOtUe+uGBNxEGMp0U0Ln/5uKRzXy8yz2AS1P5Z8sQ9IJY?=
 =?us-ascii?Q?RFIyW2OvUhzQpgfjbVkxRAiY9eyc2sUJVfAk1Qn+vxDoOtVB2iz8S0BzO2mF?=
 =?us-ascii?Q?sv5Rg5wTMJaUGf3daMNMQUTCouMqI4onQAwOd387zijENhMgiRY2TftU19ib?=
 =?us-ascii?Q?ui/11KiipSSf2C5tIk26C3ieqmyEroNZJuMSsYeaNFILOkfFAWCuBFfXp40V?=
 =?us-ascii?Q?Bpl+Xg2oJvBjaQCCZpekaGZn+tLWy3skuEHNYqYnnJLOzAzt66LHjtFK0sQ9?=
 =?us-ascii?Q?OtDtznXv30xbAf+xUJ57155gOIt8D+48fCksxr2Z0I6j9582NENOnu2nbGaQ?=
 =?us-ascii?Q?FKfRZpBjDajg/gu2R64KDPvAJ9aZyVIUSgMMC3yr+x73bHf6ROOkEfaBb1uK?=
 =?us-ascii?Q?19Nb+47JRSeNqnyVRPBz90+hL4nZWA80La7CvpzIddGnE4PokecZ5LRbMY8W?=
 =?us-ascii?Q?TLqraKtzW0gKI10KZPU3UrHEzhhtzckxdRs5Y3QximWfeWsBzaVQjG+siaqh?=
 =?us-ascii?Q?4sCTpfdlVewVvaQsmWuk41i3vFzSvYMX7X0G5CW70IrQ5F6xUaSY5Nk4Co+q?=
 =?us-ascii?Q?3RILLZKcDy/WzuURMdHRcrYFJ7JldPh0VmCuaLljoyeyQTinYIBWGakrdlBs?=
 =?us-ascii?Q?tNHcH11U9Ik7Byl/lTe2igAx1A6Z/QQPWUDJiZX8kFq5bBi5tAvdMgjUyWl4?=
 =?us-ascii?Q?0bc6jOnUAtReZ0QQvgAY5GBYQzpXQjK0FlbhxGUWqBf8Oo0h6//cd7m46MLr?=
 =?us-ascii?Q?50Jl53VmOoufXCQhzMOW4dpuQUY3yFvXHmvpxD89q+R4a15oRb/cxZzagMbz?=
 =?us-ascii?Q?O9i6vftPpLfr2fwStYN8WBOsOIN1E6JSLiPDw602WKxFVOXoxhgPRsryRPn9?=
 =?us-ascii?Q?UVxVVlP9G/gE2fz17yyOuR/yp+t7kdgNV54gxYF8wTeT2KAfxvFRQaXUsWvo?=
 =?us-ascii?Q?Y7fkUsTe6jeg8lRvmFZMzKYCnN5SSBYZ5mzzPFM2YPmbmpM2vXqH4+jCelCA?=
 =?us-ascii?Q?imXoi/1/JvPO1xZXv9lvUh58GhYuPnvNIlHndiId17QR79roFjqC9UG1Iof5?=
 =?us-ascii?Q?IvurgGft6BWbL2NUiEtH5L+WP4Simia3avJxfzR4jF55KA4WBAym8yPdF4h8?=
 =?us-ascii?Q?iq1vuSXwmKxO2ToCaLCeubLjF+JCcc2RDebzcjXj9CcuLx8EDp8QQSspOt7z?=
 =?us-ascii?Q?V6AlQFOn5B9VO7H4I4VmOdREA5462MVF1m6StSYQ3XfZVcGfi2Wiq3jIhAml?=
 =?us-ascii?Q?JZCFk6TSLkHgIm6+zc7Rq3ZH7UlzNdpJ+uM7jRYxfCWlvvEZVcMZryz1oXGL?=
 =?us-ascii?Q?JOKn7fE83/8bryHeWispiFMQfkQnHV9AibMUa9phxpWp7dnGgYAikl9zYiII?=
 =?us-ascii?Q?DSUHakTeFb5NSHL7KW0z6jvknmUzpchev0U5oVN1ldePUyWJULoq+/o0RK3B?=
 =?us-ascii?Q?Bh/j79UiDXm9qo0xU0PKdfy2zBKqIrE8oNIWNXet?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45611ab3-784a-4dcb-c8e8-08db82a40854
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:48:43.1267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 473MlwKkiL49UQqGxJIs3vP9UvxpAC/irlhtrJtgUPeZ1DhSo/3XqdKtsNKQlcsFlm3J37O/toJVZ6JgOXXzuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6432
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function no longer returns a value, synchronize the comments.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/spi/spi-cadence.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index de8fe3c5becb..42f101d357c3 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -690,8 +690,6 @@ static int cdns_spi_probe(struct platform_device *pdev)
  * This function is called if a device is physically removed from the system or
  * if the driver module is being unloaded. It frees all resources allocated to
  * the device.
- *
- * Return:	0 on success and error value on error
  */
 static void cdns_spi_remove(struct platform_device *pdev)
 {
-- 
2.39.0

