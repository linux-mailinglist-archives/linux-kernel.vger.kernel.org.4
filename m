Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A1F68DDEA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjBGQ0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjBGQ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:26:08 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FE33EC6B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:25:55 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id d2so11870324pjd.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 08:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yFM5Yaobs2Occpb2FR0i8/T7O2SHqwcz7pTe7Mef/v8=;
        b=Pp+tHvfQW77EcmLrVzwpDEqex9kxOQW9cn12Fjx4d+fa3xnEk2vJ9F9TkGkobSW19M
         dByP9frvRsbIXbXjb2efS9+tqXQpXjQlvNtr9Dm6bWnJbNDSU0wVSbvHfWOzRBBV7MqM
         NDJE8BNY79496tj5XtAn3OU83y+G4v4V1zB2E9OX09d6N6ckW16Dg78wZjBk0hsc09kz
         7ei8cbZqtgnhiXHAhi2n0YtWVuzllo2PPATJVCNy4QUf7eRc8IEgtqD8HzRUvKLnrIcT
         c48F0FOI6QHzfYPpZxExZKKYoBamCbPIloyEHea3WYpbTPvA8NCqtgBA6nIuN8/2I+8b
         50nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFM5Yaobs2Occpb2FR0i8/T7O2SHqwcz7pTe7Mef/v8=;
        b=Xt/VQ+0QI7YsNpmz72qYMpmQMt4Wk5lBP73zqB5fB/1guB8BeFf6VOcW1RT1f+KGqu
         9GL6JNbvSiqc67ccG/vRjjyP3TV/HfSBLOmJ9Q22c2+yqsAPb2KFDJZgAuK28/WekVJg
         zhFoXJ/IQ8KCkcd9gI6pMtUxhnCIYt9vuh5/PrVx0SFduyCW5JucYpaTSVo4VK3uRE95
         wcti6DX8cS/2O/+gqTxzIcK9L+gbiNZMGLcC9zUmWI+PkM8M5daqUsu4ZbbhWVajCSqu
         jIpsvTIYTijgv6IwEDfdsZyVmXpRAdqAZkBbHGLyTvtpnnCHdTyE/Acp4E3SUxVN7c+/
         Xf8w==
X-Gm-Message-State: AO0yUKVbh8+8KyEyX4AzvmI/0DckkABxb0+XqDaAHp70cnhxe9QZaZ0A
        5S8iI+3bdGNsg46vcZiBYh35/DKnn/aIWXklm38=
X-Google-Smtp-Source: AK7set98tqnb6UcqS0jXGArlNRvpmZM98md0FhgwG4ZnBzdTDS8Acb6IumbHidk9lfYERcSDh1kQSA==
X-Received: by 2002:a17:902:7c0b:b0:198:af4f:de0d with SMTP id x11-20020a1709027c0b00b00198af4fde0dmr206086pll.13.1675787154893;
        Tue, 07 Feb 2023 08:25:54 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a23-20020aa78657000000b005a75d85c0c7sm1902879pfo.51.2023.02.07.08.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:25:54 -0800 (PST)
Date:   Tue, 7 Feb 2023 16:25:50 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/7] KVM: x86: Improve return type handling in
 kvm_vm_ioctl_get_nr_mmu_pages()
Message-ID: <Y+J7jurSKEIeYEeM@google.com>
References: <20230203094230.266952-1-thuth@redhat.com>
 <20230203094230.266952-3-thuth@redhat.com>
 <Y91JAb0kKBYQjO8a@google.com>
 <579f432d-6100-0ba1-5ba4-f72349ec9173@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <579f432d-6100-0ba1-5ba4-f72349ec9173@redhat.com>
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

On Tue, Feb 07, 2023, Thomas Huth wrote:
> On 03/02/2023 18.48, Sean Christopherson wrote:
> > On Fri, Feb 03, 2023, Thomas Huth wrote:
> > > kvm_vm_ioctl_get_nr_mmu_pages() tries to return a "unsigned long" value,
> > > but its caller only stores ther return value in an "int" - which is also
> > > what all the other kvm_vm_ioctl_*() functions are returning. So returning
> > > values that do not fit into a 32-bit integer anymore does not work here.
> > > It's better to adjust the return type, add a sanity check and return an
> > > error instead if the value is too big.
> > > 
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   arch/x86/kvm/x86.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index da4bbd043a7b..caa2541833dd 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -6007,8 +6007,11 @@ static int kvm_vm_ioctl_set_nr_mmu_pages(struct kvm *kvm,
> > >   	return 0;
> > >   }
> > > -static unsigned long kvm_vm_ioctl_get_nr_mmu_pages(struct kvm *kvm)
> > > +static int kvm_vm_ioctl_get_nr_mmu_pages(struct kvm *kvm)
> > >   {
> > > +	if (kvm->arch.n_max_mmu_pages > INT_MAX)
> > > +		return -EOVERFLOW;
> > > +
> > >   	return kvm->arch.n_max_mmu_pages;
> > >   }
> > 
> > My vote is to skip this patch, skip deprecation, and go straight to deleting
> > KVM_GET_NR_MMU_PAGES.  The ioctl() has never worked[*], and none of the VMMs I
> > checked use it (QEMU, Google's internal VMM, kvmtool, CrosVM).
> 
> I guess I'm living too much in the QEMU world where things need to be
> deprecated first before removing them ;-)

If KVM_GET_NR_MMU_PAGES actually worked or had users then I'd feel differently.
Anything we do to try and make this less awful is going to be an ABI change, so
we might as well go for broke.

> But sure, if everybody agrees that removing this directly is fine, too, I
> can do this in v2.
> 
>  Thomas
> 
> 
> PS: Has there ever been a discussion about the other deprecated interfaces
> in include/uapi/linux/kvm.h ? Most of the stuff there seems to be from 2009
> ... so maybe it's time now to remove that, too?

Not sure.  They aren't actually "deprecated" for most projects' definition of
"deprecated".  AFAICT, "deprecated" here means "removed, but with a placeholder
so that KVM doesn't reuse the old ioctl() number".

It probably makes sense to do the same for KVM_GET_NR_MMU_PAGES.  Yank out the
backing code but leave the ioctl() definition so that if there are users, they
get an explicit error code instead of random behavior, i.e. prevent KVM from
reusing the number in the near future.
