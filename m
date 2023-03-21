Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941296C2CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjCUIsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjCUIr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:47:58 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04879497D8;
        Tue, 21 Mar 2023 01:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGeVHlkrZl0IlnBKA8gOOWgecXUxNu3K0/kNpbMLd2JLPTwbnFL1XnyrAWXq6ty/fiQLq+N0MTNKqQg8+eg8eW86TkXB5Z+QrFqxjbVgxF8DkH8sYCK1vJZKLRCnDOU5aYw4bhYxGgvGcxpJaK2vBTjiZLz5ivrukXLropdT8DF7haNyisTANaKyYE9XbBKzBxK3U7Y2Qf552TqTLTfZIEPLRl3Sik+tM0NfNgKO7CyRbxXcanfAMeeOV1xAMKL7nXNFh12zpQgga/B6fcKG7JN4KDYRrQxzjr6VHjKeCx8loY//GAP7kkrC9FqMOGKBimW45pykVhf5MJXH5wUTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7qRzmrqVGtNdwFdjUzGULAXUH0p1QxsxHmlky9vDwo=;
 b=h1fShB7BjHVnc+blMthdW76yqdLYxy13m5/2CGgf/pxYb+qB28B+j+9nrcJny4xccL5y0G9WEyr7gs44XPrkmoc8jI0KOxHCIg8lfwCUxifnL7mS5fiHiEYocy5wYRWOLFoZZFKaedluVt6Omb+8uPgKKNT8Sy1KAl4ATafLFOZtGX25ZpRXdd4l+/1OW9MwRrYbLuqfPTaGh7UhMjEfPtuxfH4CDpCGzKslwp2p3/o+TgOI3fPGNKzRda5c9nCyXP7855vgpkIEyY2R8o8WLRx3osszOhQ7el3F+IhdWPnu68LoGqjXdDgu0AC24HAFNCYkP17Ai+eOADomG3RIGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7qRzmrqVGtNdwFdjUzGULAXUH0p1QxsxHmlky9vDwo=;
 b=Ez/YlTC0VS1BhV2MGOCfuYxP0d+T13LhILi5nKX9tIa7bz+Bf08sghreYJNPLZEr1KKRTSdA/0kwQQw4PiDSS/e/bxqt7uRaRjhI7jXGIzaywHg1P+HDtsAAs1Kkk3Graa1rmvOZ/N3V2TuLD3AvvCYmwxJUO8e+wQ1kseCdX3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7849.eurprd04.prod.outlook.com (2603:10a6:10:1eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 08:47:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 08:47:10 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 00/10] dt-bindings: usb: covert ci-hdrc-usb2/usbmisc-imx to yaml
Date:   Tue, 21 Mar 2023 16:52:03 +0800
Message-Id: <20230321085213.1624216-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 292d2f90-7b5b-44a5-b005-08db29e8dba8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v2YDkgXslTykc4LwuLDLsEw1ap2wWAaHzfmLLiRwWFd4LGVEYInCe2ylGfM7WaJtd7PDwZFjcpuKKvm6qaFKvnmF4ydHjODrEFN/OCE3Ax9T4byikf+4Iw4PpyhsUZFuzPsaZ25lLthdqWQV1Q8kHaOLMwdYRIMe5je5a4HQeHzQvhNC7WqCFMPuFWq+7nctvTlX4MJP8XPT9LysMLJIBVvufOxFsMKYwJO9QAq4+g/4eGnYc3g50j1iealuFnKuGX1LYCPJY+uKKDbLL0l5YQqKyigM8dG4FBkOPmDNLCl9sXp/SSANdJpWaEceFLR0MC8IE6drJfaR0qq6TukkoqQSR+6zt7z5JmpVBcVNkO+CRfYyswZIkBY4h5bdbfhwbO7zgkoeGEYu4iy1sCYG8QWl24Bto6WK/6EMyoylHG3JT5Mb7QjAuZAPhAJX+x9ysSaiZQeTx2qzjVvOaY5lpr0TLHVPejT+XMtjF/v83QUqBIhlFV8BWzxV3J7ncw7HW/2kLBjKdHjEyILfmFmQGSHaud/0L9LyxdcGgwK1pUuSpiEG3rYL5cpq1d2c+ehSOKVEJjgJ7OUT+Wyxij5MvruHbpVDYt5lAN+A7Lg/DMHEJIgujtRy8/Ru0gmBIwETqStVSx602f4dsRMjTNkl1qU5xgxvVHE+Xg/VB59/c5BhpwlgQcLbIeLKa6+rsLJSGaIEa+gMFzpfEWyN1YiqtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199018)(2616005)(6666004)(6486002)(6512007)(186003)(26005)(6506007)(1076003)(52116002)(38350700002)(38100700002)(478600001)(2906002)(83380400001)(86362001)(66946007)(316002)(7416002)(8676002)(4326008)(5660300002)(8936002)(41300700001)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gBnVLYem/PuQ1q9FYqOKiQqqcWB+4rnZq+nTLWi+A9500xi8/Cao2W8fOt29?=
 =?us-ascii?Q?WpODnDyGMZxKRQM6phAO6HTzb+FwAGvYT/Lt8RkGtdZfIjg8IxO/EVVx7l+n?=
 =?us-ascii?Q?sHxVdFqERCkJGCOsWS3qkVyYKz1cYnRiaCiVmGGw+83Fns7qwDclJ7F8+5eF?=
 =?us-ascii?Q?DaM9Ywvygy/aDlwaROmaaa65vy0vF2OExjsP9sJL7OURtajBuIX14XYEJFFy?=
 =?us-ascii?Q?AAyyjRUndEMxfbrr1PnH3uPOeFHCiA4dbWfKlB0pquhDBvpZSBPctl9Ug+Vt?=
 =?us-ascii?Q?3E6nGStfgqyEHPE8o1KWNufh8myj7vaxYRaWtqJDm8xyTKPfR5II2CPBdh2o?=
 =?us-ascii?Q?kOeMVTp3Y1i50XkxaX/FZ1sYwGNuKJkXL5+T/dZZOWLhf03HBaRNCxCnhBSq?=
 =?us-ascii?Q?pxaHSHHpMzquM3LfT3doxJEwpgiP/Xx7wK/fC4T0VZEhHVf8w4+jya5GC0nd?=
 =?us-ascii?Q?N6euP14tEGVz7av4Y1+DdfltmpG81L+lUh6zOfY+/9pHPc0yw7UrJ7ZcmpVV?=
 =?us-ascii?Q?acm0h6lQ7w8qFqbEhUxgITuT87K0jae763hNN1w2yzhAwa0Jklc0nWzQpSai?=
 =?us-ascii?Q?41vhX3ooV9C0uaGoXyllLNIakqmjqFXbBsZ+nMWHHwpcxWctb3N9l5cbTodI?=
 =?us-ascii?Q?KuKegQrVa3xxthxsrHMESS01qJOGUHfrTdAFiwto/fI9Jg4urBA9xVcXfrA2?=
 =?us-ascii?Q?0nOKnuKbktKnCDsSLh32CSLroGQxHEsDjYEv4vFoHEW/i/1QhAlF9/TahuIc?=
 =?us-ascii?Q?0kJucQjKTmjSZjYLKI04D/sPNsAfQCAXYXew0lzqc3sgji3nvZKjf8sGHDYp?=
 =?us-ascii?Q?RvC9j0qFEBTpaoZjOV3XLx3V4NK1LTlHV5/6qmHtldxjAmg0yrKAZgajgX4K?=
 =?us-ascii?Q?7lok4OiLjVK/A12mJGLWirZi//HF/TFIFx+CUXe+I9thkrUTQ6R2dPeiaClO?=
 =?us-ascii?Q?TjcldlokMaZvdoz+NJ/bmc3SLtCUJanSiwulrNURxujD4Rg/i4CEG6+dSY4v?=
 =?us-ascii?Q?YoEBpZc/P6JGBAW14AstDjAcCBsGoqpg7a0vQwXRuMKx35fdLK1nTpeNbC//?=
 =?us-ascii?Q?h1FgjH6bf2n7IZa0EOhQaWFN8EL3m9Gpq7C6WEpajMyfqz/WcznxpRre/Xya?=
 =?us-ascii?Q?KWXHWv6aYxGGZQLtY99PkCUXpLhNY+D8nIftVnU90qoC8mhhBlpLPgeIryex?=
 =?us-ascii?Q?VuVhfcMJqtk7yRuAoA0Uv2xCeYaMNRpDpiMlgarNZUd2yYHXl2MEpy8mRvc/?=
 =?us-ascii?Q?azggV+RCfexvNSkrmLaCeJpHFWpZkBftp41Ak/YX3QJiJh/RZl8TkTgbFWGf?=
 =?us-ascii?Q?KI2lN6yfpfWUXYdXbwtpP9aLpHv7T3IhIFBs3LaZIqEveoccjIwJzD6orSJV?=
 =?us-ascii?Q?mxqlP8GphRTF9Y8qBe2FWxIWZPCGlm9Mak1P/8zF9GzIN04V0zBbEMqJxLNk?=
 =?us-ascii?Q?GtZfAv/I3SkUN6VgGyhdGHh1m7fdo+fEIMogpBZyCZAv42G2EOwKCpQU8P1P?=
 =?us-ascii?Q?Po3uVVVQqNmlWt+ZRF+A/+94kK+DbYJUByI9HVb0XzqIrCGrk+Yt16gCVTQJ?=
 =?us-ascii?Q?eh/xCuuKkOPqCzKwXEIicQ79OzCfvpTk1BMHkDht?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292d2f90-7b5b-44a5-b005-08db29e8dba8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 08:47:10.2004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFM2bmQVNpp0JV2tFExQiifBwimESDIpp+nHEMonOQpU8721ovP5sTO3U9j0U05DiZ99aiIEAM2ffTsXhM/rlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7849
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This is target for i.MX8M* System-Ready IR 2.0 Cert.

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
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 449 ++++++++++++++++++
 .../devicetree/bindings/usb/fsl,usbmisc.yaml  |  68 +++
 .../bindings/usb/usb-nop-xceiv.yaml           |   3 +
 .../devicetree/bindings/usb/usbmisc-imx.txt   |  19 -
 arch/arm/boot/dts/imx7ulp.dtsi                |   5 +-
 .../boot/dts/freescale/imx8-apalis-v1.1.dtsi  |   1 -
 .../boot/dts/freescale/imx8-ss-conn.dtsi      |   4 +-
 .../boot/dts/freescale/imx8dxl-ss-conn.dtsi   |   5 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  10 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |   5 +-
 11 files changed, 536 insertions(+), 192 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt

-- 
2.37.1

