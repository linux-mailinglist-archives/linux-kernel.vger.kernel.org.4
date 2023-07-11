Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0106574F014
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjGKN17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjGKN1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:27:52 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2169.outbound.protection.outlook.com [40.92.63.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D78134
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIDigr9Hzu5KMxkRD+Rv5/45eue77iSvZJvSdXnsVCUBRBM9AXqvel9nQbwXSCHMJniKyonI6lsXDUZLqPzVTlXv6GpsMA7l71MdQ0+jRJ6WrMFjC+AE5D37+Tv8Tz7Szam+F74Ylw75mjHlrurCqdpRmRR5UHQwsEWW5dHivvVC4WJhx03JKIsmbBF3UjwN6J0jZzDRipaOIUQmIbwTa03OvNfrk9f5Yzc1wBJWcNNVZt2nQZapvjOeiLjlg4wku3YTYP+JuDSEGF4x4qus/EoePhdBDxSACl4Z6XUuOKUIxkrqzb0It5A/LXMrh/sNjQdcuY8AxNMZ0WTglcM76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYC5mZp+WL9U4g6IwgKd2wLJs3s/0PjaaM6CGDw8LSk=;
 b=H7IvxFQE9dUzbBmZGRnz2wgKaa9R9FzyaK5a+SK9EN4gbW/wBRtfbVU4Me7J8qnST4+kxiAYoy0TAGUR+bykzEllhUVM84GEsbedrMJTO7gDS9G/NzvnawJXQhWbhlQGC54VlV5o65lzPDMeZE3ztNJxV1Sr27KJEE89mQxtRhHiSvcoEDHVD+fKB/LGffKQ3MnrkkSTNvR81i1AYRYm5xaoVBEfsGb7eAmyV7OfPHeYWJknMX/7nR1N/ZRmOta7ev4dfymlTs904B4vL/W/Ljac5/V+YxN4mqffLUQ7cK2bMpfJGQEkiGEDOebKSucemugJUrTUMR4GekKvzRiiRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYC5mZp+WL9U4g6IwgKd2wLJs3s/0PjaaM6CGDw8LSk=;
 b=rhSg3WFKFfyCzjt5k5ITXxAKBewxAqQ4zy1EVKFj44ajfoYzLA0drUZDw7gnxMY8vTKpDjPMnqXPZpCoHExveERqE58YSL2PtTFk3+JjYCIKz48ff7PT/gSkRfP/38SxMDdkLdZQonHMqR55To5U+uJ7khgtwGFhinD9oA9mHn3cZjz/8UxNTRl18txbWihFKNzhpR+v+VAcJl0ONUQG3X+pywO0sjctoL32O8JTiIDpiUKWmBAbmfyYGTrJBjwNngE/wJS0XT0AblvPOEKLZOnJAPDSdTkwYVDd9Pnkb75eYaE35SvcmMx72jFQNp6FbG+NZ7Ry7MrFD/msLhiDXw==
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:128::9)
 by MEYP282MB2800.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:155::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 13:27:46 +0000
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f]) by MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f%4]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 13:27:46 +0000
From:   Dong Zhihong <donmor3000@hotmail.com>
To:     chenhuacai@kernel.org, kernel@xen0n.name
Cc:     ardb@kernel.org, tangyouling@loongson.cn, zhoubinbin@loongson.cn,
        yangtiezhu@loongson.cn, donmor3000@hotmail.com, tglx@linutronix.de,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] LOONGARCH: Make CONFIG_CMDLINE work with CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Date:   Tue, 11 Jul 2023 21:27:25 +0800
Message-ID: <MEYP282MB2597022C264B501FE1B9C40AD931A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [3EzGn6rexepr4m6+Xn1W4xZxmqC4CKf1wfVRfhG29u6F6ECwse5uJCg++Q6MklfR]
X-ClientProxiedBy: TYCP286CA0177.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::20) To MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:128::9)
X-Microsoft-Original-Message-ID: <20230711132725.3736326-1-donmor3000@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2597:EE_|MEYP282MB2800:EE_
X-MS-Office365-Filtering-Correlation-Id: aad3101b-d09b-46da-a8b2-08db82129d30
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TX0vpKMQo3yIkRA/xfh+JfFSuDWJK0S1ze2t12/yXHnU3hbHq47GUPQmpQ2MHlvoIOAkYnPrKQj9aM76bgvEhA0ZH+6YsibFDbJVZDyUYQ1aI631ly8/uawl41/sT2poAwrpvdvplEllm2m0StQWN0lFUgsUClsNEFPk/DJ8VtGkiuheP5AJ7cVHRRv3rctJcUcy1mz1lt3pmnyzGxVH5cJY6Cgm5d+FdMY0L5vfL96K3FquYHJphE09bDVY1pAbnkvvG7jwnOWHeTWkOiwm7CShAFtK0vBfQX5rygd+FmFMtbxMGelYacPJHFIBYZAVempzxVQofpukPgbIxBJv4B/ZxTW5ys2eiSYmNkNoW5VGawb8PLmPOLzz9KUSoCsUOaT9uIEC7ZN9tq3otanqe+Ua+fEj4q7aC0A8GyI058+M8krdBi76VuK9y1PlKNp6rRu7JoNV8pN5LGqLa7mwqJz7Xrt7altXdM9htXeNKNwtjfRAZkIxG0kG8Mwk7RApfbafE3oSV4QOZ3+zLVETEzq2tH2E9Q6hCHrJMcT/8LyVVy2HqP6IkouCYu1oj9Fru6stfpGXKGcBM7SbyOG+fblcL5jRiledK50sCd2n/IKAdASv8wpcb8LBckigidx7saMH5oWvAYfV3TrkMuOEl215HJmLPXoVVSBr1iW34/xtEb/ZbJ2G5pnE5Bug5L0ha5bN+W7dEgY5wQLSTXBFVX0+bVAacriofRcJVF4F3Wwceo/IHtVXSkKRth8QZk5KkJEc+ygYNssTTXbcJCSh0kSoZZ38HCPvqs=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+ZcnVBOCNClXIie2MbZr/fC3adZk9bx73+sT4VxvDYBDacNiNS7ORZcRcno80GApdjLUjrad28eTRaXy8ngwZzM06WKW1OOQ9w4X6OZD86XZHFw3hxHKRfE3t8DlTT6le58adtLJOGoLrD/s5jZG3pBeos9bhrjS87u+ms42H8CLXfRcOhMK3vlk/Xekese3Yf8/hr1Xgqy6EkFgbg+Vy0I9UzGxwhkhioSehArGmGguSMPRSoJZJO8m9+fmnm389VxEUDeMElHRmPQ1lm8qlsV0Q8N62WZjsmFBOl8TFZON/7AmzEWSdMQcjfMcG5ILBJGp59aT08kCLci5dR42aqOmvVoXhNu1EGM8bC75ORdGYDRlbSeqIJV0KPG1+FO5W4oXor79UULb/xF9+2N/JchhJ8FTUapaAXPV3fedKuyIgSzC98bc/1Uo4uvDcBmnowHbSLgA402RN4PU2LaAqsVYZMKHUSXKC9yXn8iYS6X5goOiRyXt05jGiKXw7cq59pKtfzxPch7FbsCLt6wwjJy+POpq2Ems7qKDDbMQHydj10/96YNxuOFY+GPY+v79WiQ07zJZOYKDi+imx83CSdGzTWUPYFTqAzX0E635a6gFDfSAdmbj/D+jVqTF/bk
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dHOYRj+m+yPuiF73HyPFQhpgfit8LUEnelmEWmzZorsojvACAwLJOrpPBlIY?=
 =?us-ascii?Q?Ib7bt2VaLAkPZRm4PxhYylRgxDQtZGixHDn/CUvlVm/52XxUchhC+nZCTOhH?=
 =?us-ascii?Q?L4wsvEl2V/plKinY3vj3J4J26sKZVa+qCl0UfP8cEhUAFBwX2djFywnSjtZ6?=
 =?us-ascii?Q?KnecEjOUY2bFk4yjYYKa8RausC91EjaZMbQWyQ0sS7KK5VAu3ixFVxCa5laP?=
 =?us-ascii?Q?jNlVoyEiZFSIp28lwmnKalfrttv8HH3QmtZi6AFqMxdWbSpJ5AXNd+Lz5n+6?=
 =?us-ascii?Q?fSp68zR1gqtZGBQYuy/Z9vRWHV452vBC/THZPdIxHiYFCHgeSB+vdfi+uwSy?=
 =?us-ascii?Q?b/LLXcrGE1F+T8MW3ihEpMeiY1xPPkbmPUy1itSUWBGJTfGLV3ibaExu80AY?=
 =?us-ascii?Q?da0E9VzHx26ktglTIKj+l85Z021VWyc1Yew0/hOSF2skEEexTs3Ix+y8P2J/?=
 =?us-ascii?Q?hUIHhguIyaIuyeMcRek1hArtXFgUkJ0lsnX2+RBqFgHNL83qAvJbsNTsgLWt?=
 =?us-ascii?Q?3jwzAqGd+5Hodj0rIumvGsLATZVWPgd9rLYncZLeiVgJ4S2Tmc6DX2A96M4r?=
 =?us-ascii?Q?hu4KDdnRl3OMqUr68eeG/zx8v169fsudF1qIvyobQnDxwGXNHG3q3/jFFllw?=
 =?us-ascii?Q?rIyyYUZ6HKAUbGwiwE869Nx6nO4nX4gN5v4HcY3mlvL+ICLl+96T/qYG1n/3?=
 =?us-ascii?Q?tPqGAnZId7S7N+fklUbLUE0YJ2HR0uWVr4eLCUFyBKSmNCpwozrff/pZPRDz?=
 =?us-ascii?Q?kQNYyHR0jywaaH5LRmqvAYwRfiM9Uha/xsLoapOslszT+xd2BIbEQ7zuV+IQ?=
 =?us-ascii?Q?IBmxEIfBgfqS39AoO2sMywOoh6eLwGT23qRddTJoUuKOLsRpJ+9C06y1mj7Q?=
 =?us-ascii?Q?IhR3+sV4yziUPgfInQES6Lw1XNZIaIcdlOd9ku+p7QmD53A166/j0R8hMx+f?=
 =?us-ascii?Q?tZkSFy5+0BQuRi/jrHlAe9wnOJXMJRTLNR12hiuzUTdHZauHmblmIOj0JAe4?=
 =?us-ascii?Q?+P0Ew6/vOfPHP77cDtWFMQweHF9DR3ITaZHJL4+5KgEKR17P0aa7OJ1V8yhB?=
 =?us-ascii?Q?7MZUf/IAqNaaUzM5x+yitHmmoGOyD95yU0w5S0H1ZgExF7DIkzVkQsCfvbyf?=
 =?us-ascii?Q?6VjSTAc3LxGRq39QvE0bFAzGMzIrczknwpDEWVpvNHt7zxrgfwiPcc+unpBh?=
 =?us-ascii?Q?ORX0I+g3poYX/7pGE61DpXoiuwhPtRGKGuwMwT1fXFZHp+U2nX7/aJowYCto?=
 =?us-ascii?Q?f71WwY9zl41c/W+7CL4xAnyRli99UwOnM1/qY0H8RI3cdh8PsbE/rCrJO0st?=
 =?us-ascii?Q?yyg=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: aad3101b-d09b-46da-a8b2-08db82129d30
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 13:27:46.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB2800
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tends to make CONFIG_CMDLINE work with CONFIG_CMDLINE_EXTEND
and CONFIG_CMDLINE_BOOTLOADER. The touched function is bootcmdline_init()`.
There's already code handling CONFIG_CMDLINE_FORCE, which replaces
`boot_command_line` with CONFIG_CMDLINE and immediately`goto out`. It'd be
similar way to handle CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER,
so I added some code after OF_FLATTREE part to handle them.

Signed-off-by: Dong Zhihong <donmor3000@hotmail.com>
---

v2 -> v1:Reworded the commit message so it's more imperative (Markus);
	Added `goto out` to FDT part (Huacai)

 arch/loongarch/kernel/setup.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 78a00359bde3..3cafda1a409e 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -332,7 +332,24 @@ static void __init bootcmdline_init(char **cmdline_p)
 			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
 
 		strlcat(boot_command_line, init_command_line, COMMAND_LINE_SIZE);
+		goto out;
+	}
+#endif
+
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
 	}
+
+	if (IS_ENABLED(CONFIG_CMDLINE_BOOTLOADER) && !boot_command_line[0])
+		strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 #endif
 
 out:
-- 
2.25.1

