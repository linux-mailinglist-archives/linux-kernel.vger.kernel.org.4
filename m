Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631E760FF3E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiJ0RW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbiJ0RW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:22:57 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2D018C421
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 10:22:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id v28so2060686pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 10:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xdt63SxEY4K5w2+Q3gX7B2Gg/JGFNAEvy1g4Fz6Bigs=;
        b=mwkBETp7Xvfd3Q3OLg0X9IIOB8LNnUSkzSnhm0OTfyWbWfN3oK5uf763RGar2BdjU5
         arLT/eHJrhVQNpkaStEFQ8+BhVfxgEUuRLlZNdORyEC8cwD+Q+4aJFnISlD+1pjt8xTW
         1WtykhcYzWwr06eGi4SxRq8RPtQ7eXJB/ATOYTAhhlDOm472lps2aPwfx62D4B3bTbUm
         LLHQYK4KQ0xgFz+1KIYEUdzCUCnk5AAkQyX7nqE14H28sG8mvHjo1kXzAb/QB3DsP5rJ
         i/iYDj4qmdat4AeBPb/AT1PY2E8R7snjgQsaRSIrl0hMaMzHrj1tD2/9JLCoJsOHfCEE
         m4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdt63SxEY4K5w2+Q3gX7B2Gg/JGFNAEvy1g4Fz6Bigs=;
        b=uIFFKvEGoNeaXcArzU1ZoAGl10cKkUlTKthQUZFtVU/kx3IPgh+DEI1Rf3E3xzsc5G
         VNjK8RpLEpnZEMbEo0aXrFFLFhhWQaLFpoHASXsE/3+uTMuLX0T819sSECpxmiiUsgnr
         9c37N/Rw45UU0TcVwWl5I5J0hPDBPpkS/WKjDXVQ+f5JTC+V62ov7UAbDB7oy1uvR6Wo
         vyMMwksNMC+LBc79nzga2WZcxmR9tjOFzg9kkT6BOEX3bmt9QFO2sgOnfX9yfr6/u7N9
         x2i+83UuJqOr17ORjJa9UtHPgWIW7dlHvRz6VZTjVGi7nOWkoFaCmYM7YrtLRw8MfkaT
         SNHQ==
X-Gm-Message-State: ACrzQf3ddqw/CqqevF5t1sHtgbedQH+x635tbBXmR89U/bDlX00PjVxE
        JwnFyA5Whk9/o4421tPyjelb8g==
X-Google-Smtp-Source: AMsMyM4Va5X7EVlPPmVuN2nFXHsVirgEyHnheYF9OPRkjs0ttBzH9CwemB+VfbK3vYt9XDKlEtPGUA==
X-Received: by 2002:a63:1a07:0:b0:46b:2825:f9cf with SMTP id a7-20020a631a07000000b0046b2825f9cfmr44154524pga.370.1666891375310;
        Thu, 27 Oct 2022 10:22:55 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i26-20020aa796fa000000b0056b8e788acesm1412983pfq.82.2022.10.27.10.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 10:22:54 -0700 (PDT)
Date:   Thu, 27 Oct 2022 17:22:51 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mhal@rbox.co
Subject: Re: [PATCH 03/16] KVM: x86: set gfn-to-pfn cache length consistently
 with VM word size
Message-ID: <Y1q+a3gtABqJPmmr@google.com>
References: <20221027161849.2989332-1-pbonzini@redhat.com>
 <20221027161849.2989332-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027161849.2989332-4-pbonzini@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022, Paolo Bonzini wrote:
> So, use the short size at activation time as well.  This means
> re-activating the cache if the guest requests the hypercall page
> multiple times with different word sizes (this can happen when
> kexec-ing, for example).

I don't understand the motivation for allowing a conditionally valid GPA.  I see
a lot of complexity and sub-optimal error handling for a use case that no one
cares about.  Realistically, userspace is never going to provide a GPA that only
works some of the time, because doing otherwise is just asking for a dead guest.

> +static int kvm_xen_reactivate_runstate_gpcs(struct kvm *kvm)
> +{
> +	struct kvm_vcpu *vcpu;
> +	unsigned long i;
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		if (vcpu->arch.xen.runstate_cache.active) {

This is not safe when called from kvm_xen_write_hypercall_page(), which doesn't
acquire kvm->lock and thus doesn't guard against a concurrent call via
kvm_xen_vcpu_set_attr().  That's likely a bug in itself, but even if that issue
is fixed, I don't see how this is yields a better uAPI than forcing userspace to
provide an address that is valid for all modes.

If the address becomes bad when the guest changes the hypercall page, the guest
is completely hosed through no fault of its own, whereas limiting the misaligned
detection to KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADDR means that any "bad" address
will result in immediate failure, i.e. makes it so that errors are 100% userspace
misconfiguration bugs.

> +			int r = kvm_xen_activate_runstate_gpc(vcpu,
> +					vcpu->arch.xen.runstate_cache.gpa);
> +			if (r < 0)

Returning immediately is wrong, as later vCPUs will have a valid, active cache
that hasn't been verified for 64-bit mode.

> +				return r;
> +		}
> +	}
> +	return 0;
> +}
> +
>  void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, int state)
>  {
>  	struct kvm_vcpu_xen *vx = &v->arch.xen;
> @@ -212,11 +243,7 @@ void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, int state)
>  	if (!vx->runstate_cache.active)
>  		return;
>  
> -	if (IS_ENABLED(CONFIG_64BIT) && v->kvm->arch.xen.long_mode)
> -		user_len = sizeof(struct vcpu_runstate_info);
> -	else
> -		user_len = sizeof(struct compat_vcpu_runstate_info);
> -
> +	user_len = kvm_xen_runstate_info_size(v->kvm);
>  	read_lock_irqsave(&gpc->lock, flags);
>  	while (!kvm_gfn_to_pfn_cache_check(v->kvm, gpc, gpc->gpa,
>  					   user_len)) {
> @@ -461,7 +488,7 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
>  			mutex_lock(&kvm->lock);
>  			kvm->arch.xen.long_mode = !!data->u.long_mode;
>  			mutex_unlock(&kvm->lock);
> -			r = 0;
> +			r = kvm_xen_reactivate_runstate_gpcs(kvm);

Needs to be called under kvm->lock.  This path also needs to acquire kvm->srcu.

>  		}
>  		break;
>  
> @@ -596,9 +623,7 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
>  			break;
>  		}
>  
> -		r = kvm_gpc_activate(vcpu->kvm, &vcpu->arch.xen.runstate_cache,
> -				     NULL, KVM_HOST_USES_PFN, data->u.gpa,
> -				     sizeof(struct vcpu_runstate_info));
> +		r = kvm_xen_activate_runstate_gpc(vcpu, data->u.gpa);
>  		break;
>  
>  	case KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_CURRENT:
> @@ -843,9 +868,13 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
>  	u32 page_num = data & ~PAGE_MASK;
>  	u64 page_addr = data & PAGE_MASK;
>  	bool lm = is_long_mode(vcpu);
> +	int r;
>  
>  	/* Latch long_mode for shared_info pages etc. */
>  	vcpu->kvm->arch.xen.long_mode = lm;
> +	r = kvm_xen_reactivate_runstate_gpcs(kvm);
> +	if (r < 0)
> +		return 1;

Aren't we just making up behavior at this point?  Injecting a #GP into the guest
for what is a completely legal operation from the guest's perspective seems all
kinds of wrong.
