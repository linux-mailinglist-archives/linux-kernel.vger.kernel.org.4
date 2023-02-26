Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357D76A2FB3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBZNHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBZNHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:07:35 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2053.outbound.protection.outlook.com [40.107.241.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5330F8;
        Sun, 26 Feb 2023 05:07:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTHulXEa+UiueVpf25yVSnXtlng5HIKObFRxUXS1BOg2gNu0mejOkZgMzWB/0NhE0e9kkcSz/m0V7Vv33m0SaKQet1VhdQ+aJzWT9yYMQBTLsNtzqfLyWJwkSlh849alfiBxLGJSgE3imshBzBViiGEmiu/mlcIjVRnNOiBB33L85lBIHhoXKaLGQL9jlWRXJaWOf2Ry7O/jxjLJkwGqUBNWuRnwz/f0KTFa87mL7xpIGbnjjilc2efpxxqYjX1pnhCIbtyE6Wtlp4sBcO3j6QXsgu/d9WGsTQ3eUBGftj1mEDoPyzV+PbaZprQlmwkCR6kbdhcwJg52uPbEjyAusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPeChp+Hhy6LO/GJbCYgrurAT/gnM/15Bg8oXOXgMhM=;
 b=c/toLBWJmos2c/7nahSI038rmnICtviY7SZTP+qhWTD6jg6tjGTSs6hjUvJNMZC9YatEUhQTv9knOoVCQxQiD8fnI9Rd22/CbzXFN2ezRdR0aPNj1/yxb2STNEJZ2KVKD8RkJ8Ufo8bOJGEv+WRrNILJRvFAPe06o4oVUFRBGzQdp7IZXcFvEvjQZRrpVuvZVBC79sDNEzTfuD1EsF94IlqFJMhRlIQwS8javxvpG8vGnzWnliTOt26G2CNbfpt18qgBLEwmcZmsmAMd0mFS7+aQlFAAZCE7e52TgOMmG0DEn0CMPkhtESPwh/vmS/s0CTLG+pW5AahpfJUpl8U0Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPeChp+Hhy6LO/GJbCYgrurAT/gnM/15Bg8oXOXgMhM=;
 b=LiODzaf1E3zqNBejoGJkpIXrFNKZ4xVdkYeyczcFgglmsObLr0ug3Hefy66/V8XSr67wSdNKKS7OmoUNF9K4aG/avKdBFJThFybXcX85ByM6t8yFqtkiIX6oa43CU3RdmRVZdVP4Tszg7ozEHYUcM8N08rEsuluU/Kq7SDRM0Dg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7962.eurprd04.prod.outlook.com (2603:10a6:10:1e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Sun, 26 Feb
 2023 13:07:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.025; Sun, 26 Feb 2023
 13:07:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/3] ARM: dts: imx6sll: e70k02: fix usbotg1 pinctrl
Date:   Sun, 26 Feb 2023 21:12:12 +0800
Message-Id: <20230226131214.278911-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 735e87c8-52b0-4aa5-d062-08db17fa6ac6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /KP7hPgSr4zyxde63jMrX9gBBVSEzo8rewf09zBNVIJlcemJkrqZLT28akqVeV2M/xyk430zfSMeSb4c59KtDq3Y8CLU4Kx84P7FL52174ItKX7GkN9aK3G4T7vevUp2Gikl73kR68gUEWvqHh2CrQLWuUjqhTbVw6OkNOzSGOhQGWZpCiZRZ9v2LBbk6CIwxnDbvLZWf6YvvYazBAwm61900ysx+Qrjg38+jqfPZX5Cdr/XkKILB/SlGQ+eoCzp4FCeLxLXGZLpkhpk8e3xQwItf4Uhvo/AIUVwopXXmTNt2as044Ejd/LdYGsbP9jQQk6U7yHB/Csyc2dMW2u/rET6Bp26Tc6Cb3ALhxzo09ssvZT4/6Tn1KWcDR/BWixMhWN+0VCmFVZtvYwfvBYLKWAcxE5IlChc1vulV8VH1c15rm6mz85vrlQuoMviFtltZZol1zCMkWCZE4E8o+VEMW4A4APURpwPIYzNLW9qt6QIZdIDGhbafG7v1OfJP612JEpu7ZLv/8mqclmm2L/RCcINOycV7BF0j/npBx5pcuXzCYMh0Q01hqt6EKyY4XjIUFDcHmx2y0FkKB6WaffmZPOv8Z/GIRiuzZLF+Ma4OFeNws5eBw/8jGgaJhUA6QNw7d1/DDTIIJU7gn5Z/oal04YVhHAjX7L0akNmtyVn2riEpeZ1unEtA7d89ia/yz/KqqM/A66qua09pyj5GhoOLKzrTwVJ3Mf61YLodCuwk7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199018)(1076003)(26005)(186003)(41300700001)(6506007)(6512007)(6666004)(478600001)(8676002)(4326008)(66476007)(66556008)(66946007)(316002)(6486002)(52116002)(86362001)(4744005)(2616005)(8936002)(5660300002)(38100700002)(38350700002)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oRtW0n+VIsgK8hldwUvqiqm1c/m94906DjfYYmj8jFe9QW7JoxVT+rR7sSy0?=
 =?us-ascii?Q?t5+Xh771OE1BYeoVNFozb70IW3p4PiKjU09gs/anGcZ5MEC95f40KCAf7GaW?=
 =?us-ascii?Q?n+pkC5JiBq88p5YfDFc5Vl8yL6Mpus3wl3UqRDKcLUrip2opndB915MlnfZH?=
 =?us-ascii?Q?RnkK4BoatHgzVD7HpGsCp8IfBBwFWXoyS3sjFVHTL9N1ujeKw770sVDMauGu?=
 =?us-ascii?Q?CyidzNtXBexJKdm4GHX+sEwErVGUp94ve0oZJ/5UH9cPSh0nCrmj04J49U8y?=
 =?us-ascii?Q?lsYJ8r/mYW2VBPRlHZw3QYMQ7uK6NQxiaaRa3r2IAetvOsOA49xSG6dcNaMQ?=
 =?us-ascii?Q?AvZ8X6VNOLg2ZFh0a7USkRd5KOatKBsFEHEPbar9mv0jl8tD6lKO63plJJbf?=
 =?us-ascii?Q?wjQUn/E8Ckf0UBvVtOMJaWYju3JsuvU24ZzkDGp4IwhdvhKztZ6wA+Jy+yTj?=
 =?us-ascii?Q?YbqMdhByMu1zHbncQ0q21aSwChCR6MJ9X7gxGor+6vJ6NkSxhw8pFO08sRQp?=
 =?us-ascii?Q?JQZAAP5XmxWy2wF3EWaqHPBd5HnkUbLkltVrCM+98KOibGnj6tICg0ccE2py?=
 =?us-ascii?Q?CqJN2S8luSmt2psV6mqMFqTo1ocHjECR+r3KuNLqiVafZVhf8RuuSgyz9GNg?=
 =?us-ascii?Q?xFTWM6M9o5X1v7/0t/B3cGz2ZRoroVTKEVOP4or8aJRkNrsZNclEcta3jW+C?=
 =?us-ascii?Q?YoKelQixYnrDpgzJd4yNA1SUMw2grcB8ax0CDislnJXC2bvSqIkSoU5rGhpJ?=
 =?us-ascii?Q?wqbYLwRYhvvOUP68N07RZiFmRw2cOvgDZctBmH+yONoM7AhYZUfin5OcxbLk?=
 =?us-ascii?Q?arHEm7M7kea6JUZM4gli6OhsBN/DCKrRAdMFfmIUZiUezuQzclaPpaNT4YlC?=
 =?us-ascii?Q?0aFXRSRLW0ijZyjC0XImQny8MMFEXiY7ztINcA7sDzsaChlUx6FwH0HatyuE?=
 =?us-ascii?Q?cHTvnwVz/zg7ktsdnUNAArstGfRh5D3zM2dQjGZmffac+Jq41pyVPShoi1WR?=
 =?us-ascii?Q?K+qZo9qZdHEYRbT7WrMUj6Kc5jAi1q0ltz6THSQmxXPN9MxO1Ao0SC+jpoAi?=
 =?us-ascii?Q?/zPxw0TQH8oZNFOE+eu3drLEMhbPZZxJnqenAMXGWB9RlgjaMhLIRn3fky45?=
 =?us-ascii?Q?vtEZz6WDF/TsvS1TjuQRrcGoUpQ8wbJBncioJMAatirVeCp74Q80jTyRL5J6?=
 =?us-ascii?Q?Hy92OzLsruNvsEo8Yyn6WYI9Rga/LNiVrZ7M3LqhRZ816kuQLiP27xbe9cbV?=
 =?us-ascii?Q?7S3fD/aKBgb4b8mz8Qj0LkHjQ2dbt2BO1ZlTnD5yIfblF0FbI9bqDCyJZi26?=
 =?us-ascii?Q?jZYF2XsnozquSVdkukPVecGRL5iYPC3EHxkiivOnv3bStxXqKn1Dyc009mN/?=
 =?us-ascii?Q?VR5xR0SutBu7t2ozCK5LCq4RYniXxOJc8SrbZE0WYZwJtkyReBTSy9iDg8w/?=
 =?us-ascii?Q?gLfJ6uTO05iQ2HcbvyBskh7lj8OmUMqZk67AZ5B0dIlg86QrUYiXo6zkMvuE?=
 =?us-ascii?Q?2jVoG3Gr3jRKJNtw+/et6+fjjlX620Jk1Qfi6Zt4i2gwfAYa6x/HZZpCqoDn?=
 =?us-ascii?Q?PR/WGI0Z4QQidcX5g9AN7QsFbOCYVQbsfNVVNxIO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735e87c8-52b0-4aa5-d062-08db17fa6ac6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 13:07:30.7015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 568IEf+dY1ZlcF78zxSdxh+4JY9W6SuXsgNQ3FFqwUQ/o5y5jXLRRbqNdMqOUM7GrrSUZInp+Dw/XRMT5GjRkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7962
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

usb@2184000: 'pinctrl-0' is a dependency of 'pinctrl-names'

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/boot/dts/e70k02.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/e70k02.dtsi b/arch/arm/boot/dts/e70k02.dtsi
index ace3eb8a97b8..4e1bf080eaca 100644
--- a/arch/arm/boot/dts/e70k02.dtsi
+++ b/arch/arm/boot/dts/e70k02.dtsi
@@ -321,6 +321,7 @@ &usdhc3 {
 
 &usbotg1 {
 	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1>;
 	disable-over-current;
 	srp-disable;
 	hnp-disable;
-- 
2.37.1

