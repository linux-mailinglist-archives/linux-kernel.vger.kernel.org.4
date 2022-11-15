Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7136962AF88
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 00:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiKOXiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 18:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiKOXiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:38:13 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2101.outbound.protection.outlook.com [40.107.113.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B525F2F014;
        Tue, 15 Nov 2022 15:38:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx3zbLid8vnqb1qd6H7LMhn4wVcJ+Lp7rNYHEQtSMmPGCnk9XFG0+nmb/aMKpy03pXLdsrK4V07X5KkTQOnlz7MFt8B7PeNRoXOi6+RxyYZ8ZzmWRpR2r7NPhYtpDptniPd5EEFoZmyY4yZXZa2S/7Yiz3m0LDK/VJ3BuWx4roUiW+YgqUyTdDU+ic2bS76z3kbUTeJPyxNvR2t0ML7aot8QXbJB3LR7UYU+2iL7KgZujot5sK9dBFFt3GncLcz2Y4PO+MGwX7yV60T/ITU7KLA101vXteRFRY5eAyACnWCIaUmRRt8JOnIAwjLPPoYvaY/Oa05ou4aqpUM8QmwQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1cGHvTkjdY9OxBVTybT34f5HBYR3sOWmTuy940HFTk=;
 b=mq+dFkEOwlgDxwQtBglNE6hCtbljP1Vq5ZVoLh3tcPp4mUzJDlZYt68j72iYmDFH9fH7UX9DprX999zUp2xk4bMIUp76Ng8SXO2lZa/ChXRh2FxBceT6fB6n9VgOl7SrZd24B/DfVrwju8KFzUhZMVUr43CihMj2voM7kwK/Js4i4Vhe3L0Lne49MXszhzPz/7mWtQD+XGPR7RSh6qMrW9eChxBMFmw2+0JXWe6hmhotNFGQTnVdQWbEUZBdNGmjEvdDK6LrxNwxx7ZWw9JuHAjWoBXtyFrMtAutCaZOlc+RLXpFkfopgXWd4jNiNPWHI5VhgEQmmyYT34ziTqir9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1cGHvTkjdY9OxBVTybT34f5HBYR3sOWmTuy940HFTk=;
 b=IeTAXo4M10RN+CTWXFL95JGGdzq7xK/ydL/CFVJRcz48WTgcSriPUPwf0kWjUuh/huD36BZjKJDt8O2BEx+LH6D8E+51oTUTaNUYvhvVnXDRY+RYu37deg6+CAk5uMyvZyvqht5biY9Wh0Toy5ocodenJnadO3Wa174qn22iR+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by OS3PR01MB8842.jpnprd01.prod.outlook.com (2603:1096:604:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 23:38:08 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::60f7:f062:7c7c:d289]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::60f7:f062:7c7c:d289%6]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 23:38:08 +0000
From:   Alex Helms <alexander.helms.jy@renesas.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, geert+renesas@glider.be,
        alexander.helms.jy@renesas.com
Subject: [PATCH v3 1/2] dt-bindings: clock: Add bindings for Renesas ProXO
Date:   Tue, 15 Nov 2022 16:37:48 -0700
Message-Id: <20221115233749.10161-2-alexander.helms.jy@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115233749.10161-1-alexander.helms.jy@renesas.com>
References: <20221115233749.10161-1-alexander.helms.jy@renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0052.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::27) To OSAPR01MB3892.jpnprd01.prod.outlook.com
 (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB3892:EE_|OS3PR01MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f13374-72fa-4ede-a259-08dac7627314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GrEFatCia1mOoharHW2u3+D3UsISkGhxKrC/QQo0oj7YaHo+OWNen4T/m7V2yH348A+38bzBw9Jd6Me0RJwwfxfaNjwi5byQzlc7d6X0pOgJrk6Ju24kovNkQ6x/VIY+sK9FMZNXW0PBL9gcHK15a5jGnyILtX4+KGL3yzFywviMpXAqNM0o2IADFTsA0VcLls+MGsstlXKAM2WmWEe1GRKJxmyf+DA+Wjk4CjahTt7WTKkOMfGbp38tJK/zx4PFfYCM2tDYY/i4r+jLvRq6m6L3ZZgOu7+Y8PgkVOB7xDM1OgcCj1CH9O+UZrznetGzkk51v/SLDr5+OP3JEjN/FrhRow2zbbyZpkz1n5eDEBLrMj1Hxb5mfMgGdT0zlHrLJTTSeEG2Jfbs95E/cQTqsPD9DcSFcCOFAf0GENYJDj3z3XfIe4oo/oBU/bSXMJrZUtxdwLyceMQAfGj4Ouw7ULr6k0IpRI7eNagNhSeSMme/7H79Bz/yZewaewh+RV0/JaMGrjhjSPdNj74sFmYQZQfIYfsWCpWG4UDmBepphzdobZxxRz/sMlV840lo17M9hJ9TFDkb/4CPjmt/1Pr5vhyyzbB9Z4BZJneRp00y+CVbbUxaMj+QMa6AGXdhT2pR1MF+XOgGYfaSHJpEZMLejBQJTFWuutOhN3S1Ls1pGIRNVXodmdsTuPgoioale07gmW+PLfMYKPoNxkReFCI5gwDJSBiUBxUSmXBaYXiA2St4bXqM/+gislT2c1jv1U/bubtA8xVr+I6yqoGpvGd5XP5xEtclUy5E031y0shnrCCTZTqtLdktooV0Jn1hhy3kqjB+0wmepUfvheUo1f88mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199015)(1076003)(186003)(36756003)(966005)(83380400001)(6486002)(478600001)(6512007)(2616005)(107886003)(6666004)(52116002)(6506007)(86362001)(103116003)(38350700002)(8936002)(38100700002)(41300700001)(2906002)(26005)(5660300002)(316002)(8676002)(66476007)(66946007)(66556008)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dbu7LqBInr4FH9oHuQnUey1+92uYyQ7uEEWVjNVfX86e3zFFwyLVSgV/Npox?=
 =?us-ascii?Q?H7zdEZdQzzAJOdIKRUXXYrYIYafc1G9o25tD8+PoircdlbRgMyYVUfxZGJow?=
 =?us-ascii?Q?6ZNSkdI2xiCP9EqjlcgfV/dWIsWTCBz4qcpsA/J3/SW6gGIwVgm3DmWUN1YJ?=
 =?us-ascii?Q?HDxp+G2Aupc6PxMxI3mTQpwrICBy4Ex6M0nGrsS6TL8cR4bvbz7kuybY3VcH?=
 =?us-ascii?Q?px1lWv/mEV6/IXMeNJ8ToR9w6V0Wfi3najVQlQnHRDEoP4HzI6awHkdJdJOy?=
 =?us-ascii?Q?KaSV2UWZGYzWSqxN4t41/A0ujllchzuezSyDbwI5EanwvJnRYLBo1dVZTKUx?=
 =?us-ascii?Q?RpzbQFlUkbBiIIj1R2X/jzGABGof+b93I7U4XDhpA2MZk7cNKR/rc5Onkps4?=
 =?us-ascii?Q?O29AJii5sQvhMkkDl3591PwRnE8h6+9yVQD3FTp5M1znrqdIGXm1gRNEvhT+?=
 =?us-ascii?Q?w+cr1NbevaHYKOaRF34S7Z+3586XXnmbxQr8sEL2PxUOALq6Asct+UIyOd7F?=
 =?us-ascii?Q?WdB+CSlicG0F30bN0Xo4HL2se46NAEt2rXiv0T62Igy9zaTNr9Jsq6Brs5hi?=
 =?us-ascii?Q?C50KoL3IG3C7h8GNuq2eom24BDAxE0md/PX88ShNKhf+MSWzXlchjwZkUtT7?=
 =?us-ascii?Q?qv/CjoBfz+8nH/EeSLY6g4s/aHM7M9EU/crNmcOt59s/FuFpAq/hpqTwMNke?=
 =?us-ascii?Q?dsxJr0cqWQ4iUXx5P4wPwndDiNcEP8x7YxUUjfgRBdEvAygcNUwoIk8+RSRJ?=
 =?us-ascii?Q?bCzuKh7cRspqnSYIbd7Pck5/3W6XDq9DWDxgvOCld3E5U67VbNtJiDB5FEUH?=
 =?us-ascii?Q?LJg6/g88Wct39Jrrf9gEq3R/u6XRw3e5ymr6qxrktw7NCvMdKJJZ4dlCiTrz?=
 =?us-ascii?Q?seJL/5nBXxXfw39/qvCMqCkjcSM4Lk0q7QY0AGqb8ljm38gXvV6W1UATsXUl?=
 =?us-ascii?Q?R+gmlhG2fvVdu6WE8jJ+57U8esVAHTIiJ+2Nwqf0yQQ+yYRreREgnIe9XClg?=
 =?us-ascii?Q?j1VKCuJMpe/DooweGOStiHkzvzYxel5Gh7ENC1bByVQ+0Zb2fGVq5Ng46bX7?=
 =?us-ascii?Q?9g4bW24rWcR5xZxuPSy1UEF76QlX5PYF6MhR1jMsB7Mn+J3e8/f+yMAH4P/8?=
 =?us-ascii?Q?kV7pYmg61Yny39B8QFaR+opQJBV6PTozlg+4wsFoFqIwnvC7ge8G+quhqOGP?=
 =?us-ascii?Q?x9d31Mc9Lj/CQTTwYsQ1LBnN1XwryheRm1P/12xx7eCRCDvsUcaEFejjNRwn?=
 =?us-ascii?Q?nRA+wb2ZI2W4cF39nV4aTagXRJUkzufoM7EBvjCrwnC+hXMaplFOo3e75TEn?=
 =?us-ascii?Q?yNRtT1X6bcU7fSH6IQ7NupONyeA29zHC+5RtVTkW5J0Tz4gUMTUl8AlUBg0e?=
 =?us-ascii?Q?q2lS/Rb0Jf9cjGo1csTdj5O8W9h60n07fdiB9F62WkVyoy20adUjOBqmeO3X?=
 =?us-ascii?Q?JYMj7Jdi/spfeNxdnM4YJbpwAvWBJvt14QOq78em0LKGiy2JZ2xyJXcvOuz/?=
 =?us-ascii?Q?9NmZqKpHyDtUFikpaRZl9A/Ub3G2uwcf47/PAb3fPevbqbbKL7KZrn09icOH?=
 =?us-ascii?Q?O5PrdY9TIAnv2HWqPMootM6QVG5neSEcK7kthZVqU17JcD/besfze9i6zZiN?=
 =?us-ascii?Q?ByDMsn8NhVYo9tpp8DcljPM=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f13374-72fa-4ede-a259-08dac7627314
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 23:38:07.9675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdqgiTDwhaAu4sHDsa8Rfv6cohgvda/8DtLcfmjiT4fogJSCH8aT7/DeqxLXxI2pwnWWfTjWLauCpr/z8F5TKXu6296WmDWbf6mUni3klP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8842
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt bindings for the Renesas ProXO oscillator.

Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
---
 .../bindings/clock/renesas,proxo.yaml         | 51 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,proxo.yaml

diff --git a/Documentation/devicetree/bindings/clock/renesas,proxo.yaml b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
new file mode 100644
index 000000000..ff960196d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/renesas,proxo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas ProXO Oscillator Device Tree Bindings
+
+maintainers:
+  - Alex Helms <alexander.helms.jy@renesas.com>
+
+description:
+  Renesas ProXO is a family of programmable ultra-low phase noise
+  quartz-based oscillators.
+
+properties:
+  '#clock-cells':
+    const: 0
+
+  compatible:
+    enum:
+      - renesas,proxo-xp
+
+  reg:
+    maxItems: 1
+
+  clock-output-names:
+    maxItems: 1
+
+  renesas,crystal-frequency-hz:
+    description: Internal crystal frequency, default is 50000000 (50MHz)
+
+required:
+  - '#clock-cells'
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      proxo: clock-controller@55 {
+        compatible = "renesas,proxo-xp";
+        reg = <0x55>;
+        #clock-cells = <0>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 350102355..d52a8a5d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16080,6 +16080,11 @@ S:	Supported
 F:	Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
 F:	drivers/iio/adc/rzg2l_adc.c
 
+RENESAS PROXO CLOCK DRIVER
+M:	Alex Helms <alexander.helms.jy@renesas.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/renesas,proxo.yaml
+
 RESET CONTROLLER FRAMEWORK
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 S:	Maintained
-- 
2.30.2

