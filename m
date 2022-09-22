Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A075E6138
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiIVLfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiIVLfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:35:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0E51AF12;
        Thu, 22 Sep 2022 04:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzdBXHBdTs4tYB1qyeCprTxiCvDBe/gNSE4HxVJVJaQNe9js1XxbiqE5IHhmf+Bv8yjZ7mT7BwdTLcnkVooY1Fr8FS2YXelMoF4tQsieGZEo/wAlb8etH+uEHR7DFa2f0PMBJ9mg3P0t5c1slUBL5hzZHGWgje79eA0KJbpb1yDdvs+crm+RfDFZ+ashTY3cuGcfsG8oLV3nDG+qkkUS58rpOhSvhpykGTsejcnJrk29JJv9LtcyoEEpm/r/Ti2OLWgBCcAIFSLI469Ms/lT/6LKvxPROBYojQ7EdPSUxIvGpsw2yHvqev0fz+0lp/OxwniFfOv/IgD+rjXNc+CeJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TECYhTLXSKstPhj0hTpyYFsZBXdIn6sVdyTkKm+0jY0=;
 b=LVZggfnxmNsbsijlewGZWcDAPg6GnTqppQAd3fLePcL0njAyPwdLYlT+ZxgakWsVkpb0h9ogXNIWW9Ar9I0YC+wTBQsxrht3KTKnNdB3uhMkyKWGU2fD+LE+fX06rBLfS3C3O0kGt1Yfq8I89e4p3KYQBCHb07vF59Y5JPlmOZXV3mG1YxJsvt3cMpq2teJGMRpRjED4Uwxz+GG6RM3wpdNJ6ViWyoWN5FnFhlSg+OiDyqimUGOH9LFo8kokFzwS9WoiHQafpviMuPpZz/G6OPs/gcJbVmj3V4CVatk7ro3NRbXSI2SMpkKTt00jITGUweLjBbYVMLS6yV/r5bAHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TECYhTLXSKstPhj0hTpyYFsZBXdIn6sVdyTkKm+0jY0=;
 b=H1f8DFiPMX2Sb///urSORzudKnWYTWmYCAnl1p+LFQKt5r5cIztlwCC89erXr2+4kjVGkUmwl0g0OvcvtxyDf7P6WI9N1a0GnWl2h1xsi4PlGtH2aTM6LcYVRAVPnFrT3Vo9LJMmcJ1ssZeVnBKBBOda7xkJLCE3x4QHbhJoe5s=
Received: from BN0PR04CA0092.namprd04.prod.outlook.com (2603:10b6:408:ec::7)
 by DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 11:34:54 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::d7) by BN0PR04CA0092.outlook.office365.com
 (2603:10b6:408:ec::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19 via Frontend
 Transport; Thu, 22 Sep 2022 11:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 11:34:53 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 22 Sep
 2022 06:34:50 -0500
Message-ID: <1824afba-c249-f5d1-e504-d71bf7d79979@amd.com>
Date:   Thu, 22 Sep 2022 13:34:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
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
 <46b9bb31-efb5-1e1f-9d01-3841661293dc@amd.com>
 <00368da8-bf24-da5a-15da-dbc1a6a716e8@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <00368da8-bf24-da5a-15da-dbc1a6a716e8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT037:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b44aa2-e5d9-463f-e2ec-08da9c8e7804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xvPGOxi3VMSw0pfETJSEs+zUYlduK0ZY5K6wQ4s2h4+t/G1Hzv+7VXM/W2ihD1py86Z2YN9EQn64WcFFUofDKnfLqHP6PzGlPe2SYsiFCvBhIJjTDrIDbd+U/N76eTlg+iidhMqjH+/+L5xDbsPnvfj19aSYkgjEiJxeFpaP+t9vW913OxUAhsyuGzzfuw4f3GbsSjZK/oRle5S68k4QfkegI+uGKhmqFt+5Qszjd15sSXT7ujfMr52a2DItDjejMHw0+tv4vbyxRWPuAKXMcqqQtp8QsoE5CYZ6Gt5rMvh1rsjOsAmHBa9N7zdWDAPwleaWCP9C41z34f9lXipZ5zIQ5HG1IUfYwT0ZLwJQAwAvgpkPUjG5C/qTXEjPA0arpM024jG2+RVoOLlUUteOUeEhjKFyZXp7cTism9Y5uBYAflMBKxsmvgfCzIa5rO/zSTlP8C5grXA4BnKdXxkUnmDJL4LwFlKurD68Gm23XdA0zY/Urf1VzFZ3127pPGsonjpIpc6dTxLw37wVBv2K5IKUrRqutHYxbocMnEOlXMbKe/A+UpvS3b0LvPHEv1WUEDdSeFVOzXfLleNPtAJpCdjoQxBC18p3it/A6koCU9wa2jASejUYmQTXhvOe3P/Q4mobO3FsjLqvMnuhr6ree1DpFl/bdM5EYK0JVhlcOQUEYM7N5Avk40F+LCTVOmmMmFUdk/d74D1nrshv454gesMSXB/ujmPH2kbUzIM5TFK0faUseI/23tCzN/qSji6xq2y6OtTgzunkhzD9XJmg+oY9OtNb+EAXpWPNMe2gLK4TkLm5DTQeolxGtfOb6qXFMGg+gnxjwoWWpt5uSgFIFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(41300700001)(70586007)(70206006)(107886003)(8676002)(36756003)(86362001)(40480700001)(81166007)(4326008)(316002)(16576012)(82310400005)(356005)(53546011)(16526019)(336012)(110136005)(6666004)(54906003)(2616005)(8936002)(31696002)(186003)(426003)(47076005)(83380400001)(36860700001)(26005)(40460700003)(5660300002)(2906002)(44832011)(31686004)(82740400003)(478600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 11:34:53.8596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b44aa2-e5d9-463f-e2ec-08da9c8e7804
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/22 12:10, Krzysztof Kozlowski wrote:
> On 15/09/2022 10:04, Michal Simek wrote:
>>
>>
>> On 9/15/22 10:44, Krzysztof Kozlowski wrote:
>>> On 14/09/2022 14:15, Mehta, Piyush wrote:
>>>>    
>>>>> Where is the user (DTS) and implementation of this change? If this is specific
>>>>> to Xilinx, why you do not have device specific compatible?
>>>> [Piyush]:
>>>> We have dedicated irq line for hibernation feature,  "hiber" irq line triggers hibernation interrupt.
>>>> DWC3 core supports the hibernation feature, we have a dedicated code which is yet to be upstreamed.
>>>> As the hibernation feature provided by dwc3-core, so this will be supported by other SOC/vendors.
>>>
>>> But is hiber irq line present in other vendors? What confuses me is
>>> adding not only "hiber" irq but also otg in completely new enum.
>>
>> I will let Piyush to comment hiber IRQ. But I expect we don't have visibility
>> what others are doing but this is line is not Xilinx invention that's why I
>> expect IP from Synopsys have it by default but it is up to soc vendor if
>> hibernation feature is enabled or not.
>>
>> otg is already listed in
>> Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>
>> It is only about order.
>> Driver is already using
>> platform_get_irq_byname..() functions
> 
> Linux driver yes, but other platforms (bootloaders, operating systems)
> might be doing things differently. Therefore the order and items are
> usually strict. If they cannot be strict, it is nice to know why or it
> is nice to restrict it to some specific variant (if it is applicable).
> 
> This is why I asked whether the line is specific to Xilinx or to others.
> 
>>
>> I think any combination should be fine. Do we need to record used order or there
>> is way in yaml to support any combination with dwc_usb3, host, peripheral, otg
>> should be working (ignoring that hiber which should be likely there too).
> 
> What confuses me here more, is having otg. I understand that dwc_usb3 is
> the single interrupt for all the modes, so my naive approach would be:
> oneOf:
>   - dwc_usb3
>   - enum [dwc_usb3, hiber]
>   - enum [host, peripheral, otg]
>   - enum [host, peripheral, otg, hiber]
> 
> However here Piyush adds not only hiber but also otg...

I was looking at code and I think we should be able to use this order
- enum [host, peripheral, otg, hiber]
which should ensure compatibility in other SW projects.

We can completely ignore dwc_usb3. It means above dwc_usb3, hiber shouldn't be 
also listed to make sure that the second entry is all the time irq for peripheral.

Thanks,
Michal

