Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34AA66E574
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjAQR5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjAQRyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:54:47 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9CF301B1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:45:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqmuC/U1k3BOHh2Mel/m5LXcGxuuSokZvcfNF2DU980Xtv0Y2ru7vNtjp5sWpzMbNSghcCO0WurFBR5fvFzxX9rbY6OvQqH3f7tE89eUY3fQC0x6VR+J/ay5HQDOrmjpCVRRxtAryHub4fOVJ0BR0JDEAQk50tKZyFooGjPss5BLQvEUKyF0AD3Eu4T46JZt02XYYKdiZeJwPnbcG8GVKcQ73futZWOHze51Pdm4CxA8b8S9NhgrNG/t9mnPmLYk2LEakcO9jmI5IOFYIfMtubVqRKlEF7ZoFoGDI6qIaOkHzybTnEgpXR+qecrqLRP/eRnRWJKecNigaQmNzC2vWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6O6s7sOvBvNJ7RhZy/ja4XrsqQepgp+rknJCcBS2WE=;
 b=Nwi747tEcH6EgJmaMfGmvNKTDYx2rnzaORzm9oQdMkHjav5AtO3YyTYvnc33sNWLn7SK5TNr/344Lf48to+E9nB8TkIOu934j7wXhfYK8Hr+q8F7bWZMLj1cWE6eEHcEJy6+qyM4wef/BVAcXd2uB67Fgta/+YlFcCjF4wfIreIdWCDj7kiCNEUk42Fqux3YhZPqnTTu8Tk/LT3Cc0hsrtjL0nVXrPmplWqiWXDrzKtHvxrIKi18ZexikWxEtjsZ7Zqi5sdSn60omy1zGB18Wawit+kMRxhxp+oxXg5JmAActgcPGXiTGXYp2ziTsuyXX0a8Soo2fDfuKqDaG++evA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6O6s7sOvBvNJ7RhZy/ja4XrsqQepgp+rknJCcBS2WE=;
 b=N6TlA3JMKIbDDpVHxi1ybZumvD6q68fQLECUYfZS91BXwatuMZURsVeccbTQ2B1bYjUVWu41swosRQ0/inBgokaqDkZ+8YOuIL+2ZQHQNApfAnfVqADr92sodOsotQtHpRRviDriskL/gRkjPxd9UhB6HhMgjy28l11TBhmcQ30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Tue, 17 Jan
 2023 17:45:51 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::f9e8:ee48:6cf9:afdc%7]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 17:45:50 +0000
Message-ID: <10a06a2f-0dfc-6f36-3b7b-f4fd03153f66@amd.com>
Date:   Tue, 17 Jan 2023 23:15:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH V1 1/1] sched/numa: Enhance vma scanning logic
Content-Language: en-US
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
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20230117145951.s2jmva4v54lfrhds@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::19) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|CY5PR12MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 95da4097-6c8d-40d8-09ef-08daf8b2ac3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NVtiUqj3GVVe6WD5++ZSb3nmfwpcZDnW/rOGUSaxMF1LAmGF8mPlDsJIpJdAKJR82D4Acds6Rbl1OfKmdGfdcxvUgcY+wCa8/QndssVbd5JQZR7gvSg5CgoiY/YSrp9q2xGJxfYoOpjLo9O05C9OW/2wxdUCLnsI9dlhmhhVvHFcQsDYu7xqavlDPgudgkFzMstnpa0vWQk4vIAwBNkOqSa7idDMJSABIT8UDoCy0bRWbPpmpBwdj9/xIh09maF2pNkQ6hzw/CrQSYhPWuUk4xirOa8SLcvXHvfzZVemwPwlKFe3lI8okqZFtIE+JFDE24zvnC0yBqv4P1TatuymUhDo1bAaeNDCWdZpnskj5ql1jv4lImUWC+kUuD4RxMTazAQ3+u/fASprSPnF4bMfAar/+gCPylvW8ccaEcxNu6caln7XlRsQq6eSBzHw2Xfd1SKKcw/fWJXJ/ocywRwlFnsTS7H6MSMteNfCmMdPp/JF4CnJp4xVktS185a44EBQUaHIC2GbLSv/TmzNa5hA564V69Nk7awsD7+D9CbqJGC8DnccwGk4JHlYW516k8yDYCgTm9o3Qz4s7ANViL/SNTeRLfMEAmQSQEKJSIlo6sbVkWVNzhhSz+T/aYIDDdpMslUL3gpGtunTnsbc0+B9qNthHjmPTQYnMGqr/5C0X14W1+tVkHXDa8ojyQ0tgbZFk8PGeE2RCiFwk7nMdkuX5Cv+ivo79veBFZZbPWEZ34k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199015)(6506007)(26005)(6512007)(53546011)(6666004)(36756003)(186003)(6486002)(38100700002)(478600001)(31696002)(83380400001)(2616005)(66899015)(5660300002)(66556008)(7416002)(8936002)(31686004)(4326008)(66946007)(316002)(2906002)(66476007)(8676002)(54906003)(41300700001)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnRRamRKcDhWOURHa012bXk4eXRjdFN0SGVDeWVzU0VYa1NlWUsyeFo3MXNo?=
 =?utf-8?B?c0ltMDBMbG1jNkgrSEk2aTFlZnU1c01aMW9kSkNzRUZQQ093aHdydW9LOXZY?=
 =?utf-8?B?dHR3bmxqMjFVSEZGZmdkK3Fya1d2cnVMNXllUlZjQUNBTytDNktxRUFDSzk5?=
 =?utf-8?B?TCtabWkwazV3NUNPTG56U1N1eVR6NkdsQ295MnVtVkNJc3JBUDlvakdKMDBp?=
 =?utf-8?B?bW9WWDBaMjFYTEl0dXVXeXBqc2ZkYUVqMW9RQ01HdTltUllLZlFwOS9BcUdM?=
 =?utf-8?B?MEsvOVJSeGdPS0FNZFlwTE9VNW1IQjQ4UkpFeVkwZno1NG5vNlhZbmxhQUtH?=
 =?utf-8?B?dGNycWdidUVpdGxJSlhxTlVkUEFsRXgwWUtlVTVWY1AzL3VrWmhPOXAxdDNp?=
 =?utf-8?B?QjBheWRaWEt5dUl0WmVpaW0wYmd0MzcrNlNxU3YyNzdrWVprZWRKWi8reFlu?=
 =?utf-8?B?bkQ3endXQVBSb2xRL3MyNWZOaEdpMTdwNjd6bjdjcGFvbC9SS2I4SlhSUzdL?=
 =?utf-8?B?MVp4OW5qa1BIa2ZZUlczRUNHL1kxZ1FkSERFK0M1b0Mxd1R4ZVp2WmU3a3oy?=
 =?utf-8?B?VWFIUERwWklEVTdaN0g1V2VlVnNoNW1YZWZBSVZZZ21uazlaQThPNklnRWpo?=
 =?utf-8?B?VWxFQnROaU1ybTZiSzVKUVpHeVlpSGRjcHBCZDNFV1g2U2tFb0UzTWxBeG5l?=
 =?utf-8?B?OHlrN3NlcnlKK2xMS3BJZVNwUjVJV21GdW0vWFA1OHlPZ1dCWWIwVVpjTHox?=
 =?utf-8?B?VFJpTSsvNVg3T1NnR2Znb3B1YjRXTUJJUXJnTW45SUowR21GeG1pcU1DSUp5?=
 =?utf-8?B?cGR1dDFsN2J0YXloa0krYjZYeFlWRUNoSVROL3RMcVBqTEtjYmJEaTU4OGJJ?=
 =?utf-8?B?bUJPUHRLQnc3N0JWbFBhRjJQbkJvY1NMQjRVMWExSGd0RWZXVmlHdld4Z2la?=
 =?utf-8?B?VDkxdmxPYXZmTTFyZWdiYVkrRWV2cXRhdHJWK3ZLTG1aeGpVKy82N1lGeVhw?=
 =?utf-8?B?Z2k5a0Qyb0ZmZ29BcW1XSUFIY3FnZldiQXRoZkg5cDNRWEdiTHJOeWdESkVU?=
 =?utf-8?B?c0xtRmVuMGQ1b0tteDd6TGx1eCswNk5VZTlHbXpGbU5PekU5OFFVamJXMVJS?=
 =?utf-8?B?QlY2YldYdWE4YWgxNVRXTmg4djJJc2NzYkdvb1FaZXpHZnJVTlo2em5LdFlG?=
 =?utf-8?B?U2ljL1NOSDB4SnMzQ1MzK0w2KzYxQ3U0Tnpma3gvU05hdTVNSHdMUjlrUEd6?=
 =?utf-8?B?Mmlya0pZaTVnNlV2allNNlo0S3Q0UWdoZWhuVWpUdnVVSTJ5dU9DbjJOUXVy?=
 =?utf-8?B?UGxYQXZPZHFrKzY5bDg2bWdwSnQrRjhhWlVXQ2hOdTF1eFRHM05YeTd2cHdV?=
 =?utf-8?B?REZHSXJCSGVUQjVkOWY5QkRzNUxPNThuLy9aaThpV055NWU0eWRvOFdIZ282?=
 =?utf-8?B?Q0NoeWRreU9jVDJPUkdkbGdtM2NJQnZ3RnZGM0h1OWdUVHV3WCtMME5aV2xT?=
 =?utf-8?B?aEFXZ2hpT3c1d2VjeEpQODJSenFXT0g3cmM4NVIvdnNQMzZMdUJFRmlnMnlM?=
 =?utf-8?B?Zk9RMHByOWJXNzZBcjMzclVicDBYUkF4S3ZwbGMvMVNOT3pIWTAvbXcrZzc5?=
 =?utf-8?B?cEhVT3VVTWt3WEpJN0R1UFpGQnBxQUJLcDFuRjAraUdyOXhpeXlyTmtFV01F?=
 =?utf-8?B?WFJXWE9JTGo3SThIT2czakxIRzNLZFpmWFBpbzRZUEQwRXVjVDZuZjZyTEJD?=
 =?utf-8?B?L2w4QXQ5WTFPb01hK1VmL2Fzenk3UU9DdkdaNVhkWXUyK2Z3Q3B6U2VCNmt1?=
 =?utf-8?B?NHZZempoWmxUZkRUanFYaHN0TytpcERONi93S29tUXJycVNFdWM5NjJJNnVn?=
 =?utf-8?B?MkpBYUp2OXpvQXczSmt2dEJsYVN1WWI5ZkFsQTI2OXdGUGhxeEs1WHRjdCta?=
 =?utf-8?B?VU9jd29hZmdYUHp4dWNWdm1hM3JDcG95R1VlSWRqV0RldGFrMGZoLytmKzNY?=
 =?utf-8?B?ZVVNWWRBdnpKem9FMVFldEpVamhXRGJkaG1pTEhpRzg2eVFic2RZQlEwdUJk?=
 =?utf-8?B?QnBjUnQ3UlhBVjU4QWI3NEpqd3VVNG1PUDVDTE10b0hyVjBIYm1XMG5oTmUr?=
 =?utf-8?Q?fJ9ELnSg1qj4Hi7mxkNeL0ZLH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95da4097-6c8d-40d8-09ef-08daf8b2ac3d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 17:45:50.7644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OU4bV4KT0q08SmqZxWdHQaQzBLKiia6ZNMco3gv8xv8fQ/NvUoc8QId70pU6W1wz1nXrhXMm9l+CLRFOefDE5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/2023 8:29 PM, Mel Gorman wrote:
> Note that the cc list is excessive for the topic.
> 

Thank you Mel for the review. Sorry for the long list. (got by
get_maintainer). Will trim the list for V2.

> On Mon, Jan 16, 2023 at 07:05:34AM +0530, Raghavendra K T wrote:
>>   During the Numa scanning make sure only relevant vmas of the
>> tasks are scanned.
>>
>> Logic:
>> 1) For the first two time allow unconditional scanning of vmas
>> 2) Store recent 4 unique tasks (last 8bits of PIDs) accessed the vma.
>>    False negetives in case of collison should be fine here.
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
>>   include/linux/mm_types.h |  2 ++
>>   kernel/sched/fair.c      | 32 ++++++++++++++++++++++++++++++++
>>   mm/memory.c              | 21 +++++++++++++++++++++
>>   3 files changed, 55 insertions(+)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 500e536796ca..07feae37b8e6 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -506,6 +506,8 @@ struct vm_area_struct {
>>   	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
>>   #endif
>>   	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
>> +	unsigned int accessing_pids;
>> +	int next_pid_slot;
>>   } __randomize_layout;
>>   
> 
> This should be behind CONFIG_NUMA_BALANCING but per-vma state should also be
> tracked in its own struct and allocated on demand iff the state is required.
> 

Agree as David also pointed. I will take your patch below as base to
develop per-vma struct on its own.

>>   struct kioctx_table;
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e4a0b8bd941c..944d2e3b0b3c 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -2916,6 +2916,35 @@ static void reset_ptenuma_scan(struct task_struct *p)
>>   	p->mm->numa_scan_offset = 0;
>>   }
>>   
>> +static bool vma_is_accessed(struct vm_area_struct *vma)
>> +{
>> +	int i;
>> +	bool more_pids_exist;
>> +	unsigned long pid, max_pids;
>> +	unsigned long current_pid = current->pid & LAST__PID_MASK;
>> +
>> +	max_pids = sizeof(unsigned int) * BITS_PER_BYTE / LAST__PID_SHIFT;
>> +
>> +	/* By default we assume >= max_pids exist */
>> +	more_pids_exist = true;
>> +
>> +	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
>> +		return true;
>> +
>> +	for (i = 0; i < max_pids; i++) {
>> +		pid = (vma->accessing_pids >> i * LAST__PID_SHIFT) &
>> +			LAST__PID_MASK;
>> +		if (pid == current_pid)
>> +			return true;
>> +		if (pid == 0) {
>> +			more_pids_exist = false;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return more_pids_exist;
>> +}
> 
> I get the intent is to avoid PIDs scanning VMAs that it has never faulted
> within but it seems unnecessarily complex to search on every fault to track
> just 4 pids with no recent access information. The pid modulo BITS_PER_WORD
> couls be used to set a bit on an unsigned long to track approximate recent
> acceses and skip VMAs that do not have the bit set. That would allow more
> recent PIDs to be tracked although false positives would still exist. It
> would be necessary to reset the mask periodically.

Got the idea but I lost you on pid modulo BITS_PER_WORD, (is it
extracting last 5 or 8 bits of PID?) OR
Do you intend to say we can just do

vma->accessing_pids | = current_pid..

so that later we can just check
if (vma->accessing_pids | current_pid) == vma->accessing_pids then it is
a hit..
This becomes simple and we avoid iteration, duplicate tracking etc

> 
> Even tracking 4 pids, a reset is periodically needed. Otherwise it'll
> be vulnerable to changes in phase behaviour causing all pids to scan all
> VMAs again.
> 

Agree. Yes this will be the key thing to do. On a related note I saw
huge increment in numa_scan_seq because we frequently visit scanning
after the patch

>> @@ -3015,6 +3044,9 @@ static void task_numa_work(struct callback_head *work)
>>   		if (!vma_is_accessible(vma))
>>   			continue;
>>   
>> +		if (!vma_is_accessed(vma))
>> +			continue;
>> +
>>   		do {
>>   			start = max(start, vma->vm_start);
>>   			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 8c8420934d60..fafd78d87a51 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4717,7 +4717,28 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>>   	pte_t pte, old_pte;
>>   	bool was_writable = pte_savedwrite(vmf->orig_pte);
>>   	int flags = 0;
>> +	int pid_slot = vma->next_pid_slot;
>>   
>> +	int i;
>> +	unsigned long pid, max_pids;
>> +	unsigned long current_pid = current->pid & LAST__PID_MASK;
>> +
>> +	max_pids = sizeof(unsigned int) * BITS_PER_BYTE / LAST__PID_SHIFT;
>> +
> 
> Won't build on defconfig
> 

OOPs! Sorry. This also should have ideally gone behind
CONFIG_NUMA_BALANCING..

>> +	/* Avoid duplicate PID updation */
>> +	for (i = 0; i < max_pids; i++) {
>> +		pid = (vma->accessing_pids >> i * LAST__PID_SHIFT) &
>> +			LAST__PID_MASK;
>> +		if (pid == current_pid)
>> +			goto skip_update;
>> +	}
>> +
>> +	vma->next_pid_slot = (++pid_slot) % max_pids;
>> +	vma->accessing_pids &= ~(LAST__PID_MASK << (pid_slot * LAST__PID_SHIFT));
>> +	vma->accessing_pids |= ((current_pid) <<
>> +			(pid_slot * LAST__PID_SHIFT));
>> +
> 
> The PID tracking and clearing should probably be split out but that aside,

Sure will do.

> what about do_huge_pmd_numa_page?

Will target this eventually, (ASAP if it is less complicated) :)

> 
> First off though, expanding VMA size by more than a word for NUMA balancing
> is probably a no-go.
> 
Agree

> This is a build-tested only prototype to illustrate how VMA could track
> NUMA balancing state. It starts with applying the scan delay to every VMA
> instead of every task to avoid scanning new or very short-lived VMAs. I
> went back to my old notes on how I hoped to reduce excessive scanning in
> NUMA balancing and it happened to be second on my list and straight-forward
> to prototype in a few minutes.
> 

Nice idea. Thanks again.. I will take this as a base patch for expansion.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f3f196e4d66d..3cebda5cc8a7 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -620,6 +620,9 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>   	vma->vm_mm = mm;
>   	vma->vm_ops = &dummy_vm_ops;
>   	INIT_LIST_HEAD(&vma->anon_vma_chain);
> +#ifdef CONFIG_NUMA_BALANCING
> +	vma->numab = NULL;
> +#endif
>   }
>   
>   static inline void vma_set_anonymous(struct vm_area_struct *vma)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 3b8475007734..3c0cfdde33e0 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -526,6 +526,10 @@ struct anon_vma_name {
>   	char name[];
>   };
>   
> +struct vma_numab {
> +	unsigned long next_scan;
> +};
> +
>   /*
>    * This struct describes a virtual memory area. There is one of these
>    * per VM-area/task. A VM area is any part of the process virtual memory
> @@ -593,6 +597,9 @@ struct vm_area_struct {
>   #endif
>   #ifdef CONFIG_NUMA
>   	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
> +#endif
> +#ifdef CONFIG_NUMA_BALANCING
> +	struct vma_numab *numab;	/* NUMA Balancing state */
>   #endif
>   	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
>   } __randomize_layout;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9f7fe3541897..2d34c484553d 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -481,6 +481,9 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>   
>   void vm_area_free(struct vm_area_struct *vma)
>   {
> +#ifdef CONFIG_NUMA_BALANCING
> +	kfree(vma->numab);
> +#endif
>   	free_anon_vma_name(vma);
>   	kmem_cache_free(vm_area_cachep, vma);
>   }
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c36aa54ae071..6a1cffdfc76b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3027,6 +3027,23 @@ static void task_numa_work(struct callback_head *work)
>   		if (!vma_is_accessible(vma))
>   			continue;
>   
> +		/* Initialise new per-VMA NUMAB state. */
> +		if (!vma->numab) {
> +			vma->numab = kzalloc(sizeof(struct vma_numab), GFP_KERNEL);
> +			if (!vma->numab)
> +				continue;
> +
> +			vma->numab->next_scan = now +
> +				msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
> +		}
> +
> +		/*
> +		 * After the first scan is complete, delay the balancing scan
> +		 * for new VMAs.
> +		 */
> +		if (mm->numa_scan_seq && time_before(jiffies, vma->numab->next_scan))
> +			continue;
> +
>   		do {
>   			start = max(start, vma->vm_start);
>   			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);
> 

Thanks
- Raghu
