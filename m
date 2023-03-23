Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F466C5D92
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCWDvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjCWDup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:50:45 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2077.outbound.protection.outlook.com [40.107.247.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C162ED60;
        Wed, 22 Mar 2023 20:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNntpc1hA1+FlWvBiLEhCFhpczRuN3cwm8wZcPTcuz28EQPtTyqsyDfc/UxgaZ7miJ3ymb1IdHrBU2EuIw+bpm+LlHifXRpJPVrs9GPxTOdH3HH0Y78ZxpgVhRWgSvFsnsNdBHlx9Wf8ZHesNLYqC+wkk8AniCS1MKgLdP+YXXtvC8VkHQX/uEISNBjHiCheh9tFKdndQqZp7asUfl5L5XupIboPygNmOKjXgvxXw3w3XT29zblDDq9iHaZFKkC8NYLifAczP/KsxWiDYh2aeQQ/umb8xg4US0FZcfBVtkMrGckCz2eqMIw2Soki7wzLljJniwXMw68QBzMCvup2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIvUSWh+aIjw6Ss4/sPQHKtp+iFiSUGJyZ95LnlFkRM=;
 b=ciZMhkWaVl+zkO/XIM5C6wiFifSKcne5mmKR1xbJHOMr8uRXRmiZuBZQnhbfrd4rEmohO0lwP4We/iIf8mHFQofEbOYrALJoz5IpQkEO+z7vu1S6J5L2nUMV3z6zztlucKFbn7by6S32OfzpW6IbGodSflYljbOU+f6AB5dt90fmiMu91y5Isr6sHves6ztJkiVcUu/nEX5cILOEiXXKUIfrZda7CiQhmMC+nJm2mpYLx8dP+laJxo2tPffdbl8o/9cQdQQROqWStTOBxS5Qd8BMTk3kcQgaAy6tdQcJTZ3YdB5lOf0gKjObwDEVIssbXPnrTh/KOgSvsUqhxrnJCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIvUSWh+aIjw6Ss4/sPQHKtp+iFiSUGJyZ95LnlFkRM=;
 b=VYeyJqmQyYNBjDUat8DYU3gZHPSTUBO8m8iJFg/VMP5LA9PQKTigOO7jchXUdlFznNhqev9Pkh8mPrs7ROwfv9JpFgylImD2yOprDGrMt6r5cILRnLlFUqY0ljn7aXzUiBqCTNYgqmSCfQNxXLvMdFnKwZbuME7NF96dmzlw7iw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8099.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 03:50:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 03:50:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH linux-next V3 2/2] arm64: dts: imx8mq: drop usb3-resume-missing-cas from usb
Date:   Thu, 23 Mar 2023 11:55:31 +0800
Message-Id: <20230323035531.3808192-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230323035531.3808192-1-peng.fan@oss.nxp.com>
References: <20230323035531.3808192-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: a0092f41-5389-4f11-6cb6-08db2b51c1d9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yg//M4drsXSTZhe1qg7JpXf2YmhZ0jT+qexvA2LldC4Okvy+uWIZz+h8DSpuxYRleRddOLmyACiu8LPo2CRV/L3hlocugs9iRndN896tDO1wK/DWKGlGq+xqzK0MdGGlnjWRJNDrPPvt3a5e6rrF1iUBvsiOaJC6Uk82FmdiQfKsZY3Kr6rSd2M4KXXimqEGrRZVkmc1/LX7xexCf2lMVx9SZQ0DJbtEHRf3CnyB5MrUabdbaP2s8HQNHqy3mtv5Dl2RQA4rNa+nYR2A4uvTOhie4Dsc7pTtXTdmdziO8g7aC4ventKALidhNnO5fUKj2HgbWOo1tOMNpwvFLOLAo3DqUr7nf96MILTpQIcsouc64Z+Q6afRcp+ZDDnPL7pQx8cftm9TbCtQ1CmNKfj6h9995yzU9iAgOqQmlMBoxB8QzzTKUDIvLaGD80rVLt11fEj/yKg37SKKCqZPNATck5AuYsyDXFYq1OVCmWMAOd26uiesy8v6VUETU7D2qDS0/n8VmY5csuTRTo4rRr1KeLwflZGmDbwZXeDgfwqJfU+0Jf8nkjvna5v2sahyQ6Vea7w3YYt5loEgfMMnlKEjbaD6X+MB1iF9w0CTkyx+B0Vge2Le0QMkgczYyrr2QJDPqLpBeVaqRZD8Gaxi9unlUcPgmZ+QM1TGwMwYVcvH1Bf991vk+Jk6X0D+HANtgxlJNC5oSeBDsyIbPlocoG64kleiemjy8O7zpWdO5zueCsA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199018)(186003)(6666004)(26005)(2616005)(6512007)(6506007)(52116002)(38100700002)(83380400001)(1076003)(6486002)(86362001)(38350700002)(2906002)(478600001)(4744005)(7416002)(316002)(5660300002)(4326008)(8936002)(8676002)(66946007)(66556008)(66476007)(41300700001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NryKcLEYX0LKBg7vLf6VSbWP8Y0qF5mpyiKLt4CUaQHnAS8S+5o5keuacf6S?=
 =?us-ascii?Q?bHM0dDEgEpR/u4aN3K2kpSRl/X3oZeuNO6iLaIBeHTM8HZQYwrujb9gt0ZOd?=
 =?us-ascii?Q?cTvKbI6zWOd8BXvexRJsX7k2g2v2J0IXkGSI6Sk2AcNj0Bz3W/MbBlWLdevu?=
 =?us-ascii?Q?P/0YfXnpDWAQ1Pp/5YfMA4TNPMc30FPgu7BCzVnRGZi05ldDigC/mvYqmmnS?=
 =?us-ascii?Q?oCxPYaoL7XL8ABLOiZrUsVRjwu8QIfxhWjL+/LJ97RY+ROU7uTlbFpXc44je?=
 =?us-ascii?Q?TJDLNT0nO1vlxOHcQUNHQBqYYvlSaBU8e5m/yN1z93Esp+oeHRRQX94VVwi1?=
 =?us-ascii?Q?Cj7O6soixAOl9DBwr4D5LkbDdNxFEGyEqXpHIhfJjTuQgrfRjxXzV9jrlO3X?=
 =?us-ascii?Q?aRAKWtm8/T6PuQ4HYBU1cYhd6sa2ZkyBcPNYuJDJGcDVml87V4ukOv5crSIk?=
 =?us-ascii?Q?owh6A78whD3U2zg7zeWZgYepTiB2zggorplu1VsfWJsTEuSrQTEJ+2pahLVa?=
 =?us-ascii?Q?vr4I9ofZbUlz6q4KJuI3KbuFOXJS2QTF6XF+kHL0+y+c1gWzz07KKrkAfr/X?=
 =?us-ascii?Q?b0J0Pkrykty0jj/2GClgbjmucLZMbIGvcRJSM/LfV92g/6h0KP7EZZ32rXCW?=
 =?us-ascii?Q?s/HsI5Iw2JyqXC7oj6Wi3GyTLZ3U9ZToUzrNlNk0OhHzN6C18TTsym86AETX?=
 =?us-ascii?Q?DwzLnnxHWYY9OWEW9uKZJ1TuRiPTnGRd0a1eTapZkrXVkeKbDzLpffcna4Ta?=
 =?us-ascii?Q?RxIp2AKHcXXhbzl5mK8PSRt0zB9BhdurfMB1X2//HWZLcZTKt9GOzNheqz/o?=
 =?us-ascii?Q?Us35/I+7WtD71K0CRj7VOwnRpgmksjIsJOi8ht61Necwl4c8TZpQby0nUnfh?=
 =?us-ascii?Q?6rdVTurK2YZFVKrt3nt2ZTqz1PoyW2b483jsjr+9TgPZYSkUZsBmG64TWVIW?=
 =?us-ascii?Q?LKHWGsT93AkfFwO9prLUq8yzaLsPvUokimLcob0Be9T/PgIobchh1q3Vz3z6?=
 =?us-ascii?Q?H882uOPRcsssHe1LaglCW7Bd2cSTJuCOfC12o38dJlST71jcsE98RfTho+y1?=
 =?us-ascii?Q?vJslas55oo6y3+QWL1rqK03zDhQJHFtlnf0F+eho6STfqY9AENxezmYigatC?=
 =?us-ascii?Q?9+EkJOGhxhcJOHaC0ogWJoE9WuRpvABcGj8/TJJuNRYVFVU8NOQwoUX0tTuL?=
 =?us-ascii?Q?sqkHONSnjwDnal0WrOM8cFGxW9pHBIIWcVD3R1oSRFbHD3IKzooh9QC8Tb4P?=
 =?us-ascii?Q?xh5MB76+5i0Gy1aC4+wdbL0eeyveDsYKM5l9vTviUDXaPDOKAmaoNX2B1JXW?=
 =?us-ascii?Q?EWc3G4QqAZtYMmYAW034lZtxlxcIfP59wuDGFdvaQ85jXxDQNPIIjwjn5wv1?=
 =?us-ascii?Q?/ukDvIwSwx/ODu2+wl1qXgZ6XbMzoJwp32ogLjBLAJKbkzdXKkE01GNBq7Da?=
 =?us-ascii?Q?4MH0vgh0yjIiy4RO+PKUAxHIHEawqwE5SBpVktzrPITWcRe8UEPF17aB9STo?=
 =?us-ascii?Q?SBFjY393ZdR+LZg3nBuTxZUfARN0jB4r3ToyIlXH0rHpGVPYtFpipA3bUe46?=
 =?us-ascii?Q?6fyX6eQKRvcdR4iMANwgGMEPTLeKejRKeCPmm4qR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0092f41-5389-4f11-6cb6-08db2b51c1d9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 03:50:35.1091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufcC5L1VG/R8AbXozwaxHQmKtLzuuXHySRIfM8YZ5Ipf0ukaKRoUF+V0mJ3pEOomSJkg+M2PdNAngMUlGqahAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8099
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The property is NXP downstream property that there is no user
in upstream, drop it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 New patch

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index cd925c0ac911..0492556a10db 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1453,7 +1453,6 @@ usb_dwc3_0: usb@38100000 {
 			phys = <&usb3_phy0>, <&usb3_phy0>;
 			phy-names = "usb2-phy", "usb3-phy";
 			power-domains = <&pgc_otg1>;
-			usb3-resume-missing-cas;
 			status = "disabled";
 		};
 
@@ -1485,7 +1484,6 @@ usb_dwc3_1: usb@38200000 {
 			phys = <&usb3_phy1>, <&usb3_phy1>;
 			phy-names = "usb2-phy", "usb3-phy";
 			power-domains = <&pgc_otg2>;
-			usb3-resume-missing-cas;
 			status = "disabled";
 		};
 
-- 
2.37.1

