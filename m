Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3D76CC10B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjC1NeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjC1NeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:34:16 -0400
Received: from out-16.mta1.migadu.com (out-16.mta1.migadu.com [95.215.58.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4BC1BE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:33:29 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680010386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bApSM0pbQ1TIIJavw9zL4ET4YoxmQnS6zSB9mo2QPVs=;
        b=h+3S9y6bJH2C+qKsJ2+jwk3bg681PdA/HojOJvujz1hEc6v3u+mLaM/MoR166+PkK9tFAq
        mZLOw5/m6xhbiUiDIxXs+nA4pwholyum5LGMZ04VDT4nYkgudVONED/hzjadX2smNG0KFd
        ILxBKPIbpqLH4BOWAGTbOCLDovKPeic=
MIME-Version: 1.0
Subject: Re: [PATCH 5/6] mm: kfence: change kfence pool page layout
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <CANpmjNPZxDYPYzEjr55ONydwH1FZF_Eh_gu7XKg=4-+HK6vL9Q@mail.gmail.com>
Date:   Tue, 28 Mar 2023 21:32:28 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>, glider@google.com,
        dvyukov@google.com, akpm@linux-foundation.org, jannh@google.com,
        sjpark@amazon.de, kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <291FB0BF-F824-4ED9-B836-DA7773BFDA48@linux.dev>
References: <20230328095807.7014-1-songmuchun@bytedance.com>
 <20230328095807.7014-6-songmuchun@bytedance.com>
 <CANpmjNPZxDYPYzEjr55ONydwH1FZF_Eh_gu7XKg=4-+HK6vL9Q@mail.gmail.com>
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



> On Mar 28, 2023, at 20:59, Marco Elver <elver@google.com> wrote:
>=20
> On Tue, 28 Mar 2023 at 11:58, 'Muchun Song' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
>>=20
>> The original kfence pool layout (Given a layout with 2 objects):
>>=20
>> =
+------------+------------+------------+------------+------------+--------=
----+
>> | guard page | guard page |   object   | guard page |   object   | =
guard page |
>> =
+------------+------------+------------+------------+------------+--------=
----+
>>                           |                         | |
>>                           =
+----kfence_metadata[0]---+----kfence_metadata[1]---+
>>=20
>> The comment says "the additional page in the beginning gives us an =
even
>> number of pages, which simplifies the mapping of address to metadata =
index".
>>=20
>> However, removing the additional page does not complicate any mapping
>> calculations. So changing it to the new layout to save a page. And =
remmove
>> the KFENCE_ERROR_INVALID test since we cannot test this case easily.
>>=20
>> The new kfence pool layout (Given a layout with 2 objects):
>>=20
>> +------------+------------+------------+------------+------------+
>> | guard page |   object   | guard page |   object   | guard page |
>> +------------+------------+------------+------------+------------+
>> |                         |                         |
>> +----kfence_metadata[0]---+----kfence_metadata[1]---+
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> include/linux/kfence.h  |  8 ++------
>> mm/kfence/core.c        | 40 ++++++++--------------------------------
>> mm/kfence/kfence.h      |  2 +-
>> mm/kfence/kfence_test.c | 14 --------------
>> 4 files changed, 11 insertions(+), 53 deletions(-)
>>=20
>> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
>> index 726857a4b680..25b13a892717 100644
>> --- a/include/linux/kfence.h
>> +++ b/include/linux/kfence.h
>> @@ -19,12 +19,8 @@
>>=20
>> extern unsigned long kfence_sample_interval;
>>=20
>> -/*
>> - * We allocate an even number of pages, as it simplifies =
calculations to map
>> - * address to metadata indices; effectively, the very first page =
serves as an
>> - * extended guard page, but otherwise has no special purpose.
>> - */
>> -#define KFENCE_POOL_SIZE ((CONFIG_KFENCE_NUM_OBJECTS + 1) * 2 * =
PAGE_SIZE)
>> +/* The last page serves as an extended guard page. */
>=20
> The last page is just a normal guard page? I.e. the last 2 pages are:
> <object page> | <guard page>

Right.

The new kfence pool layout (Given a layout with 2 objects):

+------------+------------+------------+------------+------------+
| guard page |   object   | guard page |   object   | guard page |
+------------+------------+------------+------------+------------+
|                         |                         |     ^
+----kfence_metadata[0]---+----kfence_metadata[1]---+     |
                                                          |
                                                          |
                                                     the last page

>=20
> Or did I misunderstand?
>=20
>> +#define KFENCE_POOL_SIZE       ((CONFIG_KFENCE_NUM_OBJECTS * 2 + 1) =
* PAGE_SIZE)
>> extern char *__kfence_pool;
>>=20
>> DECLARE_STATIC_KEY_FALSE(kfence_allocation_key);
>> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
>> index 41befcb3b069..f205b860f460 100644
>> --- a/mm/kfence/core.c
>> +++ b/mm/kfence/core.c
>> @@ -240,24 +240,7 @@ static inline void kfence_unprotect(unsigned =
long addr)
>>=20
>> static inline unsigned long metadata_to_pageaddr(const struct =
kfence_metadata *meta)
>> {
>> -       unsigned long offset =3D (meta - kfence_metadata + 1) * =
PAGE_SIZE * 2;
>> -       unsigned long pageaddr =3D (unsigned =
long)&__kfence_pool[offset];
>> -
>> -       /* The checks do not affect performance; only called from =
slow-paths. */
>> -
>> -       /* Only call with a pointer into kfence_metadata. */
>> -       if (KFENCE_WARN_ON(meta < kfence_metadata ||
>> -                          meta >=3D kfence_metadata + =
CONFIG_KFENCE_NUM_OBJECTS))
>> -               return 0;
>=20
> Could we retain this WARN_ON? Or just get rid of
> metadata_to_pageaddr() altogether, because there's only 1 use left and
> the function would now just be a simple ALIGN_DOWN() anyway.

I'll inline this function to its caller since the warning is unlikely.

>=20
>> -       /*
>> -        * This metadata object only ever maps to 1 page; verify that =
the stored
>> -        * address is in the expected range.
>> -        */
>> -       if (KFENCE_WARN_ON(ALIGN_DOWN(meta->addr, PAGE_SIZE) !=3D =
pageaddr))
>> -               return 0;
>> -
>> -       return pageaddr;
>> +       return ALIGN_DOWN(meta->addr, PAGE_SIZE);
>> }
>>=20
>> /*
>> @@ -535,34 +518,27 @@ static void kfence_init_pool(void)
>>        unsigned long addr =3D (unsigned long)__kfence_pool;
>>        int i;
>>=20
>> -       /*
>> -        * Protect the first 2 pages. The first page is mostly =
unnecessary, and
>> -        * merely serves as an extended guard page. However, adding =
one
>> -        * additional page in the beginning gives us an even number =
of pages,
>> -        * which simplifies the mapping of address to metadata index.
>> -        */
>> -       for (i =3D 0; i < 2; i++, addr +=3D PAGE_SIZE)
>> -               kfence_protect(addr);
>> -
>>        for (i =3D 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++, addr +=3D 2 =
* PAGE_SIZE) {
>>                struct kfence_metadata *meta =3D &kfence_metadata[i];
>> -               struct slab *slab =3D page_slab(virt_to_page(addr));
>> +               struct slab *slab =3D page_slab(virt_to_page(addr + =
PAGE_SIZE));
>>=20
>>                /* Initialize metadata. */
>>                INIT_LIST_HEAD(&meta->list);
>>                raw_spin_lock_init(&meta->lock);
>>                meta->state =3D KFENCE_OBJECT_UNUSED;
>> -               meta->addr =3D addr; /* Initialize for validation in =
metadata_to_pageaddr(). */
>> +               meta->addr =3D addr + PAGE_SIZE;
>>                list_add_tail(&meta->list, &kfence_freelist);
>>=20
>> -               /* Protect the right redzone. */
>> -               kfence_protect(addr + PAGE_SIZE);
>> +               /* Protect the left redzone. */
>> +               kfence_protect(addr);
>>=20
>>                __folio_set_slab(slab_folio(slab));
>> #ifdef CONFIG_MEMCG
>>                slab->memcg_data =3D (unsigned long)&meta->objcg | =
MEMCG_DATA_OBJCGS;
>> #endif
>>        }
>> +
>> +       kfence_protect(addr);
>> }
>>=20
>> static bool __init kfence_init_pool_early(void)
>> @@ -1043,7 +1019,7 @@ bool kfence_handle_page_fault(unsigned long =
addr, bool is_write, struct pt_regs
>>=20
>>        atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
>>=20
>> -       if (page_index % 2) {
>> +       if (page_index % 2 =3D=3D 0) {
>>                /* This is a redzone, report a buffer overflow. */
>>                struct kfence_metadata *meta;
>>                int distance =3D 0;
>> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
>> index 600f2e2431d6..249d420100a7 100644
>> --- a/mm/kfence/kfence.h
>> +++ b/mm/kfence/kfence.h
>> @@ -110,7 +110,7 @@ static inline struct kfence_metadata =
*addr_to_metadata(unsigned long addr)
>>         * __kfence_pool, in which case we would report an "invalid =
access"
>>         * error.
>>         */
>> -       index =3D (addr - (unsigned long)__kfence_pool) / (PAGE_SIZE =
* 2) - 1;
>> +       index =3D (addr - (unsigned long)__kfence_pool) / (PAGE_SIZE =
* 2);
>>        if (index < 0 || index >=3D CONFIG_KFENCE_NUM_OBJECTS)
>>                return NULL;
>=20
> Assume there is a right OOB that hit the last guard page. In this case
>=20
>  addr >=3D __kfence_pool + (NUM_OBJECTS * 2 * PAGE_SIZE) && addr <
> __kfence_pool + POOL_SIZE
>=20
> therefore
>=20
>  index >=3D (NUM_OBJECTS * 2 * PAGE_SIZE) / (PAGE_SIZE * 2) && index <
> POOL_SIZE / (PAGE_SIZE * 2)
>  index =3D=3D NUM_OBJECTS
>=20
> And according to the above comparison, this will return NULL and
> report KFENCE_ERROR_INVALID, which is wrong.

Look at kfence_handle_page_fault(), which first look up "addr - =
PAGE_SIZE" (passed
to addr_to_metadata()) and then look up "addr + PAGE_SIZE", the former =
will not
return NULL, the latter will return NULL. So kfence will report =
KFENCE_ERROR_OOB
in this case, right? Or what I missed here?

>=20
>> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
>> index b5d66a69200d..d479f9c8afb1 100644
>> --- a/mm/kfence/kfence_test.c
>> +++ b/mm/kfence/kfence_test.c
>> @@ -637,19 +637,6 @@ static void test_gfpzero(struct kunit *test)
>>        KUNIT_EXPECT_FALSE(test, report_available());
>> }
>>=20
>> -static void test_invalid_access(struct kunit *test)
>> -{
>> -       const struct expect_report expect =3D {
>> -               .type =3D KFENCE_ERROR_INVALID,
>> -               .fn =3D test_invalid_access,
>> -               .addr =3D &__kfence_pool[10],
>> -               .is_write =3D false,
>> -       };
>> -
>> -       READ_ONCE(__kfence_pool[10]);
>> -       KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>> -}
>> -
>> /* Test SLAB_TYPESAFE_BY_RCU works. */
>> static void test_memcache_typesafe_by_rcu(struct kunit *test)
>> {
>> @@ -787,7 +774,6 @@ static struct kunit_case kfence_test_cases[] =3D =
{
>>        KUNIT_CASE(test_kmalloc_aligned_oob_write),
>>        KUNIT_CASE(test_shrink_memcache),
>>        KUNIT_CASE(test_memcache_ctor),
>> -       KUNIT_CASE(test_invalid_access),
>=20
> The test can be retained by doing an access to a guard page in between
> 2 unallocated objects. But it's probably not that easy to reliably set
> that up (could try to allocate 2 objects and see if they're next to
> each other, then free them).

Yes, it's not easy to trigger it 100%. So I removed the test.


