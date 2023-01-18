Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED597671F68
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjAROWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjAROWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:22:10 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E967674EBC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674050697;
  x=1705586697;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=huQ1jXIclGLsGK85Ini+1f9i9YRUrxsasMjlK0LmKXg=;
  b=o+iKE0aRKK/ElTAXHlMFNIbB2uakPc61swGubh9uxPCCAyzoPVOc9Vdz
   79UnSuQVtjteam3SKRR/Dp4bcPSM1T6PqmbcHGVsHPdzWDxsSV3rnK6AK
   BK1QNoYrBFUJ2ES27pxY8ucEbctwgtN3PI4nCb4OgN65YHD19GI2dtKmz
   pUrWDIElIc9XQkAujQDMydiO6iVnSsoc3911APRoXXl8TEJyEzyWL96BX
   kYzDK8VvNdNnPFAVMiH+4B6Nk4YZMci8dIjtSM1r2kh52/GsFeg7ePIcE
   GzpCGjJKwXOoeyYiiIP8SQ1x/gBi9hWldxedjzfVR3wxEFLdoI7XT+8V0
   g==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jk5jrjOYMYalDeLZEX6VTsWMCaGW1vGb0VSMSgdKwK7ZExqmkv+6+alWYEXA9op4bBKeHLXBuiyMl1DEWLx7Z/F7dOBqiq/ffs0a5eO9K/CVVhiCATea6E8vvflOJe7l1oPbMEo04yK9vIheQfZv1gZDL6PWyuCAIfj7e4uJyedaJThaFt9RgNKG1x+674whdwkKwIupEClJGtGm7o1Ev81H5eWCtBqvHGcboqj+Jn0a+EVOXuI2H+kTtU8Ld9/I66uOSqAeJpy/+89Rxj96pMnlRXFEmnTSu/B+u3PcPi8JsorTHxPev5ZEDl9IpCf03d27Eom2QEvqYTkJ8agZdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huQ1jXIclGLsGK85Ini+1f9i9YRUrxsasMjlK0LmKXg=;
 b=jkgYjMikYBrUV5Vg0uOhkLUUCGPxj/0Kf1o7BPweCXixXOqxW9+I6LnwVxprpkxipXIBjZzTzXtvctEpHANoW4esU1xjrAtQrRZy+RUH329NFjjcGAFvTVypA6F8Vy3dgFI5B38M2UWezt6YXtep5jHlVlTyk/gUvODLaT9u8sMvzDaRszCzl9y0KP+4oST65xlbp3XBbqRG3luQeFkv70KrxKuXyG7elSMdys3oyEjhmIM2sN/bGemFhnpplqjyCFvL5f4nkleSTcisUkAfLZiG1CJzI+dIfxOAhHrbrh50a8GzO+hIKQyVXxrEb7WkA3HlwEwTBSyet9PUH7H9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huQ1jXIclGLsGK85Ini+1f9i9YRUrxsasMjlK0LmKXg=;
 b=F2xVZkYV0CRvfH/wgl+pOZJtvOwFZGnz9bnk13xFKz3ug5MWfHqfjfvFY56/0oVomhQnCg0mOCGR4uylPD+lnV+ZgaOj+5My9ZIs3dct6JEBR7WMQq2l9iMLL7ooSKz7T4zb2QJ56TEQMofBf2mCxufXLfKkb4kYW/rcPg8cFCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <858c2dc7-e439-b3b7-f768-8974c3e1b15b@axis.com>
Date:   Wed, 18 Jan 2023 15:04:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 2/4] ASoC: simple-card-utils: create jack inputs for
 aux_devs
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Astrid Rost <astrid.rost@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <kernel@axis.com>,
        <linux-kernel@vger.kernel.org>
References: <20230118125226.333214-1-astrid.rost@axis.com>
 <20230118125226.333214-3-astrid.rost@axis.com>
 <e08f5a83-5a7e-9095-92f2-d78601c7a0bd@linux.intel.com>
From:   Astrid Rost <astridr@axis.com>
In-Reply-To: <e08f5a83-5a7e-9095-92f2-d78601c7a0bd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0099.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::12) To DU0PR02MB9467.eurprd02.prod.outlook.com
 (2603:10a6:10:41b::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9467:EE_|AS8PR02MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a28d50-247d-4894-6648-08daf95cf6bd
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TW2mQ1vt4UG3PAIX+R0DNvUuUUYBYCJoI5gKtjIU5BqbAOTqsx1QR5wSG8UgMNjNGYpW/HrHLmYXqiqcOm1sx0yTubyrGdiTkXlQg1ibq1qBiOesqOl/SkQq+OjVKPmNUDCCe/v8/LjdvFv1YSGkg8WzOtkTBXNDI6E44fcmfb5pay9EtJ8rL/L+kQJ04psSj/pCXuObWbENua+PgcK9CHPkroERtOJzLcIZ040XOr5yG1851PLveX+XVu+/8qOcYvFCyDwtE3KckTnVk7SGe4I/fapsdjdHaDr57Prk3Fi6GC3DsVgLMqGT1268+PQi2t/Rf3hV3w1Krw0GFobtIm8pjqI6kaHAgOS28LZ2xPKQwFAGQI/yP+NFESxcQGSCY/wDvUjFtmOh6cywMQFAlbGyOw7o89kHHKVeazwC9Cgcx60N0LTzizzAe5oRG6vasLUMhIKb++njYN1PmxOjgFBHdmSiHovU7aDsm8SsN94mIGWoiZQanVSeHj1m3PQso0ZHKHCR1KCwWWg0XdN6Y51SUQeACKXwNSUXhlrj6Qjr7ShnaB9BhZmU/oxm2mJehuOssDf+l6oBvvb072WwXWQKVq2V1oR/zU7hP1YO+I5v+Et4ka8YJb63XOu+yz6sUiphfh5+2xCunQl6EXrkya3y8+2xo3QilpXSjWdU2B0jSIDBpeWF2dQJBQCQiAF+7wI2GxXnXT8BrYj+MkyDgyOZZlxcyLq1UUMlApgipZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9467.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199015)(31686004)(6506007)(8676002)(41300700001)(31696002)(66476007)(4326008)(66556008)(66946007)(186003)(26005)(53546011)(6512007)(6666004)(2616005)(36756003)(6486002)(478600001)(66574015)(83380400001)(316002)(8936002)(110136005)(2906002)(5660300002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T25sVlZvNW1sOHdYYVVHK0l2RkFSUjYyMGp1SFNxVFdvbnR3Zkhzem9Vbmgr?=
 =?utf-8?B?bjNiejlJM2Jkc1J4MU1IMHhhQnAzcEFrc0tCZHR1ZTVUbC8rMVl0R3dhK01V?=
 =?utf-8?B?WmVFcUdWUFhQY2FSR2NGTndHWURaWkpOcjNQYkxuSFhqbTRZYXo1STF4aDZS?=
 =?utf-8?B?RXFLQXQwR01RbmJkMHpvZFFQNlU2VXREdnlhUEFsNmRKNWhNV240VGxCeHlq?=
 =?utf-8?B?a1kvT3VNb3lZMUJuNE9qVWVUQk4rbFlyd2Z0Nk0zbVRwV3FmMHFOY2JLMlVx?=
 =?utf-8?B?QWJTSWhsL0xDSm9JVlhmM3VsSm1JVWhzUEkrbU13dVVsTFlnMC9US0VqOTB6?=
 =?utf-8?B?S1A0bUNvNnMrU1k3Z2FUdllmMFdXMlIyekNWUGp5WjVJVDNRRXNLdkVZSjZI?=
 =?utf-8?B?RVFnOExoS25JT0Ivb3AwbUJ4RFg0bW5MTmxIWTE3bjRMN0dhcWFnbEw4TGt5?=
 =?utf-8?B?NDM3WFV0d0FlK00rdXptbk1hOW5pcEU0SHlmN1JISDNzUWx4SjhVMjVhTUJB?=
 =?utf-8?B?NDZQcTZPaWNxdFMzNzZldG5KZmtLUStJeklSa1lCTzY2RzcxY1UzcWVqd0Jz?=
 =?utf-8?B?ZjY5NnA2eE5lQjE0MjcxVVhocWxGaVJXM3ZJdGxodS9HY21KUnNtZGZJV1NE?=
 =?utf-8?B?UWJrd2xZM3JEMHdkSkVvMSt6SElEWTJlQkNZZHVDNGxCSGhDbmtvTStKcXV1?=
 =?utf-8?B?THJvdDRKMmVvclRJSTVFVEd3bGhiTXFQTnNtSzZScXNWMjlTbkZSMG9BZEcy?=
 =?utf-8?B?Sm85YndJUUFqNHU3YWFCMWlzM0ZtR3JLdlpNRmRzeEpLU0dTc3RXemhtSWFX?=
 =?utf-8?B?eVlHeGVhN05XeXRYMTMxa2JlNkQwNElXczFMRG5OQ3dDcDB4TEpMU25tYm95?=
 =?utf-8?B?aUhkNDBnRHdxQmhsTllFL01TMjJxalFuRjQzMCtMS0l4amd2cytvek90ck8v?=
 =?utf-8?B?dzdwL3lDaGVPTE1rejdjbW16WHVSSXVxRWtGeUlaN090RmlDeUFvSU5hLzVW?=
 =?utf-8?B?djZEdFhaajdOR0JyUWR3ZjU2NE9NUnI1RlZUa255RGV1OFBEUWp6eUhGci9w?=
 =?utf-8?B?VndWTVVtZlUwL0thNjA4ZnhtSmtodjdqTE9FbGlodGdNcWcyUGY1SU0yWGJI?=
 =?utf-8?B?ajhSWGZJU2xaVjVYTm0razNNQTNWNDVadUVlekFjVTdzQU5ER1RBLzRGRXlW?=
 =?utf-8?B?cFhrTTdZbjZzck5WL29zWWh4dVVoNmZCN2ozQm9uQno5bUxWY1lWZG9oZTBa?=
 =?utf-8?B?UkxZbW5oVlBkNE85NnFBeGJ5Y0tRbDNmNG9EMTZJd0VpL3BSL1IwcUtFNVZ6?=
 =?utf-8?B?ZWlpb0ZtWkREd0VGZ1FQS0pvUDBQUXRVbzBCZTgzMUlXTzltS1NGWExIZVhB?=
 =?utf-8?B?a0UvSERveUFZTGpGRFdsOVNRS01XREFnWURZUlI4Z1VFcXgvYmtwWmpnbkow?=
 =?utf-8?B?NjRVNnRMVU01SWdCVlRaV01BV3p0Nzl5Mys2ZDlMZEQzS2xpVzN2RDJucHUr?=
 =?utf-8?B?WENRcmdVNS8yT253ZFZNcEE2YUtyRkZhZ0FYSkFpajBZYitRU2t2cWVwbFlI?=
 =?utf-8?B?bkhYNW1yU3owUThRVXRlN2dZcHdSbkZwMGQzMUwzODlFWXZxMTNvQTFrbFp6?=
 =?utf-8?B?SFJKamxBYkhtWFhYL3BGQXN5UUFwa3h1TnEzUTdDUm1ERnAxbHVzc3FibVhq?=
 =?utf-8?B?R0VCN2F4RnAvOW9GSlJPdi9KZ0x2VkJZUlVFYitxN2V3Z1dyNEpmNS9Nckt4?=
 =?utf-8?B?eWtnL1ZNdTNUWUlxOHpkR0pnOXFOb2R0TVNORFBtMXJwTkZRTTBwQUF4ZmVt?=
 =?utf-8?B?MG5lV0ZYM2VQM0huOWorQ1IyRnBRSDVYVm90dkFTYmtlYzNGajZPK0hDN3Fy?=
 =?utf-8?B?MGk2Wll4bmxlbXhoUDB1ZmtST0NmOFIxSzhIeEVyVzBtaCtieXcwM3ViZWsx?=
 =?utf-8?B?bVlqOXJPalZpV2dqdFBwVEtPTU1kS3Z0NVRkS0FzQWhOTHM0M0ZyOUE0Mzl0?=
 =?utf-8?B?ei81cXk3YXY0NGxRbDRuRkN0VGJINGRtTG9DSTZWa3BKb1Z0ekNIQThqdzN6?=
 =?utf-8?B?YUxyWXVRaUR6ckdQSG13MUkvNnFIRys3c0I3WHhEKzVVZ0l1NGI4VjIzM3Mx?=
 =?utf-8?Q?kjc0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a28d50-247d-4894-6648-08daf95cf6bd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9467.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 14:04:49.9511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+C+ydGVif75dtgmworafE1EE8zYBIgao5OgivmYgBiup77oMb9mzLPUT1piSPBKXaCRbh2Bw49RpZ+EYolFtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8946
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/23 14:39, Amadeusz Sławiński wrote:
> On 1/18/2023 1:52 PM, Astrid Rost wrote:
>> Add a generic way to create jack inputs for auxiliary jack detection
>> drivers (e.g. via i2c, spi), which are not part of any real codec.
>> The simple-card can be used as combining card driver to add the jacks,
>> no new one is required.
>>
>> Create a jack (for input-events) for jack devices in the auxiliary
>> device list (aux_devs). A device which has the functions set_jack and
>> get_jack_supported_type counts as jack device.
>>
>> Add a devicetree entry, in case not all input types are required.
>>   simple-card,aux-jack-types:
>> Array of snd_jack_type to create jack-input-event for jack devices in
>> aux-devs. If the setting is 0, the supported type of the device is used.
>>
>> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
>> ---
>>   include/sound/simple_card_utils.h     |  3 ++
>>   sound/soc/generic/simple-card-utils.c | 63 +++++++++++++++++++++++++++
>>   sound/soc/generic/simple-card.c       |  4 ++
>>   3 files changed, 70 insertions(+)
>>
>> diff --git a/include/sound/simple_card_utils.h 
>> b/include/sound/simple_card_utils.h
>> index 38590f1ae9ee..a3f3f3aa9e6e 100644
>> --- a/include/sound/simple_card_utils.h
>> +++ b/include/sound/simple_card_utils.h
>> @@ -69,6 +69,7 @@ struct asoc_simple_priv {
>>       } *dai_props;
>>       struct asoc_simple_jack hp_jack;
>>       struct asoc_simple_jack mic_jack;
>> +    struct snd_soc_jack *aux_jacks;
>>       struct snd_soc_dai_link *dai_link;
>>       struct asoc_simple_dai *dais;
>>       struct snd_soc_dai_link_component *dlcs;
>> @@ -187,6 +188,8 @@ int asoc_simple_parse_pin_switches(struct 
>> snd_soc_card *card,
>>   int asoc_simple_init_jack(struct snd_soc_card *card,
>>                      struct asoc_simple_jack *sjack,
>>                      int is_hp, char *prefix, char *pin);
>> +int asoc_simple_init_aux_jacks(struct asoc_simple_priv *priv,
>> +                char *prefix);
>>   int asoc_simple_init_priv(struct asoc_simple_priv *priv,
>>                      struct link_info *li);
>>   int asoc_simple_remove(struct platform_device *pdev);
>> diff --git a/sound/soc/generic/simple-card-utils.c 
>> b/sound/soc/generic/simple-card-utils.c
>> index e35becce9635..668123549fbf 100644
>> --- a/sound/soc/generic/simple-card-utils.c
>> +++ b/sound/soc/generic/simple-card-utils.c
>> @@ -786,6 +786,69 @@ int asoc_simple_init_jack(struct snd_soc_card *card,
>>   }
>>   EXPORT_SYMBOL_GPL(asoc_simple_init_jack);
>> +int asoc_simple_init_aux_jacks(struct asoc_simple_priv *priv, char 
>> *prefix)
>> +{
>> +    struct snd_soc_card *card = simple_priv_to_card(priv);
>> +    struct device *dev = card->dev;
>> +    struct snd_soc_component *component;
>> +    char prop[128];
>> +    int found_jack_index = 0;
>> +    int num = 0;
>> +    int ret;
>> +
>> +    if (priv->aux_jacks)
>> +        return 0;
>> +
>> +    snprintf(prop, sizeof(prop), "%saux-jack-types", prefix);
>> +    num = of_property_count_u32_elems(dev->of_node, prop);
>> +    if (num < 1)
>> +        return 0;
>> +
>> +    priv->aux_jacks = devm_kcalloc(card->dev, num,
>> +                       sizeof(struct snd_soc_jack), GFP_KERNEL);
>> +    if (!priv->aux_jacks)
>> +        return -ENOMEM;
>> +
>> +    for_each_card_auxs(card, component) {
>> +        if (found_jack_index >= num)
>> +            break;
>> +
>> +        if (component->driver->set_jack &&
>> +            component->driver->get_jack_supported_type) {
> 
> This check is really weird, you are checking if callbacks exist at all, 
> which should be unnecessary as it duplicates the work oh 
> snd_soc_component_ functions. I would just try to call 
> snd_soc_component_get_jack_supported_type() directly and if it returns 
> -ENOTSUPP, just go to next iteration.
> I guess your main problem is snd_soc_component_set_jack(), but you can 
> just call it with NULL jack to check if it returns -ENOTSUPP, but I 
> guess the overall asumption would be that if someone implements 
> .get_jack_supported_type, they also implemented .set_jack, so maybe it 
> is just unnecessary?
> 

Thank you!
Yes, it works fine without it. I will remove it.

>> +            char id[128];
>> +            int type = 0;
>> +            struct snd_soc_jack *jack =
>> +                &(priv->aux_jacks[found_jack_index]);
>> +            int type_supp_mask =
>> +                snd_soc_component_get_jack_supported_type(
>> +                    component);
>> +
>> +            ret = of_property_read_u32_index(
>> +                dev->of_node, prop, found_jack_index++, &type);
>> +            if (ret)
>> +                continue;
>> +
>> +            if (type)
>> +                type &= type_supp_mask; /* use only supported types */
>> +            else
>> +                type = type_supp_mask; /* use all supported types */
>> +
>> +            if (!type)
>> +                continue;
>> +
>> +            /* create jack */
>> +            snprintf(id, sizeof(id), "%s-jack", component->name);
>> +            ret = snd_soc_card_jack_new(card, id, type, jack);
>> +            if (ret)
>> +                continue;
>> +
>> +            (void)snd_soc_component_set_jack(component, jack, NULL);
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(asoc_simple_init_aux_jacks);
>> +
>>   int asoc_simple_init_priv(struct asoc_simple_priv *priv,
>>                 struct link_info *li)
>>   {
>> diff --git a/sound/soc/generic/simple-card.c 
>> b/sound/soc/generic/simple-card.c
>> index feb55b66239b..e98932c16754 100644
>> --- a/sound/soc/generic/simple-card.c
>> +++ b/sound/soc/generic/simple-card.c
>> @@ -623,6 +623,10 @@ static int simple_soc_probe(struct snd_soc_card 
>> *card)
>>       if (ret < 0)
>>           return ret;
>> +    ret = asoc_simple_init_aux_jacks(priv, PREFIX);
>> +    if (ret < 0)
>> +        return ret;
>> +
>>       return 0;
>>   }
> 
