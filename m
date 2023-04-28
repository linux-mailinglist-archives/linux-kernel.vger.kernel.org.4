Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1756F1166
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 07:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345261AbjD1FpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 01:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjD1FpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 01:45:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC901FFD
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 22:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQO1lJWh/e//F77SJYPHDp2YjTk8OL8hw9XxBX4os/rILqGNALxD1kGc8nDcxTxgQms/bjXUY/qPvJU72axci8DsHAK3G1tP5MgTtsYtQwNaE2u16hfY/9S+wVOQKmemFGAfbXNOaNgf7A/coUM8m+Hm9JCpGT/fxew6quNozJS9EUDg270qQVGizgfEKRQs1+yYV3cJYE/Wj8ywoZuEX5kaqNXj8G5YVcPjZZCWR++B+duDHhTM1Uc4INIxZoURXqYX3sJMZlhCOwxslwoepFoMvUeWCzVapAgN+FPKbTE/NF7119V1A6OCumsaLe6KdRueOWd9coiY+TgZiqzPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLi87/kpyxIuj0cWJ0hooEwMTl68Z0/A/IWvt5zVRqY=;
 b=Zu20ZuRmNxxbYs49VUvBoovtgEJD64xasyrufDZaThDlm6icIRIVF8IoXJX1STD8qFecfjOluYv+M5F0FNk+lsI2tQ6UEkXa2FcUKBqV4iaoBevLQIkJQpbQOvF2jXzj7BHTpl2WdnBxFwfJ9Q4bsafIAX9vHQJ1sT1sr2psMZvcGCn4bz5r5Sv3RM5llHOjWkrV81QgWqqsbfZxSshJKuQU5qq4yi9f97iG4mvTEMSjnxiDCwlCHQhvc5xfn0GUd+uwNrOAdw3DjyXHn1FXh2ZA1IoxEqFZ6/61zU3IOw6uQtyqDfIjF++RpHcJEhpZW4nXPtXwvwpCyADUnDPpnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLi87/kpyxIuj0cWJ0hooEwMTl68Z0/A/IWvt5zVRqY=;
 b=TJSiKf/u5wnQ8a8frWtFLEJfd0rEArZ3f16bNwQUYHMQMv5h89EEJJatcTMiuvj9RJBQmi0m7YcRujCo35rS1zejHNH7fZwvnZHjweQtLpQo3WUBdH9u5AUrO3ioO9uCemKMPQgFWXmY9s8NBMkfp+eWSK4wEYezHjD3moxs5AY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 05:45:09 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::1891:71ee:fde7:4e1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::1891:71ee:fde7:4e1%7]) with mapi id 15.20.6340.023; Fri, 28 Apr 2023
 05:45:09 +0000
Message-ID: <21f69b43-a1e7-6c84-a360-dae410bedb3f@amd.com>
Date:   Fri, 28 Apr 2023 11:14:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu: Avoid softlockup and rcu stall in
 fq_flush_timeout().
Content-Language: en-US
From:   Vasant Hegde <vasant.hegde@amd.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Li Bin <huawei.libin@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20230216071148.2060-1-zhangpeng.00@bytedance.com>
 <edvxk47ok5dhlif5mhntrazzg57vxpcwqncjtr4n3ts2zvp6ib@o6qvqfmvxmlt>
 <7bede423-690c-4f6a-9c23-def4ad08344e@amd.com>
In-Reply-To: <7bede423-690c-4f6a-9c23-def4ad08344e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0228.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f14720-78a1-41ed-385d-08db47abb9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dg75KHmNcpBF5mxTodWZBOk6oa1H2d8la00WMysH0fZdsFXbFkUEiduacLGwpmmNTCH2gMit+ZtOHW7wvnJCTDTeunMHKn4R6b0cW51740bdYgOhEfiVhbixIXyxb6le4qrJkLSnCDVaviXpejOUfRE8o+EEEnYk+SOi9qh0Lc7bNLrCuOWneabEiHu9TEJ4WcwOkXULsUR9zLhw8Gxa4XKkAD7G+1fpzGL+m/0VfI2Z5dQvu6XNtFDIP2DypVPtLpNYcQQgsNFm1aDAj3+zyA39U7EAlZG9czhfd/P3ha2J/6npDpAu+DQgB4cqtMa+0A4Y6YS2Z63P0BZBw1mT9H9VrdppSwOL+wreVIm68Nr12SCA33tDBrQG6jx9ppxLsTKzsl/wUoExW7rH80s/tPIOIEP+MJrZGIrnlU1wIt6eB7Y/rJs5YtFLfZrzPnhXkCbZIjVhYLZu/aUMxVcVGIMoajggh0WoVZrx7yzGXK4vzJi+A7UW6+vOaS6eytOmC07k8Mgz40bCKy0yNkW/NrolmAfTccCL0jZe7lG7xPmkP09/H42k3LM8wb4srrntxoKpi2z0bnaKTE76rlh+GusV3QGq8fonB3K9J2NtBp6cjh1PzEUQEFICoxlBD+/tn+r9pYCw5s4k67M6tu9vCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(86362001)(53546011)(41300700001)(26005)(66899021)(6506007)(6512007)(31696002)(2906002)(5660300002)(8676002)(8936002)(36756003)(44832011)(7416002)(83380400001)(38100700002)(54906003)(478600001)(6486002)(186003)(110136005)(6666004)(31686004)(45080400002)(66476007)(66556008)(4326008)(316002)(66946007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHkydnlEWkdXQktNcGlOQ1l5ZGEyYUZTY0Q3bUN1ak9FSEl2b2wxK1lKTWNJ?=
 =?utf-8?B?TGRzN2ZybU45OWlmUDFwU3FOUmoycnUzUmpXMzZyZWUydXBBa1NmZEp4NWxE?=
 =?utf-8?B?N21OYWJDdS8vYmtLUVFQVzh3NlpKaStQOHVFcU1RbXQ3aTNwV0FVeEM1ZHE1?=
 =?utf-8?B?My91WVUySnN4UnZDcW1Nb1NuTE9welV0Nk5ZdVJTNlZlTkdTcDBOUkdWcXVO?=
 =?utf-8?B?ZjBValJTeFdBZll3SlRNSk05eUVya082V1RuSWg0Q0svQ3diSGRISktuc1c2?=
 =?utf-8?B?dE4yQk5oNUFCWU5xd2JSc0NwUDl2MnRpYzhkaTdwZUVMWmxFdXdESDBNSnVi?=
 =?utf-8?B?VU9HWlo3LzFpVXhsMERXTXdsTlI3WW4zVDVEUVB2dFBKNW00R2drSE9uWVFO?=
 =?utf-8?B?N1FBSkluOE5JbkJrVmhHWDd2Z3JJYVZSMlM2YjMzUmJ0V04yU25MM0Fock1L?=
 =?utf-8?B?TUFlc25jWkhmRDl5OC9WdzJYdWppUVgwQVpXbVdWZEwrdE5Qa2s4bWlWWGtH?=
 =?utf-8?B?am40RmJjZFl4SDRDL2s0V3JDcmhZdVFxeHF0WlFlenZNd2N1MWxkQmU3ODcx?=
 =?utf-8?B?WGhIbnJFWXRMMzJNdDc2ZGl1VjBGMzZDbktLU2F2N05zZWl5cTNjQVRpNXVj?=
 =?utf-8?B?RnhPK3dDNjdzSFVCaUppM3diN2t3aHd4ai8xM3B4cTVQODkvNnBpQmdTV0FV?=
 =?utf-8?B?RDRQdWRsdnB0MXkrUjR3L2RaTjF3b1hXZXlxaXFmbkRIaE1EeENGcWdzc1kz?=
 =?utf-8?B?VmdCMXZ2cnNEVTgxZVZJWjExUmNGYlJhYVlJK1dCRTlqeXZGUDcyQzVjVGxo?=
 =?utf-8?B?UGdHeVVNQzRlMFcxNC9qcU96bzRrcjF6QTNFZlB6OUZKdjU1MC8wVnBZSW5B?=
 =?utf-8?B?MnJROVQzSzdLbkxPUkVYOUwvQTIwaXRDTUNPNStCNlNXWG1YSmlJOTY2clRB?=
 =?utf-8?B?ZUhwLzREdlhPcDlDR1o3Y1dWMVArQ0xwaStiSVE1RzR6WHJLeERiK1lNelVl?=
 =?utf-8?B?UU54Q3JIUkFReFNZQXZBdjJFR1R2U243cEdJQWZRNFJ5SHlYZDA2VUxlQlRS?=
 =?utf-8?B?aHJyL09rYnN0VzdmY1FWK1BqNzZmeGxiVmJFQkkwZ1p3VkdzYlNtMkFUYUhz?=
 =?utf-8?B?cU5MYWM4dk43eGcxNUZZMXB1eXJEQUFqM2UrYWJQRzU0TE1wc0plR01XdWV4?=
 =?utf-8?B?MW1TRXdFS3hjUU56VktzU2lJRmpVOVhIclY2UEt2QW00N2Rud1QzenlTdVhW?=
 =?utf-8?B?cEozWHdnam5qNW5FdVNRQUNFTW43N3FHTzlzQUJMUlp3MGJlTS9BTm9IUE1s?=
 =?utf-8?B?WEZxZ2xvSWE2anJRZUxMQ284SkRhWmE1VHBJczMyQ1dCYU5uMFNiNm9vbXhv?=
 =?utf-8?B?dCtCUTVHNExtcjk5b25IUDJKSzNQOVY1L3dvYlhVR2lxZFd6dWkwYWF1RTRL?=
 =?utf-8?B?elRWSDBoVHB1UnNxcTJ1WmZvU3dLb2VhdUZNZGpqdEF1b2VTRlRMSkpkbXpP?=
 =?utf-8?B?VGwyMnhiTG05cGZBV3RjSHAvZlhOOGhWc0hWcVJaUXVwQWZBaUlRSXcybHpu?=
 =?utf-8?B?MzYxZ08yNms1VjFRUHM1R2JCUXRwSENLajc3dmJSaVZlSEgwa2ozZDdhdllG?=
 =?utf-8?B?Z244eXNjTG1zd0Y1OE1mOWFQV1R1M29HV0hDdDh3NVZpREkyaEhpUUVya2Jv?=
 =?utf-8?B?aWVDdW54UDNscXRwRmpKK1ErVEtRL3FyWlJFMUNuclpFa0kxK0xrNVhRem5o?=
 =?utf-8?B?aHJOdG16bHBia1VmcWtQWjdJd2pUTnFpNGdnNWZJV1ZFbGVjekVNOU03blpU?=
 =?utf-8?B?alpENzF2WFMvY0J0dU9XT0FNRjdQeTZUdkJrUUhDU3JQUFNtdkkzZjJzRSt1?=
 =?utf-8?B?RDczQ1lBUk9SdnEraG1oWGZvVUFmaFNyM0dUOC9oMzlUMnp0SjczaVQyWUIz?=
 =?utf-8?B?NVJ3eTByK1RmeGwwblp4cHp2QWV6bnIwZXhMV0hZN0kxQ0c0a1ZXTWtkMHUv?=
 =?utf-8?B?eDJuMmwzWVpWRUEvRHZ0SndBck1sZ0wvK1A0dUVxNnkvL3FwU1lhZDhVNnp5?=
 =?utf-8?B?djNvZ1h2WVd2K0RCUDZjWEJTcXBFem93bUJMS1VMbW5QT0lKb0ZHd0w4bTM3?=
 =?utf-8?Q?fOU+EaZDYasXPWsMu5L30XEBl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f14720-78a1-41ed-385d-08db47abb9eb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 05:45:08.9342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkOWhb1SrF2gZqpad/uDsKjKTY6ObLimhE1VbGsYhaVXU/KZ/m/2/YwYmCYSAEbYXbshR11ifQP6Azoin8RbpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7572
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Robin, Joerg,

Ping. Any suggestion on below proposal (schedule work on each CPU to free iova)?

-Vasant



On 4/18/2023 4:11 PM, Vasant Hegde wrote:
> Hi All,
> 
> 
> On 4/11/2023 3:52 AM, Jerry Snitselaar wrote:
>> On Thu, Feb 16, 2023 at 03:11:48PM +0800, Peng Zhang wrote:
>>> There is softlockup under fio pressure test with smmu enabled:
>>> watchdog: BUG: soft lockup - CPU#81 stuck for 22s!  [swapper/81:0]
>>> ...
>>> Call trace:
>>>  fq_flush_timeout+0xc0/0x110
>>>  call_timer_fn+0x34/0x178
>>>  expire_timers+0xec/0x158
>>>  run_timer_softirq+0xc0/0x1f8
>>>  __do_softirq+0x120/0x324
>>>  irq_exit+0x11c/0x140
>>>  __handle_domain_irq+0x6c/0xc0
>>>  gic_handle_irq+0x6c/0x170
>>>  el1_irq+0xb8/0x140
>>>  arch_cpu_idle+0x38/0x1c0
>>>  default_idle_call+0x24/0x44
>>>  do_idle+0x1f4/0x2d8
>>>  cpu_startup_entry+0x2c/0x30
>>>  secondary_start_kernel+0x17c/0x1c8
>>>
>>> Rcu stall may also be triggered:
>>>
>>> rcu: INFO: rcu_sched self-detected stall on CPU
>>> NMI backtrace for cpu 21
>>> CPU: 21 PID: 118 Comm: ksoftirqd/21
>>> ...
>>> Call trace:
>>>  fq_flush_timeout+0x6d/0x90
>>>  ? fq_ring_free+0xc0/0xc0
>>>  call_timer_fn+0x2b/0x120
>>>  run_timer_softirq+0x1a6/0x420
>>>  ? finish_task_switch+0x80/0x280
>>>  __do_softirq+0xda/0x2da
>>>  ? sort_range+0x20/0x20
>>>  run_ksoftirqd+0x26/0x40
>>>  smpboot_thread_fn+0xb8/0x150
>>>  kthread+0x110/0x130
>>>  ? __kthread_cancel_work+0x40/0x40
>>>  ret_from_fork+0x1f/0x30
>>>
>>> This is because the timer callback fq_flush_timeout may run more than
>>> 10ms, and timer may be processed continuously in the softirq so trigger
>>> softlockup and rcu stall. We can use work to deal with fq_ring_free for
>>> each cpu which may take long time, that to avoid triggering softlockup
>>> and rcu stall.
>>>
>>> This patch is modified from the patch[1] of openEuler.
>>>
>>
>> Hi Robin,
>>
>> I was looking at something similar to this recently were in this case
>> they were beating the heck out the system with the hazard io stress
>> test, and someone else with some medusa test tool. In one case they
>> had them force a dump on the soft lockup. On the 384 core genoa, 90
>> cores were spinning the iovad rb tree lock for one domain, 1 had it,
>> and the poor flush queue timer handler was having to fight everyone
>> for the lock. I'm not sure what would be considered a realistic workload
>> compared to these stressors, but could this be an issue over time as
>> systems continue to get more cores since the timer handler potentially
>> grabs and releases the iova domain rb tree lock for each cpu? The only
>> cases I know of are using io stressors, so I don't know how big a deal
>> it is.
>>
>> I think soft lockups could still be produced with this patch, since
>> there would still be the lock contention.
> 
> Right. We hit this issue when running stress-ng on 384 CPU system having NVMe
> disk. I have tried this patch. This improved the situation. But we still hit
> soft lockup after an hour or so.
> 
> Backtrace with this patch:
> 
>  4551.470797] watchdog: BUG: soft lockup - CPU#328 stuck for 30s!
> [kworker/328:1:2710]
> [ 4551.479441] Modules linked in: nvme_fabrics(E) intel_rapl_msr(E)
> intel_rapl_common(E) amd64_edac(E) edac_mce_amd(E) kvm_amd(E) kvm(E)
> crct10dif_pclmul(E) ghash_clmulni_intel(E) sha512_ssse3(E) aesni_intel(E)
> crypto_simd(E) cryptd(E) rapl(E) wmi_bmof(E) binfmt_misc(E) ipmi_ssif(E)
> nls_iso8859_1(E) ast(E) drm_shmem_helper(E) drm_kms_helper(E) i2c_algo_bit(E)
> syscopyarea(E) sysfillrect(E) sysimgblt(E) acpi_ipmi(E) ccp(E) k10temp(E)
> ipmi_si(E) ipmi_devintf(E) ipmi_msghandler(E) mac_hid(E) sch_fq_codel(E) msr(E)
> parport_pc(E) ppdev(E) lp(E) parport(E) ramoops(E) reed_solomon(E) pstore_blk(E)
> pstore_zone(E) efi_pstore(E) drm(E) ip_tables(E) x_tables(E) autofs4(E)
> crc32_pclmul(E) nvme(E) ahci(E) xhci_pci(E) tg3(E) nvme_core(E) libahci(E)
> i2c_piix4(E) xhci_pci_renesas(E) wmi(E)
> [ 4551.479475] CPU: 328 PID: 2710 Comm: kworker/328:1 Kdump: loaded Tainted: G
>           E      6.2.9schd_work+ #1
> [ 4551.479477] Hardware name: AMD Corporation Genoa, BIOS RTI 03/20/2023
> [ 4551.479479] Workqueue: events free_iova_work_func
> [ 4551.479484] RIP: 0010:_raw_spin_unlock_irqrestore+0x21/0x60
> [ 4551.479488] Code: 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 49 89 f0 48 89
> e5 c6 07 00 0f 1f 00 41 f7 c0 00 02 00 00 74 06 fb 0f 1f 44 00 00 <65> ff 0d 50
> f8 fc 7d 74 13 5d 31 c0 89 c2 89 c1 89 c6 89 c7 41 89
> [ 4551.479489] RSP: 0018:ffa0000092e07e30 EFLAGS: 00000206
> [ 4551.479491] RAX: 0000000000000000 RBX: 00000000000000f2 RCX: 0000000000000000
> [ 4551.479492] RDX: 0000000000000000 RSI: 0000000000000282 RDI: ffd1ff3cf82be060
> [ 4551.479492] RBP: ffa0000092e07e30 R08: 0000000000000282 R09: 0000000000000000
> [ 4551.479493] R10: 0000000000000000 R11: 0000000000000000 R12: ff1100010d2af6d0
> [ 4551.479493] R13: ffd1ff3cf82be060 R14: ffd1ff3cf82bb858 R15: 0000000000000282
> [ 4551.479494] FS:  0000000000000000(0000) GS:ff11018056200000(0000)
> knlGS:0000000000000000
> [ 4551.479495] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4551.479496] CR2: 00007ffd392f5f28 CR3: 0000000152f06004 CR4: 0000000000771ee0
> [ 4551.479497] PKRU: 55555554
> [ 4551.479497] Call Trace:
> [ 4551.479498]  <TASK>
> [ 4551.479502]  free_iova_work_func+0x6a/0xc0
> [ 4551.479505]  process_one_work+0x21f/0x440
> [ 4551.479507]  worker_thread+0x50/0x3f0
> [ 4551.479509]  ? __pfx_worker_thread+0x10/0x10
> [ 4551.479510]  kthread+0xee/0x120
> [ 4551.479513]  ? __pfx_kthread+0x10/0x10
> [ 4551.479514]  ret_from_fork+0x2c/0x50
> [ 4551.479518]  </TASK>
> 
> I did slight modification on top of this patch (schedule work on each CPU) and
> it worked for me.
> 
> @Robin, Joerg,
>   Does something like below (schedule work on each CPU to free iova
>  (fq_ring_free()) is acceptable?
> 
> -Vasant
> 
> 
> ------
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7aed15e53f10..eb52814e67e5 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -157,10 +157,12 @@ static void fq_flush_iotlb(struct iommu_dma_cookie *cookie)
>  static void fq_flush_timeout(struct timer_list *t)
>  {
>  	struct iommu_dma_cookie *cookie = from_timer(cookie, t, fq_timer);
> +	int cpu;
> 
>  	atomic_set(&cookie->fq_timer_on, 0);
>  	fq_flush_iotlb(cookie);
> -	schedule_work(&cookie->free_iova_work);
> +	for_each_possible_cpu(cpu)
> +		schedule_work_on(cpu, &cookie->free_iova_work);
>  }
> 
>  static void queue_iova(struct iommu_dma_cookie *cookie,
> @@ -235,17 +237,15 @@ static void free_iova_work_func(struct work_struct *work)
>  {
>  	struct iommu_dma_cookie *cookie;
>  	int cpu;
> +	unsigned long flags;
> +	struct iova_fq *fq;
> 
>  	cookie = container_of(work, struct iommu_dma_cookie, free_iova_work);
> -	for_each_possible_cpu(cpu) {
> -		unsigned long flags;
> -		struct iova_fq *fq;
> +	fq = this_cpu_ptr(cookie->fq);
> 
> -		fq = per_cpu_ptr(cookie->fq, cpu);
> -		spin_lock_irqsave(&fq->lock, flags);
> -		fq_ring_free(cookie, fq);
> -		spin_unlock_irqrestore(&fq->lock, flags);
> -	}
> +	spin_lock_irqsave(&fq->lock, flags);
> +	fq_ring_free(cookie, fq);
> +	spin_unlock_irqrestore(&fq->lock, flags);
>  }
> 
>  /* sysfs updates are serialised by the mutex of the group owning @domain */
> 
> ---------
> 
> 
> 
> 
> 
