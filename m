Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD30A73FCC8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjF0NYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjF0NYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:24:03 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB97B2978
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:23:57 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bfe97b3752bso4534722276.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 06:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687872237; x=1690464237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/JjYFWhUkMupfyA5wc877/4DODs5BAde5YzMX5S1gP8=;
        b=ho7foCp1iomzBMJUN9dgNTqgOYV6foh3PxhD42wyab2lTivFel6OtChoy2wARvAwTW
         zipYDhOBCN8mIHqoPsGCzD459X7nQ2yK0seUpuAeigWN82vCEioSp+r1T+TnOZc1NbK2
         eK2scxkS9uuEgo7FVcQ6mwn68nEjbwJ0VyTij68U75ELIKTD5RfmZkWYjWV/oE7txY1d
         hA3woL1CXR1sOioU9frSebjeK7RF5tQCACjcVcyTg/DmHy/Q3XwyZC8rgC5QpobPeJE6
         2Zx18Yd2gF6zilQdrAuR4Fxau7QYqfvPst97Ut56Zxh9g8YbwgHm0nZLrISFJl8txg+Q
         sLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687872237; x=1690464237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JjYFWhUkMupfyA5wc877/4DODs5BAde5YzMX5S1gP8=;
        b=ecffaSNFU8jjB9YYTwyJV5kAjxko1SHmPAjkSG5MvNumhLExZ+nEAmNMbSk5KSswWI
         vTT/7ePfn0S1/F9WOeFFlJXO3VMVKawb/JUHBPDXlOr0/bliy6cc7n2u7SSbd5PPmEVa
         0m7N/yA0yMfenz+dCy+4hOhqTjWVrPAKsYQ5ziPXWcJwqQx8huxv/k9f6spEqRxsVIvS
         X84jYOlwW33NOODovzhX2a8aqa7HSUVsoVJNXDiFV5cL8c9GKr0/VzuAtOepTNMb/9cf
         k2S7RSgQaYRMvgkAcrjOckOo/6Q0i3IAx9B5bqg9uUiIN+t+N7/3SxQ/+IQMikibb39U
         GFAA==
X-Gm-Message-State: AC+VfDzutmZa1oLKRwuwqCqC22/DDJ+QET12y7GdCJiHr+7lfE0TPFHc
        tmjoWW41n6eJtgj1yAT3QSuCwMcOoM+8Y8n39JQ=
X-Google-Smtp-Source: ACHHUZ5kYle0pb+ExBj6UrSHmU6RI+90cNOJvoGrC4RF/jQeBWkHQHDJOqw+v3NeiwRfA/nyZjyyhfvCiY6CN8+asB8=
X-Received: by 2002:a25:dd8:0:b0:beb:5abc:763e with SMTP id
 207-20020a250dd8000000b00beb5abc763emr26131120ybn.26.1687872236662; Tue, 27
 Jun 2023 06:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230619075315.49114-1-zhiguangni01@gmail.com>
In-Reply-To: <20230619075315.49114-1-zhiguangni01@gmail.com>
From:   Liam Ni <zhiguangni01@gmail.com>
Date:   Tue, 27 Jun 2023 21:23:40 +0800
Message-ID: <CACZJ9cXTJkHKGfZQsjf6LsySSwfYDht=fR+e+8bpMxT+Wi722g@mail.gmail.com>
Subject: Re: [PATCH V2] x86,NUMA:improve the execution efficiency of numa_meminfo_cover_memory()
To:     rppt@kernel.org
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

friendly ping

On Mon, 19 Jun 2023 at 15:53, Liam Ni <zhiguangni01@gmail.com> wrote:
>
> The number of pages in memblock that doesn't have the node
> assigned,which also means that these pages are not in numa_info.
> So these pages can represent the number of lose pages.
>
> Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
> ---
>  arch/x86/mm/numa.c | 25 ++++++-------------------
>  include/linux/mm.h |  2 ++
>  mm/mm_init.c       | 26 ++++++++++++++++++++++++++
>  3 files changed, 34 insertions(+), 19 deletions(-)
>
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 2aadb2019b4f..ffe3b771eac7 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -451,28 +451,15 @@ EXPORT_SYMBOL(__node_distance);
>   * Sanity check to catch more bad NUMA configurations (they are amazingly
>   * common).  Make sure the nodes cover all memory.
>   */
> -static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
> +static bool __init numa_meminfo_cover_memory(void)
>  {
> -       u64 numaram, e820ram;
> -       int i;
> -
> -       numaram = 0;
> -       for (i = 0; i < mi->nr_blks; i++) {
> -               u64 s = mi->blk[i].start >> PAGE_SHIFT;
> -               u64 e = mi->blk[i].end >> PAGE_SHIFT;
> -               numaram += e - s;
> -               numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
> -               if ((s64)numaram < 0)
> -                       numaram = 0;
> -       }
> +       u64 lo_pages;
>
> -       e820ram = max_pfn - absent_pages_in_range(0, max_pfn);
> +       lo_pages = without_node_pages_in_range(0, max_pfn);
>
>         /* We seem to lose 3 pages somewhere. Allow 1M of slack. */
> -       if ((s64)(e820ram - numaram) >= (1 << (20 - PAGE_SHIFT))) {
> -               printk(KERN_ERR "NUMA: nodes only cover %LuMB of your %LuMB e820 RAM. Not used.\n",
> -                      (numaram << PAGE_SHIFT) >> 20,
> -                      (e820ram << PAGE_SHIFT) >> 20);
> +       if (lo_pages >= (1 << (20 - PAGE_SHIFT))) {
> +               printk(KERN_ERR "NUMA: we lose more than 1M pages\n");
>                 return false;
>         }
>         return true;
> @@ -583,7 +570,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
>                         return -EINVAL;
>                 }
>         }
> -       if (!numa_meminfo_cover_memory(mi))
> +       if (!numa_meminfo_cover_memory())
>                 return -EINVAL;
>
>         /* Finally register nodes. */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0daef3f2f029..99b7b49f1378 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3043,6 +3043,8 @@ unsigned long __absent_pages_in_range(int nid, unsigned long start_pfn,
>                                                 unsigned long end_pfn);
>  extern unsigned long absent_pages_in_range(unsigned long start_pfn,
>                                                 unsigned long end_pfn);
> +extern unsigned long without_node_pages_in_range(unsigned long start_pfn,
> +                                               unsigned long end_pfn);
>  extern void get_pfn_range_for_nid(unsigned int nid,
>                         unsigned long *start_pfn, unsigned long *end_pfn);
>
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 3ddd18a89b66..1d5085a8f93b 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1132,6 +1132,32 @@ static void __init adjust_zone_range_for_zone_movable(int nid,
>         }
>  }
>
> +/**
> + * @start_pfn: The start PFN to start searching for holes
> + * @end_pfn: The end PFN to stop searching for holes
> + *
> + * Return: Return the number of page frames without node assigned within a range.
> + */
> +unsigned long __init without_node_pages_in_range(unsigned long start_pfn,
> +                                               unsigned long end_pfn)
> +{
> +       struct memblock_type *type = &memblock.memory;
> +       struct memblock_region *r;
> +       unsigned long num_pages;
> +       int i, nid;
> +
> +       for (i = 0; i < type->cnt; i++) {
> +               r = &type->regions[i];
> +               nid = memblock_get_region_node(r);
> +
> +               if (PFN_UP(r->base) >= PFN_DOWN(r->base + r->size))
> +                       continue;
> +               if (nid == NUMA_NO_NODE)
> +                       num_pages += PFN_DOWN(r->base + r->size) - PFN_UP(r->base);
> +       }
> +       return num_pages;
> +}
> +
>  /*
>   * Return the number of holes in a range on a node. If nid is MAX_NUMNODES,
>   * then all holes in the requested range will be accounted for.
> --
> 2.25.1
>
