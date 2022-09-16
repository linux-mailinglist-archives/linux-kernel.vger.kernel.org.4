Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C371C5BB1DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiIPSKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiIPSKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC07527B24
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663351796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dGo9IIHnzVXPXPzRwNLgG2J2p1J5QcMOec8HOITKZNg=;
        b=L+nDd7drQ18V/4o+P3iWlEwbGCTApKViDUYJSuQiyuYGZvXm8ZoeFu9zf7M0agV5Afg8Es
        ASqGEL7SAI5ROEiWOJhW1QYhZyQY5gkw60kg9knoPc+BhNLgD8iDkP27vtIUr3URpIZe0z
        NkwzgdT52RXTrK92Fv1TJ7sQ/SqCrhc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-480-GoN8AAOuPES_BcodPtpqfA-1; Fri, 16 Sep 2022 14:09:55 -0400
X-MC-Unique: GoN8AAOuPES_BcodPtpqfA-1
Received: by mail-qk1-f199.google.com with SMTP id s17-20020a05620a255100b006c9cefbc68eso18931861qko.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=dGo9IIHnzVXPXPzRwNLgG2J2p1J5QcMOec8HOITKZNg=;
        b=jxtQpV9JAfniAM9QU7Dt58nDjljKvVU/pDIvZFPZZdxKe9njoVFiz/CmSrPggmOTYf
         uhMWKo07jVqAGXTBAt/HuF+w9nbeHSXFL6A3dPJBeGHgMhdjJX+ii9N8+pJPu1CemlYp
         p8jms2Kk6Jz2QNJf0a55lURpjO7pUR3l+FMXuM0MUE8DQTmmUUvBt7aR6M1t2Ck8qq7I
         Xf1osOHZYN0Mw4nH8F58DGDSX4f+xUpF2K5JAApURcPk0fjBlbQMRfhTcAOOr/BQevb6
         JKM3RTkdks33AtVklnw8eLOW6Nalq/bLa1u1b6dqyE6oCA4UDUdqmAYRbUMn9oiCoJxl
         gtyw==
X-Gm-Message-State: ACrzQf3uuO55V9zb1XY3mg95G4BzElhmw+X7E9phBzc0vimOyhYj5nKM
        CevHr5IjLX1lzFdoHmmKzqtDFgFHuSQzNM0pqIOnaDWSA2LJ6yjZL/m17VG1kBn6BwUwL2bob7i
        ZsNSp9bVdFHc/rhG/bGkAqDuD
X-Received: by 2002:ac8:5f4d:0:b0:35b:ba2e:ce1 with SMTP id y13-20020ac85f4d000000b0035bba2e0ce1mr5516870qta.26.1663351795091;
        Fri, 16 Sep 2022 11:09:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Eq8nutd1y8SgkrtcXFUsUl9UMHM0MnxQbGXx8ngkMtdvW9XgFJl7Id6By2Z5c1AZ7GoPT7w==
X-Received: by 2002:ac8:5f4d:0:b0:35b:ba2e:ce1 with SMTP id y13-20020ac85f4d000000b0035bba2e0ce1mr5516842qta.26.1663351794880;
        Fri, 16 Sep 2022 11:09:54 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id l19-20020a05620a28d300b006b60d5a7205sm7398453qkp.51.2022.09.16.11.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:09:54 -0700 (PDT)
Date:   Fri, 16 Sep 2022 14:09:52 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, catalin.marinas@arm.com,
        linux-kselftest@vger.kernel.org, bgardon@google.com,
        shuah@kernel.org, corbet@lwn.net, maz@kernel.org,
        drjones@redhat.com, will@kernel.org, zhenyzha@redhat.com,
        dmatlack@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        oliver.upton@linux.dev, shan.gavin@gmail.com
Subject: Re: [PATCH v2 1/5] KVM: x86: Introduce KVM_REQ_RING_SOFT_FULL
Message-ID: <YyS78BqsQxKkLOiW@xz-m1.local>
References: <20220916045135.154505-1-gshan@redhat.com>
 <20220916045135.154505-2-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220916045135.154505-2-gshan@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 12:51:31PM +0800, Gavin Shan wrote:
> This adds KVM_REQ_RING_SOFT_FULL, which is raised when the dirty
> ring of the specific VCPU becomes softly full in kvm_dirty_ring_push().
> The VCPU is enforced to exit when the request is raised and its
> dirty ring is softly full on its entrance.
> 
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/x86/kvm/x86.c       | 5 +++--
>  include/linux/kvm_host.h | 1 +
>  virt/kvm/dirty_ring.c    | 4 ++++
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 43a6a7efc6ec..7f368f59f033 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10265,8 +10265,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  	bool req_immediate_exit = false;
>  
>  	/* Forbid vmenter if vcpu dirty ring is soft-full */
> -	if (unlikely(vcpu->kvm->dirty_ring_size &&
> -		     kvm_dirty_ring_soft_full(&vcpu->dirty_ring))) {
> +	if (kvm_check_request(KVM_REQ_RING_SOFT_FULL, vcpu) &&
> +	    kvm_dirty_ring_soft_full(&vcpu->dirty_ring)) {
> +		kvm_make_request(KVM_REQ_RING_SOFT_FULL, vcpu);
>  		vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
>  		trace_kvm_dirty_ring_exit(vcpu);
>  		r = 0;

As commented previously - can we use kvm_test_request() instead? because we
don't want to unconditionally clear the bit.  Instead of making the request
again, we can clear request only if !full.

We can also safely move this into the block of below kvm_request_pending()
as Marc used to suggest.

To explicitly use kvm_clear_request(), we may need to be careful on the
memory barriers.  I'm wondering whether we should have moved
smp_mb__after_atomic() into kvm_clear_request() because kvm_clear_request()
is used outside kvm_check_request() and IIUC all the call sites should
better have that barrier too to be safe.

Side note: when I read the code around I also see some mis-use of clear
request where it can be omitted, e.g.:

		if (kvm_check_request(KVM_REQ_UNHALT, vcpu)) {
			kvm_clear_request(KVM_REQ_UNHALT, vcpu);
			vcpu->run->exit_reason = KVM_EXIT_IRQ_WINDOW_OPEN;
		}

Maybe it's a sign of bad naming, so we should renamed kvm_check_request()
to kvm_test_clear_request() too to show that clearing after that is not
needed?

Thanks,

-- 
Peter Xu

