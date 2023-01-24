Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A17367A4F5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjAXV0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjAXV03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:26:29 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214694EC3;
        Tue, 24 Jan 2023 13:26:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/SE5sFDdLcyINxL91Eke51SH4VqFUW/cVSoNtjf1LSVZUuBbWweKSVUrOELU1+h1NX9Mb3w9k4ysYkY/VDUeGrQ6QrliJbqunyxgAel823gNbzh+9QKn7h9WdGNXJo3wN738BAzRRULytU7pNsAn6RNxJDjmiXGwUzwgSn3DjkmJ+gktCAVdlo9YiV2l9J3pUxmIkTf5UVenL7L0t0bXQC37wVMFIA85jFJrjP6wBvNcRiAC98AG0GQcb1qJIGb2cqs7syg9ncjIUb5gyvUrn3b5evBc7CxDUyXA7Ms6txGsrZoFxf/DHBh8K4TBQ1eUf+tod+1+LB2dQgIyUB5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nu7TEEp2YgTTfXKzNlYc0kVKUWFN/1oNJmYvKektMU=;
 b=G6Ti93iMIJpWZFv+6/15htBjlc/5PsZlhqPMOHPtazu0zA4ywboQlRvDNEe7JdnRxzbh3imF6jGT4vG3aoIWUYxMeJM+Of2tCrze2Li0xg1UQprECFkZGDOtPITy+OhXfxraDg4Nn+LrVRevTdOuYolG5PEG202dVAmhGw41L3J7zUHo40KaWc+NwIqaOoONb4sU2Y1k562iUMkEsXsa1i9EPC30q8HuZuh9l2OGIAOrFxDNc0XN+yh334tdU8vA+/OXCg6vJvTUIypVuocPvOsNhpsKr5l0+FiQzh99lmLjYEq3lgqYAuHS6Ce7vDSdLCx1r5aQLJINFSUE61r3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nu7TEEp2YgTTfXKzNlYc0kVKUWFN/1oNJmYvKektMU=;
 b=Z+IhJtU08NxYmwGLCZlc16vIj08on0ziJM9jWUcnFPd6Xyca3yFQHfBCEL/EKmAm+PR6Eo5yddYahHCOSaU2gsvlJp8lITfAdovJndQEnBmmBhYL1s/3lWDVy4VpLGq4kZqo6GN3pzOgV82rwv4wHirlJDaAWuJWBnddcR3LsU0=
Received: from DM6PR06CA0079.namprd06.prod.outlook.com (2603:10b6:5:336::12)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 21:26:25 +0000
Received: from DS1PEPF0000E648.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::5b) by DM6PR06CA0079.outlook.office365.com
 (2603:10b6:5:336::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 21:26:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E648.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.10 via Frontend Transport; Tue, 24 Jan 2023 21:26:25 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 24 Jan 2023 15:26:21 -0600
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
Subject: Re: [PATCH v9 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC SPI Controller bindings
Date:   Tue, 24 Jan 2023 13:26:15 -0800
Message-ID: <20230124212615.26080-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <84233b60-2468-4be9-7aa7-bdd296fd96e8@linaro.org>
References: <84233b60-2468-4be9-7aa7-bdd296fd96e8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E648:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: c3223926-b8d4-489e-ae88-08dafe51a5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P2pGK/RFqguCY7T9MaxYLFicyM0BkyAncU5lhW435WpD9ku/7Kmm9WLpFVsnA3uXfD9Q3/0e9sVu8SRcj/bwFKwGvBtWjzWnoLDe5yfNMjpcCFbJXnPWVXqSm7SrKcrkHPw69APJFpNzyqcSP7KXU5O3+vSQCjzAj+DYs77QRPIKmIek/g69WC97RLm8yKm0G7uIdGNmXOXloF0wlHjuyM95YAKaJWs79zZlD5s8XVOThpXCkBTlkfc7xNHou3KmVBFu4CObb+pssf7bTBmkhJc73SUapJagcgIPNhqVCkMO1Gh7jl+fUvSm8tYaoTfPGueRjqupoHhBqq1VOZwUbmzIdQRHXsvHWztnAozGkcf/LYjZ/tvmL69ZmQr7fuKHbChRSqqK5sfz2niat5vbbNUqnD2th1U5XOeFf8zlTm6wLZDsN+ZC6FpoWCTwRQpXA3UYkfEtgsbaurIQ0O8ELaDMM0VhpMU6iIe7M7xJ3eTEsvpHzQLENtdvhBKfJZE2nMjoROqYJvtU2iYZVcD8rOxARMf939JcK7gtb+Wj7X6+g2rEkTgdLvHD8W6j/5OtOYot6WYgcuCve0CqDz6uu70jG6RKo4wr1Zo2qScbpvNRJ4hgXKnNlHQfSaz2OmuyP8tdWwggUCN1Z9lrNalmCjOBMPMssKiq2ycZDG0v3gmmkq2y4+aTEXUtKJO7QHd5VX7pvZHK1sZTQaVXPaTeyem9MnWm8OxwhkUPp+ABxpwXl9kFHXU9HmJTNylnqdBPQLZJRmeUjIc/4inNTE8hvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199018)(40470700004)(36840700001)(46966006)(82310400005)(82740400003)(356005)(81166007)(16526019)(54906003)(2616005)(40480700001)(6666004)(5660300002)(186003)(53546011)(26005)(966005)(1076003)(478600001)(2906002)(336012)(36756003)(8936002)(36860700001)(7416002)(7406005)(47076005)(426003)(316002)(70206006)(6916009)(41300700001)(70586007)(83380400001)(4326008)(40460700003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 21:26:25.5057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3223926-b8d4-489e-ae88-08dafe51a5eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E648.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 7:55 UTC, Krzysztof Kozlowski wrote:
>On 24/01/2023 02:57, Brad Larson wrote:
>> On 19/01/2023 7:55 UTC, Krzysztof Kozlowski wrote:
>>> On 19/01/2023 04:51, Brad Larson wrote:
>>>> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
>>>>
>> ...
>>>>  .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   | 14 ++++++++++++++
>>>>  1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>>> index d33b72fabc5d..96b072835de0 100644
>>>> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>>> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>>>> @@ -37,6 +37,18 @@ allOf:
>>>>      else:
>>>>        required:
>>>>          - interrupts
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            const: amd,pensando-elba-spi
>>>> +    then:
>>>> +      properties:
>>>> +        amd,pensando-elba-syscon:
>>>> +          $ref: /schemas/types.yaml#/definitions/phandle-array
>>>> +          description: AMD Pensando Elba SoC system controller
>>>
>>> And nothing here - neither in commit msg nor here - explains why do you
>>> need it and what is it for.
>> 
>> Adding property amd,pensando-elba-syscon was a result of this thread:
>> https://lore.kernel.org/lkml/20220621101159.stvan53rvr6qugna@mobilestation/
>> 
>
> But it is not in the code. The code should tell what the property does,
> what is its purpose, how it is used etc. Your property description
> basically copies the name without giving any new information.

Yes, I looked past the description, thanks.  See below the updated description
and added amd,pensando-elba-syscon definition to top level properties.  The
property is added to the end as I see partial alphabetical ordering.

--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -37,6 +37,17 @@ allOf:
     else:
       required:
         - interrupts
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amd,pensando-elba-spi
+    then:
+      required:
+        - amd,pensando-elba-syscon
+    else:
+      properties:
+        amd,pensando-elba-syscon: false
 
 properties:
   compatible:
@@ -63,6 +74,8 @@ properties:
         const: intel,keembay-ssi
       - description: Intel Thunder Bay SPI Controller
         const: intel,thunderbay-ssi
+      - description: AMD Pensando Elba SoC SPI Controller
+        const: amd,pensando-elba-spi
       - description: Baikal-T1 SPI Controller
         const: baikal,bt1-ssi
       - description: Baikal-T1 System Boot SPI Controller
@@ -136,6 +149,12 @@ properties:
       of the designware controller, and the upper limit is also subject to
       controller configuration.
 
+  amd,pensando-elba-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      Block address to control four spi chip-selects.  The Elba SoC
+      does not use ssi.
+
 patternProperties:
   "^.*@[0-9a-f]+$":
     type: object

Regards,
Brad
