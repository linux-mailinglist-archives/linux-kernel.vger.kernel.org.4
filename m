Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AC65E7524
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiIWHsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIWHsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:48:17 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F257AC16;
        Fri, 23 Sep 2022 00:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLencc+zdRWmfPmA5TA8JhWl/C25cx08YCPbcuwKAsqITau4qoVerpBA5FnXxiPwzSfWaUKH/NsmSy70uNrTcjmU6yD+ma2jdYW+coMefZ3ZF/p721n9YRjUZ+LKU/eNxfb8Lh+KpP5nEZKi38ek56oPd+X1mq7cKKdZRxmALF3LcY0eJathwMGH1f3LMOe9NogRhECyZ99xtIeTfowB37Q3jj9K0XUsJHU3pu6qGg3M7wJ4M3xJ4UM3Wz8CbcAh4sOmpKPRt/4YKqJ+bv1ltF8WEvHqYWLA4QQkc7JMlq6LvUrH+9QFH/Wpnn7zp9YtiajwxiXykAsfuA91uVKYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYS52H5B+AJvYV5ma3ZyICzUL2m/mT3W346klMC2gCc=;
 b=UzMTOXPmTPHHQTpcVLW7LO9irrg9hA+0WSGR9udQfgxbFCcSTp/It/2gZDv2xDRwqLSFK7mkgdDUgmlRGrVw+s7lrcXb0XHanpOX/aOH51WfKluzYm4Heh5+3HxiznkQmKjS9vS9LgFgJbi4nKrqxZ47f/IeNePdtghIfX45xmu34zoABKqIAebZIC03FRiuQdc07I5CKYvivqt2KTh3V/r3MdUH+S/Hz/ecFZqRITQLpAv/HAmR25DYd5kh+SYo03tFuMOv4hMHGDwa4v1yPI0f4lSydvW6GDSa4rrLQ56N/Oq6ijD+ySGllx3u27r8/bJTJBRNNusmDcRpRspDRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYS52H5B+AJvYV5ma3ZyICzUL2m/mT3W346klMC2gCc=;
 b=kmePl0nLbzOk0Pwx3UHYWuVNhIER4e8iL3PSh+Xoj++pSe2Og9Le6V2PqeMoxv+dDAK58WDCLEYUywBBflFxHBzYxVBZTCK7OuVhte+9FAUJQzJH7K1aDF6EwE5PGEw16VnFKljIO62s1scgqyMHIOb+iJrUNsb3HSpuLniO8gg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7203.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 07:48:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.018; Fri, 23 Sep 2022
 07:48:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, sboyd@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 0/2] add anatop bindings and correct dts node
Date:   Fri, 23 Sep 2022 15:49:41 +0800
Message-Id: <20220923074943.981127-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 0417b3e3-7fe8-404f-d4a0-08da9d37f74f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XGgfGzt9xZDWXtF7QwCv8uKosJxWPlRk0FIQo4LBhgMGUM5/x2E1UlKXjpXgbm4T+GXn0ZvM9Z2dhgbJ41EweaOzmdZ4YoN89XRHotyCTuPcvkshyc1jaX/M9IGbYxg1XuM1IUau7CmqfNgeAIxETcEGRjPW5QTjjGvwEuiKi2l0r0WTWT0BUrkYeOIaIe2pHzMNILWQkP8nEMYrEXbF7hldQxEZJq2BJLz2tPySK6C9jX3ibdnPiJkJrUbt6532seiH5S0NaRb1M2HAESwnqCEdYXGVirFds/dS6Na2kaca4gLshYsOpJXv7vSKPoyvPAXh7PwUXtzwkHZu6i/fWYovZd8+iO/a85lBdMcLF8Nv/h6X3X9Opl60ix2zJZfo4vPouReduV2ZY0c10ORXoxFaRztuEI0ra7NqxzAOkSml1fOgxg9LJb+1vFr13U2YsthfVdXSHTq87iFtOSSjElyryeyZv1Zmsn1jMcF+reFA/kGmKcrnucKT8sjHn4VADGbuR62yehQQOnshVrrltP6uXrR//lgvZQonOb9+/65VmtGHfxCgIUkaiyomR+YdzPm/Aw+I9Ptfi9DTZVSQzAAyw3vhxPhgci0/FjmE2jhnZbgMuEYOYJ9NBYBFcYbBhfwbMP3LRk7RNEYFxFZYF2HyaKK9VsqljNbS1tXMxJzjttCv/pLHkM/OpbIeiRp59eYxoCY2NA2+dAYWH8V0m2I2ofvdEgGEBpfnEPWX8V3dxs7fXVWGWPtT2s2TisFjWNNVHUxrggMT+OzcfjRlgyLLkAQyZJtSrONyiCO1kU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199015)(2616005)(186003)(1076003)(41300700001)(6512007)(26005)(2906002)(52116002)(6506007)(4744005)(5660300002)(7416002)(8936002)(6666004)(38350700002)(38100700002)(86362001)(83380400001)(966005)(6486002)(478600001)(316002)(4326008)(8676002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f82OXu9WEBAhDEHlsoG2z0wzUNlEcq1tu6g/9rKDWaP+MYdEWnUjiZ5oBnZR?=
 =?us-ascii?Q?zj+yzzaqOBnhhxhIwVJ07jViUTx8c0gww4JoflsAbGJttrWfFN0qay3Tf/j7?=
 =?us-ascii?Q?0HXzW2xeqThFCQsbktg8gv5JS7bFowF3+YhWPxtRpuYJQkQg8owJlUu+LLXU?=
 =?us-ascii?Q?/BkrIq3u4CdiRWcL8K+6yLU2HTwko/eblWJvEadQW5uxYrcdbVzHlVCTD7A+?=
 =?us-ascii?Q?TckthfMKMNWKQ2j2U3wQHB0zYhcIl+RUOgi+DZk7tPiEvaKHVAc8KYgYv+gP?=
 =?us-ascii?Q?EsOkPqtwCNM4XP8xUP3/wA9jKwquHFzlLt0G1NFjRXpvJM2eaAiktUGcmaIH?=
 =?us-ascii?Q?aXZoN1T+/aq8EW0sbbIN+oV0ce5Z5VZe2+gtq3Wagfu1p1F/rsKsLhvBeqhh?=
 =?us-ascii?Q?NclgueUN8UmT3/4qaUBkUg3DC1kXGC038+hEuNgM9GUclFNQfJHWvtjveJkR?=
 =?us-ascii?Q?x9LOBC/OBllO8LGqyNxgBzIhkgnOtiWC8qxMR6E22WcVi6Z2iuOqb8IY5Vw/?=
 =?us-ascii?Q?Dtp8vGosLbw2SaZfPERLQpOJRStrSmbyvdllnJJJfXiBHJrFQBqXRjsSuFH7?=
 =?us-ascii?Q?I0uhFvR9FdPY0JYA9Hz1OE212XYriU/TwJwYpm1wbp4TBFrRg5bl1xH5W2kP?=
 =?us-ascii?Q?EAG5OrZQLTTmB2fZH3HwL4GLnYPyswdKIq6X0kg2rvyvYGJdCR/SGJp71fcZ?=
 =?us-ascii?Q?8wy0ziq+AE+d6isGEiF6AZH5JqrDQjAafRPTK7NuXilOW4NF0XLqC/hxnGB7?=
 =?us-ascii?Q?CjnYefKpvVwfVHIaleiVLsyoA9y60VbtTTa/RRnm5k3d+BNvFjULBx7ZNGnV?=
 =?us-ascii?Q?OBovMxGm1Ile4RfCDrvPexGDoCieuinOOx081cJexEDtUnV8UB9Y+vrUNpIK?=
 =?us-ascii?Q?IDbbRDV197PzPOQYapiq8HUhzdcg5bCPDB79RaEGTWqoAenu7cfvmlzZF5AT?=
 =?us-ascii?Q?2i4o9vjgiIsj+z0Soqhad2c0WcC5FH8DHRWi9nbSDq8hcE4J5r7S4QalC82R?=
 =?us-ascii?Q?zKDmFec4dTNLGHI+lUjJnU8i/aoHebElT6j0SSr6pUhhNyJyrdZyqLHUY+SO?=
 =?us-ascii?Q?b871zhVBHOv3siVhmeSuBvAhIwoAFIJR3dyHH65TPrDajj/mtq5y0tJz2r01?=
 =?us-ascii?Q?bHuQbAt3NqsT+1i6psmFUI8++NVkA0iKumZ2ETcorIXDWNf4H81/kY1p26QD?=
 =?us-ascii?Q?lbM/3irqm+WSip1waoHj+27Zah1iL2wWP4p5CZo+EztSbhxsysljYRh1cX6v?=
 =?us-ascii?Q?j2Fsa589ShPT3SgdoogaFRLBpiPGZVPXd8SW5IH65qe61xvABqh22e+x0W8J?=
 =?us-ascii?Q?DrRXOSHR3xq5C+M/Pz3/2TaPDIfJyI6bVgMROHC8b5tq+GtdcgfmSxuff6Up?=
 =?us-ascii?Q?ztgMxf0f+B49M3OtO2NOR9vv8PkVLzf0zL89loOVxZh4PKR0R0If6MyifLEN?=
 =?us-ascii?Q?ESnwRIe2Flao2gN+oUtL33aGl98drorWaCpVQ/KYfOHW8fTdw4PKWSocQG4h?=
 =?us-ascii?Q?V2DKxROluRM817pmS9tic1xkmoHUt6J8367eQXYnaxxFzLfs2sat0c8Vpi5c?=
 =?us-ascii?Q?lwYEC+ICL7Pjm0yh1job8Pen9s3i8CMjRbd/aWbc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0417b3e3-7fe8-404f-d4a0-08da9d37f74f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 07:48:12.9144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vlz8UtMnptzeL4VdAfkadANR9ilzw6GauqpraVLzhBelD0cjB/QIzlbCowWBO4g98+SCgLOWFNEsWgYh2yORiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7203
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V4:
 Add R-b from DT maintainer
 Include dts change

V3:
https://lore.kernel.org/linux-arm-kernel/20220919055904.1659124-1-peng.fa
n@oss.nxp.com/t/
 Add #clock-cells property

V2:
 Drop syscon, use clock-controller
 Add fsl vendor prefix
 Add interrupt property

Peng Fan (2):
  dt-bindings: clock: add i.MX8M Anatop
  arm64: dts: imx8m: align anatop with bindings

 .../bindings/clock/fsl,imx8m-anatop.yaml      | 51 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  5 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |  6 +--
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  6 +--
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  5 +-
 5 files changed, 63 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml

-- 
2.37.1

