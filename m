Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226946C8560
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjCXSvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjCXSvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:51:49 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C59270B;
        Fri, 24 Mar 2023 11:51:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TC1n6LM1aCAMDc9WDQX1m4oiVEwuXVe5d/wq6lnaXV2hFdku/5UcGG9kHnFrRUhf5ABHqp2K3NCK353GIRpgl/Cx4SwNQ7H27/9JsQv7d290nMBmXXoTcwa9+eB6MPZbtB/x6BB1Ez+IuA4o6F5aJmYyMDLSBFg8TDgU9nSwu4kcihMzR9iG6XUAou94Qq0KRZ8OZU2Xzm1f8yIH3UN2VaNraBwhTir5NHJv5O2ZD/d8x+kBbD2T1s/yX0ItjrnkWVNo2O8HSBqo1Iz9o+SFGja802vaI6+2foDExNLYkuGnKOVIfhg21/wl4E3ciMrmZ200ARAKAiA6I8UHxymZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTRp0nIAhtx0YzW2i3jspM6rsZXVMyMRmOkQ8fO867g=;
 b=mtxnajkEn9wGgxpcPcvpG1jgUDAWy/cDER8PF1iC1JtAle2RmIlgOSAZnkyvkqKkdq/0MGUZV4tx+ZJIsHiHVzD+RWD5xt+d6yNWiXSbmOWKfXeamyiBUa8t2xyT/61c8wGKNGaYVZXZnCFh4YA86Kv3vnCPwUHMFYEGMhkAVNq+SMyfvr2gyziWtvtWWCiWxvnWCEfo1yabKIK2AoavGe+2I94ETFg6CkJW0aBd67HWMnMk2maakAfzlZlPUhZ+uBAJVco3Bz+y0iYI4xxhwHZ/FUwkY1KUfHXkjpqnqxzwWtkgiA9k1etxeUcGfc52VFUFyGWkWK7f19x0kzi8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTRp0nIAhtx0YzW2i3jspM6rsZXVMyMRmOkQ8fO867g=;
 b=FpYdwirearVN7oF9gAQsyt9Jr2NE+DvFSn5LKCnlvvjuX43NWRyG4/KpnrQ4+mdjWIz4X8awRu6Duhy3tQy6dnwe0I63XB3emSz9ifdeVVwfxh2q33bSGwthhzcER+i7f1uqYsvap7+zFKfXIZUrh/2zC/SV/OYa9ECUGjW7T3WwCgV59Exb66DwOU/61VqDcyR2RCeEyZOq+RnMV9mqr3sNMsmy6Ic6wPbhdwAPMsb6X/d84vBEeEzAgshvQq0oD8jhMaazPIMr83MzWxLCiPQhV+lZTKoCkqoeCq1s44hmVQvMj4PBRDsVRFWk5eOQj88bb1deCGWN+ECX+jJW4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 18:51:44 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a%5]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 18:51:44 +0000
Message-ID: <7f2dc5cf-78b5-81c6-0012-26b1adce1c86@nvidia.com>
Date:   Fri, 24 Mar 2023 11:51:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH V4 04/10] dt-bindings: timestamp: Add
 nvidia,gpio-controller
To:     Rob Herring <robh@kernel.org>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
References: <20230323012929.10815-1-dipenp@nvidia.com>
 <20230323012929.10815-5-dipenp@nvidia.com>
 <20230324171329.GA2062332-robh@kernel.org>
Content-Language: en-US
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20230324171329.GA2062332-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::15) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: eec32a54-2a08-4d52-661a-08db2c98d02f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SIyjqGq0z1q+sHdvUNO3lH5LvYnzgRepiuWsZhS3xEMo6xs0rZViZNSZakj5SUbiA0ttze/Dw8Z9XANs1MLgEaZIkwHIVX79NnMO9ywqnb357Tm99GRQ0xzBTSNcpGNnI+P7zMXHBrkE0ySun+ftFCNDrtMHjcgn0o3e6HYcrWTdPf7kWCQLGQEm/eISQPSCgjyk/6+JVZoAcRUQm8k8T8REAI+euGgOLFcTdO/i4naCgpF1m/EK+OHsyvCVTcapurU/lA3SSY2n46J086f2FsoM4cOSTKxW86y4wK5usEwudSHqRPBk+WnJF1wROBdCXV7bfkBXpIPmojrVOoOAVEZEQbBeHv/nvtnkP9WswbnUuzBWYf9fQnlj7Q6us24PCUmOXtuDDRFnEi+LKekAnAtr4ZjWALZn1v2OIrxBo5+DcHtNqBsk2tyEBd4Qa1FnNlUWIDkY9OHaK28egHSQUasdkjMyz7PYFaLVi5QIVMHKVDon8ROlNvLEgwpqqZGg49u6aZII3YMMM1Hb7pam/iOzwzUDA39gyCPZ7rnxpVLrsCv+5G8C7dnj3hXpXYF+xrHEoFkGBQjzlue+rw46Y1ndhuwdRvUNSTcdO3Tce78bRjUXVpnLzegXRmdOCsB4hrFH2UNE8NvuvKYOirFrCVbNqm+AVyH5lt0tYz80uz9N7H/ZFRMhPbh2MSGYEHeALm9ByMP3c+MfxM8VfYl1RJN08ndFOJBitMSjp/rveE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199021)(2906002)(2616005)(38100700002)(4326008)(6916009)(66476007)(66946007)(66556008)(7416002)(6666004)(41300700001)(316002)(5660300002)(26005)(6512007)(186003)(6486002)(53546011)(6506007)(478600001)(83380400001)(8936002)(31686004)(8676002)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1Y2dU1LKy9TTHpFcFZ3elp0cG9HcFh5K24wamc5M3FmTGhCcWRFWUxjaWJL?=
 =?utf-8?B?TkVNWURIWER4elJ1OUxnZlNvNXd5aVdSTVEydHUwVEdKdW1LK0hkV3NYQ29M?=
 =?utf-8?B?QUlXMzdMcGVoaEdyL3VualhWUjl3Q2lUcW8rekFZVGo2WVdYSG9xWXFOSWto?=
 =?utf-8?B?TzNENVFzWlIxOGJBMVpnNXJQRWZCYXNISkNVQUlQNEZTdFlsSzRaNk1wS0ll?=
 =?utf-8?B?N240L2JlUXN3bURBTDhqYStUN2tMeHdpK0taN1hHdVV5MzdlNE1Va2ZMbnN0?=
 =?utf-8?B?YUlMc201RlExNVo0c1RMWjhyZGNZeU9wSkRPTlpibDlGeHBLajNCSS9MRUpL?=
 =?utf-8?B?elVwSlFTRVBvKzdDWTliVzFqcTNYZk1iVmdjQjZPWm5xSWV6dzM4TWJCSVNE?=
 =?utf-8?B?cFVKS2Z6S1JndUtrTU1CbTdmMjhYUUZ6WC9nQzIrMWVoQk1KTFI5dHc2d2ll?=
 =?utf-8?B?SnZ5blpENmh3bi9iRCtwOFkxNW55R25RcUg2NHEvWHYzZEFWQ1loTXJBckp3?=
 =?utf-8?B?a09HNytHLzRDdWdXSGRtVFZJb2tuSjNUR3Z0dEhDdE9qVnNDNXRZZlZSZm5j?=
 =?utf-8?B?TXI5MW52Qlk3NkJhVDNudWFpRUdOTVM4WGpDa2k1dTZqa0pvQURaQXdlRmFF?=
 =?utf-8?B?dFpmejlXQ0JpditaZUs3ZFJiUWJxSVdhS3dSbFMwc1NxNDVRdkR3Nmc2RGZl?=
 =?utf-8?B?Ym1TT213MDNmQWczQTdhcGVGd0hqdTlqYzdMU3NnZXFzbEwwRENzN2pVelBx?=
 =?utf-8?B?LzgwenB2SjRtdzR2ekdBejNrZVFuUVN5TnFqdzhhOFhIcE8rWFc1K0UrTGh5?=
 =?utf-8?B?aGh3ek1BZDJVSEFzVUszQkZEVVFnQWVlMXBWNmxJUnF2dFdocFlQOXlsNm5C?=
 =?utf-8?B?NVFiWkRHMnNnbmxOZ09YaVpxM21UY3AwaDFyeHVxQ1N2c05pSTdvZ1ZjRGRW?=
 =?utf-8?B?ekV5QVNPOHVtT3JsNTRVL0Mvak5od1NhT0JVSWRVWUR1RjJuSWp6eEppT3pn?=
 =?utf-8?B?Q0ltOCtveTh5MEVhWWVIS2gweFdQVjlzZ1NrRmQ3OWNYOHZZMWhRWUVsR2hC?=
 =?utf-8?B?OERGMzNVaGc0WWxOTEROczlKcS81ZWI2cFdiVnBRZUxsQmRIUlplL3JqRUE4?=
 =?utf-8?B?WHNram1EQmhOQWpaN2xEdlRDeVNUS3d6a1djS1lJQjErQ3hSaEMvZHdkb1lq?=
 =?utf-8?B?OHVyNHo4VTVZdEs4OXhZVmUzOXRWamQwcmIrcWFzb0F4RVRaYlVGTVhvY2Jk?=
 =?utf-8?B?aTdvbnpWVXc2RnRJNUtsN2ozUVNsMEtEWFJrZFhnOFBPU3ZlUnhWeG9Qd3da?=
 =?utf-8?B?Ui9tYzBVQy9nQmVSTDR6OU04RFZ6ZitUeFcrR3dtcXcyQmpqSUtEM092TDZD?=
 =?utf-8?B?ZHhjeXhQbEtSZGlFZnhreVowaEhGU3dIN1JiYXp4UjNMc3I2c3Rla25keEJl?=
 =?utf-8?B?eGYzOTFSMHlDcWJNeE5OUzFwZXJXS29VOWhZUGVnVlVtT3c3dTgxcVZWMlhp?=
 =?utf-8?B?UmZKWks2b3lIWlZBTStkcEgxZWJXSGlUR3pMZVNteExuMGt3NVNiTjkvWDd4?=
 =?utf-8?B?cFpnOEdwTzYzbFQ1anNGL1Y4UzVGQnY4Q2VLT3FmVUI5dUhKdUVqemxrNjFM?=
 =?utf-8?B?d0diV0hTZFZ1RWJsV0swL0RpbUY4VWYra1RzajZTbS9aS3JnbUs0N2d4N0FX?=
 =?utf-8?B?TGRBbGNVY2YvbUtZU09JUmNNY1dYdllKNzk0WTVBelZ2OVRseWFWUzJEbXpu?=
 =?utf-8?B?c2Q1U3FPK2hUcEk4Y2p4WUNQRjhSNmpPemVramF1RnZQbElFZFlYWE1JQkhw?=
 =?utf-8?B?bWxJeU9MUGpLQ3Bza3pNSEwyTFVtM1o3d04zcGNST1dMQUcyNGU0WGVjRENW?=
 =?utf-8?B?L0l6OU41ZlZqaVIwQUpLS0w1YzF5c0JualpIeUtJemJxNU0waytOblZJSXBQ?=
 =?utf-8?B?Q2pnbExPODU3RmpyMnNtOXNMWmtrS1dpUEh0UVB6NkNxN3o3YkhNUGhjbllD?=
 =?utf-8?B?ekR1Z2Z1Y3Z1dUZDVlZJbWFwUlgya3dSZXk4aGRGblMwQlVueXdjL3NHczNu?=
 =?utf-8?B?MWZkWVJoVDZwT2pHMmJUSERxYzdzZGc5K0VrNVNVMGgvVHFhaFd2RzRaeitk?=
 =?utf-8?Q?5hR1sLkZjghP9nvVIBczBEGZW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec32a54-2a08-4d52-661a-08db2c98d02f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 18:51:44.6898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ep8PXmLhvIATDBoDWAFgJnhtohsxxZ+hgAcw94wLWve87zYbPQF6925gmQmzPrckwWsrDTkR9Sk0jXZjMIua5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/23 10:13 AM, Rob Herring wrote:
> On Wed, Mar 22, 2023 at 06:29:23PM -0700, Dipen Patel wrote:
>> Introducing nvidia,gpio-controller property from Tegra234 SoCs onwards.
>> This is done to help below case.
>>
>> Without this property code would look like:
>> if (of_device_is_compatible(dev->of_node, "nvidia,tegra194-gte-aon"))
>> 	hte_dev->c = gpiochip_find("tegra194-gpio-aon",
>> 				   tegra_get_gpiochip_from_name);
>> else if (of_device_is_compatible(dev->of_node, "nvidia,tegra234-gte-aon"))
>> 	hte_dev->c = gpiochip_find("tegra234-gpio-aon",
>> 				   tegra_get_gpiochip_from_name);
>> else
>> 	return -ENODEV;
> 
> Or you just put the name in match data.

Not sure I have understood this comment, but "name" the first argument is
already there to supply to callback to match data. Also, this if else is
needed to know which "name" to provide.
> 
>>
>> This means for every future addition of the compatible string, if else
>> condition statements have to be expanded.
>>
>> With the property:
>> gpio_ctrl = of_parse_phandle(dev->of_node, "nvidia,gpio-controller", 0);
>> ....
>> hte_dev->c = gpiochip_find(gpio_ctrl, tegra_get_gpiochip_from_of_node);
>>
>> This simplifies the code significantly. The introdunction of this
> 
> typo

ACK...
> 
>> property/binding does not break existing Tegra194 provider driver.
> 
> Making a new property required is an ABI break.
The driver code for the Tegra194 binds by old binding and does not need
this new property, the relevant code is part of this patch series.
> 
>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>> ---
>>  .../timestamp/nvidia,tegra194-hte.yaml        | 31 +++++++++++++++++--
>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>> index eafc33e9ae2e..841273a3d8ae 100644
>> --- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>> +++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>> @@ -51,6 +51,12 @@ properties:
>>        LIC instance has 11 slices and Tegra234 LIC has 17 slices.
>>      enum: [3, 11, 17]
>>  
>> +  nvidia,gpio-controller:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      The phandle to AON gpio controller instance. This is required to handle
>> +      namespace conversion between GPIO and GTE.
> 
> Explain what the GPIO controller is needed for rather than how this 
> changes the driver.
Doesn't "This is required..." statement addresses why GPIO controller is needed
for part? Or do you want detail explanation which is already part of the commit?
> 
>> +
>>    '#timestamp-cells':
>>      description:
>>        This represents number of line id arguments as specified by the
>> @@ -65,22 +71,43 @@ required:
>>    - interrupts
>>    - "#timestamp-cells"
>>  
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - nvidia,tegra234-gte-aon
>> +    then:
>> +      required:
>> +        - nvidia,gpio-controller
> 
>> +
>>  additionalProperties: false
>>  
>>  examples:
>>    - |
>>      tegra_hte_aon: timestamp@c1e0000 {
>>                compatible = "nvidia,tegra194-gte-aon";
>> -              reg = <0xc1e0000 0x10000>;
>> +              reg = <0x0 0xc1e0000 0x0 0x10000>;
>> +              interrupts = <0 13 0x4>;
>> +              nvidia,int-threshold = <1>;
>> +              #timestamp-cells = <1>;
>> +    };
>> +
>> +  - |
>> +    tegra234_hte_aon: timestamp@c1e0000 {
>> +              compatible = "nvidia,tegra234-gte-aon";
>> +              reg = <0x0 0xc1e0000 0x0 0x10000>;
>>                interrupts = <0 13 0x4>;
>>                nvidia,int-threshold = <1>;
>> +              nvidia,gpio-controller = <&gpio_aon>;
>>                #timestamp-cells = <1>;
>>      };
>>  
>>    - |
>>      tegra_hte_lic: timestamp@3aa0000 {
>>                compatible = "nvidia,tegra194-gte-lic";
>> -              reg = <0x3aa0000 0x10000>;
>> +              reg = <0x0 0x3aa0000 0x0 0x10000>;
>>                interrupts = <0 11 0x4>;
>>                nvidia,int-threshold = <1>;
>>                #timestamp-cells = <1>;
>> -- 
>> 2.17.1
>>

