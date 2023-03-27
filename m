Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401C26CAB28
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjC0Q6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjC0Q6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:58:30 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4B630D6;
        Mon, 27 Mar 2023 09:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2eT1YxKqWCk9lA2wV8QMkywa7HeF7kzi7SfQWIE+jp/c0n2elN5fPf6CLZ5k1/HXkr2ytaS2jkFizX+ByJ5JeOr1U97GvJIPunrLkQxAcTA/rwNXab1qF2Jq2OpRsWVdJPhJZNfRhmPwl6lXXIhdQs+Xe9319BYEu8U02Rjj1Hz3/uqA4MY6uXsOOSLdFO8gV1/oKlKUoPQqH9bY6t5TjTwmRVkJ1TGH5gXNg+RWGXJ51bEK+5z83SCeQODzmlkkHv4M8NhLdw5fYxxMTs55YLso/EYwX5hnJlr11l7GcV8QAIa+SpUzB5gDbwRp7WoJnxwN29QELVRKRO03MAmKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0M7XTiL9Rsp+Sy1ymkZK5t76TN0snq+YRbsXewzsf1Y=;
 b=f1fOlmiCYxWBwmNyMoqobYeu+Bxbe4RM1A0JfMPpBTC0ZhSZDMDfS8xNZM65ALnVKNB6SKsPyIuH+0fukDA87jum4HDkioTmF8rVwBeLSCY1z1VO0kvEVb/8b02Obj/WmlS2EzLE8rrdRvBEC7XuW4Awr/QAspZ1aV3lywe7XNL4+b6dEEUG+bwU+TtSx27+xc+j7Z34wC0HxBHbA6L7qiuD6XEs/eeDApVLxIiOHDHdR9uHhNe0zWZoa1/IYrV+shvE05e8KofGb16gtdk2HXKpPOu7fJmWsb+HFZqZ9iTK95m6RESI47UbPDkHHWyuWw5VYLEbqyYD3gMUlXC8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0M7XTiL9Rsp+Sy1ymkZK5t76TN0snq+YRbsXewzsf1Y=;
 b=GQDaPegSOhXGZepo7+H5cABT7uMUkBWmYDm6phEI7a3LFvhTY7hN+TD53RRsDRkQS3I2ugHXHrpLIbmy9gPFWXM4N/3659X/on0dbFDEcUFmxI9dl3suEI5v3F55Q9otDkpixz98vIbXXmf1t8CMRZ0t/SOJczJi8J+WJS00dCmuBkO+b2rfCdQT4P2ngjQwPmVQ5r87e6IqYct6kFBRH94JLDNcQkpvlLl4nXVBe17/P7mMINK7MIYhczRt94pgN+mtvPEoQSf2o1OqwIgveLyVlNm+TtZFpAeZnlwBLRMBrHMW0Z2MoJgHycF2mCaKYpIk4498fAlJrvDGpaikAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Mon, 27 Mar
 2023 16:58:26 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::265:64aa:fb3e:288%4]) with mapi id 15.20.6222.028; Mon, 27 Mar 2023
 16:58:25 +0000
Message-ID: <a7539193-8374-cda6-f535-360a4a8eab22@nvidia.com>
Date:   Mon, 27 Mar 2023 09:58:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH V4 04/10] dt-bindings: timestamp: Add
 nvidia,gpio-controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org, timestamp@lists.linux.dev,
        krzysztof.kozlowski+dt@linaro.org, brgl@bgdev.pl, corbet@lwn.net,
        gregkh@linuxfoundation.org
References: <20230323012929.10815-1-dipenp@nvidia.com>
 <20230323012929.10815-5-dipenp@nvidia.com>
 <f523c155-7d05-2034-27ea-e2e56881c0bb@linaro.org>
Content-Language: en-US
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <f523c155-7d05-2034-27ea-e2e56881c0bb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::27) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: a03d6718-78d9-4148-bd40-08db2ee47b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFFZji0Ig2uAa6AOrkta99bY/NmHBBwVVkY50LapncSguH5/BtV5ZFmJu3IkhClLf9hyz2tSkFDp0sBTgoY3IOZXATpfJIOMW2cifrzb4JZ1FDsG7QKP+bQOAR/D0TIUthDjpy7ZXfWlMUtXJtUnu/omh5xbLUZkrgMrYKxiEvZ7w3NDzpgShQ7bw0mybdYWaFN8a4YgcclpTKayJug4oxqEtwh0k1fvL4adcA2C20AO6SrZYStfdAuVPFM9acp/jUgF4WxpuSvIlzmdNSMuW/jkRGSZCpQI0dduclbqRof+j41NPJIAeFbIT8wYvLctSjnThc+xbQTMpAKH909rfZ3+7hiXTeJAORUi4I2virVYvnO8JIifnDJImHSEXwRFamnGDOM9HA9UmWoNFoRXGlGCwZRiHMM0iBql9RxBJgSB3RM4xxZQ/om9FdldlM+V6BMP5q6ac9CCasn8CYASwXOdVjSiDq12h8CM7hKjfZUiJOAIgs9NHKM7j6Eb092bbSamNN2DgXQgsFqof2sjP8EXTC4FjdNnlkQa6LKpUGFf8eanGoCZIvZBoslHmGCp47iqmIfn7/QLZkQkySNTyC28eWo6TQY1oKJCvhrka2eDxQnqtv1gjvwJZlVXR6zHz6HjKDsk5DP7llMUD3FPy3s8FYBwcOB9jE4B3gyOolg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(53546011)(921005)(2906002)(36756003)(186003)(316002)(6486002)(31686004)(38100700002)(6512007)(26005)(31696002)(83380400001)(2616005)(6666004)(66556008)(8676002)(66946007)(66476007)(86362001)(8936002)(41300700001)(478600001)(5660300002)(7416002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWJZd0tUY2FuR2RJbVRnOS9ZMGl5d0NsMytneUdKREtjTi9rQk80VWt4d1g1?=
 =?utf-8?B?NWVock9oeHpSdVprQUFhYVE3eTNsb1N5WDZPblYreFBwUnRwUDFPYTFzV2Fw?=
 =?utf-8?B?NERsOGM5SmlwK0JXK2xSeGhRUTV0OCt2d2VSakM5c29WWUJNOGFPOTRtRW91?=
 =?utf-8?B?SXVCcTZLKzh1MTdabzZDRTA3c1lHWXdKN2hlV1VvRFZUalZEeVdYeURtRjZy?=
 =?utf-8?B?RFhpVkFOMkFRbTF6bklJMHBGUHJHUlBvN0NJRDl3QmJuK3I4YUkwU0tRTWRk?=
 =?utf-8?B?RjZ4dURqUUNBbGhNY2xMVk5pNnVYZGJEUVJKZVpPamkzWGhjZXR2bHJyYjBE?=
 =?utf-8?B?STBjUkdNQXd6TmZMMGU3bTJlUldieFNVQ1UzbTZOblZNUFdhejVlSThwdjJ3?=
 =?utf-8?B?bEd2Q05sUmZyUDB6djEzUEhDWVlveWNlbEcxRFB4Uml6Y2NiNWh3dkZDWU5u?=
 =?utf-8?B?WWk0WStmcVN0U3ZSRC9OUXo3MjBPSEdyaHpDRGVKeDV1ZktEVjVrWnJIbVMz?=
 =?utf-8?B?cmZaZWVaVDdVbnE2bHRiVElFNEtRSXYrZWU5K0kwMzVHWHIyWlgxVlYzRzJH?=
 =?utf-8?B?VlI2blJ6NWh5Tks3S0hXWUtncitJbFJaQkdOaDBaSHdhektRSElpMmxSdU5P?=
 =?utf-8?B?SS9pWVkvUy9hejBDOUhuVDJpeFBiWWVLQWViLzJXZEt0aUJqVWdpVGE3c1p0?=
 =?utf-8?B?aGFtMEtnTEJENkpCTjZMYUViTGFJbHhlZlA0Q1pWbXdvT2thQjJadGlGN2Vz?=
 =?utf-8?B?YVlsVjkvc2EvZzFtSlZ3VFhpNmRnQ2VOdEF2VjBiRis5SXVSNWd5NEFhNXBY?=
 =?utf-8?B?WUI5ZHB5amdQN2lWbEdwK2pjai9CdkpOMzJoeU9aMGZaU3BVeGNZWE5weTJo?=
 =?utf-8?B?d1VGZTFhR3FrMGc3UC9MVmtpSWhWd1ljYnJza2liUzVBdkhPUTJzVVVkNk02?=
 =?utf-8?B?dTRYTU5YNnprWGEyU2t5am5HU3c0SlQrL09qa0phbmZjZURLR2lnL3hqVW1B?=
 =?utf-8?B?VXl0VzFERFlaS0VLOUVPcDhLM1pMV2pyYmdna1lVOTEwODBsMnc1cmlmWUJY?=
 =?utf-8?B?ZVV3TjRLcTl4TlB2VWhOVnF0aTJPUCtLeVpKRUFlZXlGY0I4YUZIQkROcWF5?=
 =?utf-8?B?WmozdkFiVzBDM1dCckxLTS9pWW54Yy9OaWQ4ck4wemZZNllGSnRncDk5VXY2?=
 =?utf-8?B?S0x0UXN5b3cxb3liOFJ1dnUvbDZRalBJd1N2dGdKTEkyQkJyRmV0MFQxa1Zn?=
 =?utf-8?B?WmNiQ243Y0RCWm13MFhuNkFkcTZXWlNXWE16WVczMWlzS3FMajJrUkFKbGh2?=
 =?utf-8?B?RnlXQmRMSHNmbTJ1cXRrL0tKaGVkVkptWlRrZ3F3NHdCL216N2N5NGdPQ0Uy?=
 =?utf-8?B?RVgvVDduOUluY3hOLzNYQzE3dTdEdDJISUcvZDJlL2Vnblo0S0NYNU5QTHdT?=
 =?utf-8?B?aEJaU2F2enVsWnZ6Y1VFZGdsQmZrVHVDdXhVVWhJOUs4RzRDVGU5UDRoSUhs?=
 =?utf-8?B?ajRtSnIySjF1ZmxmUW9aeHlyYWRSdDBBbzRZcnlBd2lVNE5zY2N3bkprQTdm?=
 =?utf-8?B?SExmT1FrcWFBNEZhU1FsN28wZHNzdytGVlN4NnpkRThEbUtMeEV4K3hqRE9Y?=
 =?utf-8?B?MFVMZHVIYjdiL3FGVUxhK1BwSUVnMnp3RVl4Smd3L2tScDB2bnpQamdaQUlh?=
 =?utf-8?B?dlZ0WWFRdFFvNS9JQmVrM1ZlWlRCQ3ZmLy9PaXRTcXlONXVqanpqcXR5bmY4?=
 =?utf-8?B?bThpV1lGM2t0U2x2eU91elJMQUJsVVYxWTB5SVdyYUpNSjd3MnVEZ0hxUjU5?=
 =?utf-8?B?MVFLaHR2dWxWRDVucDR1bDZ2UnF5OGp1WDRLN013MC9za2JrWXBqODRXcG02?=
 =?utf-8?B?Nm5KQ0VzUGhXL0phVHlpb2RUNmJMbHFWMnhmeW54N2VxNk5tVnpsUStNaHBM?=
 =?utf-8?B?NC9jcHVleG13UlZ4dUIrTVkxNjVkQUtXRU12T0lkelU4OTNDNkJ6dDIwaE1V?=
 =?utf-8?B?V3ZyR0JPWVgveGJuS1YwQ3B2K1JqYW1UTm1iQ2FuandJKzNtTVlMc25iV3Fx?=
 =?utf-8?B?TVN3NFNRcnBIdWt5R0o0WGtUcDZwbW5UeEtRMy9BZ1J1bnBkOTZhZ3loR251?=
 =?utf-8?Q?gdYHrE9cske7QRlgfddiNx55/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a03d6718-78d9-4148-bd40-08db2ee47b11
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 16:58:25.7934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0DNxkfJn8/pcETd383TL8J5MhpFMc2YqMGyS3diV5zkCgGiLMmGgmMRIO8i1d4jY22pLX0NCwPAAZfZu5cCAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/23 4:07 AM, Krzysztof Kozlowski wrote:
> On 23/03/2023 02:29, Dipen Patel wrote:
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
>> property/binding does not break existing Tegra194 provider driver.
>>
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
>> +
>>  additionalProperties: false
>>  
>>  examples:
>>    - |
>>      tegra_hte_aon: timestamp@c1e0000 {
>>                compatible = "nvidia,tegra194-gte-aon";
>> -              reg = <0xc1e0000 0x10000>;
>> +              reg = <0x0 0xc1e0000 0x0 0x10000>;
> 
> This is not really explained in commit msg... are you sure you tested it?
I have to revert this part back in next patch as when I upgraded dtsschema it gave me errors.
> 
> 
> Best regards,
> Krzysztof
> 

