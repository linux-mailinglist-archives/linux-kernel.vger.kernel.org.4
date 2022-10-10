Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A4D5F9C83
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiJJKQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiJJKQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:16:49 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A033647D7;
        Mon, 10 Oct 2022 03:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESh4l4qDkivBYzj4HoHStqj59wcOxpb8Q8be9sX4M2oDMYJ63H2hEF2SWon0UsRw5zSdtrX+IR8PzbCzD6H9ch35u0vtjhwjp96ia818khm3XFy4q1zPJZjLATyt1lsL4FXclIO+dv0hnhBxre/fD/PRKbQr4ml1vyBbUVGYRGuGO0mIMxeibBPqjDgduhXSRdQubpyS4AbsZTZvQVIylm/+9f7Vi7mFEkMGg9f9eli5/joJ3IOkjQPpRAI/t8yPHx4rosMaLhK9Awxpc6VABdwofyOlK0RsqH7X80ToomzBv2N09Jhg0DZ0EevCSICtKdHKZ0T1twd9FpDuclCKrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Orz9H0ebOXK6z0jF8SeTGwTppiAHPtpEiDdhcxVn/A=;
 b=Mc76dgqzSJr7OQMooXTb8pV4vUnJ0d5I+Wylkz16eXlar0bwPNrKTxLb4LK3gnU5ghhJEYhasTB1aXY4qyiubFieD6TuQms83XcJZDNbEfl7y3Ysbe70oKh3n+8eJMJsvT/CxZl0jfW8ZXLxW9EIJBUoBRsyPguPUPBnBN2l0reCQ6xzq7/YnzjSkTi3415PefrPSsJYKAe6PweQKrTqZlujGxlu3P3pRCXeQSY7gC+KCt9+eE/8paEu3iE9d+bI22Ov61AQDUDnl6Um8+7svxV4YU88usIAeCRYjo/LfLKOiiJetPFdIwblkppYNBl8TipByuP7gD+3cm+HFomWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Orz9H0ebOXK6z0jF8SeTGwTppiAHPtpEiDdhcxVn/A=;
 b=WU/k1j1G9nkOf21pJr0nRI7NOqqUFA4oQzLKWWugTPtQghF4ewjFKIRPFdXBCebSZas9Hdy5rES0hUKDoboPME0vTOup5ya+ytSnb6u/4Qkbx3E3K2lEExuQ80nskHjPqY6RoK7utWUDjpNTxZpMj4aKooXH85CaAkI8CB68V5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7783.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 10:16:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Mon, 10 Oct 2022
 10:16:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/6] dt-bindings: usb: covert ci-hdrc-usb2/usbmisc-imx to yaml
Date:   Mon, 10 Oct 2022 18:18:10 +0800
Message-Id: <20221010101816.298334-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0048.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea53ccc-f21c-4849-f267-08daaaa88816
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oU0RVnqQLdfNLOZuZavCjJjp8VYOZndlHfnaJq2a/ivVNY/PCIoLAQCbhQ98cAXzicpBtkEefxl0uNTuLl44l4KipOzAEMpZFJ+AHBDuiMGH6f1yAhnpGsMqaf2TDwFTNBQvJBDpJEdGcNk6RcCPdzyPnU2RoSFODVIef4N9kZVF3V4jWR1Oua3mGCMoGA2LGanD496NzAa0vEpd/TRq2oQMBZO8+f7qCNMoP0d1wojIXv/zExFSybPCOPzr6MncyBYz1XCJ6RBX0gTbmhpbfKSJKx0OPcH7eUJ3bnV3MCL6wQgdvvR41mF3amF/PK9JSqbynYQ3OXqn/t9lU/w9P3ELCyHhrj0nh/U6OFtmyhMY54LHG/WjD6BlG9Q/n6hz+VASXRLB8fuGpsox+YrZos1ORsRpdg7O9mr6STnq/EKElXEvRFmpiaCkumWgQO5BScGHxqRiNp1mxAWdNFAU7OfHQFnJPrxZViDsO3zwDhxT+DDKjWErVESHHZT0bLNj2TATPovbee49YGj6PBChC66E60WHhO+DYBrFHmNisq7bBGZZSObrX2U90hoSlJzCqmT1lARQbLzsuIgTzLPV6DXMu22prak4OP2bDiybLUeB8EzWzIlUb/JNpRFcs9wxz5/6JefX3sKjrtGIMLNU7K23WYyf9XZNjH6wGEkiGaynUmVMJtY/09gN944KfqlUQru8afInx68CO/AlP9csFBd0L0OjBJxAzExVVXdzwnQvt6RO/588JZ/cUooIzVU90TVEzdAYeCxu7wbthcOu9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199015)(316002)(7416002)(2906002)(6486002)(186003)(1076003)(2616005)(66476007)(41300700001)(6666004)(66946007)(83380400001)(66556008)(478600001)(8936002)(8676002)(4326008)(5660300002)(26005)(6506007)(52116002)(86362001)(38100700002)(6512007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oiY6BGKDafm1zGRTCyOezRLauvEO/91vQV/rPntllxVzhhQTUazMrYJ+HGi4?=
 =?us-ascii?Q?ROLOmBiiNx9G28R9k4zSDmLyGOMSwQKHvRJDalDoKjdMh0jxKEtHmyiQgW2e?=
 =?us-ascii?Q?fGNSgDjIiRQsFATOGaUXj1HYNa/xmfNUoKHVeaFVKn0loV3WBKDgr/vvI2G1?=
 =?us-ascii?Q?gwnWDnd38RqcbTGB40igVNPC6Gze31BQClBSfr8QCdq7Ai9hnJp2LEj3JHRC?=
 =?us-ascii?Q?z26sMciCQyNzjC8/DCooc+9MwjpPZ2+WROhDOW0JDjqejTuMNZFhmiA/NtyK?=
 =?us-ascii?Q?rm3wXE2+gMoa4kZ2mRvm9mv3J95gqNek2VX7ZgWoyx79iwCFDdHYsCAhLt6/?=
 =?us-ascii?Q?znn/ZNRwtZCbCJclBC8zPwwJRD6Msh39e7dDLMBraXHhMC9qKgLLpjMJNFKY?=
 =?us-ascii?Q?Mn5ZKePUk7rfd6MxDj3J+iuVLh+cHSqDh+54VyPZjTMidPHmShpAjVK6npnG?=
 =?us-ascii?Q?99sE3EhraTeNHU1zF/Z+wXZ/v+uNcbgvdI28rNOgZ2vj+ttKH3FemzIWp+zr?=
 =?us-ascii?Q?P+LdNLt3qRK30yfdohNrmoL6fGLo7wtyPLZhjKw7gBZ6KiKwbkwcZlebKrsZ?=
 =?us-ascii?Q?Cj2fZXUwz0+qjW1ySLlT1KIYj0mG+9w8ej42xkhSBqkRLNA0IWSJXaDug54p?=
 =?us-ascii?Q?SVod+AZOQyFXWemu8vfXB0ktXIn8PyGxNo1c4lfAjyXzPeJYJiKUMhuFDgCC?=
 =?us-ascii?Q?1lzh6vkZXaYvh2PzAZpquFrCjUm9ghvvRnSM+LQd1n/Fw0UMMTgJ3t18+0HN?=
 =?us-ascii?Q?1c5ReKKWc76U3Co/MOWhlpfO6TvpnrOqsjEQFMkovOxD5HW6gRzMvIGW7M9K?=
 =?us-ascii?Q?HGHZT3/wtez/wWTKO35w1H4A7tgvp12SY8oi9+jJNC8ZCWJxgjfcsyCmZUUG?=
 =?us-ascii?Q?xMo2uQAZb2P4jMIgQzn7PBEOnhYTOqpWAL95zCVA3+Cx8ICtGhVQxl0ORG0g?=
 =?us-ascii?Q?xp+NY4znQp9rvrvQ3OU7HnfEJESFTdDpo7l7QwXLRviWzkrGamX9CUW2c79F?=
 =?us-ascii?Q?bAH5qrRWPRwdDwUzqNeDLKoA9aw34B8S+BOE8I4hB4+CkV6rBejfrWaIJuHj?=
 =?us-ascii?Q?nurWjAHrE0HyRV4PDHJGsx/9Dhn+cuiRAyWK1vL1mFSGxjCTyG73AAQCrSqH?=
 =?us-ascii?Q?MJwWtxnSfOzPEoefHg/W7325i6Mqo0lZUTcoJxDni0CK4ORnnJu3khh6VwXW?=
 =?us-ascii?Q?ohDz3J7mmKE6Q39qwogxFfyYJKWKFBDDgNHFT3i0VZzLNK8qLYKbTqWTMeR5?=
 =?us-ascii?Q?KhXX6ovn0ygiBlDZPp4z/mbU4ZGO0A9Q+QCpr7TABxEJ+mQSb7N8GJEFUuqf?=
 =?us-ascii?Q?VkuJAVA1YyzjX6cASmGcY9bKD+T3wObPF5bkMpy1A1nyZrN7zKcllP5IXKaY?=
 =?us-ascii?Q?xJ3AjRQ/nqL0XAoAlgjmIh1leChADSB1P+y9nkHJ4dOkqJmUWUFSoxk85jle?=
 =?us-ascii?Q?pBM0qEbizL8U4LgIE6W4LIrpsToXHwJIULgmOnT0JEM64+H7mqgwMLE842pw?=
 =?us-ascii?Q?cjflOKe2u7O1ykK3X+1xvy8AnNK6rbFQN0JMOLIdjWOa1QTu4/OU1smHWta/?=
 =?us-ascii?Q?ZP+ciKzz1R/OHiP8nT/CfbnRv4HTdtrsn19+ntQT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea53ccc-f21c-4849-f267-08daaaa88816
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 10:16:44.3291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5NM6kX/4UpLqzZinZCmYwdJJZps1AyBtC0zj1HI5VGerysd9jEA8XokhTfq5scgOQ0E8xYF6FVeiMSV9Ycpkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7783
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This patchset is to convert ci-hdrc-usb2 and usbmisc-imx to yaml format.
There are compatible strings not landed in binding doc, but in device tree,
so run dtbs_check on the single yaml convertion patch will report
dtbs_check failure. If apply the whole patchset, there will be no failure.

I put Greg as maintainer of the yaml file, because I not sure who should
be put there.

Peng Fan (6):
  dt-bindings: usb: ci-hdrc-usb2: convert to yaml
  dt-bindings: usb: ci-hdrc-usb2: add i.MX53/6SLL/UL compatible
  dt-bindings: usb: ci-hdrc-usb2: add i.MX8DXL/M[M,N] support
  dt-bindings: usb: usbmisc-imx: convert to yaml
  dt-bindings: usb: usbmisc-imx: add clocks property
  dt-bindings: usb: usbmisc-imx: add more i.MX compatible

 .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 158 ---------
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 322 ++++++++++++++++++
 .../devicetree/bindings/usb/usbmisc-imx.txt   |  18 -
 .../devicetree/bindings/usb/usbmisc-imx.yaml  |  67 ++++
 4 files changed, 389 insertions(+), 176 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
 create mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.yaml

-- 
2.37.1

