Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61CA72B070
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 07:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjFKFv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 01:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFKFv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 01:51:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CFCC4;
        Sat, 10 Jun 2023 22:51:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3969960AB6;
        Sun, 11 Jun 2023 05:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31432C433EF;
        Sun, 11 Jun 2023 05:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686462684;
        bh=odwd+s+PPw9HVkel4y3m5C8tVdKpRQo8tMCWtU9VGeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=khqjTupPSnTEHqr1EM60Mm/tlRG4Z4toiUsPnnrwv+mZExfujDwv+LxazAHlIGeDJ
         q9kBzitPQC4TESVNRIcRsCl6DOEkmIvKAH+oc3ukyyeHzRgULD+TL+GGp7QBmFc5Ow
         3uZdZzCw3+1dPhQSOAlLVTAcipRnDEAkxSxUf3IrAyqUh1UQvLB6ulYKDYK9DJ8LD7
         JR6JI20YJyeHNOElPezQtianTnNZhQpBvXixE8Nx0DI7uq+3pP1u20p9EdS41ttq4k
         AAb2DA0XCtqQAi9EGM/4kkm/LSOpwM16IaAsqtwglR9dQQUfXYYcB+r1PY0iEdD/Nm
         KvX4VCg6olVPg==
Date:   Sun, 11 Jun 2023 08:50:52 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Deming Wang <wangdeming@inspur.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Collingbourne <pcc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] Documentation/mm: Add kmap_local_folio() to Temporary
 Virt. Mappings
Message-ID: <20230611055052.GO52412@kernel.org>
References: <20230609030908.31373-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609030908.31373-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 05:09:08AM +0200, Fabio M. De Francesco wrote:
> The differences between kmap_local_page() and kmap_local_folio() consist
> only in the first taking a pointer to a page and the second taking two
> arguments, a pointer to a folio and the byte offset within the folio which
> identifies the page.
> 
> The two API's can be explained at the same time in the "Temporary Virtual
> Mappings" section of the Highmem's documentation.
> 
> Add information about kmap_local_folio() in the same subsection that
> explains kmap_local_page().
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Peter Collingbourne <pcc@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  Documentation/mm/highmem.rst | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/mm/highmem.rst b/Documentation/mm/highmem.rst
> index c964e0848702..bb9584f167a6 100644
> --- a/Documentation/mm/highmem.rst
> +++ b/Documentation/mm/highmem.rst
> @@ -51,11 +51,14 @@ Temporary Virtual Mappings
>  The kernel contains several ways of creating temporary mappings. The following
>  list shows them in order of preference of use.
>  
> -* kmap_local_page().  This function is used to require short term mappings.
> -  It can be invoked from any context (including interrupts) but the mappings
> -  can only be used in the context which acquired them.
> -
> -  This function should always be used, whereas kmap_atomic() and kmap() have
> +* kmap_local_page(), kmap_local_folio() - These functions are used to require
> +  short term mappings. They can be invoked from any context (including
> +  interrupts) but the mappings can only be used in the context which acquired
> +  them. The only differences between them consist in the first taking a pointer
> +  to a struct page and the second taking a pointer to struct folio and the byte
> +  offset within the folio which identifies the page.
> +
> +  These functions should always be used, whereas kmap_atomic() and kmap() have
>    been deprecated.
>  
>    These mappings are thread-local and CPU-local, meaning that the mapping
> @@ -72,17 +75,17 @@ list shows them in order of preference of use.
>    maps of the outgoing task are saved and those of the incoming one are
>    restored.
>  
> -  kmap_local_page() always returns a valid virtual address and it is assumed
> -  that kunmap_local() will never fail.
> +  kmap_local_page(), as well as kmap_local_folio() always returns valid virtual
> +  kernel addresses and it is assumed that kunmap_local() will never fail.
>  
> -  On CONFIG_HIGHMEM=n kernels and for low memory pages this returns the
> +  On CONFIG_HIGHMEM=n kernels and for low memory pages they return the
>    virtual address of the direct mapping. Only real highmem pages are
>    temporarily mapped. Therefore, users may call a plain page_address()
>    for pages which are known to not come from ZONE_HIGHMEM. However, it is
> -  always safe to use kmap_local_page() / kunmap_local().
> +  always safe to use kmap_local_{page,folio}() / kunmap_local().
>  
> -  While it is significantly faster than kmap(), for the highmem case it
> -  comes with restrictions about the pointers validity. Contrary to kmap()
> +  While they are significantly faster than kmap(), for the highmem case they
> +  come with restrictions about the pointers validity. Contrary to kmap()
>    mappings, the local mappings are only valid in the context of the caller
>    and cannot be handed to other contexts. This implies that users must
>    be absolutely sure to keep the use of the return address local to the
> @@ -91,7 +94,7 @@ list shows them in order of preference of use.
>    Most code can be designed to use thread local mappings. User should
>    therefore try to design their code to avoid the use of kmap() by mapping
>    pages in the same thread the address will be used and prefer
> -  kmap_local_page().
> +  kmap_local_page() or kmap_local_folio().
>  
>    Nesting kmap_local_page() and kmap_atomic() mappings is allowed to a certain
>    extent (up to KMAP_TYPE_NR) but their invocations have to be strictly ordered
> -- 
> 2.40.1
> 

-- 
Sincerely yours,
Mike.
