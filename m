Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE326A2F97
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBZNAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjBZNAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:00:39 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BA1125A8;
        Sun, 26 Feb 2023 05:00:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQ6xwAaQxD2YjXIA174oNfAKiOE0WgEVUM00elwUFb2Ym74uUj2SzRr+EymMytm2n92ynoiSrrPQjivq6b6zUwhaTBlDPCkp9Fw7k4ZhlpHjtwOwrx/WvG8tmQUyUCnloiOm/uQ7U7gBNjL3sF+wSNullVCEt6LXwzjElabTyhEUJQgXZvTIk8pK/in78Mi7XM1EGanrMhMp+uN8axzbpLYZ6CjjGF2eMx/TCzyTDgp2LowaZrVHwWox6JKhFOrmrwt4Uh6HirUytk+2IfJdEh7u2Sa/G8hdJqPkDG/qNFJ+8G4y/amkaCUTnI4xyWCJu5F7PXn4MYSFGObqj5phBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ka9U6yex9c9W5xzVhEMN+jJtYBLOLgbCCkYdYIPB5U8=;
 b=VIQmgIfblinhHmj67cgxJQLxPOrKLGDly+copGlf+kDxxXyESbP7Ch+AaRXTbugzRRf34CzCbDYYbmSVs5zWahcShcMpm0vsSZMBOF9NnvVtDZYvS0umcsi/L0X/BUbvBr+pYDCRLfKOtsPHWmuq/EtoDxzUfBlHF2StSnj45iVfEwGJkE1BqKvOGDuA7qtJixoHJRhAM1NozvvmKMa9G6CdTeLEAwVRww7CUDxAfjsODXTc9CGpxo6J1OxZ0w901pHHRK17+a4hI/dhgMeeK/9CZVlSoSaUmNISu2Lv1dns4edlbZ6qm4Aw/x3xkYPYkmVO7KQfdaYWteOldq6iQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ka9U6yex9c9W5xzVhEMN+jJtYBLOLgbCCkYdYIPB5U8=;
 b=K+23Bv57bykXpjkEDI6NK/0q0ZkO8oOru3z5X5RTwUQnme5XsnVn5kElTaBFZarXBfC8+qtsDJtA/aM1lGPQVLSbLD80X1NgIv+uwzX5/iB/PVBU3hEzq72plmyX+8qNt/tqf6CMxz2+RvN6BB3Y4R9FLfPW340q9A717w1ftoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8968.eurprd04.prod.outlook.com (2603:10a6:10:2e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Sun, 26 Feb
 2023 13:00:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.025; Sun, 26 Feb 2023
 13:00:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/7] dt-bindings: usb: covert ci-hdrc-usb2/usbmisc-imx to yaml
Date:   Sun, 26 Feb 2023 21:05:32 +0800
Message-Id: <20230226130539.277336-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: d4cb1c60-9d67-44e0-bffc-08db17f970e1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tn0kLApOVWGR+AqYCai26JD/DBbdU2RHqbAjbSl7ImkgXqo0rAIyq6TdSZpUDdedOLfeJsJLRCY6Jcgw9LYvOBS5YnUm9lvsKyFeTQkLhfTQqr5Ny4ibqwhbz+BzrIwrjc+L6ZyJJVnZxUDetLNtHX6RQSefDdnbagsUzEXDmXnZQ0UFb3O2itBIFKL1PHJ3rB9IRG4TMTiXAw5zux532ml0uKGxcY5vaCV7bGXDRr5aUPoxqTgPLxsSGWw+5ZJhKj075+3fOicSg9dUpqgba8tbn4Dcv8rXhDXpbfZv8hpUoz9n/8qsS6EdfsJQbMgwIA+53kEBVdjn7lMYwigPywBRRE9WeblNQCDbI3qDjEzt3SpUO4/nOmlDmje1oPjYrZZHxRIiH5utWEuoHY1eWqGJidMpXK5/oGqrbPnwRjiKFjeXd2Mtu7b4gGstw059rVV9qIQ/t9lIKL+8QAXSXWgM00FgnMwxAdzR+c7dVNoJtF0SDy7Yun8uF81ZQ6cfU6KScwqVmOE7namFm2FhhPvd7u7vyORVoPycHtDQNO5MPaHaHxX5+P0TDO4flSNPwZNi/Ymv7udC15UHwhVcdIGgawQT1paoVgFq4yHa36NC8TaRBYY4BKObLd2GGUEox/unvQRMqljC+m4S93WZTtrqSt8UBnJzniNLUyKL8NEjf13t5X+unSfbO59xuRJNWA9OcDeebtpOBhhN62xwTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199018)(83380400001)(8676002)(38350700002)(38100700002)(86362001)(8936002)(5660300002)(478600001)(7416002)(2616005)(26005)(6486002)(1076003)(6512007)(6506007)(66556008)(66476007)(4326008)(2906002)(66946007)(316002)(52116002)(186003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EG5kcEOsFPFom6P0Wz3u0AS+0fR1UxGa6deBnbO+f4tzzfqCmKnmYfhB2UMg?=
 =?us-ascii?Q?yx3x3WlyUoMxFyTI0gzJ0aBZxvDgOloJ47vuj3S65Xx39zJiKxx3oItABffM?=
 =?us-ascii?Q?SWykLhjfNKGW4f02hvEf25k0XEsBNpJClL808iJlIBD5WK7n7HN//vtglLzs?=
 =?us-ascii?Q?DrDjAGaZENFGXvba+kgSWxgLI2Jn/FMlzs/xQqlmPphv6GMUpAWdNLBLkYMi?=
 =?us-ascii?Q?NOsOLx33AUWJWilIFgSYKBPD2VuFXcqgrI3nd+snE4UiSvhVfOryw/nGb1sM?=
 =?us-ascii?Q?cmsqRbK7tzEw0hRWthHcbQ69QmvVr8wGzkvK04hRE5QrNBzS3XcdV43noxIu?=
 =?us-ascii?Q?h9Ly0dKq5jyKdWVy5TM/c0990j6CMg+GbmXcwUeL/4nJaW9ur+iUKVhvGhdD?=
 =?us-ascii?Q?jIW+At/oVlP048WpZOpIe+9WFVoGC6FEUrI5ZzZe1whinNmYbl7072XUDs79?=
 =?us-ascii?Q?vJd3FzYi9oitrNnluJvjFZ6t/A0kbYC8FW6EZdewlmQiYBzGmcjv54pbUzzB?=
 =?us-ascii?Q?qY3rYDorkUlowjnmB/HiFULPWz2rA3hAdM4Hmcw11EDhn2iyIzRFtCEkDl/k?=
 =?us-ascii?Q?twkJyxVD32SufQwQiz8Cr++/FpRRbzvqodrefvWWA1XCFzx1uSEUghqybr6g?=
 =?us-ascii?Q?TSVLNHlS/VH6sGmatXCoJeaKQM6YVeDPj2umcL6808oufemHGEtDamQjxt3+?=
 =?us-ascii?Q?o3uAZOBROtI+xe3o8aRQIz7o5apW20BU6yhNc2/KaZ7JAej7scLhumEvVkkV?=
 =?us-ascii?Q?emAWujIMeD35VWaVB/MuSiCtqR1MSb4qwL0mEmDSNJXYYXci6RNTIe42Q5X7?=
 =?us-ascii?Q?1z9WFzeW3qNO3AhLux980kAYmclbbxTuPoNky5jo87dsV/dOrARUyHrrZ38l?=
 =?us-ascii?Q?wqrn37eubZV2i1E0KaPhZgLS6XmyunKcc6z5U1reNeDX4bX11fSDVy1J5iNu?=
 =?us-ascii?Q?KANwyEM98c5ec6GQlm4qjY6c1h7chiCQNhwsCRQ0YE8MrqExz7N/D886nPS4?=
 =?us-ascii?Q?cG6Od2kuNwtnpx9ckKnokNb99qPVkteMx+2h3AN2cKReVst9A8YEhjoAf3Ml?=
 =?us-ascii?Q?hYdI2o2Y3BX+a0gl/xjv58QzxUvBKOGIUB1wLcp4lu+GVnn5wyjCKo30pcG8?=
 =?us-ascii?Q?Yuyf8BsCVR46ul5iPmu7B0Xs5+YwgHGWxB3bW0rN/7qXZA3VGsOl104F0uGZ?=
 =?us-ascii?Q?uUk7vEJzyTe82sYjHed7fCK49jM+9eyYysqyShIy91jgZseV56MoWbOBuqrk?=
 =?us-ascii?Q?7o9GmkkH7ci8AU1hdh6IXJHx3eGYTbyQFk1CS+SJiJH+6yF5cWiuCEyxDR8U?=
 =?us-ascii?Q?ZOnfWpGu/rYWI9iDiPSwvcjTntngaVD9K+uGNx9+Lro0m5+D3ulp3NHl8Qx3?=
 =?us-ascii?Q?8Lav5HTXZ0S2Ox4fJG1ypTazsiBasi56r7saiVJ7rFqJJoYtv4sNENn8DBdK?=
 =?us-ascii?Q?PZOOlKep4byiXNPZiB78mE+C8p0fJDOfbfmZUqqHeZY+9BinD+Uet2INI+8X?=
 =?us-ascii?Q?X+WmBkDh/f+lPfc9icdC8re2Pzbi4mosP/xGE07lnyQZ90wKG26GZm+I0h62?=
 =?us-ascii?Q?pQJXu/R05dcq52OZXFEd+O22L9u8KVhoR4FYtinq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cb1c60-9d67-44e0-bffc-08db17f970e1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 13:00:31.4788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0k7Hz5fweIhFGHNDLLCBD8VU5gygvZw3Bii9eA837gXn02Bi7EJKbID87dMzfPc3igHwDbznn1dptc9fDsF6RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8968
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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
so run dtbs_check on the single yaml convertion patch will report
dtbs_check failure. If apply the whole patchset, there will be no failure.


Peng Fan (7):
  dt-bindings: usb: usbmisc-imx: convert to DT schema
  dt-bindings: usb: usbmisc-imx: add clocks property
  dt-bindings: usb: usbmisc-imx: add more i.MX compatible
  dt-bindings: usb: ci-hdrc-usb2: convert to DT schema format
  dt-bindings: usb: ci-hdrc-usb2: add i.MX53/6SLL/UL compatible
  dt-bindings: usb: ci-hdrc-usb2: add i.MX8DXL/MN support
  dt-bindings: usb: usb-nop-xceiv: add power-domains property

 .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 159 -------
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 421 ++++++++++++++++++
 .../devicetree/bindings/usb/fsl,usbmisc.yaml  |  68 +++
 .../bindings/usb/usb-nop-xceiv.yaml           |   3 +
 .../devicetree/bindings/usb/usbmisc-imx.txt   |  19 -
 5 files changed, 492 insertions(+), 178 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt

-- 
2.37.1

