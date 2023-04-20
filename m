Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8516E9D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjDTUtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 16:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjDTUtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:49:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20719.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::719])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D2610B;
        Thu, 20 Apr 2023 13:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDs6zJkhPX1sy0QsaNicNcl/1tGJKmiG63VO9z3EkxuqNLRCGiHf4gc5l9FW3NRV9bDJKDy/YPcuBgSTmeLqHY2u/IpLN7RFCFXhsvJs93wNzI7ybXs8QKo90ZHoVw7GxxenVH3KHvoEPwSXza+HKmHLjgFMdaBXR384IxtGT84pZthqxGwhPBKN6Oc8aimNKymGuO+ryneS9+DHDw4nwjqzbl0/JY4d5h37z8/f133vaKy0SOlczTjFOjz8b3IpV3DMVdp/EJGm7oJ5s5fy8Rx1Vh3Ls9YUy/omSGXLuBDagcmMO0716D+JdLOoXT6dewGMOYASpejGuJw2EwS73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6aE0jiuGjCOv+9Ouh90tabdQTbRM2Gy33BMSNmz6v4=;
 b=bn6aG5JsMlXHoEih7vCLszUYYAHQutFdYrZzOOJkpSuaalLztMM3iJxMReBjSbF69oBe8QkLYtto/oGBjCf1vxNJyOZ7v8XRwxEag8FqbR2/0RNT6B57jFX2bOB1O6BZ5fY7MCIwInVAGc1cFVlLGRLJeYkwKMYSDiEpJSk0yyjpEAUcRBM8XIW7UmGYf1bbvw4pqC3Z/ixkJpdPeY3mG7G6iApN+F5jqkYJWJ1HftiRswPrwSLer97YYlq/A9vEWXWYsVhD7c2ANrDJ2MHx31AlGVB2lCZ4ar3Ov3QH5d8Q24a99xZJ3UdQaB7MJpoCf79/drlnwExh/N5zbvzQFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6aE0jiuGjCOv+9Ouh90tabdQTbRM2Gy33BMSNmz6v4=;
 b=fRXNYcVussvaCm4cpL2ffv3Yq7pUnFRGTwncbB0LxAVxJ+bA5Mr+/WN5tP2moHyOF20MP33L4h0H7CI/DKsXkGbhyNQbltdXR2YeBkwlw+YMQTaCv6Ums17XNVd7HYppq6p/EDVscYo64Fg5xcZgdOnyUdJGFSvyCuzEnXI5hqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7027.prod.exchangelabs.com (2603:10b6:208:35a::9) by
 SA0PR01MB6218.prod.exchangelabs.com (2603:10b6:806:d8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.11; Thu, 20 Apr 2023 20:49:30 +0000
Received: from BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::6df9:7381:4788:cc3a]) by BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::6df9:7381:4788:cc3a%5]) with mapi id 15.20.6340.011; Thu, 20 Apr 2023
 20:49:29 +0000
Message-ID: <f0fd057e-95cb-4a85-00fc-9eb25ef7b9b3@os.amperecomputing.com>
Date:   Thu, 20 Apr 2023 13:49:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid
 high error
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>
Cc:     viresh.kumar@linaro.org, scott@os.amperecomputing.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20230328193846.8757-1-yang@os.amperecomputing.com>
 <CAJZ5v0gQ7vak9DaEmLKe6un60Gcpj7VtmxdjPwuXTi=P=KJjbA@mail.gmail.com>
 <d08222bf-fa05-3e3b-18dd-d24ced6c1536@os.amperecomputing.com>
 <4bda6b02-cc50-fa47-c9b6-acda4cf201a8@arm.com>
 <cd79df5b-68c4-4825-6c29-e560989a1130@os.amperecomputing.com>
 <195c95b2-f47c-f3d0-5663-97dd4c929ea4@arm.com>
 <3e239024-91d8-ea06-25a4-631496576319@os.amperecomputing.com>
 <d287eff6-77bd-693c-96d3-87d8981b7f96@arm.com>
 <7b57e680-0ba3-0b8b-851e-7cc369050386@os.amperecomputing.com>
 <a2924821-80b9-e68f-3ae4-7a2c989afc88@arm.com>
 <1ce09fd7-0c1d-fc46-ce12-01b25fbd4afd@os.amperecomputing.com>
 <cc32f950-ea78-87cb-e708-6d42d1e58cc8@arm.com>
From:   Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <cc32f950-ea78-87cb-e708-6d42d1e58cc8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:610:b2::28) To BL3PR01MB7027.prod.exchangelabs.com
 (2603:10b6:208:35a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7027:EE_|SA0PR01MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: eeeb5a36-d248-4180-e3bf-08db41e0bc6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwddvB9TeXbEIu6iQicondN9iEjqEKrWpGjIHvE+y4kT0VY1n4liNpnYgFRwnNa7eEXeBTwzgUG3DwW9g7dtBawcyfH8aNmghyUQvmdnZupwAWIyGn0ZoD4lPWD1SgP91aXqSdeGDh0XR7EriHL0/c+ixVv/8izbJZ8AGgMjwpU2nDEoxp9/XrmK/hippdV61tLbn5krMjIRnTKh4WhjqEV7G7Bx0LfTo4V8/plRAfZXSCN4JuqVUIYl1f4xSPGNgdPcP8R/S6w63UyYp1MpyzwSHdfkPleoEATipRdq/+WetmXYAF2d5JtLfZGAkGFZyJYTTAUjdLgt4fiRjpRiosG1jB9tt8k1rqkn02bXBpg3Ounu36KJYh9Fpjaa3dSRbDujU0TwFDMZGb/ZLQRQVepf/XZkIPYAvZRarj97wPaaWi072VqBEdE5cLro2KJvklGtYSu+sOjVZcSPCeVsjIDT4uvsnZeFC5kbZFIK3w6Wm46W4JFZN9LmTWNOSjbn3V65SY04NXEbdzHoUX1P5X6IAx7sYBWinGZ122AA1Tt1cPxn56WGYImaWmbItpLtEFO5Kvx/IOK8VLPNC+XSFy+qaJehq6sSgxob+7GVwhMVKAx+TDCER7Ah/afU4Nd2Fn063JHobztNQV1sz9NZgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7027.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(366004)(376002)(346002)(396003)(451199021)(110136005)(52116002)(186003)(6666004)(6486002)(966005)(86362001)(6506007)(6512007)(53546011)(26005)(31686004)(2616005)(478600001)(4326008)(66556008)(66946007)(66476007)(83380400001)(316002)(38350700002)(38100700002)(8676002)(8936002)(2906002)(66899021)(30864003)(41300700001)(5660300002)(31696002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjRCd0Z4RGJ3ZUlLcTdGV29yTFMrNFg4dEh5NWVQc0VpWGRZaWZXUTR2SGd2?=
 =?utf-8?B?bjF0SW05cEpkOVk3cmJHVExGNnh2emZ3TElEVTdWd3NRZFA4QkVVenJlT3BY?=
 =?utf-8?B?UW91QkF0OUh5OHhBeUJsL3dCQUt4c3RvLy9PTW5xeXhORzZYai9qQkk1aklK?=
 =?utf-8?B?NWJ3cTVGZ1RVZCtnQWZiK1R2SEVoTDQ2NjJuMWJUQU5DOThRRExKNko0T3FJ?=
 =?utf-8?B?SmpoZCtsUm96cFhaa2c4dkJ6MFkxTDRkMmg4eGF4cVJ6UE9pdmtnRy9WU0hl?=
 =?utf-8?B?OU93SHN0ekdyOXFNUkpGbEhhdFBidVMxUXc2emNRaWVuUEtZOHREU2VnRHZh?=
 =?utf-8?B?VS9LT1VGNWd6QldUNDZCUWtNdzlrUndsN1JMVkFvVkNHdVB3OFJ3SXhWNVhs?=
 =?utf-8?B?TjBVSTQyZVNoVVpzVENyL0Q2cW5TTEVRMW83VkxjWEpIZ1NSa205WDBESVdG?=
 =?utf-8?B?TVM1ZmRGd09zK3ViRWNTazJxdTQ1MnU5MVRtN2tyZmtQUnd5dksvenVkVHE3?=
 =?utf-8?B?TUNDQW9uc3JNRVhpeW5QMCtOYlpISkVWdzJ6dU1ndTc3SVMxQ0hrYTFoYU42?=
 =?utf-8?B?UUhHdnVObjQzVTFYMGhkOEQ3Z3BSWE91U21WVS9ibTNRVGVERXBLWXhvdFgw?=
 =?utf-8?B?N3J6bllDNXcyQVpHd3NtM0N6ODk4ZWY4RkJBL2RWVXdsR0J3K1VIUUtqVkZp?=
 =?utf-8?B?eVAxWGswVllOc2puNFZzczFIaXRlcktMNzl5S2trMkdjdWRtZnk2OHF6Ump3?=
 =?utf-8?B?YnBXNnRkT3FDeHFHbmJDek04b09VY2dzTlVFYlJZcGs2MXB1UGpJakVRbVp5?=
 =?utf-8?B?N1JOTVJzRDM0cmIrSzNPYS9WSnNsUVBYbXNGYVVFSTBZa01uamRiejVyT2Iw?=
 =?utf-8?B?enBmMTdmL2JoOFFkem5rbmg4VGsyamtvUkdzZmh4TDdwQ0ROVXJDSnhDNWxT?=
 =?utf-8?B?UU01UkQzSlRJa0VSK003NWErOE9LVDViZ21DYjcwcUd1OWFLeWJNV1F3T0lR?=
 =?utf-8?B?c1oxNkd2UUlsUHozNFV6eFVxQ2VyWU9seDVBSFhoSlZiZ1NWQkxmbFNuckdE?=
 =?utf-8?B?QklRWTBmMFVrdEpQQWozTXYweUM3VDYxY3lKZ2g4RnVwMXlpalRHdXM2ZkhG?=
 =?utf-8?B?L0pVREJ4Q0plVkNCR3hGSWJ3ditoVDZpa01wRjNwbmV0alQrL3NnYTR1VUww?=
 =?utf-8?B?Mk9JRXVYODhvTi9ubFhXa0NKdlV4V3VFa091WmE2OUFiNnZOVXc5RHZLckUy?=
 =?utf-8?B?MDBiWE11d2d3MjNUUnlLaytaUlNFTk9RdzlGU1k2RmNZeFZLOHFUY3laeW9Y?=
 =?utf-8?B?Qk9nQXljNDNQY25URXBxN0Y1Um5pcnpFY01KUkhtbTNqWFMyVlVTQnVsSDJY?=
 =?utf-8?B?NkhJZG5Na2hBSzJZTENjVVROM0cvWUdJOURTcnFsUnZTOWxMWVFxWjNhaUtX?=
 =?utf-8?B?YVpzd2M3TTlIbnJMVUEzNlJ0YXpEYUkra0pJZ0dDUDlMQTEwck9GT0I4d3VD?=
 =?utf-8?B?Uk5FTURJUjhFRGhiaFVvNFZvdTVEYmhuVnhBcG1pNTZ3MzFseEFLVXpsSWc5?=
 =?utf-8?B?aGNMMERxUEQxTnFMNm5hMkJoK0RSK3l0bVFQNlUwTlp5dGtjUlo2amZDWEFh?=
 =?utf-8?B?bUo5c0Q5YTBMcTBOeU1rZzhWVVBtUTQwZmFnTW1PK1k2M21wdDdzdVJycTZC?=
 =?utf-8?B?b0RYeVk5SnZqQlcyeHh4MzFpS1ovRjl4SWRjWC9ucitEOHRrSysxRXpqNXFI?=
 =?utf-8?B?cEJQZFMwLzRqV3NMTldyMkFqSXkyODlJeEF4WkpiTXE3UTVFMjhTVWhCZXN4?=
 =?utf-8?B?MExlcmlYNkw5cnlzMDVwU1cwckJhVCtGWUVUV1NmbUF1ZXA4Rkg2cVdrMm1Z?=
 =?utf-8?B?NUVXQ2lZU0Q2K0FYREJOTTJCSCszeld6ZW1ZQW5OeEpjYTNUVTEwYmtPYU5I?=
 =?utf-8?B?L0VNZzRsU2lCVHhrTCttWk5ETGZoMUFnaURNTVYvN1FOMCtpbWtDNitvdi9F?=
 =?utf-8?B?U1BkL2dEUWY3dGhZL0hySkhQaURZV0Mya09oajJnYWxrdm1NdnRZZGt4WkU5?=
 =?utf-8?B?V2d0T1pUZFRVOE5OeHpPZjhXUEEyaCt4ZmJGeE5hZ1ZaanR0L3BJSE1TQkR3?=
 =?utf-8?B?d1hqL2FZbXJldThYK3YrNlhKeTdkODZpdGVmVW1IbDZibVU5TXVtUktwWTR1?=
 =?utf-8?Q?1M8iB8Q6F6xcE5f5IHL6d5I=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeeb5a36-d248-4180-e3bf-08db41e0bc6f
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7027.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 20:49:29.6107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJj+o8xo90Ys1UkGox0zrKpz57T6wE67oERVXVi6FdULbEL1msEuU0T9vE8dkFlHl+/dlfEJj19PKBmozAjauI8ZUllU9NGDJsabGX2thjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6218
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/23 9:01 AM, Pierre Gondois wrote:
>
>>>
>>> You say that the cause of this is a congestion in the interconnect. I
>>> don't
>>> see a way to check that right now.
>>> However your trace is on the CPU0, so maybe all the other cores were
>>> shutdown
>>> in your test. If this is the case, do you think a congestion could
>>> happen with
>>> only one CPU ?
>>
>> No, other CPUs were not shut down in my test. I just ran "yes" on all
>> cores except CPU 0, then ran the reading freq script. Since all other
>> cores are busy, so the script should be always running on CPU 0.
>>
>> Since the counters, memory and other devices are on the interconnect, so
>> the congestion may be caused by plenty of factors IIUC.
>
> +Ionela
>
> Ionela pointed me to the following patch-set, which seems realated:
> https://lore.kernel.org/all/20230418113459.12860-5-sumitg@nvidia.com/

Thanks for the information. I think we do have the similar syndrome. But 
I'm not sure how their counters are implemented, we may not have similar 
root cause.

>
> One thing that we didn't check I believe is and that Ionela pointed out
> is that we don't know whether we are accessing the present CPU or a 
> remote
> CPU'AMUs. In the latter case there would be IPIs and possible delays in
> waking up/accessing the remote CPU).
>
>>
>>>
>>> Just 2 other comments:
>>> a-
>>> It might be interesting to change the order in which cpc registers are
>>> read
>>> just to see if it has an impact, but even if it has, I m not sure how
>>> this
>>> could be exploitable.
>>> Just in case, I mean doing that, but I think that b. might be better
>>> to try.
>>>
>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>> index c51d3ccb4cca..479b55006020 100644
>>> --- a/drivers/acpi/cppc_acpi.c
>>> +++ b/drivers/acpi/cppc_acpi.c
>>> @@ -1350,8 +1350,8 @@ int cppc_get_perf_ctrs(int cpunum, struct
>>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>>                  }
>>>          }
>>>
>>> -       cpc_read(cpunum, delivered_reg, &delivered);
>>>          cpc_read(cpunum, reference_reg, &reference);
>>> +       cpc_read(cpunum, delivered_reg, &delivered);
>>>          cpc_read(cpunum, ref_perf_reg, &ref_perf);
>>>
>>>          /*
>>>
>>> b-
>>> In the trace that you shared, the cpc_read() calls in the fist
>>> cppc_get_perf_ctrs() calls seem to always take a bit more time than in
>>> the
>>> second cppc_get_perf_ctrs() call.
>>> Would it be possible to collect traces similar as above with 3 or 4
>>> calls to
>>> cppc_get_perf_ctrs() instead of 2 ? It would allow to check whether in
>>> the first
>>> call, accessing the cpc registers takes more time than in the
>>> following calls,
>>> due to cache misses or other reasons.
>>
>> Cache miss? The counters should be not cached and reading the counters
>> should not hit cache IIUC.
>
> Yes you are correct, what I said is copmletely wrong.
>
>>
>>> Ideally statistics on the result would be the best, or if you have a
>>> trace.dat
>>> to share containing a trace with multiple cppc_cpufreq_get_rate() 
>>> calls.
>>
>> Tried option b, I managed to get histogram:
>>
>> @hist_first_ns[cat]:
>> [4K, 8K)          112321
>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>> [8K, 16K)            212
>> |                                                    |
>> [16K, 32K)            25
>> |                                                    |
>> [32K, 64K)            59
>> |                                                    |
>> [64K, 128K)            6
>> |                                                    |
>> [128K, 256K)           9
>> |                                                    |
>>
>> @hist_second_ns[cat]:
>> [2K, 4K)          112590
>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>> [4K, 8K)               4
>> |                                                    |
>> [8K, 16K)              0
>> |                                                    |
>> [16K, 32K)            15
>> |                                                    |
>> [32K, 64K)            18
>> |                                                    |
>> [64K, 128K)            1
>> |                                                    |
>> [128K, 256K)           4
>> |                                                    |
>>
>> The "first" means the first cppc_get_perf_ctrs() call. But the bpftrace
>> script can't tell the second, the third and the fourth, so all them are
>> shown as "second". Anyway it seems fine. We can tell the first read took
>> longer than the later ones for the most time.
>>
>> And a typical func_graph trace shows:
>>
>> # tracer: function_graph
>> #
>> #     TIME        CPU  DURATION                  FUNCTION CALLS
>> #      |          |     |   |                     |   |   | |
>>    4447.171333 |     0)               |  cppc_cpufreq_get_rate
>> [cppc_cpufreq]() {
>>    4447.171334 |     0)               |    cpufreq_cpu_get() {
>>    4447.171334 |     0)   1.060 us    | _raw_read_lock_irqsave();
>>    4447.171336 |     0)   0.560 us    | _raw_read_unlock_irqrestore();
>>    4447.171337 |     0)   3.480 us    | }
>>    4447.171338 |     0)   0.400 us    | cpufreq_cpu_put();
>>    4447.171338 |     0)               |    cppc_get_perf_ctrs() {
>>    4447.171339 |     0)   0.720 us    | cpc_read.isra.0();
>>    4447.171341 |     0)   0.700 us    | cpc_read.isra.0();
>>    4447.171342 |     0)   0.380 us    | cpc_read.isra.0();
>>    4447.171342 |     0)   0.600 us    | cpc_read.isra.0();
>>    4447.171343 |     0)   4.900 us    | }
>>    4447.171344 |     0)               |    __delay() {
>>    4447.171344 |     0)   0.540 us    | arch_timer_evtstrm_available();
>>    4447.171346 |     0)   2.420 us    | }
>>    4447.171347 |     0)               |    cppc_get_perf_ctrs() {
>>    4447.171347 |     0)   0.540 us    | cpc_read.isra.0();
>>    4447.171348 |     0)   0.520 us    | cpc_read.isra.0();
>>    4447.171349 |     0)   0.400 us    | cpc_read.isra.0();
>>    4447.171350 |     0)   0.440 us    | cpc_read.isra.0();
>>    4447.171350 |     0)   3.660 us    | }
>>    4447.171351 |     0)               |    __delay() {
>>    4447.171351 |     0)   0.400 us    | arch_timer_evtstrm_available();
>>    4447.171353 |     0)   2.400 us    | }
>>    4447.171353 |     0)               |    cppc_get_perf_ctrs() {
>>    4447.171354 |     0)   0.540 us    | cpc_read.isra.0();
>>    4447.171355 |     0)   0.540 us    | cpc_read.isra.0();
>>    4447.171356 |     0)   0.380 us    | cpc_read.isra.0();
>>    4447.171356 |     0)   0.420 us    | cpc_read.isra.0();
>>    4447.171357 |     0)   3.640 us    | }
>>    4447.171357 |     0)               |    __delay() {
>>    4447.171358 |     0)   0.380 us    | arch_timer_evtstrm_available();
>>    4447.171360 |     0)   2.380 us    |    }
>>    4447.171360 |     0)               |    cppc_get_perf_ctrs() {
>>    4447.171361 |     0)   0.520 us    |      cpc_read.isra.0();
>>    4447.171361 |     0)   0.520 us    |      cpc_read.isra.0();
>>    4447.171362 |     0)   0.400 us    |      cpc_read.isra.0();
>>    4447.171363 |     0)   0.440 us    |      cpc_read.isra.0();
>>    4447.171364 |     0)   3.640 us    |    }
>>    4447.171364 |     0)   0.520 us    | cppc_cpufreq_perf_to_khz
>> [cppc_cpufreq]();
>>    4447.171365 |     0) + 34.240 us   |  }
>>
>> It also shows the first reading typically took longer than the later
>> ones. The second, the third and the fourth actually took almost same 
>> time.
>>
>> I also tried to read perf_fb_ctrs_t0 twice (so total 3 reads, 2 for t0,
>> 1 for t1, 2us delay between each read), but I didn't see noticeable
>> improvement. 4 reads (2 for t0, 2 for t1) does show some noticeable
>> improvement.
>>
>
> Thanks for the new data.
>
>>>
>>> Example of code where we do 4 calls to cppc_get_perf_ctrs():
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c
>>> b/drivers/cpufreq/cppc_cpufreq.c
>>> index 022e3555407c..6370f2f0bdad 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -853,6 +853,20 @@ static unsigned int
>>> cppc_cpufreq_get_rate(unsigned int cpu)
>>>
>>>          udelay(2); /* 2usec delay between sampling */
>>>
>>> +       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       udelay(2); /* 2usec delay between sampling */
>>> +
>>> +       /* Do a third call. */
>>> +       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       udelay(2); /* 2usec delay between sampling */
>>> +
>>> +       /* Do a fourth call. */
>>>          ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>>          if (ret)
>>>                  return ret;
>>>
>>>>
>>>> The above trace data shows some cpc reading took a little bit longer
>>>> than usual. I suspected it was caused by interconnect congestion.
>>>>
>>>>
>>>> So it looks like IRQ is the major contributing factor of high error
>>>> (4xxxxxx KHz), interconnect congestion is the major contributing 
>>>> factor
>>>> of low error (3xxxxxx KHz).
>>>>
>>>> So I did the below test:
>>>> 1. Disable IRQ: The high errors were gone (> 3700000KHz), but low 
>>>> errors
>>>> were still seen.
>>>> 2.10us delay: The high errors were still seen.
>>>> 3. Disable IRQ + 10us delay: all the errors were gone.
>>>>
>>>> I think the test result also supports the tracing data.
>>>>
>>>>
>>>> I also got some confusion about calling cppc_cpufreq_get_rate() 
>>>> with irq
>>>> disabled. Rafael thought 10ms delay is too long because the 
>>>> function may
>>>> be called with irq disabled. But a deeper look at the function 
>>>> shows it
>>>> should *NOT* be called with irq disabled at all.
>>>>
>>>> First, if pcc channel is used, cpc reading may take over 100ms, it is
>>>> way larger the proposed 10ms delay.
>>>> Second, reading from cpc channel needs to take a semaphore, so it may
>>>> sleep. But sleep with IRQ disabled is not allowed.
>>>
>>> Yes right, however the semaphore is not taken in between the 
>>> sequence of
>>> cpc_read() calls in cppc_get_perf_ctrs(). So maybe the change below
>>> should
>>> be acceptable:
>>
>> Yeah, we should be able to find a smaller irq disable section.
>>
>>>
>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>> index c51d3ccb4cca..105a7e2ffffa 100644
>>> --- a/drivers/acpi/cppc_acpi.c
>>> +++ b/drivers/acpi/cppc_acpi.c
>>> @@ -1315,6 +1315,7 @@ int cppc_get_perf_ctrs(int cpunum, struct
>>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>>          struct cppc_pcc_data *pcc_ss_data = NULL;
>>>          u64 delivered, reference, ref_perf, ctr_wrap_time;
>>>          int ret = 0, regs_in_pcc = 0;
>>> +       unsigned long flags;
>>>
>>>          if (!cpc_desc) {
>>>                  pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>>> @@ -1350,10 +1351,14 @@ int cppc_get_perf_ctrs(int cpunum, struct
>>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>>                  }
>>>          }
>>>
>>> +       local_irq_save(flags);
>>> +
>>>          cpc_read(cpunum, delivered_reg, &delivered);
>>>          cpc_read(cpunum, reference_reg, &reference);
>>>          cpc_read(cpunum, ref_perf_reg, &ref_perf);
>>>
>>> +       local_irq_restore(flags);
>>> +
>>
>> cpc_read_ffh() would return -EPERM if irq is disabled.
>>
>> So, the irq disabling must happen for mmio only in cpc_read(), for 
>> example:
>
> I thought the issue was that irqs could happen in between cpc_read() 
> functions,
> the patch below would not cover it. If the frequency is more accurate
> with this patch, I think I don't understand something.

Yeah, you are correct. The irq disabling window has to cover all the 
cpc_read(). I didn't test with this patch. My test was done conceptually 
with:

disable irq
cppc_get_perf_ctrs(t0)
udelay(2)
cppc_get_perf_ctrs(t1)
enable irq

But this will break cpc_read_ffh().

>
> (asking for more information)
> Just to check, the core/perf counters are AMUs and the other CPPC 
> registers
> are mmio right ? Is it possible to know the CPPC registers that are
> implemented on your platform ?

AFAIK, the perf counters are implemented by AMU and accessed via mmio, 
the other CPPC registers are implemented by PCC.

> Also is it possible which platform you are using ?

Ampere One

>
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index c51d3ccb4cca..f3c92d844074 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -982,6 +982,7 @@ static int cpc_read(int cpu, struct
>> cpc_register_resource *reg_res, u64 *val)
>>           void __iomem *vaddr = NULL;
>>           int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>>           struct cpc_reg *reg = &reg_res->cpc_entry.reg;
>> +       unsigned long flags;
>>
>>           if (reg_res->type == ACPI_TYPE_INTEGER) {
>>                   *val = reg_res->cpc_entry.int_value;
>> @@ -1015,6 +1016,7 @@ static int cpc_read(int cpu, struct
>> cpc_register_resource *reg_res, u64 *val)
>>                   return
>> acpi_os_read_memory((acpi_physical_address)reg->address,
>>                                   val, reg->bit_width);
>>
>> +       local_irq_save(flags);
>>           switch (reg->bit_width) {
>>           case 8:
>>                   *val = readb_relaxed(vaddr);
>> @@ -1029,10 +1031,12 @@ static int cpc_read(int cpu, struct
>> cpc_register_resource *reg_res, u64 *val)
>>                   *val = readq_relaxed(vaddr);
>>                   break;
>>           default:
>> +               local_irq_restore(flags);
>>                   pr_debug("Error: Cannot read %u bit width from PCC for
>> ss: %d\n",
>>                            reg->bit_width, pcc_ss_id);
>>                   return -EFAULT;
>>           }
>> +       local_irq_restore(flags);
>>
>>           return 0;
>>    }
>>
>>>          /*
>>>           * Per spec, if ctr_wrap_time optional register is
>>> unsupported, then the
>>>           * performance counters are assumed to never wrap during the
>>> lifetime of
>>>
>>>> Third, if the counters are implemented by AMU, cpc_read_ffh() needs to
>>>> send IPI so it requires IRQ enabled.
>>>
>>> If I'm not mistaken, the CPU calling cpc_read_ffh() might have IRQs
>>> disabled,
>>> it should not prevent it to send IPIs no ?
>>
>> It can't work with irq disabled. The comment in counters_read_on_cpu()
>> says "Abort call on counterless CPU or when interrupts are disabled -
>> can lead to deadlock in smp sync call."
>>
>>
>> And it just returns -EPERM and raise a warning if irq is disabled.
>
> Ok right,
>
> Regards,
> Piere

