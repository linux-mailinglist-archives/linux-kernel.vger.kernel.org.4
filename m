Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BDF674EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjATIGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjATIGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:06:37 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2053.outbound.protection.outlook.com [40.107.7.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA406518DE;
        Fri, 20 Jan 2023 00:06:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOk3qN+hCXqdvxF2bIJTAFWM4HaSdVeXu8jLnUJd4PG2OBdNRe8I+ef4MahLpGA6QzjYoPSWKqpb6WZ3Hg5K3SkkFGjwsDy493PN6yFDuSNbU+nL3vbZ6hLTc61MAhsiPw2t+oE1nZGmx4Cef0xADw+yTeaSsScWvTYXPkCeRBOk9Ln+zqX2c5mSRiQuFUmpOerGxLbz+RfNwp/uU+CY7JB2W7tznk1FWhZ1zfYFmg9i7KsFyFzl+fasINikevmLt7cRd34Q54Ob0pQ4g615vzdCCWiEXPEm1HrYDsJrs2Skz9otTIVxRlih4dgzH4217LqrjShc+7uqCL8rrqgIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8KzwXn7Yfg6VLXV1d9boK42pxBTFB4LkviwqNaMD2I=;
 b=KdM2A9MMp4K+MMPZ6xJA6s6hn+PUh3Ay6+HTZPgvwXQj1N3gv/eZ6yJbGU6yGCcuCeW4KjL+sB3YANxwHpj92YeaMXt+QY7P+BownqLbZUmEqj1GPfkXfOtQWdF3i3duSAh1opVxskivXIs2MGq/mdilKXITxVDevyFJvH52LWNCEE1zKWFSYy0hfVkM6u1vR20cZgDcFUWBH1hOL71MfsvQUoso05ytQnsELqvQ6iXgAYmZ7bBwSujpsNTAa/rUkkY5GjWS9eIGnLJGMqujYYRRbHi1akt2bMK5iyoSF/I3+Qw6C2249HKCmOGivvGmue1/bNMg9MljwFsuyrhawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8KzwXn7Yfg6VLXV1d9boK42pxBTFB4LkviwqNaMD2I=;
 b=E6J5zzopTPytYozE5aLFLcLWEDIOqNjbLL/HAcpe0gGcsuKEC6D97iBnFC8LMQ+Chs3IYpW4ZpooWoDQnezMhC3qzKtbKfZdjx6BAKpeVWJxbkjKalKCC7yw39bQf8FKUoJWYVuu2eAUEZNY/z9F5fpjZ6a6OFYAFPpole73nrw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from AM0P193MB0738.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:160::8)
 by AS8P193MB2333.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:444::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 08:06:33 +0000
Received: from AM0P193MB0738.EURP193.PROD.OUTLOOK.COM
 ([fe80::9506:ff7b:ae6e:e51a]) by AM0P193MB0738.EURP193.PROD.OUTLOOK.COM
 ([fe80::9506:ff7b:ae6e:e51a%3]) with mapi id 15.20.6002.025; Fri, 20 Jan 2023
 08:06:33 +0000
Message-ID: <8044fb10-519e-c8ac-7c0d-50bd8b6a1224@kunbus.com>
Date:   Fri, 20 Jan 2023 09:06:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 12/14] rtc: pcf2127: support generic watchdog timing
 configuration
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20221215150214.1109074-1-hugo@hugovil.com>
 <20221215150214.1109074-13-hugo@hugovil.com>
 <72514fec-12e2-5b51-261d-9e171b46f5bb@kunbus.com>
 <20230119124853.9193fd073b8a95b45e20f41c@hugovil.com>
From:   Philipp Rosenberger <p.rosenberger@kunbus.com>
In-Reply-To: <20230119124853.9193fd073b8a95b45e20f41c@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::10) To AM0P193MB0738.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:160::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0P193MB0738:EE_|AS8P193MB2333:EE_
X-MS-Office365-Filtering-Correlation-Id: eb25b73e-2fa0-406f-03e2-08dafabd3e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zaORkP1L2UgHUNLK1vBbothXrgrCxphycqSshQVNJTzu9Q6eGz2TPPJcd2h/4Kdmx3Pwv0dMkGsboilGb8euOhRHQbv6GuYoDkkOTr2ps+FJDxuJaya3fDdn9qP7rUxZVPyon23t2ogjSeVD18tPi+S7SLB/G5d6YMdreZxbrMn9pS1ScAwOVYSF8zu1WKpTD9rmDeDyrv0Llk4nbgq48l+9YTD+FxTcVOrFOzMd93YbmaX1o6Kfu9r8Eh6EWibMM3jfuuVxyokS8m6dDsEWTGGb2kfVypazG25F/AUq0R+Dr5UGt3PZmz00uLRAEyf9i4Mrbx5byAeM3Bh+pUtgOzUAFVedoSHi98T5szTyhpS6hOGgohvS112qIgK8Y5uoghYUpPjTslzywgJEI3rEbwuW0ysbqcLEYCfU4ol9DTyn+16zRSucznh0VeV3twT6gDpCAmCxrEvGmAgp44q4ZhgXU6MEdyEEzFJo55adLEh0ZB2a+m7bN/mWruZeadILQ6xcYHiGmVjbGVjb5EinmknaPYCBaU0qTkWR4PVWdz02ltuuhDdznHWX0qKFNFT/NukXAIRFJDhkqAChiIB1LH0U5UXWk6meljhsUT/5azqB0qZo0H8TlPu2Xv/J+gxhVEEeSUdXTJyiw33Kc1sB5vqedAw5pnD3AQn0WneYV/cEOA5NicnAi42DkLosWWe3fGYarSvX2yftjqD+vHn9tio3YK9DQnUVje+auWV05WRQD/k5bwaBoRvChCUNkWhu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P193MB0738.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(39840400004)(396003)(451199015)(5660300002)(8936002)(31686004)(4326008)(66556008)(6916009)(66476007)(8676002)(66946007)(31696002)(38100700002)(36756003)(53546011)(6506007)(6512007)(186003)(2906002)(26005)(6486002)(478600001)(316002)(2616005)(83380400001)(41300700001)(86362001)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXB1M0c4Ykh5R3RQMENCVnAyWTNTVDJZcWdGdkZGUlo0VHNmK2Vzb2NJbU91?=
 =?utf-8?B?SlZMN1lHeUJES0FmdHVqMWlxc2w0ZGhLSzRVOGtDUklZWDlGNllBbVhJaVR3?=
 =?utf-8?B?YVllcHdCdDV1R3NuZndNd25TVUhpRDMyZkx5cEtCZkJSWlJ2czFIVExGc3hv?=
 =?utf-8?B?UStUOEQxTi83R2cyNWRIQkZCZ0JqVW00WUgvWFRsMWoxekRaK3Iyd2xXNFpQ?=
 =?utf-8?B?bGQyMElpNVJMYWNGVzljTjRaTkZ3eHpDQlN3T293dm9BVm92NjRRd3psZzNU?=
 =?utf-8?B?VjMzZkJHTE1PS3p6cXVkR2RkZ2lFbzFzWkRDQW0wSEs4QjJsT2pWa0hsL1BT?=
 =?utf-8?B?VTBCbm41eVhaRlRJU3RIVXJqRFBUTHNaenVOZ2xmM0trSW4wdjI0SWQ3bjFP?=
 =?utf-8?B?bUxnbDV0STIrNTFISks3L1Zkay9GYU90T0hCVnhyRkoySmgrc0w3OG5yMXdo?=
 =?utf-8?B?c0I4WXFwOGJQbVY0ZVhYWkRVdTJGQmNHMUxKN2duWkcvWjNzS3NvRFkwM1B6?=
 =?utf-8?B?dWJ2bU1QdWRIWDEvb0gxQ3ZDaVJpZnNpMHYwendNU0QvWjc5MzRQSElZSDFR?=
 =?utf-8?B?cm1zSDIvOWk4alNNZksvRWNtNnJQd0tNWTVzWjh6OThiUDllRFZKMTJFVDVP?=
 =?utf-8?B?ajVPeVV2eWI5NU5YQ0NpRlFkV1dreGE5cEJVeUhsSEVkU2t0MmVLdE51a01m?=
 =?utf-8?B?THJpRHhRZ0tLOUh3eWZpR24zcVpkaUdIbStGZ0hTcllUelVabjBWbDNxMmdN?=
 =?utf-8?B?MElmVmNLeFFyYlJlMjZvUlhQbW1zdUplcWdjaWhYUnFXYXdodERmRFBqcGpJ?=
 =?utf-8?B?SkZHS0dzNEdmNkpoYnIxUEJwNDNrOWVZR09oSDBiQWd4UWxaZGIvNk1Lcnk4?=
 =?utf-8?B?TmoxbjNPY3RjaExMMHFwTDJaMUFjaG1HUGRJWnNWL0t1OGtHYzNQZVVWWXFi?=
 =?utf-8?B?OStJcFF2Y1FNc00wQTBrUjR3R1I3V0JEY1l2TDBXakxZbVhFT1pXb1BZYW95?=
 =?utf-8?B?VFI1emsxMFkybC9SRnJTVkFnWG5EVTBKYWZnVWVLWGJrOFpSNnJ1K1JkM0VN?=
 =?utf-8?B?Q0dDdU1iR3RMNXBWbG9uY3M4WFdpajhjMGg2cFdsV3lLSDNRdFJaamVvdi9B?=
 =?utf-8?B?ekhVYmFYVEVXRlY5bk8xOUFSaTFFeVNTck80ZVFNVFRybzlSWXlaWXpjWS81?=
 =?utf-8?B?K29GTFV5SUM4WnBsRnRwODdTVmdBUzdYVHl3cGxML0NWNWdxRUZtMzB0Mldp?=
 =?utf-8?B?ekRRVFJlRU9haDFKVWQwbTk2ZDczaDZ6K1MzbERCL3Jnemx4LzhpQlQwWFla?=
 =?utf-8?B?YkhvYTVyOUJlTEtUU0JVOThQLy9mYjhUSnBKMzdzT2lmN2FoNUYyaTIwb3ZL?=
 =?utf-8?B?S2RXbDhPRiszNS8wV3VGQWZQT1d4U1ExaEdTMjU4YUFGWTBzc2lWcVNIOGRS?=
 =?utf-8?B?bEFTNDNvakl0R2MxSWNPbkoxdHFnbUVkL29pNWhXR2ZXZmNFdC9DbVRHem0v?=
 =?utf-8?B?ZkZmeWN2SllYRTB3cktWbEdHbjhuVG9mQUpjRXUrMitERlBhUms0LzJUV2NX?=
 =?utf-8?B?MFpFTWJPVzZnMFlDUHA3UytKcXVtN1JVVEZRVzZaQmY0b0dZbUtZYUFIc0w3?=
 =?utf-8?B?Q2R3KzRpbG84OWdFV01STmc1WEl1cXZMRVZlR0ErU0pGQm90SFo0N3pyZ0o2?=
 =?utf-8?B?WWp6R01uNGlyUTVQMVFWQ1VoNVpsWW0zU2wyQ3k1L0NtQUFPOHZkSitWOGdm?=
 =?utf-8?B?dWFuOUdWb1k1dUI3SGUvZUtmUzRUMlJUNU1SdzNNRVpsTUkwOVdNZk1TUHc5?=
 =?utf-8?B?c0xHQ0d2THE4MU54TlJKOE1GQU9rTEFCc2dSeFF6OWMxV2lLckMrbWVrV1FJ?=
 =?utf-8?B?ZzFOeVZoUjVKL0NvODdNeWo0MHdNMSs3NFpFaERaL0hmVzViOU5Wbjk1U05E?=
 =?utf-8?B?bzFFNlMzQTdFNUkySnlUUUZCdzVaRzhDVi9DeFVRVCt3VmRPeE5XOFQ2NG9E?=
 =?utf-8?B?UnJCYWlsdUZLbDUyeFB2bGRDaytNQlQ2MW1sWjF4N2dnZkpXMG5ud2JrTU1l?=
 =?utf-8?B?YUZOZnZzODVNbTRLWUk4NnNYUHRTSFBvWGFvOFpLdUdqcHJacXpPMUlJbkhB?=
 =?utf-8?B?SGZ2NU0ybWg1Y01ER2FJTGpiclhaaDdKb3ROdW5WWXZQa0RpWUhHa2xkQW1W?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb25b73e-2fa0-406f-03e2-08dafabd3e7e
X-MS-Exchange-CrossTenant-AuthSource: AM0P193MB0738.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 08:06:33.1961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UsLnaI8eUG+nG6dDZuUmUf5zxzh6Vuraig5iUAbiiCSYK9aYpvj5lYdT3K5etq3DXTSXyxvH/2mDm6/ESeO4ATIB+e9wyeqnWISbaNM0Ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2333
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.01.23 18:48, Hugo Villeneuve wrote:
> On Wed, 18 Jan 2023 14:23:14 +0100
> Philipp Rosenberger <p.rosenberger@kunbus.com> wrote:
> 
> Hi Philipp,
> you are right that the value store/computed inside the structure wdd (struct watchdog_device) should be in seconds, according to the header file documentation in watchdog.h.
> 
> However, in the PCF2127 datasheet, the value n that is stored in the PCF2127_REG_WD_VAL register does not represent a value in seconds, but a counter value. It is given by this equation:
> 
>      n = source_clock_frequency x timer_period_in_seconds
> 
> For the PCF2127, since the clock used is 1Hz, it works as the previous equation can be simplified as:
> 
>      n = timer_period_in_seconds
> 
> However, if the source clock is different than 1Hz, it would no longer work. Also, since the PCF2131 uses a default clock of 1/4 Hz, it also would not work.
> 
> That is the reason why I modified the watchdog timer value (n) computation to take the clock into account. I then use the desired timeout in seconds given by  PCF2127_WD_VAL_DEFAULT to compute the counter value (n).
> 
> So what I am proposing to do is to store the PCF2127_WD_VAL_DEFAULT value in wdd->timeout, as before, but convert it to a counter value in pcf2127_wdt_active_ping(). Or to only compute it once, I could define a new variable and compute/set it in pcf2127_watchdog_init().
> 
> Hugo.
> 

Hi Hugo,

with some small changes to your code I was able to get the behavior 
right. But with this the timeout get converted from seconds to the 
counter register format on every ping.

Just add WD_COUNTER(wdd->timeout, pcf2127->cfg->wdd_clock_hz_x1000) to 
the regmap_write() in pcf2127_wdt_ping(). Then in 
pcf2127_watchdog_init() just do:

pcf2127->wdd.timeout = PCF2127_WD_VAL_DEFAULT;

Best regards,
Philipp

> 
>> On 15.12.22 16:02, Hugo Villeneuve wrote:
>>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>>
>>> Introduce in the configuration structure two new values to hold the
>>> watchdog clock source and the min_hw_heartbeat_ms value.
>>>
>>> The minimum and maximum timeout values are automatically computed from
>>> the watchdog clock source value for each variant.
>>>
>>> The PCF2131 has no 1Hz watchdog clock source, as is the case for
>>> PCF2127/29.
>>>
>>> The next best choice is using a 1/4Hz clock, giving a watchdog timeout
>>> range between 4 and 1016s. By using the same register configuration as
>>> for the PCF2127/29, the 1/4Hz clock source is selected.
>>>
>>> Note: the PCF2127 datasheet gives a min/max range between 1 and 255s,
>>> but it should be between 2 and 254s, because the watchdog is triggered
>>> when the timer value reaches 1, not 0.
>>>
>>> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>> ---
>>>    drivers/rtc/rtc-pcf2127.c | 56 +++++++++++++++++++++++++++++++++------
>>>    1 file changed, 48 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
>>> index 11fbdab6bf01..3fd2fee4978b 100644
>>> --- a/drivers/rtc/rtc-pcf2127.c
>>> +++ b/drivers/rtc/rtc-pcf2127.c
>>> @@ -157,9 +157,29 @@
>>>
>>>    /* Watchdog timer value constants */
>>>    #define PCF2127_WD_VAL_STOP               0
>>> -#define PCF2127_WD_VAL_MIN         2
>>> -#define PCF2127_WD_VAL_MAX         255
>>> -#define PCF2127_WD_VAL_DEFAULT             60
>>> +#define PCF2127_WD_VAL_DEFAULT             60 /* In seconds. */
>>> +/* PCF2127/29 watchdog timer value constants */
>>> +#define PCF2127_WD_CLOCK_HZ_X1000  1000 /* 1Hz */
>>> +#define PCF2127_WD_MIN_HW_HEARTBEAT_MS     500
>>> +/* PCF2131 watchdog timer value constants */
>>> +#define PCF2131_WD_CLOCK_HZ_X1000  250  /* 1/4Hz */
>>> +#define PCF2131_WD_MIN_HW_HEARTBEAT_MS     4000
>>> +/*
>>> + * Compute watchdog period, t, in seconds, from the WATCHDG_TIM_VAL register
>>> + * value, n, and the clock frequency, f, in Hz.
>>> + *
>>> + * The PCF2127/29 datasheet gives t as:
>>> + *   t = n / f
>>> + * The PCF2131 datasheet gives t as:
>>> + *   t = (n - 1) / f
>>> + * For both variants, the watchdog is triggered when the WATCHDG_TIM_VAL reaches
>>> + * the value 1, and not zero. Consequently, the equation from the PCF2131
>>> + * datasheet seems to be the correct one for both variants.
>>> + */
>>> +#define WD_PERIOD_S(_n_, _f1000_) ((1000 * ((_n_) - 1)) / (_f1000_))
>>> +
>>> +/* Compute value of WATCHDG_TIM_VAL to obtain period t, in seconds. */
>>> +#define WD_COUNTER(_t_, _f1000_) ((((_t_) * (_f1000_)) / 1000) + 1)
>>>
>>>    /* Mask for currently enabled interrupts */
>>>    #define PCF2127_CTRL1_IRQ_MASK (PCF2127_BIT_CTRL1_TSF1)
>>> @@ -202,6 +222,11 @@ struct pcf21xx_config {
>>>      u8 reg_wd_val; /* Watchdog value register. */
>>>      u8 reg_clkout; /* Clkout register. */
>>>      u8 reg_reset;  /* Reset register if available. */
>>> +
>>> +   /* Watchdog configuration. */
>>> +   int wdd_clock_hz_x1000; /* Value in Hz multiplicated by 1000 */
>>> +   int wdd_min_hw_heartbeat_ms;
>>> +
>>>      unsigned int ts_count;
>>>      struct pcf21xx_ts_config ts[4];
>>>      struct attribute_group attribute_group;
>>> @@ -496,10 +521,19 @@ static int pcf2127_watchdog_init(struct device *dev, struct pcf2127 *pcf2127)
>>>      pcf2127->wdd.parent = dev;
>>>      pcf2127->wdd.info = &pcf2127_wdt_info;
>>>      pcf2127->wdd.ops = &pcf2127_watchdog_ops;
>>> -   pcf2127->wdd.min_timeout = PCF2127_WD_VAL_MIN;
>>> -   pcf2127->wdd.max_timeout = PCF2127_WD_VAL_MAX;
>>> -   pcf2127->wdd.timeout = PCF2127_WD_VAL_DEFAULT;
>>> -   pcf2127->wdd.min_hw_heartbeat_ms = 500;
>>> +
>>> +   pcf2127->wdd.min_timeout =
>>> +           WD_PERIOD_S(2, pcf2127->cfg->wdd_clock_hz_x1000);
>>> +   pcf2127->wdd.max_timeout =
>>> +           WD_PERIOD_S(255, pcf2127->cfg->wdd_clock_hz_x1000);
>>> +   pcf2127->wdd.timeout = WD_COUNTER(PCF2127_WD_VAL_DEFAULT,
>>> +                                     pcf2127->cfg->wdd_clock_hz_x1000);
>>> +
>>> +   dev_dbg(dev, "%s min = %ds\n", __func__, pcf2127->wdd.min_timeout);
>>> +   dev_dbg(dev, "%s max = %ds\n", __func__, pcf2127->wdd.max_timeout);
>>> +   dev_dbg(dev, "%s def = %d\n", __func__, pcf2127->wdd.timeout);
>>> +
>>> +   pcf2127->wdd.min_hw_heartbeat_ms = pcf2127->cfg->wdd_min_hw_heartbeat_ms;
>>>      pcf2127->wdd.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
>>>
>>>      watchdog_set_drvdata(&pcf2127->wdd, pcf2127);
>>> @@ -926,6 +960,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>>>              .reg_wd_ctl = PCF2127_REG_WD_CTL,
>>>              .reg_wd_val = PCF2127_REG_WD_VAL,
>>>              .reg_clkout = PCF2127_REG_CLKOUT,
>>> +           .wdd_clock_hz_x1000 = PCF2127_WD_CLOCK_HZ_X1000,
>>> +           .wdd_min_hw_heartbeat_ms = PCF2127_WD_MIN_HW_HEARTBEAT_MS,
>>>              .ts_count = 1,
>>>              .ts[0] = {
>>>                      .regs_base = PCF2127_REG_TS1_BASE,
>>> @@ -951,6 +987,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>>>              .reg_wd_ctl = PCF2127_REG_WD_CTL,
>>>              .reg_wd_val = PCF2127_REG_WD_VAL,
>>>              .reg_clkout = PCF2127_REG_CLKOUT,
>>> +           .wdd_clock_hz_x1000 = PCF2127_WD_CLOCK_HZ_X1000,
>>> +           .wdd_min_hw_heartbeat_ms = PCF2127_WD_MIN_HW_HEARTBEAT_MS,
>>>              .ts_count = 1,
>>>              .ts[0] = {
>>>                      .regs_base = PCF2127_REG_TS1_BASE,
>>> @@ -977,6 +1015,8 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>>>              .reg_wd_val = PCF2131_REG_WD_VAL,
>>>              .reg_clkout = PCF2131_REG_CLKOUT,
>>>              .reg_reset  = PCF2131_REG_SR_RESET,
>>> +           .wdd_clock_hz_x1000 = PCF2131_WD_CLOCK_HZ_X1000,
>>> +           .wdd_min_hw_heartbeat_ms = PCF2131_WD_MIN_HW_HEARTBEAT_MS,
>>>              .ts_count = 4,
>>>              .ts[0] = {
>>>                      .regs_base = PCF2131_REG_TS1_BASE,
>>> @@ -1215,7 +1255,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>>>
>>>      /*
>>>       * Watchdog timer enabled and reset pin /RST activated when timed out.
>>> -    * Select 1Hz clock source for watchdog timer.
>>> +    * Select 1Hz clock source for watchdog timer (1/4Hz for PCF2131).
>>>       * Note: Countdown timer disabled and not available.
>>>       * For pca2129, pcf2129 and pcf2131, only bit[7] is for Symbol WD_CD
>>>       * of register watchdg_tim_ctl. The bit[6] is labeled
>>
> 
> 
> --
> Hugo Villeneuve <hugo@hugovil.com>
