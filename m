Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04CD5C045D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiIUQi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIUQiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:38:08 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863355E556
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:23:16 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so14802508pja.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=TgCDquYzB+uh6PyjQ36h7MsKqShSbirTLStqH3wnxJo=;
        b=JOnwT0e5P2QGIUMUm8nxiAb7XQN0dCUXzpEoJyGWfmcp0H9oYpBbziJ0jPhWf3pcGz
         2twu5ZCLzDrMghoTJG52f1uQdccOfadJdZzcucfxar4LDeXZf29HvOBNAyRggX1ewfN/
         KFKKsxyVPWrg59Dl+N9UWUdFxaeEo64sCRunkLoLi3oA7r6dGiQXqDba6UJipJVLd9XI
         cCnmtruLS7CnIN8gKrYXO8FosqfYaA65O7QBU95OtTstsnkma2hnUgveTL3N6Mzh5iX/
         GCN/tQ0FpVJnbuOdgqFVS8eHnZmlIA1j4ZW8Xo+9civlXvjInjMh9s9hsNuGn8Zz5Mg0
         9piQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=TgCDquYzB+uh6PyjQ36h7MsKqShSbirTLStqH3wnxJo=;
        b=eGd0esf0jLpxDPMn3oQebSHyETz+33KE0ZeXsJUfV6JXdgoziDaYIKH5ZgaPWcM++H
         MK3rThWSIPm1ZfITgxKGUEWCagYxhuaqDaTuG11oXvgiHmGFf5sp/1Ry2r6j+dB23jss
         VKJ3FnWg6TApyqG+vZ8iIPS/GfevbKaU3mG+xZaERtAlAiErNcpdWdRX3dmm2g3+7Oc1
         zbu2X24ElMo2ycY7f12bcKicJEoBQqk+wfiVaqbAcbYttC0tSfKi3NcR5G54aUIGeF8V
         PKx5G8JO3tuR/OqlFkfO+6aMuGXHipnDAr6GUw3gsyilbVwsZQzINc+eki5qWPnAFp5x
         nG9A==
X-Gm-Message-State: ACrzQf3Eta1I4xp39zT11YZZv3vL5Ila6VrrQDPYVga5mZbfgaUsNzE4
        q7s7OIvNYSJxh+UMa9KKSQ7gCQ==
X-Google-Smtp-Source: AMsMyM7q3W2tJOzxQ0WF5GHYHSACr2zshovPYRCEUlaSf+y5r61u9vrpyAFgizkR1mw0AMkopm3klg==
X-Received: by 2002:a17:90b:4f8e:b0:202:dd39:c04d with SMTP id qe14-20020a17090b4f8e00b00202dd39c04dmr10765799pjb.66.1663777395856;
        Wed, 21 Sep 2022 09:23:15 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id jo18-20020a170903055200b00176a2d23d1asm2255751plb.56.2022.09.21.09.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 09:23:15 -0700 (PDT)
Date:   Wed, 21 Sep 2022 16:23:11 +0000
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
Subject: Re: [PATCH v10 02/39] KVM: x86: hyper-v: Resurrect dedicated
 KVM_REQ_HV_TLB_FLUSH flag
Message-ID: <Yys6b1ZqYbw9Umyu@google.com>
References: <20220921152436.3673454-1-vkuznets@redhat.com>
 <20220921152436.3673454-3-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921152436.3673454-3-vkuznets@redhat.com>
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

On Wed, Sep 21, 2022, Vitaly Kuznetsov wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index f62d5799fcd7..86504a8bfd9a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3418,11 +3418,17 @@ static inline void kvm_vcpu_flush_tlb_current(struct kvm_vcpu *vcpu)
>   */
>  void kvm_service_local_tlb_flush_requests(struct kvm_vcpu *vcpu)
>  {
> -	if (kvm_check_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu))
> +	if (kvm_check_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu)) {
>  		kvm_vcpu_flush_tlb_current(vcpu);
> +		kvm_clear_request(KVM_REQ_HV_TLB_FLUSH, vcpu);

This isn't correct, flush_tlb_current() flushes "host" TLB entries, i.e. guest-physical
mappings in Intel terminology, where flush_tlb_guest() and (IIUC) Hyper-V's paravirt
TLB flush both flesh "guest" TLB entries, i.e. linear and combined mappings.

Amusing side topic, apparently I like arm's stage-2 terminology better than "TDP",
because I actually typed out "stage-2" first.

> +	}
>  
> -	if (kvm_check_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu))
> +	if (kvm_check_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu)) {
> +		kvm_vcpu_flush_tlb_guest(vcpu);
> +		kvm_clear_request(KVM_REQ_HV_TLB_FLUSH, vcpu);
> +	} else if (kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu)) {
>  		kvm_vcpu_flush_tlb_guest(vcpu);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(kvm_service_local_tlb_flush_requests);
>  
> -- 
> 2.37.3
> 
