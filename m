Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9355B52B9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 04:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiILC4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 22:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiILC4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 22:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183CF1EED3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 19:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662951369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QNx0pkhpCOCmN1r/bDO5Y2HzdH/DnCo328+m7ItQR3I=;
        b=EHKTsyqeRMg/K6ewWUFEUIW00TGztGNFVqKSGQKe1R/NcRcxYprExVqfVgdxGLOJRdeLmA
        +LNZb4JMrMTs3jqcU2DfMF1YSVqrRJJd7WfG1nCBTG/jyXQnS36ph77ZMh/GrZokTcTWd6
        36k3ek1nPB7bKkBphw17eeblB92OVjI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-LfkHz_sqP8i2v-ih7rxMbg-1; Sun, 11 Sep 2022 22:56:03 -0400
X-MC-Unique: LfkHz_sqP8i2v-ih7rxMbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FDF429AA381;
        Mon, 12 Sep 2022 02:56:03 +0000 (UTC)
Received: from localhost (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6087C2166B26;
        Mon, 12 Sep 2022 02:56:01 +0000 (UTC)
Date:   Mon, 12 Sep 2022 10:55:58 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 02/11] mm: ioremap: fixup the physical address and
 page prot
Message-ID: <Yx6fvuXakMnCwinB@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-3-bhe@redhat.com>
 <e7f8798a-43ac-8083-93ac-4581bd2a5647@csgroup.eu>
 <YwQrC3X3PHa0pNDy@MiWiFi-R3L-srv>
 <54b7afcc-056d-7f33-6858-d451a3222c70@csgroup.eu>
 <YwTI6jAjY68QK5h6@MiWiFi-R3L-srv>
 <8df89136-a7f2-9b66-d522-a4fb9860bf22@csgroup.eu>
 <YwtND/L8xD+ViN3r@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwtND/L8xD+ViN3r@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 08/28/22 at 07:10pm, Baoquan He wrote:
> On 08/23/22 at 07:03pm, Christophe Leroy wrote:
......
> > >>>> Is it really the best approach ? Wouldn't it be better to have helpers
> > >>>> to do that, those helpers being called by the ioremap_prot(), instead of
> > >>>> doing it inside the arch_ioremap() function ?
> > >>>
> > >>> This is suggested too by Alexander during his v1 reviewing. I tried, but
> > >>> feel the current way taken in this patchset is better. Because not all
> > >>> architecutres need the address fix up, only parisc, and only few need
> > >>> adjust the 'prot'. Introducing other helpers seems too much, that only
> > >>> increases the complexity of of ioremap() and the generic GENERIC_IOREMAP
> > >>> method for people to understand and take.
> > >>
> > >> I can't understand. Why is it difficult to do something like:
> > >>
> > >> #ifndef ioremap_adjust_prot
> > >> static inline unsigned long ioremap_adjust_prot(unsigned long flags)
> > >> {
> > >> 	return flags;
> > >> }
> > >> #endif
> > >>
> > >> Then for arc you do
> > >>
> > >> static inline unsigned long ioremap_adjust_prot(unsigned long flags)
> > >> {
> > >> 	return pgprot_val(pgprot_noncached(__pgprot(flags)));
> > >> }
> > >> #define ioremap_adjust_prot ioremap_adjust_prot
> > > 
> > > My thinking is we have four things to do in the added hookers.
> > > 1) check if we should do ioremap on ARCHes. If not, return NULL from
> > > ioremap_prot();
> > > 2) handling the mapping io address specifically on ARCHes, e.g arc,
> > > ia64, s390;
> > > 3) the original physical address passed into ioremap_prot() need be
> > > fixed up, e.g arc;
> > > 4) the 'prot' passed into ioremap_prot() need be adjusted, e.g on arc
> > > and xtensa.
> > > 
> > > With Kefeng's patches, the case 1) is handled with introduced
> > > ioremap_allowed()/iounmap_allowed(). In this patchset, what I do is
> > > rename the hooks as arch_ioremap() and arch_iounmap(), then put case 1),
> > > 2), 3), 4) handling into arch_ioremap(). Adding helpers to cover each
> > > case is not difficult from my side. I worry that as time goes by, those
> > > several hooks my cause issue, e.g if a new adjustment need be done,
> > > should we introduce a new helper or make do with the existed hook; how
> > > 
> > > When I investigated this, one arch_ioremap() looks not complicated
> > > since not all ARCHes need cover all above 4 cases. That's why I finally
> > > choose one hook. I am open to new idea, please let me know if we should
> > > change it to introduce several different helpers.
> > > 
> > 
> > A new idea that would have my preference would be to do just like we did 
> > with arch_get_unmapped_area(). Look at 
> > https://elixir.bootlin.com/linux/v6.0-rc1/source/arch/powerpc/mm/book3s64/slice.c#L638 
> > and https://elixir.bootlin.com/linux/v6.0-rc1/source/mm/mmap.c#L2131
> > 
> > Instead of having the generic that calls the arch specific, make it the 
> > other way round, have the arch specific call the generic after doing its 
> > specialties.
> 
> This sounds good. I made a draft patch to change code in generic code
> part, just showing what it looks like.
> 
> Both arch_ioremap() way and the arch sepcific call the generic way look
> good to me. Just it will take less effort for me to continue the
> arch_ioremap() way. I would like to hear Christoph's opinion since he
> introduced the GENERIC_IOREMAP method and suggested the earlier
> arch_ioremap() way and change in this patchset. 

I will make another round change and post. Since Christoph doesn't
reply, I would like to continue with the existing
arch_ioremap/arch_iounmap() hooks way if you don't have strong opinion
on the new idea to reintroduce ioremap().

> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 68a8117b30fa..4bc3e18c475f 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1047,35 +1047,18 @@ static inline void iounmap(volatile void __iomem *addr)
>  #elif defined(CONFIG_GENERIC_IOREMAP)
>  #include <linux/pgtable.h>
>  
> -/*
> - * Arch code can implement the following two hooks when using GENERIC_IOREMAP
> - * arch_ioremap() return a bool,
> - *   - IS_ERR means return an error
> - *   - NULL means continue to remap
> - *   - a non-NULL, non-IS_ERR pointer is returned directly
> - * arch_iounmap() return a bool,
> - *   - 0 means continue to vunmap
> - *   - error code means skip vunmap and return directly
> - */
> -#ifndef arch_ioremap
> -#define arch_ioremap arch_ioremap
> -static inline void __iomem *arch_ioremap(phys_addr_t *paddr, size_t size,
> -				   unsigned long *prot_val)
> -{
> -	return NULL;
> -}
> -#endif
> +void __iomem *
> +generic_ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot);
>  
> -#ifndef arch_iounmap
> -#define arch_iounmap arch_iounmap
> -static inline int arch_iounmap(void __iomem *addr)
> +#ifndef ioremap_prot
> +#define ioremap_prot ioremap_prot
> +void __iomem *
> +ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot);
>  {
> -	return 0;
> +	return generic_ioremap_prot(phys_addr, size, prot);
>  }
>  #endif
>  
> -void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> -			   unsigned long prot);
>  void iounmap(volatile void __iomem *addr);
>  
>  #ifndef ioremap
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 7914b5cf5b78..87d51003dee6 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -11,8 +11,8 @@
>  #include <linux/io.h>
>  #include <linux/export.h>
>  
> -void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> -			   unsigned long prot)
> +void __iomem *
> +generic_ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot)
>  {
>  	unsigned long offset, vaddr;
>  	phys_addr_t last_addr;
> 

