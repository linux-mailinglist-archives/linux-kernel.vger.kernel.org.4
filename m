Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F8C699905
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjBPPhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBPPhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:37:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6301421B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676561801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5Fb8PImBrYGyHcsdG89CK7ZB/CdIFJmA9weCo0XdLc=;
        b=KrE+TIwxLyMkulYmp0k8vMdZqQQHLb1BtCKpynhp9oA95Izz4e1HnoMn0tUHRZCNe4QgbU
        V1JEJuaO0hXxzJ7zzLfDjYJubYPHv6JmrcfvXo/UlQHrEe01rwdKtZ1fycvr5OMfn8dSLj
        AsH8FMGgemQxHn2pJALv8rR4SlvdCQc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-215-WB4u9JBWPHG2Y3oriV7HdQ-1; Thu, 16 Feb 2023 10:36:40 -0500
X-MC-Unique: WB4u9JBWPHG2Y3oriV7HdQ-1
Received: by mail-wr1-f69.google.com with SMTP id i4-20020a5d5224000000b002c559840c76so310117wra.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5Fb8PImBrYGyHcsdG89CK7ZB/CdIFJmA9weCo0XdLc=;
        b=2UUBYoeQtTCVQ20ty5r5c9sZgRYtgE/sXwiAv6WaCRB0WuHh3NM2BCIT3aeInVgRJD
         NNsXBHr4nWS6kzDop6T1mFjt3c+RmYugC+kInqzh2wNx/cOTX8J1ZBd5l20cwLqa3r8P
         Kbg3msLBGcCsEHBYqqZwmTR+aM7051gMnLGBSfU6In1pri3etRATYWG2pil7zbVsIpJ3
         9GHEoFC/+4uWs1RhU3QBMeLHC/K3JIlsPJXVD4tfSeRyWGuAHIZ4OSJtI9DyxQtc2ZQ2
         0EZ9SjmbYcXpSbVhw3WDYxhJzsZZ3c4Qw+/Pq37kCksq5ZbBIE7+HQcOozDOD4oDKeqV
         ebLw==
X-Gm-Message-State: AO0yUKWkPoiLcfiovuaj7v4/2tpGo7ns5YdR/uCUn/294ojJmSqmvMCW
        r0yL22fiyUj8lpegZuFD0csqUE8jWy/TE42/wfBg9IWaM8ZEqMMw4PGM6oR32IrQQVCswrDDV5u
        xauD1cDPp49mPy2ZsRKm1Ic4vn8Md/RJPfq2c5KOGDoO2qCWmeP2rRtKpwPZ+BVs53b2mT06E2x
        uMJg==
X-Received: by 2002:a5d:574a:0:b0:2c5:582b:bad1 with SMTP id q10-20020a5d574a000000b002c5582bbad1mr5462457wrw.30.1676561798946;
        Thu, 16 Feb 2023 07:36:38 -0800 (PST)
X-Google-Smtp-Source: AK7set/ecoRRJ/I3UFNiSfLEqudNbDaalrprKJA/jDlYKXRQpXFBDA3mNLzN3AuEsyjLo2c1BpYZZQ==
X-Received: by 2002:a5d:574a:0:b0:2c5:582b:bad1 with SMTP id q10-20020a5d574a000000b002c5582bbad1mr5462420wrw.30.1676561798525;
        Thu, 16 Feb 2023 07:36:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:bc00:2acb:9e46:1412:686a? (p200300cbc708bc002acb9e461412686a.dip0.t-ipconnect.de. [2003:cb:c708:bc00:2acb:9e46:1412:686a])
        by smtp.gmail.com with ESMTPSA id a16-20020a5d4d50000000b002c55521903bsm1718324wru.51.2023.02.16.07.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 07:36:37 -0800 (PST)
Message-ID: <311e3201-4dde-9f45-2cea-1a570b85179c@redhat.com>
Date:   Thu, 16 Feb 2023 16:36:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1] sparc/mm: don't unconditionally set HW writable bit
 when setting PTE dirty on 64bit
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Xu <peterx@redhat.com>, Hev <r@hev.cc>,
        Anatoly Pugachev <matorola@gmail.com>,
        Raghavendra K T <raghavendra.kt@amd.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
References: <20221212130213.136267-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221212130213.136267-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping. We are seeing more issues [1] with that handling that require 
workarounds.

@Andrew, if David is unavailable for sparc64 activity, can we route this 
through your tree?

[1] https://lkml.kernel.org/r/20230216153059.256739-1-peterx@redhat.com


On 12.12.22 14:02, David Hildenbrand wrote:
> On sparc64, there is no HW modified bit, therefore, SW tracks via a SW
> bit if the PTE is dirty via pte_mkdirty(). However, pte_mkdirty()
> currently also unconditionally sets the HW writable bit, which is wrong.
> 
> pte_mkdirty() is not supposed to make a PTE actually writable, unless the
> SW writable bit (pte_write()) indicates that the PTE is not
> write-protected. Fortunately, sparc64 also defines a SW writable bit.
> 
> For example, this already turned into a problem in the context of
> THP splitting as documented in commit 624a2c94f5b7 ("Partly revert "mm/thp:
> carry over dirty bit when thp splits on pmd") and might be an issue during
> page migration in mm/migrate.c:remove_migration_pte() as well where we:
> 	if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
> 		pte = pte_mkdirty(pte);
> 
> But more general, anything like:
> 	maybe_mkwrite(pte_mkdirty(pte), vma)
> code is broken on sparc64, because it will unconditionally set the HW
> writable bit even if the SW writable bit is not set.
> 
> Simple reproducer that will result in a writable PTE after ptrace
> access, to highlight the problem and as an easy way to verify if it has
> been fixed:
> 
> --------------------------------------------------------------------------
>   #include <fcntl.h>
>   #include <signal.h>
>   #include <unistd.h>
>   #include <string.h>
>   #include <errno.h>
>   #include <stdlib.h>
>   #include <sys/mman.h>
> 
>   static void signal_handler(int sig)
>   {
>           if (sig == SIGSEGV)
>                   printf("[PASS] SIGSEGV generated\n");
>           else
>                   printf("[FAIL] wrong signal generated\n");
>           exit(0);
>   }
> 
>   int main(void)
>   {
>           size_t pagesize = getpagesize();
>           char data = 1;
>           off_t offs;
>           int mem_fd;
>           char *map;
>           int ret;
> 
>           mem_fd = open("/proc/self/mem", O_RDWR);
>           if (mem_fd < 0) {
>                   fprintf(stderr, "open(/proc/self/mem) failed: %d\n", errno);
>                   return 1;
>           }
> 
>           map = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE|MAP_ANON, -1 ,0);
>           if (map == MAP_FAILED) {
>                   fprintf(stderr, "mmap() failed: %d\n", errno);
>                   return 1;
>           }
> 
>           printf("original: %x\n", *map);
> 
>           /* debug access */
>           offs = lseek(mem_fd, (uintptr_t) map, SEEK_SET);
>           ret = write(mem_fd, &data, 1);
>           if (ret != 1) {
>                   fprintf(stderr, "pwrite(/proc/self/mem) failed with %d: %d\n", ret, errno);
>                   return 1;
>           }
>           if (*map != data) {
>                   fprintf(stderr, "pwrite(/proc/self/mem) not visible\n");
>                   return 1;
>           }
> 
>           printf("ptrace: %x\n", *map);
> 
>           /* Install signal handler. */
>           if (signal(SIGSEGV, signal_handler) == SIG_ERR) {
>                   fprintf(stderr, "signal() failed\n");
>                   return 1;
>           }
> 
>           /* Ordinary access. */
>           *map = 2;
> 
>           printf("access: %x\n", *map);
> 
>           printf("[FAIL] SIGSEGV not generated\n");
> 
>           return 0;
>   }
> --------------------------------------------------------------------------
> 
> Without this commit (sun4u in QEMU):
> 	# ./reproducer
> 	original: 0
> 	ptrace: 1
> 	access: 2
> 	[FAIL] SIGSEGV not generated
> 
> Let's fix this by setting the HW writable bit only if both, the SW dirty
> bit and the SW writable bit are set. This matches, for example, how
> s390x handles pte_mkwrite() and pte_mkdirty() -- except, that they have
> to clear the _PAGE_PROTECT bit.
> 
> We have to move pte_dirty() and pte_dirty() up. The code patching
> mechanism and handling constants > 22bit is a bit special on sparc64.
> 
> With this commit (sun4u in QEMU):
> 	# ./reproducer
> 	original: 0
> 	ptrace: 1
> 	[PASS] SIGSEGV generated
> 
> This handling seems to have been in place forever.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Hev <r@hev.cc>
> Cc: Anatoly Pugachev <matorola@gmail.com>
> Cc: Raghavendra K T <raghavendra.kt@amd.com>
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Juergen Gross <jgross@suse.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Only tested under QEMU with sun4u, as I cannot seem to get sun4v running
> in QEMU. Survives a simple debian 10 boot.
> 
> This also tackles what's documented in:
> 	https://lkml.kernel.org/r/20221125185857.3110155-1-peterx@redhat.com
> and once loongarch also has been fixed, we might be able to remove all
> that special-casing.
> 
> ---
>   arch/sparc/include/asm/pgtable_64.h | 117 ++++++++++++++++------------
>   1 file changed, 67 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 3bc9736bddb1..7f2e57747563 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -354,6 +354,42 @@ static inline pgprot_t pgprot_noncached(pgprot_t prot)
>    */
>   #define pgprot_noncached pgprot_noncached
>   
> +static inline unsigned long pte_dirty(pte_t pte)
> +{
> +	unsigned long mask;
> +
> +	__asm__ __volatile__(
> +	"\n661:	mov		%1, %0\n"
> +	"	nop\n"
> +	"	.section	.sun4v_2insn_patch, \"ax\"\n"
> +	"	.word		661b\n"
> +	"	sethi		%%uhi(%2), %0\n"
> +	"	sllx		%0, 32, %0\n"
> +	"	.previous\n"
> +	: "=r" (mask)
> +	: "i" (_PAGE_MODIFIED_4U), "i" (_PAGE_MODIFIED_4V));
> +
> +	return (pte_val(pte) & mask);
> +}
> +
> +static inline unsigned long pte_write(pte_t pte)
> +{
> +	unsigned long mask;
> +
> +	__asm__ __volatile__(
> +	"\n661:	mov		%1, %0\n"
> +	"	nop\n"
> +	"	.section	.sun4v_2insn_patch, \"ax\"\n"
> +	"	.word		661b\n"
> +	"	sethi		%%uhi(%2), %0\n"
> +	"	sllx		%0, 32, %0\n"
> +	"	.previous\n"
> +	: "=r" (mask)
> +	: "i" (_PAGE_WRITE_4U), "i" (_PAGE_WRITE_4V));
> +
> +	return (pte_val(pte) & mask);
> +}
> +
>   #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
>   pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
>   #define arch_make_huge_pte arch_make_huge_pte
> @@ -415,28 +451,44 @@ static inline bool is_hugetlb_pte(pte_t pte)
>   }
>   #endif
>   
> -static inline pte_t pte_mkdirty(pte_t pte)
> +static inline pte_t __pte_mkhwwrite(pte_t pte)
>   {
> -	unsigned long val = pte_val(pte), tmp;
> +	unsigned long val = pte_val(pte);
>   
> +	/*
> +	 * Note: we only want to set the HW writable bit if the SW writable bit
> +	 * and the SW dirty bit are set.
> +	 */
>   	__asm__ __volatile__(
> -	"\n661:	or		%0, %3, %0\n"
> +	"\n661:	or		%0, %2, %0\n"
>   	"	nop\n"
> -	"\n662:	nop\n"
> +	"	.section	.sun4v_1insn_patch, \"ax\"\n"
> +	"	.word		661b\n"
> +	"	or		%0, %3, %0\n"
> +	"	.previous\n"
> +	: "=r" (val)
> +	: "0" (val), "i" (_PAGE_W_4U), "i" (_PAGE_W_4V));
> +
> +	return __pte(val);
> +}
> +
> +static inline pte_t pte_mkdirty(pte_t pte)
> +{
> +	unsigned long val = pte_val(pte), mask;
> +
> +	__asm__ __volatile__(
> +	"\n661:	mov		%1, %0\n"
>   	"	nop\n"
>   	"	.section	.sun4v_2insn_patch, \"ax\"\n"
>   	"	.word		661b\n"
> -	"	sethi		%%uhi(%4), %1\n"
> -	"	sllx		%1, 32, %1\n"
> -	"	.word		662b\n"
> -	"	or		%1, %%lo(%4), %1\n"
> -	"	or		%0, %1, %0\n"
> +	"	sethi		%%uhi(%2), %0\n"
> +	"	sllx		%0, 32, %0\n"
>   	"	.previous\n"
> -	: "=r" (val), "=r" (tmp)
> -	: "0" (val), "i" (_PAGE_MODIFIED_4U | _PAGE_W_4U),
> -	  "i" (_PAGE_MODIFIED_4V | _PAGE_W_4V));
> +	: "=r" (mask)
> +	: "i" (_PAGE_MODIFIED_4U), "i" (_PAGE_MODIFIED_4V));
>   
> -	return __pte(val);
> +	pte = __pte(val | mask);
> +	return pte_write(pte) ? __pte_mkhwwrite(pte) : pte;
>   }
>   
>   static inline pte_t pte_mkclean(pte_t pte)
> @@ -478,7 +530,8 @@ static inline pte_t pte_mkwrite(pte_t pte)
>   	: "=r" (mask)
>   	: "i" (_PAGE_WRITE_4U), "i" (_PAGE_WRITE_4V));
>   
> -	return __pte(val | mask);
> +	pte = __pte(val | mask);
> +	return pte_dirty(pte) ? __pte_mkhwwrite(pte) : pte;
>   }
>   
>   static inline pte_t pte_wrprotect(pte_t pte)
> @@ -581,42 +634,6 @@ static inline unsigned long pte_young(pte_t pte)
>   	return (pte_val(pte) & mask);
>   }
>   
> -static inline unsigned long pte_dirty(pte_t pte)
> -{
> -	unsigned long mask;
> -
> -	__asm__ __volatile__(
> -	"\n661:	mov		%1, %0\n"
> -	"	nop\n"
> -	"	.section	.sun4v_2insn_patch, \"ax\"\n"
> -	"	.word		661b\n"
> -	"	sethi		%%uhi(%2), %0\n"
> -	"	sllx		%0, 32, %0\n"
> -	"	.previous\n"
> -	: "=r" (mask)
> -	: "i" (_PAGE_MODIFIED_4U), "i" (_PAGE_MODIFIED_4V));
> -
> -	return (pte_val(pte) & mask);
> -}
> -
> -static inline unsigned long pte_write(pte_t pte)
> -{
> -	unsigned long mask;
> -
> -	__asm__ __volatile__(
> -	"\n661:	mov		%1, %0\n"
> -	"	nop\n"
> -	"	.section	.sun4v_2insn_patch, \"ax\"\n"
> -	"	.word		661b\n"
> -	"	sethi		%%uhi(%2), %0\n"
> -	"	sllx		%0, 32, %0\n"
> -	"	.previous\n"
> -	: "=r" (mask)
> -	: "i" (_PAGE_WRITE_4U), "i" (_PAGE_WRITE_4V));
> -
> -	return (pte_val(pte) & mask);
> -}
> -
>   static inline unsigned long pte_exec(pte_t pte)
>   {
>   	unsigned long mask;
> 
> base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476

-- 
Thanks,

David / dhildenb

