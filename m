Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233676D50FC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjDCStT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjDCStR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:49:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D941BF3;
        Mon,  3 Apr 2023 11:49:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UB+APoCSj9NtnZ/DgSPSJVRcZSotTHc4ZLt3wcMcmYKnyT43TAeJTFwD1KpR8tXbP6Ov3EybZs2g/DDMTUgk2Oe/jTEWIl2Uep07dPkwtA83XFxZN8NLkle+GMFda8Y/maOyrM1pygBzWHneSPrbDrfBLNNAQW5JL0aSpLsm3QoJ3Y1zZ/LYuYZDNQMGPO4QZoixAov+bnmtOy7iI+9Q0o122wAgPU7qtjCORgzNSbsmPKV4QZTZJN5nWiPEZMsAE8GHuVYoew9XVzSfVMPU923KGp6QVcgdosoxUA+qOBmBh1BU/0wfJdUbk0lQ0fuiRvYyWH8DaHYePey0NKC7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oA+3Xc0SRG1xTmFuM1mM6ikHs1lQywvdw89vBox+WQ=;
 b=CVxcH+Gv1GyJPD5Qea9Vqr8uwZ9UiI0ttEHPPYbDCeAT4XzkJ+VTRetI0DkRa88ktlrnEKmDBAxAD3WjdYfKuW1eK2l9pobuYreLWGyLNYcXfsbAedS/jXiLv11OlilP+IteDXy4CPPHYah9AADcmV4nClK1aLnL0ow+nOB0iykoijIys1F5KFUCYgmgdaZzh5k4Z0IeSaT0Fyr7em/eB8mxCmk23yB8L7j6RzjgOkWu2GK9y9K0xiyznXzTwWtWkFI5f5Tswm3uGy0uK5l3q8u8M/o+iC4s05k/a/3l3Jn6lpeVkKKpQnl4sofSulMKT9PlfjEVgWeoN5OR+D9Hkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oA+3Xc0SRG1xTmFuM1mM6ikHs1lQywvdw89vBox+WQ=;
 b=NE1Rp5RH0sidAybmSrhXKxqgRke05XVzwodiSSguqIouoP7UsNv4v29v96E0EB6t/Nys9bgyFsi560En7g1Xwftbhu7cqGICgK4EJG+1o8BmDAE7qzdQniEhRkU2Y94DFtt2EGv+WR2UsZ+lttY+pep6XnuySjseSUZFsQcUMZayaAX5/J36R2Hmo1qgMWXe0y/gFkmpHGbHdY7iRaMkTRhVZnTPCNpT1fCBrm40IUbiosL40QKesDvpJStbc34z5LmSdeOe/nHOvr9LfgUpnK2wvDGv54yifJ5V4q3wRfz0hmv4vIcarWynbF3eJ1iSodwEDYY5qLQ1UO1KGrGgpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Mon, 3 Apr
 2023 18:49:13 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 18:49:13 +0000
Message-ID: <d21063d2-da5b-bb60-93da-0e7f827c8599@nvidia.com>
Date:   Mon, 3 Apr 2023 11:49:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH V4 03/10] dt-bindings: timestamp: Deprecate nvidia,slices
 property
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org, timestamp@lists.linux.dev,
        krzysztof.kozlowski+dt@linaro.org, brgl@bgdev.pl, corbet@lwn.net,
        gregkh@linuxfoundation.org
References: <20230323012929.10815-1-dipenp@nvidia.com>
 <20230323012929.10815-4-dipenp@nvidia.com>
 <eb9a922b-82d6-c955-0fac-d6bedb494c68@linaro.org>
Content-Language: en-US
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <eb9a922b-82d6-c955-0fac-d6bedb494c68@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0068.namprd17.prod.outlook.com
 (2603:10b6:a03:167::45) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|DS7PR12MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 08867a55-a4ef-4907-e016-08db34741e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ed6lsKiHPepBCReAlRqaLiUOC+S++cjSNHGvhpxcZ03JdNujo0iBoXZYXN603fRUrQpbT1kvy4uMhDDRDpMyMGeqgfswbEHbBjQF6KLqfDe7mFOLvtDA17qoNp2J74X/DD9/mCYpMAJyF/icz9grvu8L6iSG4mvx7fkGrVMslmkHfCWhA0Zb8UC7aEdZNGr6J5gd1DLC1HH1nyMCyp6EKuQKulna1WKum1shdDO8GRB74qu04rLLjM2K1u58j4PMICN636mbKaCQQUVZ+yrQw6Rkb/fGfnuhobhZ+uLze8iavrDNrMZ+tIvip75bGvsMDpBcsQnfYb17U7uZoJzUzTIFKw7XMaLMDFqIYAgtW/GxHlvf4vXWlTTVKM72vstLAPoRlNDFoTc7dXb8+IwZyII7UmposrsXkZPTmC46EUnVKwm966e0pgTlMyVu7Gka3+kaspWivbL4CegWmLl//qy/6MOQNGlpZIjgx5EyvR5x/xI18dOKKU+/1t3C5YbVlKRieebrJV+19tE8F4gTJ8JztFPqek8zJNV5lStH/tx6kFbk04GEH0y5N5F4BUBCY7Zm6WaeZa+dBVK5xPzxymcb2GHflQ8oHBxDkTozX4x6Ad/T5ieomvHjYX886k/1czlDCgK1GFWxYFk3klnNFJUVqzcAbW+Dsu7NftdARo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199021)(31686004)(2906002)(38100700002)(7416002)(5660300002)(921005)(66476007)(66556008)(66946007)(8936002)(41300700001)(8676002)(36756003)(316002)(2616005)(31696002)(83380400001)(53546011)(86362001)(478600001)(186003)(6512007)(6506007)(26005)(6666004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2oxb3BTd3JWWSt1NXJERE0xVjJWR2RHVmg0cUc5ZmQrN0RwbmZJRjNyMDhI?=
 =?utf-8?B?dHBpVUFmRW5FSzVxdmZKWmdMNXU5ZVVhWFhvemp6SDg2RGJmRkVuRjhkdStK?=
 =?utf-8?B?V3Z6dExmZUFKZnJPVVVZK1NwdEdReURHQi9vNjUxTXFaeFZGK1ZQSk9PT1dM?=
 =?utf-8?B?NUpuM1p5Yjhrb1YxeFBRbnM4SVhJSS9jVVR4eWp0VHpDSVFkaXVsS3ZZSGoy?=
 =?utf-8?B?NFJMY2NOREJxdDdqOFcyWFROVFZrdk9uRjVhM0FOSk82TjQya2lEYTNNbnpE?=
 =?utf-8?B?ZFk5ZytuQnNxamt2UUxGMDZGY0F0U2RTeGI2SVQrK0hMQTF2UlM2S3dZaTRq?=
 =?utf-8?B?ejRaWWhabTFJeTdwckVJU2xxcWNhSVVWNTNzSTZaUEtIMkllUVRRQkRQVWVp?=
 =?utf-8?B?dERPTmtsS1F0VTJXbmxqOXFwYS9kdnVjS0dOaVoyZXNsQkpzTUUzM1RPeith?=
 =?utf-8?B?Z3lWTEJITmF0b2VrTHdKNVVqaFlaMklWeDdhcUFiUkFNWVI1R1d1eGIzWmFL?=
 =?utf-8?B?ZVpkY3BnRzhhZjBrWmJPTkJuUExjcGR4NUhEUnVIZ0oxQTgzVndVUFpaaTZB?=
 =?utf-8?B?SmtjcjRIZjFuTXU2MWZBOXdVVmdpNktCeXZOS1pRTzBhcjQzTHlhTUp6OXJM?=
 =?utf-8?B?SmxlWXZsR1R3MTN3QmRVUEx1K3lpdDVJbTF2UmRWSnIyKzJoSml5M1JEWkxl?=
 =?utf-8?B?MGRzKzAyNTQ5WDlPeVk3MDlrejhqVXBjU3ZBY3oxbWlxZURDZGdGdzE2Vm9o?=
 =?utf-8?B?YVQxUEVRR2VLWVJXditIY1JqendWSkZXTTN3R2hXYVFUenp3aDdhT3V4ZElH?=
 =?utf-8?B?MnBSYXp1S0IzdWU0OC9OS24xbytCcklUeHFDZmVSZ3ZreWpXTEVDdG1RTEdV?=
 =?utf-8?B?TUE0cnFhWGFmQ3VRZ1o0N0FRd3JmMmV4N0tlOEltWHQxSVFua0lUTkJ0YnFh?=
 =?utf-8?B?VmhlWUNJVk5wamZlQ1MyTGFuRDN6UXN4QnY3dVlkWHJmRUxyTVVwYmZxdFpH?=
 =?utf-8?B?TVF5Qk1zY2ZjRFlLZDBiUS90am1yc0ZiRFNLUWtWSTdxY0xqWkhZQUIwS0hX?=
 =?utf-8?B?RVpKY2NWOC90RC9IVGtZMUlzTGxPd1lUSG1OdFdFSEE3TW45QXN0clBrUUZV?=
 =?utf-8?B?bHlsNEFuRkZKVG8vM1loTEdGQ1pnb1V4S1lsZlh4VUtvK3V2ZjdwL1hMY3B6?=
 =?utf-8?B?Z0FwSm9sR0F1a2NHSklCZ1h3MndzTTZ0NXQvaUZQMWttZjlBekY0TjJyUTlp?=
 =?utf-8?B?Q09QSlphblJDK1hMY2VHZjBYOSs3N2NxOGVhSzhuZlZvVTBiMFV0V3BzR05U?=
 =?utf-8?B?YTAySmFYNHRza1l4dW5Lb2pBeDNWUFlqT3FSbkU0eGw1MWM5UndxQm5Ic05P?=
 =?utf-8?B?aHg1Y0RORWpPYS9LMW1LMHVTbjJrYXA3MXVLWVdnYkhXM2lqSDRGeHFZbi9P?=
 =?utf-8?B?aVAxd21HZGE0SWdHQkxuNHptR3RqSmJsaDlyeFMrb1dRTitVa25ZdFFRSzE3?=
 =?utf-8?B?MUYycWNnVENIUTRCeDlBQ2E4MUhSRjFjeFlPT29vK0V1eTlpQmJKUG0wejFs?=
 =?utf-8?B?YzRlVWVuczkzMHRUVm9OSEVrZmtMRDQ5TitDYzJtY1ArQU9KWlFLeEdRYU14?=
 =?utf-8?B?aTI4bndLeGRPaHViakZuSzNZY1Q4cDhsbXJEckRFNGtIbU9VaHYrTEJKcmRw?=
 =?utf-8?B?dFVLRHJ4M1E3NnRDaGtoTklEWUN6SW1jYXZBSTVtdGZGYnczTzZSY0NESFcv?=
 =?utf-8?B?VTh3c1R3YTdWNFBxdndhUktFbU5SQWpoOTNWSVQvUzVROXNhdTdNM21JUUIr?=
 =?utf-8?B?NDl1K1B0Q3I4Y0dZWFgvTGV3c0g4OVhXOEdveGNIR05HdHpReG5SNjdhdzlK?=
 =?utf-8?B?emxWcGpXVkIyK3RoL1JMcFNHSXJablZuOHZCTE0xTHJTQ29FejBzb1VyUjgr?=
 =?utf-8?B?ZDVDaWcyZ0l6T3pOdHNoSjRFS09ia1NQUE92bmNsVU16WGFXc3lYSWVxOTNy?=
 =?utf-8?B?dGpzeU5lL1pOTmVPRmt0V3hDVE9ES2FpQjZ0VmdJcVArdVAwZ2pROE55UzFI?=
 =?utf-8?B?MVRJWHZkd1B1d3NBb2NuSzR5UXRCWG5BUlBXSFFQekQ4Q2VkN2tZRlNlSDdT?=
 =?utf-8?Q?D4pl0I0IyhLfLwU0lxKGce9Xg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08867a55-a4ef-4907-e016-08db34741e28
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 18:49:13.4263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5z7grNbWjso4hxshrvtTdWX6narjt+1IYv9NTWK9ftGH6xS2ht1h/j+FS7XHYEarhYlG6by+D6TjZ1SPjclKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5839
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/23 4:05 AM, Krzysztof Kozlowski wrote:
> On 23/03/2023 02:29, Dipen Patel wrote:
>> The property is not necessary as it is a constant value and can be
>> hardcoded in the driver code.
>>
>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>> ---
>>  .../timestamp/nvidia,tegra194-hte.yaml        | 43 ++-----------------
>>  1 file changed, 4 insertions(+), 39 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>> index 158dbe58c49f..eafc33e9ae2e 100644
>> --- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>> +++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>> @@ -42,10 +42,13 @@ properties:
>>  
>>    nvidia,slices:
>>      $ref: /schemas/types.yaml#/definitions/uint32
>> +    deprecated: true
>>      description:
>>        HTE lines are arranged in 32 bit slice where each bit represents different
>>        line/signal that it can enable/configure for the timestamp. It is u32
>> -      property and the value depends on the HTE instance in the chip.
>> +      property and the value depends on the HTE instance in the chip. The AON
>> +      GTE instances for both Tegra194 and Tegra234 has 3 slices. The Tegra194
>> +      LIC instance has 11 slices and Tegra234 LIC has 17 slices.
>>      enum: [3, 11, 17]
>>  
>>    '#timestamp-cells':
>> @@ -56,46 +59,10 @@ properties:
>>        mentioned in the nvidia GPIO device tree binding document.
>>      const: 1
>>  
>> -allOf:
>> -  - if:
>> -      properties:
>> -        compatible:
>> -          contains:
>> -            enum:
>> -              - nvidia,tegra194-gte-aon
>> -              - nvidia,tegra234-gte-aon
>> -    then:
>> -      properties:
>> -        nvidia,slices:
>> -          const: 3
>> -
>> -  - if:
>> -      properties:
>> -        compatible:
>> -          contains:
>> -            enum:
>> -              - nvidia,tegra194-gte-lic
>> -    then:
>> -      properties:
>> -        nvidia,slices:
>> -          const: 11
>> -
>> -  - if:
>> -      properties:
>> -        compatible:
>> -          contains:
>> -            enum:
>> -              - nvidia,tegra234-gte-lic
>> -    then:
>> -      properties:
>> -        nvidia,slices:
>> -          const: 17
> 
> You just added this entire block in previous patch. Adding it there and
> immediately removing does not make much sense.
Yes, probably I should just keep that block in this patch as it is since
there is a deprecate field already introduced by this patch which should be enough. 

>> -
> 
> 
> 
> Best regards,
> Krzysztof
> 

