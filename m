Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648157507D5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjGLMNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjGLMNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:13:07 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC757E4D;
        Wed, 12 Jul 2023 05:13:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4MF79pW0JdcOVcmd45MntbX4Yk5Spbe4+A9wentDNX51qs4TRKtBU2Oe93EyGLhf37MVj70wbV+NACvRiOVRy5zf8GKdn9PVELQ61u+Dn5feoneJ7LPvYJp/zTFsvpewSNxHOGkDzK8rQvHOyY4no0TBFZpnZDca+bf03hilpHDqIammzjppQVUGY+SQZPRFkN4XRaURL8Lgw9WjCv+Naxc+q9G70tr9XtSXiRAzewcfKitEOJi1LC49u+aUEXnx79C2nraISaY7BkqPB+VYqK4ZaDs4UVINnapmEBo2ROqQ6ZUz7mqMCqBXSC7P90t3qk76SGiljQCsz/x0MimnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zyZfki0IQbK0uj/C9G3C7ETRHnP/7Bs2iKn/uC/V3M=;
 b=mh3oZe2s6zmyKFeJAlIC+EjuQSmHwPcMzL8GzCHu0BN3Lxf2zn2WckJWI2LV7Ds3EPdXstRLAZD8Wms+bmXXdzfvQgQ41yc5pmli0Y2t/leR0KnQ6tKbiZkTMZkGzac+CwDYTWTSoG3WoJNfW43tF5zNvFZiMImDHYLnXdVN8DZ+8boNd7lAQ98Thhh5sRZ3htgqSJRVS15yrCQe8o6Kq6/fjqbZtatnA6U9M7tqOs7G8jbYdV6th1uFVZYwT+QoWno3zaCJwx+nD+VYrypCE+Oi6OXr51dBTfPy0wfiLeeP2SCBz5Rms9T8is2TM6XlyTMbnwIN/hxTaqLWv+ZRgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zyZfki0IQbK0uj/C9G3C7ETRHnP/7Bs2iKn/uC/V3M=;
 b=jVzGtITmxaug7W2E+YnDVOXS+UYcdVJdcUxKSmGKY2o1qfTjBAobQ3mkuOCQys+FbQpwMnlOk9PuEsJy4XkSVcPzpEum/N9ntbVYBFRFkoUyeiCYqrW4NCEJt9w7XddWkTqSGK5F+o/xJlzL0HDDoWeBA7q/X2CgNKhNES4CIgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14)
 by GVXPR04MB9877.eurprd04.prod.outlook.com (2603:10a6:150:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 12:13:02 +0000
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec]) by PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec%3]) with mapi id 15.20.6544.024; Wed, 12 Jul 2023
 12:13:02 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v4 1/7] dt-bindings: arm: fsl: add se-fw binding doc
Date:   Wed, 12 Jul 2023 17:42:13 +0530
Message-Id: <20230712121219.2654234-2-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8638:EE_|GVXPR04MB9877:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b86f44-bc95-4cd3-fbc1-08db82d156d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0019eLd+oMKEcqqt/7ius5vasp/VUVaxGzOkNzgUVyh9q5cpAuSA1m0DFhKD8DTTo3FKV2N6GTJ2SrBEh19Nn61UmPY93POLITJjj7CfNOZ4ARiXMPjLpVspBx7Xz3Z2JUZl4RwnQbY1eIftyTk5B512qiUtBTTMvHtdr5BEQ3ZYoB6vO8HlqmrVdAMtOUfEay8jZrIkmm6iwXIu0EnpvzZFwWBPo9Iz++yrMOWwEBcPPF9/RSvBKn1aHHaqmQl8i6xJd6btL4CAmXvIamskHaHpDDVvX0Zh0dPZ2rwESc2I0xechjeLVM5cv0Oy1hOnQ5o88A4XEfHVLt4LnvlQel9dSWkT0akCny0KQH/9Ip//JX2F4qN+AMpH/8Dpm8hhyF4O00RwGRWMqswRbYB/laCkZI1xtJDsah52hiP0mUbNi2rlK899TKnrfp5LL2hKmWsOF1Brh1xEM6ZxfORWPd3kfhlLOx9GpOYj9bD/2QpKtVR2r6YfiwjgXKnd0eBCnh8w+zpBwcFnjlpfD/Kr2Tpx6FUUE449ZkE502cFy/5cafpPtsVFD90CcccWhi35Jq2dFxAtWdlPFo1O8SZcbTGBH6Zfw99iFzGODmQLTXPnDRpz1B/jq59TwjPeKzmM+f2vE7oVbkxYH1WEJjXEgWMZ+rwLaaw1LrhVvwmF9bk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(478600001)(52116002)(6666004)(6486002)(6506007)(1076003)(26005)(966005)(6512007)(186003)(66946007)(2906002)(316002)(44832011)(41300700001)(66556008)(4326008)(66476007)(7416002)(6636002)(8676002)(38350700002)(8936002)(921005)(5660300002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XmZ09en57wzJWgVF9L2cht4I/uR9djtFN9wr1VKvn3zWJf3I6pwmF91BWmjA?=
 =?us-ascii?Q?XouRUi/c1hXG8U64RRvls+zBJgehUnNQvHr+2OLIlMEpvF87p/6P6IOLDUY8?=
 =?us-ascii?Q?B6P72YVld1m4GrYJO+oSjYJnaSDU1UyZW5Xujmin0X4i3jfdZZjoOhj/Wpxw?=
 =?us-ascii?Q?UM/sz4zaRi/+7MsQuoIQAPgpjALDMIaNB6TSx+Ws+uncwzUq44k0zV7neZbS?=
 =?us-ascii?Q?kW6eeq6wiGXtusYw2pR3J40RwDwXn61OUtcjgdlyz1VHYSuIoxRNq9N2QFR3?=
 =?us-ascii?Q?Gz06FEEWZVG87Boug1EjSUmabTflh7EZ6YrY9m39TaIek2QwZ2/3UaJgPszR?=
 =?us-ascii?Q?X5ZDA1Vcc0ygNzFTrVP572kMDKXlK83iZyKhERysRy2NWxPt1eUHukKo2228?=
 =?us-ascii?Q?8v6eS37tEWVh/JHRX4VjwJPOHH1CLVvmwPpTKY6WcOrHWcNZpmZXfL+x1d0l?=
 =?us-ascii?Q?5AaDdm0KE9okkapm2l4MWV6STWVt9gu9FSM8bSFRASMwgbESjEdstJc3XviG?=
 =?us-ascii?Q?guHZkUvGdW7gjhU9XXr3YP7paPw/q4gB2bM7mqXjGc3xTBlsA+Qnk9RoQw80?=
 =?us-ascii?Q?ieDzUD66SM/56vm/10TAdWuWwIiIduV8N6DrzYlBecWrWs71gxcM01pybz2T?=
 =?us-ascii?Q?QCNw2PubR4B80jrb4muxNYkd3DL186i68dd1cdkIuU4XwthvMyls+HoV3MDk?=
 =?us-ascii?Q?1yBpf5S2m+CoFyUNef9G+FpWizs/llw7BVeZ5qvVL8gczBlIeFUAnCysHUyb?=
 =?us-ascii?Q?LzG2C0mLvVnf6wvqfBy6E+7xT9w2LebTCBLbVgPD0nbxUAjt7enRl1SM1ErW?=
 =?us-ascii?Q?Sb9fjCdFHYDN5Xd2UnCPF3mDR0rw582mk64rWi6VGcKzp0j+4nwR1JosBRag?=
 =?us-ascii?Q?mmIvDpz+1SGf2rR+RamXukqs4Jc2gf0zhzhJ0GRvtOxsjBggTQ5DTEoIrhyE?=
 =?us-ascii?Q?PqyNeVX+jL8WW/NkYqfTMYcCiz69tkNE4hFn0ABR0DHB9ZlwcQicrtrR1469?=
 =?us-ascii?Q?DGmD01jAvnwQf+7C8TPgmJNqHjYO4dmzo7hBLFnsNnKkpzyyjKXHWBytkCZP?=
 =?us-ascii?Q?WsQbN6WdTJvdDzQOlA2Y644UBqqYmaOBJXE/D/Lria7f327GdMZKrCSfHJcM?=
 =?us-ascii?Q?/+5OI9+Utxj9LH0kzQYDCDrwr7qnF1RkkdmYs4jTYMSqQqF8MSIKgaH+aXcG?=
 =?us-ascii?Q?qgMseXPxs9y7zpS4LnZBFirU5XTGbCMLgDd+J4mNbVTAELA3Tg8ZadmB88BN?=
 =?us-ascii?Q?MhrP4T9Dzv72jzDNC+Sk7Yjc4eON/2oyEoPylCN5ohf2eEpruTJmIwyeGBfW?=
 =?us-ascii?Q?aLKoI7BWDmkKT8yORBxsWRmG42/XuuhkFakzRvX+ZjJMEemD013WVjTj2NMs?=
 =?us-ascii?Q?hvxUc9pgONEbQxx0+7SOd2dfVmhoYC5HAK26ME9/K3fPZtc0xxx9IznTlCIM?=
 =?us-ascii?Q?bBL77QXyV5Rkw8DS0oV+tTDzjNS1ShlRCsMtcm8akcfuemkWvPKU6KaIcooU?=
 =?us-ascii?Q?+SHRR+nQkLhMNyLRowYglrozlqKKT8pP4b+Gn8NfaN6ZhjbqRdK1k92YnEdr?=
 =?us-ascii?Q?KZjavJUDB1P8bAEZmvIqpaPn5QbfkPRe1iVf3QTO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b86f44-bc95-4cd3-fbc1-08db82d156d9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:13:02.2335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wd6KL1cLy00989DeEo3JP2inD60PUZWNdyllbjm0jGiBRYKVZ0kzyaL3V1v8SJdUih29Jpx6KrKOqJD+gVtBgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9877
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded
secure enclave within the SoC boundary to enable features like
- HSM
- SHE
- V2X

Communicates via message unit with linux kernel. This driver
is enables communication ensuring well defined message sequence
protocol between Application Core and enclave's firmware.

Driver configures multiple misc-device on the MU, for multiple
user-space applications can communicate on single MU.

It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 .../bindings/arm/freescale/fsl,se-fw.yaml     | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml
new file mode 100644
index 000000000000..7567da0b4c21
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,se-fw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX EdgeLock Enclave Firmware (ELEFW)
+
+maintainers:
+  - Pankaj Gupta <pankaj.gupta@nxp.com>
+
+description: |
+
+  The NXP's i.MX EdgeLock Enclave, a HW IP creating an embedded
+  secure enclave within the SoC boundary to enable features like
+  - HSM
+  - SHE
+  - V2X
+
+  It uses message unit to communicate and coordinate to pass messages
+  (e.g., data,  status and control) through its interfaces.
+
+  This driver configures multiple misc-devices on the MU, to exchange
+  messages from User-space application and NXP's Edgelocke Enclave firmware.
+  The driver ensures that the messages must follow the following protocol
+  defined.
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
+  fsl,mu-did:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Owner of message-unit, is identified via Domain ID or did.
+
+  fsl,mu-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Identifier to the message-unit among the multiple message-unit that exists on SoC.
+      It is used to create the channels, default to 2
+
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
+      fsl,mu-did = <1>;
+      fsl,mu-id = <1>;
+    };
-- 
2.34.1

