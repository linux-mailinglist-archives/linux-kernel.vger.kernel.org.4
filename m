Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB40747D9A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjGEGy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjGEGye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:54:34 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2139.outbound.protection.outlook.com [40.107.117.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9351722;
        Tue,  4 Jul 2023 23:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myiQgBRNNC+aVCrhOl4gpiCXxYKzeWmf5EZ4zoqeJxSQuycBRDQf+QojHI/r7K72GJOdZibVyPHqSIi5P39YtYSw2PplrD+ZZ/sOfqGy31M3zaVPok7gGxhFuIdkIOx8RlCSw8l3tNtD+LhYxwcm+4VM721MOfs8sn+oB7lqDnPVrRogvW8obofbvRDWlB7h9kO2ABtJ1l5eTH8Bt2U/CxKdDO3A8kI5dZ1Tw4TSX+aIcEmfPhKdgxXAK46nzl3yFUfZbG9psj/9OUoukOAtOsDcFgGVyw2jQwKNh/MFV/sguKVT9MxliWZNvhnOVzTmu2TbT+3+Yvx+60UdidE9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RDVdQLyhWYC3CAVbe/JAYa23nrvATFhWoc2jDkRfiY=;
 b=N5b9T4bGqdGuPZODhfbXvpK3O1EZQmncP6IAj3W6/AvQu1ObiDRAcRG6zXliVaEUvO2Zhw3dy9sIXkiQZ4WYueQWNhZONJkVMt4ShG/7tf8PcqVEybCka6/d4R6nNKWNJOZJ2AooAoyj4vUlkHFz35rjtuZt4JmpuPbxB1rgB03Nm8M1hCK8ItXkTcTrVbH7sjWE/F6n4t0H+tvRD3kDq4Lqw62KQIo2DUr3P5zvCxdbu0M8uB8zPB0/dOXr9tlo1aimPouQFRdBzzhx2FXfkkeaXhZQdnMtr30LzA7qH+3R7Z45N8z/7Oeh+J7rtPxs7EC8sh5e/5dy86ep36GHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RDVdQLyhWYC3CAVbe/JAYa23nrvATFhWoc2jDkRfiY=;
 b=g7ncDPVBFVDE1mmU9Jvr9GfLZCiIrhijZvztJ5lUe7J8+zEB2qctzMPq9fBqn/cQbcGBpnjeRUQ9KvpBPf3L3jwrlaX4IwXoZWc0I2Syh6mGOpXauqNf1zWijxKhKZubwJDT2rugkvjaPCcp7TG1j3/ioWiuCEpETwIAPoq48CL1T3ovJ8lwzgv3yHe42h0emFH5y0Api4fcL1HapoVZWtK0FDoCfPARjZxzOCKSysTuq5Zs4JXrHu0UEVENjCNRKhCa5KcIg+XyVgyYa6CM17mOKObbl9fFVElRaihVnaUCQS++b+cyKifT+TMbeDrWxZ+yCok+gyNUEw7TjDqm+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6087.apcprd06.prod.outlook.com (2603:1096:101:e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 06:53:34 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:53:34 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] clk: fsl-sai: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 14:53:05 +0800
Message-Id: <20230705065313.67043-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705065313.67043-1-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 227013c0-9c03-4d31-b53e-08db7d248cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBEy7aDCcOm7m7KpMwhZTbqwO/mFCk7IsIZsgKoPwta4PhpC4jnd3UffNIC/urlEk5lDwaLsXI5QF2+cGorYshNkBwjdk/H/aL0MD1PzQCSDWlxztzg6uYygTqfK9SI4xW8TMrCNyETwcfJvhRKPae/ohy7r+cG6mVOIzSasb93zujlqigeo7C5bD2LaePxsXQLpElD/V3AOzrE4cNHPQlvtcMPbYEA4z0yfq8n+cyGYdt69GQgwMJAJlmr23k3yrgRPpcH4bgRLpFuJ7uu1EqU9H5viVWCeepKjzDwccmui/nTeYtgUyV9QKZF7PU4FPMo4es3BIxD0DWV9I8iVw0mpQ+hUVRjdidrVdEH4re8oRNLCNytOzs6aZec3Brr/WeFWCshEkFoEFixloe52EHIRJdnOQk2Wwjzg/ySZhTg0XDBLFxtpekWQgjS+AuVuVhtKaYMbK4jFKBk5FaANZXqXm2muUSacaqc4PYbn1pC3Y//4Zv4D81FX19Z22C/wH+D53fqipYj1lforfJv7iAyl5v/xt69YR32DXggAG8OjfjNZE4NYigb84X0X8BJJ2KBTfLn2LAmeWoZVvtXagnGfm1/D4SXgbWO4tm46gv9uSFtkAfEs6TsJdzjv54HI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(41300700001)(38100700002)(4744005)(6666004)(52116002)(38350700002)(83380400001)(2616005)(186003)(6506007)(1076003)(6512007)(86362001)(6486002)(110136005)(316002)(478600001)(66946007)(36756003)(66556008)(66476007)(4326008)(8936002)(8676002)(26005)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mhzuoSkJYeER5R94cyYhS76D3caTdF5O46oxCxJHowPgYuCv7AcU7UFhA1ww?=
 =?us-ascii?Q?eg/VEKCdLIG+nhW4tRFxLPURlI5f8VPCFoczJ9Md+ESTf9hBy1lf22C54fXS?=
 =?us-ascii?Q?gwkllMkBN9Yok5dXhdEqYCFt+CQ7qAU9ZuZ2O+ihtkZPYvDPouvqW4559Lg5?=
 =?us-ascii?Q?LdHSDsB6Mrrv71qxhnjuKbXq1r8mgWWJKBGDok6x3NPbwtLC4sn1I11QUme0?=
 =?us-ascii?Q?FWJreQ4tcIq8JNE+HZD31AdqVOHemX0DtKYr5HaK2uDl8lyAV5W4DcQysqc/?=
 =?us-ascii?Q?GRs2PVswoqm1NNcKHSayxliGbrJ3LAllqkalU+obmFn6BVhxiYu4GgseuecL?=
 =?us-ascii?Q?aXrCZQ1jOO0vP4T5RfAAFpUbItaed8Ua/KTYpHGMeRvEus7du5ClfnHFbub7?=
 =?us-ascii?Q?C8tikhYh7g5F2Y0sg0cImT/Q6aS1fGUic5DhxDwxyWJBISEBVrMEZRf/jTrd?=
 =?us-ascii?Q?WJM/NEM6xpTAohXhX/h8jwEId88t9MOLt+KVM4VLBqcV3Lbe5o4reLHpLWaW?=
 =?us-ascii?Q?z77LpaU5lQHz6masBA4XYsniAhkEOaQpHJ5BY/bfc2ccHOUTmT585lZ2ajG+?=
 =?us-ascii?Q?nZ+HjKZfRfI6imwoBVGek9SsR8yKp5eu5xzLOlvIFzFH8nV7wdvS2Ns24ePh?=
 =?us-ascii?Q?75FboiekrH+LmCqqcCbAKwTLnQY/blkc5IhhqbwHEWhSN2ZLJYJG4NFg0o4/?=
 =?us-ascii?Q?CF39ofF/Cul4IvMfvS9qjmUXDjLcL+bx/B0TTldnWZx8bT56XDdJUmCMjgai?=
 =?us-ascii?Q?XwDlCcUrAYti7heb5B6VzTv/fnej8xjEvAkpLG24WdXLAzIsRwMxhWaWAPkv?=
 =?us-ascii?Q?TePJqhpsNabB7DZOLphC2zxnd3fECYAVBDs4JyxzZA6VqWMGRlddOwKe2CpO?=
 =?us-ascii?Q?8p2Ifz7cVZ69XC8EROCc8S/yV91tTpq9WtelCrIHB+rWVDa6v59HcNMeq6R+?=
 =?us-ascii?Q?rjrCvjRFd8176a6E8EX1YT0pQyYY1mw1PwgSwv17Y8vP6wcIYyk8fNKzCaJw?=
 =?us-ascii?Q?Ikg7QWUi3XyKOcGFW49s19TcP4lp8IWDr4rzx6EAsD/5eC9EWLOKMDlFNmhJ?=
 =?us-ascii?Q?XxU9MAjtPaRlugFKob+PGfW2Avf5eK8EHrbkVytGFVA9BXqIDZC937GINlVM?=
 =?us-ascii?Q?dPA1g5QNmvVVlbTJ9TcNv6DF9j/KzdPUNB8A2QI2UmlK4kFQQcemhUM3xh7i?=
 =?us-ascii?Q?2UZx+T/t+VVoTtMYRh50+1Z0zP+nTEzPPyiltSVb5Xve3n87e+HjMZG5Kbed?=
 =?us-ascii?Q?aqR3Yti/TCEQ87NUl33NDfzukt/O/oPdGv/x9S3XRsfuBlloqOoa6LwB6Qvb?=
 =?us-ascii?Q?QJYU31FU/iEZGblJ0rUKUtd98pP2U3HtjdlT0laj43zqhB1i/YIowi3JXq3w?=
 =?us-ascii?Q?tGcbe4bgQJrEIdhsafJQqjAM/DecU1jI71ZCN/OITGV+7Wsean7ZJ8XJmejX?=
 =?us-ascii?Q?6Uf+NAmvMmU4GQM7BxvtEtdd6dnNmYerzZUPydcIwmbSYuvKL2IkkBvrGUa2?=
 =?us-ascii?Q?Ij2w46D6e+Fnx864V2NOBYLcGVBulMpIy29hNS8rvIt1RKU7fo9rETAMJhyC?=
 =?us-ascii?Q?feJWifSmtk6EOyoLPwgT1XTSiKz0FIA/L5LU33wT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227013c0-9c03-4d31-b53e-08db7d248cb4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:53:33.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgGt9dHX81jxhm7NaXCsTPxta9B/fy4CYsVBySPd46wzWFqSkwgGxk/MuJ27s4gHlgi+eM4YiNxzaY1k1JUUUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/clk/clk-fsl-sai.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/clk-fsl-sai.c b/drivers/clk/clk-fsl-sai.c
index ee5baf993ff2..cba45e07562d 100644
--- a/drivers/clk/clk-fsl-sai.c
+++ b/drivers/clk/clk-fsl-sai.c
@@ -33,14 +33,12 @@ static int fsl_sai_clk_probe(struct platform_device *pdev)
 	struct clk_parent_data pdata = { .index = 0 };
 	void __iomem *base;
 	struct clk_hw *hw;
-	struct resource *res;
 
 	sai_clk = devm_kzalloc(dev, sizeof(*sai_clk), GFP_KERNEL);
 	if (!sai_clk)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.39.0

