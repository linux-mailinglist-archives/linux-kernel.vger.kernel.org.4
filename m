Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4355C68EE49
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjBHLvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBHLvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:51:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB4AC4671E;
        Wed,  8 Feb 2023 03:51:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 935EA1042;
        Wed,  8 Feb 2023 03:52:17 -0800 (PST)
Received: from [10.57.12.246] (unknown [10.57.12.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B1023F703;
        Wed,  8 Feb 2023 03:51:32 -0800 (PST)
Message-ID: <ce11001e-dbe5-8694-71a5-841f4d614456@arm.com>
Date:   Wed, 8 Feb 2023 11:51:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6/7] KVM: arm64: Change return type of
 kvm_vm_ioctl_mte_copy_tags() to "int"
To:     Cornelia Huck <cohuck@redhat.com>, Gavin Shan <gshan@redhat.com>,
        Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
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
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, Eric Auger <eric.auger@redhat.com>
References: <20230203094230.266952-1-thuth@redhat.com>
 <20230203094230.266952-7-thuth@redhat.com>
 <c6e605fe-f251-d8b6-64ed-bd1e17e79512@redhat.com>
 <7b32d58b-846f-b8d7-165b-9f505e5f00f0@redhat.com>
 <d0b3a1e7-0864-f169-cdea-60ad95951b3f@redhat.com> <87zg9oleyb.fsf@redhat.com>
Content-Language: en-GB
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <87zg9oleyb.fsf@redhat.com>
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

On 08/02/2023 08:49, Cornelia Huck wrote:
> On Wed, Feb 08 2023, Gavin Shan <gshan@redhat.com> wrote:
> 
>> On 2/7/23 9:09 PM, Thomas Huth wrote:
>>> Oh, drat, I thought I had checked all return statements ... this must have fallen through the cracks, sorry!
>>>
>>> Anyway, this is already a problem now: The function is called from kvm_arch_vm_ioctl() (which still returns a long), which in turn is called from kvm_vm_ioctl() in virt/kvm/kvm_main.c. And that functions stores the return value in an "int r" variable. So the upper bits are already lost there.

Sorry about that, I was caught out by kvm_arch_vm_ioctl() returning long...

>>> Also, how is this supposed to work from user space? The normal "ioctl()" libc function just returns an "int" ? Is this ioctl already used in a userspace application somewhere? ... at least in QEMU, I didn't spot it yet...
>>>
> 
> We will need it in QEMU to implement migration with MTE (the current
> proposal simply adds a migration blocker when MTE is enabled, as there
> are various other things that need to be figured out for this to work.)
> But maybe other VMMs already use it (and have been lucky because they
> always dealt with shorter lengths?)
> 
>>
>> The ioctl command KVM_ARM_MTE_COPY_TAGS was merged recently and not used
>> by QEMU yet. I think struct kvm_arm_copy_mte_tags::length needs to be
>> '__u32' instead of '__u64' in order to standardize the return value.
>> Something like below. Documentation/virt/kvm/api.rst::section-4.130
>> needs update accordingly.
>>
>>     struct kvm_arm_copy_mte_tags {
>>          __u64 guest_ipa;
>>          __u32 pad;
>>          __u32 length;
>>          void __user *addr;
>>          __u64 flags;
>>          __u64 reserved[2];
>>    };
> 
> Can we do this in a more compatible way, as we are dealing with an API?
> Like returning -EINVAL if length is too big?
> 

I agree the simplest fix for the problem is simply to reject any
lengths>INT_MAX:

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index cf4c495a4321..94aed7ce85c4 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -1032,6 +1032,13 @@ long kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
 	if (copy_tags->flags & ~KVM_ARM_TAGS_FROM_GUEST)
 		return -EINVAL;

+	/*
+	 * ioctl returns int, so lengths above INT_MAX cannot be
+	 * represented in the return value
+	 */
+	if (length > INT_MAX)
+		return -EINVAL;
+
 	if (length & ~PAGE_MASK || guest_ipa & ~PAGE_MASK)
 		return -EINVAL;

This could also be fixed in a useable way by including a new flag which
returns the length in an output field of the ioctl structure. I'm
guessing a 2GB limit would be annoying to work around.

Steve

