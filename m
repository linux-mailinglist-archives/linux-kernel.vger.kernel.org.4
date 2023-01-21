Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DBA6762A1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 02:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjAUBKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 20:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjAUBKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 20:10:40 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907725274;
        Fri, 20 Jan 2023 17:10:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RO/E+NGcFf+B5ijE/PBv6wfxLsL7KhePesSwJND2obwUZj7R36aXIGGe9nk1ubhNeBD6nSWp8CW749lDnL16f6p+yPgllm7zsOqZls+52tRkIO2RWKWyBWEGJENdkiUTXdH4atnWY1lCpvRUV/YHQi48AvLUD9tp/vuzy5baBg1HeZ4E1pygeH1/loj0R2qi+6Ax42/+qJNIPU11ogDvsl6htcloNPIKJS6y+cHLnNRzJv61MHUDRLoSnxq/HgEhH6v4ZLADWWGHn2pSMYLc4EabGGhR+2cOic3uuafwREDUy6cajYWZ27pvThGszsXu/mbzmJ7x5pG3kkzjr1s72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eWLbbNOvHgck1bTH9zYLJMkhJ3mzuuQBlSY607oxuM=;
 b=e+P162dChc5HXKHB+zo1a8Y8v3KMSalvstIr5/UQ8tE9tRK7Dc2qMwjcwpmXRxMqdTCFK2xzS0Ju3WgnK3N4h77ml9ZXiP0UTSuCgpTCXnyOu+x13JcqU27SJJPy1HqnVMj4moKg/ra4iK+mKsoTXwvu2VmdM/q+npANCkV4ZQ3Jn7RnDUDiwCO9WqVH+gWYTKYHmoU+MzHgbVNSh9Dn2YgQTelwV/zNqm8Zv7MVfaj27geoMwOWsSdkpJfZ20uIcaRi5UjGhLUfUpOhp+AEWvost7zzOX/sqlXsosTD3tDgbWvO39upYgwRBNts/CQNfB0xQxLp41v4ty+HX/PDiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eWLbbNOvHgck1bTH9zYLJMkhJ3mzuuQBlSY607oxuM=;
 b=RqLL57FNnbLbP3vYAvjggPBwmk11L6LBy59nD5elbFOYCzUh/A259c55NMVaiPUYdlJmKG5Jp8KKCZVTXvsMxNb4HZvfuyIgHMKuuqt/QYiBOqCvM9IBH0KepglwKIJATBMeRWy/UQE2H+xl2/nbPopwGrSWCXo+UFDRAifOWrk=
Received: from DM6PR08CA0051.namprd08.prod.outlook.com (2603:10b6:5:1e0::25)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Sat, 21 Jan
 2023 01:10:36 +0000
Received: from DS1PEPF0000E64A.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::6b) by DM6PR08CA0051.outlook.office365.com
 (2603:10b6:5:1e0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27 via Frontend
 Transport; Sat, 21 Jan 2023 01:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E64A.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Sat, 21 Jan 2023 01:10:35 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 19:10:10 -0600
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
Subject: Re: [PATCH v9 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
Date:   Fri, 20 Jan 2023 17:10:04 -0800
Message-ID: <20230121011004.38654-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <f85cdf27-7ea0-14a8-10b0-7a9ac137a040@linaro.org>
References: <f85cdf27-7ea0-14a8-10b0-7a9ac137a040@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64A:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: 8516f73d-8fab-475d-812a-08dafb4c4d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ORViS0p6GTXczKriJkNmipJBguVv8csBKvKFRvZ+2CjyQmdPUuo/Qq4iGgA43sPPfrLVsZwKpOw4UoKQ0nelTsdfGoTEPl232JnaJizyT/1fa7O5JA5cRUFiQQ1tZaoOVmwziwWMqDglvNbMOo1VyA2gCs6BvnutCaucAbiezmbWo430xiEf2ce1m6WUXMmQUcPYFgKMTl7jPJy9WoBd2zTy08oicDWsHnXh4vjwbIpCa2SZEILffm6Tkd3zH3LX8TBrl/QrD7fbdNYfddXOy5V5ZpnSI+UaYsJxFzFtXatQfQzPDWls78L2NnMtSLGkQWBe+Ac8Cz72hGAMpZ7R/AkLnvUOpmWAc31x0dsN2YbfXAtLXt5leDpT8Hy5yThMCnAsfwUstIwgGLEo604Ol21ss0RW8fWRkrjfQsZ0NFrOT6xSXqRRSsyRKxHJOGEH7bK21TahK1/MrPsMEhnM+DKlQapMvfQygehOsZ4Fgbj0vuZZ/J9tlYYzqJr4QeiUUwvfVU+ZO2tXHjM7jhu+LFzCj4dxIqbOqt/9G+0tNk2VXICplKPp2fpJ5rWBosrBF5fGpL9MnYTX8F1rs6xP184d2jNzlc9AqQlfCoEOXshnifrjdymYgu0S9uf0KBHItvd9WS65R+8AaBHIvGKmhH2dTn7EUdJCxbzbKzJNj0VcAhYk/jO2OyCQJBFdYVzWMuPVR/4a7VtOZ8TxlXdwHig9m4h6MbBPqFb13ILAuTg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(5660300002)(8936002)(4326008)(7416002)(7406005)(8676002)(82310400005)(6916009)(70586007)(70206006)(6666004)(186003)(2906002)(16526019)(26005)(54906003)(36756003)(478600001)(2616005)(316002)(53546011)(83380400001)(41300700001)(40480700001)(82740400003)(356005)(36860700001)(47076005)(81166007)(426003)(1076003)(40460700003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 01:10:35.8248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8516f73d-8fab-475d-812a-08dafb4c4d48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 7:47 UTC, Krzysztof Kozlowski wrote:
>On 19/01/2023 04:51, Brad Larson wrote:
>> AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
>> explicitly controls byte-lane enables.
>> 
...
>> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>> index 8b1a0fdcb5e3..f7dd6f990f96 100644
>> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>> @@ -16,12 +16,14 @@ properties:
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
>> @@ -111,12 +113,36 @@ properties:
>>      minimum: 0
>>      maximum: 0x7f
>>  
>> +  reset-names:
>> +    items:
>> +      - const: hw
>> +
>> +  resets:
>> +    description:
>> +      optional. phandle to the system reset controller with line index
>
>Drop "optional"
>Drop "phandle to the" and rephrase it to describe physical reset line.
>Don't describe here DT syntax (phandle) but the hardware. What is
>expected to be here?

Done, see the resulting diff below for full context.  The missing
'contains' was the bug.

>> +      for mmc hw reset line if exists.
>> +    maxItems: 1
>> +
>>  required:
>>    - compatible
>>    - reg
>>    - interrupts
>>    - clocks
>>  
>> +if:
>
>Move the allO from the top here and put it under it. Saves indentation soon.

Yes.

>> +  properties:
>> +    compatible:
>> +      const: amd,pensando-elba-sd4hc
>
>BTW, this probably won't even work and that's the answer why you added
>fake maxItems: 2... This should make you think about the bug. You must
>use contains.

That was the problem, see updated diff below.  Passes dtbs_check and dt_binding_check.

>> +then:
>> +  properties:
>> +    reg:
>> +      minItems: 2
>> +else:
>> +  properties:
>> +    reg:
>> +      minItems: 1
>> +      maxItems: 2
>
>No, why do you suddenly allow two items on all variants? This was not
>described in your commit msg at all, so I expect here maxItems: 1.

Set maxItems: 1.

>Also, unless your reset is applicable to all variants, resets: false and
>reset-names: false.

Added false for both, this is the diff with above changes

--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -9,19 +9,18 @@ title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
 maintainers:
   - Masahiro Yamada <yamada.masahiro@socionext.com>
 
-allOf:
-  - $ref: mmc-controller.yaml
-
 properties:
   compatible:
     items:
       - enum:
+          - amd,pensando-elba-sd4hc
           - microchip,mpfs-sd4hc
           - socionext,uniphier-sd4hc
       - const: cdns,sd4hc
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     maxItems: 1
@@ -111,12 +110,42 @@ properties:
     minimum: 0
     maximum: 0x7f
 
+  reset-names:
+    items:
+      - const: hw
+
+  resets:
+    description:
+      physical line number to hardware reset the mmc
+    maxItems: 1
+
 required:
   - compatible
   - reg
   - interrupts
   - clocks
 
+allOf:
+  - $ref: mmc-controller.yaml
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amd,pensando-elba-sd4hc
+    then:
+      required:
+        - reset-names
+        - resets
+      properties:
+        reg:
+          minItems: 2
+    else:
+      properties:
+        reset-names: false
+        resets: false
+        reg:
+          maxItems: 1
+

Regards,
Brad
