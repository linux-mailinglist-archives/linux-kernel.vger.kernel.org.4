Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256C96DDF3E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjDKPNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjDKPMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:12:31 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CF03A97
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:12:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSicR86rWE+WkZSsNF6E4nGkjLSdD0uSGw49iRh52DVoUUXxDgAVZhFgAJBjDdDi5z/FH7r1AhILeLZ0JAjNmZgXlIMG15dgnnFm4HhpKPw+5vwcjlbSpcfNRV60bm3b0aHy5QJSY7EFbhkP8CR3ff9E3BV+pF6qrZPdWr/PlCTEIG8O/+R9K0EYHns1D46/fZrpuEMyVuDT3cCCapPk6qLCsXfXHC+ZbwEHcqYo1NGfhRShRvAfPMUtnXsTz8kavvWQtBmNi7rCl/8nGn+oMJYX7VO3XRfoIFymVUUTWpk/XqBGv7d2WUiwe9o4OOp/oVuOe3e7R+bT+C3LOwcx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMpnbrLzmqLGPrUT8GUVNw+op81ZlmfpWHZy6aE1eq0=;
 b=Dh7j3r/bCMl3yTC5TpiPPkAShLo8e1VLOjGgQH2y5FgFjUAfNWT3ixPsGlY97bEVPFcIIYN6lBFdBParzu64CVLEkklZpkKCxtqAkzmj78qIi8jYmGE/FirWuim5jv/E7nU2WzqPiugoP+VjU9j5oF4FtV0FnG0sHmykt1wRjHSX9zMOfs+6OfAHVW5oH7+iXQgbubBFiiS4zKGuIVCE2CaoQ/rOQkYXTMHe03pqvzxeKvQVhVvdlgoPxaz5jyvLVbnjCSrA1waDTzEKpThmdgfXFD7xlUuDtRxIAlBGeeth2gwepN++ZltL9NLJo6UTBcowd/der8eQiXfPN5ZILA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMpnbrLzmqLGPrUT8GUVNw+op81ZlmfpWHZy6aE1eq0=;
 b=aKQkHSzzBb8r5FsDIsg5kT3jTxhAcUtWdW+SYjitWDU4U/bWxS8iWvXsM7tM4uklcz8wC6+abNXBqaqdexuf9theKmf2U4BjNEs14f1Cj4Jt9ASw1dWMF4dcwnGA862MtLJ9dXPkbTo+/G+H1DXBuDElztQfkcvM4DELFn0u0fQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by VE1PR04MB7454.eurprd04.prod.outlook.com (2603:10a6:800:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 15:11:39 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed%8]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 15:11:39 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gaurav.jain@nxp.com, sahil.malhotra@nxp.com, aisheng.dong@nxp.com,
        V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [NXP ELE-MUAP 1/7] doc: device tree binding addition for ele MU
Date:   Tue, 11 Apr 2023 21:55:30 +0530
Message-Id: <20230411162536.30604-2-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230411162536.30604-1-pankaj.gupta@nxp.com>
References: <20230411162536.30604-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To AM9PR04MB8636.eurprd04.prod.outlook.com
 (2603:10a6:20b:43f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|VE1PR04MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a775dd-0f53-43f5-839f-08db3a9f0cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTupujyoOKA7zuIn385Q7NcrbsS67YfiA9pfPzrYry2TdveIJjDxI/3HZJykYXC0ffxhFpuyktMCXLdG81vrUahpghqGxzZERu/TPs/AVDxDzxUoN4TCXHbq/C4DqkaUCdZKrIX12WMj2Bz2UzqQfdv46b2EG0VRi9aE/srdziEHHINIEAFhtXmO+MNd6I9bqE8FtWqyadNFbYSLpUqN0eobrBWr2AKw7vwKFHGfObNT2ugSw1rpmEGPOSTjrJSbTmFBDyMt5qyVEf+lRscmsmnGubmhf5igQcTSv5R253+G21jUZmOb7DU3gGlg8vQ//BZHVJ+ZqhgK2998Tn0h2aGQmWxAdhj4tIL59tjKr66bqdSRMBIW044DTf2UjpCBjOUDqnkBZkoV3u6d06K/5bBZ7AorA39CHn6TOVVei4toz49VDkmbZ4BI9BX2cFcBUGeQTFzYayNPsGxfUMhKfGOgFQLY57WGIU0iRO20WphOEVDJ5wYJxrGQNgwMvaHScXn/cphXKXTNQVJkWMXbQgQCahi131gWBMaEwyzpyNUm0pXb3q+x2fN0fwXDqkTpViFMbR/BG0G++8U+wHHuOQ0DyICLSZKkHP54gSon8YVfyPSQ2Vbf+QnNEWPcfish2KlUJBp8rYXhbTVAUICqS5SNax+7yJ6PNA7MuzEVpvM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(6486002)(478600001)(966005)(4326008)(52116002)(6636002)(8676002)(66946007)(66476007)(66556008)(41300700001)(316002)(86362001)(36756003)(83380400001)(2616005)(26005)(1076003)(6512007)(6506007)(6666004)(2906002)(8936002)(44832011)(5660300002)(38100700002)(38350700002)(186003)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NYqmayL6mr3iVxLMImAfxudfcXuFYPkq2mN87AGsp1yuH+qh2Vugdew7ew4o?=
 =?us-ascii?Q?+4SczvPb6TEfV8gb9Dro2gCfh0txWneus6yF4kta4ussu4kFc+WvtwhP+5Hs?=
 =?us-ascii?Q?vPzwiHZb1/2Xd0JsHCKZv13MebuQ4q7f9aTE/4lAWWx0hMPETuv/F7YNolgd?=
 =?us-ascii?Q?16sRfelBuLVYIf2nTJed4MTLPij4WWr+I4c4rvzdihy/lLxa622KPiz1edWf?=
 =?us-ascii?Q?UbYk85kz/ktL75nXUm0Iu/kQxYamSs7JTCivX8oPohk2PXyKCQfkvDXHOolw?=
 =?us-ascii?Q?55kwEUopFbSA6Wzd/t0yBxopfW7JveJBI+Fd2pmNayrLVoaDL7WyHFwtPw63?=
 =?us-ascii?Q?IAeC3LFKFZVJPZJsKml0bZURThApFO+iOG0C7iNRx/O/jTinbzeNHHV4oa4g?=
 =?us-ascii?Q?cU30n5pSJFGH4mggqw7JqViZUXIL+uvlk2Ej3LtkNYtbGJDumgk1QqsDebSP?=
 =?us-ascii?Q?x278553YWr0Qv3sr2PlKXFHTnFHFjzvwFgygIkB44C4iB1uweHDnKuaN/ncd?=
 =?us-ascii?Q?m+5rz36YmI+VopCnICADiYwSTr+jPqDzfWmrSIM0qEGQ/UYpTrF46juvRLyH?=
 =?us-ascii?Q?c8ma2iNevLBwetKRjoINOWGxBC/RsVyHa9l+FbMBHD6PbA6UMMJ1MEmCzRad?=
 =?us-ascii?Q?WQ4QYlol4cJ1j9c7mpOJ14ckJ8KOai1lApFmdXM1exTChxVH0x2M/b/DKnT6?=
 =?us-ascii?Q?yGSIokp9DnE5QhqxzGN7zr7XPtVqQhiP6KawyrH7KvhOLaQFMs0z7bQI2XE0?=
 =?us-ascii?Q?cZW/P5li704viUf13acCB23DYtS5PICrcpUVYppVIgOighlXtGEhbJWDzZfX?=
 =?us-ascii?Q?egSrwH2e+RJh1CxqKHqfAN8kkNqOCoTq8WsGjOaKP18KVXNtNsM2kXY1Qm9f?=
 =?us-ascii?Q?JmAxgByLBz1eh933cH6QjxpTUnAxTCnIagwapvBtITo+1HDAIAMaUtYsppcp?=
 =?us-ascii?Q?tRqJpB+Rczf2GMeSoTwhr8s876Gg6Z84DEOrRQqLrrK4gNyIG/WU3Uku0kxe?=
 =?us-ascii?Q?05Oxn25F20P3xW25Yp9fxSgL2A5DInqy3H2db8LVkJdr3dqDLobyERyEmDXG?=
 =?us-ascii?Q?nxzjon6N+UVd4bVIsASWUXbGHlTebTiZ+tEeyFJbmwvczZZjpt6r9cx8wxLu?=
 =?us-ascii?Q?wwmq3ZwkPXeKSZ7K8gHCEbVxFMw7UJ11fXnBx+KA4cxL4ZBGqiG5M8Y+0Aet?=
 =?us-ascii?Q?9EpZKBHXqWB7QWozemi2zG3N66QZQGAZqD+XtOeau8IetccEaIIuzt26upRQ?=
 =?us-ascii?Q?rAXmgkUPGSbxaezBMCdiQczqSGqijaIv/KYsqQ/jvZO+CjlKzs7AYLkIRbn2?=
 =?us-ascii?Q?eQ1771bM6CWfsKSBDOTeyLwwB5fXXKm5xoicR4TyQCN9Z7SEDrbzIO2U8rjy?=
 =?us-ascii?Q?N11wulQ+8LASrMkO62OjM4buiXBcSlhdERvnpD+NWogJASof5IJVrGC2pJ3i?=
 =?us-ascii?Q?e5Yk+Ruu6HSpl8xVdmVzwnOJ2rGqrwtEX/4Lr8c/mS/bdr6vINU5WwMUhsnO?=
 =?us-ascii?Q?FV+z37hfC74fzXUGUt3wPvPi8hJ4WCuKqTJByxnVHfIjtji/FsXWEVAW9XJm?=
 =?us-ascii?Q?9Nz307PTCCkAeJYlHa42dPZQojE+XQwew+Tc+HrJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a775dd-0f53-43f5-839f-08db3a9f0cce
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 15:11:39.4814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2bqKEgJRo5ovlbaYGix3l4anVdnRfGAZmZPaGjrjxIja+Vm03BikcaMJ98wKzCFSgluAQTHxQJN48OBbApABQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7454
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation update with addition of new device tree
for NXP ele-mu (Edgelock Enclave Message Unit), driver.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../bindings/arm/freescale/fsl,ele_mu.yaml    | 90 +++++++++++++++++++
 .../devicetree/bindings/mailbox/fsl,muap.txt  | 89 ++++++++++++++++++
 2 files changed, 179 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
 create mode 100644 Documentation/devicetree/bindings/mailbox/fsl,muap.txt

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
new file mode 100644
index 000000000000..8f75a43aec26
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,ele_mu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX EdgeLock Enclave MUAP driver
+
+maintainers:
+  - Pankaj Gupta <pankaj.gupta@nxp.com>
+
+description: |
+  Create char devices in /dev as channels of the form /dev/ele_muXchY with X
+  the id of the driver and Y for each users. It allows to send and receive
+  messages to the NXP EdgeLock Enclave IP on NXP SoC, where current possible
+  value, i.e., supported SoC(s) are imx8ulp, imx93.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx-ele
+      - fsl,imx93-ele
+
+  mboxes:
+    description:
+      List of <&phandle type channel> - 4 channels for TX, 4 channels for RX,
+      1 channel for TXDB (see mailbox/fsl,muap.txt)
+    maxItems: 9
+
+  mbox-names:
+    items:
+      - const: tx
+      - const: rx
+
+  fsl,ele_mu_did:
+    description:
+      Owner of message-unit, is identified via Domain ID or did.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [0, 1, 2, 3, 4, 5, 6, 7]
+
+  fsl,ele_mu_id:
+    description:
+      Identifier to the message-unit among the multiple message-unit that exists on SoC.
+      It is used to create the channels, default to 2
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [0, 1, 2, 3]
+
+  fsl,ele_max_users:
+    description:
+      Number of misclleneous devices to be created, default to 4
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
+
+  fsl,cmd_tag:
+    description:
+      Tag in message header for commands on this MU, default to 0x17
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint8
+      - enum: [0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e]
+
+  fsl,rsp_tag:
+    description:
+      Tag in message header for responses on this MU, default to 0xe1
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint8
+      - enum: [0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7, 0xe8]
+
+required:
+  - compatible
+  - mboxes
+  - mbox-names
+
+additionalProperties: false
+
+examples:
+  - |
+    ele_mu: ele_mu {
+      compatible = "fsl,imx93-ele";
+      mbox-names = "tx", "rx";
+      mboxes = <&s4muap 2 0
+          &s4muap 3 0>;
+
+      fsl,ele_mu_id = <1>;
+      fsl,ele_max_users = <4>;
+      fsl,cmd_tag = /bits/ 8 <0x17>;
+      fsl,rsp_tag = /bits/ 8 <0xe1>;
+    };
diff --git a/Documentation/devicetree/bindings/mailbox/fsl,muap.txt b/Documentation/devicetree/bindings/mailbox/fsl,muap.txt
new file mode 100644
index 000000000000..6854ce3467fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/fsl,muap.txt
@@ -0,0 +1,89 @@
+NXP i.MX EdgeLock Enclave Message Unit Driver
+=================================================
+
+The Messaging Unit module enables two processing elements within the SoC to
+communicate and coordinate by passing messages (e.g., data, status and control)
+through its interfaces.
+
+The NXP i.MX EdgeLock Enclave Message Unit (ELE-MUAP) is specifically targeted
+for use between application core and Edgelocke Enclave. It allows to send
+messages to the EL Enclave using a shared mailbox.
+ 
+The messages must follow the protocol defined.
+ 
+                                     Non-Secure           +   Secure
+                                                          |
+                                                          |
+                   +---------+      +-------------+       |
+                   | ele_mu.c+<---->+imx-mailbox.c|       |
+                   |         |      |  mailbox.c  +<-->+------+    +------+
+                   +---+-----+      +-------------+    | MU X +<-->+ ELE |
+                       |                               +------+    +------+
+                       +----------------+                 |
+                       |                |                 |
+                       v                v                 |
+                   logical           logical              |
+                   receiver          waiter               |
+                      +                 +                 |
+                      |                 |                 |
+                      |                 |                 |
+                      |            +----+------+          |
+                      |            |           |          |
+                      |            |           |          |
+               device_ctx     device_ctx     device_ctx   |
+                                                          |
+                 User 0        User 1       User Y        |
+                 +------+      +------+     +------+      |
+                 |misc.c|      |misc.c|     |misc.c|      |
+ kernel space    +------+      +------+     +------+      |
+                                                          |
+  +------------------------------------------------------ |
+                     |             |           |          |
+ userspace      /dev/ele_muXch0    |           |          |
+                           /dev/ele_muXch1     |          |
+                                         /dev/ele_muXchY  |
+                                                          |
+
+ When a user sends a command to the ELE, it registers its device_ctx as
+ waiter of a response from ELE.
+ 
+ A user can be registered as receiver of command from the ELE.
+
+ When a message is received, the driver select the device_ctx receiving the
+ message depending on the tag in the message. It selects the device_ctx
+ accordingly.
+
+
+NXP i.MX ELE-MU Device Node:
+===========================
+Required properties:
+--------------------
+- compatible:		Shall be: "fsl,imx-ele", "fsl,imx93-ele"
+- mbox-names:		Contains the name of TX/RX channels- "tx", "rx";
+- mboxes:		Details of the shared mailbox node instance from the
+			device tree. Example values are:
+			For TX: s4muap 0 0
+			For RX: s4muap 1 0
+
+- fsl,ele_mu_id		Contains the message unit id that connects between
+			application core and NXP EL-Enclave.
+- fsl,ele_max_users	For 1 user-space application, value of >2  is suggested. 
+- fsl,cmd_tag		Default value of command tag is 0x17. Though it can be 
+			over-ridden for futures SoCs.
+- fsl,rsp_tag		Default value of command tag is 0xe1. Though it can be 
+			over-ridden for futures SoCs.
+
+Example:
+--------
+
+	ele_mu: ele_mu {
+		compatible = "fsl,imx93-ele";
+		mbox-names = "tx", "rx";
+		mboxes = <&s4muap 2 0
+			&s4muap 3 0>;
+
+		fsl,ele_mu_id = <1>;
+		fsl,ele_max_users = <4>;
+		fsl,cmd_tag = /bits/ 8 <0x17>;
+		fsl,rsp_tag = /bits/ 8 <0xe1>;
+	};
-- 
2.34.1

