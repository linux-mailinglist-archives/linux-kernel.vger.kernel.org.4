Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B58766C227
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjAPOY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjAPOXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:23:35 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2064.outbound.protection.outlook.com [40.107.105.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AFD27497;
        Mon, 16 Jan 2023 06:08:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wt+o7VsmiAzgP09tpIo836VF0JnJVuulVYV1DjxxDrNPMiI4a+Mf1BcTv3yRlukEV8FVR0a4xrkVe2S5b81dYlFpqi18LFstTKjjWYUqPyExuWmecd8EdX1uxM/Vda2p9SPoKofiZBmJjDqIS84y4b8p7pyHk4Xs4Y8rVZl0dCV7YSomfPwq+a/Y5YE9Nuj+XNill+Z9c0F6Q6FfPk/oHF/5dM+eqG4cPkrE5ItLAMMF/Xi+iJbSgrCp8UkJ7Jfi76XSKO+D3VBj4PLpepd6E83dGCTRzApKzHl45ZwIdPKmIfiVvabXVwjN7hrN10r3kj3iD3CB6CW4lQJaB2K7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2eOSpS4SLmcc/4EP5FRJAL6OEvrfv0fhFOif66MgTo=;
 b=gY3OE9nPG2EcB7UTRx7EmAB6Oqr17ahB24Bg93ovGukJgs/fI+5xAmUv/Z+lgtDnqo3eu6uAO8yUpe6pDQ3cBx8kbZO4h0LOLpotcUr2TLFZupx05PN5t3gkvqYj/tB2ZyVn2+fHR2rroXODs58RkWLpXABeXEeZEo/QT1NzdbhGAkgEV+qfjMcoUiYAufamzfCPp6OCD5HHveZqEFVCPW7V1Sc3KfAzEwSivf00Xo3o8ps1m8e73nyteTNnV33eSKU6HO5I23rNPmBLrR2kuFE9oYkabsZSo/nDWRSHaj7fx30e7WjenCEsdKOWX32lnWKb6u7bxFMi11ZqCmCNdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2eOSpS4SLmcc/4EP5FRJAL6OEvrfv0fhFOif66MgTo=;
 b=B3a3td3DapBwYuZ3zoRVdP6rTJ9d4FMHOUmxXajNqu20en7CkwpRjn5oED0kr2CmgOkdHNw1kBkMu7la4nmHyyZ7qbCGLy/SoR3/LQcbP5KAsJ0za4oPG2K7UaH/Yu46tPrWjpflq5jBivpP7hE/iS4MxV1VV9mkBeNqJgfJQYWwkdZAh4FaA0m+nINTuGtsU/LoBP+8zbq8QWT5RPFdnFq2fji2yXQne6Av5C+AKE80ImA7Yk/X0QIcgxQZo0pWmFa5ojUlFsQfsivORgdillBvvUHZ6C7IB4Bez38GINP/KWcPwnNKF70VMXYCM6/8R8AfHweOTuk4z7URlaH+Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by DU0PR08MB9080.eurprd08.prod.outlook.com (2603:10a6:10:474::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Mon, 16 Jan
 2023 14:08:19 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee%5]) with mapi id 15.20.6002.012; Mon, 16 Jan 2023
 14:08:19 +0000
From:   Pierluigi Passaro <pierluigi.p@variscite.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eran.m@variscite.com, nate.d@variscite.com,
        francesco.f@variscite.com, pierluigi.p@variscite.com,
        pierluigi.passaro@gmail.com, kernel test robot <lkp@intel.com>
Subject: [PATCH] gpiolib: fix linker errors when GPIOLIB is disabled
Date:   Mon, 16 Jan 2023 15:08:11 +0100
Message-Id: <20230116140811.27201-1-pierluigi.p@variscite.com>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::7) To AM6PR08MB4376.eurprd08.prod.outlook.com
 (2603:10a6:20b:bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4376:EE_|DU0PR08MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ff2746-841e-4421-f309-08daf7cb1e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v6hoGdWT8pCJrUxYaA0hWsRVrCeD4KkXQJbt12Y0m6kBq8MyTgVzc8R9OeJD5Q5LPFFXFlcaNf6IA8GOKkkQL8b8EiZdVa1t5qVpQy17IQmUZC/MR4I34tA4K9Z5Geos17IBYrLR3y1jpeOCH7HggoIbxZpXB88fnlISBWEygRDeHCi/CSBeVYw+OoNmiop3ImXE3T49dKGHiVcotZzzQLHtOPAyOQlBqOcZRsirY2UP5mEmYJ8AATkxRLomGiWkYt/xP+3nHhwRBRpwrVs7c+w3ZyDBuH4+FQraQQNL0ZTxm5S51ty+CiiXcvcH/3ZmjlH/iUveFK5ULIm7+a4NM5bgcbmwFo8u4N7wZyxCmZPr/0RJMf5EDiSEIN9zP9JvvXcAXGdTvZZtrkvt2Aa2iCTnobloIAlo12Jgnf5O9a4a/D20LQbzLYkpIsJXS5wTRSoUgQmmyXW4T6I77gOFptIY2rb4DYRdQkiSQBF42aCvNGMVsosGCB+CN+yLoL8DPqejl6iH/tvZaqzb1JogGmsCiv3hp2Ji2YsbuAdXxIev9aVYoU0p8toRGVD+Gdt0bdI/Bcu2orVwuQXSBBBOaIa8x3HnB7ol9VfPlYa4uXsNzUHkjuh4HKt2Va9pVkFI50f7mqI3iWm+MSse3RZB/soNBQN9XqUFheeKBkY1y2Lo3kN+JOYUH87grSngapiIwNXWp5q8PwG3GzfbVDWIlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(346002)(366004)(376002)(136003)(396003)(451199015)(83380400001)(2616005)(41300700001)(66946007)(66476007)(66556008)(186003)(8676002)(4326008)(6512007)(26005)(36756003)(86362001)(5660300002)(1076003)(38350700002)(8936002)(6506007)(478600001)(52116002)(6486002)(316002)(2906002)(38100700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+eYNetVPmwKZqZMlkzqUuci7+Y8jnfC5fVUsOOqtZSLNTGygU3T6DOrpiSPf?=
 =?us-ascii?Q?KGxe0MdDCm9PA3v0ENC7QefoPYquu/E8Q/7TnqkfQzpzOGxXtf59KHBVT94J?=
 =?us-ascii?Q?EXus2tbLW6D7KIptMnA3LGTUXAXPLlwql0ELtBA1vK/1SuyiuqvJyEOhpL+f?=
 =?us-ascii?Q?2QCpfYQNrkqwH8TkzpK/YK/e2quT1WRiN5gE8Io2QTNh2YjV40OegTwMtfi1?=
 =?us-ascii?Q?KXbOtseLvaw+bBjg/AdfbRG7LLhiltAdal/FSIqQe9IYv08vJYcjy3lncvDf?=
 =?us-ascii?Q?ED+a7xJ+1W1SyvreJh3dLJ1UOoOpihlR86aGfMKVvrvIMHzXjjAWySCOscPs?=
 =?us-ascii?Q?hHKGIijDQy9YCN1a598FpgFNNhc+TFrVV43TGPa7IFSPax+WB0I6Wof1cvIX?=
 =?us-ascii?Q?RTFzk/BexFu8/MtytHWq76nyzteuvjH0IYxt9j8oaAqyvQlK6qWc+M6gnloU?=
 =?us-ascii?Q?tqOL0nqmWSD/J0v4tCmegdtFOr6IyTKtS/0qzhYMmhSpr9Pow5o4hCB2liyi?=
 =?us-ascii?Q?0tkCcJP8L2NiVohpLSVgpFPSPJhYUCn5VBtlglBJZmCyfE7NbbUIUFj0yttR?=
 =?us-ascii?Q?L7oYbRylSsIcERxQMQQU2wrAFfvXaGl+4tVY+Ul2aVXtdlDmBo7dujF1GdM5?=
 =?us-ascii?Q?jMhswAQTmgaMCkKaBtIZYQfPr0GfsD09YGzpUkcBvEb4/jGVYQCuL5wus0jZ?=
 =?us-ascii?Q?/23MBM8io0dDcTCU7Eo+LSpMykoBGrgcg1P0d5qihDty1v5SqvFjf+JwSzfR?=
 =?us-ascii?Q?81V1V+QYkNg9b2Alhe+iAsMkMoowWZppbm26dy7ylhYo6I7qF9xHCHmiHjWi?=
 =?us-ascii?Q?nI6NjzMVtX+2+Y7ORX+mlu0i/6IE3QC+qj0lI0Dw5qpZTztftAJw1y5+W4gl?=
 =?us-ascii?Q?F9MPm1Vf9GF1vYJbHNhLaY/4sfJPB1YxFbNk8ORjawLjHm9HB0WynFsaxMGY?=
 =?us-ascii?Q?y1A33KLv57aW1AD3OIQaUSTamvZgXSA59eiB3yoav3KK4K32jZ0RrsQDjQic?=
 =?us-ascii?Q?rlJR4V0biephiaHdkjkDKLqdiOD7Jiu4omXLLfoX5xiUqeXkPhtW8rF8Jxa8?=
 =?us-ascii?Q?+6fUrXznsmW1+Z7g4Z8BHqYzivXw3vYMAT9MNZ3UofU4GARaSlewaiE/byU6?=
 =?us-ascii?Q?8NkPSiBDiDM1ZIRDFubVD5UE8GsYw0OUvXLp5pGGnvafsLYRux18fs2IIoR+?=
 =?us-ascii?Q?a20R4mNzDgs7WbSnRAEQ3lSjEW8SuSnS41FbRrFY2CJykl2bPmylbRABAxOa?=
 =?us-ascii?Q?mh9ISjfZW8V2y9cHDqOFenQxDB/zwXMOYNRtSCw/taeSJVYFVeyX38NC393g?=
 =?us-ascii?Q?WTJPFTzln9eXon+5a3YXCXVoF7prUHSmjOPjr6VGYLV3C6AMk/JcJobEu5Uy?=
 =?us-ascii?Q?Iq/TdX8M+xQdNvRlSGkJdKTKFoMtTHmTd1bfKUymm3vKX2asgY4XekHR95po?=
 =?us-ascii?Q?26tb+w/k0ch+mXxKnxEVEKwjTqeXaJRtHRQdAPlNwV3KsmAu5t9PXW+YRpa/?=
 =?us-ascii?Q?ktQ2G1LRVCKyMLGFS//YF4P0edGPXOt8ZJkxBzay/2foqQH2srdmntbqhQcD?=
 =?us-ascii?Q?BE4ypUorhGNOkVkU8v0V8pl7Uii/w6141AU7acwhmnLq/k+G2iE8Uo+8TQca?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ff2746-841e-4421-f309-08daf7cb1e8e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4376.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 14:08:19.4296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pp4xQjzR4iOScJCY0VCKJHR4uKmMAaIxxGH1btWvOZ/G22NaaTBGbGlyTySS3zqoXL8RWLa+1hcKNfPDVAvCR5Vu10GLksWplZ3veR3Sx3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9080
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
Move the protototypes under "#ifdef CONFIG_GPIOLIB" and provide
reasonable definitions in the "#else" branch.

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

