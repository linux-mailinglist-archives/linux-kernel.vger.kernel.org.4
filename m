Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494266DC9D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjDJRL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjDJRLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:11:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A842684
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:11:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 82-20020a250355000000b00b7411408308so6254257ybd.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681146667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ARWrA3tyrYvYyQo2qoH9Ph9VGASMsHQkguc25HVf/nY=;
        b=JjvN/iA1fIfrtEwAfnVJJkmQsSA8IeFFAttPVKfRtLKt+8fAa9E5uPXJ5lQobSaixQ
         MMQY6V1x1is1XkQPm452fhXekuD9K3aJ+32dVdKYdQRKZrPJB1z7py2Ueqqco4RWa9mE
         Q50uHPQMlKyUUZZQUZuYCr9pBwWit3fXjU9Q30HZmVesFUV4Vrc3V1i9hSTxUmlL+cjK
         fo6GJ25AEiRCFsSd+MZZPkcVPyNyHko86wPMrPVYhs1Zzn1cwF2zlagb6YTbaDTBJHMl
         jWaaxhDo26FVT6k4Zmpnxg2D45P/myPyeQhvfdzPMOg0ho6tyTfrzhk7ZbK21tM2osyK
         p2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681146667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARWrA3tyrYvYyQo2qoH9Ph9VGASMsHQkguc25HVf/nY=;
        b=yYzjOPC/mRqiSIhD/Abhaw7nrfoNx/UzcdnvlNwvZLSjFGAVh/xFuaMKs8Un0I6YTb
         pLDeif9j7UxOrBOiSmWFCK93qWJUNKoKU7Og7IkiKar7GP48MMRPuPaPifA4Dq/Z7ZO1
         K+PxNbi13dee6JvGP4C1o+ayar6KVMRHmeHpcfedGfVU7C7iSBChb5vyQJyNbB6jrQPE
         a/sQC0cW5vKENJZxEYrRYNVufkq4uA9ZooimV/yg5oXNlrXSUHxtrubP17PHP5g4+ri7
         ioHr0cr2cVerg9V7PvJCj3/NuT03cXlz2giIwECWQy5vFgarrwWCQB2ROzlobZVnd9hf
         M8IA==
X-Gm-Message-State: AAQBX9dUZrQzKnynpSIBfz5wwY9F1J6/MpQol4e2O4T9VGKa8xL6CJ/9
        bgjbSpzsiIFJjrtxTqvP5kCRJb4VWeY=
X-Google-Smtp-Source: AKy350bsx/Jc+JztpwRq49B9ca1aq9AyyShMMci0Mc/dtM3U8xp2K8+bALvwkB/KjtnMYSzYqQfjVaf7jB4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:909:b0:a27:3ecc:ffe7 with SMTP id
 bu9-20020a056902090900b00a273eccffe7mr10049885ybb.3.1681146667701; Mon, 10
 Apr 2023 10:11:07 -0700 (PDT)
Date:   Mon, 10 Apr 2023 10:11:06 -0700
In-Reply-To: <20230410125017.1305238-2-xiaoyao.li@intel.com>
Mime-Version: 1.0
References: <20230410125017.1305238-1-xiaoyao.li@intel.com> <20230410125017.1305238-2-xiaoyao.li@intel.com>
Message-ID: <ZDRDKsPGP9JI2MHA@google.com>
Subject: Re: [PATCH 1/2] KVM: VMX: Use kvm_read_cr4() to get cr4 value
From:   Sean Christopherson <seanjc@google.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023, Xiaoyao Li wrote:
> Directly use vcpu->arch.cr4 is not recommended since it gets stale value
> if the cr4 is not available.
> 
> Use kvm_read_cr4() instead to ensure correct value.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index d7bf14abdba1..befa2486836b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -3431,7 +3431,7 @@ static bool vmx_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
>  
>  void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
>  {
> -	unsigned long old_cr4 = vcpu->arch.cr4;
> +	unsigned long old_cr4 = kvm_read_cr4(vcpu);

Ha!  I've been tempted to change this multiple times, but always thought I was
just being a bit obsessive :-)

Patches look good, but I'm going to hold them for 6.5 just in case this somehow
causes a problem, e.g. if there's a bizzaro nested path that "works" because KVM
_doesn't_ decache info from the current VMCS.
