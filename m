Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC44610DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJ1JxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiJ1Jwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:52:31 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E2D1C882E;
        Fri, 28 Oct 2022 02:51:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCtKpf0EzwfIJml8xvGF3XymNJ45JPtuxecPeBfPzoDWnwLNfQjkiZjTulGs94C3rebSRXbA7/Y/YNVzyMu5I3jqH00SuC0yPLF+NLLdWrgQPeHfxcNIKoFTm1of6S0fFY6NkN+miA7MDhCnFUMzt1pT0/7Ygx41FnTG5Miwg8jDpEpgbNnnZI9LsJ1/LaYlmhU8cHfDO1fxPf5JIBKoVamWwhOD+vp7db45jnVHXSnHzL4hog/UOR4ZWFTPERjaY46632jXBzBC63v+nPDOaPuUsiPAiwfV1bqOwQ3tvwnw+C/tq9VGd5QYRIG0hCMXtovVRwoQAK10ftmvwJMKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD4s9lO6PjPq3IAEopQSnp5Qd8A3LSv3nNa0xqxwxv4=;
 b=XGx2HkjNQ65Ca6v+sbRqRGvmFIqe8hwPqpOUVTm3FrqcdwpFzhuhocIVKl9f+pjxKk/foglu1WHei2594hhqt1XHIcyrvwXlN7rLCoiJsHTHj9JoiICA9jePzPlwJQaSStXYK3iwJvPrq9LEbr94afTR5lDzTUnXkjpiZomz4lYadWnGJtK+DQXiq7M6SNeN0e86adrp3oKyTielb06ZD+N7FVXQFBl9Ha62fXnlDUfWszY97MR1f3jtGiR9aC7o9Iw+ETjrzIFpar8qFEWT7N1kQG4bWIfxgSaVw8huIhy1695Dr2cVPqm85Jmg9a6OURtTgq6cWCPKMNzS2Lwc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD4s9lO6PjPq3IAEopQSnp5Qd8A3LSv3nNa0xqxwxv4=;
 b=hyAk2SVc8j7roDEhSWW6g4DMWRSjtnrOGtxczXS86d/HYTL0ZOY4uOQVBxvcIh1LilFeQLTHBZVBBpMagbjOyajkzgzqMxHawe9jfarlD3GR76ZRswqMclYTcuoGQi607uV5/p9Oqis0gOcIxpre19ThNSm8R4rAhmSSB31HhGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 09:51:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 09:51:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/6] clk: imx: keep hsio bus clock always on
Date:   Fri, 28 Oct 2022 17:52:10 +0800
Message-Id: <20221028095211.2598312-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221028095211.2598312-1-peng.fan@oss.nxp.com>
References: <20221028095211.2598312-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ac7896-26cb-4756-6770-08dab8c9f378
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h3EUUtXhVFq9XsnX8gak5reFSzk7pHOdAwW0YN2NRqAWM2V7qz8JzC99YVGN6nm1nT0HFQDckWo+IjITXxCj+PwKPP0+4G8t96uBgVJwkHH+4Pg413/otB+LL1fRLH8IbHo0L6ISFSBqrHxvk1hwJSGtu1h9oUgrMIj+0I36fsYVWjDdTMvOEQWH5eHO1eeAVvWEEC49+i56ab55zwoQ9O9SvlASEeUQztMWy8dmANPy6gXssxRT+FczgzNLdKkJR1+14B07Ocx3zsJNQlQyDvoMFEQzQwt5Ojqc+Vk5TUUJql+LmEPBU+61xkU6iF2SlRg2+TuA6j9CsGYCf0VWgOeGbbO6rn39bUeLV/lYE63RiZFQk4EKqYBc1Y/m8kgjfPlpE1N1d8iluqJc2dV2tDtfJ8VL5sJ967Djo2FB7d3bGSDyfQhsveG8RhKG6FYHyujeFDiZCTHst9HSWav5hpIOwt58JziUWURVGWmz+F/jCd7/Mb3Y46AGtdFt2QWMvKSHrV3YByMKUB/1qs8UPskhSbjm4GXQCYPv2XVZjCtKZBoM7dmTP1MMKz4sMHvpFPUoEPgYsne6RMOFNAbHDEOTH5c6aJsSEcJ+JJch7ylwMAFs3Njw3QCYWW1lTrBp9YIsN8s0VmGDiiBjCa3+EW2SrKioUbA1YqTmvIudKPUycEV06uIZJac62CHoi1c0PYsQo6ZPNQGm0UWEaeOJFEbpANO1rR2N9yKlPAYnVJnfJm+HJrHcMzDK98wR0FMx2jALTsYqufmqtHe8791+iso6qUMVmH3sqIfnXTQvpLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199015)(52116002)(2616005)(6506007)(26005)(6512007)(478600001)(186003)(6666004)(1076003)(83380400001)(8936002)(2906002)(316002)(54906003)(6486002)(7416002)(5660300002)(4326008)(8676002)(66476007)(66556008)(66946007)(41300700001)(86362001)(38100700002)(921005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BZ9fp6cVISeDjnWHnCxcmkpZN0+CAE05SYuqE8YYOEEZL9pHOf0eDA1icavi?=
 =?us-ascii?Q?IFauvPE8YeuJ4suK1oe4/HiXT8/Rk6FoCJTDwwOt9iQ9/1aJZLJjwOn/5Y0o?=
 =?us-ascii?Q?TwvpkMNCgBDCIC5Vpxe68VkuUCRLqceuuEd0winyxxPSOidwXGURzEUpQwe3?=
 =?us-ascii?Q?f10knzSIhM16mRF7NDsC8dyOTmLE6qZtGTMZLUUMhdGqY4gVYhbAjt9oTm28?=
 =?us-ascii?Q?gQzqcsinmXPxr6zGNflTpttRmDQ0ClVw9MP9HDqFq4/mEcaWA6/q2bZOlOsK?=
 =?us-ascii?Q?5kJMR48NE3ZRei2lXTPIulYX7Le4TjXSI7nbJlr7Cg4QI7EXT70n9Rpgvat1?=
 =?us-ascii?Q?eQGyjbVdCwt/VrgKiB7wxB9d8n8/2sY86WmR+1ZeqSHX4WmiM+pLuxSSns7/?=
 =?us-ascii?Q?5aGkz3C0WzmVM6tRAwB4weL5GKIoypu/ePbJ0ORnuvvus3ODH6n2sNL2FAx9?=
 =?us-ascii?Q?69vTdlrRZ08cceJ3oSdLmN0RUS4ySWRj4Kl2R9F+EfZlF2KgEkunovXPAV7h?=
 =?us-ascii?Q?qhFT0pgQe+qKjvA4brDaiGhOCLEHJpzlIaQlH81QFOIXw9R8/wYGLwThXqca?=
 =?us-ascii?Q?S08v93luj8SGURvb9oI1DEVUMucf5/yFfW6zFHXf5WADoJqSRkFzKEOU05Yc?=
 =?us-ascii?Q?w3JQiA5NcqH0Lv/UMTDuwEp39CMmbJFpxxGPzD3DwJGGurXIKMyERX+lPS80?=
 =?us-ascii?Q?rzkUNU2onGy+86UnCXW4G5BGVZugytWCL6Stk5/z70egXiwsPVeILrO8AdCE?=
 =?us-ascii?Q?axn1S/LhTw7xQxhcM5gkx1veQoQDUBsI4xQeRJlfeYmAhweMt85s0/Ld/N+w?=
 =?us-ascii?Q?VRLUSq8O+hZi02VOQVSe60wLdORi3ijmXo6lZenQkw+oDR+B1hejhd9MYOw2?=
 =?us-ascii?Q?tXfpVdX4aEDEjvyCWPzMpIzm+xEAVHL7a8qUHgfZZVtJj7/PfzonDc9ap7sf?=
 =?us-ascii?Q?jBKZQ7MSXRflC1WGiGFNhJyDPcMtBbkSeF1CeR8bP1FRDpCu4/5ZaN2578qE?=
 =?us-ascii?Q?TnKoKvuk0FHbx3SUcSA3mwN+UUO5+/k+5bxwob/qYip9iv0mSN4Am7JiAO6l?=
 =?us-ascii?Q?LOfC+WxabegnaD8GQ9EQ/2qJhwyylNlZR6GOOz+1PlIoyXl6Upa9mp12gyu2?=
 =?us-ascii?Q?hsIFUjBXSgvchkqDID66RIRXYoHsJfhISYWVvuRo9plg0tYoJcz5Yz+F/g2S?=
 =?us-ascii?Q?G9G3+Dcq1gX4d5watRlqspcvjP47Qt41E2aS8f28bqiu87I3lz+OO0/DwFKv?=
 =?us-ascii?Q?CLKh0x7kVbVYfzYylwo7RYqT8MITEm5Wwqv97xS1FTDwChQitDZ7nF3B/azV?=
 =?us-ascii?Q?l85w/dywR+xWzGgFK+4EKigruhIRjIiSxIxfCYT/RBC4Gu2mE/FAFWz89P4M?=
 =?us-ascii?Q?6Ze/fOFySRtkjQWL+AJr/8FtHH7nqSYo9svZxvkZ6Da3ly3LfDJPyHjAzkPL?=
 =?us-ascii?Q?MQX+FrQXhurI+pAIyduxxgRYuY40iCfFoiPlqAGOypR/EOkJVU9NraLceDcw?=
 =?us-ascii?Q?C7I3qAHVHhUHUxElGLcBUxQNK1jEPNsbmWEkgcqzgDEjx2CGCWAT76WcGrzH?=
 =?us-ascii?Q?AVZCypIPfj3Gt2oEKgbviAXAaUxeVBinJQPIf2HY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ac7896-26cb-4756-6770-08dab8c9f378
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 09:51:14.0756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4ed1ov/1quRvsfQO9Z4vlbrgkixRR4C6Dmt2fKQ690nqdLohEyXCOks23Ejt4OfhqgOGqmk93qDQj3M13BiLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

During Linux System suspend/resume stress test after System Sleep
enabled, system will stuck sometimes. It is because NICMIX is powered
down, which HSIOMIX(always on) is not powered down. When NICMIX
powering down, HSIOMIX will get a hardware handshake, without HSIO ROOT clk,
the handshake will lose. Then after NICMIX power on when system resume,
the access to HSIOMIX through NICMIX would be broken. So keep HSIO ROOT
always on.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
 [Peng Fan] rewrite commit message
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 422ad3c89845..7dace96f36df 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -109,7 +109,11 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_CCM_CKO2,		"ccm_cko2_root",	0x1d00,	CKO2_SEL, },
 	{ IMX93_CLK_CCM_CKO3,		"ccm_cko3_root",	0x1d80,	CKO1_SEL, },
 	{ IMX93_CLK_CCM_CKO4,		"ccm_cko4_root",	0x1e00,	CKO2_SEL, },
-	{ IMX93_CLK_HSIO,		"hsio_root",		0x1e80,	LOW_SPEED_IO_SEL, },
+	/*
+	 * Critical because clk is used for handshake between HSIOMIX and NICMIX when
+	 * NICMIX power down/on during system suspend/resume
+	 */
+	{ IMX93_CLK_HSIO,		"hsio_root",		0x1e80,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL},
 	{ IMX93_CLK_HSIO_USB_TEST_60M,	"hsio_usb_test_60m_root", 0x1f00, LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_HSIO_ACSCAN_80M,	"hsio_acscan_80m_root",	0x1f80,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_HSIO_ACSCAN_480M,	"hsio_acscan_480m_root", 0x2000, MISC_SEL, },
-- 
2.37.1

