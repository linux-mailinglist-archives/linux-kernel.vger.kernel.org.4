Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E559F60CF62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiJYOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbiJYOmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:42:01 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60048.outbound.protection.outlook.com [40.107.6.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683A4166994;
        Tue, 25 Oct 2022 07:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLsAwnoiM9JkZOZaWVKCazH33QK00I7Iboy/7UIN15lYTpOSx1ia50LrbxccokNGqLyGAyoOHTkdHurXfd8ctNUfShz1/TyvCi+9cIF71AexNnjlUDoqMqpc8jxCQMgHaAJEzCgbb2r2dOH7bSpxMGSuitJkclt7zkyVlR8PWQBcvdtBYtw54BLKo/R82dCm/vvvAAL4njefPzUsL/PFFmLk4M5mS3J9UKonEfQ7YXJ1biLXW5g+jI+EKfc/oGAe0ulNuZp19xcu5kTZrX2hPoQ6n5FyQUV+LsAKULI796WcEDRn0G8/rUI2MavEyVqdJNNu2E7CBz9QAouzn5WiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLXjUErPRHjM0ZcFI8P0DubxZDqAH/cjLy4gavA5ajQ=;
 b=G0+JzqE3i0qRCn7Xcq+19kmLCpxRqt+GZ/O+MpEOcdd9DLhCGf7CSX6JDxsUAFeMgHylFkekhrLdRH49GwNuWOknyYN2Hp++hhGZGwtAN8gUgjXS0KiUTsb2t9eebEuf3RLcs+spVRSb99KxOpjmOUC+IF8GGvZkYFu9EU7ZSLxE6gFXyULPV03cQBN4/gdOqZt51nO0Inn+fkd6xqWfcyqb6/OBKouIXsmXxPPIumiQ4kLbvQPutqJnHDfuvTLD4OT6p7cjaYVW4gIbLpdQylNsKSH3N5Y3rqnBb3ESVIUKHNQ5KA4wtX7mY8gZH/qLvvp4RKS+Sbe5+XSOVnak5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLXjUErPRHjM0ZcFI8P0DubxZDqAH/cjLy4gavA5ajQ=;
 b=osmmiPUBO0FEnrp15Mfw5grUv7TAgncmFaLuZJ8PUUB0EN0gOkelnrhUE5Gldq88W/KZGvgL8GVPz9TnvPIDX/4ke+yUJzWQunj2UdJd7kt7txeCvHd0irCPvbyH7aea3UAoo4M6sO4e9jOsagJYoW+LJjX3MMkfqu1QtDE6Deg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9055.eurprd04.prod.outlook.com (2603:10a6:150:1e::22)
 by AM9PR04MB8537.eurprd04.prod.outlook.com (2603:10a6:20b:434::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 14:41:57 +0000
Received: from GV1PR04MB9055.eurprd04.prod.outlook.com
 ([fe80::408d:4d9d:f80:620a]) by GV1PR04MB9055.eurprd04.prod.outlook.com
 ([fe80::408d:4d9d:f80:620a%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 14:41:57 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rmk+kernel@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/3] arm64: dts: ls1088a: specify clock frequencies for the MDIO controllers
Date:   Tue, 25 Oct 2022 17:41:16 +0300
Message-Id: <20221025144117.1010488-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025144117.1010488-1-ioana.ciornei@nxp.com>
References: <20221025144117.1010488-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0037.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::18) To GV1PR04MB9055.eurprd04.prod.outlook.com
 (2603:10a6:150:1e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9055:EE_|AM9PR04MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 89fe0d7d-99d2-43fa-63c9-08dab69710a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jHsRwQqxF2rIBS853IiAo2k2nIeR7d5cG20HwUXY+y2VzZul+41cQdE7NIiGzellb5Q0yCi/C4eJvCDndmHCOVgnakeyiBcZyUVZxMtrlWtdgNrXyRKiz1SfHxwDEZhpbKClVgUebsY4PUtOfWH5eFhMSW6kjljltFwUPUKNkALnWDYTv4yoGMqJVZTY3EIXlp3lObw39ebnGMjuGsGG77Y1Cx6q2egmqPpSaHsTWrI5QhbIEQtp/8m6sm4NjU3WBtM8d9WtvcIt7CklOWTgloTZvCemkIU0XmOEFu2F0hyQlYbP13Kox7iGlKc7Qd5S20B62xjrFYBGzOGux35ie9xfM+C0LyUZchdqYiyfENDU6UKLLcZOhPkdvw1Kf4f7H5McUTvjrQKFJ2mKEeWtexDe7CoYfv3jCnSF3vJzijaXfR+XkXKO1K2nsnsZShDsE9c3LDC19HN+u7r2eOhWH6h75WBxNEq8GvjIX2v4nFL05kLXSi5ZSFY4UIhBwKC56UGrXbimUhG7EYeXVYJwme3sv9vy1Q0cfASeVHQn5E6grQFjZ6PmPQTLLVBNR53X1YxiQmVq3sES9bX1Mmm5gdQAkuZioAWFXmU/uh7bByqVA9wxL28vY7qyPaxGm7Hgz5CkGjXLaZcHov7EXnixPQ5ZsVpTUUkQfvdJlJFHBIW7y5LKu9oIfRKFSrNf9D7gJDwTca+Aj9IbD+foik8iVoA+YDkAfF3EZMreyktPfryHOPTmYDdpew+lX3uypJSZ65PCIogRcrJjt11LIzriQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9055.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199015)(36756003)(66476007)(44832011)(2906002)(316002)(66946007)(41300700001)(4326008)(66556008)(8676002)(5660300002)(478600001)(6916009)(6486002)(8936002)(83380400001)(38350700002)(38100700002)(86362001)(6666004)(26005)(52116002)(6506007)(1076003)(186003)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uEHwJ5wq6gNQqZFbU0VnPUrDyO7FOKSOM8ltsAyqnKKxPNU6nEg0RIs8Cx7x?=
 =?us-ascii?Q?ODMRQEZBB4mmfDDzR3KkMR0fM202NikHc17CB9rI5+6aznpMVY/+yrMybu1R?=
 =?us-ascii?Q?hLviIo+EDXHj5l+5Yo0qfT1zPhd9/cIl+Z7dCcdnn1bt8SwkvqFU0CCkS6fr?=
 =?us-ascii?Q?FMHwINtJ3r8XY5o9htpatRkMDDNCznZxhGKrMzm50CZ8OpcwJJK1GNWPelS4?=
 =?us-ascii?Q?BbXtwQoHMypf2IoQESMHifgFseiN2v0dps58bbJvCIQd9mHdGLBmwV2UE4fk?=
 =?us-ascii?Q?kgwQQE5b5TsMqwLOOG6ydV/kU3fGksuXgM6dlJ1viBECg2Q5g8ajf3JM96+E?=
 =?us-ascii?Q?IKevNM86Wz/q9vsGnUm9/iF9MyAB4KqiPmTFcr01t1f18D+2aKJPx5L+0jbg?=
 =?us-ascii?Q?y4t9ewnQHupuRxJ3yBtC3j0bGxFJW/K7UOk4lXCJaLf7pURGEODcc4+HIl2D?=
 =?us-ascii?Q?Yimvp7IHfgtUe+uItF/WZsKFpSHjuUsVkTTlXrLb2NBLBsDYYtXSPqNhVt4X?=
 =?us-ascii?Q?cXb7mIynmaURFwcKIybLhdhsghZ6ePYGBAZlnQ/EP6eOIaUNiLGXd6ShOnr3?=
 =?us-ascii?Q?fVjEdqHu2qqwQfFMw3D+XqAUGk3pLM5mOh92v+1dzZMU1FeS5/1FSAM7xI9p?=
 =?us-ascii?Q?+zZ1jmsiZHW2V9olrvw01z/8ps/xf0YRARO7HDZHRdZtvs8maCCOIGq3GuEB?=
 =?us-ascii?Q?s5o/ZbHwJ4MeBbJgZs+I8fo5Eq1ISLSIvxI2YQSrFtAg0y+MeniH3KBc/1g+?=
 =?us-ascii?Q?ylLM6/i2KRUVFJZselnblP0o0YO17RkSZ/kkmBJCCKDN67qPhGU3fLCqQ2bD?=
 =?us-ascii?Q?ieqTbb2wNj2E6Hl36Ey08fkGbLMjzTLy7FP+2EO0NQvArI2YD/lBuffe/3FF?=
 =?us-ascii?Q?TnyOpd3RG85MA1fypT8J/Lg2oXkXD0OMxUN5BvpIaqhDi6/kJsFmCHEfHjq3?=
 =?us-ascii?Q?gYVemgT1htpjTIjKV/9Jq/IEYfp7X3vd+QESjFHo2t8fuq5fBZsWNq5SmrJ5?=
 =?us-ascii?Q?DhUFrV+nyUKoi+okUAdz9Q/oLtjjOJbdtt8bphrwIszIQWndtcHK7PxU/0q8?=
 =?us-ascii?Q?Y9vSsQv5aIKH4vKPPcLYVUALd7f3PQjE+1f/cNB7QtDabCNlcxNoxOXjKgdo?=
 =?us-ascii?Q?z1OZfMkXryOqNb9U13jBhwWtsAFM2KIzf+cd2AfklLKfYSgooVRY95fMbqW9?=
 =?us-ascii?Q?zJHN2KcaWzEJBD1/9EipSyXKuhOLNVuuuuUk+UOtk432LkoA81EFV3GM4DKU?=
 =?us-ascii?Q?QTBBfxPzmvh9DL2589QlnCqILTDUzR12m/26QR8TRI2etTElkE7yrGnfd4NZ?=
 =?us-ascii?Q?+cARlFDCwj92T3JgCPcUzgK2EZn2Gm2vxYsK4ttwu5rOa6k5EeYWRrno+QOR?=
 =?us-ascii?Q?uMEYdu6Zjw0aDVZpKPUOPuDJPz56O1EgHD7PkEo9OOTk8VCpBQxMWrD+T9Ji?=
 =?us-ascii?Q?tjGk0xhUg9SW96V0RpTnvR/Vhxq1hQjShj/d3akrTK63lTIY/rTAk2tAGwx5?=
 =?us-ascii?Q?iLOhN3hgy3mZI/0y1QD79uUjuzvIqWgtONs2ydbnJ8/X30LAkQOjyan+sQOK?=
 =?us-ascii?Q?L4YOMgf1IpGLDMgrFN1YTlek9w3uOdgWxPnbg/8O15+4QPrrf8nTaONYQETA?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fe0d7d-99d2-43fa-63c9-08dab69710a8
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9055.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 14:41:57.1366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLNsotBIv6fJRqveXbtSZpF1gvlN+7A4nu6iyyhlGdo93dq9elpaEmjUHLJ0m1JikwYhNPZwwa8eLO4IFj9lBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8537
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until now, the external MDIO controller frequency values relied
either on the default ones out of reset or on those setup by u-boot.
Let's just properly specify the MDC frequency in the DTS so that even
without u-boot's intervention Linux can drive the MDIO bus.

Fixes: bbe75af7b092 ("arm64: dts: ls1088a: add external MDIO device nodes")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 421d879013d7..260d045dbd9a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -779,6 +779,9 @@ emdio1: mdio@8b96000 {
 			little-endian;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			clock-frequency = <2500000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			status = "disabled";
 		};
 
@@ -788,6 +791,9 @@ emdio2: mdio@8b97000 {
 			little-endian;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			clock-frequency = <2500000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(1)>;
 			status = "disabled";
 		};
 
-- 
2.25.1

