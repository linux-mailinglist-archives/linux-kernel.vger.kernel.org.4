Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8C4604B09
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiJSPRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbiJSPRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:17:34 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259BC15F324
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:10:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f23so17545356plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2DixuWllqtEEhZE9JBfkpCOOYoYTM4QC00/Ubs5BToo=;
        b=qB4BoG68qOoT7hZPHxcqZYEg2fNwccwvH+/dO+OJVWxexqLR5iTgSozi/pX8RsH+6b
         ixr79O64VG2ucycVujOhqy1H+nkgdVFYjH5AMEgkZly4DmjCvb3Af1MPLyp8NOTWDM7/
         xxOQ3zVnrNIbh/VFW2TLRRQI2Hd3Pk6O6PKZC79vlD886B8hMY6cMspUVnl3TncH8qfp
         Bp50U2mscsn+B94lhD0cgzoN3gJ2XIhEwEJxXGqTtcEyWtbJ98C2OVsEWg8YA+8IBohw
         GJsxuhrSYsGtg9a3p/MtpNySvqLZr84SG+rMrfqe/GpCvQBjbHdCi4WyqrBEv6VyKHLs
         N7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DixuWllqtEEhZE9JBfkpCOOYoYTM4QC00/Ubs5BToo=;
        b=NVils0qURzpopZwZa8tD1gcRpbzWgVBnsknoLMsQ2JHJ+BRz/Kw+3mk0/PXTDVNiZ3
         CKLWzqSoWuU9gX2dyM7jdWpefrrn825y1M+LhyO/7o+wpC7S3M8yO5K51y+unSsqsV10
         LcxMJcJH7lmlBYyTrtPTXNrWZg/O/Rcb+Y+9BKUpq5gHvlD+/S2v2e8x37oWd7JTwBku
         637YIj249ID46r6MvFbQCJFpq4S8hi4YkfQZ/Hn6vtZkpG70AG0nSAjH7ToxERLQeHu0
         hbG4b/a8M1q4eCZhieKld1/Qq5WZTh6Igy6X2HMSA6z8s0agur9QLCi5R/9bBI2aJZYj
         K8dA==
X-Gm-Message-State: ACrzQf0j3L4tmz895VZDaCGtCUCiSrhIW5KJ8EWFvRaDEKME+ZlPcr1k
        aFjx/QvjcrvxMdSYQ3msv8pk5bYBlym6yg==
X-Google-Smtp-Source: AMsMyM4R0PY7qix/nuvdxWbd5kybx++ZPgEWv4AvW7PfszITQWd9Rad0fsqGrCGtC6Nbvf/b90qV0Q==
X-Received: by 2002:a17:903:1205:b0:178:ac4e:70b8 with SMTP id l5-20020a170903120500b00178ac4e70b8mr8719937plh.52.1666192172629;
        Wed, 19 Oct 2022 08:09:32 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902ff0100b0018099c9618esm10734227plj.231.2022.10.19.08.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 08:09:32 -0700 (PDT)
Date:   Wed, 19 Oct 2022 15:09:28 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jiaxi Chen <jiaxi.chen@linux.intel.com>, kvm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, pbonzini@redhat.com,
        ndesaulniers@google.com, alexandre.belloni@bootlin.com,
        peterz@infradead.org, jpoimboe@kernel.org,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        babu.moger@amd.com, jmattson@google.com, sandipan.das@amd.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        fenghua.yu@intel.com, keescook@chromium.org,
        jane.malalane@citrix.com, nathan@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] x86: KVM: Enable AVX-VNNI-INT8 CPUID and expose it
 to guest
Message-ID: <Y1ATKF2xjERFbspn@google.com>
References: <20221019084734.3590760-1-jiaxi.chen@linux.intel.com>
 <20221019084734.3590760-5-jiaxi.chen@linux.intel.com>
 <Y0+6tJ7MiZWbYK5l@zn.tnic>
 <Y1AQX3RfM+awULlE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1AQX3RfM+awULlE@google.com>
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

On Wed, Oct 19, 2022, Sean Christopherson wrote:
> On Wed, Oct 19, 2022, Borislav Petkov wrote:
> > On Wed, Oct 19, 2022 at 04:47:32PM +0800, Jiaxi Chen wrote:
> > > AVX-VNNI-INT8 is a new set of instructions in the latest Intel platform
> > > Sierra Forest. It multiplies the individual bytes of two unsigned or
> > > unsigned source operands, then add and accumulate the results into the
> > > destination dword element size operand. This instruction allows for the
> > > platform to have superior AI capabilities.
> > > 
> > > The bit definition:
> > > CPUID.(EAX=7,ECX=1):EDX[bit 4]
> >
> > For this particular one, use scattered.c instead of adding a new leaf.
> 
> Unless the kernel wants to use X86_FEATURE_AVX_VNNI_INT8, which seems unlikely,
> there's no need to create a scattered entry.  This can be handled in KVM by adding
> a KVM-only leaf entry (which will be needed no matter what), plus a #define for
> X86_FEATURE_AVX_VNNI_INT8 to direct it to the KVM entry.
> 
> E.g. 
> 
> diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
> index a19d473d0184..25e7bfc61607 100644
> --- a/arch/x86/kvm/reverse_cpuid.h
> +++ b/arch/x86/kvm/reverse_cpuid.h
> @@ -13,6 +13,7 @@
>   */
>  enum kvm_only_cpuid_leafs {
>         CPUID_12_EAX     = NCAPINTS,
> +       CPUID_7_1_EDX,
>         NR_KVM_CPU_CAPS,
>  
>         NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
> @@ -24,6 +25,16 @@ enum kvm_only_cpuid_leafs {
>  #define KVM_X86_FEATURE_SGX1           KVM_X86_FEATURE(CPUID_12_EAX, 0)
>  #define KVM_X86_FEATURE_SGX2           KVM_X86_FEATURE(CPUID_12_EAX, 1)
>  
> +#define KVM_X86_FEATURE_AVX_VNNI_INT8  KVM_X86_FEATURE(CPUID_7_1_EDX, 4)
> +
> +/*
> + * Alias X86_FEATURE_* to the KVM variant for features in KVM-only leafs that
> + * aren't scattered by cpufeatures.h so that X86_FEATURE_* can be used in KVM,
> + * e.g. to query guest CPUID.  As a bonus, no translation is needed for these
> + * features in __feature_translate().
> + */
> +#define X86_FEATURE_AVX_VNNI_INT8      KVM_X86_FEATURE_AVX_VNNI_INT8

Actually, there's no need for KVM_X86_FEATURE_AVX_VNNI_INT8 in this case, just
#define X86_FEATURE_AVX_VNNI_INT8 directly.  The KVM_ prefixed macro exists purely
to redirect the non-KVM_ version, but that's unnecessary in this case.

diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index a19d473d0184..38adafb03490 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -13,6 +13,7 @@
  */
 enum kvm_only_cpuid_leafs {
        CPUID_12_EAX     = NCAPINTS,
+       CPUID_7_1_EDX,
        NR_KVM_CPU_CAPS,
 
        NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
@@ -24,6 +25,13 @@ enum kvm_only_cpuid_leafs {
 #define KVM_X86_FEATURE_SGX1           KVM_X86_FEATURE(CPUID_12_EAX, 0)
 #define KVM_X86_FEATURE_SGX2           KVM_X86_FEATURE(CPUID_12_EAX, 1)
 
+/*
+ * Omit the KVM_ prefix for features in KVM-only leafs that aren't scattered by
+ * cpufeatures.h so that X86_FEATURE_* can be used in KVM,* e.g. to query guest
+ * CPUID.  As a bonus, no handling in __feature_translate() is needed.
+ */
+#define X86_FEATURE_AVX_VNNI_INT8      KVM_X86_FEATURE(CPUID_7_1_EDX, 4)
+
 struct cpuid_reg {
        u32 function;
        u32 index;
@@ -48,6 +56,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
        [CPUID_7_1_EAX]       = {         7, 1, CPUID_EAX},
        [CPUID_12_EAX]        = {0x00000012, 0, CPUID_EAX},
        [CPUID_8000_001F_EAX] = {0x8000001f, 0, CPUID_EAX},
+       [CPUID_7_1_EDX]       = {         7, 1, CPUID_EDX},
 };
