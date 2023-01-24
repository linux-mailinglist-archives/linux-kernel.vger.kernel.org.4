Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310C4678DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjAXB5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjAXB5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:57:34 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BCC39B81;
        Mon, 23 Jan 2023 17:57:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8tcoUV+645xF5cEYb7nAvbOGcT2JfU89viNd3BdALeGCUFlil+ZkoXUesNEyJGNX6CYdud+wdEQHqWg6+R+uDJprrhGAAu52PGYlYaG6iw8aSjg9y8QawHNG3E9g96PXg1r0wnSeiu9E5UpzOiqUo8iYj6guB2hjn7o3qJtZOALom+xt5DJduNEAukFC/oLkwuTrW2zKzwvx9gt6sCvlJ7ehL542gc7ghQrEfIdlRQyOZh1By8qmlg16s4D8QaN9/PWYLv/902sMPsj1XSHFt63svYf8t7BzIcCt14HdJBSTCFqP23YirgLyIJDsuyl+/FUGztUPAyYQTAW4eexfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZuUPsSwSbPDn2TQRyJxaRAmrCdlsCNJwCU8/ar2WVQ=;
 b=dJ+NdXwL2v2kbkswbuRVBJ3xZb/IJFNyFGObQ6R3G3g2yJ5dWLz0rTzSwqfKrUzt6wq8SmqVVs21f2zMDlWiMzZfuPvXJ1Gwb66Uwt2QXmJnoZtNsFnHI3v+T4xfBLf2tmh0HQCLUIZGsr5gMt4sOFQIDtG7ePOCEakFy/rYKJzYiubcb7OYWpn4o1wYjWPA8QJiimbBZyEZqRdsaLrJenyvqH2/BgJWkpPKvORTlohLFgCFcQMr9JRmtG13Qtsu7Cbh909oo4H/PqCWhGOrpOAyxtY8Ki826pGn1W+Ufqx1z1mwUigQ4lkOimx+ePIYPgS10kN+N4uPmHhh/p0XZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZuUPsSwSbPDn2TQRyJxaRAmrCdlsCNJwCU8/ar2WVQ=;
 b=PUBVP+muvvskLRhCY53+IjrdCihQtytrrCfbV+PwdICIH4IXf9qGDyEjdCYQzKB0jMPp33ZWmeionzqD8ubvOPxbtjy7m7T1OaymbSOwJdrEvXk6EwM/QsG5sT8457IL+926wZe22SJ47XVUMh8i2KbnCxj2/yDCRnaicZQV+bQ=
Received: from DS7PR03CA0191.namprd03.prod.outlook.com (2603:10b6:5:3b6::16)
 by CH3PR12MB8235.namprd12.prod.outlook.com (2603:10b6:610:120::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 01:57:31 +0000
Received: from DS1PEPF0000E650.namprd02.prod.outlook.com
 (2603:10b6:5:3b6:cafe::87) by DS7PR03CA0191.outlook.office365.com
 (2603:10b6:5:3b6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Tue, 24 Jan 2023 01:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E650.mail.protection.outlook.com (10.167.18.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.10 via Frontend Transport; Tue, 24 Jan 2023 01:57:31 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 23 Jan 2023 19:57:27 -0600
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
Date:   Mon, 23 Jan 2023 17:57:21 -0800
Message-ID: <20230124015721.2285-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <322383a5-5c2b-a1e0-d14c-6c038085301d@linaro.org>
References: <322383a5-5c2b-a1e0-d14c-6c038085301d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E650:EE_|CH3PR12MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: c23b1320-3dea-4447-7e63-08dafdae5a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p/nYhxziZcA/By28ettXCnul5M3qbLZuw5x+1gc7YHAp3x/KKL2IAudOdPNQd1yHW8/Pt5+yeG3rY8+gBhiouQ3+58lQwkA9kwfbctxhg+sRLMhjaj7BexTewsIdlPzq32yrJpWi/eim7tyA4j/tZzxqFK79T4MNvl62AXx8keqD/nFz9yeR/abjIkP+eLRnUgcf9Xp4/MpNlRyTeYmzr/b/kSoLEIQ9Rr0FynieguSTBhTEn6BfVvMUqoyzXZT5a3a4+n5zDYjMvJ4Nn8/6WEzuIg37eyb1I+VwWwJAHywpUgd+oqkuBGbErK0EUFEuwvDQE/rP4MwQgRgn1cISTstgd3EKI/Zfs4+iRJBDhEFx26hL+o6947SuhKRE6TLorQ1UFUaV8EpDNs2ZsCAq1jZIMjShj9KRfcNLH3y9SFLE8Ni8TqCwNOZ6uokPxTbcjIhS81ShA6RZFA9thUyUJVBlyTaBgTuE2WV4ikYc80UPwCF7vTBFIGXKC6QOK6zkQoq6UgbmjmFJ0Iy1wBVAdaRxMtIX//73CyWrlcjVxAnuCqZagPy5h+ifSzoirSbDRsxRRaCEJCbnHM5lGWOyY6EyVPEhuLWL/sHYdH1ZVuLbwhDZjwMkmJT2rUHkbpFG1/uAKq1FdhPo9HubvON8Zyd0FfjZkQ4YIl7xF5VlGH/Hr95kcpAffOMakiefqQHCXUnGHc5AnQW1vPAIxsMxHo0xVb5GdEwVered0xvjY/RAa1tkRazhfZ8XxOkQyGKw3WldtVzfICizVxfj2+M+cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(81166007)(82740400003)(40460700003)(36756003)(40480700001)(356005)(82310400005)(336012)(478600001)(316002)(54906003)(966005)(6916009)(4326008)(70206006)(8676002)(426003)(47076005)(70586007)(2616005)(53546011)(1076003)(36860700001)(2906002)(26005)(6666004)(186003)(8936002)(41300700001)(7416002)(5660300002)(7406005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 01:57:31.1357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c23b1320-3dea-4447-7e63-08dafdae5a96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E650.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8235
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 7:55 UTC, Krzysztof Kozlowski wrote:
>On 19/01/2023 04:51, Brad Larson wrote:
>> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
>> 
...
>>  .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>> index d33b72fabc5d..96b072835de0 100644
>> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>> @@ -37,6 +37,18 @@ allOf:
>>      else:
>>        required:
>>          - interrupts
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: amd,pensando-elba-spi
>> +    then:
>> +      properties:
>> +        amd,pensando-elba-syscon:
>> +          $ref: /schemas/types.yaml#/definitions/phandle-array
>> +          description: AMD Pensando Elba SoC system controller
>
>And nothing here - neither in commit msg nor here - explains why do you
>need it and what is it for.

Adding property amd,pensando-elba-syscon was a result of this thread:
https://lore.kernel.org/lkml/20220621101159.stvan53rvr6qugna@mobilestation/

>Define properties in top level "properties:" and here only allow (:
>true) or disallow (: false) them.

Ok, will change this if the syscon property remains.

>> +      required:
>> +        - amd,pensando-elba-syscon
>>  
>>  properties:
>>    compatible:
>> @@ -63,6 +75,8 @@ properties:
>>          const: intel,keembay-ssi
>>        - description: Intel Thunder Bay SPI Controller
>>          const: intel,thunderbay-ssi
>> +      - description: AMD Pensando Elba SoC SPI Controller
>> +        const: amd,pensando-elba-spi
>>        - description: Baikal-T1 SPI Controller
>>          const: baikal,bt1-ssi
>>        - description: Baikal-T1 System Boot SPI Controller

Regards,
Brad

