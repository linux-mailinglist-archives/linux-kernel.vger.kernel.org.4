Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592A266B431
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 22:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjAOVfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 16:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjAOVfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 16:35:18 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8381632D;
        Sun, 15 Jan 2023 13:35:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzO0Yi1tkeTXD6TzQq15tI2b7SgXgzKLxGaF8+C4wp15oWvPlGiHgd3drqq7VBCsdAnxThSTeMohAnSELEFSIJJKjU9vkGmfTYotUNSuYaLwKiyadBqeyB568tqjS34qqOqpL4zYXkbO+F7IiYhlShsKNexE0s9J1lkYTcE55C1N0wWbCPv9Z/0MYV1tmMUlMOHb6W1ZxqrpbQ02C+ZiljLVdmw7AX9F90e1cWF9jDoE6FRMdRKb7Mtbe9MzMB+ELXOefxIP/NReJH27Z3RoahCd6xW7afScJZf1wAw/z1JrZvokiKXQBum9dp44Co/sxMfS5yqP5OZ2mhI/7lP5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KIBzV9X4o03JcBg5zot6EBDFjNtT0pLDm4cxXYovEw=;
 b=e1Zle/Qsijwt3MBYRGT5NYHfL1mn3mEKLrmFpZv0gMNgAnTHZnkz7SlCBD7qxixgFXpGZZHYl6456BQ3kxxQX2svX+KC/w6gmd67UZGgLzGmSt7cJF1Biyy56ANtdsh9qiaVBqyJsVo8FWfpJfsHrqGi5e7BHjs5zwFmXTGcN9xzRAXfKT8ezF8m07gzJhth7I/2dH9RAr7U4dDyvjlEt6sDm6SqaYw0LZaT4RzBg+5Bih2n6/iEyZGNemUsKzghqVvMZYSz6hVWTy5L6YpPoRta5ED0PfNuu1OOql2Hso16/qKjA2RLFIkpWbEF9yLfHAFwqOun00kf8V8C5iw3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KIBzV9X4o03JcBg5zot6EBDFjNtT0pLDm4cxXYovEw=;
 b=gqSpVtLZI6o76OrFBGj9qjENCnPk85cxZo1IgzTtp9GPFlOgW3ZwSDwwGKO0FVhj6wfSh2dfp4dNf3xGHpvShQzzwuqXqQHIQ5XVoiFxMKv6Zt1G2qgybEwznx8cVJGGthKu9OoCF90JEzUnIEPq78hDyj1M/v6zrwTGJl8RFZXvOFettCY4U8lChMfPIfroOOGrR7hj6LKoHhc0hhENyN58SVhYc+YVyjutBARSgwnVZvUcIDUXziAAeaklXJSrB1oqFHK0uFiYkIB/cYz3jbeBMJ79UCmN/Pe5HRTNku2DtKdSNuGLsQHL16Er+M5FHUXxXCH+/Hx3br61c9WVmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by DU0PR08MB9607.eurprd08.prod.outlook.com (2603:10a6:10:449::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Sun, 15 Jan
 2023 21:35:14 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee%5]) with mapi id 15.20.6002.012; Sun, 15 Jan 2023
 21:35:13 +0000
From:   Pierluigi Passaro <pierluigi.p@variscite.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, marex@denx.de,
        peng.fan@nxp.com, marcel.ziswiler@toradex.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     eran.m@variscite.com, nate.d@variscite.com,
        pierluigi.p@variscite.com, pierluigi.passaro@gmail.com
Subject: [PATCH v2] arm64: dts: imx8mm: Fix pad control for UART1_DTE_RX
Date:   Sun, 15 Jan 2023 22:35:03 +0100
Message-Id: <20230115213503.26366-1-pierluigi.p@variscite.com>
X-Mailer: git-send-email 2.37.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0090.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::43) To AM6PR08MB4376.eurprd08.prod.outlook.com
 (2603:10a6:20b:bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4376:EE_|DU0PR08MB9607:EE_
X-MS-Office365-Filtering-Correlation-Id: 5159cacf-1a5c-41be-688c-08daf74062f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ekSA1GK0gKixs2XPVS5JiJc/mBC7J5c1ht19S082ozrAYSgmBq3KLPN5bMZQl1s9B6/deO2cUnNZkY0Bj7RvZWFpjNBfN/4qR3bAa/Nl86HecAr52TV5v5iryRn5cgpHe46f5RuAVIoNAQY1JKuqCGKlZnPJv32bicSrHlhtKsjf3ZO5p4tImUFj5tvL2UrrA3l/plFfW0lt4w1PuTidwbXkKhU2exnVqae1viO/s6GthQLJ3IRBXgX8cGPO3jsEiKZJ9uxYEGOnzHzFIY83/0Hb8XlsCfaKCW6ldGcaFokY8u21SWXibPY4XzSVLFP+B2WmpSaFaONCFX+rJOz2KXCyS6H+yJoprMNHFwuJAygvDgi6YneYeOaFYl45cpHE5f3D1/rTdL8dk4pdtcdU422ObJY0ZsJLcB0DPRGbPw738MEZtMxPBvDz+L8EkfNNyOxLe3YC+XH5HV5tABJZvygh6WqZZYheee4SaDtiqYmNmbALZ6L2xsRwyT+Ya+30hPqW45KEj36orGH/uJIFA7srtKS8TTfFByeScLCXi82Tidtb1Nr7vt2rpCJ29KoP4Qo5mxB023qoYVaDJGKoMZTAIT5DWxIVn1qZHUBkojAi+0DkTzwCPRA4pg0CVzaRlwov/I7FzcrysbJA9WolfQyzMOPkbdQkM/Xcx8K3oml8RExOXHZOKIDYRXTJVL4plZBMOR72lVSYNpiLAWm5xM9duvpxT7DoUH82kFZCC+ZT8T9qLR26HFW0uNvHwWk8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(396003)(39840400004)(136003)(451199015)(36756003)(66946007)(8676002)(66476007)(66556008)(4326008)(7416002)(41300700001)(5660300002)(186003)(8936002)(83380400001)(26005)(478600001)(6512007)(6666004)(6486002)(6506007)(1076003)(316002)(52116002)(2616005)(921005)(86362001)(2906002)(38350700002)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2dmQm1iU0VPSFlBS3Rub01EdTR1eDJ5cGg0YmRQOTlXRHFkK1EwNDJkNEp6?=
 =?utf-8?B?K3poRGhvekliOHltaVdHL0d2Wm5GKy8vc0RPMnBxTkY2VWQyeGxqOEZzTVVW?=
 =?utf-8?B?TzJJZDMvaTlob1BYeWhYRER5Z3RIWDA2V3Vla2V2VDZobFc1YnlXd0FNMnRj?=
 =?utf-8?B?WHVVSDZTZExLK0NqZmtrYzdjcWJKK3RnalRnamdMbGJNeTM1dVlaMVBWV09H?=
 =?utf-8?B?SU1YZTNRQ2J4RmRJWW9NVWd6QWlRdTl2Tmg2bTExMGZKaUNHcDQyejBrZ3JP?=
 =?utf-8?B?Q2w4WkNjNWlUbTVrVjJFRGZTQW5FRFZHTTVTTWVlK2haelBsaEN4amYwd1lH?=
 =?utf-8?B?QUNsQSs2aE43cjRaUDNLRm8yY0E1K21Xb1FFV0pnbi9rOWI1YVFzRXJNNFNk?=
 =?utf-8?B?MlI2ZVR2NU8zcmRCZGllTFlqOTFhRkliWnJGbE1oYjZBSDN0SEp0QkROVk9s?=
 =?utf-8?B?U0huUVExbzFFZEhQOWFCUjJrNWM2bldsSWo1YStvR0xLa1FYSHVGdGJUam9L?=
 =?utf-8?B?SzIwSmVVTHUxOUdrMHZiREQ1Q2llN1l6OTVUQnpHM1M3SWg4M2pkTFR0V3Vy?=
 =?utf-8?B?dDBsd0drV1BDRUFtZnNQWjdsa0VDT21XYzc1T3p0cVZkTHUvMXM3VGFaRncx?=
 =?utf-8?B?U1JZU1UwYXViZkZrekxQMjBoZzdiVStjVVZKMjJKRXZ3UUlTYm01V1RURUJX?=
 =?utf-8?B?SE5QZVZCeDRmU2tITUZTOFlRNkVnLzMzcEFuN2dhSExsZm5aa0ZHWWVDZE1a?=
 =?utf-8?B?ZWFyVUFRVUhDQ2F4TUx0UlFFbUQwNGttYXh2dnhnRHNiMlE5RFJoUXhmc1Jp?=
 =?utf-8?B?eGFUaVoyalpDODhlUGZHS2xLSzM5cVIyWG9UaTc0ak9oZkFjdk1ObTFJWE5x?=
 =?utf-8?B?Q053cFVoM3FXZ09Wdi9IVXNEZUlNRDMxVGI1Q0lMWWFZQ2lRc0lCMGxIb1R4?=
 =?utf-8?B?NUI5a1p5VmhGbGJjQzVBdzBDdDZtN2llUjlmQ3M5aTNlZnI3VVh2ZlNVU2hM?=
 =?utf-8?B?Q3RTdEVuVjBQRnY3d0lNQWExVTFCK3ozMDYwYXZjS2tHMmNGMVlwUnNmNGhh?=
 =?utf-8?B?UndPaUszRlUyaDEyQWJ6U0QwNG93QkFHR2t6L00ybXBmaHI0MGp0N1k0Q0ph?=
 =?utf-8?B?VThtNkFWQjNoTm9QbzdvTGY3Uld5UTlJVmVyM0YrTWxoRk4xbmYzdUwzZ0Jy?=
 =?utf-8?B?UlBYeTBCUUE4NFYrUDhRWWM0aHdVS01MdjNETFlCNUdPZHFHajBDak1uZnk5?=
 =?utf-8?B?akZHZ0pTZEVKZzZac1VNZzBsYUhiaGJGVnIvN2pVamMyNzZGb254Y25vWWdP?=
 =?utf-8?B?S1c2amhpV2pDRURjS042TFR1YnBBaXdLNlhIZlVCalJGU1Yzc0ZtK2VtWFpO?=
 =?utf-8?B?RVl4N25kV1FCMWtvZm02K3BGWVJWS1pVSDV5b3NWU0o1REc1eXk3blBJZlk5?=
 =?utf-8?B?WkFyS1k2RDkwSUljaDIzRGtYbmNRZWFoZ0VTTHk4amdMSGdxZ0tDd0dveTdZ?=
 =?utf-8?B?Y3BrRDFENGxOWkJBWTRIbHFIUjY3bWNkTWVhZnlKbkQ3OVh1dHgrY3RIcTd6?=
 =?utf-8?B?eWRaNG5Ld3JiaGhoL2crQ0J3Q0h3RWJIaDdjNThXV284VHVUV3llU1V5eXQ2?=
 =?utf-8?B?NmRwUEQwOWJIMXIvZ2JkNkNGZW9aTzZtMVBpZXhEQWY1ckdaWmJYdWlySWxN?=
 =?utf-8?B?c3Y1eFpuenFaa1IzVXB6UXRKWkpUS3Q3cHZBbm1jTzNwaStzSklLVmh5MXRS?=
 =?utf-8?B?bGxxQWl1QytNUHdCQ1V2dWpzYWdhU0krMFhMWGE3clp6Mk5QOW1VT21EL1pS?=
 =?utf-8?B?R281R0Q5TUdWZDFGb2VrMVhwc2krNmdrWUFKKzBGVk5zN0RzTE1pOS9Jdnkw?=
 =?utf-8?B?L2cvTys2TEJubTZQcUFSWGc1SXBvbm4rSjVRRUl6R1RBa2VDWEZPUy9lNmN2?=
 =?utf-8?B?dUxsTVhUTjI5cktLYy90RnF1WUY0aVJ1UkVzYlc3R2ZCaGhzVDJOdmJkaVRJ?=
 =?utf-8?B?QlNReU5DZldEUlorTHFTV0FMczl2T044UitPeEVnMlVzSGhublN1M1VuSExO?=
 =?utf-8?B?bGh4cGorOUJYQVdEcHdlS1FnZC90dWhlTlh6QzlHU1ZUQTlwTDEraWp3U2o3?=
 =?utf-8?B?dHdoajIxdG9ka00rN2xRbEtBUEVIRlFROVhhb25zNlArYm1aSldRem1pSHZB?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5159cacf-1a5c-41be-688c-08daf74062f8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4376.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 21:35:13.8010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8a/Jc2feRMQ+wy+SegDiqp1CVU5ncbJOz9Z41ONh3EAI9a9T17odOYBfnkWyBZNnFLqNGmuJKR1ArGDIyJcutrW7n9pYsbyoOEUHjXO6vI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9607
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According section
    8.2.5.313 Select Input Register (IOMUXC_UART1_RXD_SELECT_INPUT)
of 
    i.MX 8M Mini Applications Processor Reference Manual, Rev. 3, 11/2020
the required setting for this specific pin configuration is "1"

Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
index 83c8f715cd90..b1f11098d248 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
+++ b/arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h
@@ -602,7 +602,7 @@
 #define MX8MM_IOMUXC_UART1_RXD_GPIO5_IO22                                   0x234 0x49C 0x000 0x5 0x0
 #define MX8MM_IOMUXC_UART1_RXD_TPSMP_HDATA24                                0x234 0x49C 0x000 0x7 0x0
 #define MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX                                 0x238 0x4A0 0x000 0x0 0x0
-#define MX8MM_IOMUXC_UART1_TXD_UART1_DTE_RX                                 0x238 0x4A0 0x4F4 0x0 0x0
+#define MX8MM_IOMUXC_UART1_TXD_UART1_DTE_RX                                 0x238 0x4A0 0x4F4 0x0 0x1
 #define MX8MM_IOMUXC_UART1_TXD_ECSPI3_MOSI                                  0x238 0x4A0 0x000 0x1 0x0
 #define MX8MM_IOMUXC_UART1_TXD_GPIO5_IO23                                   0x238 0x4A0 0x000 0x5 0x0
 #define MX8MM_IOMUXC_UART1_TXD_TPSMP_HDATA25                                0x238 0x4A0 0x000 0x7 0x0
-- 
2.37.2

