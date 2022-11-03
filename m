Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E78E617DE5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiKCN1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiKCN1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:27:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C285FCB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667481995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cuPtpUWRIBBX5sUQfRc1MFba94GA2Vpd0z/+sy98D5k=;
        b=EA3iYGCT1UBGgdBq2pngjOIiZNDiDfuOwmQswrsfoD6ZzQgW/btXN0MPLhtohchCbEOJTb
        OL17JFmAsHpNoPzYVtPyCTZvu1l4uSNTtw4h2YrprCfurr+w8yuHoEsPDjgiGQ99CbvQkC
        y8HbKJhiLoTTodnisdbSjCvOS2LV728=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-101-2uI2nCybMtisLfkiKah2dg-1; Thu, 03 Nov 2022 09:26:33 -0400
X-MC-Unique: 2uI2nCybMtisLfkiKah2dg-1
Received: by mail-ej1-f71.google.com with SMTP id qa14-20020a170907868e00b007ae24f77742so408743ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cuPtpUWRIBBX5sUQfRc1MFba94GA2Vpd0z/+sy98D5k=;
        b=Df2q3QVi8+kgrGMf31/PfwpVLsny/l+Y6voElBt7Wd4oqXXNFLfZAWrbLZks+6XLsV
         LR/aoVXYIVyiGsMPi0iiVtS+h2gQAuuCP6JHTdhBRduQ/Php6rIqqOJ/LlsT9zYvegzd
         gMTKU4DID/lav4SBgyCqdsTLAyPHHT1NxZ9sMBZ7OVsM329FL6M2NIXQrfobYVuvDX/J
         JQ9ape2WfF4M/bOwVi5kBxIBY0Ija8oTeZoGDYIUGv/JEv6RHChYtNsF6GYfXIby4vm6
         kaIr6tK6gnJ8UIOK7N7zfsH6diAmOvc+qpLIGZ/BuE0N7Nr/crxm9NvpIN2+CjlYaXs1
         hxsg==
X-Gm-Message-State: ACrzQf2ZToJAubxBh1TfUmQXcZv3ih7FGaLTekk2+dp837DHI9krq/Do
        Wq9fwMrF/8iqrXc4HY5sYRPLNnTwEB0yNvz5bNWcXNQYFV0gpoLI8qvjZZh8ebYRNHAjEYyq3eO
        8Tp4Y64nEBxVdTmjiqSw95gV9
X-Received: by 2002:a50:c302:0:b0:463:26d6:25fb with SMTP id a2-20020a50c302000000b0046326d625fbmr25725019edb.204.1667481992042;
        Thu, 03 Nov 2022 06:26:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7JxVpynVEuwDtNmx56dfxLJ+jvldPq9eu49Pvjr5E1N9lkwwPwDD30FVj7JUT6f3BxyYUKQA==
X-Received: by 2002:a50:c302:0:b0:463:26d6:25fb with SMTP id a2-20020a50c302000000b0046326d625fbmr25724972edb.204.1667481991766;
        Thu, 03 Nov 2022 06:26:31 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id p25-20020a056402501900b0046191f5e946sm530591eda.21.2022.11.03.06.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 06:26:31 -0700 (PDT)
Message-ID: <ad56eb5a-a999-52b4-4c5d-4ff4b124b0a0@redhat.com>
Date:   Thu, 3 Nov 2022 14:26:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/5] perf/x86/intel/lbr: use setup_clear_cpu_cap
 instead of clear_cpu_cap
Content-Language: en-US
To:     "H. Peter Anvin" <hpa@zytor.com>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jane Malalane <jane.malalane@citrix.com>,
        Kees Cook <keescook@chromium.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>
References: <20220718141123.136106-1-mlevitsk@redhat.com>
 <20220718141123.136106-2-mlevitsk@redhat.com> <Yyh9RDbaRqUR1XSW@zn.tnic>
 <c105971a72dfe6d46ad75fb7e71f79ba716e081c.camel@redhat.com>
 <YzGlQBkCSJxY+8Jf@zn.tnic>
 <c1168e8bd9077a2cc9ef61ee06db7a4e8c0f1600.camel@redhat.com>
 <Y1EOBAaLbv2CXBDL@zn.tnic> <fd2cf028-bd83-57ff-7e6d-ef3ee11852a1@redhat.com>
 <MW5PR84MB18428331677C881764E615D2AB399@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <EFDA4E40-4133-4CED-97FA-DC75AEA24556@zytor.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <EFDA4E40-4133-4CED-97FA-DC75AEA24556@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/22 17:23, H. Peter Anvin wrote:
> We have a dependency system for CPUID features. If you are going to
> do this (as opposed to "fixing" this in Qemu or just saying "don't do
> that, it isn't a valid hardware configuration."

I didn't check Robert's full list, but at least in the case of 
aesni-intel_glue this is not about AVX2-depends-on-AVX or 
AVX-depends-on-XSAVE (and it is not about QEMU at all).  It's just that 
checking AVX or AVX2 only tells you about presence and is not enough to 
say whether the instructions are _usable_.  Likewise for AVX512.

What would the dependency be?

Paolo

> 
> 
> 1. Currently checking XSAVE YMM:
>  aria_aesni_avx_glue
>  blake2s-glue
>  camellia_aesni_avx2_glue	camellia_aesni_avx_glue
>  cast5_avx_glue		cast6_avx_glue
>  chacha_glue
>  poly1305_glue
>  serpent_avx2_glue		serpent_avx_glue
>  sha1_ssse3_glue		sha256_ssse3_glue	sha512_ssse3_glue
>  sm3_avx_glue
>  sm4_aesni_avx2_glue	sm4_aesni_avx_glue
>  twofish_avx_glue
> 
> Currently not checking XSAVE YMM:
>  aesni-intel_glue
>  curve25519-x86_64
>  nhpoly1305-avx2-glue
>  polyval-clmulni_glue
> 
> 2. Similarly, modules using X86_FEATURE_AVX512F, X86_FEATURE_AVXX512VL
> and/or X86_FEATURE_AVX512BW probably need to check XFEATURE_MASK_AVX512:
> 
> Currently checking XSAVE AVX512:
>  blake2s-glue
>  poly1305_glue
> 
> Currently not checking XSAVE AVX512:
>  chacha_glue
> 
> 3. Similarly, modules using X86_FEATURE_XMM2 probably need to
> check XFEATURE_MASK_SSE:
> 
> Currently checking XSAVE SSE:
>  aegis128-aesni-glue 
> 
> Current not checking XSAVE SSE:
>  nhpoly1305-sse2_glue
>  serpent_sse2_glue
> 

