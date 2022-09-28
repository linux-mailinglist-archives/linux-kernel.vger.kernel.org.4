Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E185ED2E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 04:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiI1CFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 22:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbiI1CF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 22:05:26 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C640A1A04C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 19:05:24 -0700 (PDT)
Date:   Wed, 28 Sep 2022 11:05:11 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664330721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c2MxatIKlnRgTMVHJ645nKU6WcLahTngruGJ8RFFSSI=;
        b=saP9WBl20FekD59GxcSd000H9QjoPMKOzc16DBIxBa840PxpuwWzA2nIAixdfUzsiYpepf
        Gc2gKjmkKqD6PySlCgyJYSbHO1at/g2r3Ki5byEuuTwhXP+RSRCxC5KwIP0G+31gluQFM5
        myCVF9uMunvhFXlWlwPGIPst17HGyVc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] mm/hwpoison: move definitions of
 num_poisoned_pages_* to memory-failure.c
Message-ID: <20220928020511.GB597297@u2004.lan>
References: <20220921091359.25889-1-naoya.horiguchi@linux.dev>
 <20220921091359.25889-3-naoya.horiguchi@linux.dev>
 <4b7c327a-547e-be8b-4568-745fabe74641@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b7c327a-547e-be8b-4568-745fabe74641@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 07:53:15PM +0800, Miaohe Lin wrote:
> On 2022/9/21 17:13, Naoya Horiguchi wrote:
> > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > 
> > These interfaces will be used by drivers/base/core.c by later patch, so as a
> > preparatory work move them to more common header file visible to the file.
> > 
> > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > ---
> > ChangeLog v2 -> v3:
> > - added declaration of num_poisoned_pages_inc() in #ifdef CONFIG_MEMORY_FAILURE
> > ---
> >  arch/parisc/kernel/pdt.c |  3 +--
> >  include/linux/mm.h       |  5 +++++
> >  include/linux/swapops.h  | 24 ++----------------------
> >  mm/memory-failure.c      | 10 ++++++++++
> >  4 files changed, 18 insertions(+), 24 deletions(-)
> > 
> > diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
> > index e391b175f5ec..fdc880e2575a 100644
> > --- a/arch/parisc/kernel/pdt.c
> > +++ b/arch/parisc/kernel/pdt.c
> > @@ -18,8 +18,7 @@
> >  #include <linux/kthread.h>
> >  #include <linux/initrd.h>
> >  #include <linux/pgtable.h>
> > -#include <linux/swap.h>
> 
> Is header file "linux/swap.h" already unneeded before the code change? It seems there's
> no code change in that file.

Maybe yes.  I updated this line too because it's introduced together
swapops.h by the following commit.

  commit 0e5a7ff6e36ad58933d076ddcac36ff14d014692
  Author: Helge Deller <deller@gmx.de>
  Date:   Fri Jul 24 19:17:52 2020 +0200
  
      parisc: Report bad pages as HardwareCorrupted

> 
> > -#include <linux/swapops.h>
> > +#include <linux/mm.h>
> >  
> >  #include <asm/pdc.h>
> >  #include <asm/pdcpat.h>
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index c2277f5aba9e..80a2d800f272 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3279,11 +3279,16 @@ extern atomic_long_t num_poisoned_pages __read_mostly;
> >  extern int soft_offline_page(unsigned long pfn, int flags);
> >  #ifdef CONFIG_MEMORY_FAILURE
> >  extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags);
> > +extern void num_poisoned_pages_inc(void);
> >  #else
> >  static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
> >  {
> >  	return 0;
> >  }
> > +
> > +static inline void num_poisoned_pages_inc(void)
> > +{
> > +}
> >  #endif
> >  
> >  #ifndef arch_memory_failure
> > diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> > index a91dd08e107b..3e58a812399a 100644
> > --- a/include/linux/swapops.h
> > +++ b/include/linux/swapops.h
> > @@ -581,8 +581,6 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
> >  
> >  #ifdef CONFIG_MEMORY_FAILURE
> >  
> > -extern atomic_long_t num_poisoned_pages __read_mostly;
> > -
> >  /*
> >   * Support for hardware poisoned pages
> >   */
> > @@ -610,17 +608,7 @@ static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
> >  	return p;
> >  }
> >  
> > -static inline void num_poisoned_pages_inc(void)
> > -{
> > -	atomic_long_inc(&num_poisoned_pages);
> > -}
> > -
> > -static inline void num_poisoned_pages_sub(long i)
> > -{
> > -	atomic_long_sub(i, &num_poisoned_pages);
> > -}
> > -
> > -#else  /* CONFIG_MEMORY_FAILURE */
> > +#else
> >  
> >  static inline swp_entry_t make_hwpoison_entry(struct page *page)
> >  {
> > @@ -636,15 +624,7 @@ static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
> >  {
> >  	return NULL;
> >  }
> > -
> > -static inline void num_poisoned_pages_inc(void)
> > -{
> > -}
> > -
> > -static inline void num_poisoned_pages_sub(long i)
> > -{
> > -}
> > -#endif  /* CONFIG_MEMORY_FAILURE */
> > +#endif
> >  
> >  static inline int non_swap_entry(swp_entry_t entry)
> >  {
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 5942e1c0407e..aa6ce685b863 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -74,6 +74,16 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
> >  
> >  static bool hw_memory_failure __read_mostly = false;
> >  
> > +static inline void num_poisoned_pages_inc(void)
> 
> This function is defined as "static inline" while it's "extern void num_poisoned_pages_inc(void)"
> in the header file. Is this expected?

No. 4/4 effectively fixes it, but I should've done this in this patch.
Thank you,
- Naoya Horiguchi

> 
> Thanks,
> Miaohe Lin
> 
> > +{
> > +	atomic_long_inc(&num_poisoned_pages);
> > +}
> > +
> > +static inline void num_poisoned_pages_sub(long i)
> > +{
> > +	atomic_long_sub(i, &num_poisoned_pages);
> > +}
> > +
> >  /*
> >   * Return values:
> >   *   1:   the page is dissolved (if needed) and taken off from buddy,
> > 
> 
