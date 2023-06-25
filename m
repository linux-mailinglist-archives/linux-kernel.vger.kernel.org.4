Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005D273D0DF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjFYMVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjFYMVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:21:17 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2078.outbound.protection.outlook.com [40.107.241.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F46EE67;
        Sun, 25 Jun 2023 05:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFBrIniKpkDvXv1+/cpi1rLuwls4ODAp1l1IKhw+ifU34hgouT+8LRluMLedDjHkYUSw07u2qDtVBbJYCcZ+LseCuYe+kx1HsstjYNPFJyfqaIA4yygmHlNN1B9nPog0+IpQPuLmVER33retA1SDTcsou+Dkh5gxArvvlpqi1sNPBMqDLAgWZrm6g2G1zl8veM6fTmr4Zd8d0dFRPpEl5ACa7ss69XdDPaiNouVbkbJJ82PcYn7eoSmy0Tw+9RHEmnRkeNUiHOPU7HAkO8hcyBu7m8mKihck1Bq5SfVS1g3JCRsSuUWTcLl880TaJPHw6h2W4nFh5jsAt6+caEEvHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gU/NSpTIwabDUDEAGLxhSg0/sXVV9kJRatepUZ64Yws=;
 b=HfjchOndQSR0DDNzlyw0+duqJRaIUJGIWN1bDBKdAvUFHunq/4k3nOu3Pjj0vRflxwAaRuoNPFYPXV4FjOcTx3H4Ve8YA2sVIspZHaSKZTa4PRARujI8rBdBpxzdtZ3RBJsuoYDbWIE4Ry4vnKtZOsPFaEv9zC3lfdEE+7QVV+6EXNuZgpWIZLa6k616gXMvVr0vZFeLnUauQAHc7pjtehoAZtRgs4UgZRVHq+54tbDv4Mt9oK7FaZBU5Dj8CVtVBWbxXOdSfdtw5nDlji1tGUmLKofybrOoj1AOD+/yUQpKqv4o6SFa15w5gk5pSbWOQVX6MPu+38jy3eRjCXffkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gU/NSpTIwabDUDEAGLxhSg0/sXVV9kJRatepUZ64Yws=;
 b=fxy2YFMlyzxP8gYXXBmGR/0+AKOP+2ax4gb0KqmEFW5iiDjH0c1ixByBreM6S70v7CbuRZ6hRzuLr/3HfeJ4no+/DFMvcPyFg7PiA9ayiR1rqpdeiVRX/ghAgYnHFiJYHic4DvKIxr2WlPvt+nko7JUZzhLF8c9Oqpddpo6jb1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 12:21:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:21:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/4] arm64: dts: imx93: enable CM33 for 11x11 EVK
Date:   Sun, 25 Jun 2023 20:25:49 +0800
Message-Id: <20230625122549.4066027-5-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 05de3bc6-5b69-4f4d-7fe8-08db7576aa53
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v+fJJSlji+l1KBbH078/pdmBQMfuHhgtL4sUeIG8CgUfrO2h76xlVh1s5e6UgJ4z4/zMFY+QPSefXKyeQwKtOGKJ2vckOkjcNLRc/Snnrx7DSdImj3kAYtwutAqS8Ou3Y3khsbNm+9UndcFQtxx3HrqIu9I2s/ns1NxLbC/u8Gg4Ua6k8TJlk0AnwJTUFoaQXBrxLjNr3fk0BI8eU/QtYn7XV+sBhgp86JJhYnDpvV2kigyWD+oQPxwiLG7v5UBgwWGc9CNBLIVSZtlbcr9CDdKASe/zxR7WqaoZfk5Ugo0l/5PBot8DzHGHtkejYKl+LMs98h8CPvAjq4iHFg6CN7cOijvhPt5SCNnJj81SzQ1s9mYAG2dRC0v8BqqCMW2cXnu2CjkBaoKa6Cn/i0EPdjWJBpvSn13forL2kJ45yN/tWyuIkE8dFNPqoB2uAnoEeD1bc+fshpDpoaA7mkqu6hf3JAK6Qv+sEq9CjTO0vjiM8Tjtwe9c28AyTBgb5nPovR1DbiKift/nVQdmc34aDMYPae6K6XFhCvwBFgfpbUOLnp53ljSep+nS+AZ4RoG86b2bVcV6nJofwJVXF5L5vkeSECDYlBPyujNvqCbVV6C3CAFAgzaEjJbnbbWXjxXV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(6486002)(478600001)(52116002)(2616005)(83380400001)(6666004)(6506007)(6512007)(1076003)(26005)(186003)(2906002)(5660300002)(38350700002)(38100700002)(4326008)(66946007)(8936002)(8676002)(41300700001)(316002)(86362001)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MotGhWB5X0dcVknLoAlBmW2W9ULU4re/261431lm9ajyiwuoTUA3Vy/EtZ1o?=
 =?us-ascii?Q?Ix9OpoXBhg87PyrjXExDqzrPRdOMUPdZOetqjVGjROhRmfu3+sN5JBLfgqBY?=
 =?us-ascii?Q?bsvlVHPzK03Cfpf2Z4l8YrzyOr/9QXSWwx6UHjWv1HDKi1Qpp2F97vN66spE?=
 =?us-ascii?Q?7HCktZ18tIP3Cz4Hsdyji0JGAR0qzgwZPKaueQTixUkHY0QAl/83i00PU+sb?=
 =?us-ascii?Q?xJneLANB90Q+rTJ6MBPKnbLq3H2Eyi5S1Tr3yT9Uj4lgxlNLuPyQLd/zlnHe?=
 =?us-ascii?Q?aZIppbeSVbfsQ3adxbT8Y9ohcngPzJ3vA/oOFNxgMLzmBXWSZjzJcYzgdHd6?=
 =?us-ascii?Q?bXP/dsLuUbF+GbLanDf8uBjTWHK4hEMocLHAp8qe54d4R7DxJ57/sLqEPirf?=
 =?us-ascii?Q?WErnCreYPG6mQzBeVZoJU06oQWCDdbyOS6DJCihrjgp88o1Ru//kQ6VofuGm?=
 =?us-ascii?Q?2Hs4/ERUczVxc9G8PVoomS8jlS3AIUgS8jzFOrcs5OMyp9KA8Nzbn6Wq0vYL?=
 =?us-ascii?Q?cJ5kAVCmfyZFow6yIVL7e2F3A5SZaY01fDILgZB/oYswJ2qWrxFn/f0JMLBT?=
 =?us-ascii?Q?ZLGqgnobUH1cW84WWbBWi+NUh6tq/PlmrWPgImxS1FQDFuetdPbz0EMVVE8F?=
 =?us-ascii?Q?hs264cnQfxkly8moZfMRT9oTNXd7m6gLJo9jscd4PK9iufdl/+8ckYVqhuwy?=
 =?us-ascii?Q?UPTiEk7MyY5o8h9kg4zxRgxGbKTneuOmhdRyyRdkUfKwGgFQ1N6miksAdCZt?=
 =?us-ascii?Q?AAvaP24vLmvyO7lbTgZQAJRztfCR3b0Uirr0aLI2vmEEwy+19/LgulDmeziy?=
 =?us-ascii?Q?ocZRjKjFGkFZ33weq+mXRAGuTn0BmjVC01QQDJn2N9s2+qy9bipZx27PIsc5?=
 =?us-ascii?Q?cL5LjFggVGSsMN8NNMhyU6JOTP1xwhWQZnBCRmkICPViTL2rhf05PXOA49XN?=
 =?us-ascii?Q?e/VVSXz+FgH5b43OJ8wtExQfEkiChfb7p4noddUmrw05ViP7zWN/Jp78YCVz?=
 =?us-ascii?Q?sZDfasv6DRVsinp4S9FV/cygh5idjK6hovoHK7vQVPH34yl92t/kobz03PdP?=
 =?us-ascii?Q?O0qRLlCgQDNf2TdPlZZuW/JxDQxsngz9cxDyMvZCyhsZsx8Igk1w2Tb5kzK8?=
 =?us-ascii?Q?HR7UjoXaAQpHhnTRVQlh0/VqB1J68ZghE38RZmZU7HfimaTVSZrXJ14chO9x?=
 =?us-ascii?Q?khp7ogx9C/M15pu4WAYdV2UyYqI2dv/CfrAvneedKIoWG5Bb8mYvacI0HSbp?=
 =?us-ascii?Q?8ijFfzQlORwhnSX3cCO/VVuDyhd3nBRxgpH7rdYNWnzZMBl9zOwHSHN6pmsb?=
 =?us-ascii?Q?bOKrZdzxJhq2hw3clww9e9U/h7h3RdGpIgoebbkYfCQVzT4CPbWpWWchTNUW?=
 =?us-ascii?Q?AanHhdJojUl/YpeU3Qw1KSDhAlqXO1cWkBO+lkF5T+aIyMEdpACsr4/qFTGD?=
 =?us-ascii?Q?sf3QHAC9VdlGCtHRinQjrtHgaR+1nsmxYg5leroMoAxRaq+nYH4GdF7PJ5oE?=
 =?us-ascii?Q?r2zE5e4QIv4Irfia17D+jpodEmvWsXoK/nNNNnA8NX4DnLojFtcrGK+XgGye?=
 =?us-ascii?Q?unmjsI0X5GHYhoEI5cgcVp7F9QT2dGa1vwfYPQGt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05de3bc6-5b69-4f4d-7fe8-08db7576aa53
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:21:12.8882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKvcI5QakcSiDB+u5D9aXnbWppdnoZ7Miq1lH625+x/d/GUq3W3eomUEVREXPDLUfZs7qa7IRGVNwzY3E4d/QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add reserved memory node for rpmsg
Enable CM33 node with mailbox property included for doorbell.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 359ae86f4e7e..cafd39130eb8 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -27,6 +27,38 @@ linux,cma {
 			size = <0 0x10000000>;
 			linux,cma-default;
 		};
+
+		vdev0vring0: vdev0vring0@a4000000 {
+			reg = <0 0xa4000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@a4008000 {
+			reg = <0 0xa4008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: vdev1vring0@a4000000 {
+			reg = <0 0xa4010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: vdev1vring1@a4018000 {
+			reg = <0 0xa4018000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table: rsc-table@2021f000 {
+			reg = <0 0x2021f000 0 0x1000>;
+			no-map;
+		};
+
+		vdevbuffer: vdevbuffer@a4020000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa4020000 0 0x100000>;
+			no-map;
+		};
+
 	};
 
 	reg_vref_1v8: regulator-adc-vref {
@@ -53,6 +85,16 @@ &adc1 {
 	status = "okay";
 };
 
+&cm33 {
+	mbox-names = "tx", "rx", "rxdb";
+	mboxes = <&mu1 0 1>,
+		 <&mu1 1 1>,
+		 <&mu1 3 1>;
+	memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+			<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
+	status = "okay";
+};
+
 &mu1 {
 	status = "okay";
 };
-- 
2.37.1

