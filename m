Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1776AD481
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCGCQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjCGCQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:16:58 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B809D305C4;
        Mon,  6 Mar 2023 18:16:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+4GT89jkPPjerla4y6e24M/jNL2zGt/8gH17TSdR39CWUpU2jvsvKzNyidhxFs+h+8w5ARPKMqMAVsQWKW6VtO21+I4X1Ob+5TUullzbxNZslxCXIpKnUf0jpXube2Oe1ljR6mqyRZTjiwZpUZyxGaHxqbetUrhkJuihbkz1RwiWJeJ/04kDoQPZXdnn/yVGRscQ/DASS7A/srpce8xpvB1X6yoObY0IJxkEepp9Wu57UgpXnzPKsmsvRFuoCg4FVwUG7Byft7PacKGUKUCSCFrXM/ycbQ/qYMQQmq/2by6TBdnZtRvKZiiIDGC4hmeMx1saCVF70nRvV9BLrdfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcasPlqyuHis2OUqpDOrGO2nE9D7+0entKaLV7UndMU=;
 b=TmccLMFy/fh21XrVmWMk2jjUBRTnLZ4fR/NgLTcSSDmgRDAZfuZi6seeW9eFoCYQcuEUeBb18Ypr+CWqfhEw9544Qi9rBe6gY3SY5BBTHP3z0oTKIMf6ryFDTrEiMxOe5XtNTmsMKYnk+hK/5g3tTldRv01ItVs05TLGAJnIN3c5UAm/M2PxuPcJ3rRAC4WASBj1ZpHaVnXw7R24pk+Nv6HKD5JJ1Gi4lwk2SBZinZ/PamTEacmbq5NiEfaqi08qzeeeLqbkhxm40RLBHofezjvfOn+Fl0eTMqU44PVnQh99e/HqHF3D/8hPPCTbUNRE9B3MRtjPN7pTxhGULSDKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcasPlqyuHis2OUqpDOrGO2nE9D7+0entKaLV7UndMU=;
 b=zgahV1ZpP8nFvx29zbScqBSkWKWk1YLlfCH4zwpKeuCAlpZFwPwvf7QQ4e1DizKBx8mmq3BJMDLLYfCLWL6VyOGAVWNw6ISbWKTaUFzseBnnZuVvOxta6JxT2lYFvzc6wdYwZHrj2OZcPUrbyCn28B3ynLRf+xOIpsWt7c8ljts=
Received: from DM6PR08CA0028.namprd08.prod.outlook.com (2603:10b6:5:80::41) by
 CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Tue, 7 Mar 2023 02:16:54 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::b7) by DM6PR08CA0028.outlook.office365.com
 (2603:10b6:5:80::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Tue, 7 Mar 2023 02:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.21 via Frontend Transport; Tue, 7 Mar 2023 02:16:53 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Mar 2023 20:16:50 -0600
From:   Brad Larson <blarson@amd.com>
To:     <krzysztof.kozlowski@linaro.org>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>,
        <andy.shevchenko@gmail.com>, <arnd@arndb.de>, <blarson@amd.com>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <brijeshkumar.singh@amd.com>, <broonie@kernel.org>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <devicetree@vger.kernel.org>, <fancer.lancer@gmail.com>,
        <gerg@linux-m68k.org>, <gsomlo@gmail.com>, <krzk@kernel.org>,
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
Subject: Re: [PATCH v10 05/15] dt-bindings: soc: amd: amd,pensando-elbasr: Add AMD Pensando SoC System Controller
Date:   Mon, 6 Mar 2023 18:16:43 -0800
Message-ID: <20230307021643.25938-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <52fb81e2-0d9b-600d-42af-1405fdd6509b@linaro.org>
References: <52fb81e2-0d9b-600d-42af-1405fdd6509b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT047:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c9f9dd0-4aef-4cb4-3bd6-08db1eb204b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NS2wvNFay8OUAh3j0fDRelO7Y7gjT051Sys/IxBqJjF0I9uMKpNrh2YpZh76VhgmC0NK5xfjCf51zdBuXt+cN7UCiONsDbzmaYYzLizERcj6bhlO7CiHhxcOOo+poFtqy2WKQAb4v9E7yzYTyQNyUKN1jX31tfcgiVXdCub2Lv5q0XCxwoWChrVLy1u/Mr8UrYDs7HuaGja5MAr9ciuTt1NqdN8D0lLJHVMF3Uahu+H3NXxEoEuBVsY/ygYtva6KVkr/MvZ/gU6cEEmoYyT49koiRkcXQfu/abRx29ED3dTgbvVa5I+amHaK6IyLe3YjmbXfDKsjNMY18a/EilldsWjM11leDSdBAxSJIzsGDvMGuDd4QvtIYvv0XozfOOgzjxAQEMbyqUM0Jxk1gEYxfX4lfuDXdHe0mpole0Ce0uwCX8MxhfLKaoJS39+b5m7y3C9nEYqejvJUagyB7Vh6QcoSIyWuwXq3lm8IMTk1aKA3MHYYfVCiN+XlMwBJMOOmeicf5VK5pC1QKjCs4N+qJ65Pew7IXeDitoYJlFXe9mjawXMNXVXrgOKsJQnATuOYXtTZCdEO9hzhgOVPE8qX77Pceg4WhSUqJghmLQZ/sumq7ugmOMeAZ8bFCb0ubm/4bov0zHsvvuQrNuci00XOKDlACW8PxGG5MuF2VzozK9HOMYC0UpZRbXz6tEgXWYI/zgymbdN/pahuJ8snTZoKd6wqtQvB7T0r8YLa6UBdmqjaB+TDCFk9x78tFKLJBGoz
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199018)(36840700001)(46966006)(40470700004)(1076003)(966005)(53546011)(36860700001)(6666004)(36756003)(426003)(47076005)(82310400005)(83380400001)(356005)(40460700003)(81166007)(82740400003)(40480700001)(16526019)(186003)(336012)(26005)(2616005)(41300700001)(70206006)(70586007)(6916009)(8676002)(4326008)(2906002)(7406005)(7416002)(5660300002)(8936002)(478600001)(316002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 02:16:53.4077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9f9dd0-4aef-4cb4-3bd6-08db1eb204b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 8:35, Krzysztof Kozlowski wrote:
> On 06/03/2023 05:07, Brad Larson wrote:
>> Support the AMD Pensando SoC Controller which is a SPI connected device
>> providing a miscellaneous set of essential board control/status registers.
>> This device is present in all Pensando SoC based designs.
>> 
>> Signed-off-by: Brad Larson <blarson@amd.com>
>> ---
>> 
>> v10 changes:
>> - Property renamed to amd,pensando-ctrl
>> - Driver is renamed and moved to soc/drivers/amd affecting binding
>> - Delete cs property, driver handles device node creation from parent num-cs
>>   fixing schema reg error in a different way
>> 
>> v9 changes:
>> - Instead of four nodes, one per chip-select, a single
>>   node is used with reset-cells in the parent.
>> - No MFD API is used anymore in the driver so it made
>>   sense to move this to drivers/spi.
>> - This driver is common for all Pensando SoC based designs
>>   so changed the name to pensando-sr.c to not make it Elba
>>   SoC specific.
>> - Added property cs for the chip-select number which is used
>>   by the driver to create /dev/pensr0.<cs>
>> 
>> ---
>>  .../bindings/soc/amd/amd,pensando-ctrl.yaml   | 60 +++++++++++++++++++
>>  1 file changed, 60 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml b/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
>> new file mode 100644
>> index 000000000000..36694077b2e6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
>
> Your subject suggests this is pensando-elbasr but you write everywhere
> pensando-ctrl. Confusing. Pick one.

I'll fix the commit message.  This driver is common across multiple Pensando SoCs
and embedding elba in the name is misleading which is why I changed it to pensando
controller (pensando-ctrl).  Sorry for the churn.

>> @@ -0,0 +1,60 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/amd/amd,pensando-ctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: AMD Pensando SoC Controller
>> +
>> +description: |
>
> No need for |

Removed |

>> +  The AMD Pensando SoC Controller is a SPI connected device with essential
>> +  control/status registers accessed on chip select 0.  This device is present
>> +  in all Pensando SoC based designs.
>> +
>> +maintainers:
>> +  - Brad Larson <blarson@amd.com>
>> +
>> +properties:
>> +  compatible:
>> +    contains:
>
> Drop 'contains'. That's not a correct syntax here.
>

Removed contains and looks like this now:

properties:
  compatible:
    enum:
      - amd,pensando-ctrl

>> +      enum:
>> +        - amd,pensando-ctrl
>> +
>> +  reg:
>> +    minItems: 1
>
> maxItems instead

Changed to maxItems: 1

>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  spi-max-frequency: true
>
> Drop, not needed.
>

Removed spi-max-frequency and included alOff w/spi-peripheral-props.yaml

>> +
>> +required:
>> +  - compatible
>> +  - spi-max-frequency
>> +  - '#reset-cells'
>
> allOf with ref to spi-peripheral-props.yaml
>
>> +
>> +unevaluatedProperties: false
>
> This is not correct without allOf (should be additionalProperties if you
> are not using allOf), which leads you to the missing allOf.

Thanks for pointing out use of spi-peripheral-props.yaml, looks like this now

+required:
+  - compatible
+  - reg
+  - '#reset-cells'
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false


>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    spi {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        num-cs = <4>;
>
> Drop num-cs, not important in this context.

Removed num-cs

>> +
>> +        system-controller@0 {
>> +            compatible = "amd,pensando-ctrl";
>> +            reg = <0>;
>> +            spi-max-frequency = <12000000>;
>> +            interrupt-parent = <&porta>;
>> +            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +            #reset-cells = <1>;
>> +        };
>> +    };
>> +
>> +...

Regards,
Brad
