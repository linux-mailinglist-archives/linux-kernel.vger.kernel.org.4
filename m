Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BE46EEBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbjDZBdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239075AbjDZBdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:33:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2115.outbound.protection.outlook.com [40.107.220.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D1816F1A;
        Tue, 25 Apr 2023 18:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UldPrLt623sO5m/gugfDw2uGVdcE7Ib+hXbIwY34jpdjmRe4Ophfz2beqNLO8lb7fMtxiGOjPGDw8YGXrMtX0Qj9kmfv9U7mEyzRB/BC0bm0Y9EswlWyhp2h9ZfD/JUqQX3Re+2yQJJAhu/zwZxlu7KBUp/NV8BKmyksQk1vu2D0h9ywGnvH20IlA6Y48ATkaAh2ZTr9EeEkxBSGYjhAv1j6pKJTRfZUTRNIu9fhYG1ZW+gBvCA/q5l2RAZyP9jMDtbQ8wanJz0rFRuWE1V7wYfF4VJ/j72PXXoCIcSYP1guKZtliCQ6QAG6njbA2EHXkjft1J4Waa73HlHInBOThw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zll4pc/rQ1rrm+04OOI9twQiIMjKnW7YjQJTBuTA0yk=;
 b=VbBgvMhqZDzeSaPq5ATiDzmMo6PjKUayl5Y/cL3fsHKDO5/DALMTVyHl+vHOdm42qwrll/ecr8c7zXSkIWYzWLraCe9PXOaMgTXW2FRgKD8VoqkqwENI9AUgM68ZdKnUL9fAjy2iXczMBE67IRPhamOn4Y2C1V6F3sgQk+OMfRTbQUKNVsfjc64MaTb0vtoCcJSAq0hY0i0tK/tpb1fidcfdU9gcRLkRXZ0x46qqIvmUrHKMkQbEWiSdZvThQEn3V/89nxcOGoVubzqWSTUd+0tv9rq8lZA57Rxp0RJISMSYb+nLhP/z5la90tpL54aej3tQjFYqIsMixDs2DWT5QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zll4pc/rQ1rrm+04OOI9twQiIMjKnW7YjQJTBuTA0yk=;
 b=bUkXHx8bz0BqK2rT1xiSbCnM/zY+7DpB+5vcYKoyIyveGZNjQdid3P8XvtXfdIWcJxNEoARfBlI5hkUzk5R7yPqtXQpAPRmvtfbgt9WZlgOE56CkmEdDrUc75H+DS16z+cQ+2gSQqL90dR6jlFgDtOYY0YNbz1dgSRy6ijBP06A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7027.prod.exchangelabs.com (2603:10b6:208:35a::9) by
 BYAPR01MB3958.prod.exchangelabs.com (2603:10b6:a02:91::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.19; Wed, 26 Apr 2023 01:33:00 +0000
Received: from BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::6df9:7381:4788:cc3a]) by BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::6df9:7381:4788:cc3a%5]) with mapi id 15.20.6340.020; Wed, 26 Apr 2023
 01:32:59 +0000
Message-ID: <06ca8066-fce6-d3cf-db37-584c3666f7df@os.amperecomputing.com>
Date:   Tue, 25 Apr 2023 18:32:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
From:   Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid
 high error
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>, viresh.kumar@linaro.org,
        scott@os.amperecomputing.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <4bda6b02-cc50-fa47-c9b6-acda4cf201a8@arm.com>
 <cd79df5b-68c4-4825-6c29-e560989a1130@os.amperecomputing.com>
 <195c95b2-f47c-f3d0-5663-97dd4c929ea4@arm.com>
 <3e239024-91d8-ea06-25a4-631496576319@os.amperecomputing.com>
 <d287eff6-77bd-693c-96d3-87d8981b7f96@arm.com>
 <7b57e680-0ba3-0b8b-851e-7cc369050386@os.amperecomputing.com>
 <a2924821-80b9-e68f-3ae4-7a2c989afc88@arm.com>
 <1ce09fd7-0c1d-fc46-ce12-01b25fbd4afd@os.amperecomputing.com>
 <cc32f950-ea78-87cb-e708-6d42d1e58cc8@arm.com>
 <f0fd057e-95cb-4a85-00fc-9eb25ef7b9b3@os.amperecomputing.com>
 <ZEZrnWUc2y0w9yY8@arm.com>
Content-Language: en-US
In-Reply-To: <ZEZrnWUc2y0w9yY8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::26) To BL3PR01MB7027.prod.exchangelabs.com
 (2603:10b6:208:35a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7027:EE_|BYAPR01MB3958:EE_
X-MS-Office365-Filtering-Correlation-Id: db064acc-b4eb-424b-d980-08db45f62b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVIsqV5YCxlAmQ1ZKR0qGkUhOkHJWnfhtIH0VADd9+Rxw9YSMP2SXANqyjx2jih58OyRAGA9CNm2T8/uZB//Els615RYOgyYWdTB08wtPrvzhYKMKmrh/RCClnaXwukCBIH1U+riRUrc1WWEUOCh4Wp3bud3ODMHFFSWas/H3tc0Vxfh2DfsaDQ+n7nXL7QqzS43vBRyZ8c8GZ544WqMu8+2rvMlgGfLG6OFgpQgvmZcaV3+cwWjYg/5zHaUsGt66Kgnl6uI4jChrhWEGRR/8uJ30UOYP5HZLmmhZ/8Gh8lcx5640KtFofAHCFOdKIrBRPTWos+trj4GhFC497cQjrmmdTYrscK8I13mD8vuOLRcfhBt27jRiijnaqVkkWZSqivwIFNs+SLc0yW+AvmSqB5Z2RDUcC0hJnoULz/wa2EJmtzi8gpCAv1MfrJA6M81jGDk1HOv4F5syVabIhnJPDn+s1AM+pyN+DzEZFyQu06AbxMYz0OamZjM+ykw/K1XUT4DUHwdBN/RU5ClwlWqtPlkZuL10MNQIBWrScYqa2Ud7nT9B09DxKMd96FDZPhxiCKKEi39O4Ge7+F/HseCndAll35LcIq3TELm3ZKoWHcHXaOpiAJnoZ0G7sSYJBqpCWG8Bzw6fwKnQ69vX/tjdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7027.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(396003)(366004)(376002)(346002)(451199021)(52116002)(53546011)(26005)(6506007)(6512007)(8676002)(8936002)(316002)(6916009)(4326008)(54906003)(66946007)(66476007)(66556008)(6486002)(41300700001)(478600001)(966005)(6666004)(5660300002)(38350700002)(38100700002)(31686004)(86362001)(2906002)(30864003)(2616005)(66899021)(31696002)(186003)(83380400001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWo5SVdpYU1LNlV1RHRaUHVJaTJwcytuTSs1WHNIUjRzcUJmQ3JpcmhVenRm?=
 =?utf-8?B?clZjWFlVOEwzODhlQTErK2QyK1JZbCtWcEZnRHYwcVo5WWs2WlBaZU1RWFpq?=
 =?utf-8?B?dWpUdzFDY2tNYkJ6SUVYcG5UUm5EVUZjRnVFRmZFajBNNnVlVEhiUENqQVZ6?=
 =?utf-8?B?Sjh6KzBzSDhpTTJUNDU5b0k4UWJ3SCt6bkxRaWZwZVpLTSs1M3U0QmU0Y2VL?=
 =?utf-8?B?ekV3b3dyd1IrNXQ2MlZvS1ZXTW5YK3hEWGF4OHNLT3BnTUJmOXhsaGNwdGNx?=
 =?utf-8?B?UGxNc2VTNkFBNXFqRERTd2RGOEl3eElMMW10ajZ1QTNpWUl2WTdFT2hwZlpL?=
 =?utf-8?B?NjRNTkRzZ2JHaTlzVDByV0pxSWtpbnVucElud0p3ZkZiY0l5K2pHSzgxanBM?=
 =?utf-8?B?VlZ5TFgxeTRpcEJqMmp3VGN1ZXVKTGJjRkY3SmVybzNLS0JXQ2krcjlmeEtE?=
 =?utf-8?B?RzNKcFlPekFDWDhZT0s2bFo1aHJsY0R0NkplZXVkYXBMQ1BsVHVaRlBYZVdP?=
 =?utf-8?B?T2NXT3ZWRzRkYmxBM3dKRFBLNit6OHpEb3ZPWVQ1VWNmc09rUVZPSWFFNllU?=
 =?utf-8?B?OC9wM0tpSkNmQXVTUm5OSTYwSzkyNWRvVUVydHhMcHh4S3RlWUZRU3htNDE2?=
 =?utf-8?B?U251MWtzb01QTG9CRXVLYkE3M3RPVUZpN3BpMU9CNkZsRXM0YXpNRFY4dnQ0?=
 =?utf-8?B?SGRiaU5yQjZtWEZyZGlML0FlWXFUV2N5S0FqY1VPbENIOXFtWnc1V0NQTTJV?=
 =?utf-8?B?VkdZNFZOSFh2c2ZJWXFXMWhKTzUwWjgvSmtJd1NRaUhCYTBWaDMxMjAvMWdq?=
 =?utf-8?B?MlBzNmt5K1JMVThEczRWc1pmbmZNTzZIRU53eTVHUlBRcTQxVUFWa1NpWkdP?=
 =?utf-8?B?SHAyL0lieXF4UEdvT3FrOWxxSlN2V0NRMXFadTY4bnFWUCtMZktmcVhIRVVD?=
 =?utf-8?B?WGtNZVd2dENETy9UcHN5L2k5ZWdQckJCcUFHaWdGQ2ViVG9Xamh4dytSUFRB?=
 =?utf-8?B?WWZYWHBwU1lnbDhRSHpWTFRac0J6Wk1sMlh3bjF0a2tkN0JldCtMWHQzWHFG?=
 =?utf-8?B?VTJ1R3NkQW1SNW1vSVpxdjZkZms0L1U4VWNCVW44QVlKOHN5K0t5d0h3WVpX?=
 =?utf-8?B?dEJRWjFRODdrK1NEckNubGdmRFBuMVFneERpTjdMZ1RuTjZ4T3I2M1Z0c3d2?=
 =?utf-8?B?ZStoc1hQL3VXRHFWSGFYNWlGTVFBT2FvSDlJUmxJWXNTY2lrdC9rN0I2OU10?=
 =?utf-8?B?aHFlaHQ4ajY3eG1xYlY1V1B6N2h3blhVS3NQNHl0aGtucXpLdVVRVU9kaGcz?=
 =?utf-8?B?blRWT0VNOEQxK2tVcHpHQ1lPMnBLeUZ2UEpBcFUzdXNXZmpNTi9SUHZ6KytO?=
 =?utf-8?B?RTdsVkRhWXJQcHdkS3VlLzRwaERUVzQ3SmZ6TmhRWmRLWU5wZHB1NU1IdHJt?=
 =?utf-8?B?dWE0M3B5TVVKZk5EWXR2dFlrelQwT2dtaVpmZUJPTUdPVzdLNnc2a0svb3Er?=
 =?utf-8?B?VXVyNDRvc1B5WWpYU0pWZVU0Tmt0d1o0bzlNNk45bzcyZ1ZWRVRWdjlHYmRH?=
 =?utf-8?B?bU1UanhJeVIvNW1MZmd3cWNVOHBZNnJmalNDUkJnNUJEMnQ4Zkd4MVpEcVR3?=
 =?utf-8?B?Nm9yTVpCRlBjeWFUbnBWM0svOWQ4WGhBU3gvRUJRVlUyYUN1UFRkZDdPTmdh?=
 =?utf-8?B?VktnZ2lnK3dxc2pQV3FXRno2eTliU01IUElKWnZVbzlHZjBHaGpVOVJNSXRw?=
 =?utf-8?B?Z05xMEZiMW9LOFFnMVB0RDl6eS9yS1ltYnIvb3JEVHpqNzU2ekdWQWIrZG9a?=
 =?utf-8?B?UG90MkNteFNPQ3VvRXdRelBPNU5qYzRqQ052RG11UmY2blU5Nkh0eGM4dW5W?=
 =?utf-8?B?cjBqekl6bW5SSlZuYUZsSEFBb05kMzRJMTJlL3RaUlVJYXB5QU9QVmsvUjVQ?=
 =?utf-8?B?THFLMDVENHhWY0gzSEZkNGU5b1JNMmpZWmY1eWlRc3U5MXZHMGFjMndydU9L?=
 =?utf-8?B?TFlNZk0yaWZST01BWklISDhNWFVhQWFXWU5tVXR0azVwdHd4M2k4OGhzM3Jv?=
 =?utf-8?B?Q2xxUDU4SUFYL2tRODRsVTcvYjcxeEFvNWsrRE1DY3ZGemozTmFQRmp2Yld5?=
 =?utf-8?B?TTgwYlpaTnJIc0JrUE0yZ293Tjc4MGdpWjlqV3B5Tkl2ZW1SbVRyNUQvMlVp?=
 =?utf-8?Q?Zw5JqQzMOBjugqBGA1Sf+J4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db064acc-b4eb-424b-d980-08db45f62b44
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7027.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 01:32:59.5284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9ZG9n7YfYDg7dLvFYXJ2aNaLMRa/NAad/4ZTxfK3BEZ+jJ2kGvltOl4YJ4P6iQNM5r79d+wrr9osvf3w31GvFZwvnU+xFJO9On2W1yG0q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB3958
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/23 4:44 AM, Ionela Voinescu wrote:
> Hey,
>
> On Thursday 20 Apr 2023 at 13:49:24 (-0700), Yang Shi wrote:
>> On 4/20/23 9:01 AM, Pierre Gondois wrote:
>>>>> You say that the cause of this is a congestion in the interconnect. I
>>>>> don't
>>>>> see a way to check that right now.
>>>>> However your trace is on the CPU0, so maybe all the other cores were
>>>>> shutdown
>>>>> in your test. If this is the case, do you think a congestion could
>>>>> happen with
>>>>> only one CPU ?
>>>> No, other CPUs were not shut down in my test. I just ran "yes" on all
>>>> cores except CPU 0, then ran the reading freq script. Since all other
>>>> cores are busy, so the script should be always running on CPU 0.
>>>>
>>>> Since the counters, memory and other devices are on the interconnect, so
>>>> the congestion may be caused by plenty of factors IIUC.
>>> +Ionela
>>>
>>> Ionela pointed me to the following patch-set, which seems realated:
>>> https://lore.kernel.org/all/20230418113459.12860-5-sumitg@nvidia.com/
>> Thanks for the information. I think we do have the similar syndrome. But I'm
>> not sure how their counters are implemented, we may not have similar root
>> cause.
> Yes, my bad, I did not get the chance to read this full thread before
> talking with Pierre. In your case you have AMUs accessed via MMIO and in that
> case they are accessed though FFH (IPIs and system registers). The root
> cause is indeed different.

Yeah, but it seems like using larger delay could mitigate both issues.

>>> One thing that we didn't check I believe is and that Ionela pointed out
>>> is that we don't know whether we are accessing the present CPU or a
>>> remote
>>> CPU'AMUs. In the latter case there would be IPIs and possible delays in
>>> waking up/accessing the remote CPU).
>>>
>>>>> Just 2 other comments:
>>>>> a-
>>>>> It might be interesting to change the order in which cpc registers are
>>>>> read
>>>>> just to see if it has an impact, but even if it has, I m not sure how
>>>>> this
>>>>> could be exploitable.
>>>>> Just in case, I mean doing that, but I think that b. might be better
>>>>> to try.
>>>>>
>>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>>> index c51d3ccb4cca..479b55006020 100644
>>>>> --- a/drivers/acpi/cppc_acpi.c
>>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>>> @@ -1350,8 +1350,8 @@ int cppc_get_perf_ctrs(int cpunum, struct
>>>>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>>>>                   }
>>>>>           }
>>>>>
>>>>> -       cpc_read(cpunum, delivered_reg, &delivered);
>>>>>           cpc_read(cpunum, reference_reg, &reference);
>>>>> +       cpc_read(cpunum, delivered_reg, &delivered);
>>>>>           cpc_read(cpunum, ref_perf_reg, &ref_perf);
>>>>>
>>>>>           /*
>>>>>
>>>>> b-
>>>>> In the trace that you shared, the cpc_read() calls in the fist
>>>>> cppc_get_perf_ctrs() calls seem to always take a bit more time than in
>>>>> the
>>>>> second cppc_get_perf_ctrs() call.
>>>>> Would it be possible to collect traces similar as above with 3 or 4
>>>>> calls to
>>>>> cppc_get_perf_ctrs() instead of 2 ? It would allow to check whether in
>>>>> the first
>>>>> call, accessing the cpc registers takes more time than in the
>>>>> following calls,
>>>>> due to cache misses or other reasons.
>>>> Cache miss? The counters should be not cached and reading the counters
>>>> should not hit cache IIUC.
>>> Yes you are correct, what I said is copmletely wrong.
>>>
>>>>> Ideally statistics on the result would be the best, or if you have a
>>>>> trace.dat
>>>>> to share containing a trace with multiple
>>>>> cppc_cpufreq_get_rate() calls.
>>>> Tried option b, I managed to get histogram:
>>>>
>>>> @hist_first_ns[cat]:
>>>> [4K, 8K)          112321
>>>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>>>> [8K, 16K)            212
>>>> |                                                    |
>>>> [16K, 32K)            25
>>>> |                                                    |
>>>> [32K, 64K)            59
>>>> |                                                    |
>>>> [64K, 128K)            6
>>>> |                                                    |
>>>> [128K, 256K)           9
>>>> |                                                    |
>>>>
>>>> @hist_second_ns[cat]:
>>>> [2K, 4K)          112590
>>>> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>>>> [4K, 8K)               4
>>>> |                                                    |
>>>> [8K, 16K)              0
>>>> |                                                    |
>>>> [16K, 32K)            15
>>>> |                                                    |
>>>> [32K, 64K)            18
>>>> |                                                    |
>>>> [64K, 128K)            1
>>>> |                                                    |
>>>> [128K, 256K)           4
>>>> |                                                    |
>>>>
>>>> The "first" means the first cppc_get_perf_ctrs() call. But the bpftrace
>>>> script can't tell the second, the third and the fourth, so all them are
>>>> shown as "second". Anyway it seems fine. We can tell the first read took
>>>> longer than the later ones for the most time.
>>>>
>>>> And a typical func_graph trace shows:
>>>>
>>>> # tracer: function_graph
>>>> #
>>>> #     TIME        CPU  DURATION                  FUNCTION CALLS
>>>> #      |          |     |   |                     |   |   | |
>>>>     4447.171333 |     0)               |  cppc_cpufreq_get_rate
>>>> [cppc_cpufreq]() {
>>>>     4447.171334 |     0)               |    cpufreq_cpu_get() {
>>>>     4447.171334 |     0)   1.060 us    | _raw_read_lock_irqsave();
>>>>     4447.171336 |     0)   0.560 us    | _raw_read_unlock_irqrestore();
>>>>     4447.171337 |     0)   3.480 us    | }
>>>>     4447.171338 |     0)   0.400 us    | cpufreq_cpu_put();
>>>>     4447.171338 |     0)               |    cppc_get_perf_ctrs() {
>>>>     4447.171339 |     0)   0.720 us    | cpc_read.isra.0();
>>>>     4447.171341 |     0)   0.700 us    | cpc_read.isra.0();
>>>>     4447.171342 |     0)   0.380 us    | cpc_read.isra.0();
>>>>     4447.171342 |     0)   0.600 us    | cpc_read.isra.0();
>>>>     4447.171343 |     0)   4.900 us    | }
>>>>     4447.171344 |     0)               |    __delay() {
>>>>     4447.171344 |     0)   0.540 us    | arch_timer_evtstrm_available();
>>>>     4447.171346 |     0)   2.420 us    | }
>>>>     4447.171347 |     0)               |    cppc_get_perf_ctrs() {
>>>>     4447.171347 |     0)   0.540 us    | cpc_read.isra.0();
>>>>     4447.171348 |     0)   0.520 us    | cpc_read.isra.0();
>>>>     4447.171349 |     0)   0.400 us    | cpc_read.isra.0();
>>>>     4447.171350 |     0)   0.440 us    | cpc_read.isra.0();
>>>>     4447.171350 |     0)   3.660 us    | }
>>>>     4447.171351 |     0)               |    __delay() {
>>>>     4447.171351 |     0)   0.400 us    | arch_timer_evtstrm_available();
>>>>     4447.171353 |     0)   2.400 us    | }
>>>>     4447.171353 |     0)               |    cppc_get_perf_ctrs() {
>>>>     4447.171354 |     0)   0.540 us    | cpc_read.isra.0();
>>>>     4447.171355 |     0)   0.540 us    | cpc_read.isra.0();
>>>>     4447.171356 |     0)   0.380 us    | cpc_read.isra.0();
>>>>     4447.171356 |     0)   0.420 us    | cpc_read.isra.0();
>>>>     4447.171357 |     0)   3.640 us    | }
>>>>     4447.171357 |     0)               |    __delay() {
>>>>     4447.171358 |     0)   0.380 us    | arch_timer_evtstrm_available();
>>>>     4447.171360 |     0)   2.380 us    |    }
>>>>     4447.171360 |     0)               |    cppc_get_perf_ctrs() {
>>>>     4447.171361 |     0)   0.520 us    |      cpc_read.isra.0();
>>>>     4447.171361 |     0)   0.520 us    |      cpc_read.isra.0();
>>>>     4447.171362 |     0)   0.400 us    |      cpc_read.isra.0();
>>>>     4447.171363 |     0)   0.440 us    |      cpc_read.isra.0();
>>>>     4447.171364 |     0)   3.640 us    |    }
>>>>     4447.171364 |     0)   0.520 us    | cppc_cpufreq_perf_to_khz
>>>> [cppc_cpufreq]();
>>>>     4447.171365 |     0) + 34.240 us   |  }
>>>>
>>>> It also shows the first reading typically took longer than the later
>>>> ones. The second, the third and the fourth actually took almost same
>>>> time.
>>>>
> Do you happen to know if this is still the case if the delay in between
> the two cppc_get_perf_ctrs() calls is larger (a few ms)?

Do you mean whether the first reading takes longer if larger delay is 
used? If so, then yes. It should be not related to the delay.

>>>> I also tried to read perf_fb_ctrs_t0 twice (so total 3 reads, 2 for t0,
>>>> 1 for t1, 2us delay between each read), but I didn't see noticeable
>>>> improvement. 4 reads (2 for t0, 2 for t1) does show some noticeable
>>>> improvement.
>>>>
> I'm not sure I understand this. t0, t1? Can you expand on the sequence
> of reads here? Are you reading the same counter multiple times instead
> of reading all counters multiple times?

t0 means perf_fb_ctrs_t0, t1 means perf_fb_ctrs_t1. The above experiment 
actually does 4 reads (2 for perf_fb_ctrs_t0, 2 for perf_fb_ctrs_t1), 
but just use the 2nd (perf_fb_ctrs_t0) result and the 4th 
(perf_fb_ctrs_t1) result to do the calculation.

>>> Thanks for the new data.
>>>
>>>>> Example of code where we do 4 calls to cppc_get_perf_ctrs():
>>>>>
>>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c
>>>>> b/drivers/cpufreq/cppc_cpufreq.c
>>>>> index 022e3555407c..6370f2f0bdad 100644
>>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>>> @@ -853,6 +853,20 @@ static unsigned int
>>>>> cppc_cpufreq_get_rate(unsigned int cpu)
>>>>>
>>>>>           udelay(2); /* 2usec delay between sampling */
>>>>>
>>>>> +       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>>>> +       if (ret)
>>>>> +               return ret;
>>>>> +
>>>>> +       udelay(2); /* 2usec delay between sampling */
>>>>> +
>>>>> +       /* Do a third call. */
>>>>> +       ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>>>> +       if (ret)
>>>>> +               return ret;
>>>>> +
>>>>> +       udelay(2); /* 2usec delay between sampling */
>>>>> +
>>>>> +       /* Do a fourth call. */
>>>>>           ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>>>>           if (ret)
>>>>>                   return ret;
>>>>>
>>>>>> The above trace data shows some cpc reading took a little bit longer
>>>>>> than usual. I suspected it was caused by interconnect congestion.
>>>>>>
>>>>>>
>>>>>> So it looks like IRQ is the major contributing factor of high error
>>>>>> (4xxxxxx KHz), interconnect congestion is the major
>>>>>> contributing factor
>>>>>> of low error (3xxxxxx KHz).
>>>>>>
>>>>>> So I did the below test:
>>>>>> 1. Disable IRQ: The high errors were gone (> 3700000KHz),
>>>>>> but low errors
>>>>>> were still seen.
>>>>>> 2.10us delay: The high errors were still seen.
>>>>>> 3. Disable IRQ + 10us delay: all the errors were gone.
>>>>>>
>>>>>> I think the test result also supports the tracing data.
>>>>>>
>>>>>>
>>>>>> I also got some confusion about calling
>>>>>> cppc_cpufreq_get_rate() with irq
>>>>>> disabled. Rafael thought 10ms delay is too long because the
>>>>>> function may
>>>>>> be called with irq disabled. But a deeper look at the
>>>>>> function shows it
>>>>>> should *NOT* be called with irq disabled at all.
>>>>>>
>>>>>> First, if pcc channel is used, cpc reading may take over 100ms, it is
>>>>>> way larger the proposed 10ms delay.
>>>>>> Second, reading from cpc channel needs to take a semaphore, so it may
>>>>>> sleep. But sleep with IRQ disabled is not allowed.
>>>>> Yes right, however the semaphore is not taken in between the
>>>>> sequence of
>>>>> cpc_read() calls in cppc_get_perf_ctrs(). So maybe the change below
>>>>> should
>>>>> be acceptable:
>>>> Yeah, we should be able to find a smaller irq disable section.
>>>>
>>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>>> index c51d3ccb4cca..105a7e2ffffa 100644
>>>>> --- a/drivers/acpi/cppc_acpi.c
>>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>>> @@ -1315,6 +1315,7 @@ int cppc_get_perf_ctrs(int cpunum, struct
>>>>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>>>>           struct cppc_pcc_data *pcc_ss_data = NULL;
>>>>>           u64 delivered, reference, ref_perf, ctr_wrap_time;
>>>>>           int ret = 0, regs_in_pcc = 0;
>>>>> +       unsigned long flags;
>>>>>
>>>>>           if (!cpc_desc) {
>>>>>                   pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>>>>> @@ -1350,10 +1351,14 @@ int cppc_get_perf_ctrs(int cpunum, struct
>>>>> cppc_perf_fb_ctrs *perf_fb_ctrs)
>>>>>                   }
>>>>>           }
>>>>>
>>>>> +       local_irq_save(flags);
>>>>> +
>>>>>           cpc_read(cpunum, delivered_reg, &delivered);
>>>>>           cpc_read(cpunum, reference_reg, &reference);
>>>>>           cpc_read(cpunum, ref_perf_reg, &ref_perf);
>>>>>
>>>>> +       local_irq_restore(flags);
>>>>> +
>>>> cpc_read_ffh() would return -EPERM if irq is disabled.
>>>>
>>>> So, the irq disabling must happen for mmio only in cpc_read(), for
>>>> example:
>>> I thought the issue was that irqs could happen in between cpc_read()
>>> functions,
>>> the patch below would not cover it. If the frequency is more accurate
>>> with this patch, I think I don't understand something.
>> Yeah, you are correct. The irq disabling window has to cover all the
>> cpc_read(). I didn't test with this patch. My test was done conceptually
>> with:
>>
>> disable irq
>> cppc_get_perf_ctrs(t0)
>> udelay(2)
>> cppc_get_perf_ctrs(t1)
>> enable irq
>>
>> But this will break cpc_read_ffh().
> Can you not disable IRQs in cppc_get_perf_ctrs() only if the registers
> are CPC_IN_SYSTEM_MEMORY? Only spanning the reads of the delivered
> register and the reference register, which should have minimal delay in
> between?
>
> As in:
>
> if (CPC_IN_SYSTEM_MEMORY(delivered_reg) &&
>      CPC_IN_SYSTEM_MEMORY(reference_reg))
> 	...
>
> This will and should not affect FFH - the fix for that would have to be
> different.

It won't work, right? The problem is cppc_get_perf_ctrs() calls 
cpc_read()s to read delivered and reference respectively, we just can 
tell whether they are CPC_IN_SYSTEM_MEMORY in cpc_read() instead of in 
cppc_get_perf_ctrs(). So the resulting code should conceptually look like:

disable irq
read delivered
enable irq

disable irq
read reference
enable irq

But there still may be interrupts between the two reads. We actually want:

disable irq
read delivered
read reference
enable irq

>>> (asking for more information)
>>> Just to check, the core/perf counters are AMUs and the other CPPC
>>> registers
>>> are mmio right ? Is it possible to know the CPPC registers that are
>>> implemented on your platform ?
>> AFAIK, the perf counters are implemented by AMU and accessed via mmio, the
>> other CPPC registers are implemented by PCC.
>>
> Usually there is an implementation defined rate of sync between the CPU
> counters and the values available through the memory mapped interface.
> Is it possible that some inaccuracies are introduced by that as well, in
> case there is a sync in between the two counter (delivered and reference)
> reads?

AFAIK, the counter values are available through the memory mapped 
interface immediately, there's no coarser rate of synchronization.

>
> Hope it helps,
> Ionela.
>
>>> Also is it possible which platform you are using ?
>> Ampere One
>>
>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>> index c51d3ccb4cca..f3c92d844074 100644
>>>> --- a/drivers/acpi/cppc_acpi.c
>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>> @@ -982,6 +982,7 @@ static int cpc_read(int cpu, struct
>>>> cpc_register_resource *reg_res, u64 *val)
>>>>            void __iomem *vaddr = NULL;
>>>>            int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>>>>            struct cpc_reg *reg = &reg_res->cpc_entry.reg;
>>>> +       unsigned long flags;
>>>>
>>>>            if (reg_res->type == ACPI_TYPE_INTEGER) {
>>>>                    *val = reg_res->cpc_entry.int_value;
>>>> @@ -1015,6 +1016,7 @@ static int cpc_read(int cpu, struct
>>>> cpc_register_resource *reg_res, u64 *val)
>>>>                    return
>>>> acpi_os_read_memory((acpi_physical_address)reg->address,
>>>>                                    val, reg->bit_width);
>>>>
>>>> +       local_irq_save(flags);
>>>>            switch (reg->bit_width) {
>>>>            case 8:
>>>>                    *val = readb_relaxed(vaddr);
>>>> @@ -1029,10 +1031,12 @@ static int cpc_read(int cpu, struct
>>>> cpc_register_resource *reg_res, u64 *val)
>>>>                    *val = readq_relaxed(vaddr);
>>>>                    break;
>>>>            default:
>>>> +               local_irq_restore(flags);
>>>>                    pr_debug("Error: Cannot read %u bit width from PCC for
>>>> ss: %d\n",
>>>>                             reg->bit_width, pcc_ss_id);
>>>>                    return -EFAULT;
>>>>            }
>>>> +       local_irq_restore(flags);
>>>>
>>>>            return 0;
>>>>     }
>>>>
>>>>>           /*
>>>>>            * Per spec, if ctr_wrap_time optional register is
>>>>> unsupported, then the
>>>>>            * performance counters are assumed to never wrap during the
>>>>> lifetime of
>>>>>
>>>>>> Third, if the counters are implemented by AMU, cpc_read_ffh() needs to
>>>>>> send IPI so it requires IRQ enabled.
>>>>> If I'm not mistaken, the CPU calling cpc_read_ffh() might have IRQs
>>>>> disabled,
>>>>> it should not prevent it to send IPIs no ?
>>>> It can't work with irq disabled. The comment in counters_read_on_cpu()
>>>> says "Abort call on counterless CPU or when interrupts are disabled -
>>>> can lead to deadlock in smp sync call."
>>>>
>>>>
>>>> And it just returns -EPERM and raise a warning if irq is disabled.
>>> Ok right,
>>>
>>> Regards,
>>> Piere

