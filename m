Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CAF744660
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 05:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjGADfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 23:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjGADdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 23:33:49 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5030646BD;
        Fri, 30 Jun 2023 20:28:16 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3fde82c8ca7so21313511cf.3;
        Fri, 30 Jun 2023 20:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688182095; x=1690774095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UFqIqSRBSLc1Ges7V4RrWVh1QvEfZbr10hghH4pahl4=;
        b=pP1eEBxBE+OVpA07P4Ifj0szylxAlkwPW8RX5HAGwyE4tZMO3jDb8fusxlH1wZb3/c
         cNoWB7hdRYIm7CXM/u6deOmZvfm7OMp4IPzjytvdIAGtEQCRkSHswAUZIpIO0Df4973b
         srgfH8N4aj0OrQlxshypBuT346uM5vYzmBA9IaKEs1lkE8GjnRSzky+qXnGHY5JpaACB
         WLt4H5O3NXlyMbhfaIhMVrP3Pe87Q1umHeE8ExxojKY6feICDUMdGtJAqCQJ5l7zo4Gr
         gXFQxvm3C0At+3BCsEHa9zgKsWLZKi7uz+1DPhxhb6eV3cHZVQR5+4uNgVPnBFotwJPX
         JEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688182095; x=1690774095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFqIqSRBSLc1Ges7V4RrWVh1QvEfZbr10hghH4pahl4=;
        b=YuXqgS7qzL9v5YtnklvFapxqKoabfp+SaWo7ZJ6fDMeNvqKg9+ZbvIRoLzyaj+EYAy
         FI15ZGUH4zMcZKTHO3QlpE19pe5hjtT04YDBWPckHHyFIUCJ8DcDh+a4uzSXLkAsnN2K
         8fx7gwEdTai9zMIotnV/zPcTtov/kld1MFTCALnnrrfZp3dhCJordt68fU3y6z6t2Bc7
         6HsrthNqI/niN/1Ob9gIiV+hNzU3k7lztYy+X1VWR0bnc9U43zB/4PXhdPM+zFkOgMez
         uhrUMWs8F72x8a0D02OXoq9v0Y578HhrjXEqF5u911Yn2uiLJxs8uSc9I3Bszz2xv/UG
         9AvA==
X-Gm-Message-State: AC+VfDzINVnQ3ZPQP8hn7fT8uUudK0fsqvPLw6yXZ23/fU8iPrRZQC1p
        AV63guLgma11tGJajex65e2/hO1Ce4s=
X-Google-Smtp-Source: ACHHUZ4B6R4I+euwxmhxe2vEfD8fzPBZAFh9e9ic9lkRZHYEO5MIfilrT0jQhbbhk57WtDvOG52dAA==
X-Received: by 2002:a05:620a:4249:b0:75b:23a1:3606 with SMTP id w9-20020a05620a424900b0075b23a13606mr5310663qko.23.1688179782577;
        Fri, 30 Jun 2023 19:49:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k6-20020aa78206000000b0064aea45b040sm10510104pfi.168.2023.06.30.19.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 19:49:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 30 Jun 2023 19:49:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Jason Wang <wangborong@cdjrlc.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
Message-ID: <e4dd115b-1a41-4859-bbeb-b3a6a75bf664@roeck-us.net>
References: <20230629184151.888604958@linuxfoundation.org>
 <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <fbe57907-b03f-ac8c-f3f4-4d6959bbc59c@roeck-us.net>
 <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
 <CAHk-=wiN5H-2dh2zCo_jXE7_ekrxSHvQcMw4xfUKjuQs2=BN4w@mail.gmail.com>
 <fb63ea7b-c44b-fb1b-2014-3d23794fa896@roeck-us.net>
 <CAHk-=whh_aUHYF6LCV36K9NYHR4ofEZ0gwcg0RY5hj=B7AT4YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whh_aUHYF6LCV36K9NYHR4ofEZ0gwcg0RY5hj=B7AT4YQ@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 06:24:49PM -0700, Linus Torvalds wrote:
> On Fri, 30 Jun 2023 at 15:51, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > There is one more, unfortunately.
> >
> > Building xtensa:de212:kc705-nommu:nommu_kc705_defconfig ... failed
> 
> Heh. I didn't even realize that anybody would ever do
> lock_mm_and_find_vma() code on a nommu platform.
> 
> With nommu, handle_mm_fault() will just BUG(), so it's kind of
> pointless to do any of this at all, and I didn't expect anybody to
> have this page faulting path that just causes that BUG() for any
> faults.
> 
> But it turns out xtensa has a notion of protection faults even for
> NOMMU configs:
> 
>     config PFAULT
>         bool "Handle protection faults" if EXPERT && !MMU
>         default y
>         help
>           Handle protection faults. MMU configurations must enable it.
>           noMMU configurations may disable it if used memory map never
>           generates protection faults or faults are always fatal.
> 
>           If unsure, say Y.
> 
> which is why it violated my expectations so badly.
> 
> I'm not sure if that protection fault handling really ever gets quite
> this far (it certainly should *not* make it to the BUG() in
> handle_mm_fault()), but I think the attached patch is likely the right
> thing to do.
> 
> Can you check if it fixes that xtensa case? It looks
> ObviouslyCorrect(tm) to me, but considering that I clearly missed this
> case existing AT ALL, it might be best to double-check.
> 
>                Linus

Yes, the patch below fixes the problem.

Building xtensa:de212:kc705-nommu:nommu_kc705_defconfig ... running ......... passed

Thanks,
Guenter

>  include/linux/mm.h |  5 +++--
>  mm/nommu.c         | 11 +++++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 39aa409e84d5..4f2c33c273eb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2323,6 +2323,9 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to);
>  void truncate_pagecache_range(struct inode *inode, loff_t offset, loff_t end);
>  int generic_error_remove_page(struct address_space *mapping, struct page *page);
>  
> +struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
> +		unsigned long address, struct pt_regs *regs);
> +
>  #ifdef CONFIG_MMU
>  extern vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
>  				  unsigned long address, unsigned int flags,
> @@ -2334,8 +2337,6 @@ void unmap_mapping_pages(struct address_space *mapping,
>  		pgoff_t start, pgoff_t nr, bool even_cows);
>  void unmap_mapping_range(struct address_space *mapping,
>  		loff_t const holebegin, loff_t const holelen, int even_cows);
> -struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
> -		unsigned long address, struct pt_regs *regs);
>  #else
>  static inline vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
>  					 unsigned long address, unsigned int flags,
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 37d0b03143f1..fdc392735ec6 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -630,6 +630,17 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>  }
>  EXPORT_SYMBOL(find_vma);
>  
> +/*
> + * At least xtensa ends up having protection faults even with no
> + * MMU.. No stack expansion, at least.
> + */
> +struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
> +			unsigned long addr, struct pt_regs *regs)
> +{
> +	mmap_read_lock(mm);
> +	return vma_lookup(mm, addr);
> +}
> +
>  /*
>   * expand a stack to a given address
>   * - not supported under NOMMU conditions

