Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27CB67356F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjASKZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjASKZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:25:21 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD864DCC7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:25:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1HFdN/4LbUzv5qKQbaipcNnKteokbtKZojTyQJJcrO2dkcIagsP/y33rJ3YBBmYcJyc0sW7tNNFvZr//sQn8SzlohtqcMtddjzHO7MiATPXwSIBtFIuiVUO7rvPzAIo3tLmb8hxRFW3y64BnsTLYXuhl4tgGgC2Qxkq7QpDZ0GzqL5ZReG/nvNpg0av2qNVxcgc/doIrtWDahThBtZKUY5OVrwugHW2Iu4IpMwF+06ll8bYQGUArZ5sWX7G3SoRE/N4BfCPYOjMHA9v1jibysoz2iutl0PeL3njbeLG238j90MCBxX9UYclnEpybBM+5WESwmY2rvc8I3tn8sBPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/zuqKVP/z0hZxrx5Fu7y6xItGF2yzGMp4fnWW1zw6I=;
 b=ExTDw9LBK6vGvLr3pWutJmwDCVwpAJGWxz96uJ0/dPU0zgQbAco14CDqOmMr1uO3TKwKk7///oOkkd4MHxd1qvIsHwMfFfVGHY9fIhJE6qv61wlesn7oMrmLHzTogtRTnoTf9n3PDihDNyYaiG83j/JaVZvZ3F6rfxLAjhTTZOCBmbtFjG0c+INiJrCScXF9O1RdMsjFzqU1RzAZiarXEUND7azFAxxQj+iNAFpfAxWEhn4iGB957KpBX+VogY+grSVwMtA2X9CqdRBKgq+Z+i28ewxxamVj1R4+Us7rhQZkI0KNANdXgxsmg7s2PFrhwmO/pTwTrTNE3+HUP6VI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/zuqKVP/z0hZxrx5Fu7y6xItGF2yzGMp4fnWW1zw6I=;
 b=KohlXV5ASh0k936ds+KxA2XzzUNtqOlXV/99RFpNuPQMrcrSA0OAfYa6qDsvIX32iDxJcZU23ONVtQHESNqyzqqS/I9kkD+Sa6arQm5ntnHSuz7TIJ6XcBBhw8yEXVmzE+8x27kTtb6Nd6zcg+ai4HlF3o+cMg/PVsniQImg4Yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by MW4PR12MB7466.namprd12.prod.outlook.com (2603:10b6:303:212::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26; Thu, 19 Jan
 2023 10:25:12 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc%7]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 10:25:11 +0000
Message-ID: <acf37296-485d-0281-69fd-811e7ce011b9@amd.com>
Date:   Thu, 19 Jan 2023 15:54:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V1 1/1] sched/numa: Enhance vma scanning logic
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        xu xin <cgel.zte@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Colin Cross <ccross@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Hugh Dickins <hughd@google.com>,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
References: <cover.1673610485.git.raghavendra.kt@amd.com>
 <67bf778d592c39d02444825c416c2ed11d2ef4b2.1673610485.git.raghavendra.kt@amd.com>
 <Y8kP2KbJqWDIgGRZ@kernel.org>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <Y8kP2KbJqWDIgGRZ@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::10) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|MW4PR12MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 72284c2f-be94-49df-c36a-08dafa0771f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iEJiatobY9FUuzl72EewqmmFF33IgZ9O39T24hlZJ11zu9ScVLl3hlXPPSBXeLkSc2uUF7FknscGVKtdIDODuDyKeb26tO7sJyTg1B/XQU6iXS8pUTMkSD3thooJ6Ti5Zssf0pR3pl+Wx0GC28GgJk+nrB6Cy4OjyoaGr2a9MWCDwp/gim0hog29vvrF3LkBCXWAwG+kb053SeYwk8ZfoSQzxYdHEujfcybBD1cSQ/gSMOXNcI7jr0xob/yLtVCTfhTZJGDJPQkKE1oxsBl0sEFMjafjKRBKAAT4iW3ZK0+Tde33mza8qFRoy48eQgUfFPqaw7NyFoZoBcFPTnATrHD0PZqQQRE3IzvsuPtnOgzJHqoqemIx6pJm6lLFL0lPzVnh6hb855/KE+YjVHrNihH/gCgRE4Krn/Y/7G5ZaCFP0vNUPQhW0yGNy9aS5TxQ7/QMYnbOW7DbYgHYuJiSYzn/o2OvLrfsUUJcc4TCr3yLYXy5YMU8CxTzrK9IbdrquKV2AnwLm+xteDmr3GyThsygjVfhQxNulgEcvvBZ3vjeP/iWR24VTVTydySdBH3qmCLLmTbRh7EpKycBxZ6q0SbiedZmPAhx+fooOote+QoCvO3nNb5CkVkkAzdTzBySXn5nW5v17NyTPlAx3W6P0cr8l+3EYctSThyqHsZ+Dck/PIT2uUS7FjGUzvqnhiLks1gL0EjG/607Rup8QDJ1X3XwvBXZ3yVeyXYk4xA8Z3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(6666004)(38100700002)(6486002)(6512007)(26005)(186003)(2906002)(36756003)(478600001)(31686004)(6506007)(53546011)(2616005)(31696002)(54906003)(316002)(66476007)(8676002)(6916009)(4326008)(66556008)(66946007)(41300700001)(5660300002)(7416002)(83380400001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVNPcHlYM1BHRkQzOVluVTJ0QzE1WFhyOVFTQXE3RjZaYlFQV2tRNlpyQ1Jx?=
 =?utf-8?B?N0xUWkJ0a2RyMU5Xb2wzU1Q2UUZ5d2gxMFJicHUwMGtRZzNoWVZTRTNiQ0pU?=
 =?utf-8?B?YzN4TEQrMDhqRWUwNTdvMnlIUncwR1JjNTFkNmtEbTBEMXpYbEJQejVTSUlu?=
 =?utf-8?B?dTVvbmJSMEdYWGRxbC9IZmRUNU1SdW92c2xYOUtJamRsQm5tTkZsR2hGbTJp?=
 =?utf-8?B?MzBDN0EvQ3JUYWZQMzBuTFEvU0hNVGlha0gyU1JvVG40Qk96SEcyYUxaTE5v?=
 =?utf-8?B?TlMrdThWQmY4YUppNUY5Q0IybmdrRHpJT3VpdHgyQWdJQ1k2RFIwT1Z0Tkda?=
 =?utf-8?B?ZFRTeGdXZzN0SjZzRHhzSHZKK3IvUC9qUE10a2NhVXZqYlJEaWVoSDlaaElN?=
 =?utf-8?B?Y2JXTDJaMG1FZ1MyaUFWSGxNY2JDV1NEdk1uSkpEYXQ5SVR5ZTBiY1BtV0NO?=
 =?utf-8?B?UjVWOVoxNW05TVl5UHpjVTVDUjA3dHU5UE53TmpmT01iaUMwWW8yTzRoUFor?=
 =?utf-8?B?TlZFZ3FBZkJQTHdncGxmSTRDUS8vY0I3R1FRYXZvZVZsMzllUEw3cGxJREdr?=
 =?utf-8?B?dE1sZ0VSSklFWVA0bU45SDlWOGx3NVd5T1E1S3BwRk1PTWo3K1N1elkrNXR3?=
 =?utf-8?B?N0IwaXpuVVg3aW81aWgrK2JyaWgvVkxWWGdxWE5qb0VZQ1BIMU5oQzhkNmJ5?=
 =?utf-8?B?UHpaTmJZT1ZKT1dVL1FWamJscjk4cmwrZXRWYnJkdWZwb0JFN29VMzdCb1Vl?=
 =?utf-8?B?NjVMRUxoaCt3R2pRR3d0amNjdCt3U2ZmVkdwOGJCRUdNV1VUYnNmU1hrNERz?=
 =?utf-8?B?Yk4yWHVMbFZkVWxNQkRGTGpmWWUzc3JGYU9IWVh3cndPK1QzTXptb3ZlTkJ3?=
 =?utf-8?B?MUp5R3czY2U5TW90Q0V0aGRuZXB1eGIvSDNSMVFkL3NDTW1uK1hoRzU0OXN1?=
 =?utf-8?B?TVVFS1BPeGJRcWZ2Z0lBM3dteDRaQ2syWnYxYk1rT2QzdnhsT0VCUUZoMnNY?=
 =?utf-8?B?cHVKSHBpZEI2WlNGUEdYZzBBMk5JNk9vQ3dSdUR3MzIzdVUzN2x5WlBjS1g5?=
 =?utf-8?B?aUt5VjhpQTZSUmZvSzdiNGRkcTBrNEQ4dDh2UDV5YWVaVzBFQkNJM051eHB0?=
 =?utf-8?B?bUh2Q0JWcVFZNWN0K3dlZElkSEc5YTR3VFhHYUF0Y2MxV3FTT2E0ZUU3aHl3?=
 =?utf-8?B?QmZDWTVFbkVnQktzblBnTlYxNStENG1kM0QxU0JXK2JvTXJIRGdVV0dBQ1l2?=
 =?utf-8?B?UVpTREIzc2wxWG5hYlR5TlAvMHRaMWxKd3ZVWHVVNndhMnNOV1FwQXlyclFO?=
 =?utf-8?B?Y1A1bkZsQnE0ZkdDcVFILy9QelV3ckY1T1lHZzBNVDNRVG51R2dUcnhCa1dP?=
 =?utf-8?B?QjVsL3ZVczNuMXhRUUowY2hXNm15d2FTYTlyTkN3a1QybGFVU1B1bVFZTG9l?=
 =?utf-8?B?bytyMnFUeUlOMnptYXpRZmN0TmZlR01tUDFjVXR1bjVXcHpINkxnR3hrQjd3?=
 =?utf-8?B?SG9idnVnSmdmcmdyS3NhempwdmtlaFFUODlJZThtbERRTUErdm12TlVXdFNx?=
 =?utf-8?B?S2lkV1lzRkQ5eUtHazNPVnZ4enEwelFYSTN2U1Jkd05LYTdtd3BZT2JHdmZs?=
 =?utf-8?B?RDFHeksxQi92dkt5SkdsZURtR2tGUjh5OEY3ZUFDMkJLbU1uczQ4eEVBMGpU?=
 =?utf-8?B?K2NGNnJIK0dhU3I4UStyS1BvRE1JdGtsQ0RiM2JrM3g2M2t0VU1nNWpFUnFh?=
 =?utf-8?B?MHdXUzcyWW9oakZ5RGQrdDEzd3VKelk3SVp2SWwzbmg0d2R2bUNSQ25kVkVn?=
 =?utf-8?B?dUtPb05HUFJEZmFBWE5qS01SYVNybTFLUWY3KzZiaDA1MzJWRTl2UHZtd3Nz?=
 =?utf-8?B?RU43aC84ZjR2VncyMjducGRtNVBQNWlSNzdMYWc1d203TVg0MjVkOE1Ia1ZW?=
 =?utf-8?B?SFpsYm9HRloycEtsNXNoamdLZkpqbFRxdGF2SGtrTWc4Q2R2RWNnZ3B5MzRu?=
 =?utf-8?B?TXJJNHVCbEsyWXdBTHBFUFVrVFNETmpDT1o5Si9pbGpNRUh2eE9YV256MW93?=
 =?utf-8?B?OEh6Q1ZSZW4zaHpSbVNzcFFrOG1JQStmeXhYY2ZoZFZQVUdUSTVuZ0dpYjNW?=
 =?utf-8?Q?NKoamPhCJDodbqnp7GT1aGbEw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72284c2f-be94-49df-c36a-08dafa0771f0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 10:25:11.3415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDCoPcz4+jQabLgalq5n5KD7/8UzyPIzIAtMhO5bVsdxyKnfmUY0sETx75FZNeKfRAgM9yAok1Wa4aZA/uuiLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7466
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/2023 3:09 PM, Mike Rapoport wrote:
> Hi,
> 
> On Mon, Jan 16, 2023 at 07:05:34AM +0530, Raghavendra K T wrote:
>>   During the Numa scanning make sure only relevant vmas of the
>> tasks are scanned.
> 
> Please add more detailed description about what are the issues with the
> current scanning this patch aims to solve.

Thank you for the review Mike. Sure will add more detail in the patch
  commit in V2

> 
>> Logic:
>> 1) For the first two time allow unconditional scanning of vmas
>> 2) Store recent 4 unique tasks (last 8bits of PIDs) accessed the vma.
>>    False negetives in case of collison should be fine here.
> 
>           ^ negatives

will take care of this and one below

>> 3) If more than 4 pids exist assume task indeed accessed vma to
>>   to avoid false negetives
>>
>> Co-developed-by: Bharata B Rao <bharata@amd.com>
>> (initial patch to store pid information)
>>
>> Suggested-by: Mel Gorman <mgorman@techsingularity.net>
>> Signed-off-by: Bharata B Rao <bharata@amd.com>
>> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
>> ---
[...]
