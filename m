Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296C2734ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 05:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjFSD5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 23:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFSD5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 23:57:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4F5C5;
        Sun, 18 Jun 2023 20:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687146949; x=1687751749; i=deller@gmx.de;
 bh=2fndrLIH+tdYpXaN3a+B2+gpkPc6UJVTkZbYPRfVVB8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=tHEzjmtG0VENHAd2DsNX0VdgvhB3svy7eaGOu9NFOvFGhn1vMbEvw1DJ+6Ro8SfR+zYO8Jk
 oQyuTgSliiEbg8vZLpHgVzlyXTGg39KCzCetFU2QY1sIGcgFZePrwHb9ybGVXL+myxIM7zyFW
 vutzWxYp5k3P7CbcRS0bdRBQ3OV2xelDwHz+H2/Evbu2z8c/2sLPc4ox6wVqaIps6PKmnyug3
 Uh162w8Lsy86g+eUKl1+1tWZwxCjWi6j5hYhUWVVAHRKRfHvDjtn4aElpEf0t4RvU0/z6Fz8/
 PwGLztv0XjhmK7HYbqINh4rNCYiEBBtnOqKRgIMD0/NnASTKw8BA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.148.114]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My36N-1ptYsd3hol-00zXMS; Mon, 19
 Jun 2023 05:55:49 +0200
Message-ID: <2f5a3805-b7a5-1c45-e5a4-e273ea289ba6@gmx.de>
Date:   Mon, 19 Jun 2023 05:55:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 08/23] parisc: add pte_unmap() to balance get_ptep()
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
 <653369-95ef-acd2-d6ea-e95f5a997493@google.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <653369-95ef-acd2-d6ea-e95f5a997493@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E3xdg5CpQcjOoKW8Y56OwqWPK69wZz6OC3pXUq5sC4koD4vx6TE
 8yx7mlAVEcBGQCbXtdVKp5UUdnr/61/KwgdLsdsCeafoXWrwMUBr6cWiQIGAUgINT3sBkXj
 YUQ+i02IXhG0ZBE1C7Dv9zl3aVQVXzwfFiVekkVC97MGOBsK+OwPv4gKZzvDYcrI9sx6vlb
 RKMhNKB17Raa0wGb+9IJg==
UI-OutboundReport: notjunk:1;M01:P0:f2v0q5B++HE=;Da2Hd/q80C0hblRDasa115R7ipH
 ITP+kxg7e8qZRipjLb6CGqyHPdG/Zhb8pEJIpXAWFU3ar1yt+BeqPp25z1tD2fgQoomDBafSI
 T2JI0cHyhX9oBPPhCH37HzO5OqjXai1apVVEetq9P184N6g33p3cSDDZYP4I6GoLDN9DvQEFu
 QGd3zrkWkqEmZ6Vad/7T9wzoz6Iy73Cj+YnQUayxP/WmDRLwi5RNxp1O83PFQIH+w3CKE1EWO
 23kOMxcrgAD7YqjQU4alZc4K1Phuaj4FBExhBg+66ocbKtD9nfb6PZRuchNLX/Q5VmxOlBfea
 +unhX9xz0F4yej82C9a9Ahzf2WFmqaqduJ4GfxBBVMpA2OodPCXovgqDmB1veKiq8vZA6X5yk
 wU+Jcnh+QmfWXd/xL82C8EjAYdwJcDg+eEk6he/T2BpLkdrJqvUsbwmL1s6vm3h2xfZdv9HjP
 HDqKexAwIHyONgbwbztyEJNTMjILHQtvalYaPHd4cLJWdj/f+xdGeWpPd11qIZv0pNRC6RmzG
 BMRyfjmCQkvWDZio/DHwSQ9i0PRIQ+8+VjmSj1b6Y6CsaT5/J9RXXe4kiJxSG4snZdzRGYY2O
 4McI1b8tXhq5e63I/ekb0ajHKJ5Bor2QBVqDM68FKmYbJv/bR6oV8WIMMsLewJ2LUtXAfXAbu
 x/EEjEq7JGtus66za+aX5Yazu6PYy0EIzEn+QO1Pnloxqaq1TITSpEEXtzuFrLPYbW8qHKqNl
 aMzyEK7bpqATAUqTeGQYGs5kvHwxHgsW47YV5D9G3+QzisWw4SSUG2zUA0IqSI6i/fK/bZUUg
 9s7lXJW9HE6ObKs8Fk2cZGz0H9VAEPLoLgBcumMBsPE0yNFDqFiHwKmbJ24rQM7wtujiIH8eg
 Du+92nPxZgAKb8/YuRr6Rozc58x213b7vXjIz4uu3TcvqL6TMGK4B5hLfnDu5CfN3qfqxkdKR
 hKk8rTZjPetTc5al7ev4qbwvKGA=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/23 21:18, Hugh Dickins wrote:
> To keep balance in future, remember to pte_unmap() after a successful
> get_ptep().  And act as if flush_cache_pages() really needs a map there,
> to read the pfn before "unmapping", to be sure page table is not removed=
.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

For the parisc parts:

Acked-by: Helge Deller <deller@gmx.de> # parisc

Helge


> ---
>   arch/parisc/kernel/cache.c | 26 +++++++++++++++++++++-----
>   1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
> index ca4a302d4365..501160250bb7 100644
> --- a/arch/parisc/kernel/cache.c
> +++ b/arch/parisc/kernel/cache.c
> @@ -426,10 +426,15 @@ void flush_dcache_page(struct page *page)
>   		offset =3D (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
>   		addr =3D mpnt->vm_start + offset;
>   		if (parisc_requires_coherency()) {
> +			bool needs_flush =3D false;
>   			pte_t *ptep;
>
>   			ptep =3D get_ptep(mpnt->vm_mm, addr);
> -			if (ptep && pte_needs_flush(*ptep))
> +			if (ptep) {
> +				needs_flush =3D pte_needs_flush(*ptep);
> +				pte_unmap(ptep);
> +			}
> +			if (needs_flush)
>   				flush_user_cache_page(mpnt, addr);
>   		} else {
>   			/*
> @@ -561,14 +566,20 @@ EXPORT_SYMBOL(flush_kernel_dcache_page_addr);
>   static void flush_cache_page_if_present(struct vm_area_struct *vma,
>   	unsigned long vmaddr, unsigned long pfn)
>   {
> -	pte_t *ptep =3D get_ptep(vma->vm_mm, vmaddr);
> +	bool needs_flush =3D false;
> +	pte_t *ptep;
>
>   	/*
>   	 * The pte check is racy and sometimes the flush will trigger
>   	 * a non-access TLB miss. Hopefully, the page has already been
>   	 * flushed.
>   	 */
> -	if (ptep && pte_needs_flush(*ptep))
> +	ptep =3D get_ptep(vma->vm_mm, vmaddr);
> +	if (ptep) {
> +		needs_flush =3D pte_needs_flush(*ptep);
> +		pte_unmap(ptep);
> +	}
> +	if (needs_flush)
>   		flush_cache_page(vma, vmaddr, pfn);
>   }
>
> @@ -635,17 +646,22 @@ static void flush_cache_pages(struct vm_area_struc=
t *vma, unsigned long start, u
>   	pte_t *ptep;
>
>   	for (addr =3D start; addr < end; addr +=3D PAGE_SIZE) {
> +		bool needs_flush =3D false;
>   		/*
>   		 * The vma can contain pages that aren't present. Although
>   		 * the pte search is expensive, we need the pte to find the
>   		 * page pfn and to check whether the page should be flushed.
>   		 */
>   		ptep =3D get_ptep(vma->vm_mm, addr);
> -		if (ptep && pte_needs_flush(*ptep)) {
> +		if (ptep) {
> +			needs_flush =3D pte_needs_flush(*ptep);
> +			pfn =3D pte_pfn(*ptep);
> +			pte_unmap(ptep);
> +		}
> +		if (needs_flush) {
>   			if (parisc_requires_coherency()) {
>   				flush_user_cache_page(vma, addr);
>   			} else {
> -				pfn =3D pte_pfn(*ptep);
>   				if (WARN_ON(!pfn_valid(pfn)))
>   					return;
>   				__flush_cache_page(vma, addr, PFN_PHYS(pfn));

