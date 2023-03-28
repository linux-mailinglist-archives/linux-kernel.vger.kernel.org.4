Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B066CC01D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjC1NFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjC1NFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:05:13 -0400
Received: from out-1.mta0.migadu.com (out-1.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614496EAC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:04:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680008686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Son+EeR8XyaKhlokwJs6j5Bs+OL8G7txoA1nBIX15Xk=;
        b=aPFwvaZd6nfzRXCS/nAZB5enMyqkmzTFxQhGDmRDwrNX0W93BB3iKW881jxXgG6I2CU4Sd
        BL9lDjTjuBZdINj3Vfkg1EVTG++R0/8TcP2cVZ8oEwqa0fZit2RlTgETczibdVWfFb2z5L
        F+r1WNI1O/KiNbjnJmWEfnCgzltc6uA=
MIME-Version: 1.0
Subject: Re: [PATCH 3/6] mm: kfence: make kfence_protect_page() void
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <CANpmjNNry_OxZJFAKSFf9Cpb2SCWM-__AF25BpGwOXpa+DJBUQ@mail.gmail.com>
Date:   Tue, 28 Mar 2023 21:04:11 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>, glider@google.com,
        dvyukov@google.com, akpm@linux-foundation.org, jannh@google.com,
        sjpark@amazon.de, kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <938ED660-4153-4F16-8115-E96BCAD51F35@linux.dev>
References: <20230328095807.7014-1-songmuchun@bytedance.com>
 <20230328095807.7014-4-songmuchun@bytedance.com>
 <CANpmjNNry_OxZJFAKSFf9Cpb2SCWM-__AF25BpGwOXpa+DJBUQ@mail.gmail.com>
To:     Marco Elver <elver@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 28, 2023, at 18:32, Marco Elver <elver@google.com> wrote:
>=20
> On Tue, 28 Mar 2023 at 11:58, Muchun Song <songmuchun@bytedance.com> =
wrote:
>>=20
>> The arch_kfence_init_pool() make sure kfence pool is mapped with base =
page
>> size (e.g. 4KB), so the following PTE lookup in kfence_protect_page() =
will
>> always succeed. Then there is no way to stop kfence_protect_page() =
always
>> returning true, so make it void to simplify the code.
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> arch/arm/include/asm/kfence.h     |   4 +-
>> arch/arm64/include/asm/kfence.h   |   4 +-
>> arch/parisc/include/asm/kfence.h  |   7 +-
>> arch/powerpc/include/asm/kfence.h |   8 +--
>> arch/riscv/include/asm/kfence.h   |   4 +-
>> arch/s390/include/asm/kfence.h    |   3 +-
>> arch/x86/include/asm/kfence.h     |   9 +--
>> mm/kfence/core.c                  | 142 =
+++++++++++++++++---------------------
>> 8 files changed, 73 insertions(+), 108 deletions(-)
>>=20
>> diff --git a/arch/arm/include/asm/kfence.h =
b/arch/arm/include/asm/kfence.h
>> index 7980d0f2271f..c30a5f8125e8 100644
>> --- a/arch/arm/include/asm/kfence.h
>> +++ b/arch/arm/include/asm/kfence.h
>> @@ -43,11 +43,9 @@ static inline bool arch_kfence_init_pool(void)
>>        return true;
>> }
>>=20
>> -static inline bool kfence_protect_page(unsigned long addr, bool =
protect)
>> +static inline void kfence_protect_page(unsigned long addr, bool =
protect)
>> {
>>        set_memory_valid(addr, 1, !protect);
>> -
>> -       return true;
>> }
>>=20
>> #endif /* __ASM_ARM_KFENCE_H */
>> diff --git a/arch/arm64/include/asm/kfence.h =
b/arch/arm64/include/asm/kfence.h
>> index a81937fae9f6..7717c6d98b6f 100644
>> --- a/arch/arm64/include/asm/kfence.h
>> +++ b/arch/arm64/include/asm/kfence.h
>> @@ -12,11 +12,9 @@
>>=20
>> static inline bool arch_kfence_init_pool(void) { return true; }
>>=20
>> -static inline bool kfence_protect_page(unsigned long addr, bool =
protect)
>> +static inline void kfence_protect_page(unsigned long addr, bool =
protect)
>> {
>>        set_memory_valid(addr, 1, !protect);
>> -
>> -       return true;
>> }
>>=20
>> #ifdef CONFIG_KFENCE
>> diff --git a/arch/parisc/include/asm/kfence.h =
b/arch/parisc/include/asm/kfence.h
>> index 6259e5ac1fea..290792009315 100644
>> --- a/arch/parisc/include/asm/kfence.h
>> +++ b/arch/parisc/include/asm/kfence.h
>> @@ -19,13 +19,10 @@ static inline bool arch_kfence_init_pool(void)
>> }
>>=20
>> /* Protect the given page and flush TLB. */
>> -static inline bool kfence_protect_page(unsigned long addr, bool =
protect)
>> +static inline void kfence_protect_page(unsigned long addr, bool =
protect)
>> {
>>        pte_t *pte =3D virt_to_kpte(addr);
>>=20
>> -       if (WARN_ON(!pte))
>> -               return false;
>> -
>>        /*
>>         * We need to avoid IPIs, as we may get KFENCE allocations or =
faults
>>         * with interrupts disabled.
>> @@ -37,8 +34,6 @@ static inline bool kfence_protect_page(unsigned =
long addr, bool protect)
>>                set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
>>=20
>>        flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>> -
>> -       return true;
>> }
>>=20
>> #endif /* _ASM_PARISC_KFENCE_H */
>> diff --git a/arch/powerpc/include/asm/kfence.h =
b/arch/powerpc/include/asm/kfence.h
>> index 6fd2b4d486c5..9d8502a7d0a4 100644
>> --- a/arch/powerpc/include/asm/kfence.h
>> +++ b/arch/powerpc/include/asm/kfence.h
>> @@ -21,16 +21,14 @@ static inline bool arch_kfence_init_pool(void)
>> }
>>=20
>> #ifdef CONFIG_PPC64
>> -static inline bool kfence_protect_page(unsigned long addr, bool =
protect)
>> +static inline void kfence_protect_page(unsigned long addr, bool =
protect)
>> {
>>        struct page *page =3D virt_to_page(addr);
>>=20
>>        __kernel_map_pages(page, 1, !protect);
>> -
>> -       return true;
>> }
>> #else
>> -static inline bool kfence_protect_page(unsigned long addr, bool =
protect)
>> +static inline void kfence_protect_page(unsigned long addr, bool =
protect)
>> {
>>        pte_t *kpte =3D virt_to_kpte(addr);
>>=20
>> @@ -40,8 +38,6 @@ static inline bool kfence_protect_page(unsigned =
long addr, bool protect)
>>        } else {
>>                pte_update(&init_mm, addr, kpte, 0, _PAGE_PRESENT, 0);
>>        }
>> -
>> -       return true;
>> }
>> #endif
>>=20
>> diff --git a/arch/riscv/include/asm/kfence.h =
b/arch/riscv/include/asm/kfence.h
>> index d887a54042aa..1299f47170b5 100644
>> --- a/arch/riscv/include/asm/kfence.h
>> +++ b/arch/riscv/include/asm/kfence.h
>> @@ -46,7 +46,7 @@ static inline bool arch_kfence_init_pool(void)
>>        return true;
>> }
>>=20
>> -static inline bool kfence_protect_page(unsigned long addr, bool =
protect)
>> +static inline void kfence_protect_page(unsigned long addr, bool =
protect)
>> {
>>        pte_t *pte =3D virt_to_kpte(addr);
>>=20
>> @@ -56,8 +56,6 @@ static inline bool kfence_protect_page(unsigned =
long addr, bool protect)
>>                set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
>>=20
>>        flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>> -
>> -       return true;
>> }
>>=20
>> #endif /* _ASM_RISCV_KFENCE_H */
>> diff --git a/arch/s390/include/asm/kfence.h =
b/arch/s390/include/asm/kfence.h
>> index d55ba878378b..6d7b3632d79c 100644
>> --- a/arch/s390/include/asm/kfence.h
>> +++ b/arch/s390/include/asm/kfence.h
>> @@ -33,10 +33,9 @@ static __always_inline void =
kfence_split_mapping(void)
>> #endif
>> }
>>=20
>> -static inline bool kfence_protect_page(unsigned long addr, bool =
protect)
>> +static inline void kfence_protect_page(unsigned long addr, bool =
protect)
>> {
>>        __kernel_map_pages(virt_to_page(addr), 1, !protect);
>> -       return true;
>> }
>>=20
>> #endif /* _ASM_S390_KFENCE_H */
>> diff --git a/arch/x86/include/asm/kfence.h =
b/arch/x86/include/asm/kfence.h
>> index ff5c7134a37a..6ffd4a078a71 100644
>> --- a/arch/x86/include/asm/kfence.h
>> +++ b/arch/x86/include/asm/kfence.h
>> @@ -38,13 +38,9 @@ static inline bool arch_kfence_init_pool(void)
>> }
>>=20
>> /* Protect the given page and flush TLB. */
>> -static inline bool kfence_protect_page(unsigned long addr, bool =
protect)
>> +static inline void kfence_protect_page(unsigned long addr, bool =
protect)
>> {
>> -       unsigned int level;
>> -       pte_t *pte =3D lookup_address(addr, &level);
>> -
>> -       if (WARN_ON(!pte || level !=3D PG_LEVEL_4K))
>> -               return false;
>> +       pte_t *pte =3D virt_to_kpte(addr);
>=20
> This WARN and bailing here has helped us catch an issue early before
> [1] - and because KFENCE ought to be enabled as a debugging tool, the
> philosophy is to be failure tolerant and not crash the system here,
> hence the "return false".
>=20
> [1] https://lore.kernel.org/lkml/Y3bCV6VckVUEF7Pq@elver.google.com/

A good example.

>=20
> We're relying on the architecture doing the "right thing", but it's
> not entirely unlikely that the arch ends up doing the wrong thing due
> to some bug like above (i.e. arch_kfence_init_pool() is faulty).

Got it. I=E2=80=99ll drop this one next version.

Thanks

>=20
> Nack.


