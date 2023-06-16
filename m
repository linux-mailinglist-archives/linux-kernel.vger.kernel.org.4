Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D227F732947
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243788AbjFPHvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243842AbjFPHv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:51:27 -0400
Received: from out-47.mta0.migadu.com (out-47.mta0.migadu.com [91.218.175.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FE92944
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:51:24 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686901882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bMtAKP+P5Y4Hq8LEnvTfp0OCofr+9CIr8IAtwL6K60I=;
        b=Qs1wTCGbpHCFf0Oj8l9qjpOojhKRgI4zV+yeAXxtFEhyOUh5RKNo8wEaUb7r8zU0Cnl/CW
        usYUPNa9v+cCZ3KsxnnEAZRFhzQrz623YsGwvHUXbGYtWGJ43pdbcjf0MjFR7bohwDevdf
        PqgHuuYzWdCvyExLrnP2StIdMyH6mKo=
Date:   Fri, 16 Jun 2023 07:51:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <5ba9ad9bedb2fd3fb96571a778fc35b5@linux.dev>
Subject: Re: [PATCH v2] mm: pass nid to reserve_bootmem_region()
To:     "Mike Rapoport" <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "kernel test robot" <lkp@intel.com>
In-Reply-To: <20230616072247.GL52412@kernel.org>
References: <20230616072247.GL52412@kernel.org>
 <20230616023011.2952211-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

June 16, 2023 3:22 PM, "Mike Rapoport" <rppt@kernel.org> wrote:=0A=0A> On=
 Fri, Jun 16, 2023 at 10:30:11AM +0800, Yajun Deng wrote:=0A> =0A>> early=
_pfn_to_nid() is called frequently in init_reserved_page(), it=0A>> retur=
ns the node id of the PFN. These PFN are probably from the same=0A>> memo=
ry region, they have the same node id. It's not necessary to call=0A>> ea=
rly_pfn_to_nid() for each PFN.=0A>> =0A>> Pass nid to eserve_bootmem_regi=
on() and drop the call to=0A>> early_pfn_to_nid() in init_reserved_page()=
.=0A>> =0A>> The most beneficial function is memmap_init_reserved_pages()=
 if define=0A>> CONFIG_DEFERRED_STRUCT_PAGE_INIT.=0A>> The following data=
 was tested on x86 machine, it has 190GB RAM,=0A>> =0A>> before:=0A>> mem=
map_init_reserved_pages() 67ms=0A>> =0A>> after:=0A>> memmap_init_reserve=
d_pages() 20ms=0A>> =0A>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev=
>=0A>> Reported-by: kernel test robot <lkp@intel.com>=0A>> Closes: https:=
//lore.kernel.org/oe-kbuild-all/202306160145.juJMr3Bi-lkp@intel.com=0A>> =
---=0A>> include/linux/mm.h | 3 ++-=0A>> mm/memblock.c | 9 ++++++---=0A>>=
 mm/mm_init.c | 31 +++++++++++++++++++------------=0A>> 3 files changed, =
27 insertions(+), 16 deletions(-)=0A>> =0A>> diff --git a/include/linux/m=
m.h b/include/linux/mm.h=0A>> index 17317b1673b0..39e72ca6bf22 100644=0A>=
> --- a/include/linux/mm.h=0A>> +++ b/include/linux/mm.h=0A>> @@ -2964,7 =
+2964,8 @@ extern unsigned long free_reserved_area(void *start, void *end=
,=0A>> =0A>> extern void adjust_managed_page_count(struct page *page, lon=
g count);=0A>> =0A>> -extern void reserve_bootmem_region(phys_addr_t star=
t, phys_addr_t end);=0A>> +extern void reserve_bootmem_region(phys_addr_t=
 start,=0A>> + phys_addr_t end, int nid);=0A>> =0A>> /* Free the reserved=
 page into the buddy system, so it gets managed. */=0A>> static inline vo=
id free_reserved_page(struct page *page)=0A>> diff --git a/mm/memblock.c =
b/mm/memblock.c=0A>> index ff0da1858778..6dc51dc845e5 100644=0A>> --- a/m=
m/memblock.c=0A>> +++ b/mm/memblock.c=0A>> @@ -2091,18 +2091,21 @@ static=
 void __init memmap_init_reserved_pages(void)=0A>> {=0A>> struct memblock=
_region *region;=0A>> phys_addr_t start, end;=0A>> + int nid;=0A>> u64 i;=
=0A>> =0A>> /* initialize struct pages for the reserved regions */=0A>> -=
 for_each_reserved_mem_range(i, &start, &end)=0A>> - reserve_bootmem_regi=
on(start, end);=0A>> + __for_each_mem_range(i, &memblock.reserved, NULL, =
NUMA_NO_NODE,=0A>> + MEMBLOCK_NONE, &start, &end, &nid)=0A>> + reserve_bo=
otmem_region(start, end, nid);=0A> =0A> I'd prefer to see for_each_reserv=
ed_mem_region() loop here=0A> =0Aokay.=0A=0A>> /* and also treat struct p=
ages for the NOMAP regions as PageReserved */=0A>> for_each_mem_region(re=
gion) {=0A>> if (memblock_is_nomap(region)) {=0A>> start =3D region->base=
;=0A>> end =3D start + region->size;=0A>> - reserve_bootmem_region(start,=
 end);=0A>> + nid =3D memblock_get_region_node(region);=0A>> + reserve_bo=
otmem_region(start, end, nid);=0A>> }=0A>> }=0A>> }=0A>> diff --git a/mm/=
mm_init.c b/mm/mm_init.c=0A>> index d393631599a7..1499efbebc6f 100644=0A>=
> --- a/mm/mm_init.c=0A>> +++ b/mm/mm_init.c=0A>> @@ -646,10 +646,8 @@ st=
atic inline void pgdat_set_deferred_range(pg_data_t *pgdat)=0A>> }=0A>> =
=0A>> /* Returns true if the struct page for the pfn is initialised */=0A=
>> -static inline bool __meminit early_page_initialised(unsigned long pfn=
)=0A>> +static inline bool __meminit early_page_initialised(unsigned long=
 pfn, int nid)=0A>> {=0A>> - int nid =3D early_pfn_to_nid(pfn);=0A>> -=0A=
>> if (node_online(nid) && pfn >=3D NODE_DATA(nid)->first_deferred_pfn)=
=0A>> return false;=0A>> =0A>> @@ -695,15 +693,14 @@ defer_init(int nid, =
unsigned long pfn, unsigned long end_pfn)=0A>> return false;=0A>> }=0A>> =
=0A>> -static void __meminit init_reserved_page(unsigned long pfn)=0A>> +=
static void __meminit init_reserved_page(unsigned long pfn, int nid)=0A>>=
 {=0A>> pg_data_t *pgdat;=0A>> - int nid, zid;=0A>> + int zid;=0A>> =0A>>=
 - if (early_page_initialised(pfn))=0A>> + if (early_page_initialised(pfn=
, nid))=0A>> return;=0A>> =0A>> - nid =3D early_pfn_to_nid(pfn);=0A>> pgd=
at =3D NODE_DATA(nid);=0A>> =0A>> for (zid =3D 0; zid < MAX_NR_ZONES; zid=
++) {=0A>> @@ -717,7 +714,7 @@ static void __meminit init_reserved_page(u=
nsigned long pfn)=0A>> #else=0A>> static inline void pgdat_set_deferred_r=
ange(pg_data_t *pgdat) {}=0A>> =0A>> -static inline bool early_page_initi=
alised(unsigned long pfn)=0A>> +static inline bool early_page_initialised=
(unsigned long pfn, int nid)=0A>> {=0A>> return true;=0A>> }=0A>> @@ -727=
,7 +724,7 @@ static inline bool defer_init(int nid, unsigned long pfn, un=
signed long=0A>> end_pfn)=0A>> return false;=0A>> }=0A>> =0A>> -static in=
line void init_reserved_page(unsigned long pfn)=0A>> +static inline void =
init_reserved_page(unsigned long pfn, int nid)=0A>> {=0A>> }=0A>> #endif =
/* CONFIG_DEFERRED_STRUCT_PAGE_INIT */=0A>> @@ -738,16 +735,20 @@ static =
inline void init_reserved_page(unsigned long pfn)=0A>> * marks the pages =
PageReserved. The remaining valid pages are later=0A>> * sent to the budd=
y page allocator.=0A>> */=0A>> -void __meminit reserve_bootmem_region(phy=
s_addr_t start, phys_addr_t end)=0A>> +void __meminit reserve_bootmem_reg=
ion(phys_addr_t start,=0A>> + phys_addr_t end, int nid)=0A>> {=0A>> unsig=
ned long start_pfn =3D PFN_DOWN(start);=0A>> unsigned long end_pfn =3D PF=
N_UP(end);=0A>> =0A>> + if (nid =3D=3D MAX_NUMNODES)=0A>> + nid =3D first=
_online_node;=0A> =0A> How can this happen?=0A> =0A=0ASome reserved memor=
y regions may not set nid. I found it when I debug.=0AWe can see that by =
memblock_debug_show().=0A=0A>> +=0A>> for (; start_pfn < end_pfn; start_p=
fn++) {=0A>> if (pfn_valid(start_pfn)) {=0A>> struct page *page =3D pfn_t=
o_page(start_pfn);=0A>> =0A>> - init_reserved_page(start_pfn);=0A>> + ini=
t_reserved_page(start_pfn, nid);=0A>> =0A>> /* Avoid false-positive PageT=
ail() */=0A>> INIT_LIST_HEAD(&page->lru);=0A>> @@ -2579,7 +2580,13 @@ voi=
d __init set_dma_reserve(unsigned long new_dma_reserve)=0A>> void __init =
memblock_free_pages(struct page *page, unsigned long pfn,=0A>> unsigned i=
nt order)=0A>> {=0A>> - if (!early_page_initialised(pfn))=0A>> + int nid =
=3D 0;=0A>> +=0A>> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT=0A>> + nid =
=3D early_pfn_to_nid(pfn);=0A>> +#endif=0A> =0A> Wen can pass nid to memb=
lock_free_pages, no?=0A>=0A=0Amemblock_free_pages() was called by __free_=
pages_memory() and memblock_free_late().=0AFor the latter, I'm not sure i=
f we can pass nid.=0A=0AI think we can pass nid to reserve_bootmem_region=
() in this patch, and pass nid to=0Amemblock_free_pages() in another patc=
h if we can confirm this.=0A =0A>> +=0A>> + if (!early_page_initialised(p=
fn, nid))=0A>> return;=0A>> if (!kmsan_memblock_free_pages(page, order)) =
{=0A>> /* KMSAN will take care of these pages. */=0A>> --=0A>> 2.25.1=0A>=
 =0A> --=0A> Sincerely yours,=0A> Mike.
