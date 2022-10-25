Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7DF60D396
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiJYSdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiJYSdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:33:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3505DC4D83;
        Tue, 25 Oct 2022 11:33:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMtz7apCOxDxthvrBOtIg4H43AfzbBk5AMks4OlQn4Gt12Giq4BNUP3ZSEE5HXhZXs3t9p7ub0TAzDuZ1nZF/o3oF5CKfgCMFsb8v73k4QSW7ZsoRIlhsvo5kKYzSF2PeTmKGlLWMGEQJZsdLLNHrTWoCNpZyhdL4GPHmX7N7TgLWmCd4SpP/qGkCTNbRcuuMJiZXyKvjhCmA+pUVMDaxf8/+qz/oqOM7mfFEdHkPJSDyReJLe0VZnl1tHLZs8UhnUI4rbPq3rRRHEHI77pPNSflc2EaxGo4Z21usxIFhd06pSMkq1HCrthWrQhepAdcCA1kjHpTZUiO16QfBOtLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5vZ51io3rmne9ye6+yjfVJhctjJqiFWsRy4RCg8bZw=;
 b=W5vopNJvXzS8sCrbeHcdMQb6phGUbXxol0oYcedieJfB7wJiWz/+7HnAxkyYzm9Qmv3xLENgIKC+KtVESD3IU0UrNXEM3vfJ7AmhIKQD4pqsTCbPcJYJkvbU/Fm8s6v3WYJSquZ6VLyoJR7j7gmtuBS1Cwp8p9HyD8wH4UyT7bQhvNH8oJUyXILVkWBmx4VLDLuAHjavDdkAs0OKuAPURZCr3KiR7ClueeeorPJWsWojvk51MkMh1KB3YM+6I0FKAg/8Y4vWnkzKF3+8t/EYUfpyuMi3oojIT2tGYVWqWGfYOPjzIOZWSmx1KKtxZRXM2J35+23i0YpdOC1IR+1WXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5vZ51io3rmne9ye6+yjfVJhctjJqiFWsRy4RCg8bZw=;
 b=LaI/OFWFl8Z+ywCtcraibkw2trLEKYm84Hlbsm3F5mLJEIEoD2SORll+BW0a9znXWWoICFOdkqPD23Q76EoMmZ4Qa7M5waOv1gWQiL3YszOzOsz1jAbVD04DL78p5N1ohsA5/ke5tfGIjmeuOB0t0DA0ywXmMwuZNohONjOzh/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS1PR04MB9581.eurprd04.prod.outlook.com (2603:10a6:20b:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 25 Oct
 2022 18:33:02 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::4150:173b:56ec:dc6c]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::4150:173b:56ec:dc6c%9]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 18:33:02 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH v3 0/5] add suspend/resume support for i.mx8x SoCs
Date:   Tue, 25 Oct 2022 13:32:39 -0500
Message-Id: <20221025183244.615318-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::23) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AS1PR04MB9581:EE_
X-MS-Office365-Filtering-Correlation-Id: dfcaf1b1-e2c5-4060-cf4a-08dab6b75972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2rVS9XGYCW053SY9MIm/ju+XPYYtzcj5zzRYlTfo3J/PHyJCoPqNpz1B70dh4BUiMVFzy7W5yt8yMytN1xYWGiF1IIWTrSWqcERLnI59BNnYTK5FAVZADdIzPMl0OHup8YNhSuO1nyPAPPgttWj+aiNxNSK8lKC9FGaQ4rsyEtqaQ+uAi2UUTBVY72Q3tPCZfRi9dAFlp2QfEuHR5ehg9pMJcv/T//kaO3aBBevXGG57vSDPzxxT1HGK5itiuPre14NeM8Rlo3wudVfwYvIk6qo2FlT7zBIU3xnit1h2gChOoTaZjwz0yifsCnyFewSD6L+xSEYVH6ZpgqEpq1MLesAH3m5+Ng13VFBGhErV4xMggtjA5Bq0pO697J3wFcztKhbLPrKJz1FUe8k2UUbFkA7UUgiyiUxUSeYYLxM10P79D8AQX8CExapkvTP6Ta6cqw4AUZby8i2uhhlD9SNOwvnWHFgpvBR3059T0QMJ9EXww+17uV0oer3P75/cEO3RvKqBHwCfVSitWcQSDlHuBiN8YkJw0kPVBZ1yL0zTdWHr8hNORYN8ATD9ARvx4yV+slCZuA3D0qL382nhsP33P1GqHRAmDL58cNcmYPPOBWZDkTlx4CC883sJApT5iVk1Xyafq7DFm01nsVcxD7EpDMa4FvhAQs7AFA4WZjvs2yopdpdn8zh2AbMO4Fu/CUfxOqQLPT/gzHgIdtngD0shI63W6HvfP+7KPqMJyDdbSufHux0GwqDVQQAAS7SKFVmE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(478600001)(38350700002)(38100700002)(7416002)(55236004)(15650500001)(6486002)(8676002)(86362001)(2906002)(52116002)(36756003)(44832011)(6636002)(66946007)(66476007)(110136005)(6506007)(8936002)(66556008)(4326008)(54906003)(26005)(41300700001)(5660300002)(6512007)(316002)(1076003)(186003)(2616005)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s8XJ8CHIwJ5YAJ8NPJnAuNR3bsSl85bNQkO1dETE0ztoDjWTFhwzC46TrisG?=
 =?us-ascii?Q?LY0cvOPG70Bm2mXfllYnt5oa58TSdsnvJ8NprRrcEAAumWB782gsCVFwFTRr?=
 =?us-ascii?Q?Cr2FUCQm2r+ApOeNAMEKP25Fa3DJ7nE82Sb+nyGE8xonZI2W0sHn/EmCG429?=
 =?us-ascii?Q?uwDVgDSLZkJHEKPCv2iZUYVMcbEoGCDQQ9nnKwrhRgMuzptNljxBu9RpM67x?=
 =?us-ascii?Q?jxcS8S+UMxOJdeKdm4+X0evBihVn+Q4r+/I6X3CZ5cGZodwbAjFPioOD7IXw?=
 =?us-ascii?Q?nzQw6gULuruZY3uvci8ZUm0TEouG/mFu/SxJA5N0TFXfx36sNEcp7CdBCSqR?=
 =?us-ascii?Q?PoyM837S9DlCNcmJq/GHr0RmvbaaK5uRqQsu+ZVBCJrcG+fT5o+wj7NCWhvN?=
 =?us-ascii?Q?OvBFZv+kHgrCZrBDujv1X0IpNYC0MoNDwBbOf9rEfXu0RyKBOBU8FwipqyIm?=
 =?us-ascii?Q?uww0M1WyG7ACneJjLV+eVR15Xv5+P7vhtRLiJ0g8ffB6y4DebwkmSCWiSi28?=
 =?us-ascii?Q?YxKsI+cD6PDIhJblsTIyqQL3anx8PyAPaVEa0wtNW62NqQORC3DYGQWmjtYo?=
 =?us-ascii?Q?nqeIpvZwjhmwZw3Qq0Tyj4VV1WOKuFm3M2vrG7/ZKylbbb5IIgsRBzaEuTJ2?=
 =?us-ascii?Q?5Dx4nEFPHe/NejZugfcjj6Ire3Of9F9FKRjY+02lcF4DJXVhFMXPqUHyMISy?=
 =?us-ascii?Q?zMH94lPkLuePMNDrBlAANyqKHuu15iGz/TDsTgNvIzZaQLUj/9NzRL7+iQUQ?=
 =?us-ascii?Q?Jg9h21gclVImvgW3W6QPRCQb/jjMg/vPPwAPqmQrOReHBvOOgsXuv9WR+34s?=
 =?us-ascii?Q?wBq/RC2bT6Frt0wysDghG48OUqa5XKAjUnX4hJ+FjOivdKRhWZO43lSJIWCq?=
 =?us-ascii?Q?T/dhbzEOhk3NFTDc3pOcuBX0IJmzI75CkA3zZrpWOIKdnCs8InmhldvBi/Ca?=
 =?us-ascii?Q?71mxbiWBitiTYCVEDIkIyYK9zx/y8D8km4Wp+nWQiRfNkAjYCbKNiPAgSx9Z?=
 =?us-ascii?Q?V1rgZgCWreDvKhgPfD3aHM7TMn7XVuFgPQYN2ueEUp9gI0J4x2TxLIRg4DEz?=
 =?us-ascii?Q?nJTuaAdJEMgOCDYDITsso1eycZdmdvqgVixzT+NxnkyvSknpdD5Oh4rXsTQ9?=
 =?us-ascii?Q?DKN+lovWXl6/gE0Zul7ioDF5x00bZtEhOOXrhKOBk08yojs4afUhvih6h/Pi?=
 =?us-ascii?Q?CHB7x/VFcs/7iZsUqwL2c0Cj+69uo0k82sd4EI1tdpL/fqRin6Dy6uWI5CJC?=
 =?us-ascii?Q?zp4KT/8FPDNN2z6KYdQcWDy9dZzIdiABuserFoGqhSDtHqjb4Eu0liGeUW/a?=
 =?us-ascii?Q?f6cp71CTbTQW4NuuGAnIIuANnpOqfwd97e7G+pB5HGdGGC2IXgnkGdr3bM/k?=
 =?us-ascii?Q?sF1RQRNOsfocPzPKvSW2AKVB8oB8VErbiiDo7TB4wbdStl7/0iIQ2uz6UY+9?=
 =?us-ascii?Q?OR1mA0zWryACPPwuIbwAYNFlrNve/2noLEQ/XzYoB161wHHKbRqSp7Z4M6Aj?=
 =?us-ascii?Q?/N12kbfkEbwOcaZ/MMmpDw9XF5S2LJsA2ox191QjolN/fnvRmfakbEn3eqWv?=
 =?us-ascii?Q?x1osV6vB465ht2tqOPWDe5LGdFoAMpfI/jJ/Z8sm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcaf1b1-e2c5-4060-cf4a-08dab6b75972
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:33:02.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: blowWXArQglYxCp7W0oVq38+o4SnQeXKrYv07h6if3C4X6PxwQoyjjUOYo5EhxokkH2xueaw+ut4vMZgsBGU4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9581
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8QM/QXP/DXL SoCs, even a GPIO is selected as the wakeup source,
the GPIO block will be powered off when system enters into suspend
state. This can greatly reduce the power consumption of suspend state
because the whole partition can be shutdown. This is called PAD wakeup
feature on i.MX8x platform.

This series of patches enable this wakeup feature on i.MX8QM/QXP/DXL
platforms.

Changes in v3:
 - According to the feedback from Linus Walleij, the wakeup feature is
   moved to pinctrl driver, and the array of gpio-pin mapping is moved
   to gpio device node and initialized via gpio-ranges property.

Shenwei Wang (5):
  arm64: dts: imx8dxl-ss-lsio: add gpio-ranges property
  arm64: dts: imx8qm-ss-lsio: add gpio-ranges property
  arm64: dts: imx8qxp-ss-lsio: add gpio-ranges property
  pinctrl: freescale: add pad wakeup config
  gpio: mxc: enable pad wakeup on i.MX8x platforms

 .../boot/dts/freescale/imx8dxl-ss-lsio.dtsi   | 41 +++++++++
 .../boot/dts/freescale/imx8qm-ss-lsio.dtsi    | 38 ++++++++
 .../boot/dts/freescale/imx8qxp-ss-lsio.dtsi   | 25 +++++
 drivers/gpio/gpio-mxc.c                       | 91 ++++++++++++++++++-
 drivers/pinctrl/freescale/pinctrl-scu.c       | 30 ++++++
 5 files changed, 224 insertions(+), 1 deletion(-)

--
2.34.1

