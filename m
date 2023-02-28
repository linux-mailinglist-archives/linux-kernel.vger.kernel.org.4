Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3446A527E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 05:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjB1E74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 23:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1E7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 23:59:54 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44C728D2D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 20:59:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPnzof7excYzZ+hHAPKK2xYgDhzl+eOdSjFMXRv33RX0dW6P6dwQJ7tWlVclwn+/N2OCfi7P3EXkoKAOZXloHc+sMRxW2hAvFfkk45nXd8HaRGoAdX4SPigQHpGiMXyMdtZ1Ccilg0bg0OZQFK2e5cK6HRJgq+MP5X75LW3zEC7wv6axEx86R6RAutF9DpTY0QvPtd+JgsFPSlZUerUbmHNS8usj+Z3VyCQ0L70kdzM+MrFv3bwgHrcyrBxVOh+hdfCtMPUcpv/WpaQqPlgocvz5UGedVgjw/IH9jq4SLVnqgS6ikM9xT9cOnu7RzVQTW6DEbkXduWqKKMD1VQaQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txPCcsTonF544RaWCQ93G8LEhwCzL5QKNQIKTn8MSJ0=;
 b=NJnITat3rhddlkr8hblRTIAPup0T+5MCwFaVKFBvEvXjxYOpUdjk53krCxoIHQ7N/+TAUYPdUUX2t5b8Ia4gl6zGRAB+tSK2SC/yuy69yqlAvD/3B4z0uwU9UHGw4YxLiUS+N95kNfdV4y4R7qztOFAnyFf3Si0IVe17DvZsHcYvfC+IpN9pT1/ISRW90OIOfVV0kw2Vbl5qJrVwMS4satpoyEBIHj72zpwEgErSmuoi2ua60sFYh3pLOYfdUgjhTXihOmc6a8u81//pcrm9ui2cu5KO803ouZwXJAzrOQBiKzTcib7qE63dZnvSAfArSZExIqGhKUe3bn8187VQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txPCcsTonF544RaWCQ93G8LEhwCzL5QKNQIKTn8MSJ0=;
 b=A+o57bO9+jdHT9x8WRfHdhfpIfcVSVx6c8S/fIFcz+huvYglo4mYsIAn2BrLyBe+0kblVwqmHLlObZCJJCE/uUniGruVFBnsnagLG02DYq7XfsvWYs0AHN9PJW0l60xhp6ZxZSVsKgQVDmZ0Ssxgs7QSsvl2M8ntEBCIMw5XYx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Tue, 28 Feb
 2023 04:59:50 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc%7]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 04:59:49 +0000
Message-ID: <7ecb1d90-91c3-2f78-162a-1c1c4fa7e386@amd.com>
Date:   Tue, 28 Feb 2023 10:29:38 +0530
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
In-Reply-To: <048964e8-179f-de7b-1190-831779d9911f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0213.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::7) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd6dac3-82c7-4e0a-ab95-08db19489e9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKG1e2vq2TqU9xLc1qtjLZ6aD9CuTkUuuFvaNBZ9kmi6/j+NeaN/BJTzE/Ag5I128eD7wZFooRGx1TDuwOkKcYjycwiaY+NpA2RdZ7kFKVYPYlqirBSUboBNkCgDe7S8pbD2tnU9UrhyoV5QA3mQSsrgESz02Y9snjd71kx4lWeRc+Gk03Djlaf3PZnlsRzLR4spmMQIGoelS5fQP5Dx/O1s3MULiXg1Wj9veIfxpw8bjb4CJjDm6E4f+tVdUPU6xzIX7QqDwSXMVsHxIU6K/RI41FMSM/9xkKd+RdVc8XZh6oGSp8418xFADuzu6OUFw/td+P83ezr4IjefOSXcFBPiKlsybJqIm2ahpucdu5kVQIzCjNoxqI8mAMSmfCwqGjxDgwI4sn+wSgvyZBfGh6lLJIQI5kU+O3FlbRu/LDad2AtRN+GYhs2uRyP2UFePUw5IMDzHJqm8JNCSDzOPwL+pdbBbHXC9Kh+Zk6bxY8PGvlwNGw59856TuwpArOWjYREcGHqz5ajuZsdSVVOSI3pIA7fMRW3iuCqeJczDe/qilcmM4NmuH3uQBpcnRsf5B6LVu02/psMjVgMVusjZe/jVu5PnMHfbu7Rusi2K7jfREwGHoHV2oJhRIrbGOyUI/HUA4IZqtwADXkPSAEMyl/lvVBkCyg7mSA1+Gk1qUOaeGFLDvbUrYOAgWlMlvQQQy9h9wx2D2M5lfH02umB0YT5lZ6B1w+8nNgDArp1LQ5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199018)(31686004)(83380400001)(2906002)(2616005)(4326008)(66476007)(66556008)(6916009)(26005)(66946007)(8676002)(186003)(478600001)(53546011)(8936002)(5660300002)(38100700002)(41300700001)(36756003)(6666004)(6506007)(6486002)(54906003)(31696002)(6512007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1JXU2FCTjh6R0p2ZEUwNWlHMit4dG43TU1jV3liUVdDRDE5VjN4bmVaeUVU?=
 =?utf-8?B?N2FtS3JObm9ZZ1hZdE9kRkEyeEI2ZVpld3UvcmkvdDNjUUVXcldkNWpIR3ZO?=
 =?utf-8?B?eFZMRWFhOEFXaFU4S3gra1BndXFWdmEyR2x0bFVGc1dNaGxXL2lqTWZ0VjQz?=
 =?utf-8?B?TlNEUlNuaHE3ak90ZmJxL3VCNDBZcHg2ZDRaMVorQlIrcHV5MTRrY0RvZGVy?=
 =?utf-8?B?U25wYm8rNHI2bStrdFNYNzYzVkhYSkJzMmpKMmJZTnRlZHNIRm15bjhtY05h?=
 =?utf-8?B?alcxU1IrS1Q4V2U0dkphcGRTM011Zjk5aTh0WFI1aTZaaGdSMnJaOEw0MDNy?=
 =?utf-8?B?VEtWcUI2b2NIK3ZpQkUwZmN6UWlRajlTNi9yK25KN0pUQlhaZ2tzSjIyZlVK?=
 =?utf-8?B?SHUzbnU1Q1NSWlJyY29IazN3ZWN4RTB3ZXF2N2F5R0cvY0pCeXNtNUYvWFc5?=
 =?utf-8?B?TXAyTGpNZHk4NDVCQXhuUGcyRHlzMnNNQW1oYjZEOUhweTZEcFpyclFId3ZB?=
 =?utf-8?B?SFpTUXh0SU14allmKzNzR3I1MUFZZm1VS01YdERmVWhzd0xnS1YxMVYvZEMr?=
 =?utf-8?B?ZGxhd1BJdVJjbDhjNDIwVzZQMDBJQVpTdGU4c0FaZVB5NUlxRlZDT1BveXlp?=
 =?utf-8?B?eThzMXROdzJtcXhzdmhRdjZNaCtTS3NHVVhOMVI0NmpVMjdnNnhYeDU4aUJw?=
 =?utf-8?B?SmxPRFE3eDVpcFE4UWxIY2pXdnhNdVJVcnQ0M0RyaitrcHE3aXppeXNzOE1Y?=
 =?utf-8?B?cnF4TWxhQzVqazNlcXVXNUpVN3JHalVCUFlzMkU5T0c4aDcva25aZHcybkZ4?=
 =?utf-8?B?bnhnd3NEWE9DeS9ERXJxOEpmQ1ZSTTBoUDBFdFMxOUF2RnIxTW92emF3ajJn?=
 =?utf-8?B?MWpiQzlycjhMMEgyYWR4U0FleVQzMUhYcTdGWVZQeFlXZWN4d09zcWtVL1h4?=
 =?utf-8?B?dnp1bjlGWkE5VzM4SjJZWFlqMFRpZHFVanZXcEVQVHF0Qi9PSXZONkpUcmd0?=
 =?utf-8?B?d0tMUHdxMUF0Q0t6NVVhNVlYVFZMZlpYWDBsYm1OVlFvZkdOdDMwTDYrMDdx?=
 =?utf-8?B?SnBWejloN2RTbUdHZTRMS3d5Z3JBd21QTU5DVUVHL2V2VkZCaFhKaS8vRngx?=
 =?utf-8?B?NkNmWjlSdDk2MEpRM2JzaGtpWHBMbE4xNDJXNkMvaXRwanZlMVlKMTVpSEVH?=
 =?utf-8?B?RVlRQWgxbnNPMEh0dUxyalAzNEZqYzgrTmNlNFFTcHNsY0dmdVlVYTRNcWVh?=
 =?utf-8?B?Wk9ZSG1WMWlsRTY4R3dpU3pnRWw4a0hIOGxjcWt0UWEzWUZKRnYrbVZZNGsw?=
 =?utf-8?B?WjZKVHBjVCtZQ0t3WVFyVTFDVzN4L0ZlaFNKUUJHdjRPQ0wxUkw3OFdDMUNC?=
 =?utf-8?B?RWlhRXQ4dUxJUkltYll0eFE1TUZZY3c1OEhsSS9VMFJITkx1MEs4ZDI0Vlg1?=
 =?utf-8?B?a2gyeThYK0tpK1pTNDVsSzRjQnRwZFFMVkY1TVJoVUxWNGdEbHB2VnNpcEty?=
 =?utf-8?B?L2dDMDl1VndDUGw0TjluRFVkdUNORzQ5WFB6UytqRHNLN1g0OERqQ21mQlZV?=
 =?utf-8?B?SXBjd21rUDd0RkRSYjZIbnhLL1oybWFVSDNSWHhoSkZ0RytWaWtSZjcvMGVN?=
 =?utf-8?B?bGZJYm9CekkrQ3FFanpOK3NCOWZPeXBKSkpRR3BKYnovdHlpbVVoUy9iR2ZI?=
 =?utf-8?B?eTF4SnZqWFR5b2hjRGQwN2dBeDVQcDh5ck1oUm5wRzRUbEJCb2VST2VrWi9L?=
 =?utf-8?B?VDRCZ09BVVh4NUh0S2paNWlpWmo2VjBPUVZmQ0QwdmNHQUZURVErb0NUdXF1?=
 =?utf-8?B?SThlNDl0V1o2bUVNQytXZlg0bEk3czBLSU9vcDdzWlJnWUlhVzVOVCtXSlBY?=
 =?utf-8?B?M1F3OGIrbHFCU21GZ3ZzRmllQmN0NEExdExEQlJZYVlNc2hCenJrVzVnL0NQ?=
 =?utf-8?B?WUl2MGQrUjUzRCtVdG1qbUJRdHVqcjNNVjhENWpiUXhCeXp5VzJFQk9CTWRH?=
 =?utf-8?B?bUo2Q2dzQ3ZOaG5zODRqOVNYaGJqZE1WeDhVMFRrMjRHUURnNnRXWlcrTCtB?=
 =?utf-8?B?VnhqaGljQzEvNTZnSGdUMkRaMlhPZWt5WFgwSkRQK0lqZHE5U3V4TTlyemhp?=
 =?utf-8?Q?IEvWJv+/pWllafTqVdd4xwPrR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd6dac3-82c7-4e0a-ab95-08db19489e9e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 04:59:49.5720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifdZgtl0woT91W9CuRFm3C9MYgbfkR76zlXSbp17/LwHxbojI6G0GMTtR01kwri9qJIOEAuk+YqiL6nW0NhxNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/2023 11:44 PM, Raghavendra K T wrote:
> On 2/3/2023 4:45 PM, Peter Zijlstra wrote:
>> On Wed, Feb 01, 2023 at 01:32:21PM +0530, Raghavendra K T wrote:
[...]>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 8c8420934d60..2ec3045cb8b3 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -4718,6 +4718,7 @@ static vm_fault_t do_numa_page(struct vm_fault 
>>> *vmf)
>>>       bool was_writable = pte_savedwrite(vmf->orig_pte);
>>>       int flags = 0;
>>> +    vma_set_active_pid_bit(vma);
>>>       /*
>>>        * The "pte" at this point cannot be used safely without
>>>        * validation through pte_unmap_same(). It's of NUMA type but
>>
>> Urghh... do_*numa_page() is two near identical functions.. is there
>> really no sane way to de-duplicate at least some of that?
>>
> 
> Agree. I will explore and will take that as a separate TODO.
> 

Did spend some time to look at if there is a better way of merging these
two.
code looks similar as you noted, with very subtle changes (pte vs pmd
and difference in unlock).
But I thought only some part of the code can be changed easily, but 
changing whole code did not look to be worth as of now.
(unless we come up with better idea)

This is the only comment perhaps not addressed rightly I feel :(

Thanks
