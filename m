Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB526E79B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjDSM02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDSM0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:26:24 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95202681;
        Wed, 19 Apr 2023 05:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO8gIOcOhrK5vXPeua9KLibnxtL1m+hEnCExXOWA5VyQ5fECE1VD6B/hGK0SnDJtd2PEtYp7r8oX0CnhzuOlM8aD5KkJC/5J0vOFMdOsnm4SUpinixFKSbr+36fjnMYa/kjq/BLAF0Y8y+wEP2ceaN9R4/LB6nkn22UI0y7k8beVrgeAHMz7yqzddjnVqYvR0uSXIqlkjjnWZv76w5N+9+jTg0q6qZOGs4+wXDF9yPz72rxVb6lKKpKUi2CvID/D8xoPuUmp+o+js4x6r0SOo5zapR+W58pOUPGKdTBoj7Y+Fu2ABx3xfP6lsSmP8vckq62Ba6oCXyNd1Hl4N0Lknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2Hb9R4fPXVM5ig+jbbVwZ+8b0qF9k+ZngMa0dt3oUs=;
 b=lVqAc2Nkt5JmHwdeK4yPeVls/NzHgVrx0j2ZeDfMcuIswRDcaY/gmfoNwX0MAu2Gm9Pbahvsda4Kn4BcsUM6xAnPiHHYpzu5I6rhui6PKQiYk1iqbya3RwQxym10RDLjfXcxw9EJHkohQ/sIM8LD8Z7UCFy80iR0PfUyRIOhBIud+cLHqFJFPe1RH6cKDQaNwcEfISejCk5tyj2CTtGz+9xvTkXnhKhrQSBiJ/jBD/8fk1Rh2h2VjnixMSuiimz1Og3VL48c6qgbkZCycbCeJW7oPS/NypSvnGsMfQGMv6mPxFiz1fpinW/+Z1DYCb3JL8KIhQG/xz0wvNsLud1ZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2Hb9R4fPXVM5ig+jbbVwZ+8b0qF9k+ZngMa0dt3oUs=;
 b=ZRVQkdMObIE2zI2ydnjmlpymT8+hPDPDtjzstQM3DO87yDPecpjaHm9qecGHnejIACoE2T4w1zne1TE14s5QbQONIcdbK0D2feTXqxiG/y8YppKnSZW+PDK5d7KG0461+8N6uUpt02wCPXDnudNC8XNp7iAlixpdmFXM0xsFlGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PR3PR04MB7386.eurprd04.prod.outlook.com (2603:10a6:102:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 12:26:19 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::bb08:83bc:69ce:21ed%9]) with mapi id 15.20.6298.030; Wed, 19 Apr 2023
 12:26:19 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        gaurav.jain@nxp.com, sahil.malhotra@nxp.com, aisheng.dong@nxp.com,
        V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v2 1/7] doc: device tree binding addition for ele MU
Date:   Wed, 19 Apr 2023 23:25:32 +0530
Message-Id: <20230419175538.855493-2-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419175538.855493-1-pankaj.gupta@nxp.com>
References: <20230419175538.855493-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|PR3PR04MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: be5dc848-0a0c-4622-e206-08db40d1474a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hOTekR2Vk45qtgNHaLxNGDFwH2ECt+9AJUGvrvqEGsS9Ay71lQsWrU1f7h3fBzrP+5UGrcpCwsz7vTob8xZKxkf0SYnnrVzzB/aYANC6MBYI0dKzAx7h14cWe+ZDpWLIatNPk2UO7gl08vjFyKmu+wPRFW9JmjVHmBaVamOepqdl/H70+Oar/2QGHA1SVc7lYOhH/ShiiWo/tD4PeqLe/ukRTYjb2NrORuk7lX5K/WZ5YgpzuVj0b/IYfDthd9y4sHN45jOc70BpklhE/jgfAPgchbtDJtwp+Zm+wjOd+EKAR4P8CoC9vStayVpsypqtb7R+vcd2R2AyzeBT3WrPqZzZ9JWWhAMrIyXGAls3rFcwcpowaWTvpcuV/xEU8wzIrxBxFFn3citmXSdOSioLShVol5Dk+k4EbIXu2BAs3RIzcKgjhQjMEL/n3jJDt3ynRgBijpdwz5Tlb+MzT2XRTN05g0O0gSKIbeFbeU+eh4XJIkyV3CDw0lPJqFZodFirk9+hcGPj3lL+mHm1pPePNe5I5B5O9d43r+cHPWT0z6/qh1XWmu7AHRvcTTfCN2HEwHPPJWbjGXQUH27PjPrVoDgHpwewZcvmfT4UvI8jZaM2YZxqF2+NtihVf1A0rhgOf8ObbTdVupi2ecFaqDYGvaWjYfEFDY9fFR9Qzmbjoeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(6636002)(83380400001)(478600001)(2616005)(52116002)(6486002)(6512007)(6506007)(1076003)(26005)(966005)(6666004)(66556008)(4326008)(66476007)(41300700001)(66946007)(921005)(316002)(186003)(5660300002)(44832011)(38100700002)(8676002)(38350700002)(2906002)(8936002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4a/wfDrkmO/dEteJa/5gQt7RBrdGb3cZZOxDmo73IAakv2VnmHRl/ZxyH+GN?=
 =?us-ascii?Q?i0PiVY8prarkZBT1MvUmW3kwo9VfV6JwuqFGO6LGm8WYFdRLbp+dxkR/zUVN?=
 =?us-ascii?Q?DxD7iGxekzl2QASKxNXvabCOVz7kGs+ledESfTqfzw7PJUCIAnTAuSezEeUi?=
 =?us-ascii?Q?C5nWQYCp3Nv6Cc1VZZtu+CDX9toTGIfTRUqSlpADUbDYQXUKlBErbiaMzB4D?=
 =?us-ascii?Q?Z0ijH0S3SliEC+EHB/hpGCQFlEp13ueGvjTASb1AUe2bmDKhAhdztH5KsMxi?=
 =?us-ascii?Q?L+jxJXFJ9WspYH22rATqadlEBw41k9HZyMNRfYBs/jLUnD9RtCuAYGFIBIv6?=
 =?us-ascii?Q?QJSW4Rvlk80vkexbojzxCzWHLakWe+4wiPaqVvznHMfB7DuWpzkYDCu3Qghb?=
 =?us-ascii?Q?nH/01jLAHOigs6OZCnwRnIwgVwy5YcFjE+YvpDN8tYrqvFmcxvRJ7Yx+tJgY?=
 =?us-ascii?Q?7PciLA1MHvQmm6mjuZ5ctNbHstJsxm8dYWtq8KgwLAZYgtveF3pl9VuCRpBo?=
 =?us-ascii?Q?qrgygg5pKXCOFwfLNRb1ZHglNiDjidSzsHkYJz8YMHBQvILBs00DlhIQY1Dr?=
 =?us-ascii?Q?8zoOhfP/GQ+IyZgs067/DXyLEz/xLgtbxq/xzrzOGPeSH8UUGvf7gR/KakbV?=
 =?us-ascii?Q?9/VRjbti1/l623DbbmM9J2fRm6oaSBUQ9zXeRTl+7XYBgE05vWvwh+6uvpeI?=
 =?us-ascii?Q?WWLhjn+8IEKNxccl9Bx66iUD+9QEVyg1gtrDbo3keNW90YYBTjg3w9bZd9VG?=
 =?us-ascii?Q?Y4PHynuE2UW+IAR5DMknOwo2iZ1GK9ZxjgUZKy2t+kUBaBJ9l5Of5gbcjeTv?=
 =?us-ascii?Q?RR5c/DwKTrmWA8Ekcu6I+SuHeuptnBaQ68G/EsfoODJ5rmbLVDc1x8ZqkC6Y?=
 =?us-ascii?Q?i09I5d2FGzQXDxGSuGh+PgtlWHauJT2MnMqktuuUluPi5MSuQuwRBCycargJ?=
 =?us-ascii?Q?wn9zLz8ihkx06P2Hl/Pg+7Rb6bd6LyeMfJmCEMPtfUW6uxjFJt8tnqaaVU//?=
 =?us-ascii?Q?pTd01Rm4Wk0/YrcyP6X2WkTCgkL9U0AQlhDs+v/VmijrU5tkeEG7rcebiSJR?=
 =?us-ascii?Q?eDo8dxUFhYdSeDq8mNvm8bSpogw0bqIokeTVdjcx279IuwSuhjoXTItc8jX6?=
 =?us-ascii?Q?1onjQFoJQ5dQDjHiOlImlqZ3eIllJOPsryquwgWTWxj6ZSjB4wsoLt4b0r5d?=
 =?us-ascii?Q?gQ8j+sCTMn/YH/C0cD5Y/osoPSaJf24L0e2D1bH3yOblYghn0qisyCjRXoeW?=
 =?us-ascii?Q?EEhKyXqIuR4rdpJdFgbhlj8omoq6DOBOvPWkf5tHCs7jdrJ+IuXeMKJjPrMT?=
 =?us-ascii?Q?i4D+tG9yFr9FfVmbaaUClI/My75rmcLuczGBaMw/DAL34lT3ppX8bN9SezwI?=
 =?us-ascii?Q?9sz0MM4wQ1u5Sjvkdp12fvxqq4ysORzmh+2KN7jqlF1DrMLBwQIaQBCBLCnw?=
 =?us-ascii?Q?uBs7BNYW46dHHmzNocZbpANEHTJ1yT1NS3z63K181P+M6JnAgZOE7O5DBRm/?=
 =?us-ascii?Q?eZFlNOdWOw3MelNEDowcgc64J/VWe8Id/2PQnCIyEb3ULcoIymgAZ0CnsQ/Y?=
 =?us-ascii?Q?2atOwID0Bbuk5Wd00pGe7B897HRFUys79FMjVWec?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5dc848-0a0c-4622-e206-08db40d1474a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 12:26:19.3807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RKrDc2zZQ1x8TolXwuu0Yn91LrjEnITzhV0kjQtRnzcZEyj86aJg38IfjSmZRqZ19ezKSiynYCp/FexODhHXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7386
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation update with addition of new device tree
for NXP ele-mu (Edgelock Enclave Message Unit), driver.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../bindings/arm/freescale/fsl,ele_mu.yaml    | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
new file mode 100644
index 000000000000..8c4cc32f62ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
@@ -0,0 +1,139 @@
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
+      List of <&phandle type channel> - 4 channels for TX, 4 channels for RX,
+      1 channel for TXDB
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
-- 
2.34.1

