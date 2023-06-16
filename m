Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D6C733172
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345314AbjFPMnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344648AbjFPMnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:43:01 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2079.outbound.protection.outlook.com [40.107.247.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F7130F6;
        Fri, 16 Jun 2023 05:42:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GO7P3SUjoEHJq9/deKGoGXoDx/Qr2ud3lswUxm2+VMmtRv3wfOK4WE7C3vQdF3UBS9Psfhqf5Dq5DVK2uTt95h33vT4RaGqPOZh63cv/y1/CY37EmfCPnGVXAHfjNnewoFCnTeQO2u13RG3KelurUGa5Py0GKqtmIl6wtdrG+3aYuu3IKhZTCLQxRoSZHz2Mvw/83jQ0zFNANh05Ym7ToyGnVU0PjkNMuEakiZTYe39UOYv5N0Uwk88Gh8uEU3sPeW/N8AsrmpJ5fwD4n52IP4mdtZYFnndX7wCVqUYBVMAXhiWdrPT1UMmUeyOEYASNssKNaeBhHKkZoGwefRGcjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1fhPRIZOPPL6zUY6w4eSpTu9xFM7irWNsi7ifWfsS0=;
 b=dUxnPUhQy4ahtZbTDMxQbSd8NrIzO6obS3+4RZXaujADwk50QzAidCorkdVSTehBU61O/h7GtolWXEEqwUUMbLy6Rhv+yIBiLQLWoE8tneid7XeNynjnTqcfZI/mr8aBx2pS0NS/jo7pg3DMYnX4ubUjo+blxixDGbzv2UQem8AK3KsvqJi/7QDI35f0T67NJ+Y3DUkT2Nlih3aWLLTa3ZB1dk0qlj7H3AFtiFti8gao8TDzkfu9iipsgFESQ+FKArbNSErx7F5yafDhDbCn63xhXGyHkXcmzjBwAs3FqL8yePSbZ+FUGukztOjuIkqdFM6kqiFimSL5B5mwe5I3fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1fhPRIZOPPL6zUY6w4eSpTu9xFM7irWNsi7ifWfsS0=;
 b=nXLN8bMtg/UWzQBMcppexiKijo4I4EZbEsIjQ8WQeTg84bKTkzT1uka4+jq1dFlttigwa27MXGyhsYwWNOBLr5jS+nXA3ecU13iUozKfvfGBJO+GlM1VOR7BZOrMFmUpUaRGQgZIC7G98FhNF3g2zcQjf8eJxnOeKxV3N3YZLGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAXPR04MB8320.eurprd04.prod.outlook.com (2603:10a6:102:1cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 12:42:55 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad%3]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 12:42:55 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gaurav.jain@nxp.com, linux-kernel@vger.kernel.org
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v3 1/7] dt-bindings: arm: fsl: add mu binding doc
Date:   Fri, 16 Jun 2023 23:41:38 +0530
Message-Id: <20230616181144.646500-2-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616181144.646500-1-pankaj.gupta@nxp.com>
References: <20230616181144.646500-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|PAXPR04MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a5de26-3b6e-49c5-542a-08db6e6734ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q5Qc8/nVCq2mUqmkl9JhcQcZbPPGNTVQeLdIz4IbNF5EUkpyb/oX2ztus/t1mWdQVxSaKL+AyiL2P3LbcqoU7zeGfu4ZlO5PQWN7bsm0N/6PIRxtmS+jvtBM5LZjCY319LYnBtgGN//4kpl3AWzGcNVRirigRRNGdlo8NKx5HrDYZvHZ7ZDqttcYNhOc3+zkLXDyYsyOKz8ZqFi1CJnSWxxhfSEE2ylqatj5efhSAyyBVZGuve7naQDiMkqF/n8z8yS1m8vXor/uwHWwCqda1Ef/LcCjUQZyZwgt6Q91WGGKvYGWt/atURA2WAXf/9BN+6KzoQkbhX2/Lz8Rg4/y619SEMjYzWD2BlRLmx9p5AQxToL7I3sCGQcie18ybnzkXsaHMc2TWNfR6nYqApmzLJ2WKEZ5wOQq9WLG+45ZeFA8RjKpBTDhCtqtOWDqiQLmQ92jqq3Ft4NS8cJh65agivBkscx906Sn637C/qt+dVingaIgorjn7fxC692WSvYtOZ9Ee7zRObTXbGcZFzJu9UlZTtJilJOWjcUUz8AUN7t33U2kJ5OhuwRyTOms1KZhz/3iVeNFvMwJXqrJJQDBy0YUgTHWg5KAsgl1B+nItRS/0H7BFDQQwwc9hWGZfwg6nDMKBCLHP/9jHacJ+ZMgh9q3jTXmBvnE99HfvuehsG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(5660300002)(478600001)(8936002)(41300700001)(8676002)(966005)(316002)(6486002)(52116002)(1076003)(6506007)(7416002)(44832011)(186003)(6666004)(4326008)(66476007)(66556008)(66946007)(26005)(6512007)(2616005)(2906002)(83380400001)(921005)(38100700002)(38350700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XMcTFZVTi0QnQ+by3RqCyf9rNFjOxCW7vNajsuLPQTAr3I1eaaIvu+SqRAi/?=
 =?us-ascii?Q?9fgyfOCHL7U956wkHhKBJJcTnS7Y9NAYHewnAzkq6Lq8l7akKfDH7TbWrRgy?=
 =?us-ascii?Q?39ZdO7ypZ281ZDHaIqLCH0q64MLtctcF1FFmuZEHgDJndV73EA7DKEn3o4Yv?=
 =?us-ascii?Q?jZ5hm3TeKoglzS4nP02a8mVuXK7B0ZS89G3EFqiPZ/VexqQK6I15R1nt9qNU?=
 =?us-ascii?Q?ekGHookVkU5EOMGyvlc1EmkHzxZwHTN4kGAeOOzMEd9wthLN+9Aa7Spo7A3r?=
 =?us-ascii?Q?EB7NPUIGM0yTookUlpavMKXpH7CBlqce7NYnnBq3VgfP04REYI+rI1IrX/VC?=
 =?us-ascii?Q?J12d1brB1NZxHuSL+IyyR/wcRMce5NfR0TcMnwq4gLQtV/rjUEkNQX2WBwQC?=
 =?us-ascii?Q?oVxDhj9Oa8wyNuwOEcx1Sy/7mqjmFMzjm/2eo/z38GaESi2PGPNScDf/7mNR?=
 =?us-ascii?Q?BAK/6HiSm1n+VNyu64vsRHtlc1DRkMPA+yUAcVSajE6rPtUHH9wQIApaduHN?=
 =?us-ascii?Q?L1d+lrYMtGxQevADxmh0LzdOQF0Myl/4mj8zUAAffN+tHk6x1oIDR2LhRCG3?=
 =?us-ascii?Q?W0EquCHxc3ffMZI48nqguv5AODEjl32w44H17AjLnxuMHNkc9XR3+PUZ4XDB?=
 =?us-ascii?Q?M8D06ZSlBxwkGD1xFH2+06ZMbNYZFWkU7W0SHDea0ZMsGSU0foOO1vwhnMrH?=
 =?us-ascii?Q?2G3YI9TtiI4XtvTN/uFaryqpSOONi1yW2yte2Y0Roj58FC9wAzrSm2I5fx7s?=
 =?us-ascii?Q?7PnEtLNIqyGoxbOxNjxFPmvcro4WES5qMid202SMcaZf3BAjqo/iqIykuZKw?=
 =?us-ascii?Q?KboezNuihtcJO8Z2MCh+SoJfaBEpSukcG/ybA332R5k6Kkb6BNeJ6qRIRe97?=
 =?us-ascii?Q?xbIL9bpvazFnkG9N3HQS3sFjw1ijnOq35o3Qe+g85UtAAGHGtKynbCJypTD6?=
 =?us-ascii?Q?9L2Kzyagna6K+HMwbxHwD9MzQWZP82QqyfZZqTa7sCkD8y+ukWUAVDYUjlME?=
 =?us-ascii?Q?gVyzHyHYNt3vPjAfiSnv75tTsHFl7gI7YnmdFFOOLVR9d5yKSrpIEkDWyaoB?=
 =?us-ascii?Q?59JFOni0QqSpQjfdLo3QMfCrvnqTHW5vmo/LkbbnhCeJZj1u59TSP2XPzj+J?=
 =?us-ascii?Q?qaboskDB1F9tXPPAjYdUzK7xZFBLBzdphmbVc4quCKjn/j35ftH19acMvIQl?=
 =?us-ascii?Q?TrZmRmunJahccmFA6pE3v356GH61FVX6NmzV7HClicfbgRb4f/rBbSwHSclO?=
 =?us-ascii?Q?jNR3fz6j+73cY8VjiGhiJtgH8bieT0Y/22sQspIGvp22faBV4gn3AH2hf5bf?=
 =?us-ascii?Q?GhTK0T5IXy1Hgzllxk8W+8uLcS56B0UEzbChPE74cZyNkDlozA2In5FoH81Q?=
 =?us-ascii?Q?MaceMD/eTm9nOR1cWUXqRmT7ulnzL9Ey7wj2pBip0iJYlaTRr8CuEJz3O4wf?=
 =?us-ascii?Q?0NbsbZqpKjW5UyIZCQzQzghNeIlsyMF6yVnYHTlNT1XICXK7A7aqu4xsHK0w?=
 =?us-ascii?Q?DCAtnHyVLryq8hPWjuCVm9h6fs3TA4aXpTlq9+J/1jVXrsjD0ruVx2I4QLB5?=
 =?us-ascii?Q?zubrWsnDnjB86O/ORMLJJzgqAjDk3SSjhQYdbcpb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a5de26-3b6e-49c5-542a-08db6e6734ec
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 12:42:55.3162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahDo/ITaoz7kmL/JxDd25KlFc17qDUzrNq6a0L5w7rTqEUosOXvdGrS9VsRkAPn+Zxb6636K0ku6cNW67zkmCQ==
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

The NXP i.MX Message Unit enables two processing elements
to communicate & co-ordinate with each other. This driver
is used to communicate between Application Core and
NXP HSM IPs like NXP EdgeLock Enclave etc.
It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../bindings/arm/freescale/fsl,ele_mu.yaml    | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
new file mode 100644
index 000000000000..29e309a88899
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
@@ -0,0 +1,144 @@
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
+
+  NXP i.MX EdgeLock Enclave Message Unit Driver.
+  The Messaging Unit module enables two processing elements within the SoC to
+  communicate and coordinate by passing messages (e.g., data, status and control)
+  through its interfaces.
+
+  The NXP i.MX EdgeLock Enclave Message Unit (ELE-MUAP) is specifically targeted
+  for use between application core and Edgelocke Enclave. It allows to send
+  messages to the EL Enclave using a shared mailbox.
+
+  The messages must follow the protocol defined.
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
+  kernel space   +------+      +------+     +------+      |
+                                                          |
+  +------------------------------------------------------ |
+                     |             |           |          |
+  userspace     /dev/ele_muXch0    |           |          |
+                           /dev/ele_muXch1     |          |
+                                         /dev/ele_muXchY  |
+                                                          |
+
+  When a user sends a command to the ELE, it registers its device_ctx as
+  waiter of a response from ELE.
+
+  A user can be registered as receiver of command from the ELE.
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
+      A list of phandles of TX MU channels followed by a list of phandles of
+      RX MU channels. The number of expected tx and rx channels is 1 TX, and
+      1 RX channels. All MU channels must be within the same MU instance.
+      Cross instances are not allowed. The MU instance to be used is S4MUAP
+      for imx8ulp & imx93. Users need to ensure that used MU instance does not
+      conflict with other execution environments.
+    items:
+      - description: TX0 MU channel
+      - description: RX0 MU channel
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
+                &s4muap 3 0>;
+      fsl,ele_mu_id = <1>;
+      fsl,ele_max_users = <4>;
+      fsl,cmd_tag = /bits/ 8 <0x17>;
+      fsl,rsp_tag = /bits/ 8 <0xe1>;
+    };
-- 
2.34.1

