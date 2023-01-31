Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE37682651
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjAaIZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjAaIZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:25:54 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0987F42BE7;
        Tue, 31 Jan 2023 00:25:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2o6Vk2aaHCDxgF0abF0EvYTz+o2XX7GMKdfyVoJ9gCAEX69mWsv57Zw4hIvCEhgQfE0OG52oV9eOSizm6NMIfcw4htojG2EvlNG6Yc4bksSU1Eb8jlmfy5p62H+2ljXfQRlZqvj06K3nRhdzi4nG3hcnwR1GB/GTcP0R9O7DnZ5ixm/AWdd5g/2ggn4GfEtLEjbu27/OuiZ5Ful9H7LS1ASDO0gYBuMSnOc1mFDwytHT+eFjhgRkeYpSADnLC1t3m6xyRoG9gBhHoFP6Ld9/oaLd/K/ey5pQ7dSh9+XN8uaJkYj3/415FpDRvUA9UYJuW47U07RFCglJbbJ2SzXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDzqzMhYnbhNGLmSPH0FcZPDDZRS+ARYxJlLaQgPMwE=;
 b=ciDP1QWfJgm2EZMH7iVoZGuLcmXdFLGYAcxcqcK3N6cPmbY2aGfhMdjKvg0F7pr9WMZbGZ+FExtnY2T/izdYfMLO6hysLj3H7c7cokXnEDI8wOw/SlYdNpuLUNBXUkx4lyxYGHKrTkzDmOb7t+jWYa6f/bMKxIGY7n/EdJY1npOjmjpa7Kvs2nOY5LftIv/WE0PhWP/oQsPvf3WBr8lAocRHlIhNq+OjRaYQH4hB4AC03lagpdg5L5rkRgd6LDBo26LmVRbwKzkpMWosNo/3jz2DIFTbolJztNWeQ8JoEsTDa/j+mG7Rl0+oxPv/L0L5w9Oiek52V0zNPwkg80UgSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDzqzMhYnbhNGLmSPH0FcZPDDZRS+ARYxJlLaQgPMwE=;
 b=fCrjfY2rFLfEm1WdIEY8fFUXnX2MrNDLZHOJHOzeds1BaYUhAj6GQk8vAyTotnzf9lCkdu62dYjrULEvliun/jQ/uNzLWjCk62SX7SajqGtrhzk1A63m2Zgvs5PhsFNiA5SMCELeyOIchCE923g0ZGAfTYRMJNIByE8c6M5PS+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW4PR12MB6780.namprd12.prod.outlook.com (2603:10b6:303:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 08:25:49 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::25e3:3a9c:e866:787]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::25e3:3a9c:e866:787%7]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 08:25:49 +0000
Message-ID: <fcf5ee96-178d-061a-ccbe-9be925b1b708@amd.com>
Date:   Tue, 31 Jan 2023 13:55:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/1] perf: Fix warning from concurrent read/write of
 perf_event_pmu_context
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, peterz@infradead.org
Cc:     syzbot+697196bc0265049822bd@syzkaller.appspotmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230127143141.1782804-1-james.clark@arm.com>
 <20230127143141.1782804-2-james.clark@arm.com>
 <2cb6bb4b-fd04-556e-0790-524bf174cf89@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <2cb6bb4b-fd04-556e-0790-524bf174cf89@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::16) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW4PR12MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: d54ccb56-8f20-4500-d533-08db0364c23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: arbEy5LfgFtxm+9DAxmfhtrJHXx08a0bED6tMzmRw/YJVNVeD0X8V9pbcm9twwpPozJe++YgTAjJmeaTxwngZrdG4g1VXIJlCZDIhcGckUllHWwSrdjgxZxR/pXUqWLVptnmJuMPoOR9AusAgK+SEIjE+Oyr3z+Lfcc03ylSmK4pMLFeEP1cSd15lrKYlbAUMMGQ/OogNXlpdKFTI4FSNWrEOLdwdeVx38obXAUMolv2VzI+dzoE+vaYSXxTFd326SsZjljhmSXy3Ew5+avGfLnM/2GXAmLtMDPKBH0CQNxTdZ65O0GdEGN4aYKk/t+aaED+Rn7d/ofc92Pb1iBAJOM4nQn+UVCYRCh/Ff2e1l47WqRkuu8TziCyQCddTREHxv0A/4I1ggCH4NjD98YH/DEc+k4TcWmoT5qtWaZ+vL02/Fdy45UTxJVEBPQ0hUu0Kta65bcMTnRdX3kXNQbum1R8zuhaGelY5cE4QR/qsWWDj/jsEHhoTVBGCNaYoP4K0dCOFUazPLFnAUjdnzGa9JEDFvTa83hOJlHCRp7xZ6SeKjHhWLKw+eWroqRtRXaKCW0znNDvVSNhQYrqUu2VY2qBNRqpPu98bAUSMMFdNHj2gdlR5TYM7tYEVBB07ui0um/0Q1GEWnDs3rf/Mr+oqOyUeorsEb7ueKskQWuaFN2YhVV5bEh6HrvYkxPzB4MUQZW685EkZsn4m9bbzKVYFNRL7cgQxWaFeHjC3Mkx4yfSBb4v5bK12MWZ2yy2EYvMHI7WbI5oOsVvsrEsOVBWEJYHxQQHQeFLnaKBlVWXmlU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199018)(45080400002)(2906002)(316002)(6486002)(6506007)(44832011)(6512007)(26005)(186003)(53546011)(5660300002)(7416002)(36756003)(54906003)(2616005)(966005)(6666004)(38100700002)(31696002)(31686004)(83380400001)(86362001)(478600001)(4326008)(66556008)(66476007)(8676002)(66946007)(8936002)(41300700001)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlhhK1J5YWMxdVFNTEt3QWptSlNJaGFJcFZrbFRSVHdXLzhTMDZYbHIvTk8x?=
 =?utf-8?B?aVl0NTMrQjBZUVhsTi9DSXpINkRsY0M2QjJ1cmFibVExUXV4MWJkOU82SzFz?=
 =?utf-8?B?YmMzMU9pSlYxTkVKM05PSXFqdE1hU2JoQld4aWxTK3dNaThERFdpY1pQUUY5?=
 =?utf-8?B?WUhFTXIyNloxWGNqN0RMSHFXZ0NJMnc2cXl1WE5DckM3KzhXaFBqZElIMGIx?=
 =?utf-8?B?RkFFa2o5SjVWNEhoRXhhQS91YlUvMVdHYTFkL3BjcmIrWUVkQ0NWc09NcWN4?=
 =?utf-8?B?MXI5YUpsTkRQbnYxUFhqY0ZtNm0xVlovcTFISTl1SnExeTZ6ZEdOeDlydzdl?=
 =?utf-8?B?Z2tnMFpsRE0ra29Ec2RFL0dyYlVsem9zMVAvVmNZQktwc3g2SXlLMkVWYWd2?=
 =?utf-8?B?NjNpK1psckVFSU8vNExWN0hVWHFMRzA0WllITGcrekozSjhGWExBelRwS1ho?=
 =?utf-8?B?TzZpZU9CWHZKbHk4QUF5TFhaMkFiTTJWSnppUXlmQ1RTaVQxQmlmQ2ZJRjN1?=
 =?utf-8?B?VW43bFM0a3dNbjdWWXBUUlh6WUR4S2dnK0xHU25XUlE0dGFDY1VKeW1xajlR?=
 =?utf-8?B?ZWo1eE15RzVOWFZhcTdnNTVXWVpETkJ4d25acEtTY0FTcWZaTXRza0pyY0pl?=
 =?utf-8?B?VktjeEc1TGQ0T1Z2cG8zZ0d6L3lOMXBveTMrRDg3d3NZeVYvMUptRW1KK01j?=
 =?utf-8?B?b3pBOUdIblFsMmpyM1RuUlE2QWdiVk5YUDBmcjVjK3BXY2c2NlJjTTJrWFV0?=
 =?utf-8?B?VkxsSWo3azlIbUVNYXBCU1FGb25WZDdVVHd2REltUnZRdG5rOWZCZk5MS0hI?=
 =?utf-8?B?TmxlbGZzc3pYY2RVOEZuMjhwcUtIck53NlFtS3JTSkV6bTcvRGxWSmR5dmZv?=
 =?utf-8?B?WjVpdWcyWUFEVkFOWWM2U3lGdThHR2F0ZFJ4V3VWUDk1R3E2WGx3YTRMZjR3?=
 =?utf-8?B?MnhEZUNGTkdxY3FJTnRWSmkxVmRNMFlDT0hGZnU0RWpZQVpWV1hFeW5lSUZK?=
 =?utf-8?B?bURqMUVUc2o5R2djKzg3dnd5QUIwNXNEcHVkTmsrTE93ZkVvN2dBNHQyWHRp?=
 =?utf-8?B?UEdqZjBHTm9kRzVJUFR2U1NtOU0rU254a2c2NUFUdlBIOUFtdGVTU0hLbHNq?=
 =?utf-8?B?b0syVWZTRnh6N2RhMmxsZGZYS1ZoclpRcXhJZGxvTld4bllzZjgzZ1RLdEpN?=
 =?utf-8?B?cTJvWTIxTGVuQTdPVFc0SkdLMFdCZFRBVFlQYXdzaXFDL1NrTmgxUWR4VWpE?=
 =?utf-8?B?TTE2SE1GOVJHQzQrazdxbGwrMEpvS1dzZ1dKRUE3TE1BWEJMNHg5NE5QZmJL?=
 =?utf-8?B?QmlrTWc5VEpad2VpNWh4VmtPYnMzWlcxQ3crU2NGWXdaMlRyUXdYMXg2Qmdu?=
 =?utf-8?B?QVQ4MjVLYnR0MkxqZk1PQjhnZFJCQmFqakdtMitOOExtSEdzVEFrSDRWNlZU?=
 =?utf-8?B?a1FOdVVrc2ZMZXhsdjFTYVh1WmRNb1RnZ3UwWkJ3WHdJa0crRjVmWHQ2cTJv?=
 =?utf-8?B?TUhncndRdmpkcmhnMmxHdGU1dnpWWVdUbVdpSFl1bmFqNU1xUlAwWW5xYStV?=
 =?utf-8?B?RDhBdWpaSFJMVlNEZnZBZlNoYm9DdVJZNUR2RCt3WkJ1WnFmRjZXMGU2VVMr?=
 =?utf-8?B?Vzl3YUhXcnZPMENoaVFzYVZkVnZPR1N6TGZhUndkc0ZGVSt6S0FuQTE4SVNk?=
 =?utf-8?B?cG5HdElkU3ZwamdVMmd5V0ZxNEZqcURGcEFQZTI3WXM2aVZTV2JFWkJUMHhr?=
 =?utf-8?B?WHlmZHhBMWp1ZlRwQTVXdmErRVE0UGVTZUdUWEE0SG1LdXVGTFVMZllzbDZ4?=
 =?utf-8?B?ckUrSU1iSlRRbWNKZ2JaS0gyNW5Bb0JmUWhsUDNVcmJKZ2FlaTVyUnNvMUIw?=
 =?utf-8?B?aDBCV2NuM3gxNlFFejE4RkJtZjMxdXp1ZUhkdUhiZ2J1QWt0ZW44alc5NGI1?=
 =?utf-8?B?WUFya3MwQmNpZ1ViT1ZScytmU0I4UU1RQUtNdXcxOHg5enJiR2tBSDZLdnBL?=
 =?utf-8?B?VGtYNGVoY201eGRTY1YvSmdjb3duZE56a3JjVlFPekRjMC8vcDRaVkJIZk9m?=
 =?utf-8?B?U0pGYjRYQTdDYzVXYmtFVXFmL1VJR09LbTVpejEwVCtBNU5qY1pRT2ZUYy93?=
 =?utf-8?Q?d5FTYGMTyL8swKXE+H4wjzEMb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54ccb56-8f20-4500-d533-08db0364c23e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 08:25:49.4817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ga+qTFSA3M7cs15tmBcMtmCeTKDr9zsuZe3/ZAhd5pQZhBIJnGSfEtk6+rwf80CzioKrtD92fxqnivR7aleZ1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6780
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-Jan-23 11:19 AM, Ravi Bangoria wrote:
> Hi James,
> 
> On 27-Jan-23 8:01 PM, James Clark wrote:
>> When running two Perf sessions, the following warning can appear:
>>
>>   WARNING: CPU: 1 PID: 2245 at kernel/events/core.c:4925 put_pmu_ctx+0x1f0/0x278
>>   Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_mangle ip6table_nat iptable_mangle iptable_nat nf_nat nf_conntrack libcrc32c nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables iptable_filter bridge stp llc coresight_stm stm_core coresight_etm4x coresight_tmc coresight_replicator coresight_funnel coresight_tpiu coresight arm_spe_pmu ip_tables x_tables ipv6 xhci_pci xhci_pci_renesas r8169
>>   CPU: 1 PID: 2245 Comm: perf Not tainted 6.2.0-rc4+ #1
>>   pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>   pc : put_pmu_ctx+0x1f0/0x278
>>   lr : put_pmu_ctx+0x1b4/0x278
>>   sp : ffff80000dfcbc20
>>   x29: ffff80000dfcbca0 x28: ffff008004f00000 x27: ffff00800763a928
>>   x26: ffff00800763a928 x25: 00000000000000c0 x24: 0000000000000000
>>   x23: 00000000000a0003 x22: ffff00837df74088 x21: ffff80000dfcbd18
>>   x20: 0000000000000000 x19: ffff00800763a6c0 x18: 0000000000000000
>>   x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>>   x14: 0000000000000000 x13: ffff80000dfc8000 x12: ffff80000dfcc000
>>   x11: be58ab6d2939e700 x10: be58ab6d2939e700 x9 : 0000000000000000
>>   x8 : 0000000000000001 x7 : 0000000000000000 x6 : 0000000000000000
>>   x5 : ffff00800093c9c0 x4 : 0000000000000000 x3 : ffff80000dfcbca0
>>   x2 : ffff008004f00000 x1 : ffff8000082403c4 x0 : 0000000000000000
>>   Call trace:
>>    put_pmu_ctx+0x1f0/0x278
>>    _free_event+0x2bc/0x3d0
>>    perf_event_release_kernel+0x444/0x4bc
>>    perf_release+0x20/0x30
>>    __fput+0xe4/0x25c
>>    ____fput+0x1c/0x28
>>    task_work_run+0xc4/0xe8
>>    do_notify_resume+0x10c/0x164
>>    el0_svc+0xb4/0xdc
>>    el0t_64_sync_handler+0x84/0xf0
>>    el0t_64_sync+0x190/0x194
>>
>> This is because there is no locking around the access of "if
>> (!epc->ctx)" in find_get_pmu_context() and when it is set to NULL in
>> put_pmu_ctx().
>>
>> The decrement of the reference count in put_pmu_ctx() also happens
>> outside of the spinlock, leading to the possibility of this order of
>> events, and the context being cleared in put_pmu_ctx(), after its
>> refcount is non zero:
>>
>>  CPU0                                   CPU1
>>  find_get_pmu_context()
>>    if (!epc->ctx) == false
>>                                         put_pmu_ctx()
>>                                         atomic_dec_and_test(&epc->refcount) == true
>>                                         epc->refcount == 0
>>      atomic_inc(&epc->refcount);
>>      epc->refcount == 1
>>                                         list_del_init(&epc->pmu_ctx_entry);
>> 	                                      epc->ctx = NULL;
>>
>> Another issue is that WARN_ON for no active PMU events in put_pmu_ctx()
>> is outside of the lock. If the perf_event_pmu_context is an embedded
>> one, even after clearing it, it won't be deleted and can be re-used. So
>> the warning can trigger. For this reason it also needs to be moved
>> inside the lock.
>>
>> The above warning is very quick to trigger on Arm by running these two
>> commands at the same time:
>>
>>   while true; do perf record -- ls; done
>>   while true; do perf record -- ls; done
> 
> These dose not trigger WARN_ON on my x86 machine, however, the C reproducer
> provided by syzbot[1] does trigger it.
> 
> [1]: https://syzkaller.appspot.com/text?tag=ReproC&x=17beacbc480000

Unless I'm missing some subtle scenario, the patch looks fine to me.

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks,
Ravi
