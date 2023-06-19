Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BD0735D97
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 20:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjFSSxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 14:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjFSSxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:53:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395B2130;
        Mon, 19 Jun 2023 11:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U43+8+msyJYQvLn/LdvWsONzl2e4LRK9Ow7saxx93qxolQLp2cBUlbqvbO4j1SgyyT5gvMgzH917E+7AXL7O8qMDoPsTytp1Ke5jBg7cu68X+Soc9SOZp8Q6kI1C22QpWFxECOgzSN5Iup7W3BWajk020IcH42cd6cCxc1R+ONW2+45d8IQ/4cIq97bts/4c4Uh5ELSRYrNe+OBC57wElc5QzbEJnxy0+zWnoLRl3ZyqrqlZe14YAzOs9XD2Jb6CCsxOWPtnRIoz22HgSZh4xQtc7kkpsi4vzkPbhPy/rN7n46U5MBfx1hWo6sR217Mqt8jOXOSrbGEJdJouQczrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grqqoij28na5AclMhy9ZuuhCK17aJOchFFnzWNY0p8Y=;
 b=gOLEUVEavSpu5WLdCoMxsV0bOjllqYDcHWnfKCruVk9p/Tbi0TTAXNH57DeUWWjH7zxYh3Lt1ucsnzDp+mlwCGMmWe+ZF0BhYol+c6tE645JEcvXjJ6IilkWNDWfnmLYpcQnctT3PqfQBjdZVcrpv6BO5gG+AriHZjK22rKRlGXjd20MPQZejN+1OHjFuOoCM9POOxXxEFYT6UpUiUtjauFGeIyv16tZNalV1Wk5+AY+vdKbQ5HferYF4VP+C+Qxo/9uoPx0prAbatIU1LBRF+oOmvN9dW2eqUXlLgRJoxRKISOwvaCUG3m/R+GIC6kXxOHixmuYJavvyVfWrkp6Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grqqoij28na5AclMhy9ZuuhCK17aJOchFFnzWNY0p8Y=;
 b=0L7ZgHkIwYV1saoJSagN3x9SLT4PcatkBc7w0n1b82wpEjH5VaOARY1nM7UZVOiVVzOxY7qMiQ/LGs2XUATy6FaaaoiVsrK8WsvUxTrW+3By1oXjMvp6/wIqK/QUNkPses/Yi9eRC82jbPOd49LIajiWmdrYGAVu7WRKtIprGo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4880.namprd12.prod.outlook.com (2603:10b6:5:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 18:53:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 18:53:08 +0000
Message-ID: <a8107f7d-3163-4f03-9f17-82e1a93d8e91@amd.com>
Date:   Mon, 19 Jun 2023 13:53:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3] hwmon: (k10temp) Enable AMD3255 Proc to show negative
 temperature
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Baskaran Kannan <Baski.Kannan@amd.com>, babu.moger@amd.com,
        clemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230619165413.806450-1-Baski.Kannan@amd.com>
 <4585ec62-b7bb-9f2a-eee0-07032648e55a@roeck-us.net>
 <012ea369-52ec-4a7a-ec66-812690d430ad@amd.com>
 <598247ee-3ff8-8413-274a-7d313c2af324@roeck-us.net>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <598247ee-3ff8-8413-274a-7d313c2af324@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0113.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4880:EE_
X-MS-Office365-Filtering-Correlation-Id: c420a1e0-b05a-477c-b402-08db70f66c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfnZyD0FF2kjCFQ0LUF2dmgERQ+me4OYZKRB/EnT8HM9lnFfP+vRnUoMx0XB0IUDqd+w6AiJ4ltimYOrOYG4faYKEbCHwQHQuO/LcGhcIfv13Q94eXpL0oBG++9PxGn8FEJT4hpE3AiMF82EicHa+noGfLzVSj2RqtYYgQMHy5g2TVAbVP5SR7lQI6xaSlxel4UxjMAn1ytZsB+zrZbmzy3qzBpRwFdoKdbJXb8GPgRIH1TA6Jlai1b8jVNZfOE/9+XzUysOUdUevzNuTpbGiivzeMQFZ/GyL4UQxG/ZPAEg2jF8/3cQErz1PZFL9lwqrf90EAMKL3mbT3SPLIBk3wXWfKZEVP5TU4/HWAX63uIRgxnpUd1ZRUo+HuE25g+0MEGLlM2AVdy0IUktKzqRAL1uiU9W2EYWple8Yk9W8ZbFqBImezd6rDb3M6pMoEYRLedWZvprAGIpPYZyczizTDIEJEbdVaZwp6OEu8Phu5OkCpK7BBvOOl4Vv8/2LWRYHeWdam59SREUptuxAxWoVyl0X+Ur8d1ERBkf24/1xFAfCkpEff6FvsTaAOGEeJq5GVJ2n5QwDvrIuKkBi/FzCJqshP1BtLiYSypyHh+esJHt1eL7A9nCI0xe8XtC0941IafC/xLsDHZ31y/oH9IIqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(186003)(26005)(6512007)(53546011)(6506007)(2616005)(83380400001)(38100700002)(478600001)(6666004)(41300700001)(66556008)(66476007)(31686004)(66946007)(36756003)(8676002)(316002)(110136005)(8936002)(6486002)(31696002)(86362001)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzczS0Q0U0YxZ2JYcTR0WndKMVZ0N3pQOHFyNFY3MjEvRThwSFB5Slo5RXQ5?=
 =?utf-8?B?Y01hbEQ0dVkySHQ2Q1Fwb2ZvQkNMZFdRdnJvVWVtT2dYdWxjYS9jenF2bEVF?=
 =?utf-8?B?dTI0N3c3YW0wZ1pEZmNYaElTdloySlVEaHBoN2NjNGVOeWRORjJwS04wUmlE?=
 =?utf-8?B?ZGFFaGs2YXhjUGtzZmpoK3VsWDZmRUt0T3lvWSsyc1ZSZjcrbHZmUFJOWnYr?=
 =?utf-8?B?T1R5S2ZtWmhuNVNXdkNhL2wybjRtYXc3RFJWbE5icGdSc0FOTjA5Yi9JVzM0?=
 =?utf-8?B?WG1VN0EyYmV0TEdsMWRTYTBhSWVZbUpFUDRsNEZTYnJqWlJpV2I3U0o1RmVo?=
 =?utf-8?B?eWJxTWZDZkU0VGNVVmN6NzlqSnVSRFVhV1ozWXRLYWVoQzJLYTNtcENMVXFy?=
 =?utf-8?B?TWRwZDZERWR3YXNRNDdYWlZpVWh5YXlDQThjcUhlZ0UxNytYa05XcWFsLzUr?=
 =?utf-8?B?Q3hGOHByQ2lTR3BCRkVUaVlmVGZzbWQvSEl4WU5QQVdTYkxtTzQrZ09VN3l6?=
 =?utf-8?B?ZTQ0Nnp1WjNscHJzN1l5UTFXcnNmSG1nOEIwbFVSVjQ1NmNJaitkRFdzN0hp?=
 =?utf-8?B?VjhvVDRIU2pwdGZOU3gzam1KSkhSQks1N3dLOXNTVzIzdU9oTUNjRTFzRDJm?=
 =?utf-8?B?dDJQTmpzb3Y4aldLUVc4RkFGMkRJYkFlT2ZVSjdhTmVBdE1YV0dZTExKOURD?=
 =?utf-8?B?cnBlc1dZaVR5ZUhRYS9WWnZEbThMWkNvV3ZEWlFqNFlSTGpUUnhTTk1MNlJw?=
 =?utf-8?B?L1ZYUFNtcGYxazg5TnNYbktmcFQ1aElmbEdJL2xxeUU3cjVYajVzRFlrbkc5?=
 =?utf-8?B?clhaOFNzbWRtR3Nzb1Y0bHhDek9IcTYwVEVxTThxdE02QWdHRkVnYkN1TTFu?=
 =?utf-8?B?QmtMUTJCUlVsVjY1VFU0cHVvNDUrWGNJZStOanB6bXlkdWpXN2YvL3pJMjli?=
 =?utf-8?B?dUh2QmsvV1pTUnMvd3QxbWxURmJ5WHdiUGo4bnl5UU5IYU1nam9NRUlwZkR3?=
 =?utf-8?B?ZUc1MFhNTVM3NFBSU1F2QWorZmo4bUR5a2dLZHJjUVVSbUJOTk4rOGovdWN2?=
 =?utf-8?B?eTdrNEdtZm03cW5EQjd0aUh3bURCSTJLaWpmcGgzc0V1M1ZmRHFKakRIYkFH?=
 =?utf-8?B?RjFFc3oyZlRIdVhLTGZFSkRCUEg1NUtnK0VianZqakVZK1pSVU9lZ2p5dnlW?=
 =?utf-8?B?YXNmdll5bG9qVzRWQXZaS1FmTDQ5cmdaalBhZmRVQ3BwcGJaQmtGNlI1T21T?=
 =?utf-8?B?RmpFN0xwcWJGYUs3ZDhCdVhQL1dxZzdzOEhZa3A3cHRtWVlxVWxWVnpnbm4y?=
 =?utf-8?B?TkxRaXpSUHlWazI1UDBDN0drZWQ3SUxLRE93Vzl1VmluS2ptd21NREZuN29U?=
 =?utf-8?B?dGc5SWlMeDFaVTdaUmpoRnBJTXJralQ0cXBqbEEwZmhuVXp3OXNRczVjZktm?=
 =?utf-8?B?VkRsaHF4eUswWTBqVE9EempmVjhGNGRmR0ZyZ0RSM3J4ZEMzMk9ERzRlZ3JT?=
 =?utf-8?B?QmdaQURCaDZHRFBWa1dwVzRVTktlNklKeTM1SDV5NklWU3NnMVBLeHIyb1c0?=
 =?utf-8?B?dkRKZHJEZ1BFU1A5NGxpbHJqam9PZHI0TEVFVUJlbDRPeDNwQ2dYbGtkSnFk?=
 =?utf-8?B?eVF3aXJOYnkwSDZwR1NiNHAxdjA1Ums3dnFOZnZVMU9GTnp3RzZLOXlYU2hG?=
 =?utf-8?B?UXcyUTJiZlZGYWpud0FzaXR4c25RUlNnQnJ6ZFo4dnpxbldMZlhIb0NLWFRE?=
 =?utf-8?B?VGpQRHpBazRUQmlQWTlkQ0ROTUdVbDNmVWluMk5Pc2tKNGoyN3JRZGU3Tlo5?=
 =?utf-8?B?N2dON1N3akRRSGdwNFEzNFJpQVBxUXkyRXFLMG1tSGM5WTZQRENUMnBEck9Z?=
 =?utf-8?B?KzdMZGt2Z3RHVDBTSlhtZmFLQWJqVVlVQnVrU2NKTE9lMDBXMUFVSUpJWlgr?=
 =?utf-8?B?eFpmNEhUZDh3REFValBKMkY0VXR1UXE2a0M1Sy9oOHpWOTEvN3lHVGZNYlZJ?=
 =?utf-8?B?bWN0ZHZEd25DaEF0b0tOM3NrVHU2ek9ZSUVxdk90TnVtcEc1MUVJQmtTUU4z?=
 =?utf-8?B?K282Wk5Ncyt4cVNBclBwVm9QM3dGWkd6OG9LTXNham9lb2craDVFTjJSbEhH?=
 =?utf-8?Q?qqmbUDP2XpCXDPZ249LGqn7aI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c420a1e0-b05a-477c-b402-08db70f66c28
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 18:53:08.3174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9m/HQVORapQlJUDxITGhkUD5lmJ/zCGKRphup5edDXhh8a6Ro3lchgDYVU3L24jiFSEBkN7Jo0PuQQSyQpVAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4880
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/19/2023 1:40 PM, Guenter Roeck wrote:
> On 6/19/23 11:02, Limonciello, Mario wrote:
>>
>> On 6/19/2023 12:07 PM, Guenter Roeck wrote:
>>> On 6/19/23 09:54, Baskaran Kannan wrote:
>>>> Industrial processor i3255 supports temperatures -40 deg celcius
>>>> to 105 deg Celcius. The current implementation of k10temp_read_temp
>>>> rounds off any negative
>>>> temperatures to '0'. To fix this, the following changes have been 
>>>> made.
>>>> Added a flag 'disp_negative' to struct k10temp_data to support
>>>> AMD i3255 processors. Flag 'disp_negative' is set if 3255 processor
>>>> is found during k10temp_probe.  Flag 'disp_negative' is used to 
>>>> determine
>>>> whether to round off negative temperatures to '0' in 
>>>> k10temp_read_temp.
>>>>
>>>> Signed-off-by: Baskaran Kannan <Baski.Kannan@amd.com>
>>>
>>> Now you have made changes you were not asked to make, extended the flag
>>> to cover a range of processors instead of just i3255, and did not 
>>> provide
>>> a change log nor a comment in the code describing why processors with
>>> certain model numbers should display negative temperatures.
>>>
>> i3255 happens to be one of the industrial processors in family 17h 
>> models
>> 01h through 08h.  These are potentially used at subzero temperatures and
>> so displaying negative numbers makes a lot sense.
>>
>> So I think the commit message needs to be be amended to better 
>> explain that.
>>
>> I guided Kannan against leaving a comment in the code with specific 
>> models
>> because it either won't age well as other industrial processors are
>> introduced or may need to be ping-ponged each time.
>>
> That only applies if there is a guarantee that the check does not
> inadvertently ends up displaying negative temperatures for other CPUs
> which are misconfigured. After all, the current code is just a hack
> working around some problem with bad temperatures reported on other CPUs.
> Personally I'd rather have a clean fix for that. If/since that is not
> available, whatever is done subsequently (including the code suggested 
> here)
> is just a hack.
>
> ... and if a hack on top of a hack is introduced, we need to make sure 
> that
> it does not undo the previous hack.
>
>> But perhaps it should be more generic like:
>>
>> /* Industrial processors may be used at sub zero temperatures */
>>
>
> You can not just display negative temperatures for family 0x17h models
> 0x00..0x07 without explanation. The above needs to be documented.
> I fail to understand why a variant of
>
> "i3255 happens to be one of the industrial processors in family 17h 
> models
>  01h through 08h.  These are potentially used at subzero temperatures and
>  so displaying negative numbers makes a lot sense."
>
> can not be added as comment and description if that is exactly what 
> the code
> checks for. Something like
>
> "Family 17h models 01h through 08h are industrial processors with an 
> operational
>  temperature of -40°C - 105°C and may be used at subzero temperatures.
>  Display negative temperatures for those processors."
>
> makes perfect sense to me. Only of course it is incorrect ...
>
> Model 0x1 was used for the original Zen, and 0x8 is Zen+. 1950X is 
> family 0x17 model
> 0x01 per cpuinfo, meaning your hack undoes the original hack, and the bad
> temperatures would again be displayed for the affected systems. That 
> is simply
> unacceptable.
I just double checked the documentation and you're correct.
To target just the industrial ones it would need to be > 0x00 and <= 
0x08 ALONG with
checking the model_id_str value against the industrial ones.
>
> Yes, it may be a pain to find an acceptable hack to solve the problem,
> but after all this is a self-inflicted problem, so it can't be helped.
> The alternative would always be to find a better means to identify CPUs
> affected by the original problem. If that is not possible, explicitly 
> listing CPUs
> which are _not_ affected is the only possible alternative.
So Pinnacle Ridge and Summit Ridge (Zen/Zen+) have model_id_str values 
of 'B1' and 'B2'.
I think we should be able to detect those and only avoid showing the 
negative values when:

* Family 17h
* Model > 0x00
* Model <= 0x0f
* Model ID str B1 or B2

>
> Note that the code sets disp_negative for model numbers < 0x8, meaning it
> does not include model 0x8. It also sets disp_negative for model 0x00 
> which is
> specifically excluded above.
>
> All that is no excuse for not providing change logs.
Appreciate your being thorough.
>
> Guenter
>
>>> Guenter
>>>
>>>> ---
>>>>   drivers/hwmon/k10temp.c | 8 ++++++--
>>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
>>>> index 7b177b9fbb09..2613420d43ff 100644
>>>> --- a/drivers/hwmon/k10temp.c
>>>> +++ b/drivers/hwmon/k10temp.c
>>>> @@ -86,6 +86,7 @@ struct k10temp_data {
>>>>       u32 show_temp;
>>>>       bool is_zen;
>>>>       u32 ccd_offset;
>>>> +    bool disp_negative;
>>>>   };
>>>>     #define TCTL_BIT    0
>>>> @@ -204,12 +205,12 @@ static int k10temp_read_temp(struct device 
>>>> *dev, u32 attr, int channel,
>>>>           switch (channel) {
>>>>           case 0:        /* Tctl */
>>>>               *val = get_raw_temp(data);
>>>> -            if (*val < 0)
>>>> +            if (*val < 0 && !data->disp_negative)
>>>>                   *val = 0;
>>>>               break;
>>>>           case 1:        /* Tdie */
>>>>               *val = get_raw_temp(data) - data->temp_offset;
>>>> -            if (*val < 0)
>>>> +            if (*val < 0 && !data->disp_negative)
>>>>                   *val = 0;
>>>>               break;
>>>>           case 2 ... 13:        /* Tccd{1-12} */
>>>> @@ -405,6 +406,9 @@ static int k10temp_probe(struct pci_dev *pdev, 
>>>> const struct pci_device_id *id)
>>>>       data->pdev = pdev;
>>>>       data->show_temp |= BIT(TCTL_BIT);    /* Always show Tctl */
>>>>   +    if (boot_cpu_data.x86 == 0x17 && boot_cpu_data.x86_model < 0x8)
>>>> +        data->disp_negative = true;
>>>> +
>>>>       if (boot_cpu_data.x86 == 0x15 &&
>>>>           ((boot_cpu_data.x86_model & 0xf0) == 0x60 ||
>>>>            (boot_cpu_data.x86_model & 0xf0) == 0x70)) {
>>>
>
