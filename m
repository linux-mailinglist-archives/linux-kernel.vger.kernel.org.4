Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33644654B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbiLWCzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLWCzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:55:47 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9612C1134;
        Thu, 22 Dec 2022 18:55:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoRKw2G1xDmpTag8ltnNMpl/PhJuJ1Hd1Iq6pzOAy0FhR7c2Mqd4lHkhrR71xu5/JV8ouOkIm1I2SiLZ5w7rGzBsvzYqoW3ZTTIqE8WwWTS/B6mOOEeiUtTb0A0UuuM0LweU9dlwG6XCfEOo15izuV/8sI+u+HxMX5meKnb4mm9zsxdA9a/jJGRPMnurNHVoigym5QNkaAA0buqhC6+hiyg224dBoyo6UBkdU/6KCZsXg55oRbNpdimW2MegdXUsolXYlQspVJg0clgz+lUQuiF9im33dVlgBE8iYWJn+TIKs0LTkS7F8P6OjU/FVmuYBNaT4iKy34zq+la4F2rYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKH3AP+Cn+7UdSIKFoJgho0+OS7G8fwFIARkA6Iy2dw=;
 b=dH/ooLuHKzpYi6cJCX5RWIHpIceW0s878YG/82a5NTGqGUlqWzRH8wryTtIb/wg42HiU/p4k5SuW7UrJjP6uvb2CuxeXjBAsdnTKCznhnMYCYJY0aWuIH2OXDtRyOV0owfQ/zssCL2In39ElEkVuPUdrTsvkPnIFxz8QgjIocqK0p8Vwqu2PxCvgrC5WIeLv4gOyc3oYA1Hf0/SXpP0+Gt5KjAXyJ65b0beeZRr/aDj22lMEmKK+Dc/4hPmewDhhphwTPSxh4ACpecpv7MbpQ/Vw3+1hLYwhEjEXOrfWx8CGq+YJ9eb6oH/RlBKk0wGh5bbY3z9TJ5FJJe91iZUkmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKH3AP+Cn+7UdSIKFoJgho0+OS7G8fwFIARkA6Iy2dw=;
 b=Zbp9yE7fqfX0tf/t9zux3bNDWlLZybHBkH19BO6x7vbygW4qg70EI8YCu0QCNB/rgoFZmAGPPA+VI5dqJZNfDxi/fDG6rtRqrZIt/yregrBuAhzDKloqbSlrg/LeUe6pFre/nCtw3Xm8lPOKCrFpa5mcFJ2sLzEAEmnPt9L/Mnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Fri, 23 Dec
 2022 02:55:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973%5]) with mapi id 15.20.5944.013; Fri, 23 Dec 2022
 02:55:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/5] binding: imx8m: add IOMUXC GPR
Date:   Fri, 23 Dec 2022 10:56:58 +0800
Message-Id: <20221223025703.15784-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9642:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d60a63-e134-4318-91e9-08dae4912d46
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHQCL+6M2jE3SdRGDJdeVhvlWeq5/H6bfXHVU+Rw9+F7zhnyEgF3E9e0pHww28RP0ISXRproKAzwcLl9z6OMeLnj6kO3H7AaUuAWsh1LXtrVtaGTyJ0j3ESR9LKLA09boCau750wkykW36Z1lVLb7q1KI3h2WGHk9XyxniQmTSi2GQIxADRKCIJ47KBhIR0X2mwyEexFFYigxHTzYqfxgooDY8HUrRrCjKcprH865fT9b8CBJzCHj47WBF5+hNveutQBvchq6fgzAn7ky5aZU6R2z3Gq8kEosN2z+BuGEGSq3epKSY/dEcnvprs1c/dGnWVraXHthGnU+pdawWWowBJXEfhZodl2uTEXTyv1I6PX6rA4ODgz+gj47/X8HaKu1gj4a0D0fMjaTd4RijEU5HV2dI0ATTcFwcGq5VLIqh+B1TAs5+N7mFFEb2OuPOCQTT7QsWV+rGyxGLWArEUWBZ4wrQvO5m9kXKNlzM3PFxS5ulNJxitzcEnMvbDNHd/PHAukoUPx3IMuIIQ04Jxn50ubMkT355o7MCNFHdVyAzQkoJ6cN8Q/ETEnOwZmjbyB/z0Rw343gSJA1iC0rKHySkh1jyegCojtGfETdRgLt8vNAJ9831g1V+Ud3XiYo8kU4wKPiZ2LLnUkDKA9aAhOe5moQcUbUx7DyWWFeRVoDmJ8UJAGBxHfPhWSmXycNZ6Ft0deGNS08ZtdXpJI8GK1uHZSq9489eeKZRRkBqjrkV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199015)(6512007)(66556008)(8676002)(66946007)(4326008)(66476007)(6666004)(186003)(26005)(6506007)(2616005)(6486002)(1076003)(52116002)(478600001)(83380400001)(316002)(86362001)(41300700001)(4744005)(8936002)(5660300002)(38350700002)(2906002)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1/YauPsdoIAfHFTdBxNfote97+SkKSaJUTsqPZtTnkYS6tIbtiC45vgPled/?=
 =?us-ascii?Q?kd25v2k063lZoDdPTLOfJgQzxkAfnvnimhZHZtRmsl7lV2I1C9F3T4jRhmS5?=
 =?us-ascii?Q?830OfLRiDaWxYof/3Bqga73i5ydubwWW37fvkudVSd55GssgoJG9Q6VGbQyS?=
 =?us-ascii?Q?J2KMkfzPnbW9Mh5l2pEPXhI0ZAuKl8utKajiSVzhjBTKbnzVbpXZfXIZUtP6?=
 =?us-ascii?Q?FQdMHOjVipaVmGC35hDx9DYRrjNuhZdEtvim7MrEP4apNRacb8t8K5UAD8Rm?=
 =?us-ascii?Q?MCdhvoYIJ3wFW5HSInXbxyBICIB1865eZ9ma/9CBcI1mDPe00AMGuj4M+Pb5?=
 =?us-ascii?Q?l+6SDJ91ekT1tudBH3H/Ant4L5ctWJPjH2+R9KHkKasJQlb30EZ4B+UTqNwA?=
 =?us-ascii?Q?4KaPFWHe8Rdf1Vd2wx6RMxZDJLb8KMm1pduthRiDbUVPUunZfUiaONbDn6T+?=
 =?us-ascii?Q?DV75D6Rmw9on5kZxI+HSfsvqS2Q1d74Gje/dFII022XCESaVj4P4fE+Kvmz0?=
 =?us-ascii?Q?6tGpvTgeq4DbB3ohhlqX2ldHRU9dfKJrQNC8pW33UMDj7PMPF1EqgCZUTl9+?=
 =?us-ascii?Q?qOvxLOqNqjKMkkOaJ7ibai7J45suO9sUdfBn0gxZoOlHpjDcRRxO74owvzJE?=
 =?us-ascii?Q?Z49MLZvUh16V5i+uss/wlvA4Ansxdz0QY1OjLqz2PLiIYpyPL/+0o2NqoiTr?=
 =?us-ascii?Q?+XLiYqsjbZy1WOxsoxWkg/WS0Y30hzE9nFMVb7ntuPyQLozyxsV1GaS3EUdo?=
 =?us-ascii?Q?lucdSc7X01RBn0yw2hBmUJTqbraXQjm5vZVvPCtlKD9IB69IiBJ+Xf3Nwc5Z?=
 =?us-ascii?Q?NEqBaIEUVDyrdydyOUHmbZNvDlyvLCmPwu+HzzM0JZPBcHBqEL4XLvLi20FG?=
 =?us-ascii?Q?foVVDLi07RVSdSXPBaHB3C4YtyMao48CRdOQ35bXjLldOEnllhlDbU7tjVF1?=
 =?us-ascii?Q?afEzK6jUnhaO1U3kjxcH2Uh3NebaS0kHUJPaU/2qCzjBGg+ac4MwxTVVr3OO?=
 =?us-ascii?Q?H3FIl1KOj8ri5ZtuHJw+ztor0vQn9CkBJ0HgA12WfJSlHksoUoT5b+1VEFEg?=
 =?us-ascii?Q?WC4uHVHoeRuzHjxwexXhn96TWVSNYPxRDkAgWmFJxspjiHpSxqbWTWtFZOqS?=
 =?us-ascii?Q?9uWrlnvuJ5mIdLwfxl5fPkD0KpH4prhoEPDJJHYErA5IJ0zharZP4xfqkmIz?=
 =?us-ascii?Q?i7sI16d2CsMxBoPopHW0iMNDaz9uiRIOKPzqWBXPo4yd14EYWrsKN9ZgsFNC?=
 =?us-ascii?Q?52NPD/IogU1E8WOCztYGAKOT7cBdmifhPA9TLkt+FgyI6Y81A7t8oB1TgYCl?=
 =?us-ascii?Q?hJx9OQ+JUczCBoHATf25Q4yTpL9cFaJptbnT77+Vx+YzzSb8vFjMciTyaLBL?=
 =?us-ascii?Q?6to9bBDBjrPvj/8/96nWH3BsNN/XkaKQ19xSPYY5GDHODLdYPTKhRQVwd4JG?=
 =?us-ascii?Q?NnPUOHdHvdh5nl1dVzI1LVlfWtkT/zb6oCcEzeriT1x8UaTrkf1UigxOH/dx?=
 =?us-ascii?Q?qfpYPhMbJoDetL7MzoGNZ+CdopR/z/IKAXdt9m05Zm0b8aFRHK0PkrXNkS9A?=
 =?us-ascii?Q?CegViGs6FnTjERjl8Kp5UEg/zviQfWmtdEQ+1a53?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d60a63-e134-4318-91e9-08dae4912d46
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 02:55:41.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LbD2ZahToozoQPflwaEWKXdVGgNpRpdwPXaT7EOizZ9x1L831Yj258pz0JzI48T8nVimJb8iBGODCASuAsrQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9642
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add binding doc for i.MX8M, update dts to match binding doc.
This is effort for ARM System-Ready 2.0 certification

Peng Fan (5):
  dt-bindings: soc: imx: add IOMUXC GPR support
  arm64: dts: imx8mq: correct iomuxc-gpr compatible
  arm64: dts: imx8mm: correct iomuxc-gpr compatible
  arm64: dts: imx8mn: update iomuxc-gpr node name
  arm64: dts: imx8mp: use syscon for iomuxc-gpr

 .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml  | 57 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  3 +-
 5 files changed, 61 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml

-- 
2.37.1

