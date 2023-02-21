Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8831969DC53
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjBUInV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjBUInJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:43:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D1723D81
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676968940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TLJIC/RrvVE7PdqmcHdwOf29lNkhzpC8wWHN3DTeCNY=;
        b=Wz1uOJ/d+VJus6ZBFOpTXsSdcn5zFazF//uj7DOYbvk0tUaFSACEkKECpSde44VrNrT/Ce
        bbw4rHUV+aY3ItIm2NGHhZEO08ip3Ij1KS20UZIAZbrEnlf59LTWqS2cv0X2r2Y8FebW1o
        TJuQvxuRnlyKKCfMnBtC3Em1NQ9/c9k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-355-cHYO949pPUizsscreUp61Q-1; Tue, 21 Feb 2023 03:42:18 -0500
X-MC-Unique: cHYO949pPUizsscreUp61Q-1
Received: by mail-wr1-f72.google.com with SMTP id 1-20020a056000154100b002c54d9b8312so636929wry.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLJIC/RrvVE7PdqmcHdwOf29lNkhzpC8wWHN3DTeCNY=;
        b=4/XAUXnmObh26/eN0IsuT4gQX1C+p+li8G3MCt09kktqUPyNlQsVI0+xks/mBYmYF0
         n6LpLX5DTvQQpmNBDX1wrXCa51PoYtvnKQSjZDs3pgP5t/tSgmfpTwxT4XkzDexil/8f
         27ONFyial8YpabXng6iN8J9aPFepdfPs/HzNkIjJSp2Oa6vVM5E2OfdUSH2Og14n7rTH
         re+xM3T4WZQweTvXyLQFsyuOBJHnN/+PFlW3ZzZo8AA/RoFw3bxcKAw+P/1xIaZxE0iN
         JV+XGRdWxfQS4Zro9Dae7xS2Wo2VIiJSoQf2OQ83jJoR6WkI7qv211NKuoPmT1V44v6P
         IXsw==
X-Gm-Message-State: AO0yUKUpq5Lqb0MQFPhD8lu+mQuRNpKiw4h6dNAYtvCa+0rAfD2Hw1NB
        bEN1HfK4b418Tw6isNcLZHeJ7JH60ALhqj16paXvxIOvt5zN57gp3Kl2N+WadpxsL7znvpMxoCj
        lGVTTKL9QwfcgX90S4YX99Nm4l6PYCQ==
X-Received: by 2002:a5d:5308:0:b0:2c5:6025:cd65 with SMTP id e8-20020a5d5308000000b002c56025cd65mr2218699wrv.9.1676968937538;
        Tue, 21 Feb 2023 00:42:17 -0800 (PST)
X-Google-Smtp-Source: AK7set8HYdakBP7NNr75W24EBS8ylbUTvbqe5cKGc3PV4r6NUAF4mQpJtQCSggSEkz/UdpiRyLcPVw==
X-Received: by 2002:a5d:5308:0:b0:2c5:6025:cd65 with SMTP id e8-20020a5d5308000000b002c56025cd65mr2218684wrv.9.1676968937186;
        Tue, 21 Feb 2023 00:42:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:4800:aecc:dadb:40a8:ce81? (p200300cbc7074800aeccdadb40a8ce81.dip0.t-ipconnect.de. [2003:cb:c707:4800:aecc:dadb:40a8:ce81])
        by smtp.gmail.com with ESMTPSA id c24-20020a7bc858000000b003e11ad0750csm1147194wml.47.2023.02.21.00.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 00:42:12 -0800 (PST)
Message-ID: <8b8ffa43-9003-010d-30ea-c5de128d646d@redhat.com>
Date:   Tue, 21 Feb 2023 09:42:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v6 24/41] mm: Don't allow write GUPs to shadow stack
 memory
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        debug@rivosinc.com
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-25-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230218211433.26859-25-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.02.23 22:14, Rick Edgecombe wrote:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> Shadow stack memory is writable only in very specific, controlled ways.
> However, since it is writable, the kernel treats it as such. As a result
> there remain many ways for userspace to trigger the kernel to write to
> shadow stack's via get_user_pages(, FOLL_WRITE) operations. To make this a
> little less exposed, block writable GUPs for shadow stack VMAs.
> 
> Still allow FOLL_FORCE to write through shadow stack protections, as it
> does for read-only protections.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> ---
> v3:
>   - Add comment in __pte_access_permitted() (Dave)
>   - Remove unneeded shadow stack specific check in
>     __pte_access_permitted() (Jann)
> ---
>   arch/x86/include/asm/pgtable.h | 5 +++++
>   mm/gup.c                       | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 6b7106457bfb..20d0df494269 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1641,6 +1641,11 @@ static inline bool __pte_access_permitted(unsigned long pteval, bool write)
>   {
>   	unsigned long need_pte_bits = _PAGE_PRESENT|_PAGE_USER;
>   
> +	/*
> +	 * Write=0,Dirty=1 PTEs are shadow stack, which the kernel
> +	 * shouldn't generally allow access to, but since they
> +	 * are already Write=0, the below logic covers both cases.
> +	 */
>   	if (write)
>   		need_pte_bits |= _PAGE_RW;

So, GUP fast will always fail when writing ...

>   
> diff --git a/mm/gup.c b/mm/gup.c
> index f45a3a5be53a..bfd33d9edb89 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -982,7 +982,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>   		return -EFAULT;
>   
>   	if (write) {
> -		if (!(vm_flags & VM_WRITE)) {
> +		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
>   			if (!(gup_flags & FOLL_FORCE))
>   				return -EFAULT;
>   			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */

and ordinary GUP without FOLL_FORCE.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

