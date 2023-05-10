Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E40C6FD7EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbjEJHM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjEJHMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:12:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185FA3C2F;
        Wed, 10 May 2023 00:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUHUsBQXiuLV7GiwNsGDivyI1YY8w42gw5jSUasMyq4v9OOGaCvEA4wuL8WFBWQVz15it40P0gnzLfNXdfNQRQhUrugDbJb4AGWR+RVgzwdzTpgSev0XNeRzElUd+xNiLhWU1IRdg2W3fJY2VbqFS5xnbNpQJlQBg0Vovs9h3R6B5zz6jKKy5QXVqkdKjixWB3m46cfc6YpyViOhikwphWoOl6hWeOYYf5nI4FQwIdpFTtzc2B6w1qQVcXWn46q0uZnjq+2UuWa780CcFAelJq8N0xn9BUXkOmhn0pKTMacQqkEr1E+NmDxN2xGNjl+ihFz3QyX61zmse5JkH6WvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCUg3mmFSdnDyt458yucRGWozCLq7kYw507D7T7GcAo=;
 b=SlgZv91ys2EOmDrH7fKtWZbPPklOR8y5kTEbXd9LXdxFqvICzIsbMvN/v9f+d0ZflZt9Ub/p8EEFSOjMCzjSR77c7GOh4q5Cfy7NpghywuURsmXdM5JXLfClGifvNux3DAKNBbxhzQGSArSWzfdMaxY0QX804EPKispdCvyed2UM+9pRJ0aTyWn+xiTXwaceZ4ffICYKHAWJTmr+vtAajqIRdsJFsyo8+D6EWD4LP6r53TBhLMMXRB5oBIFFpXTDtEss+ih40ow+qeN2+uDkIF3PqmKXLLo3Wt1igwhfuMSKFPNpG9cxbMlt9gu4aFcRPj8ocERMMKk90xhHCX7D5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCUg3mmFSdnDyt458yucRGWozCLq7kYw507D7T7GcAo=;
 b=Ut+K3G9MlKph6+WoPxnhKYSnQD+lJ/P7q5aVxIzDveQLmLsxV39Rn0pVsPLHx04EtCTyucJ/Mf0LGWCKkwIr9DJnkB3Woj/hIwUqOeu5HYDq/rW0a0qMh5mwWO+DODvl6bQe8DiNXqgK4Fcq4QIjQPDlPYdbQT4phTe1nl+7X/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4765.namprd12.prod.outlook.com (2603:10b6:805:e4::24)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 07:12:51 +0000
Received: from SN6PR12MB4765.namprd12.prod.outlook.com
 ([fe80::edcd:752d:df60:d4ae]) by SN6PR12MB4765.namprd12.prod.outlook.com
 ([fe80::edcd:752d:df60:d4ae%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 07:12:51 +0000
Message-ID: <9e94c275-4752-061c-3090-144d83769eb6@amd.com>
Date:   Wed, 10 May 2023 09:11:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1683034376.git.michal.simek@amd.com>
 <9eefc40c727928e0c7b794a3a2e061ecf6ea230c.1683034376.git.michal.simek@amd.com>
 <20230510065253.GA11711@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 01/23] arm64: zynqmp: Describe TI phy as ethernet-phy-id
In-Reply-To: <20230510065253.GA11711@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::10) To SN6PR12MB4765.namprd12.prod.outlook.com
 (2603:10b6:805:e4::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB4765:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: 559d4ac3-c4df-4397-6609-08db5125f7a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r4Mb9HCWsESsnWcXLJUi68rYE+kilBxlEuSVEe4YkQUvXdWv8C9wmuFIDRsVw+2q5gOSP2m6I+WbCMiW0ZZYAEoSH2ipOFlCHaTuKsZX5pkET1QhSHhruaadbCcJI7Aglt9AuevtAtFksjesjELy0yPk+i4/afJuGX1eAULhfuqRpjmgrg+Hupicd8Q9AKdu9tclxIAQSxCRUOVS4wRyCaDEQ3Gjne3fd2tVVCPw1XZ2Oi7MKfJVM31I+ygQm7saE0S9cgo31sH7ENWTF/2A3F2xO9JHMn9Uq7SKZYIU8e9JxYM8sBRUgrSxfK9IfkZzwaSSZBE0bZ3weGay/4wMsanMl8iyLrr5wjLugBNxgSrRBpM8NpFZS/s2zeTUqUDziJWPK6/GgWNcsTYGQebhf+vVZUNEEbeMcy24y2F+sYyK97D3H9kZ7GCy6b0xGLId0REqjRudTmCP+CxhusjPoY3LyG3woe9Ocv5qSUg6f2K/RxPZo2LfjD2bnpqkvZ2/3K4KeHaaH7tDB1EAD9ozjIHcEGogej4rCnyVhsmxx/GAsgBTUekg4e4dIMoq2H8d3dPROyF60KfMC+FEhj9ZsAUhzEQo/mC8NShBpMfILolhUbOGFZgPY0HRsfOKU2Zn1EYfvaUSwFeo/ij0uYKHCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(6506007)(6512007)(6916009)(4326008)(66556008)(66476007)(66946007)(316002)(41300700001)(6486002)(478600001)(54906003)(31686004)(26005)(8936002)(8676002)(53546011)(5660300002)(6666004)(44832011)(7416002)(31696002)(86362001)(186003)(2906002)(2616005)(83380400001)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW04L21tZGtmazJCM21CU0x0QTBxOU55WHBLbFJzNktyelR1UXJEa0x3cnNa?=
 =?utf-8?B?ZFpLMDlVRFZ2a0RmZHFRT2YwZzdya2NNaWtSN0FaQTJjYmQxKzRDU2t5dTR6?=
 =?utf-8?B?dVRiTUlnckNrbDJjeVByeU40U3BRa1pjcFVDZDROSHplZXppRDltQnFVekFW?=
 =?utf-8?B?RmV4SUFaYmhzNUdNT3FYZEVKR1BsUjZ1RDAzaVMxcXpjek5jZ0UzdTlucVZS?=
 =?utf-8?B?SzF0cnkvdUpNL2JPNDlpMTJwTkhHMUJEVG5xYmtWamVRSk1QUDF6Q29Dd05H?=
 =?utf-8?B?OUJtZGlISWp5VzBtZnhLMVdvTDl5VVBiRTFKR3cxZ2o1N2JyNVNTZURHMnVI?=
 =?utf-8?B?ZmtuNWVvTFFEOWJaK2dENWo4UUtUSmVreTQ2RkVKSEhqckM5WjNLNHB5WnVV?=
 =?utf-8?B?WElXSnFDV3d6dVArQ3RmT3E3QkY5OGcwRzJ3ZDRPaWlKNlEvemF2NE1BY0U4?=
 =?utf-8?B?NER3OEdQS0duSGg5bzYrUUFZSXNvVlpoaXZrbWVYT1hNd0wyckV6RmhmUE05?=
 =?utf-8?B?REFvbStaKy9NRnAvSUlPT1k5M09vbUNRalVMQURGS0t1Y2hYVTNha3RCblNm?=
 =?utf-8?B?ZnE2NDNUT0VmanZseWZGQlBpL2VBMVFYdXJCWHl6Yy9ISThHcDNDeERpQ1Jp?=
 =?utf-8?B?WExtZjVOVzNCUnlPNUdvUVZKYWJtRG5KQ2d1R3RUdWM2TU1NTXVscm0rUVVM?=
 =?utf-8?B?eFRlT1JsVHZxYlBaTmo0VFhsTnZUSkFyQ1J6eG5tNkFHMXNqNXZSbFFtNUpx?=
 =?utf-8?B?WitiT3E2UUJSY0grdnFkOEl1NEJ1bjJNa0g2L0Faak51WjVBa1NrNHdLUFdp?=
 =?utf-8?B?enFIdVlabWwrWUwvcVFOWlZIR04vZlExa1FRY2taYW9JNkpqQlVLOHNNeFJG?=
 =?utf-8?B?RTNWaTZzMjlLb3ZOd3pVclJCNVFYNGd1Vy9VTkM2dnJUcjlFTVc4NGRzaTU0?=
 =?utf-8?B?QVB3L3BVL2xTSzRyWDdzQXkxVWFNUmV0ZVpPZjVRS2x0YW9BdFVPQ2NESVRp?=
 =?utf-8?B?ZkJqWW9vYU9ra3g1eCs3cHVEMWQxNE0zMXl3UEhXYXBoN2ZGd1N2SW5YKzlj?=
 =?utf-8?B?LzVSY3hXQ0FuQXF2a1B0eVhvK3lEUndhRkVEK1NpS1ljTTNOOHgvYmpwaU9q?=
 =?utf-8?B?Qm0xSzFGWlE4OEJta2NpeXhsbm5CbUpDYWZlUWk0amhJcGFNOWI1ZzVtRkVO?=
 =?utf-8?B?Q2txVnQ3U3UyREJQcExmSlBDM3lVcDhiTUlxM2NOMjcvWUNOb3B1NjFRUDQ0?=
 =?utf-8?B?S09uVituc2ZrNGp6QlVSOWVYS0w2QUZVRWJyU25CRFJBalZ1UFNnQzRiNEl5?=
 =?utf-8?B?di9YYXcvbm9oZmwzdWFDbGYyQ3ViSGJ3NDBWbERaUkxrVnNMU205YTRBQXh2?=
 =?utf-8?B?WW1Rd0dPMU03cDFDN0xldDVQQkFjTnNKWjZBY3VwV1BoeUpkK1pDUHlNc3dK?=
 =?utf-8?B?a0Izc2prbGF4eS9UQnhGREI5ZFRYQkJ1SFVEUUVkaElOak9rWDM3Nnhrdy94?=
 =?utf-8?B?RHZUNDRJeHlFaFIrR0JFUnRmZ29LcFNsQmxFWG9QTzh4SWx2ODJHZDk5azFh?=
 =?utf-8?B?THFnSmwxaG9iUmwzQzdNVFE5ZkxhTHhzL29lNmpvQ1ZYZ1ViVVJLKzQvV2ZF?=
 =?utf-8?B?ait5Y0hBK0RRYWVpT202bUJOV3JOTEhiOTA0L09od205ZCtXSitNSlBEZ2p1?=
 =?utf-8?B?M1ZVa3ZtVFBpMzVodEZTci9EZHVXVjdxQjZoU0NrWlFrZnpQdFZ2OEhNTVM3?=
 =?utf-8?B?UUU2Rk9KajdOMkw0ZWswTG1BWFpFSnZndnczSUowSXpPb0NTL0NuUlpXUkNT?=
 =?utf-8?B?NVJMSWVXcllIUCttNnNrYkxjWmtXVGFWSGZOMnhaV0JlZVd6aFkvK29BbU1y?=
 =?utf-8?B?TWxKTjczU3QydExXdnA0MWQ2UjFoamhBTWhtZUwvSGlVa2V2eDBxUThiSUlk?=
 =?utf-8?B?bzd3YUpDREpMbTVBK0dJL2w0OEVvSm01ZkpaanlWdXkvbXZNNk9zZ280Sjg5?=
 =?utf-8?B?bHh3MEdIRVZSTjVhVmd6dEhBbDkrd0hGLzJFWGtIYlFxemJNN0lzdnNPTTZv?=
 =?utf-8?B?Q2htNXRRK2htUzhlKzVqdFMwWHpSV0ExcnJYbVdKWng1Z29CZmF1RjFMTkJB?=
 =?utf-8?Q?XU0lGx33CgT5qGejDm+zQmRN5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559d4ac3-c4df-4397-6609-08db5125f7a6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 07:12:51.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WA/4HakD//2CLKyKv13FlruVds8dYiDT1d2o3ch4PIwlqtqCIGcR8z6NhxW+0mk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 5/10/23 08:52, Laurent Pinchart wrote:
> Hi Michal,
> 
> Thank you for the patch.
> 
> On Tue, May 02, 2023 at 03:35:29PM +0200, Michal Simek wrote:
>> TI DP83867 is using strapping based on MIO pins. Tristate setup can influce

And typo here.

>> PHY address. That's why switch description with ethernet-phy-id compatible
>> string which enable calling reset. PHY itself setups phy address after
>> power up or reset.
> 
> I'm sorry but I don't understand this :-(

What exactly is not clear? Phy has some pins which is using for strapping for 
phy address after phy reset or power on. Pretty much it is resistor array which 
based on datasheet is decoded to certain phy address.
And because some phy pins are also used as data pin for RGMII they are connected 
via MIO pins on a silicon. That's why IO block output setting really matter here 
because it changes resistor array and it moves phy address.
That's why there is a need to do proper IO pin setup and after it call phy reset 
to get it to address which was decided by PCB designer.

> 
>> Phy reset is done via gpio.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> Checkpatch is reporting issue
>> warning: DT compatible string "ethernet-phy-id2000.a231" appears un-documented
>> but it should be fully aligned with
>> Documentation/devicetree/bindings/net/ethernet-phy.yaml
>> ---
>>   .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 23 +++++++++++------
>>   .../boot/dts/xilinx/zynqmp-zcu102-revB.dts    | 25 +++++++++++--------
>>   .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 22 ++++++++++------
>>   .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 22 ++++++++++------
>>   .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 22 ++++++++++------
>>   .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 22 ++++++++++------
>>   6 files changed, 90 insertions(+), 46 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>> index 13c43324f1d2..c193579400cf 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>> @@ -2,7 +2,8 @@
>>   /*
>>    * dts file for Xilinx ZynqMP ZCU102 RevA
>>    *
>> - * (C) Copyright 2015 - 2021, Xilinx, Inc.
>> + * (C) Copyright 2015 - 2022, Xilinx, Inc.
>> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
>>    *
>>    * Michal Simek <michal.simek@xilinx.com>
>>    */
>> @@ -200,13 +201,19 @@ &gem3 {
>>   	phy-mode = "rgmii-id";
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&pinctrl_gem3_default>;
>> -	phy0: ethernet-phy@21 {
>> -		reg = <21>;
>> -		ti,rx-internal-delay = <0x8>;
>> -		ti,tx-internal-delay = <0xa>;
>> -		ti,fifo-depth = <0x1>;
>> -		ti,dp83867-rxctrl-strap-quirk;
>> -		/* reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>; */
>> +	mdio: mdio {
> 
> The "mdio" label isn't needed. Same below.

I am doing it by purpose to be able to reference all nodes and add/remove 
property in an easy way. There shouldn't be any conflict with dt spec to have 
labels even they are not used in current DT.

Thanks,
Michal
