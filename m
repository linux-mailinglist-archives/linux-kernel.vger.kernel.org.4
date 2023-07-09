Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1857674C461
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 15:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjGINdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 09:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjGINdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 09:33:17 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2141.outbound.protection.outlook.com [40.92.62.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA58EE7
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 06:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwWa/4ESxfU5ptJPjn2iugJKi62U49DXmtKxJS4h0VgvYHn0hZ6G7QRu+Dmpjlpa69Jysnh6uDpbu+nN4kC+OB0cFMwM6fxSrEXkw55TQFWWnkfRPLZBEzkYNca1IzXeWZX+pABkTexZK0EAuk/0MZnp+j+qeWDlsn9JLmCWHBimrCdn2GsxC5yoG4+nMa+FYea3i4zsF/srgJVluK5HGHdzVlM8czYJdKeF60r9qFYSwKyEGxAadu2N7zVeYFvCXqOyZ14GvqMbp87UuEJLlVxt975x4I8jso3UWh6tcoRDvIh/9DP19gatnbFbE87ychZQrlMjj4bOWpSdRZe+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omxhB7lvu3aF2Lb+pDAie0Ir0FqgYtULcE74HWha4KU=;
 b=nH6l9tYGWFdw1KihuLdU53yeV3fS61ZFc8+E7lXtpI4cp7S8XjYmOrp7cpJzCTlkc4LxTkGTKr8uhT0CrnnwDYQcVfTyL2I27k8EF+y9+0+7FYvfj8ZLg2r7XnsM4NPWVidOJ9NlXP0htr6IRvYYeH0krY3e2FKfpE9ElKUQuTa+I7jipyn/3CV1+za+Hqx4LSAEjCZuPrCvXg6lL5Z2Fj6jYq8+glNcSzrwQF80qUH50dvI8DDLPmVM6FxynOUrT44Ff74vz1D1lgJC1kN0GKqxXGCEZUR2QOtqh8zoTZ12bzMElk1AuraTbpGK7u/LGkKpAydYUBsOrHmXfaCUhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omxhB7lvu3aF2Lb+pDAie0Ir0FqgYtULcE74HWha4KU=;
 b=rqsDHgAqMRdifZ3+EK4mRqJgJac67k5j2y3p1a5Prn4A5vAzRz0hs1ZGw/AlKk6uO6cJQ+atCzXGeR/So1gdZFcaJfWofs8TbrU7FwpKL9R6vRlU1zamTugFinuo5Qm1dBG3GjvdgPlm58Zmv3TCVXdVWXK13ipwnQHkcwM6gYG3VtMgspEzjq5mtZrsZY0QE8GBqaSl+QgM7C2yQZAqytpbVBo/LhcNQ1+zaQDr4NiIfWudcwjElKvdUYeiq9SIH1jc2rffNVf/gLcVZZ1JcP35/i4cR2AiJXDwNsgmdWm8ds362v0h1mWMA5lf/EvPCvvk+RLe6QMlYFo1tPSwfw==
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:128::9)
 by ME3P282MB3185.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:146::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Sun, 9 Jul
 2023 13:33:10 +0000
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f]) by MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f%4]) with mapi id 15.20.6565.026; Sun, 9 Jul 2023
 13:33:10 +0000
From:   Dong Zhihong <donmor3000@hotmail.com>
To:     chenhuacai@kernel.org, kernel@xen0n.name
Cc:     ardb@kernel.org, tangyouling@loongson.cn, zhoubinbin@loongson.cn,
        yangtiezhu@loongson.cn, donmor3000@hotmail.com, tglx@linutronix.de,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] loongarch: Make CONFIG_CMDLINE work with CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Date:   Sun,  9 Jul 2023 21:32:51 +0800
Message-ID: <MEYP282MB2597CD6E861D659E3218148DD933A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [NYGtxBnB7aBhmU4vJ2THA4oKpWlbCF9egH3mBxg7273/LlCuc43YnVhOAMCPuG63]
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:128::9)
X-Microsoft-Original-Message-ID: <20230709133251.3696175-1-donmor3000@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2597:EE_|ME3P282MB3185:EE_
X-MS-Office365-Filtering-Correlation-Id: a97a19ed-96c2-4d48-e78c-08db80810986
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TVxMCof6kCq3WuOSAHUXfYfk1Hn5zyo56zimuTPcKMkCefqh2GGK3XeP3FEETUqrUo4ZSbmGinaS6sbbLrXsr71WeWroJQU3xJAeVV2YVoA5DheH2+Zd5xwzQq1X/JzN0D8sYFRQqIrFed/435JTeQKFQfyumXTK+Iwjlov3xBbgqUDMukqxggj73tg/71ym6jEwREw8KcjHo2zMLa8mEy5FDFOfEk9jhWG+M7H4S7ARjW4XwKN+ViWQIdI+xE/VUVcIASCVQ3Z9EOrowPOAfzWoB1uN3mGMyP8gR1l07LzG/UlMI6V84efKFR2w9cquUMh2aCvfBZLAWPjgncpu2SdejoSgp0uxAGuDz5RMmP6mRviQA1K6biZkqLOnYDNkhIuv1m/X/gcwMC2ptAe5S7HqvFrilwN5NKupTFzRMAOTLPQBLsn9bhB6tPttWWtfk8fCP6UrSYDuDsqvjHYitX4fiB66hgOfi7DpM7ZbstvZ9uCrbViaKhcCKxRYw3K55xHUPzs8WFIwpGS8fqlkSuDNIVWiOttwrVQVD2gw9m2PohM9Mnhg5cj7ZAj+h8E5hKcRJMctTcIsi9m30T6VVlVBEMIqOcqDwurh7P/M+VXpD3V37G45+v6V3ne6LGwz4zPVJuhnIuuEsaPPfVKpe89B/wJyGlj41nm4dTMHdW1+rimidp56RzTWLlmkUl07LzBdNDzSEOC+JzcB7/jkwywpV1htmcf9RpSwVpJlnqjJzDtwMkCjgt4veqdqFA5qCLhW0x+CGx0S/RxHWVCkdiWaP8vnOFWNFg=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAi8w/p8mfmT+TMEuvxmg5K3W/IbLk+SqMaNGSy4dLL2F+qGc1OTrzjhz0EVcoj1/QlqsymT9v/zRf+C/mPwkJZDXA4YsPSUgZT0idgwiFQOlf8wW+NVHNXsovgBJMVv0cLVl1woByQGBS67yOfZgXOWuuRJuVPs252qxf0HHDRa7ofZuu141ywQ/6rev6Q5GSZwEpoFHGJ79F7VAfHhhLpUkSwULCmMaGm4t5AIgivjj/d6CT34goAG7fn3QDWoqr7iPErawm5DKL++Kcj/RZmFifwJPVzntUQlUA3uw5+VDRIHKV/DcVMu58oeKrpOUlyEbDtsHk1u6RMdywtnCtjJMQr3ST50l9UzZqi55Msijx7oO/kmrK6uYACJ00Eil45Fcvb5qLgNYHiQmajDHEaa91NpvuGLuTEyKQwZwyjpYZ1VJSnF0AXBOWDDoxpghnRe1yjx4IvqSIxI+9YvyTNgAzc+RPukO63WboxUgOVOYFHAOFqBInU/QLakiV2CkReNXrnnxB0ZgRP+Rwips+9QPHUyo11rk5NaAaadLtuiLjX9YD9OO6zi0qRJqADT5O5rAoI9hI56tLBUrTON44zITOVRaJejb3Eu7PP76yVN/0knIF+KdBibhieB21V+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z0U3OjizK2XbHaCL5Bgep4sKecG6HmZDJUvHuhZnyiCqVQl9fyl2jzT6eKsa?=
 =?us-ascii?Q?IV/dl6WXGuzDEaZg7Qx0J3wNzHMKrUGL7z+UxKAK+M+8jpDFJL7bYt0m9RJ9?=
 =?us-ascii?Q?CJ7RA2IIRJQdbxHONxSq2ypKY50Ri32B3N1U2LE+GIe577BlAJg5wcHCAZEd?=
 =?us-ascii?Q?bCR3gf6ClFXnH14LcnYQFy1ZOGPD7N8asiJG1C4kDI75WHY1EecpriIJgA/K?=
 =?us-ascii?Q?xyEiROGGZCEZLqs4ZqNqfu247ryiTkHZyx1a0dBxppCQ6YHN5jwJ85+7YKm/?=
 =?us-ascii?Q?RYKi6qfMFR6FGWNPQFg4N2BlvlgqzwdKAXJHiWWASZa6sCN3DChBZpoV0Ylp?=
 =?us-ascii?Q?NXDP9ylEYpPbnwkYZx/E/Tyg25SDMg0R3SIvRrt5N/rq07+L1FjD59GKMhR6?=
 =?us-ascii?Q?ap5wz6BHFqBxJUUpn48ckkY48nxdPDQTfjk4rRtAoBbF3dF1OeIVocyoG3CT?=
 =?us-ascii?Q?/oL5wvPA6IpAwuhQWq5yPE5ebFg99fInzAn5fh6cbgwUtodovHUJucLCgKC0?=
 =?us-ascii?Q?d612BKcCtiAvn1+oxW1IjfpER9NdjvE0KtrISOXmPUU1rQPxRwnTgJdLTQYr?=
 =?us-ascii?Q?VzJh27p5lc2rK8aXZ3S1MB2qmwu6VBRADZSH0eam845Jvg6Zf7gQIrrHl0s5?=
 =?us-ascii?Q?pyC4Ar9ETAW32imPXFExzMYL9vIb92vwtYql6JjZFSphXI656TKAel24gVI9?=
 =?us-ascii?Q?R6fu4j8MVfuHe8ZGt+6AN07UJb6f3pC/c2mN46FjKEc48mrlwZ/WlT06uPop?=
 =?us-ascii?Q?VynDpK/JmGutm4uNbSkj7V0jczp4YzrA/NQJJKlxtI/KfSFb6ybFnnmtAwyK?=
 =?us-ascii?Q?6H1wZJO2B1M2UIBP0AnrItqQi6GPEUXnj+yV+ZntKcut1PXOH/6zd0Sk3bFu?=
 =?us-ascii?Q?mwYxz7doVfWDQQMf6IGrRofVoG2oVm4svmmxSMLaaXvsHoF35N35753Uzlx0?=
 =?us-ascii?Q?GeQ48oiOc5VskAI+2UsREmcf65DckS6GBhOG0NX7BMzHZPcIOWgviEus0bXq?=
 =?us-ascii?Q?4PuACb3b1KVjGyPHV/QoI9No+Zq8E+6dND+II6Yn1/IPp4Kpaw7Pb5mHLI/5?=
 =?us-ascii?Q?uw73ady+XxtbO/SbtOP/tklaXgfxT95a++dDXxo416X/LYSl0n5bPsO3398K?=
 =?us-ascii?Q?5HrvI+6Fnc8JdpZ9hWWs6HNArto/EupgjxvGXn3hDiHA2ihpPNLP+XT8O1AP?=
 =?us-ascii?Q?hRY8hczgSZPB2Jqn9nq/C0enwmXAk1So8yHFw9AY+aK01WHayWv1pLsujJjY?=
 =?us-ascii?Q?SZ9DkkhL0mcKSbQADbLhlYJwcqt2WIT6mwBFbqm+GQOTqn9fqA4JvfVc5pnD?=
 =?us-ascii?Q?tKY=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a97a19ed-96c2-4d48-e78c-08db80810986
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2023 13:33:10.5883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB3185
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tends to fix broken CONFIG_CMDLINE, which is not working with
CONFIG_CMDLINE_EXTEND or CONFIG_CMDLINE_BOOTLOADER. Some code is absent in
arch/loongarch/kernel/setup.c, which should handle built-in command lines
in CONFIG_CMDLINE. The absence of such code causes CONFIG_CMDLINE not
working if CONFIG_CMDLINE_EXTEND or CONFIG_CMDLINE_BOOTLOADER is set to Y.
CONFIG_CMDLINE_FORCE is not affected.

Signed-off-by: Dong Zhihong <donmor3000@hotmail.com>
---
 arch/loongarch/kernel/setup.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 78a00359bde3..504218b94879 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -335,6 +335,22 @@ static void __init bootcmdline_init(char **cmdline_p)
 	}
 #endif
 
+#ifdef CONFIG_CMDLINE
+	/*
+	 * If CONFIG_CMDLINE_BOOTLOADER is enabled then we use thei built-in
+	 * command line if no command line given, or we append given command
+	 * line to the built-in one if CONFIG_CMDLINE_EXTEND is enabled.
+	 */
+	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND)) {
+		strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+		strlcat(boot_command_line, init_command_line, COMMAND_LINE_SIZE);
+	}
+
+	if (IS_ENABLED(CONFIG_CMDLINE_BOOTLOADER) && !boot_command_line[0])
+		strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#endif
+
 out:
 	*cmdline_p = boot_command_line;
 }
-- 
2.25.1

