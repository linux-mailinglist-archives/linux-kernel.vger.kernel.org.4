Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D6D74F0A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjGKNrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjGKNrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:47:04 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2158.outbound.protection.outlook.com [40.92.63.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BDC10FC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtsJCdjXd7uMn1GFzQWJdyen5I3S0ceEKr64rgWQfc1AoqV/fm77YuqOUtlEfCJ2mokJgI1lOnF6Ipee0fDx5/aCujXMQyPtPUnFAMmC2/rMxA4niYd3VoFOYvS93sNrGVwmfEpQ301/j3qWkWBkozAsH7mFA91ptq+3NpnMizDwjI5vWBUWr1flr7x9uU8sknEo/o8nQ2GolvAwHvByHC090iSW6kiTHrE9fLDWil+wND7QEClB31RjelOQj5rAjye+j9JPVVQM0Ki2Hjl/IT2afxlwEiAknyZoCXioFDKi54O4zVxjNHRbcmy0KrwUl72lFQvtHHgyDyimq8XP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCvp/X7U+N0UkiSMgXUxLVQodxkCAByu8EHTE1hXihs=;
 b=XAC2msA4bgUAQUHzclVe1kicUqeHPwJZlZ6sFmAiY9fyUUGizB+AbRexdehYCyDg2uPBtogBqMfUNonBQfBlYucxZta9al24GgtFktNGhtRwmOZHhtJIwRcHoen9hDY0VHDwRa3KhVMe9gNMK+YniLoH2j/M4ZO4Aue5fwvEPGuoaiIR/5VX4/pKVJrnqonIHS8lT8p247DnrrgQfMITcEpWItJwhaJWhFgu8FEa7mXz4cM/Sbz1e5cOmECIeFKnqiO1BNwmLWMELwqtxu5GaKw42g2D03rSddkC3vs/SVCkgBrzG88QX7JYzf6MhdVP5Sz03Ksgq1sPtpXMvyUoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCvp/X7U+N0UkiSMgXUxLVQodxkCAByu8EHTE1hXihs=;
 b=MOH4Vfjyc+61ueaAjmZYWDk/6m3IpZucf1OaRafBpiYnhC5J0dPO2JKtJifOUh8lxzZFJRVYI5dHE3aPeMGvZFwWBO94xTRCtbATJwIiGiaMGTkGAlS3sC5NELdH7HYT8eIKJtsQlBFE0LtOiNPR7gJWRzDLbgUT29I+ZGWqDCbi4uiWrN/jiMitlsxuNkeLJ2k0EXQil+RI1tQa1btw4ztselLi9CTREnSdfAek255O9c9wN+ABYzGLxW4XvvH+eFP7/qPhWtNxHW7fxjVrr+6mMK3+wfDuFqH3GEDNm9tkkX6wTH6CUwKW93AOrVee04YTSWIFlvCFC+RysVSmWg==
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:128::9)
 by MEYP282MB4155.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:170::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 13:46:53 +0000
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f]) by MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f%4]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 13:46:53 +0000
From:   Dong Zhihong <donmor3000@hotmail.com>
To:     chenhuacai@kernel.org, kernel@xen0n.name
Cc:     ardb@kernel.org, tangyouling@loongson.cn, zhoubinbin@loongson.cn,
        yangtiezhu@loongson.cn, donmor3000@hotmail.com, tglx@linutronix.de,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] LoongArch: Make CONFIG_CMDLINE work with CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Date:   Tue, 11 Jul 2023 21:45:41 +0800
Message-ID: <MEYP282MB2597B4BD3CDA1ED340691C9CD931A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [MgJygUeTMYcr8uxQ73jZKXrF5vLJwvZw8oVVwrnEQUrVREO54NIeBi5ZvdD8BB71]
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:128::9)
X-Microsoft-Original-Message-ID: <20230711134540.3737578-1-donmor3000@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2597:EE_|MEYP282MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e30e647-c0ff-4cbe-878e-08db821548fa
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TX0vpKMQo3yIkRA/xfh+JfFsx6TQdTdyDvaa/qFOUmlJbm+/gVVwi2XmoVhQ+vdAK6h753C3kYd0G+UlfuyWscPk97VNf/2FSZhNL06YpxgoE+puZKiz3Vw6aR0XbEjQZtLK+6LfvArU5fTrfiz2ND4wQIFl7j1QttrmcahUu+fN1nWd2tZPFf0HSZbQ9UTZHmPdKMNJipRDleA7/ODHSDbU7gnweefE3CflJPbd3hZHZMfs5b0CvHB4lwATJz4WND17gVGOEKp1fe6pxttH/PmleMTaBtDIzn9pqcbp4rDX3pBlXX0Gzw8chhZ9gjxEXDqxbo3PuuVdaDFKLXotZL2JWdhTFOVmUJ0V1IlZc3UhnOim7eZ8V/flmXpyfjsIdFY2iexjeUyPsHJb1dYx2qIBPK6+8Y/kwtvGU/iZvn3NPUK/f+th6oh9nMM+8qaUWL63eX0qrZvg3dm9FTK6ZIUhs/ayOKdgN6EWcCyAzJaVxayD1PXS1y0n8NxO4bKLKqgzDyfA9yp2JegqRoBa1YbrU+x9E92X49vPmd2HgFECFvjLBOBh8mdsKYGgWRN287BUn0i3l2MYrQM8vrqj/vW7IPPsjnqT4hKs4EClOFeR8k5pgIZ4eqyR+hZBWaRloP3n1NzluFkSRr+02/UfeyuqnXqMMKWY/hZHjhG5GYe94Qb/ym36kfLktDrlWZ/ULPXapxM27WS//veb0OSGzk6hpyXjJS8LlwW0/Qb2LDKkzyQQvXAkyWWY0aKgwgpbk6QOmwYE+ZLFTO5PwbOZ7IIHPn8y1PBNuM=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RzAWoI8YBZRt+9AYNfNOo2lxvWo6sMkx3P3OnWKVIrAHwtbvEhe3fOhcGhd40i0D7BnrukgLosf9oCweO8a+4BaLLrTYu6VTmFJDAqKZ71UgO0eiHgGzXdJ4pWYf6+EyVO/UUBGx9GLqFvafYLeWFvMlUjfLtLJymdVcfsMCKLahlAAafKF1swXREifUV9QVg2WkENdgULj04tfCV3s/i3CDWzFh/QpAozTw9fpkKtbk73El81bwqMUtRrhLaIQCF5ISClKtgacj5s5CwUFWSs/53CISExDndcdfm+S6opqdyh5H9EvTFvmstVy4PY0NOTQ24oyRVGCN1l8QRVJfWioMD+2wLvv85YHbxyO2CGK0QjChWeKKvelNGKqd8tQfURcX76lQyBzU6EuixpSdHhyRjR1AINeIuKf8vurwg7NdEktOynC6j7+ub5z7ps1Ri2mIVB4LZ8aMGUt75IQ3mUpRrhn2TqfUYrKKh/iG9OEZk1yesQnbb2A81yGc5pVlXU+BRfDYbM0LDAPe+TclHFDs1Yuqdhd2gys8LJ1Rsi//tynltGxUC+Z5sjyeHf3YBH2SfzeEftHMBEhfQvz8Dfn07xpr9tr3WynSxa6M7cYgrFHzH0JQIZWriqeZQ+zv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Zop6i99p4R3/1uInj6RUcX2a0ZHchMDCWWHgWKfasXC4TQ9AO15+HbJopTr?=
 =?us-ascii?Q?YAbmSM3wBzFhtJ10JZiq0N6NHSqUFM8qJ5rTrHGbDdQUIgh3D7S7v+WNmzpr?=
 =?us-ascii?Q?gWeS5LKYZWAKhFmJR1e0fMKIg1fsOFAEBzIClhH8xLZIa2UXRrVkA1VjDyRV?=
 =?us-ascii?Q?o2RHr00eo+mAWf/NlzrgkZMmvTsXWv6idlo/BwUFLJO4awGxjlJwEytDakRE?=
 =?us-ascii?Q?L8PMeH2u+JAnf8ewqEsIWycm8lWC3qbghVVyEE25dshrLY4lPfhwmhBfwAEE?=
 =?us-ascii?Q?3aYoMWEhGz+40/aBG0Rh52QG9qbEa6zO/z0DIP8RzPUwtWgMlyuXSSewkNii?=
 =?us-ascii?Q?hAjYqAp5Xjf0lkbkzg0KhuNznq0VG/8AppX+squy+kF0aqQxc2Pjd1R8HXdv?=
 =?us-ascii?Q?Yn8VXMP9VT1298wSFb8dSoyr74LMivwkwvggzWuTnlAmTehYdyd91M8oCzar?=
 =?us-ascii?Q?sto54oIOmnHIHwNwTHCXqm5pNRAAQe5xzKYJuVK8HFSFowL3771HTXdcanH+?=
 =?us-ascii?Q?ozQKIujVvMmgDDn+qlQpSGKPo+w8DOqGpBzghBK8laIppMNO3jMGitwaDzq1?=
 =?us-ascii?Q?0l7XGaiE4ymJ5YXJxi1HA6vFR7bEWfLrSodC8LPEnFWuFsqQHE6P9WkWVOQ+?=
 =?us-ascii?Q?ysgQvySs4AZtxXpYZIIEqXXSwjQHx16xg2cMONoBzjYEh/dKT2dl+AyeJ0Sj?=
 =?us-ascii?Q?uPva3u06aKre5k1stDOX1i8w264ynctIDJWlwzuQy5+IJeFL2ZdWAXUgVJE6?=
 =?us-ascii?Q?0l1qmXHw0HPGxuxkh7Z/VXDkQuvIEm3d4kl2+/d1sxajYTLjCHamY4J1iKFh?=
 =?us-ascii?Q?kYaFnxzLrNyDG68k/nHWgsjUFpH0SaZOuzNJusBNLU9PemWsep7ugVrocgr7?=
 =?us-ascii?Q?eEEEmH6QAtbGlYzDh0V4eVD8XC1DGFKQb8aLmbRbCmx9pxxTlbkNYy4ShgzB?=
 =?us-ascii?Q?joM96pRKwLoUjU1SWlD9Bg2Yy89cXIL/azsHBS6Tikyg64EcOjPZsV9wP0/c?=
 =?us-ascii?Q?dxGDK8kWoxvjoizxjuSu7/Osvj26kQ+Xcbmgs9ez6VXgmmTr10MifIWwT0W/?=
 =?us-ascii?Q?MFoKUDdUjQhs4QgQAFt8RL9n3YzVx1+15J3e2jC3cCTBJvXOJoAfyxuZhlcS?=
 =?us-ascii?Q?2ymNVg5mN7Q4alZXRv0JqaQLYnqwRJ6GY6GK8/9I8xbwSZSWvVX0seizBcn/?=
 =?us-ascii?Q?svpYiNgNXDJtAZbEzdtsKAaMr467dzCTpZ+tlE9szqDxvg3l0bEvDZvCi5ko?=
 =?us-ascii?Q?hbtkmVQj8TJ/vwZHb9mtzIGNb2Xi1dSCYx/eTbt2iY5l3CYeMgsfLYJLCumN?=
 =?us-ascii?Q?VWs=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e30e647-c0ff-4cbe-878e-08db821548fa
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 13:46:53.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB4155
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

Make CONFIG_CMDLINE work with CONFIG_CMDLINE_EXTEND and
CONFIG_CMDLINE_BOOTLOADER. The touched function is bootcmdline_init()`.
There's already code handling CONFIG_CMDLINE_FORCE, which replaces
`boot_command_line` with CONFIG_CMDLINE and immediately`goto out`. It'd be
similar way to handle CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER,
so some code is added after OF_FLATTREE part to handle them.

Signed-off-by: Dong Zhihong <donmor3000@hotmail.com>
---

v3 -> v2: Reworded the commit message again to make it imperative (Ruoyao)
v2 -> v1: Reworded the commit message so it's more imperative (Markus);
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

