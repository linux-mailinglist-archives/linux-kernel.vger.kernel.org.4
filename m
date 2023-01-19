Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5933673925
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjASNBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjASNBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:01:15 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC527929B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:00:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LT22r7Zj8vbCSVMsYtbGJPOCC8kscrSufvA9YCQpYvU0Zyf/Vf3cLgvcd3B0PDoGUPc1Lw3MmM1CYrEFH0UIHQrMA3VWeJLfgevT7XWTqJrPgHjBS0bEy4zMG0g/FQoTmclDOp1PPv/MVLaT6HTbaHfQkATOzWtPiHKSgpJ2ciWPfV+6BCUz7C4EAuYSCoTwRhWJLrgXWTxMTbn2ACwUj+ibMSTHcHapZ2Zmm/soSV9vmXl6l3Auj84/ivpWOLQLMkjkL2Dreh5kt8+BYoW4v9SGal4fOFjLg2VbBANVz4Qbb3iw0lw7WVMGfbJj1ioYWtZZmI7p1JYBRcKpWj6fsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7Tk15x3q9uatwapDmUmYQlCrLfG5zLzeHFOeezO9F8=;
 b=br3xIJJz+Vw4RsO+MebOd4WjTHc23S7ohC+KAA4FowWwt4Fr4dmL5m0tmdJowi+T+WqGYUsm2mPaXbpcoIqU2I2edlvc5u3e6f4/SdIrrQCuDmS2Oe1/EMqw1gWkovibd0hjht8/ekfPYnkpzHBxoXyiGMBr9RKWKOr/TQqNriVfJSnVSbxWn5Xs3cG+kU8K93Bl9DvMn3J7ShELPAAVOTuCRr1AHhWeu9NCGyVp9Q8DO/mDKkcDart4DOqNpzZMh4RnyQe9hKTmCOcFLq6rpBGqXbHY8XqSDTil9BIx3LSfWyOifrK+FDl4EXmVKAnNM8QIxeVxzbW/Lkp8x8LjVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7Tk15x3q9uatwapDmUmYQlCrLfG5zLzeHFOeezO9F8=;
 b=cnDc/DX9X3wr4f95v9qjhUTXXV4OaDRR5+X9soekY0VpOcKRuAF+s/TPqUZ3yONcLVC3IY86Bl5rw38vWtgwAZqnMB5kb3MIrdvxAhGtZL9VyTko+1Y9xRhuQkecY8eA0WkXt341IRVQsMx1aXMF42xxOhXckWncmeuVADF+2HcConPCnQl25QUlIMJ0WjZpmAK5yALAPJ6eVA4h908l/wk24+pgJFLirC5nArG32AAnpn9JWegmjWLyeu8Y1P2vcYdZhGsK+eFfiCMuu4um3wsaX5TqFpeKzHsMnkPk7eC6qd6m9lhuE3jG0YTEvnzA2Ixpc9rXOjEcuxwPLLCrpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by CH2PR12MB4953.namprd12.prod.outlook.com (2603:10b6:610:36::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 13:00:56 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::a11:e220:e862:e216]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::a11:e220:e862:e216%9]) with mapi id 15.20.6002.025; Thu, 19 Jan 2023
 13:00:55 +0000
Message-ID: <2e0c971a-0199-ff0d-c13c-d007d9f03122@nvidia.com>
Date:   Thu, 19 Jan 2023 07:00:49 -0600
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
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <87bkmvdmna.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::15) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|CH2PR12MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: 491e9129-6b7b-4ba2-26f5-08dafa1d33bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k2LJUHoyftvONlaeSrD1zAatPDTFUQ+v81N4eXkaIb2bdY/wswGlz+rrZvmIPdtajHvTcN84jl4AmZ/973H7eHA8ubGTzZDUDYOg6XJ1MnOY1lZvyKsKWYsmIPQ0eh9SE53FcgnC/+On8dXQ0Gqim+85EwAQL01szhSWhBj+984EUrgVol5n0/Qpv1owGCr26rrnvYWYGZ8IoDUZnrrs+t9PdpDHhjqhUDHPsWMEUx8K6Y3IdisMq4BbKYZipYN/vp3gtC4E1zsRjrsS3lII0ydviI2tWkJ3uuI2BUMzpdafb1kCv67k207qHPNniXn+KmePDfP1ZujWEHEbf5iV/KzP3NPkWp4J36dSSPt4B8A+hN7ud5F1/ZP/UeBpsQ8kKmgYy7RTgcbtv7njMWh1ZarXhRL2nhrJyj7tGPVgSq4oX01LHquZQZ5joqyDSRTlnCUw5FNIIJDI78VFhRo6skL1tLCZuICqDDIewIlbwka3HXgpj7bIdChRiEGqDxZspEjMGhjTB+96PeDo9eO5COVatphs+E+dkCuEumTW4+BGrolKqPX0DG5vjLQujuqO59ST/SJ+EtggNiL0fDB6dwteAv0aFgUEmEPdL/USLI6QkutHKL79ThfMDPQjeCkapOGZDTzPGz10YrAOhM8GaS5pAbQuVqUbru6BGzFrMZYDizc/tHF4tS0rZPwi2kJHS3F7HEs2myoP9fIIHpv9TQ3676xzl+j5GPnLZAfk7gY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199015)(83380400001)(4326008)(86362001)(38100700002)(6916009)(5660300002)(2906002)(8676002)(7416002)(8936002)(31696002)(66556008)(66476007)(66946007)(26005)(41300700001)(186003)(6512007)(53546011)(2616005)(6506007)(6666004)(54906003)(6486002)(316002)(478600001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T29xVHJTWWRpaXhlY0ZzQUM4V2szd2pQeldWYU5lS0N1TDJSbkoxdHZnWlhz?=
 =?utf-8?B?Y0NadG1oTDZsOHhsQ2l5WFpkODgzY0JGdy90N1lCVFlUK0VFb0RsMUI3TnlD?=
 =?utf-8?B?NXcxSVFKMERZUFdoU29WL2VlT0NlYzVzQ3gyVTlNVjgrYitxOVg0eXdVOWpJ?=
 =?utf-8?B?ZmlSWTBCaVd1OEhyTkEvTFhsS1VTV05zMEwyTVJzaWNQTzl6dldBVndhc0Vw?=
 =?utf-8?B?NCtrZHpNN3EyVWljZzR5TXhONWh0SVMzNk1FZnhiRnJZMUpUMm8wWVl1R3pM?=
 =?utf-8?B?dkJlcFdOZVBxS29DZkljbnVaWG1IUVBCUm5uVkNILzVGMG02MWttOHhFYTFi?=
 =?utf-8?B?cEc0dTkvRW5XR25waFY2MkVjZXRxbnRCVHNRRDVRZVg3emdJVGV3VnJZVkkz?=
 =?utf-8?B?eldjdXBlOTB2RHV2d2ZsT0NWMmJRZ2JERTBuYjlYY2k5ZFdBOTBJaEdoR3BP?=
 =?utf-8?B?UFJqeHBvTnF5UXcxRmJqSmVBSzZHM1NvTDhjaXhod3FHMWJvU2llTllZUGJq?=
 =?utf-8?B?YTRUYWtIYWRONnVRLys5MkF0WXFsdlhsWHZuelB2S0NoT0lNbXc0ZU5raFpW?=
 =?utf-8?B?Z2JKZkdWODljeXRMdlFncnBsOFdBRGg2ZUNyL2prdjR5NHMxbVlmTmZZWC9i?=
 =?utf-8?B?R2RwU3J5bm9SUGZ1T2dQRGxJR2gwdlFnVyt3QlBodmxjUjlNSUJCeDhOWHRY?=
 =?utf-8?B?a0NWZUV0OXRhYmZpdlgwTUFlb0lJVzFCSE9pbVhydEtEVzBkSUtvaEo0ZURo?=
 =?utf-8?B?emxQUCtUNnR0TXpKRzZ2TEdRbXZiaTFoRnpkdUlQaFRNVnVzVVN2SWYrRTJK?=
 =?utf-8?B?bDdCWFdKRTQyQXIyM2lsbGtrOVJGeStYV1N5enNuQkp3MXBDbmd3U3dkNGJw?=
 =?utf-8?B?Z1hRSnRtM0kvOHJWczNIamFIazkxRGp1Q1Z1ZHp0VnliTVBYZGFvVlJZNjBK?=
 =?utf-8?B?VlZ4ODNDQU1JaldreHo2TWNOVEU1UERxa3lHN2dlNnJVNzZVaUhsVnUvcU5X?=
 =?utf-8?B?TW1ZeXF4MUNmQXRNeWlZbVhTL2I3OWZzNXA4N0htUHNYN0hkODJMYXczb0Yw?=
 =?utf-8?B?Y1FydDMyb3dIQytPRTBua2xVVHRzYlhRWmVUSC9IT0pQVzNhYWU2dXNhS2Zu?=
 =?utf-8?B?OVVaK0I3eGxPSjNNYkM3YzhOdGhydnpLQ1pmWmVnMzhzSFdZSGtvcXhqTWVN?=
 =?utf-8?B?blorQXBPODdsT1JYdnFYaDFGWnF6Q0VtS3lSVzMrR3lyMitWcncycnp6dFdx?=
 =?utf-8?B?MG5ueUEvQ1VENkRYVE84R1JzaklvaVlkYnNiOVlJcEN5UzlCaUhyNGVvTnhq?=
 =?utf-8?B?SGI0QzRRSk16R3ZZR0d3eCt0YUY4RGJsMXVjejhqUzB0YzYyVUc1QVZzYTBx?=
 =?utf-8?B?TG95UDhkRDZQZ0toUG1kbm5TM0xLTWJmRTVmWEI4ZEtaQmVyYmFzNnNwSFpo?=
 =?utf-8?B?dmx4RC9aOU9kV3NOaXYwSXJ6NDFGVTZlLzVmU01jZ2U3N2REcmhtOUp2QnRo?=
 =?utf-8?B?NUF0bG9kbDhtbVVFWWh3bU9SazAxNWg2a1p5amcrRGR4TFprNkhCeTdKUk9W?=
 =?utf-8?B?b1QraDc0Mk5NUU5NK2lEbUtHWnY0YnVZKzl0Y1B3eWJvdmVpTjJOaW5yaXpn?=
 =?utf-8?B?Z295MnAvNVRpRVJYeGRYTkxMRVMrZUE2TFowSjdxRmIzT3RsU1U5eDVrTGl2?=
 =?utf-8?B?RU1rdG5RR3lRcE02NXdkVGY3dS92N1lJTk42ZEloZzlzdTlHQ1l5bU1oKzhO?=
 =?utf-8?B?Z1FsQU4zSDg1bWRzMmZhblUzdG11WkUyMXlFNExXU21xODZLV2ljZWhFbytW?=
 =?utf-8?B?QWYvbmhiUm1uYWxPREtIaC9rejh4TURSOXd0RHUyQ2FLck5ia0VRVjkxK2Jy?=
 =?utf-8?B?TldWVEVOemh5bk1rWU8zeUs4UXdXOTFvM0ltWVV5MDBLVWEwTlJFTmpib1Zw?=
 =?utf-8?B?VVE2T1Zpd3M4R2EvNDhoczdwQXRHQkd2RXNIa2xsNGx4MDVwVlVLaXc1SXN0?=
 =?utf-8?B?dDVOZGF3L0prTTgyaU84RXQ1Njl4Wkg3M2dTU1IzYm0xMkxzeTEyNXppMk5L?=
 =?utf-8?B?cy9seFhGMGtLMFZCRm9hcnBCbzczUWtrVlJpVUEvL1puODdIY3ZCeEczb0JK?=
 =?utf-8?Q?L8ktu1riVhLOEBDMR/MuPIfMS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491e9129-6b7b-4ba2-26f5-08dafa1d33bb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 13:00:55.8838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itP0KHWOJt4NsHu4piiuhqz5QXmiZz/5hPx9T11rXqtwUDIHeqYaGU1Vi/3nZ7VBbjQLWgeM2ID6rHUnv9jpug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4953
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/23 01:11, Marc Zyngier wrote:
> External email: Use caution opening links or attachments
> 
> 
> [dropping the now dead old kvmarm list]
> 
> On Wed, 18 Jan 2023 19:24:01 +0000,
> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>
>>
>>
>> On 1/18/23 05:54, Marc Zyngier wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Shanker,
>>>
>>> Please Cc all the KVM/arm64 reviewers when sending KVM/arm64 patches.
>>>
>>> On Wed, 18 Jan 2023 02:23:48 +0000,
>>> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>>>
>>>> Getting intermittent CPU soft lockups during the virtual machines
>>>> teardown on a system with GICv4 features enabled. The function
>>>> __synchronize_hardirq() has been waiting for IRQD_IRQ_INPROGRESS
>>>> to be cleared forever as per the current implementation.
>>>>
>>>> CPU stuck here for a long time leads to soft lockup:
>>>>     while (irqd_irq_inprogress(&desc->irq_data))
>>>>         cpu_relax();
>>>
>>> Is it a soft-lockup from which the system recovers? or a livelock
>>> which leaves the system dead?
>>>
>> The system is not recovering, did a power cycle to recover.
> 
> This isn't a soft-lockup then. This is at best a livelock.
> 
>>> Are these two traces an indication of concurrent events? Or are they
>>> far apart?
>>>
>> Concurrent.
> 
> So you can see the VM being torn down while the vgic save sequence is
> still in progress?
> 
> If you can actually see that, then this is a much bigger bug than the
> simple race you are describing, and we're missing a reference on the
> kvm structure. This would be a *MAJOR* bug.
> 
How do we know vGIC save sequence is in progress while VM is being teardown?
I'm launching/terminating ~32 VMs in a loop to reproduce the issue.
  
> Please post the full traces, not snippets. The absolutely full kernel
> log, the configuration, what you run, how you run it, *EVERYTHING*. I
> need to be able to reproduce this.
Sure, I'll share the complete boot log messages of host kernel next run.
  
> 
>>
>>>>
>>>> irqreturn_t handle_irq_event(struct irq_desc *desc)
>>>> {
>>>>       irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
>>>>       raw_spin_unlock(&desc->lock);
>>>>
>>>>       ret = handle_irq_event_percpu(desc);
>>>>
>>>>       raw_spin_lock(&desc->lock);
>>>>       irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
>>>> }
>>>
>>> How is that relevant to this trace? Do you see this function running
>>> concurrently with the teardown? If it matters here, it must be a VPE
>>> doorbell, right? But you claim that this is on a GICv4 platform, while
>>> this would only affect GICv4.1... Or are you using GICv4.1?
>>>
>> handle_irq_event() is running concurrently with irq_domain_activate_irq()
>> which happens before free_irq() called. Corruption at [78.983544] and
>> teardown started at [87.360891].
> 
> But that doesn't match the description you made of concurrent
> events. Does it take more than 9 seconds for the vgic state to be
> saved to memory?

Are there any other possibilities of corrupting IRQD_IRQ_INPROGRESS
state bit other than concurrent accesses?

I did another experiment, changed the bit manipulation of the IRQD
state to atomic operations, the issue is not reproducible.

struct irq_common_data {
-       unsigned  int		__private state_use_accessors;
+	atomic_t		__private state_use_accessors;

+#define __irqd_to_state(d)       ACCESS_PRIVATE((d)->common, state_use_accessors)
+#define __irqd_get_state(d)      atomic_read(&__irqd_to_state(d))
+#define __irqd_set_state(d, m)   atomic_or((m), &__irqd_to_state(d))
+#define __irqd_clear_state(d, m) atomic_andnot((m), &__irqd_to_state(d))
> 
>>
>> [   78.983544] irqd_set_activated: lost IRQD_IRQ_INPROGRESS old=0x10401400, new=0x10441600
>>
>> [   87.360891]  __synchronize_hardirq+0x48/0x140
>>
>> Yes, I'm using GICv4.1, used these 2 functions to trace the issue.
> 
> Then *please* be precise in your descriptions. You send people in the
> wrong direction.
> 
It was my mistake not to mention the exact GIC version.

> [...]
> 
>> I ran stress test launch/teardown multiple VMs for 3hrs. The issue
>> is not reproducible. The same test fails in 10-30min without code
>> changes.
> 
> That doesn't add up with the earlier description of concurrent events,
> with the VM teardown and the vgic saving running in parallel. My patch
> doesn't prevent this.
> 
> So either your testing is insufficient, or your description of
> concurrent events is inaccurate.
> 

I'm using the unmodified 6.2.rc3/v6.0 from kernel.org and QEMU to
reproduce the issue.

Using the below steps for launching/terminating 32 VMs in loop. The
failure is intermittent. The same issue is reproducible with KVMTOOL
also.

numvms=32
socketcnt=1
iterations=100
while [ ${iterations} -ne 0 ]; do
  iterations=$(( iterations - 1 ))
  for idx in `seq 1 ${numvms}`; do
    vmname=vm${idx}
    cpunode=$((idx % socketcnt))
    cpuset=`lscpu  | grep "NUMA node${cpunode} CPU(s)" | awk -F' ' '{ print $4 }'`
    qemu-img create -f qcow2 -F raw -b /var/lib/libvirt/images/cloudimg.raw /var/lib/libvirt/images/${vmname}.qcow2
    virt-sysprep -a /var/lib/libvirt/images/${vmname}.qcow2 --hostname ${vmname}
    virt-install \
      --name ${vmname} \
      --numatune ${cpunode},mode=preferred \
      --vcpus vcpus=16,maxvcpus=16,cpuset=${cpuset} \
      --memory 4096 \
      --import \
      --noautoconsole \
      --os-variant name=ubuntu22.04 \
      --disk path=/var/lib/libvirt/images/${vmname}.qcow2 \
      --boot loader=/usr/share/AAVMF/AAVMF_CODE.fd,loader_ro=yes,loader_type=pflash
    if [ $? -ne 0 ]; then
      echo "Failed to create vm${idx}"
      while true ; do  sleep 1; done
    fi
    sleep 5
  done

  for idx in `seq 1 ${numvms}`; do
    echo -n "Checking vm${idx} boot: "
    while true; do
      ghostname=`virsh guestinfo vm${idx} --hostname 2>/dev/null | awk '{ print $3 }'`
      [ "${ghostname}" == "vm${idx}" ] && echo "done" && break
      sleep 1
    done
  done

  for idx in `seq 1 ${numvms}`; do
   virsh domstate vm${idx} >/dev/null 2>&1 || continue
   echo "Started shutdown & undefine vm${idx}..."
   virsh shutdown "vm${idx}" --mode agent >/dev/null 2>&1
   while true; do
     virsh domstate vm${idx} 2>/dev/null 2>&1 | grep -w "^shut off" >/dev/null 2>&1
     [ $? -eq 0 ] && break
     sleep 1
     virsh shutdown "vm${idx}" --mode agent >/dev/null 2>&1
   done
   virsh undefine --nvram --remove-all-storage vm${idx} 2>/dev/null
  done
done


>          M.
> 
> --
> Without deviation from the norm, progress is not possible.
