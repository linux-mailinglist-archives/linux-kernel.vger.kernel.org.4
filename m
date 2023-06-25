Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932C773CFD5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 11:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjFYJyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 05:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFYJym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 05:54:42 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1B9122;
        Sun, 25 Jun 2023 02:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpUI10Y2HE2z2y1ELytWo+FWP4nTxV1H3fPim+fdKtAMUAHYEjBl9eB5qJADgVeT218UNPOz1pEqET9aCdgDDa76z3UA/YufX0BtYQLZzL2eWSq/tjUF91WuG105qSp7K5/z5p8EnAf+79ZfQPz7IP992DMDFkiXdYklMPRi34lHWXL/7pkxlfe423J3uJYIlMDLKbrseAqeNIEJIYcekHtI20Z36agIiD/P+xumkh5YlY2ZlCOb1LaPbynkcEzo7IyrIfI+izOUOJWjm0fm7K/h/kIyKweFeLVwY9xXHQT7E15vV3Vpg2Uo849p/+JjUWoBBNlc6BQ0R+ypuc16Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llCSc8a+YILetqtGWI9uBcq+ZxVyrIoYe4Rwu/C0SUU=;
 b=Y8bO+YbS24ftAOqyEGuCh9tXhJ/volQ1Ogrs9jnP/dddY2BhEAYILxEPtAd8nuBJac7VsWMwJQCVHpCcgF5JZ62XtBNlxYYiVNBfDVvinpDX5n0uZctLeOUC7nE4t4cpBtmBmkhhflrgpykNiSilWaJm+JC5Wie+SNuBRfnRCg1zcJNKv+Hm83E9y8M2VM0whQCTHS0rVGcYWE7PAYN8l4jCWI3eOjH790tEwc8EHxyRgGNIfBVoSPC+F+PfJ1Z+vayFTOfAMKROaxlGTKMFh1DWjmky3UiUczfZWniV4swRTaLs6v+yqhwPo7RaVItLFITyxxaN6dxFcMh1xWJbig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llCSc8a+YILetqtGWI9uBcq+ZxVyrIoYe4Rwu/C0SUU=;
 b=Vt2sR8F4GhysTT7ibaefmJxN86nk5oiyqx6VG1EeLEnfkDpLA00zL2w3882phursLiA7mVyFYzwFH6sRQU6r5djIWGS7g3QOi4OVQ57xdTqJZgMNKzZ7jZTWH4tVX2XDMiO+MdP1ccdPOgS4vs86ufE7L92z4xVbTi0PTsGB9gQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8816.eurprd04.prod.outlook.com (2603:10a6:102:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 09:54:37 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 09:54:37 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shenwei.wang@nxp.com,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 0/4] correct the lpuart compatible for imx8dxl/imx8ulp/imx93 
Date:   Sun, 25 Jun 2023 17:48:53 +0800
Message-Id: <20230625094857.29644-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PAXPR04MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: c6bab8f3-1abf-43d0-d587-08db75622fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: POVABgtySowwN97UOuqCUsFS9oMHf2rQtkKyeGA6Zgd4MQVXHeMACnrwLDKBRXwvhn9BIP86ydAW2+kJnQQeT7Oo3DJl/OW71JKUlG5V+JJurnajDRYhsx2OebDoaw4aeINMztsJFJi+rFSssS/X/ZOASnFOIkFvvmY0n5ZVqM9EChVJgWh89V+uvhhVlDW4mmzR//7vEZUjAU0kDKcpJ8AunnDZ3kf25XEptQ1mHc8N/Vj/NE/y/SiexCDHwzmL8YGXFR+OpuVhDemRKpycU1o0FUyJGJreZVrPmfaD/CMWbLfJbnK1V0DIarOwW5c1WyKjD8UaI9IkToctOdTNpleJWmqF9JhZ35qWanavKqj19btpagXLbPQ37JLZJ8ThNoaKqZGComfb7qKBL/5W78orFxB0VOaFgdYeuKUiZ9vk6SjGg4NXr+zpE5aYajIWbArZyZuedGS9Fzv0Y2T8/uda0hcO02vZLu86IXb97yQpFUSapONbHxxYprPcDl9LvOY6tgn1pc82a3ztqD3XG22/1qNLbZFiSrMaXA/dcpevjBpiDE2jsv8M8TdrCJPtSUmS0YsjNW9BckZ9/Kv/w806yJwz2dAaIoBx647mV469VfErauEx2vaXAHceDGs8vUax/jLOJX7Af7nP7SH8vA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199021)(26005)(36756003)(5660300002)(7416002)(44832011)(66476007)(8936002)(8676002)(41300700001)(86362001)(316002)(66556008)(4326008)(38350700002)(38100700002)(66946007)(6506007)(1076003)(4744005)(4743002)(6512007)(2906002)(6486002)(186003)(52116002)(6666004)(83380400001)(478600001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?47DBYfTliWL7JDv9lN3nbt0iR/qdkhc2MfhBg9cYVo+zIUxyg+hHrrXNgUva?=
 =?us-ascii?Q?hsH0JOjqS8YDhWEsj9wKnLVWErtyd+gKFcZWfBCMPirKDJXJHLgwA0a97GAU?=
 =?us-ascii?Q?pM4Bto8FcntPuBMJsEwSj6AOdy2IZmEH6lF3zo1CCFCvFvIgN0bBwGuA0z1Z?=
 =?us-ascii?Q?xraU1HnwMQVfrcZTPU5QEgnFr4FgXdUGHXPE9twhDxU6HOOejwLXLDvotB6O?=
 =?us-ascii?Q?BW/2w3GnUlg6uKoQ3fW/bZUBd9dW3EQRcgyvIGpbchPPo1a37T/Dlmj+0Ia1?=
 =?us-ascii?Q?i1Sw+sh8xdJU2953OHwmtYGULhiYFqpjBhLmwWzTzCCP9ew3Fx6q4Yr45sGG?=
 =?us-ascii?Q?qM7QXla8CY23qcOdAr8M0ulBjy0/OUIJkhQC9OPNRNyLw4k1/PwWuB+V2R5x?=
 =?us-ascii?Q?my8wBA1MPCWopp5dS3kVhnSqieu2283MxyPqZysO5vMb+XW3s6IHONVkeRMg?=
 =?us-ascii?Q?WnVgzQfPaCcgYBPNW9cwZh1sbpIQv0AQUYyltCBze/EhKUwoddjqWPp4iW4t?=
 =?us-ascii?Q?eLR8LiFkuv7Kdu/BpK2jjZoKALbkA15ppuZDml4+CWp07yM+gg+CvdAJ40C7?=
 =?us-ascii?Q?YArq6YS7iDVqux9x9AJlVpzSPkcWssMOLhRpbUq6tKPHxgL7i42XnnUBMWs1?=
 =?us-ascii?Q?7iTBu7G+qq/Ig0/wXDDf/u3LEBQhEdgtqhkPf5Z7LGD4srwQcxKYdlCshk5L?=
 =?us-ascii?Q?12bfb4WIzIHaNNxNk+0o40uwhPOfhQF1Qq7CRA0C/M+twH6IMwx8cOt15sP4?=
 =?us-ascii?Q?Gun/NqzFubviWw4XH0ezCp+9ICAY9rWRyNF6rXPIZeJk6NbDFPjBimDiP2jU?=
 =?us-ascii?Q?x5HXEHf2R4Yol18nZa+mt+OgZXPRqT9r+ob6rPmo0QCnwO15g3vhKGKyUfB3?=
 =?us-ascii?Q?07f7hKL3kLlGe41wz+BcE3+og5xnkrTHFalJyLaQeh40Nvacw77yYBJ1bvuB?=
 =?us-ascii?Q?uok2igeTzcxUBR8pRf8cTTf+ROg2GJa/HkTPeLb85rBfYQa5I2ZowvektivQ?=
 =?us-ascii?Q?sx3RqFJ+xmZreTBnbweNpvG/U3PwknxSDaz3Z+07boHsW0uV6ZEM+GccywD4?=
 =?us-ascii?Q?nJs2kd0FCrQBCD1iNa5Fv6XbfWU9QVwG+zTZJ7tDrYGJCRzMRerJwCPFD8E6?=
 =?us-ascii?Q?tMv0fjLUTkzzIxJe6xV/D7xyXevL8Ql6/xwsnpKxEh9idGYhJQZCLvhz762e?=
 =?us-ascii?Q?SU11RLMS6oaBnJCKy5JW6OyHg+338BMECfljs9L1P8ewUtz0lpF43FEYakjF?=
 =?us-ascii?Q?IbilsSz/1aUCwMqGb7F9dCWI/xEo0C1l5cqWdmxCDsqaRRR0j9SQLtt5/5KO?=
 =?us-ascii?Q?gn/+OvHFRENhDi/3uz0Movwk1zvto9+H2lcPNFxirats39C2+TaQ38nGr4/h?=
 =?us-ascii?Q?YJY5OR34LzRHlx/e5hXudh4Nn45wLEb1PTwkoZ0NTO/HDlGgBMvNPLbwi5fF?=
 =?us-ascii?Q?2WP38wnbeNF1BDQAJBURy1sMJhMnvdm9trxdkY8Y7aD8/SBlKAEPNYQo5bcS?=
 =?us-ascii?Q?92Y/8jECjWkYiZdcioPZW+MlFyjB0NSkSfLEETF0p1PBRkSyfgc/Z/BcOdR+?=
 =?us-ascii?Q?C9kYbD9Ckrlp3iVEGD1O++hcHoPvMJ0mHm//KN9/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bab8f3-1abf-43d0-d587-08db75622fcc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 09:54:37.5731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKeI4LDGKzGUc/y0iRI+s+jcfoX7jN9EWNo1lAt9TNDrKAjvF0qYCmqSNmG7wDrRWAmri7JQjNYm96Y1cnvGVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8816
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set corrects the lpuart compatible for imx8dxl/imx8ulp/imx93
platforms, also add the imx8ulp compatible string in fsl-lpuart dt-binding doc. 

Sherry Sun (4):
  arm64: dts: imx8dxl: remove "fsl,imx7ulp-lpuart" compatible for
    imx8dxl
  arm64: dts: imx8ulp: remove "fsl,imx7ulp-lpuart" compatible for
    i.MX8ULP
  arm64: dts: imx93: use "fsl,imx8ulp-lpuart" compatible for imx93
  dt-bindings: serial: fsl-lpuart: add imx8ulp compatible string

 .../devicetree/bindings/serial/fsl-lpuart.yaml   |  7 +++----
 .../boot/dts/freescale/imx8dxl-ss-adma.dtsi      |  8 ++++----
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi       |  8 ++++----
 arch/arm64/boot/dts/freescale/imx93.dtsi         | 16 ++++++++--------
 4 files changed, 19 insertions(+), 20 deletions(-)

-- 
2.17.1

