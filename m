Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B666251AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiKKD2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiKKD2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:28:13 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7A45D689
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:27:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zi6rdLoz4xxx5SnZF6ZAHsbZT7sw9JrhOdyyzPgdvYWwlJEH8S9natv1wJY5BcM1vG/p/pFzn55fNJdN0segXom2C3we380bm/f422P0oXaSBttvKLPWl7AKcECAEXfeMWBflHMMIxBEsB+ZbpYaN0TMy78fuSUZOJbKcmkExV1khnQ8q2zD3lfSafxKA+yz1iyzV5Fq4VGgNIGCszgnwGegznYdcEXXpScvPbuW/WCF4NtrQiDhtSlXBOcD4iGwzJlKvQoUF6rEVoqGa3QHPXvBFcczR4sYQ9RqH6l3OstnCDTQeMf8q/+dqV6RR/fjI0ZtmyqMpdLl9AukhttbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooICO2bcvN8ZxEm3I+1oCqyVOu3YHmUmgXvKVeCCiTk=;
 b=G0MqQL3EvMaBfBit1AhmPmetyCwBagYYC6FpfB2eoBnAFGqOvZ9u6tmzIipF3byw8zpZVejZJ7IEQpHzcEfL+lY6QywiZCxX38TiRDDC2iWonqTILxNBQWhasMpgm5F7dAYMhZTA4HpLB8TlqjiX9meO/H1+KeP+ejiTFfJxlbJzXr005skHf3kZ1Nfv/6Xb2mxpGEfKqK5DDkOIqLy5Jj7jT1bBeFAEn8bVXQIseooE1zVvMtNHQGhWTw+1C0dTIbvquWqRmHkALx6QEdA7yb5Ws+gGe4HVNfPi8RpRBTj+omNv9T+q2hAFzHhjwZ43j9dpgTh8lj/5GP58QNoo6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooICO2bcvN8ZxEm3I+1oCqyVOu3YHmUmgXvKVeCCiTk=;
 b=C5gExE9LsnlcJdFnl1rRCrjHBiQeG/7Jvq4JsS+Al4GMlgD9MTj/ndWW2s0+cCvEnc4uhJ6TKvUgmsXy52nqVkYS7pQG6h5MdvjrUHZXgxXtv8ZQ/iSD/eBNXck7xNzfOVIr6TSi2JSDivE1lmuiwENXQgov3DJXFw7ThhRh4c8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 03:27:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 03:27:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V4 06/14] arm64: dts: imx8mp-evk: enable I2C2 node
Date:   Fri, 11 Nov 2022 11:28:03 +0800
Message-Id: <20221111032811.2456916-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
References: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdf6226-0907-4673-1f71-08dac3949ad5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E0Ep2k/sUlNlrVfbrD04aYR6arqKMNC6xzAH/lIa6uPdpzlKPvFkfYXwTRsfvFo5JZ7ob8Hxxx38+RxyXDsO4ffbfCn/WKtNaDbg0z7cdaLlfGRFIPRXNSB6s73GURaXHEtvw+VglkGzdDsyx8Y/EhsbiN3u2o2k0JZ/a10U/se1tQ1xZKZ3aqOA8zufA6SVaowAoQNCMwiYB0asad9L5FvLHUc36W+Ra+lOQOuC+WFNm/fq0VqeHbvtuuUuFB9KukhnfEiFv2uLXlH3SG7t64FU/aetSdXXg3dxHPCi7N1fgjHRtOF+3qNUSr0BiWXOXhRqu8iG7fGDGz4Yuu/rfdvWr/I1KZ3XO9tr1/f1IO6BW7FlDIyvxblXIMlFRuoYuLue4r3R++VmCKIFFNfvX/vqBlZTfoTBF23vNanciYNc5tra/35eBmZ6KgxaMFJCkA93ENP3wRnlP3jlSH0rGRST7/SYORC+97uUfZRTbHhvU3tBg+tj/aiVxJRofG97WBR2vJIGqFe7oRRUUO8T7jYDiwhFxtXC7dDbJeRuFyQI7set03ruBUaqvfOGZ8DRV0K6xXnw+oYoKRnJxLPrmUeWTM3nTyxXaneJbgD0UzhJHbRCT7YklqJMsuHZYMY+N3uXtiZ+AmBCo9EebhfbTkcYakMJe5XRZ2jERfZwof8IEU7J3MVWGiGQo0J9H9oYytT9HfBgJm1pVxH5xhwqKksprFjPNFIM5xo2nrjxDuk7b7lNLzJpZcRlmeS16DbeJM5B8Pomn1i3jCHh/SOaB7HllbkI9nIq1vf/poRAQho=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(6486002)(83380400001)(8936002)(478600001)(41300700001)(5660300002)(1076003)(186003)(316002)(6506007)(4326008)(38100700002)(38350700002)(6512007)(26005)(86362001)(2616005)(8676002)(2906002)(66556008)(66946007)(66476007)(54906003)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bsWjv8C/5gDleMlyKnV81CwSunVOBsvHIGkrxC0nI1XbOHkCqy8OTTCqNd9q?=
 =?us-ascii?Q?iJYZKMqcFhEurbJ2p4klFhV87rkyjJo34a2UrzDXqJMBisryVDC1cQqyhDNV?=
 =?us-ascii?Q?1zqcbOPlXoOszk5JWF0D8mnk/Ciwp2ttq6AcE6OMpAtw6mzKThx9T4P452R5?=
 =?us-ascii?Q?gNPb/2SykW2Z0ySWd6surn3ig+RHti47ajqV8MBRgnPM1W5K5JRwAp4c1oK7?=
 =?us-ascii?Q?qLIXTjx0NJHjTjIy2SiAZEizvr357JlA+QvbFYhYwxDwhQTb6ryo+MfehamH?=
 =?us-ascii?Q?/3FsZLA97zGdi/omxwVMDYvFgTjcP6RzJc00ZdjcqKoONP0VzcXDYsobdN8P?=
 =?us-ascii?Q?CUiCHr3PIr2s85gtiGthEENaTajnqBPTeYDSx0PeEIPO7WYIyvHZ9BlbAkx8?=
 =?us-ascii?Q?zCJ1e/iPEgJAsA/qxD0lIJtOps/crmx1pdUiYsRnHisfgyQwSMJ4a9aXG+N9?=
 =?us-ascii?Q?XbZAQJUZQeAZHGxtPPpOD9kyzxZuygcov6OojMOKHTxRPDwMReUz91iNh+HH?=
 =?us-ascii?Q?nURMB6p0t4S27M4nBYHqruxqf+ner5WRg63utrJ6Icd7VsQ76HDDlZ8Xt2sO?=
 =?us-ascii?Q?7q3QHWhnNXOAgat04IOhy7jyhE3rRa9GvdOfSLKv9LxLX/LqHq0t4dExoCv1?=
 =?us-ascii?Q?ekRa4DigZ2T3dSPo7frzvYq4EfeC9cQk1xq072n+FPp4+AeJai/hD4gyhPVD?=
 =?us-ascii?Q?ZysFae+m/gWFi7eiMv7FbnBH0htIvMJq9tNgiA3eaTA7MXpXuJcZS0AHf0CI?=
 =?us-ascii?Q?4fhWsB4/3rq2osJk1zx7HKh/cymYe+VzYEZeoVltvmZByALrsbcXxod3GMCc?=
 =?us-ascii?Q?ucFNiUOu6iAXkEseN+xWxpbwkOHO0lMVN5XvtJtEK0rWZsLLG11tIP0MWJEr?=
 =?us-ascii?Q?vbwjSHIOq3HQIITaaoVakS+DeoOCkY5Rv7scd80lxW0aiqofwzD63JJGPdAl?=
 =?us-ascii?Q?g8EGPc/eOyWYj5Y4zhxHmCsxFHOC7PlccnTWlsa37Q7MOGlcNIitXJKE9DDw?=
 =?us-ascii?Q?7B3M4xfylkwvPHjkNeKzgbkkUIMgoDdCsE8i3Havf/Hc/ZCjEWDvD+RKnPbg?=
 =?us-ascii?Q?sZahN1sMx3d3xy+0chm3QdHS1c6bGR90PSKMrOG9M7vAV0GXvBAu7q9vFNaw?=
 =?us-ascii?Q?EjTCtJ7PA7K9Ux4Hob3S1BaC5lUGLE1YMNioR5yhw/wQllH/IEmJhXX9EyVs?=
 =?us-ascii?Q?l8L12zHtASFpD8FniDuq/V/raHt/QNudo0HJulKIwskTW14pMqe9mDFnLiKH?=
 =?us-ascii?Q?xrVtSSqX9apof+fNE09+wdFeCs7qFxM0X60RtHwqjWTMoDsOHV8DpmMZ7U/m?=
 =?us-ascii?Q?njBNfbsCs3eh1ZYNA8wMgWY7S/EeUWtXm50ZiBmTdYXgIVf2KpVwUZAVd+Wd?=
 =?us-ascii?Q?jIYjpCHJ3UR1CodAIj3I1g/fvw/2+BFLX6wY9P6TmxMCKAkxGt9YdniTO3NZ?=
 =?us-ascii?Q?xpsUur+z9y4TlqD6pMQvc81JQ21PESDazwY/C5psqtCaXsUPLiYeCqHkwjdg?=
 =?us-ascii?Q?JJsw33SJSNmINAi98bW8ZRvidU1nEfcXZEJObYcvxUd6y+KdAW+Q4jHbSRHW?=
 =?us-ascii?Q?l5LtlY6SbPzYoLqbQoSW7WOqVm3O9OBXGpvhx6rP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdf6226-0907-4673-1f71-08dac3949ad5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 03:27:04.9861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmkBB59RlTGDKU+cPNaC5ZzJa9FtCk9J5P+JUIcL5vCQByPQXszhEPHTz/VUvIyBlS82hZkeUVVpojLXx2qUAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable I2C node for i.MX8MP-EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 4164f69a89a6..878d4a752090 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -331,6 +331,13 @@ LDO5 {
 	};
 };
 
+&i2c2 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+};
+
 &i2c3 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -589,6 +596,13 @@ MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c2
 		>;
 	};
 
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c2
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c2
+		>;
+	};
+
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c2
-- 
2.37.1

