Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F1C6A3B53
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 07:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjB0GlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 01:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0Gk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 01:40:58 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432DF113D3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 22:40:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VL9HmEMzUOBFoaM9QbdGJXnNvmdTpQBS6c4xNUs2EeOgbAQxwnmT5p9bsT4+QnsqTzAfi9Qs2lBaYTBIFmBgv35svS6GnY4UhmP+NXwT7Cq65s9PKUKqoElPCugThYxj15LmpWuWCpLvz3Ruf1g6E9Z1Z+nmervK2SgZN6gUVpuBcl2DUh0i9NBkfJC9DF8dsQMPTVsN5emePfn5oQKy7jgiiuKHCWVSBM/SDfjdk0TKeLVv1g5lFApMVoPMILlV9776T8P7xZmOiEJNSfw0jBNieMsZRbkgj6DriDXmMqmTG0Jxp271i6ZIafB2p4R9lKY3OqErJThUHk47B+rOvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxFxNIL07+K8rg8H6Lql1vzh9qZ57PpQGl1GqWHYws4=;
 b=l7mTTFu0xTg4fNQ+Qg7CeTkfkRoUBDtvOHr+J56Bn22qK+wF6UxklQ+ETmSOE2nppEVKijq1MlOlN1adsz31MVYKhBU4Puqw3vZRkyEgGwjnKs9IW9VJxDg2wY5cW3uLhJTLhbvSB9aP3NmP+3SSl3NS0Jvnuvo0PPOClvATZVMxnfqfcksz8fxoLoFhIk8n7hU0NcD0ZMRHkEFMQHcjry+QpJR25QGX2k7HaffV3N84ZdmkXY5ywj/NLFfDIoQIrixxtiLIySYmOh2LTn1DaquwjDFEkT0MkjO16YtM9oWzSKVXMK7UpJHd8w8yQBu0bMuCznztuO/NSmCmXGtcWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxFxNIL07+K8rg8H6Lql1vzh9qZ57PpQGl1GqWHYws4=;
 b=JSvBogBI6Zwt7hYds2XrRRNuR57dhFgQpcR5Md8Du+L/vAPIWw5hLrFAK9tL/HSw74ko0TDkzNtD7PIXy0vmdJhOTCQig60TcwYldKWPW+eVM+Tey/+jQcYeVwIS/3XGCP64u2ZMFq6yG4gzt2/Bz33HJ1EFHyLBMxmR9DYrl6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.28; Mon, 27 Feb
 2023 06:40:53 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc%7]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 06:40:53 +0000
Message-ID: <c730dee0-a711-8a8e-3eb1-1bfdd21e6add@amd.com>
Date:   Mon, 27 Feb 2023 12:10:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V2 2/3] sched/numa: Enhance vma scanning logic
Content-Language: en-US
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
References: <cover.1675159422.git.raghavendra.kt@amd.com>
 <5f0872657ddb164aa047a2231f8dc1086fe6adf6.1675159422.git.raghavendra.kt@amd.com>
 <Y9zs5A/T1WQpJTuM@hirez.programming.kicks-ass.net>
 <048964e8-179f-de7b-1190-831779d9911f@amd.com>
 <ccba1a65-fe4f-89d5-a32b-2efba30a1350@amd.com>
In-Reply-To: <ccba1a65-fe4f-89d5-a32b-2efba30a1350@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::30) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 28978505-87b7-4702-41c1-08db188d926b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: whKBMrkLTqmAf1nnMsN7oouC8IgJhyxyY7bLxjmAybORRCkHINZtXXh4TN4Zfd6B4jsOh3DwFjbsfcO3ImlmaibYqbmO9r45gbvqaOZxli3asDWNgxmSU7YteAUOKwPvZeHHKIYJ/g+eUEl4FU1hP557sA3JRGtFHNwlOwFwyQTZZFNiAStecwLfrGXiVANvFBLcancmcgwCshYKg7ry8hMDZRCgiCSOHTblIdv5RVX1CQrc03sETLmeyaRpier5Xj2rtxSXBPcVqu11fhDS1wJbWyilrl40Jk3maOcOcn2XyfBtioL6VV+dgRPQiSlA7Pe4PgrXcpUMB+2b0OoZ6TeM1pqYiiCZq9CCaYdbt2WsktKYHpsv8P6ct032VwgMLqaSFLIv9f3IDq6NPhMrxe7eFfwtXk0a7g4k2lF58Hx2cfClKuEZ8hz2roDgieaQbaEXmVMmcl68GTbB6CF4Le0+fpwiKgkXiib7dzCdsATDWPz7fyylZJ6SC1GejPtyC2YTGUNQVh8rIpo3YIHSbleCBrW0IGbkEfec0x1tt6f9nrTMyxJ0n2OVveawTIXLNvQoi680aB7uZoPl0e/AQfBXmbSm/X7YgIychJmnFRTysRGx4tQli4GRuz1Dm8lwmJuJmgFyHUYFalnLbHgpAkGhJl81llCTy+wJDlLzh5HvZ/selae6sEELmfc+4yCYY/QzPSKEzv06n4XibKlkstmT7z45t1/aJxYIgk1iSMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199018)(31686004)(54906003)(316002)(36756003)(31696002)(38100700002)(6666004)(6506007)(53546011)(83380400001)(2616005)(186003)(26005)(6512007)(5660300002)(2906002)(8936002)(6486002)(478600001)(6916009)(4326008)(41300700001)(8676002)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGpOOExpVGRXNXpQUzd4T2JPWlhmeXhGdEh2M3pYU1RBS2t6MEZCMkE4ellT?=
 =?utf-8?B?bys0SEVaVTNuT3c2YVozbTBDd1Q5S0g2Q0VaWkdQd2Rpd0YwMDZqY0ZYaWhR?=
 =?utf-8?B?ZmRldUxRclFIMzU0VmVSM3V3WjFrZDU1QlplcWJGb2JLbjExUjBmS1lkQ04y?=
 =?utf-8?B?RTRuZHNLb0gySkUybFllS3dFUUE1ZTZDMllLdDhmQm5qL3U4SVhGWldBbTdR?=
 =?utf-8?B?MWtqN0lnNnlsUUZlNnR0aTJBZ0NBdkc0MUdjU1JSSmRycXNudnZReWFoYkpm?=
 =?utf-8?B?YnpXZG5qK3FUc1hDc25NdFRMMnVYZUVwZm5kZ2Z4Q3V3TUE2K01FMHdDMEY4?=
 =?utf-8?B?OU54a1JKTEFGOWhRLzhjSkZVRm1JcnZKWVk5VHlZeW1HeDQwS0VJZGdHR3Rk?=
 =?utf-8?B?a3kyc201a3Z4c2tobXBYTWhJL2g1U0FQTnZFQlVWUEFTYW92YXh3eFZJekVE?=
 =?utf-8?B?bjROblNDSHB6SWRPWDh6MCswNWtEc2tQS3JxNlNvWldRS1lTVndNeVRZZEto?=
 =?utf-8?B?UExWTVI4d2VYcHNHY3JyUjNpaW5QWXd2YW05MURPeHNRZ1N3MlNMMW5TNHlL?=
 =?utf-8?B?eEJDbzBVVStQTk5iQURleTFPeTJvZjE3ZVRDMTlpQ2pLRWgzM0Fpa0ZrQUp5?=
 =?utf-8?B?RjNsdGNJYlVCZmsxOFNtOUNZYm10aktwYzVERWxGNkFMN3dRbnR6Unl2Vk9P?=
 =?utf-8?B?TSs2NERoN2RCbkk3ODZ1ZmxKOGljb1N4bzk3NXRtR29jcmJrbU8rN21wY2pk?=
 =?utf-8?B?Tlp1YzJhUnpqY1pSQmw4eHI0VmgxRElxTDF1b2VZa0VkcGpGTTZtbUcwVFYy?=
 =?utf-8?B?R3VGZ0dFNGV5b3RvUlFBc2g2R2RKd0lFU1lKanN4L1RlNnZrbDJTVk9EQmFi?=
 =?utf-8?B?alBhY1BkNlNHemxaNUZpWnpxRFpwRVZLei8yMURLb2ZIT1F6OE4wMm50cDM4?=
 =?utf-8?B?TlI0WThiM2lhM1dHWjVZa2d6aHlodHc4dlpVTCtRVzBXcE43SlRiNHMvaitq?=
 =?utf-8?B?SjQ2c3llMUhYc1Fzb1NLZWxiNjlQdXQyblNwU3hNZ1RzMkFJTkROeUw2am1F?=
 =?utf-8?B?Y2grZktickFjaW5VdVpLbStnMGxkTDdXZVVYRFJWeTZIbmh3WHlKeFVjMWpI?=
 =?utf-8?B?WjBXOXBiY1ozT0NBWEFvYUVKamZlMk5wV1FSL2RJQzgwL3BQK0JEcUtTS2pm?=
 =?utf-8?B?Q1VPdEZoRmUrTXgyRWZxNVdvbElJRExIK3VvaCszbGVTN3BrOHhscHczZHlq?=
 =?utf-8?B?NUpTYmJUdkRPbFdwYjh6b05SZmViR1haS1lQdE1hbDNNb21IYWlpUEZvOWhC?=
 =?utf-8?B?UUMrN0V0TUZqQTNiTWtFdW0yazVYNzdlZTVJUCs0eksrem1kUDZ5bmc5NkJ1?=
 =?utf-8?B?NEt3dk9lN2JtcWxqelJQd1UrWWU1NjNWNTBhRDBjV1k4eE1Celg3a2ROeDNs?=
 =?utf-8?B?K0xodFVLL3hoRTVOb2JkMVgrVFBBd0hUZEpoRXhHSGdLRVdUMkFyU28xWjl2?=
 =?utf-8?B?aWx5NnJtd2FHMUdSd2dWeU4wMGVnZ00yRHhLZFFVbjNWVHI2OUowZWN1OHIx?=
 =?utf-8?B?N28zb2w4YmxOeklua2E4d21NQytFeWNkWHNnMmNUM2NudnIySGRQMTgyeDVZ?=
 =?utf-8?B?dHZhalIvaHgrUG1rUk9VNkNsM09MTmEyZmpYd2Z1VTdDMmF0NWRuOHdMck9U?=
 =?utf-8?B?SHFVR2RBS1ovbmU0YjY5cGt1NWFDU0dNazYxVml5clhGMHJHY29COTZySzhN?=
 =?utf-8?B?VFR1aEtOVmdKYk9tOWxUVWNyM3A0MlZCOTdYTzF6c3l1RFZKdVBUMDhZa0FC?=
 =?utf-8?B?M25GR0NDUGt5UEpYazYyb0xZR1RpcEEwM2dlMXJrNWs2TE9XbHJpY0luSkVH?=
 =?utf-8?B?OFZuL0ROSUpqSVlIOWJ5cnlwdG5HSEs1clhkZ2NuR3gxSmxZYUNXRVMzSzZa?=
 =?utf-8?B?SnpPUXZzTlVMeHkvRUVlSEFSVHlNckpXVkk5MDV5RDhZci9Mc0xKRElMMmRR?=
 =?utf-8?B?ckZMWnlXYWNmRlZzeEo4bVZJMGZHNFBpQnpZS0RkY29WQ1FubGpHZ0N6OE1N?=
 =?utf-8?B?cGJNampEUm9hWWNzYm1wTEJZTXpndDVNVDhQaXd2cDNsOVhXOHNnVUtaUDY3?=
 =?utf-8?Q?C8b+PIc0564NhhJMGjQ9Ug4Lc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28978505-87b7-4702-41c1-08db188d926b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 06:40:53.2452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBoaE0/Pn3ZGnwEiOe1/o5D5QrvFiTC8BIHKyR0O9BjI9Pdx5wfFZZSdgsWoNRnKvcQkc8vbDMTrUaZ9iW1QeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/2023 12:11 PM, Raghavendra K T wrote:
> On 2/4/2023 11:44 PM, Raghavendra K T wrote:
>> On 2/3/2023 4:45 PM, Peter Zijlstra wrote:
>>> On Wed, Feb 01, 2023 at 01:32:21PM +0530, Raghavendra K T wrote:
> [...]
>>
>>>> +        if (!vma_is_accessed(vma))
>>>> +            continue;
>>>> +
>>>>           do {
>>>>               start = max(start, vma->vm_start);
>>>>               end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
>>>
>>>
>>> This feels wrong, specifically we track numa_scan_offset per mm, now, if
>>> we divide the threads into two dis-joint groups each only using their
>>> own set of vmas (in fact quite common for workloads with proper data
>>> partitioning) it is possible to consistently sample one set of threads
>>> and thus not scan the other set of vmas.
>>>
>>> It seems somewhat unlikely, but not impossible to create significant
>>> unfairness.
>>>
>>
>> Agree, But that is the reason why we want to allow first few
>> unconditional scans Or am I missing something?
>>
> 
> Thinking further, may be we can summarize the different aspects of 
> thread/ two disjoint set case itself into:
> 
> 1) Unfairness because of way in which threads gets opportunity
> to scan.
> 
> 2) Disjoint set of vmas in the partition set could be of different sizes
> 
> 3) Disjoint set of vmas could be associated with different number of
> threads
> 
> Each of above can potentially help or make some thread do heavy lifting
> 
> but (2), and (3). is what I think we are trying to be Okay with by
> making sure tasks mostly do not scan others' vmas
> 
> (1) could be a real issue (though I know that there are many places we
>   have corrected the issue by introducing offset in p->numa_next_scan)
> but how the distribution looks now practically, I take it as a TODO and
> post.


Hello PeterZ,
Sorry to come back little late with Data for how unfair are we when we
have two disjoint set of groups mentioned above:

Program I tested with:
1. 128/256 thread program divided into two sets each accessing
different set of memory (set0, set1) from node1 and node2 to induce
migration (8GB divided into 4GB each].
Total iteration per thread was around 2048 to make sure for
128 thread: program ran around 8 min
256 thread: program ran around 17/18 min

SUT: 128 core 256 CPU Milan with 2 nodes

Some of the observations:
1) Total number of threads which gets access to scan in the entire
program span was around 50-62%

for e.g. 128 thread case total tasks got access to scan was around 74-84
for 256 thread range was 123-146

2) There was a little bias towards set 1 always (the threads from where 
remote faults occurred)

In summary: I do see that access to VMAs from disjoint sets is not fully
  fair, But on the other hand it is not very bad too. There is definitely
some scope or possibility to explore/improve fairness in this area
further.

Posting result for one of the 128 threads: (base 6.1.0 vanilla)

column1: frequency
column2: PID

set 0 threads
       1 5906
       1 5908
       2 5912
       1 5914
       1 5916
       1 5918
       1 5926
       2 5928
       3 5932
       3 5938
       1 5940
       1 5944
       2 5948
       2 5950
       1 5956
       1 5962
       1 5974
       1 5978
       1 5992
       1 6004
       1 6006
       1 6008
       1 6012
       3 6014
       1 6016
       2 6026
       2 6028
       1 6030

set 1 threads
       3 5907
       5 5909
       2 5911
       4 5913
       7 5915
       2 5917
       3 5919
       5 5921
       3 5923
       2 5925
       4 5927
       4 5929
       3 5931
       3 5933
       2 5935
       7 5937
       4 5939
       3 5941
       4 5943
       1 5945
       2 5947
       1 5949
       1 5951
       2 5953
       1 5955
       1 5957
       1 5959
       1 5961
       1 5963
       1 5965
       1 5967
       1 5969
       1 5971
       2 5975
       2 5979
       2 5981
       2 5983
       5 5993
       5 5995
      11 5997
       1 5999
       6 6003
       4 6005
       3 6007
       1 6013
       1 6015
       3 6017
       1 6019
       1 6021
       1 6023
       6 6027
       4 6029
       4 6031
       1 6033

PS: I have also tested above applying V3 patch (which incorporates your
suggestions), have not seen much deviation in observation with patch.

Thanks
- Raghu
