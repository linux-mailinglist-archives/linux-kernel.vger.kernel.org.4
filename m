Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3B268ABD5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 19:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjBDSca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 13:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDSc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 13:32:28 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CFB2CC67
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 10:32:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EH+k7mRu326z4bIGT0qJ19zJGAuC13mleLNXXpHmU2PSxUx2axltoIq2FQ1gohqkdgxzJf2Dytv2xu10YM9nPa+QG50QAxZa7wxi4b4pq0x4Z8Ws3RkqCnvvQIR13YIrZCkw52GJM3xM1qa0A0w7NQHH2z7FDRXtaYelGggu499B36/UA9WZM4ZrLCC2UteSS+2TdO7PUDS+FJjbXOsbeO+tWbcJxJ8A/rRHmzdiXKaKofrVbTnK2aPSfyH+7dAwTwaVUV/v+1Vbm2wo/FN1RMbG4JurqYNAr1OBZT9FUmWWv+BrLa/pH8MYr0V3ckVJTtTHIBczyRySMczAL04YXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvS8ySgARsfYos5ZWQkhA6TQwYLasFOuKWdXnmOGR+Q=;
 b=b0FJtQsavpNcCOygRJO9LLtqMmrOYqZ7NL0QilLCXMeXykOIc/5P9U8XLFfCgMJWiJszjBP9LdGlMtDXJ1y7bR5VvyYJhvJwrm7pbCQweauESGgWpIIupjCaMPZirAsKp85emyfO5ebPVVQO2qnyiAuj9DefbF2+HnVh3448vuwxKWQdd/Jl5jWKitMh9z6O1iB3rXiaQXob99Vc8TG/MCYu8e9hOScSRdJdfrxheI1kvymBGdJw2s4T8MiBKTqaA7CU09IBT55ftR04L0EKGed/ygek+I+ZXYMp8qgFPFEd0XXJ8NNSurw8u255cVUxmxk8Y+xO3K852YM2obICKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvS8ySgARsfYos5ZWQkhA6TQwYLasFOuKWdXnmOGR+Q=;
 b=zn/tgIgzbePyi/iszKPqtdbA5mJNj98977aVSBMXWobkgZrH0QsQFbr9rdEm2efMGlbddk5mcwJDL2EgUQ4hXOifEcD1k7O5amT9vtAMxvbOBRvOk/sIc4WnHKi0naWZSHF8q5TioXhg4J+DvV+z9u9vtrvt9F/BIYmiuZTntvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Sat, 4 Feb
 2023 18:32:20 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc%7]) with mapi id 15.20.6043.022; Sat, 4 Feb 2023
 18:32:19 +0000
Message-ID: <45360170-f132-3204-1e99-ed78c73641c4@amd.com>
Date:   Sun, 5 Feb 2023 00:02:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V2 3/3] sched/numa: Reset the accessing PID information
 periodically
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
References: <cover.1675159422.git.raghavendra.kt@amd.com>
 <b0f273113fedffb02f9b1358c88813ff355a81d6.1675159422.git.raghavendra.kt@amd.com>
 <Y9zxkGf50bqkucum@hirez.programming.kicks-ass.net>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <Y9zxkGf50bqkucum@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::14) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|PH7PR12MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b2ab35-04af-4cd7-1d20-08db06de260b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qN+NlYELJmQfLgLgjGaDDJ4eU+VMcuMI/RS2mRC6XpHGaBvgtUqnkZm43SFc55i8gf1Bgco3w7Z2TwnCRIuhc/unUBZZtG6ahFmIY+8NqYzyw4aCR+9OV94cpezQ4ypTfHCjEC5WTqWBIFbPqcd5480LWSBiJUYSccI5T2Y1dNeLB7Rj41PsxZABLpN/BcqmdLC5QhDWX0BQVBzBA3yktYR+iIPAmkg4EsbZ7zkLQbAFMrd9FeS4CqUL6t9Dw2sxTR7DT6oWpFKbuhJKKRb3F1i1dgkDXtUjJthHEghqEhMeVh0rSQSrVGqO0M8S/dArDazFggP0ib82j8W5DAQj/JIpT2PfVZbMv0KG2hbsjCl2vH96PTe1KuNOJaN1Osdq80M8lUlYLywgkMNkckho4WUwcrGOWkAe2xBjVYkj3auVTqbMDR9H/6cqLbEWX4mn7AKEyBLjPFU3QI0yTQ2I8vE1rc7Md4/aXF4wFmR2+CAxpR/qVLxwLp/Oq2ztN/L5KM3sY25a9RLqQApCgUwIxQRsuSOzA5hL479WLPqoD7qz1TK7g9gByfYt1aG5/UFiDaQwytM+5hAXzFn2k2U/OXjpPENL6543k3pcck8LwuEJ6Jav1kYYtfv6eZGxRptLukV0k1JGwDNfHREttODyqdsSIHF/4gFDAOEJkLA246V77K7IB67ob3DZjzdZR+B96ILrL5L2dvZfi5HriuKKhLzjTHzeaQrMVyM7HSp4Bj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199018)(31686004)(66946007)(54906003)(316002)(66556008)(41300700001)(8676002)(4326008)(66476007)(6916009)(5660300002)(8936002)(31696002)(38100700002)(36756003)(6506007)(6512007)(26005)(53546011)(6666004)(186003)(2906002)(478600001)(6486002)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anZ6SFRNZFlST01TYzNra0dLajhJbnJ6aitPdkY5bTNJcGRxVmM4MmFaMEN5?=
 =?utf-8?B?Qmd2NFc5UnNqM0w4S3lVcFN4MnNhK1M3Z3gvdkswNkIrTUYzMlhvSURNOEFl?=
 =?utf-8?B?ZHJzdDFPaldiTTEzK3VCL3hScW1GZTM5UFMydGt0Y0RkT0lsVHgrSTZrZnhG?=
 =?utf-8?B?aTVqWitwQVdtZUo2TzdvU3U4dUZLR0diTGFBNUM0RzU0QzFwTXc0NU04d0ow?=
 =?utf-8?B?RGhVYVNQZGxpWDNDdmo4Z3VCaTNIdEE3enJiVjVtVlFCTmJRb1d4M1FKV1NE?=
 =?utf-8?B?RHlJVzE1dWFqUWNNeGdYbklwR2tqb3ByUkh5VWJMY3Y4TUM3ZUJHbStVMGlZ?=
 =?utf-8?B?NDZxcEhHRFlrY0pRK2RySFZ2NjhzbGZFZDVtNDhzSUxrTEVyR2RFZzFwbWZG?=
 =?utf-8?B?Nk4wMzdBTkI4SysrNXk1ZjNSMWJKcFpLcndJTUhQYU9RdXlqZW4yRm5PWkN3?=
 =?utf-8?B?NVNXMnM1N2ZvcmJaV2RsdjFoNEU5QVNGY3p6WTFyVWhzUy9talkzMnV4TTR3?=
 =?utf-8?B?NlZqU3lFUUpPUkxOb2VWa1dVb3BmSmJqTjVBNTh6ZDI0UEprNzlBZTZ1cW9L?=
 =?utf-8?B?bm1kWmdtdG9TclkyNCs2OUpZZ3N3RGZtRkJRWk04QjF6SFR0eUdHNUtEWWNx?=
 =?utf-8?B?dGZ3YU5SQ0tLWEJTaEZPNFd2ZUIvZWg2ayt2R1NnTnNyMGs2Vk5KWU1IRHlt?=
 =?utf-8?B?QkdYRStJZnRESXZOZDZBc1ZGWmRXbEgwRzlCSXZWVTJjbjRSTDcyaXZJcENQ?=
 =?utf-8?B?NkxKcXdmT3hNdXBMV25OZG1rYnNBWHM1RVpXUE41WWNGbW40UjBDeU9HMkRB?=
 =?utf-8?B?ZHMxcnZGWjdVdkdkU0huaTB3bTcrQkFIbXFzelZKOTFlVkdiWXdUdWdudG02?=
 =?utf-8?B?KzlLZ1RzM0lGYm1HdXY3RzVEb1RtWitBZ1FnZ044S1pzQ2Q3TlZQRTQ0Zk5n?=
 =?utf-8?B?UGpKMVphdEdCK2JuczRKMGdKS0w5YWtpMkZYTG1NbnBtNDIvVEJVZTlPWjF1?=
 =?utf-8?B?aTBnd2RBdDlmUnVzZVRHUHJuKy9OUlUrbUowVVdveE4wTHZlZmtROG5Lb3ht?=
 =?utf-8?B?ZHdKckwyaHMxMWFPRWZyN2xWMWRTeVBRZ0ExWnVtMWtyYjNsVmQ0NEtzUEMw?=
 =?utf-8?B?dHByWUtidUhPc2kxME02dGduU0xxN2pHWmtyRVdmbGpKN0gzTVVrWnZUa25O?=
 =?utf-8?B?V3dUWmVPeG9yZmRSdjRQczNRbytpZGNtRGdRMDRqV3JFZzJVR3Z5Q2hqRkhO?=
 =?utf-8?B?VU1zdnNkNjlhMEpwbk1oUmZkVVJCWmtxT3BOVmx2ald6d0ZiSDVaeDdSUitQ?=
 =?utf-8?B?ajhnNG9DU3MwOHFuN0JHNXdZRnJtQ1Izdk9wbXdNSHU4V3dvSjFSNWhIOWFD?=
 =?utf-8?B?ZG1Xc3NrSi9FZHVVbTRldUNha1c0ak5nVUltbDhoQWN2b2Y0dWYzR0x6b2Z1?=
 =?utf-8?B?SDkxUVQxQ2UrbDAwajBSSll3alZiLzNCbTB6NDQ0RkIzeWUzbVY0L2xtR1Nw?=
 =?utf-8?B?OEdEYVpkQWhIMzRQWkR2ODFHQndOUEFILzMrbjRYZHFuVUtoMEczbi92eXVt?=
 =?utf-8?B?TzdVWWNYY1RlQjh2OSsyRlhHM0NDdzFOT3ozZVVJNlVBZEhPMk11dTVkaGRw?=
 =?utf-8?B?WG9hN0FrRGowUkxTQWVrVHUyMDY2WjJ2MFdRNmJha2dPQTE1RHJsNDhTTENj?=
 =?utf-8?B?OXhEN3JWTUczdXVUNnBrTkxxVzBnWUpRVFJra1dOcW9vbDBsTUdSemp6WXdH?=
 =?utf-8?B?R2pzQ0FPdi80L0NYZXpjby9WSGxVdHhxbSs2TnVjLzJ4NUdoUGY0WnB0SnRF?=
 =?utf-8?B?RlBpSlc0QTV6dkY5T2JvTHVsNDBQeDVvbVpQcUxWcnJaZWpLRitLZUg5WDJs?=
 =?utf-8?B?WWtZTENHM1FYVmFXMGFsYis1RjdlRXcxbWhVa3NoU2VJeWZ6ZmJjM2dvTUVo?=
 =?utf-8?B?ZngyYkNDSXFraXduZ1R0TVpTVjlyUkVER3dvc01GMWpRdFBza25CWVovVGN2?=
 =?utf-8?B?QXVseU9VT1Bpdm10bTR5WXlNRUlqZlJhZ3dSZGVnNmxVV1RjdWt4aG9RSFl0?=
 =?utf-8?B?WTRhc3dva2xBcHJNZ2tJdVRxd0lGdmlFS2JnWTEzVW1Yd05xbWtORTd3emxB?=
 =?utf-8?Q?olmNkRa3JJ5IujluAn1t5FI0a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b2ab35-04af-4cd7-1d20-08db06de260b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2023 18:32:19.7419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lof5ZMV/Ud2MiY0WCQ56W4jP9NBljj4RLHt7xqPQAJ01uiJyx8vGH9cPSnzR8Yp4Rt19y7WWt5/F3bDERcl/RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/2023 5:05 PM, Peter Zijlstra wrote:
> On Wed, Feb 01, 2023 at 01:32:22PM +0530, Raghavendra K T wrote:
> 
>> 2) Maintain duplicate list of accessing PIDs to keep track of history of access. and switch/reset. use OR operation during iteration
>>
>>   Two lists of PIDs maintained. At regular interval old list is reset and we make current list as old list
>> At any point of time tracking of PIDs accessing VMA is determined by ORing list1 and list2
>>
>> accessing_pids_list1 <-  current list
>> accessing_pids_list2 <-  old list
> 
> ( I'm not sure why you think this part of the email doesn't need to be
>    nicely wrapped at 76 chars.. )
> 

Sorry.. copy pasted from my "idea" notes then word wrap fooled me..

> This seems simple enough to me and can be trivially extended to N if
> needed.
>  > The typical implementation would looks something like:
> 
> 	unsigned long pids[N];
> 	unsigned int pid_idx;
> 
> set:
> 	unsigned long *pids = numab->pids + pid_idx;
> 	if (!__test_bit(bit, pids))
> 		__set_bit(bit, pids);
> 
> test:
> 	unsigned long pids = 0;
> 	for (int i = 0; i < N; i++)
> 		pids |= numab->pids[i];
> 	return __test_bit(bit, &pids);
> 
> rotate:
> 	idx = READ_ONCE(numab->pid_idx);
> 	WRITE_ONCE(numab->pid_idx, (idx + 1) % N);
> 	numab->pids[idx] = 0;
> 
> Note the actual rotate can be simplified to ^1 for N:=2.

Thanks good idea. This will be very helpful when we want to
differentiate accessing PIDs in more granular way. Perhaps we can go
with N=2 and stick to below simplification of your code above?

something like:

unsigned long pids[2]

// Assume pids[1] has latest detail always
set:
if (!__test_bit(bit, pids[1])
	__set_bit(bit, pids[1])

test:
unsigned long pids = pids[0] | pids[1];
return __test_bit(bit, &pids);

rotate:
pids[0] = pids[1];
pids[1] = 0;
