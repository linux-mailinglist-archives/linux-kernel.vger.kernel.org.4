Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6A260D1D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiJYQqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiJYQql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:46:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF7ADB756
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:46:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso12362653pjc.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t802XRZ4ju6esHz2gdzBPKyQxUZo0kLjybVlTy+BaT0=;
        b=cokZ1mvGSozXMG6CerV6Rd+fP9tW7EAkrSQqYfX/qq9TiMk07e9iMvBJGdHFtvszeh
         wlWG4DmW116lK4/Mzr0Udqt4rzPg1VZaGwrZvY59pDghJRU3/CXn/LLWjyr+3J5WbnzT
         eWDnuudTcrc3bfPHDWrjsRd5Udboq+d8wFW3SP8gLtXGjFInmHnKI6W2VI/4Pasq3fLE
         0rwXsMoXZAFiuE3J5uzkmftuvssYkrCNuJBbbQfQaWY6XvmN42g+dfaAG44YOmS9C277
         3hwjrMoN03VvTdvyX1Q0E0RjqljHeNZcz7XLWUDoJcj+yoVOon3qOc9Nt2U812VgMB6Q
         9g9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t802XRZ4ju6esHz2gdzBPKyQxUZo0kLjybVlTy+BaT0=;
        b=b62O6EBww0fV4gP6UVob/QG4f/dPOgP1d0rHvS4KLjyMqWWky8VhFO6z0XvJIqh3gC
         Yb/Lclr9/HVwXevizw3N5wyWEPO3mt9wHZjA+XEn4ac0wVtukFl1Cm0/Z7JgQgbnY4Wc
         44hpPCRvYZ4MQ2lbQu4tUUh3uvpEYKa/MViMogsJq6b91/mV6aFYbfrWobSXhPUAWIKj
         bN5e4HXoMDWF04A5o6vev1H6jqtqdPF+g50K9QEGGuXgQT2yHlo0rT9qR0wBeWwdr+pi
         OXAGPLyAIKXs9/tg07hY89qtPktjlAnbbFttbpK/HGJiLT2KP8IOU0rlh3QeIV7rg1aD
         ehiA==
X-Gm-Message-State: ACrzQf12CVk/ALodA+M3gn00n9w2/UiEXt95EY/DGCk9JlDI7tr09PNH
        1AJsSedNSNVvpJKY3kYMORLFoA==
X-Google-Smtp-Source: AMsMyM67kI+RGzNqCrJTOz4Ed0J3fiT5qutk6vQ4Ua/kDBpPMGw/L8BMLFlQ6xjsigPKJ1bDm7qhfg==
X-Received: by 2002:a17:902:db09:b0:184:ba4f:af28 with SMTP id m9-20020a170902db0900b00184ba4faf28mr39099395plx.145.1666716398746;
        Tue, 25 Oct 2022 09:46:38 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id z10-20020aa79e4a000000b0056ba138067fsm1608430pfq.29.2022.10.25.09.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 09:46:38 -0700 (PDT)
Date:   Tue, 25 Oct 2022 16:46:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com
Subject: Re: [PATCH] KVM: x86: Do not expose the host value of CPUID.8000001EH
Message-ID: <Y1gS6Z/kc+WfUsa3@google.com>
References: <20221022082643.1725875-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022082643.1725875-1-pbonzini@redhat.com>
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

On Sat, Oct 22, 2022, Paolo Bonzini wrote:
> Several fields of CPUID.8000001EH (ExtendedApicId in EAX[31:0],
> CoreId in EBX[7:0], NodeId in ECX[7:0]) vary on each processor,
> and it is simply impossible to fit the right values in the
> KVM_GET_SUPPORTED_CPUID API, in such a way that they can be
> passed to KVM_SET_CPUID2.

The same is true for 0xb and 0x1f, why delete 0x8000001e but keep those? I agree
that KVM_GET_SUPPORTED_CPUID can't get this right, but KVM can at least be
consistent with itself.

> The most likely way to avoid confusion in the guest is to zero
> out all the values.  Userspace will most likely override it
> anyway if it want to present a specific topology to the guest.
> 
> This patch essentially reverts commit 382409b4c43e ("kvm: x86: Include
> CPUID leaf 0x8000001e in kvm's supported CPUID").

Why not do a full revert?

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/cpuid.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index a0292ba650df..380b71600a9e 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1193,6 +1193,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		entry->ebx = entry->ecx = entry->edx = 0;
>  		break;
>  	case 0x8000001e:
> +		/* Different on each processor, just hide it.  */
> +		entry->eax = entry->ebx = entry->ecx = 0;
> +		entry->edx = 0;

Putting EDX in a separate line is rather weird.
