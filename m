Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEA073D0E3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjFYMVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjFYMV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:21:26 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D0F10C6;
        Sun, 25 Jun 2023 05:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dulOfBaqOukIsb394SRmmoFfLzdF94ovxjW6HJGO42nVQanZdi0y5HOHFSSz5INmLYbSCO/5/MYTvpNbq2WUTmVxaSR5QvDJL49EpX/dzwXgOTrCG2Z4NKlSGsDDUyKcURBmCNUOqKNNNujZVHu5yNInPsxr/PVgIhDgl1rZyN0aVc974uqRAKD9R93ekAw16RGNJK3B1Vq920H7he0Mx3yvgejVrqURvbRIiAnHrd952l/6rj7od7xNfqVXZKlfk4qpmYV1dBafOt0w0nhvfmYmTnWcYUDuYBH97rrkxvTcqlW5Y1eEJ70nqZM6+t8A/fHvXTEYif9V/mvTRi/cLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JR5zeVXW9W2yC5NS6z3aDckYQroTYDEIVUbKjhNJjsI=;
 b=NOV8BmfH3N+LQ2wGHyDq1E2KM3AWYbog77wRnAUt7TtGzUxEHoPy9sp7wNOgcfTCuzelUri7EsR4m1SUd43GAQr9omV54pr5BSh/QoWeMLKodRC2ygUwACBbGbQJxO61GZmIuY+ZMLbWxhC5KbqOt2yjUd+uctUIJfHo5cn1n4DELWmqbxX7J3sniZOGpxKyzp5+0CAbOXfbApKxmkoPni5XGlIcQBR3KlHQj4rlHnXikQEIxxVcRn4DEE2Ojn7As/A4m3vN5wFRUXs8hHPkY4T4Id/PZTyi0I9wVirwNt5v/oHTk4TWfadMsCEuUAza37C2yPLDsWNTTrK1+2efSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR5zeVXW9W2yC5NS6z3aDckYQroTYDEIVUbKjhNJjsI=;
 b=WWY4W0AXq/Pk2EdQSMhLJiWhn/+WKFyKc8ovlmU3xDAO5lECr2Tpv36TLGC/gjxJ34yqbOzyEMYydkixWxOKrUXKD8eVBi0l1dTaPnhnV6bBmbUMtEYUtzh4qin/nkLqRHH1CQPjrcTBHRZ6bzAi3zDyb5QkYZxChfDeUMrE7no=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9129.eurprd04.prod.outlook.com (2603:10a6:10:2f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Sun, 25 Jun
 2023 12:21:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:21:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/4] arm64: dts: imx93: add cm33 node
Date:   Sun, 25 Jun 2023 20:25:48 +0800
Message-Id: <20230625122549.4066027-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230625122549.4066027-1-peng.fan@oss.nxp.com>
References: <20230625122549.4066027-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: e4282a73-c058-44bf-17cf-08db7576a828
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xdXX1TpiW0SzQdUN1ef+hGVNAXArItUypL8nlxNvvFPJXHq2rrt3oP9OOSmyiXFbdKYgZMHTlCqYnIgnLOHD6s6qPhpqpmbJEj1A6GrPkzSyZhoA5UpWeicdQcXpl5nlo6X9qCpNvV2r4z7fDv7oeXndICp1BZyxcsJ2vIp5+oTwdMJjlSlO4KP9yzL+H9XVH8qRSQbUr6KgaRiQ+wzY1xaUlBq1+NNU31tOYYPEQH529nxRo3ucHdbZA092hCNWdcFEScJ8Z7LVUn011nyTM1LQD7BAsoMccKHC9/Ku+FT5f8EkiOaBN4Ae/cH5Pxc9uNVJWGF6qsAK5oYBkVVm53QPl4aTejj0cuRoIuyMZF/wuVEPwa3RqqwDObe+baz04UIN92dhphu3HXaXkAjb4smg/36HZ+S8CBlfEJKlre+L3A1zozqnOVxj/AqS5perOUlT1mNT7iAfTFczCRGeY/YeIu0HOunqQLR6mLClL8UrEJy+VSOVCjeNeRsIExrdV0gOHth10u4hKSz6KJUy2kUlzx4+LMqN93HjN90y1e6A4+mXA2TeCzi+3PCnjafduTR4W/CVgogtA/8UQBObtei88JMgN7hIwQr9fvbNcWOMQ3wBWQwlJWyrd9uEH9K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(39850400004)(136003)(451199021)(38100700002)(38350700002)(83380400001)(86362001)(478600001)(2616005)(6486002)(52116002)(6666004)(66946007)(316002)(41300700001)(8936002)(8676002)(66476007)(66556008)(4326008)(1076003)(6506007)(26005)(186003)(6512007)(4744005)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7lA14OUrJ5KFcbS2KVaqda30gu/XpA7+p04r2TXH9ELbLxNB7OXjfhqCiDIf?=
 =?us-ascii?Q?m8iX/mFq/1YwHF2QzmxTFYReX6/acBpTyoeOooUeMjhBMpYIAR5ogpNAy45l?=
 =?us-ascii?Q?oyzdid24OJhGbn8WY0Z+Jt36Q68EOajzC3A6E/OcpxUeOrGA5UUq8WdbM+4e?=
 =?us-ascii?Q?esaXEy9xxYaxXXjDMDY8xj3qywm31QvvlXN8nB/qDzHRzHFo818ZrxgRaQUS?=
 =?us-ascii?Q?sKSbNaTnsklq38544E6ZUJh9/F5F+xbub9W8aELvvqMaGWVmJ35d+uaJs5KV?=
 =?us-ascii?Q?kYauc3FGIOlFQcIfETvDTvQq3VCC5D4tiJTVzNbQmGjsHn+c0cdU3R8oHT+L?=
 =?us-ascii?Q?QIf109LDyvXMwf6r6XH9DcEG9KNxZqZsw+463pjhLfUAIfhDEcPElfXjgrQF?=
 =?us-ascii?Q?95Ldx3SMNIllWY4fqS4fSNhO6qODY3XVBac06ZaYIXxbqI1yej5nWz4okxdl?=
 =?us-ascii?Q?ptPTI8lgU5q+6Jq2tBPoyG+x7QLTBoV97CjVwpQsQW71/U+sH+p/Ke/xRbO6?=
 =?us-ascii?Q?eqC/m6qNrP92SqnJStIxO777y3mjBb4oeaV89iYbSg1bTPZgAl3ZiKgKJ/Os?=
 =?us-ascii?Q?Uo6FmjyTzE4MxOs3Og4gRtkTlBdX35tjYXGm+06V8mtv6coO8eypJes0Hrwp?=
 =?us-ascii?Q?LhOUMxxBUs1uqUIixdTVrFOQ66UiJapbSf16IzUuGxw1620/P6fKmvIepokv?=
 =?us-ascii?Q?AcrtXJbHvPn0cIOQJ4JRN7f3aIQ9zZ6fbwEBRQ0TKaN/ABgHOBk7F/bkmC/d?=
 =?us-ascii?Q?LflQiqWdtWCNGNkWgvBQm0t6oCuJKHDH+UmXUJOus45lpJv3o6utyik9uV6E?=
 =?us-ascii?Q?MQ+TjI7UQJ6iaLO5d2JxPHXNFmQz9kRhD5ifw8a+xyX6IPVgfNXN4KP28iUx?=
 =?us-ascii?Q?p0LLK1CTRCIIWTste4SjXCq3HX26GWZUlQgO7CnUq1TtEkakh52eGx4CT3jx?=
 =?us-ascii?Q?Sc6KpQ8+3FdDfsTVNsN1gpxec0owbyZHgktQhoWoArd5HAlAxGlWOS+E6uh/?=
 =?us-ascii?Q?dDsqLzL/0HmJ7uC1KsFeq76D4jiQ/+GP4sDCw0Me+C9po1MFPKemKI4CE+Ov?=
 =?us-ascii?Q?VAWi2U4O4Sbr1Rsh7bggb/hG1qCoo5z8CCK8Z9+o/fU9y5tl1SYdNlhXelzq?=
 =?us-ascii?Q?nk0Wg5ld/Gz8Jbp9aPmVGCZundnNa22Qex4AVxPtPZa79e8XwX01lmfv+PJ5?=
 =?us-ascii?Q?6tf3a/bDkzjc8IPMcSpNs8/P8PHlnfxfL07qL3hnJjL+VQOm9msdMK36zWDa?=
 =?us-ascii?Q?0yPfL0BQKW3kR1tlsitP7bYnlB1Ez5rhbMeCIB9e4Pe6KsOME+d8d3Pugn8b?=
 =?us-ascii?Q?J+6XDnciYovlznX1z1rxSAe0ROE6TGdKzVmA0UiN8uDSgKF128u9R8hdzjuy?=
 =?us-ascii?Q?RL4AzrnMx5ZIEItC/hMDnBfIXPov2X1/iW23OtbO8vRvlQ96bPkC70UA4bEl?=
 =?us-ascii?Q?vHNb11SRjCkBl/YCCxx9rkO11YNLhnfnxOwmfmLfFJ7XmPrpKRIRjZhqifyZ?=
 =?us-ascii?Q?n9ITolBYEoUbz5ZsiM6wGtvwa2QrIh1n4ofohZ4hnSgE1tDMlZO2xyWZQWUJ?=
 =?us-ascii?Q?K45pFtO/SzIjY2QScYaU9b5cQYKX9mZvqD9uMudM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4282a73-c058-44bf-17cf-08db7576a828
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:21:09.3718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doIZfpyggmyjhE0Xl6nNs3StuAEn3t9rl4pXagHs2PLvbi0xkJggVWRv7lB9Z1U9FHq+zX5wlaDbD3kylu1qig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9129
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add CM33 node for i.MX93

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 9aad073b491e..285e80907367 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -165,6 +165,12 @@ map0 {
 		};
 	};
 
+	cm33: remoteproc-cm33 {
+		compatible = "fsl,imx93-cm33";
+		clocks = <&clk IMX93_CLK_CM33_GATE>;
+		status = "disabled";
+	};
+
 	soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.37.1

