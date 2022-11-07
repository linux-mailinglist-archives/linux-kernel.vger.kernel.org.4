Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672F361FADD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiKGRKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiKGRKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:10:45 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C21614D1A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:10:43 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i3so11202742pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 09:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K4HC8IE6jCwskNYnMV1hbDXS3AUmFilIIiWC+9UcFrY=;
        b=jIYjSje09muKhWSTGCEO/eKjq9IYibWQ0V0mGEu6NLV+Whi5C7o4KfOYHqPuBfOPEP
         rFNnElWYIvGVW+N/NydSuVDcj/IbK7mvTsvj5D70F1Q16xzja7qCpTKSx3kC7p0lIbKK
         S3c0SRrL3BMt6EkLRa2knimoaZGrxSOZLDJX4Dd8QCZXhkLz8rZE2Ztbj3CEx1RjCstp
         t9ucLB/cGq4ln3Wojb7Y08vOc5ePOgw5WTVcXwOh75d75HbFU+qIXHn/A+mVg/AJXjXq
         iGDeCbCy79/s3xlC0lvjjSSim9rGcvG61LSjIcx8GVGCxpGR/S1yQGwFgI0IeDeuow2K
         sMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4HC8IE6jCwskNYnMV1hbDXS3AUmFilIIiWC+9UcFrY=;
        b=W22PK99THw8UuEzPNXfDJTBx94ER9JKSYYhm1803T82M8WtXGRRGFeC2opJR7blezA
         oVBF3k3++k94jyA/mA6zDR6ACthwS7qBkAMP9CDzeoNgs70VSheq7EqP5tkdoGYq1sz4
         2av8nDE6c0i1w6iwXHGoV6KJ4CxhMbdn3h5fYJFQcG4ISZS6MPWk7iWutm54KP78ocwI
         squFfm70j2JAdd5hDnsgAc2iqpdLniZHRbUQu5teSpo7feO7c0gvBY4BgQKSIkgDoKva
         fsDgrH/DYjuy9UlOAUchTPxWL2DyN3ix7aYiwOZYN4fAQ4sg8RfT8hfpdVjwG2rdpYfh
         XUVA==
X-Gm-Message-State: ACrzQf2niZxY8H9yMcaH/7jMKEGmF4iKBbfG4elOaRyvq3itw+FUlzH0
        X2lROKw71s5yKrzul7rDX7OrEs6CQ7RfIg==
X-Google-Smtp-Source: AMsMyM7s9suVr6kb8IGijaNRtSzSXXCYGzI6gg8QBO2C8G17IikSjLTXJ5q2vYek0zJWHU6FLHvUUQ==
X-Received: by 2002:a63:de4b:0:b0:470:4222:c3f4 with SMTP id y11-20020a63de4b000000b004704222c3f4mr14250283pgi.291.1667841042576;
        Mon, 07 Nov 2022 09:10:42 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id j17-20020a170902da9100b001811a197797sm5240709plx.194.2022.11.07.09.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:10:42 -0800 (PST)
Date:   Mon, 7 Nov 2022 17:10:38 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        nathan@kernel.org, thomas.lendacky@amd.com,
        andrew.cooper3@citrix.com, peterz@infradead.org,
        jmattson@google.com, stable@vger.kernel.org
Subject: Re: [PATCH 2/8] KVM: SVM: replace regs argument of __svm_vcpu_run
 with vcpu_svm
Message-ID: <Y2k8DilImFBVcZPG@google.com>
References: <20221107145436.276079-1-pbonzini@redhat.com>
 <20221107145436.276079-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107145436.276079-3-pbonzini@redhat.com>
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

On Mon, Nov 07, 2022, Paolo Bonzini wrote:
> diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
> index 723f8534986c..8fac744361e5 100644
> --- a/arch/x86/kvm/svm/vmenter.S
> +++ b/arch/x86/kvm/svm/vmenter.S

Needs to include asm/asm-offsets.h, otherwise the compiler may think that
SVM_vcpu_arch_regs is a symbol.

  ERROR: modpost: "SVM_vcpu_arch_regs" [arch/x86/kvm/kvm-amd.ko] undefined!

diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 8fac744361e5..8d0b0781462e 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/linkage.h>
 #include <asm/asm.h>
+#include <asm/asm-offsets.h>
 #include <asm/bitsperlong.h>
 #include <asm/kvm_vcpu_regs.h>
 #include <asm/nospec-branch.h>

> @@ -8,23 +8,23 @@
>  #define WORD_SIZE (BITS_PER_LONG / 8)
>  
>  /* Intentionally omit RAX as it's context switched by hardware */
> -#define VCPU_RCX	__VCPU_REGS_RCX * WORD_SIZE
> -#define VCPU_RDX	__VCPU_REGS_RDX * WORD_SIZE
> -#define VCPU_RBX	__VCPU_REGS_RBX * WORD_SIZE
> +#define VCPU_RCX	(SVM_vcpu_arch_regs + __VCPU_REGS_RCX * WORD_SIZE)
> +#define VCPU_RDX	(SVM_vcpu_arch_regs + __VCPU_REGS_RDX * WORD_SIZE)
> +#define VCPU_RBX	(SVM_vcpu_arch_regs + __VCPU_REGS_RBX * WORD_SIZE)
>  /* Intentionally omit RSP as it's context switched by hardware */
> -#define VCPU_RBP	__VCPU_REGS_RBP * WORD_SIZE
> -#define VCPU_RSI	__VCPU_REGS_RSI * WORD_SIZE
> -#define VCPU_RDI	__VCPU_REGS_RDI * WORD_SIZE
> +#define VCPU_RBP	(SVM_vcpu_arch_regs + __VCPU_REGS_RBP * WORD_SIZE)
> +#define VCPU_RSI	(SVM_vcpu_arch_regs + __VCPU_REGS_RSI * WORD_SIZE)
> +#define VCPU_RDI	(SVM_vcpu_arch_regs + __VCPU_REGS_RDI * WORD_SIZE)
>  
>  #ifdef CONFIG_X86_64
> -#define VCPU_R8		__VCPU_REGS_R8  * WORD_SIZE
> -#define VCPU_R9		__VCPU_REGS_R9  * WORD_SIZE
> -#define VCPU_R10	__VCPU_REGS_R10 * WORD_SIZE
> -#define VCPU_R11	__VCPU_REGS_R11 * WORD_SIZE
> -#define VCPU_R12	__VCPU_REGS_R12 * WORD_SIZE
> -#define VCPU_R13	__VCPU_REGS_R13 * WORD_SIZE
> -#define VCPU_R14	__VCPU_REGS_R14 * WORD_SIZE
> -#define VCPU_R15	__VCPU_REGS_R15 * WORD_SIZE
> +#define VCPU_R8		(SVM_vcpu_arch_regs + __VCPU_REGS_R8  * WORD_SIZE)
> +#define VCPU_R9		(SVM_vcpu_arch_regs + __VCPU_REGS_R9  * WORD_SIZE)
> +#define VCPU_R10	(SVM_vcpu_arch_regs + __VCPU_REGS_R10 * WORD_SIZE)
> +#define VCPU_R11	(SVM_vcpu_arch_regs + __VCPU_REGS_R11 * WORD_SIZE)
> +#define VCPU_R12	(SVM_vcpu_arch_regs + __VCPU_REGS_R12 * WORD_SIZE)
> +#define VCPU_R13	(SVM_vcpu_arch_regs + __VCPU_REGS_R13 * WORD_SIZE)
> +#define VCPU_R14	(SVM_vcpu_arch_regs + __VCPU_REGS_R14 * WORD_SIZE)
> +#define VCPU_R15	(SVM_vcpu_arch_regs + __VCPU_REGS_R15 * WORD_SIZE)
>  #endif
