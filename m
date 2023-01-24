Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAA4678D70
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjAXBby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjAXBbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:31:53 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C1512869;
        Mon, 23 Jan 2023 17:31:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bp/DgEWbz0aHTtbDKlVsHs0/CAcRhbamUDYS9wJyRYT9O8D8qb/Rv0KgWWeVsX2vapmeinoXDgIfpjWlBwievVbAKMqxKAapE24mMgEARm8aLgSucNWNcx1yGqFIxBnNcm86FH36TEsqLKqyePSbhdA1/NpLgjNnGILUK1AUGB1riiJX843fOd5CIf0kKS+qypOXASHGhXn4SaEE/Fvnzk/Xw1dhx+TWWBhdGZKuX5OqdxjrC1Oh5HpdD2BIn/ANdYf6nztY5bFGrfRq6bSiJN0hoY04VkMgSKbOHTm01eqBsDnZpR5mjR9LT6oQltQsBgZlG4r2LtOyefLVKXK0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MlceOkI8fkh9/CohHhlzr2+DLmbKxPmJlm/isw+Mtk=;
 b=CxEEHBh977tfMdSPqwj5CEZLE+yWbAsvEhQ3nhEivKD/38rlO217LdulTXfrRn4blkcZ/Q3odAMgfZwYAGidxmhU6I8IGKWUzpzwFCnl3fTtIMOll7wEIuUf703G158wbQZBU0kQIlBgmyigmPYRaAnyAzoMpcajhEX0SnO7GCdHwi4bETZ7YGsXvjeYL6v0RsTpczxrbJxjibQKfCwhJe56vTa2wCiBEd31i8bOA5HW87mGoE/3IHNHNngIO3bbyoL9ifs2J0TRTCG01JlJrpCe+2AsUYqxq/igiCIG3g1/scshKq0hyj6z7d5e34NTe4IlM/tjsb2WkPcMH+g+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MlceOkI8fkh9/CohHhlzr2+DLmbKxPmJlm/isw+Mtk=;
 b=nXHVwsea3eEqpqeCqAgyGXkffEXph1reb0fGPlnUjLthZRuYGIxV7hdeOoygp4M9dNUQVTQ05cYY59X9mTAozm6gdzCG02ClazF+e0lIjHMHAsr+niFGtiW00ZeZUf4+Fll+krsHUSCXubYb0zLMpkubB/kFys/sOberxmOSPCaXcrjoMrRgov9nghtnCBbyL+2FghRn6sdOHT+LagZQVB2nxUGmNf2neWDGM1ipQIQcsYB0WshyYQIFDivyIp9iFNr7aI46QA/3JrmkSEaCLQhwDjDyyCP0YZI+gAFuBNwM2EoRZPyBk0mOO3Ggc7E3jCnHkKQUKsYMEJfkyOvVyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by PAVPR08MB9484.eurprd08.prod.outlook.com (2603:10a6:102:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 01:31:47 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee%5]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 01:31:47 +0000
From:   Pierluigi Passaro <pierluigi.p@variscite.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        yamada.masahiro@socionext.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, sfr@canb.auug.org.au
Cc:     eran.m@variscite.com, nate.d@variscite.com,
        francesco.f@variscite.com, pierluigi.passaro@gmail.com,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3] gpiolib: fix linker errors when GPIOLIB is disabled
Date:   Tue, 24 Jan 2023 02:31:38 +0100
Message-Id: <20230124013138.358595-1-pierluigi.p@variscite.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::19) To AM6PR08MB4376.eurprd08.prod.outlook.com
 (2603:10a6:20b:bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4376:EE_|PAVPR08MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e2e45f-6dc7-42a4-4f94-08dafdaac240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XigILwP/NYPgFoh+zvI/J2VCxlWm7u6acwozFvbgrbM+KawSdb6mMUrk+LHOEOskN+WkAt/Q6cWvL0EVKy8InZZ/lAuKo5bwR7iSr5wbpVzE3QtDCU/OvhMPY9mM8b9dHZwk3q+z0ylLzgxROkvZzG6ZpTN3TQVw3xRAsWmAdHnhBAXjDpQkD4mROjwDRdqjQ6XwC2jzeOuPZcFVhEDvLaKPWVceuv1I3/BKKAL0kQUsNrvygAJdNvwlqTDWcLQPNVLM5PjT8ekJqJe/zPwcXx+71iOz9BziUGCBnnx5VB+7M7qEaZ+xPAbhBYSCxh94NA304eq14ZZVT4W+s5bAUPLrlypu6xYRNgxH+J9Vjj/9pTMi1DMzlqeMLyla/vhtij8eQKWnTuv4VaGnr12r71LAjPExfUvGxpTDUcJtrbhZ9sro20c7nOfVujOtx9iDozOIPN+5hHupK0FYshrB1RWHhQ8mQNXdLXQgh+dCnanFL/FmBx3ZE7iTLC9WoyuKd1VDmC3l6F5mm+dmJniDasVXUa+LSga6idYZuQF2GBIS5Hz1ZfkjofHIGJ9XSo5nwhlblULUnsxSPrj24gNBxKlmDxVdVKx6ZNoQpQieTFL7aGfvI41WOkp6T7H2H0IHhsWT9/UqUn5HwIeKOZlbiXLkgz+l+w7Bm8+dR9CIBcULyAQKGyAPMTg5sNlWcYPj1h1JKaJf37b8xzJthAjWaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39850400004)(136003)(376002)(366004)(396003)(451199015)(478600001)(52116002)(6486002)(36756003)(6506007)(1076003)(83380400001)(6666004)(2616005)(26005)(54906003)(186003)(6512007)(316002)(66476007)(66946007)(66556008)(41300700001)(8936002)(2906002)(5660300002)(4326008)(8676002)(38100700002)(86362001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VUjUtihWry8W+oL4zHCCjOy4dhGWWQo6sHWTpqfSXcV/i2jNwFBL5h+32ecs?=
 =?us-ascii?Q?aFlo2N3NG2sOc5PUyoECS1Se66lB3v54PutXCaVc7AjKuxIWGkfMX4Nx/UYQ?=
 =?us-ascii?Q?h7aSya1r90ajoDDN+2q3uhADx5YvRPkJ0zaNfw0wz2UxAN09s8kZkziZ572p?=
 =?us-ascii?Q?39M2dTvUOSiC8GBI1FiJzg3RA3tuiep7XJqlFO27ZlkgZOdEA5NSnDljn7oo?=
 =?us-ascii?Q?3aIWsEzdrBGOWgHNsbY0ijLDt2DebcRHvf3/ibo9hI/M002iyMS0C+7sxNV4?=
 =?us-ascii?Q?YYJeiJA5S5U0FtRLndmdIksDlCFdyHXxcq00W9cZwEHn97F35jIHBagbL3Nw?=
 =?us-ascii?Q?Lg+ktjmlNGoWYCQD75Y0rY4n0ZFEglEl4CFn/HtiQQ8OAiUDU9reEeA8s7gY?=
 =?us-ascii?Q?3Yx18ASGErdjZpvyQbwVjdRmbH8a0398oVqO9ERkZIjZDUjsbmydMvj/YQC7?=
 =?us-ascii?Q?3NxbOrgscWOWibh3qisZKRAz7CAauA92dBVcc05+kofu+/Kg84GojMk+RNiq?=
 =?us-ascii?Q?FY0egVYxclfgkkwElZHeFE+n+acwC1LFaNC0vFgijEAO6yKgcZll/kTWJKFj?=
 =?us-ascii?Q?h3uZzRiUKxeyJW3vX2p0HS2KcpbbIMj/3mp6osWLGzvms7gjJDWNBpBT42Nd?=
 =?us-ascii?Q?x/mTWviXILwr/MBRIU7uR3lE831HiWneD96gGgN1ML+jdkJVgHLFdS9cYygR?=
 =?us-ascii?Q?w9e2VdpQJXsSGJi/LfqtEjPE5oUgtb3yrzHHPOtKVqN3v53t13QOIMFjR1+l?=
 =?us-ascii?Q?jePqM3qisVf2SkpHyVf60Kfe89qHylWSQtCK/jJiHBVsOtzXOWj//duzNLUN?=
 =?us-ascii?Q?hC00okK4+vJRFul6o8OBzeRUDXwFbTMadadyp2T2DcvE9FFN97A2kGZvfHoh?=
 =?us-ascii?Q?b8I6IdAmQ78CPZcZgVMvM8qL6/yk7CaH77z277fX4JslK9bstOiaV1xaVSjG?=
 =?us-ascii?Q?twDBQUqpH4YBg7ERG8Hy666pa0bv6+PeQvWggZu9nzT80k1hGc1XbstVq0oW?=
 =?us-ascii?Q?l32jslmU0R/5ckJIjrA+gOUXPYtWqvJ4YJVyO8JQaVErr4iUGlobdWykug7W?=
 =?us-ascii?Q?7B3z9pAVY84AsFXsxVaVcnhBmyoCPoP3+4g60cKdUuMVKsidn2zsPcil3xW6?=
 =?us-ascii?Q?TCYL6Mwm7/EXARCi3Gv90LmxZtLYMvlJNFIa3UVzGRuR1N8DSuUP1Yj/4Ruw?=
 =?us-ascii?Q?v0T9h+ZwBn3jXl7oSs37VIXeN28naKrx//XLwoDW0F2oUVQhmYHVS2m1vW3Y?=
 =?us-ascii?Q?b3pTGZ1KGLWW+wps0pnv9r78N3zC3dxr++hRYugIPPIOiEzUw9ezynH9LHjI?=
 =?us-ascii?Q?CIuccExj/T6Rh8qX/yg3sFOBVMIrR3NPcpp8jE0vBFAOhE/Pz/9GP4CzCZYh?=
 =?us-ascii?Q?AA69pOR8pPltYWKhWEZScsjDL4PHznqicMTGR6QdNA9hBla1Xk8gaHJ3YAwY?=
 =?us-ascii?Q?An+AafmyyaFbbjRsmkNDW6Km3qjon4E3i4j69coDnknVBfQ4xuFSDIgCwqZm?=
 =?us-ascii?Q?kyl7qamA2f2SEYiqnI+1zXFAOCmfppiAT43oI+gGnKSKYh2A5ObcwmApvf3L?=
 =?us-ascii?Q?AodSGwq+1p2A1blyRgup4FCWZMWufykaeBz8hvp9A8Co+eaHS4HRsHDgqMUU?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e2e45f-6dc7-42a4-4f94-08dafdaac240
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4376.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 01:31:47.3327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jK54Iuu0a5Xua9nP3IpVqiSn9JMNbDJ5YXv2Ok3+xeY4eQIy3N5ApAPkv6ytCgbw37EQUZukg9ZFnQef+8b3f4z6/xetW9BSpFfxBM+ik04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9484
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the functions gpiochip_request_own_desc and
gpiochip_free_own_desc are exported from
    drivers/gpio/gpiolib.c
but this file is compiled only when CONFIG_GPIOLIB is enabled.
Move the prototypes under "#ifdef CONFIG_GPIOLIB" and provide
reasonable definitions and includes in the "#else" branch.

Fixes: 9091373ab7ea ("gpio: remove less important #ifdef around declarations")
Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>
Reported-by: kernel test robot <lkp@intel.com>
---
Changes in v2:
- add Fixes tag
Changes in v3:
- add includes to fix builds against x86_64-defconfig

 include/linux/gpio/driver.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 44783fc16125..e00eaba724dc 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -758,6 +758,8 @@ gpiochip_remove_pin_ranges(struct gpio_chip *gc)
 
 #endif /* CONFIG_PINCTRL */
 
+#ifdef CONFIG_GPIOLIB
+
 struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 					    unsigned int hwnum,
 					    const char *label,
@@ -765,8 +767,6 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 					    enum gpiod_flags dflags);
 void gpiochip_free_own_desc(struct gpio_desc *desc);
 
-#ifdef CONFIG_GPIOLIB
-
 /* lock/unlock as IRQ */
 int gpiochip_lock_as_irq(struct gpio_chip *gc, unsigned int offset);
 void gpiochip_unlock_as_irq(struct gpio_chip *gc, unsigned int offset);
@@ -776,6 +776,25 @@ struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc);
 
 #else /* CONFIG_GPIOLIB */
 
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+
+static inline struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
+					    unsigned int hwnum,
+					    const char *label,
+					    enum gpio_lookup_flags lflags,
+					    enum gpiod_flags dflags)
+{
+	/* GPIO can never have been requested */
+	WARN_ON(1);
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void gpiochip_free_own_desc(struct gpio_desc *desc)
+{
+	WARN_ON(1);
+}
+
 static inline struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
 {
 	/* GPIO can never have been requested */
-- 
2.34.1

