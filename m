Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E05681A12
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbjA3TN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbjA3TNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:13:18 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098F8166E6;
        Mon, 30 Jan 2023 11:13:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e50cRAXVYVkCthTOdAzFHp0adR/HwkcTXRGwuH86lMw8Hcu6/ghz05lcdanDz60dw4Cb6uRTbAJleEB31iMfn3aMVavKf3C7dgV2y0GXkySBi8GULQx6HjsYl+BqU1iSCkkQ3STZT8AKqQiU0m9beObqsHAKQcGFrmM6HA/trDxlZx9x6T2McWR11QULOo5hVpCE96dGXr4YIQVTOJG6xcZsE5zESGvRhLewxlXzedGRZGRftUCKHMC5ILybP3Y/K35jPCy4addKhV59ELY2gbvSU7QHCMxE6+pa33BKkrKt8YHZh08bk/c9u69RDpcO/fv7zD8Oioa30BNjwuGJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vyzYV6v1okUKdV+Tkg+GsyLZcoe2EUioBLvAaACX6U=;
 b=Mw9N9FT9EKRHcxTazKKd3ljZOM8m/Z8MG6oimHSNvjoqyHFZErxv3h9WH4BB178vbO0Lgge3c8BuzhWj9hHFupfgll0f76dfBTf7dBq6pu1mNWJAnMBfinRUT6Nbw0dX7jppr2x4E2FkZ/pH/5D1AEvIUMQRwMqxLZ25qzJV+D9BQaI2dfBef2Kx9dXFkZlZXo+PxPufy3T4vh8ohQ1FsmzkplftYeqT8sCVIiKwxbYNxhitP7UPGdpKUrX+LjjAfQSyE5w3AeI4Ay85r/c/cD0JT/vl0gZhTKuOC/SSycUtJz4EX3L5Pp6Aj+xMHJxhG0kh3fT/QoGDjPzbQfGQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vyzYV6v1okUKdV+Tkg+GsyLZcoe2EUioBLvAaACX6U=;
 b=zFmi1dBd5FA9VThTxfhxzGlZGFN2CbO52f0yxO7IRRxeilKEwpLEKB2rUALO4l5+sv1m1NxSq734jRGKfEAOhUEye0dzX55SxBYj2WEq3ABpOsUe2e/tYF/a70gMQB+6OMtZGPvxqSBkF6OuQjzPd5M/sy/OjE/zIKZrc/KZyjw=
Received: from DM6PR03CA0089.namprd03.prod.outlook.com (2603:10b6:5:333::22)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 19:12:58 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::d) by DM6PR03CA0089.outlook.office365.com
 (2603:10b6:5:333::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 19:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.36 via Frontend Transport; Mon, 30 Jan 2023 19:12:58 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 30 Jan 2023 13:12:54 -0600
From:   Brad Larson <blarson@amd.com>
To:     <robh@kernel.org>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>,
        <andy.shevchenko@gmail.com>, <arnd@arndb.de>, <blarson@amd.com>,
        <brad@pensando.io>, <brijeshkumar.singh@amd.com>,
        <broonie@kernel.org>, <catalin.marinas@arm.com>,
        <devicetree@vger.kernel.org>, <fancer.lancer@gmail.com>,
        <gerg@linux-m68k.org>, <gsomlo@gmail.com>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <krzysztof.kozlowski@linaro.org>, <lee.jones@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <p.yadav@ti.com>, <p.zabel@pengutronix.de>, <piotrs@cadence.com>,
        <rdunlap@infradead.org>, <samuel@sholland.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <ulf.hansson@linaro.org>, <will@kernel.org>,
        <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v8 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD Pensando Elba System Resource chip
Date:   Mon, 30 Jan 2023 11:12:48 -0800
Message-ID: <20230130191248.1933-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221116223045.GA1130586-robh@kernel.org>
References: <20221116223045.GA1130586-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: b500e412-6d0f-43e1-9a1b-08db02f5ffa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvghDOKLhYKZAKvV/muW16k8HE7pKVh9C9XOSWmh3NLFXVRmtbkN4EiZLAZzazNkpNEhaHCZDh8EUxtCIlFoYgYOKuKlxx2ApG3SPL9elQcU3X/gVi/sTOU+rI9LSgds5Ci83mPG9CgP+RrBPwKpwHDAuXqhKYC3QPHaRNiu26IFM4wOGNh3lDuCCVsK90OI7x155RQty2ZKQf6uUnEEeJtlIx+bzADVPaGieAlSK9n1ny0SczSmbwMnUdTHPreGp5M4lI/+qq9h9SR9VeMspphXWMH5KC4cAhYDYjzCSfgg49ILLG++zy5nqiAwCF7zL84wuNOZlGCiP5SiDxUlBxf5kf1bb5CCzfeSSM/wbh/JVBC2niomU3m+8C084Lt7MIoL16jXd3xelQEsSOZeInGjLN5q/ppkjy17R7I11+f1sXDSu+08Ex6jx4H5e5G4/GfYrOriODXuSpoJGea8Eej02FO5q7YINv7MG/AjHy+xUne/jfYZkt5Gi2asc838etprEiBaxQadGHhi/fjcKpIiLjm6fhc2H+yOZ6NkHKx/AeiurR4X0/RvW9WyqlWGA6IS+eknaIxn9tDjfy5VIh7u55irSPMNcfpY80lbJdrVzFKh+8M4Tl/BpvQHhEBdApl9nVpOYtwykYaje1Vmhr+Xx5pI+PRviEtsHhlX8yTBvwDaoNU62bAbyNXhAnC7AUhJAEn8umeZa1u4ADT1xG8k1/Tf+Wdqgy6g2o3yodMhvi3Glz1TJJVOy4CoGgk0b1mB87YwXGgahv2We4XYZnbNVIjtPZC7SnL+LkseK/ZljcT56Cc46DPVxLqbcnKL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199018)(40470700004)(46966006)(36840700001)(70206006)(41300700001)(70586007)(4326008)(6916009)(83380400001)(8676002)(316002)(8936002)(40460700003)(36756003)(356005)(16526019)(2906002)(40480700001)(426003)(47076005)(36860700001)(7416002)(54906003)(5660300002)(478600001)(336012)(6666004)(82740400003)(1076003)(53546011)(966005)(26005)(82310400005)(186003)(2616005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 19:12:58.1365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b500e412-6d0f-43e1-9a1b-08db02f5ffa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wednesday, November 16, 2022 2:30 PM, Rob Herring wrote:
>On Wed, Nov 16, 2022 at 11:39:40AM -0800, Brad Larson wrote:
>> Add support for the AMD Pensando Elba SoC System Resource chip
>> using the SPI interface.
>
> Please resend the whole series properly threaded.

Series sent as v9

>> +description: |
>> +  AMD Pensando Elba SoC Resource Controller functions are
>> +  accessed with four chip-selects.  Reset control is on CS0.
>
> One device with 4 chip-selects? Then I'd expect 'reg = <0 1 2 3>;'
>
> Hard to say more because I don't have the whole thread nor remember what 
> exactly we discussed before. That was 100s of bindings ago...

This has been changed to one device and four chip selects. This binding error
is occuring for snps,dw-apb-ssi.yaml using reg for the chip selects.  Any
guidance on how to fix? 

$ make ARCH=arm64 dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC_CHK arch/arm64/boot/dts/amd/elba-asic.dtb
/home/brad/linux.v10/arch/arm64/boot/dts/amd/elba-asic.dtb: spi@2800: system-controller@0:reg: [[0], [1], [2], [3]] is too long
	From schema: /home/brad/linux.v10/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml

Binding:
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

DT node, single device and using reg for four chip-selects

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

Regards,
Brad
