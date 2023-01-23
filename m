Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC6167774A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjAWJTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjAWJTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:19:46 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10C413D7A;
        Mon, 23 Jan 2023 01:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674465570;
  x=1706001570;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r74AIdkoJ4RDCTCAngh1FA6xEROMey3oogGF7pMxEoQ=;
  b=NnXglGkI5SbZWOq8ew71OrtzPbOy5SmdWv5F8eS3fIWezAnyjPvYfh5j
   +dCzElYSN9QslZalb2RUTRE33DxcMQw2/H28k9q5r/Tp9leE19Tj8ju+C
   TownBFezjVbNEE/WPAY2g6IxNOEM3J/F8u8m+hMfiZxljy0jHOPqRqL+R
   fFw7jLj9Z6MeWagB2EFtQffstyvBrf5XyVQSOKa9j9xqWfoxPFbupIYCD
   jqV4sFWwBihf5JHa9VMEK49Y3hsnTNGY6C15JbWIdnfQIT1ybSp0OSxhS
   PSeog+WZgcQZ9QKGcp7HO2infTE8mV6ze1ZgAWqVbpzkY3/Xolg6xtLaD
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wm2mjtFjdaqqRRiDoO1euhfEfeA4p1dgav/4M2Em7MNjLGiPsa52YT4p2Ga6hT4oojKaTv4+APy5IopeYVAF6PW9COZ7KX+p4tZ+oPD07pv9AbXm68IbuZhzCASsOBYGJ2v8Olat6ZjLQ+nSL7/8D5KHUbZE2oyJyhcqh+Ch23oaXADOqBMCuRLL3ev5v3/2003S2vyaaC45GZwrWe8Mni3GvFDqqQ1T0GHjfGuF0qAedUPWOZ6BQk/8OoOowrxtqSkuJDRuFDY4OczM9Sy/xompcXHHNLJySXQN2V3s3dmnFqohEjNW8pFYrO46wbnyl+f1iXEjM+IMGCOoagegTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r74AIdkoJ4RDCTCAngh1FA6xEROMey3oogGF7pMxEoQ=;
 b=J28Eu9A8vuLHiGnrKTLZT/uhprWdlELN/CJq1DzBLCRuV9BQ83s5EIvelBTjnQP9eDHxkBmth/+iUTNBjUYV/4KqRkKdlx7yvALtBq6CAWBIXKLeevsd1meWu4E0hTJRsnVe2z0BBuQ2BPdOllfWH3/PD1LR+CkZlssED+7nM6jyqs5Herzfe5AvzmSW9K9kkn7oh8H/w5pYwRDY+gymuuwBbddLrbaFDeuVQw8WWtTs6L4bYLfUsMJ3aecr/0sjOsYQtdZ/F0wXi/4h3qU7xiMCn90tMEWLJdJaoNcB7xzPbPPGiEUDmsDIMZUVCJqQQHAYRGYU8oen/Ox3uDxTBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r74AIdkoJ4RDCTCAngh1FA6xEROMey3oogGF7pMxEoQ=;
 b=E0gKCApPRt5dK4es2W/CgKQOSEQ0KD8vJ3lnla4cYIlfOy5osceAPoJLA+vNtADekaQU6ZToob/WHFqz7IFoZyFtcx9Fqvmj1uN8b19tsrO1/J23wP9i9XMOch44+ybEKrc0h4NOktCgr3BCEiQxDBHSURQ1veTp98fqgVK3cR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <50af77ad-d12f-a6b3-7864-e8c9a5a7756e@axis.com>
Date:   Mon, 23 Jan 2023 10:19:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 4/4] ASoC: dt-bindings: ti,ts3a227e.yaml: add jack-type
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Astrid Rost <astrid.rost@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dylan Reid <dgreid@chromium.org>
CC:     <kernel@axis.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20230120102555.1523394-1-astrid.rost@axis.com>
 <20230120102555.1523394-5-astrid.rost@axis.com>
 <2d05a943-3510-5ee9-9906-247a6344190a@linaro.org>
 <0b0c0030-3587-5501-c7b2-eccbbe4551e0@axis.com>
 <21ea0402-c4f3-1344-d084-9f3138713abb@linaro.org>
From:   Astrid Rost <astridr@axis.com>
In-Reply-To: <21ea0402-c4f3-1344-d084-9f3138713abb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0113.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::19) To DU0PR02MB9467.eurprd02.prod.outlook.com
 (2603:10a6:10:41b::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9467:EE_|GV2PR02MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 4149c2b2-796c-4a0c-4641-08dafd22ea97
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftjRBtgiKbaUcyEH3xqJM6UrA0TmH6qyzCBCWiuz26il9GI90TvpUBkN3fIh02t3S3Qf8iWqsuzyaDTnz8BXN2qSc60+js/xSNuhalVR9edkPGv2xnrUsIYeaxJY3NoLa6mobysgdY28w4rGthAHN4fjNJjlh3zlGSQLNZ2p/H3b2VcRtDLtP/AeLmTp4nOTmI8u1oVr2dmnfK6IbzVeuDT0DtPYLtYEhF8xKEwP233B/kP84qiKFsQ87goQaYXA2UMf/jcAVEFF/2t4cqgNsdQqsh1nU0PlPQ6Bcrzp/vuzkekZEs5zsE7tuF/L3u7veDQ+fr8+BHEaonFRAeOczEv3WENQZmxveAr7BhLbJn1VSUcMoySZUFeCKC8wYFzWfMio+H6pkOglmivtn9xnNRmzUIFFZiFHw8wkVrKiwLfYM3+JLPNkj4Qg4EtSzJY7B/BLB1sXO2pG4Dmkfaz7BQzut9o2vyOliNiv9GaUfdXp4bcG5tr/DWMLCtw5rHy1bSzR5bySV78ttN4aUwwunryvfrOyNDmMDBNECpDGniyJdtQNRt4DabgGjJi1aDorf5DpDs73L4siUaSsL8G0tfqi/L05FQ04UY3MgifizXJ0kepQkaoJ7ALxtcdAacvH9bT0DJ+ew4XMT5dxb5ABNmcknb9FPKEqzvOfhTa1eMdFaAWgH64rTc1f1XmfQcPxcPR5OG+hNHp/VuV7g7Ni97QBn0vMTFd1umHv4baWnTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9467.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(346002)(39850400004)(451199015)(38100700002)(36756003)(31696002)(478600001)(316002)(110136005)(6486002)(8676002)(66946007)(66556008)(66476007)(4326008)(2616005)(31686004)(53546011)(2906002)(6506007)(8936002)(41300700001)(186003)(26005)(6512007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVV4YlAxUTdSem1xaEp6bE9vUThEbEsrd0RWOUYxbElwZGZjUS8xaUlVREM2?=
 =?utf-8?B?d0hmQ1NzSG5EUVRPVnVQZ2RVdU9CMG5jSmU0SXBBUFl0ZlNBeEFqL0lFNTBx?=
 =?utf-8?B?VWZKdUJOWU5zRU1maVFuRnhucjBob3FPemdhMUFNRGFwcjBxUm41Y1l3ZFdx?=
 =?utf-8?B?dDQ3dkpXL2RXR2xQUFFTaGtBaHdId1ZyZ3BEKzAzNHlSeldnVW9FSnVrVW1l?=
 =?utf-8?B?R1NYUXBUckk2L2lSWGlMd2taUzJNUFNtbUZWN2dYVHpGV1QrTm5WQVQrdXNW?=
 =?utf-8?B?cWVNdXlmdEpycHJrNzk3YWY2WmVhWE1XVFhmVnB4Wkl3Z3lML2hucUdhbjFP?=
 =?utf-8?B?UnNyZkZTQzZaN2E1eEI1K3lDYUgvVHJMN1BMbHc2ZlBKM0VHVFVJZEFkRlAr?=
 =?utf-8?B?Z25ZbWY1b000N05DZnhzWlJRNWpkeGIzTmxTVlBsZEJoMDRCQTlIZUwwWVp2?=
 =?utf-8?B?RDg1MFZGT1hWcXFjQlcrUzFjeVFjdzA5M1cwN2VrUFhYY1BJQWFJMDRBS0ph?=
 =?utf-8?B?cFlCOGc5UHBJK0J4ZExiNUdUL1NjSWNRT0R6Q2tTam9ZbUlEZ0p1Vi8zT1JP?=
 =?utf-8?B?V2RCNDkxNHZaT1hXbEtpN1lBU2dISlRUNUhFS1ZtN1kydUF0L2xrU0ppczFU?=
 =?utf-8?B?L2E3WlQ4N3VFRDFJVWhuTEFBWjRFemliZFFBUkNUUE4wd0dibTZMS0l6UXBx?=
 =?utf-8?B?bzJnVFkwclFVVUJFYTVLRGVHTjlzcUVDY1QzMGM5OFN3eDF4K3JlTCtsWHkz?=
 =?utf-8?B?S0JZa2l0eWMxS1NFRXRhbWxheDFKVHltVmRtTUxzWTZyNldJc3RxRXZKck55?=
 =?utf-8?B?eVFnN2RlQnlDNnAwcUdZeDB4ZmJIcnBGeEYwbkJBWlIya1hkeDUvVzVITnB6?=
 =?utf-8?B?QjB1clN0ajlHTGlpU3lSUndyVERqeUR5WHl2NjVOVmRLaEsrVmdDQlhpVFpt?=
 =?utf-8?B?VWNWei9tNDlrc1UxYTlXYlpnZDZYM0pMZkFpTXI3Wi91WFU4WnNQRnhGRU5l?=
 =?utf-8?B?ZnpjaUlGTXk4ajN0QkFDUHBKdXF0S3lVZVhjUzlDMEFsa2lENFNQT1BMVUM4?=
 =?utf-8?B?eXVrQS9BdDhJVndLaTBhUUN0aWZqSzlINllzcXhFNlhyM0l1aDIzOGVZZTRD?=
 =?utf-8?B?TTBna09KbEVvek93Q3lKa21TY1pWeXdMelFOTmI0Q1FjVHp2RXBIOXNKVG5n?=
 =?utf-8?B?WUNhakp2blZvRnFaM1V1VWxJR1pXR0dRc2psMnhpS09kQkhCOG9kckdQU2xV?=
 =?utf-8?B?VzN0N0RtMUpZWWJqTWRMalhMSFc3aFRDYkFhTmI3WWswODcrTy8zTlkxUFB0?=
 =?utf-8?B?YjY2Uk9uZ1ZkczdiZjIzMWo4a1o3bkZLZnVpOTUxSmVvTGVJR250NXNmT1Vr?=
 =?utf-8?B?cTVkbWZLV3NCcEJGbTl4bFdxNk9pZTBScWZ3dTBVRGFMd2ZwSWlvUlJMV051?=
 =?utf-8?B?OGVGb2Z0bVF4ZDRlUUM5RzZzQy9Uckk3OGdUQ1k4Um0yZUlqdGFVNUtQZmc3?=
 =?utf-8?B?bTNyZWthRHUyYkZWaUUyeSsrZVp5bVBrTU9vb0xsK0Zlcnc3SGVVUUE4SndN?=
 =?utf-8?B?TWZWa21NNEVnNElhNjZsUmtPUmhGQlIwNENHaUdKQVlMOHRGazJQUGp0TnJT?=
 =?utf-8?B?eGdzcEJiYUprOE0xcHBIam10aFNrTjBwK3VzbGxXdTEwcWFsdFhwNlhwQXRC?=
 =?utf-8?B?Ri9RSmFHV2hHbXhrc05KK2FQTndPeHJ6VDd6ZGNYRWxMWmtQczNMUERMZFdM?=
 =?utf-8?B?ZEVkQ1dmTnZ3WFQ5OURnUnVRajVyVUNYM09rS0JtTWZ4ditKV2p6QUhUbXBl?=
 =?utf-8?B?cGFoOUxMNEgzdEJISUQwc05KdTJUZlR3STdqVDBWeks1SGtYK2xQSkE5VjZF?=
 =?utf-8?B?c29nS2pTMkdPY2RYKzJJMzlvdUphczJUdWxaSjBHOWx3QXNPQW5icDFHaDhB?=
 =?utf-8?B?RDU5WWlpZklsUmVNMS9JNXlGWlFFdEtVSzhFL1FHNEthNWZ4MkphcU1IejNa?=
 =?utf-8?B?NUZhSEJPaHovMFpxZTF1eERhRXdLSHRkTmtNUkwzNWRPbTVnTVg1OU9rNlo0?=
 =?utf-8?B?NFZFc1R0MDJIaCtod0RLRzh0R29PUk9YQ3pNWUlnTlZzV0pNM1QyTkFoeFNn?=
 =?utf-8?Q?mT0sGKQLPtEl+f1bR0LnsOEyy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4149c2b2-796c-4a0c-4641-08dafd22ea97
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9467.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 09:19:23.4094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X46inwF5e6mevEKFxiFCLS/peQTdQeHTE5+DzQW490Uot7bY8aBGOvWfgKews0dDz7wvIPFigidazv6pwXQF+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8652
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 1/23/23 10:05, Krzysztof Kozlowski wrote:
> On 23/01/2023 09:39, Astrid Rost wrote:
>> Hello Krzysztof,
>>
>> On 1/22/23 15:16, Krzysztof Kozlowski wrote:
>>> On 20/01/2023 11:25, Astrid Rost wrote:
>>>> Add jack-type: Bitmap value of snd_jack_type to allow combining
>>>> card drivers to create a jack for it.
>>>
>>> Subject: drop "yaml". We do not filename extensions to subject prefix.
>>> Nowhere.
>>>
>>
>> yes, true.
>>
>>>>
>>>> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
>>>> index 785930658029..1d949b805f98 100644
>>>> --- a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
>>>> +++ b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
>>>> @@ -27,6 +27,14 @@ properties:
>>>>      interrupts:
>>>>        maxItems: 1
>>>>    
>>>> +  jack-type:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description: Bitmap value of snd_jack_type to allow combining
>>>> +      card drivers to create a jack for it. Supported is
>>>
>>> Why the device would once support (allow) headphone and once not? Device
>>> either always supports them or never...
>>>
>>
>> If a device has two connectors (pink and green), one for the microphone
>> and one for the headset.
> 
> We talk about "ts3a227" here, which has always two connectors (pins)...
> unless you refer to the case when these are e.g. grounded?
> 

yes, that is what I meant.
I push a version, where I remove this.

> 
>> It would be easier to see from the available
>> events, which is which. But of course it is possible to give it good names.
>> My first approach was, that it returned all supported types, so no
>> devicetree change needed. But by colleges agreed that it would be nice
>> to remove unused flags. I am happy to remove it and someone who requires
>> it can add it.
>>
>>>> +        1 SND_JACK_HEADPHONE
>>>> +        2 SND_JACK_MICROPHONE
>>>
>>> minimum and maximum
>>
>> I do not understand this? It is a bitmap. I can put it as an
>> enum:
>>    - 1 # SND_JACK_HEADPHONE
>>    - 2 # SND_JACK_MICROPHONE
>>    - 3 # SND_JACK_HEADPHONE | SND_JACK_MICROPHONE
> 
> 
> Then maximum is OR of them, isn't it?

yes 1-3
> 
> Best regards,
> Krzysztof
> 

Astrid
