Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E826946D8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjBMNVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBMNV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:21:27 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B3EBDFB;
        Mon, 13 Feb 2023 05:21:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGh69TnyJbmv1K6M71ApwctX+PgRDvOHlJkviCwbz/fj+d1bnwLgv6pDOQ/a1UbrFmCZdKjE0ehmgv2xG+6YArL///tFvHjCfh6gafPbOo/CwfI42BDXLTigJvzd4RO/Or9ERA4pmk7OmNv32tha1KeyJV3X0k+E/cMLZD06Cvi/QrAJxjm/zQgS4s5WwPkcBv1OwtuZm4EZitCgTpBjOrX5xGf/REgGRUZpWZYX/E4trWJxY89PYKqRXRW15RdP9i32hgQ7ivJENAvpbAxEl0ofNYjSwgBDSFRdn5upIgQWDb2daI1WQfHcbA0C2toOjV47TOYpyNA4COTPHbBm6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UNfF0SwzDAgNIE4hkpIGuH2fji34h3X1mUSMNNIeeA=;
 b=fvYHyDtirX1RU83HUTawLVGdur1TNhKt9SHG8/KWP7Cxi9Uyf2+OUr8vsko752+VAt6kIwaKEWpQV6xnYr9trqx2mgEqePP5dn5uHszDk4G2n2Lfg9uxEpEmtbD27FEhhftf0cRfXXTKDI04Uh15AL/TW2SkIHHMRfifUlTjMlu40MZo5ssF0W5hWS5PVIV/WKA1z9FxuyIgBicp4dR7CYqsoj2VvFNMg6oefUlh+6BBlRDITYx5l+UI2rF3uAwn1lU9kT2mKZGtgC46r7kqBKvUjwvcQFeaMzTdXkFjyl4WGqNkX9UW2rlLIsRnIbhtfb7JGHfjffplpxe02R/D/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UNfF0SwzDAgNIE4hkpIGuH2fji34h3X1mUSMNNIeeA=;
 b=Qok8JM9pMi2knA1HVfOxqzzj3bYxeLctmUMazbtEUarYF7/4dXIKg8L5ve8m6naLXy9iL3T97c4LImyLWiBsg1ciRvzbexh18eEJdm44ppKpiro9aAGmxNZLFwpNRmADb4vynOONGampKSneWMHR0HwxtqTh5BkqJLEr7f7mcm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 13:21:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%5]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 13:21:20 +0000
Message-ID: <86db79fa-5efb-caad-3310-60928907cc58@amd.com>
Date:   Mon, 13 Feb 2023 07:20:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NH5xAx
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>
Cc:     mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Raul E Rangel <rrangel@chromium.org>
References: <20230210164636.628462-1-wse@tuxedocomputers.com>
 <Y+Z5OSa6hepQBOyc@smile.fi.intel.com>
 <029b8d80-db28-cdb2-5c39-334be6968fad@tuxedocomputers.com>
 <Y+owDqifuU9nf+1i@smile.fi.intel.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Y+owDqifuU9nf+1i@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0131.namprd11.prod.outlook.com
 (2603:10b6:806:131::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba8e356-4474-4199-e657-08db0dc53221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59Wi5MhXUXKav3nxBK2StxVI35w9VD2MgjmDebtCLAjyBC+hRerx4NzRglCCNw82R/NhWLgyKm6klJ6ZwF0G9COtrVjIwOA/trzry/i/kX15IBp0hShXnvjIc6CS3cAqVLJ3oj3NygmEqEpowe5IfETQ4qT0vRhlu86ewYq2LiPlu7VM9HuxlOp8cPE2bWcy07gf5FcXRdZ3AccX3ioXrGp+b7NLrT8djinJhUuNivN5DT0pLp+wsZZqSfi+ZaDt7XvKm7GwIeUlhTSh/IQ0ahAAycsy4mtIuOoIxcj+H1w9HF1JaLdGVQt3X8AxxOJgX2xW4gucGvgpPLs6EMjULp0NfPE1rTxd3pCEGZqOCCq9sqzIM3UuUDLPOAESdh+9QO8QMkWAprcMcWEaL0EHO1fb51VbqPta4XoB5bs4QBRW7dk5vDtzDVTVR5ZdSb5cdnPUzTS27SmEkTMgu4S2OC3ld/N+N4aMmA1zvOVXGRHr6tzKkwd6Zm1Ka0KoniWJKoEI3VwJh6+idqYeesaKp095p8u2rZpcIkQOt1N6ZBayQTH8gM730H+QnZSRgLKrNN2Z0EWTz756EtDRsoWuIkydB4vyoKiky9HYiIuYMR/MDrApyEB9uYIGnvIYSZZgUvBrqyFD5DZOlJQMynpu7TEpJbg1Wr7kyHwvQEO/XL4328hHTuMH8MV6zNXPU54XBfHtqtIBz7UtoarKPwwGURLWSNK+QGGJ9/MUxhGITY6c8aJYRWMgaig3VHyy2C8zh0PJ398zQtNMrlmKq2mex95JqQcjFwwCTprhQceXWZDGa7nIcHNBA4iebwV4ZuR/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199018)(44832011)(2906002)(36756003)(5660300002)(31696002)(83380400001)(186003)(2616005)(4326008)(38100700002)(8676002)(66946007)(316002)(54906003)(66476007)(66556008)(8936002)(41300700001)(478600001)(6666004)(6506007)(6512007)(53546011)(110136005)(86362001)(6486002)(966005)(31686004)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmVQMzd3ajgrbjM4OTRvOHNmNDRCYXk1clFRTEo0dTdlSjNxbWV3OXNOYUg5?=
 =?utf-8?B?TGZEbXk4U0FmVmYvMWNNWUs5QWxEYkV6WS8rT2M4WUsyZG1SYUQyOW1Nb2pV?=
 =?utf-8?B?M0p5dE4rak4vMXlXaU1TYk5OT0RCN1lwSndnSkJvNVhVVVBNWkVaRDBoejlj?=
 =?utf-8?B?TmFEdDBMRFdxaEtRYWt3elVsOWFXdTY5L0UySDQwQXhQOG9wT2FHSkVIclhx?=
 =?utf-8?B?enBwbkpNQ0hsTUhEVXUvOHNSUWI5ZytmcDJHcUZvYmJ0SkNrL1dEN3RzVzJz?=
 =?utf-8?B?eDM1cGJJUHNveUUyMmVyeG5HVXcydG13UmJxUWtlQ05MNXBDT0YrdUZrUGph?=
 =?utf-8?B?YXRobGFnS0xaNnFvaHVSeHc0RnhtNWNTVnp4TUwwY0pkblVlUmJIV1lkVk1T?=
 =?utf-8?B?c3RGS0cxZ296NHNVd0pLbW5JQVdicW1Kam4yWUwzUHc1SWtPZDNnWlBFaTM4?=
 =?utf-8?B?UjU5QnMwTkkvS1dQcEdZZEpWa2xlKy8vQUFtdXVOcmpwK2RQMnRPZVFOb2R1?=
 =?utf-8?B?TUs2WTI1TzEzVy84TEh0VWZiRVV6em1QeVZrM2pUcVVXNVVIYkFGRTFybGFT?=
 =?utf-8?B?TFI4aVlxUWptOEp4ZkJJRU9iQTRlWW5IcDExUUFRQjEzblFLbWw3MkVKb0kz?=
 =?utf-8?B?L3RJenZxOFlVY3B0RTJxSEtWL3NFNGVROEh6TVFHVEpBd2d1bUNsSzE5bFVx?=
 =?utf-8?B?enZmZi9qZHJNcFdxNDFnZkZBQUo2QXJJREppTGJvanNDQ25VdmlvcksyeUs3?=
 =?utf-8?B?bURualJjcmFzZVhzVkJ0QWNrdGQxbW05ZWo1RWljam4vODB5SEg5WlJIOVhi?=
 =?utf-8?B?LzZNempxYVl0blU1Wm53V3Bwcy80NnZ1OEhjcnF4MnA4TkFjS0RwRTVPK2FP?=
 =?utf-8?B?RjJwd1NIclBHeG5GZlpvRHlIYXV0ZmRSdktaYTgva2VKNnduYnE3SlNsSjdy?=
 =?utf-8?B?QXFLMk5wSmlYYnJnRG5rK0wvb1NHREdQMmREejYrNW4xY1JNYVFTTnBZVjJo?=
 =?utf-8?B?dGFwVDNXWnhqSXVBSVBEZ2R0VmpncDh0bUhnN1U4TVluNjZpOHRsendxRVFs?=
 =?utf-8?B?L1pPT00rcmtQbXpPbXdNWGtHWURaNjQxSTRkOXdIRWVaUVhyK0c5akZjdTIy?=
 =?utf-8?B?Zjc3Z1hNTXZ6U1BmSnVhcU41eWxhS2MvQ05jZTRGZ1dqdW1wcWhTQ1Npb1ly?=
 =?utf-8?B?T2ovZnFtQXVEaDJ3VlhrN3hUYjRFOW54aE54ZzcyQ2p3UW5qeko3STVENEd6?=
 =?utf-8?B?MGNFUm03Y2luS1Rza0tKbkg2UWs0Qlg5aHU0VjJtbEZsNUJUbHM0TGR4OGFT?=
 =?utf-8?B?aXVROXBseDk5Si9JekRCUU1wSXd0bnFTY2hTZ2FtS0RUNHZJeVNGaGprWlVW?=
 =?utf-8?B?RWM4dW1PSXpUVy9oYXhHRGY0U1RpSUlldlo5TDFjSTR0MTljbWZqWURCOE14?=
 =?utf-8?B?bGxaZDhpRkZQcmRqTkVGaStJWmFiNERBQ0UrUGVtWXlXL053TDZ3Z3FaMmlF?=
 =?utf-8?B?STR4MTNPV0tvWE5ldWlUdnFZd3d6Wk42YUNLRlc0VHVRZTlEOUFmd3F3TThB?=
 =?utf-8?B?Tm9qRk5HNlVZWjNNczBxelNOQ292OWFqZkd3czVhaDNnbXFueGVhbFUxYlFv?=
 =?utf-8?B?UGlSc0tad29wcFZJYWdzd2lacGxwWXdVZ29CUzJWQS96WWM3Q1h5d3hGbWM1?=
 =?utf-8?B?cHdnWFBCWmdiVDFKdlp6SCs1TjNWbmo0ZjlhcklpV3Z6R2hsL2Y0YnUzQXpq?=
 =?utf-8?B?V1gzYm9jLzZWYlY3U2Z6V1pPaEZNeW5CUzJDZll6eFdQVCtNYzVuRG1GbEUw?=
 =?utf-8?B?NHM3ZzlidS9mYmk0SU5mZ2dpanJMcVJwQVViTFVsUWl2VlJtTG1yc1RjTXVB?=
 =?utf-8?B?T0F0WW9XQU1oUWVBcUJuWjNOdmdRdXFRcFJtWXEzOEVWbEZoQ3BCdFZ4VXAz?=
 =?utf-8?B?S000SFA3eE9QbHNZRGt0MzhxazRoYTUycHNrd2JjcmxhMytvL2Jib2hEYkZ4?=
 =?utf-8?B?V3R6b1hoYlYrb3NHMVA3bTN6QXNDVE1Cem4vN2V4aXcvdWFVeEpFanJ6bTBl?=
 =?utf-8?B?V0R3V2Z1bWNlRWlOTEdlZlU4S3BXeXhoaGtsVnR5UUlCM2lSclZsRlA4NENs?=
 =?utf-8?B?TThTTitpVy95VmFCME9xSkhZSjdKODBkeWZNa2pRS0FtTjIyVDZtQ29tQld5?=
 =?utf-8?Q?Oeu2NgZ2qMUAVxpQ+4VVuKygbVamJLqibhsxh4D4fN26?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba8e356-4474-4199-e657-08db0dc53221
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 13:21:20.5108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAIew2ckjrXoBUjpjzYxrJMIgT1L5FaSeWAp0+lUyoJmiidnzNsGYmpadjEzDrXK+2y2ohjodfylf24+o4i8bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/13/23 06:41, Andy Shevchenko wrote:
> On Mon, Feb 13, 2023 at 12:30:08PM +0100, Werner Sembach wrote:
>> Am 10.02.23 um 18:04 schrieb Andy Shevchenko:
>>> On Fri, Feb 10, 2023 at 05:46:36PM +0100, Werner Sembach wrote:
>>>> commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
>>>> changed the policy such that I2C touchpads may be able to wake up the
>>>> system by default if the system is configured as such.
>>>>
>>>> However on Clevo NH5xAx/TUXEDO XA15 Gen10 there is a mistake in the ACPI
>>>> tables that the TP_ATTN# signal connected to GPIO 10 is configured as
>>>> ActiveLow and level triggered but connected to a pull up.
>>> I'm not sure I understand the issue here. From what you say here it seems
>>> correct ACPI description.
>> TBH I copied the commit description from https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4cb786180dfb5258ff3111181b5e4ecb1d4a297b
>> which is for a different device having the exact same problem.
> Yeah, and I reviewed that and seems paid no attention to this detail.
>
> So, ActiveLow + PullUp is the _right_ thing to do in ACPI.
> The problem seems somewhere else.
>
> Mario, can we have an access to the schematics of the affected pin to
> understand better what's going on?
>
> Or is that description missing some crucial detail?

The schematics were shared by the reporter for the original issue which 
is how we reached the conclusion there was a mistake.

As they're both Clevo designs it's certainly possible they have the same 
mistake in two systems.

>>>> As soon as the
>>>> system suspends the touchpad loses power and then the system wakes up.
>>>>
>>>> To avoid this problem, introduce a quirk for this model that will prevent
>>>> the wakeup capability for being set for GPIO 10.
>>> I'm not against fixing this, but wouldn't be better to actually target the root
>>> cause and have a different quirk? Or is it me who didn't get what is the root
>>> cause?
>>>
>> I missed to reference the original discussion while copying the description:
>> https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1720627 (Note that
>> it's a somewhat convoluted issue spanning multiple bugs when you scroll up
>> from that particular linked comment, which are however irrelevant for this
>> patch)
>>
>> I'm not deep into how ACPI defined IRQ work so maybe not a good idea for me
>> summing it up, as I might have misunderstood parts of it ^^
> The GpioIo() and GpioInt() resources have gaps in them, due to this some
> additional information is required or some heuristics is used to deduct
> the settings.
>
> All this is described in
> https://www.kernel.org/doc/html/latest/firmware-guide/acpi/gpio-properties.html
>
>> I added the other ones from there to the cc.
> Thank you.
>
