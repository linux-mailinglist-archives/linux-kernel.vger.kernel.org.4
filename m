Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009D65E54BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiIUUvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIUUvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:51:07 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33D79F743
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:51:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c24so6872315plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 13:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=EpFVglis/hXur8vqCFv/kcVmjP57HwC3X+RG3Se8aB0=;
        b=LaJWe/boRhue4Y6QklLItBbLYLFPSnqap8c+FiuCAxzA7PttnG+4/3rx9O9jrOIZdm
         z4gh92TH2x1TKT2WuZlLmvNio4bkM4YSKBoQl4WKS51J1lpPB5Wkxjl+8hkqNI7J8cL/
         yhf1MibgLchwej915W7FoJPdJ15Ta6uT/rLs5gSf1q4W+hCMeMvPWxUuks2razJd20jV
         0mnYz4Td/y7SX69rZbNUjkhkKw5V6w6A9QILgk7CCqU7cGuVRAgKU6frb/XbHKY/A6+Q
         +Oo6Xnr5Kue7rDp/AMLz2Mg7toq24INuL2ieFzaAOvHPVFaCvtnhVI76OiqV+RG4guvk
         OKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=EpFVglis/hXur8vqCFv/kcVmjP57HwC3X+RG3Se8aB0=;
        b=TM8Ss7RX0t/uUJicv4vVYLPx2R8NZbxE3vE/veJ1jq8XHgSVYxPvQ5sdwD8ps/erCg
         gtI+QnpT02nkZpM4hbQmD7Ww+ICBN6MayGc0SNO7W7ZqM87W8ElrlFoHT3nORheGJCCW
         UT3phKoIIWXCUYtQ5DksE8itKYG6U84ZX4sR28DahbHr4poiUhltcgscdBbCisFM6LNL
         sPoiD1BpJ/ENX0GoXKkdfJSHkFJ0VXWw/deXAw77tqScugSH1F02hJZkRKRce9fssXH4
         DkWkM7jxYc+5qxl+2RwZ7PXwgychUerYue2NMKIVk34xxGi7/a4WWgmQCgTjB9QQboD1
         NX0Q==
X-Gm-Message-State: ACrzQf32WCqg8MCKMXs5P0w5E2N7i/kkZKuucERF0wubd374NO7K1ckI
        ET6CXW+bhVqe1Vimr3TkFQh8kA==
X-Google-Smtp-Source: AMsMyM5u+8ZqtRUMwpOPW2zQtWT/VHgLH9DbNZ57Xkt0W8p0Cg6tdgOsf6/nwKjEsZH/Zkujq3oLMw==
X-Received: by 2002:a17:902:d484:b0:178:1b69:1488 with SMTP id c4-20020a170902d48400b001781b691488mr44695plg.156.1663793461187;
        Wed, 21 Sep 2022 13:51:01 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b001fba4716f11sm2464843pjb.22.2022.09.21.13.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 13:51:00 -0700 (PDT)
Date:   Wed, 21 Sep 2022 13:50:56 -0700
From:   David Matlack <dmatlack@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, seanjc@google.com,
        oupton@google.com, peterx@redhat.com, vkuznets@redhat.com
Subject: Re: [V2 PATCH 2/8] KVM: selftests: Add arch specific initialization
Message-ID: <Yyt5MHc1bwPfvBq/@google.com>
References: <20220915000448.1674802-1-vannapurve@google.com>
 <20220915000448.1674802-3-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915000448.1674802-3-vannapurve@google.com>
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

On Thu, Sep 15, 2022 at 12:04:42AM +0000, Vishal Annapurve wrote:
> Introduce arch specific API: kvm_selftest_arch_init to allow each arch to
> handle initialization before running any selftest logic.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  .../selftests/kvm/include/kvm_util_base.h      |  5 +++++
>  .../selftests/kvm/lib/aarch64/processor.c      | 18 +++++++++---------
>  tools/testing/selftests/kvm/lib/kvm_util.c     |  2 ++
>  .../selftests/kvm/lib/riscv/processor.c        |  4 ++++
>  .../selftests/kvm/lib/s390x/processor.c        |  4 ++++
>  .../selftests/kvm/lib/x86_64/processor.c       |  4 ++++
>  6 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index 24fde97f6121..98edbbda9f97 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -834,4 +834,9 @@ static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
>  	return __vm_enable_cap(vm, KVM_CAP_VM_DISABLE_NX_HUGE_PAGES, 0);
>  }
>  
> +/*
> + * API to execute architecture specific setup before executing selftest logic.

nit: s/before executing selftest logic/before main()/

("selftest logic" is vague)

> + */
> +void kvm_selftest_arch_init(void);
> +
>  #endif /* SELFTEST_KVM_UTIL_BASE_H */
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> index 6f5551368944..2281d6c5d02f 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> @@ -495,15 +495,6 @@ void aarch64_get_supported_page_sizes(uint32_t ipa,
>  	close(kvm_fd);
>  }
>  
> -/*
> - * arm64 doesn't have a true default mode, so start by computing the
> - * available IPA space and page sizes early.
> - */
> -void __attribute__((constructor)) init_guest_modes(void)
> -{
> -       guest_modes_append_default();
> -}
> -
>  void smccc_hvc(uint32_t function_id, uint64_t arg0, uint64_t arg1,
>  	       uint64_t arg2, uint64_t arg3, uint64_t arg4, uint64_t arg5,
>  	       uint64_t arg6, struct arm_smccc_res *res)
> @@ -528,3 +519,12 @@ void smccc_hvc(uint32_t function_id, uint64_t arg0, uint64_t arg1,
>  		       [arg4] "r"(arg4), [arg5] "r"(arg5), [arg6] "r"(arg6)
>  		     : "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7");
>  }
> +
> +/*
> + * arm64 doesn't have a true default mode, so start by computing the
> + * available IPA space and page sizes early.
> + */
> +void kvm_selftest_arch_init(void)
> +{
> +	guest_modes_append_default();
> +}
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 3c83838999f5..dafe4471a6c7 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1984,4 +1984,6 @@ void __attribute((constructor)) kvm_selftest_init(void)
>  {
>  	/* Tell stdout not to buffer its content. */
>  	setbuf(stdout, NULL);
> +
> +	kvm_selftest_arch_init();
>  }

Suggest defining a default no-op implementation of
kvm_selftest_arch_init() using __weak since most architectures do not
actually need an implementation.

> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
> index 604478151212..26660dd2ba78 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -362,3 +362,7 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
>  void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
>  {
>  }
> +
> +void kvm_selftest_arch_init(void)
> +{
> +}
> diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
> index 89d7340d9cbd..8654ec74009a 100644
> --- a/tools/testing/selftests/kvm/lib/s390x/processor.c
> +++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
> @@ -218,3 +218,7 @@ void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, uint8_t indent)
>  void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
>  {
>  }
> +
> +void kvm_selftest_arch_init(void)
> +{
> +}
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 2e6e61bbe81b..20bf125f9363 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -1311,3 +1311,7 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
>  
>  	return val == 'Y';
>  }
> +
> +void kvm_selftest_arch_init(void)
> +{
> +}
> -- 
> 2.37.2.789.g6183377224-goog
> 
