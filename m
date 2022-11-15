Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44A5629760
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiKOL3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKOL2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:28:54 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B5B1010
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:28:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOKa1Bi/6BgVmQfrioJqg8uE5QBiKXHYauOVpP1aDSuWGelIL0xI2r5CnEeNvcDr8sN4v+fdoh0bFF43C3p/I9sKJMfRAqHr/Kir0URE4pGVDJljFppftUarM2pC41HoSxHIQlWl2dROi5fh/3TRPhvukLvCAUbuLsCSHYWlwjNck9tKJBpujqPm9O63Bz5v2ktI0MlxgclzvMwEFSLXbsYW+ZrDYeZSwg3dpQocGbj56/D/p+/3I1ySMPb3wVgQEWQnNMxnr074uwviQIWWX31T1iisr5NhxOyFgOilbolJBdJRKTAyVBCygO1ckVx5WW8Ef3abCGgaojZlPRVGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4ZOhLz4KVAFnU2NwSfAGyz21NiKeWAl7BRxbgzjX1k=;
 b=mbs7s3Cwzf5f3tC/6+5CVeMzBiruapDA9AwclCOL6t9gZd/qnufo/vQE+hZqiQ7hGWaEcEzzK8JMdtrtKuZWbj3WIiSpPYkPxqZ29JO63i8NIvraLygZE7NtPfphKZubNmULOOzRnDvotWZnpcgmRtPweQMe6PUeYojCWghXBVhiiMjgkuScwk/c2xw9CPwXMcpqPaLD76V/wP2qgBiVCXcje4BJzO19NTZSwK0UstKh130sa+skP26/oM9G1cKJfX/dZK8Y+ngsNIFsjlgculynD6NFIWMt88vV2OR622bgphM3vo2HaDjHP6nudV9kfylEjmRzw9hT44OgVBVuXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4ZOhLz4KVAFnU2NwSfAGyz21NiKeWAl7BRxbgzjX1k=;
 b=VsJ8rd924Clm83zBJI/Tps3CTrmpFc34Vjj9F1bqXCvjLT1lmLkATUUE155/geFTWyAjoEAB3YMbxU7fHBgL8htGmnUwOtLKQaCNjicvGKUCYS54h1XvCNJPOwpxtnbAPemWSQaUHjWdh1W7/6L8c/MUrAcFGh1ur5v87uioFZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 11:28:51 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d9a6:6f94:8e92:9e20]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d9a6:6f94:8e92:9e20%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 11:28:51 +0000
Message-ID: <906747ff-148c-f058-dc94-7a9225125f52@amd.com>
Date:   Tue, 15 Nov 2022 16:58:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 0/4] sched/fair: Improve scan efficiency of SIS
Content-Language: en-US
To:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
References: <20221019122859.18399-1-wuyun.abel@bytedance.com>
 <c7c5a654-8d26-28d9-7b33-e7b2b7bf2401@amd.com>
 <2a049755-57cb-4943-0850-cbbf2537c97e@bytedance.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <2a049755-57cb-4943-0850-cbbf2537c97e@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0201.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::13) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: b24e21a4-821b-4892-5984-08dac6fc91f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NWjNfTSpMoM3DO7k9A6De2mHeuvcfBMyfTgqBNQKiUCcp5H/mD1cujQIJyxU1z3DdqKy00yLORkovdJ74ltCmnAlM8dx5/AsBNNxLXwIEGp9WTIILJPl41QuGsZn7Ef9t4cb7ius2V1Puf3GpZqg2ZMIzoMhOKrJH7aYkjxn6xYmBEU7pOkTiYWkdsAodi0+yanABDw/ttKQAF71XD5oQev1Sjzij/sVJ84MplPpUT/v6lX0nTK/9FaTofA+DmlBGfRygQ0LRMLs54u+PbOdphXJZhbDBNzTtmVqRayn+hjpQy1JrA1bwzuAwnSI7QhBTRA4MCopIptOE+E9IRx/7VdK5B9tXv1ObmqNr5rpgUnxGne3DQqEMZyq/9pGVNN1L4Ju8XK97MAY9CdNIIV4YeJrGRVFoVGU1eQ+5EbRg3fNDbJhxmY6GSq4AAVuxeX14xUl6Mj6HTnbGW1ZkCqJNqhx+Yr7I5QArXJW71MbjGlVWd3hXPiMLpObiXK7e/zRhYGL8FiQQN1hgj3DBcJyHo6hKFPzUVUlrV+VBmobG3t9Gt0Nkhul6lO3QTcfPHUMi3WNW0cG7vPiw9oEaU7zSl/DnzeRtPqgS3gxIKmq1RhKMf9gVMAI0lQ/XSSmXNAZpPBiXed6xTBqr4FlrNl1XpyKy8kOCmf9BN/v+x3pkZbc6CyEQWCZvj2m8Rhte1JcJzAqdFWS74nJpkSuQfsiouwRVZgZjSsPkEmXe6UALiR8UsoQQVM2kfwYsVUouRQQ8GZeG/AY+Qw886uKxI/GmPBt8qGJn/ZgRojXfiisbr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199015)(26005)(6512007)(66556008)(66476007)(66946007)(316002)(8676002)(2616005)(8936002)(5660300002)(186003)(4326008)(36756003)(53546011)(41300700001)(54906003)(110136005)(6506007)(31696002)(83380400001)(2906002)(86362001)(38100700002)(7416002)(6486002)(31686004)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVFDUlJGdDVLTGZTWE1HRGZOVDRLcVJ5Wjd2a1F3ak9tbkFlNmNCR1ZKdFgz?=
 =?utf-8?B?T3dWT3JMRVgwZHptVDhnc3l5RThZcXd6Y09sMDJCQU1yRmlLNHJnQXd2RTMr?=
 =?utf-8?B?TDNEMUduREhzSEh1Lys1Mk9jbG9IOFpBQnVZNWd5dncxbThYVlZHYjN3NVJM?=
 =?utf-8?B?YmNJc3ozaXltL2N1a1paMEE2NHpiRDZZdWtJeXVueWdFMis1d01XenBTeUhQ?=
 =?utf-8?B?dHljS3lpL3pLb2hEZStjM2p6OTBZRStYd2swY3NVV0MrZkV1dzhFUUZnQnIx?=
 =?utf-8?B?UXYzK1NQVnE5U0gxakljZld2WmxlOTI3aGhXSE1Td1dJMGpKanlwaFNkSEQ0?=
 =?utf-8?B?RmZTeXlQL283QkRVVUE4SW5KcFBycWZyVGVKSmJWZnhNbC9FaWRJb3hCWndS?=
 =?utf-8?B?ZHJxNFcva0t3OEk4VnNhcnpHcmk2dks4eVBuR3FaZS9VQXRUSVlqa3JiWHha?=
 =?utf-8?B?bkh6enp2WHJOY0VpTXRwT3VaWjc1MG1TVHNXWVEza0FmVC9QZ2RQNS9za0Fj?=
 =?utf-8?B?ZTFaaHYrNW1hSGY2aTNUVHBibjVCZ2VzQ2hvTHZYVjY5b0ZYZXNWTE5HMXha?=
 =?utf-8?B?bURETk14TFZKWkNIL2w0N1VBUE1EMU9kZ2UyS2JtOGk0S29KMjJiQlZOTnRm?=
 =?utf-8?B?YmFvT0loV1h6UkkyN05PUnZCU3kyU3Y0cHJUZ1pVVEhFbk5BcmtEUzdwR0xD?=
 =?utf-8?B?a1dHUjBSaWw0YjVuaG1URzhYdXo2ekZzMnhiUWlIOEpOYVU5alhMTXhrUnpr?=
 =?utf-8?B?L3l1NWhNT29Hc0VON1ByU3Z1dTBTbkNKYUsyOXdoRjJ6TS9NWFh2Qkc4c3NL?=
 =?utf-8?B?YmZrOE9rQkJWRlF4a3pLYkYzc09pOVFqZDMyM05weFFCU09vRW1zTnRsRmhX?=
 =?utf-8?B?ejBsZTNuMHd0eHM1bFdRdklZd1YyNUpxTW85blJSM3F1ZWNTSnhPWVZkQ0Jj?=
 =?utf-8?B?dkNjY3JtV0VtSktPTCtyTkNlbys0aWxOZEQ4YkFjYkk1eVZUdWFnaDJRdlha?=
 =?utf-8?B?aGpHcFVlM3JGYnFPeFF5MS9CYWphclBkZ0hNY3NjMHBDWjFCWW1pNE9Db3Ro?=
 =?utf-8?B?UlZ0K09SSDhiUmFsZGhIVjlVVGoxOFlnbDNjb2pWc2dtZ283WEpkVk5ZbXE0?=
 =?utf-8?B?WDdBeVMzbGtMT2xuZFZCUExPSE9sMWZ3ekh1M01SUWRjTm9uMUtZaGpkT2tO?=
 =?utf-8?B?UUs5cG1TUWZNSkpnd3B3Tmdvd1grWEVzaFYyUEJHNHVVeForYWZ1SHFKU2Jm?=
 =?utf-8?B?blV0amgwWkF4VjhCVnhyT1lEZm9CbWowWHRxNjZWMW1PdHdyVUQ1SkxkYVZE?=
 =?utf-8?B?bmY2OTBSWkpnaU1sczQveVB6UVhDRUJRMndINUZiWnZ1U0YvS25YSzRBMzFD?=
 =?utf-8?B?SFZ6Z0VtVytvRzVOd2RIV1ZRTmFpTVQ0aWkwNTlOeTVmK3JhUElkV0EwMW1U?=
 =?utf-8?B?QzZkYmlVTU8yckJZUmZzUnVTeUF0UUsvUlBwdGRPd3MvUERHYVp5MGEzaVFN?=
 =?utf-8?B?aEhvdWZZUmN6bmd6ZE0wUnZMYjNiK1pjTTVuMGFOaDdNR25QU2VDVUJkS2FM?=
 =?utf-8?B?NDlhQnM4azBRYWRCRWdRSmg5VWU1U2h3dkRmWGZaaDhlVG0zcHNZU2hycjda?=
 =?utf-8?B?dDlYVXM1VjlPMkZocWJBREdLTnNOQm5jZkNHbVhmWEFDSXVmNFZDQTJNTXNI?=
 =?utf-8?B?ZW9VeUJwRDRoY3g1Tkp2WlFiTTZOK0lJOWVSMXN3SUY0Uyt2bUkyVTZQR3Q2?=
 =?utf-8?B?T1JGOUU4Z1RMQmdXUDIvMkdNR1d0dzFDYnBmL21JRTNWdHI3N0R4M2huOVVz?=
 =?utf-8?B?RWZxcEhlTGZ5RmZ6c2F3a2lManBQQkFLZlg5MVpGOXBvY1FOSTJxL2hOeGkr?=
 =?utf-8?B?dTBzK3JhTTFJOXpkUEc2RWJVa3NuOHJxY2tDWTg1RGJhdEF0WmpiOHBKVzZW?=
 =?utf-8?B?QU9hWk1yL2tHTVNEcENWTXdxL0E3OEtGdFA2UnhXd0ZPQVlkTlAxdm9sMklG?=
 =?utf-8?B?YUVMSnZmR3l5TEhYNHZQdnlqM2crUSsvZjJtTmZoZnVHVXA2U3kraytCMEVp?=
 =?utf-8?B?VXMvY3Avb0Zsd1hTbEpUeEVPSlZ0eURFL1BLbXgwc25KbWdwSS9mZDUyTEpL?=
 =?utf-8?Q?CJkyVsRBI6S6utSJVEYJPFiNv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24e21a4-821b-4892-5984-08dac6fc91f3
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 11:28:51.2486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hOzd/NU4wBqCq/oowBk8agX/x0OSAJwIRi6XXDVnzC5jdhLZSsmhT0W0YguW0En8REh/qGPYnXFDB4t665cfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Abel,

Thank you for taking a look at the report.

On 11/15/2022 2:01 PM, Abel Wu wrote:
> Hi Prateek, thanks very much for your detailed testing!
> 
> On 11/14/22 1:45 PM, K Prateek Nayak wrote:
>> Hello Abel,
>>
>> Sorry for the delay. I've tested the patch on a dual socket Zen3 system
>> (2 x 64C/128T)
>>
>> tl;dr
>>
>> o I do not notice any regressions with the standard benchmarks.
>> o schbench sees a nice improvement to the tail latency when the number
>>    of worker are equal to the number of cores in the system in NPS1 and
>>    NPS2 mode. (Marked with "^")
>> o Few data points show improvements in tbench in NPS1 and NPS2 mode.
>>    (Marked with "^")
>>
>> I'm still in the process of running larger workloads. If there is any
>> specific workload you would like me to run on the test system, please
>> do let me know. Below is the detailed report:
> 
> Not particularly in my mind, and I think testing larger workloads is
> great. Thanks!
>
>>
>> Following are the results from running standard benchmarks on a
>> dual socket Zen3 (2 x 64C/128T) machine configured in different
>> NPS modes.
>>
>> NPS Modes are used to logically divide single socket into
>> multiple NUMA region.
>> Following is the NUMA configuration for each NPS mode on the system:
>>
>> NPS1: Each socket is a NUMA node.
>>      Total 2 NUMA nodes in the dual socket machine.
>>
>>      Node 0: 0-63,   128-191
>>      Node 1: 64-127, 192-255
>>
>> NPS2: Each socket is further logically divided into 2 NUMA regions.
>>      Total 4 NUMA nodes exist over 2 socket.
>>          Node 0: 0-31,   128-159
>>      Node 1: 32-63,  160-191
>>      Node 2: 64-95,  192-223
>>      Node 3: 96-127, 223-255
>>
>> NPS4: Each socket is logically divided into 4 NUMA regions.
>>      Total 8 NUMA nodes exist over 2 socket.
>>          Node 0: 0-15,    128-143
>>      Node 1: 16-31,   144-159
>>      Node 2: 32-47,   160-175
>>      Node 3: 48-63,   176-191
>>      Node 4: 64-79,   192-207
>>      Node 5: 80-95,   208-223
>>      Node 6: 96-111,  223-231
>>      Node 7: 112-127, 232-255
>>
>> Benchmark Results:
>>
>> Kernel versions:
>> - tip:          5.19.0 tip sched/core
>> - sis_core:     5.19.0 tip sched/core + this series
>>
>> When we started testing, the tip was at:
>> commit fdf756f71271 ("sched: Fix more TASK_state comparisons")
>>
>> ~~~~~~~~~~~~~
>> ~ hackbench ~
>> ~~~~~~~~~~~~~
>>
>> o NPS1
>>
>> Test:            tip            sis_core
>>   1-groups:       4.06 (0.00 pct)       4.26 (-4.92 pct)    *
>>   1-groups:       4.14 (0.00 pct)       4.09 (1.20 pct)    [Verification Run]
>>   2-groups:       4.76 (0.00 pct)       4.71 (1.05 pct)
>>   4-groups:       5.22 (0.00 pct)       5.11 (2.10 pct)
>>   8-groups:       5.35 (0.00 pct)       5.31 (0.74 pct)
>> 16-groups:       7.21 (0.00 pct)       6.80 (5.68 pct)
>>
>> o NPS2
>>
>> Test:            tip            sis_core
>>   1-groups:       4.09 (0.00 pct)       4.08 (0.24 pct)
>>   2-groups:       4.70 (0.00 pct)       4.69 (0.21 pct)
>>   4-groups:       5.05 (0.00 pct)       4.92 (2.57 pct)
>>   8-groups:       5.35 (0.00 pct)       5.26 (1.68 pct)
>> 16-groups:       6.37 (0.00 pct)       6.34 (0.47 pct)
>>
>> o NPS4
>>
>> Test:            tip            sis_core
>>   1-groups:       4.07 (0.00 pct)       3.99 (1.96 pct)
>>   2-groups:       4.65 (0.00 pct)       4.59 (1.29 pct)
>>   4-groups:       5.13 (0.00 pct)       5.00 (2.53 pct)
>>   8-groups:       5.47 (0.00 pct)       5.43 (0.73 pct)
>> 16-groups:       6.82 (0.00 pct)       6.56 (3.81 pct)
> 
> Although each cpu will get 2.5 tasks when 16-groups, which can
> be considered overloaded, I tested in AMD EPYC 7Y83 machine and
> the total cpu usage was ~82% (with some older kernel version),
> so there is still lots of idle time.
> 
> I guess cutting off at 16-groups is because it's enough loaded
> compared to the real workloads, so testing more groups might just
> be a waste of time?

The machine has 16 LLCs so I capped the results at 16-groups.
Previously I had seen some run-to-run variance with larger group counts
so I limited the reports to 16-groups. I'll run hackbench with more
number of groups (32, 64, 128, 256) and get back to you with the
results along with results for a couple of long running workloads. 

> 
> Thanks & Best Regards,
>     Abel
> 
> [..snip..]
>


--
Thanks and Regards,
Prateek
