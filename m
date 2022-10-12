Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182B55FC033
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 07:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJLFwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 01:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJLFwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 01:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69D982D32
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 22:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665553937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5QSAAaXZXllgX8yVoPm+c1cm+iIcy0BJKgHI2x2HPqw=;
        b=D6kbEKLMW4iwlIWsB8VnaPlo33xyxCQjTmfjmwjUZ2ID+h0ZzrOxJRkP8FGMYRKAkZf419
        t4TsDz54RM3evUPoV6m77tqaseG8LjY6xvH3j+EYU8kS45vypr5+x2gQOFF8wU+gSXuSNy
        rSsIEks2uvGNJx0ut5/U7mL7Kk/bYl4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-D1CQ0-vDOvWSF53RoDnr0g-1; Wed, 12 Oct 2022 01:52:11 -0400
X-MC-Unique: D1CQ0-vDOvWSF53RoDnr0g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C47185A583;
        Wed, 12 Oct 2022 05:52:10 +0000 (UTC)
Received: from localhost (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E027849BB64;
        Wed, 12 Oct 2022 05:52:07 +0000 (UTC)
Date:   Wed, 12 Oct 2022 13:52:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        christophe.leroy@csgroup.eu, David.Laight@aculab.com,
        shorne@gmail.com, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 09/11] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <Y0ZWBMKKIuf5Q+qk@MiWiFi-R3L-srv>
References: <20221009103114.149036-1-bhe@redhat.com>
 <20221009103114.149036-10-bhe@redhat.com>
 <b6ac5c44917390b9a5cc7ebb87a089568279c459.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6ac5c44917390b9a5cc7ebb87a089568279c459.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/22 at 05:16pm, Niklas Schnelle wrote:
> On Sun, 2022-10-09 at 18:31 +0800, Baoquan He wrote:
> > By taking GENERIC_IOREMAP method, the generic ioremap_prot() and
> > iounmap() are visible and available to arch. Arch only needs to
> > provide implementation of arch_ioremap() or arch_iounmap() if there's
> > arch specific handling needed in its ioremap() or iounmap(). This
> > change will simplify implementation by removing duplicated codes with
> > generic ioremap() and iounmap(), and has the equivalent functioality
> > as before.
> > 
> > For s390, add hooks arch_ioremap() and arch_iounmap() for s390's special
> > operation when ioremap() and iounmap(), then ioremap_[wc|wt]() are
> > converted to use ioremap_prot() from GENERIC_IOREMAP.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> > Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > Cc: Heiko Carstens <hca@linux.ibm.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> > Cc: Sven Schnelle <svens@linux.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > ---
> > v2->v3:
> > - Add code comment inside arch_ioremap() to help uderstand the
> >   obsucre code. Christoph suggested this, Niklas provided the
> >   paragraph of text.
> > 
> >  arch/s390/Kconfig          |  1 +
> >  arch/s390/include/asm/io.h | 25 +++++++++------
> >  arch/s390/pci/pci.c        | 65 ++++++++------------------------------
> >  3 files changed, 30 insertions(+), 61 deletions(-)
> > 
> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> > index 318fce77601d..c59e1b25f59d 100644
> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -135,6 +135,7 @@ config S390
> >  	select GENERIC_SMP_IDLE_THREAD
> >  	select GENERIC_TIME_VSYSCALL
> >  	select GENERIC_VDSO_TIME_NS
> > +	select GENERIC_IOREMAP
> 
> I think you should add the "if PCI" from the diff in your last mail to
> this patch.

That's reasonable, will do.

The code change in driver should be posted separately to get reviewing
from the relevant drvier maintainers. I may wrap it into this series in
next post so that people know its background.

> 
> >  	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
> >  	select HAVE_ARCH_AUDITSYSCALL
> >  	select HAVE_ARCH_JUMP_LABEL
......
> > diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> > index 73cdc5539384..3c00dc7d79bc 100644
> > --- a/arch/s390/pci/pci.c
> > +++ b/arch/s390/pci/pci.c
> > @@ -244,64 +244,25 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
> >         zpci_memcpy_toio(to, from, count);
> >  }
> >  
> > -static void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot)
> > +void __iomem *
> > +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
> >  {
> > -	unsigned long offset, vaddr;
> > -	struct vm_struct *area;
> > -	phys_addr_t last_addr;
> > -
> > -	last_addr = addr + size - 1;
> > -	if (!size || last_addr < addr)
> > -		return NULL;
> > -
> > +	/*
> > +	 * When PCI MIO instructions are unavailable the "physical" address
> > +	 * encodes a hint for accessing the PCI memory space it represents.
> > +	 * Just pass it unchanged such that ioread/iowrite can decode it.
> > +	 */
> >  	if (!static_branch_unlikely(&have_mio))
> > -		return (void __iomem *) addr;
> > -
> > -	offset = addr & ~PAGE_MASK;
> > -	addr &= PAGE_MASK;
> > -	size = PAGE_ALIGN(size + offset);
> > -	area = get_vm_area(size, VM_IOREMAP);
> > -	if (!area)
> > -		return NULL;
> > -
> > -	vaddr = (unsigned long) area->addr;
> > -	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
> > -		free_vm_area(area);
> > -		return NULL;
> > -	}
> > -	return (void __iomem *) ((unsigned long) area->addr + offset);
> > +		return (void __iomem *) *paddr;
> 
> nit: no space after the cast

Sorry, remember you pointed this out in v2, while I didn't get what
it is. Could you be more specific or give the right line of code?

Are you suggesting below line? 

-	return (void __iomem *) ((unsigned long) area->addr + offset);
+		return (void __iomem *)*paddr;

> 
> > +	return NULL;
> >  }
> >  
> > -void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
> > +bool arch_iounmap(void __iomem *addr)
> >  {
> > -	return __ioremap(addr, size, __pgprot(prot));
> > -}
> > -EXPORT_SYMBOL(ioremap_prot);
> > -
> > -void __iomem *ioremap(phys_addr_t addr, size_t size)
> > -{
> > -	return __ioremap(addr, size, PAGE_KERNEL);
> > -}
> > -EXPORT_SYMBOL(ioremap);
> > -
> > -void __iomem *ioremap_wc(phys_addr_t addr, size_t size)
> > -{
> > -	return __ioremap(addr, size, pgprot_writecombine(PAGE_KERNEL));
> > -}
> > -EXPORT_SYMBOL(ioremap_wc);
> > -
> > -void __iomem *ioremap_wt(phys_addr_t addr, size_t size)
> > -{
> > -	return __ioremap(addr, size, pgprot_writethrough(PAGE_KERNEL));
> > -}
> > -EXPORT_SYMBOL(ioremap_wt);
> > -
> > -void iounmap(volatile void __iomem *addr)
> > -{
> > -	if (static_branch_likely(&have_mio))
> > -		vunmap((__force void *) ((unsigned long) addr & PAGE_MASK));
> > +	if (!static_branch_likely(&have_mio))
> > +		return false;
> > +	return true;
> >  }
> > -EXPORT_SYMBOL(iounmap);
> >  
> >  /* Create a virtual mapping cookie for a PCI BAR */
> >  static void __iomem *pci_iomap_range_fh(struct pci_dev *pdev, int bar,
> 
> Gave this a round of testing on s390 with both the MIO and non-MIO
> cases. I also see you addressed my previous comments and it looks good
> to me. As you showed in the other mail the compile error is a pre
> existing problem so shouldn't influence this change. So assuming you
> add the "if PCI" and the nit above you can add my:

Thanks a lot, will add that part to this patch and add your tags.

> 
> Tested-by: Niklas
> Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Niklas Schnelle
> <schnelle@linux.ibm.com>
> 
> 

