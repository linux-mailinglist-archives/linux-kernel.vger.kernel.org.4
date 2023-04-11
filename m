Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F22E6DDF4D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjDKPOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjDKPN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:13:29 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87AE49D3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8NBx+8bQJNgiV7k9ttOTG0WifbVtTmshTxwgO/BqgMprX2LkMI/zUxIvaIfCU+lsngNfv9LWhMabyyxRRB9oVM+AKd8POfFJ/wuqAqexNawGeJX6AkuJpnyUbr6eESOx+nTiW2lY1PH0YBEVxxu+tFQQFRLjsV9jFHiDYYQJwisHLnpiWQ0k5BoDqdIhASfMsBBBJxh+3kqbmrZl2xq23FVRMMTynYq5Fd53AMOsEbpGdgXtg4SYyZyh+ATmx37h4i/TkzGD5GdSDGGYRdf5R7FFeyZsFYdg05xXva6eJZTluqN7XOJgNJyG5YtRW433PE0wvPrtFreD5cErdfG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RP26lmURKsBYKhqFNc6Q1bFIVIbw6p56LyuWvgy/TA=;
 b=m4taz4hJycVGAeaEKvIjPGG/SF9P/C0sQFV9HNLsLtYtA+BLlZ6XvV9IdULG8ccbjhTh08C6TH258myrIWRlVfHCBTmg0VUdSRKbutOc6h6HDpqg+mbepqbqk3RVGxhloce2aE5XFNC4fu2/8tEJGHkknqRP1pkkrQdsp5YKFLVTDrlEZuxavratxpSg/5sv9eB3aHi/b8dIe9iTuePnLI6p2PEoJ0417Dvwt4sFDnULeDMWlm1PrewWxrBgW1M5zLV+oFF2E3sXvxepOS3o2FU3316XVU9AB5jO1cC3E6IXICplWFxPyO25jxNx9anq7R1FQvvvBFoaxUOeRcwQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RP26lmURKsBYKhqFNc6Q1bFIVIbw6p56LyuWvgy/TA=;
 b=EtAU3kFcpqNu24c2Ite7L4LcT6r0zX073O8hhysKXNXqB1WNZM7ZYnY82kYWH88pXJ4UaSrRxn35V9frSXEDKGiC5a2D2rgihqXQNv7q+YOtzlwYnNzGvQe9QxK1SJtFej76E2yXL/wPH6lk0N2QL+94nnT1x+UmAdMMP2/ZASA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAXPR04MB8669.eurprd04.prod.outlook.com (2603:10a6:102:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 15:12:04 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed%8]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 15:12:04 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gaurav.jain@nxp.com, sahil.malhotra@nxp.com, aisheng.dong@nxp.com,
        V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [NXP ELE-MUAP 7/7] MAINTAINERS: Added maintainer details
Date:   Tue, 11 Apr 2023 21:55:36 +0530
Message-Id: <20230411162536.30604-8-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230411162536.30604-1-pankaj.gupta@nxp.com>
References: <20230411162536.30604-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To AM9PR04MB8636.eurprd04.prod.outlook.com
 (2603:10a6:20b:43f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|PAXPR04MB8669:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d5f5b8-063a-4504-8697-08db3a9f1baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NR607SdXhwq93mTksbA3wTUsdjNCeDZaLz5WSERVhSH9dg3dIsOlA5jWlbB3An6co4fsf0rl0dVMN7W2q6kisdFmXvpZMNLAmG9paVAaGNcl8CWe1sDmFr6FAOmHap8Hv1s6lGA+MqnS/C+avonalgphYCkpQRTkymOzQwmZB+iaa4W/ZOt+wOLXmCo6aKe0O5Xr10ynZOVcXkSEDO7hE4AJgW7Z58BdSh+hLkQmM+pbG/GJUa5Lo9YKMLEF/FElzpxsrpDihaUoX7sV+Sj6Vd2QtXShC4BKSM2dza/sG2wFK6HQ/7T9SmxmPGkZrXfwZifXbrTet5dCTkvkcy0jaQI1JG8ilUkslHHQ2TJLtPc1HzlBpymE5wJ5iLfONLh7IAY6NzDwih8DIELIml1FMOChLC99Qp8WllaFSKYer1C13PkSbfEHV9OTjf7RbP0C1IEwd320JHhCgq8mlw+jtre/Q91nLHB4WE9bEV6XlnfyaY/osmJdLvigo5lAccGALk2FOvPUArw/9lPf1R5tD8qEwzSZD0wVVzQo9xuCi63GClF7CZPm44nT1mWEkgAQmxVhlqL4TFkaurFqikkcPPtasvMxX8UUB0xC0f1Y2sL3fN75EihX5aFmNTTO/4ZwvcuWL9TnQNGypTZPURZPag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199021)(44832011)(36756003)(4744005)(2906002)(8676002)(8936002)(38350700002)(38100700002)(5660300002)(86362001)(478600001)(52116002)(6486002)(66556008)(2616005)(6666004)(6636002)(316002)(186003)(6512007)(6506007)(1076003)(66476007)(26005)(66946007)(921005)(41300700001)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cINFdRYKtNuF7jDTO+aLU7ZlyuGrISP5Uh6GKFBRhCIKDIWmesg+kwuag84A?=
 =?us-ascii?Q?nFypnPboTm47h18okOT6rHYc/HkU6tCceku0Fpp6ahiOo5AAv/LTPKJDuV4J?=
 =?us-ascii?Q?+YOk8JHvmvrgFUD9zlGzqkfridd/CsNboNrxyiIOYCGGFC7Hs9HxUo9n+tve?=
 =?us-ascii?Q?JDoUlWXyhAc0LzYHUvmIMUuRc5TZY8ysfiIZtYFO9mbm9t1XIFJd/dAGpvMO?=
 =?us-ascii?Q?N30dRsPSZJOOA0oTo+IsHXkGpCr6PKw5Oba8CjMSF/UTORs2/ekLpghwTgpl?=
 =?us-ascii?Q?IR3x50aYED1G3BFLRyRwXzi1U/8y65bRfRgG3y13Newb/uNpYawJWhwy4nv3?=
 =?us-ascii?Q?eJERpEdA0ExG8wAI0PlTSwnLbhPWtHEGEniRG353A+e9rA5ZlX+PBoVMjt69?=
 =?us-ascii?Q?W85Ofy9OPVTKY6AKSS+pi7HMV72R9W/Oaw7AW37sczY6VOVUl8ALLEURiKjm?=
 =?us-ascii?Q?NknhOKbOEL93w8zvg+gssOkKLIRpd/2EU8aAkEO388lF5SfdFiNSNeaxSq+i?=
 =?us-ascii?Q?tiZGYOUwZeBKCFJe5D2dcWCyLVznxjD0RIgopFl8K0kp8aBeUhMpqI5Xzoew?=
 =?us-ascii?Q?kXhBYFYviQuFErqeA0mObnmTz39+mGIkiqp4bD58EMAD61QXjv+D/gadZ5IP?=
 =?us-ascii?Q?5HutGNQIccN0mOgvoPTYT0PHiol4U0cs1kqh0oCf/omqU6IHJj7qlQfzMLdj?=
 =?us-ascii?Q?59GOc9DDs9f2Z6ikgEspL63Vgni6YXqLvgGVn9V5Xk7e9LQMriKxYGRNbQ7y?=
 =?us-ascii?Q?lafVuHJWR030XyhwdXycIoZ6sQ9pBFYPbXfeoO3cKlIxhsryD2a+oHVfscPS?=
 =?us-ascii?Q?hRZElO97h8rnCQeK20E2YQ7Ieq36HCJ2ggviegf1eSDAMfF1Z6hx0Zk3H3a5?=
 =?us-ascii?Q?k0ObEE6g9nztQ0VLqfqv8BRp2/0lYRUj1ImLYbSmHbnC+k3wl93vGXkfw7I4?=
 =?us-ascii?Q?hWxsGg0dY4R6Pv1oxCSTj3wNSnoWKRK8pvakPG7t1CWK9kz5zX1d2SvWuZZf?=
 =?us-ascii?Q?TI6as7Hhr31++DxvnAFPTdcuHJX+FmEYB7/XbQSrJexXQtcYfgEZcjsV8SxK?=
 =?us-ascii?Q?i28pHZwAe380ApukGlmgXnPQJsdAueSfbMCMI0o7DEGYjp/5hYvpGhuu03TO?=
 =?us-ascii?Q?J+yIxPln4bEM3+eMiE2pXh5efbES1AJYL2Y52Ia78vtf9hTVjV+sUc7ylhsf?=
 =?us-ascii?Q?PbbQn6TKIj4q6dsYuCcZY+a+HO3fRudkOoBLd2GwHBmgiKLZPavpWE3cNSwK?=
 =?us-ascii?Q?+uHlUOq28KLARj0J4eBi79eQxubSWG0MTdjj54dUAPgUemlLYPhA1Hu3azFP?=
 =?us-ascii?Q?T4aXEO6s2M7eMM0nOTfN7M2RH9pJ7fhHc0wEbOwCJDOT/RZHH8ACePGScs1T?=
 =?us-ascii?Q?quq86kQmQS+nbEm/++VY/gb3YL8boHkYj/3JQKWkE8wHAKCifktgyW2S1COL?=
 =?us-ascii?Q?QUH9cqItWJOOEjLBpS0BiWZO84qogf27Kk8uSD4hTKXV8K+OUr6B3Yfn/1fC?=
 =?us-ascii?Q?bq80tHCbDbPPQWt2C0zp0dVmHgyAbz17PJssZ2aySnpZ2c9CUJMZ1w/DMwO9?=
 =?us-ascii?Q?PB42MTzVLqC+hmeDsPotmPrItyIzip/KMH4KCTYx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d5f5b8-063a-4504-8697-08db3a9f1baf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 15:12:04.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xb8VM7SLexHhRHXapjfYKZBMIgfv6DC0WmTTDdF5ZtUqCH2Ke2ZP48IU6vsVEFaiYwaWQL6veyVUlwTl3lvplw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8669
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAINTAINERS: Added maintainer details for ele-mu driver.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8ebab595b2a..74e3dbaf9d63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8103,6 +8103,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/crypto/fsl-sec4.txt
 F:	drivers/crypto/caam/
 
+NXP Edgelock Enclave MU DRIVER
+M:	Pankaj Gupta <pankaj.gupta@nxp.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
+F:	drivers/firmware/imx/
+
 FREESCALE COLDFIRE M5441X MMC DRIVER
 M:	Angelo Dureghello <angelo.dureghello@timesys.com>
 L:	linux-mmc@vger.kernel.org
-- 
2.34.1

