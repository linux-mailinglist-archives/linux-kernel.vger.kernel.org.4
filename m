Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F22733170
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345210AbjFPMnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjFPMm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:42:59 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2079.outbound.protection.outlook.com [40.107.247.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C7030F1;
        Fri, 16 Jun 2023 05:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZDb2oODy0dbOPBnADvuhNSlxoNA8k00Pc4aXjX8Lke5u59S2g1H0YTWm9Dy46T2laMQWojxFwuR8YGSrTaGbAK78+fD3cLJ0O2PCouY49LueCB9wwvqcLkFG0JglmbTKMbSTEfMEfvXRRl77clpwUqMwfZXZDQPrqYz9xvE6FJBjjyJJgHhAeH0bfiN8lQVb3lbV2qbpK/iWNAVyLdEnRjY+lpW/UZQX/ZEW3wScERxHsUnrVE48KFKEW4iXpw3yefSaBMjYUbejFFz4zO+ldXLAxN8hGHfwKHtCalx16EZuceqFEMLFi3r5JpEWTQPNvE7sMm8CWQl/vhYJrsiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91ujNrKH8FtsZC2b7lrdju/kIhm5l3l5h8gLk0varzo=;
 b=H2vI9z1vN8wZrcSzhbidiilvlXohRIxtsxJUHIJStwr0tMYl3WU06LlrG+Jr8qFM16/qGw8R32Yktezo+GJMJcpSXtC/PNlGR+NiP9BEeefAFpYKhFMBl8DsEwzXuFW4QkaXoVaoTf60CI+wjdkpM0GvormE1meAcXyk9SW2mAw+f2vibkYKaBV23sE2yN/b/vTaDDrgu9JxLzZqNGp8wVMXOuKcR+2NzxwDfj2QjpFDA5lOoC9RH9IrMsh5nzNpxsKqbZpRHiy222RbA5XE8ZBoofcqjpjj1WL/hWkNBazR5Vlbt96QPe8m+CnZnL2oUfBHInx3EbyJHZAUQft3pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91ujNrKH8FtsZC2b7lrdju/kIhm5l3l5h8gLk0varzo=;
 b=rOxjYS+DkEmfu0f0mM6HXkPGeoZ2ETB+StVA66O57e4qY0ahEuN/c9zRntct4xl51gcqUrnmoAS3ylcsROmFrwy2YFI7WBYti0+t6fKxYyCThbm0DqSDWOH9aLwZMxC67R/9ICUTtJWDgKgdyPQXCTwc3rE+XKnYnyGEzSaugFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAXPR04MB8320.eurprd04.prod.outlook.com (2603:10a6:102:1cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 12:42:51 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad%3]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 12:42:51 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gaurav.jain@nxp.com, linux-kernel@vger.kernel.org
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v3 0/7] firmware: imx: NXP Edgelock Enclave MUAP Driver
Date:   Fri, 16 Jun 2023 23:41:37 +0530
Message-Id: <20230616181144.646500-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|PAXPR04MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 89fd5ee1-5d9e-47d5-0241-08db6e673296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjN5G+4mKmzIKmPvYYTlvfw/JrTzfZ3XuQw4lH+WNQoh9HGk0dXpbz2llhm3mxU6Zbxb58vccoU78w3CgDzYWFolNRhytSrOhPgkIrck5XVKNx+6hvuNxrWaZkB1KkV6ad9+UvgN3rzSemPFYv/RzJMZ+eywY13JzJqEfrMe5bh271DFsT0SkZlgEKrZn7ZKcj1BubXGxgNSxnj5oLSHZy0ho4A9bcFOb/m1Q0mvHCGkpo2tUn/qlbph2YDrM5XLoHx2GpVETWOgvZCsA8dNjsDZYg6ZfgfWzF5bAmo+6IDWR0n+AeOiNnfZo7pC4L9x5AepnaQlvNGC5EDsxQnlS+9jMdG5CWYz4KxqGUxkg5Iq2E7OF/63AuUSsWLKzXZbkfjIJcsApgCA+nhUJfyhAx7NuqnaH6lJ78PmUOfI2oX61FvHkjqUnSGa/iHQP/yG2ni6oE+jeRy2Cs+XhH2A66k43aeErlXN5j2hs4xNejLNr+U5bIsk3QmLAGqM5ghuZ4FUNXgDBwbteCXlYxKDmekohpln+miCRV+DD2bSOoPsSsD6dc4Iykda/CLo7iG1bsLZKYHob7yh0KuKJIgCwFA4xAbS2RWHvgCltyqCX5hP5FQXV3xRo1QUs/llrwSgsTZ7mHkfjhlIV1fcZT985w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(5660300002)(478600001)(8936002)(41300700001)(8676002)(316002)(6486002)(52116002)(1076003)(6506007)(7416002)(44832011)(186003)(6666004)(4326008)(66476007)(66556008)(66946007)(26005)(6512007)(2616005)(2906002)(83380400001)(921005)(38100700002)(38350700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3l268BcOkjT0v7rzzykgC3J9LqKrmB4L5IYCT8+qoWqNiy4toMUJ8ibr+aU4?=
 =?us-ascii?Q?ktrG871c9YyZVbRPhncP4ULrSJdugWVBB/tv56X5nkSY6nEGz/ijRq/+nueH?=
 =?us-ascii?Q?10rA8DxUfKvtCNvAHfqyQOxmyuEMAdejnquXaWsWZbE3JggN2glh/wEWAztW?=
 =?us-ascii?Q?P5e3ZFjJRirotyQO76X8JQz1EGSidqIdjpS5y1ufkSyJ6i3uSVEaca5t/0uQ?=
 =?us-ascii?Q?c9m91HKqVNSCLJoOhW0qlD3qV5rfLf0VmJlsNMo1Xh3R1S1rSAOKHgeAM3EN?=
 =?us-ascii?Q?vLF0BDdLlzAH7bfqzs4fKcWPAT4KVuv5rnPbm7n+j9DKksVyfAnPnh9NAzVR?=
 =?us-ascii?Q?YQxQzNZA2KZMSmhJHI2zBXSuQX1bie9up8swmSpILnmlhWlg1O6vR3aEiIxv?=
 =?us-ascii?Q?s0Lv0yhYU17wCICzSCh/SPiraRHNEmXE27sfbhNSLPPQwN0802rqvSPdk0qM?=
 =?us-ascii?Q?ERrL5fKUqaHIAmhZVsKArWWEj/J8cAtYRFR5KP+JpEM2Evb4LB8vOvy6hqB6?=
 =?us-ascii?Q?23zGAMfVuKxbRmKwKdIGZm1QBAq8/nbQ19/kGXVfuU/VfGcNC5maFtwnD1Aa?=
 =?us-ascii?Q?PyFd+PibSCxzLWEFP0BbglufEn2ScknLsru93VKgBiquunSZOFeQp102eMYP?=
 =?us-ascii?Q?SfI8Q6dKxjlHovhXXRVs3zi0NikhsC2nPaHn18B3CVvOtIXcurbXd8zCc8ky?=
 =?us-ascii?Q?4rNeeWudU5kInmW7ShGGlvEYb+NM0omZV6xZNlLnmkMa9BbEgOy9YwIav34K?=
 =?us-ascii?Q?OPd2H8JvpdW3r8ja2Sal1GeZ/X2VVzJ1aFJLbD3NtP8/2Z5UdYZIk0Kpjizn?=
 =?us-ascii?Q?arlLNh9zjkBtO218EvhP6DR2j2jDSajaIXQXzyegl34OOJL8dBuoeqGI46o9?=
 =?us-ascii?Q?eL4czqu5yC/hR7goCf4nqXG3tzF96ZKL3m6Gl+MsB4rwBHTB3Y0ojtTCyzA6?=
 =?us-ascii?Q?xUKP0AFJDMjPxxaiRpXUXXOndBNXSEx392+0NgqmPYRN55R6tdfINqaKRSfd?=
 =?us-ascii?Q?JOkhFBtduTFiS+/dd5Q7mBiToxk9eE1pFmWlGwfLSArXMXRSZwrMfBbBLXZ2?=
 =?us-ascii?Q?sqmS5JtXV70InTt+7wDnS9HtpTKW1gnWQAnfVaN02GixaIi2ngdFC4idtOKs?=
 =?us-ascii?Q?qpDd0cy5mHQojs2X9y7Ky5bFBCOjVPXaJRj9XKXErYIungo5NIOq5NcFwcpN?=
 =?us-ascii?Q?M377yrAzbQwyyYfC1KOYjofKmUY4YQHXjDyum/OIxm7mZ5SZFu6jBF/PMBxb?=
 =?us-ascii?Q?F6ew2TmKAdGS0/QOav4klefVThpPBcbTOM2077iU8z3EfgUkN7lW4QhW9StH?=
 =?us-ascii?Q?UFgHNFirrZ3mTsZmoZMOPwGsXoZ3oLtFykfDfMJgH6xEAxOJjZlSIUQsd8q/?=
 =?us-ascii?Q?UKGZutFjrxwiobn70p77hdvRK7rogU0iwwgWTT41VaitGwwNqJE3nRwRTQ2A?=
 =?us-ascii?Q?rqWQmGHsRODoG7TGcaZE2Cn1Ph4Ob8wW1axw/nqO9IifwmhwS4T1/QJNFcKc?=
 =?us-ascii?Q?45n/e8/fQxiBLjOUFsohSgc3b2w3iX24J2lKQY2EW0GSLP/gMtipUdFwolHb?=
 =?us-ascii?Q?ycf+es8oaz6kikP1NXQudEoBpOc4x8iXUFECpxiy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fd5ee1-5d9e-47d5-0241-08db6e673296
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 12:42:51.4066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWAQEp2j627NB8ei6cYQtIPTgjcqDqskLw8TaBLChKB7ZLXnTSPe7c/OpFgKuKkzN+ZYFssFJzulbCsAcraCYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8320
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 Changes:
- update the commit message for documentation.
- Fixed dt-binding checking error for file- fsl,ele_mu.yaml
- Coverity fixes in the ele_mu.c

v2 Changes:

- Fixed Kernel Test Bot issues.
- Removed ".../devicetree/bindings/mailbox/fsl,muap.txt"

v1:

The Messaging Unit module enables two processing elements within the SoC to
communicate and coordinate by passing messages (e.g., data, status and control)
through its interfaces.

The NXP i.MX EdgeLock Enclave Message Unit (ELE-MUAP) is specifically targeted
for use between application core and Edgelocke Enclave. It allows to send
messages to the EL Enclave using a shared mailbox.

Patch-set add the ELE-MU  kernel driver for exchanging messages with i.MX NXP
ELE IP; both from:
- User-Space Applications via character driver.
- Kernel-space, used by kernel management layers like DM-Crypt.

Pankaj Gupta (7):
  dt-bindings: arm: fsl: add mu binding doc
  arm64: dts: imx93-11x11-evk: added ele-mu
  arm64: dts: imx93-11x11-evk: reserved mem-ranges to constrain ele-mu
    dma-range
  arm64: dts: imx8ulp-evk: added ele-mu
  arm64: dts: imx8ulp-evk: reserved mem-ranges to constrain ele-mu
    dma-range
  firmware: imx: add ELE MU driver support
  MAINTAINERS: Added maintainer details

 .../bindings/arm/freescale/fsl,ele_mu.yaml    |  144 ++
 MAINTAINERS                                   |    9 +
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts |   15 +
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |   13 +-
 .../boot/dts/freescale/imx93-11x11-evk.dts    |   15 +
 arch/arm64/boot/dts/freescale/imx93.dtsi      |   12 +-
 drivers/firmware/imx/Kconfig                  |   11 +
 drivers/firmware/imx/Makefile                 |    2 +
 drivers/firmware/imx/ele_base_msg.c           |  372 +++++
 drivers/firmware/imx/ele_fw_api.c             |  112 ++
 drivers/firmware/imx/ele_mu.c                 | 1442 +++++++++++++++++
 drivers/firmware/imx/ele_mu.h                 |  180 ++
 include/linux/firmware/imx/ele_base_msg.h     |   62 +
 include/linux/firmware/imx/ele_fw_api.h       |   19 +
 include/linux/firmware/imx/ele_mu_ioctl.h     |   52 +
 15 files changed, 2458 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
 create mode 100644 drivers/firmware/imx/ele_base_msg.c
 create mode 100644 drivers/firmware/imx/ele_fw_api.c
 create mode 100644 drivers/firmware/imx/ele_mu.c
 create mode 100644 drivers/firmware/imx/ele_mu.h
 create mode 100644 include/linux/firmware/imx/ele_base_msg.h
 create mode 100644 include/linux/firmware/imx/ele_fw_api.h
 create mode 100644 include/linux/firmware/imx/ele_mu_ioctl.h

-- 
2.34.1

