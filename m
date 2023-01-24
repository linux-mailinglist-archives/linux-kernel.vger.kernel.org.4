Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7361B678D37
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjAXBSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjAXBSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:18:17 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC96A9772;
        Mon, 23 Jan 2023 17:18:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7OrBE5nmEEC+gwviBV3bjJAN8eZnTTVscCkyV742Xduxlqbn8vyc4JzBEHu5APsf43r7BuhOeA/d7+vBucTxiDTHAksIBRIJTatYV1UgMDR+fK7/qzyqpfL9498chQRCFTNnv/KMBXeCjL7pn1nPsWUh+PEDMood1qWVJEy0ZlKfo+hEPP6X6OdVIHxgkliRNe8e06IduMqTpXJRitqOXw5kavGC7yLIn9dejF25ENmr1tta+cdKctEJDLrrJwpMYlFxCm/yBZm/kjndFElsV2+OVMjVb4sXuWWOLcbBjpQU/bEkkfSgh3pG4eLJGV132zED29sQhIxs5MlpKr4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulgIukue4F41NVc8yt6y/E0QtI8j3xfHl1rqPHJRK+k=;
 b=jfgrVpTGiYZb+0b0rxch/1qtkUe227gNEQrT37V14amRb8Iq0uSznRXieKhiI2ari6V+0xb/B3X+vhDO18BwrgpVljfYNk3BgHpv6BCORaYwKFV9dhy9m9KHZqPa8dA1wleob9lx7VBZKTsIxfXQKVx1/a6teMxHVIYqQNX/GtrnGIT6t4rfBVGADufrPQ+Kgd9LNJL5ttNmQoHqMHRzl4OVA6e8sg/Qiwob27UeWem/zG9aoA82VFQjyVI+g/BnQMhedTp2Vwspvwx7Q5ZCdkE4lze0/YD+CCwACdkXVIDrxrthmd0BRT0i+0xYnL2zjDSk3vS4Dp7dAgy0HB1zkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulgIukue4F41NVc8yt6y/E0QtI8j3xfHl1rqPHJRK+k=;
 b=FUCTDAiW2lRw3CSvYLuNMPcDkPGWE4m/Xl0pM2FiVhFp8Q2Z7PA2R4hzZ5Y0o3g7YDz2SEAcMVw0pSeOn5D2mXMEA+il2Sg1MRfQE1BqXG1AMdTuZ65CHKfUnAa807HvTWPbtPY8HA63xGxOQZnkul7BulHIiEzTpFlvtoNvwpM=
Received: from DM5PR07CA0100.namprd07.prod.outlook.com (2603:10b6:4:ae::29) by
 DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Tue, 24 Jan 2023 01:18:09 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::8e) by DM5PR07CA0100.outlook.office365.com
 (2603:10b6:4:ae::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 01:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Tue, 24 Jan 2023 01:18:09 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 23 Jan 2023 19:16:54 -0600
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
Subject: Re: [PATCH v9 03/15] dt-bindings: spi: cdns: Add compatible for AMD Pensando Elba SoC
Date:   Mon, 23 Jan 2023 17:16:48 -0800
Message-ID: <20230124011648.52334-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <42be3c33-1055-a63e-d0ad-673d85c27d3e@linaro.org>
References: <42be3c33-1055-a63e-d0ad-673d85c27d3e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 7929dea4-72ea-402a-6ef4-08dafda8dac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wpFJOhqwfbXyxAI2txN5UbcQZZmz3H2RP9FJnwhic9gGwTz4WSZwXn4wrhRDbbbeMeLI/kIXcSsdiQxmP+T7teesWFtPsPBmw30Z+PwihJ6fzZlXNQV9iZfVu5VFIaLgmWuecqIfGv4GCvuVSQ9+nfOBA/4f3LaEVQDsia9fyXgSGoiQ7CC20DlrhQCk2Es4GAh9pGnmUF031dyBqQra2IUSwJYJqZheMIk5kB//s2zvnechBuzXY6R36uG8Y1t8gJfGbBZuxrUhjVUFnnVKSs31cJG4wnPvX26lpcv/fHyK6MeWHWrhZ0OUdOqfIdjDBslTmwuwy2drTtIRj99a0HtXeCxLWHKqYcMgKLUkP/gUIJ+uZ0LfvlHX5/8hYGHkTIyF/zK7cdaeeDMnuQB8P/KMRUKQqxJ1Cp16TZfDlf2XgbgMtj6YOpCKlIBiEZFTQOlfoc1IIQPGpS5SkZhxXBP2tSShZcSUGWaSj1n1L7OI52rTy+tZPbydwI+3te07IDDP3ioILYASjxmaBEeDDj94+yPqEhUITPWrI51tD36z/slkezW2cVakBXt7/TbsHP3mkNuFAawr+ysJcA+rBV5YJU3YpJdqIJwSgW8hzTj006Nn/2uasWK+j0FdU860QGVe89pbvKOeG44K7toB0gQDwcuAMJwqyXd2V3OT2dubJ5j0Fg0WwXpY3/5Ytxw/EZYdj7iTjl1N1L5ehr0XOrsjP8hk2zpaa5ErfjyHjyA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(41300700001)(356005)(81166007)(7416002)(82740400003)(5660300002)(7406005)(8936002)(4326008)(82310400005)(2906002)(36860700001)(83380400001)(40140700001)(478600001)(53546011)(6916009)(26005)(186003)(8676002)(40460700003)(16526019)(40480700001)(70206006)(316002)(70586007)(54906003)(1076003)(2616005)(6666004)(336012)(426003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 01:18:09.2401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7929dea4-72ea-402a-6ef4-08dafda8dac7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 7:53 UTC, Krzysztof Kozlowski wrote:
>On 19/01/2023 04:51, Brad Larson wrote:
>> Document the cadence qspi controller compatible for AMD Pensando
>> Elba SoC boards.  The Elba qspi fifo size is 1024.
>> 
...
>> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> index 4707294d8f59..a6556854234f 100644
>> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>> @@ -20,11 +20,23 @@ allOf:
>>        required:
>>          - power-domains
>>  
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - amd,pensando-elba-qspi
>> +    then:
>> +      properties:
>> +        cdns,fifo-depth:
>> +          enum: [ 128, 256, 1024 ]
>> +          default: 1024
>
>This won't work either... did you test it? Is 1024 really allowed?

Removing enum/default from the cdns,fifo-depth property definition
and using if/then/else in the allOf block fixed the problem.

Yes the Cadence IP 1024 fifo-size is supported and is in production.
The below passes the dtbs_check/dt_binding_check and leaves all
other implemenations with max 256 fifo-depth.

Do you want to move the allOf block to the bottom as was requested
for cdns,sdhci.yaml?  This is the updated diff:

--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -20,11 +20,28 @@ allOf:
       required:
         - power-domains
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amd,pensando-elba-qspi
+    then:
+      properties:
+        cdns,fifo-depth:
+          enum: [ 128, 256, 1024 ]
+          default: 1024
+    else:
+      properties:
+        cdns,fifo-depth:
+          enum: [ 128, 256 ]
+          default: 128
+
 properties:
   compatible:
     oneOf:
       - items:
           - enum:
+              - amd,pensando-elba-qspi
               - ti,k2g-qspi
               - ti,am654-ospi
               - intel,lgm-qspi
@@ -48,8 +65,6 @@ properties:
     description:
       Size of the data FIFO in words.
     $ref: "/schemas/types.yaml#/definitions/uint32"
-    enum: [ 128, 256 ]
-    default: 128
 
   cdns,fifo-width:
     $ref: /schemas/types.yaml#/definitions/uint32

Regards,
Brad
