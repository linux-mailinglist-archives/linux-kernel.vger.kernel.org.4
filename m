Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A3F6D577B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 06:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjDDEYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 00:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjDDEYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 00:24:32 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49EB1BE2;
        Mon,  3 Apr 2023 21:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9RHTmL5bD4iJOgQ7hrD3EKw7QUGb4xlr5d4hvX1wqMj3AJrJdZ2vEA3mIm3ZyWuauZp6M98QvHgTZX+Y63MNpD7uak2oK55jJpSrht5lrquoqPidVOIaDaESeiiGrK3OM/djqxn6yvxMaAvHxf9r7I90dI+0Hw/sQySpnyvKyq+fXFYOHbuPWd173dLvfBQJEnskGo6UzFJcaVhOVDZ+oMFdFhDXjH8pWkyHWsVGG1E+K2VJnxUHKhcOToi7Kq9Z27XW6HG4KRC406pqV4e4ZPjWAc1A4vujGrq0Nh2/4YzfELLjxXaQvU4/bGxoIcCmN8suOJHMVAPpEfeVK3Maw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aob/5Ipz2jhKjubDxDdI9abGRhJTvx/aQ3IL9obuOSY=;
 b=ax2MnS8FMAqo415fgh0VovBBw7FLQ8+DFCS/dHO7O6UJ/lbnJQ2n+vyZ6ut0k5KQ0zIJpntvBKeE4lCYNMfjhlSA+HapDj4LbZtdUafTS7edLJKH1fZJyU9H+FlE8121CFkko1lxADFL0kCpNf5g9PNUKiVy7qYYTcH4FHosahtQdOs1Xl/S034GFgzh7I9fvXEeq98bKjsyTJmdKhamnNkUX4M5ZnubMX+2uM8CSYRnPLmmspqLRooYTp5jPCt63uxblEhMLhUi1flzyRhkmhkGctP58TcDO2TE2V50iKy4MQNmdFkLdQD0xTnxax33kWO6UFvBkIMH81uAmTkvSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aob/5Ipz2jhKjubDxDdI9abGRhJTvx/aQ3IL9obuOSY=;
 b=tHUgk3YR6f3C0JLNAj72brYUfenZ0H9blfr/hxDERia/qsNQ77Fo4dyKt3xGeEQR3Dphq/uQyxhrSAzJZiTLOs7V+d6fJZp1YfrNgAWhAzbAxHHfu+y1O1cM+5LQXMeIS436+jguWyBD9EbWiJKmyE+4DOWSRJkLizygUof5qMlQXbO8TjakQPIWRkYOegxA3dcoCyEha4wkUQUWOJnFfJgByPY5mUKSG6hXa6+0d1ufXQenfYsZw/s86A+niI5Pt1Erb/EM/iVk32ni1CNkdYmzP0Ww4L1e8c+dl9tnqXd+br0dGqruOzk4F8bS+zdYRhlPCOOyikDJhrIiDzFXFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Tue, 4 Apr
 2023 04:24:28 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288%4]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 04:24:28 +0000
Message-ID: <df00404e-96a8-bf33-cbc7-25dbb09c89c7@nvidia.com>
Date:   Mon, 3 Apr 2023 21:24:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH V4 04/10] dt-bindings: timestamp: Add
 nvidia,gpio-controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
References: <20230323012929.10815-1-dipenp@nvidia.com>
 <20230323012929.10815-5-dipenp@nvidia.com>
 <20230324171329.GA2062332-robh@kernel.org>
 <7f2dc5cf-78b5-81c6-0012-26b1adce1c86@nvidia.com>
 <19b71fef-614a-d678-2e73-95db8f226e61@linaro.org>
Content-Language: en-US
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <19b71fef-614a-d678-2e73-95db8f226e61@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:74::31) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: c837e192-2c59-4934-374b-08db34c47abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZTuoi1nZ9d2B6OJH6FZ/m2/Rftyo+hvBDLVltmpDH+SlYVJLJJFt0zAbS2J8mxn9SlApaywzrtAyk8Q1xnQQyxVLnZI25X9sQfmz2XPOuyfmC2JXLaM3IouGi7kgopHPEDl3KLAfDRcnsVdnbAbh7F6ywrbPDCAoHkhwSivaNL9F6jSpAJJ296lcpTolt+WRYCFWgtcAURaO8gCszWcFO1QTpVvyifY4cyfIo6ypdu7phJupNdl3iCIwIJnYd6IBDlYllRJUO3XYT3OovkLSuO9ArIgbSsJi02Lx4j/R96Y0IX/Or1EkbeDA+mdJTPX5ndX/q+8pX+CUBXbaAsT2D6uXwwXkiDq/dxxcYwv8qs4fYUoHtayElqHbHJx/l0dLK/ecJYM2ZifxpYo6XaPdwm3EVj2lSk4d3TNkHNsUWt9JD6ydWi4TPL2fllnWKmUTDtwdJzGgYPg/Vct23hWM9WArA04LSxT2WyNzOEsHklpZr87w9lph4yZDQOxn/IhshUPZfIrnxW7HXX11SqCW8uGUlqtfxUPjRaQUuarRvqONa/IF8f1dGZpgbcNnyy/GpBzg0vYnKyyU3xJShMqzrfebUtVYau4AyWwVOMj4j1QciZf9TPoIcaEyEGFBfw59mmpt7rKB8861M62U6mRFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(66476007)(8676002)(6666004)(36756003)(5660300002)(4326008)(2616005)(6506007)(86362001)(26005)(31696002)(186003)(83380400001)(478600001)(38100700002)(31686004)(66556008)(6512007)(41300700001)(7416002)(6486002)(8936002)(316002)(53546011)(66946007)(2906002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1I3QXBWb05FdUNPTy9vYXhyYWJiWTZVdnJ5TjdXMFUweFR5RVBRTWhzS2VL?=
 =?utf-8?B?WVRoL2VUL1N4Y09iYzNDZlBqVDZaMWFsV0ZmRUx6VUQ2UTEvc29uQis1NEg0?=
 =?utf-8?B?ZEEwU3h2ZDlKZkJnYlJ3ei9ZTVdQZEtMdmJudUQ2eE5LVXdVQVpNTC9aajc5?=
 =?utf-8?B?L1ZQa1lFbFhIZGpxYWxJSXV4VjRwb1V6VGxGWjBncmJsQVdlNVo4cDFkWXRY?=
 =?utf-8?B?REFwM1pGTkd3U1FZS3Z6bDRqczNrZVFraFNqTE5wTVEwSTkwaVVIM2RabnNC?=
 =?utf-8?B?SklYdTZBamtWbE50Qlp0Q1VRaHduVVBLVllwaFI2RUd2VmIvVE5XeWpZdXRU?=
 =?utf-8?B?eFY0RFNTU2JwZ0xWWFpkQzh3R1FHTnNiNkNJaUdMbU5sT3NUbkV2TFNCYlNC?=
 =?utf-8?B?cXVvM0xrY0ZnRXprR1VoNmpJeVVKQnFtOU05cVNYblJTZ0RvaFlZVHU3d1Aw?=
 =?utf-8?B?elNFbS92dUpuL0ptNnE3Z1diRkVDQkZtNDFpN1g4bXBLZnVkRWExSkFoSGlK?=
 =?utf-8?B?SWk1c1IrOXdEaVdheXBFN3dGQkEyWkZoOTM3czNTbTcwaUZJNFlCY0lvOEYr?=
 =?utf-8?B?NXJ4NWRwSDNrdEZ5Qit3QzN0RVFHNkJhbGFCZDdzTmFhbU5DSlFHdHE1RzN4?=
 =?utf-8?B?Y1d4TUpPVG11S0lueUgzSlE2VGU0WExYMUZHbjE4RTZYRThCejNicm9wa0tJ?=
 =?utf-8?B?SGY0TGk3M3NuU3FWOXdGYmR2Z3pEZXRQSE5ZMDNTcWkwaUJDS2R3UzFlbmRY?=
 =?utf-8?B?Wng3dG51UVU5T1hZNVp2Smp2N2RZc0w0SDRlck8yZDM1WHliWDl1aVFCQUFF?=
 =?utf-8?B?aHFzNVA2aVJJbW5DZWVpUlZkeFdYdDdtZUwvNXNYTkxIaXREZlJMNnFKQnVW?=
 =?utf-8?B?UlRqZ01yaHgrQng3VXVYVjd4bFA5cytpaklDSEFUM1lNS2I0R0tRS1g1SVdV?=
 =?utf-8?B?eWJXM29ob3VUU1VkZmljWUI5RGdRbk5oZllrZVZ5L3d6S0d1ZTNIMmxiRnhL?=
 =?utf-8?B?Vi9BeTNVcktDbDdVRy9iNU13ZTY5N2tuSStmZkRiYzFUUXVQVllRUU1odUlN?=
 =?utf-8?B?Tm5DZEFNdjRpYXV5cFBxdUdoWEZLUUhKU3RxamUyck4xaHhrVTBvdTBycFRG?=
 =?utf-8?B?SXo2eFlEZHpUQTlMQ0lhYUQ0cEIrL1QyK051dXRSWHN5NkZvRkNpbDhPdm0w?=
 =?utf-8?B?bmNHQ2NnRXgvdjlWQzh0TjZXOVE1WFFNQTYwTjVjcE5rVHc3QlRncWMwK01U?=
 =?utf-8?B?eldTaWd4MVN5cmpsZ1ZSZmlYN1BhU1BXdWxjV0lwNnp0T29QUHhkcG00RHRS?=
 =?utf-8?B?Vk1qREhuN3BKUkZsZnk5VUtFWEZXRnk2OTc0UmFEdFkyYndJTWZMQ3dLa25w?=
 =?utf-8?B?RWNabUJqVkwyc0NPN2I3dXg2dkpiV2FIUkZDRUFmRm5ITm5Pd2ZqckN3NkYy?=
 =?utf-8?B?ZGRMdG50dTNHcXlVZTIrQU9oL25GUjlxbDdnRU00dSt2eUZJb0JoSXE5dlpM?=
 =?utf-8?B?QjF1NkhZMnh6ejM5bkpmYXdSWk5WMGRsTlBYTHgySG5pbDFydjE2ZExLbXk0?=
 =?utf-8?B?dVQzWnRjY1djRXMvSUtTWW1wa29udmlwWHdocW9LV1l1MUVnK3dhd3F0b1Rs?=
 =?utf-8?B?V2FHMWsySzN6aGxZd2ptVG9XM1BjYmFlQWF3cXpnTGJleTUvTXZlR2ZjMUJT?=
 =?utf-8?B?UjBxZ29zN21pb2ZsVGxaZEN1MVV6N1F4QzYzKy8yRjNLYXE5bjhtQm1wWWZx?=
 =?utf-8?B?WUpUQTBXT3YvUzVWc25taXNIdG54VEJhMDBWQ3NVQW5TcVZWSi9MNHZOYzZC?=
 =?utf-8?B?YmNXdlRUblo2UElWWURiNXozbFZBYnY1bmorZkpjOUFtWldLdHF4T1M1YWtv?=
 =?utf-8?B?VkEzRENTRkdPQUJKczdVcGRzQzUxcVdZNTZkSGJlbUFBdjZHaTFFcnNLT3hG?=
 =?utf-8?B?emNzanMyM3dqU2R5cFNWUHBqSmVNd0NIeFdzQ0dsTStFc1pJb1lxSE1iaXRt?=
 =?utf-8?B?UkpNQTkwQWx2Y051K2hKTVVwMm9wN2d4bldxd3p1UHc3NDJ3clQrVk1LVWRi?=
 =?utf-8?B?b2JLRzNpM3I3T0g3eEQwN1Y3ZzZlcU9kQlFld3pSRVVmS24xcndtWFE4TVJa?=
 =?utf-8?Q?W0Z8jQeaY1hjuNQk7eApix207?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c837e192-2c59-4934-374b-08db34c47abe
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 04:24:28.2877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+YDxyIhtDjzU+aI5agA89KGm6KLoGJJ8bAQNPaBAmoJHiweA72waLT1fBBpziirSyxcKShkAEoS2CN9V8waqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/23 4:09 AM, Krzysztof Kozlowski wrote:
> On 24/03/2023 19:51, Dipen Patel wrote:
>> On 3/24/23 10:13 AM, Rob Herring wrote:
>>> On Wed, Mar 22, 2023 at 06:29:23PM -0700, Dipen Patel wrote:
>>>> Introducing nvidia,gpio-controller property from Tegra234 SoCs onwards.
>>>> This is done to help below case.
>>>>
>>>> Without this property code would look like:
>>>> if (of_device_is_compatible(dev->of_node, "nvidia,tegra194-gte-aon"))
>>>> 	hte_dev->c = gpiochip_find("tegra194-gpio-aon",
>>>> 				   tegra_get_gpiochip_from_name);
>>>> else if (of_device_is_compatible(dev->of_node, "nvidia,tegra234-gte-aon"))
>>>> 	hte_dev->c = gpiochip_find("tegra234-gpio-aon",
>>>> 				   tegra_get_gpiochip_from_name);
>>>> else
>>>> 	return -ENODEV;
>>>
>>> Or you just put the name in match data.
>>
>> Not sure I have understood this comment, but "name" the first argument is
>> already there to supply to callback to match data. Also, this if else is
>> needed to know which "name" to provide.
> 
> The point is that of_device_is_compatible() do not really scale and make
> code more difficult to read. Your variant-customization should in
> general entirely come from match/driver data.

Perhaps I should not have mentioned driver related details here about how
this property will help, that detail will go in driver patch. In the next
patch series I will remove this commit and just focus on what this property
is.
> 
> 
>>>
>>>>
>>>> This means for every future addition of the compatible string, if else
>>>> condition statements have to be expanded.
>>>>
>>>> With the property:
>>>> gpio_ctrl = of_parse_phandle(dev->of_node, "nvidia,gpio-controller", 0);
>>>> ....
>>>> hte_dev->c = gpiochip_find(gpio_ctrl, tegra_get_gpiochip_from_of_node);
>>>>
>>>> This simplifies the code significantly. The introdunction of this
>>>
>>> typo
>>
>> ACK...
>>>
>>>> property/binding does not break existing Tegra194 provider driver.
>>>
>>> Making a new property required is an ABI break.
>> The driver code for the Tegra194 binds by old binding and does not need
>> this new property, the relevant code is part of this patch series.
>>>
>>>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>>>> ---
>>>>  .../timestamp/nvidia,tegra194-hte.yaml        | 31 +++++++++++++++++--
>>>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>>>> index eafc33e9ae2e..841273a3d8ae 100644
>>>> --- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>>>> +++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>>>> @@ -51,6 +51,12 @@ properties:
>>>>        LIC instance has 11 slices and Tegra234 LIC has 17 slices.
>>>>      enum: [3, 11, 17]
>>>>  
>>>> +  nvidia,gpio-controller:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +    description:
>>>> +      The phandle to AON gpio controller instance. This is required to handle
>>>> +      namespace conversion between GPIO and GTE.
>>>
>>> Explain what the GPIO controller is needed for rather than how this 
>>> changes the driver.
>> Doesn't "This is required..." statement addresses why GPIO controller is needed
>> for part? Or do you want detail explanation which is already part of the commit?
> 
> Your bindings commit msg focused on driver and it is not really what it
> should be about.
ACK...
> 
> Best regards,
> Krzysztof
> 

