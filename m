Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F72B74AE59
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjGGJ4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjGGJzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:55:44 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B183170F;
        Fri,  7 Jul 2023 02:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6ROjTqtU0kY3n2hjPn+rGd9q+PQ0+h8QsVmOpzTgpxwXfQW5jPhCD6P79rnO1h0bPvMn1ZKO+GYDWjco+vNxypABF6MXQnhwFeRgs//JEJTlBKETGWb5iR3M6R8HRyF+gXapwUaLVPAvk7mPuShMtNhIbO9PvAXEAWKeEelGtme2b2F3sU1ObJPtTFEWD5mp/ElBl3dU3Nz9PDmOuaiVpQZSPtRMLbe8mQBz4qMhv6NOgYcT6rzM3L0Wuj8WQqAXbbo68h6ru4A5u7/yD/C4pGkfBdw2xpYCL4adz0r+1tBveZdKQiBYSxGbNky4z5WM185br5dBq6z9kqLcdHoXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJAvfRMxI6sMvI58Rwr8yWutZsD7z584ezavB/HPbPk=;
 b=Ixy1oiIQZwTVJxUXcTmfMS2M8T8eWQO74eC1UzH3S+0IdDKzAD65QRb4rtHJk01ixrF8bjfFcC+ax7dxyqgnSr2BP6K4QI9xVcTyuUJbnCdazjGn4Kvn7Qi+7lL0MLrfLTl+uvlxCo1H5yr5zT46GMki9Ojc6EHI0R6XiPseig/YkvCnllAyVCC9GZUYDitkdtKIYVOTwl7kAR++CvwQuAMOLPmeQOK3lTunK51BojmdLUdKHkrY5JnC9Pxhkox2tOiFebeA0IOtksiAchMbJig3mBonCuEMaWtp0ygylDtpyUstAsLD2fbqmTj0DmKyW8uMz7uoidbOcuDCJPyJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJAvfRMxI6sMvI58Rwr8yWutZsD7z584ezavB/HPbPk=;
 b=QdmUyFipauix35OKkexcgd6NDiz7MWFCJXWAab7xGkraPzDOP5ChIR0i1o3QbdAKmpOPvyUEkgFnOfM2Ep6NOXjXEWWtXD141+ZlPZbI/90FZ+cDjizJrG7MQBvSWgHVuZgOxVbrPuvN1EB6FJwoLg3L2Md/3qlFdNuTIlRnntbyWet+4SpXRRmY21viKE2E+gGYnu8LYv3WsqPSiAh5p4Iaj1zWPb8mtg8L691dplTInrO5MmM3qjOxUP5aiZtLGUP/gDHft/gF+KKdNeM3Zd00/KKGlHDHr3ukw7bTb+l1rRlJafuGb0VEmm4GBMF/f+SrdOF7wZACnbIhf6tMnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6793.apcprd06.prod.outlook.com (2603:1096:400:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 09:55:39 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 09:55:39 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/11] ata: pata_ixp4xx: Use devm_platform_get_and_ioremap_resource()
Date:   Fri,  7 Jul 2023 17:55:10 +0800
Message-Id: <20230707095513.64224-8-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707095513.64224-1-frank.li@vivo.com>
References: <20230707095513.64224-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYSPR06MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 021d4d43-fac0-4b19-e768-08db7ed051c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uVYZBrGfM32NnD/XPSDK5a45ZIojQsJiAn7s37f9blf0f8PyQj/psk/cKm77/fubz5pRmV8MAY+gfhSbQq4EjbAgmqffdNWxfKojrYOLkEKjf2TDCsVWlwnkAVX1jbt3SP3/EeGmSoYbG/YCiZekNmTqQCgEQg94crSMqtrDnCZu4PVk2xWtf5+e5J9AxaKee4RDPkHKmg3GPTLObB/P0IEqPmnmtg2AlcZemj9JpHd5NGBVp3ovD9MM8jP++Xvnc9HAv/i51Rj8mrlNXGxBdc+T+q0YswbDy2tFRTgN5CAxKVBjKBRdmfOgmfJXPmWKcNZVDBzv6ZDRZyEkHGeQ0OgxntXXPx1/EeMXsy3lTUSZiXrqeNI39rAllJ7aAbZTgaFz31RzYINsMS0zOWYC4z+Z4sLmwyqR2IU0F2un5UqMsZ2op8YHBXotwE5xI4+L5QhcI3B1gLRQWUk7a+iFpPRpG+3ewO1C80x1fn24wyVCEhaYOhQQjFT7rObMLylKLezM4Nht/va0hsvrfF4nn0wh97Zi7w7ftCn8pJBdnXS13fvSfr5vIFK+t7hSfO7KnHcs1ByjO2GPN8LBfqzKS1JkWRx4lkGI+u57NzO7V7iw32ypC/cyat9iedy/0+Yk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(66556008)(66946007)(66476007)(4326008)(2616005)(38100700002)(38350700002)(86362001)(186003)(6506007)(26005)(1076003)(83380400001)(36756003)(52116002)(478600001)(6512007)(6666004)(6486002)(110136005)(41300700001)(8936002)(8676002)(316002)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3z+Jn7UMwh2ckxLy5P0r5aapjaLzvvJdFgGDRnNTaZisuXCrxIZt59+OT8lZ?=
 =?us-ascii?Q?BZp+9cRdCcWnHAqlPOlMT9iTFLJKT4m8x2OPAcDlkbwwRvi7sgMbKp+zaaDp?=
 =?us-ascii?Q?pr9rWBzLxmxzkxeYQJgle0YgEJRDKfZMnWgKInK6Auu61XMozR8RleZ50eSZ?=
 =?us-ascii?Q?C2+DrJC05qnWnqHiCLAIUSnWxpyijv+dIJ+VAy7jbZo7DDcq6s8I5TGRDqZP?=
 =?us-ascii?Q?ruK9kbZJKBceRxUh1dqkU8qivTwGskON+UsZQIH0Zp+aRtpOK7DLOrFRLxW4?=
 =?us-ascii?Q?NvB+nAdodh1567etmVlqCqwXIDmGbiCi8qxoECs/qUE+DcWHMrnL8dP2FP4a?=
 =?us-ascii?Q?K8pEBWqmEN/0rv7VPoREJ4q3WF32YR/OMnmJQOeMZC8krTQtDvBML5KUeX94?=
 =?us-ascii?Q?XHwrqTRbNJjXsV9zG9Z6EhoBOk78IEwJBZBx/pTKeMtY+wsKVdu+CoTKZ3yN?=
 =?us-ascii?Q?OFni4qCTAJ4C8P9ySxtk6t7+m1D5rK7dbydCB1KYSKzIvD0KOSUwrRuHPsue?=
 =?us-ascii?Q?AJU5qUIL/OAQ8DIflDlndmtBnXoFc2DKl/tupvbueDs00CihlW5QNygJ6tRf?=
 =?us-ascii?Q?ofO9k3e2H9W58XAglNcQRKkeHvJebEGW5sK2jiSde41pVfImmNOG0b7ulbej?=
 =?us-ascii?Q?8cypDYlfCSQkcKly9ySgJtXVRU+9/68qNuQ5+zzOWrRp3v3QdKYY6PqLywbU?=
 =?us-ascii?Q?/OMEdFBSjWFfLT6Fpd83Cs11BkLIaLA+qVv6GQuHgIwJRuxzjrIvRHCAiLBe?=
 =?us-ascii?Q?v7rAFeo7YIN01aAHhwVpgnp+EWPIjeV64GEkaWtAyj1rhFbGYriKZXuIfOUj?=
 =?us-ascii?Q?rMopGiuiPml0VzHNqGZfQtkVay5BVQx4lX+zMYsOejhT7i5GZ5ufIE6BlKKL?=
 =?us-ascii?Q?QMtR6DEgdwJrkMIypQunIZ5la8dcssZf9usJEdX3pHDsfTiyK7nGQKefawM9?=
 =?us-ascii?Q?7HmPse8XZdjK7bc6dNSIQxPgw3fJSw0Uyfj2est4J+FBMukzT61UFUcLDoca?=
 =?us-ascii?Q?3eE1wJPt6QCd/lOH31yg5sbdsFS6akT1Nn4Uy2h9XMeD/szMB7blmsMpXJoJ?=
 =?us-ascii?Q?5TP/5TYjiPOY3gcbvdOmlBxQCXom/px0n6+a4N7qMevBH8aGqRPOciJ1DFrq?=
 =?us-ascii?Q?4kMK9e/g1GCpBQ89YyScH37qo3c8gb/yeHhLNx3cIXzjYL0huwBHWrRhPjOz?=
 =?us-ascii?Q?19E5QjW2nMWMUTaqivb4Ez+fzz6mKETq/NllbzFj4b2BfZPoXCBy9xGqv1PA?=
 =?us-ascii?Q?a54rzLHBZ5mueyf+BVyx7Ibvm2OzDQDCcGb5Fv5RCk7Z4/SzMnX6gEeLMVRc?=
 =?us-ascii?Q?2aFyOpiWtXyotAZ1YjteDhwwqy6KAqYYg/4aGG0wgPYKzffaxWcqifiElU+o?=
 =?us-ascii?Q?QxlB/mEb35XzWdJvyykBvJdZdryy4EeiO3c5WjcX1eXxQmpTAeGF5DkrtpTT?=
 =?us-ascii?Q?r51B5BojhtqTIFxpx8t9xhkG/vruwok88i/QSxbv69fhSeV42qbv5++Ki0HX?=
 =?us-ascii?Q?ZXyqIXOpbWD+Pj/4OaDJIIr6msPYjZGEL8aDm488dG5Un1k6ZNYca4HYHQf7?=
 =?us-ascii?Q?/XUoTCV4FttngTUHfiTDzClexrsd4EqbdXHwYrDF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021d4d43-fac0-4b19-e768-08db7ed051c3
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 09:55:39.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/VIw+l+pCyIcpV0mHp8iU9ybRfGiY6JcRObhNUPdljxbQ5iW9GdkB27F65XAqDMjWj1oGHTRwm/exkxLkmIwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6793
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/ata/pata_ixp4xx_cf.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index b1daa4d3fcd9..1b9f67e16864 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -242,12 +242,6 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
 	int ret;
 	int irq;
 
-	cmd = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ctl = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-
-	if (!cmd || !ctl)
-		return -EINVAL;
-
 	ixpp = devm_kzalloc(dev, sizeof(*ixpp), GFP_KERNEL);
 	if (!ixpp)
 		return -ENOMEM;
@@ -271,10 +265,13 @@ static int ixp4xx_pata_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ixpp->cmd = devm_ioremap_resource(dev, cmd);
-	ixpp->ctl = devm_ioremap_resource(dev, ctl);
-	if (IS_ERR(ixpp->cmd) || IS_ERR(ixpp->ctl))
-		return -ENOMEM;
+	ixpp->cmd = devm_platform_get_and_ioremap_resource(pdev, 0, &cmd);
+	if (IS_ERR(ixpp->cmd))
+		return PTR_ERR(ixpp->cmd);
+
+	ixpp->ctl = devm_platform_get_and_ioremap_resource(pdev, 1, &ctl);
+	if (IS_ERR(ixpp->ctl))
+		return PTR_ERR(ixpp->ctl);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq > 0)
-- 
2.39.0

