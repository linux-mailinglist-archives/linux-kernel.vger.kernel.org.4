Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0D76987CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 23:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBOWYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 17:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBOWYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:24:37 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810323754A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:24:36 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z8-20020a170902834800b001990ad8de5bso66452pln.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s//5Uv6g/H1dLOt9CacaL5SpVK997g6euR8d9ZQ4syk=;
        b=YDSO0P0Qvyx3frZ2ts9vid4DFRViwUw2dtZ7jgOLfEYtsB/HX8o7eqx8rxU8BQljFp
         VTskW9VS3N9bHyDbtyOR8MvhuMld59b/GLWpbU955Jgbq3smz8Uh+yi4RcxErKAJd+rA
         18X9Ldrj6VtM/0z7a9ncEy+YEzJYeRRh28aZJgu8nPLjR0nwWK8E2bD4hGYXRgvaSIAj
         fewWJlf0y1SHH7HPPDq+873IUYG1aDT/VzyFQ87e9nCcBYi99TmSb4ThtwPTPl/BBA+K
         aqvSjEDutED/I3uJqCvSKPWEHnqsebcouvH8jnwBZFrVR+rKw6ON1PNOAFRPsfwN5OO8
         tgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s//5Uv6g/H1dLOt9CacaL5SpVK997g6euR8d9ZQ4syk=;
        b=mNaCOoC5mCumAnbDi7+2SjO6RHnX4IeX2RAwPUNbU86SEqiO/6t9Jr7wRXJt5RDwgy
         0H+ACPadW5JO86xaI0gExHIyDtOkrZo53Zo1GZSFFxJ38WE2IqeLWlF5KXArbVEIU9MM
         VVOy+WZuT7y4yI0W9rzaHfm2Hf/ZaQnU7Vbz9sm4JU7KvkpYueRF7HsBfsx+S9J6GFoN
         rhH66KWQZHAJLWq4JPJKgyjsr+nm6NYdG5PHtdMpsx+oON0RCyP7J7z81/9Nhw048/+Z
         xU4Zd5X3/WGQicYBkprTqh5MrOxtcqYd0b/TTc9mjue3LDiF7PK1mVI986QE8XzSdNip
         g7DQ==
X-Gm-Message-State: AO0yUKXr8EXiPK2EnjxZhrW8Aa3w0ckWsm3XSLbu0ZVVDeHSf6I6DA55
        5+F7GtKwed5TINPB4eYj/NX2aD++c8w=
X-Google-Smtp-Source: AK7set8+cJELyQfDuC8OsZoJxp2bYsU7jOHMj3zXQ7bW5gcnGsIBOSRWBr4NyZAD1Q1HwhutMmZ9nutd5e8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:9691:0:b0:5a8:ec16:85f3 with SMTP id
 f17-20020aa79691000000b005a8ec1685f3mr602638pfk.16.1676499875820; Wed, 15 Feb
 2023 14:24:35 -0800 (PST)
Date:   Wed, 15 Feb 2023 14:24:34 -0800
In-Reply-To: <diqzlekzkazq.fsf@ackerleytng-cloudtop.c.googlers.com>
Mime-Version: 1.0
References: <Y88ylDFfMQNcUEw7@google.com> <diqzlekzkazq.fsf@ackerleytng-cloudtop.c.googlers.com>
Message-ID: <Y+1bom6CMFeNGWmm@google.com>
Subject: Re: [RFC PATCH v3 08/31] KVM: selftests: Require GCC to realign
 stacks on function entry
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     erdemaktas@google.com, mail@maciej.szmigiero.name,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        isaku.yamahata@intel.com, sagis@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, like.xu@linux.intel.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023, Ackerley Tng wrote:
> I figured it out!
> 
> GCC assumes that the stack is 16-byte aligned **before** the call
> instruction. Since call pushes rip to the stack, GCC will compile code
> assuming that on entrance to the function, the stack is -8 from a
> 16-byte aligned address.
> 
> Since for TDs we do a ljmp to guest code, providing a function's
> address, the stack was not modified by a call instruction pushing rip to
> the stack, so the stack is 16-byte aligned when the guest code starts
> running, instead of 16-byte aligned -8 that GCC expects.
> 
> For VMs, we set rip to a function pointer, and the VM starts running
> with a 16-byte algined stack too.
> 
> To fix this, I propose that in vm_arch_vcpu_add(), we align the
> allocated stack address and then subtract 8 from that:
> 
> @@ -573,10 +573,13 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm,
> uint32_t vcpu_id,
>         vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
>         vcpu_setup(vm, vcpu);
> 
> +       stack_vaddr += (DEFAULT_STACK_PGS * getpagesize());
> +       stack_vaddr = ALIGN_DOWN(stack_vaddr, 16) - 8;

The ALIGN_DOWN should be unnecessary, we've got larger issues if getpagesize() isn't
16-byte aligned and/or if __vm_vaddr_alloc() returns anything but a page-aligned
address.  Maybe add a TEST_ASSERT() sanity check that stack_vaddr is page-aligned
at this point?

And in addition to the comment suggested by Maciej, can you also add a comment
explaining the -8 adjust?  Yeah, someone can go read the changelog, but I think
this is worth explicitly documenting in code.

Lastly, can you post it as a standalone patch?

Many thanks!
