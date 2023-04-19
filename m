Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCC46E79B1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjDSM0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDSM0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:26:17 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B04E44;
        Wed, 19 Apr 2023 05:26:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzX4IRQ3kmUifqkKNsJZJUmD3Sm5sRJOO+FnQUhCIK7rEx3XZNj5qLso4zc9k4kVDWC26gl2aGEhAIsyKesnU1DBNZ97MA8oEFoSo2OzpjiashD18HNb07kL2cYWh3kkQ/QfkM1ukEEKE74ctHFWEwpzg4nmCztOXVZ22wI6inQUzltgkQYjOd/W3Uf7RmRNumT81FrrsDnlWperOiQjm7neJwNZBBFJ86nNXZw6rFsnWpt47EmLZFKoZcMMpfYg+aN2ny8SehaOaLTwPg1pkjijuB/XvXKObZCogEKGpe5IxMnJzs3xzfN+DV5SvXAJtcSo/2HHuMeo9N5NHKlG5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3OuFcS8FmoUWaFC4M6KJidIIuemm41W6vqZI4YlH8s=;
 b=S8J1azNMK/VXWIHtHzcwYBuxx8YW6kIcwLPjO38psHGTrIigltOdQoNM7QVv+/BMPg6gbQikZIte229ceiA6EKAnXCBpYZy9Yd3bGtQePpF6wrYr5fSmxoQpx3mMr7HVkbqNst+BycEZBonuicFXt4EGZ7BWUWCayZ54hGYYYMxgr+QEn7OR9tl1/UNR/fCdd1Rv4dhOHG6egUj4/b83rDY4t5l2F0J7D5hU5Py4ESheDqZsuoEOFabP4n2Whpl6A5DL3dA40GvPDppHOf7ZvuEldke0eb5c3GX1gIDD18tACIlYIWw4r6lMixuK45tUfU84++jjQ5GoXrtLdT1vkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3OuFcS8FmoUWaFC4M6KJidIIuemm41W6vqZI4YlH8s=;
 b=UOwp1AJyysMkiBh5E7PkfjoRwdEqvEP428fx8r0UV6l3jH+14F1FKwANAYKIIqKWSCxdI/cWTkuwkdarFpI0x/lYILRma7BsfT3Lq8xNGrMGx45Xf+nJcpzA9IbeIDBGSJ+a651Iihq6DQSt4qT9+YmJsiCZS7jqSrRRA/6mgl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAXPR04MB8912.eurprd04.prod.outlook.com (2603:10a6:102:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Wed, 19 Apr
 2023 12:26:12 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed%9]) with mapi id 15.20.6298.030; Wed, 19 Apr 2023
 12:26:12 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        gaurav.jain@nxp.com, sahil.malhotra@nxp.com, aisheng.dong@nxp.com,
        V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v2 0/7] *** firmware: imx: NXP Edgelock Enclave MUAP Driver ***
Date:   Wed, 19 Apr 2023 23:25:31 +0530
Message-Id: <20230419175538.855493-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|PAXPR04MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: 0447e269-e379-4086-2c2d-08db40d142d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ms6Q56DmXSnafV74dedXwDqZuZeTqt1RwI4MAXkU76Rp3pjB8kWSrN4kuBxqWcZKYpjZy8edxy2VsdMqMv7no1G8VlEJx6Aq6B5MGppbYern0xlUHDNfRpTiPS+9i3rzgRZhkUwp1XgJKgGbnsGkiBvuGTMrg1GK2UOjUYHQ0lpOsv6PNBqBgQo2eB3/tJ7vfJtrkX74EfRMkCdQsr0wnlOtXmLIQi7uUVsTMjN1OIzC2tvnSzsu68cE9vuA5yWRE6BOQoJryfHfFLqElBUoe6e2Odque4ld2kSdhKxhZuY6I38h0mwDK+fYSnhWAS72oEhMbrujO6bEOtkMz4nWNL60dv/4k/dExCwKthre7xy1xWwoPGFivBMraRe0hjCpxyIivvDLGJihoCQAWbgr3yFXIgUt6GL6BzLA1YAlczQ7eCCVmuOav+44njw7xC8xYjoCi6g5UtHGBbElc86PnKbtCkXSWkt2GLw/j/uGd++5xsIsYr8PIQvzUaxsTfCE+m3dobwgj5Xpd+84UGmoDULPkNgAwuDZtBlPH11CoYkkFfZW1Ndc9CqW3VW2M2LjXrT3EMe1/eKNRMhTFs0+fv1RWiueilz8jnIRXNWrwJ1R4idXo0eYpjqqtRdZQkf5/ASLPMbGNbGCs9aIQsTLbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199021)(44832011)(5660300002)(8676002)(8936002)(41300700001)(316002)(4326008)(66476007)(66556008)(66946007)(2906002)(6636002)(478600001)(86362001)(26005)(38100700002)(38350700002)(921005)(36756003)(6486002)(52116002)(6666004)(83380400001)(6506007)(1076003)(186003)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xptzECeHwWLKPMbN6KwmMGttRorFY11ABQ28GVfcOWYufVA/qXiQL7jfE6wN?=
 =?us-ascii?Q?WHOANpy8u5DapMmt4EslG9Ul6dsAn4thx184FxvcOwzpeXGyAn8Qfy47rtSw?=
 =?us-ascii?Q?7zXg8WIK51BBw97wJcrQHAjbM7BPFrpDeWP7/JxWFLDJ90BCp8NnJ/2e/ApQ?=
 =?us-ascii?Q?MxlAXE+WDkuc6CaHFZZHuPcWQgj3YZhHJWarWjd3xC2fy/OGZ4fNibY5AieX?=
 =?us-ascii?Q?EyPTRwjx9MUWi3K9rW5K3uJ02nTG/NNDxHTDMXwvHC2T8O0qXUefjFBJUYl0?=
 =?us-ascii?Q?3NGn7AXMrm5ye34Rm/r5CWOLsXqnhJyxhlNLxKkaTTImlhTwlbgqfJfQhEtE?=
 =?us-ascii?Q?CnfYa6nsTsPIbGGkwo7dIJ1q4AqXl7G6oWBGJGmKuTRnfytcXcuGN65fBbc2?=
 =?us-ascii?Q?Sxyr6CRj6twzyZLXFpe2mNPcPekJU0HeLQJgi3BIxteIZkCi4RbexGE1HCfM?=
 =?us-ascii?Q?qzMSGjUMXrGbVGbnByBwcPqyU6O7+iF7+pXQ033YwcG4Cle2YGlAo1UaqXxZ?=
 =?us-ascii?Q?CW+hj7JqH30jCus0QaGR420pghFGwSlw5PtFQZwyTqqqkPNkLj/6IwP/iWzY?=
 =?us-ascii?Q?pxKxwypxgTlzSnt8tFwsw3PtVhnyTnmnKDSQi6cF4G/EVIlNnnLM7sAsvT+8?=
 =?us-ascii?Q?uU3PyFBmTGcDkVuv/PX/sZj2UF0YRDv/NlMxsD01KCRLOmA7fNs11UL1WxNU?=
 =?us-ascii?Q?MDmIam3ec0B9gOyyYfdwtmzVCyUDkYtWs4SjOjbvhfNERGGbY9/lGvXmtqmr?=
 =?us-ascii?Q?LPiL58ghGZ1y3g37iOYer9ZtAu2ZkmZSNGtMDodYdjn/Q2O5APl8wqp5mMBw?=
 =?us-ascii?Q?DxIuf7D1coabQfihgwb+Fraev1ggCq0wO3wpDP6ox7EFqNtlxtQTUIziC7Fc?=
 =?us-ascii?Q?4MsuGumwv9D/iqcvo+i+5Px839iIAwJII/t7KYL+boS/jSodPNMtrvbax73Q?=
 =?us-ascii?Q?qleUn3gzzeozwLjXfqzbvj0ONLv0Fe30Vv373b3eqVlK+E3aWZlz/XNohFm6?=
 =?us-ascii?Q?iGHDKL1KMzjIX5JHVq1r+4++7FWnJza7xN21YWn3m4B2lwaIXrf0ZqDGc34X?=
 =?us-ascii?Q?APvoTFqbsXWmhOFbXUK4MPEZtvw90kPjJ5MKwCUoaKAsoo6fsUOhVGY8Lc7r?=
 =?us-ascii?Q?nC7gWobuwvSZuNWnE0Rtnc5U5vJwcYvSpCIDXnPRQArOr/TGB5/WkinXQTuP?=
 =?us-ascii?Q?tzhcP/0c9NaV443qAGdZxvR9mB1sYQgfQRuZ9G0Xe+U5E7ob1vQcavc/AMgM?=
 =?us-ascii?Q?qltca+tZxbKHA/X1AmtOUfPjSJAagOBRzzXFvp4zoKGHGPXIwY7QIUBFddAg?=
 =?us-ascii?Q?f7+hMgouaYgeXiohDrBEZHPNfa7bZ504i6LUQTpTyxwdeDy3uHRQ+t43/Wrr?=
 =?us-ascii?Q?z6pCMG0cGgg0OdAHBAjPNA4l4XPT5Za6LQzLnyDZKjcTc0ILz4SPxtjto4eY?=
 =?us-ascii?Q?Kcp/fjQoIxWpoo2sKm59/W+sWgUpRkTba2vtlf/JoSw/8XmUbVZj+vgDrDdM?=
 =?us-ascii?Q?sjN9yyrvwUJvC24+SR+P5pQuEp9dquZFf/KHH3HJE7RkqRk/B2k9XK18MWey?=
 =?us-ascii?Q?4bvOfQ/yCwXy7xWUO3YzLO0or26MHV0Utcb3gT5u?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0447e269-e379-4086-2c2d-08db40d142d9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 12:26:11.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tt9BIjBx7XYppMY+p+rO5fZBpZunc8/1f/E0hMAn+wDFv9F67GAbOOgKGQ6dXH85N6d01E7OrPzZVA/bpEYpHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8912
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
  doc: device tree binding addition for ele MU
  arm64: dts: imx93-11x11-evk: added ele-mu
  arm64: dts: imx93-11x11-evk: reserved mem-ranges to constrain ele-mu
    dma-range
  arm64: dts: imx8ulp-evk: added ele-mu
  arm64: dts: imx8ulp-evk: reserved mem-ranges to constrain ele-mu
    dma-range
  firmware: imx: add ELE MU driver support
  MAINTAINERS: Added maintainer details


 .../bindings/arm/freescale/fsl,ele_mu.yaml    |  139 ++
 MAINTAINERS                                   |    7 +
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts |   15 +
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |   13 +-
 .../boot/dts/freescale/imx93-11x11-evk.dts    |   15 +
 arch/arm64/boot/dts/freescale/imx93.dtsi      |   11 +-
 drivers/firmware/imx/Kconfig                  |   11 +
 drivers/firmware/imx/Makefile                 |    2 +
 drivers/firmware/imx/ele_base_msg.c           |  378 +++++
 drivers/firmware/imx/ele_mu.c                 | 1285 +++++++++++++++++
 drivers/firmware/imx/ele_mu.h                 |  174 +++
 include/linux/firmware/imx/ele_base_msg.h     |   67 +
 include/linux/firmware/imx/ele_mu_ioctl.h     |   52 +
 13 files changed, 2167 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
 create mode 100644 drivers/firmware/imx/ele_base_msg.c
 create mode 100644 drivers/firmware/imx/ele_mu.c
 create mode 100644 drivers/firmware/imx/ele_mu.h
 create mode 100644 include/linux/firmware/imx/ele_base_msg.h
 create mode 100644 include/linux/firmware/imx/ele_mu_ioctl.h

-- 
2.34.1

