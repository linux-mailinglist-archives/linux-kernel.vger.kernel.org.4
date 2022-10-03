Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639B15F32CB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJCPmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJCPmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:42:32 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C0424BFF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:42:30 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n7so10032064plp.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=QuA2nOD/g6wO4fWfuOSK3kZxzasuklXfklg/Thl42UI=;
        b=iauC8CGpndM0cJg51qRBrKbHzQVrXOt5ulqjoPDFRlqkkRjLECvBZjNBSbhtx3y0Y/
         wPkdvkD3l4OPZNXW1whw1m8MM6+Q4l67VnlPtsmtJEGyHf9kvlK20Usg27F9QDelf3lw
         YA8HRaGQSiuayuaFnwTOB9ZIIX5IgI00N1pAWS9DyP5GINXwsCx6m2C8jFrM+hN4CTUq
         P5VfYnDHSxZQizG+BjetkQUuy5Rgknd2hhMxkXSbJBazfSZvf8xNdzeENrj9Vpg/nDQp
         A91IDrn7aL1OTwxUGm4UeXUbXxMBin2vWChfbyOebTwDSRPDWjbLQW9QUDHOYQDnkL2Z
         KmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=QuA2nOD/g6wO4fWfuOSK3kZxzasuklXfklg/Thl42UI=;
        b=eTlZPpow4/LLyv9PP9SsLjjrcVJU1vRQ3rpdzQP7PjVLyetbnsrCo2297UVTuoPyJz
         2WMCG9Dx0/gKirddjX/I6EdT7V02+OmQZSbmERpzHgOuZooF8DibX/dXFGtvJBpzy4R7
         k7HtIw7Ql9nB0YNfVGhK0j2YDD+1s/VepZUrPxknDAZNKCsHgJAD1cFa3O32H0kceBPA
         ZJRWUuUSNm4UaAgX8sE3nFRh5XNvwP15YmvQ8McJEWXLi51CkkvCngF8hngjITBCvVzL
         fPbA0nQEr80HeNWoqisWey69COKlSpRPOhaMKq3550tSd5YwDFocpqkMLz3L22SdYKuz
         Irww==
X-Gm-Message-State: ACrzQf3o0jhOMQ3v3Q9EOEWrYtG6ZsQ+irUQitIXTvWaV4Zb3hXVR1so
        A7oEiiSi2wVsiNplO3TnzMj68A==
X-Google-Smtp-Source: AMsMyM7PU6yJAVOgQKRYlotLyGZgeKjWdsmJfJM9qm4TXRCp70S49xvYRlR1jtgZbV1wYkLEChw0nw==
X-Received: by 2002:a17:90a:a21:b0:20a:6fd6:f66d with SMTP id o30-20020a17090a0a2100b0020a6fd6f66dmr12967873pjo.70.1664811750230;
        Mon, 03 Oct 2022 08:42:30 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id v5-20020a622f05000000b0053b2681b0e0sm7594949pfv.39.2022.10.03.08.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:42:29 -0700 (PDT)
Date:   Mon, 3 Oct 2022 15:42:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     David Matlack <dmatlack@google.com>, x86 <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [V2 PATCH 3/8] KVM: selftests: Add arch specific post vm load
 setup
Message-ID: <YzsC4ibDqGh5qaP9@google.com>
References: <20220915000448.1674802-1-vannapurve@google.com>
 <20220915000448.1674802-4-vannapurve@google.com>
 <Yyt586xOWrNEoCYF@google.com>
 <CAGtprH8=wjQAhpr97KNsziT_jAqSS6sMTb5=gzgbhssNPm8q_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGtprH8=wjQAhpr97KNsziT_jAqSS6sMTb5=gzgbhssNPm8q_Q@mail.gmail.com>
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

On Mon, Sep 26, 2022, Vishal Annapurve wrote:
> On Wed, Sep 21, 2022 at 1:54 PM David Matlack <dmatlack@google.com> wrote:
> >
> > On Thu, Sep 15, 2022 at 12:04:43AM +0000, Vishal Annapurve wrote:
> > > diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> > > index 98edbbda9f97..73cfee3ebd76 100644
> > > --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> > > +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> > > @@ -839,4 +839,8 @@ static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
> > >   */
> > >  void kvm_selftest_arch_init(void);
> > >
> > > +/*
> > > + * API to execute architecture specific setup after loading the vm elf.
> >
> > It's not a "vm elf" per-se, it's "loading the elf into the VM". How
> > about:
> >
> > /*
> >  * API to execute arch-specific logic after loading the selftest ELF image
> >  * into the VM.
> >  */
> >
> 
> Ack. Will update this in the next series.

Even better, call it from __vm_create() and name it something like
kvm_arch_vm_post_create().  Like David said, while the hook has a dependency on
being called after loading the ELF image, the action that arch code is expected
to take doesn't have anything to do with loading the ELF image.

And then instead of introducing an arch hook with no implementation, the patch that
adds the hook can instead use it to replace the x86-64 #ifdef in __vm_create().

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index dafe4471a6c7..593dfadb662e 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -298,9 +298,8 @@ struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint32_t nr_runnable_vcpus,
 
        kvm_vm_elf_load(vm, program_invocation_name);
 
-#ifdef __x86_64__
-       vm_create_irqchip(vm);
-#endif
+       kvm_arch_vm_post_create(vm);
+
        return vm;
 }
 
 
