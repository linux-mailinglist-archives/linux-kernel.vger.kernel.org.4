Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513676DD86F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDKK6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDKK6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:58:06 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B183D40F8;
        Tue, 11 Apr 2023 03:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tr8xDiOFm1Uct+L10NCkTiyvNfRJCVyCthdKfTG/14z8OodvBlXGEEiSGvIAvk1TSjK0/2430P4zJ0EZV29tb0eYx4oMRSA8fb8AGGpC12StigFcR5YkhB8/1SN6lUfE12AIoDNRS9V8jpY1V6wdh+ZjCMULBpRfYiVH4vcxMeXRjz6XAzK0c3AorsIzqYMQw4TiqSJ7DTGfkjhvkL2c0mr6TPwPL+a8NUfXxFkZ/XURBKWft1NF6hy2xwYmFJHKbf0DUAEGVNlMOUpzn8x+d+SDPU+OBoPR+mme67c+rATwczvV0no6tc1KfcC3XdB8B59/0YJ/DWc+Ha5SNkDtng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plVIOzz+AWYpXQ8j/tx9DYTtY+wfe9TMF4LlPt15uhE=;
 b=SbIH5D7nroVe4Mv32vjlQAAS5eJN/FzFyHSKnPxNZypC55TvRJha9hED3kBX3TgBjyXO/cfv4BYIVm01Yu9/I8sCtDsgrV+BJ75Rrpj5n8roP8ZkRDJ9uA2FdGMR5EIcxDi8QcSlkNZYyc07BeCzZ8HclTV8xKPBw0MNz0ZIe9IcXkBjXWb5+0AghilkcHfJXRt2h8086y3VfRaqBIyP6kB3HbhjWBiUyLj/GNYWBUQkgYT1C5X7cMIummnO/EAsZDiSyFjRIQrGZzM0lOfflYV615zG1P8r4M96YYtUE8l9/MyyX21fsxVqz0bkoEqbEnw2a38WO2et4hK4l/EF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plVIOzz+AWYpXQ8j/tx9DYTtY+wfe9TMF4LlPt15uhE=;
 b=fTMHbG3t6Lprfr8B2zYP6eyi2l1PPBYRFgBImIbuWa2veuG34DzsWrJKSNQDXUkb3/fvMCXIFeUO3IeazgPIkNnHBFSPSsb2XZK68H+km0u/7s27EKTxUYmHFMCJv/YW5yAX9EsWxH+54bBpLqbSRQbORmKvxWtRPw4KFntbGDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 10:58:03 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::42cb:32d6:2502:4cbd]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::42cb:32d6:2502:4cbd%3]) with mapi id 15.20.6277.034; Tue, 11 Apr 2023
 10:58:03 +0000
Message-ID: <691aa8fc-43e1-7393-0092-f3198e5b34d6@amd.com>
Date:   Tue, 11 Apr 2023 16:27:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] x86/Documentation: Add documentation about cluster
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        jgross@suse.com, andrew.cooper3@citrix.com, peterz@infradead.org,
        Jason@zx2c4.com, thomas.lendacky@amd.com, puwen@hygon.cn,
        x86@kernel.org, linux-doc@vger.kernel.org
References: <20230410163527.1626-1-kprateek.nayak@amd.com>
 <20230410163527.1626-3-kprateek.nayak@amd.com> <ZDTa1PbEqcyrhJsU@debian.me>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZDTa1PbEqcyrhJsU@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::35) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|CO6PR12MB5473:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2b550c-f3ba-420b-68f1-08db3a7b9f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1xwVjVzKFAQn2BLwvZJxpsGfyu0qOH+ZrPRECBVL7GLApsY9b0P0/EYnCVMwM8Ei9PTniuLyJT+bQYUQTXSkYVgrf+XEjO+Yk+rHDfmE3MtI/Ok4Xsu9kQQD1GucJ0rPmK4ljuIwxOU0P7+BQkxo1/DTnpQOqFQmFLxmTmlD1CJFSRzqdX51xI7JLwrO4050EYAVzJyJJ+06p/vFD1NKub+ac0jyZYW98YfvJw+asGkEFqg4T1ZM2ssRGbX3TRBtLCSKehgKAXkJizE1fGFIUgEUriC8xJCsWVTXqszZS+Dxlq7hzXI844PI7JY98utj97xZKYTpPUauxHZdXrbZaVzMKlUGP0+KV9duBqxsret3s0z945HqoDj2Mi2f4TL4X1VLX4cnUCB8cuMRUQk7ZEJiEf2CPlFww9qQcYPK1lz5HKa8sQKgqcxbntW5XaTRlq0oIxZmdVG+SPFA+M/EiqI0EKLVfakvxigo9C2N3l+i320sBnZcxGTzJscRTeSCCb+0GacVqUmVw3C1kHbMsK6Falk1PfY429gbNYOvbKqvhxB59vupttyMo7GBucB7Lc/rBsVtpWr93wsO6ms+QffHV4IkfJkH65GHJFbzQJXXDzrSpIi21sc7y6e0+PJYS2x3RF3TMGCbl52wiYPWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(478600001)(6506007)(316002)(53546011)(6512007)(26005)(186003)(6666004)(6486002)(2906002)(66556008)(66946007)(4326008)(41300700001)(7416002)(5660300002)(8676002)(66476007)(8936002)(38100700002)(31696002)(36756003)(83380400001)(2616005)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDJSNzhCSE94dFR6WTNaS3RrMUwvOWM4emJtWEE0TW9VbmlRMm1MZE5Kc3hY?=
 =?utf-8?B?UEZzSVpScnhkdlN5RmNueEo2WXZoekZWSUpyMnZxWGFiWWNlTHgrYXhKRUZT?=
 =?utf-8?B?dDN5Nm5YZlZiWDlZaVdXN2dVbTlFU25aSUJYSG9uanE0am0yR2tVeFJQWXE5?=
 =?utf-8?B?NU9jdVIwSWI4bE4remRsR2FYb0Z6akM4cHM5TGxCYnBmbFB4ZW9KTUtSMnRK?=
 =?utf-8?B?VFJ6ZEtuK0ZUUGN5VWp6UG1Lb21sUE52bERmN0ZwK0o2WU4wR3phdXhyRWJq?=
 =?utf-8?B?QmVpYkZNSkxob3AxS1lWcFpSWUNuNmk5TTE3OUdWdS95UzczbytnUXZ3NHRQ?=
 =?utf-8?B?MkZVeCtDb1NHNGErUjYxV2h3THhwR3RJNlZKWmR0VkhkcGFFTTA5SG1wdldw?=
 =?utf-8?B?K0tHN2F0Z0daTFhHa3NpQVhFem5lRzQrQWpCQi9ySmlnVjM4dnZtZEJsenVk?=
 =?utf-8?B?b0xlNGFOdjVHSzVmb2FwWERKSzBoNjJWRmpSZEgrOUZrbGxRYmY0NWJhNnY0?=
 =?utf-8?B?WWpoVmhka3AyNHBFdEk1ZG5STSs4QW5zMnROaTB4K3haSUZ4d1RBZmZTVGxr?=
 =?utf-8?B?bVJvMmxoZXRiRjhaR3JUbkxLSUtaT0dpU05ZcWtXM0d4OXNGaEhaSjZQSVZH?=
 =?utf-8?B?RVBuc0cwWG1UakRHdEVCZy9CY2tYRlBCWTcvM243eDJJZUFlZmxpOEM5cHZo?=
 =?utf-8?B?akRXN21pdjQ2dEhMK0NjUGJYLzBsa3ZDdndGazlVdWNqakZIb3VlR0xVbkRG?=
 =?utf-8?B?NzRRTDRBTkFFNEU5dDdaczMrYWozRzVuOHhBT0lOaFAwMVJsWXorckJYd2tx?=
 =?utf-8?B?SnA4M2dOTW1xV1JSM0srMXZpK3pRYmdlNGhveXlOSVJSdWFadzlqTGN0TzJ0?=
 =?utf-8?B?L2ZwQTU2V2FMR0xhcFJUdWhJVXRmblgydTRrdGZiVmJlMW1jc3A0RDlLaUdi?=
 =?utf-8?B?NjkzYmlRUFdWUWxqbzMzVnd5SFZoYTArN1ZTRGg4ek04Z2g2U0xGanhPWTFx?=
 =?utf-8?B?QmEzYnV5N1d2cEU0em1GRDRGVFNzYXlnVjVzSUVDZDVYMXpDdy9SWFRIaE5t?=
 =?utf-8?B?dzFjbTVmSFFxTmFyaTY4eWZHOVZDN1ZtbWMwTFBXK3Ava2dnRzlCbS81anYx?=
 =?utf-8?B?V0NOMmM2aWNBdkZqdEppNE1rNHU3RWIxd3J0dVd4U3B5d01WbjFrN3pSdGRu?=
 =?utf-8?B?K05pKzFHcndhemRnSTVrZEhUSnFTc040akZHNmFjM2xUNmEzRE9sSDVRWkFs?=
 =?utf-8?B?aVhmaUE1QkZ2cjI1NU95bFllRUZkbTNyUnpxc0JVdjZFTXVHVUJxSHBBcWRx?=
 =?utf-8?B?cE5ON2hPeHp5K0RkTWp3QkdXYXJ1UVJzMnMzMDhLbHdwRC8xa0ZHM3VKa2xR?=
 =?utf-8?B?MHFpdjVaMkhRK3g2SENHbUFLUzcrMlRIQUlReGtvV2lieUQ3T2xPODdsdWla?=
 =?utf-8?B?WHlGTVI2NEpjZEgyUS9xNHMrdG1wYkJQa2JtcHlzOENLYVV4R3RVQTNsc3JO?=
 =?utf-8?B?R1FOUklFQUp4TDFlMWRlZGhEc3pHVHVHdzVPcFVPMWFVeTI2TUZERlVkVHJK?=
 =?utf-8?B?VzJJbHAxVWVqQWVVdjBZWm5yK2trNXJPajZPSDN6ZDdrbG9CTW5RcjJBelZp?=
 =?utf-8?B?Q1JIb05vYWpENEg0MjVNL0J0bDlRUmhuVU4xY005QnduY1NSNVpqTXE1eWM1?=
 =?utf-8?B?WlVDaFAreUNEZHllY2d5WUhxTUJZSXg2b2d2a2MvdytmbEN6VHByaFRCWlBZ?=
 =?utf-8?B?NHJtRDdGS0RlcTlNeDRQWllMMXpLQjJSbjBGejlqZmJiYXhvditCV2VmeFZ5?=
 =?utf-8?B?L2NHL2w2cThFblBTam5vVWVWMVZRMWRJRnV0VXBYM0t2T3NrY3NaUG52WU5S?=
 =?utf-8?B?cFJXS1VxSGsycFVhZDlOdi9nWXpXR3F0alg1QVZraHBmODR0cE56YWVyUlNl?=
 =?utf-8?B?d1ZWVjRBSld3Yk9uS0JLQ0FFVk9CaXdvT0cxYWZ1NDdiYlBYMkJVcVcxLzUy?=
 =?utf-8?B?cVRabUwzK2p1bWVrNTc4a0JNd3NKVTc4cm1zL3lENzBiRkIxcXlNVHQwVUZZ?=
 =?utf-8?B?TE9NMHhUWENvOW43NkY1VmRjamowV2dxNFd3aFJ2OExjdm9OS25yaGhpREVE?=
 =?utf-8?Q?WYb1IWGnUIUQqd2ZhC6NH3n/r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2b550c-f3ba-420b-68f1-08db3a7b9f36
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 10:58:03.3284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjPWmFcPnyA0ssXAVNnurPu5LAqXJJ/Mf0pU8IA8CFTeVPdbXO/hXyuX+RWshNvK9hlcKxbT1lt1yQ41w8q2Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5473
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bagas,

On 4/11/2023 9:28 AM, Bagas Sanjaya wrote:
> On Mon, Apr 10, 2023 at 10:05:27PM +0530, K Prateek Nayak wrote:
>> diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.rst
>> index 7f58010ea86a..35991d8cdef1 100644
>> --- a/Documentation/x86/topology.rst
>> +++ b/Documentation/x86/topology.rst
>> @@ -33,6 +33,7 @@ historical nature and should be cleaned up.
>>  The topology of a system is described in the units of:
>>  
>>      - packages
>> +    - cluster
>>      - cores
>>      - threads
>>  
>> @@ -90,6 +91,27 @@ Package-related topology information in the kernel:
>>          Cache. In general, it is a number identifying an LLC uniquely on the
>>          system.
>>  
>> +
>> +Clusters
>> +========
>> +A cluster consists of 1 or more threads. It does not matter whether the threads
>> +are SMT- or CMT-type threads. All the threads of a cluster share the same L2
>> +cache.
>> +
>> +Cluster-related topology information in the kernel:
>> +
>> +  - cluster_id:
>> +
>> +    A per-CPU variable containing:
>> +
>> +      - On Intel, the common upper bits of APIC ID of the list of CPUs sharing
>> +        the L2 Cache with lower bits set to 0.
>> +
>> +      - On AMD, with Topology Extension, the common upper bits of the Extended
>> +        APIC ID of the list of CPUs sharing the L2 Cache, left shifted to
>> +        remove trailing 0s.
>> +
>> +
>>  Cores
>>  =====
>>  A core consists of 1 or more threads. It does not matter whether the threads
>> @@ -125,6 +147,11 @@ Thread-related topology information in the kernel:
>>  
>>      The number of online threads is also printed in /proc/cpuinfo "siblings."
>>  
>> +  - topology_cluster_cpumask():
>> +
>> +    The cpumask contains all online threads in the cluster to which a thread
>> +    belongs.
>> +
>>    - topology_sibling_cpumask():
>>  
>>      The cpumask contains all online threads in the core to which a thread
>> @@ -138,6 +165,10 @@ Thread-related topology information in the kernel:
>>  
>>      The physical package ID to which a thread belongs.
>>  
>> +  - topology_cluster_id();
>> +
>> +    The ID of the cluster to which a thread belongs.
>> +
>>    - topology_core_id();
>>  
>>      The ID of the core to which a thread belongs. It is also printed in /proc/cpuinfo
> 
> The doc LGTM, thanks!
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thank you for reviewing the patch :)

--
Thanks and Regards,
Prateek
