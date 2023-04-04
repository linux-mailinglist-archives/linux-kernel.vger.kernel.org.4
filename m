Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668146D6CF4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbjDDTH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjDDTH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:07:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2111.outbound.protection.outlook.com [40.107.237.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B077AB7;
        Tue,  4 Apr 2023 12:07:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYGP98Ek0q2S2Dq6g+4UC1tSEsqb0iDTw9/27kyM8ceCg6USYnImsHSIdiMdUpwnvDS6tATcm/7SVHDJBoQZoVmvyqcVsBNdQ3QBi7bL42Hq6sxi4nVnSCDDqK39MGTuMhZ0449jOxyUHPl5fpsMQR0L8FCN+y1zqUD2UHJpRDM8sNYZ2QXUOYSnsEcSH/CxNc1B/GaYW3qiOO1WJbeb6aY4yzNSMpQGgfyWAlufwMq1XFTEQMiOsZAwCUxT2CSniJo7OQq2pMEBhGCCKlXCkjtWnh+eJrR40v7cevVVO4wFqMPIWcgQjB8UJXYcczN7GTDceMINpvEleHnNWTVm2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE//LJhlElbTPIA4czoTjZ1+5lOb7QHK7Z80oYqhPkc=;
 b=GLc/KFWfpz4SpZnoLsnKBeHN7dE07t9S0QNA/e/DVvSbZbTnHlf6aGc3Sj5Po2CyHkmmlGhT1v+iaA9jurpUEDuuk7rVYmJ7zH3FdqZkG+4fSMwGrE6897Knjs2peWGCo7sz8bpqVmIgWap/aFaKwTXIN4Yb1apHeol3dnei3D2AVp0qHNb3UtHOAqKt/bPCCCKO+Q88+Tj+SCyudWloNf+x+BZ9ObxCAINYHWisqezrBxO7uMpHOrF4qN1ZvxhRDPiHup6Iw6vNHWBSnAGgakHoCxM9XvDPydEKzln1KEg+coPSwnJCSPrOa3YUTjTd7MCwPTD2SSpPvR7STZHSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE//LJhlElbTPIA4czoTjZ1+5lOb7QHK7Z80oYqhPkc=;
 b=a1Ji06wumlWmdMH0zrBdgRHxF6WxTASkaI0S7ht7QxUhH39ptyRTzrIR9d2iDD01/NRr6ugpUmi4MVOq6Js1O5yWXiE/JejbAu+Xeau7mhP4Az+ECo468GhC3u6PTUHTMqoRVal+WuX355e28011savvdYhBq1BDGPfvzV4Uh+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7027.prod.exchangelabs.com (2603:10b6:208:35a::9) by
 BYAPR01MB4583.prod.exchangelabs.com (2603:10b6:a03:9c::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.28; Tue, 4 Apr 2023 19:07:20 +0000
Received: from BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::ef17:958:5c42:3d26]) by BL3PR01MB7027.prod.exchangelabs.com
 ([fe80::ef17:958:5c42:3d26%3]) with mapi id 15.20.6277.028; Tue, 4 Apr 2023
 19:07:20 +0000
Message-ID: <d08222bf-fa05-3e3b-18dd-d24ced6c1536@os.amperecomputing.com>
Date:   Tue, 4 Apr 2023 12:07:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] cpufreq: CPPC: use 10ms delay instead of 2us to avoid
 high error
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>
Cc:     viresh.kumar@linaro.org, scott@os.amperecomputing.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230328193846.8757-1-yang@os.amperecomputing.com>
 <CAJZ5v0gQ7vak9DaEmLKe6un60Gcpj7VtmxdjPwuXTi=P=KJjbA@mail.gmail.com>
From:   Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <CAJZ5v0gQ7vak9DaEmLKe6un60Gcpj7VtmxdjPwuXTi=P=KJjbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:610:e7::13) To BL3PR01MB7027.prod.exchangelabs.com
 (2603:10b6:208:35a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7027:EE_|BYAPR01MB4583:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e07a3f-44bf-45e6-2b58-08db353fd089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gIbu+Ux7JCtOoha4n8ao/tJarvtD1gs6yoUCct7wsl4xaFOy4FZBDumn3Arw0W7ZStQkmg4PTiOAYb8cOSzER9LcI2V9pBQE2gEcIE5PhPjDl85Fs1DCp08vR28LDiStLpIpeFRf288NcWl1Bujfiwy7t4orzzpkqkz7dwBBAxCYN4WvsVUqosV9jdGqxrA/SPkUQ+OOyqe+vUnnkOqhE04aESeC/ncSuyS7+K9oQ2Xnr8I7XufPXMr0ue+vJhdb0boQ+852KVoO6EFv79kROTND8wsn1Xbj3vv0YX/ErurpgCwajlw+lyenCTjQu2SuiMoEhGMzltrm7KWBiM4k+X1RniBch2X3Tfs/ueCNiyRQfn6cDRxXig5X/QPYscvTkM9loPVf3M7Oz9Akb0E7X3c50mdd7M2+cGIN3YxOQ1sdUcbp99aMsKieaQLOFVOg1eFX+6GuUBHzUZze69ivxw6c3zXg2CrM+AmB+8sZLrL6MLMSuwsb01/cluQJLWKCcrLjv3OPKdXma3vlvg9Is/agPnhxhqwv7vXyA2ctjEr5RGnFoW4pMMZaj5/7UO8JsAcQsib2jXjo8oZ8OcAJw6QHCUtCOjAtFYNCE5YcYixJwsUl4Cz+Az7BOzJ44/D5gbiaB+F1tDqDP5lDnRpcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7027.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(366004)(136003)(396003)(376002)(346002)(451199021)(53546011)(31686004)(26005)(6512007)(6506007)(6666004)(186003)(2616005)(83380400001)(6486002)(52116002)(41300700001)(86362001)(5660300002)(8936002)(31696002)(38100700002)(38350700002)(478600001)(66946007)(66476007)(66556008)(8676002)(110136005)(4326008)(2906002)(316002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW1FRzVPaTljUjJRQjV5L1N3WThtaEM3TlJ0ZldnOCtNYXZlQnVXYTExQzky?=
 =?utf-8?B?b214TlE4OEJOMFRTdm1QZTc2ZjAzZ1FBUEFPa25WWEJDVEJ2R24rb0RwcnVz?=
 =?utf-8?B?SXd2d1ZxQ0dIa3FBUjBUN0dJcnlPSkcyLzAySStqWFRKNkl6WXN0cFg0bzBZ?=
 =?utf-8?B?VG1kWEtkNUw3Z1V5eHcrdGRXUzh5YlhiV2pRK3gxTUhEQ0wwV1MyVWpkVWd5?=
 =?utf-8?B?Wmdqd2Jnc20ycTJVZ3JDaElFQkFQZ1pxb3hFakpHS3poR3JaZVJsUFY5V0xB?=
 =?utf-8?B?R3NXTkNDSVA2NWRtazFkUXRyVHpxbHVLcGlkcVFiVC9MMjRjSURwYkl5OG84?=
 =?utf-8?B?QW1zTzNDRkowV0N2TE82L0xYQ2V6SDVhaklrWnNzeGpVUEtxTnk1VHBSamNW?=
 =?utf-8?B?SlpSdjJ2eEo0OXhtcTh4dEVNYW90ak1JTCsxUEVORGRMdHRHWGJVb0tORTFO?=
 =?utf-8?B?a0UyN0puclJuVHMrSDNQK2xQc1BiYkkyVnppZ1pTTTM1dDlUcTNXWDBVcC9i?=
 =?utf-8?B?L2lWOFQzYmM1RVozU1RsckpvaFZ1Vy9NYnVjS3hySzYvZFVBdVZveE5LUWht?=
 =?utf-8?B?TkRNaWdPdzRQUThsRGJhSm52SjhPVEh3aWtSNDZHaVk2TmhtSGxaL2FzVzkr?=
 =?utf-8?B?Uzh1U1lLSFVuV0RVZHdCSzlkbXc4a2FsNkcyWDhoNnlEYzgyRlE1eVhkb1ZY?=
 =?utf-8?B?TEwzTVVRRG5hMUpLRk1QdEZuL2JGdzAyQWJwWWJvWlNLYi9QUHI4eW1jbVFn?=
 =?utf-8?B?dVhweWJTREJ2YkdwVDVjVHNCaVAyY1h0Y3JTUmU1QklELzRlZjFPUTVCZHF6?=
 =?utf-8?B?SnVOVnJDS3hxTUc3YUVmeENyZWdrRXZxZXFzc2JCWlVNUTVQWUg0Wlk4VXhq?=
 =?utf-8?B?cEtGSFNhR09ERUM5MmJnYTRKRHN2d2p1NmxTL1V0VjhtY3lWN1dHOTRmeE5l?=
 =?utf-8?B?akRXRVlOSTBta1Z5WUVQVHpxanBYa3UwdlZxY2VmM2Y5MS91S1VBM2RHYU8v?=
 =?utf-8?B?dW4rTXZReGpXMEQ2VDJjcWV1b204Y1NBRnBUcVVORVFUQ2NMZlRPNHB4Qk8v?=
 =?utf-8?B?MWE3Z0Y4ekhLeHNTWFpWeVFDaHQvelhSRVdCZlpxdEkrMmFGOTNqWEFveUgw?=
 =?utf-8?B?eTcrWkR4WENmaVNRcmJQbDdWWUxUZG50QWQ0U2RWNnRrYmg4a1NQdGhMc2lE?=
 =?utf-8?B?ZWtDNGlWWDR3dHdkQ1hLcU1KcVh2d240NUpkc0h6ZUo3NWs1d3dsaHhtNzMz?=
 =?utf-8?B?THVnUTFFeFBybEtub1BJM2I0bSs1eHJ5Mm0xZWRoMmFUS0UrR0N2TmJXeHFp?=
 =?utf-8?B?aDRMV0lRcVl3YjVRVnA2WTF5VUJ2QzduaFNSekdxRGRuUmpHMmZ1blM2b29M?=
 =?utf-8?B?bElsTWRsMDYxN1JSNEhqSVZ2N2dUWkt1MmlWOW9hckdhcFh4Qk9sOXhtSnRz?=
 =?utf-8?B?VzBBVWRFZ25lMERJeXlLSllGcTB3Y21iMkg5aHQzbUF1bDRpc0dSTG5QT1lO?=
 =?utf-8?B?bTNDUVpXUURMYWphRllKaXRMRTNrSnV4TGtMbzVuQW5YcDBIUHFXUkZONUxI?=
 =?utf-8?B?UzJTdHdvYWoyOVpydlBMckx3d0NROE5zMnJPaU1ISjdTZ0N6aDJVdDU4RVZq?=
 =?utf-8?B?SDkwaEJHWTlxVjFGYm1VSjJUOTVCR1FKMi9OeGpqQnB5azNRSTFqT0RpWmZs?=
 =?utf-8?B?YitFb2VRMzdIdGlZbWZLMUJVdWR0UXpsUDdUSVZrdnpCSjRzKzh2eHkxUmR3?=
 =?utf-8?B?QXJFK1RzUk95UG5IYnZ1a2labnpvTVE2a2xwYzZvbHB1aFNjRXk2RURPY3px?=
 =?utf-8?B?c2h4enYrbkwwKzFuSnRwUXBFcW5nSExLZ1JOeUw1emRYMVdqK0M1UmpHT3Fs?=
 =?utf-8?B?MjlxZDJnUUkzb1ltSXUxUkliZDg5aTFILzhrMyt0NEVnZW5wdkNRTWNwRkZV?=
 =?utf-8?B?ODR0U2p3WXgvQURFV2JTNVVVTWVwVXUvVm1ya2dOdVFCODhwTm5HSnBzWjRQ?=
 =?utf-8?B?S0RoUzRlc2RXQkxhK2VmbUNNMmZjMFhSeTlVd0lvUkVvR3JibjVSaHlna3lx?=
 =?utf-8?B?L094ZERNd3pnd2k5UWVHN3BLS2dGaldCOHovWEkwald0RXVZMVdaUnJxWUdo?=
 =?utf-8?B?aGZxeU9GQWE0NXdqekZKYkNBQkc2and5eFhkMENrV3hGajZnRjdZQjhlMm1k?=
 =?utf-8?Q?5GilPUzuix1mLf6ezrjkjrg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e07a3f-44bf-45e6-2b58-08db353fd089
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7027.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 19:07:20.2250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7njCHUzlfZtSyrSGZ17EWQjLp5UflstUzAXSWeRvHFSudmPn5mn9Cr8sNyv79yaI75/v/VCpbnB6eM0O8LPdXnohuka5PiIerv5pSOtD16g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4583
X-Spam-Status: No, score=-2.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/23 11:43 AM, Rafael J. Wysocki wrote:
> On Tue, Mar 28, 2023 at 9:39 PM Yang Shi <yang@os.amperecomputing.com> wrote:
>> When testing CPPC cpufreq on our platform, we noticed the error may be quite
>> high and the high error may happen quite often.  For example, on a platform
>> with a maximum frequency of 2.8GHz when the CPUs were fully loaded (100% load),
>> we saw cpuinfo_cur_freq may show 4GHz, it means the error is > 40%.  And the
>> high error (> 1%) happened 256 times out of 2127 samples (sampled every 3
>> seconds) in an approximate 2hrs test.
> The description above is a bit cryptic IMV.  For example, it is not
> particularly clear what "high error" means.
>
>> We tried to enlarge the delay, and tested with 100us, 1ms and 10ms.  The
>> below is the results.
>>
>> 100us:
>> The highest error is 4GHz, 22 times out of 3623 samples
>>
>> 1ms:
>> The highest error is 3.3GHz, 3 times out of 2814 samples
>>
>> 10ms:
>> No high error anymore
>>
>> Increase the measurement delay in cppc_cpufreq_get_rate to 10ms to avoid
>> high measurement errors.
>>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 022e3555407c..c2bf65448d3d 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -851,7 +851,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>          if (ret)
>>                  return ret;
>>
>> -       udelay(2); /* 2usec delay between sampling */
>> +       mdelay(10); /* 10msec delay between sampling */
> This function can be called with interrupts off, so it cannot spin for 10 ms.

Per Pierre's comment, the delay may still be ms. Is it still too long? A 
quick look at the code shows cpufreq_quick_get() is the only caller with 
irq off IIRC. So can we have another callback for it, for example, 
get_quick() which does spin for shorter time (for example, keep 2us 
delay). Then have ->get() callback use longer delay?


>
>>          ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
>>          if (ret)
>> --

