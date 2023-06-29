Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571FF74217B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjF2Hyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:54:39 -0400
Received: from mail-vi1eur02on2048.outbound.protection.outlook.com ([40.107.241.48]:31489
        "EHLO EUR02-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232422AbjF2HxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:53:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEFqPCs6uE6RPpPVvAAKnAxOP6jsa1r0CuRVCtoG5zQK/QYN+3gA5X/xLtMYCxG+Ic8X4y+HKbMSeonmhb7h8aFJMgoeqEcDNy3GVTFflBlXCk5YASKqI0uEOXHdKbt73x9Q/URHxKiyBGdRuI2Jl3vplrZS0qWcOdPiweNwl/jGzHfFKuBxyPW39Bhvjt5ZiIXV2AsPza7TyvJn3uSSY1UoQLiY+A46lwj2qiYkOh4Zyh5tz5FlbqriV8WZkae7M7+SZBJmZBF/T1SguONFOU71nwmJG2ycgU07SwWrd9lZjalPsqjG1CLW2OmhyKwpfCo8rSNLAp9eeB5xYOY5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSI2Qmu64zQHLVJ57XQ4ze1rlixAColllgajHlYDBfg=;
 b=Wlf6Kfc0/9JLpIJo4gNiF4ANFCtg7ICbnb5ytQjY/aLzmgXuN/XTuMgjmeZgM16nAXpCeaqmV5sF/hpnhg3CCoiBmRVD7lR62ghL9pZi7sdiHobj0dcGjtnZSjjLzTO51qkQao1/EGsqU8MqerJ7S+7NCBPsh01PguTY5xtlJzGg/eVYy/BWzIZgK8f4IPiEqlLsZ0WbiaZsUBe9lDbZFeK+Es8w3jGWJYXjFhGeGewwEu85Nh7JDcemfkjtkJCamYehzli3N0G/ybIHg56tG6ORJ0D2Lv1mi07/gb2WevK5AUq3rRLECcCpyhR0tIPn7b2VD2Ohr8w7nhSGtU2nqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSI2Qmu64zQHLVJ57XQ4ze1rlixAColllgajHlYDBfg=;
 b=tAZBDV9WDHhBsG5rpfn+vKQ0Ni983ngk06sZtdmgz90UIKkijssZJ7s0KYcxARUrl1ziSlYDqWVcpYY3r6Ssu4RPEPteoLKbd2IOEjPJOS6NOlggJyLw3DHABBUDW3Onq8Xj1ipwknPfJl1gDr2Q4UxWrimyg5D+sWO49yNQ//0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB3PR08MB9009.eurprd08.prod.outlook.com (2603:10a6:10:43f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 07:53:15 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6544.019; Thu, 29 Jun 2023
 07:53:15 +0000
Message-ID: <feb8931d-45e0-e701-d8a7-0f5e3c108a84@wolfvision.net>
Date:   Thu, 29 Jun 2023 09:53:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/4] Input: ts-overlay - Add touchscreen overlay object
 handling
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v3-1-b4fb7fc4bab7@wolfvision.net>
 <ZJj5VcHvfMMWMRx8@nixie71>
 <89cbb534-9371-c2be-0bad-776b51476ce8@wolfvision.net>
 <ZJmW/KOCJF25Z79t@nixie71>
 <543b2d74-eac4-3856-17c6-0654459a91b4@wolfvision.net>
 <ZJz6jnt9hDjuU3du@nixie71>
Content-Language: en-US
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZJz6jnt9hDjuU3du@nixie71>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0155.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::48) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB3PR08MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 45cd38f6-dcfa-4c55-4c68-08db7875e4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XsEROJ+dGk1JHA6AKyNim52G3JGqL+UY0Iq7Mh93U0E6PGrK/eEw9/ZTI0c5MW5LuIJVqPWMiOrHoWEH+JX5gS5aPQQqEi5Dq5ib9tzXfKQWJKpUe8CVCRWZCwsu77pjoE56NVaWouV/6HTtOsJ4006A7mk/26iyGud1KZXgJlxek+IRzzPEM60rGjWqg24TgyxkwxBKDW4GiIDaa6uh0tG/IGtwr3AJ33LD0CjrHYpkqAHoaHIVXfCJ+xKeaw4yLepRM7GQ3G0byoatqpd7tTi/GgQoU9Bv2NjkJRU6B7Zscu690WCbhqTx8nqN/ket5yeqiWji7pobEpHNE4vYbndI5lad3HtAkBxdegn2mFqdhVdkp9eAAdxmVjnL5EHvnAhAKnNM7h466U47sKjZUlPnlFO1TMhAK0HYyY7K2WQhAwCXtIfhy0/vItUstr96jkmkPgTLWQKlCotpViCkpWmKlMUhkxDArexMjHAb+iRh8KkTudMvNgoHhqkFrzeqLSXQB2X+fImbDln22j0q5Ymvo9V2os906dhjI/qHXeQlh2Yj4J9LRK2h2Qr9BUJeE8Oiz+fjoeS9X8k/520JbKYSgJ+beqEsNll3qZlPWxZdHNWq3CJNzS+r45hCnC9Etvi9gXUjzsGrvnyIwNEjYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39840400004)(376002)(366004)(84040400005)(451199021)(31686004)(7416002)(66946007)(316002)(44832011)(66476007)(6916009)(66556008)(478600001)(4326008)(36756003)(8936002)(66899021)(8676002)(5660300002)(86362001)(31696002)(2906002)(54906003)(41300700001)(6486002)(53546011)(6506007)(6512007)(6666004)(186003)(83380400001)(38100700002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mjh3VmJjcmRvWXZnSytaNlZLTWVTSHMyNjFCK25GQjI1dmhrSDI1VGpWT01M?=
 =?utf-8?B?TzgrV3JiclJwN0xlRGh4WXFEM0RxNzNNVmNRK0xzMDkrdlBlTGdyZWpyV1NF?=
 =?utf-8?B?QkFuSFFRZnZNeGNlUzhUNGJCamdTcThFZGRNRzc1Yk9qSHZheEtuZWNGcDA4?=
 =?utf-8?B?aTUrV2NnZXM3UjkyQ2tYeHRjNzB0bzFuT3liMmU5VStsOG9wa29FOWtyUXNo?=
 =?utf-8?B?Q3o4Y285OEtaU3dsUFBVZjNLRC96eTBRRGtld3pEZGJrRnhCd0VaN2tCejRU?=
 =?utf-8?B?bW5TVHNWNHBkQk9WcEt5M1JEejRUMHI1V3JiNkloSXVNR2NRcW8yYjJBMFZs?=
 =?utf-8?B?Z0tEOFBOVUVBQ3J0d2JSY2cwRllGZ1pJUjBJcWdCWkFEVy9ObjZFekFQbWh5?=
 =?utf-8?B?MUd6RnFKK0NUSkh5ZFY3cUdDbGJhcEhBNkJ4VitWMnZnTzNjdGVNUThwZjVS?=
 =?utf-8?B?ZG0wVjM0U0NjSnpTcGRCOFhYQ2lFRnlvTWtLMU5jYUNVRUJBemFpYi8rTVVV?=
 =?utf-8?B?S1pPRWNPM09vSHBuSU9ySTFLcTJRem9GMmEwTDdlWXdkODZBWk1Lb21XNzN4?=
 =?utf-8?B?eTVpeHBmc2NhbDJ4WEw4a2NJSlREUkU5bFdMYzA1b3VLYnh0Slp5a1YvNmFi?=
 =?utf-8?B?Wm91RDlFQ3B0NFBWVzZoMitRaVRQTGo0U3FkdTBseVkxcks3SjFBYWN5V21x?=
 =?utf-8?B?ODBoRUpzYXk4Ylp2UXlpMzY1VHVFVDZ3Q0Yweit0TGhuZzVRN0RydHNnWGJO?=
 =?utf-8?B?SHpPei9heDlKa2habzVqUjBwbmxHTlQzMUJMK3NyWm9uTDE4TE9HNkRUa1ho?=
 =?utf-8?B?LzhDenBaMVRGUHB3eDFIb0ZoaUJNc054STZ6YlZGZ3ExZ05UeU56dmd1V1J2?=
 =?utf-8?B?RHlORm5IeksvbmJYL2xoakpzWi9LRHF0WHVpRms3SEhyR1BhbElENDg2N2Na?=
 =?utf-8?B?bVBnNVRibC9rbWsreDMvS2s4RWFGcWhSOXdsVlN4OFRBUzgrcjkyK2t4U0xj?=
 =?utf-8?B?RVQ4MStkdlVkOEp3dWh4MW0vTk96MHh3Nkp3V01MTFlUT1pMcmcxU3ZYNUVU?=
 =?utf-8?B?dlVtQUJ3UDdmNGplNGNDYXZ5Q0l2TG5Oek05ZzhBODd2NkJOa0N1YVY0bHFn?=
 =?utf-8?B?cGIrZ2MyRnlxN3ZaYzZBOWtGQ0xsc254YWI2MDY3UFRMVitza05zYnRmb0U3?=
 =?utf-8?B?OTMrNzE4OWNGTEozRGFDNlEvb1VYOERvQmxMQ1BOZVBiZ05tOXY1VTJMaHNM?=
 =?utf-8?B?V1grUysrMnhTR2VObUkzUWVTemJuWEluNTcxUy9hVG1XU1RrcmtzWkZObHha?=
 =?utf-8?B?cDV1MzE0cVEzMnl2VTQrVS82cWhDL1RraVdEWkNtNTI3MVR4cXpMQU9DalFE?=
 =?utf-8?B?eHhUZ2FoKzJSK2lnV2dWWS8xWUxJTUFpSHpyeTJ3WE9rRFNqb09IcXRWK1NT?=
 =?utf-8?B?K21VdW5XOGtFUXgrVG5mRmVjUjNBcWJNcG1IWnd5RmovcjA2WFRuS3BYMjZk?=
 =?utf-8?B?N0t6ZTVtZUc0aGx1NStYc1JneEh5RUxnRFB0ZkNPNkJZdXlIb1o3em5Cc3lu?=
 =?utf-8?B?ZktNS25aNy9WeW1VRVNORWFMTm1NVHM3RlFydk1hN1FhWXBwL1c0b3h6L2tL?=
 =?utf-8?B?M29pTXFjdnhHblZ6c2Vvb1NJVC9SMnVDVXpuUy91TE1venhBQ0huVGJMeHJl?=
 =?utf-8?B?VUhESTI2M1ZXTWxjWkdMcmI2RldiL05EU1d3aTMxQk1TZnVUQlZ5dTV1dWFF?=
 =?utf-8?B?bE9FSEhWeUFrR3RpcTdDTEdLcTZqNCtLRzBtT050L1Ewd2FNM29HVVFpSkRW?=
 =?utf-8?B?aEJaNi9IcmdvSG92VGJHZlhZVFNzWlJtT3NZdnp6U3NYTUlHV216bWgxWmxh?=
 =?utf-8?B?YS8wb3lSbUhrQnRkR0EwMzBjdnU5TWdITzlIVU9CZzVuN01ITjkxVHRsTW5x?=
 =?utf-8?B?eDduNHRYdWc4QlY0dld3LzFzQVF5RWxFTTQxeVBTMVlmVUZKMUViRzF3cy9m?=
 =?utf-8?B?Nnl1RS9wSDZoeWFSMXhPWXlBeitZVjRaZit6OVhXZHNub0hkeTFHTTNHNFdV?=
 =?utf-8?B?c2Z0S29vdEU3TGlSRUl2bTJRQVkxalVHdERMY0JuNzd5cDJXYnU3R0laczNi?=
 =?utf-8?B?THZHVUsreUdjSGNxYWc3Snd6QUViSjlnWGxDUVQ5WnpRdFRTWCtzU05SeUJv?=
 =?utf-8?B?MmFlMzE3WXoza1B5eGZlSkFBcHNLTEZOS1FQUmJ2RWZkNGcvSnVDRGZXaURQ?=
 =?utf-8?Q?SmVUVNmZtXi6vLT7+1DQAGh4Bdhy4cpgHpMlwNU5e8=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cd38f6-dcfa-4c55-4c68-08db7875e4ce
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 07:53:14.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rpr6jMMXp28RmAryHxrU+FDnpcePvNtiCISUDCh46FBr2jA1FXz0QPiRNIzsTGbaSS6/00fapQqTV4f+8wATd4hd5ljAJLd8zGgu2+sa7nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9009
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On 29.06.23 05:29, Jeff LaBundy wrote:
> Hi Javier,
> 
> On Wed, Jun 28, 2023 at 08:44:51AM +0200, Javier Carrasco wrote:
> 
> [...]
> 
>>>>>> +static const char *const ts_overlay_names[] = {
>>>>>> +	[TOUCHSCREEN] = "overlay-touchscreen",
>>>>>
>>>>> I'm a little confused why we need new code for this particular function; it's
>>>>> what touchscreen-min-x/y and touchscreen-size-x/y were meant to define. Why
>>>>> can't we keep using those?
>>>>>
>>>> According to the bindings, touchscreen-min-x/y define the minimum
>>>> reported values, but the overlay-touchscreen is actually setting a new
>>>> origin. Therefore I might be misusing those properties. On the other
>>>> hand touchscreen-size-x/y would make more sense, but I also considered
>>>> the case where someone would like to describe the real size of the
>>>> touchscreen outside of the overlay node as well as the clipped size
>>>> inside the node. In that case using the same property twice would be
>>>> confusing.
>>>> So in the end I thought that the origin/size properties are more precise
>>>> and applicable for all objects and not only the overlay touchscreen.
>>>> These properties are needed for the buttons anyways and in the future
>>>> more overlay would use the same properties.
>>>
>>> Ah, I understand now. touchscreen-min-x/y define the lower limits of the axes
>>> reported to input but they don't move the origin. I'm aligned with the reason
>>> to introduce this function.
>>>
>>> This does beg the question as to whether we need two separate types of children
>>> and related parsing code. Can we not simply have one overlay definition, and
>>> make the decision as to whether we are dealing with a border or virtual button
>>> based on whether 'linux,code' is present?
>>>
>> A single overlay definition would be possible, but in case more objects
>> are added in the future, looking for single properties and then deciding
>> what object it is might get messy pretty fast. You could end up needing
>> a decision tree and the definition in the DT would get more complex.
>>
>> Now the decision tree is straightforward (linux,code -> button), but
>> that might not always be the case. In the current implementation there
>> are well-defined objects and adding a new one will never affect the
>> parsing of the rest.
>> Therefore I would like to keep it more readable and easily extendable.
> 
> As a potential customer of this feature, I'm ultimately looking to describe
> the hardware as succinctly as possible. Currently we have two overlay types,
> a border and button(s). The former will never have linux,code defined, while
> the latter will. From my naive perspective, it seems redundant to define the
> overlay types differently when their properties imply the difference already.
> 
> Ultimately it seems we are simply dealing with generic "segments" scattered
> throughout a larger touch surface. These segments start to look something
> like the following:
> 
> struct touch_segment {
> 	unsigned int x_origin;
> 	unsigned int y_origin;
> 	unsigned int x_size;
> 	unsigned int y_size;
> 	unsigned int code;
> };
> 
> You then have one exported function akin to touchscreen_parse_properties() that
> simply walks the parent device looking for children named "touch-segment-0",
> "touch-segment-1", etc. and parses the five properties, with the fifth (keycode)
> being optional.
> 
> And then, you have one last exported function akin to touchscreen_report_pos()
> that processes the touch coordinates. If the coordinates are in a given segment
> and segment->code == KEY_RESERVED (i.e. linux,code was never given), then this
> function simply passes the shifted coordinates to touchscreen_report_pos().
> 
> If however segment->code != KEY_RESERVED, it calls input_report_key() based on
> whether the coordinates are within the segment. If this simplified solution
> shrinks the code enough, it may even make sense to keep it in touchscreen.c
> which this new feature is so tightly coupled to anyway.
> 
> I'm sure the devil is in the details however, and I understand the value in
> future-proofing. Can you help me understand a potential future case where this
> simplified view would break, and the existing definitions would be better?
> 
> Kind regards,
> Jeff LaBundy

I agree that your approach would reduce the code and then moving this
feature to touchscreen.c would be reasonable. So if in the end that is
the desired solution, I will go for it. But there are some points where
I think the bit of extra code would be worth it.

From a DT perspective, I can imagine some scenarios where a bunch of
segments scattered around would be messy. An example would be a keypad
with let's say N=9 buttons. It could be described easily with a buttons
node and the keys inside. Understanding what the node describes would be
straightforward as well, let alone N being much bigger.
You could argue that the buttons node could have segments inside instead
of buttons, but in the case where a cropped touchscreen is also
described, you would end up with a segment outside the buttons node and
the rest inside. That would reduce the parsing savings. Some labeling
would help in that case, but that would be not as clear as the current
implementation.
There is another point that I will just touch upon because I have no
experience in the matter. I have seen that some keys use the
'linux,input-type' property to define themselves as keys, switches, etc.
If that property or any other that I do not know is necessary for other
implementations, the button object will cover them better than a generic
segment where half of the properties would be meaningless in some
scenarios. Buttons/keys are so ubiquitous that a dedicated object for
them does not look that bad imho.
But as I said, I do not want to make a strong statement here because I
have seen that you maintain several bindings where this properties are
present and I am not the right person to explain that to you... or
actually anyone else out there :)

Talking about the code itself, having a structure for buttons is handy
because you can keep track of the button status (e.g. pressed) and in
the end it is just a child of the base shape that is used for the
overlay touchscreen. The same applies to any function that handles
buttons: they just wrap around the shape functions and add the
button-specific management. So if the parsing is taken aside, the code
does not get much savings from that side and it is again much more
readable and comprehensible.

Thank you for your efforts to improve these patches and the constructive
discussion.

Best regards,
Javier Carrasco
