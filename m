Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EDA5E680B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiIVQGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiIVQF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:05:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3551DDCCDB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:05:56 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id a29so9761867pfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=8UXm0Wuxlu4Bt4voSl7YZvWHdnCtxyCoMESERPosODU=;
        b=QAhs05oYxHJqAl4FU2oaWzzWkKI0nIX60qInjCgo7UyfgIuvRzjFQJcqQMQNlL8YpY
         XRyOM4KeRIM4ilOf7GzWbOqlYAoVldEx0pYU3747pH3jBmqJppokAoBOtYiGyKev1STt
         XsYtxnL667lK2Uw2xI06UANITgMMQMtAxx+6FqmMR5dmARX9j19qkVZDzYcqp+n/885t
         i2DE4/L5jlBc+mbvWMHNIfD8A51MHWoi1St7tb9uAgNMrt7c0T3AJp7IKVRcZjIMupUV
         h6iW2kdZGfQTe/5+JaWALvxVUzAMdh6A2aQRiFWabPqW/3x+RPsYpSLbDjSb3sbKAENm
         A/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8UXm0Wuxlu4Bt4voSl7YZvWHdnCtxyCoMESERPosODU=;
        b=eyNpdxfKhw5DMpr7I3pyFNu9+OfGrTnnrDjFvOkwKkF4rx+PZAQiNmL89141s2o7BU
         UFOSneu23uCLRhtpnoV89aD0TguFlbrJDjEC5zf5j5js83szmNGIHNIlC0rEX+9/OXPQ
         I4XR02hQxs+g6kj6AIpKgIlsj0OitgzaDgcJbRAm1j1AUwl0WR4sTEK03qt7iqnIoKy8
         jW4TyJIHua8jrmSnhvrYlENg/6xQlT7TvnrwTrzJQfLT6MKmU4acIQQ7rqFfflp7mojC
         OTEe5LZCobIBP6M1282MGzJnvqTVmmXxZM7ZGXodcMnkzeT6Vumiih+CdmZPYwoJ2pd4
         0IKQ==
X-Gm-Message-State: ACrzQf0PiYHwfrPilIy8UrL6B9CcC3z95h8JCytcWgDYYpg4ZISfB/jD
        OmvqFDffZVW9WovcIPFvtoHttjq3zc+WtA==
X-Google-Smtp-Source: AMsMyM48tM5Re114GNafkJryyjV/WpRtV9qDBsM3hMJPYpwdORr7THBc++vwCcW8GNNqnLaeakklBQ==
X-Received: by 2002:a65:5b8d:0:b0:434:e318:80f with SMTP id i13-20020a655b8d000000b00434e318080fmr3706853pgr.97.1663862755052;
        Thu, 22 Sep 2022 09:05:55 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id r9-20020aa79629000000b00537eb0084f9sm4485056pfg.83.2022.09.22.09.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 09:05:54 -0700 (PDT)
Date:   Thu, 22 Sep 2022 16:05:50 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 20/39] KVM: nVMX: hyper-v: Enable L2 TLB flush
Message-ID: <YyyH3jnBfC8AnxHL@google.com>
References: <20220921152436.3673454-1-vkuznets@redhat.com>
 <20220921152436.3673454-21-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921152436.3673454-21-vkuznets@redhat.com>
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

On Wed, Sep 21, 2022, Vitaly Kuznetsov wrote:
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 0634518a6719..1451a7a2c488 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -1132,6 +1132,17 @@ static void nested_vmx_transition_tlb_flush(struct kvm_vcpu *vcpu,
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  
> +	/*
> +	 * KVM_REQ_HV_TLB_FLUSH flushes entries from either L1's VP_ID or
> +	 * L2's VP_ID upon request from the guest. Make sure we check for
> +	 * pending entries for the case when the request got misplaced (e.g.

Kind of a nit, but I'd prefer to avoid "misplaced", as that implies KVM puts entries
into the wrong FIFO.  The issue isn't that KVM puts entries in the wrong FIFO,
it's that the FIFO is filled asynchronously be other vCPUs and so it's possible
to switch to a FIFO that has valid entries without a pending request.

And thinking about this, KVM_REQ_HV_TLB_FLUSH shouldn't be handled in
kvm_service_local_tlb_flush_requests().  My initial reaction to this patch is that
queueing the request here is too late because the switch has already happened,
i.e. nVMX has already called kvm_service_local_tlb_flush_requests() and so the
request 

But making the request for the _new_ context is correct _and_ necessary, e.g. given

	vCPU0			vCPU1
	FIFO[L1].insert
	FIFO[L1].insert
				L1 => L2 transition
	FIFO[L1].insert
	FIFO[L1].insert
	KVM_REQ_HV_TLB_FLUSH

if nVMX made the request for the old contex, then this would happen

	vCPU0			vCPU1
	FIFO[L1].insert
	FIFO[L1].insert
				KVM_REQ_HV_TLB_FLUSH
				service FIFO[L1]
				L1 => L2 transition
	FIFO[L1].insert
	FIFO[L1].insert
	KVM_REQ_HV_TLB_FLUSH
				service FIFO[L2]
				...
				KVM_REQ_HV_TLB_FLUSH
				service FIFO[L2]
				L2 => L1 transition
				
				Run L1 with FIFO[L1] entries!!!

whereas what is being done in this patch is:


	vCPU0			vCPU1
	FIFO[L1].insert
	FIFO[L1].insert
				L1 => L2 transition
				KVM_REQ_HV_TLB_FLUSH
				service FIFO[2]
	FIFO[L1].insert
	FIFO[L1].insert
	KVM_REQ_HV_TLB_FLUSH
				service FIFO[L2]
				...
				L2 => L1 transition
				KVM_REQ_HV_TLB_FLUSH
				service FIFO[L1]

which is correct and ensures that KVM will always consume FIFO entries prior to
running the associated context.

In other words, unlike KVM_REQ_TLB_FLUSH_CURRENT and KVM_REQ_TLB_FLUSH_GUEST,
KVM_REQ_HV_TLB_FLUSH is not a "local" request.  It's much more like KVM_REQ_TLB_FLUSH
in that it can come from other vCPUs, i.e. is effectively a "remote" request.

So rather than handle KVM_REQ_TLB_FLUSH in the "local" path, it should be handled
only in the request path.  Handling the request in kvm_service_local_tlb_flush_requests()
won't break anything, but conceptually it's wrong and as a result it's misleading
because it implies that nested transitions could also be handled by forcing
kvm_service_local_tlb_flush_requests() to service flushes for the current, i.e.
previous, context on nested transitions, but that wouldn't work (see example above).

I.e. we should end up with something like this:

		/*
		 * Note, the order matters here, as flushing "all" TLB entries
		 * also flushes the "current" TLB entries, and flushing "guest"
		 * TLB entries is a superset of Hyper-V's fine-grained flushing.
		 * I.e. servicing the flush "all" will clear any request to
		 * flush "current", and flushing "guest" will clear any request
		 * to service Hyper-V's fine-grained flush.
		 */
		if (kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu))
			kvm_vcpu_flush_tlb_all(vcpu);

		kvm_service_local_tlb_flush_requests(vcpu);

		/*
		 * Fall back to a "full" guest flush if Hyper-V's precise
		 * flushing fails.  Note, Hyper-V's flushing is per-vCPU, but
		 * the flushes are considered "remote" and not "local" because
		 * the requests can be initiated from other vCPUs.
		 */
		if (kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu) &&
		    kvm_hv_vcpu_flush_tlb(vcpu))
			kvm_vcpu_flush_tlb_guest(vcpu);



> +	 * a transition from L2->L1 happened while processing L2 TLB flush
> +	 * request or vice versa). kvm_hv_vcpu_flush_tlb() will not flush
> +	 * anything if there are no requests in the corresponding buffer.
> +	 */
> +	if (to_hv_vcpu(vcpu))

This should be:

	if (to_hv_vcpu(vcpu) && enable_ept)

otherwise KVM will fall back to flushing the guest, which is the entire TLB, when
EPT is disabled.  I'm guessing this applies to SVM+NPT as well.

> +		kvm_make_request(KVM_REQ_HV_TLB_FLUSH, vcpu);
