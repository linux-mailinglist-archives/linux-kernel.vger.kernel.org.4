Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0439B67281D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjARTYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjARTYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:24:17 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D701153B13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:24:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdJG4QvRSFkGPgj7jaSYR0jv/TzQL+seGyAGX0ZmEs9SLhY7Wk6HoTZPVfqaL2L3+llFH0/vJG/mNk6VND47EauK/o0uVXfSP3/V4y9XysQnNOfZSRRCMF93pwt2Gr1cP2uakcZkc5gPdoxjyLNX1a9D4AcanZ3yZzN6Nr6o537R3gfLxDkuEaMdlFVelRRvwvOp7I8B4X7Z7dNngVxSgCAVNQlGUwieKInQoiY+aF0OzPTQ4rDnrIqoppsJckQujeVjOGBFqC5tmEDnD4PvH9r4lYTpV87MrB98LKhVTZqrDhQoe7LGI6XvMIHT6N0pmp1HQYJ+6vwKNTqc4CAnoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEf2IMtgtob93ItUgB/a4xiusnEShNUNrFWFBoklf0M=;
 b=lCBURulv0/peeON5m39SDu87SBaCT3cFEe831zfKeal7wo9BPqu7mEBDfj95iUPWT8qf2UH5BuPoGSD95QrxWI13e4vWM84kTu9QBELVLhkTdBzGIMPANh9OOKwz0q13wVZbAdJxLEWeQDExdxmAvigkHFRgAdNSbdFXl1VLGdrUfaPYRMzwfvxSJQhkM9psqhGBevYy9HfpXNl0OSC8YpqKMMO/K/wSYYm7HNWXo/AEZLtKkJMt7N1wN3BXlnhsBYMf/Nu3ykGYwH3lN1QV9ehdQYk3xib7n8axCewzVSqYmZzC2iWcH1VPCp1cRONmRGwDLkugpZoVdS0qmjwH1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEf2IMtgtob93ItUgB/a4xiusnEShNUNrFWFBoklf0M=;
 b=eU9KgEN/oqh76j9baNOtXV/jDLNkWtPDZd/iyFRc4ZAST21fs0TWzHsiHryBRj8qsiBD9sWvDvIqrBrlHkj0A6sX0KXVH1t4NHUm2qaR9XKLYlogpgkivMngSoazV8MZs4jTB3MRo65jRTyppESi92bdNHMzl+KVZ06QCfJhILOX0hLXVAW4cBTY4jOviFd3Ca1HKvQK1ic2hLTZQgEzcBQm7eS+TDUxyg7W01p/+hysklbnVg8aH9G/loO4pmSJlaYIwvtu0eHmQjf0+j/27dlwADW96w3he09nx2FeGrv+rAJTU8jCUDmCN1//GGqQaoGvwwB1kLDm8IcNERhkOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 19:24:13 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::a11:e220:e862:e216]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::a11:e220:e862:e216%9]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 19:24:13 +0000
Message-ID: <28061ceb-a7ce-0aca-a97d-8227dcfe6800@nvidia.com>
Date:   Wed, 18 Jan 2023 13:24:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] KVM: arm64: vgic: Fix soft lockup during VM teardown
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Vikram Sethi <vsethi@nvidia.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20230118022348.4137094-1-sdonthineni@nvidia.com>
 <863588njmt.wl-maz@kernel.org>
Content-Language: en-US
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <863588njmt.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:5:177::21) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|BL1PR12MB5378:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b16813-292b-42a6-54a7-08daf9899527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TPxY3Mg2hfNIF9UmRDyeIOpyx2izUVBx0KA4QZbGa+Qz0dd5kkzmemxT/lmaMm/1JgqazzAgjRKWFgdg4w+9FyRRS9CYXdJu0iQ0I/LYBrz1guFQbr4/1mVZRoTD7VNu8Ivwz9Rv4nG1CvoTi/OKwhupXsmtxMmLV/PhFrubn1+skfb14Z/gcg29yJZWtoCwoh28pOZhP+G9mupR+nWVHN7ouomP8kr6m22V53Mj7MuVbofeBuvpbxLXZdoEhaRhxa1FSO1Sju8/T/O7+daxNyKfPVEs8PTPhCZn56JsO2LLFE9L8pVAvQlRiS+JHuopEvQ+5gexanl6f7iB5AAaBOPOjgF1R27udcQtgAm7g4snU9W9D3lz5XFFnB9sBOY6xBqlaA6perxBu5GT9HTw6EyKuyphDZMkI5kvhOUDa4d/ook01z+R5omCeip6JHKLrXH3IVOq2ZL0QjlMh8VxfRWsr3anoOQMijS/b+19X6VJ3V5p2fVx8CbnYNrF6ku8dgJTPiUSR63JSEwYFhd2TS4s9DFakK4UE04TtaPvIyI9baNUdYNAOvvIeUwoskfdbVGUXadjPPoWJ1fbGTGnkAMbp5rbQZ+idEHAavmwZ548HX6I1Dt83inHrRXQFrdF7JVWxffFG/uYJGLODM28IaRn3YUky0OcD7sJ5Kq7//90Uyil9aHejB9qwk87HSOuexyDAZE2RD5YGdI/8mn8cL+yrEr2A/k4M0RY37TaenU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199015)(36756003)(478600001)(31696002)(54906003)(6512007)(6486002)(45080400002)(6506007)(6666004)(2906002)(26005)(66946007)(8936002)(30864003)(316002)(41300700001)(5660300002)(7416002)(66476007)(6916009)(53546011)(66556008)(8676002)(4326008)(2616005)(38100700002)(186003)(86362001)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amhjV21vb0VYVWpGZEZscCtWRWtxS3FDTTd6UjRxM0hDa1R5K2FiRFcrbG1C?=
 =?utf-8?B?UmRHbGN6Y0F4bTZRTUdTMjQzM3VtNU8rSm81d3pKOGZoM0YyRUVRQzdKZzZj?=
 =?utf-8?B?MFZFcE5wS0I1MU52RkQ2RElMR01CcTBQVVV3QklGYlhzZ0dyZCs1UlpmcXBy?=
 =?utf-8?B?aUJlRGRKZzJjTU01NWFTKzhFT2ZHRHZoQW16VHQyQ0hBODhncFNaODF5TzJU?=
 =?utf-8?B?cTlLdmUzYWhDR2NsZUcwbW8vWExPQlJMWm96QmVqWXFMeGhzU3lIR3U5MWlr?=
 =?utf-8?B?SWRiT1R6Tys1cG9NNENKaVpzelVOZm1aa0VlKzkwQng4dnJiQUpDL0ZyNllO?=
 =?utf-8?B?R054bDJmZjBhTllQVE8yV1plcjJmYlUxYXUzVS9yRCtjdy93RUVEaG5FTm9s?=
 =?utf-8?B?NzVwYllpNmhObklaL3U5am9jaHZSOXR3RGVySnRsVk4yWlpDNjQ1NC9IMk1k?=
 =?utf-8?B?R0RVYnVxK0JkVFVxOUxsbDZBbldTL1lXR0NjdnRUeTVGTWFIME1HNXA3Sko4?=
 =?utf-8?B?ZWNYQm1IaTE5eGNlb2ZtdE1VLzZxcTNOeHoweW16S0JoOUF4dkhDbktmVnNi?=
 =?utf-8?B?Z2hkWXllRmp0cmlVM1VXRFYwci9IbDFFY25mYitwRjcrckNOWUs5UDFHeGNx?=
 =?utf-8?B?a0pQajdhVEpCM0V1ellmWGpoTHNIUGhZankzeXZXTVd1bUlwV3ZYeGcva29a?=
 =?utf-8?B?MG1rRDhtUWZlZk9aVEN3Zjg5NlBtcFR1WWw0NjFmZkZmRDJwM295U0NacWw2?=
 =?utf-8?B?TWkrcUhWQktHeW11K0lFTmgreG1DUFlmSUhRdk1qZTNCVkRWaUZtM3AxZTZK?=
 =?utf-8?B?Y2ZRKzVMeHJFdUEwdmtGb0pxbFRaZGVIakZDbExSdXMyUkpKdjJ1TlJqMmZz?=
 =?utf-8?B?TlptbXN4NTdTaXp4MEplT0dFZFlMRVB5TDdPcFJKakJHeitORExjRWxobTB0?=
 =?utf-8?B?eHFkT0tsdGZZYjhJdkVMWVQ2eXh1eFBMZTFsK2ExNkNzNHErWnNTN2Y4dWQ0?=
 =?utf-8?B?cWFYMkk4VGM1aUtIc1UrYVZvN3MvemY0MEpBa0J2R0VaMGlsaUI2UWhrVHZi?=
 =?utf-8?B?aVJwWXplemYzL2h6NGl5cFQ4Y28zWTNOQUdwWlhrMm5jQWhYak0zZlcrWkg4?=
 =?utf-8?B?dW1iQ0IzZHBnWUNoa3I4SGtYQmdHMDhkSzFLRE5aY21kVmthb0h6U05JcUZt?=
 =?utf-8?B?K0ViTUJQc2wzMFZqQ1MxY01LTXE4K0U3dEFtWjZ6V1JPNGZpZE1EWTkyYzFp?=
 =?utf-8?B?MFNIMlBNaEtPblRlM1dEdUFJcURRTElHTDVCMzBkYzZmRlpsMGVMUHRKMG5u?=
 =?utf-8?B?dHY5L3FhYjVSOEdoTGlqUVU3bUZLcVNPbnc4TzV2ZVQ3eXAvSGEvS1JSVU5T?=
 =?utf-8?B?V1REMVVuWXdOR0JiZEh6YjVYS0t4VWlDZFMrdTRpRVhUdFVnejk5VEdlWTl5?=
 =?utf-8?B?eExRTlcrRUlOMHpDdEQ4Y2VtVExCTzJMd2tVR1lzaVVIVU1RTWo0VFIrODNy?=
 =?utf-8?B?MG00Yzl1Z2ROQUJONGVCTjZlZThnOVJQNUpMU3V6YW9NSlFKNTdXVjR3ck0v?=
 =?utf-8?B?eXcvUDZ3aVZvWWhLUEtISDk1R1lsaHFXdC9MZ2xFN1JzdzF5Tys2eFc0eFln?=
 =?utf-8?B?Sng4bFdzM2lwVHl1NkYybXFRb1lTOVlEVWNFNUpGYVo1dENMMkJ4V0NOUzlo?=
 =?utf-8?B?WllBcUhRSGJjVW55M2JQVmhBSy9VRXdWN3NweHVydnM4TnBXQ2d1MkZyOVlr?=
 =?utf-8?B?QkJlQ2lYeVo2U0lKSVh4d1U1YmhNdHMyd1F4NTFPU3VSSWJOR0hLMnJkOGxL?=
 =?utf-8?B?VjZxWXlNaVp5WEg1c3NDR2JwWWpEay9pZ3Ryd3VhRXVtekdZQkV2Ym9yVU5z?=
 =?utf-8?B?eDUrVGRGL1FiOVBHUlhFYldkTVlINjZGQWgrZVVWTC9FZXliZVZ0OEtJaVpk?=
 =?utf-8?B?L2RoVVh5ZWdiSk1CdnZWa1A4MXRCcTlZOER3b0tzbGluZ3pJOW5ldGs4dUR6?=
 =?utf-8?B?MWJ1OU5Fd1VzMEI0cDJ5K3VVSkpvajJvR2crWjJOaGNMazlzSTBQYnpid3lO?=
 =?utf-8?B?dTczVHcxbjJXTUFDWGJnOENKTG85cEREbTRGaVRncGU4cGRjbkhOUzFqY0Ew?=
 =?utf-8?Q?f953S+yLLCnSU9GQBgTYxqn4O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b16813-292b-42a6-54a7-08daf9899527
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 19:24:13.6283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JibDbssTEE30WBXdta9yhPIgNe9+3bbn80cd+bdLghnInsxpldg1oHVwcN1/us9ZeV8+kjthgFxtHeP/uPoEKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/23 05:54, Marc Zyngier wrote:
> External email: Use caution opening links or attachments
> 
> 
> Shanker,
> 
> Please Cc all the KVM/arm64 reviewers when sending KVM/arm64 patches.
> 
> On Wed, 18 Jan 2023 02:23:48 +0000,
> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>
>> Getting intermittent CPU soft lockups during the virtual machines
>> teardown on a system with GICv4 features enabled. The function
>> __synchronize_hardirq() has been waiting for IRQD_IRQ_INPROGRESS
>> to be cleared forever as per the current implementation.
>>
>> CPU stuck here for a long time leads to soft lockup:
>>    while (irqd_irq_inprogress(&desc->irq_data))
>>        cpu_relax();
> 
> Is it a soft-lockup from which the system recovers? or a livelock
> which leaves the system dead?
> 
The system is not recovering, did a power cycle to recover.

[  211.018214] watchdog: BUG: soft lockup - CPU#8 stuck for 45s! [qemu-system-aar:1261]
[  211.026164] Modules linked in:
[  211.029283] CPU: 8 PID: 1261 Comm: qemu-system-aar Kdump: loaded Not tainted 6.0.0 #7
[  211.037338] Hardware name:  /th500_silicon, BIOS v1.1.1-4638c6c9 01/17/2023
[  211.044453] pstate: 62400009 (nZCv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
[  211.051586] pc : __synchronize_hardirq+0x54/0x140
[  211.056421] lr : free_irq+0x138/0x424
[  211.060160] sp : ffff80001504f990
[  211.063551] x29: ffff80001504f990 x28: 0000000000000008 x27: ffff00036c880000
[  211.070850] x26: ffff00036f888c00 x25: 0000000000000000 x24: 0000000000000001
[  211.078219] x23: ffff0000835659d0 x22: 0000000000000001 x21: 0000000000000000
[  211.085513] x20: ffff00008356591c x19: ffff0000835658a0 x18: 000000000000003f
[  211.092807] x17: ffff001feafabf28 x16: ffffffc0012c3388 x15: ffff80001504fab0
[  211.100103] x14: 0000000000000008 x13: ffff800008b41718 x12: 00000000f5257d14
[  211.107489] x11: 0000000000000040 x10: ffff8000091f1680 x9 : ffff8000091f1678
[  211.114783] x8 : 0000000000000001 x7 : 0000000000000000 x6 : 0000000000000001
[  211.122115] x5 : ffff8000083524e4 x4 : ffffffc000db5e20 x3 : 0000000081550146
[  211.129409] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000010071200
[  211.136736] Call trace:
[  211.139232]  __synchronize_hardirq+0x54/0x140
[  211.143746]  free_irq+0x138/0x424
[  211.147139]  vgic_v4_teardown+0xa4/0xe0
[  211.151072]  __kvm_vgic_destroy+0x18c/0x194
[  211.155351]  kvm_vgic_destroy+0x28/0x3c
[  211.159310]  kvm_arch_destroy_vm+0x24/0x44
[  211.163579]  kvm_destroy_vm+0x158/0x2c4
[  211.167495]  kvm_vm_release+0x6c/0x98
[  211.171257]  __fput+0x70/0x220
[  211.174373]  ____fput+0x10/0x20
[  211.177588]  task_work_run+0xb4/0x23c
[  211.181327]  do_exit+0x2bc/0x8a4
[  211.184622]  do_group_exit+0x34/0xb0
[  211.188271]  get_signal+0x878/0x8a0
[  211.191856]  do_notify_resume+0x138/0x1530
[  211.196075]  el0_svc+0xdc/0xf0
[  211.199211]  el0t_64_sync_handler+0xf0/0x11c
[  211.203635]  el0t_64_sync+0x18c/0x190
[  211.207374] Kernel panic - not syncing: softlockup: hung tasks
[  211.213335] CPU: 8 PID: 1261 Comm: qemu-system-aar Kdump: loaded Tainted: G             L     6.0.0 #7
[  211.222851] Hardware name:  /th500_silicon, BIOS v1.1.1-4638c6c9 01/17/2023
[  211.229993] Call trace:
[  211.232498]  dump_backtrace.part.0+0xc8/0xe0
[  211.236890]  show_stack+0x18/0x54
[  211.240330]  dump_stack_lvl+0x64/0x7c
[  211.244097]  dump_stack+0x18/0x30
[  211.247479]  panic+0x160/0x328
[  211.250622]  watchdog_nmi_enable+0x0/0x14
[  211.254818]  __hrtimer_run_queues+0x118/0x244
[  211.259288]  hrtimer_interrupt+0x114/0x300
[  211.263471]  arch_timer_handler_phys+0x2c/0x40
[  211.268034]  handle_percpu_devid_irq+0x84/0x138
[  211.272671]  generic_handle_domain_irq+0x2c/0x40
[  211.277394]  gic_handle_irq+0x50/0x128
[  211.281221]  call_on_irq_stack+0x2c/0x38
[  211.285226]  do_interrupt_handler+0x7c/0x88
[  211.289552]  el1_interrupt+0x34/0x54
[  211.293239]  el1h_64_irq_handler+0x18/0x20
[  211.297433]  el1h_64_irq+0x64/0x68
[  211.300935]  __synchronize_hardirq+0x54/0x140
[  211.305385]  free_irq+0x138/0x424
[  211.308767]  vgic_v4_teardown+0xa4/0xe0
[  211.312709]  __kvm_vgic_destroy+0x18c/0x194
[  211.317007]  kvm_vgic_destroy+0x28/0x3c
[  211.320927]  kvm_arch_destroy_vm+0x24/0x44
[  211.325204]  kvm_destroy_vm+0x158/0x2c4
[  211.329125]  kvm_vm_release+0x6c/0x98
[  211.332872]  __fput+0x70/0x220
[  211.335988]  ____fput+0x10/0x20
[  211.339192]  task_work_run+0xb4/0x23c
[  211.342980]  do_exit+0x2bc/0x8a4
[  211.346310]  do_group_exit+0x34/0xb0
[  211.349960]  get_signal+0x878/0x8a0
[  211.353520]  do_notify_resume+0x138/0x1530
[  211.357703]  el0_svc+0xdc/0xf0
[  211.360818]  el0t_64_sync_handler+0xf0/0x11c
[  211.365197]  el0t_64_sync+0x18c/0x190
[  211.368947] SMP: stopping secondary CPUs


> What kernel version is that? Please provide all the relevant context
> that could help analysing the issue.
> 
Tested with v6.0+ and v6.2.rc4.

>>
>> Call trace from the lockup CPU:
>>   [   87.238866] watchdog: BUG: soft lockup - CPU#37 stuck for 23s!
>>   [   87.250025] CPU: 37 PID: 1031 Comm: qemu-system-aarch64
>>   [   87.358397] Call trace:
>>   [   87.360891]  __synchronize_hardirq+0x48/0x140
>>   [   87.365343]  free_irq+0x138/0x424
>>   [   87.368727]  vgic_v4_teardown+0xa4/0xe0
>>   [   87.372649]  __kvm_vgic_destroy+0x18c/0x194
>>   [   87.376922]  kvm_vgic_destroy+0x28/0x3c
>>   [   87.380839]  kvm_arch_destroy_vm+0x24/0x44
>>   [   87.385024]  kvm_destroy_vm+0x158/0x2c4
>>   [   87.388943]  kvm_vm_release+0x6c/0x98
>>   [   87.392681]  __fput+0x70/0x220
>>   [   87.395800]  ____fput+0x10/0x20
>>   [   87.399005]  task_work_run+0xb4/0x23c
>>   [   87.402746]  do_exit+0x2bc/0x8a4
>>   [   87.406042]  do_group_exit+0x34/0xb0
>>   [   87.409693]  get_signal+0x878/0x8a0
>>   [   87.413254]  do_notify_resume+0x138/0x1530
>>   [   87.417440]  el0_svc+0xdc/0xf0
>>   [   87.420559]  el0t_64_sync_handler+0xf0/0x11c
>>   [   87.424919]  el0t_64_sync+0x18c/0x190
>>
>> The state of the IRQD_IRQ_INPROGRESS information is lost inside
>> irq_domain_activate_irq() which happens before calling free_irq().
>> Instrumented the code and confirmed, the IRQD state is changed from
>> 0x10401400 to 0x10441600 instead of 0x10401600 causing problem.
>>
>> Call trace from irqd_set_activated():
>>   [   78.983544] irqd_set_activated: lost IRQD_IRQ_INPROGRESS
>>                  old=0x10401400, new=0x10441600
>>   [   78.992093] CPU: 19 PID: 1511 Comm: qemu-system-aarch64
>>   [   79.008461] Call trace:
>>   [   79.010956]  dump_backtrace.part.0+0xc8/0xe0
>>   [   79.015328]  show_stack+0x18/0x54
>>   [   79.018713]  dump_stack_lvl+0x64/0x7c
>>   [   79.022459]  dump_stack+0x18/0x30
>>   [   79.025842]  irq_domain_activate_irq+0x88/0x94
>>   [   79.030385]  vgic_v3_save_pending_tables+0x260/0x29c
>>   [   79.035463]  vgic_set_common_attr+0xac/0x23c
>>   [   79.039826]  vgic_v3_set_attr+0x48/0x60
>>   [   79.043742]  kvm_device_ioctl+0x120/0x19c
>>   [   79.047840]  __arm64_sys_ioctl+0x42c/0xe00
>>   [   79.052027]  invoke_syscall.constprop.0+0x50/0xe0
>>   [   79.056835]  do_el0_svc+0x58/0x180
>>   [   79.060308]  el0_svc+0x38/0xf0
>>   [   79.063425]  el0t_64_sync_handler+0xf0/0x11c
>>   [   79.067785]  el0t_64_sync+0x18c/0x190
> 
> Are these two traces an indication of concurrent events? Or are they
> far apart?
> 
Concurrent.

>>
>> irqreturn_t handle_irq_event(struct irq_desc *desc)
>> {
>>      irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
>>      raw_spin_unlock(&desc->lock);
>>
>>      ret = handle_irq_event_percpu(desc);
>>
>>      raw_spin_lock(&desc->lock);
>>      irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
>> }
> 
> How is that relevant to this trace? Do you see this function running
> concurrently with the teardown? If it matters here, it must be a VPE
> doorbell, right? But you claim that this is on a GICv4 platform, while
> this would only affect GICv4.1... Or are you using GICv4.1?
> 
handle_irq_event() is running concurrently with irq_domain_activate_irq()
which happens before free_irq() called. Corruption at [78.983544] and
teardown started at [87.360891].

[   78.983544] irqd_set_activated: lost IRQD_IRQ_INPROGRESS old=0x10401400, new=0x10441600

[   87.360891]  __synchronize_hardirq+0x48/0x140

Yes, I'm using GICv4.1, used these 2 functions to trace the issue.

static inline void irqd_set_activated(struct irq_data *d)
{
	atomic_t *state = (atomic_t *)(&__irqd_to_state(d));
	unsigned int new, old = __irqd_to_state(d);

	new = atomic_xchg(state, old | IRQD_ACTIVATED);	

	if ((old ^ new) & IRQD_IRQ_INPROGRESS) {
		pr_err("%s: lost IRQD_IRQ_INPROGRESS old=0x%x new=0x%x\n",
		       __func__, old, old | IRQD_ACTIVATED);
		dump_stack();
	}
}

static inline void irqd_clr_activated(struct irq_data *d)
{
	atomic_t *state = (atomic_t *)(&__irqd_to_state(d));
	unsigned int new, old = __irqd_to_state(d);

	new = atomic_xchg(state, old & ~IRQD_ACTIVATED);	

	if ((old ^ new) & IRQD_IRQ_INPROGRESS) {
		pr_err("%s: lost IRQD_IRQ_INPROGRESS old=0x%x new=0x%x\n",
		       __func__, old, old & ~IRQD_ACTIVATED);
		dump_stack();
	}
}

>>
>> In this particular failed case and based on traces, the two functions
>> irqd_set_activated() and handle_irq_event() are concurrently modifying
>> IRQD state without both holding desc->lock. The irqd_set_activated()
>> execution path is reading memory 'state_use_accessors' in between set
>> & clear of IRQD_IRQ_INPROGRESS state change and writing the modified
>> data after executing 'irqd_clear(desc->irq_data, IRQD_IRQ_INPROGRESS)'.
>>
>> To fix the lockup issue, hold desc->lock when calling functions
>> irq_domain_activate_irq() and irq_domain_deactivate_irq).
> 
> For that particular issue, the main problem is that we are abusing the
> interrupt startup/teardown code. The locking is only a consequence of
> this.
> 
>>
>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>> ---
>>   arch/arm64/kvm/vgic/vgic-v3.c | 6 ++++++
>>   arch/arm64/kvm/vgic/vgic-v4.c | 4 ++++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
>> index 2074521d4a8c..e6aa909fcbe2 100644
>> --- a/arch/arm64/kvm/vgic/vgic-v3.c
>> +++ b/arch/arm64/kvm/vgic/vgic-v3.c
>> @@ -353,22 +353,28 @@ int vgic_v3_lpi_sync_pending_status(struct kvm *kvm, struct vgic_irq *irq)
>>   static void unmap_all_vpes(struct vgic_dist *dist)
>>   {
>>        struct irq_desc *desc;
>> +     unsigned long flags;
>>        int i;
>>
>>        for (i = 0; i < dist->its_vm.nr_vpes; i++) {
>>                desc = irq_to_desc(dist->its_vm.vpes[i]->irq);
>> +             raw_spin_lock_irqsave(&desc->lock, flags);
>>                irq_domain_deactivate_irq(irq_desc_get_irq_data(desc));
>> +             raw_spin_unlock_irqrestore(&desc->lock, flags);
> 
> I guess this is the guilty one, based on your analysis, and assuming
> this is a v4.1 issue, not v4.
> 
>>        }
>>   }
>>
>>   static void map_all_vpes(struct vgic_dist *dist)
>>   {
>>        struct irq_desc *desc;
>> +     unsigned long flags;
>>        int i;
>>
>>        for (i = 0; i < dist->its_vm.nr_vpes; i++) {
>>                desc = irq_to_desc(dist->its_vm.vpes[i]->irq);
>> +             raw_spin_lock_irqsave(&desc->lock, flags);
>>                irq_domain_activate_irq(irq_desc_get_irq_data(desc), false);
>> +             raw_spin_unlock_irqrestore(&desc->lock, flags);
>>        }
>>   }
>>
>> diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
>> index ad06ba6c9b00..a01b8313e82c 100644
>> --- a/arch/arm64/kvm/vgic/vgic-v4.c
>> +++ b/arch/arm64/kvm/vgic/vgic-v4.c
>> @@ -139,8 +139,10 @@ static void vgic_v4_enable_vsgis(struct kvm_vcpu *vcpu)
>>                /* Transfer the full irq state to the vPE */
>>                vgic_v4_sync_sgi_config(vpe, irq);
>>                desc = irq_to_desc(irq->host_irq);
>> +             raw_spin_lock(&desc->lock);
>>                ret = irq_domain_activate_irq(irq_desc_get_irq_data(desc),
>>                                              false);
>> +             raw_spin_unlock(&desc->lock);
> 
> This one looks wrong. The interrupt never fires on the host (that's
> the whole point of this stuff). There isn't even a handler attached to
> it. How can that result in a problem?

Thanks for catching mistake.

> 
> My take on the whole thing is that we should stop playing games with
> the underlying interrupt infrastructure. How about the following hack,
> which is only compile-tested. Let me know if that helps.
> 
>          M.
> 
> diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
> index 2074521d4a8c..2624963cb95b 100644
> --- a/arch/arm64/kvm/vgic/vgic-v3.c
> +++ b/arch/arm64/kvm/vgic/vgic-v3.c
> @@ -350,26 +350,23 @@ int vgic_v3_lpi_sync_pending_status(struct kvm *kvm, struct vgic_irq *irq)
>    * The deactivation of the doorbell interrupt will trigger the
>    * unmapping of the associated vPE.
>    */
> -static void unmap_all_vpes(struct vgic_dist *dist)
> +static void unmap_all_vpes(struct kvm *kvm)
>   {
> -       struct irq_desc *desc;
> +       struct vgic_dist *dist = &kvm->arch.vgic;
>          int i;
> 
> -       for (i = 0; i < dist->its_vm.nr_vpes; i++) {
> -               desc = irq_to_desc(dist->its_vm.vpes[i]->irq);
> -               irq_domain_deactivate_irq(irq_desc_get_irq_data(desc));
> -       }
> +       for (i = 0; i < dist->its_vm.nr_vpes; i++)
> +               free_irq(dist->its_vm.vpes[i]->irq, kvm_get_vcpu(kvm, i));
>   }
> 
> -static void map_all_vpes(struct vgic_dist *dist)
> +static void map_all_vpes(struct kvm *kvm)
>   {
> -       struct irq_desc *desc;
> +       struct vgic_dist *dist = &kvm->arch.vgic;
>          int i;
> 
> -       for (i = 0; i < dist->its_vm.nr_vpes; i++) {
> -               desc = irq_to_desc(dist->its_vm.vpes[i]->irq);
> -               irq_domain_activate_irq(irq_desc_get_irq_data(desc), false);
> -       }
> +       for (i = 0; i < dist->its_vm.nr_vpes; i++)
> +               WARN_ON(vgic_v4_request_vpe_irq(kvm_get_vcpu(kvm, i),
> +                                               dist->its_vm.vpes[i]->irq));
>   }
> 
>   /**
> @@ -394,7 +391,7 @@ int vgic_v3_save_pending_tables(struct kvm *kvm)
>           * and enabling of the doorbells have already been done.
>           */
>          if (kvm_vgic_global_state.has_gicv4_1) {
> -               unmap_all_vpes(dist);
> +               unmap_all_vpes(kvm);
>                  vlpi_avail = true;
>          }
> 
> @@ -444,7 +441,7 @@ int vgic_v3_save_pending_tables(struct kvm *kvm)
> 
>   out:
>          if (vlpi_avail)
> -               map_all_vpes(dist);
> +               map_all_vpes(kvm);
> 
>          return ret;
>   }
> diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
> index ad06ba6c9b00..a413718be92b 100644
> --- a/arch/arm64/kvm/vgic/vgic-v4.c
> +++ b/arch/arm64/kvm/vgic/vgic-v4.c
> @@ -222,6 +222,11 @@ void vgic_v4_get_vlpi_state(struct vgic_irq *irq, bool *val)
>          *val = !!(*ptr & mask);
>   }
> 
> +int vgic_v4_request_vpe_irq(struct kvm_vcpu *vcpu, int irq)
> +{
> +       return request_irq(irq, vgic_v4_doorbell_handler, 0, "vcpu", vcpu);
> +}
> +
>   /**
>    * vgic_v4_init - Initialize the GICv4 data structures
>    * @kvm:       Pointer to the VM being initialized
> @@ -283,8 +288,7 @@ int vgic_v4_init(struct kvm *kvm)
>                          irq_flags &= ~IRQ_NOAUTOEN;
>                  irq_set_status_flags(irq, irq_flags);
> 
> -               ret = request_irq(irq, vgic_v4_doorbell_handler,
> -                                 0, "vcpu", vcpu);
> +               ret = vgic_v4_request_vpe_irq(vcpu, irq);
>                  if (ret) {
>                          kvm_err("failed to allocate vcpu IRQ%d\n", irq);
>                          /*
> diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
> index 0c8da72953f0..23e280fa0a16 100644
> --- a/arch/arm64/kvm/vgic/vgic.h
> +++ b/arch/arm64/kvm/vgic/vgic.h
> @@ -331,5 +331,6 @@ int vgic_v4_init(struct kvm *kvm);
>   void vgic_v4_teardown(struct kvm *kvm);
>   void vgic_v4_configure_vsgis(struct kvm *kvm);
>   void vgic_v4_get_vlpi_state(struct vgic_irq *irq, bool *val);
> +int vgic_v4_request_vpe_irq(struct kvm_vcpu *vcpu, int irq);
> 
>   #endif
> 

I ran stress test launch/teardown multiple VMs for 3hrs. The issue
is not reproducible. The same test fails in 10-30min without code
changes.

> --
> Without deviation from the norm, progress is not possible.
