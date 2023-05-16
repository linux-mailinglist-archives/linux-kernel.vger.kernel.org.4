Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5567047E1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjEPIdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjEPIdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:33:07 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA581BFD;
        Tue, 16 May 2023 01:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4nGj1t5HrX9ecuDa1FFLUSsSwI9VRe2jbSXWP+L2hvaawgdOV58kGjCZNMQp0eZLvfPEPlXmUnDbE2Xt4fWMBAJOT7rPH1WRIK/r0ZBah7JRCmoA+Vx2bxsm8rfCAV4LyeW9lOjzdDGmw+FhXIwZZtSz5oKdvNDG+nkpULkCGfwSGAT+/K9IF+D6kjW0dTIPohrg2oN7US5/W+E7pNcuQHDLiXSjgMqcmcGyM5p4zSQrz5GeROzo8bSwfR0jP9apVc+uaZCGdVxucEEYpHECl1HW8pLUgEpLDjcZL4YgiLa4RW0E1Ek/iZ1awBa39vSzuc5KBEVp2dkV2ujXOJSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc5Pk0e2JJ4AxW4OTi/UD4axguCWtZINOgyMB51+n4s=;
 b=JJh42MhHBCyILCZOT7vfuV83k5TpjNho5WmFz6axyp9mqbEl2Pdw4Y0nfKqQBDrriejaf+lvbVoxOWJ4G0RIr2DuyZdayAkAp4JGgHCTdnOYcs2Zowq4RS9E78UPP8wQ6T1sks/W/vSkYtJ+nGMRFeEcJbJ78CalEmA23cpc+zbkl2Gm60uWb+DhGMfNWo2OWQpvS91Kx5UUACRxFRLxwv5Eih6D85V1Kc1YQtBECPGxEvys4x7jh/3tjoO4R5EuiDG0rSukCLmhw+MEU4CUfV1aIEUPHP3vKs2Ste1ulYvLFjleCBA8W4OO3Rm7IkxFnWlwqLA9bWhnZH0l3qt5/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jc5Pk0e2JJ4AxW4OTi/UD4axguCWtZINOgyMB51+n4s=;
 b=U/v9MCLs9WIOK+Zfp/FS83LnA/2vhM5NH+WQStLINBrm9yUWcs3GgxbKhv8m5wBDqhevW2C7VeHpXEqryiTRk+wUFJ5Ori7NLWt1rODxC19bqoM1nNVkYeYN4QcT3CnVM9kkMOrkfA5eepBP55+RFBFCYvrnGzbb7zEmnghKYkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7644.eurprd04.prod.outlook.com (2603:10a6:10:20c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 08:33:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 08:33:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     amitk@kernel.org, rui.zhang@intel.com, andrew.smirnov@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, alice.guo@nxp.com,
        Pankit Garg <pankit.garg@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/3] thermal: qoriq_thermal: No need to program site adjustment register
Date:   Tue, 16 May 2023 16:37:44 +0800
Message-Id: <20230516083746.63436-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230516083746.63436-1-peng.fan@oss.nxp.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:4:7c::27) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c09bfa8-a2da-4df2-4dd2-08db55e82890
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 82J6zjxFEYzdL8MDQ+XeZE7kwoS9SfCZs9skHMXPXuTeqeZSClG//huL1WeZ827MhWTRdqid2bE8RCvK3E+1L4rgjG6nC3R7Kp0mpuxnE8G303VXIf0Xf39yI7jnzTg8c1FZFVNOTBkNyTCfJ0Bv9to3z1+4/FzGorx6AOpnVUHy36QJvUxWsGOVHxg74dvIfXmOLdpHzlbUDd3Qf4478zwVxmJBmLUzyXNM3uGe1d0HTa/+3Fbzds97Z03dWxnLhh2xqPsnC3Rc+4+xi6GddES3H0eUZRQljU5nTo1JbmylFKDJhjvBhvVGjbOVkJuxDcuFe0/3cglPhlPX2NNiVrjU9Wb3aXrr3gKHmDDT9vvKsdtF9dxzpE8Fp4xBrv6gG2wEOuap/myvqKQmHyBZzi07Syo+1gbwlNLpdrVjIATEhnzMxAGUjIUXp+3TYIJh3PFZWD/GOg+uNlVSCe88c6XKQrWXbLPR/D9Odjue6n5MLoiIz0I04sLYcqpLulzCFsIcZpGwZgQ/KI1bRbFlKPCYI+TyLo2Nl8QTUh5NpXneSYKoiwaPBtDpceq54JHOfDmwwEiZY8JysIhsIBT6V4mYnT9UKdY9RZknKI+xKxjg/ptIDqd3R0hH/Cmk4lYW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(52116002)(66556008)(66476007)(66946007)(478600001)(4326008)(316002)(54906003)(86362001)(83380400001)(6506007)(6512007)(1076003)(2616005)(186003)(26005)(6486002)(41300700001)(8936002)(8676002)(5660300002)(7416002)(2906002)(6666004)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yVP1BOKPHAgRXo6skd0iDWvr4dp553J5F0tgnTOttnihj5fww/vJs66LWSDo?=
 =?us-ascii?Q?Cc8I3eooH2PztssjjzqtffU+o1D947NJ5UKNQRxGBXrC92Ip4qnqDaEDt+Tu?=
 =?us-ascii?Q?o/jwRPwv7TKykiC0Qt3MhxbovMNXkowF6yPIXiFgLK3YJ3a4Halzk2t7U35N?=
 =?us-ascii?Q?ehevs+7dpNT26FsNnGfZ7SgaCZAf2rab2O3teedSEusEbvJBWfcSOffh7jNK?=
 =?us-ascii?Q?T1e33X435P0dc0pKKm9x8M0oRkFnQPRmWGIiwv4D4mLowvk/Z0tJLn/2O27w?=
 =?us-ascii?Q?NcLGlwGKxyYJ9sCQ+/Mi0U/FZpSTkxQuxf9zvAte5QuNaSkEgrFUA+qwxE9O?=
 =?us-ascii?Q?h0fHaRrxUo18Hd/7ZWM/LgnpqZjQ8dZpu+AZ+z7b8Tm6/6x+brgbPvZ1tuaC?=
 =?us-ascii?Q?OkIbjM51xyAoeY3munwsEaN+7mM93rYj5BFRo4qphxb2Y2t4JbRZLcBMwkal?=
 =?us-ascii?Q?DDJNb998V2KrJle3DADlkl3lwAxbSMgNHwXASudwQlLJSElenFs/GcR1tw+a?=
 =?us-ascii?Q?WS34tyng8JRXjqgmDyw6gfNLqFu8ubBUVxkRMMk5Bfn8ywnoHPox90cXRQDn?=
 =?us-ascii?Q?CNCgIjBkvAx/1BefHuDCl1Qq+4RTt33v+O7c2EWickbFPiUEgP5wjfIwFgHD?=
 =?us-ascii?Q?ogszCKImkbXNszWtdrHI6Wl/4zm1ddmS/4HBEh4NZMi6vmlpGH3Vi4llhJYf?=
 =?us-ascii?Q?vr0TKt3vEv2Xwfg6k8rkew2obSpDBTvKbGYjVaH29hbFnYQCDI9tHgvlH2De?=
 =?us-ascii?Q?Lq5+W38ZZ9vPEzbLN1NoFssI8/lCulhgbWDHzRsxRyTILVSf9onyCJMiylon?=
 =?us-ascii?Q?DnYY8GL2DsKiYmOTm6wsZDwQZYMqo2zVFDy9eTj3wyo+iAuvrOjuxcBVpioJ?=
 =?us-ascii?Q?ThmqFRaqBOiIr6958hOkupFkzFIce3II5IFCKkmz4JkC2VcAkXgmvgqwpJoe?=
 =?us-ascii?Q?ubf19HYhYKo98ns18zetTQ7VSuxGllbyCqVRPJWXoMUjxYC4QpgvU+FeGKll?=
 =?us-ascii?Q?RVEML/vC8Okrq7EDYBshT4mAe8UO9NyR8SzMvOnl2rtkkVAgR5Xr8r1YkP5b?=
 =?us-ascii?Q?ZBk1Xtei3nO2rr1hhqWA3ae/X71jme5Grtyxx7nrkmQgZ0kkuovPZXC87vIb?=
 =?us-ascii?Q?YBAdjXW6c/8btGG84wZkYqb4PEy5Rab+ISRnVUkRhMQeL5+O//KsbETR5n8q?=
 =?us-ascii?Q?fUjRONSt1ld1/gv6bzKfNPi/kDcWxq4D10Q+teVgACPkOfnq1r/wygARiRfs?=
 =?us-ascii?Q?bANPY3Z7Z/1i06W+xKyoTJcw58JbeW5NsQWq3BppCQy1eo6xQUxDZWFlWWDk?=
 =?us-ascii?Q?IpqqpOBeAqF05lr1hP7Fqt6OcM0H5sXxJM+9dVXVnJg7+y1w+D/1u7dkeSY4?=
 =?us-ascii?Q?3+E7OHjcQpnbCPEdSvcqFH5r1kGtpXk6brN6DgrGvY3Hl/eBsxfzKGaoINQF?=
 =?us-ascii?Q?2u5XNQpKxqqfch0IOt27jMnFiKwxZcQwM1dmhwGuKh1GCOZ4ezTO2UsP/y28?=
 =?us-ascii?Q?hl6sB/P6y9R2UWrRfYIR8omIdWW5dI0BwVW22shhMid6sOWN2lFJPdCNhuJB?=
 =?us-ascii?Q?VDT7uRjbvCAroG0O9qOlDICWq2065Qy1QIOYwiPz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c09bfa8-a2da-4df2-4dd2-08db55e82890
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 08:33:00.8600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2LeXsNXwEcw8Z437xI006lfoVoViO5Zq8Rf41ZDdseIZe2CJPoaOqsuP59/B8veoPRM5ygJpLb7zSMY8HGziA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7644
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankit Garg <pankit.garg@nxp.com>

No need to program site adjustment register, as programming
these registers do not give accurate value and also these
registers are not mentioned in Reference Manual.

Signed-off-by: Pankit Garg <pankit.garg@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/thermal/qoriq_thermal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index e58756323457..b806a0929459 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -208,8 +208,6 @@ static int qoriq_tmu_calibration(struct device *dev,
 
 static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 {
-	int i;
-
 	/* Disable interrupt, using polling instead */
 	regmap_write(data->regmap, REGS_TIER, TIER_DISABLE);
 
@@ -220,8 +218,6 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 	} else {
 		regmap_write(data->regmap, REGS_V2_TMTMIR, TMTMIR_DEFAULT);
 		regmap_write(data->regmap, REGS_V2_TEUMR(0), TEUMR0_V2);
-		for (i = 0; i < SITES_MAX; i++)
-			regmap_write(data->regmap, REGS_V2_TMSAR(i), TMSARA_V2);
 	}
 
 	/* Disable monitoring */
-- 
2.37.1

