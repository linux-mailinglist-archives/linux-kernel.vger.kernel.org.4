Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1137275EF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 06:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjFHEBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 00:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjFHEBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 00:01:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AE726B8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 21:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7p94ZFBR6F3mPZMe96FSjS6Q4OuKRuWpfloEFwL9AvDgCi11FUU+hjRLN8jGH67Y7wVKOaikA4VwGrOHLPrA6Go61wYBnnL2XNfWOY6N2y3nsnqFk5N8t4tj4L8BM/nTUbqRtv2vP7ZfA/lyqXRZ9OBa8+NQ+QP6iZZ1Fs+1myE7mZmRvAOSxbcCLoUKma219xZYWjofZbFlZnUxKUxgeIRwE7TpHaLpTdIIpYOYQPZlJQexoWbjYbqFxWYICoZ3zgsnDz8XyyQz+Vj8vfh1BhC2hI5AMn/a10wRPNA9GeEu3XAeFM3Rb3u6KCfNL7stdwZT4qeijTJCgGPUSN10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfHm1Uw1nJ9NBRxVhvHA7XCPXjDqBe0q+kegE99LNJQ=;
 b=OFw3T1W8SWr1feUSXl+UigS7Iv41X65F41bDm7EHrz6bIIY6mvruKbB67Qocg1Q2kiR+rgSitq9ysEYR7wdQ8qUeNRuA8+X1DM/H9nG91Dr2fyKNxQQYOXbtXZHFAHMYs50sxLnqLozY/WDlhm8Q8SpGxNadcLNp82BsH6jy5a4ZaUatvdElCCexwqFLDI296DKa78ZrzYJk2uVqDWDyndeseKIjIOtmdcDIzukpIoZmYC6sEuVIZgOZcxWBlJhee8/CENvaWBKNn77wC3LbiRa9SEcJcnsBfDaK7zzot0gD4SyjAaU6coneIStkSSxpTNPeONESI/q1HI0cla+7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfHm1Uw1nJ9NBRxVhvHA7XCPXjDqBe0q+kegE99LNJQ=;
 b=pPhocN6etLVIQGm+ujAbsyx0goXwyHu5f4wX5Dfvk7wOuHaIpxvzI36YpYvYX5CoGVXsjXp77JQlIAN9k9OGOWT2KjVGQ6uR5f8YUR5plAyii4++nXQnE0Jii0BubO2AeOYjunccid42O/7M6vKojRGeJwUYPTyQVzXJQmt7LDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 04:01:15 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::3d2c:e06a:5a1c:b1a4]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::3d2c:e06a:5a1c:b1a4%3]) with mapi id 15.20.6455.034; Thu, 8 Jun 2023
 04:01:13 +0000
Message-ID: <301ffc14-84be-461a-91d8-ff5a97cef981@amd.com>
Date:   Thu, 8 Jun 2023 09:31:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V3 0/1] sched/numa: Fix disjoint set vma scan
 regression
Content-Language: en-US
To:     Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel test robot <oliver.sang@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>
References: <cover.1685506205.git.raghavendra.kt@amd.com>
 <53f3872a-4cbf-563a-2658-9222586680da@amd.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <53f3872a-4cbf-563a-2658-9222586680da@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::12) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a342cc-76c6-4576-241f-08db67d50009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HiWR44JrW8kKUkbzeFsH2l24CqXCgOn7HQRuu8DZzHWb5O9uM49R/Gnapvjs1/7IoO5FiSA3tCiWsZwi3/2zB4dgW6tF84L9yWu2MArRBFm9FTOlB6DBI0oWDtqxMI4boM39xjzKgMP2GiiBT2CdBWVyYXouSPzrodPUiCNvpilKFnUBWdyTY+o97qdzZD1VzSdOa6x9SI522yBIWeqJk3v/20pg5tEv2rHyzrguTNP6U3NwgwSqS882BNGCL9Bv5jFENDM0xYT41U4sVFm76a5wQM76ajsD0eS/d9QG8riiD2henL6WbkeGgVsLAofg6lGQKkczNSWCumgp229UiZ/kNahfevotKbf9jbGnacleh7A5Te1ezyEYSbaLhWO7K1EADh8jlfDBs1z01jbaPhOwN9k79VG7/g2buOXdjv+9iqX4rDkvlEMKIeUOtEbpoS2/WiJKCvAOc1Ld1CWjKtdRbBy/79xNdbcJrEiFLKK7Ige1ghnkCrp8o06IwxlceZK6IT2Zm/8KtyWl/wZOkUYvsRTBeFkqfgsmgaGYSyEuruM6NRte+vFpte5BpD8f8lOyc8jw7lNa+ltkmQmIWP6G53ZviS9vMZNmVU4CBfvVYEGxDGPwxZYPGXtX9PW8eTWFarPlzLVyS9HslvJusCS2bAN4wXdatBCj3VbFjSi/P2sPu3oPq4TrK/hYsRDm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(110136005)(36756003)(66899021)(2906002)(54906003)(31696002)(478600001)(38100700002)(41300700001)(7416002)(8676002)(5660300002)(8936002)(316002)(66556008)(31686004)(4326008)(66476007)(66946007)(83380400001)(6512007)(6506007)(2616005)(26005)(53546011)(186003)(966005)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnJLKzl3V2c1b2x0TFpXWUswQ0xNQ1pYRjFKRHlYMWNJa2VValNJRmNPZUV6?=
 =?utf-8?B?OTZvMkVMdVRBaE93bUNEQ3pBM2tIWU9ieEh3ZTQvSkxhejBUWjVJT3B2WlQy?=
 =?utf-8?B?d3BidXg1Q254aEtBTjVzRThxaFptQ25DaTZaL1hnWVVNY0diaEcwcmdDcWZx?=
 =?utf-8?B?Q1F3MU02ZThlamdzSUd4RDNMZGRrQUZxZDFxd2plbTJQNzNPWG43cndmQzRn?=
 =?utf-8?B?Qk1oNG81WWlGVXl2UHJSNG5LTTNiZkRvcVpBTFhpTjVnNlcxWVd4QWFDeVZJ?=
 =?utf-8?B?ZmxJcXlNb1laTjc0blNMUXpIdm1JN3J0TEtSWVdpMkNZekdpYjhCZ3dJeExL?=
 =?utf-8?B?blZWRVFJRkdOMDVtelpDbTA0eDRVY09xTVFvK2crcFpiZ0QwcXR2QXNOckVQ?=
 =?utf-8?B?N3RPUUp5cjFZWTVteEtKN1FCQVdsemtieVVnSit1RE9zQ2srTXh2STFyUHBP?=
 =?utf-8?B?Ym9OckltN0ZkN3BjODc4ZDJweHF6RjZpdG4xanFHY0VJZWlVMUkyNWgzUW5n?=
 =?utf-8?B?VXRyQm93WmRndXBNRVNUT1Q5K2x5NE5hazNxMnpIcDh4bVRyQ2RxQU9BaWU4?=
 =?utf-8?B?MEF1bitIR09nZFMvWW52b2Z1Ulk1b0FwWVlFamVUTWprZ05NKzRqYVkyYm5Y?=
 =?utf-8?B?VytVWnM4V3l1RmVkWCtzR3ZKN0JJMG9zamZiYzlXY2c5QkRXbms4NmlzT2hS?=
 =?utf-8?B?TVZhQ2VmTUh5MUhna0ZEb3BoRG5FSjdtRkk2MjRNK2FOcjQrTUNMdCs2LzFy?=
 =?utf-8?B?c3E1ZDBSaG5wTGFocHlrTEk3amh4Rjg1MFlYNVRmY3lybExya1BjS2tmWXV4?=
 =?utf-8?B?L0djR0ZLeHFSQnR3eU1zZTdNVi9meXdmZWVUYjVUSXlxdmc1dFZLbForTXRU?=
 =?utf-8?B?YVV2NGpUcVJwYmtHdWZKeGNHZDQyQVZHbEFoWndLd2xrZlRLeXgrNU9MSmRY?=
 =?utf-8?B?dDA2L0hTZ3NrOXF1SDhmOGdoSVFERlY5a0tWcmJ0Z1ZzakhKemlpZjVlWlI3?=
 =?utf-8?B?T0tBS2JuY0NEMGlzcGZhTVJ2NjRicFA5dzlmdGVaTG01a1NGV0RsWU1oaERJ?=
 =?utf-8?B?VDArOVFKQmZSbmlJWEN4ZzZ3eXpqNEMxakYwSnc1TmNzUXFUOEtKN083Mkta?=
 =?utf-8?B?SkhaK0hWaWVHYmk2THlGSExiUThTTTBzZjV4MnRvcmNmQkpHSXlwMFhBd3A3?=
 =?utf-8?B?L3RSOXVlUHB1bjg0UFZHdHRiRzFjd1pkV3NBU1dwTnN3QW4wZ2c2STdwWmFI?=
 =?utf-8?B?dWFEY3k0OXQ2YXFZUStNc1YwVndmcDVjQjZCZ1ZPMnpyYlVUYTk3QXFiZVpE?=
 =?utf-8?B?dVRnOGExdlVkZUp5VUJwTUl5Z2pzVmVWVkVXaWU3U3NqeFkxZ1pCajhYRDJR?=
 =?utf-8?B?R2Q5ZmNTOHlEbVZFNjFMeS9kbEtRcXc5ejQyZkRRS05oYyt5SnJnVzl5SmV4?=
 =?utf-8?B?SVBuZTBkMFZiVGFzUWRVWXJRT01KMXJkYnpKWjZySjU5MmVLWktaQ0licnBF?=
 =?utf-8?B?RmhCVmZqZlA3dEFNQTh6V3REOWwvenJYNmkvUlNqQVhaLzNjdGVzTlN3MmV2?=
 =?utf-8?B?bTY3TEN3NWR3alZtZDVGSHlTcVMwMU5uUk5SeXZjODN4Zk13UzUrbUFKUllJ?=
 =?utf-8?B?OGswdUJLMkorOXpxWnZFdlZ4dmNIY2xpYy82N254OVRqNzVYeDN2U3h1Rmdk?=
 =?utf-8?B?TEgxQ1BBRkNKeVJsWHFBM0VRWmk0R3lXcDJLOFAyazFULzJNZWoxZm13ZHla?=
 =?utf-8?B?WnI1VnhobStnYk5HT2FVbmhFS0hDUlVwb25lOVFnQXN6K1FtUXVqMWhCTnNx?=
 =?utf-8?B?NFF2WW9vSWJXME1HTGVuUjhIcXJQRUUzZFQvdWhQdFpxYUt3Z2YrNFhPSTcw?=
 =?utf-8?B?OW0zYmRZVWxxUWxIMTF3MEJhWVBxZCtoQkRPazZSeEh2WUVob2QxcGpXV1gy?=
 =?utf-8?B?Smw2ZmdrOUpTYzhyd3B5eTdpQ3JvaXBsUlhVL095dG5veDRNSVV4N00yRlJt?=
 =?utf-8?B?cXBTTDByVTM0TjJUS0FFeENaSUZjK3ZiYitzWlRGSEpiL1FsdUI0SU5YTFBG?=
 =?utf-8?B?UlFFVTRBRlZCazM4M2lvWkVxNVp4L1p6NWJZbEtIOWMyUWx0K3RnZDBKTFRJ?=
 =?utf-8?Q?+0QZB9XyoVWZSkI4b6/8W+ORq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a342cc-76c6-4576-241f-08db67d50009
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 04:01:13.2680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QN/AcYc6c/QKWSLbFvGhMkoYy1lap4I/eVu7WsiIflTuPN1IivVpISHkiAPmZ6VSQQC5ZRFpKxsjxMSm9e9ADg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/2023 5:10 PM, Sapkal Swapnil wrote:
> Hello Raghavendra,
> 
> On 5/31/2023 9:55 AM, Raghavendra K T wrote:
>> With the numa scan enhancements [1], only the threads which had 
>> previously
>> accessed vma are allowed to scan.
>>
>> While this had improved significant system time overhead, there were 
>> corner
>> cases, which genuinely need some relaxation for e.g., concern raised by
>> PeterZ where unfairness amongst the thread belonging to disjoint set 
>> of vmas,
>> that can potentially amplify the side effects, where vma regions 
>> belonging
>> to some of the tasks being left unscanned.
>>
>> [1] had handled that issue by allowing first two scans at mm level
>> (mm->numa_scan_seq) unconditionally. But that was not enough.
>>
>> One of the test that exercise similar side effect is 
>> numa01_THREAD_ALLOC where
>> allocation happen by main thread and it is divided into memory chunks 
>> of 24MB
>> to be continuously bzeroed (for 128 threads on my machine).
>>
>> This was found in internal LKP run and also reported by [4].
>>
>> While RFC V1 [2] tried to address this issue, the logic had more 
>> heuristics.
>> RFC V2 [3] was rewritten based on vma_size.
>>
>> Current implementation drops some of additional logic for long running 
>> task
>> and relooked some of the usage of READ_ONCE/WRITE_ONCE().
>>
>> The current patch addresses the same issue in a more accurate way as
>> follows:
>>
>> (1) Any disjoint vma which is not associated with a task, that tries to
>> scan is now allowed to induce prot_none faults. Total number of such
>> unconditional scans allowed per vma is derived based on the exact vma 
>> size
>> as follows:
>>
>> total scans allowed = 1/2 * vma_size / scan_size.
>>
>> (2) Total scans already done is maintained using a per vma scan counter.
>>
>> With above patch, numa01_THREAD_ALLOC regression reported is resolved,
>> but please note that with [1] there was a drastic decrease in system time
>> for mmtest numa01, this patch adds back some of the system time.
>>
>> Summary: numa scan enhancement patch [1] togethor with the current 
>> patchset
>> improves overall system time by filtering unnecessary numa scan
>> while still retaining necessary scanning in some corner cases which
>> involves disjoint set vmas.
>>
>> Your comments/Ideas are welcome.
>>
>> Changes since:
>> RFC V2:
>> 1) Drop reset of scan counter that tried to take care of long running 
>> workloads
>> 2) Correct usage of READ_ONCE/WRITE_ONCE (Bharata)
>> 3) Base is 6.4.0-rc2
>>
>> RFC V1:
>> 1) Rewrite entire logic based on actual vma size than heuristics
>> 2) Added Reported-by kernel test robot and internal LKP test
>> 3) Rebased to 6.4.-rc1 (ba0ad6ed89)
>>
>> Result:
>> SUT: Milan w/ 2 numa nodes 256 cpus
>>
>> Run of numa01_THREAD__ALLOC on 6.4.0-rc2 (that has w/ numascan 
>> enhancement)
>>                      base-numascan    base        base+fix
>> real            1m1.507s    1m23.259s    1m2.632s
>> user            213m51.336s    251m46.363s    220m35.528s
>> sys             3m3.397s    0m12.492s    2m41.393s
>>
>> numa_hit         5615517        4560123        4963875
>> numa_local         5615505        4560024        4963700
>> numa_other         12        99        175
>> numa_pte_updates     1822797        493        1559111
>> numa_hint_faults     1307113        523        1469031
>> numa_hint_faults_local     612617        488        884829
>> numa_pages_migrated     694370        35        584202
>>
>> We can see regression in base real time recovered, but with some 
>> additional
>> system time overhead.
>>
>> Below is the mmtest autonuma performance
>>
>> autonumabench
>> ===========
>> (base 6.4.0-rc2 that has numascan enhancement)
>>                     base-numascan        base            base+fix
>> Amean     syst-NUMA01                  300.46 (   0.00%)       23.97 
>> *  92.02%*       67.18 *  77.64%*
>> Amean     syst-NUMA01_THREADLOCAL        0.20 (   0.00%)        0.22 
>> *  -9.15%*        0.22 *  -9.15%*
>> Amean     syst-NUMA02                    0.70 (   0.00%)        0.71 
>> *  -0.61%*        0.70 *   0.41%*
>> Amean     syst-NUMA02_SMT                0.58 (   0.00%)        0.62 
>> *  -5.38%*        0.61 *  -3.67%*
>> Amean     elsp-NUMA01                  320.92 (   0.00%)      276.13 
>> *  13.96%*      324.11 *  -0.99%*
>> Amean     elsp-NUMA01_THREADLOCAL        1.02 (   0.00%)        1.03 
>> *  -1.83%*        1.03 *  -1.83%*
>> Amean     elsp-NUMA02                    3.16 (   0.00%)        3.93 * 
>> -24.20%*        3.14 *   0.81%*
>> Amean     elsp-NUMA02_SMT                3.82 (   0.00%)        3.87 
>> *  -1.27%*        3.44 *   9.90%*
>>
>> Duration User      403532.43   279173.53   359098.23
>> Duration System      2114.31      179.20      481.54
>> Duration Elapsed     2312.20     2004.48     2335.84
>>
>> Ops NUMA alloc hit                  55795455.00    45452739.00    
>> 45500387.00
>> Ops NUMA alloc local                55794177.00    45435858.00    
>> 45500070.00
>> Ops NUMA base-page range updates   147858285.00       18601.00    
>> 42043107.00
>> Ops NUMA PTE updates               147858285.00       18601.00    
>> 42043107.00
>> Ops NUMA hint faults               150531983.00       18254.00    
>> 42450080.00
>> Ops NUMA hint local faults %       125691825.00       11964.00    
>> 32993313.00
>> Ops NUMA hint local percent               83.50          
>> 65.54          77.72
>> Ops NUMA pages migrated             13535786.00        2207.00     
>> 4654628.00
>> Ops AutoNUMA cost                     753952.10          91.44      
>> 212633.14
>>
>> Please note there is a system time overhead added for numa01 but we 
>> still have very
>> good improvement w.r.t base without numascan.
>>
> 
> I tested the patch with lkp autonuma benchmark on a dual socket 4th 
> Generation EPYC server (2 X 96C/192T) running in NPS1 mode. Below are 
> the results:
> 
> commit:
>    6.4.0-rc2
>    6.4.0-rc2+patch
> 
>        6.4.0-rc2            6.4.0-rc2+patch
> ---------------- ---------------------------
>           %stddev     %change         %stddev
>               \          |                \
>      501.84           -12.5%     439.14       numa01.seconds
>      228.66            -1.8%     224.44       numa01_THREAD_ALLOC.seconds
>        0.51           +21.6%       0.62       numa02.seconds
>      107.17            +0.0%     107.17       numa02_SMT.seconds
>        2936            -9.1%       2669       elapsed_time
>      794910            +3.7%     824178       system_time
>      474520           -17.5%     391331       user_time
> 
> Tested-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> 
>> [1] Link: 
>> https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t 
>>
>> [2] Link: 
>> https://lore.kernel.org/lkml/cover.1683033105.git.raghavendra.kt@amd.com/
>> [3] Link: 
>> https://lore.kernel.org/lkml/cover.1684228065.git.raghavendra.kt@amd.com/T/ 
>>
>> [4] Link: 
>> https://lore.kernel.org/lkml/db995c11-08ba-9abf-812f-01407f70a5d4@amd.com/T/ 
>>
>>
>> Raghavendra K T (1):
>>    sched/numa: Fix disjoint set vma scan regression
>>
>>   include/linux/mm_types.h |  1 +
>>   kernel/sched/fair.c      | 31 ++++++++++++++++++++++++-------
>>   2 files changed, 25 insertions(+), 7 deletions(-)
>>
> -- 
> Thanks and regards,
> Swapnil

Thank you Swapnil.
It reminds again that LKP's numa01 = numa01_THREAD_ALLOC which has
regained numbers.

I will also wait if kernel-test-robot also sees issue fixed. and also

if Mel/Peter have any objections/comment on the direction.

Regards
