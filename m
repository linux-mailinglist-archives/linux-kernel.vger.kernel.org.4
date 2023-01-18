Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308AE67134C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 06:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjARFsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 00:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjARFrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 00:47:47 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7CA53FBE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 21:47:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNEjhHix6gaV1Al4O5aTpLntdcoSGgfIRe+LcefpxKosxZNT4ROXEGwA5s5CSWL0DL+Th9CcR8yOAHNZwVRwCVmEqjsUaJookHpD5I/pR9Zr+75seZcDOX6Hzz3256AJwmUN1CpM/KRngXrqh/ZC0sZVumPzKWKeKBHxw1uUCBRfYatWnsro+FAT2VafMGnw9dN9SW0NMLIsg2eYw3IeBXkpNcRlFGj5dmd4H4lTEviN8V0Aouvf0GZwLO/ljWPKDkMB02am5Nv7eDn8MbkbFfompJvvttApPJbN9KvlmtHHeLkzTfbUtP8TbxYaZRl6GoUMAl9hILBAG/JZLaRdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NqSu2CkyN0P0GZj8TL6XLKZ6pe2aUA9L0VT1S5oh8M=;
 b=ERkO+lFzxuUKUbgcN9cVbvgPJw6xgWdAmsnuTvSdqPIqAUb0B/+XQyNlvEwN9W4SOIvoQV8RHgu16xBPPkBnG3iUqgtCilKrySbE6QYmCI8vuR3KwFpzfJbOY4VoPIinAZjiJlJKxYcutPXDGo1FcCV86Xoc59YV7gQuKwraZb3N9Mv9mzF9ksB0HA9O2M3nOQc+dj4Nh8ktlAhbi8zALU5yEKXC4VCVsMKy+2P/bJU8seuqTLOpz1uq7FJXWS/+Y4Ivcu/SfxG1Mrqme/ZIu3SYbmFT/uq5aqamnssclOkhpqu87rD36zvdCOtwRFidBnx9eEMnx4S/xQ7UgqtJKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NqSu2CkyN0P0GZj8TL6XLKZ6pe2aUA9L0VT1S5oh8M=;
 b=NDRKGIMtUgjKd5x+6HmuxsL7PUyM9g6PaxmSWek8L65sfaDcyeUvouGKBx5PDrJjKdymeLBraPKNTK5kBjrJ26uG+IFjebuF6Ji2994etOY4NKOgD3nvHmENiXcU20OvZoSiVPE7GazzMJmAxOXuumXz2VUbXBAPwd2gGntX/YU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by CH0PR12MB5315.namprd12.prod.outlook.com (2603:10b6:610:d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 05:47:37 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc%7]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 05:47:37 +0000
Message-ID: <91bb0e78-7ca9-63fa-a3c4-d55294b33f27@amd.com>
Date:   Wed, 18 Jan 2023 11:17:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V1 1/1] sched/numa: Enhance vma scanning logic
Content-Language: en-US
From:   Raghavendra K T <raghavendra.kt@amd.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        xu xin <cgel.zte@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Colin Cross <ccross@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Hugh Dickins <hughd@google.com>,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
References: <cover.1673610485.git.raghavendra.kt@amd.com>
 <67bf778d592c39d02444825c416c2ed11d2ef4b2.1673610485.git.raghavendra.kt@amd.com>
 <20230117145951.s2jmva4v54lfrhds@suse.de>
 <10a06a2f-0dfc-6f36-3b7b-f4fd03153f66@amd.com>
In-Reply-To: <10a06a2f-0dfc-6f36-3b7b-f4fd03153f66@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::21) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|CH0PR12MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: ff57b12c-395a-4ea6-7969-08daf917812a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CdKv2UeGMQuRXOQJ0zB6L6Vl0x9DHqja/AaU8AZPdhLuAK2uhS4Bufb/H+wgS0e/j1rCcojczmgV3eMYDzVzHoCgaKPqt/6NtdeeWDRLHcAz4qHJXRNUXa3nSDbWHJLu7ECOs70HaF+IVbvGHdhGfJ0kgWypLMUqlq7LEtMZlq7Yf+cPYAXZWBIwx0Gl4AaMR26R8kTaJLofqtv9LZTgA17qhMH3MAa56wXYnk63JcRCJ9d4q5NHqd6CjfWkUb+QqEfvfRgfsN21UvCHjdzHEPEulOc12FaakJhJ7T6fRr+69YvUHfqLqY4y7rqKFTYj4Vh2bjEnxLtLsyQljNCdUow6j3Q2nBwsD5nvuTYeiH4alyqlo+QgwBaqJdPzK9tkPK/PpQDIIMHQOAgqHniVMHoAmuq0MnkfE2ON/9BKHREDQI2yzFFEcZNY26sFx1Uu+hmeFy97DtO36eIeh6nhLSQeD5yZxXnHcE9jHgUpCgJZiqoFupr7UKbDMzRS4I2kJm+ViC6mxc3wUHL2Fc8zAL4Ckc5wkFlyuMIvg7HiKymjUEFnUzcM/qgT7bsv4F7BoNs603MI/hzBFeVAmrUHUWeTcCqY8YvxJ+iP2TBJzo57lBltPdDDz0dKKTZUsBelxJowYCSzc796gjGP0lWSDzNZt9oDeKBvJIfshXBwzcatwJtAw/mUod7YS4qB1FpcXHIzQSYcXlP/ALT/GD9hJhRCtGqkfjdSVKkveDvHUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199015)(31686004)(2906002)(7416002)(66946007)(66556008)(66476007)(5660300002)(8936002)(31696002)(38100700002)(316002)(54906003)(6666004)(53546011)(6486002)(6506007)(478600001)(36756003)(41300700001)(8676002)(6916009)(4326008)(26005)(186003)(6512007)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1BQaExZS0ZQL0JUSk5TLzlUTmk1bFc0eGZBYm5PVFNBNEFYVzViaHpOQ05D?=
 =?utf-8?B?cHRUZzFpWk5qaU9vVE5majg0QjkzZXBsVDZzb2x1a2V2OFMyRWFPQmJENEd2?=
 =?utf-8?B?QUZ3dWRabGIweWpqRFdzODB5alNsVEIzblRTak9DQ001cnBNbEptVm83R01H?=
 =?utf-8?B?Qkx1ZkVlQlVxZmZiS2lpd1liSW9KOENDQ0VTS052dmpKb3ZmckdybGpQR0Nq?=
 =?utf-8?B?RHhWS1daYWN2RnhrR0h3K1I2NjM1WXV3dXJQazN3dHNRdEV3R0ROU3ZaL2tm?=
 =?utf-8?B?eGpuN2s1ZGdMYzVGNFhUUTI2RlV6KzdMV1ByYVBsZWVxK0hXeW1lQ1V1N0pX?=
 =?utf-8?B?UUl5LytFZU9QVGtUdkg5Q2ZyUEhtS2RvcnRRU3pKYTZoYW5pdlloOXJBM0M5?=
 =?utf-8?B?ZVNGcTFlUVJvSEVUVythZ3I3dyswRlNmdFZ5SkxuTG5CcHRhYjZiRnZ3RkQw?=
 =?utf-8?B?SVkyWTZEOEIreFZYa1hwY0p6ZnJscCs4UWlRY0dmdVg0Z2pNMHVockRDa0pp?=
 =?utf-8?B?NDBIWFVhLzVSRXgyZGtsTVRzdWpOV245K3FIYXlpTU1ETm9oWWJtQTNWWndL?=
 =?utf-8?B?SFRaV1huOHhVRGxaMzFoYjBlbG5WWmx3a3kvemxURlNCL0kxY1JMTERZamx3?=
 =?utf-8?B?ZHJyQlNVSDhpK0R0VzUySW9mRktCWHBsWUdpdXZYZUhEY2RaVW0wRHYweFRz?=
 =?utf-8?B?LzMvQWV4U2lWREZhWEVvWXp6S0diUW9JbGVzcHFOdXdGVjQ1T2w5eDlSelF3?=
 =?utf-8?B?T3Arc2hlVGM2L2dmaHFqRVIrdmV3WUhsUk52L2RwcVpSUnBiNkYxSm5kTzdo?=
 =?utf-8?B?dkczRjJ0ekswdlV4RmEvQ3FsUXFZODVFSGV4NzgxUVc0UngvTUhSS1BuZHFE?=
 =?utf-8?B?OXJubnNySjlRSTkrczVYcWlrQVY5dlVSdVprSEdjU3FmL1RXV3RIdi9sb0tD?=
 =?utf-8?B?cWYxZnk5NXdnUUpseUhDemptUkhwZmV1aVVxTnlWU1hGWlhsUEZpYi9pcmMy?=
 =?utf-8?B?dUk5VFZmVGdDdG9FNTlSTGM4MG1zTlV6NFRNMFRBamtoMEpGeDFRSXVybEhq?=
 =?utf-8?B?Q1BkcEJackIzS0p0d3A2NlcwT3pyMFgrZkNmb2RrUjVmWUo0czFnRTVCRzRW?=
 =?utf-8?B?emRONktsUkpYNERTVmxaUFRqZDJBQ0srRFdkQkpmS0JyNVpGaUpGZGZ0QXRF?=
 =?utf-8?B?S3NjeHRJenowTTAwbFAxcnhLN2Fodlc1RXNkejR0cklJU2xYUThPMDJuR0RM?=
 =?utf-8?B?L3FYdTNYcnQyOGNFcjRRRXQ2OEF3V0ROWmczNGFVSEpFRDVtQnpZdzExUzFx?=
 =?utf-8?B?ZWVKa2FyTFRzY3dUZDlHYU5Yc1VoNjRUMWV3V3NGQmlRZGg4Rk42TzRtcVpq?=
 =?utf-8?B?REREOGtwRldENG1IV2d0RUljalZjbys4TDhNWGE5bXBmc2lIdmtPbkVsZ05Y?=
 =?utf-8?B?VnplRDJ6cHFkazFCRmVuTkd5L0l4WkFvQ3g0QllLNTBKQ1JjVVMrSWVNU2Nm?=
 =?utf-8?B?QjU3d21yQ2xpNmJ0UGJZbVlLVTJRWnRTbGNLTGRQSENGOFZmU2RneDI5WnNM?=
 =?utf-8?B?ejZlMlZIQ3ExVnVzdUhBTkRKVEd5WHpyRlYxcTBWL2FyWUNhc25PRGVXUVlT?=
 =?utf-8?B?Smd2TVRvNW4vdm1XTzl1QkhwM3htSHlTVDlBd1kzazZJWlAvYVZoQnA0UkFo?=
 =?utf-8?B?Q1hjeDU2Sk8rUXd0TG1qa1hnK0pPU1Vjc3JHQXhSOHlNUXAxcVlJeXBYM2sw?=
 =?utf-8?B?M0IzYVhEYlcySURWSFc1Qm1xNUtlZDRrTGt2eDYxOGhBc014bUFDZDlCSC94?=
 =?utf-8?B?MTUzeGhPa2tSanFOcWg3RThCNCtOL250c0JrRUlmZFBjTUFzSGRBK1gxVGJv?=
 =?utf-8?B?blJFZlB1eTJYcEI3VjFocVJ2cGUwYjF5Tjg1Zld1N3ZjN0JYQXFkTDRxQm0r?=
 =?utf-8?B?TWppQ01LU1VwQmJHSVJlWEZSc1JUaXNXdCt4NlhybDIwZCszK3l1eXpsRktl?=
 =?utf-8?B?MDFuWE1ReXVDMDdTQklrRFg1VVZuOWVIQ1VEVUxGQ1NGUXdYMkhzbUFRR1RG?=
 =?utf-8?B?SGlmcGdzcVltc1lucXE3SVZwSFJ5ZFZZZzVITUtoZmJLai9hWG9VVHE3Nzlt?=
 =?utf-8?Q?fOoYhpXHDuam0ugolnlcRVCqp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff57b12c-395a-4ea6-7969-08daf917812a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 05:47:37.7173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uk1TnapNxyLLfzC5Oo/uF3hdO9AuZxNLDiH/Pt4dBqgafYSk2x//qf4G80pD+5L76saOG3H6PtsIhaf1iSW3qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5315
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/2023 11:15 PM, Raghavendra K T wrote:
> On 1/17/2023 8:29 PM, Mel Gorman wrote:
>> Note that the cc list is excessive for the topic.
>>
[...]
> 
>>>   struct kioctx_table;
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index e4a0b8bd941c..944d2e3b0b3c 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -2916,6 +2916,35 @@ static void reset_ptenuma_scan(struct 
>>> task_struct *p)
>>>       p->mm->numa_scan_offset = 0;
>>>   }
>>> +static bool vma_is_accessed(struct vm_area_struct *vma)
>>> +{
>>> +    int i;
>>> +    bool more_pids_exist;
>>> +    unsigned long pid, max_pids;
>>> +    unsigned long current_pid = current->pid & LAST__PID_MASK;
>>> +
>>> +    max_pids = sizeof(unsigned int) * BITS_PER_BYTE / LAST__PID_SHIFT;
>>> +
>>> +    /* By default we assume >= max_pids exist */
>>> +    more_pids_exist = true;
>>> +
>>> +    if (READ_ONCE(current->mm->numa_scan_seq) < 2)
>>> +        return true;
>>> +
>>> +    for (i = 0; i < max_pids; i++) {
>>> +        pid = (vma->accessing_pids >> i * LAST__PID_SHIFT) &
>>> +            LAST__PID_MASK;
>>> +        if (pid == current_pid)
>>> +            return true;
>>> +        if (pid == 0) {
>>> +            more_pids_exist = false;
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    return more_pids_exist;
>>> +}
>>
>> I get the intent is to avoid PIDs scanning VMAs that it has never faulted
>> within but it seems unnecessarily complex to search on every fault to 
>> track
>> just 4 pids with no recent access information. The pid modulo 
>> BITS_PER_WORD
>> couls be used to set a bit on an unsigned long to track approximate 
>> recent
>> acceses and skip VMAs that do not have the bit set. That would allow more
>> recent PIDs to be tracked although false positives would still exist. It
>> would be necessary to reset the mask periodically.
> 
> Got the idea but I lost you on pid modulo BITS_PER_WORD, (is it
> extracting last 5 or 8 bits of PID?) OR
> Do you intend to say we can just do
> 
> vma->accessing_pids | = current_pid..
> 
> so that later we can just check
> if (vma->accessing_pids | current_pid) == vma->accessing_pids then it is
> a hit..
> This becomes simple and we avoid iteration, duplicate tracking etc
> 

Did more brainstorming/thought on this, I see that you meant

active_bit = (current_pid % BITS_PER_LONG);
accessing_pids |= (1UL << active_bit);

In scan path:
active_bit = (current_pid % BITS_PER_LONG);
if (!(accessing_pids & (1UL << active_bit))
         goto skip_scanning;

My approach above would perhaps give more false positive, this seems 
better thing to..

Thanks, will come up with numbers for this patch  + your vma scan delay 
patch.

>>
>> Even tracking 4 pids, a reset is periodically needed. Otherwise it'll
>> be vulnerable to changes in phase behaviour causing all pids to scan all
>> VMAs again.
>>
> 
> Agree. Yes this will be the key thing to do. On a related note I saw
> huge increment in numa_scan_seq because we frequently visit scanning
> after the patch
> 
[...]
