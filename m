Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7E36231E7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiKIRuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiKIRuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:50:50 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681BCDFAE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:50:49 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so2617114pjd.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 09:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PWlxrjHNyHtVbLrisLkLwYbwy71m7tuzb8Ab1acsSa4=;
        b=nNrOr94hj56UPjOXWoyI15arbN+as6uD8BxrMiP1GjfOh7z7y75cTPhITuOMojULe9
         oEGNoEKrETNqJ8Id3dTMCWr+ik1PPsssl6yHabw13OvZW23essY3g8rO/GHqma3ulBk8
         fgkObWjuzgTp3z/21Dyn7eZR9nrbtBsO3fFAmuJ58hJ7UHnWkJNnNYbkvS8Xv3+yTQv4
         SS2xSarUqK6eNJtsmAfnJ8aby6za0e6yirMfUst7g8iqsw1qnFxlDuCaO/owwKslIBFR
         552Rx9sDALgWJEt2LDy8lgl3PeKCQ7qq2zp5RTwfxgcvld4kNBmVcIr1dpWG1Qd1ZY91
         fM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWlxrjHNyHtVbLrisLkLwYbwy71m7tuzb8Ab1acsSa4=;
        b=l2Ug5aVBKJwscJQGa4oEfWfzFI2JdZvHxDBEpBWxTk+bO39tnM6QY+g6obdtnl0IUR
         bZLpSEGOizfGZGTQt8dNSBNCp6zX1LdYyBdFI3+ctbU1+qz6aZaRXInJmaz3qhofzndz
         rhKA3zi4TWwfoLwbGnQj7fXVWFjR3wcPpQbsAljZaYNfFlMBInnBQSpqIv+RBEYVqM7E
         j5bN8JIR6MF/BZOWlIdjknNGbbnbL7I4OYAv6KAEuP9hjON+cqhR4GihGB6oMDAmsE6k
         +FB8VqQcmGS2ykiYACJyRP98HB9SU7TkPKPLaxUTdNvhU+aw7376xnkmf0Rfv82IYqfY
         Cf9Q==
X-Gm-Message-State: ACrzQf0dr6DLXlMHA6vBDTiK0F/7SHZf9GLug2VMF+0AvUTZsyZQoiN4
        iD259K1k1g/qDZcqM1rlcSujs/wqHcMXlA==
X-Google-Smtp-Source: AMsMyM78b05H3S0x1SQ3DpwKbfHjOOPrNxhkQ/y1xAihADYy5pxKzxZJ8XYZ73JlV07TI/Inh6zI+g==
X-Received: by 2002:a17:903:258b:b0:186:8bb2:de32 with SMTP id jb11-20020a170903258b00b001868bb2de32mr63493899plb.63.1668016248824;
        Wed, 09 Nov 2022 09:50:48 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c195-20020a621ccc000000b00550724f8ea0sm8468741pfc.128.2022.11.09.09.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:50:48 -0800 (PST)
Date:   Wed, 9 Nov 2022 17:50:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 2/2] x86/mm: Populate KASAN shadow for per-CPU DS buffers
 in CPU entry area
Message-ID: <Y2vodSEIrNyxf8wF@google.com>
References: <20221104220053.1702977-1-seanjc@google.com>
 <20221104220053.1702977-3-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104220053.1702977-3-seanjc@google.com>
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

On Fri, Nov 04, 2022, Sean Christopherson wrote:
> Bounce through cea_map_percpu_pages() when setting the initial
> protections for per-CPU DS buffers so that KASAN populates a shadow for
> said mapping.  Failure to populate the shadow will result in a
> not-present #PF during KASAN validation if DS buffers are activated
> later on.
> 
> Fixes: 9fd429c28073 ("x86/kasan: Map shadow for percpu pages on demand")
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/mm/cpu_entry_area.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
> index d831aae94b41..64ae557ceb22 100644
> --- a/arch/x86/mm/cpu_entry_area.c
> +++ b/arch/x86/mm/cpu_entry_area.c
> @@ -91,13 +91,12 @@ void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags)
>  static void __init
>  cea_map_percpu_pages(void *cea_vaddr, void *ptr, int pages, pgprot_t prot)
>  {
> -	phys_addr_t pa = per_cpu_ptr_to_phys(ptr);
> +	int nid = ptr ? early_pfn_to_nid(PFN_DOWN(per_cpu_ptr_to_phys(ptr))) : 0;
>  
> -	kasan_populate_shadow_for_vaddr(cea_vaddr, pages * PAGE_SIZE,
> -					early_pfn_to_nid(PFN_DOWN(pa)));
> +	kasan_populate_shadow_for_vaddr(cea_vaddr, pages * PAGE_SIZE, nid);
>  
>  	for ( ; pages; pages--, cea_vaddr+= PAGE_SIZE, ptr += PAGE_SIZE)
> -		cea_set_pte(cea_vaddr, per_cpu_ptr_to_phys(ptr), prot);
> +		cea_set_pte(cea_vaddr, ptr ? per_cpu_ptr_to_phys(ptr) : 0, prot);

Gah, this is broken.  If pages > 1, subsequent iterations will generate a non-NULL
ptr.  This is likely what the kernel test bot is complaining about[1].  Andrey's
suggestion to map the entire per-CPU area in one go[2] should obviate the need for
special casing the DS buffer.  I'll give that a whirl and smush all three of these
mini-series together.

[1] https://lore.kernel.org/all/202211092215.948a1cf3-oliver.sang@intel.com
[2] https://lore.kernel.org/all/b5e31093-ac80-595b-1127-2a3e35913d86@gmail.com
