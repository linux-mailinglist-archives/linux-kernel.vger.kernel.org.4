Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B603B68F057
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjBHOF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBHOFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:05:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D9065FF7;
        Wed,  8 Feb 2023 06:05:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 820751042;
        Wed,  8 Feb 2023 06:06:32 -0800 (PST)
Received: from [10.57.12.246] (unknown [10.57.12.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE2293F8C6;
        Wed,  8 Feb 2023 06:05:47 -0800 (PST)
Message-ID: <0f6690ec-8b33-866f-536e-3d111523b203@arm.com>
Date:   Wed, 8 Feb 2023 14:05:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 4/6] KVM: arm64: Limit length in
 kvm_vm_ioctl_mte_copy_tags() to INT_MAX
Content-Language: en-GB
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Gavin Shan <gshan@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <20230208140105.655814-1-thuth@redhat.com>
 <20230208140105.655814-5-thuth@redhat.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20230208140105.655814-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2023 14:01, Thomas Huth wrote:
> In case of success, this function returns the amount of handled bytes.
> However, this does not work for large values: The function is called
> from kvm_arch_vm_ioctl() (which still returns a long), which in turn
> is called from kvm_vm_ioctl() in virt/kvm/kvm_main.c. And that function
> stores the return value in an "int r" variable. So the upper 32-bits
> of the "long" return value are lost there.
> 
> KVM ioctl functions should only return "int" values, so let's limit
> the amount of bytes that can be requested here to INT_MAX to avoid
> the problem with the truncated return value. We can then also change
> the return type of the function to "int" to make it clearer that it
> is not possible to return a "long" here.
> 
> Fixes: f0376edb1ddc ("KVM: arm64: Add ioctl to fetch/store tags in a guest")
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks for fixing this.

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  Documentation/virt/kvm/api.rst    | 3 ++-
>  arch/arm64/include/asm/kvm_host.h | 4 ++--
>  arch/arm64/kvm/guest.c            | 8 ++++++--
>  3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 0a67cb738013..f184427931fa 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5553,7 +5553,8 @@ with the KVM_XEN_VCPU_GET_ATTR ioctl.
>    };
>  
>  Copies Memory Tagging Extension (MTE) tags to/from guest tag memory. The
> -``guest_ipa`` and ``length`` fields must be ``PAGE_SIZE`` aligned. The ``addr``
> +``guest_ipa`` and ``length`` fields must be ``PAGE_SIZE`` aligned.
> +``length`` must not be bigger than 2^31 - PAGE_SIZE bytes. The ``addr``
>  field must point to a buffer which the tags will be copied to or from.
>  
>  ``flags`` specifies the direction of copy, either ``KVM_ARM_TAGS_TO_GUEST`` or
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 35a159d131b5..b1a16343767f 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -963,8 +963,8 @@ int kvm_arm_vcpu_arch_get_attr(struct kvm_vcpu *vcpu,
>  int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
>  			       struct kvm_device_attr *attr);
>  
> -long kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
> -				struct kvm_arm_copy_mte_tags *copy_tags);
> +int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
> +			       struct kvm_arm_copy_mte_tags *copy_tags);
>  
>  /* Guest/host FPSIMD coordination helpers */
>  int kvm_arch_vcpu_run_map_fp(struct kvm_vcpu *vcpu);
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index cf4c495a4321..cadef953046f 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -1013,8 +1013,8 @@ int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
>  	return ret;
>  }
>  
> -long kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
> -				struct kvm_arm_copy_mte_tags *copy_tags)
> +int kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
> +			       struct kvm_arm_copy_mte_tags *copy_tags)
>  {
>  	gpa_t guest_ipa = copy_tags->guest_ipa;
>  	size_t length = copy_tags->length;
> @@ -1035,6 +1035,10 @@ long kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
>  	if (length & ~PAGE_MASK || guest_ipa & ~PAGE_MASK)
>  		return -EINVAL;
>  
> +	/* Lengths above INT_MAX cannot be represented in the return value */
> +	if (length > INT_MAX)
> +		return -EINVAL;
> +
>  	gfn = gpa_to_gfn(guest_ipa);
>  
>  	mutex_lock(&kvm->slots_lock);

