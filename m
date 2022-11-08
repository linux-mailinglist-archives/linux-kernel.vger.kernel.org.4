Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B219620695
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiKHCSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiKHCRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:17:47 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70078.outbound.protection.outlook.com [40.107.7.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD2E2E6B1;
        Mon,  7 Nov 2022 18:17:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvrAjuzvFsu+ko798S1pKM8yre0VeNF6kICUUhAd7cUFRmBVhzW5Chi78QKrY56FJ2S3T8zDwVEj9RmiMDIwDYFmej5LUjY0Wl3+E0DPWri4yeNIyvUSoBUKIg2oEyxQnWrjOs02ym3KzRKNaIX2FuI5o2Oyc2ZMA8UFDXz5KwHP1wIQUw9LseG7Rtu8FrfAaqNZggh8oDhp8hJf236z5ihKe5OUjKCZQgYfvTQYvMvX4x4W6jT2lvNTJnc1zmxu5n5Ibgu22PyRy4NApdCAv6zlL+LXHbVukaPOFc/fDI4AW19peXVR1BvSYN6uB8iUU6Lzu5nEC0ck/2E726+31w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvUAb3mcK96FP9e73bKTht9uQvkXPfy6sAzCX5waNMc=;
 b=j/ru1zC71tVPKdJiBRAtGWAVZo0yRAXxpC+UhPg5CAZx1D+sZbbdvzLZOSxpnCCNFf1PoRU6NpaBONAUgFVc/EGFqVSLLM8kv6wfNGt7qFmFhi68Z7Ejs1ZSWhOFm2qK2xW7q4s9hcj2Di+nZfdNUFftABPjgi8z0OMxsH7T/J2oUnF2lJD7kGD4txWM1zLRUF9URRG4+bCukF4SYwYhYiOCxYDpKs1oKb79vmJkZDOs/y7aVmBC5Fz1unR3gbKDqIU8i8iOoQq4VKogt9BZN7GZsShGKhxQjEwDsSOhkDki4ronxsj81TZQsVSMkk2tm3ug1eHH3fC4yop+YBEOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvUAb3mcK96FP9e73bKTht9uQvkXPfy6sAzCX5waNMc=;
 b=imi2+dKlUlM5Wn2PUf9jugr9aZOFzu+wzOz3xpShvfMw+WGDEknxHqb6QKZK6m4yQBngfbvQzqd0EURaQj+lhmyL7BlUDJ0OVsrwn9ML//auJupersOesUQRhG/saV9uxpywDcPiM8qtFD1nvjKBNSMkBnN+5A2ivquxZ1tqMZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 02:17:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 02:17:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 08/14] arm64: dts: imx8mn-evk: set off-on-delay-us in regulator
Date:   Tue,  8 Nov 2022 10:18:14 +0800
Message-Id: <20221108021820.1854971-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
References: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0fa6b5-012c-4f08-707d-08dac12f69aa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OLpteAdKEhLCPkQzJOuYujCjy5FVnNEfoaAGlFqMwu3GpgtXaX/pgNg8DYzKzZkflcfE84sLl9azyW5ObqDiHLjWEldDo5nBDsBM9dLTig0wHQxmsjz9tNLM6LdrKpCDfR+CoJwGtOEcoH6KeEY1CG7X3MfKK0HQVkeBoP/s2C9mmdkLgW/K94b1o0ZtHMe645lUbtVRDc6mQW5snJB4SDTKYmXKpySn4zKyTS19dKnHH0fLfDLVRoT1L18RwvatPWaQbWkKAfG4vrIhqoUgTsQsXzRw2pvJKXUtvNIjVsjid3/Mas7uEQJBfEW4l57cLgpJZK14uo5N1t0sptmNU6U7wwVO/PkTiOt39GSr/3uwTkZLBykv2uK3mw+U8s5YjvTRkcODSeHrlE+ZcNj54rpHlaA7djwWB0nEDVyb/DH67zs927ljYYYtYDY5q2hlMc9UFzCttMA2uggFSc0XhZ7Xq3qt3XiiqH3UONKnbV322WoCYMNueuNpRVc/NEEIn2noAh+mWknuYJe+yCUwGD0bJukRyCKjSttaUurn4NHfu8KFI4JvroLwSPNMA41azH15J8DcB4w0EePDEzYP/7ZudzlzK3mxGW9fodh4BWl1nHrw0xMEkuxXBojmJ7YgO015pbHAzKx6ookVZAUoi1Z0WdN6sgC4OMb4eS5iKFdgpvfjxZOL+DPGp9HvI41X0THXiniaXqLOCw57eJs76i0ydHx4yYbXILmGKAxleolfKA/iXCnmHfjJsu/nNHKUScFDzAiebW2C9GNpyLwusEvM1UwUFe43zutU9+yuMww=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(1076003)(5660300002)(8936002)(41300700001)(6486002)(2906002)(86362001)(478600001)(316002)(8676002)(4326008)(66556008)(66946007)(26005)(186003)(83380400001)(52116002)(2616005)(6512007)(38350700002)(66476007)(6666004)(38100700002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ILat6eZDg3HlEEBJFIJ+Fg3mlA6+utm/WOnD218wxPZQ1BP/muSgx831EnrE?=
 =?us-ascii?Q?zRFLREtL6+6k4kUnVYoxnRrh2XohDGDkSEB9q7vFdIyF4qCzuzFWPhYZolL6?=
 =?us-ascii?Q?H0JofpWH+jLedI1uEMnGYuTGnP2in+/+RIZIrU4fRx8UJ0xQpQgJvLpzsCGD?=
 =?us-ascii?Q?KdLhc3oWtHujERwE+2RM+UWLtyEkZukrVZKaXg4L69dBjoAPN5HlqYlFMf33?=
 =?us-ascii?Q?x+9qim3eP0/ua2WQe9luF8OLsUxveJzFc2Daq69BEzr4qHJMn3kPN3nW11Vi?=
 =?us-ascii?Q?RHe2Q6+cyYGx6yQpvZBzN/m6yyK3kqQuSVhTunWtqbAGwb3iYAGVy9QmUddh?=
 =?us-ascii?Q?y/jtnfmTM/rfCD2KHdARTpiCOl5WIqI0xQlfcRB4Zp23SA8CK8DOg9nTrbnd?=
 =?us-ascii?Q?T0BzMP7yZ+itY2N1AhD51jpbAJFDI+3dgrXGJzl9POfpFPzAK6VWxjF1KX0t?=
 =?us-ascii?Q?SUMdtJSEwzb13/9f+qZEJJpX0is3n21pzZHHCkNZesgfewUerwq4rVho2hVb?=
 =?us-ascii?Q?y/qvzHOW3ophIrflPvpU/YgZLpp0v51za+XiQwhJIVNt5PLIigWoJO5jC/N6?=
 =?us-ascii?Q?bGx2sGJNPCcpKdq9w7JgdCe++c/8K3uViNHDholt2sX5nl2iDxvMa9EWm1kk?=
 =?us-ascii?Q?DuqRt84qrhbJlWCA/5oNhWbKbr8uA5B7+vrSfYlYCeKMRyAB2NI7UiDHk4mM?=
 =?us-ascii?Q?5FrVEut/KT9Q6dsd58gQBUX6lFcuPxMHCyX7k8vF+NvsAAuJCEwBuxTEgXzY?=
 =?us-ascii?Q?72IvHgUIC6+OlQ6FmL2hfbMej2gluOH16LUARKFXyfhexY98rLh0seeSS9+d?=
 =?us-ascii?Q?QDAb1JC0bcmcglmVQdDGEyuExCFiEJRcfF+Lrpo8xSEBT29RZho2FV2BUsgv?=
 =?us-ascii?Q?IcqbL2YshK3bAUmNuh25VrOgx2p/0HjHhd48NHEQxOqs/WAgNNStfuQEH0Wx?=
 =?us-ascii?Q?i/Hb06xiV8ICB+ktcFpF5TM20P45C2XucaoyATQBWdCQ47FDjo9+ws8jbJIE?=
 =?us-ascii?Q?XUDLq72FVpObqnhrW71OxIGP5lRutNzOGnQx6JWnGckonqp/MsGn68QqQbo5?=
 =?us-ascii?Q?0Bve8Ibm4HxLYGncsv2+bUXgIICQ0RTBKQO39ZuAjYLZtiNKTCFcFW67vc9V?=
 =?us-ascii?Q?AUclJfLKc8PSfXap7INRYRwvb30DotWW/FGfQKpF0V7Qj+NAxRL55pG9zhSF?=
 =?us-ascii?Q?TaG4SOmSrWLSTYOEI79ZqBcrKHsGx743ohLliSKacapmeba73bqYmEVCtqpV?=
 =?us-ascii?Q?GOOsvt0c5BOv9rHfUdmUrBBIV3rzKBVXjqXL0GggKLTB8XIm+UGmLxG5yzlR?=
 =?us-ascii?Q?QSEBbjQC+vLSqtDsQj+8SVS+OWQFsPu+nFTVYQrlIOv52CM/nv9WGeHu015N?=
 =?us-ascii?Q?yqAKfWbJNwW7Yruv16dXrQ73rqeWiIZK1ZG/XsyfqVQhKtiXz10nqtfy8sJ8?=
 =?us-ascii?Q?k27tV0DrigTCPkTGMwphkSu7h5uXw9So7ZNP+4XoJRZzJzckZk4jn3ILqpyL?=
 =?us-ascii?Q?BwavtzgRel+lolBpv/uuvDwR92RmMFphbj1dKr/e6bys17uF1/DFoozbxddY?=
 =?us-ascii?Q?M20JQArbXPBL/5e1gDxP5ySsuQit3B20q3rVA0bs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0fa6b5-012c-4f08-707d-08dac12f69aa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:17:40.9728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVT+m85iVbSZXwffFbzKgujI83/NRFmQricthOWnUtF0GVUBLcBFtdanmCwvKrMCOazAtg6lT1BPLxQd7Ewhnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Some SD Card controller and power circuitry has increased capacitance,
so the usual toggling of regulator to power the card off and on
is insufficient.

According to SD spec, for sd card power reset operation, the sd card
supply voltage needs to be lower than 0.5v and keep over 1ms, otherwise,
next time power back the sd card supply voltage to 3.3v, sd card can't
support SD3.0 mode again.

This patch add the off-on-delay-us, make sure the sd power reset behavior
is align with the specification. Without this patch, when do quick system
suspend/resume test, some sd card can't work at SD3.0 mode after system
resume back.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 261c36540079..2b4395854283 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -36,6 +36,7 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <12000>;
 		enable-active-high;
 	};
 
-- 
2.37.1

