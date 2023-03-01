Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6B56A6509
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjCABwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCABwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:52:32 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11CF34312;
        Tue, 28 Feb 2023 17:52:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGN+9A6vQHwX0sMxroLuvJmYblEJ6//xYoeyz5hNMYVb8L8hmlC4fQz4SlUu7me2t3D/L1+hETQG+i+vfdqGnM4tI28sThJK63h2Hvnu/zcyPK9Rc/plvpW9Inrj1tOjiYdiyocNMiaoNFbjNLcS1S1FgcbFzniXdFj7MW2hHLttPc3GMwxmFYx1fq+aqfwscQaPXTOWGgid0EAIQszliGAZUlsgn88arF5Y5cWLaaMfOEfkK+QpeaVPyfBglsZW8tIeMtyXUFt82DodGCEthOjYQqYvPhDhX3Wrn7EFnvHddBVfeepjCM7wbmiuCrNtJbrIDmowLincwCmFqrEV7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsXtab0as+OVxMANvpowOSHiNt6eXiozzCDOrbHISnw=;
 b=P3QUGzFLFJWE3ak+eRJKDk10mBuXlIHVSYWLhKuM24PvWGoBQ/BRajWg3de0VeoFrmCxwzPzqVp5tbfNf8rbshaDNtArvTbm0SNdU/b2Gzj4Y+7DgGKAydQimMZf6MRvXv0LBDCU7tDkAAsGPkjMHWDPE1D2+7tiZwhgAJpxCBPHAgHubqNhfnu93rNyb5yNK/q9ICeOEM/RAVLWteRToYMLVLXawP3KQfi7ZEBUNouFs45CwLTYtbjuc8WLlD1T5UdwGa2bN537SMnjZlIowdvuoG1cCKC21kU5s6U9ppwuiHvkmFealHtwMmSBaW+osadve2Trk8uX5s8IJWmVow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsXtab0as+OVxMANvpowOSHiNt6eXiozzCDOrbHISnw=;
 b=lBN5B6z749VkdCbm8L3R22PAasSwB6cDXq/p23yn6NBsvwjv1OKKrPSJiSMW0hJ3XumbJgisc9vt9ugZf3oLdFYHFgNrdIdqsHRimEifGyjzv5GYoVrjx4PDZiBo+rRBnIJE8OgLpQJCNuUA4rQWOYh1+J1Zi4EFzGgVLO+7GwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7546.eurprd04.prod.outlook.com (2603:10a6:10:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 01:52:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 01:52:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, stefan@agner.ch,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/9] dt-bindings: crypto: fsl-sec4: convert to DT schema
Date:   Wed,  1 Mar 2023 09:56:55 +0800
Message-Id: <20230301015702.3388458-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 80cbc8a6-74f5-4be6-17ac-08db19f7901f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewLFvT7QUTmKbZQDyx97m1d11VG2hPJxcY7c4AUP4GXMsj6RiERQq4Y+g/J/kpyX4Jr9zykNGIxnbS/axU+VguHTvdAlbTw1nu1DWPbZfMtOPdUgA+H0GiA7nVlSVHF0p/e++jptVdhJCc9k1Zo8YD2O6c1RVOkPajDBr1TuJ7A07ZlClvGyaCXhsJq7d87fqRG/MEqK17YXIPHnnEUay++CFiCAVR5/2aG+xe+nvysqurumlFcB/XHsOqYrgFv8Z30Nxk96oYPsepJaKZyLp9X20kMa4KCAwyqstmWFzRYtNep+nub4JjfekgqqSVPJAmjBb3OkkBHqcdCW+/qmdrTVcPyXpmyn+Ros/fr4LAPOvvZgXKbEPzY5EaxFw2zqh3L0IZNc9KZuFC4Sz5WrgyLI3c9XM9evnDtpkXmSCK5Ntf/VSKG7E5DEm6eic7pHojHUBF0bS2L2RL4ZOhVBFC/HvK4BJQ/VK6t5019n7VggbiVHlEfpWwLeqP9J+UZrx+2S5ABDIodu0hGCHGw/yfvWoankymoP9dZFEvc7uFLeRyhB/kYPxlXu+P+c9tG+HLcaNrRf3IF2/ADZ3Kk0MKkeQuuc0Eg7rnGqA83HWaK4oC80ts4qLuB2f3bmapQto40e1rdrZztkQYCvNdF9sWeRDCbpN2iBr4GK5DVWS/AG76DdZeb0ZV9OGE1w5UycXceC2HZaIZBwS32hXW9o/+t5vVC7Zjg9NiJVVr2ZBQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199018)(83380400001)(316002)(6666004)(2906002)(6486002)(966005)(6506007)(478600001)(1076003)(2616005)(52116002)(26005)(186003)(6512007)(86362001)(8936002)(7416002)(41300700001)(66556008)(5660300002)(66946007)(66476007)(8676002)(38100700002)(4326008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WftLPRYIrAkluYNLM+Ddt6UkISSbMqp686TbXP1JhitseWIBuxBxfcW3TRgr?=
 =?us-ascii?Q?5QyvW8PWCYc7PEd7Wt0M8mMTf73yF5OyqBR07qOoc5QUI/jicjtfXTQF5ifx?=
 =?us-ascii?Q?8MWBv8DiwErcRiXlE9rbXxJhoqfMwStVmr4wMR63tlVwKZI98hYNQuYPf4AO?=
 =?us-ascii?Q?SEN8Frnwu68zPVsTN54wAogLHuY4Pelcpcu8boCVheRjKe1Jf5TdgAq5AILM?=
 =?us-ascii?Q?luVyiXL5MrkAl59leqdLB0sTTX8XioBqvNzM6Oj3VrIMxLW6CB3uVSsuwp2s?=
 =?us-ascii?Q?vxCvY7PFtXltOSRbuoTQERd8RZIWUurp7LDORXq0Iy2k7Ysv8XqVG7i/dD0T?=
 =?us-ascii?Q?IOw1MCYuYp6P9umiB54GuorvIFaDV/OdKqljqHWGu/cMTdLC7OCcAMHYNZcq?=
 =?us-ascii?Q?bd3WiWj7VajUINaWXcPnUNr5vDugunN7P96jGRTje5Hz8ujeyzfcB4TVa2Dg?=
 =?us-ascii?Q?VLQTFTQn/uUo94d6R+piWNNoCU6Nj3G5LNqWyuPjvrgiY/4qMj2rkkHgGZRo?=
 =?us-ascii?Q?i5D80XpR/I9aGYLFeRKWdTgkFiFo06R6DW5J6UbsJrWo0m1Y+v6jTM2Et+oN?=
 =?us-ascii?Q?UpOX1fvPrPSHHKmVpKSNnQNdSEJpDOWm/HYznlP4XvMn/3y811jhjFsb5aLK?=
 =?us-ascii?Q?vlRVjcEJ1d6nJQxGe1Wn0kXLOZB5t2j71Ap3Ij1+Nw7aagcQBeT3NJjnzsSl?=
 =?us-ascii?Q?4w0uihrc5vTAWN3f2mIV5C1lURDpnfqz67su6x0XH+hHm8ahjoR5KCC3izQX?=
 =?us-ascii?Q?n++6ExeIFDF8s1cH+epMwFgWINLU0A3aZ0hm4dBc7IispEJ9gIWNznolZTiw?=
 =?us-ascii?Q?YLSymL5h10XFe1NJlIMkbMF9MMPzZ8XmP4id+AkmLACiYCp/lo4+N+QXDWoX?=
 =?us-ascii?Q?SutBcjHd9jf7Vl2VWwUK6+ImNNvfzd5SlSEH4nHn7b9/0bRvGNyB/PrYGu4O?=
 =?us-ascii?Q?Gbq2F7fqOUj0wMQCQtMlZixk5Jy6t2TVXHnZ3Ws4gmwB9LENoAGivVWWZShQ?=
 =?us-ascii?Q?6X7zWvxCAVR3Q+vKKXKo9sF0CKFxysfESk9395Ns4Xlc89SjpfiS5qqC+Evb?=
 =?us-ascii?Q?QoEmWCZ8STEmR5MLrk+zbYn29Iz3pUwUcjjetYBQAcTvCXfx2yN/SkhVZ8QB?=
 =?us-ascii?Q?bfrq3mMusQeIVdbpkDZj+YNr2lveGDOoZ6WEdM5gg/ZHoA0gi8ABEoepYtWH?=
 =?us-ascii?Q?T77IFzmGN/S1tcTpOyyXjdxdyvKaEIsOtIhAail8UGKB0fVhkiySaBGGr6j+?=
 =?us-ascii?Q?JdUWNPptwNFzuIvendXhLIXinxWbswNeR+/4U6dqaBGVAAtcPOLD3xeq9n/a?=
 =?us-ascii?Q?YKzALwR8LdWtgaodi0WMlepx1+uL6rIIv1ECt/jvrpwOZqJy32JaeoebFi4K?=
 =?us-ascii?Q?xbQxQNid1az1Z+KKW9tR5oH7VRAjzNAp5/gp2cakO60JAD1IpNiED3kpBg4R?=
 =?us-ascii?Q?hB1qOvlGCxMeaCLNc+2Wx/Y9XSA32Hd3eteOA59r2UHrOojfOxVrQ2yy1pKg?=
 =?us-ascii?Q?5doWrTycRLKrF8olJaEFVn4p20KvF9b1TkSEpjj+xdfw9qK4IXbXfIqoGUXF?=
 =?us-ascii?Q?EZu7LcBdpQA0KkhrENYc2MepxG8VH2Sin63jqOKS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cbc8a6-74f5-4be6-17ac-08db19f7901f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 01:52:07.1924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwCNfCQahELEmFyyitbAUuZEBLMi2kl5brhoKwcWpuw4OKiuYsA6SlvmE3C3lo1MBgZBglsGNdINU/SMhRMtAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7546
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Convert the fsl-sec4 binding to DT schema

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/crypto/fsl-sec4.yaml  | 324 ++++++++++++++++++
 1 file changed, 324 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/fsl-sec4.yaml

diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.yaml b/Documentation/devicetree/bindings/crypto/fsl-sec4.yaml
new file mode 100644
index 000000000000..678c8389ef49
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.yaml
@@ -0,0 +1,324 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/fsl-sec4.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP SEC4 Crypto Binding
+
+description:
+  CONTENTS
+    -Overview
+    -SEC 4 Node
+    -Job Ring Node
+    -Run Time Integrity Check (RTIC) Node
+    -Run Time Integrity Check (RTIC) Memory Node
+  NOTE, the SEC 4 is also known as Freescale's Cryptographic Accelerator
+  Accelerator and Assurance Module (CAAM).
+  For information on SEC4 SNVS, ref fsl-sec4-snvs.yaml
+
+  =====================================================================
+  Overview
+
+  DESCRIPTION
+
+  SEC 4 h/w can process requests from 2 types of sources.
+  1. DPAA Queue Interface (HW interface between Queue Manager & SEC 4).
+  2. Job Rings (HW interface between cores & SEC 4 registers).
+
+  High Speed Data Path Configuration,
+
+  HW interface between QM & SEC 4 and also BM & SEC 4, on DPAA-enabled parts
+  such as the P4080.  The number of simultaneous dequeues the QI can make is
+  equal to the number of Descriptor Controller (DECO) engines in a particular
+  SEC version.  E.g., the SEC 4.0 in the P4080 has 5 DECOs and can thus
+  dequeue from 5 subportals simultaneously.
+
+  Job Ring Data Path Configuration,
+
+  Each JR is located on a separate 4k page, they may (or may not) be made visible
+  in the memory partition devoted to a particular core.  The P4080 has 4 JRs, so
+  up to 4 JRs can be configured; and all 4 JRs process requests in parallel.
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - fsl,sec-v4.0
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  ranges:
+    description:
+      A standard property. Specifies the physical address range of the SEC
+      4.0 register space (-SNVS not included).  A triplet that includes the
+      child address, parent address, & length.
+
+  interrupts:
+    description:
+      Specifies the interrupts generated by this device.  The value of the
+      interrupts property consists of one interrupt specifier. The format
+      of the specifier is defined by the binding document describing the
+      node's interrupt parent.
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    oneOf:
+      - items:
+          - const: mem
+          - const: aclk
+          - const: ipg
+          - const: emi_slow
+      - items:
+          - const: aclk
+          - const: ipg
+      - items:
+          - const: ipg
+          - const: aclk
+          - const: mem
+
+  fsl,sec-era:
+    description:
+      Optional. A standard property. Define the 'ERA' of the SEC device.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+patternProperties:
+  "jr@[0-9a-f]+$":
+    type: object
+    description:
+      Child of the crypto node defines data processing interface to SEC 4
+      across the peripheral bus for purposes of processing
+      cryptographic descriptors. The specified address
+      range can be made visible to one (or more) cores.
+      The interrupt defined for this node is controlled within
+      the address range of this node.
+
+    properties:
+      compatible:
+        enum:
+          - fsl,sec-v4.0-job-ring
+
+      reg:
+        maxItems: 1
+
+      interrupts:
+        description:
+          Specifies the interrupts generated by this device.  The value of the
+          interrupts property consists of one interrupt specifier. The format
+          of the specifier is defined by the binding document describing the
+          node's interrupt parent.
+        maxItems: 1
+
+      fsl,liodn:
+        description:
+          Specifies the LIODN to be used in conjunction with the ppid-to-liodn
+          table that specifies the PPID to LIODN mapping. Needed if the PAMU
+          is used.  Value is a 12 bit value where value is a LIODN ID for this
+          JR. This property is normally set by boot firmware.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        maximum: 0x1
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+
+  "rtic@[0-9a-f]+$":
+    type: object
+    description:
+      Run Time Integrity Check (RTIC) Node. Child node of the crypto node.
+      Defines a register space that contains up to 5 sets of addresses and
+      their lengths (sizes) that will be checked at run time.  After an
+      initial hash result is calculated, these addresses are checked by HW
+      to monitor any change.  If any memory is modified, a Security Violation
+      is triggered (see SNVS definition).
+
+    properties:
+      compatible:
+        enum:
+          - fsl,sec-v4.0-rtic
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 1
+
+      reg:
+        minItems: 1
+        maxItems: 2
+
+      ranges:
+        description:
+          A standard property.  Specifies the physical address range of the
+          SEC 4 register space (-SNVS not included).  A triplet that includes
+          the child address, parent address, & length.
+
+    required:
+      - compatible
+      - reg
+      - "#address-cells"
+      - "#size-cells"
+      - ranges
+
+    patternProperties:
+      "rtic-[a-f]@[0-9]+$":
+        type: object
+        description:
+          Run Time Integrity Check (RTIC) Memory Node. A child node that
+          defines individual RTIC memory regions that are used to perform
+          run-time integrity check of memory areas that should not modified.
+          The node defines a register that contains the memory address &
+          length (combined) and a second register that contains the hash
+          result in big endian format.
+
+        properties:
+          compatible:
+            enum:
+              - fsl,sec-v4.0-rtic-memory
+
+          reg:
+            minItems: 1
+            maxItems: 2
+
+          fsl,rtic-region:
+            description:
+              Specifies the HW address (36 bit address) for this region
+              followed by the length of the HW partition to be checked;
+              the address is represented as a 64 bit quantity followed
+              by a 32 bit length.
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 1
+            maxItems: 3
+
+          fsl,liodn:
+            description:
+              Specifies the LIODN to be used in conjunction with
+              the ppid-to-liodn table that specifies the PPID to LIODN
+              mapping.  Needed if the PAMU is used.  Value is a 12 bit value
+              where value is a LIODN ID for this RTIC memory region. This
+              property is normally set by boot firmware.
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 1
+            maxItems: 3
+
+        required:
+          - compatible
+          - reg
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  # iMX6QDL/SX requires four clocks
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx6qdl-clock.h>
+
+    crypto@300000 {
+        compatible = "fsl,sec-v4.0";
+        fsl,sec-era = <2>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        reg = <0x300000 0x10000>;
+        ranges = <0 0x300000 0x10000>;
+        interrupt-parent = <&mpic>;
+        interrupts = <92 2>;
+        clocks = <&clks IMX6QDL_CLK_CAAM_MEM>,
+                 <&clks IMX6QDL_CLK_CAAM_ACLK>,
+                 <&clks IMX6QDL_CLK_CAAM_IPG>,
+                 <&clks IMX6QDL_CLK_EIM_SLOW>;
+        clock-names = "mem", "aclk", "ipg", "emi_slow";
+
+        sec_jr0: jr@1000 {
+            compatible = "fsl,sec-v4.0-job-ring";
+            reg = <0x1000 0x1000>;
+            interrupt-parent = <&mpic>;
+            interrupts = <88 2>;
+        };
+
+        sec_jr1: jr@2000 {
+           compatible = "fsl,sec-v4.0-job-ring";
+           reg = <0x2000 0x1000>;
+           interrupt-parent = <&mpic>;
+           interrupts = <89 2>;
+        };
+
+        sec_jr2: jr@3000 {
+          compatible = "fsl,sec-v4.0-job-ring";
+          reg = <0x3000 0x1000>;
+          interrupt-parent = <&mpic>;
+          interrupts = <90 2>;
+        };
+
+        sec_jr3: jr@4000 {
+           compatible = "fsl,sec-v4.0-job-ring";
+           reg = <0x4000 0x1000>;
+           interrupt-parent = <&mpic>;
+           interrupts = <91 2>;
+        };
+
+        rtic@6000 {
+            compatible = "fsl,sec-v4.0-rtic";
+            #address-cells = <1>;
+            #size-cells = <1>;
+            reg = <0x6000 0x100>;
+            ranges = <0x0 0x6100 0xe00>;
+
+            rtic_a: rtic-a@0 {
+               compatible = "fsl,sec-v4.0-rtic-memory";
+               reg = <0x00 0x20 0x100 0x80>;
+            };
+
+            rtic_b: rtic-b@20 {
+                compatible = "fsl,sec-v4.0-rtic-memory";
+                reg = <0x20 0x20 0x200 0x80>;
+            };
+
+            rtic_c: rtic-c@40 {
+                compatible = "fsl,sec-v4.0-rtic-memory";
+                reg = <0x40 0x20 0x300 0x80>;
+            };
+
+            rtic_d: rtic-d@60 {
+                compatible = "fsl,sec-v4.0-rtic-memory";
+                reg = <0x60 0x20 0x500 0x80>;
+            };
+        };
+    };
+
+  # iMX6UL does only require three clocks
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx6ul-clock.h>
+
+    crypto: crypto@2140000 {
+        compatible = "fsl,sec-v4.0";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        reg = <0x2140000 0x3c000>;
+        ranges = <0 0x2140000 0x3c000>;
+        interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+
+        clocks = <&clks IMX6UL_CLK_CAAM_IPG>,
+                 <&clks IMX6UL_CLK_CAAM_ACLK>,
+                 <&clks IMX6UL_CLK_CAAM_MEM>;
+        clock-names = "ipg", "aclk", "mem";
+    };
+...
-- 
2.37.1

