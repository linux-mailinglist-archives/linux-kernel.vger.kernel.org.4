Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F936C1C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjCTQqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbjCTQpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:45:23 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE1CEC55;
        Mon, 20 Mar 2023 09:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AN3bWLtCVGMiXcwRS7J8a7/wnGcWFUpmh/Y7IfQDu2EBL6MQWO57gF8pXC5N03FwoxVKwIcMGaaqbQx0Y4WqoMrHPf19hAxaE0uC/86GB0AQtOF8+iHQxNuuF5nf4AT2pbscNbz8oVWlgQHGs7NoGpIpOmEFHSw6Dri9usfQMD0wbCytn9HAnCjcqp47817IOyTM6POZj6j4TY4bPoPD/VS225g8J13e9QnaIe1713QgrS0bJSkSK1Of29I5ePtG+IEaXfZRzxeDXHSwOYDY4I6BzRlQi2Vm8oufFZ9mHezui0PweAmAV0wH9VodUC4oURcEyG1B3D/hacUK8+gfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNDPnp+blOHO2CqkrXX1ETmJ7PEE6MQf90eOmcm6Ma4=;
 b=GJZORVRv28ZkmcPz5DcNhVFqzI7+zv1zLTUs55g5Qfp16ZE2C8/urvc5DE1XQdLgWnQZEJzpVi9vGRSXXDt7JofcvWw+9KCHCXkZPioICgmCURTPwan91Xos44/jYHU2H6KEhhuPoG7coHjMUEIStpaOONysmHw9GOnooY0SRa728yl8txo/7eIh0JLtt9NaMYwp9ZLpvE7I405WuvbFVcCG00ET5JH8WDXCxLxEQQ5NaMAiiWd5PpLOVM8ZVCoJcWHSBtLFZN17lflks36p9PumE1Az69FYcHI8iog3ZVNR+swVWrRwKStFdnKY6RlwszOSNjwuXcMoGkIm0C2xAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNDPnp+blOHO2CqkrXX1ETmJ7PEE6MQf90eOmcm6Ma4=;
 b=qSFJNTuY8IVQKJnkEigR6W4I8wcNcGat6dmNI6ln1PQ21fCcAS8riLiKq7c8w+kRQY8E9fNEzH++EGgJHNetQeOTOJl+ZixJqt5YgmwDCUqW1Nny5QwMGe/0eK5u9hUEbs78hKEN+ljvdh5+XCQmsOXURzKPpVL8UcgFd/W3xlwdQHVdqjvf7pFwnA8Nft5j///KCOcF9Ls/hdmOnE2WZbtomQf+VFyiJJLs+dUgULkHnPLp8k9HTWPrzmlXV/t8PEkNI2Ib9M2IQLmbFFY+cRRzqkKXdsR3pCXFDsuWpkQURHbtjuDw0hFdVK0WjZqYql8aUeUNH5wolht06m/+fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DU0PR04MB9274.eurprd04.prod.outlook.com (2603:10a6:10:355::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 16:39:07 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::6802:b2c3:5f12:8f9f%2]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 16:39:07 +0000
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Chester Lin <clin@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v2 1/4] pinctrl: s32: use of_device_get_match_data() to get device data
Date:   Tue, 21 Mar 2023 00:38:20 +0800
Message-Id: <20230320163823.886-2-clin@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230320163823.886-1-clin@suse.com>
References: <20230320163823.886-1-clin@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:405:2::14) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DU0PR04MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ab178a-63f5-4bd9-2068-08db29619fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: loWJfdi0DxhATunVst+npiXBcWlAOvxnMIdxf1D5Gt8JmeF6/hPLI3mbGdYQF/4Z3V4QyzIW0UUdpwCC9G+2/t0+kUCV1+PHcS1xmLPylpKq6pjI6kTj46QV4uDMlBXoGq4hLVqVuvMUDxhwJWXUtbqz0LnIgpYHvhjbinr5DdUch8uSLzSFoiqNe7zXeyVuWjE5SfO4qW6qG4uHqRYK3NEAbzJDsh/UlPAQEoiXbwuyKXLJwOQqWTr80VGYvlcMX0ZKRyrVdK2jkZXZsxoM3X6kL8ic/5xaeJJTTD/gvF8atNpaDvrv7sa2cjj8FZhhA7XYKdJnVUS4LtBrhENaFfDwKhrz2FNe7FDeNyKr32Hp9WAufLALVbeyqK8iSqqi5uhUNWPi7nJk6JvNUAXl5NiZE8j5DXUpzYOziUKyZIJ+tJbI4M+0JPW5vtSiGoNlyx/t408OcY+Z+ZYR0d+pXh4D0ikC1s1ORxSoFQdgjef9wMjn2Ci4ak80pHMwHZjWNHaw6AFdYK7xXaiM2prBH4hpVGZgu/rZ1gANR0Tg2PRT4+QrFP+xdgxvjFnHYL3U1NAqt6HISNLWYq4HOtDSmv6UZgdMBk//9ueb2UbdlIFwbIeo6vXSTiW9Bw6wGcXDxcEaeidulzknCXdF2qyZmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199018)(8936002)(5660300002)(7416002)(86362001)(38100700002)(2906002)(36756003)(4326008)(6486002)(83380400001)(478600001)(6666004)(107886003)(41300700001)(2616005)(186003)(1076003)(6512007)(26005)(6506007)(54906003)(110136005)(316002)(8676002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?19uaPTxzlFkp2VJICwi0UwBVxzqN3PL5aV699mibvARgrA50q0y9lCVa0oNe?=
 =?us-ascii?Q?7ZFMo2PzH97f/OmrwOGlOncvtUa5d4gGErYqaSqF4X7YXO492Lci524abfQ7?=
 =?us-ascii?Q?aZ01gQwE7Tld3EY/g6jUWEOd+JPgNMB7FJIVNxelTPPGe4y7EZpQX0I48aen?=
 =?us-ascii?Q?8jE9WRi9QHhOH7+x8j36/k3iQke+xBxjjFYwcAJqMlniKKdXadg0tmvi9vbM?=
 =?us-ascii?Q?ra/+CIbhG1y/4FZtbjm6QghoGESuIK3gCRNOrzjHGmGQQ8NJx6vQYoMe+Yir?=
 =?us-ascii?Q?5VmCNcvE3gFhRCuPbUNjKvjkvEL4ErV3nRspCIWuJLY+MJcyP8LPGC52ea1n?=
 =?us-ascii?Q?s4q3K3nnNxuary+/cKof1qFMcHcHbU+JYQ2+vwUj9twDgdK2BFJyUXaD7Zn0?=
 =?us-ascii?Q?kKly5qKNlEroFDQss/4kDKKZzdxZIWs1naBWQqyoZbMMcCmtx0KxWaCvqXch?=
 =?us-ascii?Q?bn0hUDcPtCW8EXUmfZB+ClbremGdrvRfg5qHyHgm+9CDrvLWFQHZ46Sp6vl2?=
 =?us-ascii?Q?dfWGU0ErnQG/n03PNfx71VgenLjNnGKxA169RW7cKMo3/wZiLBNb7hZ+Y+6V?=
 =?us-ascii?Q?28TKMFZ61z0eWYZT+gfKpzxqrIXFP4L7WYWPKf91E/HNzMjohOdhyVrtkDUm?=
 =?us-ascii?Q?XRtZmfxAGHSimz2OVxGHgEt00q90dIEsBuic//2pzFMsLuY8pu/KQD8THflJ?=
 =?us-ascii?Q?+WFaGbQ8BTqo9SWjpDjFr2h1+20LgyBtYSfCHw2zfh+uROXBoJJ6feLrpcTH?=
 =?us-ascii?Q?xRddGAkfp2G50Wm103mvOjki6WCtR8BZT0foAtRHcGIsGXPub2vzB7dM0zUD?=
 =?us-ascii?Q?atbDmo9KP6EfQTefk96P5tzEFySay/r7gIgZHvewiSZIKwn8+xryYm2YeKbi?=
 =?us-ascii?Q?Bm36IX09WuPtMQKPNC6U2Q9Mg3E6VdutlSx8KA0XY6jmLB5zrgAQ2+wkSuK8?=
 =?us-ascii?Q?0XVojCu/E6bkIb/XyptW9oRYCFj/me5gQj60KUfw9aKe8EILSyO3Ba368V2b?=
 =?us-ascii?Q?gYxaa5DI8rax10WpbzJxTsXLPZ1XE3SRnd7Cl6ec9v6lXzQj9Fgazf5EA61v?=
 =?us-ascii?Q?H4H52cvvux36il4cPkLVmMGlIZrwQLAcAT49bTv2i8rVgWSErFQIiUjBidby?=
 =?us-ascii?Q?YpP/PhEUxoMr1iPtiNCz7lnAI0g60gfDxFSwGZl/n2MSmLLK8SCCjlm34qG0?=
 =?us-ascii?Q?1pPQEfcCy4B/cr233onDCll6bGSoqwzuGry+S2rZIkutXB35zRDzBN4qOUpt?=
 =?us-ascii?Q?ckOgKb6Co+e4vy9SnPwXPlWIY2kq3ThaM2m9J5NAVjup0rdXGhcqJkvp7xrN?=
 =?us-ascii?Q?xvdPTqcY3hArd99hFZemc6PHMyHWv4pIGcdPNwEam7dePMCrxRpjwbTv2MbA?=
 =?us-ascii?Q?/hYjmYWdVJiOVpxmx7+ZRCz6zUPg4HU4Dj2OzvkrzJuSz2xPNzrysxjGTSim?=
 =?us-ascii?Q?V4zJDASyVTCJxS9BeqO7EBaWeNkNAkJBWXYasmq6K0VF+z4qTESRo+9tA6Z9?=
 =?us-ascii?Q?mx14bzUPZ5f8unKnMKek7j82cK98SQf58j21VYtj2JAvkupkYQmHX/lxiUxL?=
 =?us-ascii?Q?QE2wINbj0mqOrlIj9UM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ab178a-63f5-4bd9-2068-08db29619fd2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 16:39:07.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XaD9q6/jRJY7FGwKlThgp4MmxyN6xFEREXDcZlGYo055mcd1wvIMxIFjX7MHXlga
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9274
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on of_match_device(), using of_device_get_match_data()
can simplify implementation and avoid code duplication.

Signed-off-by: Chester Lin <clin@suse.com>
---
(An initial version since v2)

 drivers/pinctrl/nxp/pinctrl-s32g2.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32g2.c b/drivers/pinctrl/nxp/pinctrl-s32g2.c
index 5028f4adc389..f99f88615ef6 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32g2.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32g2.c
@@ -740,14 +740,12 @@ MODULE_DEVICE_TABLE(of, s32_pinctrl_of_match);
 
 static int s32g_pinctrl_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-		of_match_device(s32_pinctrl_of_match, &pdev->dev);
+	struct s32_pinctrl_soc_info *soc_info;
 
-	if (!of_id)
-		return -ENODEV;
+	soc_info = (struct s32_pinctrl_soc_info *)
+			of_device_get_match_data(&pdev->dev);
 
-	return s32_pinctrl_probe
-			(pdev, (struct s32_pinctrl_soc_info *) of_id->data);
+	return s32_pinctrl_probe(pdev, soc_info);
 }
 
 static const struct dev_pm_ops s32g_pinctrl_pm_ops = {
-- 
2.37.3

