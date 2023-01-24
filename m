Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B600B67A232
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjAXTD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjAXTDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:03:48 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CA44DE1A;
        Tue, 24 Jan 2023 11:03:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAZRKE1ZdN77z/St9JAgKbquteXULpVrc4+EzUqLxJ224/2pY+YZcaYnCcZ/f1zrIpnHdkg0VVuRPIDFYMxZ21XAmVu4XS5TCfybyNevXC3r9QZZM7cwwucrfR3YtZhefw3uce/RcqFTObYo9x3/5LFKcWMx4Zsq752XTLAFxZsaxNnaxx3qwjSpqcsmM6hWXdls+B61QWc7zMdAqGk84jV4i/vTWEL8yfpeJ5HwEnWzSeOODvc3RdEojrkzvjF46qJUY/vpY+oW31ipQQe5GO9SjY3FCw5zEM988HH/NKa6R5/vamD+vWa5xfJvIkcReSVnZRsoizEWnM5O1FlYLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1AHshiQtkTXcbbz/PqVQ8W4D6P971JEI6DYUfPaEM8=;
 b=IxFERqFL8A6jIQQUlBeeH7ksaN51qEgSWJX++o/wjYQoQVZO6Cdu6esoji6b+po0TTn79uOUh/8I1tvSNmDM3LVLdj65HAq+U//MEfgsp03BSFPuKSStcX1cs/6ENb99jfUntxLbrGtVuFAHxElfyqCSGQNiptw8PDtV/dtDhJa/GVsLVOCLsTOgrGIeX97pZqkiu9GKuocnWWB5wZYJ15LlB1w63hhXd+PT0EBNJZQeRWZUZCEEFeLPzQMUl9B6C3j2zR2pUVQwKo552uex84r/JF2GDQcHMUyhuqu7Vsj9ylX3gQQMRfxJ/00b82rhk3qR8kP+uM7cL2Z3BrPesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1AHshiQtkTXcbbz/PqVQ8W4D6P971JEI6DYUfPaEM8=;
 b=VeX4YuaiC4MW/ZspnfvyjaCuc6JL/swMY9vwQ4GGm9w8L4OB8UtrCxHK2DEc29KbgjpjHg8D118m45GRxbHx1DwAPUNKrTf7599ICBr5TQ3SjFfbHijpSviPwaVIbtACAjhzgMo+alcqGtId58i0pY7c1MvbzzRSiskeqBlXH90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 19:03:39 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%9]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 19:03:39 +0000
Message-ID: <2cf1380e-ed98-d943-e492-ebbe9238b51c@amd.com>
Date:   Tue, 24 Jan 2023 13:03:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20230109164405.569714-5-babu.moger@amd.com>
 <Y7xjxUj+KnOEJssZ@zn.tnic> <5afd0a7c-3fbe-dfea-f1b4-2fc35fbb4f13@amd.com>
 <Y7yCCNANVBnOOmxM@zn.tnic>
 <SJ1PR11MB608321F26D729A082BFC6FAEFCFE9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ecf0abf0-59fe-3898-762c-d9d883925550@amd.com> <Y7yMbQ8hI9MGl1w3@zn.tnic>
 <MW3PR12MB455384130AF0BDE3AF88BCF095FE9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <Y8/CSrU8Bo298VzO@zn.tnic> <72cdefc5-1601-5c43-9ea4-4b637f5fafa5@amd.com>
 <Y8/07cV+t0PrqWX9@zn.tnic> <4ac38b77-77aa-f2c0-36e4-5e482013091d@amd.com>
 <1e662209-93d7-2247-4212-8c78748c69bd@intel.com>
 <12f98b80-38ce-5912-fa10-33d6b8a2fa81@amd.com>
 <f6e24e38-31d4-e2f4-4dc1-13208a427a77@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <f6e24e38-31d4-e2f4-4dc1-13208a427a77@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::38) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB5374:EE_
X-MS-Office365-Filtering-Correlation-Id: be222f88-d226-4bb9-5317-08dafe3db3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVU+AeHWX7N1vZQ77T5L1l9CWNe/UOO60Rs3XxDdQunmdFHWYhe7m9MKjSzKj4TK6LsWMTOMFfhSWlxkM2J78rFL+ypTowq0ivBY2J9pd9OuTAF/xRtL8JMejtXqepMSJ2N0gepe7MtXK+0rYZoaYOQsrG3YhvAuWsilmkMXDl5luAn2DOpQlOL4Rx4f4E0DNzvFN17Z4BfSOHxW9XHff3RZ9Ogyi5NL8JOm2mjVVwIRhrs5Fcv2k4tMFEHievTjbkg/vAxxjfhRUrqS2y664bsC+iL7SuxNvMzjH/dub4MvHl04HbK/2KOJCUoQLJDl8HHdIE4MhSkzJZVf1NHr0fAxPEw8NMcvNyNX3su405/NDB/5wPuMEQjxNwk0TG8ZmgIFBbbX+fIYB0cLVyt9HN6laTP9cImDjpUU2yIwGMkHMY8vFzo8y9vw0qeLvRti7tk1J/DSmVg2eer6k/Plh8ky0C9Tw71g1blVZTfoH6bG2R9Hax7BnO9+MWA0DQZyNg4y8Eiq2fs29/N13zyoKDEFwgGCVaiGK/qlmcnp6XbMlBPZL2jppJoAU2xaTsLFUFBE3WEUR1v0aZK890QVeH7HbuGzCNr0d3qwZDPIf17UevnGTyZ2k2skVY5TMbSm5dUfE4B2sXG4ZARaRc3hZk+5R6z5cCs+adod03/Twd3fJJqYIjdS3/rt/OVNzqYKIyiKD2CsvLflVXqn+5d/y00sB7W/cPMU8ecmfdtFH0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199018)(2616005)(36756003)(2906002)(7416002)(5660300002)(4326008)(7406005)(3450700001)(38100700002)(41300700001)(83380400001)(86362001)(31696002)(478600001)(6486002)(66476007)(31686004)(110136005)(6512007)(6506007)(53546011)(8676002)(26005)(186003)(66946007)(316002)(8936002)(54906003)(66556008)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTVxblhpNk5MYTd1dm00aVhZY3RDZUxLU2dzQldqWmlraENCeGk0cUVmaWFz?=
 =?utf-8?B?VzZKTnBuOVZxcjhvb2dDZEk5VWxjcWdCVWFuZTZydFJmQitCN1B2ejFUZlU1?=
 =?utf-8?B?OGhoSEdOdzJDTHh0TUJ1WVpXU1ZsWFpTbjYvWnl3T3pycm1lWm00UVY1eHJx?=
 =?utf-8?B?ck1iQldtczIrOHNoL2d2amszY09aUWJIcTMwRDVmcU50Z3NtZERMUTVjWXp0?=
 =?utf-8?B?V0wra0VxenRaTG1kT0hyNThIZGRvZDhDSW44OFJleUduNHRXdDRXanJSbmxU?=
 =?utf-8?B?ZlRsRXRGbHo2b3ZuLzQ1NHJja3ZvVEMwRktPeTJrTHJTbVVsU21jN3EyN3h4?=
 =?utf-8?B?djdOakxUVFJlNEcxbFd5NnlQZVZRa09KVlRhb2Mvb3o3Z3ZtU1JpN0RQaitO?=
 =?utf-8?B?VE9HY2Z2UU4yL29BTGJ0VERDdUlGTnVYMmpSU213YkVvNkpBTVJORGFmUjh0?=
 =?utf-8?B?V3lsTE9VdklUQzBXQzRlQ2Z1RVNiaElVdDE2ZjU2VW94VFhjeU1LaEFpd1ZT?=
 =?utf-8?B?REppTENLV3hyVWlhM2c2RUJUd1k2TUp1UTZtaUl3YkR4citBZzlGYWI2OVNW?=
 =?utf-8?B?SXNqcFV6d0tMQmpvYmhSMlU0RjE3eW8zeFkxLzNPaXFvRGdwWjNiY0NlanNP?=
 =?utf-8?B?Mm8wWnZUK3ZYZWU0Z2p6ZXVMdVpEZmIwa25kWUpFbWlMRXhVN0l1ODJkbTAr?=
 =?utf-8?B?eXpRY2dtVWFRUXhRZ0FkTmZWT1VTanFRdnlCWUJqMnp5dlJRTENyTGYva3Qx?=
 =?utf-8?B?ZHAxUVBncjlFdzczaXZxcUg1b1pXRU9NNDY3N1FydGk4eEhEUXdiRVRWNXo3?=
 =?utf-8?B?Qmh5akFMUXIwMFhXM3oyRUg4Q0FQQXRqU0hnYmRxa2UzR0VxMklmOGtkSnF5?=
 =?utf-8?B?NUJlRGpwbWdzVk44YjdOdjhmUVZiL2tEcURtem9LTmQxTE1PdzgrZFJTSU5P?=
 =?utf-8?B?VGFPQSswdHE1SFdmT2Zxa1dnQjdHRVlUK2ttU0kxS0x3OHNSRTFid1pBYVFT?=
 =?utf-8?B?U0V0ejhMdVJjVXFXTy8vNUdXY0NPNWJsUDlGVDFrK1JTam9teFdEaXkwdHlK?=
 =?utf-8?B?VWtlVmpMTFNRU1BHLzZxVzkyQmVVZnFjcTBjeE1sTTJDZGJydWhzc1RCbk44?=
 =?utf-8?B?Z3NqWmJETzErOW5lMzJsdHl4QVlSUWF1VzVGRHBabEQ2OGcxWnNGektxcGox?=
 =?utf-8?B?RllxR3Q0NW0vcjJRUE1KcGJOcDVsNGpFYXJNTy9HTFZtczdRN25lRWR6NHQy?=
 =?utf-8?B?QnYzTDgvZXZDZFlKakZ5ME0zc1NGQjRlcTlmQ3o3TzdmbFZFV2ZmQjYwazdM?=
 =?utf-8?B?WEEwTUlyZUg5VXFFeVF0WnZoQWhEZFhyK2VlTi90aFZkU3pwQ1YrN3RQcVls?=
 =?utf-8?B?NTY1Ry9CTTRDbXRjeVBmTTRpQjEyRmsrSmxFZytobGFIZk45eE5pVmJ1VkxM?=
 =?utf-8?B?NWFyank1S1ZBME8yM2grRm53aXVOTklqeFRiR2ltMEdqd25VcEhVZ3JSSlJJ?=
 =?utf-8?B?bGVxaGVIVWVXdTg2NXYrT0NyMnFhdFNPOThrNjhRQytTR2RocXFRN1l0bjFt?=
 =?utf-8?B?SUZsYlFBQ21Ba3lsa0FRRGx2SERmb0Q3Z3lwWWQxMjhPajRObTZRRmg5ZWYy?=
 =?utf-8?B?SVZrcExqc29MeXFSVTJRZWV6RlVlNVROUTkraWRtcjhQUHB6WkYxVnZ0UUZ5?=
 =?utf-8?B?UFcxd252Y2hTMlQzdzVJMHBvQ3B0eFBTaHJnd1ptWGU0WWRFbVNkWFRoaXRm?=
 =?utf-8?B?eTFuKzRQVjFSU000UEFJM2JmOTZ3ZVhQa3BiSHo3Rno2OFZGTVJNRFJJVUtB?=
 =?utf-8?B?YTVma0Y5aDNPb3VJOEFycEVjaVZ6alRJUlc3Z0ZpeUdTWEgwbW5CVWYrYmxX?=
 =?utf-8?B?aE5LeGVhZjhXcUIvbjdYVHFYZGNGZGtyalpMZ2VVeVdDQ0YyelVjWjNIWExH?=
 =?utf-8?B?THE2RWRINWpxSHlTVlRiZVkzQzVFdnhKMWtWWjlhUHMranprUnppR3pXWFR0?=
 =?utf-8?B?K0RXYTVzcjd5OVBsamdaMDZwNDBESHZMWVdob3J5ZjNWTVpOeWhjTHhud0FL?=
 =?utf-8?B?RFpnSW15Sko1OG5TY1c2T0duODdRTFpXTmVzOUdMaWpHK3Z4T3RFeDBSQ2NN?=
 =?utf-8?Q?WXWvzq3jNyuN/p37FBsf9l7p+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be222f88-d226-4bb9-5317-08dafe3db3d1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 19:03:39.1995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aamyEhHAAc21QywxuMp2QGlk8Jn55Mtzl9haLK3ikARBna5zFC+BW9FhM9IFgvJA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/24/23 11:47, Reinette Chatre wrote:
> Hi Babu,
>
> On 1/24/2023 9:30 AM, Moger, Babu wrote:
>> On 1/24/23 10:59, Reinette Chatre wrote:
>>> On 1/24/2023 8:06 AM, Moger, Babu wrote:
>>>> On 1/24/23 09:10, Borislav Petkov wrote:
>>>>> On Tue, Jan 24, 2023 at 08:11:21AM -0600, Moger, Babu wrote:
>>>>>> Understood. I am planning to add resctrl feature list inside
>>>>>> /sys/fs/resctrl/info/ in my next series.
>>>>> Maybe I wasn't as clear as I hoped for:
>>>>>
>>>>> so you have a couple of flags in /proc/cpuinfo which are actively being used by
>>>>> tools.
>>>> Those flags will be there. Not planning to remove them.
>>>>> Why would you want to move the flags somewhere else and do the extra work for no
>>>>> apparent reason?
>>>> With this series(v12) we have added two new cpuid features(SMBA and BMEC).
>>>>
>>>> But these features are not visible in /proc/cpuinfo. Planning to add them
>>>> in /sys/fs/resctrl/info.
>>>>
>>>> So, users can see them here. 
>>> Could you please elaborate what you are planning to do? 
>> Yes. It is sort of available. But, I wanted to add them explicit using the
>> already available function rdt_cpu_has().
>>
>> Something like.
>>
>> #cat /sys/fs/resctrl/info/features
>>
>>  cmt, mbmtotal, mbmlocal, l3cat, mba, smba, bmec
>>
>>
>> Some of these features can be disabled using boot parameter options. So,
>> this will show only the features which enabled. 
>>
> From what I understand the only feature that needs additional help is CDP
> and it appears in /proc/cpuinfo. For all other features
> /sys/fs/resctrl/info already provides information when they are enabled, no?

Yes. It is available.  But, the feature BMEC is not explicitly available.
I was thinking making all of them explicit. But we can live with that for
now. We can think about this in the future. Thanks for the comments.

Thanks

Babu

> Reinette
>
-- 
Thanks
Babu Moger

