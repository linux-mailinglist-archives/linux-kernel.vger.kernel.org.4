Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058336C4204
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCVFUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCVFUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:20:05 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2081.outbound.protection.outlook.com [40.107.15.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7A513E;
        Tue, 21 Mar 2023 22:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJT6hFaKV/emI0asrmv0ZmIzaGi1Mgo2pRMrI4WMzxU9IByHwNbU9vxlrkOPh8Ina2hj3si11H5hADj9DAlq7IQri3p+Q9YwXjM83je3CGgAOUIvB552SN5W0Gy+yTyiZVCggasXVY1AQQzV1gcUzjIMb2/XH/MPBwBlS8aa3Yw9LMTn/bq8BtwPQbtZt4J1l/i2ztQY0vqc7dSFnYtRq4KwpVlQO23n7yEn44h3+cBk1QChd+luVlDp3ODgDQ0izwo1PHWPj+/jm2sh/mQgjrVwxEMSaYkM7O7z0eX5l1OUSmwODvhnmUJe9D32fYbG3W84NzcAWx6cQU6R7xGTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3mUW1WlSkhKBAmgcLc3VV0o9ATuZr1XGHqVDT0GqlU=;
 b=cCeiPPkM6V1GWQlYgksqJqIukOuXPzDNPyEIl3N2NFhLKhxK4zn7PpmhTKWvMK/m41hp7LWGNjVP/xJ9E4SN8j46U2rtPN7d6TmU4X/zR/J00GQpUMs68iYVX59muWg+qygmBKDqFw64ZjxlXg6tebEf4DcC9mst42YXMOJ50icKLCGvHU5SwjJ7YVQ8CxYUv6EzVjqDzFii4AvoXcDuyTiUNROaKS/pCbvRBWauode2TVTNITE74dCGECrdjN0fRAH0fAOecFrN+gAdKgtcj5zMGuHQ8AcR06btswV+y65piCCTf0aYwoUhq/XWS7sNKh8rvKdYIadg9t9wy28w5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3mUW1WlSkhKBAmgcLc3VV0o9ATuZr1XGHqVDT0GqlU=;
 b=Sa2Ucu6kgTaf7QJR09CN65a1x+tKOiB7SgSzOwNLH5z5ajypM5W7Ku+1UQHK2inBvLhT0qs3RnK/um3DTQj2YDOZp4Bnhs7XPNeI/G0J5jRhewrTpYlx+vKHTrQutHvFqGDxqzZwrxGTy8Eniap+QB1Ea21IqYH+FklYlXYsX7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8351.eurprd04.prod.outlook.com (2603:10a6:102:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:20:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:19:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 00/10] dt-bindings: usb: covert ci-hdrc-usb2/usbmisc-imx to yaml
Date:   Wed, 22 Mar 2023 13:24:54 +0800
Message-Id: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9e1fe8-7fb4-4ecd-9e22-08db2a9514f4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJRJQ705pWfJQl7paNaBgRiATL+kgzA3bMUcgCBDwsc79hDQ30de2WQrSQPJ12NIuQNLGzqdCB+sNM12L3dYIjR94Qvye5oLOFkHfihNNINEQlR3l/w3aHnRA29y5pYOWmU2xEYj0ryFQtvrkf5wUWWHOzYuMvU9zamEpV/ZDTeqWJqr35EAbyRZhXJstzIiOnG5tJsRvcpequzSd2mfQA+7l9xSC+C/CAj6qsElJjrangPbCJfQnUZ/2eem93tlX1Rpq99VIFP+QJX3Me+++n5CFkyrE0I4IonsgNlQOUHR9rc8dzrXwMBc6xr7XcjBCn41Qzg4T7snwDW981YDffra/3kOQOfpvRD0X55QwjgijlQWIkXcNQYkal2KInDn5fKFPZBv6E3tcXwRSHwY8mFKu6lD/s2CH72jw14ds+o0y4UVDiAiUcrlW3FFKi4tRo5ow9RaswaUnNtljaX3NVeE7UPB1c8eDH43olZKdOLnziaOLcf/tpxs8dhbASpj56CgNguPjE0xVIg/us4xbwsVqlnGlMUCeNhrLVYKDM4p84Oacd1nn3OT2XPtISGfcx8hIeGjCk1xhgNRCSLpI0WjYdJOg7l+Qgj55Os4FboDQWHXUThNSmT2QF1SkAdiD/EX9wmlBCPyM77dDbe4BzikA+Kru9hSAWjBL804T4zEF7WhRz2VcuGo5WDS3fgcmmNAoT9OBo4+wFbVCJGbeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199018)(2616005)(6512007)(41300700001)(52116002)(186003)(6486002)(4326008)(83380400001)(478600001)(6666004)(316002)(8676002)(66556008)(66946007)(66476007)(26005)(6506007)(1076003)(7416002)(8936002)(5660300002)(38100700002)(38350700002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yp9qkRdh7x4m2ovox3PU3e+p5IbMpzQ/V0h1qgATZ8qV9yZ6wSMES+q0zU/u?=
 =?us-ascii?Q?ZWnSS42NZ9xHL/I+i5uL/67bt34Zhupgsznnrn/4J9GNskyqZ1ewQDWQkpSU?=
 =?us-ascii?Q?pKzWMFu8lp39qBY4VD/V/AcVtEyEcg006zurgrp96sHbJsM8LL+dEZh6E2NU?=
 =?us-ascii?Q?h6hTAs7O6l86GuYVNyxFvPTFuxdzYsa0fv6NHPKU/AR/Klc1BOeXQ8Plb/hk?=
 =?us-ascii?Q?MksMLhUab73PGCB5cjV9+kpAsPvya6Rk6wFDOH2qC5EocsxGvVQEoGBeC+1h?=
 =?us-ascii?Q?XpIbgezWNUqZK67YYURrORyXcQAka3aue0X82WSGXBcmiJAagOGUMdMYeIsW?=
 =?us-ascii?Q?3uuGwqRlFXTIfizN3t7+kaeoIhxtIzyT3WJ7uqErnae+i96Xnecd0MfzF4Aq?=
 =?us-ascii?Q?WQeT7RYJg3hJhR3HYFR/pd3ywV6kxlj4lGC872x/ORQ4+dea6o/lCmi0Jlbs?=
 =?us-ascii?Q?oXRsprHCVc4aBcBFWMTAI/kV2gDLaSBtZ3h5o8wU7SlTX+XadRCJDnnFiYTd?=
 =?us-ascii?Q?lt8wQxDIObleGYBvb9J4+PdPO+vjBbwMNXQnn3KCwzI4Uz/VXrxNrqXs9jE+?=
 =?us-ascii?Q?G2ogbe0QhTWbBcCd8FSJx63pp2j4hiS2RdIqSrdJnpNJkmaXRDAYZ6GZZm21?=
 =?us-ascii?Q?penfWghaW5iAj2i3YHfrl8b8yMUWyBUJZVZzbeI53mEFS0Nrun5T/l+Os+75?=
 =?us-ascii?Q?+nS9CJXx5n8bvXOTuwvUyQYXS2pY67k898p4BLi9xAWCBVMtFjZalXcHMqK9?=
 =?us-ascii?Q?aXGktETKHaer8BkklZfpmqjROQ5pcDpyoLUEW1AsndbjwwW8dtbYf4vr0/GW?=
 =?us-ascii?Q?FgXsq2hhhxl65SzLyK6VPdilUM2jhed+R5CP3JbZKqSEePHUAC5KFUHHLKrL?=
 =?us-ascii?Q?IHVZeZHYD/qac5Qfrdkl7fgAO9oO2GJzqDMQqBGs9p29S91JoT0fdtWynzTr?=
 =?us-ascii?Q?fKM+uaJohtJVslYgHACQtvS5MmYZrU9XUIUNqkmll5nCEi8dk6I6NgaqQU+O?=
 =?us-ascii?Q?DpuFkxJtT3phH2/7Owo3fNS1AK2KG7T1RcqrKlnqM17vr8ZNald+1V9wFMFy?=
 =?us-ascii?Q?rLOOO/yu9oMVnikGRe9XsWrgkOPS7VyTunAnDHJurll9jSkj3tF4SfnuLl/H?=
 =?us-ascii?Q?28EU9IZ8Mrw5W2qLqyvcGCaUSNq8iw5Alx4NEBKnUUBJ5edwnE4abBoZzBE3?=
 =?us-ascii?Q?9aLPmJWTZYRBOOk3fFmq+Kk/+oiEIUlbEqITLX2oQOfEgFw7QDzmheu3uukQ?=
 =?us-ascii?Q?roa/6hNTr0/1XO2qIeH+tudezckgjKFzKQevU5I2FtwyIhaOJNOzwE6yTUP7?=
 =?us-ascii?Q?R/7Nx2YCx1kcnBiBWKnmMDDso8glGaaQ9oOtocATEi9+bzm0MzRKJvcPWhkr?=
 =?us-ascii?Q?7YDkg046QySPAnZHi2vTxwG9BJrM951vpfKakFx1LOe1YPjllvuFlob+r0ZC?=
 =?us-ascii?Q?17FjkTqa4kBbbwQpPIev8HOxPZRaDkoLkQIYm1Fot0ZHEPOveXdWu854Jl1z?=
 =?us-ascii?Q?3Bo87qO5Bch3N6LATlU5HyPSFk/vo2AI9D/J70iK7eiXDaCxiS0TYlgSr/Kr?=
 =?us-ascii?Q?gOzNCe6V/bNkno1G8oMcWyIE6aTUTZCwegaYZ/7r?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9e1fe8-7fb4-4ecd-9e22-08db2a9514f4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:19:59.5782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LKtDA51slfU6xxbJkQgQ88hbmycnZSWo7GEWa6GpJABVX63JITR4BwsC8dkF/srf8xYaBR0frio+yj4DRdJCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8351
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This is target for i.MX8M* System-Ready IR 2.0 Cert.

V7:
 Add R-b from Rob for patch 1
 Address comments from Rob for patch 2: drop '|' for description; add type
   for extcon, non-zero-ttctrl-ttha; clean up if/else

V6:
 Add R-b from Krzysztof for patch 1 V4
 Add back patch 3 which got A-b from Rob in V3

V5:
 Fix dt warning
 Add more properties that existed in dts and driver to address dtbs check error
 Update NXP device tree to follow compatible rule
 A few dtbs fix to NXP dtbs

V4:
 Merged V3 patch 1,2,3 into one patch
 Merged V3 patch 4,5,6 into one patch
 Added patch 3,4,5,6 for dts update
 Addressed Rob's comments to v3 patch 1, patch 4 for compatible, deprecated property

V3:
 Sorry for this long time delay for V3. I thought this should be V5, but actually
 I only posted two versions before.
 Add myself ad maintainer
 The major changes are in patch 4:
   Added some properties to address dtbs_check error, for qcom, fsl. But I still leave
   some properties not introduced, such as phy-select for qcom,
   nvidia,needs-double-reset operating-points-v2 for nvidia, which I would expect
   sub-soc maintainers continue on it.

 Add A-b from Rob
 Add a new patch 7

v2:
 patch order changed, usbmisc-imx moved to first
 Add Xu Yang as maintainer
 Typo fix
 Not define properties within if/then/else
 Set additionalProperties to false
 Drop duplicated compatibles
 Fix checkpatch issue
 For pinctrl-names: I think there is restrictin in allOf, so not list items
 Add fsl,usbmisc: ref
 Define items for mux-control-names
 Rename usbmisc-imx.yaml to fsl,usbmisc.yaml

 Hope I not miss any comments

 Note: there will still be dtbs_check failure if run with only a single patch,
 with this patchset applied, there is no related dtbs_check failure.


This patchset is to convert ci-hdrc-usb2 and usbmisc-imx to yaml format.
There are compatible strings not landed in binding doc, but in device tree,
so run dtbs_check on the single yaml conversion patch will report
dtbs_check failure. If apply the whole patchset, there will be no failure.

Peng Fan (10):
  dt-bindings: usb: usbmisc-imx: convert to DT schema
  dt-bindings: usb: ci-hdrc-usb2: convert to DT schema format
  dt-bindings: usb: usb-nop-xceiv: add power-domains property
  arm64: dts: imx8mn: update usb compatible
  arm64: dts: imx8mm: update usb compatible
  arm64: dts: imx8: update usb compatible
  arm64: dts: imx8dxl: update usb compatible
  arm64: dts: imx8dxl: drop #stream-id-cells for usb node
  arm64: dts: imx8-apalis-v1.1: drop ci-disable-lpm
  ARM64: dts: imx7ulp: update usb compatible

 .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 159 -------
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 447 ++++++++++++++++++
 .../devicetree/bindings/usb/fsl,usbmisc.yaml  |  68 +++
 .../bindings/usb/usb-nop-xceiv.yaml           |   3 +
 .../devicetree/bindings/usb/usbmisc-imx.txt   |  19 -
 arch/arm/boot/dts/imx7ulp.dtsi                |   5 +-
 .../boot/dts/freescale/imx8-apalis-v1.1.dtsi  |   1 -
 .../boot/dts/freescale/imx8-ss-conn.dtsi      |   4 +-
 .../boot/dts/freescale/imx8dxl-ss-conn.dtsi   |   5 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  10 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |   5 +-
 11 files changed, 534 insertions(+), 192 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt

-- 
2.37.1

