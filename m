Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E496BE93A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjCQMcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjCQMcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:32:09 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2066.outbound.protection.outlook.com [40.107.241.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BFE6C8B5;
        Fri, 17 Mar 2023 05:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJohECUj5Vy43o0iR0KQPOPGoO/WaZ5EEm3iWb39By9uSMKDSE7EEcez6ZU+rx/St2cXt09DIULwXt6LkrFWE7jmMDYP1KQJ9WtMqticsAPoyp2+ziUzJPtALMPbo/LeiBnoMbMXSf4kO8J+V/8xtrScxY9DWIMhjU5ATmI1yfCwXttrxzyMmBQIIOXXWDTqH6Bgmlvm2v3NCNyTXm4sqt/9qlM9ETc8XE5DZsTWaKha5BdrteJnU96YnIR8dwqXT6s/220qt3db32axkZAAerHgwk+KwH7eeR2jcD4LJsR7XIoSbb0hUM3RyJjstu3dJQi5tOA8H4EEgndvsPTt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5GlWoW0LmToNwGdzmrAbrAN4NezCSBLlqBfA2gUtuQ=;
 b=OdX+uSUNIiud5HnJzm3owNDNmrv73OE6aP5mmamO7gRmZgaxoAav62bov/rQ8yDW8as5ZghfDTDQg+PIcVqrXFVeCUk8R439pRseRnKwuH/9mADP4voBk5kkGbXX1eUGvBAFDTGJiajAM/BFa+5UNrRYWenC7LNdoBNplGVWnj/dHhzL6E8qG+4Q4cJtNQuiV/kRSMoUY6jCCT/1URN1l+VLQO59B8w0bVvcYkCacNBzO1GFDO0Z0ypNquh1rN/1BQ0vv1RO4nt1QDUzTzmnqmWSqvxYmFnVSqrAWXqOxa/I99YNA3CVpZeyuRjI4JbJHGVlEC5RdLO+/LNnfOswYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5GlWoW0LmToNwGdzmrAbrAN4NezCSBLlqBfA2gUtuQ=;
 b=kC5WW8hXUJKLHsGeI83k96csXIA+CukYS4SBiixyFpsJF2f1zv/PpRgK+gnzJFQYrKJNMrN6FHtkL7sdlSRkerbRjqvSHQEyOL3/6fHY8FI+YRkj0JwpUMWhdKPtgeycWQmoGDRRyok1MCkfKa7E8aqKmP/2sl73+nWpGwQk1wI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 12:32:03 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf%6]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 12:32:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 0/6] dt-bindings: usb: covert ci-hdrc-usb2/usbmisc-imx to yaml
Date:   Fri, 17 Mar 2023 20:37:02 +0800
Message-Id: <20230317123708.337286-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|AM8PR04MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: f7949103-4357-469f-2dd2-08db26e39c4f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q8BMdfsgKR1tg8hrIDR5l3GFQc5tlw37pkx1WsHUfSl9WKzDY3meTJi6BXdoCKk70UNFFkeL2zDI94sth5mProM+7+pyaMwL3tt1xWdsq975BbxunuM0goBgoEWCkUVHkXivqSv+Z+6n1bsDIFbyZS49jaJ6anuI2JP7GEno02WiETJdVkYIGTQLNph1wfOIwwPX63ntJn5UI0wt8urloN7Awl48mPbmLHcGOBAFLNmrFgFhYSK1CM2+tkTkuUp+L9CZHnuKubpppyoYNJKG0B6pOgQjCQYfHDWjOqFYxsjveQy4jbutNjdTsCIBGYVVZlfrkssiwshb1WCHbrXPD8vt2PEfxStEztMYI5/mvPr8pmCSduG9cT1C28cfSptNPCQMJ+SP+w4SymMtKTPgRzyoXwBHMiXyElzx3SAFVVO3Aa+JM8WJhdOpnsvBtIiOpnDckBgpTPVK96FzQegUAtrV2ZAlssnrd1jB7riif0scQyH0EI3ogCFZ034ovUXXer7wluzaSePNK/UerpL04jJC1x6/IOs8u2wY3Bqpdnwyn13qni4tPU+Xt6Pc47OCwTsQsEzdcPik6P+36qqUEAhg64IxGVG+EecmHu01DXbIwpVIkJf65AaMj6gGA9UIu2+pu0M9C+jBOugp9VZUAz8KOaSS+FmrvcDVuRcmADeGdLS3dL8XQebLkIMLJCW4q9Pj78stpJjg652sCOuW8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199018)(38350700002)(316002)(38100700002)(2906002)(478600001)(4326008)(8936002)(5660300002)(41300700001)(66556008)(66946007)(66476007)(8676002)(83380400001)(7416002)(86362001)(186003)(52116002)(26005)(6512007)(6506007)(2616005)(1076003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kc8yGJf2TSA+zwH7xBIzYoV6QDEu3d7Ax/glGaM/evoKtrBAKBIoB7JLgKzf?=
 =?us-ascii?Q?vTWglS3GEazJhU24nabQkwga1KKd3uGe+7Xw+Tl7eYGpcFCw2DDbhsVXk7UH?=
 =?us-ascii?Q?2weQ7bYwvAQOlL3Na6ObygzmAWFhBCb/VbGb0WUsIGRiQS7LhKE2n9DrwHTW?=
 =?us-ascii?Q?rPtux8beuwfCkcRRwTXPo9OgLlmCFB5yftI5yibbYtgK9GQLqrB5ypfLgvT9?=
 =?us-ascii?Q?llRxBIC3KPmQ95sJBYm4XdCf+fmweyD1JygJzcPivSyR6HSRtAJ3T/sEQ53Y?=
 =?us-ascii?Q?wrW0snjz8SeB6KYHg/JSpRmWoewxRRIYeOaJmD9reUoUIR6E/KoMRLwCDqkT?=
 =?us-ascii?Q?p8CPK/5V2UWm/hacnDXOEWSw51k+PQKNR7Jg6H3J/tIbTGPeHdNw1bq/Ic6X?=
 =?us-ascii?Q?T8RJ6mC3QtXSJt+2IJwALUd/gaWpgibXl9NHxunZT9mz/2DYQDiDPN2yyO2Q?=
 =?us-ascii?Q?fG3ly8zfT53SzDB2PXtv1RkRSaGXZrJaJXGL9QGIQl9CfYKmjsNdEOy1fK4Z?=
 =?us-ascii?Q?OsaeWR25pFHrv9O/bU2EPjBZu1Ky7K9y5iMQDzYFphAgAsGRnEppp8ciRvwl?=
 =?us-ascii?Q?syXH5PR1vUtAPOyra8VOWxicDs+PCgzATMq57fDJnmhIHUGnMSRDy0/mBNPy?=
 =?us-ascii?Q?s8vTckrw8zBKXWpZbJVarH98k6hSuJEQhBz/rtvhLvYORYLLkBNIm0Bc2V/d?=
 =?us-ascii?Q?EBB9tb1zIcG5JHU5GDuHTxBWWV/vMa89KY5Gng7EVhQ19CD0nOF4R6Q2j1EU?=
 =?us-ascii?Q?fsXJ6LyJh0t35xmG7IilSBK/Q2fQ8BrNzVdTbz0sUQMInARJ0cQdIGVmw7nk?=
 =?us-ascii?Q?GYOip3ECvfsDA5i3QlCp+FUU53CzE2J98XJW9CxbZapQQ9rFhIlJfXhY6+Gy?=
 =?us-ascii?Q?CXkO4o6GtJCBLx4Cr7+qS6nIwhuM76au2wtcwG252xEKU7ozorLZIbIX5gUQ?=
 =?us-ascii?Q?07/JwzReyVFJaVFrybx9kU4aTE+8upMdVWV88MoQFdNxR2QTWLBessQxjq3R?=
 =?us-ascii?Q?GkUOT+Was1dYLh0m+gNlAo5NE10Vgi7zItHVMpB5VYIOLBvV2D13maTDfLcL?=
 =?us-ascii?Q?9Suw5F1qVVjcb3Le/aUX8Xlo0jlaWhbEfs2G3QnmdgyBbPzbZEcDt6rcYBO5?=
 =?us-ascii?Q?q4lljTWfulTQDSfuFQOrP8oB+ebAnN/QgVz0mbNLa6OAhr3/k71vZusqBpuE?=
 =?us-ascii?Q?nxRMi9EG7D6k/ebexgFbtaTWZ6ZP60KSPk0exj728YFfjH6GYNqLpXuuY4nV?=
 =?us-ascii?Q?sk+jKAcITguZurtnVKbtUOAni7By9vmbT/1HF3AyV957IDLvka6qnrSpxvmT?=
 =?us-ascii?Q?zgo0CM9EtWy3SVUIZbK9AP5xjisw8IONhesgs8a4fRurjg8qX8o2CV5S/yWU?=
 =?us-ascii?Q?VB1EZxAKqFLjUFJ4OVYB2tKQ2zPQFD33errsEwzYsDuxszIFXeIVAXuJQxlw?=
 =?us-ascii?Q?PPkvoThpJh/Om9anJ938sqha6MB5KS+TchObtXiDR/ZGp6btiwlCgfcaglHF?=
 =?us-ascii?Q?TAZ4dZi0OeKyoiIDZI86ee3r+xwX3zuIgcicESbLPrzJYazleFMOOXhgln0h?=
 =?us-ascii?Q?rFWu+QjIxd4z/MQVZfP/1enorYhvAzP/sSf5sHDb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7949103-4357-469f-2dd2-08db26e39c4f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 12:32:03.2265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqRMxeUnryNb13Cc6G2yJxfUCEliPFhUx4Ob96+3IOlOFy72R0bR7OO8vD4jsR8lUaJUBWdzQdHo5Q34Rdu0aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361
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



Peng Fan (6):
  dt-bindings: usb: usbmisc-imx: convert to DT schema
  dt-bindings: usb: ci-hdrc-usb2: convert to DT schema format
  ARM64: dts: imx8mn: update usb compatible
  arm64: dts: imx8mm: update usb compatible
  arm64: dts: imx8: update usb compatible
  arm64: dts: imx8dxl: update usb compatible

 .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 159 -------
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 412 ++++++++++++++++++
 .../devicetree/bindings/usb/fsl,usbmisc.yaml  |  68 +++
 .../devicetree/bindings/usb/usbmisc-imx.txt   |  19 -
 .../boot/dts/freescale/imx8-ss-conn.dtsi      |   2 +-
 .../boot/dts/freescale/imx8dxl-ss-conn.dtsi   |   4 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  10 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     |   5 +-
 8 files changed, 492 insertions(+), 187 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt

-- 
2.37.1

