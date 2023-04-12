Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903016DFC50
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDLRKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDLRKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:10:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0973118;
        Wed, 12 Apr 2023 10:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZ+Phni+HA/VcuEOvw7SVigOjxtFQfd9YDsgG3MxLqCZiqpsPXwKhMVU01f+XwFDJmQZ+wugiiZa0XK+XevHuUqGVwJlQIqN7q8ODeLP9mYXA/L+yFDJkvY3bifntl2TzifTyCZ6XYpcRCNt5DkV1e7GUgwp27AbsHrSuesPix+qS7gmt/tywfV5DLljqotLPp9mFkyJW46ync9eKS9zIovPHHl3O8ObQuAjgt3LqspxDC/4THFjb9vKnRzi/nWLGQNHq/BIUJV1nG2XX8Y8w8mb1SO4WW2yFKmJ5MSFnvlIPJmv0PeSxlhQoextvnRKoK94C74GLjbF//1258qtvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q5NYrVN4YRUWNMiIoWaR5gQkSuuPEDXslDnU52cNQk=;
 b=NlijC2cpW1/jHB9rS9XPSAuz9UXHCCkvASHNXW6YBXtw0LuEpTwY2eXggQLq7Jiedd/AYV6Kz1ogucgJruGv7EYa6L4dIn8k8pE0gcPWq0HUL9FmVkLPDp7lD+RXsVHTFfxlFQugO8KNekknHeCKv4L4Puyjq88KJD7HcPRzgQaSuPYSYSXSsshKgp5Ft068pCgOzf5B1t2KaXiWd73eJBdSZAZ+ckuDvs45BlOsFJmpUHDR0w53qFoDqOD2hyAz+Bz9FHU9fq0HHaonO7QbwIJ7hb7+WZJAb37jXIwxrJML3u5zFtBFE+LwFJoYPm9pe4Kuk7eh7kwaEjZphUludA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q5NYrVN4YRUWNMiIoWaR5gQkSuuPEDXslDnU52cNQk=;
 b=TggoZwNRLn7pvmDNU5+/o03+85j6vlomCUxOG7gG0f25d3y4DSGyDKAJQ8IJzBjKqO+CZsDFZW0/IfgSFbeD+agaKiT5XEceYNCHU33FESvb1vrfnquVH+eIQf1IqlP6JBQYNh/gpAug/M9AI9G5QpIRZRZDdtg9BRPnSf5xSmKl1NpIc5UE04195/+JV0VYO166qAYRPF2fAC+Uw5XJXkgRZlrHGk8xbDlBzqeyVt6M13Cbgyj774EcZ99bdR5pdmQanuYckQ3CL+7d2bIEnQPzxuRCDzkHW1WAvf1cgsGOCIdiPhuSxdfmIBTsesEJR2fHId+GCuzKzPTgYEVmXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by DM4PR12MB5891.namprd12.prod.outlook.com (2603:10b6:8:67::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 17:10:40 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288%5]) with mapi id 15.20.6277.034; Wed, 12 Apr 2023
 17:10:40 +0000
Message-ID: <2c02147c-827a-030c-5aab-15b53e25e4c7@nvidia.com>
Date:   Wed, 12 Apr 2023 10:10:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [V5 04/10] dt-bindings: timestamp: Add nvidia,gpio-controller
To:     Rob Herring <robh@kernel.org>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
References: <20230406171837.11206-1-dipenp@nvidia.com>
 <20230406171837.11206-5-dipenp@nvidia.com>
 <20230412142903.GA2313008-robh@kernel.org>
Content-Language: en-US
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <20230412142903.GA2313008-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::28) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|DM4PR12MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: db83e991-af1d-4006-2c4c-08db3b78d77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zCghiKSEJ6yDu047FxMCxvQx89piyh/45G7Ht+gxAK4GHZTlP/Mtd5sgWCt30S6nkg9ZVRYCXf5yoJX3GwM8IdoF/kuobbBZJHLZFbjts+3/rQ/As7UMBNUVmC+k8jc2AlRfU7F0Uz3pUUmHr/RjxQ5NAm0lFFESZZryo+lk7+F7Rhj4d1lYxNBMfYmjnW4ywSVuwut/Ner+U8Sm8PHcIsiTSxp4xigU0ECwhjVjwTqp9P5E8hY3ghg+/uN1VPIBZeanWY5+z6p0KYanZXMxqKrqx12AmIX42p/pAoIJH+agPkf6S6+QjeibqYlFhuVZqEdj31d9A5haR/15f11wXiWAm/cWY2EjJXv1IAQ2GICtXW8KcKYKqRZEkSKszrFw2J6OfnSukqej+IL9QW+TdxVKAyRGWxsxL+q5so1TYFy2sqNSvwf9tH33KJc9BLQmwQV2RLLChknmqaJ7hqraFle9R8NUnB5tO2iERagd3UNmEw8SKoi3Jytw5nrzptPd7voC5nYzXeuCvI1DNs09jBZlVz1oIqL/frIJrGdy+pLcLVzaxld5NZvKzhVJqFJqD5OCZ3pJDxmOLAroLQnqdl25vJ6KQdlHkdSjGjWO9bpS7jav6UlU8YlORRpaUi8w96ZnFiHIoqIcC1GAl3AeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(31686004)(478600001)(6512007)(83380400001)(36756003)(31696002)(2616005)(86362001)(38100700002)(316002)(2906002)(53546011)(6506007)(26005)(186003)(5660300002)(6486002)(66476007)(6666004)(6916009)(66556008)(8936002)(41300700001)(8676002)(7416002)(66946007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWJ5a1ZKaDZoQ1RqbWlrdnZLT1pNbFBaelZha1BtcDA2bmFSUHhlVmVqdlBa?=
 =?utf-8?B?cTJMVTBtWFBobHVLTGpUTHdnUm12Wm9UVlhLVkJVNXBjUnFQaTd0bXR1VHM2?=
 =?utf-8?B?Zm40K0ZHQkk2RDY4TVprV3VhZnczOGRHSGsxUWd1eHBFMk5yRmhYZWJwT1BQ?=
 =?utf-8?B?VVRsWTI4MVpUU3doVCtSMlB1MEd5YStHZVo2WnBUdEJ0QUUxWmFsS0tPWWVr?=
 =?utf-8?B?NU02b2dnMXhQWHBiUHFUTEtYRG9LOVVZZVIwUzlmbmM2Y3FDLzI4V2tnRHFv?=
 =?utf-8?B?dllXSjArQkpxYkNFcTdiUDBOemZ5TVVUV09NM29XOHozUldUekVGL0JINS8w?=
 =?utf-8?B?UkJRUm9BN1NISTZ4Y0xJWlhCS1V2Z0tURjd1bFlSRU9nT0VhQmNvNjB6ZnJj?=
 =?utf-8?B?NVFQMEh5aE05OVFSYW9iR0VOeXVJNzd2ZGt6K1ZURXZZdDVWSTVGMVlFOWYx?=
 =?utf-8?B?MGF1TEFtTXdOaEZ0b09QeVdNMTdlWlNHdmhmTmtNbWpLNG4rYWtkUzFvQm9S?=
 =?utf-8?B?L2hmb1ZqbEdwUUVFYjZwY0QvTFhjWlJybzlwNHp4Z2JuMnlWODFEenIzVHlp?=
 =?utf-8?B?VXpSRy96cnNUMnZLNVM3REdlMTVFWVczSnBNd0pUN3NHaDlncytreHJBUU55?=
 =?utf-8?B?bmNMVGR3dDF2WVc3RmhqL1BEK3ZLdHRjSlEvK2hSVDMxbkhqMytUaHpJR0N5?=
 =?utf-8?B?MCtVZmhKdWZLeXBiMTlTdmdBRFc2SlB5SVNjajJaNE1zWlBvUlRGL3FWcTlW?=
 =?utf-8?B?eUJaVWdodVVoOUlNUHhXYkFOY3dqM0dHQXY3MjAwUHZncnBpOThCeGtuUGR1?=
 =?utf-8?B?ZklNQmJ5NUx0UVEyQmV0UjA2NEc2ZGVBQzNtSW11eW56WjNnRlY2ZW5zbnVD?=
 =?utf-8?B?TnVtRVp3ZGVjMm1LWlRjbTBkNG9WNlNTNXhXRVNEbXljN0N0ZzNGdXpFT01V?=
 =?utf-8?B?TDlURkJsMGdMRmZ2N01aaEZYWTFqUktYNXFLVE1xdExkYTZ6QllaUU1xNzZJ?=
 =?utf-8?B?TkxKa05OZmhZN3VmWDBnd1Y1ZUZILzVwZWJFd2haczhTM2NEakk2eVVRN05E?=
 =?utf-8?B?VEFhTlQxNnVhWURUTlFYLzBTZ2xMaXBDWGZTRHdPendsRk9jWGttdkorYVlU?=
 =?utf-8?B?WEdTQU91MWZGUFFVbnc3SHVJL0VkS1ZUYWpUSVpUeStVaEpHNkNzS2RxNXRr?=
 =?utf-8?B?dDNGT0JMb0thR2JuY0kzck0vMk9LSzNYYTFOUkx1NG1CRm1zbk5GdDdZS0h0?=
 =?utf-8?B?d21TcEdaN0ViM1JaOGJXanEvMTdsRURVcjVxVFNCL1l5QWZ1R1Y5YlRFWDdy?=
 =?utf-8?B?ZmY2cHBwWS9NQUtWQWdaMFZtbFpuK2hpK2N5SGJLL1hiejcycitRdGtIRmtF?=
 =?utf-8?B?dFhiZUZOWS9UdUFpZW1JaDlhZUZqNmV4WXh4QVROYitZeXJudEJxdFBZUW5Y?=
 =?utf-8?B?U3lqMnlFT3RJVTlWUzFRSGxQNlYySHdtQkF1TkMvNmUwcFR2aEpNQVUyVmVv?=
 =?utf-8?B?SFNZMUQwbGJIV1JkWEI0NFgwVG44SkhSL2trNXNoalM2RFJhKzVCQXhaK3Bi?=
 =?utf-8?B?MmpPTGpOay82K3d0emRaR1A2eXFQUEV2cnBEWXY2WCtyMW11RVB5UWdpdUpK?=
 =?utf-8?B?QjhmU216TnI1NThmL1c5Q2wyakI3NzJzcWtzd3NZY21YakEyYzlUbW1UaEFx?=
 =?utf-8?B?WWhwaGJES042Y0hnZlA4c0VIM2NpNXNKcEtpaUNxc25PU0haTVpPaWd6Z3lG?=
 =?utf-8?B?V2RYVGlXK3c5TWdiM3IrOEJsLzJ3TjlKYS9JMXpQcFk2UjR4TlQ4bjlqTHNq?=
 =?utf-8?B?VnZhMXJuTnpmSkVIOWQvY1NxcEdSZWNQcWR3a2FxU05WUmFGMmNjTW5kOGYw?=
 =?utf-8?B?QjA2V05EaGJ4V1lQQnRHRG03UVZLa2FoTFFjd29zQ2hHZGdQckxIVEVEaGkz?=
 =?utf-8?B?U3U2djBjQ1pPSUplTHpzSzFocHhROU5GelN3SlFFVjE5L0tuaGUzUHNuZU1h?=
 =?utf-8?B?UXovZmZPSEdJY0lCOGNIa3FmeG9Pa3RRMUlUT29UTXlHQmtjRDBGNTd5SWFM?=
 =?utf-8?B?NGx2UTlmT2ZISWRJU2tGcEQ2bEszQThkOHZxZzZoTmJtQSt5Kzhqck5NbUtT?=
 =?utf-8?Q?i4rr/Cygy0yMC69T/VgwezzBf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db83e991-af1d-4006-2c4c-08db3b78d77a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 17:10:40.4003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6CVweztjhWl/lmVr8/X4KX2gd6TClK1UFDDj8moNsrlV7pUK/cqBDKgB39697+o663/q43t80zK/iFrRyNjLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5891
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/23 7:29 AM, Rob Herring wrote:
> On Thu, Apr 06, 2023 at 10:18:31AM -0700, Dipen Patel wrote:
>> The tegra always-on (AON) GPIO HTE/GTE provider depends on the AON
>> GPIO controller where it needs to do namespace conversion between GPIO
>> line number (belonging to AON GPIO controller instance) and the GTE
>> slice bits. The patch introduces nvidia,gpio-controller property to
>> represent that dependency.
>>
>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  .../timestamp/nvidia,tegra194-hte.yaml        | 36 ++++++++++++++++---
>>  1 file changed, 31 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>> index 855dad3f2023..66eaa3fab8cc 100644
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
>> +
>>    '#timestamp-cells':
>>      description:
>>        This represents number of line id arguments as specified by the
>> @@ -59,6 +65,12 @@ properties:
>>        mentioned in the nvidia GPIO device tree binding document.
>>      const: 1
>>  
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - "#timestamp-cells"
>> +
>>  allOf:
>>    - if:
>>        properties:
>> @@ -94,11 +106,15 @@ allOf:
>>          nvidia,slices:
>>            const: 17
>>  
>> -required:
>> -  - compatible
>> -  - reg
>> -  - interrupts
>> -  - "#timestamp-cells"
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
> Adding a new required property is an ABI break. But you just added this 
> in patch 2. If this is required as part of nvidia,tegra234-gte-aon 
> support, then it should all be 1 patch.
Ok, will move this to one patch. For the ABI break, I have added appropriate
code in the concerned driver to continue to be backward compatible.

> 
>>  
>>  additionalProperties: false
>>  
>> @@ -112,6 +128,16 @@ examples:
>>                #timestamp-cells = <1>;
>>      };
>>  
>> +  - |
>> +    tegra234_hte_aon: timestamp@c1e0000 {
>> +              compatible = "nvidia,tegra234-gte-aon";
>> +              reg = <0xc1e0000 0x10000>;
>> +              interrupts = <0 13 0x4>;
>> +              nvidia,int-threshold = <1>;
>> +              nvidia,gpio-controller = <&gpio_aon>;
>> +              #timestamp-cells = <1>;
>> +    };
>> +
> 
> Really need a whole other example for 1 property?
The property affects Tegra234 Soc and beyond, This example is provided
to showcase that and it also implies that old SoC Tegra194 is not affected
by this new property. Havind said, that I have not issue removing this example. 

> 
>>    - |
>>      tegra_hte_lic: timestamp@3aa0000 {
>>                compatible = "nvidia,tegra194-gte-lic";
>> -- 
>> 2.17.1
>>

