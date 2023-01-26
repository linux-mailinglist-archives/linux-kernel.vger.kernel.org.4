Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4A067C2FB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjAZDA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjAZDAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:00:54 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F0C5B59D;
        Wed, 25 Jan 2023 19:00:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLn9G3Lfr00VOyiXEfc5brWX6LQoak7FARm6ajUebUUGFYY/8INIfHpdaUjA+pwJy7+APNywkBf83v9L+stEU0WfC/cR6ORjdp9hTwfPLN1/CxpfcpV/kJbNvoRwbTnDvaEuBGWPwifwd0gax9n6VPxDe/Zm15hYL3WFX3d42h/NKdYoZZIlh6/ukJOplsDbfAUlSXFB78nses0Vko4i6DcG1vfupul34mWpQ56PRzST9TSpa6NNe6hrvG/w1/toZXeOWHe2bK0EZ3LjUPglAbygHNtnXmG2TXYLFGTzLyLel4/zY66Vq18jtQU8uKHVhXnEMhtMZ25bRpGqX2y/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaN9alzCpC5KbZIB+l0mH91WgDwkYu5YErkjsxncQQE=;
 b=bKG87emfILL/2W+l1jib3FwH1qza2U7ZDKde5DVraL88vzMZHZ7R3s52hjfqxt6kk2QUBetDoZXdaEcwzdfxIt1gT4VwsDaTzuG4QhIsvSxVPWlcPLDB1nq7qCYoh3tMMS3To5ntDPKBKvZhJ7KqBhRWBG/ABXOHjCqys68xFAlztTn5KERPrPoQpjTbayNbzF5lM5sudvO7y+LCDDMtzoEKujV4FEttznHxEbC756bKzYxU+/n8kSPpTiQiGLoEkxV0KLZCv3aLPWDLZyq0f/lWyHbVxHoqZHUvl1lBarTybSqCuzsD42zWPWWlDosrhEP+XtmYyoSxp7l2YL0TtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaN9alzCpC5KbZIB+l0mH91WgDwkYu5YErkjsxncQQE=;
 b=cTj0EagCt5L3X6v66jFdWzvrUCti0GmGzoMxWBCRoFVRzHHbSfRlxHXaMshqEmqvYxPo4BSpjFO0La3/GOo/eixs8GvWx/wcxbKzAkRJv7IXTB6L8XrdLIm7DLETrlTX31cs1RXDM95HVKKRS1YklbrNkycTlumFj6vuSdCXXT0=
Received: from DS7PR03CA0343.namprd03.prod.outlook.com (2603:10b6:8:55::17) by
 DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22; Thu, 26 Jan 2023 03:00:50 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::b2) by DS7PR03CA0343.outlook.office365.com
 (2603:10b6:8:55::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20 via Frontend
 Transport; Thu, 26 Jan 2023 03:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 26 Jan 2023 03:00:50 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 25 Jan 2023 21:00:46 -0600
From:   Brad Larson <blarson@amd.com>
To:     <krzysztof.kozlowski@linaro.org>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>,
        <andy.shevchenko@gmail.com>, <arnd@arndb.de>, <blarson@amd.com>,
        <brad@pensando.io>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <broonie@kernel.org>, <catalin.marinas@arm.com>,
        <davidgow@google.com>, <devicetree@vger.kernel.org>,
        <fancer.lancer@gmail.com>, <gerg@linux-m68k.org>,
        <gsomlo@gmail.com>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee.jones@linaro.org>,
        <lee@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.yadav@ti.com>,
        <p.zabel@pengutronix.de>, <piotrs@cadence.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v9 06/15] dt-bindings: mfd: amd,pensando-elbasr: Add AMD Pensando System Resource chip
Date:   Wed, 25 Jan 2023 18:59:56 -0800
Message-ID: <20230126025956.33859-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <a3c4feaf-c98d-5507-11f1-3dd1129f7360@linaro.org>
References: <a3c4feaf-c98d-5507-11f1-3dd1129f7360@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 322de92f-8546-49ef-21b7-08daff4987ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OtsOyJH3itGJHaVWnFql/OVIvXIYxTgGZP6sDxcNFgHGilyE7E6WhlBuFMMmOL6nrU+sNKdjk9kUaxBAr4plbZTCg1rrl172SB/+s88uebRLAVmSZkxV8PEYsEE8XNx9Kpq9iIXqTkkY5O2yCA/b5C62mNNqG1XuEWyld+i/AkZYxSXXYCT7hL+xK8qeDEptio2eFCe7LLi3Srw7Cg+5xlUVgzEpOK0MZRtd3vSE2cAUnfIYIjemElOFzxthnXWZwNxJnHXnLchPnB2zcFhWJpkKV5miEbs3bb5LsxGKgNHsh3Pa6W+OMieOrGSFCWr6yyALNaiEy+xpzdCPvi/gOc3DP80hdr8gP8T2L0D4VpX3BX8khTxete4BX1FxbqZrYMXvsi82jKNYEnMOwbg8aNocUS1rjeaZVvRxVCNpPJ4HKPxZznCh2rjkcXim7KgRVt+92cYVgXQH8FM2qnS1j7diQbMFN/a/B3z6hXBUhm+c5UgRgfDbaKCp/QtYhbOXXmdaACkE2jTS0nlwtafU9pIh6fZki6f+xvBBejjLlP59YpAfaDYNG9t5Oq7q0hlkMMaYGqLWzV+89lVJJRHJFw3P8TmRP5eVXpv1VKW0c9EUwyFBEIB3gCh+VZpAGI3nSoyOMvVGUYAuVLjyZIU0xjBxC+8G92NxIF26y9t96ggv7jsS3mYa/8qD2YcmIbAcDpHCKGqiwT/KK8fcty9VsehG2idyqtqGTBjyi/9l/RV9WNrJZQlQf1Auf0iPvg01rIYOCR6ghBZ2WNBFmu8luuYrCLNQjX6fIz67GPDnFyc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199018)(40470700004)(46966006)(36840700001)(54906003)(316002)(41300700001)(81166007)(356005)(8676002)(70206006)(6916009)(4326008)(70586007)(40460700003)(7416002)(5660300002)(7406005)(8936002)(36756003)(40480700001)(2906002)(36860700001)(82740400003)(1076003)(6666004)(26005)(186003)(16526019)(966005)(478600001)(426003)(83380400001)(47076005)(336012)(82310400005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 03:00:50.3856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 322de92f-8546-49ef-21b7-08daff4987ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> diff --git a/Documentation/devicetree/bindings/spi/amd,pensando-sr.yaml b/Documentation/devicetree/bindings/spi/amd,pensando-sr.yaml
>> new file mode 100644
>> index 000000000000..8504652f6e19
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/amd,pensando-sr.yaml
>> @@ -0,0 +1,68 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/amd,pensando-sr.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: AMD Pensando SoC Resource Controller
>> +
>> +description: |
>> +  AMD Pensando SoC Resource Controller is a set of
>> +  control/status registers accessed on four chip-selects.
>> +  This device is present in all Pensando SoC based designs.
>> +
>> +maintainers:
>> +  - Brad Larson <blarson@amd.com>
>> +
>> +properties:
>> +  compatible:
>> +    contains:
>
> That's not correct syntax. Please start from existing schema or
> example-schema. Drop contains.

Fixed, see update below.

>> +      enum:
>> +        - amd,pensando-sr
>> +
>> +  reg:
>> +    minItems: 1
>
> maxItems. Which example or existing schema pointed you to use minItems?

Should have been maxItems.  cs below is dropped and reg is used
as discussed for the chip selects but throws a too long error, see below.

>> +
>> +  cs:
>> +    minItems: 1
>> +    maxItems: 4
>> +    description:
>> +      Device chip select
>
> Drop entire property. Isn't reg for this on SPI bus?

Dropped and using reg, results in too long error for schema snps,dw-apb-ssi.yaml

>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  spi-max-frequency: true
>
>Drop. Missing reference to spi-peripheral-props.

Removed and added spi-peripheral-props

>> +
>> +required:
>> +  - compatible
>> +  - cs
>> +  - spi-max-frequency
>> +  - '#reset-cells'
>> +
>> +unevaluatedProperties: false
>
> This does not make sense on its own. It works with additional ref. When
> you add ref to spi props, it will be fine. But without it you should use
> additionalProperties: false.

The updated binding

--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/amd,pensando-sr.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/amd,pensando-sr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando SoC Resource Controller
+
+description: |
+  AMD Pensando SoC Resource Controller is a set of control/status
+  registers accessed on four chip-selects.  This device is present
+  in all Pensando SoC based designs.
+
+  CS0 is a set of miscellaneous control/status registers to
+  include reset control.  CS1/CS2 are for I2C peripherals.
+  CS3 is to access resource controller internal storage.
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  compatible:
+    const: amd,pensando-sr
+
+  reg:
+    maxItems: 4
+    minimum: 0
+    maximum: 3
+    description:
+      Device chip select number
+
+  '#reset-cells':
+    const: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - '#reset-cells'
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        num-cs = <4>;
+
+        system-controller@0 {
+            compatible = "amd,pensando-sr";
+            reg = <0 1 2 3>;
+            spi-max-frequency = <12000000>;
+            interrupt-parent = <&porta>;
+            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+            #reset-cells = <1>;
+        };
+    };
+
+...

any guidance on fixing the following?

$ make ARCH=arm64 dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK arch/arm64/boot/dts/amd/elba-asic.dtb
/home/brad/linux.v10/arch/arm64/boot/dts/amd/elba-asic.dtb: spi@2800: system-controller@0:reg: [[0], [1], [2], [3]] is too long
	From schema: /home/brad/linux.v10/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml

where the pieces are

arch/arm64/boot/dts/amd/elba.dtsi

                spi0: spi@2800 {
                        compatible = "amd,pensando-elba-spi";
                        reg = <0x0 0x2800 0x0 0x100>;
                        #address-cells = <1>;
                        #size-cells = <0>;
                        amd,pensando-elba-syscon = <&syscon>;
                        clocks = <&ahb_clk>;
                        interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
                        num-cs = <2>;
                        status = "disabled";
                };

                syscon: syscon@307c0000 {
                        compatible = "amd,pensando-elba-syscon", "syscon";
                        reg = <0x0 0x307c0000 0x0 0x3000>;
                };

arch/arm64/boot/dts/amd/elba-asic-common.dtsi

&spi0 {
        #address-cells = <1>;
        #size-cells = <0>;
        num-cs = <4>;
        cs-gpios = <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
                   <&porta 7 GPIO_ACTIVE_LOW>;
        status = "okay";

        rstc: system-controller@0 {
                compatible = "amd,pensando-sr";
                reg = <0 1 2 3>;
                spi-max-frequency = <12000000>;
                interrupt-parent = <&porta>;
                interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
                #reset-cells = <1>;
        };
};

Also should the driver for this SPI device used for every Pensando SoC 
be in drivers/misc, drivers/spi?  Didn't make sense to leave it in 
drivers/mfd once the resets was squashed in the parent and only one n
ode with reg setting which chip selects result in creation of /dev/pensr0.<cs>.  

Regards,
Brad

