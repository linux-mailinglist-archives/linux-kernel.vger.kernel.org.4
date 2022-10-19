Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB35604D80
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiJSQev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiJSQer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:34:47 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CAF10048
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:34:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pq16so17395331pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B9J9vtnmQvMpOvT645bX1wE7KqlpPWsdQxGl2q0xez0=;
        b=fKZ/ZRkXYkNnOwqNhB2UpPcpuopFq13NTE03CIdD6pvvCh8p24d5Ur0OWXUk/RhkPa
         XcosiN2sfVYBXZm5nV+0/5rlu4fhwd2xZ+zCr6ayQBXkeS5KTAXCXRS/7q6V4zLyG8GG
         lZxTzk+920HRpWq4qmnCx3rCMSpgfmCzugCxTv6JnClhryF/vd2gGbwAA8+2B15yqcHw
         sLfbmugXVymgWdd/5zo+gzi5ksBrN9ZkWCQcdDRHPWgmU4jdGJhSQyXd0WHBjXLLlB7O
         QoTZ9xP8LPvnJPcMHF+HWGDiKimmFIH/jniD3Ia8rTEcEJngizGaCGlCWkUHbql4yPPM
         cUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9J9vtnmQvMpOvT645bX1wE7KqlpPWsdQxGl2q0xez0=;
        b=XQ/xVR0Ml4ACYIuAN/aAA9idyfIMwTEvv/htE41LIIHHLrduExr8VxYdOcqCYdmMiU
         mNZMNtvTW526zuwmnZjlFz6WpDvGDzpo/xyCnx+kaRswvbr0olXpkX3ZiVnPcQ48+DmY
         4EN3lvz22TRQETbXxOU6LFjO3N4kOz1dCdGJ0BzWZPmT8QVWHYgX0Zc97fNzJY584j2c
         VqLGdb/Pf7Ae/BuMgVI7nF6P4P9C9LiWEWtH9ZUFDKlxQ+RV2u7LnABHSBbmYd5IftoN
         oLeuEr+XetbTFONWMBIxlzGr3iFvoB8+pn1KlL/uu5kbPxqjXkamsrw5aLTByAtnFKLU
         uc6A==
X-Gm-Message-State: ACrzQf0qyffhvjYMvedrctQkeTp9Pq9Odl09s5F/ILyp5q9bPtzrqM1F
        ZzMyzixp1vR16giK4QGyE7K0wA==
X-Google-Smtp-Source: AMsMyM4Z1Eoj0j4wsBheXsn38zsGBY5Ci/WBHz6Q19ckdtTUSsqvOdiM+lBt65UbDxXkOjbBcFDFvw==
X-Received: by 2002:a17:90a:d397:b0:20c:7a28:8834 with SMTP id q23-20020a17090ad39700b0020c7a288834mr46357563pju.153.1666197284202;
        Wed, 19 Oct 2022 09:34:44 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902710f00b0017f8290fcc0sm10826695pll.252.2022.10.19.09.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 09:34:43 -0700 (PDT)
Date:   Wed, 19 Oct 2022 16:34:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Gonda <pgonda@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcorr@google.com, michael.roth@amd.com, thomas.lendacky@amd.com,
        joro@8bytes.org, mizhang@google.com, pbonzini@redhat.com,
        andrew.jones@linux.dev
Subject: Re: [V4 6/8] KVM: selftests: add library for creating/interacting
 with SEV guests
Message-ID: <Y1AnHwVtOFShRxQD@google.com>
References: <20220829171021.701198-1-pgonda@google.com>
 <20220829171021.701198-7-pgonda@google.com>
 <Yz8dpB5+RFjEhA3n@google.com>
 <CAMkAt6oZQc4jqF7FOXOKkpbP3c4NXxPumVVjX9gXwPCh-zbtYg@mail.gmail.com>
 <Y02ZLFcDQbX6lP9z@google.com>
 <CAMkAt6q0g5Ua=PwLXa2oA4zCQUaHuEQ3pTXycD61HU6-dtQ5Gg@mail.gmail.com>
 <Y028WrU3pmEQqWDq@google.com>
 <CAMkAt6pvT15teuYWjz7r1vmUP5McDp76qjxQ26_oeg5mTnv5NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMkAt6pvT15teuYWjz7r1vmUP5McDp76qjxQ26_oeg5mTnv5NA@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022, Peter Gonda wrote:
> On Mon, Oct 17, 2022 at 2:34 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Mon, Oct 17, 2022, Peter Gonda wrote:
> > > I think this means we don't need to add VM_MODE_PXXV48_4K_SEV since we
> > > can set up the c-bit from inside of vm_sev_create_*(), thoughts?
> >
> > Configuring the C-bit inside vm_sev_create_*() won't work (at least not well).
> > The C-bit needs to be known before kvm_vm_elf_load(), i.e. can't be handled after
> > __vm_create(), and needs to be tracked inside the VM, i.e. can't be handled before
> > __vm_create().
> >
> > The proposed kvm_init_vm_address_properties() seems like the best fit since the
> > C-bit (and TDX's S-bit) is stolen from GPA space, i.e. directly affects the other
> > values computed in that path.
> >
> > As for the kvm_vm_arch allocation ugliness, when we talked off-list I didn't
> > consider the need to allocate in kvm_init_vm_address_properties().  That's quite
> > gross, especially since the pointer will be larger than the thing being allocated.
> >
> > With that in mind, adding .../include/<arch>/kvm_util.h so that "struct kvm_vm_arch"
> > can be defined and referenced directly doesn't seem so bad.  Having to stub in the
> > struct for the other architectures is annoying, but not the end of the world.
> 
> I'll make "struct kvm_vm_arch" a non pointer member, so adding
> /include/<arch>/kvm_util.h files.
> 
> But I think we do not need VM_MODE_PXXV48_4K_SEV, see:

I really don't want to open code __vm_create() with a slight tweak.  E.g. the
below code will be broken by Ricardo's series to add memslot0 is moved out of
____vm_create()[1], and kinda sorta be broken again by Vishal's series to add an
arch hook to __vm_create()[2].

AFAICT, there is no requirement that KVM_SEV_INIT be called before computing the
C-Bit, the only requirement is that KVM_SEV_INIT is called before adding vCPUs.

[1] https://lore.kernel.org/all/20221017195834.2295901-8-ricarkol@google.com
[2] https://lore.kernel.org/all/YzsC4ibDqGh5qaP9@google.com

> struct kvm_vm *vm_sev_create_with_one_vcpu(uint32_t policy, void *guest_code,
>                                            struct kvm_vcpu **cpu)
> {
>         enum vm_guest_mode mode = VM_MODE_PXXV48_4K;
>         uint64_t nr_pages = vm_nr_pages_required(mode, 1, 0);
>         struct kvm_vm *vm;
>         uint8_t measurement[512];
>         int i;
> 
>         vm = ____vm_create(mode, nr_pages);
> 
>         kvm_sev_ioctl(vm, KVM_SEV_INIT, NULL);
> 
>         configure_sev_pte_masks(vm);
> 
>         *cpu = vm_vcpu_add(vm, 0, guest_code);
>         kvm_vm_elf_load(vm, program_invocation_name);
> 
>         sev_vm_launch(vm, policy);
> 
>         /* Dump the initial measurement. A test to actually verify it
> would be nice. */
>         sev_vm_launch_measure(vm, measurement);
>         pr_info("guest measurement: ");
>         for (i = 0; i < 32; ++i)
>                 pr_info("%02x", measurement[i]);
>         pr_info("\n");
> 
>         sev_vm_launch_finish(vm);
> 
>         return vm;
> }
