Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516046C1F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjCTSNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjCTSNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:13:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD3F3B3D3;
        Mon, 20 Mar 2023 11:07:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUkRU1Yw8c0WeoveNEnst9t3tli0OPmO0lZvn+9dUgfRpYm2hSHfVKDv/HzhaeHR1lGAtHp40GHIuqM3Raxz+QCZlfdmVvLeDMpfslxUVPCN7bD7Y3pYStS2tfpXOGbMxj66gdQSpEYn+nw5ztvaYgmwvBaX8636dXbehigeRqT71RjdktvHNgTs2rwwNDX91poRzRqAIAqLNEmXwRs/rvz3m7J9DY1oHiX2gqWabSXTOMzN8ZA/S7S4m5LjF2KxwHt3xCFnCdDPa2IgZYPSKc6kfLZoy8dnfpcIsWwumRSo/eoHCOw9XXZ8FGXnyOd1BklH52Iz5hCvQjweJ8ugkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrk3ssCips920tY9LASP2epxfx90yku75xzvIsz/mJI=;
 b=L79DD80bZr+7ucisWzelfN523c/Mm66BmWz7HjXYGT/mq2JatPQOoCcvcLYbyMbGhj9Gc7p4jrsRgm1EVRUnnlBNZZCN6rlVQPccij7bmxOzC8N5OgtSUi/8RhTyemk4fWeoFNGVw/YFuwFJDUNnM/4gvCfVGkVXIVgcuQrrFZN0qPIJvICgvlBPdAVOkfra5udDSl90a98V2jv1tsOWmmAyAkm4LLDcA9omEwR3rjOfQdXVPG5o9Z1yxBoh92sV2qoGmeVP/8y/benP1dh7R2j19lOkU4pAHrTiJHVcqO79GIcVlqq1lxnl9ph2inYGl0H5S9XsNmSra0WJ2g0ZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrk3ssCips920tY9LASP2epxfx90yku75xzvIsz/mJI=;
 b=DU0Lv3h1DN6XYB/HhYAIUxIwYdH/d61XJqRqlpCcsF9OBK+R5rcn/h431TRHzRbowuCjntYifTjxOjm2kVyAc1lkJIYVs0X9puMYdJXW0AdQo0bthvbW7ngnuTGgDUNkkDO5VhsPfuTthWfnuZYQUiFAdmO8NoLJ33kdZgRO7ZE=
Received: from BL0PR05CA0002.namprd05.prod.outlook.com (2603:10b6:208:91::12)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 18:05:56 +0000
Received: from BL02EPF0000EE3F.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::d2) by BL0PR05CA0002.outlook.office365.com
 (2603:10b6:208:91::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.15 via Frontend
 Transport; Mon, 20 Mar 2023 18:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3F.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 20 Mar 2023 18:05:56 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 13:05:56 -0500
Date:   Mon, 20 Mar 2023 13:05:43 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
CC:     <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
        <linux-mm@kvack.org>, <linux-crypto@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <jroedel@suse.de>,
        <thomas.lendacky@amd.com>, <hpa@zytor.com>, <ardb@kernel.org>,
        <pbonzini@redhat.com>, <seanjc@google.com>, <vkuznets@redhat.com>,
        <jmattson@google.com>, <luto@kernel.org>,
        <dave.hansen@linux.intel.com>, <slp@redhat.com>,
        <pgonda@google.com>, <peterz@infradead.org>,
        <srinivas.pandruvada@linux.intel.com>, <rientjes@google.com>,
        <dovmurik@linux.ibm.com>, <tobin@ibm.com>, <bp@alien8.de>,
        <vbabka@suse.cz>, <kirill@shutemov.name>, <ak@linux.intel.com>,
        <tony.luck@intel.com>, <marcorr@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <alpergun@google.com>, <dgilbert@redhat.com>, <jarkko@kernel.org>,
        <ashish.kalra@amd.com>, <nikunj.dadhania@amd.com>
Subject: Re: [PATCH RFC v8 02/56] KVM: x86: Add 'update_mem_attr' x86 op
Message-ID: <20230320180543.ly4jgu54hyamy2gl@amd.com>
References: <20230220183847.59159-1-michael.roth@amd.com>
 <20230220183847.59159-3-michael.roth@amd.com>
 <20230318045611.GE408922@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230318045611.GE408922@ls.amr.corp.intel.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3F:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 6033076e-667a-4212-bb3c-08db296dc0f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVyZQrhE/fEDvRvF/w3WQCQ73HXH8wjPvGIPSfRJnQZZsX2ks1ROGIULojNI7anbQ7720Koi4I2cqVIKZgbtJnbSf3xloTlTJdA6rk43mG/fqxQ3O2Mpxyjyh1ySSaME/IYOiJvdmRAf8BMJwp3rnmjNWWuLpdiQFEf5z2IxfBHrdWIEenGNcwOxb5fSfp7QktlK/YiJr28ZbwCswxokRG/RQyYoU4tE2BNUBk1ZTnc9DeVPYt1S+pN6YdRrauhRcVp7DpUWWcv/lvvxYo/VKEWJwE8R9MZVAriehStorEsTacvqw/2aEVXE6bXWvG+TRZuL65DRdNlX63VHngsl3BYhDl3Drcc+mvw4humRum1/vGpg6iNtHNTv8TTONNI6ZQfYOF8z7A3DjBwWQXx79wpMMr3szImxCJv3f5vacBiAuJrT2jfznTTMZ+ho0BXskpcVcI7KbLeO2MBWdTteru+YacEN7ERRLPIxOqVa1lZu3+ASqMgLEDZta7C3HkdfJUWNYfHkOhiPfIQGp/06mMpYV6OrI02EAu2T89mOmJlLIuCLfQUw2n+xDglryFw15zHpzP1S8M42RmGVtvJR+VZIeOn4SCuklVHHfDes5mF1ZlCY+eAEenTVI1ilvQj72JkuYRFbSYYI2BTNUa4wF2Aozx6UmRiY6qh8XpZdx0LIBPY8Mbhs5ibm+HC9a/9b6LuMnZoGK1HdfyA53AGKGXQDBi0jBl9a+o5aI92MXPE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(86362001)(82310400005)(40460700003)(40480700001)(36756003)(83380400001)(316002)(6916009)(4326008)(70206006)(478600001)(70586007)(8676002)(186003)(54906003)(1076003)(16526019)(26005)(53546011)(2616005)(336012)(966005)(47076005)(426003)(6666004)(356005)(5660300002)(8936002)(7416002)(44832011)(7406005)(36860700001)(41300700001)(82740400003)(81166007)(2906002)(15650500001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:05:56.7739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6033076e-667a-4212-bb3c-08db296dc0f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 09:56:11PM -0700, Isaku Yamahata wrote:
> On Mon, Feb 20, 2023 at 12:37:53PM -0600,
> Michael Roth <michael.roth@amd.com> wrote:
> 
> > This callback will do any platform-specific handling needed for
> > converting pages between shared/private.
> > 
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > ---
> >  arch/x86/include/asm/kvm-x86-ops.h |  1 +
> >  arch/x86/include/asm/kvm_host.h    |  2 ++
> >  arch/x86/kvm/mmu/mmu.c             | 13 +++++++++++++
> >  include/linux/kvm_host.h           |  4 ++++
> >  virt/kvm/kvm_main.c                | 29 +++++++++++++++++++++++++++++
> >  5 files changed, 49 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> > index 72183da010b8..a8aaf532c2ab 100644
> > --- a/arch/x86/include/asm/kvm-x86-ops.h
> > +++ b/arch/x86/include/asm/kvm-x86-ops.h
> > @@ -132,6 +132,7 @@ KVM_X86_OP(complete_emulated_msr)
> >  KVM_X86_OP(vcpu_deliver_sipi_vector)
> >  KVM_X86_OP_OPTIONAL_RET0(vcpu_get_apicv_inhibit_reasons);
> >  KVM_X86_OP_OPTIONAL_RET0(fault_is_private);
> > +KVM_X86_OP_OPTIONAL_RET0(update_mem_attr)
> >  
> >  #undef KVM_X86_OP
> >  #undef KVM_X86_OP_OPTIONAL
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index f856d689dda0..2da3fb2d5d1b 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1644,6 +1644,8 @@ struct kvm_x86_ops {
> >  	void (*load_mmu_pgd)(struct kvm_vcpu *vcpu, hpa_t root_hpa,
> >  			     int root_level);
> >  	bool (*fault_is_private)(struct kvm *kvm, gpa_t gpa, u64 error_code, bool *private_fault);
> > +	int (*update_mem_attr)(struct kvm_memory_slot *slot, unsigned int attr,
> > +			       gfn_t start, gfn_t end);
> >  
> >  	bool (*has_wbinvd_exit)(void);
> >  
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index fb3f34b7391c..053bd77bbf52 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -7251,4 +7251,17 @@ void kvm_arch_set_memory_attributes(struct kvm *kvm,
> >  		linfo_update_mixed(gfn, slot, level, mixed);
> >  	}
> >  }
> > +
> > +void kvm_arch_post_set_memory_attributes(struct kvm *kvm,
> > +					 struct kvm_memory_slot *slot,
> > +					 unsigned long attrs,
> > +					 gfn_t start, gfn_t end)
> > +{
> > +	int ret;
> > +
> > +	ret = static_call(kvm_x86_update_mem_attr)(slot, attrs, start, end);
> > +	if (ret)
> > +		pr_warn_ratelimited("Failed to update GFN range 0x%llx-0x%llx with attributes 0x%lx. Ret: %d\n",
> > +				    start, end, attrs, ret);
> > +}
> >  #endif
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index fdc59479b3e2..d200b8f45583 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -2330,6 +2330,10 @@ void kvm_arch_set_memory_attributes(struct kvm *kvm,
> >  				    struct kvm_memory_slot *slot,
> >  				    unsigned long attrs,
> >  				    gfn_t start, gfn_t end);
> > +void kvm_arch_post_set_memory_attributes(struct kvm *kvm,
> > +					 struct kvm_memory_slot *slot,
> > +					 unsigned long attrs,
> > +					 gfn_t start, gfn_t end);
> >  
> >  static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> >  {
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index b68574ff6c30..8ec985f1c57d 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -2561,6 +2561,32 @@ static void kvm_mem_attrs_changed(struct kvm *kvm, unsigned long attrs,
> >  		kvm_flush_remote_tlbs(kvm);
> >  }
> >  
> > +static void kvm_post_mem_attrs_changed(struct kvm *kvm, unsigned long attrs,
> > +				       gfn_t start_orig, gfn_t end_orig)
> > +{
> > +	struct kvm_memory_slot *slot;
> > +	struct kvm_memslots *slots;
> > +	struct kvm_memslot_iter iter;
> > +	int i;
> > +
> > +	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
> > +		slots = __kvm_memslots(kvm, i);
> > +
> > +		kvm_for_each_memslot_in_gfn_range(&iter, slots, start_orig, end_orig) {
> > +			gfn_t start, end;
> > +
> > +			slot = iter.slot;
> > +			start = max(start_orig, slot->base_gfn);
> > +			end = min(end_orig, slot->base_gfn + slot->npages);
> > +
> > +			if (start >= end)
> > +				continue;
> > +
> > +			kvm_arch_post_set_memory_attributes(kvm, slot, attrs, start, end);
> > +		}
> > +	}
> > +}
> > +
> >  static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
> >  					   struct kvm_memory_attributes *attrs)
> >  {
> > @@ -2602,6 +2628,9 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
> >  	kvm_mmu_invalidate_end(kvm);
> >  	KVM_MMU_UNLOCK(kvm);
> >  
> > +	if (i > start)
> > +		kvm_post_mem_attrs_changed(kvm, attrs->attributes, start, i);
> > +
> 
> Doesn't kvm_arch_set_memory_attributes() work for you? i.e the following patch.
> The error check and pr_warn_ratelimited() can be pushed down into the callback.

This is originally how I had but when CONFIG_PREEMPT_COUNT is set this
will generate warnings for this callback as well as the invalidation
callback as reported in v7 here:

  https://lore.kernel.org/lkml/Y80vhKwQyw8hS%2F22@notebook/

The main issue is that kvm_mem_attrs_changed() is called while holding
the KVM MMU lock, which disables preemption. But when updating
attributes for SNP, we also need to remove private pages from kernel
directmap, which involves acquiring a mutex which results in
"BUG: scheduling while atomic" warnings.

So that's why we ended up somewhat duplicating some of the logic and
using a separate callback chain that happens out of KVM MMU lock.

-Mike

> 
> From 7c618c1f3c236c382e64680efcbe7d8a672aa870 Mon Sep 17 00:00:00 2001
> Message-Id: <7c618c1f3c236c382e64680efcbe7d8a672aa870.1679114841.git.isaku.yamahata@intel.com>
> In-Reply-To: <428a676face7a06a90e59dca1c32941c9b6ee001.1679114841.git.isaku.yamahata@intel.com>
> References: <428a676face7a06a90e59dca1c32941c9b6ee001.1679114841.git.isaku.yamahata@intel.com>
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> Date: Fri, 17 Mar 2023 12:00:09 -0700
> Subject: [PATCH 4/4] KVM: x86: Add 'set_mem_attr' x86 op
> 
> This callback will do any platform-specific handling needed for
> converting pages between shared/private.
> 
> Originally-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>  arch/x86/include/asm/kvm-x86-ops.h | 1 +
>  arch/x86/include/asm/kvm_host.h    | 2 ++
>  arch/x86/kvm/mmu/mmu.c             | 1 +
>  3 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index dc5f18ac0bd5..956db2ee25a5 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -100,6 +100,7 @@ KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
>  KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
>  KVM_X86_OP(load_mmu_pgd)
>  KVM_X86_OP(fault_is_private)
> +KVM_X86_OP_OPTIONAL(set_mem_attr)
>  KVM_X86_OP_OPTIONAL(link_private_spt)
>  KVM_X86_OP_OPTIONAL(free_private_spt)
>  KVM_X86_OP_OPTIONAL(split_private_spt)
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 0382d236fbf4..88e11dd3afde 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1731,6 +1731,8 @@ struct kvm_x86_ops {
>  	void (*load_mmu_pgd)(struct kvm_vcpu *vcpu, hpa_t root_hpa,
>  			     int root_level);
>  	bool (*fault_is_private)(struct kvm *kvm, gpa_t gpa, u64 error_code);
> +	void (*set_mem_attr)(struct kvm *kvm, struct kvm_memory_slot *slot,
> +			     unsigned int attr, gfn_t start, gfn_t end);
>  
>  	int (*link_private_spt)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
>  				void *private_spt);
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 0ec94c72895c..329333486e64 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -7908,6 +7908,7 @@ void kvm_arch_set_memory_attributes(struct kvm *kvm,
>  				    gfn_t start, gfn_t end)
>  {
>  	kvm_update_lpage_mixed_flag(kvm, slot, true, attrs, start, end);
> +	static_call(kvm_x86_set_mem_attr)(kvm, slot, attrs, start, end);
>  }
>  
>  void kvm_memory_attributes_create_memslot(struct kvm *kvm,
> -- 
> 2.25.1
> 
> -- 
> Isaku Yamahata <isaku.yamahata@gmail.com>
