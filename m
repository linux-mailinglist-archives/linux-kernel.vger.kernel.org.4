Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4404676259
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjAUAZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjAUAZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:25:08 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0604.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7A4CD21A;
        Fri, 20 Jan 2023 16:24:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxlMy/083Xgm/prwXe4wnz8dy8YEKXoZyW6g1MgISwhYjFFZIaK9q4mVYs6gN6UN98JRoYZ1fTlvZGK4WOt3UmONizZjIviX2M7CnySVG0YccwYhJfTuohxJeTvMJP274wgcBg/TbXOpI9FLTebWkphvhkl7ckXeCGOHr64DHTc9mev2wbI4KiHpSpKk+DaSd9iuzDjd/AeVZdUCisiDDVcEUSu+GrcW4pEBQ8byH9DvK1h5i8gQ6z0C4py3woW1LDyNr0CWe4c3cQJv0u8n6cFfqw2K9iR/TI0+EGWJPG+LBBQqAg4AIkPcFMHiQeiAqTl7jRlw6KvoIvHO4D/XMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9HnMLFIZIVhWyN2uhimVdZjXCnxiQ/IQyK+u530PP8=;
 b=C4NNqnlShjESXyrLOu2FNc4Pj7Ku66zeqHJCMgvQL77yNVVD3wxodEEitldsCXZ1t/dlrEojaw21y64+xNmL73ojjPP2XkvSLzii3vh/HbFGQVYtqL3gtPbKhU6jDkz6BjKA8aHVCBSubFwxmFAJo8j/40VlF8u/usRD9CCh+6nH0HAAhAvwPiyIQZbBCXUYQ3FO1M2yg8Dl5hKL5ABpzr0Ki6agM4TyohXUcs/CFxom9elovh/SpyegxVvlWewGN/FFZsdkxEfyVUoPw7OMQemsSORg2ZU2uNlAq+qRg9/FzBHViqmN1qbvv9CGGCtzjaZouUKbZG50QBsUjN0Yxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9HnMLFIZIVhWyN2uhimVdZjXCnxiQ/IQyK+u530PP8=;
 b=ZnZydHe2CkYDkPEFH/cj1I7ZEBYPFO0o8PXf3tUh0COcg2MUl9ZaaJZWeJtjIyDBQc/joh+6w2BOCnxQrNSVG6Sck7J8zmWsmeBWc7k0YyPj4izJ5EJclLZag0Y+G4zQJbMYb1z87NLRqiPVGjl+NPm/DTpuneGR3yzUgdSbRPLw3O1GjbtHLNYMMF7mbXSf6L+Cgt9m6oIoz8ZQ+PsAniS7zG9wq1VoZjJaumvZfETD1cbdjSIxmTw5BpKeHdAwaU2i1za9/JM1P06cQmD9OgkPA9v0qZbxhtJPtrnsK9xZRvA6yX5ZP/YSKkAGk1Xg1BDD29hNkwX9w3vW+4njMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by DU0PR08MB8114.eurprd08.prod.outlook.com (2603:10a6:10:3ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Sat, 21 Jan
 2023 00:19:02 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee%5]) with mapi id 15.20.6002.027; Sat, 21 Jan 2023
 00:19:02 +0000
From:   Pierluigi Passaro <pierluigi.p@variscite.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        yamada.masahiro@socionext.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eran.m@variscite.com, nate.d@variscite.com,
        francesco.f@variscite.com, pierluigi.p@variscite.com,
        pierluigi.passaro@gmail.com, kernel test robot <lkp@intel.com>
Subject: [PATCH v2] gpiolib: fix linker errors when GPIOLIB is disabled
Date:   Sat, 21 Jan 2023 01:18:45 +0100
Message-Id: <20230121001845.32592-1-pierluigi.p@variscite.com>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0104.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::19) To AM6PR08MB4376.eurprd08.prod.outlook.com
 (2603:10a6:20b:bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4376:EE_|DU0PR08MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d1e7fb4-bc16-40f4-3cbf-08dafb4518ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBOVcE4rWfavI4Cy4/L6KxAoUnIyGPyOOHAHi8wbv0yBBZGfJ7DTRIDXLLexKBYEvTkjwcxDoT4WaxdfJU1knyOxraGUwekazKVV7sTMU3319+VDZOf6fvvijIzS8cIED0058RQxcS5tfzy947ZSpAKXd84toVyoYG5dx5Cjlikf+m7kOG5RxXaxrZIAoTppJ/jAhIw0GHp2Bs4rJ/dYAbSF1EpPn2dzWCT5wKCVMBXZPhP900i0NFdFuHRBFNXPDE9gh2KfWN8/AWzI3fIyU0+55VO3konsH6b5QSbxJNLVjuyNmYTkKyVrDdqwSkDRx+eXQ3UEOJj6eDn7IPtl3HKb2mMFUo6T3tzFtR7/fwrrJuwIPohjBKHeSlAYb/Jx9QWdI89DOu8A06eiirXrzC5ng8CYz8LFLLA4FhwZZO4Ha7U1WQ3o8MC1vZTL/w01+TVjdwAhkiOVlOPaUfm8DJPdvN/8w4EQPn6SVeQvUpcO1qn4gBXmwgc3I+IhC7IDcR+mADl1kId+HSvWQofO0ovPR/B55FUc1gT1LovkG88tXq8bV5OSfISt5swYpy62Sl9xDU9uLRTAswcd9vjQ/vFhyaR6mk7ZCDJ+wv6Mocm1pxjPBtd6Tzzq+7g6LX++BQHrQ1qXfHjIDwnr3LFk3uLqP4T2UtlVD827o/6tmTxf5kf0WtG9DSP7fsQFFIJSKUBYP9GVn+PZHGYChR2Smg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(366004)(396003)(39840400004)(451199015)(5660300002)(83380400001)(38100700002)(66556008)(86362001)(4326008)(8936002)(8676002)(66476007)(2906002)(478600001)(186003)(6506007)(52116002)(26005)(1076003)(6512007)(2616005)(316002)(6486002)(38350700002)(41300700001)(6666004)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q6Rg2SUs7yI58DXb26AusJYH6UxVELylCfzC8qDGDiQ+J7r7xN/HOKgLcfb9?=
 =?us-ascii?Q?c1euPPuWkrEk8d7Pf/qK07W70LTGbttwpcSNYFjeTP99fQ2iZjztueXxpUnW?=
 =?us-ascii?Q?sbMAFK3S7Pkol/tJYtlq36N6o6Zo24GXKWDVh+q8tLa2YGctmtaLWwIltG6Q?=
 =?us-ascii?Q?mPTl7/F+FhjQBdiV04gQrGG8qXK3tOIv40rqyrEJPKV5mrpUJFThgRfflM2f?=
 =?us-ascii?Q?aW5XVrNafjI+lXkYv0thfREcM3+FhBaKa0sNb1gXCQkgETRdJIEqKp0aY8Wh?=
 =?us-ascii?Q?XKr2DvXTIl+JwfJ+Pd1jmjnfayF6nGXjufFjvecyFBpwBeOAtEcfQ1MJHyt0?=
 =?us-ascii?Q?wkGYwCTKjwCWAka5JO2ku44k7tANpg0T7cCxL5l90onLWUHEVDZnWjCQVq3O?=
 =?us-ascii?Q?/bjTlYGUqinO1xtowcTvAeshSwGAb28Tg6LATcOVPZWVjoH3EqDLgxBM8757?=
 =?us-ascii?Q?TzMKy5MglTVOhEsLqpALQDxW98amIoaVGsiOd4BOOp9TRwEv3FiaYF5D6Fug?=
 =?us-ascii?Q?W9npF+PaghJd7oTPE7QuULdcMtm9QyL4Nb3rUuRHD1TcXzMdMbXDyx7yNek+?=
 =?us-ascii?Q?GOy+zdFhakvRqqABTdtc/DoBGMFfeHRg2PPm23onb3ZD1IQ7u5oo+h2Gih5/?=
 =?us-ascii?Q?/dPoEoY0e1AWbDNd2BxIlvT1PZTRvz7RjaCMV5Hu0dFEzVdvcCj4tScpttDT?=
 =?us-ascii?Q?afiGpydRsDP9liG4aQrDdhGsmNASM+LI2S/5NZVSIteTpye8uiszOhyaB+RW?=
 =?us-ascii?Q?vTpgWvxIOl8uFzFdGt/BBo7IdQWFHI/fSkcIWo7Mz1enAKzWnQXwcbzUQecp?=
 =?us-ascii?Q?b4qTCK7iV52+TeRjWmUqVGzdp7Bz/JHW8BPN6BEynF7PpQsK5muaWL1Q2D6d?=
 =?us-ascii?Q?rCYOsOch0qX7+a/JUVmo5QalPUeinLc0uIC4Hw3DeGT/dwV4VysfBA6ml3KQ?=
 =?us-ascii?Q?xVWl+nGRAs7Z6QQA9+RhGB3uhC0iAumd1v3gGW5WJmIoV4ep59ONC2st+3ir?=
 =?us-ascii?Q?8QZrSgj8w94MDxpozNipalRtCYuyBWBiWjiWBdQ9TW7NXbgpCo0096beMy38?=
 =?us-ascii?Q?Hh4yVjwjdV1OmS7uAuRGhQv6uK41XsT2edYLhptxmTXaULlfmoih5W1wCzc2?=
 =?us-ascii?Q?fl8BrsmcwOzRSXI6JULmvOdF5JEAjkMCkVEP+Aml6uB82+5NrEmWs83sjS1C?=
 =?us-ascii?Q?N59uQzhWxwq08suD5ouCtqzGLX4IletxDHODsWptadVjCDzDBKSVE6WXHhLK?=
 =?us-ascii?Q?h6KYxzVnmmaF1KmyQZYZIBFblC4L6/RXiuflxH5vOml2geRq3vMMXw34Mnvg?=
 =?us-ascii?Q?e8khubU4CeQEPygV7vmmYe/vf0qsjR77+mdSerdINcdO/ZjKNn6d3hBT1zT+?=
 =?us-ascii?Q?2+Lu/kXzrYWt1N3wW+mhFUpFDypcFhRxN9RA+56mv8hOAgu0BjcrjVto3doz?=
 =?us-ascii?Q?LOWewVCfTRzSTOsBNGG05jhY0chvCYwn5e2d1yzZqtiwRbnrQTTdqrJaji6E?=
 =?us-ascii?Q?B2EPlHm4dS6OICaUOTBlVArg/bG+CiYhFEcRyFCOYMkHAuatzKXDQqchrEYW?=
 =?us-ascii?Q?qiVcKpR2eCv1UMR9Vmr6JIomfyv/LT0SaghZ1bTisqw/lsbwi97LuGOFsMFB?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1e7fb4-bc16-40f4-3cbf-08dafb4518ee
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4376.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 00:19:01.9677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhgVEJZB7dDzfWpHfOvYFUe8B69+JfDgKBeXp3lGw7FetFg5nDMJfZf5FTwYtemjZ9uJnJEUjZeAG+q++CUJ/vx9ECxeKIfGDcErGuqMwcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the functions gpiochip_request_own_desc and
gpiochip_free_own_desc are exported from
    drivers/gpio/gpiolib.c
but this file is compiled only when CONFIG_GPIOLIB is enabled.
Move the protototypes under "#ifdef CONFIG_GPIOLIB" and provide
reasonable definitions in the "#else" branch.

Fixes: 9091373ab7ea ("gpio: remove less important #ifdef around declarations")
Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 include/linux/gpio/driver.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 44783fc16125..ed77c6fc0beb 100644
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
@@ -776,6 +776,22 @@ struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc);
 
 #else /* CONFIG_GPIOLIB */
 
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
2.37.2

