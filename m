Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D0160CF60
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiJYOmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiJYOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:42:02 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60048.outbound.protection.outlook.com [40.107.6.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3D25B9E3;
        Tue, 25 Oct 2022 07:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xf7AiOLJ8jYjO7iV1P1hQUK1u0ie2SCt8ZEQo0Ai9wusfvjC7LY7pxjibsR2P0xcf05C6DLin/WlZKnepBWSI0BMkdC6Dyo8/QPovkI5UvzPwjH4hZL7UWOMKrrfacBPwE7z9ncynDkYIH8bjZSkTYbiVpKcNucMzihmLOkCJXYuL5LPyBdLNDFy/VikaNOv0L5RcsIHK27itoFuhqZ2t/Ipr1Y4b89BiC4TbCpAAHDEs47q8X2IIm9KIFLpAXHcHUeuYaJzWM6tvvQMdzPYF6fMcg4Y0MC+e+4E51nyYYRLaehXAUVQpyEUjS9oyabpsO+YOSH4v9HA9QwMP7TD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iU60gVLQqnkvNQrBmIncIn21iTCInA34mB5HJc3zexw=;
 b=UDXjOLik+c+QAZfJQEPmJS9teJ6WzvXsflAaCHSiE7DvIxi+rOSOujjBPgrxlVRbuah7pu+9OdTe0q9+eMRnCEoCd5J6fd7HGqaJy4weGV/71Qn0S4CVr9xerY6p4YTaBT6vrZC9n6IjVOQ3rNZh3gjEblC2EMfdfUEJEm/qJGqVQkTMES6hCBjDwr4xjLBCSZdrWqlogKZsKCYgQkFGXDjHfoszxVqSPMC2hwRlrf9iEZ67L3g+1S01K7asy7rGBTnHrMnBY9bSWuvx9c618+bGU+gfedPggFsralIqVPc9EfdE5DeR8p8cr1dlMpnw1gAiKrWI2nNSw0qzNlAIzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iU60gVLQqnkvNQrBmIncIn21iTCInA34mB5HJc3zexw=;
 b=OvFbcutCj28jR0sRT3bQPNu65pkgLG5L1a5RFBScS6/aqfKzZwx+9H4vsvn/U/xmiNus96wL8zWHS+KMBBakY99umCRAQF4KxREpbRW2dhObh6SUw23RvwLY13zIDJtBScobG2zelrJ2f+LN9YWlBqqLV+spWX15jkn8fLjdFBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9055.eurprd04.prod.outlook.com (2603:10a6:150:1e::22)
 by AM9PR04MB8537.eurprd04.prod.outlook.com (2603:10a6:20b:434::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 14:41:59 +0000
Received: from GV1PR04MB9055.eurprd04.prod.outlook.com
 ([fe80::408d:4d9d:f80:620a]) by GV1PR04MB9055.eurprd04.prod.outlook.com
 ([fe80::408d:4d9d:f80:620a%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 14:41:59 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rmk+kernel@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 3/3] arm64: dts: ls208xa: specify clock frequencies for the MDIO controllers
Date:   Tue, 25 Oct 2022 17:41:17 +0300
Message-Id: <20221025144117.1010488-4-ioana.ciornei@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6c0f7845-e00d-45be-ffac-08dab69711e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nU04mfAT2Gplw4h3TsBW9dV14tAWk6xFmxh1gvyVG10TZA7WqEyuABKj+xZU4JQlbKdyGn0Gk6w/t2f1RGMo8deWBdAvCjBYWA9AbD5pAEjPcqk6LdN6gp40r8gSuJppt8/rDtVU9mo2vDwb1iEjde6z4rrsXECizDcyAw+c0X2C7Et+6orjLszfDt4H+34jMGXQtaM7wTdnQx+6zCo9ElGxJUATFoGHN027dC2ZvaxsF4K45Wm1kR0DZvsZZWrXjvDpdcoRDnbfWIEsLyNvt8mu3pKHpcB+kIxroK3awgPpUziaVucwDnF+wGCbHFPLsiECOQ1u4CeHMc7yZFyD+Y1+v3PzLQepTK43mKSlBlROkQ70EMAAzGTqB2KPmOgVgHfErh0UDkd4ZK3HctE8/kF/VJyrOhmzltOY5hMtS84FVbf+W/edCdFnjP+I+Cbp1WgVhJ9m96rh93Dajkh1s1KHuf1bGBp5mcL2je+itrtZtoVi2z1M/C542O1XgeCSxa4LHyCAIIwNKGyWbU6gsX/udVlKWMbW8vzj/06PdlbH0lPk63aJ+GeQKmFBflrRoxUFxOBEqSYMqcK0jrM7OIQ0EpREro3E+9mvVDpnwe9XHq4CtOqZwohlYzxENuPuUsUemgcSdrD0mjF70ng1K2/9mWi4y6QY8P8PnleJOLMykoolPfrb2MprwP1XdPbUCTnY+qfG29UeVoZME8jqfhG6rzKRwE90gLYknKeXhvG2UyhRhjNBDpqAOnHB3vIq+HMyzN1O360imSQSemgKxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9055.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199015)(36756003)(66476007)(44832011)(2906002)(316002)(66946007)(41300700001)(4326008)(66556008)(8676002)(5660300002)(478600001)(6916009)(6486002)(8936002)(83380400001)(38350700002)(38100700002)(86362001)(6666004)(26005)(52116002)(6506007)(1076003)(186003)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?luoDm3ULxydKJ0O/3OdJXe1PsKj0P5/uCbDwYV4OpUVkS3HcqUmIB04E895w?=
 =?us-ascii?Q?S2xSGC4FIjYSKIEnSn4kk3Lfwaobv8ZTJ3Md0pokE6YlsDT+EiHCKTbyvdSg?=
 =?us-ascii?Q?iu0VOF6HVhpACwRVyvP6aNFnYwmqn+TPkaIz+6E5PyX6SIRledgAAINUMv6s?=
 =?us-ascii?Q?j42Tntn6BLG99ynZ0CCS3yhTN6Bi8akuQ5klHqP0kmJkohRi22rwaKioLiU0?=
 =?us-ascii?Q?4Jt96S9aDnHY4BjneDfKkL6adw5n7nO95KOo1Dfg79spS6VDhmwUxSdgWDki?=
 =?us-ascii?Q?zUwszsDFSjYhQ/gO/A1bvSLClkuLxdnjGKtKXBbclO3Ts4jqGnNCOlOwfL8l?=
 =?us-ascii?Q?Jn2K4PgYn42Oes7ItCmSZVzNZ2ghnGxvvSIkbnFJbGeT5otd2trtbSHzZRSf?=
 =?us-ascii?Q?+QpUl1X6h4pJ5rgZz1+QWQjGN4SY6QYF1WA4BsUarNRKb0tONwlv7zOIO9u0?=
 =?us-ascii?Q?Sev3/YiJ9psU/ls2XpfMa+lf+1QmKhi6TmcauhtYZF+rOcf44OgXpb4Nc47u?=
 =?us-ascii?Q?wtT+LSx9FvEHruscjWv4NXwgfvYjtfhM4RJ5dTTjAE2Ursm/Zj3hYjhTZTwm?=
 =?us-ascii?Q?llSyLohBgdnb1J+EBcxnQMg7KsdEEf3XOPGjKdl7H+jgyXuarLxUR8Jd9TCs?=
 =?us-ascii?Q?HfNV/QF1g/cbpReJQfTsljUDZ+QO4kP2LfK7T9kBzIQ3jPkCilFmXZnKaGaO?=
 =?us-ascii?Q?BQ4LAlkx6RJ7wZlZdUF9vBLbAsWQMcX91fP7WmD6dN74MTMQaPXKyG4pFkU8?=
 =?us-ascii?Q?JqPe7iiSYWm/Yuf6EIj7JYLvEhS2Sa9e/QE2OD7eppjYYVAX1Kb2WxlpMrY+?=
 =?us-ascii?Q?hQKJBzyB8l5QlW+lwHU/nq1vsE/qYtVtkBEB6Xpifc+4a4Rdt7tVBekuYp7N?=
 =?us-ascii?Q?MRlqE5hi3U9tLv3rbv1Hi8iHXevOTy5vSEvXUz1ZPynUQXNIOTG11U1oOagz?=
 =?us-ascii?Q?7/My0w4nguSxAEjTgqwgFm10gIFXAQ6l8ILdQQfuulgAnlC9uXmuO/Io/PFD?=
 =?us-ascii?Q?IgBIDR8ywhUEfrIj+/ytLNM6fk9eUBRLSO11eze/lxkAV2yBJvGAqIrBH3RO?=
 =?us-ascii?Q?V+qLFE3d/7ovnFumR0FXkilbshArB42sJS5CQHDrNgu24lS4NjlDaZT44ozP?=
 =?us-ascii?Q?ZuRy4iWFkgxy98h3BNaGRcxA78Gp0k78ol3a/4BeIcLLt/FuXwK3L5e1nNHA?=
 =?us-ascii?Q?tHvYx3IqS5IBAWAF8TrNhwubT3qKf3uCrpGoSRWm/MdWEsYWDFzPCd40iSco?=
 =?us-ascii?Q?07YgUKYoVm1ILH6fiDid/p8J9l46B7aOFJ8svm23flUOgOSw8YYYesuSxCXk?=
 =?us-ascii?Q?zfx1YDUDjbcyxYe8Ftr2Qd41UPHIxxFDqenFc+luROEdZSHvtNAH4lTQgtr4?=
 =?us-ascii?Q?evgOGuatlWnWixUD9hYM8erZmXqyuFFGts6iae35XFIKabv3NitPENnFI7O/?=
 =?us-ascii?Q?We8T6Dq+vJ1DumLQojNIY4FPSX7xCWj1KP+nmdWDU+VmFU06q+SEaxf5OJQf?=
 =?us-ascii?Q?62NmAyqJd/I/h9ZAOlZuHvlKW568aSi2+gvY0t+jSqQdumnAXVyXXMMAUigk?=
 =?us-ascii?Q?HnUYVarynxr3glBqOuoST1/P7enOJ210UDuBHOuVi5bGOzaVpuFe/LSrJuWS?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0f7845-e00d-45be-ffac-08dab69711e7
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9055.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 14:41:59.0437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCbDutDjJZD9JcMeBPZ3iwcpjfiLPSln8wvrjOyLzt90j462/ubY/2wTvHkYz+Qo1XvexE6tSQyYgGeM8p7XCA==
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

Fixes: 0420dde30a90 ("arm64: dts: ls208xa: add the external MDIO nodes")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index f1b9cc8714dc..348d9e3a9125 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -532,6 +532,9 @@ emdio1: mdio@8b96000 {
 			little-endian;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			clock-frequency = <2500000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			status = "disabled";
 		};
 
@@ -541,6 +544,9 @@ emdio2: mdio@8b97000 {
 			little-endian;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			clock-frequency = <2500000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			status = "disabled";
 		};
 
-- 
2.25.1

