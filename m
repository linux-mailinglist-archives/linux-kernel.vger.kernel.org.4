Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929FC6EFADB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbjDZTSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbjDZTSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:18:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2E2193
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 12:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE32Likp8jNYGQhgWwuJznJIqVCLC4MrmHn0fq/vx62CMlNi5/07WEIUToukhkcpHg8u+ihST1gh9HMpGefELmc14XIZlpvNFmCEAbtZT9yduc74KQ4GRLoRKBVZErCVCOOvpvI9C8KaIvMysg/sCx5rHwqVkbpNk+3sdBBn65jIQHGUl+UBjcLK5GorGTdSc9PMLYQf3htDFknlPAeEN/QnrdRcMPayC8k0BoFA/r7p5pmsMPw68imWJn1p/Nzr14hx9pSVzQB/hLfB3tdHNZbdroupvI98o4kMzta69EqZpCe6VHcKjYJVsH45x6K09lL16mc0riz1mLknJUQnOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIV9Dv4Q6r2LdMo3JMIR2u4jVByjSAyakJdejn+NKeI=;
 b=UuINTMYI8G9aACtSVeDcd68W8/8fL7ks9kf+DYbPxprvs5QDQ9yxiQ6nyr8DWIsJWDALxlG/BbumVH+LcGozaSflI5cbvntbuFqDcJzwc+M1ddoHGGwCQnbDAERATErxhiYzoo9u8lxsjw70c/2cwKistIvcf9Op/KwL5AV8RdjQFqkD8Hwuu4eRO+cuF2I9r8Oyxl3CHc0XWNAC9FzSddg3YJTyO2A6e6s3vHWJ+TQyXiFoI3aid9yqCS4vyU0ifPxU69foInivhj+gtqoKFAJC4VL1J+TBEn8vQx26D4weqvn/8ZIcwpNXedBiGz5vgPZPrCxB0OH73maVHDe+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIV9Dv4Q6r2LdMo3JMIR2u4jVByjSAyakJdejn+NKeI=;
 b=18hS7v2blVSqNtjkjYbr30Fggev6yB3WwTEp1FIOdaHqfQmBcx/9JpiOK74eoJBgvsBkCepd8ZjMm0/zGR1TIaGRI1mO+dOBT9mYEXMp0Iu7uYFUrVbJtDkpTfODBroxCKIPHH/7T7r/jRa3Zp2w81L4vU07HBAf0Lyhwx3QSGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CY8PR12MB8409.namprd12.prod.outlook.com (2603:10b6:930:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 19:18:39 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 19:18:39 +0000
Message-ID: <469754ab-d8ec-168a-15c7-61045a880792@amd.com>
Date:   Wed, 26 Apr 2023 14:18:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
 <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com> <87o7nbzn8w.ffs@tglx>
 <5f8a9cb8-70cf-2a17-cfc4-cb31cb658de4@cybernetics.com> <87y1mey503.ffs@tglx>
 <ccf57fd2-45b8-1f1f-f46a-55d7f4c56161@cybernetics.com>
 <01a44722-931a-7aff-4f4b-75e78855beb1@amd.com>
 <25dd25d3-2db1-acf6-0814-9bb5bcd65bb9@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <25dd25d3-2db1-acf6-0814-9bb5bcd65bb9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:408:e4::27) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CY8PR12MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a08af7a-128f-4495-b254-08db468b0a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FdVp4awEYnAkkVvDbW3Mr3kTHnA5CS04tOJFIKqzeoHLEyJCf91AhWi9HCxcTkJn3Gve1tF8aGQdgvcbw+TkPmZMlQJzNM86GGCJyEVkkS+kBcYycHUWXJKhzU65fYBGOghhcq6KQlf8wvI3G8nVe+Qx9MyApHoIfSv6LUXCjA4ZxSf9k/cW7oAd/PLY/neKp9l/inpuVUzvg9xZrIrGlu7nogeYgzDLi+wS1SNL5E8aY+pQgliJeHomoGjgXGJEZH+LCRtsX3CcMGCaPNds4//Yk6Fc+SR1kW/vfQgIi7lNRE34/nBoe90lTG3pHRD0OkWU/IhC5J0dgtPShZD2TgOPNFJk+VkFoCEVey+af5M1cdbVMSuf0lqIoPlEylBgroJiVI4CL8SwFMQff+u5tjMWrXOjJkD1MOB5htUb61QwvZu8d066EDlAmrf8hRmeL9mQkmmwo5j3jfEBYRSy+Fv/a2aXRQvlIyyvnh/5q8k2Dd2QFaV7r2TgOFig7An53SLPp1TU5IPzbitlgM+Ive1NRCcOWrKAzeGqGY/hML47+NXQk3lo1nNT5Db3RTiMkEeyFSf+X7Ib9wVVL9v8W/9h+nmVkqLfvK6vT2JHAvpk7box7YRghIb9wzJesmv3WAF5ZH1lU/Ga6TRInxPMUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(54906003)(110136005)(478600001)(83380400001)(6506007)(26005)(36756003)(2616005)(6512007)(186003)(53546011)(38100700002)(31696002)(86362001)(6666004)(6486002)(66556008)(66476007)(5660300002)(66946007)(316002)(4326008)(7416002)(31686004)(41300700001)(8936002)(8676002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWR5SHZ5RVJsakYxZ1NreEs2WFVmNnFWLzhzdmJpZTlxSmNQSzRPeUIxdVF5?=
 =?utf-8?B?a3RQcjRMWWF3MWdOUkFqM0FyUFMwcEM0UDR4OVpQZHJqM1Q0N1FqU0dUbEwy?=
 =?utf-8?B?Njg2bklXL2k5cFFkMFlLcm4xSCs0MFVrSzJubUZZR1lvMXl5SWcvczRUc1NS?=
 =?utf-8?B?ZVlCL0pBeHU4a0ZlQUZoN09vTVhxWXd5MnI3VnpuZFRyWUVnZW9tWWpUSHZt?=
 =?utf-8?B?ZzdCQzlpTU1WSlNnbEZac0hPSUNXbkdmRmd6b25HcTZnZlBXUnd4eUhTV3Mz?=
 =?utf-8?B?VlpiNGloM01TRVA0bmpaY01zZ29Hb3hqNVJDeVV5a1VGQlhpcjhJaEFiYlRq?=
 =?utf-8?B?Z2dhR3lTU29NTWhueEMyZEg4ZlFNN2F6bG5Wek5XV3ZONStrVGp0US96eEVR?=
 =?utf-8?B?YlRHbEhqZmF5ZkJWUk82TjRucjArN1NoR0ZtZVAwaVYxZURNUVV6cVpweUFK?=
 =?utf-8?B?bG5ld29abldOWVhBaFN0ZG11LzQ4RmxuajY3STkwSEpsaEluZWQyOFArbWhC?=
 =?utf-8?B?aS9oTTJzam5KNklMZk9ZeVkxYUZpc1pvVGxOalRYZWdtZ3E5TE83aUx6d1g0?=
 =?utf-8?B?VjQvUlo3OGI2cHNrNjB1WFFQTlY1SnlyeW8xRStXeEhTQzZoVGEvSEo2TDNB?=
 =?utf-8?B?ai9XeFBYWkpvKzkyNytZSUxHaGdXTW9GbUdFYUFpSStCMkFVbityWWVNQVRq?=
 =?utf-8?B?bzAyLzVOK2hIbi9Bd0xSSWc3R0NsSXNpZGQxd2t1UDZjWTJCem1jbDc3WFha?=
 =?utf-8?B?UmdxTWg0VEJPYVJMKzBaUE9ZcHlrQnU5eGVCc1B5K1ZDN2ROK01tMXUwK0dN?=
 =?utf-8?B?T3hHNUdNbG1GUWNad00xRSs5Ui9oUDNIenRvaXlFNEgzUzVXcWY1TnBSNmgz?=
 =?utf-8?B?SlU0QXpHN2J6aE9iQVVKYXF6dEp0R2RCN0RIMy9aNUxHY24wR0szMkZsdkNG?=
 =?utf-8?B?UGhMWTBOb0FTRGpCL2FFZGo1WmxlMEV1Mi9sd0ZDSk9JY2FNei9DZFhWdUYy?=
 =?utf-8?B?SmllUTZ2SThnMGEvaXA4QmNaZDNkZTFGTlQxeHBNa0w1dzRvVVErYVRXWHYr?=
 =?utf-8?B?UDhPcS9JVkdCaVJSK3B4THV4eG41dTd4RStLR1NOVkk5WTE1eTNoL09kcU5K?=
 =?utf-8?B?SjVyTmJpS2lOVW0xOTROQ2l5NVh2ZWRUZUR1YkdYak9PeFZDWVowdkVPQXRs?=
 =?utf-8?B?aDkrc3JYV1AxbTRjOFhJcUExRXkzT3hDYWI2SjVOOFF2UThoejh5VE04M2tC?=
 =?utf-8?B?QWkyQ1NUU3c2UHdaNEFZdndDcU5WdW5aVFR3b2FSRkZiNDVlaXQrVjhxWnRh?=
 =?utf-8?B?cXNaR0duZmpzSlkzK1RNYWRiR25mODFsaTJpWjBwZWRZU3dMMThwMm1uYzhW?=
 =?utf-8?B?Z1REa1NTVjFQc3I0RHZYckhlUW1XbEFsZGp2VHEvUWM4aTQwaVVpSHVXVzVm?=
 =?utf-8?B?OC9VeWlQUDh0SXdvK0xSU3ZFcUhJQ2F2RUJpTEZjRFZxdUJwUmZucjdZWjAw?=
 =?utf-8?B?c1phbDV6TDVKUFRSU3NiQ1MyWHkzSFRnSnJwOUllWC93eDhKVyt6c05LVjYy?=
 =?utf-8?B?THRwMVNtK2hUcVBPVWtTMVQ5ZFF3NGV3b3VmVmZDVzV2ZGZ0VzNiQ01ERUQz?=
 =?utf-8?B?WHF3YWx4R0ZtOVhGTFEwdy9uOEtJd05HUWZlNktmM2pNT1MyTjRPbGVyUTBP?=
 =?utf-8?B?NWZDRHFPeFJVVHM3QW5WQjhPU1pPNGx1Z1NnNDlpT2NTVmRuOVBLSElTcldE?=
 =?utf-8?B?SC81a0d1bXR4S3I3RmwrV2FXSlBSSTFoZVdJdDBGR0Y5bGhOQnNvdkVLa2o4?=
 =?utf-8?B?OTB5TkVsMi9ndmMyVStmWCtWQzJQOUZ6K0MxSWJSTERNa1o5TXU2alBnTGJF?=
 =?utf-8?B?MTFQRWU4RCs3UGpiVnFaYWNGdzZaNVBUWG9KVmY2ZDVqM0tQRTB5K2t0a2F4?=
 =?utf-8?B?eS9iZ1JhOHhXSFgrQnY5R3ZFOHFJSWhoNGRqZWFqRVIyZzliTlp5TUI1eUtG?=
 =?utf-8?B?Rys2S3JRYW5MZHdyYzU5WitNOFhYdnc3ZFVDcGRrM0p4cWF6NjhQREpqSnB3?=
 =?utf-8?B?VFlhRU1VVDE1SURNY3phc3hmeithWkpTQnN0Uk5mUk84eUpWRHNXMTFTdXE2?=
 =?utf-8?Q?f31WbmwIzJB7OCYHJUuPEDpO7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a08af7a-128f-4495-b254-08db468b0a35
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 19:18:39.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJmVadnCw8rvANbAI9n64Rgh8AbKEvVO8+4TTQfRG185ebiHOr+gMupWKkliKC3ZGEIW9b2md+rap9nQ0ZaEuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8409
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/23 13:15, Dave Hansen wrote:
> On 4/26/23 10:51, Tom Lendacky wrote:
>>>> +    /*
>>>> +     * native_stop_other_cpus() will write to @stop_cpus_count after
>>>> +     * observing that it went down to zero, which will invalidate the
>>>> +     * cacheline on this CPU.
>>>> +     */
>>>> +    atomic_dec(&stop_cpus_count);
>>
>> This is probably going to pull in a cache line and cause the problem the
>> native_wbinvd() is trying to avoid.
> 
> Is one _more_ cacheline really the problem?

The answer is it depends. If the cacheline ends up modified/dirty, then it 
can be a problem.

> 
> Or is having _any_ cacheline pulled in a problem?  What about the text
> page containing the WBINVD?  How about all the page table pages that are
> needed to resolve %RIP to a physical address?

It's been a while since I looked into all this, but text and page table 
pages didn't present any problems because they weren't modified, but stack 
memory was. Doing a plain wbinvd() resulted in calls to the paravirt 
support and stack data from the call to wbinvd() ended up in some page 
structs in the kexec kernel (applicable to zen1 and zen2). Using 
native_wbinvd() eliminated the stack data changes after the WBINVD and 
didn't end up with any corruption following a kexec.

> 
> What about the mds_idle_clear_cpu_buffers() code that snuck into
> native_halt()?

Luckily that is all inline and using a static branch which isn't enabled 
for AMD and should just jmp to the hlt, so no modified cache lines.

Thanks,
Tom

> 
>> ffffffff810ede4c:       0f 09                   wbinvd
>> ffffffff810ede4e:       8b 05 e4 3b a7 02       mov    0x2a73be4(%rip),%eax        # ffffffff83b61a38 <mds_idle_clear>
>> ffffffff810ede54:       85 c0                   test   %eax,%eax
>> ffffffff810ede56:       7e 07                   jle    ffffffff810ede5f <stop_this_cpu+0x9f>
>> ffffffff810ede58:       0f 00 2d b1 75 13 01    verw   0x11375b1(%rip)        # ffffffff82225410 <ds.6688>
>> ffffffff810ede5f:       f4                      hlt
>> ffffffff810ede60:       eb ec                   jmp    ffffffff810ede4e <stop_this_cpu+0x8e>
>> ffffffff810ede62:       e8 59 40 1a 00          callq  ffffffff81291ec0 <trace_hardirqs_off>
>> ffffffff810ede67:       eb 85                   jmp    ffffffff810eddee <stop_this_cpu+0x2e>
>> ffffffff810ede69:       0f 1f 80 00 00 00 00    nopl   0x0(%rax)
> 
