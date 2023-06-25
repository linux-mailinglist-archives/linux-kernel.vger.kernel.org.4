Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A2873D0FA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjFYMiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjFYMh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:37:56 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9FAF5;
        Sun, 25 Jun 2023 05:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkKD2u9NM//jk852TboEFTZp6p4+T48Bv45RDkIBBA6IRpoZkRB/Zq7gJxzCqq7FCvlB1nxh2CRsVaIUiXkjrcwJ+H3+RcvBtdr2cUSLszcOJStTNRUt7LvsPRgwCOFOpzx/3eEEgZKCe8kUpcgkpF4E0F0beG1c4TcFuVPEGrpCv0RPZe+9imS33sIAgvM5gzFQnazCZjYt4NmXpmHxqqBWcHlQA0O9Si2J22PydqvFPSKa2kZ3EOIq3IemCKK++gjyUd00+AL/sDlF+gz4uM2DcTVSdHeXefBa7On2XiGvtJXqPuF8s4ksujsu4PczYITZDp1fFdgno298jT7ldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bs+XigU+rtJb52fiRS71eKGqcNcbSQSHMhvnyOvXCY=;
 b=ngt/o+JdfTjpwf6lv1xoqTfFyDjOn+3dCykEcjmfSrQQLgpS0+7m7SM+l3b/DFDMRA6Zvi8HzBgJ3N3ihUWKTuPNPUKtOTjBuZdVOvut/w02aJ3LkS9KDutQheO+E4hGrlZliWgbuMUqFgerJsCF2MUqTQPhDWTwmAhfOi7jsl+mPqMzHZVndWbWo+t8ZUr6gh4p7dui9C0N1aUnbnsQHa0oGR2g+JGffKhPVVY5goTcCxu8ou9lAEHpX5fgcf8ekhFF7PLWkjX2vcs0E2SZrmbDTbdJAy5PHBMpeR2djRFxnprjFkVb3i7Qs4X3whuKabzILKC9qj98PgARX75nCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bs+XigU+rtJb52fiRS71eKGqcNcbSQSHMhvnyOvXCY=;
 b=UQyZplcz1RyhviAsdZ8rtygsu0fmV44UI0EAVdT/kQkZsEHF8oG/PB4Pphb7adnyGaAQRPXO+Re3Kq+sJA7gFi7qCvW9QCU4zg5gqNyZxLjTgI5NFPsJGbSShQP+h/HBe+thJRlc1R3WiKrDBRmuWLfrX5HnzkxmgmE9ezFA/C0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9314.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 12:37:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:37:52 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 01/10] arm64: dts: imx8ulp: add cm33 node
Date:   Sun, 25 Jun 2023 20:42:29 +0800
Message-Id: <20230625124238.4071717-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
References: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ead313e-c493-4154-bb43-08db7578fdc7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPVj405pCjWV5elrfkNFBn9fUSFhvYAJWCG4x8xyts9GyonWGDB1nLt1315u4V0x8nW4KUstgBuOyt96/3EP+JWyY47j9dKwpzRvtPa1e3GYGr4Gen/g7Or3clmtzITWgryXSm24GC4HsxUZZ+ubHvESYjX82fkN2hGc+5ErEjGEAMQjmvrlTROtXYK9PZ9JTj32Hf6ONXDPp+JKJOTmfwlZudwGXXy1lrOOFRio6DsHmffoYYT0lFWcC/zfk9I1Ieu8aZdvKiEgHm1Q34lJDSyWOK8TNF5p1QUxKMd0PRR+vJSBACixFBbW6pAhEFvg4zSoGkIkdt/QDa11HyfvnPiU5RHQxlFhNFE6ZPPqjNNbkFcF6knCFYuOIV3OdRhJvDpJvM3o/8yMZPpl5iNfhMPaQk7rW2SAFwAOPsakwPeRzTat7sFG5bx2rrhUrHJCZdz2H4wDCg2vjRDNCjhzoKZSOVkJNvb5g2eUZhzAahKQgzwz3S8yVkJ78a36JpTfrs5eLKiraYmzyQr0L+uo0XC4j/FOEj5vn3KW81luNg86qvkpADa1lr1cl9QPV/se8dO43Icm+0L933ht4htn+9Ib5TZ+OSWJjLWOyWl4hWOSKO41m3MYvMnoKx3j/ExI985cPKPe1TYoBCkqu2CSXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(5660300002)(4326008)(66946007)(66556008)(66476007)(478600001)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(52116002)(186003)(6512007)(6506007)(1076003)(26005)(4744005)(38100700002)(38350700002)(6666004)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ufKikjIJYQFdQsV8iACmBiIBj4QDh1E6xtiA5iQz37iPW0nm+/AwLdsf95w?=
 =?us-ascii?Q?VrPg+t5mCec6GrcRLQmWVDJ0V8H0QkSUCPFq3gVcpDfaLEoQTQdMQLPRJHDc?=
 =?us-ascii?Q?kfQShrMqAc0xgXAfMxR9btMAqdBr+9GWc7bZlhtxOs1MPTSIxhgNI5zhLm7Y?=
 =?us-ascii?Q?C/UjvmFKEDuFRDJJahCjTuPKfLgSlT53wC2xoN7MNH/QEkhRQthocjpaDOnV?=
 =?us-ascii?Q?Kg0qqAg6q2LAmKUIU1u8qkVL88rdxUioNmO3NQP7YbkIuUJKz6Pcyir3onRa?=
 =?us-ascii?Q?4TPOrztngauC3rZOzbcV6q4n3AxF7GHFiRd3kircnZYIWGkgf2XNUvCgExcA?=
 =?us-ascii?Q?ivvbiseAZ8arq7cgft/MMEZ6T/js54lN7hKbSxOSDYoCGGrsCY0JNp3z5utl?=
 =?us-ascii?Q?XiVX+pIMgExsk/C4EXuy2/mW0WJTGHgA97R2PVCfZnzlI48R0tHc2vvjQtY0?=
 =?us-ascii?Q?qTqzhQXsBmnFHt+wB2aasQcdmk9+Nx376z7MDfuqhFtF4nz9svVo0iMdNlRw?=
 =?us-ascii?Q?tAqYI3WCfbYwiskkMp/rKNABM/0J/Giumpfdfv89iH0GyJTgpYyrByUf7/o8?=
 =?us-ascii?Q?CH2lQ3MpeuLOobhuaXSb77X64u69HYO1Riq9w4vNRLShZnXB/TBNQUZOXr31?=
 =?us-ascii?Q?rv7oKftvaBUhfJLhMCLApoWqjHuopk3b1/9ekkB/Xn46n2gWW6VI6Wi61Pme?=
 =?us-ascii?Q?k56U0VraetaZwwdRW6G5gkz3NVRLdsUoMZEcce1m7YQ38w4ehLEf7imspRkE?=
 =?us-ascii?Q?37Re028yMcH9PcDAPNNa03/jaj6Zta+PoxDht2KwT+j8KobYKMEKnX6UTLxx?=
 =?us-ascii?Q?J8mIVXqQ5P0yooncaTD8DgwYLsCwfkfV0S8eigZu0QlMVeK6x1faLwRC3Pm0?=
 =?us-ascii?Q?CFEdST9gTG7C49BHozDKawmmyl0zAmRkXCvBjFOLHKch27+2BrfCONFXCLKF?=
 =?us-ascii?Q?mBtCEIGxOe1R56r3Nv555UDWI+HiFVYH9aYyzcI1AlE/Jg3b5Ey8RBJ82TuC?=
 =?us-ascii?Q?w+LtysN63Dg+SHCkm3N0ybw1ZJd8icBWCE33qz0TGUsb/drooPst1TGimhOS?=
 =?us-ascii?Q?dy3/fzXypDJTreEaTdc2WlUFbgGRL/t+hYzZxzpOOFxwdcUWpGoLSe3O/QIn?=
 =?us-ascii?Q?LSiozUQ7oG+FxZh13mBEqTmQexb0lEMd94xO7l6upYmOwDURX4hjH/kLftoO?=
 =?us-ascii?Q?HpeGgOeBGABjd0Sq8AnD/NiAaxwHecuqB6p2v0v3qImyKwNkcR9OZ/zspbzh?=
 =?us-ascii?Q?LPzLOLahNxhNkxXl6CpJxPEv6DfuMjnJ5ua20pPiQ0JPUoGdJZpcCVdnqgv5?=
 =?us-ascii?Q?3gMftG2CRR2Z39tqovkNk6LIWnC/xVuw9MCVdoYRSs7J8ocwfvX7jrmf0z4B?=
 =?us-ascii?Q?yc3fZ5sZBL13dVvcn6OsMqyLBQPWzCM3Jx5SwPLwlIqV83UyNApq2K8kk+Z+?=
 =?us-ascii?Q?z7X2woUVBZL0AjA0Rbnjx3g0xvZzBG1u6M+ClnZCGA/b1e8lbRFd5XMr7qyd?=
 =?us-ascii?Q?I4aDYXIoa4Cbm7H72HqqtBSnGQjBrd6XaPd2h4Y6Ldnlas3Za9QTsGiqnrAw?=
 =?us-ascii?Q?HqQCUnSDrqmNSMhH2jCUaw4gZq8ezYB9MDBWditX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ead313e-c493-4154-bb43-08db7578fdc7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:37:52.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYlq87X81D5071Mnh4d4hdhz0pSZj9Xapb1vK5+xhxoYGhrjQ15DcSL5BWA6+MWVjsbC5iFQvki8Y4YD5ja2MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9314
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8ULP CM33 node.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 57627bdaa851..8116d6eeb738 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -148,6 +148,11 @@ scmi_sensor: protocol@15 {
 		};
 	};
 
+	cm33: remoteproc-cm33 {
+		compatible = "fsl,imx8ulp-cm33";
+		status = "disabled";
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.37.1

