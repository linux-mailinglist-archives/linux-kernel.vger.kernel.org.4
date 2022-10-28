Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215C2610FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiJ1Lh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJ1LhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C271D20C4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666956985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+t73/ZljYXT5F7jsdtcoGf9en8qeiMUB5F5E4isrHQ=;
        b=DaND4hcaNF10Liq+EuKOY6hbDV/eKBfFpEG+2vW3YTV3GfutlBTrhNL8hixrBImzv3lx90
        p0mRAuDglfgFtlxP6Lr3nAGGJnu8QnMIrCknoD7UXT+0/aYjcpPY2AaE2Cu2T5R4N0zo/v
        mLNe6JZrhnEKapgc0VhNF5mHhHQJALA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-155-o4BQONWjMv-sz_bq0sUGqw-1; Fri, 28 Oct 2022 07:36:23 -0400
X-MC-Unique: o4BQONWjMv-sz_bq0sUGqw-1
Received: by mail-wm1-f69.google.com with SMTP id o18-20020a05600c4fd200b003c6ceb1339bso3446102wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+t73/ZljYXT5F7jsdtcoGf9en8qeiMUB5F5E4isrHQ=;
        b=2nT30YwDRLq8Sguf/SxWOt+WpWFeXpv7beTeykl8x+WHJDcMnYDX6tVPRGDk9jN/Jf
         /GSfZlqy7rTpHtf9hVjcCpqmvAcFDzavnuwJ1thwybEFS3nM9NTVTkEWYYqJ1D/nMYkq
         WXT7OD/6EPuDldTQVD5/3MFC7lp1YD3wSamuAgd3Y1eO6BN/lLYWyQClvhOoqkLg37Qg
         KU870M9FEw5HzRuKkqGnEj0fyCMJl0JQ02/E7bYA1WDvu096xLIGp1PP1N9lS4my+eHx
         J/x+RMtZG/87lwWhthK7JbVnFGUEjxd6vQmC5jyBZXoirg5aUBX6r6DCScvU8hw3mgvC
         VleQ==
X-Gm-Message-State: ACrzQf2Fh+kQB2ClWpRY1RG1+lW3IY3Bucz60P82NvQHEV3LF+d72hw/
        qeQ+s+EVEo7glX1RCFbH62t5IcafB07Gx5MZTZsH1nqsOp4AVU7pfasMBzVEkTX3lnwXSgVIfTO
        CGvl8NCAD2zOl3KPAt2VetlRf
X-Received: by 2002:a5d:6dac:0:b0:236:6018:ebee with SMTP id u12-20020a5d6dac000000b002366018ebeemr20032895wrs.202.1666956981954;
        Fri, 28 Oct 2022 04:36:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7p9r6xcm2RUX/04gq2vplPI1McA86EjhkCcrLZg06y3OrwpTBWtFtl/FcN2KgtCRLGM98+Xw==
X-Received: by 2002:a5d:6dac:0:b0:236:6018:ebee with SMTP id u12-20020a5d6dac000000b002366018ebeemr20032886wrs.202.1666956981673;
        Fri, 28 Oct 2022 04:36:21 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id n15-20020a056000170f00b0022cd0c8c696sm3606024wrc.103.2022.10.28.04.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 04:36:20 -0700 (PDT)
Message-ID: <c61f6089-57b7-e00f-d5ed-68e62237eab0@redhat.com>
Date:   Fri, 28 Oct 2022 13:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mhal@rbox.co
References: <20221027161849.2989332-1-pbonzini@redhat.com>
 <20221027161849.2989332-4-pbonzini@redhat.com> <Y1q+a3gtABqJPmmr@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 03/16] KVM: x86: set gfn-to-pfn cache length consistently
 with VM word size
In-Reply-To: <Y1q+a3gtABqJPmmr@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 19:22, Sean Christopherson wrote:
> On Thu, Oct 27, 2022, Paolo Bonzini wrote:
>> So, use the short size at activation time as well.  This means
>> re-activating the cache if the guest requests the hypercall page
>> multiple times with different word sizes (this can happen when
>> kexec-ing, for example).
> 
> I don't understand the motivation for allowing a conditionally valid GPA.  I see
> a lot of complexity and sub-optimal error handling for a use case that no one
> cares about.  Realistically, userspace is never going to provide a GPA that only
> works some of the time, because doing otherwise is just asking for a dead guest.

We _should_ be following the Xen API, which does not even say that the
areas have to fit in a single page.  In fact, even Linux's

         struct vcpu_register_runstate_memory_area area;

         area.addr.v = &per_cpu(xen_runstate, cpu);
         if (HYPERVISOR_vcpu_op(VCPUOP_register_runstate_memory_area,
                                xen_vcpu_nr(cpu), &area))

could fail or not just depending on the linker's whims, if I'm not
very confused.

Other data structures *do* have to fit in a page, but the runstate area
does not and it's exactly the one where the cache comes the most handy.
For this I'm going to wait for David to answer.

That said, the whole gpc API is really messy and needs to be cleaned
up beyond what this series does.  For example,

         read_lock_irqsave(&gpc->lock, flags);
         while (!kvm_gfn_to_pfn_cache_check(v->kvm, gpc, gpc->gpa,
                                            sizeof(x))) {
                 read_unlock_irqrestore(&gpc->lock, flags);

                 if (kvm_gfn_to_pfn_cache_refresh(v->kvm, gpc, gpc->gpa, sizeof(x)))
                         return;

                 read_lock_irqsave(&gpc->lock, flags);
         }
	...
         read_unlock_irqrestore(&gpc->lock, flags);

should really be simplified to

	khva = kvm_gpc_lock(gpc);
	if (IS_ERR(khva))
		return;
	...
	kvm_gpc_unlock(gpc);

Only the special preempt-notifier cases would have to use check/refresh
by hand.  If needed they could even pass whatever length they want to
__kvm_gpc_refresh with, explicit marking that it's a here-be-dragons __API.

Also because we're using the gpc from non-preemptible regions the rwlock
critical sections should be enclosed in preempt_disable()/preempt_enable().
Fortunately they're pretty small.

For now I think the best course of action is to quickly get the bugfix
patches to Linus, and for 6.2 drop this one but otherwise keep the length
in kvm_gpc_activate().

> Aren't we just making up behavior at this point?  Injecting a #GP into the guest
> for what is a completely legal operation from the guest's perspective seems all
> kinds of wrong.

Yeah, it is and this patch was a steaming pile...  Though, while this
one is particularly egregious because it comes from an MSR write, a lot
of error returns in xen.c are inviting userspace to make up error
conditions that aren't there in Xen.  In fact activate should probably
ignore a refresh EFAULT altogether.

Paolo

