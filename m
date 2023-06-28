Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB60A741B4D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjF1V7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjF1V7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:59:02 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F242103
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:59:02 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-262f872fdcdso15355a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687989541; x=1690581541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibnfIbYLuJprbyc7sn5N3Pf0TgkraQ9Zv5pFLImKpVg=;
        b=Ge6+GmIzvDZU7Zw141Rx/LRC7h8S4S5RBarecs/PvpTQhQ+pdIj1ek6PydxAGs4wrF
         t2iVRrxbJeLRxCv5mN6fJU4t8uqOR87OO9YpWLyftShqUPn1OHvyHYfWhENz336KFZK+
         ex6254kwUAza1RlM9ZxY4VUmZjOktvGfcPN9SFnW29aABIBBWxlDrcV4D+eRzFUu9jTG
         pb2AHu2xbpBh28I56EFcG+v3AeGVEYahO29wIfow2sCSCpcMKR+lzI4jclPJdO40qk3S
         PjamQtKwbZlti7ku32Du9kxnZLrrQ6rpe6ApbCKiPBkicKaFDxLl6HdnTyR7aqPila4O
         cwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687989541; x=1690581541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibnfIbYLuJprbyc7sn5N3Pf0TgkraQ9Zv5pFLImKpVg=;
        b=MWanlWUn/7Wdf9AwSsDn/rsY01HnGWWNSiTZuptx6OXloaMpXknbG6RygEHitOXOMY
         R0P6f+h1Iyc26EpiAQoUTFWLlUNVqbAdgC6RBaTd+uZwvwFbzLrYriVrqhPaTOwnr5Ld
         fveUe3aDn4IuQVVQX5/IFhs/4matqwnQe27jLsHArQ310tdeZx5K6s1z4i4nFmrH5EZ/
         hQ/cSnHvgBgps+1VbLwkhPPFVgozF/br4bPRfGelqVFnbb2gHYIthpdhVNY/NJ4rnWr9
         nAErsf7RbXymcjsEzMgnNtkvxivvbhB19fAZYuUi2oeOYHuqGic9S/9wRHb+Iz34Xf/4
         EsFw==
X-Gm-Message-State: AC+VfDxmbSA608YdeU8GRHeUBNxmc9FbmqRg/VhuRTn5qXg0TnJsY16t
        SUBJwR9AJbfQdrdHzshWjaRqwHBF5NI=
X-Google-Smtp-Source: ACHHUZ4rvDnUAz5eHaI/CZWx4/4PhYzzJqS4OnxZCidRNr69vjsJoOjv5M+IT/B0vTJKM2dRyV7PAIysIKQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:8049:b0:263:39c1:d0b2 with SMTP id
 e9-20020a17090a804900b0026339c1d0b2mr661352pjw.5.1687989541371; Wed, 28 Jun
 2023 14:59:01 -0700 (PDT)
Date:   Wed, 28 Jun 2023 14:59:00 -0700
In-Reply-To: <20230616023524.7203-1-yan.y.zhao@intel.com>
Mime-Version: 1.0
References: <20230616023101.7019-1-yan.y.zhao@intel.com> <20230616023524.7203-1-yan.y.zhao@intel.com>
Message-ID: <ZJytJB+mwdU6v/XJ@google.com>
Subject: Re: [PATCH v3 03/11] KVM: x86/mmu: Use KVM honors guest MTRRs helper
 when CR0.CD toggles
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, chao.gao@intel.com, kai.huang@intel.com,
        robert.hoo.linux@gmail.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023, Yan Zhao wrote:
> Call helper to check if guest MTRRs are honored by KVM MMU before zapping,

Nit, state the effect, not what the code literally does.  The important part is
that the end result is that KVM will zap if and only if guest MTRRs are being
honored, e.g.

  Zap SPTEs when CR0.CD is toggled if and only if KVM's MMU is honoring
  guest MTRRs, which is the only time that KVM incorporates the guest's
  CR0.CD into the final memtype.

> as values of guest CR0.CD will only affect memory types of KVM TDP when
> guest MTRRs are honored.
> 
> Suggested-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  arch/x86/kvm/x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9e7186864542..6693daeb5686 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -942,7 +942,7 @@ void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned lon
>  		kvm_mmu_reset_context(vcpu);
>  
>  	if (((cr0 ^ old_cr0) & X86_CR0_CD) &&
> -	    kvm_arch_has_noncoherent_dma(vcpu->kvm) &&
> +	    kvm_mmu_honors_guest_mtrrs(vcpu->kvm) &&
>  	    !kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_CD_NW_CLEARED))
>  		kvm_zap_gfn_range(vcpu->kvm, 0, ~0ULL);
>  }
> -- 
> 2.17.1
> 
