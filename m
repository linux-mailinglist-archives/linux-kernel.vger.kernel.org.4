Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A655B96FA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiIOJF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiIOJFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:05:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6870196776;
        Thu, 15 Sep 2022 02:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuFXINXgjdM+8Yga1B73lGZHueP2RDXbFMOSdCTL9NXslcYpxFpgRuMwBkl6KccDEz4g4bJ4CsJnt8vd9bvIWWwxkoNSftmB5AL8LGUaeMt0XEEJcJKChUVmzkT2EphqublHE0wMP+9zGxSNaZIyYdtJRJFEgd9o/cOK7aPWeVYYug8CbhyrsWMJnpQMYuf7oUhJHS9UU3o4rfhINLzfE6gV78sC+rq+0hkJY9uvg8GG+Fv9vakAzrNqg5T/GiUd7lCotlDSM/qIYsCKogUtguBZqb6cOUCypmB0Cysn1EMdS7RaSswdiGKrRQYO/AQCwkep3A1dR2o4cHyvzYQvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpfc6zDeMUZwimXWBe9z3Di+6qkx9SsO1nI3iFRpNy8=;
 b=icdLOK6LKCw7q4VAwlkcpiQXTFjcuW9+WxkoYnsrRHZaCxVWh1iBqe+QGUXncGdeCnJ5ugmMVzkYxZAqZWUELnT7o1IlwTjtcjvj4OxeQuzpuCqkhbsDAChv9gF2qNnR/sfgU1qfqs9qywtNkRcxjwhkfpUPlNe0vvivV1jqw0/RRds8ChoR/H1EvWKZRy/FwSZjiWyfKWlbMjdWLYVHaDGMtiaDeUxPEzabpNOHouZButZj+k/GokdEhtJDmlCCsf40OMqvMDSiJOMZJ8MbDcEt/0f6Lggq8KcWZuRIsMKYoHedIP+tqNyj7kU+fgHqaHO9wMIjTkd5YpcQ+LjTfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpfc6zDeMUZwimXWBe9z3Di+6qkx9SsO1nI3iFRpNy8=;
 b=sxNU19Fi0/QwIEbcXZcSj8eWlzIQU/NJpFyBKuZat5G2dRIHAd+HEByJwEdWrZgJSjKML2/p+CV94T4Yg5qOdODhNgv0pABTFO7QiAstwJhPSeUwJKX75PVi1nhcanD2oDSJJhDVL9RNlvAo8bS0393GhyRvOvbmKUFcUf9V4EE=
Received: from BN7PR02CA0017.namprd02.prod.outlook.com (2603:10b6:408:20::30)
 by DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 09:05:42 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::56) by BN7PR02CA0017.outlook.office365.com
 (2603:10b6:408:20::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 09:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 09:05:41 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 15 Sep
 2022 04:05:16 -0500
Message-ID: <46b9bb31-efb5-1e1f-9d01-3841661293dc@amd.com>
Date:   Thu, 15 Sep 2022 11:04:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: usb: dwc3: Add interrupt-names to include
 hibernation interrupt
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Mehta, Piyush" <piyush.mehta@amd.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        Manish Narani <manish.narani@xilinx.com>
References: <20220912085730.390555-1-piyush.mehta@amd.com>
 <4cc7a6d2-64ef-c176-21ad-4c3e66f664f7@linaro.org>
 <MN2PR12MB43330B57F5CFBEC35105665188469@MN2PR12MB4333.namprd12.prod.outlook.com>
 <05ce5c7c-c7e2-cac1-341a-5461804f96ea@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <05ce5c7c-c7e2-cac1-341a-5461804f96ea@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT019:EE_|DM6PR12MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: 585fc26a-ade8-4fc2-7e94-08da96f97753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7yuvpj7xBvGoRuNWrLTBjOM3xBJ4EK73hiOeNMqVA9FKJUIqezgELeBcNPQaOvy2rPD+4EGMfmKnQaWqcaxIrpPmp2CoKRCJzLKtkHWGxc32KjAvwoCIKCFbtBLcsDxnrC/DLx+56oolgeATthMkvArRYOKyHx+ostMLIlTwsSwrpvAj9O/pd4mSqyRU2XBYIF6bhmOAYCy7ceJ3ENXu2DdRwmbmtvmRXc1rSe7SV+tj/4RqRBeBhT9WolgXttl7h/IEDfRkXMqgF8VxHGMJN1NCF/z19zjAkzTdn+XUasMFu7Li7inccSqAjFj+7WBDILjG0tS2aCXlpe05l1yL5h1Zo9sscw9vGnl6Xx7HA0q9pev3gyD0b+y/rpXD3qnNbbpybBbd/vOEUxy9KWeE9JVaJlYn4Ga4vWKJEUcmNLuTgSNbfs5XX7Py4GhFAh8s3Yufk4/sZqrHdOjeBdRW9e+mg2pPj2stowoib9t2kKSGlhFkR7Pcp2CDdmk1rGRlJAyu9t/6alB1WD7WL8oZoGryoD+ZOF7RDS3lkj4FZpLaruCIACoVWkDuchzm4vfnkq6nwTVTq3HUR+eppFig5JcJYTiZO6+RSzaf+RWKxGp3VpYWb2pXMznFRiBsF9+wen7vix/H59DVa5WEA5pSWPaHswGdLBi0ZzXr1ttdF4nakM1HgrYY7pXzbyROmLZE6OjvtNKgLTK637IHz+0l+d8EDacM1FH1yUB7U2bCIu7e2ipPBvtNY9Tz0GDtiMkf04JnR08cyTUYpZi6ny4PEmXTWuT1265mMTPihfaZsX6W8EEo+gWUQtR+mTJyo8qBac3dvE4zdLPanhWBJG0Ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(46966006)(36840700001)(40470700004)(356005)(4326008)(16526019)(2616005)(81166007)(31686004)(82310400005)(44832011)(82740400003)(186003)(336012)(478600001)(53546011)(40480700001)(40460700003)(8676002)(6666004)(54906003)(83380400001)(8936002)(70206006)(26005)(426003)(70586007)(16576012)(5660300002)(110136005)(316002)(107886003)(47076005)(36756003)(41300700001)(2906002)(31696002)(36860700001)(86362001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 09:05:41.8080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 585fc26a-ade8-4fc2-7e94-08da96f97753
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/22 10:44, Krzysztof Kozlowski wrote:
> On 14/09/2022 14:15, Mehta, Piyush wrote:
>>   
>>> Where is the user (DTS) and implementation of this change? If this is specific
>>> to Xilinx, why you do not have device specific compatible?
>> [Piyush]:
>> We have dedicated irq line for hibernation feature,  "hiber" irq line triggers hibernation interrupt.
>> DWC3 core supports the hibernation feature, we have a dedicated code which is yet to be upstreamed.
>> As the hibernation feature provided by dwc3-core, so this will be supported by other SOC/vendors.
> 
> But is hiber irq line present in other vendors? What confuses me is
> adding not only "hiber" irq but also otg in completely new enum.

I will let Piyush to comment hiber IRQ. But I expect we don't have visibility 
what others are doing but this is line is not Xilinx invention that's why I 
expect IP from Synopsys have it by default but it is up to soc vendor if 
hibernation feature is enabled or not.

otg is already listed in
Documentation/devicetree/bindings/usb/snps,dwc3.yaml

It is only about order.
Driver is already using
platform_get_irq_byname..() functions

I think any combination should be fine. Do we need to record used order or there 
is way in yaml to support any combination with dwc_usb3, host, peripheral, otg 
should be working (ignoring that hiber which should be likely there too).

Thanks,
Michal
