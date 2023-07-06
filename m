Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05DB74948D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 06:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjGFEGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 00:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjGFEGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 00:06:03 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2103.outbound.protection.outlook.com [40.107.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FD21FD9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 21:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFJQFNvcUDwpuhaaFCULLxdQh7ain0NHsjCF8YfUK2yqds5+gGW7rtxDCqM2QvCkW23W/u1I86X3n+xs9cWjBHaws8Q2AVs8s7TY4D6e9xC92awjMDspSLlms9Ofz7NmIHGv5NqoSj35+3sXFW+doKgNB0w9vLAtqoE0wq+iGxJqvJSmqLHIkJ6BHp2vJE7KD6a/6cAl2aQa/ogxtWERp34mQGvyS5dLXEqUAJcmyKS23kR/OKkgWtotstc/0pHe2t54KF53wJPVOtwcDys8tnpV++xx3DIUBqbtqAZ2XZwT+BsOr9qqb/HIPS9hH/NtJ/xgJ5PUJI/PaPBWYdH82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpV9uP0KD9gUWTTxcPL/CTt4JWL19m0zAlTBL/ShQ8Y=;
 b=QEN9jtZH3UBoHggKs/oNPbStujhPnoGUepSVe7ADrcBb0VqTwtmsxoWwqMvHnS2y/KfW4DbYxrwLC59uZ7/DNzYE6zSjafjibK2biV0jpnmYPUA4WmJDdyvCD4GNzN597RCgUET6K908R5r4NRYB5tBkVEwDOvqvpAE2QAS0rdSPaNwDjeB1ANIBUBq6ANX0ruS7yQc1cwJB2uOndCKCHvo0gZCQ/TD/5nXkpEw2oWlDrMoG/oD8M4jogaoccSVA4VigShMwf7Y7Sj4eWOcrbhXyBEUGMswyk3xXFNFSJ3sbhw8B+J5/lvkFRKK1EnPOe/kty3grY+KqOfmP1pv9Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpV9uP0KD9gUWTTxcPL/CTt4JWL19m0zAlTBL/ShQ8Y=;
 b=gVsc4GLow7UMce2XzPtDcgpOsXju1/JdQxicTt8bAVzsvOmL3J6ONvSUl6A0wnbsoOD5/MG3zp0kXAvaFY09gciiQVJtNCYZUwd1gRnrhfoaQb2Np8zTUYJq8H9ixxqd+z3tcvcdqn210X4/M/Gd79KL3vXbJ3eJ7OmD+/5alppg3gHIMUklPlHk6GsihomJxjXThR5cqLN8gdqgZKYCd8ddwlnIhzYutHagcwLH3u9e10b/OgciRDiK2ZZ2SEyA3e+B/Zq3rtxP6gLHIdgLqvdfIQ9ZuQYS1xt0zzGHboLsByABrTJv36cmX+mREllU9Q1diEMAIp5ljZb5i7EEsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB4548.apcprd06.prod.outlook.com (2603:1096:301:a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 04:05:17 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:05:17 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] nvmem: lpc18xx_otp: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 12:04:59 +0800
Message-Id: <20230706040504.34057-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706040504.34057-1-frank.li@vivo.com>
References: <20230706040504.34057-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: 80560b3d-dace-48f9-85c8-08db7dd63510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJBaBdx8pWFJOBRyF6SfinUcPyC6xYjEUqjFQIUEzqzaRPBn/Ud9xmagrt9N9/8YZ/isxTxSKjVIEhZUbAbMOwT+LwNPljyoZP1Ubg/3P6WG4rNqT2+RgqoTIhbuJfuTVIzF/aVC1GSmzOkt3K9XP2tDQWCE7vt04sc/L5We3WqSM1Adq53KQV+q6kYiFEimulHY8MrhqZj997+AjJ3xFuNlIVVfbn555VfjckQ0AA2FDNW9wLZkGO5YuDqYrrQKF4FPGqxnByehp4YGN8Z3VuzwNaPHpxXHG7KYhQq5X72eec311k/8Gg03rOQbFHg6fcq9rgWuv+7ZfdMxF5u/RXiTlr+lvSs/1eXl5WcPWb4Es37JYN0v7EGXdUZ4/h7TstvuhL09SPv/275bTVafIjWCvyboW6bOGzTBWrhC6ea251hKQnqqlglHQWTY5WDfSRSwv7enL634hnisn9SEW3dxJMwcZVpWn+CnfxHTT02NVZkugzFYyWjvFZb1x8J49qp0LhP8PVbVgTocEx/NGzAUiF0zDvGvKwj1RKRMRjykh1ls1wMqFdE3jODY0VrLqHNJW1MSZ88QwbX8UVZaxM7Es7Why5vJ/IJjZeHobO6ExoYbj1jLqci5aylfG5WX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199021)(41300700001)(8936002)(8676002)(36756003)(110136005)(4744005)(316002)(5660300002)(2906002)(6486002)(66556008)(4326008)(66476007)(6512007)(6666004)(478600001)(52116002)(38100700002)(86362001)(38350700002)(186003)(66946007)(2616005)(1076003)(83380400001)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TVCb94ZAmn2ySh17+cmsaXGmP794DZUB9KuimCMmFv/Q1DEKVfWjxobSI/iJ?=
 =?us-ascii?Q?2jofJ+nr060d3rAY1Y3EMbdm8WqeaRftbS0T+z/D/Q2L0fY7xnxMAcGMumlh?=
 =?us-ascii?Q?0m+cwzTtiHkuhsJWKJ13jWMJ5VA4fr6oLrEpH8jWrTWnTJC3QJTxO0rogm5Z?=
 =?us-ascii?Q?4vh9OrPS2lpgb8Jo9Kv2AQaBBJnI0NDmNqGwYnhtdsuiC6v0RugZtdyMw+Hq?=
 =?us-ascii?Q?lm8eMRKqnTlxrdNW2aLbRjcAIKYhvpfDXTmJagkkc7zzZCOzic1VqTDvS0oG?=
 =?us-ascii?Q?A1sNss3KGPcPVAAWmyaMzt9MhUSaW3cPSXXAsneahRj+rZ00zqvVSt4exmsN?=
 =?us-ascii?Q?zmZmzVaLvVA8waYdOz7g3cOyT2f7mdSuUhyPrAP7k16Zt1gkvSzi2NldAPjH?=
 =?us-ascii?Q?uU1XqksU2BbVwLGJZpxM4810qyhCSY4OcxvJrPUSlJHMbcvkkvRMgpbbuRDu?=
 =?us-ascii?Q?46ERbL2iBiuYl7JMvvCFvbbU+yweWFNZ4c8Gk9weN92SC+sH0AZVsifm81Jm?=
 =?us-ascii?Q?BALl7EAuNjuyCY3pM6/GAUuWgccl6WUYpK4TTEuxzo21+D4Jxofst7LdWSg5?=
 =?us-ascii?Q?BG8ofCh6zH575nf6nXH3dgGNGR4dF6o/PZW38XC2MPwbWWX9XRf2GalSlWjy?=
 =?us-ascii?Q?ZT/uh+7YhLc1lNjM28YFLDq8HXcUH3Xb2qEVDmy4CLH+stvdoZrrDsGB5nst?=
 =?us-ascii?Q?VcXgCXd+VA+bW303QOR0CN4D7GPogWCH+Dcdyo+6mOBwfPPrkb/M7cdOPLh6?=
 =?us-ascii?Q?VSlQ6buwkDnYMd4JnQPSkuWG3Qzi2h1Z9wbB2+ylXNg9pP//7jaSdHExQT+f?=
 =?us-ascii?Q?ksPw0x28jRbKtAxVBHqRkMS1h7hiuJ2G6EGMT07BmXKBReKmZt1v2VmrIY/8?=
 =?us-ascii?Q?EQqbHdZ7OvwPq0AhRNO267KKbKp78ZRswr9hImls7kMVNNOHPoq/LsCOhDtb?=
 =?us-ascii?Q?Df4iM/AbLn/de7PquOBku71nKLkAXVFq6qdx3BIYSUIeVxUlsaJpb/4QF7qU?=
 =?us-ascii?Q?HFl3dbjAVFfAF3Ed5QCk2HuYxAVowVwSwYd4v2kc58XUGW62u71aqIsmfohh?=
 =?us-ascii?Q?HcN8Bolw1BkefiMHOC2WwgcFnYrFdsTNw/n1p/bn98DzeD4KvvhjpTSgfWiO?=
 =?us-ascii?Q?R8iEl9j+6hNs5DPPs334j+3SyTcgiuo7byXxZmywRMiSxbnaYEVlfTC0exqM?=
 =?us-ascii?Q?i9+MDsM8LFuY5KaUz0+WGEvzRFGXtHUeYQGhiwgEYgwij48mbL1ts7zVCTCf?=
 =?us-ascii?Q?YUA15Osnmc8KO2YceMDUJlD5pSbkUPXFTe6LDIm0UZ5h5T8bS1ElXX4tLvGB?=
 =?us-ascii?Q?6ar+kcrAH5ourVx/j3kUWOIoY0uGySlX1GyH94xlz+tarbkYM+FYWXn9trxL?=
 =?us-ascii?Q?YW00mpqJYdjTbgJFepvipiuPV2ULQhPZMGp0f4PQcHmbL7KWGVANUbBV+eW2?=
 =?us-ascii?Q?RSBJWrnX+fOoUwf4hn2T1+zLyE9d9w/shKHD0IUQPdK4iCKWLyYK27EjZw4S?=
 =?us-ascii?Q?5m0tomVoE7vy3XApMB+mDT0ikxloiIJPtKqJg0undHi9XObhLlwXgkMUcaC9?=
 =?us-ascii?Q?hxmWgP9B/ttotMnpB6CaQ4OZY97iIZ450XcVPTWo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80560b3d-dace-48f9-85c8-08db7dd63510
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:05:17.1759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dagmAYdQ0q9qWg2T+E0xiZH/1xCPATtTe52Eanc59Qnf2pQb/oXa1SUK1jjjRdVCQxl5FuENQrZrCdk7kfE+1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB4548
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/nvmem/lpc18xx_otp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/lpc18xx_otp.c b/drivers/nvmem/lpc18xx_otp.c
index 16c92ea85d49..8faed05e3cbe 100644
--- a/drivers/nvmem/lpc18xx_otp.c
+++ b/drivers/nvmem/lpc18xx_otp.c
@@ -68,14 +68,12 @@ static int lpc18xx_otp_probe(struct platform_device *pdev)
 {
 	struct nvmem_device *nvmem;
 	struct lpc18xx_otp *otp;
-	struct resource *res;
 
 	otp = devm_kzalloc(&pdev->dev, sizeof(*otp), GFP_KERNEL);
 	if (!otp)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	otp->base = devm_ioremap_resource(&pdev->dev, res);
+	otp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(otp->base))
 		return PTR_ERR(otp->base);
 
-- 
2.39.0

