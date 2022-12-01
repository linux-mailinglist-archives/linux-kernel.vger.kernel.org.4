Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1B563F54B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiLAQaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLAQaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:30:05 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4312D74C;
        Thu,  1 Dec 2022 08:30:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzLIBit0fIaelM2CIr2/XMtbyUKgCidh5jANIiNTPZKYScFo0kfL+wzssYwwMkkcksyRvF0jF5/SbTPyCreHyCm0XZUPtK8XPTANNtt+0SrBMys85Qac+GBLyZVYnY7AYueAVpN4CtoJP8IvNO1p/ZhSS2kAQJvUkaNI701bZrHIYxvX2asOsUA2NHvJ/vYA0AJMbyMTpwOSbwcU7i02KexU6/3d+OEhz3diFcTxcUFllDjKFe0nmeQj0CX4uT/rqrPBlKGE8roW6pK/J7DqoEUIUXUaG0kpZK2+YMT8ZK/17+e5PGWlzmkOEb1Pg2OVwktJVlOdZpG7hl5EXdWR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEZ4KkIvXt2tTjBzl9LvSVwLGOfViGUudlZs2gb8gS8=;
 b=AQlYMaq/J/aDFfbnMInTC/HjG3kCzaHfHCIMp7jIlE5VxcKR0GTGb77qW4wuhHpdgzbG6Fwg1r+G4rNYdTRWIXKPFI2fWUk8Lbh3Z3/A/oFZCRYXDgqVp0F6yLAQd38Ykd8sF9zixbOs5d8xlob0ct2Mlt7SwK7As5wNPBA0JoNBfgCBOqOYd4+fsTPayoliSHLk0JmITwYWsuvyCw5FDrMRbK1Ow/pwbXnv882E/vPgcUjtIhy9+d4F7XjKOm+H5KrNZ3g2C5/Dgyh62XUn6/Z2m1oqGcz2JqMrcSQeTJwcoMaX0nzQRGyq7TsMsdv2QNUK5h2TD3Wbziod4bYc8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEZ4KkIvXt2tTjBzl9LvSVwLGOfViGUudlZs2gb8gS8=;
 b=myHqng2KqjkdBB8yHBo3me2u2cPoBuklaqCTPdfGelf2o5b5rtlJhFDgz6KoQFkbkRMskRl2UClvG1FNa4NaTjSdLnkBpqbviTqFXY2VJC/eROhrIr+o85mBoj+a0fMq41BTqrocvozOXGssGVD96yZQOwjCRSw3pZNImwGr6nE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Thu, 1 Dec 2022 16:30:01 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981%9]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 16:30:01 +0000
Message-ID: <b47c4bc7-aed3-e1a0-c791-818af091d976@amd.com>
Date:   Thu, 1 Dec 2022 21:59:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 2/2] perf test: Add event group test
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     irogers@google.com, acme@kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
        carsten.haitzler@arm.com, leo.yan@linaro.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        tmricht@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20221129111946.409-1-ravi.bangoria@amd.com>
 <20221129111946.409-3-ravi.bangoria@amd.com>
 <0dd566ab-38fd-2204-f59c-e74b2244828b@linux.intel.com>
 <62399b9c-d5ef-4c56-4592-d2cf1af503d6@amd.com>
 <7449d858-2110-1ddf-f7e1-013015cbd791@linux.intel.com>
 <0eb0cc59-d28d-8e42-3233-2587123e291d@amd.com>
 <c5e97f0e-0039-7e9f-299f-c0d03a6ac33e@linux.intel.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <c5e97f0e-0039-7e9f-299f-c0d03a6ac33e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::33) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d9ce14-98df-4245-6b68-08dad3b94a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twXdwUyjOo+bEWLmspluoJI6PEWpQTlhEdneEBGK6EJGlqr8L1XCxr909iuuphJp1U9gLqiHmpFcNzKO4NmOAOW/5LiRswcl+rnF+G5JGpOQNXdz2siZVouN73wi0vnUGmqTn4dqMvefi9Zv1XK5VGzoKzrLSvsG5f7eYqmHngtRPME10rJv7poG6d4zNSwXBFxleiSnXTr4OFTVQ798FPZBOxOFG1osxYvXkWaL2u/OwVp92MqfXhJtHhoeMmXz9HLLmGLhbzZhL99Xug0IgyGHWxbfQdwgHDVrbJKex6LUw6D392B/HAVLsRlXmMhKdH1nzDE7xUdM5pPbkhI78uPjC30FA+H7sC439+OVqNWyDLQ5HL2XaBZmHwylGW9mhi8HgDz7jeYfcCYBGMTJ0/8yzgUSfegMH2v5UxLTQZApZRn57bv6AXw797wEnzBEiKDpHb0siT1qOIHQEP8Qt/ORXRkNd1xUD7lEbM8DgLOtkQlt/+aLsw/vnaq7MQeBuhswqBqcmifKZHFA3mxOcNBCQ9GzNrYhTLmkBBHtQllAJnEgGo4VdJj8+4rpET4fiTQQHIdtZZ+MoQWhPFH3JlCQUIEzrak5tvILqNClL2eQ5GTs/Lp3206xkc7nj8f9ySDv51gUHAQ4LhK0aftHOrCHcMzmKoyf85lSxUiA8lUGFy50/7/nUzNA+dGZi58QMuDYKtdOoJit9wAgCfxwK5mpgWWyR/8l41OQZHO0+ZPQCEjGmOL2xcTFRwJZ5H7u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(7416002)(31686004)(478600001)(6666004)(186003)(38100700002)(6486002)(5660300002)(53546011)(8936002)(6916009)(6512007)(316002)(26005)(36756003)(2906002)(66946007)(2616005)(6506007)(66556008)(86362001)(8676002)(44832011)(66476007)(4326008)(31696002)(41300700001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWE0K1A0TDl5STRkVVJzMURrWC85dGZpMkQwenVWYzNnZkVGaXhXVjlwekFD?=
 =?utf-8?B?bk9KTXE2eW04WE1FbGNGYUgwYjBuSi9sSWJsZVRMUHoxTE1WOWJNbW15WGVB?=
 =?utf-8?B?VGtlVG1RTTU1R1FYdlpDQzA5TnluenY2M2JmZ2IySWhiTHBQRDIrNG5YcTVm?=
 =?utf-8?B?TXBXMmlxR3lNSENiWkJQek5hT3FSc3U2ZDQwMHJ4RVFUb1N5ejdPM0NXZVQz?=
 =?utf-8?B?OG5Odm1jL0k3Um1TYWVBOFhBa3F5Z2pXbHFSL21LMTlkdlFmbVQ2UnhiWUls?=
 =?utf-8?B?UUs5YUlpdGJlSWZGalNxbkRSYW5ZU3Naa2tqRlU5NFMzUmVSQ1prZ0JSWm9y?=
 =?utf-8?B?U0RaRWpFa1dJZlN6V1k3VkY2czd5ekVjQ0hSelA1ZitCWWpaR3Uyamt0dFBo?=
 =?utf-8?B?aWtkUWlyT3p5K1ZHVEpqK0E4QVlRajJWMW5icysvRWJwQ25xaDZJMUlqWHNs?=
 =?utf-8?B?RFRqS2dXR2I3L2lLNyt2NE1uQzZQSVNIbjBiSWY1aHlkUzJJc000NHNPNlVh?=
 =?utf-8?B?U3NiZ1N2bmI3VXN3V3lmbGR0UldwY1BzMFhBMXFHSmozZC9jSWlnb1VBT0lJ?=
 =?utf-8?B?Tm05aU9OL0EyQTB1TkxST21yaVBld05jYmZ3MDd0UUxuUSthbDAwUjA0OGxH?=
 =?utf-8?B?aEVTQ1QrV3UwQ01nRldWVGkwM1c2dkFTdmpsVC9Sanp6ZlY4TWhRa2tjZU8w?=
 =?utf-8?B?TlYrM3FTN214ZElwajB4eVJQSGMyd0s2MDNTaWt6SVBlamlLSW42dzY1R3ht?=
 =?utf-8?B?WVNtc0IwanF5MjBRcmROZlBld3U2NVVXY3dLZURmMU5tRVVRUVNRZE90RU5w?=
 =?utf-8?B?UnVmWmJ1bndodXdqTHU0RStEdE83SU5YVitGMVRhdEtWT3R4MWEwNm8yTUE1?=
 =?utf-8?B?VzU0MEphNXEyK1ovTDVacUswZ1N0eXlFaHBZR3k4TmpQTlhMcVZKNWVKc3BZ?=
 =?utf-8?B?QlkwRXlLK3haMHptTENhcGxXUHNYMGYwV0pkdGtYT3BlaU4ybUNaNTJLOUpB?=
 =?utf-8?B?b3Zpa0lWZEdyNFA1S2pyYmwrdnlHeEUxTUNHSWFieFYvamEwNG41WUtYdEwv?=
 =?utf-8?B?TUQ0OHEzWlpJTDRFVzZqWERWeTQwa3NqZkpnNnA0VnNYZ0hUS0pyVUpzcVNt?=
 =?utf-8?B?VGd6cEYrbFJVSUlsc3RIakZPMEFCNVlJeFhTeWVSQW8zZ0ZLWnd2dDdxUTFt?=
 =?utf-8?B?WUdTMXQwT0FaS0ZEeDNOcUNZMnlXQ1FzeElWSkNPcEVlZmpPQ09tUEdFZkg5?=
 =?utf-8?B?L1M3TGFCSnk2NVBGc0w4Y0NDK1IvbzJaNXZoc2FuSExod1FyUTArUGR1enRQ?=
 =?utf-8?B?MUppMXd0NGhlL1R3SzZScU1ldWd6eEJYa2dmUitIckppUGJ0VmhJQmovdTFK?=
 =?utf-8?B?L3hQS1VYNndpTVRCWkRlSnRPMmJ5UVE0eVBpdXBMZG9pQ3REYWh4b0JwU1dP?=
 =?utf-8?B?dWtBcUpDL0tEdXFZZDRYVHFlQ2k3b3ZkVzFGekRUQ2FkWDRPNyt5VE1kTkpD?=
 =?utf-8?B?bVEvcTJIaWlpaHNQNjB5Q0ZuVDRXU2hGZmFsMEtaSytzSUNOWTVncTdZdmFC?=
 =?utf-8?B?VG1RbDlndFM3cGZkb0FzL1pmdEtOMFVDMi9xUzVPSld6eGVHZExaSTJENDRx?=
 =?utf-8?B?VUNaRUpzVW1PbnZLVmExNFRXRWw3SDRabE43am0zQ29PSTNkakZHeHcra3hG?=
 =?utf-8?B?Z2pSMThWSWl6SklBTXBJSkJKeFI4WitvL2lZbklHUEdOTjAvK1FUY1dTb2dN?=
 =?utf-8?B?YVhtOGtnMVFZTkdjczFLczhDOHk0RW9tSE9FdGowRUpqc3VhY21rRXpObmtn?=
 =?utf-8?B?amRKaWFiVmVad3VPc0hpUjRMeURmb21NNVAyS3pGc1JQMlQ2SjlIZWMrVDVh?=
 =?utf-8?B?cVMxcVlmQkUrcVk1ZWZXa0NsQ1lDVnBDRUErUkNwYmRMVWRZWTdhWlpQdkZU?=
 =?utf-8?B?YWNGQzlPZG9MWkwyZmNiRlA1eVYvcjFsTjU4ZlhoN2pmQ01nWTkvNklUMkt5?=
 =?utf-8?B?R0htcjZGZ2N3R2REei92UXVWSUhKZXVMSmtVU1pzYWE2ZFQ1R2hxeTl6eUxH?=
 =?utf-8?B?TUJ1OURWUEo0blFSQW1uQ3FKdk5SRGNldytzZlBWM1RLZnhYRHROTFpXUGR6?=
 =?utf-8?Q?ywlaMN3ysefgRAXjWiP30tsBT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d9ce14-98df-4245-6b68-08dad3b94a70
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 16:30:01.5295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4U2yIAzPkBlPvGCyGGYtP/d+wfeHpRuP3zL22psTvAlpXIJR7yhAykxvEUO5I0LvlvRXAsMowsvpK8jLYDiAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-Dec-22 9:17 PM, Liang, Kan wrote:
> 
> 
> On 2022-12-01 10:29 a.m., Ravi Bangoria wrote:
>>>>   /* Uncore pmus that support more than 3 counters */
>>>>   static struct uncore_pmus {
>>>>       char *name;
>>>>       unsigned long config;
>>>>   } uncore_pmus[] = {
>>>>       { "amd_l3",         0x0  },
>>>>       { "amd_df",         0x0  },
>>>>       { "uncore_imc_xxx", 0xff },   /* Intel */
>>>
>>> IMC seems a safe choice. AFAIK, we should have at least uncore_imc_0 for
>>> all the existing Intel platforms. { "uncore_imc_0", 0x1 }
>>
>> Ok. Ian said he don't see uncore_imc_0 on his tigerlake machine. Are you
>> sure uncore_imc_0 should be present on all existing Intel platforms?
> 
> For TGL and older client platforms, there is only free running IMC
> counters. For other uncore PMUs on the old client platforms, I cannot
> guarantee that then always have more then 2 counters. I think you can
> skip the uncore test for these old platforms if you need at least 3
> counters.
> 
> 
>>
>>>>       { "intel_xxx_pmu2", 0xff },   /* Intel */
>>>
>>> Intel doesn't have such uncore PMUs.
>>
>> Yeah this was just for example purpose.
>>
>>>>       { "abc_pmu1",       0x0  },   /* Arm */
>>>>       { "hv_24x7",        0xa  },   /* PowerPC */
>>>>       { ...                    },
>>>>   };
>>>>
>>>>   perf_pmus__for_each_pmu(pmu) {
>>>>       if (pmu present in uncore_pmus[])
>>>>           type[2] = pmu->type;
>>>>           config[2] = pmu->config;>   }
>>>
>>>
>>> Not sure the uncore_pmus[] can cover all possible names for all
>>> architectures.
>>
>> It doesn't need to cover _all_ possible names. It just needs to cover
>> minimal set of names which can cover all platforms for that architecture.
>>>> Maybe we should fall back to the first uncore PMU and try again if
>>> nothing match the uncore_pmus[].
>>
>> That's a good point. However, this can endup with the same problem you
>> mentioned: it may trigger false alarm on some platform. So better to
>> skip the test(and let someone add proper pmu in this list) rather than
>> proving false negative result?
> 
> OK. Skipping the test for this case sounds good to me.

Thanks. Will respin with this change.

Ravi
