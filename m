Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800986F90B3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 10:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjEFI5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 04:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjEFI4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 04:56:52 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E003729A;
        Sat,  6 May 2023 01:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlXDkx0+yg+IyuDWxEveellG+UJAqxC2t8TxAeZRGQMZavTgzkb5cm0WeRblp8R9cFtbeTPfXVnh4p6JxfOwcIVqa+2zKsnJN3dOTfwFsWcYk04v0BILwvVV7fYSquTCAxqOz7v1u1TUQ3ZmuDiBwr1zljoYVIEExc4WTRSPC0U3KfHH9eTteEBicAMDv9rfDJ1MJAj+XSuNGP6XaPq2SRU33zUmDuDVZ6p+3CPBEMC/wtemnqvckus4QI4TlR1WmZvBP2UsZ1OnEvsneCZ/mgduKIdeayuQRu9xiaN0/Sl5XgOM1ahSnstv4jGhvhbLiWkpvYP2XHVmhSTOqi6zBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xsZsrJsgUMxRk3kDPeb+gin30uiS4j75nr/gNWqiQA=;
 b=L16YnbjrzNuUMukHoUimmkcN75/3F4v07gBLUZlukzO7nUMWex093ZV8KlU4LyhEdwVCqy1KipSetnHMr2vSzQflTi9Szc1M0TU4ra4yJMmrnWwYGGcxyGdYFZjjTMOeMzklSXOR1MST9GHvrKJvLbcBy715JirHWswZPxy1AYI6tagmXmyLmRPcbMPq0JAyj2WJX//kJ4drD9GsBUkfaXaX+pJW+du0XPjDoylnh+MUsxa197NkrLk31Frq3nFphIq9PNGuhc5hwZqTbI2sHcnkqUDK1crDLlvHykgHpEUMFNU5PEjNFUNat8R/lOO2ua7I5zpSoXGNvl/WV1LqLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xsZsrJsgUMxRk3kDPeb+gin30uiS4j75nr/gNWqiQA=;
 b=UEBoNPxfgQN/SFS9kWu8o+vGT61LoVHwdVvdFxan/EO0Nt+oGH8jhlgTI/632LrqUmf8KwXAQ7awaO56zGdP9fhXe8YDbhB50IidCbG3+gCCe4TUOjkNT4z8YVHcDHZq1DUyWmLX1uV9I+nlSARXHxo2l5kpYQ5V8qBlz8f0q00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM8PR04MB7939.eurprd04.prod.outlook.com (2603:10a6:20b:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 08:56:48 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::86a3:5425:d6fd:2346]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::86a3:5425:d6fd:2346%4]) with mapi id 15.20.6363.028; Sat, 6 May 2023
 08:56:48 +0000
From:   haibo.chen@nxp.com
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, haibo.chen@nxp.com, christophe.leroy@csgroup.eu
Subject: [PATCH 2/2] gpio: mxc: switch to dynamic allocat GPIO base
Date:   Sat,  6 May 2023 16:59:28 +0800
Message-Id: <20230506085928.933737-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230506085928.933737-1-haibo.chen@nxp.com>
References: <20230506085928.933737-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AM8PR04MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec3d8f5-ac95-4ef8-de34-08db4e0fd397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXOm924OYOmKwo1eA1DpkJiEvVPwJ7rBp76f96M+5rbrc92GqBvkJeKgdnbKY/43Ak6gKBvhlLyuNtpzYSUWDsJ7NL3/pVEUZGsoo8df0ELWVcrZ0S8TtC5j0TrOK2xIainoqb6WTY6/ZAPeWH0e67NrSZTeNmXeavzyhapA8vcD3NIuKBuUV3QJHZ7zBZj40gZ0JgnnfGpP9grPQ/KUUDdSL8GS/N7JOksWV/gb4hjbXKD/o6zj8/Wi7+UwA9iJdrbo/1ULHyLxwS2BcW7d7RjVWztNHjYpismgKlCf0F+wTlThPUntCkWPxTTZMAw/ELVW03PRwOgBr2bQpxaLNrDT8m6XqtZOoUyFks4mZDB/3nuG1QNJ7U3haiakOXqBzfE8neOXV/PvbXRlu0cOLuY7qBn4/PiBv4IKQwR0ePP7B+lHkqi+5NjqPMd5BKqxYHPSvVLBTpzb9SbjWRWg5E4Vz0WfL8aRC6eB2a7yc7GFBt8zyKBYZsPPNuxTPkHv/Rk2b3SxIsmf215zIIiCgeLLGsa/sEksdSkCNtMd6mbQYzGvS6qMdVnuCNDzM6sQzXSudnicA49ci0uzx9HzWhLz2a7RUAH8rehadK2t6k1WpPsTSZXmYCx6IDe7lKYN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(86362001)(8676002)(8936002)(6486002)(52116002)(66946007)(66476007)(66556008)(4326008)(5660300002)(36756003)(38100700002)(38350700002)(478600001)(83380400001)(2616005)(26005)(41300700001)(2906002)(4744005)(186003)(316002)(6512007)(6506007)(1076003)(9686003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oHDSf34wrkc0v7FxXfV8TIGwgfCjmHd4TxbkXBOWYV1775uYc273vDivtikv?=
 =?us-ascii?Q?6RNj1g4taM69sCOM5d1K5Noo6PaTC6X9JWm7Tc1zKSvllMWwU6xB2kDhJ9eV?=
 =?us-ascii?Q?lfBqsMd6H0VmGLLosiE3Qx4HUvf+c3wv3+jyOdRd4xmGY2aOvH2Nw3p9Lzj/?=
 =?us-ascii?Q?1aFkmmPXsdT2esYJDfCOR4B002tJEz9ckIGUSEkJ81pOpBUNlKeG5UtWC9my?=
 =?us-ascii?Q?TSC5WYinyN+/hJp3+QHoPVktK9iAmd4PksprhHcXbUnSbHx72LbyXE/FLWpL?=
 =?us-ascii?Q?m+Bc5ufRaYK0HjQpvwPiMGuYC6GNpdCm6rfrKmCmUiBsCi0BYm+VzX6H0Otw?=
 =?us-ascii?Q?pemKdJBDcdn6rCydWFUPipMRee87OLTIM9YWFtrYUY56s8V9HnuPU8mOJeT8?=
 =?us-ascii?Q?LHCNpux3AamYoYZnlzC+a7xgTP8GIADgzxyQkI+Ng3CQp2VEXcxrriMGmLTD?=
 =?us-ascii?Q?g0ZExfZbHis7vGk58zBnhEMJX++AdBwRkgk/HZHhin8zFZv28C7Cy7f0WuAO?=
 =?us-ascii?Q?KSSq0sQ3hia+g5V0Y1U/kB0tVVOARZaTPknyd9ac4HV83afCRJziIZ43oBEh?=
 =?us-ascii?Q?9mJ2B1eNrdOPYOiMn3T9xlzLEJf9ZvceyrPrKztSwNBnJVFGUjzHcvnS0vF/?=
 =?us-ascii?Q?/avl5Ks+zRwJp8sk/ObVaiF/T8HKuJ7PlUW1p5bsjwA0gBFQOfXXaz2gdSBR?=
 =?us-ascii?Q?JmUn5tGCjHnQ4S3JAOCZQq9Chi1VnbUMMvNKMeOQ6C4gw4yqUkFaaE8wLbmB?=
 =?us-ascii?Q?D42QA0CqLz31owkalcAthHZH8m37MeOKTaJhMqKpQo/deq19MbSJkZtLeELc?=
 =?us-ascii?Q?6+TG1V+wx9AGCtqWoKGrzkpZuNeCPp6nXhhUqykETU0/x11794o9uDBUAqII?=
 =?us-ascii?Q?qPd+t2xdaZ3w3ctHKk/BKk7/03PR6IphcBzSocSiKIZoSrV4R+115/Shfa9H?=
 =?us-ascii?Q?CK7FmRG4ToeIEtLhzhOAEiX5xUXPCQytKTdRHdLq8V16FmsdtiS1B82a6rSU?=
 =?us-ascii?Q?hVNpbZSMleomqGESZ9HfJQDl/mTvurrkGmE0oFh+a5mZizWVDmUBh4fzlpx9?=
 =?us-ascii?Q?RY1RwkfbyQYSesef6y0rh0SgcL3Pej88+vxALfcW6YBqWYeLanddjAbz/jMj?=
 =?us-ascii?Q?o/wshNRRrHztVYBlisGy4go6GbOR5BpUWY9RMPJHEi4L0gw1Uhj0cSHyB3Au?=
 =?us-ascii?Q?GqGL3CE9Gj1Rc/8WaDlmSPhgtFhM2WljwjOWMoVcJYyrFBAZUwwnQIGEI46H?=
 =?us-ascii?Q?H3HjcOlR9o2mU+q7yOO9zxDdJsEd5YDqF75I1C7Hqjx/6uu7l2LtnVlrdGs5?=
 =?us-ascii?Q?9Q+eMXiUYn/OumqLSbrUIMQfQvuoIeNv8m1O04sMHWSEP6KwmOS5ThJtI2OE?=
 =?us-ascii?Q?9rfrSbBfRfjBOQFmxytsoEsZFeAMLKb150a4IyXVqfWKLkoCMBiPvoHtcJgX?=
 =?us-ascii?Q?eGEbHjJcXEzmat7LQSVfowk0KMeXajJmlWK1iyxBE2nTEJ+OHqQVATBpdstx?=
 =?us-ascii?Q?tbf7WvVJVffdtQpDQbUpoub+Lz261Jk26IAn1/xGfTPchAl8O4kmabTTQunF?=
 =?us-ascii?Q?/hoJKPm9pWHvbEnJUeWqkbWrVe/M7ELQ1KDHQzQP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec3d8f5-ac95-4ef8-de34-08db4e0fd397
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 08:56:48.7929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2tcKfukVUUTV0pnI9uyLokXecPafXdzLuwR0tY6CuUGeBSKglhOjnWmOfPUBiZgJAFKvw2oebvdpan0+y0NeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7939
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

gpiolib want to get completely rid of static gpiobase allocation,
so switch to dynamic allocat GPIO base, also can avoid warning
message:

[    1.529974] gpio gpiochip0: Static allocation of GPIO base
is deprecated, use dynamic allocation.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/gpio/gpio-mxc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 9d0cec4b82a3..abc129a88a62 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -462,8 +462,7 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 	port->gc.request = gpiochip_generic_request;
 	port->gc.free = gpiochip_generic_free;
 	port->gc.to_irq = mxc_gpio_to_irq;
-	port->gc.base = (pdev->id < 0) ? of_alias_get_id(np, "gpio") * 32 :
-					     pdev->id * 32;
+	port->gc.base = -1;
 
 	err = devm_gpiochip_add_data(&pdev->dev, &port->gc, port);
 	if (err)
-- 
2.34.1

