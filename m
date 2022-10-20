Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FF4605C09
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiJTKQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiJTKPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:15:53 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DC31D52FD;
        Thu, 20 Oct 2022 03:15:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wbfb3m1C7ASHWn/VX7Q6bfoIspA/Z6DmbBKwiuM0iq4CQZihcIV8aaLRbZX0NRsK/HAQSD9Cidy2EvL+DFcvtAmySjorRHAWCnJzL/ZI4rDEFzX63vrrUuL6yhjrpVaw4mmaOcCbUtjhd6MPiIDYwy4AXSPHoQtO1FFYMDler6wcYdicr75+Qsf0CDxaZK9Nt6LLH4/RtI1XUaOEcl82OCGpab8qRJEqtVsvaRT2Op6XeifgBXaxom6EoJjNnm2ohMpaLUI803Lj0jNsS8DEo7bbCS6itiqxJ6fS+nnCPTpPgwu/gJdKmSdQAwFHeg73vQu3KTpc3Jo4ACR9sil/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0c1fa6MCccaH+QEsEe81EltZW5OSPeY1eRAAggBux9A=;
 b=jDEmeyJczJlk/GJfr6HBWMTnpsjsGaA2y2RcCCqNGI1jLv991iTnZP8/UHI4iDsu7sK3oo55lIraeG0d1/wZWbKv283OmfiZj6M7UN3yzNphNZpcEYNxStZm2dRCh4KRj6LDDGc0JnageozNp+ufE38appXF+4pvQa/zsePqV1ZJzdAQxOyRf3ew9+LO38iAYjVeEnGDooxkppGG0NTBVl+1AQEiFZ5kFR4klA2ixJbInKoLZ/F0PkIebzKlw1Tds2ndsJRwM8y3i4jQ9Zbbxu5gLB+hcca6xACGP+ZV4ldvFClQ4SRkJ0viRJXUni6bexLOWLquOSuXfo/gnwqWzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c1fa6MCccaH+QEsEe81EltZW5OSPeY1eRAAggBux9A=;
 b=dIUiWJxbimJsgvA7gdvIJAlfnTha9+aAbhrAhwIwXqlfHWD9h+3j4yFpysLT2/RQNYvQjanrDEjajgiQGP6etjIc79w+6W5kPTZUlPeZGMx9Dn0tRwYMfeXUHvkTqHEokLlFFc9Zjixq4825x3vpf5BXSgnOOQIhp86MiEqHzKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8127.eurprd04.prod.outlook.com (2603:10a6:102:1c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 20 Oct
 2022 10:15:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 10:15:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/7] arm64: dts: imx93: correct s4mu interrupt names
Date:   Thu, 20 Oct 2022 18:16:56 +0800
Message-Id: <20221020101702.1867188-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020101702.1867188-1-peng.fan@oss.nxp.com>
References: <20221020101702.1867188-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2ac352-6efd-4ac6-2852-08dab2840c67
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmSlYghaKhLo3WAmwbPOFSNQCfHNYpKfbybuQe1MZUtujYGxq2/V5NHfGzG+W0feFrQDIr8LC4OZq3d3HSrsmV+mxbEE1INdLl3TSp7V8MOm8RgpadPtLHA8HFM5xW9uMygN7x9n8rjW3FJLy/0ngNDihJzg1ABpGIOHS9hVdufH2UZTfJ+Bx8ixvrUy/y5ZmTJGlcKHW7y581rhg7GjQT+26ulSQ6cC5WcBMN5rPcSaUl0wA2OHjn5s7gdojN+VGfidx1OhP9DelAfH77tcd34IRD+Qm3KE3NHGG+ut2aURk78ex8ooQ2CuBB3tCfSOZgz6gOTVP4BpKLc/bkksdnnDG+yinCypk6Z4xcmqciDSsRg/HITae2dh5GNmuDADRfwY/5iN9H6OkTWtT/JUu3CPk+aPoVgzjO/ozcFPbFoEh/p+T0qj9A+Fc6QxzoBngn6AG99j0rxS5H7Vc9rTWSW2J5b3sRZDechrCWVqgAv9/QfGrW1RqjyGSXbJQjFO1a9I4U5/Zfr0H6uALSM4AikfkVuG/cILPKrsy6PiUal68xguz6uIb2xH68g7SmhRxfralcLTjXxqgXPgCWZ5IBZBd5wlbvLx6clBG1owtoFNhP9Ww/pAa7HEsrMaddmoHCPaTeBBydrFGafCXZLDW7kkUEUtMsrjTa0CXM0c3dvyZcoGgMO/uZ2Puk5hcTzbWYocOh2e9R38u5JajHcnm0sguY8F8hZvuqwKBKiVJzhfK6O9AJEdQtNRVi63r7Zg24e6fNPavCaEHCMoRPQ5hjWRhPeKA63atBm38fdIsuSjC6Z5FzkwAUuZRw8OlAIn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(38350700002)(186003)(2906002)(1076003)(38100700002)(2616005)(6486002)(478600001)(8676002)(66476007)(86362001)(66556008)(4326008)(66946007)(4744005)(8936002)(6512007)(52116002)(26005)(83380400001)(6506007)(41300700001)(6666004)(316002)(5660300002)(42413004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gopn1rRDeE1pwRA5hwOL3f/FnojnMd4Vu2CvLQBmCHa/g0Bvs1Pwf4qOKoOr?=
 =?us-ascii?Q?hw/UrGLZDtGJgAuKSZcBhOpQN07PP9GWEq6obG/hP4w9g+jC40/kQ709iRCT?=
 =?us-ascii?Q?HQADhorCysOU+f2hI+X2jqCM1mFKK09yd2EYClFoNjcIJXsU34/Zp9PEzl6T?=
 =?us-ascii?Q?20Ca+nJA9FGThqF2L6Zv1eDQVpSU7Ut29P4n3XIFp1iTbiig4YnS7kRNWRRF?=
 =?us-ascii?Q?HpDSq+s5LHYJyIjEt+ZEZVsp0GhVihlh09r8X5UCsKTDBQDZfFWYhVcE9k6F?=
 =?us-ascii?Q?1xcm+KqC6k6Rksl0TnW+dlTEMIP6qDzIntRkOSkUmS3pp6P94jkSEgSr9H4A?=
 =?us-ascii?Q?zRWGr5d00tkDAkX2F9OA9Tdeunfw8rBbqzUYzSQVn+taWPH8Y2JazyMlX+0c?=
 =?us-ascii?Q?PC4TUtqK6FTdvftOqOD20VajmLpllOo4E5X0IvzfLIG4OvRxOxi3qXAKkBzH?=
 =?us-ascii?Q?Qve0KkB1WZ/nsBAc3kbzU7JiLfEWAaEpLEK/N/vJxpoImp91agvPWfXiTye1?=
 =?us-ascii?Q?mn+sEtsj9B+33vWjrKCgONTeFJT4gz+7ogVtDOSlq68u/xCAJTjgTvAynbUQ?=
 =?us-ascii?Q?HNx1lF6y+GCTebq0qvimo945vdcsxdH70er5Njn+ewqZABFWBYfRpbdcTAnB?=
 =?us-ascii?Q?vDSJ6DDoxsYookoW8LPVCst4w6AeFOevrGfIMJ41LYjsh/vjcV4dbCZQ1xvK?=
 =?us-ascii?Q?64itNecN2rsQ/IOC5jMLoh7GE/1bYzWdEOWJoKfJx6vAtd4hNbQg7ie63Pok?=
 =?us-ascii?Q?8u5Vxyp+yZCRYgCMsnwN4LcccjGtWAKxiqCZx1hmkX0i85uqf2tyEhHiNRLP?=
 =?us-ascii?Q?A1qRo90XfxVb3hwtdCvyZN61kOs91f811g+OKLT6lxJfJl3RF4pA3jAfUNJj?=
 =?us-ascii?Q?qbNLJYMbLc/pcYMp1FL9BgzxePqGemJP0ZqXXU/EIUDygmnAzsmsnzyaqD3+?=
 =?us-ascii?Q?Xn4oWzsSVZZByDoiCb8utUXAzghtGmJilasCr40uvqB5P0EoGK+1gtsqSX4B?=
 =?us-ascii?Q?HDRzDO0Ipzz068X51chUa0Qf32fsBsvfgQ7wkzx+euorZJ/OfGv9ccUkAnZO?=
 =?us-ascii?Q?LwqA9xHuhz6iWIqi1fWaMh27NpdMDdRLuLWuyW0z17klDzfafwWGl0wnDhWB?=
 =?us-ascii?Q?E3Ds6z5BbXYQsKU4Xsium8znRbzw4XrKkwgCe5oy9kqnWGmboWQNu+P9FECS?=
 =?us-ascii?Q?rd2vxU/c1UHLuF4q52yCfi4+uuAD9h0gxZY3JyChRB27BLxU9hda7TPsEv43?=
 =?us-ascii?Q?KjKcefpqud9Ipqe4aJMAorit+m3Mv1Ykl2F5GAVZtxx111QmaK464KPC8noz?=
 =?us-ascii?Q?HK1fjSnObUvYvxvh8G2g76W2VjJT2Uk+HNARqXk2f1PBPixX7zc3ud8WuJCa?=
 =?us-ascii?Q?PHMYo7S+LgbD2qu4b5TEz/yujPyZAHdhbK1/e0qlRKHp8RT16JVyTOiulUMK?=
 =?us-ascii?Q?a+Bm9uBA8BmcuWI2Psfj8L/lSTJBiVBWjtvZTm8WaMu3sFxA+0WYeFM1HGJd?=
 =?us-ascii?Q?RFyKTFTRw21//OvcU3RnsbcvPmloV9QvfSMFuLyR0/6DlMRF0L8IG0rUz7cZ?=
 =?us-ascii?Q?t2XMRlIA0FSZcXyKIQZS31cY19Yo4rSmo/cN0IDh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2ac352-6efd-4ac6-2852-08dab2840c67
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:15:44.3297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8o/iWOmf2SjuEC6PiF9aZO0AmAGJQSdFR3E4In9ujFN0UCxS9EOH4uPXH+rx6f0fkvlQHA36BSF+ITqAiJ0uTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8127
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per binding doc, interrupt names should be tx and rx.

Fixes: 0dfb380d2492 ("arm64: dts: imx93: add s4 mu node")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 3a5713bb4880..55a70ee6f91a 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -501,7 +501,7 @@ s4muap: mailbox@47520000 {
 			reg = <0x47520000 0x10000>;
 			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "txirq", "rxirq";
+			interrupt-names = "tx", "rx";
 			#mbox-cells = <2>;
 		};
 
-- 
2.37.1

