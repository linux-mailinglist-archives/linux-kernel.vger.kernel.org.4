Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167467226BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjFENBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjFENBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:01:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8607DA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685970038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6aGjYzdJUv3mCKaWHOXQQVhBXGYUPAjudrmb3GbAYcs=;
        b=h9eUdP+sRAY7iqIILqaydT51jdfQxxpnu4GoJxVZfFWNJTXGdExssZYF+ez8bB2fXGKBmz
        auSRvnMydrBs4xLfe4RJ0CM7gJSXJyeRs+mbbGSInlY8tZibIazJwHvQ5rK/a2P1xlH734
        ufBLW+FJ7V8sgK7ffRepkBppT+rHLPQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-nIEksND5NJiXTAcmkDIVXA-1; Mon, 05 Jun 2023 09:00:36 -0400
X-MC-Unique: nIEksND5NJiXTAcmkDIVXA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f772115352so5113015e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 06:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685970035; x=1688562035;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6aGjYzdJUv3mCKaWHOXQQVhBXGYUPAjudrmb3GbAYcs=;
        b=ZmKNzuGf5VV95/WRZO8Op/ZouNOAxphiFx0VyxG4IyGRThef7czh0Tzfcs0Hzzts+x
         tYhmYdJH/SmAHJSMyhr5xCD3+hWWvfXuuvxeB0Dp60s0QwhDh9ZGnF1Qpwwg4/wLUd+S
         sAQu+vdZ2g0qJ22JiK5ux5ze5ZfVtL7t3ZY2e7V/2vkQ5e8OX8vvO3+lnMdjnccLyPqX
         sP7l1gWGd2mCwdWshVZ8K1Rf8OI3tIjowl78us+zeq+W2Y/BeQ52jQLg057USCS6YJr7
         rtLH8GsO22T/CBH60ht3dSnOk/0UWjLq0aOXozwYTDdERes5K4c2Lzgax4aMuRdEWI/K
         tLFQ==
X-Gm-Message-State: AC+VfDxrX9iSrKbEhCvZi79NbK6Ct+X2nOMY6XJ6D6ae6g1CaKFMbS97
        DjEX5Kl8j5WESHXDdMvRvfBxjKQjq2mHQc1BqvcJJhEELpnY33rQxMR48y+e7xM4K2XbhTOq4e7
        vZmmr/M95hf2qOibZPrX5EgTkGChALkDgUhQzVtbBr4sEuFJICikMfV0ZD71LIshO0FmNN/rysM
        tCgh7rzfEd
X-Received: by 2002:a05:600c:1d98:b0:3f7:367a:38cb with SMTP id p24-20020a05600c1d9800b003f7367a38cbmr3872785wms.2.1685970035436;
        Mon, 05 Jun 2023 06:00:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7BYasbXF+HwlwoTO7ru5Jn/GlxOkdZNhWdPXcR60/ODZuYlz9paQmxJ0VSP+eJVhTa5e/f5Q==
X-Received: by 2002:a05:600c:1d98:b0:3f7:367a:38cb with SMTP id p24-20020a05600c1d9800b003f7367a38cbmr3872737wms.2.1685970035044;
        Mon, 05 Jun 2023 06:00:35 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id w11-20020a1cf60b000000b003f423f5b659sm10737802wmc.10.2023.06.05.06.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 06:00:34 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] x86/hyperv: Use vmmcall to implement Hyper-V
 hypercall in sev-snp enlightened guest
In-Reply-To: <20230601151624.1757616-6-ltykernel@gmail.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-6-ltykernel@gmail.com>
Date:   Mon, 05 Jun 2023 15:00:33 +0200
Message-ID: <87wn0ijc7i.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianyu Lan <ltykernel@gmail.com> writes:

> From: Tianyu Lan <tiala@microsoft.com>
>
> In sev-snp enlightened guest, Hyper-V hypercall needs
> to use vmmcall to trigger vmexit and notify hypervisor
> to handle hypercall request.
>
> There is no x86 SEV SNP feature flag support so far and
> hardware provides MSR_AMD64_SEV register to check SEV-SNP
> capability with MSR_AMD64_SEV_ENABLED bit. ALTERNATIVE can't
> work without SEV-SNP x86 feature flag. May add later when
> the associated flag is introduced. 
>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/include/asm/mshyperv.h | 44 ++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 31c476f4e656..d859d7c5f5e8 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -61,16 +61,25 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  	u64 hv_status;
>  
>  #ifdef CONFIG_X86_64
> -	if (!hv_hypercall_pg)
> -		return U64_MAX;
> +	if (hv_isolation_type_en_snp()) {

Would it be possible to redo 'hv_isolation_type_en_snp()' into a static
inline doing static_branch_unlikely() so we avoid function call penalty
here?

> +		__asm__ __volatile__("mov %4, %%r8\n"
> +				     "vmmcall"
> +				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> +				       "+c" (control), "+d" (input_address)
> +				     :  "r" (output_address)
> +				     : "cc", "memory", "r8", "r9", "r10", "r11");
> +	} else {
> +		if (!hv_hypercall_pg)
> +			return U64_MAX;
>  
> -	__asm__ __volatile__("mov %4, %%r8\n"
> -			     CALL_NOSPEC
> -			     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> -			       "+c" (control), "+d" (input_address)
> -			     :  "r" (output_address),
> -				THUNK_TARGET(hv_hypercall_pg)
> -			     : "cc", "memory", "r8", "r9", "r10", "r11");
> +		__asm__ __volatile__("mov %4, %%r8\n"
> +				     CALL_NOSPEC
> +				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> +				       "+c" (control), "+d" (input_address)
> +				     :  "r" (output_address),
> +					THUNK_TARGET(hv_hypercall_pg)
> +				     : "cc", "memory", "r8", "r9", "r10", "r11");
> +	}
>  #else
>  	u32 input_address_hi = upper_32_bits(input_address);
>  	u32 input_address_lo = lower_32_bits(input_address);
> @@ -104,7 +113,13 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
>  	u64 hv_status;
>  
>  #ifdef CONFIG_X86_64
> -	{
> +	if (hv_isolation_type_en_snp()) {
> +		__asm__ __volatile__(
> +				"vmmcall"
> +				: "=a" (hv_status), ASM_CALL_CONSTRAINT,
> +				"+c" (control), "+d" (input1)
> +				:: "cc", "r8", "r9", "r10", "r11");
> +	} else {
>  		__asm__ __volatile__(CALL_NOSPEC
>  				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
>  				       "+c" (control), "+d" (input1)
> @@ -149,7 +164,14 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
>  	u64 hv_status;
>  
>  #ifdef CONFIG_X86_64
> -	{
> +	if (hv_isolation_type_en_snp()) {
> +		__asm__ __volatile__("mov %4, %%r8\n"
> +				     "vmmcall"
> +				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> +				       "+c" (control), "+d" (input1)
> +				     : "r" (input2)
> +				     : "cc", "r8", "r9", "r10", "r11");
> +	} else {
>  		__asm__ __volatile__("mov %4, %%r8\n"
>  				     CALL_NOSPEC
>  				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,

-- 
Vitaly

