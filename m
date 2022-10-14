Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9AB5FF428
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiJNTjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiJNTjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:39:05 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959E71D3A4C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 12:39:03 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o21so3259896ple.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 12:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RKH2hZmlrtGelcAWDklfuk9AgunUYQvq2tq9R0N/2SQ=;
        b=J6Pw7Qlvrl+GLJBq7xnCi2LEx4Oc/8/7zJpUWLxNyodGxDehX5K1O3AaUm2u3yokYw
         yu4qgzVOw2yia0Ay6K81PP/BKaHTCL4yVW8TPghYtL0dQmxqn/PvGl26AbYmLuWZQf+z
         8RBDNs7xO5bQPQGJhS5QCwT6sz14v+kT1xQw50dTomuCyJtKkoLvXiyIIE7NbRb9uksd
         dsZE0Gh1NhJBT9nLx/XegdtryiQrY2O1DyOEsyyYtYHgkcUP3Jb+Uk0+BFEqS+3yRsW9
         kSweAgv8M8ihxHlAM0AFNHZG7iv+bLpvgSU9ivJBbLnZj0tdj5oOPJ0DOFLIGWmQqC81
         qRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKH2hZmlrtGelcAWDklfuk9AgunUYQvq2tq9R0N/2SQ=;
        b=wzpX5p1wXbYezQe+XeNUiYdf8XcL5oDchiS23RkrK/eTqmvj2FIORksBigxvhW1sXz
         aLEl8LLzRpJhvi6yNcLvvXlpDEg2L+TuEUwah4rnQ4xhfRhTKUTME3yGTyZgcH5mF+L/
         cCJ8M9IzuKAKOsfKYOhUFL0h53aegHkoKeJi7EzCf0wHdsHAVJjj2hC72G4Kduz/KYEF
         qiaz9OagYYbqrQ20T+5+GNqEyu1cYLvwd0nl+4DZ+Vj+Gn1f1HQ6lOQe/9bm5y7oX9D2
         S84qA0e0j84fgh7H5/huExdYDe7WxfaG6MqZFCA8kCvrBHaISogKvpX7wvAY0Nlrfb10
         JLwA==
X-Gm-Message-State: ACrzQf2IPsa3ls5wkK2di8TA3OMbL4/eUvslMPreGYBiHowLuXDLm8Hw
        WN8vVvb82NT0TtLPl3mNI6MLiA==
X-Google-Smtp-Source: AMsMyM50IQWqmBBHPE2W2XgYj3Bblk1PmdlFM+JYyyDLQy5mB0lA5sgH6nttvTkgxGh0i8XPIH8qUw==
X-Received: by 2002:a17:90b:1b08:b0:20d:7bbf:4701 with SMTP id nu8-20020a17090b1b0800b0020d7bbf4701mr19152349pjb.87.1665776342962;
        Fri, 14 Oct 2022 12:39:02 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902a3c300b001784a45511asm2093816plb.79.2022.10.14.12.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 12:39:02 -0700 (PDT)
Date:   Fri, 14 Oct 2022 19:38:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        maciej.szmigiero@oracle.com
Subject: Re: [PATCH v2 1/8] KVM: x86: start moving SMM-related functions to
 new files
Message-ID: <Y0m60gnBZLSe6F2N@google.com>
References: <20220929172016.319443-1-pbonzini@redhat.com>
 <20220929172016.319443-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929172016.319443-2-pbonzini@redhat.com>
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

On Thu, Sep 29, 2022, Paolo Bonzini wrote:
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index a5ac4a5a5179..cb7e68c93e1a 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -7,7 +7,6 @@
>  #include <linux/kvm_host.h>
>  
>  #include "hyperv.h"
> -#include "kvm_cache_regs.h"
>  
>  #define KVM_APIC_INIT		0
>  #define KVM_APIC_SIPI		1
> @@ -229,11 +228,7 @@ static inline bool kvm_apic_has_pending_init_or_sipi(struct kvm_vcpu *vcpu)
>  	return lapic_in_kernel(vcpu) && vcpu->arch.apic->pending_events;
>  }
>  
> -static inline bool kvm_apic_init_sipi_allowed(struct kvm_vcpu *vcpu)
> -{
> -	return !is_smm(vcpu) &&
> -	       !static_call(kvm_x86_apic_init_signal_blocked)(vcpu);
> -}
> +bool kvm_apic_init_sipi_allowed(struct kvm_vcpu *vcpu);

I don't see any reason to force this to go in lapic.c, just include smm.h in
lapic.h, it's not an unreasonable dependency.  That way this ends up being a
direct call when SMM is compiled out.

> diff --git a/arch/x86/kvm/smm.h b/arch/x86/kvm/smm.h
> new file mode 100644
> index 000000000000..d85d4ccd32dd
> --- /dev/null
> +++ b/arch/x86/kvm/smm.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef ASM_KVM_SMM_H
> +#define ASM_KVM_SMM_H

#include <linux/kvm_host.h>

For HF_SMM_MASK, KVM_REQ_SMI, struct kvm_vcpu, etc...  Relying on the caller to
include that might bite someone in the futrure.
