Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8DD5B7760
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiIMRJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiIMRJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:09:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E154E915CE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663084639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUJaNJkuMv5yCjy1lFpV9vEsWOQX3yrO4REsQqZupb8=;
        b=RpTQjPsKlEIVIbtqQI1wRYJfHZ0fwAigwByqvvUPme8cLKWxLFDNnSta84nbg7HNwl0L2m
        XP9XVocMk3+MWYQUuBauqxQTJKlfzZRXxPnbYxGqJjN3WVvwHGleN5Vc12cY0UCsGuTYvF
        hqeCWNBHU4+q/hAQFgJONlyKG31hb2k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-Ug3pthb2NDCWfdmWg1h0ug-1; Tue, 13 Sep 2022 11:11:41 -0400
X-MC-Unique: Ug3pthb2NDCWfdmWg1h0ug-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A6918037AE;
        Tue, 13 Sep 2022 15:11:40 +0000 (UTC)
Received: from localhost (ovpn-13-136.pek2.redhat.com [10.72.13.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B1D749BB60;
        Tue, 13 Sep 2022 15:11:39 +0000 (UTC)
Date:   Tue, 13 Sep 2022 23:11:35 +0800
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
Message-ID: <YyCdpxJeyY0geOLh@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-3-bhe@redhat.com>
 <e7f8798a-43ac-8083-93ac-4581bd2a5647@csgroup.eu>
 <YwQrC3X3PHa0pNDy@MiWiFi-R3L-srv>
 <54b7afcc-056d-7f33-6858-d451a3222c70@csgroup.eu>
 <YwTI6jAjY68QK5h6@MiWiFi-R3L-srv>
 <8df89136-a7f2-9b66-d522-a4fb9860bf22@csgroup.eu>
 <YwtND/L8xD+ViN3r@MiWiFi-R3L-srv>
 <Yx6fvuXakMnCwinB@MiWiFi-R3L-srv>
 <6ffdbdbb-0a21-25a6-13f6-4c4be3b87e50@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ffdbdbb-0a21-25a6-13f6-4c4be3b87e50@csgroup.eu>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/22 at 07:10am, Christophe Leroy wrote:
> Hi Baoquan,
> 
> Le 12/09/2022 à 04:55, Baoquan He a écrit :
> > Hi Christophe,
> > 
> > On 08/28/22 at 07:10pm, Baoquan He wrote:
> >> On 08/23/22 at 07:03pm, Christophe Leroy wrote:
> > ......
> >>>>>>> Is it really the best approach ? Wouldn't it be better to have helpers
> >>>>>>> to do that, those helpers being called by the ioremap_prot(), instead of
> >>>>>>> doing it inside the arch_ioremap() function ?
> >>>>>>
> >>>>>> This is suggested too by Alexander during his v1 reviewing. I tried, but
> >>>>>> feel the current way taken in this patchset is better. Because not all
> >>>>>> architecutres need the address fix up, only parisc, and only few need
> >>>>>> adjust the 'prot'. Introducing other helpers seems too much, that only
> >>>>>> increases the complexity of of ioremap() and the generic GENERIC_IOREMAP
> >>>>>> method for people to understand and take.
> >>>>>
> >>>>> I can't understand. Why is it difficult to do something like:
> >>>>>
> >>>>> #ifndef ioremap_adjust_prot
> >>>>> static inline unsigned long ioremap_adjust_prot(unsigned long flags)
> >>>>> {
> >>>>> 	return flags;
> >>>>> }
> >>>>> #endif
> >>>>>
> >>>>> Then for arc you do
> >>>>>
> >>>>> static inline unsigned long ioremap_adjust_prot(unsigned long flags)
> >>>>> {
> >>>>> 	return pgprot_val(pgprot_noncached(__pgprot(flags)));
> >>>>> }
> >>>>> #define ioremap_adjust_prot ioremap_adjust_prot
> >>>>
> >>>> My thinking is we have four things to do in the added hookers.
> >>>> 1) check if we should do ioremap on ARCHes. If not, return NULL from
> >>>> ioremap_prot();
> >>>> 2) handling the mapping io address specifically on ARCHes, e.g arc,
> >>>> ia64, s390;
> >>>> 3) the original physical address passed into ioremap_prot() need be
> >>>> fixed up, e.g arc;
> >>>> 4) the 'prot' passed into ioremap_prot() need be adjusted, e.g on arc
> >>>> and xtensa.
> >>>>
> >>>> With Kefeng's patches, the case 1) is handled with introduced
> >>>> ioremap_allowed()/iounmap_allowed(). In this patchset, what I do is
> >>>> rename the hooks as arch_ioremap() and arch_iounmap(), then put case 1),
> >>>> 2), 3), 4) handling into arch_ioremap(). Adding helpers to cover each
> >>>> case is not difficult from my side. I worry that as time goes by, those
> >>>> several hooks my cause issue, e.g if a new adjustment need be done,
> >>>> should we introduce a new helper or make do with the existed hook; how
> >>>>
> >>>> When I investigated this, one arch_ioremap() looks not complicated
> >>>> since not all ARCHes need cover all above 4 cases. That's why I finally
> >>>> choose one hook. I am open to new idea, please let me know if we should
> >>>> change it to introduce several different helpers.
> >>>>
> >>>
> >>> A new idea that would have my preference would be to do just like we did
> >>> with arch_get_unmapped_area(). Look at
> >>> https://elixir.bootlin.com/linux/v6.0-rc1/source/arch/powerpc/mm/book3s64/slice.c#L638
> >>> and https://elixir.bootlin.com/linux/v6.0-rc1/source/mm/mmap.c#L2131
> >>>
> >>> Instead of having the generic that calls the arch specific, make it the
> >>> other way round, have the arch specific call the generic after doing its
> >>> specialties.
> >>
> >> This sounds good. I made a draft patch to change code in generic code
> >> part, just showing what it looks like.
> >>
> >> Both arch_ioremap() way and the arch sepcific call the generic way look
> >> good to me. Just it will take less effort for me to continue the
> >> arch_ioremap() way. I would like to hear Christoph's opinion since he
> >> introduced the GENERIC_IOREMAP method and suggested the earlier
> >> arch_ioremap() way and change in this patchset.
> > 
> > I will make another round change and post. Since Christoph doesn't
> > reply, I would like to continue with the existing
> > arch_ioremap/arch_iounmap() hooks way if you don't have strong opinion
> > on the new idea to reintroduce ioremap().
> > 
> 
> I still dislike you approach with the architectures modifying local vars 
> by reference, and as you said earlier I'm not the only one : "This is 
> suggested too by Alexander during his v1 reviewing".

Alexander suggested several helpers, as I have explained earlier, that
will cause at least four helpers currently. And could be more later if
new change is introduced. And the address fixup and prot modifcation
are related in few architecutures. Adding all of them is is not so
necessary.

> 
> So I'd really prefer you to reconsider your approach and avoid passign 
> pointers to local vars to architecture helpers.

If only passing pointers to local vars is disliked, I can explain why I
did so. Let me take arch_ioremap() of a64 as example. I can derefence
pointer in arch_ioremap() to avoid assigning pointers to local vars.
Please see below two version for comparing, and please tell which one is
better.

To me, assigning pointers to local vars make code simple and clean,
honestly. 

******
The version in which pointers assigned to local vars looks like below.
The old phys_addr is passed in, the assigning can decrease changed line.
diff --git a/arch/ia64/mm/ioremap.c b/arch/ia64/mm/ioremap.c
index 55fd3eb753ff..8a085fc660e3 100644
--- a/arch/ia64/mm/ioremap.c
+++ b/arch/ia64/mm/ioremap.c
@@ -30,15 +30,12 @@ early_ioremap (unsigned long phys_addr, unsigned long size)
 }
 
 void __iomem *
-ioremap (unsigned long phys_addr, unsigned long size)
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
 {
-	void __iomem *addr;
-	struct vm_struct *area;
-	unsigned long offset;
-	pgprot_t prot;
-	u64 attr;
+	phys_addr_t phys_addr = *paddr;
 	unsigned long gran_base, gran_size;
 	unsigned long page_base;
+	u64 attr;
 
 	/*
 	 * For things in kern_memmap, we must use the same attribute
@@ -69,35 +66,18 @@ ioremap (unsigned long phys_addr, unsigned long size)
 	page_base = phys_addr & PAGE_MASK;
 	size = PAGE_ALIGN(phys_addr + size) - page_base;
 	if (efi_mem_attribute(page_base, size) & EFI_MEMORY_WB) {
-		prot = PAGE_KERNEL;
-
-		/*
-		 * Mappings have to be page-aligned
-		 */
-		offset = phys_addr & ~PAGE_MASK;
-		phys_addr &= PAGE_MASK;
-
-		/*
-		 * Ok, go for it..
-		 */
-		area = get_vm_area(size, VM_IOREMAP);
-		if (!area)
-			return NULL;
-
-		area->phys_addr = phys_addr;
-		addr = (void __iomem *) area->addr;
-		if (ioremap_page_range((unsigned long) addr,
-				(unsigned long) addr + size, phys_addr, prot)) {
-			vunmap((void __force *) addr);
-			return NULL;
-		}
-
-		return (void __iomem *) (offset + (char __iomem *)addr);
+		return NULL;
 	}
 
 	return __ioremap_uc(phys_addr);
 }
-EXPORT_SYMBOL(ioremap);
+
+int arch_iounmap(void __iomem *addr)
+{
+	if (REGION_NUMBER(addr) != RGN_GATE)
+		return -EINVAL;
+	return 0;
+}
 
 void __iomem *
 ioremap_uc(unsigned long phys_addr, unsigned long size)


*********
The version in which pointer is dereferenced directly in place. Then
more lines of code are involved. And some pointer derefencing takes
place in macro, so bracket is needed.
diff --git a/arch/ia64/mm/ioremap.c b/arch/ia64/mm/ioremap.c
index 55fd3eb753ff..e1b991dc2347 100644
--- a/arch/ia64/mm/ioremap.c
+++ b/arch/ia64/mm/ioremap.c
@@ -30,35 +30,32 @@ early_ioremap (unsigned long phys_addr, unsigned long size)
 }
 
 void __iomem *
-ioremap (unsigned long phys_addr, unsigned long size)
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
 {
-	void __iomem *addr;
-	struct vm_struct *area;
-	unsigned long offset;
-	pgprot_t prot;
-	u64 attr;
+	phys_addr_t phys_addr = *paddr;
 	unsigned long gran_base, gran_size;
 	unsigned long page_base;
+	u64 attr;
 
 	/*
 	 * For things in kern_memmap, we must use the same attribute
 	 * as the rest of the kernel.  For more details, see
 	 * Documentation/ia64/aliasing.rst.
 	 */
-	attr = kern_mem_attribute(phys_addr, size);
+	attr = kern_mem_attribute(*paddr, size);
 	if (attr & EFI_MEMORY_WB)
-		return (void __iomem *) phys_to_virt(phys_addr);
+		return (void __iomem *) phys_to_virt(*paddr);
 	else if (attr & EFI_MEMORY_UC)
-		return __ioremap_uc(phys_addr);
+		return __ioremap_uc(*paddr);
 
 	/*
 	 * Some chipsets don't support UC access to memory.  If
 	 * WB is supported for the whole granule, we prefer that.
 	 */
-	gran_base = GRANULEROUNDDOWN(phys_addr);
-	gran_size = GRANULEROUNDUP(phys_addr + size) - gran_base;
+	gran_base = GRANULEROUNDDOWN(*paddr);
+	gran_size = GRANULEROUNDUP(*paddr + size) - gran_base;
 	if (efi_mem_attribute(gran_base, gran_size) & EFI_MEMORY_WB)
-		return (void __iomem *) phys_to_virt(phys_addr);
+		return (void __iomem *) phys_to_virt(*paddr);
 
 	/*
 	 * WB is not supported for the whole granule, so we can't use
@@ -66,38 +63,21 @@ ioremap (unsigned long phys_addr, unsigned long size)
 	 * area with kernel page table mappings, we can use those
 	 * instead.
 	 */
-	page_base = phys_addr & PAGE_MASK;
-	size = PAGE_ALIGN(phys_addr + size) - page_base;
+	page_base = (*paddr) & PAGE_MASK;
+	size = PAGE_ALIGN(*paddr + size) - page_base;
 	if (efi_mem_attribute(page_base, size) & EFI_MEMORY_WB) {
-		prot = PAGE_KERNEL;
-
-		/*
-		 * Mappings have to be page-aligned
-		 */
-		offset = phys_addr & ~PAGE_MASK;
-		phys_addr &= PAGE_MASK;
-
-		/*
-		 * Ok, go for it..
-		 */
-		area = get_vm_area(size, VM_IOREMAP);
-		if (!area)
-			return NULL;
-
-		area->phys_addr = phys_addr;
-		addr = (void __iomem *) area->addr;
-		if (ioremap_page_range((unsigned long) addr,
-				(unsigned long) addr + size, phys_addr, prot)) {
-			vunmap((void __force *) addr);
-			return NULL;
-		}
-
-		return (void __iomem *) (offset + (char __iomem *)addr);
+		return NULL;
 	}
 
-	return __ioremap_uc(phys_addr);
+	return __ioremap_uc(*paddr);
+}
+
+int arch_iounmap(void __iomem *addr)
+{
+	if (REGION_NUMBER(addr) != RGN_GATE)
+		return -EINVAL;
+	return 0;
 }
-EXPORT_SYMBOL(ioremap);
 
 void __iomem *
 ioremap_uc(unsigned long phys_addr, unsigned long size)

