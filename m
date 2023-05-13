Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2467F701A17
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 23:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjEMVhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 17:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEMVhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 17:37:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0597C26BF;
        Sat, 13 May 2023 14:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684013732; i=deller@gmx.de;
        bh=yJRf6LHTP/Tqq0WjA9yc9VAdZA0puqTSbfj+iJUayOI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cr8F1CRBH8iQkDkEZ/t6guBO/5jXWPHjvHesKUuGbD0L0xJGMcsfDLG0X9/WHN5tf
         gmoBZcMozWcEmMI1SXgz60UKtLHg89Qkg3K5IkelB8CkMlNz7sHwAxzIMD7I9clgqG
         8BBXU1INAL2hkc4jAoXGc9Lj9qQhDT78CQ4DXrxDBdxOVY1Chk3DgfjVKIVZpGXT/D
         hVsUkekeRL3hC4ZEJXj+51+YVnf9Nvq9nqI08asyhPuJHM5bnDl2bJRO7+pyeEkSzs
         makkDeysMdDZ+PR6cOIDeDEyBEo1Ufi+QeDWvXHj3Lo1XEgk6NeIJkd9GLiqmybaVK
         GkXJUictBPxtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.158.250]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvqW-1qYw4r4BZ0-00b73t; Sat, 13
 May 2023 23:35:32 +0200
Message-ID: <ca4ac780-42b0-4818-bd84-e1a4acbb28dd@gmx.de>
Date:   Sat, 13 May 2023 23:35:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 08/23] parisc: add pte_unmap() to balance get_ptep()
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
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
 <44ebbf90-5fbb-2815-17c7-fcfe3c87d78e@google.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <44ebbf90-5fbb-2815-17c7-fcfe3c87d78e@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:02c5NpapKZ0yND7w0y40kUtQXH+Ybc0bQPzvspvwYlotAB99sF5
 zFBBfNW47FR7ppsIv7ORzd5debot/2bSdnSyGIDtWWm1xzh1QppJDewIoqcOMGEOc5o3++E
 GB7D5SsAuS01JsydFNYGrdMOwh1KtcLiZKmwzv4YnhFPj7aU+qawXM/A52PkJ99vIebL33s
 O5IbJLN5O6SEa/1rmMz5g==
UI-OutboundReport: notjunk:1;M01:P0:bhlTqfzpBjQ=;VggY45HBIIx7XaH/PngpNV8urft
 cjwTlAoz1j7g24v8vlKLAO3PylYnY/qHL1gAemvPDWFLKb+ZHNP7elgmO7WqCtgoC6KjABob8
 DNOyUboPP4EN29IO7mQkp5zAUdfcC9dvuIH6FrtIgv24kY/u0UkP0sFqXCCza311xuhuc0bfI
 W3a3RTKNdId6dAowl5u63DT6seM8Hm4iphC0SPSPZT9g005M9r8+BQH/XC9MFQyJSO3FX3CWI
 UokhNrxaQU+aZoAGuy0ZKtyCLBTYWL4F6TSIHPfUdr4DKE8vx3tRYWkx+4y1/bi2ullhSCNlL
 t6uHP3r9oyZotSEHOmuNGQ7W90zXSNq13A8slhX51+wEbYQI7OjJlN5/6SNi0b3fPn7mCmsak
 5u96zCjBgO45UkYwIFVS3h7nF/Mwj8eEQpBbuQa/S0dQzwZzDhm85nk91JGJWzeKBhnpogocH
 HASt2e1tuCNJHXlJDWO5LuLXb/JVmpy/KwGOxafTz0qWr0u9OGwBJyzr/aekEvaK0vqfAKu9G
 WWPJ6EPxl3C5tMotM5H57EtsA/8G5fV+FiCfWCTjtjTsMZF7DQvd5ixzVKc8aKHYj3o78J5J9
 b1xbN4FsZDbke0QSx0p5QFQq4XQal0qGr9xIMYRqRZ0p56T3GrZgrwad5D5lXnpeTj0OqJ47u
 LkxrOM39notrGfVPy74SGBIJ6LFZQs2aBXs0Hrdb2Ua2vNs/36VHsvhfxQ4rZu2ljsKr7Tnsd
 t3WHCudqPse4fRr2srS44fxtRfB3efVVWEMsoe5NnAfdFJZgOwt0WYZyDbB2PZ4mU7ilCEJAJ
 irVSZYdS00VuNKqtGWxFrZ0rrE5AHHHlC1uGoa5UQz1YYRu63D00hqjC4lOZ81YrXtV0VSuXi
 PDH9rmGqc28YryLY3ce8ZihMjd1Tkl/vP1QN0EuRgkkWHoKGGQ5LzjYSoYI+w24AaBgVLeyTT
 dmWbT/BmDshTWbB5y4/6VdjN1LM=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

On 5/10/23 06:52, Hugh Dickins wrote:
> To keep balance in future, remember to pte_unmap() after a successful
> get_ptep().  And (we might as well) pretend that flush_cache_pages()
> really needed a map there, to read the pfn before "unmapping".
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>   arch/parisc/kernel/cache.c | 26 +++++++++++++++++++++-----
>   1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
> index 1d3b8bc8a623..b0c969b3a300 100644
> --- a/arch/parisc/kernel/cache.c
> +++ b/arch/parisc/kernel/cache.c
> @@ -425,10 +425,15 @@ void flush_dcache_page(struct page *page)
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
> @@ -560,14 +565,20 @@ EXPORT_SYMBOL(flush_kernel_dcache_page_addr);
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
> +		needs_flush =3D pte_needs_flush(*ptep))

^^^^^
One ")" too much and lacks a trailing ";"
Should be:
		needs_flush =3D pte_needs_flush(*ptep);

With that fixed the kernel compiles and boots sucessfully on parisc.

Helge
