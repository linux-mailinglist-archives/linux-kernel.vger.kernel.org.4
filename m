Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88B360AC57
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbiJXOF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbiJXOCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:02:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A4CC0680
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666615632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ikdy4ESn1TCb4zvnwxl7amrFzKQiGRODp2i93/VX6B0=;
        b=WnEYdQzP8aptaALtT5bw89MmHhhRoT68+bsxURHvSjs+3tQoURKhi9aig4qUxijI4/0lPQ
        sQp4pjj02+vB49PTFCIMgUcJtWXvRE183B6QMnn+PBZZ9V+GpxdYl4IROCZ9aJLzmfGQuA
        zEvjLNpEVpcc0scWk9TUsYg4L+WjhDI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-536-vyo6OUwHM3G6-ERH6oVy9w-1; Mon, 24 Oct 2022 08:33:11 -0400
X-MC-Unique: vyo6OUwHM3G6-ERH6oVy9w-1
Received: by mail-qk1-f197.google.com with SMTP id az32-20020a05620a172000b006ee8ae138a7so8841528qkb.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ikdy4ESn1TCb4zvnwxl7amrFzKQiGRODp2i93/VX6B0=;
        b=URo1+p/tgqCSKnY6vHoa2kyK9PRwx9OwePhvm3WUM4nAdZ8HZk+9qqUwo/cmGeCKb8
         Jilvn0HVlwvCCWBHl/4zTHMJy0hHgtb91f/HcvlooMq2c9B5Ifbn6XQ98+l7WF0sBhw+
         kRe34PSFoEMvsV49xXhkwqMAhKy0vfeQ3xRdtoNTo/dbdidG9USHDt5sCBR4xt36YtiG
         9KsBCHQERdOitqL3o8yUekD3FucaBzN/TrRGVRoI/mM6kV1CChDzff03KSc6s6EqSMSj
         D4blGY+g8UGpBULY3dL6ZxspjtH2XtHDQUaMXhR7ayTJQsaIbmAqyDKfivuGxovm+QAC
         PjKg==
X-Gm-Message-State: ACrzQf3uUCU56C0J7MYVpYi7rhKwl4mNn6VwhcSGP82LSNYtJ31+I33d
        qSMKz0H7Lte+l50yaDo/30v0SLxTgeEgJepvTs8jupgK3VzCwzBbvoax6TXiepx7EUqVH4vjzJ+
        w7rRKaDeQ+knXqlT7bp6Pmy0P
X-Received: by 2002:a05:622a:15cd:b0:39d:1b71:efc6 with SMTP id d13-20020a05622a15cd00b0039d1b71efc6mr15544304qty.225.1666614790621;
        Mon, 24 Oct 2022 05:33:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5GqnMikwjsnoB4MT/vsrF/0CjZKNoBcavjYjOmo0kObiOIIQkgn4TwDCiFmrlIn2emUIhntg==
X-Received: by 2002:a05:622a:15cd:b0:39d:1b71:efc6 with SMTP id d13-20020a05622a15cd00b0039d1b71efc6mr15544287qty.225.1666614790405;
        Mon, 24 Oct 2022 05:33:10 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id br44-20020a05620a462c00b006bbb07ebd83sm14475898qkb.108.2022.10.24.05.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 05:33:09 -0700 (PDT)
Message-ID: <73adb5493aba7241031b2d3f7be80fe3a731320c.camel@redhat.com>
Subject: Re: [PATCH v2 8/8] KVM: x86: do not define KVM_REQ_SMI if SMM
 disabled
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     seanjc@google.com, maciej.szmigiero@oracle.com
Date:   Mon, 24 Oct 2022 15:33:07 +0300
In-Reply-To: <20220929172016.319443-9-pbonzini@redhat.com>
References: <20220929172016.319443-1-pbonzini@redhat.com>
         <20220929172016.319443-9-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-29 at 13:20 -0400, Paolo Bonzini wrote:
> This ensures that all the relevant code is compiled out, in fact
> the process_smi stub can be removed too.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 2 ++
>  arch/x86/kvm/smm.h              | 1 -
>  arch/x86/kvm/x86.c              | 6 ++++++
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index d11697504471..d58d4a62b227 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -81,7 +81,9 @@
>  #define KVM_REQ_NMI			KVM_ARCH_REQ(9)
>  #define KVM_REQ_PMU			KVM_ARCH_REQ(10)
>  #define KVM_REQ_PMI			KVM_ARCH_REQ(11)
> +#ifdef CONFIG_KVM_SMM
>  #define KVM_REQ_SMI			KVM_ARCH_REQ(12)
> +#endif
>  #define KVM_REQ_MASTERCLOCK_UPDATE	KVM_ARCH_REQ(13)
>  #define KVM_REQ_MCLOCK_INPROGRESS \
>  	KVM_ARCH_REQ_FLAGS(14, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
> diff --git a/arch/x86/kvm/smm.h b/arch/x86/kvm/smm.h
> index 7ccce6b655ca..a6795b93ba30 100644
> --- a/arch/x86/kvm/smm.h
> +++ b/arch/x86/kvm/smm.h
> @@ -28,7 +28,6 @@ void process_smi(struct kvm_vcpu *vcpu);
>  static inline int kvm_inject_smi(struct kvm_vcpu *vcpu) { return -ENOTTY; }
>  static inline bool is_smm(struct kvm_vcpu *vcpu) { return false; }
>  static inline void kvm_smm_changed(struct kvm_vcpu *vcpu, bool in_smm) { WARN_ON_ONCE(1); }
> -static inline void process_smi(struct kvm_vcpu *vcpu) { WARN_ON_ONCE(1); }
>  
>  /*
>   * emulator_leave_smm is used as a function pointer, so the
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e22184bad92b..ba5661ee3fd7 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5020,8 +5020,10 @@ static void kvm_vcpu_ioctl_x86_get_vcpu_events(struct kvm_vcpu *vcpu,
>  
>  	process_nmi(vcpu);
>  
> +#ifdef CONFIG_KVM_SMM
>  	if (kvm_check_request(KVM_REQ_SMI, vcpu))
>  		process_smi(vcpu);
> +#endif
>  
>  	/*
>  	 * KVM's ABI only allows for one exception to be migrated.  Luckily,
> @@ -10194,8 +10196,10 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  		}
>  		if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
>  			record_steal_time(vcpu);
> +#ifdef CONFIG_KVM_SMM
>  		if (kvm_check_request(KVM_REQ_SMI, vcpu))
>  			process_smi(vcpu);
> +#endif
>  		if (kvm_check_request(KVM_REQ_NMI, vcpu))
>  			process_nmi(vcpu);
>  		if (kvm_check_request(KVM_REQ_PMU, vcpu))
> @@ -12539,7 +12543,9 @@ bool kvm_arch_dy_runnable(struct kvm_vcpu *vcpu)
>  		return true;
>  
>  	if (kvm_test_request(KVM_REQ_NMI, vcpu) ||
> +#ifdef CONFIG_KVM_SMM
>  		kvm_test_request(KVM_REQ_SMI, vcpu) ||
> +#endif
>  		 kvm_test_request(KVM_REQ_EVENT, vcpu))
>  		return true;
>  

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


