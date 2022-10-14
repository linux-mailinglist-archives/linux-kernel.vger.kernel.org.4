Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AAC5FEC11
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiJNJu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJNJuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:50:25 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B1B83F19;
        Fri, 14 Oct 2022 02:50:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHK8WySjvz2wyeUlFNAZHglR/jaS5ife6ce5vT+Ag2Utgs2F4uYzHcDm9eO8RTK/CDZ9smJTNWMuPeQhXTgufj43d5R138iksSY5kVaVCAteYDaBUk6AYzi9IyCwjkB+92+YdMOcK9JsJS6KsExXNdsHue5+F2P9I3H8J2qRT4zNlKJyMZw2dk7DblHTWAkkfYdK77nkCWmcCC6JRees4YfTSLwsjiGClB04oGfj4aMH1xc5a7RBrJ7Ucm+qzL5reNCM23ZpLVTGxzR+iRW888mK/8gy03BmGEtVBoPVnAB7h0RPCBro94x0T0Co3dcPeVd1qT0Gd0rQzW8AhLw3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tu+FNumpXaFfsKEQ6C4ezFOT5NMjchtu3oSrda66aE=;
 b=IKYH4I+geas1C71XWrSSMsMGhiIR5RBcmjxH0mCIRwMbSWfq17RV6L3PxhyIvjNN53hHKrVUq/NnJ/O/iidJewlXh0xuxq4uE3RBhYTC9Tc2O5BX4q/Eku7MnGsZVjHfhKJOtlC36VE378850WGTlQI6sD5IxMY6XB8BpWOgKGlSJrptTBb/OwpL6L/GbA0dU3Mfx37zvpMpVQOZvOau7U2hU1ZHxLmM1tzHYU1kvaaYLyq9GBPIc447cDoCsMsHn+TD1kUki15dYEx/i8WlG9GSbhmUMtC/7WmPdGywponuAqNvNZQbDJMdETDKSbZyuEQhVSbOAioPakq6M8WVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tu+FNumpXaFfsKEQ6C4ezFOT5NMjchtu3oSrda66aE=;
 b=byq9//fT6n3e7cRIAaapk+cmA5F+xBTJUbW04NcjLOy1tuRreJvWYILir94SvM8+P3RSE2HMhGoyzVz+6sjh/IYXHCWV8GndlwjbuAKo/MDeWMIZRttQWIposPO8oCDqQ/d78i9GKje4jFuwLyIQavYBGMeyUuCLTdy+9Hj+zUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9247.eurprd04.prod.outlook.com (2603:10a6:102:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 09:50:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Fri, 14 Oct 2022
 09:50:17 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/6] dt-bindings: usb: covert ci-hdrc-usb2/usbmisc-imx to yaml
Date:   Fri, 14 Oct 2022 17:51:42 +0800
Message-Id: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::31) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f33e92-ef0e-4fdc-f0d7-08daadc97fb6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bdFILy/IfGKOvs5Z7+3zDRMwivZzPWYvIdIXKVxewv8LFr9TEcFAjbQJjOJaycXjcZr5qraembvdJPAwW6D4RzxL9Lx+vHU0JAJ5sfoKKByjJ/6NqPnSD8+3yd+EMIXJJsbIMyfwPkTifjA4BRYyF5RawCrjL34X/2ER0lAfXOEVVOa9qNYwPl+wEIPaqGXxAzbhe6XoWd3ctEh4hAQTUt6OhN5kDdXomv/QMjaUFzEnojP6CF4yFR6BIColQ3u07g+zm9Vw7NiBlGXsL3daprPZu/O87iDIslZ/MzPoq39jVSNu5gP8umUoKy8Cvo1FucWIf+TBkig5zZ4CcpkG68Y3gGTp5pFVplFrA4O4QYqhtJIG33XRFU7qRyAod+4S5RRrdDdvj3IQlcKlXypY7mqLbGWQYKdutgFJKLX42Jem2mwUcX4mloifRUqcA099Fuuy/vgrTRJA9K+iiCT/E+y6cJhOsD5LkcQ45KzsS8Fm8ZtWtv5Ctm7zMeVoEIuqkkvM0PFCcdi7iI+I+X1RGsv9/pmb3D+wPIZ/wM4spGU9b6fhffjb7sUNPNB1hbb81U3sX2mk2ie7p/ZoqqU1swZs32iDWT7SGGFrRzsxXcHu6xZAuFOZbsa7Jnwk6ZYWFa1WODt6s1RIxHJMhEFMrWnR2jdNqJ1h2l0TH9EZf4auL3X+E6tZ+9Aygvl+cwqosmv/JdbkMyrqhj0vGVnZzEkpphJiEWKPMLXozU+qU0vv9SrtmKu6gKurdHxoD9uyR2r0lxfUvks6VEEvWIBAiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199015)(478600001)(6486002)(38100700002)(38350700002)(316002)(4326008)(7416002)(83380400001)(6512007)(6666004)(8676002)(66556008)(66946007)(41300700001)(86362001)(26005)(8936002)(1076003)(66476007)(6506007)(5660300002)(186003)(2906002)(52116002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YnF3gXn+rtxOVwKi4rCZL/TzEmxFSr+0/ecIB/SRhUhP6gThw/7OB/xhnNJA?=
 =?us-ascii?Q?7TrnW9g/BuYPpRRTxHs1LLYnM+WBaT667gF362WPQ1azTNbcE/87HTjP1P7p?=
 =?us-ascii?Q?9yAUpBNLrXOCjy10zEbUdDMgPxik71eFIeC+p4TTSGcwy4TtwHHdvtWSzPyT?=
 =?us-ascii?Q?S5QJ2in04UpT4D/DvveFyVMWRokBQ0UkETuC17MByNRDiWW8gMk4HG237C1A?=
 =?us-ascii?Q?vDHfsLXs5UYSr/RXqRQADBmHsjavg/OEjDaMdXeo0DJdrvnCuDs/7vmrNu13?=
 =?us-ascii?Q?JjkQYuMNZtRHjAz62roo6i0pvExKPfTlNxEVltul6oIuIiDuJttA0/KsgJT9?=
 =?us-ascii?Q?J8KnZQeWnpb7FS96V8C2xpvzZB87sZyFXRrRgr2cCZYClUZJuEMPN8qa+q9B?=
 =?us-ascii?Q?7Sv87xBIw6Yxsxiem9iuUPwTKdERLpEIqIWC/rZWXja2TxIUDi97bp6yTHp5?=
 =?us-ascii?Q?20m+/g9WpKNdSo2se122aUgiDTp1R7odPrvlIXLkV4p16TrAZVBkw9e8wTYT?=
 =?us-ascii?Q?dMO1xB7/cunqCHZaguBtdGHwuEIYtSRmRIY/oWGouu4M/y5uPZp1A++cqHw2?=
 =?us-ascii?Q?eD7wku61yYHyHLxfoHJ6zs+UhCwtAbnNcwETP8A2D4XmcLa+todgdJzDJvRs?=
 =?us-ascii?Q?Zu8Sch3GvuA72yZkpINfp/IPjsSLtVpKwCKcors0vsqA2PqQUYXnG5PtFKqA?=
 =?us-ascii?Q?1vb1vO8B5nJZMZ1MWNKZqu9UZi1ey4EhruXGoZMTojp+NBqC0DJhmJ+9KmCA?=
 =?us-ascii?Q?Od7pDUto7YRv73AEfaTMSFfzGVPp/RAXM9Pi54OpJ3A8cZMbGFwPZMr5R666?=
 =?us-ascii?Q?D9vymQnOFT5M3F2zD3lgQVHLP1Oa0jVBK57m+a8vKQbXqdbRlxg9uuyKat+2?=
 =?us-ascii?Q?6MX4FUa0L8GMpzyBbZ6zbq1673/BL25w1OcUEGtHMHad9x8+5knrE6QT/Jm+?=
 =?us-ascii?Q?Bv6lKY6hp+JTTMMUThuAqYLKHjEIkNVfXJPGHek24m9BClC9eIMRrvNrv35J?=
 =?us-ascii?Q?4Zl0e5U9u1B8XlavB1sVGy4NqkDJltTqW93ZYWLhq3nB8BM3s8lO+l+TeyxH?=
 =?us-ascii?Q?cGjwUBLB7mp5omNGw+BtJtdQLEiRK+5NPjP5R+ulVk8j+rmGReTJd+DfXZPr?=
 =?us-ascii?Q?8LwHkGmocrROP9ChXbuyvhJkKp8wvMgBB5Qc4R2gghy6iRiXZbev6BJmpA+j?=
 =?us-ascii?Q?qOA7LVYjzXsVIzvG2SwT9BhsDrOMjlGI9jPaYHM1PUppETEsIZOKwpZ/P+hO?=
 =?us-ascii?Q?3sraWJaIkXzb9dTJ6b/B5GbsE69Xz4jJfja2VaWeFO6sywpFZGw6oLZ/b5Fg?=
 =?us-ascii?Q?zATeFfoHNLvoMp/Fc8kmCXrSgW9Z6tN7Iv0gE+zGl4a+aKhjcUDPi3lMDpX/?=
 =?us-ascii?Q?wNZHV54cW9tbNBFShxMIxT+N8SqDNT9gHOwbXTOCg7xSkAP5Q/3uOdoL+hwf?=
 =?us-ascii?Q?G5NBlQ2slf9lhP2faf8ZgVpp62hPkf8egMdRlTTofxOfj7s8C3wYMfQaszet?=
 =?us-ascii?Q?87SAqscmfYk7dqAt8AiAkdiMakmaH86kxEaUOJSKQJBUccN4Q6GFP6FtTlLS?=
 =?us-ascii?Q?VJTELqxLz5Gq4QwBys8aS1//nOlPte+tE92PBRGL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f33e92-ef0e-4fdc-f0d7-08daadc97fb6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 09:50:17.5166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzV7avjnAunW7olBhcNFkjHfuSU7Q/KuKPgw89zRQ/B3dhDWY9abvjMcFfJPhD2FVvgbneyNlWNeIwznXFIn3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9247
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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

Peng Fan (6):
  dt-bindings: usb: usbmisc-imx: convert to DT schema
  dt-bindings: usb: usbmisc-imx: add clocks property
  dt-bindings: usb: usbmisc-imx: add more i.MX compatible
  dt-bindings: usb: ci-hdrc-usb2: convert to DT schema format
  dt-bindings: usb: ci-hdrc-usb2: add i.MX53/6SLL/UL compatible
  dt-bindings: usb: ci-hdrc-usb2: add i.MX8DXL/M[M,N] support

 .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 158 --------
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 357 ++++++++++++++++++
 .../devicetree/bindings/usb/fsl,usbmisc.yaml  |  67 ++++
 .../devicetree/bindings/usb/usbmisc-imx.txt   |  18 -
 4 files changed, 424 insertions(+), 176 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt

-- 
2.37.1

