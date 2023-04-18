Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F62A6E5F11
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjDRKlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjDRKlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:41:44 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0269008
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzBaRxSnY3YrAw94LYF5L9Oy+Gs5E7XCenwpQBe8V1qIfmYitf/W0YIBfDeh4ghkTGkug5zvsMffT8ufqdzmpUlV5LZqHvwgPCYhovoDowxaQOs1xkggDrIr88teNZ2B1ZXRNexioiTSA9QNZnJkjf5T49tq5UOt/jyREY/lWM+8xSaqKFwr5KNrkh1uIVkqP19oDuyUBldcfRE2UsL3AtP7FRxDvIiJQgnE176zgkI+TCaOM4bdZ9lxYN4K5hy5mSk+nS2Tgr/KjLoju8QrP83TjOX6xvNDl2pfslI3xrlFAsgZwA1N3KsTnUpIcjhUAio15eB2ga031olxPWDuFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUvb/68g1EK90ys56J6r/be/ZaRuWF9JVKUOaaBe3Dw=;
 b=KGj9iXNCl33RFSQFYo2RrEKLGaDwkl4brvdtH7HP3XsIFhhrBPDiC9erNaz88dL+oxCuN+iiuKAVP5rDCfZ5f456Sl8uXcAg69bupIrWrSIULijiWgtq8EPZtCRv0HeznHgWZK8QKj/wgrr5+WEBLNjOYkwUb9lIlQqSGjvZH1jWlz52wRT+ssbo7XJkbE4ECTljWZmafGbx8S/Tc4aEVh698LLpNRppbsQW6aY8XhrwqKegiRgunZ5jdOGAfMcz2UiErwkj0mCJYvCOr+DOsU/9BUGH41EMr6DJGkEd5zaOrYGgZwkkVG2LMWfUT8s4/w2yYV755kwzZezZkHVNug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUvb/68g1EK90ys56J6r/be/ZaRuWF9JVKUOaaBe3Dw=;
 b=W/n43vxIcFWA/HRXIkVDIx0RXMvdYfsUxTaxu6A0HZzHSmqJ+d8TqwBXQcMO4mg87WYmyDS7GFQ024DESNHcsOyG8UYQ5VykVfzLTmZXFP9BiUBP4CqWvclIui4QCMTs/K9dNcwQNiX1r91puycib6Yg8AX6/hdtK5yCqx9j5Ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7SPRMB0009.namprd12.prod.outlook.com (2603:10b6:8:87::10) by
 PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.45; Tue, 18 Apr 2023 10:41:36 +0000
Received: from DS7SPRMB0009.namprd12.prod.outlook.com
 ([fe80::5047:70da:1240:8d0d]) by DS7SPRMB0009.namprd12.prod.outlook.com
 ([fe80::5047:70da:1240:8d0d%5]) with mapi id 15.20.6298.030; Tue, 18 Apr 2023
 10:41:35 +0000
Message-ID: <7bede423-690c-4f6a-9c23-def4ad08344e@amd.com>
Date:   Tue, 18 Apr 2023 16:11:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu: Avoid softlockup and rcu stall in
 fq_flush_timeout().
Content-Language: en-US
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
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <edvxk47ok5dhlif5mhntrazzg57vxpcwqncjtr4n3ts2zvp6ib@o6qvqfmvxmlt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::10) To DS7SPRMB0009.namprd12.prod.outlook.com
 (2603:10b6:8:87::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7SPRMB0009:EE_|PH8PR12MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: 09efc007-6c93-44fe-8fff-08db3ff97b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMtRYXkpeZrM6Oi43MfP77ljVju3zOFHLH3GnXEKdAbURQ89Pkxn1/4sQcEriwu+IH7IT8LLa9o8+GBDsDsx1X5TdDSWBNvi3Kyru9JMlrAsKfua3vY2zYALWdQbX0qntddRBimXkn7lXTr1+xz2x/9UHOlgMeSiVK+ucYXSmhlVJF2sRqoZjq6PwD1b38Q5F3IbP+IbTuZMZNJG5hM7kysmdA8Kf7ep6MdSx0AqsFiF3MMz616l4iz1PJQogxCHgAnYJ0ft7RlirUxO/n1QKsQuebYE34pbR0LqFp9m16ToF8rbIUXILBK7hCs01Afnm9TgA2EUyxXg4hzGRSCUGaQ8rdeLZOwJyL2ikO0zh6tvB5f8hH2l8RcjInEXcKkJYCOBQ61x3V469ThAS3S3o6NHVxrI3z1Kh2oWtIitrzYaH/O0GoyNG1FyOP+IAE3LFWp67KbUczLWDCCArGVlsohOG4Mx3TN9iVY+I4yJrnz6+Tq3Z/n9rgCwuUCPdMiPsL1N3wbtol/AhvotOQuNxYWRt0f5ImpyzkNFP8c02JJ0NTY1PQaNA/Pp2ywchVIzgmOHv3+0t9BN7S9oAeIGNMaQiQT9jdlroNFQWZwVetMRRJIi8hqlMdQSStObNWQNz7PLAMuWP/2DkO7rAphYcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7SPRMB0009.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(2906002)(2616005)(53546011)(83380400001)(4326008)(316002)(6486002)(66946007)(66556008)(66476007)(54906003)(478600001)(110136005)(6666004)(45080400002)(8936002)(8676002)(7416002)(44832011)(6506007)(6512007)(5660300002)(186003)(26005)(41300700001)(38100700002)(31696002)(86362001)(36756003)(31686004)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDN2OUdXcVo0MjhXZFYrR3hzUkYyUXdiWUo4M085N1h3OWVkdUFYNXNnN2xN?=
 =?utf-8?B?SG9ZQ2dOOFRGaHVPbGZzL1BJM2JRYUVVL0xrNWpFUmt0VGZkTzhIZTVJSC9P?=
 =?utf-8?B?MTRobVpiTUhpU1RkYlpMc2U1MG1CY3NocFZWWDVGTDlmeEhJclJ2VzRkZWh2?=
 =?utf-8?B?cExONTdJcXlRT1NhZ3FBZFRDSG1wSFI1ajRKSkhOY0xTd25tZ2ZhRXNkSG5h?=
 =?utf-8?B?c0V0Z0MzQmJldkJwZy9rcXdKYmk3QUpmZTFTVTNnQ1daWktQVTVHOCs2anFS?=
 =?utf-8?B?eGFSa3FuQUt3VFFBSFlneGVDODhaMWpVOHZqUis1eEJKUnRSZGdxQjE3bHZ5?=
 =?utf-8?B?U1pZOVZpTGUvdG81czJIYVVDOTVFbWlsMFIzN09UczZKZzB0aWJGTzFzZ1ow?=
 =?utf-8?B?K1dnQ3dxb1h2UzFBUVFBckZXRGVLc2xxSUZKMWFqM2M4U3hiaGNzckxHVGxN?=
 =?utf-8?B?SEcwZ2U1VzNKRXZYWkRHYWVIZmtTQ2VQV3dqQkFwTjl4dmpxSU1XWVdQSm9q?=
 =?utf-8?B?Vi9qQ2tJOWd5bVoxRDFYNmhDbWZ2VE9yQTI4L2JYZUhaemZCekd1Y09jSkVi?=
 =?utf-8?B?N05kRnoyR3hDQXNDQnY1UkRWL1pnbFk3bWRJcGVLU3RZcDEza2duTE1sYUNr?=
 =?utf-8?B?anA1Z1RmZXQ5M09ubmdubzFpZDh1NG85RUFHU2lqOU4xc2lITWlyUEl5Z0xG?=
 =?utf-8?B?cURtQkNFdU1oRmp3d2Y0bGFVeHhmai9oNEtKZ1pJNk9XMU8veFRTQWxRTHVH?=
 =?utf-8?B?MloydTZWZlBnZ3JoM1VmWXAxT3NNSngwQlBya3RlRDhKd1BibHV1c01uajJM?=
 =?utf-8?B?NFhiUGE0ak1RTWpCNGd6K2tIdmlaVTVHb2hkeGFDZDhiYmx2STI3OU91akVE?=
 =?utf-8?B?MVJXQzUwaEF4c00vRFQxWlJ5ZTNzQWd0eC9VdFVuQUdmR1htVE9kUXVJWHhW?=
 =?utf-8?B?TlJlRUhxUHRnRHh5STB4VGZod1BIM09ZZ1gxOXBYa0s1c1V4NTQrZnF2NndG?=
 =?utf-8?B?OFIyWWVzMkhGa2FCSnNiVWFqNVpES2VHSUpDNXNRWVhTdTUwYTgzTlZyZ1dE?=
 =?utf-8?B?c1gxSkUyNit6TjkxUGlWRVFFOFNVb1hGbTYvRzVpYUZMcFplMnQreGo5aDRF?=
 =?utf-8?B?QWNtaUczUElidnMzT3JUVEhpNlJMckl6TnhuYjZ6MUg5VVdKWS83OHlzUnZM?=
 =?utf-8?B?aENnU3RsQ1YvdnZSUk9VQW9oY2Fxa3NPb1crSlhDUjA1UzB6aUdhNlFmMUo0?=
 =?utf-8?B?NmZ6R2h2aGVsRWRYUytGSTRQZjJEQVhGVkVtam9tTFRiNTNQUTNMcUIrNGli?=
 =?utf-8?B?WnpzdkhqUUdYWXJ1L2wzTnhhN2k0NjNFKytyaHYzQlhyNFdpdHEzL0o4dDdR?=
 =?utf-8?B?MUUxaWZ2TmV6VmhwNDRMQ1IzMHRadmh1UWhhenRFc20vV1JtU2U1azA4aHRL?=
 =?utf-8?B?dHB4R2VrdXphb2lSUGVCU1hidGRlU2RvKzlVQm9RSlh3ZmI2MGpQM0l4WHFO?=
 =?utf-8?B?RTgwWllhelRGRWFTcjdrZWNTNnYvWkFEaVZvOEpRbEVPc2s3VFhwcFVWeWhH?=
 =?utf-8?B?clJUQjFFclZlUmJZYkJTUGoxMU4wVWt0a0J4a2w5N3ZsM3BXNE1PTW80RG5W?=
 =?utf-8?B?dzYvMGJuOXdxTm1kQkFKOFFIL3hrbjN5VFE3VVgzbEdjUm91QnNQOHNJelNo?=
 =?utf-8?B?SnB2dnlQZFlXMjFnV0ZsU1BlTHpXcmhnS0lmK3QwNzczSS80Ym4ranM2NlJU?=
 =?utf-8?B?eHRaT0tESmVRUlhjVTFneUU0YXMra2NRWHdPTzVSa0NySG54ek5OMDZEcHFt?=
 =?utf-8?B?Qmg2VXkxOXFNdXZ5RzNkeFpxWitTUWNOdDhNcS9VTmMzVFVZN0x3aVkzcitj?=
 =?utf-8?B?UlVIdjNjSEpuc0V3UWM0a2dBK2JKMU1tSUxiUGlJZXQ1QXA4RHpyL0E3MjFZ?=
 =?utf-8?B?d1hXYXUxTktmOXpGUzJQWm91bW1lUVJhRjlMdjE0V3g0ZFFHMUlzMXkvNHVP?=
 =?utf-8?B?b2xBYVNTYklLMDJHOHZVZzNaREVjdTc4Z3JaMVQvd2sySXdweURTamdtdUdr?=
 =?utf-8?B?RkFET2FlemYzWmp3RjBvU3YrZmV6ZWkvc2dvTEpvWWd3TXp1ZUhKTTRyemFs?=
 =?utf-8?Q?YhRjyUeG7K4aVvmcEGIVUhIFR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09efc007-6c93-44fe-8fff-08db3ff97b63
X-MS-Exchange-CrossTenant-AuthSource: DS7SPRMB0009.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 10:41:35.4243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U71Vnuh22xKWOPTIePmDEI/UrqZOEq1I2+WZ4dgdbd5kdtSeNvOmCNtpQGz3B6VtIFyZOE3fKj2x7AfwVsAmFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,


On 4/11/2023 3:52 AM, Jerry Snitselaar wrote:
> On Thu, Feb 16, 2023 at 03:11:48PM +0800, Peng Zhang wrote:
>> There is softlockup under fio pressure test with smmu enabled:
>> watchdog: BUG: soft lockup - CPU#81 stuck for 22s!  [swapper/81:0]
>> ...
>> Call trace:
>>  fq_flush_timeout+0xc0/0x110
>>  call_timer_fn+0x34/0x178
>>  expire_timers+0xec/0x158
>>  run_timer_softirq+0xc0/0x1f8
>>  __do_softirq+0x120/0x324
>>  irq_exit+0x11c/0x140
>>  __handle_domain_irq+0x6c/0xc0
>>  gic_handle_irq+0x6c/0x170
>>  el1_irq+0xb8/0x140
>>  arch_cpu_idle+0x38/0x1c0
>>  default_idle_call+0x24/0x44
>>  do_idle+0x1f4/0x2d8
>>  cpu_startup_entry+0x2c/0x30
>>  secondary_start_kernel+0x17c/0x1c8
>>
>> Rcu stall may also be triggered:
>>
>> rcu: INFO: rcu_sched self-detected stall on CPU
>> NMI backtrace for cpu 21
>> CPU: 21 PID: 118 Comm: ksoftirqd/21
>> ...
>> Call trace:
>>  fq_flush_timeout+0x6d/0x90
>>  ? fq_ring_free+0xc0/0xc0
>>  call_timer_fn+0x2b/0x120
>>  run_timer_softirq+0x1a6/0x420
>>  ? finish_task_switch+0x80/0x280
>>  __do_softirq+0xda/0x2da
>>  ? sort_range+0x20/0x20
>>  run_ksoftirqd+0x26/0x40
>>  smpboot_thread_fn+0xb8/0x150
>>  kthread+0x110/0x130
>>  ? __kthread_cancel_work+0x40/0x40
>>  ret_from_fork+0x1f/0x30
>>
>> This is because the timer callback fq_flush_timeout may run more than
>> 10ms, and timer may be processed continuously in the softirq so trigger
>> softlockup and rcu stall. We can use work to deal with fq_ring_free for
>> each cpu which may take long time, that to avoid triggering softlockup
>> and rcu stall.
>>
>> This patch is modified from the patch[1] of openEuler.
>>
> 
> Hi Robin,
> 
> I was looking at something similar to this recently were in this case
> they were beating the heck out the system with the hazard io stress
> test, and someone else with some medusa test tool. In one case they
> had them force a dump on the soft lockup. On the 384 core genoa, 90
> cores were spinning the iovad rb tree lock for one domain, 1 had it,
> and the poor flush queue timer handler was having to fight everyone
> for the lock. I'm not sure what would be considered a realistic workload
> compared to these stressors, but could this be an issue over time as
> systems continue to get more cores since the timer handler potentially
> grabs and releases the iova domain rb tree lock for each cpu? The only
> cases I know of are using io stressors, so I don't know how big a deal
> it is.
> 
> I think soft lockups could still be produced with this patch, since
> there would still be the lock contention.

Right. We hit this issue when running stress-ng on 384 CPU system having NVMe
disk. I have tried this patch. This improved the situation. But we still hit
soft lockup after an hour or so.

Backtrace with this patch:

 4551.470797] watchdog: BUG: soft lockup - CPU#328 stuck for 30s!
[kworker/328:1:2710]
[ 4551.479441] Modules linked in: nvme_fabrics(E) intel_rapl_msr(E)
intel_rapl_common(E) amd64_edac(E) edac_mce_amd(E) kvm_amd(E) kvm(E)
crct10dif_pclmul(E) ghash_clmulni_intel(E) sha512_ssse3(E) aesni_intel(E)
crypto_simd(E) cryptd(E) rapl(E) wmi_bmof(E) binfmt_misc(E) ipmi_ssif(E)
nls_iso8859_1(E) ast(E) drm_shmem_helper(E) drm_kms_helper(E) i2c_algo_bit(E)
syscopyarea(E) sysfillrect(E) sysimgblt(E) acpi_ipmi(E) ccp(E) k10temp(E)
ipmi_si(E) ipmi_devintf(E) ipmi_msghandler(E) mac_hid(E) sch_fq_codel(E) msr(E)
parport_pc(E) ppdev(E) lp(E) parport(E) ramoops(E) reed_solomon(E) pstore_blk(E)
pstore_zone(E) efi_pstore(E) drm(E) ip_tables(E) x_tables(E) autofs4(E)
crc32_pclmul(E) nvme(E) ahci(E) xhci_pci(E) tg3(E) nvme_core(E) libahci(E)
i2c_piix4(E) xhci_pci_renesas(E) wmi(E)
[ 4551.479475] CPU: 328 PID: 2710 Comm: kworker/328:1 Kdump: loaded Tainted: G
          E      6.2.9schd_work+ #1
[ 4551.479477] Hardware name: AMD Corporation Genoa, BIOS RTI 03/20/2023
[ 4551.479479] Workqueue: events free_iova_work_func
[ 4551.479484] RIP: 0010:_raw_spin_unlock_irqrestore+0x21/0x60
[ 4551.479488] Code: 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 49 89 f0 48 89
e5 c6 07 00 0f 1f 00 41 f7 c0 00 02 00 00 74 06 fb 0f 1f 44 00 00 <65> ff 0d 50
f8 fc 7d 74 13 5d 31 c0 89 c2 89 c1 89 c6 89 c7 41 89
[ 4551.479489] RSP: 0018:ffa0000092e07e30 EFLAGS: 00000206
[ 4551.479491] RAX: 0000000000000000 RBX: 00000000000000f2 RCX: 0000000000000000
[ 4551.479492] RDX: 0000000000000000 RSI: 0000000000000282 RDI: ffd1ff3cf82be060
[ 4551.479492] RBP: ffa0000092e07e30 R08: 0000000000000282 R09: 0000000000000000
[ 4551.479493] R10: 0000000000000000 R11: 0000000000000000 R12: ff1100010d2af6d0
[ 4551.479493] R13: ffd1ff3cf82be060 R14: ffd1ff3cf82bb858 R15: 0000000000000282
[ 4551.479494] FS:  0000000000000000(0000) GS:ff11018056200000(0000)
knlGS:0000000000000000
[ 4551.479495] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4551.479496] CR2: 00007ffd392f5f28 CR3: 0000000152f06004 CR4: 0000000000771ee0
[ 4551.479497] PKRU: 55555554
[ 4551.479497] Call Trace:
[ 4551.479498]  <TASK>
[ 4551.479502]  free_iova_work_func+0x6a/0xc0
[ 4551.479505]  process_one_work+0x21f/0x440
[ 4551.479507]  worker_thread+0x50/0x3f0
[ 4551.479509]  ? __pfx_worker_thread+0x10/0x10
[ 4551.479510]  kthread+0xee/0x120
[ 4551.479513]  ? __pfx_kthread+0x10/0x10
[ 4551.479514]  ret_from_fork+0x2c/0x50
[ 4551.479518]  </TASK>

I did slight modification on top of this patch (schedule work on each CPU) and
it worked for me.

@Robin, Joerg,
  Does something like below (schedule work on each CPU to free iova
 (fq_ring_free()) is acceptable?

-Vasant


------

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7aed15e53f10..eb52814e67e5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -157,10 +157,12 @@ static void fq_flush_iotlb(struct iommu_dma_cookie *cookie)
 static void fq_flush_timeout(struct timer_list *t)
 {
 	struct iommu_dma_cookie *cookie = from_timer(cookie, t, fq_timer);
+	int cpu;

 	atomic_set(&cookie->fq_timer_on, 0);
 	fq_flush_iotlb(cookie);
-	schedule_work(&cookie->free_iova_work);
+	for_each_possible_cpu(cpu)
+		schedule_work_on(cpu, &cookie->free_iova_work);
 }

 static void queue_iova(struct iommu_dma_cookie *cookie,
@@ -235,17 +237,15 @@ static void free_iova_work_func(struct work_struct *work)
 {
 	struct iommu_dma_cookie *cookie;
 	int cpu;
+	unsigned long flags;
+	struct iova_fq *fq;

 	cookie = container_of(work, struct iommu_dma_cookie, free_iova_work);
-	for_each_possible_cpu(cpu) {
-		unsigned long flags;
-		struct iova_fq *fq;
+	fq = this_cpu_ptr(cookie->fq);

-		fq = per_cpu_ptr(cookie->fq, cpu);
-		spin_lock_irqsave(&fq->lock, flags);
-		fq_ring_free(cookie, fq);
-		spin_unlock_irqrestore(&fq->lock, flags);
-	}
+	spin_lock_irqsave(&fq->lock, flags);
+	fq_ring_free(cookie, fq);
+	spin_unlock_irqrestore(&fq->lock, flags);
 }

 /* sysfs updates are serialised by the mutex of the group owning @domain */

---------





