Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F15625EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbiKKPsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbiKKPsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:48:09 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A63532EC;
        Fri, 11 Nov 2022 07:48:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUSHwrlpUgHKU9+7M5RvCPwCQ7e5U0mDrcM5K57WkzhtQ7KRf3z4UZaZEOEBzYq3ZQjQ0AezY8b9FBrKjhGFw+e2yj5bBoa1vhduCPVnBKqzGBSehPjY68YQw9sMEutQV2aANP7sS+WuNjU0neiEY8v4mhB4UaBv1/Zb9l7M6lojRlI4xvInokGFNZ/EYacrNIEWnVnaoaZi7rdH+6aq3kv+MRLIBXCgZtzevmUWmYfw5n4TZslobrESNiY6mmaDHl9pmQ0We580Nkiy4yzd9nMktXVQwCcyr0OxJetG5HBNZVVD1gxS/tc3OgEElpjnF5+0rTLMSv1i/f0cKkOaBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZL4ovDrWWW6SUsEiZtDvoxaxcwxeayCjk3s2XKEWA4=;
 b=XiUzqDpZ5mHgSk5ksZ8Fq4J6RCJVNCKzSEhKuXTD6zrA0bSkPHxNriydwTy6wzrMa93R/i5B5J6ZQUXbZ3e0iKeF1xNzXJGQjrE/Wx7H1MLvVdxF5acgHlpywF9TKvqZWe8RAXROXDKujavFuIh9ZRUgP3HyaFUoUvfsx1SOoXZU/V439OCQnjkpNwcjCOeIrujYZIupgCevGAVoyujkqJIHXdd/uTEsMNP4pbzdc9+9+xdT/12c1eJC/g7Hfu0BxZ5Q7BEDuJSNgvUC+KMtgjNX4Tijv2W2VEToqJmy+t4CrYzc5VIRRJhVCK7vDr3cFurqtOYI+uSn+Y8ay5h/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZL4ovDrWWW6SUsEiZtDvoxaxcwxeayCjk3s2XKEWA4=;
 b=SqlE77l1busKv4y5pp6x+y8OWL43VZfNZXTVv4mYk1Yppxsx174aac2AXkUTBK+4kRc2f6N7OvHL+7zq9zJSzzDrXJsoreYAtvAbWjEkJ+eZt9YkfOXUfMtUUuzuuXvLW2+9y0T2wKGKJWvEmnYxrseZnngm/deIN1CU/a8XYtY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DB8PR04MB6969.eurprd04.prod.outlook.com (2603:10a6:10:11b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 11 Nov
 2022 15:48:05 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%12]) with mapi id 15.20.5813.013; Fri, 11 Nov
 2022 15:48:05 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     shawnguo@kernel.org
Cc:     Frank.Li@nxp.com, aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        festevam@gmail.com, han.xu@nxp.com, imx@lists.linux.dev,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shenwei.wang@nxp.com
Subject: [PATCH v2 0/6] add adc0 flexspi lpspi to 8dxl evk board dts
Date:   Fri, 11 Nov 2022 10:47:36 -0500
Message-Id: <20221111154742.2753318-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DB8PR04MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa7a24e-bfef-48be-9e84-08dac3fc1e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zViDb1E2Ytu2oEEhygcIEqd/nHQRoieCN27KFQ9vTy7jGq32EdKa7GazYzb9eMdZjooAWk+xGkEfT7UprerneJpG8Fy6WNtVVc6M/v1nb74LX2zibYYaZDh7Ffy4HvquvLLcuar6zVPYcpj4xQkuhZCjN6AUcYbC3HAW/61EiO8RdTbNSGLSsIYu53uVrrMS0mNJNGi0VgY97FeDsaM202QcOwynqBs2lESc3sfy7ximxnCBOOaFU919NG36L9gfrBJ8Et0Uk38kmi/cTQ2YgMp3hTx6PUmuoGkNTeypEh+Ad/yFoAXKH0Ps3sh6wkvJjrtbsGSM7kWk69qMj1lCHqVp0sYAMuxAstxkLZxSHmrwWS9CJm/pd5n6drAPSlnThB9r1Zqs4AtJxqu6n9Dy325Ljucgn+KF2A16R3hdk4OxvVjZNlE4hoP2mKYeLaK6H4qPYBH0loBe4mfAERv0ucpwZxpYjL+z8bXzf8ERXNDR7tv662zUVQQgq8C8NG+2nLKIJ2yG7CUGSIGkgsP3kNIX6dnHpJaZZZKG8tNCZA3IuPhLkP59BFXNPJd5De4KQVHFA7QtKU4iD4BYocBber9RJHXYlMS07mzAR+Rjpr9D1ODQdJ8eneTlbMKmifmmRwQC3JBbIw1xD35r/6GJK5cHM7It8HyYf28FEhmYCNk1I49GuhM6if4EiqTWyxZAAoSvfmICiEmf4Jj2/l0bhfq/0ihrNYuW6pbN7v5xb2JONAzj8WkfXhZlumN0pf3Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(86362001)(66476007)(83380400001)(38350700002)(38100700002)(478600001)(6506007)(8936002)(41300700001)(6486002)(8676002)(7416002)(4326008)(66946007)(66556008)(186003)(2616005)(316002)(26005)(1076003)(6512007)(2906002)(4744005)(6666004)(6916009)(5660300002)(52116002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RjHzCWIEkNmDx1WLk8SnQx7P0hSgk1wJv5YXRM+bYHfG2GeW75R2v0TDbf+u?=
 =?us-ascii?Q?qlXtnAp5A9vDBKaZ68ibCYKRo07Cre77LRN9HNQ83F8gBseOcyM2b+Hx1yKm?=
 =?us-ascii?Q?envXXHEIHU0wTUnGb1HbHFHZ27GFKZqm4hkxplOAnP0gs/nsmLSGATYxLw9C?=
 =?us-ascii?Q?t4DA8qmucFNOJcI4R200eXOe0MQPx/UjrefKCdN9y9hMGksvyLz9qLYMgBga?=
 =?us-ascii?Q?nUECbc+4WJ5rg8ZtYYdfkcMbfAAJFFBDgWF3DS9gr//uqN6sHoQtnG9GOnhb?=
 =?us-ascii?Q?BNrcfgLmg1InKVCdxle76E7SfelF3xNmHZ/PAdUPk3R0cW5YOCtxUiSN6LLq?=
 =?us-ascii?Q?BoeZ4GWRdGcOfWT8+uM0JZdcLBhn3iCJdoWNKcTaX8rwIfe4E+CyQi/SIhkO?=
 =?us-ascii?Q?8VAfax9+H0i2qj2WkDHMGHGbuFOYzulAI3J6saikwhssHRDO4Ke+VLgPkRdN?=
 =?us-ascii?Q?lLNeuPCnyvy4xkpllEw2OIVmxtOBHVpsytdYRYE+dih2VPiQxZTZp4rrCLzT?=
 =?us-ascii?Q?8zDHoz/Wi5+nJobAXNGVkLzS1pXdKjAdKQWsJWoAYFRFz3b8EObSUPkV2AJY?=
 =?us-ascii?Q?M9E7Qs67+/1Ksms4d+Sm865ZYvsz1ij+hqA3kbm3RrX3PKZfhuu50ceY7l/y?=
 =?us-ascii?Q?xJ9ZfElg9YrY0P9+q47aC8WxgPAaq6jESGObz912a2W7/Ij+i9rvwJTfoKTX?=
 =?us-ascii?Q?Vti+8AjMmO86Ikb5Q3aBAj8x1cWy7I84hrcJgvjRiRkKfb8t1PMVjK1cAAsZ?=
 =?us-ascii?Q?/0MBdK+1BnDCOiDZ5zI+DJYMzKTaH8btCsaoOiFmiOcNTdJyVj7PshtAS2Gb?=
 =?us-ascii?Q?sotwhEYtXpP4G9b4oC8CY2FuREsLdMyoN5Gx1TIoBZGUAT9oniXkuV4lNHO3?=
 =?us-ascii?Q?Nno7hdwxcH98Wli+SM05xB77LMJlFtQwPotZR305G4RSi4OaMz51qI9z2qKy?=
 =?us-ascii?Q?LnnhCfHS6FdYJywGyYWPr8LHZg9bFjzKDhv9b1j8c7zEgBoFfc6lXr+87Tij?=
 =?us-ascii?Q?kGBtDsvaGSztw21htWnyRkopQC6PQM8x/G91A06BIHg8tYxBZuH+JG4b9vCq?=
 =?us-ascii?Q?ENJfrS4CiId9yZDWazU9eBOdAw+1PbHoKkcAaWM1Mo8BLYNsl+FHWVqxOtgK?=
 =?us-ascii?Q?LA7QjORD3oEkBSvEvNrvW65ulrclY/tEkxhWJL2wUU4PBtn8F+RbLzhDkX2n?=
 =?us-ascii?Q?5FYsSikpPYGmt6AolkYmn+2lAwGqj6AigvF22TW/JVFIYABvRBnvLlrJeT0d?=
 =?us-ascii?Q?1or3H6QN1gj/960KDBt1x+BB8IdLMadclUXU20VX5OrFrPX9FHc93yDsyPi0?=
 =?us-ascii?Q?JVdpT0bDBvvadJEoIXqbmL1IYGPiR+4GIYS1VyFqgAvEHJ/VosTTqcPhPfLM?=
 =?us-ascii?Q?69p7pQCueWxHm2ktDhrKi1R43tGyl6LwMYDMeaiIvGFtrYvuLS3rTr3Hg/Cm?=
 =?us-ascii?Q?9UYbMDCGbaC49uCXdKD9rSNxo8tHyF4F82oofoNPHrPjlsnPpMXcGiYa78RS?=
 =?us-ascii?Q?z1xtkVFLVVjd7mSgdlOpx2pARXg+M/VBI86cYoAhTelW7Y9XlS1RDoJm9BjH?=
 =?us-ascii?Q?u0oPHhbXhRoiDF7CnLI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa7a24e-bfef-48be-9e84-08dac3fc1e61
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 15:48:05.6796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTi3MtAvHKbT4FJwFc6HlAPOd3ekljjf7Jy+0tt+0PODAc3KJTGbGxIg/mzTPgSpfOxPxYK5fYh88TtCG5X+cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6969
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add adc0 flexspi lpspi and adc to 8dxl evk board dts

Change from v1 to v2:
	split SOC and board change to two patches.

Frank Li (6):
  arm64: dts: imx8dxl: add adc0 support
  arm64: dts: imx8dxl_evk: add adc0 support
  arm64: dts: imx8dxl: add flexspi0 support
  arm64: dts: imx8dxl_evk: add flexspi0 support
  arm64: dts: imx8dxl: add lpspi support
  arm64: dts: imx8dxl_evk: add lpspi0 support

 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 164 ++++++++++++++++++
 .../boot/dts/freescale/imx8-ss-lsio.dtsi      |  17 +-
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |  63 +++++++
 .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   |  20 +++
 .../boot/dts/freescale/imx8dxl-ss-lsio.dtsi   |   5 +
 5 files changed, 268 insertions(+), 1 deletion(-)

-- 
2.34.1

