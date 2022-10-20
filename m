Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6CD605BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiJTKAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiJTKAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:00:24 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963FD7FE54;
        Thu, 20 Oct 2022 02:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/4/OAOhvUnXjndsFKjNgDhqnKFNb89Z0sU8pNKgAFxaedZCxjiYwQ92G3G0NfvIsMYTu9KMatnmQ8YokwRoSwQYOQT4HqFo+xFUfWCTKmPSX8Ovd/HY8cH60DH01TqDaq+3BwtSIJUOwV9py4tmotNiCNiI0mgKGVdHuhxEzlpFqBqOedV7SvnhO9SOcDm9mKUPmdvXBt9L1xrBVZaPh9l4SvxHTawjHNw0D21bQtQ2+YFirW1Vzrhc2AwOTckou37luCeCNpRmwTJKsKmjouMX+7wpmqDUSoKUAoKWnH2sGrVu+HpJ8FhlJWEES0BObrWhIc/eqJRL1FvsHumO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45ZlfSnPATcVCkuW7OpkmI6SoUKfZvDq54LQHVB8cN4=;
 b=jzuE6oVq/308wOHpHAuAqfoMnLkwQZgAPN0Hh50J7GmpzmNhus05D0s76lamX1gUHAh7gx6icF+7j7vpt2pYEX8wfN7PPEFskzzcdjoqlTMTXR4HrD3SO3s32ej+LvqRLDRTkhTbrzFuFenbWI23aVUxv52vlr+58v+1Tu+7g5LysrPKn7Xw9mOmf1jEdWQSPxioQw34cgE8rCi8VCjSxaVKT9akO6+b+21h0Pce+MigCO3+IA9oThryC7VU6a5bWAtTZrwU7q+1QuxnwCcAQy+s5GIFAxoK+9TJq1di3ICdr6tBUVeBvgnm2JzcqzAYkK+lr6d9QcBoV5iy3V8GJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45ZlfSnPATcVCkuW7OpkmI6SoUKfZvDq54LQHVB8cN4=;
 b=Fj92OueG8Wedsi3MvQPU3BMqnLG2I7NdOwui4JDg/mRlyChPVQoLCb7uUDlB9dnuMVF68bLC+bt+LPX/Wyx7+WVLTGU5WburX/pn0zGgy3IbBvubwd0bBFlxXnDi2SsmVVgDhLAQ/M99lFoQaz+qfbN6qOi7C0KLqU15TlqAY1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8039.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 09:59:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 09:59:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Adrian Alonso <adrian.alonso@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 15/15] arm64: dts: imx8mm-evk: add vcc supply for pca6416
Date:   Thu, 20 Oct 2022 17:59:34 +0800
Message-Id: <20221020095934.1659449-16-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 947d6e33-9724-4a4a-f06e-08dab281bca7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AC7tzeWjH3ip9E05p3k3tBKE2ODIoP9zPPLhIjeLBKNVcUWdAY6dklvMvoKEFaySJ81TSCjo03rfOpUoTR4pZyAj+TrBO2uEySBX1hQYsNzio3BDxHiG6PZAaSObdY5XZrPNYuM+YA1wcazvnAeDgSq+w818kSdHzqX5qdxeuJObF095NRVmgyBZlIclOWITfQhJMKW1NUzkqcTSIy3JUQjKSssGNOxM+dY8TfFEUohoqJ9oshIdxw0gVb8yRNTU4s0bqHwGuuLm0glk2LAIlorXdtjvp1wp+JLKMt6Q47Ap0jcw6lLvhvY0xIvxnS5oceI6j4q2y/dsfO43pFynYgIZFB0PFBFFW3kFLOr+ffS5I7UIpVZCv7GkcobA+k7+/ZQyacHOXSJwb3wA3/hvbvvPZl8mwducgLJsw+hXa6KNUfVdQg/bi/YivK+xRyUUbUDrqsLVrbrJpm0I57Fi1xLuGY+XAd/RMvC8s6D71aDee3JegIrgda5F9GdAdyw0JH7IviFxFXScTAnZr6RbaXKDt42GkAqqVRykvfp/PGHBtS4NySt9lCgq6vspIgo8hvI4E6DUB9cAZY8MSPHUGarAbKbILn1lt7yBMssxlp4AJPtkH2HAriASJO1ul6R1UGfAbXzslGbeezlvYSd2ShvWnTMm1+uZ4fC7OopbYFtbmvZo/OpJv12frJ/orqESMQhwrLWX4q1JlBBic/Rj3QE9v1ATa/TQf4SG2TBG7QyLek4JN0ItpHpNQPXysG+TdY9RcZ5v4VwOn1x70/1VXL4jOafdqa8loYkNaPdfK+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(6486002)(478600001)(86362001)(66946007)(66556008)(6666004)(26005)(41300700001)(6512007)(4326008)(54906003)(8676002)(8936002)(66476007)(38100700002)(2616005)(2906002)(38350700002)(1076003)(186003)(5660300002)(6506007)(52116002)(4744005)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8idu0uhp2y0QCFP5xtLnHupnUoLUEFBLNDzPz2HO4SrQxNUwOua3l9tTwO1B?=
 =?us-ascii?Q?YsN25Un3WDiCjaIYBqz/gL1CQgzukvoJBs4CV77cYI0W0PKGnJ+T8ayGJqMe?=
 =?us-ascii?Q?SPyHWU4PZq60NGtqmhR8Z/Qyc3wisaJK/+lXDQ5FSLYWJE1FxHT+/9q26Z5+?=
 =?us-ascii?Q?1eIHamyQ5xHAxhoHdAIKY54LyjkkQKTZp54tsg7eRqaVpEUcBIAAFSH7+liD?=
 =?us-ascii?Q?cDV7AHF0WYDuCKBJEiS3zlcoetZYZeS670x0jh43jpyLkdPklyiAbZZ7YH7r?=
 =?us-ascii?Q?ChD0vzKXLeFi3JC+tDhbpOkMkhLHuGELiSfESCBrsdAaKy8w86KM3LOyM7/B?=
 =?us-ascii?Q?w1woJgGb9dLf6QYFMVlji6Rkczt7KcU4TEw2pKxGI7gA1mR8OUuwM9PWqA6W?=
 =?us-ascii?Q?k1TTdhMFM84E0Ve79pBni49/7jjzbHhMYP5ZFt1r9Lq8OIDkHgg+Akckf3A0?=
 =?us-ascii?Q?gpy84iOJ7NI0FDLNejga1qoTpJRFnzKHHgvmmSq30ReHIdeWFz+nl2ygXn9V?=
 =?us-ascii?Q?L2EGZybNIOonEudkf4qJyNNwagVfH6XQ8E9ro5qsd/Ki6uMB2UVVN6hVEDJS?=
 =?us-ascii?Q?sRs48eV3nvUl+omyUnx9jmVbCGmo0VNYK1YqMWF76kQyBJRpyMEbFN1dwNlc?=
 =?us-ascii?Q?JXO5LmTuUryDFecGLXryyqrpIczGSI+IEjq7M1c75Na8w4kLHZ+anhXperP+?=
 =?us-ascii?Q?filXDtryevW4sav8N/a1Or1fZnmiI5yGraIABQzBBBqSpD9pcouA1GPw32Mo?=
 =?us-ascii?Q?jAlVsqKNhpbtx8SPXhUpMPjomPwpmAj5TtTnZIG4W5vD2DOoQqyhD8Uv1wI9?=
 =?us-ascii?Q?TmexlYnKj12r2ztWia+TsZwbWv/Dne1CiqqMDohU1TVsWypnHLOH8lcEqetA?=
 =?us-ascii?Q?9uYbUKZKSqEuYNNO0h4ob12Fo3bJf3LxeYBpaY2blZB+F+Oq9lYkf8uU4bdC?=
 =?us-ascii?Q?79Okv6qPAB+3yl3hNPqsF2U/4ccrwVqG5qd3TskdGNPweS2Vi6qRvONekx0I?=
 =?us-ascii?Q?ofI/ye3wizrbky2DAJu9BDzMdCjlD+z4SUd8v9jkjfXKS/4GPg/qdEAjnfRQ?=
 =?us-ascii?Q?v7bvmSVxqgAtpQiqPbx6Dq4rnUgzVlzBcoHUuvWGzM1oLQPH7yU4ySLgDpJW?=
 =?us-ascii?Q?vs0DGCfSzg+zMTYJCD3QWeL1fpwC5vKVG5BhrOsXfftRgK6AbJNvquG1W3yV?=
 =?us-ascii?Q?NpbiY68OFyX7b45SxZEoIAnJg8Km7KJLxiM80UfQjlKsvpv3kmO0K6MDwSBf?=
 =?us-ascii?Q?8iNs0GNqd0CG/IMb8zVmIn6UJDVZAuwU/S3bgge46ka9NHYX4n0A8JWS63nW?=
 =?us-ascii?Q?GjA1RdwjK92cqURHGVeGKswHJJq2dfb6jxB45Ma+dGe6xVf6W1Vdg6s0F63J?=
 =?us-ascii?Q?JyYRwWGmJTPC6g5523sTuoNiwcoFs1p8DbE1vdKp4q++pdBk2rgxlJ2RQadz?=
 =?us-ascii?Q?+1is059h4zw8/qixeZDbQC27TgvbXQCIOprSex/icrCb3ElEYmUzdKfC1pU6?=
 =?us-ascii?Q?LLGbBo5IGNKsi7xUSY8mb8jKJ+fgS8u8NlyvQl/DeWUUOr6//2Wmm3jmg4s6?=
 =?us-ascii?Q?G99vhRRg2h6EZU4WgjUO7ZGLYDgj7bnsKAFVl6ev?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947d6e33-9724-4a4a-f06e-08dab281bca7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:59:11.5444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDyzIkuTrQvkUnY5xrfPLWxcNHjn+CcbsC1yEaOVHcrSqGGilzieqdWcK2N+qub8RvauC8N87rdbq9TRtABrRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Alonso <adrian.alonso@nxp.com>

pca6146 requires vcc-supply to work on i.MX8MM-EVK board.

Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Adrian Alonso <adrian.alonso@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index fdbcd2483efc..31144aefe0ba 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -344,6 +344,7 @@ pca6416: gpio@20 {
 		reg = <0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		vcc-supply = <&buck4_reg>;
 	};
 };
 
-- 
2.37.1

