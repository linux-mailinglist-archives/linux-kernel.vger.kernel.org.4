Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3580E6DC2AD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjDJCYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDJCYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:24:15 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2037940FC;
        Sun,  9 Apr 2023 19:24:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZJIGnI9ER3d5+Z1AlT32SqzadhdmWV7p/KuLJM78hJbz47YE5WfqVWwIkEI631AjmxfzAO7s4n6pf9YxM4pzfwBI8vPnWW7bR2qvcOqLuWOBW2GrSKMpVtOUmBL0ZzDxuofatFOwv1GpKd0CB7kmvIaF13qSrUOtT7ihS0VfWYBPBbTHCiwzCVZDniHqIKOl8kAoti6Hm/jGzV6a3HcC/aSRSiqul9xrNc1quiovd4fDzrcyrSgwM6WadNQDCSvDIwU4+yOkIk3XcG3rFIxLEaPCwRvJXVm8YMB6ZO02qKsNm0mQqxoygl+zqRuQ1PHO+bcCLW5lmlUUVp1OZ4MjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuGTfiOIpWqi+RNeC6LGaQPbHkzg5qVivbRAO9c0ubI=;
 b=fK1QHu6lPkcjXkpRpG7BRt+HZty7teozpmSoDg7UelP14itRxOhVdmFdV3zxLQDBDG20MimaWd7sR4FPprq63XNMd8tJF8e6zYhIR8eZW2YC6Y0CX1mX2eix+8YuQZmDFNms5cjQz1XDBZ1oJY7w50gms+XXkZ5LlBjMn5K7GFENvO+bdGbMhPXMwu7Pbflm5Lqt9KwV8tjvnx9pvOnSbIhY0EjVgZs/irKw7H1hZpiymQ19ROa3u1b0n2FRKaecV+OVh6UR9Te3wMs0mfIds3D8g0s30iQzomIDEJ81I8yPo+SaP3zwMCwSWgAHPLTmhXXnrvKq8MqAHaFJ2aDAwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuGTfiOIpWqi+RNeC6LGaQPbHkzg5qVivbRAO9c0ubI=;
 b=VKnO60ZUH1uRSfmLKl72ryVtS8RtuQvrDC3OFreVjMH5KfChVjdVEQZSKcJB7pZg5Kx12kaczK4wfe9sOetRoebSe2rtmjnFTbqk2wYaMkhA+bHDcbbMt0FRpYzgFF10mZaNl99wPfI6N0FI1Rw7j0NFvKyH+Y5ae/N/At3qNdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Mon, 10 Apr
 2023 02:24:12 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%6]) with mapi id 15.20.6277.031; Mon, 10 Apr 2023
 02:24:12 +0000
Message-ID: <631876a2-5946-82d5-6f70-bf7734db3992@amd.com>
Date:   Mon, 10 Apr 2023 07:53:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/9] perf/mem: AMD IBS and generic tools improvements
To:     Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org,
        acme@kernel.org
Cc:     mingo@kernel.org, eranian@google.com, kan.liang@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        leo.yan@linaro.org, kjain@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230407112459.548-1-ravi.bangoria@amd.com>
 <CAM9d7cijvZBsaXTMm8d=sxUWy6s+umCCnWhunD3KVhKbpVp_-A@mail.gmail.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7cijvZBsaXTMm8d=sxUWy6s+umCCnWhunD3KVhKbpVp_-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA0PR12MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: 322bcb7e-c364-45f9-f22f-08db396aab9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dghpCZWT/wCAQSzmHn4g7AVtnSy23PUXM7fWp0EKOyKYOf1EdxgBGIpLqFZFUiDCRbS4qAQKC+Q15breDnEsGOJymn7xmt3PEmknJwQftfAWW7FUnclXOI0O9cWGNPGL2bsyZV4tKw73N57r1kTtjGIkiNAyodNwoYtDCUvgbTaZ0SBt0ypXz12PweyTyjG6kiVs6XA+/+rRP096LHO8TzHDJgGvPmV4SRi2fTwnTe0ZugsxHo9GOCzKiK8DIXRtp2l2yna1MkwwmqmCAixBGs4EwnUt+W1XwFS5NCJswCfYx2CJT6XsPkNoM1TAG6uGVotQFLM/7h2VZnT9PyClUzwD911C8wqEqb+XDw0sgiw23yHrJ97f3MvLmnITUUAOsbc6HzDiCmJ9KAw2XN2GrG3FhRuuk/B95dlYiJwwk5m6qLU8wwxB9BLTR/48SdLFQyjrU9gkCSEU8bN5PDshsozN/xcn6XGDhuqfEU37QDWmVqQzM5ydmwYTiGnP3YuuqmRvZzvcrQQLP2/5Foxwgt4gunm6rDSxhhkgUOx/mx3AYwjfkBCHeg484zaaouezY1Jc6hfiosh/ugyh3S7fjeeqmblUffMmaP+M3+lI8vaMk5iI9TcPg/MT8/Oc7fDNo8VpAJ4rzCAD7OgFZPUOb7MG09bfIxI8LPLe3TOZuOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(8936002)(6666004)(44832011)(7416002)(6486002)(966005)(5660300002)(31696002)(86362001)(66556008)(66476007)(66946007)(8676002)(4326008)(478600001)(38100700002)(316002)(31686004)(2906002)(53546011)(6512007)(6506007)(2616005)(83380400001)(41300700001)(36756003)(186003)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTVoeVdXbGVzV0pHWWhrVzhCVUIwbVFySnFPTFAzNGt6MXY5N2VzK21ucUx5?=
 =?utf-8?B?MnJRbnNZNXAyMkpvNEZYbk43bDVkL2dqbG1NM1kzK1FrY28rQUlyQXZlU1RD?=
 =?utf-8?B?R25HbWtIUmFQdUVDanhMbjl0MCsyd0NJYituUEY1MVJUblVKeThuOHNEajdl?=
 =?utf-8?B?KzVrUmZRWXRyL1MyRWxSSGtXMGFWTytUQlY5dXNhcjA5OEZ6RjNQaFd4eDli?=
 =?utf-8?B?d2hpTURUZnlxaVArd25QSEFKUUtiNjVJY293MEFsZlNWaVVOOGpKbzBIR0ts?=
 =?utf-8?B?QitWWDVOWTQrOUxTd3FKeVZqVnFxVFkwQy90aS9tRGFUd1pvRVdlTnpDazlU?=
 =?utf-8?B?b0FXVzl4N0pSN3cyR2xqeEk2blRoVnNGdjFOREZZMWg5cU1WRUlYWG9WVEsx?=
 =?utf-8?B?ZlJBRkJaTU9kbEtUbm1ZVXg0VkhVbkVmNEpnUnJMQ05FV0NoVytIVi9LZDVp?=
 =?utf-8?B?d2dqZnlZL2FLTERYSHB3TEdpNkc4UXRHY2hMYXVxL3Y1SVVsZlU0MVN6bHQw?=
 =?utf-8?B?YjRzemlCRzBHQm95ZFA0TDA5clczWC9jUUJlTzdkREwyaFE3VmFOQk1YVFJU?=
 =?utf-8?B?WHV4cGNxTnlrSGc5Ni9rZ1BQaU9WWlUzcjV5NUpyUk9xUjZMa0lOVFBiWUJv?=
 =?utf-8?B?allUSzcxbEtqaUdhTEI3Vk91Vk8ycjhrRW0ybWM1bkVxTWdzU0JIU0JJd3Rq?=
 =?utf-8?B?NU03MDU3bFVMeXRMdk9oZjNjRlFmZXJ3UkIzRit4dkdQMS9OM3RQSjRKZ1ZM?=
 =?utf-8?B?Q0J6WUJ6ZVB5cFJiNUFuUlloMWRGTlp1bnJBR0RvZ0ZpRWFvQ2RvS2VuNDdE?=
 =?utf-8?B?aTh3K3p4MTdnNXYwTW9QMnpvbS9PenE3aTY1MkdmS2V3WVNVTmo2SnQ1M3Vh?=
 =?utf-8?B?WVNVRVRkTUROVzc4c0E5VHBDZjluVUYyMFpzQXVhVytEcjk0ZkxhcWVTSnYy?=
 =?utf-8?B?cUM4Y0tTNkZCMDZ4WThyNnJZck9QOU91aGkvbld1dkcvVlBrRVFaQmdwQ1NR?=
 =?utf-8?B?RnBZOVg2TndRVUFYcVJFeis1bDExYzFtaE5hVzdvZnFyNkFhamhoMFZnVG9j?=
 =?utf-8?B?NEEyTzkva3krMFBvQ1diN05VeWU5YUw4RlhlMzdEQUJITEtaN3lTemxZZUZE?=
 =?utf-8?B?RWVaUXFDblg0RGZDa0t6dXUrZ3ZqNFl3MThiclovR0hycEJ4a2RyaVFuMjFT?=
 =?utf-8?B?VlFSNXI2VGNReGZOTXZLbzFkZ21TVmVHT1lhdDNka1RkQ1BwK3lmYWt2ZmNk?=
 =?utf-8?B?c3dScmZ4U0UwN1VybE9WRndscitpMDJ0eWVwTm9seTVESmczVmJQeWNiRTh2?=
 =?utf-8?B?bmpGeGg3TUN4ZnU5aXpjRlYyMW5RUHBkRjY4bW5mMDgrYVlrOUtiRnMwNnVk?=
 =?utf-8?B?VlVIbWRIQldFeU81ZEtBeVY5ay9aa0szR3BaNU55Tm1KaUpndXgxUC96RzNP?=
 =?utf-8?B?T2hkZUo1OFRxSkg2MDR2L0NaM0MxRGxVVGNtZFdOQ3l2Qy9YTTZPOGIyb2d0?=
 =?utf-8?B?SDl6WmhlUlFhM3l3TmUwSUtyVzh3TzE1WkZlZzZieE1QQ2Qzait1OTZTZkQ0?=
 =?utf-8?B?TWp1NG9xck9rQ3JBcHpsMDhBYllhNzJ4S1V0WHNrQXIyaStEc3hkajNMWmxI?=
 =?utf-8?B?N29SZmRhektVUkMvWHRKUzNFRzZuak5XUHo0dGZIbmlPbmVNSFdWcGY1OGQ5?=
 =?utf-8?B?SEFKTjlvWW00L2lxbXNrc3FBMWs5U1dDT1RzTUwzZXFSVWlqczZKVmUwak0v?=
 =?utf-8?B?bTdUb3lFNTEvSmxBbDM2d1Q1LzM2azIwSEpRM1hveHY0Ujg1aWpTU0U3MXpM?=
 =?utf-8?B?bDhTancrTXMwREtXM0sySUZpK2RBV2xvT0RTbGRzVVkyMjBqVEhwajVHNEt1?=
 =?utf-8?B?OHU2UnVHZ2w0SmVDREZLTnpuSUhSaDJyR2xWZ1AzaWNWNTdWZHlLd3VWOCtH?=
 =?utf-8?B?c09MZzlPWG9zRkNPekZkaWFwZTBGOTlmRjB0MXc5MVl5WGpBS0lRaGMyVVNl?=
 =?utf-8?B?SGtiNlFYYjE5bjFpWm5malM5eUJuQ3FDK0pTSm5BWHMrV1Myb1pNeXd0TW1E?=
 =?utf-8?B?NmFHc0xOVGxreW82bFd2aUp1aG1UZmVmb25RRk1raDZodEdpUTJpQUM5MXlw?=
 =?utf-8?B?cC96YkZHZFQ3TmttSnI3dGpsTmF3Z05uQ0gvMnV5ckQxcDRPRlM1WkJvMk0y?=
 =?utf-8?Q?wxjBDaoBoC0FXmAh6uKduMj+Jy6GZ7J7k+WMMevh9QWY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322bcb7e-c364-45f9-f22f-08db396aab9d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 02:24:12.1440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Acecajb+tKFlDHBGrsMJ4Dn+F524v5UwpYaLRxScpw5ebBE4R6UtDdoOloYjrEcKN8Wy7Z2jF3N6hpBdDPRXmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-Apr-23 3:14 AM, Namhyung Kim wrote:
> Hi Ravi,
> 
> On Fri, Apr 7, 2023 at 4:25 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> Kernel IBS driver wasn't using new PERF_MEM_* APIs due to some of its
>> limitations. Mainly:
>>
>> 1. mem_lvl_num doesn't allow setting multiple sources whereas old API
>>    allows it. Setting multiple data sources is useful because IBS on
>>    pre-zen4 uarch doesn't provide fine granular DataSrc details (there
>>    is only one such DataSrc(2h) though).
>> 2. perf mem sorting logic (sort__lvl_cmp()) ignores mem_lvl_num. perf
>>    c2c (c2c_decode_stats()) does not use mem_lvl_num at all. perf mem
>>    prints mem_lvl and mem_lvl_num both if both are set, which is ugly.
>>
>> Set mem_lvl_num, mem_remote and mem_hops for data_src via IBS. Handle
>> first issue using mem_lvl_num = ANY_CACHE | HOPS_0. In addition to
>> setting new API fields, convert all individual field assignments to
>> compile time wrapper macros built using PERF_MEM_S(). Also convert
>> DataSrc conditional code to array lookups.
>>
>> Interpretation of perf_mem_data_src by perf_mem__lvl_scnprintf() was
>> non-intuitive. Make it sane.
> 
> Looks good, but I think you need to split kernel and user patches.

Patch #1 to #3 are kernel changes. Patch #4 to #9 are userspace changes.
Arnaldo, Peter, please let me know if you wants to split the series and
resend.

> 
>>
>> v2: https://lore.kernel.org/r/20230327130851.1565-1-ravi.bangoria%40amd.com
>> v2->v3:
>>   - IBS: Don't club RmtNode with DataSrc=7 (IO)
>>   - Make perf_mem__lvl_scnprintf() more sane
>>   - Introduce PERF_MEM_LVLNUM_UNC, set it along with PERF_MEM_LVL_UNC
>>     and interpreat it in tool.
>>   - Add PERF_MEM_LVLNUM_NA to default data_src value
>>   - Change some of the IBS bit description according to latest PPR
>>
>> Namhyung Kim (1):
>>   perf/x86/ibs: Set mem_lvl_num, mem_remote and mem_hops for data_src
>>
>> Ravi Bangoria (8):
>>   perf/mem: Introduce PERF_MEM_LVLNUM_UNC
>>   perf/mem: Add PERF_MEM_LVLNUM_NA to PERF_MEM_NA
>>   perf headers: Sync uapi/linux/perf_event.h
>>   perf mem: Add PERF_MEM_LVLNUM_NA to PERF_MEM_DATA_SRC_NONE
>>   perf mem: Add support for printing PERF_MEM_LVLNUM_UNC
>>   perf mem: Refactor perf_mem__lvl_scnprintf()
>>   perf mem: Increase HISTC_MEM_LVL column size to 39 chars
>>   perf script ibs: Change bit description according to latest PPR
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks!
