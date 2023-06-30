Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196AA7435B9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjF3HXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjF3HXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:23:43 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFFF10EC;
        Fri, 30 Jun 2023 00:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1688109822;
  x=1719645822;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mFZrG8S/bAgIcwGhSOpUz40GpIgndZPVsNAg+L5nM1s=;
  b=C1CHZKTmRi7TTirtJmSut0O03viMUZQZxtgUDX7+AddO5uyg23Grrq2Y
   arK6VqyJld6THITOKm03BPomwCUkBvkwTprdAbrhXDeJIODeWfiXa/E7S
   ssPdS+7q13UXCEu+dGpCEVxPHeYi/JgYitL08PnQHfIS1ZuAD+5XXdJ7I
   LGS9URY4U6NMh4TNKnTTnpdAryosfCyO+xysvsPt78jcTp+N9vgCallS5
   BChacI/BQFQfMdeWLgiY01ILXKGhWXd0zZspjoMrMEEHezpm+ogai6M8W
   bpFTXjOQW71S9lgbiT4eXvyD5qSUXlFENQ/YE5a/PoMJvv7kr2ZyOU7LB
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZbGtJiBFimrlx01drQ1JGjPyTz0uichNlajayldSxv2t8LHOo5dfKN7SPlQx/Qld/vER2pHvyLyruriQyIJX5HYzQAx+7zc0Ibhtqr9xZhXOmB3awwPOzdWNqZMPTeN2X0Z6989q8G6zjT4hkpSzxKFCCkHG4F0mxi6UyFk9fmAAcXyKmwuaEV73TurczCziSyq+NzV7SV4aVRHBOjgkuovWzk46Mc5FBqi5V3sNDUrFR5RwYYptv2VnftaqphojoAdwieCO4bsFsEqu7lDoxO/NyzOtwXePTD3o0gNGCXs6dmr3GnhG05ujrSmQJ4XQtEPiypJalK+kY9fkehMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFZrG8S/bAgIcwGhSOpUz40GpIgndZPVsNAg+L5nM1s=;
 b=lR1DSfhKuh6tteopqVepu3P5cXpKLvJvs5w6I6RiNl2bl/fVI3qDzdyqsjvepWkzNr3PFmlswcDKKZXuMTI2t9bIrSYpRPEo7Po2JC3GMmRtAyaqvJlst7OaNreayHThmea/JE4pV1qRZ2R2bsQBfj8mKu4ll9z5Kf/82+ct9r+Os2PADm4BaH9aRK2scgcZ0bLYgQ5YyWwpjfEHYCRccSEEBVz7aKBXqBtQZYFMwqIv1HK2EoPZjaPRF1hIYbskKFVGZsLt+4QSCgkM8Vfd8mStE7EFxe7Ua+TmY7KTBXUofN4KHknDPbpf38jWjEE3FrSk73FWgS1gA2RiNEvmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFZrG8S/bAgIcwGhSOpUz40GpIgndZPVsNAg+L5nM1s=;
 b=bNVrdRb2Tyrvb09Mmx4G978cNdDIvS8E7nmstdKFpd3gEIRBFzH6DdEFeJrvQexO6/SFyZ0lx93FhZD61u61ns9mD1uYW41JEJ7iXzCuoX+p4zqAr8wUeM/UNEilIjcipkuS/9NQh2H1z5Ja0tRv6gvbrTkb9lKqK8+nYXx9VJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <065fe185-4004-2329-f016-bb5161266094@axis.com>
Date:   Fri, 30 Jun 2023 09:23:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 2/2] dt: bindings: lp50xx: Add max-brightness as in
 leds-pwm
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Astrid Rost <astrid.rost@axis.com>
CC:     Dan Murphy <dmurphy@ti.com>, Andrew Davis <afd@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <kernel@axis.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230629134722.3908637-1-astrid.rost@axis.com>
 <20230629134722.3908637-3-astrid.rost@axis.com>
 <20230629175939.GA3260807-robh@kernel.org>
From:   Astrid Rost <astridr@axis.com>
In-Reply-To: <20230629175939.GA3260807-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0091.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::29) To DU0PR02MB9467.eurprd02.prod.outlook.com
 (2603:10a6:10:41b::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB9467:EE_|PA4PR02MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e83c55-de04-4b15-ef42-08db793aea75
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bl3lHljciZiuwNoSBqSrzm0r1/ubhrStnZpB5qNiMwoXRUpX1JWqfMjS+/klDrLbzh3LQ2bNeQZTvgFRwRhRj433J6s5/DP54QfKJet77egGogDkTiW106Razk0vtob9h70QXC4FnB3bhAzF4BCxK1livoCKlZbalZ28Ig7ZeBJ2LH/Wl7LIQocFLpH9YWPW5AfNWGUCQP0+P193APHoR4I68DPtXmdD5vDB1ZXvDs+mlaeTuYyffBkYLCXWXy30ESwecngMv2hmKjeXxfZLcr8ciJPc8TPtZmLXSZkHWDQbwOkJ2f4YX03AXOlSegt1SGgYOdNndvr5NbOGSalICzYZ+OSe2vxK80kJpWCugia7fYgR1N2DpeYf7A88rl99zfz+FHQ7CPS13P5C5ORONAaEKwciH2JqOokz0am0nAgwqKg7OM9M6j3CLACsqplGo9OvBszseYgsq3J0lHDAoudyOd0n1uwIatJYvgg0z4qvTTR1vmJv50GlL9YkmdqMn7MslBFFs0lHvF88RLVZYSZkQd5px9eBe8Hafu20XpHVVSGeU+oPghSHm9xluxW05SdJh4wNwMAi0zdZ2/gQK7qRJ6mRZDf5ukmgv1bniwIG6tA314M8ZisBNKwZjKXHnhe0Xip7xwBedB+wWaOwgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9467.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(5660300002)(54906003)(110136005)(31686004)(41300700001)(8676002)(8936002)(316002)(26005)(7416002)(53546011)(6512007)(6506007)(66476007)(66556008)(6636002)(4326008)(6486002)(66946007)(186003)(478600001)(2616005)(2906002)(83380400001)(38100700002)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2duUGJWanhnM1R0elhSNTJmcDhyL0ovNWFlY3RlRHdvUStuU2dyWERIR2NO?=
 =?utf-8?B?WjhEZFBZVEhCVmU3eERoNzQ5TlUwUW01UU9QQ0g1S2dWb0NnZE0yN0F1TFN5?=
 =?utf-8?B?YUR6eUcvRWwraGNhYUhsb2kvSTJrQkcxQ2VoT1NIdFdLaXk1MlpkdGtjV1Za?=
 =?utf-8?B?YmUvcFNwRTd1UW5KNWJPTytJTUNiR0hkZ1lEKzBnRHZ0UjdhUnFzdEg5eG9S?=
 =?utf-8?B?YWhQeXozK2plRnNwTGhTVllOa3MxU0JzSFloU1B4ZGtod3lobkJJMWExbmhw?=
 =?utf-8?B?azNoYWlwM1MxRmpHNGxuRzlTclphWlVuV0lvWjlGUHVlNFJvWFpLZG1PZG9n?=
 =?utf-8?B?L2N0UFdVV2k4aEQzaStBNHBobWwrdEVva0lIZUZzNUxBcXQrNW5SNkNhTzVZ?=
 =?utf-8?B?ZFRmcnpzZlF2MC8rRkZZQXpHRTNDNkdlQ0NjNnN1STZqV0xNOXlwWEJmOXE5?=
 =?utf-8?B?bU82R0RBTUJnNXd6OUFiVXRyVnVJVDJmZ01FTEdqaCtTSkh6NlVHWU04WGpX?=
 =?utf-8?B?cUhoSS9vZlp6MmtJcnRTZktBL2pqNVR4TTVGVTRrRXl2S0JlVlRlcHZqQ044?=
 =?utf-8?B?c0RudnBld25uTE5NUVEyT1BvSUFRdHFhNDRFaFJmQWs5TnYzUFlXMi9nN3Vy?=
 =?utf-8?B?ZGV2THJPRFlNWHd1bDhLNkhVMUZVblBSUlVBRUNqZG0rTG5xUGg2YTdDR1kr?=
 =?utf-8?B?dmVYMXhNRnJNSHRhTXUya1pjUzNOYUlnOTAyZWEwWU5uU1doclBvZHdaOXQx?=
 =?utf-8?B?SUJjd2RRQ2lxbVQzd1ppQVYxRHlOSndqdjgya3YxTHlmaHJlN0pxMm9sOVBM?=
 =?utf-8?B?bnExZkFndGJBVW9LWEw5Q3BreUhDQzVsODZsNm16Z2lBa0JtVlR6by8vSno4?=
 =?utf-8?B?TjYycVVWejFIbDRucm1RL1FoM0JDUkI5UU1jV2VUSVg3d3p5OGJnRlhmQ0gr?=
 =?utf-8?B?QWhSMjJ3ajBodGZIL3NjOEloM3RZUUpNTGxYNzVaTUZHdkU3UE5jd3ZoVHls?=
 =?utf-8?B?VWRyYkhFOWNSZHdpdmVKMjd6TXdRZ1p4STU0ekVveDdMekVLNWRiMDBUUlBr?=
 =?utf-8?B?K0R5TXRIeHpXYm9rWVdDMlFlMERGVFB4TjdDTVc5ajJRSTRZd3diMGZaekJt?=
 =?utf-8?B?Q3IvTUFUS1ZMTDJ3NTdJb1htY1paY0NRdmNyWE9qNWVRcVIzODNsbE1OYml4?=
 =?utf-8?B?Z3NnREwrMS9OMTZRWmxFcG1mdnVGakdNRnNWUmNVWDhvSkJQSzdqeHUxWGJ4?=
 =?utf-8?B?LzNsY1BDOTVaVGJZY1hvL2NlYmJnb2ppdDJ3MWdKbjY1R3pTMnpRTWhvWXZI?=
 =?utf-8?B?RklKNTNSMjBhUThzUlUyUUgrRW5aZUIzdnQ2U1plTTFLZ1gwaHJnVEtydGs4?=
 =?utf-8?B?WVpUdmZJMGc5dEErQlNnS3hTZG5zclhsbkpoSi9SVmRYM1diWVYzYlZYOG1U?=
 =?utf-8?B?OW1nOW9TY1I2L24zN2FCVzgwQWl4ZjlHNVJqRy9qNmFscFJoT1VwcU15YjhX?=
 =?utf-8?B?cjNGWFBXb3NmMlBNSmpYVU1BeDdUSitRM3ErUytsTk1IY1R5YjRqcHBpV2J3?=
 =?utf-8?B?RTNqWGxER3EwZnM4eU85RHBJWVdLZjJzcnV1aVhHdWxBczkwN1RGa294STI5?=
 =?utf-8?B?T1BuZWdMQ2pHUmpaWmRVS3BzU1djZ2UwUmttaTZ1OHA1eHJJSTNSMDJxR25T?=
 =?utf-8?B?eFdJSkppd2s0MjlUYTRWYS9pa1dHYVRHUThNSlZFc2pySXhTN0VhWlB1TFJ2?=
 =?utf-8?B?ZGhybnZpeVRKWUtHZ2drTnBVMkZNdHR6dkVHMWE1N25STXhDeWM1eDRCYjY1?=
 =?utf-8?B?TytoTkFyZittS0NCU2lOVllacDJla3hLNjBycjhGNkI0SjBscEYvNnI4aU12?=
 =?utf-8?B?M1pDQkpxRUdOUEtjbTAxYnBYSHFsTXN6bklySDNQN0VpellhWk02VTE5bDh5?=
 =?utf-8?B?VHpsMW9CbnBSRmdFTklZZ3QzMzVrNnRKc1k0WmZITEVNLzFENVNKdit3cG8w?=
 =?utf-8?B?eTI1enBQc0dpRVpicE41TVd0TzdXb3Y5WmJWR1ZvY0k0WUJZWmtOTWRzMTAr?=
 =?utf-8?B?RXF3bU1ZYzdyQUc0WDNoSGxHVkRnUzhhYjVGMmI2Mzd1Y3hvcHdFZDIvemFE?=
 =?utf-8?Q?LqSA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e83c55-de04-4b15-ef42-08db793aea75
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9467.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 07:23:35.2985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rzmCWL+afCtl++vJgV1QxBgaJM+5BrYK6uLIat3EnflCm36imyyeHarr2nmLSAU2mhjjd14zR/ZyyoEb7K1FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6879
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/23 19:59, Rob Herring wrote:
> On Thu, Jun 29, 2023 at 03:47:22PM +0200, Astrid Rost wrote:
>> Add max-brightness in order to reduce the current on the connected LEDs.
>> Normally, the maximum brightness is determined by the hardware, and this
>> property is not required. This property is used to set a software limit.
>> It could happen that an LED is made so bright that it gets damaged or
>> causes damage due to restrictions in a specific system, such as mounting
>> conditions.
>>
>> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
>> ---
>>   Documentation/devicetree/bindings/leds/leds-lp50xx.yaml | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
>> index 402c25424525..6a1425969cb4 100644
>> --- a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
>> +++ b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
>> @@ -73,6 +73,15 @@ patternProperties:
>>         '#size-cells':
>>           const: 0
>>   
>> +      max-brightness:
>> +        description:
>> +          Normally, the maximum brightness is determined by the hardware, and
>> +          this property is not required. This property is used to set a software
>> +          limit. It could happen that an LED is made so bright that it gets
>> +          damaged or causes damage due to restrictions in a specific system,
>> +          such as mounting conditions.
>> +        $ref: /schemas/types.yaml#definitions/uint32
> 
> We already have led-max-microamp. If this h/w works by controlling the
> current, then that is what you should use. "max-brightness" makes more
> sense for PWM based control.

Yes, I looked into this. This LED controller TI-LP5024 has only one flag 
as max current option, which allows to set between 35 mA and the default 
value 25.5 mA. This is not enough for our application.

> 
> If you do end up keeping this, it belongs in the 'led' nodes not the
> controller as brightness is a property of the LED, not the LED
> driver(controller). And it should be in common schema rather than
> defining the type yet again.

I will look moving it into the the LED generic bindings as Andy 
suggested. max_brightness is already there and handled correctly. It is 
just a matter of reading it from the devicetree.

> 
> Rob




