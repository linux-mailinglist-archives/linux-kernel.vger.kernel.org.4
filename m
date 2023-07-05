Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4680D747C59
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGEFYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEFYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:24:05 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A1E1700;
        Tue,  4 Jul 2023 22:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWigmFrhqwh7cjkmBuFcyk+6Bzrq0duxfTkP9OCenLx+a+s5sT++jPBbgvYncGgHq74zAoKMQ1OU7Zc2bgapjUJrw49YZQJdr3XNPE11m1KaAGOF8bzAF6gtNJnBj/f6WssZa/dRsVQLpMpr6JnhUdMU1iUmZY/U3j/FO2GYNjY/CZ31ymhCSIhsdZ3tfB0C+xJeMr1NIjUPA5EjIwOyRtqSA+/nelBd+vX0zGWYI2SjZn23PU+KYUMS9du1Sh/BIYeuUvRAFpvK1fO0cdAQkbYZtgPEkA+d3p9hExQbdhp6DkTqCxjfGJEoKWuHb5OFtz8QknyQ519auRnUKfJ9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lk2AKkndr4xVIgjkxE6GygsSeSc8HTsTo+fP9eBki/g=;
 b=byR0GNwKh+getHC4S5f9Qzuvri1vGJumyakxZ8wlTyatfK5mtRaXHmJOhAUfIdtveAVxbM2xtOt6kR8HXKlK2njcNAkn9XFc0ZvLBXHyUK/J/bVLx8kRqF2FvC0eYMxTTm+j8eTx0GatuPkVPO59mNrhZ/Bte3Li/n1cLkastrC+1Ki8rFg78MeQl14Jr9An691T0CppSRg3K1NFfC4za4dDAXpj1LPDJ10MM2m7bFLgOadN+FKPQliMAgDl886DhSxoB8j9uNrDY2ujkBFGBD6umr6qiSIykIsMf/mmgw/pE2J9xVJ0kEl0DUB9vnpC51CO64GOrMGckzO/EsY+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lk2AKkndr4xVIgjkxE6GygsSeSc8HTsTo+fP9eBki/g=;
 b=gBlKIeitfRknyjythltKFO83dKRCJ335q0UzWp86PHshjjJ8vDcFBozFUx+3gfIHROcjF+ELIE3z+798k/2KUROJ/E6eC70swFnNyh10baBudjyZLiXWmkzwlVbKR1Jl49JEhgGLjcjCNF1y0/IuwXPT2F10LwhEnfToG8/W1I4soAAcPzvXlGPcVoP6jeF677f1rtlLY4/J1rOuvPSz/Ef2tzKjOuR2RReTS4Yn/SC+5lTmeeRQIi9EDaYBQWhaIOEIRhCuycis39yw8kmtU6KjcWOAU4Q2wanjP8OMBt/XnqujYIB5SKKmSi0LNPudPGP1/yWtwg2c1ay2pxWFBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5123.apcprd06.prod.outlook.com (2603:1096:400:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 05:24:01 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 05:24:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] Input: nspire-keypad - Use devm_platform_get_and_ioremap_resource()
Date:   Wed,  5 Jul 2023 13:23:39 +0800
Message-Id: <20230705052346.39337-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705052346.39337-1-frank.li@vivo.com>
References: <20230705052346.39337-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e62a5ea-f3f9-48e0-5d69-08db7d180a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTdiyCi8IhgV6dRrj7SfQzEjIIj2sucdOhMHrPcU/BhtzIUJOnuD5/wnI9f4cJO+JT0wly/MrMWJGpbxU2pcPdaDjwxtSS0LPR3YsRWIp5ajzfKkBN2OM64wrWLeaVIneA2Q5KnQtTKcJlRb7VhDz8OEIhb2A0RBYIqiVbp6qng9GRjskbwnvv+ws6M22iSYW5izXMn/LnKLBtqj4Z3xvy40qOd4CCnCX2hUSo4hCmL+fkFp8sPhUWssxNWWTiKmD0vsK+tQLU0MfAq7mdK8pq00hvj405RvPwRYD2+ULyKoL9HbAxUYwNMDuDOQjpWoVcacKyfqr+mIqYOwL1lO11tCd3TYuNjJwM7zn3nFIS6Wag7AmKZjLvyxtfAhHfR6bOp1Wpt8nbyp33LJg50X2n8o2fSv5uMiyYU4sJrcE5CAkB2SA2EBmZzs7DRhq0b8yrap3DSWOp8ruWRcgJUeIoiGp7ZYQVFOXYH1Qn7RofwO37+mmyFk95oZzt4vZWE7f5aLXX1KDk6XZYpe78iHor5mv7SYDsmW44uWzCysUNXkPkBy2LPds7uiUrwjUHr+Hjwoe3AeeWK2BtoEZ7v9wNMEUbPmxLxB8uHFmc7nX4NoHnCMANw8xAMtdJuW2Fbl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(396003)(366004)(136003)(376002)(451199021)(41300700001)(4744005)(38100700002)(6486002)(38350700002)(6666004)(83380400001)(1076003)(6506007)(2616005)(52116002)(186003)(26005)(6512007)(86362001)(478600001)(66476007)(316002)(2906002)(66556008)(4326008)(6916009)(66946007)(8936002)(8676002)(5660300002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xdC4ohUtaH6Ilm/0t+A7BF2oAXBpJtn0ABsLHORi3lZdMPqz+MwajHDRTefL?=
 =?us-ascii?Q?TmKJB5AlzL1fmrPmP8r0IMxfm6J2NVl2xhzEC0ZyVK0m1kfJKeoNjbnMU2jo?=
 =?us-ascii?Q?ffTR9ZA0uQ881dAbqlGFAZzoZezldVAS/dL+mgVh8gUGBt8C0EP/Fx8EfS7Z?=
 =?us-ascii?Q?Qlidc60uLLfqnsp5RBlUDa1juFXMcZUG1l0vfX9mxxuHJZ+8vp7teGcb0F2T?=
 =?us-ascii?Q?gfrrT1pjHlvEMHUdn4GEq90MasBfv/ySAJXpTa+b0MtEZKJ0iMSXIVRhAybP?=
 =?us-ascii?Q?pQ7+zs4MwfHKap+hzDQxle8lKL/hpu/OxZ0Bc1m6aiCNzEX5AbhUXjv1s5h2?=
 =?us-ascii?Q?a50wbohNeTih704FLjV9C5lIYnibpZkCbYXh/4rfzUYHByhQrNO0lkWYIZOR?=
 =?us-ascii?Q?9UyLO8oV0JO8HnYh+Drop9hyB5TKpaici/2PSUGZFhdV5Npgv3BqKoNVtkWo?=
 =?us-ascii?Q?iMQoBWV/BxmMrk8TbQ/DS8aKTXqCMXpZvTVEG/TnyCxSHKvlP/RobHG99Wi2?=
 =?us-ascii?Q?tZBHJ2DMiC1bfcxlGYhj7NzcejJXtV0v6QvZ34/TPST2CUWfmmtY+Fu1K4TY?=
 =?us-ascii?Q?IL3h6w1k2vQ2NFY3ojGGm6sExAf2CiXKxPmsgOcCk/35m3FEKcRI4hvWAAyr?=
 =?us-ascii?Q?dUfI2yhvfxusDUMJ1rjeIzDpY/QESX1LsMGbvBsYPsoHKtbsJDKA50xuIt+V?=
 =?us-ascii?Q?zw1L1by49PVeTQvR87D5r3B3y2XA/DEh6ZhxlXNksBrv/bASKYZOyM5Na92G?=
 =?us-ascii?Q?/WOJBCv5wIbTrESkbavIbFAQMzQSR4FE9Mzw2hvUH2yxmseRus9hRUARxxka?=
 =?us-ascii?Q?1JY4Ewllft4XRtOHksddaBZCwi6nSVfNQApijkVMfUJhgmy9gqHMIsDkjmyf?=
 =?us-ascii?Q?1VN23f8xsgggwackJ+iliXhaB+IXpuTww4Zaym6bBI36fJHlUSles0DiHoSK?=
 =?us-ascii?Q?oi6x4/xqttFm4/lvqaJh4aqnC1A/7Y6XrXFIJDMYcEmOrtLXiCpFvtHcxN6F?=
 =?us-ascii?Q?+2PfUp87aS+/bVCPFi5nyUEGsaCjxggzMHTI2IKEltlkqFN2/EQsvdS94hJa?=
 =?us-ascii?Q?IRfXMpy3Yspt26vtSKFvC7Wn+63HXMqVkBNBARX/9CeiTQOkoo8dvqhLqwOJ?=
 =?us-ascii?Q?Fg6EO+s5ae2yIJBr/gH+Qyi5Ou1q+rjwUaBrPgX8ClRfzxDmsRe6hyZijagb?=
 =?us-ascii?Q?QY6oWXo08XfWvIIn0hNbHDAB+t7Dm/2F9h1mcGoN6s+R8cIPJxq99PcF0lCl?=
 =?us-ascii?Q?XDGlmVuiFH9fh0ZdcZ3cDOUkAsMdKWRF/R0WrBTbprSrR3ippXYXVyWZHkf3?=
 =?us-ascii?Q?SHxIVt/WGYpm/X4kquFXrMdr1ZK3xYe7pawOoxETLc1l8INgKcnQvWWxYmEU?=
 =?us-ascii?Q?2HqmkT+E6eBBX/Hz6GStszymT3eUv56VU6+dAvxi0RuW+tqd6XPD2cphadwi?=
 =?us-ascii?Q?4Ldsfoy6zfVhimmxBcPeiywtJMT63c3m1cUjDYLyjIM4ubguFGeBze/vmxQ9?=
 =?us-ascii?Q?XMzWQGKTPtoDlO7uXvLv9B0EzWTWM+W7KygHAQl8mIAr9WJTpuQ0HWST2evw?=
 =?us-ascii?Q?IjJXmqZfHdKLPIPdHEn1V1k3kSCgjeGx0zzhrltz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e62a5ea-f3f9-48e0-5d69-08db7d180a85
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 05:24:01.4782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXtqjr+IdRWQxNp7TIQdLyoiqtJov8PRwx6IgGS7fuR3EdbvPxu767R8TIxdm8cRvf8QXwEFTX+GcpXGws8BvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5123
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
 drivers/input/keyboard/nspire-keypad.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/nspire-keypad.c b/drivers/input/keyboard/nspire-keypad.c
index e9fa1423f136..096c18d7bca1 100644
--- a/drivers/input/keyboard/nspire-keypad.c
+++ b/drivers/input/keyboard/nspire-keypad.c
@@ -186,8 +186,7 @@ static int nspire_keypad_probe(struct platform_device *pdev)
 		return PTR_ERR(keypad->clk);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	keypad->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	keypad->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(keypad->reg_base))
 		return PTR_ERR(keypad->reg_base);
 
-- 
2.39.0

