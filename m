Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE8F746E35
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjGDKDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjGDKDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:03:31 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2118.outbound.protection.outlook.com [40.107.215.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2781B18D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 03:03:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/UMsBjlZCuprUmABniPq0OBDOGcX4oGAF2kVlpoVOY7PMnwm6HuLsXTmPxw3K0Wlc+Ui7BfdDLp7/al/Lx87tZ7I2s1B8ZdtfBMrpLjzY5izRSxLdZtlowrZgzjYzTqmAbHtZSstlXHd+Ru4pqCUtiXtZa0CtSnnL0j2Gp4Y8vOBua4GQKZZ4QcocaU2xgxEsRMYGXwANFf3No3P4HphEswnRad1994/IaFfpeRsvXqy5uzQzgSsa58tBpoyCs3sdjZU/DQfheW9FoAomuf2zAUtOCJ/+XhaDTQRX9Vmd5sNfT/bD5lsn3K9ET01ptrnPrexYr0O51IEAYm8hgC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXtAQz+B6MsnmWVkybG3g+z23inqX3Zoa4OcbdaukDU=;
 b=g3Llo0OWSWkSmh1i0h+I9S4uE6Apv/VtiagwtY2+IWUKoQaKavice5CgEx7ja7wispR1ZmpKsHEvYRTDM82RBf/jRCh4hBbXA1I2Q9F2T4kFUTbZ6zJqGma5utQRcQ9Fydc3CGUemDLrJ3vO2wdny3FUnv0dbjIry2fii0ihVvm7sYkt4VZ8hCSrKHNWEVdC+yEh0ahjk/2f65QhHbz10M8dT8IWejEJclEHwYCJphI+fCb2v1eei/edr07ZCufRAFwa094f9AJAdFlltHjlUFfp4kUKvhzljYcrmDUmy8dcuUJps3bkXEUfBIxljBQP3WS0+PiPyCAJWke5SqV9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXtAQz+B6MsnmWVkybG3g+z23inqX3Zoa4OcbdaukDU=;
 b=HWXgGycpCT4ZnR0EnOeGzvoAD8xUX2SlncX0+JM9FK7HTQNzLrweasViikr9XsavHc4F/lCqesBtjEwpbjLZQuZyBttQ74iTwqKtTjtJYWNNF9uXOylj6sHEU5VBQli/JBsMWGmTEk12qrqGGvoRmujrWT4rnAWqrSGkQ6xTqdcMzlAhGx6c3pQUJJCuY5NNShlUbNHu9r4mcbrqxLqQKKzMyxuk4wB1rj36BNwroXKdzwnznIFxHhXOVSuXeJhzuqHaYnA7L8VrPK+n63/YU036OTcL5AjpHrFl/tFmy2kFkq2rthPyEce4fYfbFA+3r+peuQ8JM4U4Mf8RBtaUSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB4294.apcprd06.prod.outlook.com (2603:1096:301:86::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:03:06 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:03:05 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] irqchip/ls-scfg-msi: Use devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Jul 2023 18:02:52 +0800
Message-Id: <20230704100253.36045-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6ed7a5-7f10-439e-8004-08db7c75dc16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yuIvGOS/Uo4IWvrXv98COfgG+W7zPj23EUGLCAo6+vspPrdgc05JvxFp/6D9HqV+JYYX7zAMIZznbilc/aZLsi+c8FMExo+/jIU4WjAOSBXeho7FuYhM+CZy2swL8SUDXuQaBvP3bEGKRIbsOY+8dNB0s6NwwWX/URolXAMFWHbdP0bhTMwgnTVwVhlW8svtLuv1D4VGhuAIYYu5oznOBLMK5n094WyLLrk5ywY4+G6m6qCoyM+WMiJo+bWJmbyopitvufWDdL6+P4UurnpTm/X0sh2Wm4OxOFjjh7j98etOikfUqXgmGNWLJkxUlUzjG7CWVW2eKdlgWnndJq7fA2MngPO8bJ6d/F0+m6YtoPLsC6ZY+WQgXKnANPhd355KySl1LRdTOwPruDooRJ0i1RGfXuM6edu/EIsOctLDpVb/iG+XW8PcA3wnQv1MS29UI/YFhPKOffNPgpBVAXYYV3cnPkQMMiOYDi78T23EoXfi/lhEsl/dwDHlYh7vpKl963BSuKqu3Tg77HdVQxftQFnH62VkXLUAU4LYaV+P9FBIrgvifx8Mj2EHXp3vf3Xnz+ywXGtyoTZlgjXOQk/Enea+e5iUOAaPcOcfB3odBsYOgZwi5GTgW3ET4wOUDKfc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(346002)(136003)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6512007)(6506007)(86362001)(2616005)(186003)(38350700002)(38100700002)(66476007)(66556008)(4326008)(66946007)(110136005)(83380400001)(52116002)(6486002)(316002)(8676002)(8936002)(4744005)(41300700001)(2906002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A1XO2+b2+6KRJpILA9hsqPlt06ZMZoVR3IWpv4qiXS8laumBzJoHY89WMGVX?=
 =?us-ascii?Q?xNbgzzFgYTUgBXNgZTqjJodeNpkH688xcWZGjKSmIjTah5kjjIEs/lojnXPL?=
 =?us-ascii?Q?FjxenP63uBXyRyHjb0XLlbWPMBl52y80UPsNQ9bzZ3xWZnGXRwpf2TCFDUJ3?=
 =?us-ascii?Q?igPOBEDKEERLO9LfUwZA5oucVJcv2eDnsToRwZYkYhD5eABk0La+My/x7umC?=
 =?us-ascii?Q?Ry4G+Lcm7gMu5kIwcQBfeaWaIxP61vgcSpWiwj+YhxNwGeESCgXF5VKaZWKP?=
 =?us-ascii?Q?PV16wSQcWXJ0EM9RW6n4VIFY3ZO1RYvMiBAEqEIv9NEViUJS97QECSjMWy4z?=
 =?us-ascii?Q?ai4Uqhdkva6BvFcCcIaBkUewZn655hIgmnl293whNS+/wI0YXetuWtClqR1A?=
 =?us-ascii?Q?PaDiICbXSSj5+j7VFjE+a36uA8V5+25CBt01sJqHOuXsl44kttoZxe9wnGb5?=
 =?us-ascii?Q?hrdM65fQk77QsiqWd3YxLt+T8bUY812O9tl8DqI5nbjL7Bi/wUJursjq95xK?=
 =?us-ascii?Q?HaxLpwUHSq9bAUUwb8LIBOggLIvQ8O0CJzdAY7EPTNIoiPQgmmv6b96OmLjf?=
 =?us-ascii?Q?r0gJiUVI4OV+20Qb9RToNLQhj2y6O0xfKLcA+LeeCOE4QivRoBhafGAd8Ozx?=
 =?us-ascii?Q?KEl6MTQwrWB+VGlyjwpYlZj5rwi3zFS8OIPnCaJThSeipzcwdy2D0OCS+6lQ?=
 =?us-ascii?Q?eiEsPJCstm+U1DEEvWQ0hCF1eg7bFmIWpkOe4xcuu3wwmRATG6V53k9RVjwK?=
 =?us-ascii?Q?a3GYg9jWcV8LqTA5W86tC+Ml9jnThxrGWVvG5hNyISEaQf91RBWVTig3zhAy?=
 =?us-ascii?Q?+R9EvES/Je6jHaJuzuuFR81WCCaWVv2InP9y6njPUj5jO4NBn5wgXqzy0HdC?=
 =?us-ascii?Q?fc7sWOxIWxOsFEAfMgP7/cKL7YUaSuHN+tcVuS7e+DgecDszld6SCp+QDjmH?=
 =?us-ascii?Q?VdAMXYJ9PBKBW8bxTfRl6tYLjYYHkD1SG8Hp4J0LJr4pFEXnxhtfj4SRgLnW?=
 =?us-ascii?Q?mPm3Ttu1TdOoiLNcYQcSsEKMBiOtGBJErhxJgb7ShWNlMmIanzF+gpXYQ7cy?=
 =?us-ascii?Q?hBvJV2uQu9CDI3y9eLlD30nfcXTGCWe9pwoxaPiTkLDSzMxAe4IUkU8yQuKM?=
 =?us-ascii?Q?OKyBMw0IXBoSV8V2AgwFNYi/7zxR/sF7plBQrEIFcUQpZQveSAg34BPlAbYq?=
 =?us-ascii?Q?qTerqKYbtDZPsj1obu3sPTIlV26WVPemY313bwzwQ6Wpll6CWCij3bODBfoj?=
 =?us-ascii?Q?xp9neoIe/Hfa3AWHwH0k+8apBXXRww/4uZ0SYHznENvjpxNE1rWT7Gs5ZY80?=
 =?us-ascii?Q?+fED4wrs+LjUheuVUnhUug/aN8onLJa1KwSE3mReBwd2sYt58Btto2vLb4Jj?=
 =?us-ascii?Q?IEVkhkvfHgZ6Pffo6/vQ6kyHpBM8CJRmRAHab02OUUwZwpvapHs3D0prvt6n?=
 =?us-ascii?Q?1kGPuA/kWLxLhVCV2JKvzWrFjlDbGbfgCJ6acatDlctWUJ9JgMu6NOzgXjMG?=
 =?us-ascii?Q?8H6A+dtXXNthmw1w2RWtJpTZcg+BVjLODghiBL+ALZsLQnZVJdFothdbZQqC?=
 =?us-ascii?Q?NNwZDDLDL8TBVwvfPBaH4dn8DyrOk5BR29fdS/4o?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6ed7a5-7f10-439e-8004-08db7c75dc16
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:03:05.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSFo8A1PjvRZnlMk83MfHGRFmb8gCNLsSBsdC+jPuvU/gHKlD2dB1cQMHZl2bfSCf+I/JxhNZ6iT3LaW64ihwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4294
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
 drivers/irqchip/irq-ls-scfg-msi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index f5ba3f9f8415..f31a262fe438 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -349,8 +349,7 @@ static int ls_scfg_msi_probe(struct platform_device *pdev)
 
 	msi_data->cfg = (struct ls_scfg_msi_cfg *) match->data;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	msi_data->regs = devm_ioremap_resource(&pdev->dev, res);
+	msi_data->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(msi_data->regs)) {
 		dev_err(&pdev->dev, "failed to initialize 'regs'\n");
 		return PTR_ERR(msi_data->regs);
-- 
2.39.0

