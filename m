Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224B6673B86
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjASORS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjASORM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:17:12 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F30F10C3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:17:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCqNemsXdQ0rbfxv+to7dP9Wa/6yfwRqxiBEXl9j7MbKs7KQgLmQScxDsiAoTGEqMf8x/b+qsSHaXPmk1czXOPhAVmghe8CZVX35WjpGJJvxq1+h7FLkaxVcbGZ7IxUxEZY0n96rlQsPIoFN1HuaX1sbHYG7WjZSjNRoHq1mJZFGOuraxoKVgG2cI83ODubkP4G7QokD8DHwtqkMbcR6TxC/gIc0tvzt+Jdzbue6MQhnWZZX4oPAi8KNyturOzEDVJoKJQud4Z6K81uR6X0D03gmtc/LiT9OtaoLUgTcafo3WmB14jBO1Vmhyhy1XwdpjUpGc1/kUNp6vHKEaya4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZtxsajtYweiKmpvnVsrCMBNBit/35Ukmvh0L/qsVO4=;
 b=R6fBfO095fOhGsr41zAh3cDr6qOnBXJ6EtiAjFLMMfYSJkx5bdURAfkKQMbtQeixEJahggh3/wBo3zsGykE+ZgpVM5sPnnBFDcsW0YntmZe+sEbLnncEsl2x7+riBflCqI+t+uG/Yw1gZmlePwSsWc/XR/kNy7GyMj1G5IwN6RRxO2XfH8QWy4h5v+VTeE+9pSBt6CXY9ofcRyuBLDahvNuW41bgkfms+bCuS+au/bhiRxbXxXT48Aa09pWgYbWoeoNk6RwABLaX/KLKIpk8Ps4q1/e4itd7U2jA9yW/KW2qDgs5XC0wB/FLQLADBJKFN4PW8jY18smrt+rXYUGr9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZtxsajtYweiKmpvnVsrCMBNBit/35Ukmvh0L/qsVO4=;
 b=hZ7dJeGninatUd2NZ/Smu6qy01RIMCBMdQuWsgcJVs/PNmjVgon4KYgYdkfKGUn3VWMwlruxVOgjXNSXQ2V9VPNgBLvdv50OR0kPejCe4vrIw3W2hssfVr6P66GITNDTKlaixzOlrMn4RVfKlFL+SUSSEORuk79lL624F4W/tuQ1Zp2H4XJxuYW/GkxPsEAkGWkgF6kPdHX9dX4S9Vp5tCUEnpx5zMl5ypafSJFqO703V29DMhnBFygqt0e0hsnhbTPiBnNmPq71pUdpgwfl4sZG/X81HOhJJNTFFfwQBKk09ELlJBc9ja5dEWQPRAxRrs/x9JA3NkSS7cLDBaP7dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26; Thu, 19 Jan
 2023 14:17:07 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::a11:e220:e862:e216]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::a11:e220:e862:e216%9]) with mapi id 15.20.6002.025; Thu, 19 Jan 2023
 14:17:07 +0000
Message-ID: <5e70b4e9-94e4-e673-db37-03dcb5551a62@nvidia.com>
Date:   Thu, 19 Jan 2023 08:16:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] KVM: arm64: vgic: Fix soft lockup during VM teardown
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20230118022348.4137094-1-sdonthineni@nvidia.com>
 <863588njmt.wl-maz@kernel.org>
 <28061ceb-a7ce-0aca-a97d-8227dcfe6800@nvidia.com>
 <87bkmvdmna.wl-maz@kernel.org>
 <2e0c971a-0199-ff0d-c13c-d007d9f03122@nvidia.com>
 <86wn5imxm9.wl-maz@kernel.org>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <86wn5imxm9.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0048.namprd05.prod.outlook.com
 (2603:10b6:803:41::25) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 361320c8-070f-48ef-40a2-08dafa27d892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wr2Dx5eJmFRYqkCoKYmp0ICEUeHzZ9Qj2ToKqCzflO1ZNrJcLW03i5+Dv3L0rW3cFDUxlvwQ9f0kcBfswiceRMjRTR4/ZU1rCOIbxQtk54tEBNSTlMLENY2OigJQAr4O094A2SQ4jGDeA75hwWMJdTkvgS9WNgKE4iv6ijwnBTP+g4dT+bfg33YXbPzBlVyTMvJeZ303uisyRGnEQfdkjYc1B47KCBpIQ+DDzmpkNgUu4txlkwuUIrRnk9odZ3s66GDfHwgfEBABPp+8g4JymTKZ8phFqNRMQKP6jJ5YloUXcH07xR0GcuPu00N3kaGJr5WjOHbaR0ITWn4kAZGAlK1jx57POztdQGHqocz7atCkViLSWIEUrYcb6wyK9v/KxPssHhdKdUc5pNLPbvGgPWfUoLOBzu/1EcYPPMoVKJauDB6dSJ7EyMQDKWq5guNemhjZSPmgbGWio7GMcYI64iB0vbiu5pgCRAigyjxYnLFlGXtJ/VwrZelzX7jGkb1b/KJk3f4jaR6lp41gmgJ3RZa9vRwjeOSOXL4ECmkwi4qVX5PEW2nt1eZvu3J3iIqQi9IgCwnHTmYHRn3nsbB4lXpqmH8s20/cnaulGcybfgR2I8xI/fYc14fhWigx0J6qAnvXdsirnqnPoMJDnh7JCeRhKaltGinmmWNoi3Tzi1KbvWk7qY0fWinmtiCR5bXrhIKpP7syrO0vnW90+NScNzq7uBLpG0QrTTSaNXjQf/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199015)(31696002)(31686004)(6666004)(6486002)(6506007)(53546011)(478600001)(86362001)(2906002)(54906003)(316002)(4326008)(7416002)(5660300002)(2616005)(66556008)(66476007)(66946007)(83380400001)(6916009)(41300700001)(8936002)(38100700002)(186003)(6512007)(26005)(8676002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU5OSm5IdDQza3dNTVlqSi91cjJUSThhR0RLVXcwTmEvU3JDZ2hKaWxpODQv?=
 =?utf-8?B?YTFYUVBqK1ZrRUdMQXd0YzQ3V2s1N1FwK2ZaTVRZVnBtS1FFVmwyYWdRcjVZ?=
 =?utf-8?B?d25vY0dhMHJENlNkRGN2a1lxaVM4T3ZVOEdoRE9xdVFhNGdjKzhuc3E2YnN1?=
 =?utf-8?B?TkprbE5UOTZ4Mk41Wk9kVkQvNjRXRHYyekRVa0IvS0xpT0NueUFSTlV0S1lv?=
 =?utf-8?B?M2Q4WXFsbUZWVGlraXpicS8yUUhYYk45UTNlYmJnK3haTkZVY0FpNlNhZHUw?=
 =?utf-8?B?c0xXMXZ5UGRLL1RlSmNVNlh4RWlod2NSZk1nc2hycnltb2txeHV3RHpxMktJ?=
 =?utf-8?B?RXVTWkFTdGlyN2JRNEJzS09pb0ZWd1J0ck1HUm5TV1AzbG5aWFBaTkN0M0g4?=
 =?utf-8?B?SFBMK3hUSWlGWXdzV00wT3RaQzA3YlQ1N3hrT0g5bDNwcGZVTjIwQnFhV3lD?=
 =?utf-8?B?ZW1odGpkSE85Zjc1SlNteU0wWStucUNyL25Bam9tcWkrV3MvQVpEamI1WDE2?=
 =?utf-8?B?SWxzR0pmU21ETitHRFEwUDIvaWhHTWVkTW9kYUgzYWZ5amRRRW5LcGFzeGJM?=
 =?utf-8?B?ZGM3R3F4Q0thSnd4T0hIcFM5eGlpL0hSekozdENGUi9MSC9MWHRSM21VRnNH?=
 =?utf-8?B?VmtHWTZsWVFMc0I3L0hqN3gzSWxzTXlOYTlWQjZWcXhBQlFJRiszNXBnd1My?=
 =?utf-8?B?TmY1a1dQWkN0SGRrbm5QZ2JMT2tlODltZTFWRjB6STRlTXZWU1dvUVhXZTRN?=
 =?utf-8?B?RkhXRXZSMTdndkswL3Bab2p3UTdlMTAxZGVxOVdlUW9oeTNmNFprUmVMc25E?=
 =?utf-8?B?TmJiNk81ZVk4RlMxZ1VXc2dvblRHRE5qeE90SUNLTjNDTExleStUTU5MVXNG?=
 =?utf-8?B?TWpSZU5DNkJlbnJGbm1zMVF2WkpHdWFOUW1NdE5Ob3dWbmFvdDg5alBDYzJ1?=
 =?utf-8?B?aDlpb3lmV1ExaTVZVGFuelVwTWpTNjVGWUJzMXZwTjVYZGx1UUNCNHZtQU9L?=
 =?utf-8?B?MHU1SWtaS2JPU041TFJ0UzlDMTI0aHVoTzVJSTA2Z00wVTRWSmQvaGFtZlJW?=
 =?utf-8?B?VXorNi9XWVJZQ3BiREdLZmhOWWtiNXpPMmpZWXJBdVNuQ2w2VE1tRlFZVHMv?=
 =?utf-8?B?UnpPNnhHUlE5b1M1TzlBdWJNZ3lEQVZOVmhqd2k2NXJIdVZIQlZRbnFjeTIz?=
 =?utf-8?B?b0dla20wM0dONE4wM2JTNkFPblpQdGI3UXlJZDdUMGt1Y0FYT1N5Wk5VeVJi?=
 =?utf-8?B?Wmh1TWpaaSsyZFZrclNxRi9QYUpTRklNaS9CYXhnV003YWpkdTZGT3Rhc0Zn?=
 =?utf-8?B?Y09WdlVGeE13TkN2YVRhUjkvbFpWc0JPM2I1Sk1aYnVhMWpnYTF1cE5IZFIv?=
 =?utf-8?B?YWJHeDZraUJwbTB0NmZyeU5LUUIzU0JOS2t3VmpxRnB1cjVleFJSUkZLMkJM?=
 =?utf-8?B?RnZUUUNrbDJhSHJqMU15U3V1TXhlaDdQc0tvZHB4QUUxM215dE9QRld1MkFk?=
 =?utf-8?B?Rm85dlMvZjdWeElwcjhrNEFSc0N2dEMxbEZoc25uTDJ4Qm1WL0paTXBpeThG?=
 =?utf-8?B?cEM3OWhQVHZKT0hGWTFpU0VMaTUrdFpnckdYeTBGNDJEMEJVT2hoYzduZWVq?=
 =?utf-8?B?cHNuWURBV1dRM3N5U3FRbm14VkZMQWFNcmdHNG55OERycDVZM3Erai9aWGZm?=
 =?utf-8?B?SldXd1AzL0Y1VDd5VVM3Mm54U2NjVW8wUU9QaDFkWjZ4bEIvbTVmdHBzVUNw?=
 =?utf-8?B?SzdJWkcyS3ZmU2hiYUxTZXVqdHU1RkRCS3JCREk1RmZseml3TGkxL1A5d1ZC?=
 =?utf-8?B?MHhnNDY3TlpXTEJLUTFKdkR0STVyajdCcmIzcU9OSjljTk1kRGdNb29pSnZP?=
 =?utf-8?B?NGN3cm1oSFZCSlFDRjZ0ZDJOb0dhSmIwa3VseWdBY3RLaU85aTgxRnRGaUJq?=
 =?utf-8?B?eDN6bEV1alVQYzZZNXM1dlBPSGQ5WndxUGtWYnE3NXBOb05lcEpWRGVlOXJY?=
 =?utf-8?B?dmNjSUMvcmhxVDBDWHprZzdrdjBjY29UdkNCTEpUOGp6WnpSVkZXbkFmS0sx?=
 =?utf-8?B?UEdzOFFiU3p5c29OV1paT0lnMGo5OE83YWxnN2l3VTQ2RUhOUk1CN1ZuUWpJ?=
 =?utf-8?B?V09SRHNCaDFlblRaTnVGZmRRZmxRdXI1aEh2UGxrUnZ4RXNkOUh6eHhtd0Q4?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361320c8-070f-48ef-40a2-08dafa27d892
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 14:17:07.2353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUSXGLnq+sLXFJWs9apba/MuRaQ1lS8Fjy4qigqCr4kOQj12kawMzeOKoyZlM+hEAhzN3T4dLd7PuaKL1Kw58g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 1/19/23 08:01, Marc Zyngier wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, 19 Jan 2023 13:00:49 +0000,
> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>
>>
>>
>> On 1/19/23 01:11, Marc Zyngier wrote:
>>> So you can see the VM being torn down while the vgic save sequence is
>>> still in progress?
>>>
>>> If you can actually see that, then this is a much bigger bug than the
>>> simple race you are describing, and we're missing a reference on the
>>> kvm structure. This would be a *MAJOR* bug.
>>>
>> How do we know vGIC save sequence is in progress while VM is being
>> teardown?  I'm launching/terminating ~32 VMs in a loop to reproduce
>> the issue.
> 
> Errr... *you* know when you are issuing the save ioctl, right? You
> also know when you are terminating the VM (closing its fd or killing
> the VMM).
> 
>>
>>> Please post the full traces, not snippets. The absolutely full kernel
>>> log, the configuration, what you run, how you run it, *EVERYTHING*. I
>>> need to be able to reproduce this.
>> Sure, I'll share the complete boot log messages of host kernel next run.
>>
>>>
>>>>
>>>>>>
>>>>>> irqreturn_t handle_irq_event(struct irq_desc *desc)
>>>>>> {
>>>>>>        irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
>>>>>>        raw_spin_unlock(&desc->lock);
>>>>>>
>>>>>>        ret = handle_irq_event_percpu(desc);
>>>>>>
>>>>>>        raw_spin_lock(&desc->lock);
>>>>>>        irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
>>>>>> }
>>>>>
>>>>> How is that relevant to this trace? Do you see this function running
>>>>> concurrently with the teardown? If it matters here, it must be a VPE
>>>>> doorbell, right? But you claim that this is on a GICv4 platform, while
>>>>> this would only affect GICv4.1... Or are you using GICv4.1?
>>>>>
>>>> handle_irq_event() is running concurrently with irq_domain_activate_irq()
>>>> which happens before free_irq() called. Corruption at [78.983544] and
>>>> teardown started at [87.360891].
>>>
>>> But that doesn't match the description you made of concurrent
>>> events. Does it take more than 9 seconds for the vgic state to be
>>> saved to memory?
>>
>> Are there any other possibilities of corrupting IRQD_IRQ_INPROGRESS
>> state bit other than concurrent accesses?
> 
> Forget about this bit. You said that we could see the VM teardown
> happening *at the same time* as the vgic state saving, despite the
> vgic device holding a reference on the kvm structure. If that's the
> case, this bit is the least of our worries. Think of the consequences
> for a second...
> 
> [...]
> 
>> Using the below steps for launching/terminating 32 VMs in loop. The
>> failure is intermittent. The same issue is reproducible with KVMTOOL
>> also.
> 
> kvmtool never issue a KVM_DEV_ARM_VGIC_GRP_CTRL with the
> KVM_DEV_ARM_ITS_SAVE_TABLES argument, so the code path we discussed is
> never used. What is the exact problem you're observing with kvmtool
> as the VMM?
> 
Unfortunately I didn't capture the log messages of kvmtool based VM boot.
Saw once kernel crash. Now I'm trying to reproduce the issue with QEMU tool
and share complete log messages.

>          M.
> 
> --
> Without deviation from the norm, progress is not possible.
