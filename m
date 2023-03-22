Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6143D6C4CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjCVOCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjCVOB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:01:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CD7166D6;
        Wed, 22 Mar 2023 07:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPi/Q5KibMOZL8vD9Yi91sjLVEpn3y3LO0UZaXMutUd96GC02Nv32aq2625z4t0hPAVyiPDfCVClQV+L68sGhRq8Fiw3kB4oQ7uJxuBjNo1gnw8rCu3g7bU9/UYqK/nBXdIn6s8DCznuggqm/yLY0Qs3USY1SSUiFy/l1dz+1gpzgYs9lWUhstT5LjxzTs3v9BLy5h0pqI5XAXXnkVrXvM0AeuSGADQiD5HOP1CUmVL/u+Q1pmHb3yzYZ4q0iYUntshImo1DwGWKk6oDUNWlB2/SYoZM0g4dup+SCdotzw2KvYnkoML8D9sRA3WPHfNugqHwFYeX3eliuJsEjz8nDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjSTvQotiGP3v3KW7hLvc7QiZTYVRBH7Cl1nFgYEOFs=;
 b=YqPq25eoKm4oUjGAzxBm2DOX+ZKw08LO5p0emQhrYcxsVHGSkYD0+r1bcBX4PUojs9SIIE1QxUm+MyGDGCIcAqTAIVlu7AsIswoOu6lY7HZRpuIWtsO2EP6t6XodZ658Qcw3QalcrJ5xgJKBOYhUvZO22AOJoMGWFd0PXrQlTNleggkaZ4PN8TSPjXRc9u9NG7afUneczIXI7fl8mLXrrC3ymKTBO1ed0P+rs7q40Dl/et0OCQv07mQCG21GEMrt48DTPmyTQQK1sPI1YMaYETjk6gM7qL+ItYDe9MPfYXxcwYvDn2+iUtozwSuZVt4JjFGzlPEd9L8gTiPntKJvcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjSTvQotiGP3v3KW7hLvc7QiZTYVRBH7Cl1nFgYEOFs=;
 b=aD3NdFGi3HaB56YJHXCPPwde5i27fY1Yiaqw6gTVeRB1vdLNLORu0VSYAjNpOUFilz8gP3XRd4BGphVajRHUzPYnzJKmYLUDLzmIH5kU4nSg1jHHa6OtEmeWYpW9xj6Svl3VXfoUT4SfceElrym1PxPk68/OWM9sKvR3U4XeJDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA0PR12MB4541.namprd12.prod.outlook.com (2603:10b6:806:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 14:01:50 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%8]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 14:01:50 +0000
Message-ID: <ff10ac75-2f05-1237-f1a4-d3e68dde99b9@amd.com>
Date:   Wed, 22 Mar 2023 09:01:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 6/7] x86/resctrl: Introduce -o debug mount option
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778870113.1053859.9553109061915206299.stgit@bmoger-ubuntu>
 <4c33772b-fbb8-70ae-cbbb-2d93cc87e4f7@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <4c33772b-fbb8-70ae-cbbb-2d93cc87e4f7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:208:329::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA0PR12MB4541:EE_
X-MS-Office365-Filtering-Correlation-Id: b3724cb0-5c9d-4d00-9882-08db2addfb61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mnQ/VD0EQra09SAe9EpKjlSErNnakLbe3aKMT8zIVwmkHnAzhHGEbMhyqUqPWdnMXaZ7Xy7GOgSUbPpkfPokB8Eg0wiV9m6Fh2lZNjWZFAMojITFukHkbJuc+t4tMQfGcFA6iLhF8mthdyY67k6O6HoUdSONWqXS5b0SWOsuwCQ54HiJPr9Zuvptffd8o3NJk+wX9LkHsvESQWDjl52QOMQ37SMd3g6T4hNKakKWEzbCspmSyfEz51YkuSIJ2wCgrcY6ZsZtQETLBCi6/yY8mjuPDtEhp5E4u6Abi/wmoRhz7RImVHaJHJvp/ckRm+cihRc0MR3WhMJfnUp+X9oB5HNI1fV9zUCpmRau77BjlOPlQg0VVDtdqowFoy1SJ4azd7nJ20UoNtPCLDRwsZ/c7kdwygX2UfP9VWN7cAxUWtSv+pd1j1B61yg0EBrEC4GIZ1yBp9BpBaL+SVs7D7K4IAP06esyR3/8oEvRAH2KTATC8OM7nKaXfshVajuw2Zl8QJBuYWA/bbvy5JcL9GsjlB9AjB49wvnWEHkrlpQAePdGa7JortpmwxmdivwuDC6IxIrKNw6q6Tb0v55Z8rnEl6eenKZADgRt59n+7J8uIUecfDmEyQIqBFtAHmOMEQ1WIv+dR+PPudZs/ilBDyyQdIfqjfzkDQJT8A0lPeYlCZs0ScoQ2zoslrama658KRbRYn6XChYteDM/QGcleRXN1xDzt2KLIXglZIcmXN8q1/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199018)(31686004)(6512007)(186003)(86362001)(6666004)(53546011)(26005)(6506007)(31696002)(2906002)(8676002)(4326008)(41300700001)(478600001)(66946007)(316002)(66556008)(66476007)(5660300002)(8936002)(6486002)(7406005)(83380400001)(2616005)(36756003)(3450700001)(38100700002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnQ0ZmRqU2JzSFJDdGFtMzh4OU56Wnk5RW1NODBVaHhpa2pCQnRoeWlzU0wr?=
 =?utf-8?B?ekdCdkFtZUg5aHpkS2tDK1g0a1ZqNG4vVVZycWZWUGZldHNsR2QxWkpES2xR?=
 =?utf-8?B?Q0JJUlhEcElGYnhxL2Z4Y3FPNEVyS2ZrSlhmTkJzeGxZdXhVam5QZlFHRWpv?=
 =?utf-8?B?Wm5NNHoxSkhBTEsyZFFDR2EzVW42V2txQXdBZEFBY2daYWE4a3lZcHhvdEdp?=
 =?utf-8?B?Mk9sMFMrbC9ILzdHRDNFeXpLSmE1MTlia1BJQU5VdmI2NEdvenEvZEhxbitx?=
 =?utf-8?B?L0RwcE9sbE1sTnAwelZSWmtVYnQ2ZjJyM2x5R2RZeXBLaG1KNnBuWVJEL2Rq?=
 =?utf-8?B?UmQxa0ZJZ0VJTm9jZ2E1cUNyL1JhQ29ZV291ZlljZmtia2RSL3dTNFRZMTdy?=
 =?utf-8?B?QjVucGNlK2pRZjhaNFVqU0s1aWpraUJjeWYweHB1bkw1YTJqRnZxb3psNHVZ?=
 =?utf-8?B?c2hWVFU1QkJreVVRYTFFK2ZPVVFMRXFUZ2JqTDEwd29wZVhnYy9yU29FRWtm?=
 =?utf-8?B?QkxuR2tveTZWSkJKOG00K2lUMDMvZjQ3QmpqZkphQ1F5dDdDa0Y1WmpVOTZO?=
 =?utf-8?B?aWp5dUpXcGhDWEdxc0hzeDZlVUJxUGZITjM4bDJ2TE5hWXgxcWVSbUhSeUZS?=
 =?utf-8?B?T0ZwamRJVVZDcytMZ1YxSFc2VFI5WS9zVjRnSmNzOFBTYk0wdVV0M1R3WTBp?=
 =?utf-8?B?ZS95TTZSbExxa3AyVVRRN3ArdXkzQWNDdmp0R1NBWVBjSUYvMk9wcjUzeEM4?=
 =?utf-8?B?Mjg2d3lMbE1hd050a0dwV0o0UmUycWNqWE44ZHZWNUlFVXZtTTVHVnJKM2VK?=
 =?utf-8?B?QlJ4SnQ0aTJtblllSmNDVG1pUzZNbklZS1ErbWxLbEFVNEVQOG5tNlhZY3N2?=
 =?utf-8?B?Q1p1SVBsNXJ6cEx6a0JJNjRiMkFvaGZoTXUwcnQ3Z1JLcU1DblVmRk50TUtK?=
 =?utf-8?B?eWIzNkFOVENjQXNnMHB2U0FvVjdRNWVEaXhIbW82dXQrM1dkMUdMUTdVb2tw?=
 =?utf-8?B?WVFlb1Vxd0IxNlREZW1kS0M4OFhFYTM5NEx6TXRqcTJqNXR6VXZlNFN1RXZD?=
 =?utf-8?B?eC81dTdBUkJGTmNlTFpxNEsraHFiMDFtM0dlRkNab2tmSHU0NGljL0xMTFpN?=
 =?utf-8?B?VkhoeXBwNDVvYVhGd0RTZGQ4RW5NNzNWU0NKS25JT1QzWlVPUDYyL2VDbkN1?=
 =?utf-8?B?UGFVcmFrZkdtQURTdC92VHoxbFh3Vlo2Yy9kRlpYNE5OcHg3WW1LeDZUWkFI?=
 =?utf-8?B?a2IvRWpBVnF6OUpDYzQvTlpXd2ZwZFNxekU2cVFtcDdTVU4vTEtUWXdDUncw?=
 =?utf-8?B?WERKaFdDUWVxOFFrclFYc3R0TmVzVy9kdlE0bkRWSE1kekZsVFNObGo2aDUv?=
 =?utf-8?B?NHNkWDV0SzBGd3RycG1GQUZRdFVFcUhmTnNxczZiMVNPT3ltSVMrbFZraTFE?=
 =?utf-8?B?ckQyYStSN3I5ODkvTk4vN2RYTHNBU1VhTEJxNWFPZklxOFZxWGFtME96MnNU?=
 =?utf-8?B?Qmw5Q3hVQ2NpYWowVmxPbjZ0VEVQYys2aDRQWUp1V0laTGtJMlBrakpYN1RS?=
 =?utf-8?B?Zm9VcVRLdk9Ob3U3VUdDOXJwT3luT3MydkFpa3hIaU1pNlpGWnl4alJQV0xh?=
 =?utf-8?B?TXJOc1RQTm5qcm1zM2tSY2JjV09BYlNqYmxvaHMrdGZ4R2ZZemV3MWFkNUdm?=
 =?utf-8?B?eWk5aXRUdFJyRnk3L1llTmZqL0t2RExXejJBa2M1Z2l1Z2o1cHo4cDBXZWhM?=
 =?utf-8?B?NW5FVUxaa29qU21YcytXenVNdzJQTEl0ZzN2N3pIQnA2REtNRmtTTEhsU2xB?=
 =?utf-8?B?azk1SU1FbTVtL1pRQ2lDeVY4YllyMVh0TmRUWS82VlVIMTQzSkg1RndUNnlt?=
 =?utf-8?B?VG5ZL2VlOGdKdXQ2L1FBUkx3OFJwUXk5c2hmUGM1cDJFSDRyc29idndGUlVB?=
 =?utf-8?B?a3hRTmF6U2hVTC9BSzZWTXdBZEFYdk94cTh5QnNpaWpidDd6UjFyKzduK3Ex?=
 =?utf-8?B?aVloMjBPWHZhdWhaRlJXR1FCakk5bW1Lb3R5VnJjQm13byt6eHZHMm1FR1FP?=
 =?utf-8?B?dDdiM3lxMlFna2V3NGN3ZCtpZElTRjl5YStkT3U1M0hGYUxsaWphWXpERnZt?=
 =?utf-8?Q?ZeNqYTXmItZj4A0S7/0n5Yuyy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3724cb0-5c9d-4d00-9882-08db2addfb61
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 14:01:49.9185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYVMRqvE80DeMGJ96gzM6GyCAxxJu46/IzVrjxRcaNcvyRu7m5qBKBRm5cAHA2ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4541
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/23 13:43, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/2/2023 12:25 PM, Babu Moger wrote:
>> Add -o debug option to mount resctrl filesystem in debug mode. Debug
>> option adds the files for debug purposes.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  Documentation/x86/resctrl.rst          |    2 ++
>>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   13 +++++++++++++
>>  3 files changed, 16 insertions(+)
>>
>> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
>> index 67eae74fe40c..1ada4e0650dc 100644
>> --- a/Documentation/x86/resctrl.rst
>> +++ b/Documentation/x86/resctrl.rst
>> @@ -46,6 +46,8 @@ mount options are:
>>  "mba_MBps":
>>  	Enable the MBA Software Controller(mba_sc) to specify MBA
>>  	bandwidth in MBps
>> +"debug":
>> +	Lists the debug files in resctrl interface
>>  
> 
> This seems to imply that a listing of available debug flags
> will be displayed. How about something like "Make debug files
> accessible. Available debug files are annotated with "Available
> only with debug option"." (please feel free to improve).

Sure.

> 
>>  L2 and L3 CDP are controlled separately.
>>  
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 6767c85b9699..35a9ee343fe0 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -59,6 +59,7 @@ struct rdt_fs_context {
>>  	bool				enable_cdpl2;
>>  	bool				enable_cdpl3;
>>  	bool				enable_mba_mbps;
>> +	bool				debug;
> 
> Why not follow the prefix of existing flags?

Ok. Sure. Will change it.

-- 
Thanks
Babu Moger
