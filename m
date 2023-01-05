Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F61B65F4E2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjAET7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbjAET72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:59:28 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595611705B;
        Thu,  5 Jan 2023 11:59:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5KuTay4b+xHOFY7G65ptdb1ToTPcOaZNZHA1JtiVVoNQCk+JnKOtDDaWnV5Mo0GJptNcEZ9AUEBEUZOczx85fHZ2dyK8R0XjESYP/CYNEzLPdCXSoGyMCt77zd5z9FxImiiBHXUE70a36KCo1Xb2tFKJFcRKMox4IICHNfkAbPeMr/SqJpht3LQp21yTxNbx5kGgCZwNmrqbnzMdwLDuZnWpTACxfq9Q8fenpar61BbQ48mCBZbBAFK0KvsNgOc2BG7Sy1g7ZQ8osMwhgxlCWB7xRl2blGl/t9RpOSrPQGWXHM4d6PogSIPOtvUO7lR6Ics/r5lSCDE8fg0jsBjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkjTaWklxkXTZd0cND7PeAo8xi54BrT9i8FJ+3Jejxc=;
 b=WNoaTEIni+0FhkB2hV44IlF3EGJMHdaAJqKKUKVa3ggz+RgBbgk1Z4Y45HuhgvGO2qITMHNXMOw705NvInVVI7rKGPMxoQ30PRO0CpM2uaCfw4dwf+cpO1RSL7wG5RfRCeGbI9AThhTRaXGC2vsTINVR8gvV0DpLy4tafwL86vCXZ42IagcQnxGrhD9C56lQMdwMV54P3esWs4lyd57hqr0Q9vgWbWLW/TJ7ESuCDg0/u5rq++g1EqjpZXhCcZ4MhHHXPg3bhMeiIHEZHb1LxkufhqaLwEbBnqctNf0jSbySCgvcmnoZxzRPo+zVkX48cWuJNcGj/OpbiEMrx2so4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkjTaWklxkXTZd0cND7PeAo8xi54BrT9i8FJ+3Jejxc=;
 b=ecAAtADiDFhqUnS+rQ3zeU/iPhy/lTZR+z/E2dh+JFoBMgkCvIqcc4ZjWhHA5EDxYJXgB6YGIQvdCEp5Y8g5eA+coIhpzrnZE0Cag8DbhoGPaMRSD7/1+gkDIQTB8jYWS2d1JU79FsnIu0n39jY1cnxU+jWB/0ttvGWLVx2zg7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:59:24 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:59:24 +0000
Message-ID: <d9ec29b7-0efe-b9f1-ad2b-95156f6ccdf0@amd.com>
Date:   Thu, 5 Jan 2023 13:59:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v10 11/13] x86/resctrl: Add interface to write
 mbm_total_bytes_config
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
References: <20221222233127.910538-1-babu.moger@amd.com>
 <20221222233127.910538-12-babu.moger@amd.com>
 <3dc31a6d-5485-746d-3c49-df7dcd1827e3@intel.com>
 <d92fa6b3-227c-32f7-87c3-c267e052a824@amd.com>
 <d78e4757-fb74-9d80-da71-9bfe3de9d059@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <d78e4757-fb74-9d80-da71-9bfe3de9d059@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:208:256::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 1689a0f3-1b26-409c-a539-08daef5757d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pm/I23GrNoaNUqZ7jcgDBgERN5dHr/xL3yc7+n6dpvUaKU5/c4sfglMg2BKiNYLp3eCPibB/B6FvEoT2mmQ4R45QRZeAFCkR4bf9LHj6jSm4L94QUnqyOf1mDoRfgM7lSEUwzyvwSBdf5pSqgJuaoJytXsuO6pW7xyhFHF/Uw/LEMlmPubNOdj7Ubyfs9moYypk1+rMN6pZc+RxrqVYwCSTaNj0Epxuo0WElPhaNsu5UmhYOw7gocS+7vk/EW67rZgOdZPy1zdpoKkRHi8hcGyV3y8UTt/05DKQTjeAq8zbBrhBL2lql8SD+LPR5rVd7nFAb7LT11nI5IEO8YaT1+VmOfi8boPFoxuyEBgVVX0b8pmtFMJ3+dmu8q6KI2pWQS2TZIRvJpS/WkuMtiPFFFualPB3vuinxzx1qM5XTUKsypjUtYEYSEhKW/7lm5zT6Rsqg5WhA+mRXvUHBquc/3Y/6aUFFq1bb4DX+uo0fSopC+6XOrD4CHih6n6IqTzUwZh0GBeg8tUXspgC5gVHmI+x6GU/NxLr7FS1NXY2zGZ0hwE94LR0Uv61Zx0mwqK7LjRrTlCoQC2ED34KHWSQvcXAZwyOHx14MaQtWhrNVmRj5+H+C67wwYbErEDpvxh+XsXLam5sF0tVytjPXyLtUVr3T8nlaMk/j202BWeWanTtn8FzS9cM/iW6ghmHIocAV4NMYyjqwP7C9N0RcuxAmQm6yMHu9zK0cvLaQRQ/92n8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(4326008)(66476007)(5660300002)(8936002)(66556008)(8676002)(66946007)(7416002)(31686004)(7406005)(3450700001)(2906002)(316002)(6506007)(478600001)(6486002)(41300700001)(6666004)(53546011)(186003)(26005)(6512007)(83380400001)(2616005)(36756003)(38100700002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3lmOFZ4dy9XK3FIUEhrSU5NbFlkbXpBZDlYdzVZT1A2MlI0MlB5Z2dYOFJ5?=
 =?utf-8?B?VWV0aEtCT2NxODU1QjI3cEFuZVBHZzREdU9INUxhZ1lOUzZhQzltN0ZVUGpY?=
 =?utf-8?B?QzNrT0lwWVhlVjlLQUpEbDNxRE8xSXpXeHBUMXE0ejkvcktMQ0xCK0Q5UUQx?=
 =?utf-8?B?VUxIVUJOQjE3SG5DS09YL3A3ZnBrTlJTMEVPOWZsVHhGY2hVek51NkY4M1h1?=
 =?utf-8?B?TU8veGZvY0QzVGxEKzg2VlpFdW1PZG15UzlMVzY5YXB3QzJsTHhNUXROOW83?=
 =?utf-8?B?dEJxMTFHV2I5dHZqKzh0RVFSUi9XVitZTGZnNFhzalo0d2Z4V2pNUjVTYm41?=
 =?utf-8?B?UWlpMlBxLzRJL2NhRExLYmt4b1FlcHRxejlzRlhtbWNVRFZzWVRHcWN1OVNQ?=
 =?utf-8?B?cXMzNnR3eWhBRVpsL1VReENhVDZDRW1NTDF5TnRUNlF5dUFuLzFiRnR6aFdR?=
 =?utf-8?B?NWtlaFdOc28zUVZ3bGx1YWR6UUJjWEZURi9GNTl1YkhMK01qNnFkS0pDc1lx?=
 =?utf-8?B?SThhL1VvQUhSZlRFREgrb1VKU3M0UCtPV1VFbW0wcVdNWnZucVBtN1FaSVRm?=
 =?utf-8?B?MVp5RStwK1Z2Vnk1aU8wSGN4a0xtMDcrakUwL2ZLT1FwbkNoUXNacitwYlRs?=
 =?utf-8?B?NlFxaHdEZVlDc1pKMVJRTkFzNW9FdXRjTGZHN0V4TjlLZkxPam1nUWhBOEU5?=
 =?utf-8?B?bWFMWUhRTi82QlRMcWZWT1pyR3d4THM1SHdVajkrMnNBQWo3bGxPT0c1MXB0?=
 =?utf-8?B?S0ZkUnhnOVNKNUxKQ0YxVWtzUHZVMXpEaHI1NUE0S3o5eTZtSk1wSUl0SUNN?=
 =?utf-8?B?Q0ROaHFyT0Z4UUZCckZGSjBwTGJDTEp5dERkM0krU0tIaU9LWC9qbzUyT0Jv?=
 =?utf-8?B?SGlXTVoyWkR1MXExWE56eUxtZ1RmL3B3bUthZ1V3UmVpK2JKY2l1L2N3RGdm?=
 =?utf-8?B?Ujk5a3JsV2dub1psUk9zaHYzaGp0cFhEcjFKd0E2ZTFmRHF3ZDFsVHFRZWY1?=
 =?utf-8?B?MlFmVVNxcGFoNTNlRnFxZmM5Y3d4dm82MXFHaG85ZWN6dzJSMnVkZTFCRGdr?=
 =?utf-8?B?MHpjdU1rS0h0SEpSQ09RaXY4T3lkbmFNNUFPRWh4RWlzQWxJZzJzSjN6YmVD?=
 =?utf-8?B?ODlYbHdQT0UwaSt5ZEd3VWpzNy9EWHBIWFM4ZWRrdk5CK0dsOWE5d0pLTVQ5?=
 =?utf-8?B?QUVrUEtSR0N6NnZ4WlFwdU1TbU1paWVCallqejFIZmhIK0tkanNYaGluMVVs?=
 =?utf-8?B?YWorVEZYRkFlSVJwZjRxVFcrVUNMVjRJOWZ5NUxDZnFxNmlaRnF0K1U0TGxW?=
 =?utf-8?B?aGk4blkxMENCRUxKUEFyQmxTWXFvSXNqL1d0V1BkLzBTbklielBHQ1ZzcFJ1?=
 =?utf-8?B?N1FMdXJNbVBZYWtFNWlTVVNEL3NRaEdwanppL2lMM21ucEZkL2Yza3pXWGJ3?=
 =?utf-8?B?WFBWT0ErODIwNFlUVE9MQktrWUs2c2hLZGdrcXMyTTRHODYxRWZJaDJ1QUc4?=
 =?utf-8?B?TkRCdC9JNDZVYlVPNVVBOGlCeXhaR3IybWNFVHZNWnJaZkhMTjFMa2lNQ3Fs?=
 =?utf-8?B?eU1hQVovME1YU1M0N0ZYSjlSZkpoQ1JEOWMxL2NwYWc0SGlXRG04VGp4TXE4?=
 =?utf-8?B?cVdHOFpzV1hOVGRZOWFtYVJxQXIvUW1hN0ZQcmdKcUVUZVJrdGZrT2JFL1hJ?=
 =?utf-8?B?UDU0c2s0QXo3cVBPRFVvQ1JCNFVyWll2TVB3bW1CUFR2ZU45aHd2VGk0c2xs?=
 =?utf-8?B?cmRaanRhSnhxTy81NjF0bURDS0tSK3FNSmhUcnJQdEExZXk1QTVSN1FOTW9Q?=
 =?utf-8?B?Mnp0emhsbVQrTFRtSng1K1dhVXBXTGU3b01xd0tPQld2R3NOU01reFZBaXcx?=
 =?utf-8?B?bUhtRUl6OGR3YVZCZmdRdWkrMWR0NVUva21RcTBFaHV3ZDVYMTA4eE1IOXN0?=
 =?utf-8?B?MHJFUjBVb1Qyemw0T29RY0dkRE5IOU56VU1oZ2sySEk1VlRSRDFBMXY5Z29t?=
 =?utf-8?B?UmRobnQyRVY1YzN0azUzeERDdkhqd1ROQWxEM3hEeFN4T1lONlU2NmxjeFMz?=
 =?utf-8?B?WGlKc3ZDOThQaGQ0Yk8wdXRUazcwV1drNlhmVmV6aEZtYVpqMFJnRk54YlVY?=
 =?utf-8?Q?m7rU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1689a0f3-1b26-409c-a539-08daef5757d2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 19:59:24.4086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdhB5ciDb3FN0wAVQy6y1Zb0bV9De+VT+B5aMlThpcLdrfEOTgVxKNizI7O896bw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 1/5/23 11:49, Reinette Chatre wrote:
> Hi Babu,
>
> On 1/5/2023 8:04 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 1/4/23 18:29, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 12/22/2022 3:31 PM, Babu Moger wrote:
>>>
>>> ...
>>>
>>>> +static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
>>>> +					    char *buf, size_t nbytes,
>>>> +					    loff_t off)
>>>> +{
>>>> +	struct rdt_resource *r = of->kn->parent->priv;
>>>> +	int ret;
>>>> +
>>>> +	/* Valid input requires a trailing newline */
>>>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>>>> +		return -EINVAL;
>>>> +
>>>> +	cpus_read_lock();
>>> Could you please elaborate why this lock is needed here as
>>> well as in the following patch?
>> Holding the cpus_read_lock() make sure that this cpu is online while doing
>> this operation. This code eventually sends an IPI to write the MSR on one
>> of the CPUs using the cpumasks. My understanding is to make sure cpumask
>> is stable while handling this write.  Same thing is done in
> This flow uses smp_call_function_any() to send the IPI and update the MSR.
> smp_call_function_any() itself disables preemption to protect against
> CPUs going offline while attempting the update.
>
> The domain's cpumask itself cannot change during this flow because rdtgroup_mutex
> is held the entire time. This mutex is needed by the resctrl CPU online/offline
> callbacks that may update the mask.
Ok
>
>> rdtgroup_schemata_write.
> Yes, rdtgroup_schemata_write uses this but please take a look at _why_ it
> is using it. This was something added later as part of the pseudo-locking
> code. Please see the commit message for the details that explain the usage:
> 80b71c340f17 ("x86/intel_rdt: Ensure a CPU remains online for the region's pseudo-locking sequence")
Ok. That make sense.
>
> Could you please provide more detail if you still find that this lock is needed?
> If you prefer to refer to existing code flows there are other examples
> in resctrl where the domain's CPU mask is used to read/write registers without the
> hotplug lock that you can use for reference:
> * Even in this patch series itself, reading of the config.
> * When creating a new resource group (the mkdir flow) the MSRs are written with an
>   initial config without hotplug lock.
> * When writing to the tasks file the CPU on which task may be running receives IPI
>   without hotplug lock held the entire time.
> * See resctrl flow of monitoring data reads.
>
> Alternatively you may want to take a closer look at where the hotplug lock _is_ held in
> resctrl to consider if those usages match this work. Understanding
> why the hotplug lock is currently used should be clear with the commits associated
> with their introduction because there has been a few bugs surrounding this.

This is overlook from my side looking at the code in rdtgroup_schemata_write.

I was concerned about domains cpu_mask being changed while doing the IPI.
Looks like that is safe with rdtgroup_mutex.

I will remove the cpus_read_lock() from here and following patch. Will run
few tests. Will send the updated patches soon.

Thanks for the explanation.

Thanks

Babu


