Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BC86A6518
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjCAByO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjCAByJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:54:09 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3124037F08;
        Tue, 28 Feb 2023 17:53:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbd7Fa3J5lpBjlG89/b6cjp4SRRzfDDuIBTRBy02vqY1yS4sjAqpNXkV0zwdfQKzro/ao6ZfT7Cwpga7HG4iJKV0cDa8yJ2kIP0neY9goUf6zIDixvixkDm0oZSwNQ9016JQPjK2rJByyBCNhSjuwTHc8eGXgdtfvOazCLEU3WE2gs1OrW+M+/rKXH1wElb8RNnokGoXTv3LRSaw00WzfaCL4BSrz/qClXKsTBlgEs615kp40HnVZ/g9G1ODeXrZhjHcoQQnv3/4hwq9yDyezKeczplyMYyQcA7lcV/wuFSXgQMlNg8qV5a6B53wVZmB04brhWigOimci8qYGf0vaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVYuYyopJ3RBxYdOS3Kyo4yKFCOI6GJ3ThZ8sf4zcV8=;
 b=R5ijWcyh1D3UqYH5qY0X5yrtkpaG6ywZQmKKj7cd+vm0xz4PQ7EAx7MWSGTUsRNYrcSNuGaZY069PpyH3Ti4pEpAufJb1U1N3TaK6jzpIdrPkD+CW7n0EMiwmeUSaL1uoefKaGM/zis0XkNvj01iWcHajF4L1RK5YU3KLhPwH0YzFoTrIPEDSeMqk67siSXr6aTHlUiEkiuObisZn3qW0/62hZFoI2+GyeKFQ458uyKubpgqPGfwMazi39A7Q7qKzobBJqlMtVK5gb0pLTvCeLTBxdGUEB0VWNELNoMM8n7+a7gKubXJauj/K2dYjad34jZOsd8/oBdOwZtMK9aoqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVYuYyopJ3RBxYdOS3Kyo4yKFCOI6GJ3ThZ8sf4zcV8=;
 b=kVsNCrxxPKVndunxDkWZIoC/PEXHVD/JfmsZfWUg7unRHdCCLfH2cR1B/6QCgXD3BXuYw92+fwniBLDVigMJpFBCHPoDGz1hNkgajMDeSA0N/r+DmxuQ0erRmruVmSPhGDQvYBX+QcXTX84VFTY7X0Mkg9NiIty0R2a6ZIY6nJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7546.eurprd04.prod.outlook.com (2603:10a6:10:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 01:52:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 01:52:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, stefan@agner.ch,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 7/9] dt-bindings: crypto: drop fsl-sec4 txt binding
Date:   Wed,  1 Mar 2023 09:57:00 +0800
Message-Id: <20230301015702.3388458-8-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6ab59a04-e547-41ce-ff44-08db19f79e87
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KLHgPBKE+iR9+LeSNW70Sl7wQcZhbS0mkE7bWIwc0Mg/MGV0z6+gUbhJkZuLVCY6Vdkc81/WY6EtidLNxAEyypp4kAA6QjZoqkwwCfkwTZBezITYSUNLH2CYN/X/yhLCf0mR7ynqZQhmmcjryF/emmNEP/g7EePFkS8BoZIOf+RrK/Ygd0tpsI8ttwdb+fMdx7bb7BqYz9wnkQFJXhymfhcvpUHZivdzQC/ginq6kibGdheVD0rPZcAz+u3MG8WiJdvWfCRK8u/wzG2eqOuN4d7Ay1v0HL4ddUV10YNkID0uy7xWGhW1wKVXUhL40jSDQf8O52ilHjUGlocNLWDmRr5sse/+sMHL//dEgmeU/OVh8Jd2K+59KwQpHMFO9lCid0Fje+l0AsMmp3JI8TjFUVMoBbemkBr5sBaF367tEU8koyPz4XQfdBPjORAAEEksoW3ubatAwEkT++PcNqVWPfwEZuMtrULUhvtmAhhPo9qR0pEvVoBNC0XTkwYcleJdE0QRlEGQWaxx0fOrjjeCehy94eytHfLuwm7d1AbG1Y3vQfONzYL87JRnTJgj7a6iZBaYgLR78rs3k1jq8IlUZkF5M6IE9CXTbe0o3iR37smKfzrXUDYCiksoCVnBg+L8fm+I+rlgqNFjTBdy3r8Em/8uoEbwD+z62e1t/J2W2AjcRtARzYoywj/Ap0LXuK2Pzuf6GDh7NJTIiPH6pPbk6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199018)(83380400001)(316002)(6666004)(2906002)(6486002)(6506007)(478600001)(1076003)(2616005)(52116002)(26005)(186003)(6512007)(86362001)(8936002)(7416002)(41300700001)(30864003)(66556008)(5660300002)(66946007)(66476007)(8676002)(38100700002)(4326008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kqgda7KL8wKJwehQiJX0rXimMmf/vSN9vDpDtQDiWBHSceYaefWMx44SnvFb?=
 =?us-ascii?Q?2Q0XaQXvvsOO7X+ldlzREk717CS7TEyJxk11FhCxSGbWJx2Wnvtm4bpcVgy+?=
 =?us-ascii?Q?CYaLECNBj3fHbrAcMqCeJr771FkhZb1SfMvO3Rp3uANVVstBpKZ0mOHlpORc?=
 =?us-ascii?Q?0Dn5xKY8HLibLtDy2KihpZexAtO+oB3FgO9YfOTsGwrfCmTKSWy+FnZcfbj+?=
 =?us-ascii?Q?CeoyU0IGoyXUsNcE2wzo2XSumvsqzHxeY7B5mnD6QCZzOKpcjHbfYqFojeXQ?=
 =?us-ascii?Q?evd1jb4A8Ii1DcnbBZFPc5oRZTi7eHtpLlU03UALWCiey9in3pGmz4tWTjji?=
 =?us-ascii?Q?iSsgmzWcASwD2xouw63dGiW9lP1X9L3XON/em+TychESDR/c+2IQWrCVToOQ?=
 =?us-ascii?Q?5uT98u71DIh6DCsuuZgjqNHYm4/Ex/pbzGdSuTLFFtL6OaTm2BzwBMz/4IZ5?=
 =?us-ascii?Q?HvNEQx65xLuhLh39lijSHeBuQL1PadjqzqGzWJ2ZcGlVa2PXt+60Hz6d7irR?=
 =?us-ascii?Q?wc5YrnMjHf5cmVbtAGehgGEZXHmbF0zuhRuYEJVe1tEJO3VYQOJfcwijxOAZ?=
 =?us-ascii?Q?wGjxHHuH+O4+2qd7ZodC4TmmlnPwbp8lIyoSp7PvAD/++Rp6k/re9pdf6v0j?=
 =?us-ascii?Q?jAnnCbxhSvV96ynr18J2S8j1gYhbfgD2Aw34SpShaqm0l2jb4e7A/9qC6/6v?=
 =?us-ascii?Q?26UrL/n6m4/MS0Mvc/P9PrSPAC8gALQguoaqLG6Fx3ODz4HN/doLcEXugXS7?=
 =?us-ascii?Q?vEFsyCZ1XwgG0QCY9GzjSAPYm4iKpCQm7P5RK1Isccwei5mPZngcPw18icxJ?=
 =?us-ascii?Q?j9DSfUIJNhS7h0R3iAxDnn9q9H0tD8uYZDIIcdMYfr23sN2pLUzfrTApI2rU?=
 =?us-ascii?Q?tMzK3pd9vOlgC6lJqgEOBkbYDYL34bBp+QpEg4gygndKKHyk3FHUPBi5B56u?=
 =?us-ascii?Q?noM8wucK/++NsMqC9gqGJfLCtpxeL5J46CmIaFft2EFGjhZM+lFJo63Pd4Vc?=
 =?us-ascii?Q?tBI7lnbyASfARsNp/FnAWx0M8Eo4dyrpDe29+zabENryKI+72xfIuiNWQyqi?=
 =?us-ascii?Q?zIq75LBDHXOMUq5LR7nIyznsh7dzuiPDx1gyM7fFa7sQLDjeIOj41oWnQTcO?=
 =?us-ascii?Q?+X6ig14AiYNgHQKLkTLPskvt3yYSCiGRAMlzxHC+IpQhcYzb9zy2xcW+Ef0o?=
 =?us-ascii?Q?jEkbBZoVrf5g6B8YCLhsRki49aDcdSf5i0hlrwg2NMHCM+88rHc4duBze59f?=
 =?us-ascii?Q?NI2phMcgv3waR2XaId1oVZv1o18G49El31f8HptBjFibkLfiptYCmu3kzqZE?=
 =?us-ascii?Q?e1U8Xy4be/0cCmOMCD6uFc0zm+T6/YZHPD1zfuKZmCNYjSaG6Uv+JV3qWviq?=
 =?us-ascii?Q?nX5rjCxv4nn+WgBLJ/nlNJrCjb6x0Wz0xAL2FXYGcYm7iroQ5lwd7Y0Ygoha?=
 =?us-ascii?Q?x1SwQ8E0hSAMeMcB5LGpkNG66b035iKHf7gun3EahNUL/1qTXNk6ZJC3CjAB?=
 =?us-ascii?Q?M9EKSAIXTkSSUm+eaQqSqivwlRezQ/Smw7vSvms9H8XJ22U83VSn5U6AR+/r?=
 =?us-ascii?Q?lLKz1kU+VMnnUuV1iEcpGpJGx+CX0GPSdHxNc873?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab59a04-e547-41ce-ff44-08db19f79e87
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 01:52:31.4460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vedzzEfFNQJQMNx6iZvFJgNPzkfXvSLP1eL0YiRBv96qzXWb6oLIAShgtUPfnjkwrLwW0M2E4crJViFkDxBYkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7546
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Since we have convert it to two DT schema, fsl-sec4.yaml and
fsl-sec4-snvs.yaml, this txt binding could be removed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/crypto/fsl-sec4.txt   | 553 ------------------
 1 file changed, 553 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/crypto/fsl-sec4.txt

diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
deleted file mode 100644
index 8f359f473ada..000000000000
--- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
+++ /dev/null
@@ -1,553 +0,0 @@
-=====================================================================
-SEC 4 Device Tree Binding
-Copyright (C) 2008-2011 Freescale Semiconductor Inc.
-
- CONTENTS
-   -Overview
-   -SEC 4 Node
-   -Job Ring Node
-   -Run Time Integrity Check (RTIC) Node
-   -Run Time Integrity Check (RTIC) Memory Node
-   -Secure Non-Volatile Storage (SNVS) Node
-   -Secure Non-Volatile Storage (SNVS) Low Power (LP) RTC Node
-   -Full Example
-
-NOTE: the SEC 4 is also known as Freescale's Cryptographic Accelerator
-Accelerator and Assurance Module (CAAM).
-
-=====================================================================
-Overview
-
-DESCRIPTION
-
-SEC 4 h/w can process requests from 2 types of sources.
-1. DPAA Queue Interface (HW interface between Queue Manager & SEC 4).
-2. Job Rings (HW interface between cores & SEC 4 registers).
-
-High Speed Data Path Configuration:
-
-HW interface between QM & SEC 4 and also BM & SEC 4, on DPAA-enabled parts
-such as the P4080.  The number of simultaneous dequeues the QI can make is
-equal to the number of Descriptor Controller (DECO) engines in a particular
-SEC version.  E.g., the SEC 4.0 in the P4080 has 5 DECOs and can thus
-dequeue from 5 subportals simultaneously.
-
-Job Ring Data Path Configuration:
-
-Each JR is located on a separate 4k page, they may (or may not) be made visible
-in the memory partition devoted to a particular core.  The P4080 has 4 JRs, so
-up to 4 JRs can be configured; and all 4 JRs process requests in parallel.
-
-=====================================================================
-SEC 4 Node
-
-Description
-
-    Node defines the base address of the SEC 4 block.
-    This block specifies the address range of all global
-    configuration registers for the SEC 4 block.  It
-    also receives interrupts from the Run Time Integrity Check
-    (RTIC) function within the SEC 4 block.
-
-PROPERTIES
-
-   - compatible
-      Usage: required
-      Value type: <string>
-      Definition: Must include "fsl,sec-v4.0"
-
-   - fsl,sec-era
-      Usage: optional
-      Value type: <u32>
-      Definition: A standard property. Define the 'ERA' of the SEC
-          device.
-
-   - #address-cells
-       Usage: required
-       Value type: <u32>
-       Definition: A standard property.  Defines the number of cells
-           for representing physical addresses in child nodes.
-
-   - #size-cells
-       Usage: required
-       Value type: <u32>
-       Definition: A standard property.  Defines the number of cells
-           for representing the size of physical addresses in
-           child nodes.
-
-   - reg
-      Usage: required
-      Value type: <prop-encoded-array>
-      Definition: A standard property.  Specifies the physical
-          address and length of the SEC4 configuration registers.
-          registers
-
-   - ranges
-       Usage: required
-       Value type: <prop-encoded-array>
-       Definition: A standard property.  Specifies the physical address
-           range of the SEC 4.0 register space (-SNVS not included).  A
-           triplet that includes the child address, parent address, &
-           length.
-
-   - interrupts
-      Usage: required
-      Value type: <prop_encoded-array>
-      Definition:  Specifies the interrupts generated by this
-           device.  The value of the interrupts property
-           consists of one interrupt specifier. The format
-           of the specifier is defined by the binding document
-           describing the node's interrupt parent.
-
-   - clocks
-      Usage: required if SEC 4.0 requires explicit enablement of clocks
-      Value type: <prop_encoded-array>
-      Definition:  A list of phandle and clock specifier pairs describing
-          the clocks required for enabling and disabling SEC 4.0.
-
-   - clock-names
-      Usage: required if SEC 4.0 requires explicit enablement of clocks
-      Value type: <string>
-      Definition: A list of clock name strings in the same order as the
-          clocks property.
-
-   Note: All other standard properties (see the Devicetree Specification)
-   are allowed but are optional.
-
-
-EXAMPLE
-
-iMX6QDL/SX requires four clocks
-
-	crypto@300000 {
-		compatible = "fsl,sec-v4.0";
-		fsl,sec-era = <2>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0x300000 0x10000>;
-		ranges = <0 0x300000 0x10000>;
-		interrupt-parent = <&mpic>;
-		interrupts = <92 2>;
-		clocks = <&clks IMX6QDL_CLK_CAAM_MEM>,
-			 <&clks IMX6QDL_CLK_CAAM_ACLK>,
-			 <&clks IMX6QDL_CLK_CAAM_IPG>,
-			 <&clks IMX6QDL_CLK_EIM_SLOW>;
-		clock-names = "mem", "aclk", "ipg", "emi_slow";
-	};
-
-
-iMX6UL does only require three clocks
-
-	crypto: crypto@2140000 {
-		compatible = "fsl,sec-v4.0";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0x2140000 0x3c000>;
-		ranges = <0 0x2140000 0x3c000>;
-		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-
-		clocks = <&clks IMX6UL_CLK_CAAM_MEM>,
-			 <&clks IMX6UL_CLK_CAAM_ACLK>,
-			 <&clks IMX6UL_CLK_CAAM_IPG>;
-		clock-names = "mem", "aclk", "ipg";
-	};
-
-=====================================================================
-Job Ring (JR) Node
-
-    Child of the crypto node defines data processing interface to SEC 4
-    across the peripheral bus for purposes of processing
-    cryptographic descriptors. The specified address
-    range can be made visible to one (or more) cores.
-    The interrupt defined for this node is controlled within
-    the address range of this node.
-
-  - compatible
-      Usage: required
-      Value type: <string>
-      Definition: Must include "fsl,sec-v4.0-job-ring"
-
-  - reg
-      Usage: required
-      Value type: <prop-encoded-array>
-      Definition: Specifies a two JR parameters:  an offset from
-          the parent physical address and the length the JR registers.
-
-   - fsl,liodn
-       Usage: optional-but-recommended
-       Value type: <prop-encoded-array>
-       Definition:
-           Specifies the LIODN to be used in conjunction with
-           the ppid-to-liodn table that specifies the PPID to LIODN mapping.
-           Needed if the PAMU is used.  Value is a 12 bit value
-           where value is a LIODN ID for this JR. This property is
-           normally set by boot firmware.
-
-   - interrupts
-      Usage: required
-      Value type: <prop_encoded-array>
-      Definition:  Specifies the interrupts generated by this
-           device.  The value of the interrupts property
-           consists of one interrupt specifier. The format
-           of the specifier is defined by the binding document
-           describing the node's interrupt parent.
-
-EXAMPLE
-	jr@1000 {
-		compatible = "fsl,sec-v4.0-job-ring";
-		reg = <0x1000 0x1000>;
-		fsl,liodn = <0x081>;
-		interrupt-parent = <&mpic>;
-		interrupts = <88 2>;
-	};
-
-
-=====================================================================
-Run Time Integrity Check (RTIC) Node
-
-  Child node of the crypto node.  Defines a register space that
-  contains up to 5 sets of addresses and their lengths (sizes) that
-  will be checked at run time.  After an initial hash result is
-  calculated, these addresses are checked by HW to monitor any
-  change.  If any memory is modified, a Security Violation is
-  triggered (see SNVS definition).
-
-
-  - compatible
-      Usage: required
-      Value type: <string>
-      Definition: Must include "fsl,sec-v4.0-rtic".
-
-   - #address-cells
-       Usage: required
-       Value type: <u32>
-       Definition: A standard property.  Defines the number of cells
-           for representing physical addresses in child nodes.  Must
-           have a value of 1.
-
-   - #size-cells
-       Usage: required
-       Value type: <u32>
-       Definition: A standard property.  Defines the number of cells
-           for representing the size of physical addresses in
-           child nodes.  Must have a value of 1.
-
-  - reg
-      Usage: required
-      Value type: <prop-encoded-array>
-      Definition: A standard property.  Specifies a two parameters:
-          an offset from the parent physical address and the length
-          the SEC4 registers.
-
-   - ranges
-       Usage: required
-       Value type: <prop-encoded-array>
-       Definition: A standard property.  Specifies the physical address
-           range of the SEC 4 register space (-SNVS not included).  A
-           triplet that includes the child address, parent address, &
-           length.
-
-EXAMPLE
-	rtic@6000 {
-		compatible = "fsl,sec-v4.0-rtic";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0x6000 0x100>;
-		ranges = <0x0 0x6100 0xe00>;
-	};
-
-=====================================================================
-Run Time Integrity Check (RTIC) Memory Node
-  A child node that defines individual RTIC memory regions that are used to
-  perform run-time integrity check of memory areas that should not modified.
-  The node defines a register that contains the memory address &
-  length (combined) and a second register that contains the hash result
-  in big endian format.
-
-  - compatible
-      Usage: required
-      Value type: <string>
-      Definition: Must include "fsl,sec-v4.0-rtic-memory".
-
-  - reg
-      Usage: required
-      Value type: <prop-encoded-array>
-      Definition: A standard property.  Specifies two parameters:
-          an offset from the parent physical address and the length:
-
-          1. The location of the RTIC memory address & length registers.
-          2. The location RTIC hash result.
-
-  - fsl,rtic-region
-       Usage: optional-but-recommended
-       Value type: <prop-encoded-array>
-       Definition:
-           Specifies the HW address (36 bit address) for this region
-           followed by the length of the HW partition to be checked;
-           the address is represented as a 64 bit quantity followed
-           by a 32 bit length.
-
-   - fsl,liodn
-       Usage: optional-but-recommended
-       Value type: <prop-encoded-array>
-       Definition:
-           Specifies the LIODN to be used in conjunction with
-           the ppid-to-liodn table that specifies the PPID to LIODN
-           mapping.  Needed if the PAMU is used.  Value is a 12 bit value
-           where value is a LIODN ID for this RTIC memory region. This
-           property is normally set by boot firmware.
-
-EXAMPLE
-	rtic-a@0 {
-		compatible = "fsl,sec-v4.0-rtic-memory";
-		reg = <0x00 0x20 0x100 0x80>;
-		fsl,liodn   = <0x03c>;
-		fsl,rtic-region  = <0x12345678 0x12345678 0x12345678>;
-	};
-
-=====================================================================
-Secure Non-Volatile Storage (SNVS) Node
-
-    Node defines address range and the associated
-    interrupt for the SNVS function.  This function
-    monitors security state information & reports
-    security violations. This also included rtc,
-    system power off and ON/OFF key.
-
-  - compatible
-      Usage: required
-      Value type: <string>
-      Definition: Must include "fsl,sec-v4.0-mon" and "syscon".
-
-  - reg
-      Usage: required
-      Value type: <prop-encoded-array>
-      Definition: A standard property.  Specifies the physical
-          address and length of the SEC4 configuration
-          registers.
-
-   - #address-cells
-       Usage: required
-       Value type: <u32>
-       Definition: A standard property.  Defines the number of cells
-           for representing physical addresses in child nodes.  Must
-           have a value of 1.
-
-   - #size-cells
-       Usage: required
-       Value type: <u32>
-       Definition: A standard property.  Defines the number of cells
-           for representing the size of physical addresses in
-           child nodes.  Must have a value of 1.
-
-   - ranges
-       Usage: required
-       Value type: <prop-encoded-array>
-       Definition: A standard property.  Specifies the physical address
-           range of the SNVS register space.  A triplet that includes
-           the child address, parent address, & length.
-
-   - interrupts
-      Usage: optional
-      Value type: <prop_encoded-array>
-      Definition:  Specifies the interrupts generated by this
-           device.  The value of the interrupts property
-           consists of one interrupt specifier. The format
-           of the specifier is defined by the binding document
-           describing the node's interrupt parent.
-
-EXAMPLE
-	sec_mon@314000 {
-		compatible = "fsl,sec-v4.0-mon", "syscon";
-		reg = <0x314000 0x1000>;
-		ranges = <0 0x314000 0x1000>;
-		interrupt-parent = <&mpic>;
-		interrupts = <93 2>;
-	};
-
-=====================================================================
-Secure Non-Volatile Storage (SNVS) Low Power (LP) RTC Node
-
-  A SNVS child node that defines SNVS LP RTC.
-
-  - compatible
-      Usage: required
-      Value type: <string>
-      Definition: Must include "fsl,sec-v4.0-mon-rtc-lp".
-
-  - interrupts
-      Usage: required
-      Value type: <prop_encoded-array>
-      Definition: Specifies the interrupts generated by this
-	   device.  The value of the interrupts property
-	   consists of one interrupt specifier. The format
-	   of the specifier is defined by the binding document
-	   describing the node's interrupt parent.
-
- - regmap
-	Usage: required
-	Value type: <phandle>
-	Definition: this is phandle to the register map node.
-
- - offset
-	Usage: option
-	value type: <u32>
-	Definition: LP register offset. default it is 0x34.
-
-   - clocks
-      Usage: optional, required if SNVS LP RTC requires explicit
-          enablement of clocks
-      Value type: <prop_encoded-array>
-      Definition:  a clock specifier describing the clock required for
-          enabling and disabling SNVS LP RTC.
-
-   - clock-names
-      Usage: optional, required if SNVS LP RTC requires explicit
-          enablement of clocks
-      Value type: <string>
-      Definition: clock name string should be "snvs-rtc".
-
-EXAMPLE
-	sec_mon_rtc_lp@1 {
-		compatible = "fsl,sec-v4.0-mon-rtc-lp";
-		interrupts = <93 2>;
-		regmap = <&snvs>;
-		offset = <0x34>;
-		clocks = <&clks IMX7D_SNVS_CLK>;
-		clock-names = "snvs-rtc";
-	};
-
-=====================================================================
-System ON/OFF key driver
-
-  The snvs-pwrkey is designed to enable POWER key function which controlled
-  by SNVS ONOFF, the driver can report the status of POWER key and wakeup
-  system if pressed after system suspend.
-
-  - compatible:
-      Usage: required
-      Value type: <string>
-      Definition: Mush include "fsl,sec-v4.0-pwrkey".
-
-  - interrupts:
-      Usage: required
-      Value type: <prop_encoded-array>
-      Definition: The SNVS ON/OFF interrupt number to the CPU(s).
-
-  - linux,keycode:
-      Usage: option
-      Value type: <int>
-      Definition: Keycode to emit, KEY_POWER by default.
-
-  - wakeup-source:
-      Usage: option
-      Value type: <boo>
-      Definition: Button can wake-up the system.
-
- - regmap:
-      Usage: required:
-      Value type: <phandle>
-      Definition: this is phandle to the register map node.
-
-EXAMPLE:
-	snvs-pwrkey@020cc000 {
-		compatible = "fsl,sec-v4.0-pwrkey";
-		regmap = <&snvs>;
-		interrupts = <0 4 0x4>
-	        linux,keycode = <116>; /* KEY_POWER */
-		wakeup-source;
-	};
-
-=====================================================================
-FULL EXAMPLE
-
-	crypto: crypto@300000 {
-		compatible = "fsl,sec-v4.0";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0x300000 0x10000>;
-		ranges = <0 0x300000 0x10000>;
-		interrupt-parent = <&mpic>;
-		interrupts = <92 2>;
-
-		sec_jr0: jr@1000 {
-			compatible = "fsl,sec-v4.0-job-ring";
-			reg = <0x1000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <88 2>;
-		};
-
-		sec_jr1: jr@2000 {
-			compatible = "fsl,sec-v4.0-job-ring";
-			reg = <0x2000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <89 2>;
-		};
-
-		sec_jr2: jr@3000 {
-			compatible = "fsl,sec-v4.0-job-ring";
-			reg = <0x3000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <90 2>;
-		};
-
-		sec_jr3: jr@4000 {
-			compatible = "fsl,sec-v4.0-job-ring";
-			reg = <0x4000 0x1000>;
-			interrupt-parent = <&mpic>;
-			interrupts = <91 2>;
-		};
-
-		rtic@6000 {
-			compatible = "fsl,sec-v4.0-rtic";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x6000 0x100>;
-			ranges = <0x0 0x6100 0xe00>;
-
-			rtic_a: rtic-a@0 {
-				compatible = "fsl,sec-v4.0-rtic-memory";
-				reg = <0x00 0x20 0x100 0x80>;
-			};
-
-			rtic_b: rtic-b@20 {
-				compatible = "fsl,sec-v4.0-rtic-memory";
-				reg = <0x20 0x20 0x200 0x80>;
-			};
-
-			rtic_c: rtic-c@40 {
-				compatible = "fsl,sec-v4.0-rtic-memory";
-				reg = <0x40 0x20 0x300 0x80>;
-			};
-
-			rtic_d: rtic-d@60 {
-				compatible = "fsl,sec-v4.0-rtic-memory";
-				reg = <0x60 0x20 0x500 0x80>;
-			};
-		};
-	};
-
-	sec_mon: sec_mon@314000 {
-		compatible = "fsl,sec-v4.0-mon";
-		reg = <0x314000 0x1000>;
-		ranges = <0 0x314000 0x1000>;
-
-		sec_mon_rtc_lp@34 {
-			compatible = "fsl,sec-v4.0-mon-rtc-lp";
-			regmap = <&sec_mon>;
-			offset = <0x34>;
-			interrupts = <93 2>;
-			clocks = <&clks IMX7D_SNVS_CLK>;
-			clock-names = "snvs-rtc";
-		};
-
-		snvs-pwrkey@020cc000 {
-			compatible = "fsl,sec-v4.0-pwrkey";
-			regmap = <&sec_mon>;
-			interrupts = <0 4 0x4>;
-			linux,keycode = <116>; /* KEY_POWER */
-			wakeup-source;
-		};
-	};
-
-=====================================================================
-- 
2.37.1

