Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F296D6A50
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbjDDRVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbjDDRVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:21:11 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DA8AF;
        Tue,  4 Apr 2023 10:21:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/vCm0f+PR0waeGB0QY9SkC30ZFAIT444DSaSVsxxjL+cowIjqMOpdbyhNWJfxGCsyA+OS4mjymWb1PUcO6QWakZllVE1464aD8nh/H+2krZmYqYiKx8ZT5Likdaf1UJZA50zaey+gMnKTzkeUMMvRaJD95HdVJCILetjh3beZqxAQ49aIG7UeGlV3K8LSv9dMK8O6NQASpCEpGjylmcGvKWYn5o/7tbRbgulugqlpF+Ko5Fr1t/sji/A5JInkK4fITyAhc5wiSL5eMMS52ruzXuCgR9o4xWPyrktDahyAXOofe/osrgB+IT8TKrLuLr3kLGtmH9weh5gNHy7elqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vb5pGZoqwfiQ6591zAB0Q3c3BH8x0Lp4DAZGH5u78UQ=;
 b=DYsLlliJuN2ixtP9Pke4SfwysxdPvdjMn1vbEyXybtVwTLCy9ipg/mmyg2kweCqs+KYvjC2oxCnhbCWJH8f59jYI+beBt3DACZg/WfdBB36YEYWO/YsiOxxDGDkBW2pn8DUafBfwg/FfRdbb3aiqQ7NlLCC5zCgdIkAA2uvogBrLGwwvtnvGcS+ScadkZKHx4I2hs1SUmMFaHQMfPOO7Li5nS0DbD+dpUwCWIqPYiM50GmA9wqLFBAs3vxnh8poodJsjvLHTUS2TfEfoMfHWWbhg6ijyqcZg9cLurE/Mb34sjRhNiaDu9uQqLWO+ESkJdaHZqaE8ZTbO5ngAdIAY7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb5pGZoqwfiQ6591zAB0Q3c3BH8x0Lp4DAZGH5u78UQ=;
 b=tArZzN9NivofleY+Ww5b59TBvxwG3caC1bAdjw2HnQr4z7HHSP8PEK2oG+BbLk1twnORJnNC2dwvYcYr/Ns5r6HPt6QYkY6oBLGCVzmuXsvYe+DrQY7Igz8zT28AISjiIDqhhX3ghakbyV2kPdlKONrLXX0W/jgWRBhR/BHHcwViZwWAIfrdfUS2E3/8oGdy5OjeidFFGaD+AU8+nX3jX2eSDIz/Y2jR8fnPVRqYxrg8MghqHAM5X0nxjG8gJLKF55GHVaz0Wj8ngwiHp43PwqABhzO0NVv4EaWFDVJKixhna5AahcUqhWuWbBj2AT0lTD89D6a77N7MtSfvd31kSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by PH7PR12MB6466.namprd12.prod.outlook.com (2603:10b6:510:1f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Tue, 4 Apr
 2023 17:21:04 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288%4]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 17:21:04 +0000
Message-ID: <7e617d8f-6c78-3d2f-5f8a-79acae09a8a9@nvidia.com>
Date:   Tue, 4 Apr 2023 10:20:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH V4 04/10] dt-bindings: timestamp: Add
 nvidia,gpio-controller
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
References: <20230323012929.10815-1-dipenp@nvidia.com>
 <20230323012929.10815-5-dipenp@nvidia.com>
 <f523c155-7d05-2034-27ea-e2e56881c0bb@linaro.org>
 <a7539193-8374-cda6-f535-360a4a8eab22@nvidia.com> <ZCv8TviVD8n4MrnW@orome>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <ZCv8TviVD8n4MrnW@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:a03:114::29) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|PH7PR12MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df1da37-9a3b-4fbb-cfd8-08db3530f81e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aow+7VBEXAGyOBnkIdt91vJp9WOUxBGC3gwRROFQOZIg2OSjNyChOWTRxqrtcVWoEEC+ZgEgLePmHpxz1FyMXQTHBjOC5w1VBtLQGTSqo07RkK0HtbeqpZ8jKSpPPuN8FE2C1St0tDT6eYMXmc28Sox0N4wXrRIwYR/7/rLqferQA//xPOrHGpqRxBgs8j+SMMh82FO0QYQQEXlJH3yK8svqXp37LjI04/tEFhp0pts2EYlbbGx35HKkuX74+qeFjXGVvTnPLA+9xDca/aYFGJtjglz8efy2Ig2+0ugmEai0tPPcJUDBPwmsPei/MDJzSye/AiMNrQMdHdF7El7fe3UpdnAbmWtd/jk0aQzEXn/zgzAsMqarWkCjg7sf+azYZ8GTDLAaB+IpW+nVZ1RTRmtWH6rvzAMyF1D0rOZhPCcGFG/XTccG8PB45t9W5EOpQw2FksY0KgicdSvXE8KYVRRmPuclwOEBqHOnegh/htrxaV9zPFv3KttkaAOritSUZoC92zvTdZXqnrQ+nxQRoRLWXYarV1pltC7EkVy+hhCFc+LKfNeEh8e5iRCI7VLLohLuJyBTkW3u8ilmuZ0rUD9hVD4i5afkx/wa0imKoCCyaEra33svBUaz+Jv33BKrDSyTn3kocNouac5ExT3LXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199021)(83380400001)(66946007)(8936002)(8676002)(31686004)(2616005)(6666004)(66556008)(186003)(36756003)(5660300002)(53546011)(6512007)(478600001)(2906002)(41300700001)(6486002)(316002)(6916009)(26005)(4326008)(38100700002)(7416002)(6506007)(66476007)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d29hKzdWTjluNWV3TUJQclN3b1g4djhqUVZrcFMvb1dtalRXMlA5b2E1TFdM?=
 =?utf-8?B?YVJOTk1vSmpWbkFUeWp2REtXWkF1VTRwc215bHVTYlpIaHJMMFpTMkF6L1Ay?=
 =?utf-8?B?QkJoakR5U3hsRXgzU05jeWNMWnZRZ3loQ3FCenlHS2J4MGxxSm43ZXJ4Qzlk?=
 =?utf-8?B?ZGNVYUlocm04czlBc1k4aStsU3FIcElxR2RsMWE0akRCVmlXSjA2cWl3VGcy?=
 =?utf-8?B?YThQNExkRTcxZlFueWJIUDBGMkdQcFZycm5QK2FUT2xOeitsdXNyZktJY2pX?=
 =?utf-8?B?eXFJYTVPUTVkM2JiOWZoYkFLWlpucDh2QVI1K2dUSTRCeUFFOENkZDZjbVVP?=
 =?utf-8?B?dzUzTDRlemUxZlk1dTMxMlREbHNRQ3YxMmJNUmxRai9vaDFkY3Zsam9rMkdB?=
 =?utf-8?B?dHprZEQ1WjMwVDNXWEVqajZ0bWR2cFFxWXdyejR0RTJPa1lPR1lzTnUvRXJM?=
 =?utf-8?B?MUVPdFhVZ3ZWMWNhMlNKK0NhcUFZZTNEVC9MRmwxSmFsRlZ0T0JXWEJrY3dW?=
 =?utf-8?B?UWxodCthZ0ZwMkI1UjdkUmcrOWJtTXU0OFRYYmtlSi9TeTd5dEhvOGhFQThy?=
 =?utf-8?B?YklSM3R3NGVZZ0pUTE5uaXAxeHZVbGRvZGxiejJkMit3UlN6UnlGb2QyWnR4?=
 =?utf-8?B?VUM1UzJhdDY4dGYxbzErRlVIUng5Y0JJaDFJMFhmdUJsTUxrbjNUVW1FdGJL?=
 =?utf-8?B?NVp4YnBFbGkveXJsT0x3ZDZxa0JjS1dYdExrazRnN1lnSm13SlFTN3p0SUJ1?=
 =?utf-8?B?Q0kxd3dSb3BGYWY3NkZXaTdwMkkwcFNTZ013eVkvc0VqTVVycGt0RnpOZDQ4?=
 =?utf-8?B?Q0k2S00yQTRnWE5ZQzl4Wm8ySS9VVmpqY0xEUGR0Y3Z1NGZHallkbHNSVm5O?=
 =?utf-8?B?VUF2ZGY4ejM3RnFyNHF2dDQxd3RNZ3FrTm5BL0VReHVRNCtYd000bURNQ1RM?=
 =?utf-8?B?R2dKLzVHLzlGamYrUnc3akdEVHFvREdNelFCWGYySXdKUERFRkRvbjZHakZ4?=
 =?utf-8?B?ZEdsdWNleE1lYzNhSVZ4USsrL051YllFN2NZbjR4L0Znb3J5NkM2c2tXUHRI?=
 =?utf-8?B?ajY3M3Qxbnk4Z25LcEZwbHU0Yi9MTVc0REZSNlhRM0g2SFBYV2RIcGxYUGpC?=
 =?utf-8?B?eDBxM09valZzMnUxcFRKeWwrc0xRTE1lZFIrR200Sk5GNzR6VUQ5a0FwT2FT?=
 =?utf-8?B?ckNLOGNQRFhSWUlwYmdBMlh2TkpibW94Smw0b2JJcFpNOVFINzkvY3dHb09r?=
 =?utf-8?B?NmNmTlMrTHV4T3Q2RVpCWTF4LzBXVW02eTVBQTQyWTk1M0pVc0hoL3ZjUHZk?=
 =?utf-8?B?cnkxczVsZGtPaG5YajV3QUp3bFZ0VWpFb2ZkczB0bnI1Mno4UWM5UkMwL2hP?=
 =?utf-8?B?TmxvVGtMODV3S0xnWlB6VHFobW1laVd4UjJVVElFbG50NDRRaENUMGwrSjVJ?=
 =?utf-8?B?bkRoNzNyc2tsaC9jR045YnhaeUhSbGpJNnJreC9oN0xPL25IOHQyMk92U2ZU?=
 =?utf-8?B?UHRCSXJLYmJnTTB3MUs3NEgyUVAxWjJjSDdtRUdtWWhpSFVnNHJHM1pyNTdt?=
 =?utf-8?B?OStHWm5zajZwVmU2UkhsclNFVHoxbXgwcnEzWlowa2dLOHV2bnlHY1BpWXJG?=
 =?utf-8?B?ZVBJa3lJVWRDN2dETksxLzVPL1YweXJ0bzlxOXJRbGJQTFNvRmdjREM5ZHFU?=
 =?utf-8?B?ejY2NVIvWXRiSnUyK2dCZ0QyckYyZHFHLytyalhPblhkV2diTFdldmZHd2Ix?=
 =?utf-8?B?dEVVMmlsMVpPU2hEdjV5ZENrcGowUWF3OHR5djFiWUJqeWM5UWJQUWRMK0U4?=
 =?utf-8?B?djhEZ3ozbWZibFBjVk1VVC9OUmI3ckIxc0s2dDZCSlJMMElCa3N5OVU5VVl0?=
 =?utf-8?B?K1dMOUlSN3FMc2FVUytTY3BpaFFUN2JhK0VGVFFOcjJrcC95eUVmVmZvdnBp?=
 =?utf-8?B?dFRSVzNUVThPRlIrTUpZTmQvaGozQW5lM05PWjJFTHZpelUwWTU2S2prdzJw?=
 =?utf-8?B?U3BVNWdVVnNrYStsYVhqTTN1eVlOQUhYcVpiQU9Bdnp6a0ErZHJlcG5nRE52?=
 =?utf-8?B?V3JEMzUvQW44enoxOUZKWUk1dmd4STd0dTdSQ2svbWRxRUExR2dUN2Y3Z3Z3?=
 =?utf-8?Q?PFVDxptxCrfR5M7TDegYdx9mC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df1da37-9a3b-4fbb-cfd8-08db3530f81e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 17:21:04.2913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3RRoJZkqnty6MduhNduz2HRyFO1o4nykUYj5iI3jO4qfU9l84BADSmmozVVrX8WBj4TO3fEtu6yjSBZKaIZ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6466
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 3:30 AM, Thierry Reding wrote:
> On Mon, Mar 27, 2023 at 09:58:19AM -0700, Dipen Patel wrote:
>> On 3/25/23 4:07 AM, Krzysztof Kozlowski wrote:
>>> On 23/03/2023 02:29, Dipen Patel wrote:
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
>>>> property/binding does not break existing Tegra194 provider driver.
>>>>
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
>>>> +
>>>>    '#timestamp-cells':
>>>>      description:
>>>>        This represents number of line id arguments as specified by the
>>>> @@ -65,22 +71,43 @@ required:
>>>>    - interrupts
>>>>    - "#timestamp-cells"
>>>>  
>>>> +allOf:
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - nvidia,tegra234-gte-aon
>>>> +    then:
>>>> +      required:
>>>> +        - nvidia,gpio-controller
>>>> +
>>>>  additionalProperties: false
>>>>  
>>>>  examples:
>>>>    - |
>>>>      tegra_hte_aon: timestamp@c1e0000 {
>>>>                compatible = "nvidia,tegra194-gte-aon";
>>>> -              reg = <0xc1e0000 0x10000>;
>>>> +              reg = <0x0 0xc1e0000 0x0 0x10000>;
>>>
>>> This is not really explained in commit msg... are you sure you tested it?
>> I have to revert this part back in next patch as when I upgraded dtsschema it gave me errors.
> 
> We need the 0x0 in the DTS files because we have #address-cells = <2>
> and #size-tells = <2>. For the examples, those default to just 1 cell,
> so this can't be an exact copy of what we have in the DTS files.
> 
> Please make sure to always validate the bindings and examples.

Ack...
> 
> Thierry

