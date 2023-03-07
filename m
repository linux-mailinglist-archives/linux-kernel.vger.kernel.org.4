Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBA06AD472
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCGCLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCGCLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:11:31 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958F436470;
        Mon,  6 Mar 2023 18:11:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZGAVl1UZOs2kFhosbad441K0wUW0//TZuakLdJFkRGySuyLa9iI/Cmvg9+N84qZw9Z0VaKus0Eqt/zdCp7wsPoXQmfbaV8CmkQCnLfmeR0oIJraZBqjt85AYT5dt+6lVLQ1mweB6af82+GLPrj3nd76KTk8Ol1wFVXsZq78jCOTXfF6etCjwznJWkSMzoUsv3y6g6nU4j5xm0DsDlqdLGJaWF8DK9L7tlWtgQYnqOiO6gd/+EShc0/VLqc9cDgb3KiX5gQA6lXLvlT36GPRqi9Nm7biVH9UmwslzFBU40uHMi6NtWAm1UpI3lGcGa+WZT2bA3qthFidYkab6CJs3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6R1lQXnS3wwIjwkDVZbBZiQkVT2ofu+R+3D/xqKUdA=;
 b=Syo9/Oa9SWytmoX0Drrp2Ym3FWfFmsBfHZ3DRO3A8Sa4z16BoT+21DVTO+ABJ8aH5Y7+kEFnoZikRCW9e1sUstr90pblpm4W+URwZiM6Q0N3CR0+J0WPBwKBAGxc885eHG5eQQEhdB3Wk9SMIs2O+uhWG9dzBSnUeCspUTiFQidx+V+TIjyQ9HahjOpdf0DsBDkB3TJ3TRQ+0FbBgQ4cgkkyl2MBWcrk9vfjVMEmxVrDDmFX2Ed9dR1Tran5ySpOtdbJKVyV7CkXwcaSEzQrLy/WdVdVmx34evq0FJps+q+a7yFG/ul1tzralfDq3u2lXFw+cPu6oskWyGG1pbzVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6R1lQXnS3wwIjwkDVZbBZiQkVT2ofu+R+3D/xqKUdA=;
 b=mmAg3TegbKd3ctZcgS2X7QWj3YrY40HfY9wfKYSUrHRCyaGrcs8W/IIp7xPlRG4x2i2FnX3zdlnNWYgyc6Gm9adHQnX5IDDmVNJubSOXKAHmWn2UbdyVbaYsgXV1ZkmvAm7V03d/dCWOlovQlvz73BQbu4gfQVIZN2OfplZH05M=
Received: from BN9PR03CA0440.namprd03.prod.outlook.com (2603:10b6:408:113::25)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 02:11:24 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::a8) by BN9PR03CA0440.outlook.office365.com
 (2603:10b6:408:113::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Tue, 7 Mar 2023 02:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 02:11:23 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Mar 2023 20:11:16 -0600
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
Subject: Re: [PATCH v10 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
Date:   Mon, 6 Mar 2023 18:11:03 -0800
Message-ID: <20230307021103.25299-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ebbc1c7a-2a96-409c-0e92-ae0f57ae5335@linaro.org>
References: <ebbc1c7a-2a96-409c-0e92-ae0f57ae5335@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT055:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: d3862969-b35e-4d13-6730-08db1eb14018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t85SJwzMCYJJ5Kc8sbvjas0hnhRlnZPj55qjG2GHu6yDel7HBzs3XR96vn7tSp4LYDE3c8iXOWIqMIMc+9dhj8fedOnHsBA3IsuZVHhaPrEXtlAhImRVCQl6FLyDHwREfOnesRGojGLoP/FMxHPElKITvFe5jQSeyeRJxC/groKDmMg63kh1yYmhnrHs9VW0N/RykZV88M6c8oFg8WXBgzfJtnQIJT81JdiAzNXjzk5UCTzO3LMnL/v0f6/K/fFKjelBCdHEU86ROFbDksHygeFMwWTzbL3uQJtLBtb3jNkWbNcEb9PMTKZnc38cVMcqMj2DiNSNOIVyZ2nkDNlHAnMDCiRFOckZsbpv9FnQITwR0aPBQOAtKjUS4n1SNJV4DX8oWEOQcUPmKxhTDOhftU8yfP7RpAlwenrvpdbdsZ+foKPuA6sC7Nn914grnAw1y+fCGfyVOs4dYN0tVP01bMLEQYN3dRKd3KM+WJXscalW4dG9sLEeuJ5qPvrs0X9CPE2LlG0q5Z9LNNKLYjlXWzmEM9AL+mKOTvOaVGgY+TMq2zTxlsTPRE8xXkZfJNnGwhIbhd8kS0UlPwAl6fu/7WHxzWnDdHCDg3BqX9eNSgUv3vQ7ESOaH2m3MlBVfElNkqeRQ1NgvyG3TJ67fJ3AiWsRsZHpnuVRxhq8SqVHg3BtuGoWvAZu2EQeyvwMx7JAWCtMzpEawn9eeRpLkrjmMQOkJ/M/74lsD/9H4aLnj/4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(186003)(16526019)(70206006)(81166007)(356005)(6916009)(8936002)(36860700001)(8676002)(2906002)(41300700001)(4326008)(478600001)(7406005)(82740400003)(5660300002)(70586007)(7416002)(26005)(47076005)(53546011)(6666004)(1076003)(426003)(2616005)(336012)(54906003)(36756003)(316002)(40480700001)(82310400005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 02:11:23.5505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3862969-b35e-4d13-6730-08db1eb14018
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 8:28, Krzysztof Kozlowski wrote: 
> On 06/03/2023 05:07, Brad Larson wrote:
>> AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
>> explicitly controls byte-lane enables.
>> 
>> Signed-off-by: Brad Larson <blarson@amd.com>
>> ---
>> 
>> v10 changes:
>> - Move reset-names property definition next to existing resets prop
>> - Move allOf to the bottom and set resets/reset-names required only for pensando
>> - Fix reg maxItems for existing, must be 1
>> 
>> v9 changes:
>> - Add reset-names and resets properties
>> - Add if/then on property amd,pensando-elba-sd4hc to set reg property
>>   values for minItems and maxItems
>> 
>> ---
>>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 33 ++++++++++++++++---
>>  1 file changed, 29 insertions(+), 4 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>> index adacd0535c14..0c4d6d4b2b58 100644
>> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>> @@ -9,19 +9,18 @@ title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
>>  maintainers:
>>    - Masahiro Yamada <yamada.masahiro@socionext.com>
>>  
>> -allOf:
>> -  - $ref: mmc-controller.yaml
>> -
>>  properties:
>>    compatible:
>>      items:
>>        - enum:
>> +          - amd,pensando-elba-sd4hc
>>            - microchip,mpfs-sd4hc
>>            - socionext,uniphier-sd4hc
>>        - const: cdns,sd4hc
>>  
>>    reg:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 2
>>  
>>    interrupts:
>>      maxItems: 1
>> @@ -30,8 +29,13 @@ properties:
>>      maxItems: 1
>>  
>>    resets:
>> +    description: physical line number to hardware reset the mmc
>
> This part seems to be not needed anymore. Resets field was already added.

Yes, see below.

>
>>      maxItems: 1
>>  
>> +  reset-names:
>> +    items:
>> +      - const: hw
>
> Why did you add reset-names for one item? There is no v8 of this patch,
> so I cannot find previous discussion about it.

I found resets property was added recently when I rebased.

cb7f090171393 (Kunihiko Hayashi    2023-02-13 13:52:33 +0900  32)   resets:
cb7f090171393 (Kunihiko Hayashi    2023-02-13 13:52:33 +0900  33)     maxItems: 1

I've deleted reset-names and dropped description for resets.

>
>>    # PHY DLL input delays:
>>    # They are used to delay the data valid window, and align the window to
>>    # sampling clock. The delay starts from 5ns (for delay parameter equal to 0)
>> @@ -120,6 +124,27 @@ required:
>>    - interrupts
>>    - clocks
>>  
>> +allOf:
>> +  - $ref: mmc-controller.yaml
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: amd,pensando-elba-sd4hc
>> +    then:
>> +      properties:
>> +        reg:
>> +          minItems: 2
>
> Hm, we missed to mention it before, but what is the second reg for? It's
> not obvious from the binding so probably you need to describe it instead
> minItems:
>   items:
>     - description: foo
>     - description: bar
>

The second reg is byte lane enable for writes.  The following passed dtbs_check
after getting: hint: "minItems" is only needed if less than the "items" list length

    then:
      properties:
        reg:
          items:
            - description: Host controller registers
            - description: Elba byte-lane enable register for writes
      required:
        - resets
    else:
      properties:
        resets: false
        reg:
          maxItems: 1

>> +      required:
>> +        - reset-names
>> +        - resets
>> +    else:
>> +      properties:
>> +        reset-names: false
>> +        resets: false
>> +        reg:
>> +          maxItems: 1
>> +
>>  unevaluatedProperties: false

Regards,
Brad
